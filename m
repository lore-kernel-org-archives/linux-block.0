Return-Path: <SRS0=WP4r=WL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DD5C3A589
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 13:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6C12086C
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 13:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732477AbfHONxY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Aug 2019 09:53:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:57800 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732431AbfHONxY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Aug 2019 09:53:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0BA9CAF8A;
        Thu, 15 Aug 2019 13:53:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B7AFD1E4200; Thu, 15 Aug 2019 15:53:22 +0200 (CEST)
Date:   Thu, 15 Aug 2019 15:53:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH block 2/2] writeback, cgroup: inode_switch_wbs()
 shouldn't give up on wb_switch_rwsem trylock fail
Message-ID: <20190815135322.GI14313@quack2.suse.cz>
References: <20190802190738.GB136335@devbig004.ftw2.facebook.com>
 <20190802190813.GC136335@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802190813.GC136335@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri 02-08-19 12:08:13, Tejun Heo wrote:
> As inode wb switching may make sync(2) miss some inodes, they're
> synchronized using wb_switch_rwsem so that no wb switching happens
> while sync(2) is in progress.  In addition to synchronizing the actual
> switching, the rwsem is also used to prevent queueing new switch
> attempts while sync(2) is in progress.  This is to avoid queueing too
> many instances while the rwsem is held by sync(2).  Unfortunately,
> this is too agressive and can block wb switching for a long time if
> sync(2) is frequent.
> 
> The goal is avoiding expolding the number of scheduled switches, not
> avoiding scheduling anything.  Let's use wb_switch_rwsem only for
> synchronizing the actual switching and sync(2) and use
> isw_nr_in_flight instead for limiting the maximum number of scheduled
> switches.  The limit is set to 1024 which should be more than enough
> while still avoiding extreme situations.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/fs-writeback.c |   17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -237,6 +237,7 @@ static void wb_wait_for_completion(struc
>  					/* if foreign slots >= 8, switch */
>  #define WB_FRN_HIST_MAX_SLOTS	(WB_FRN_HIST_THR_SLOTS / 2 + 1)
>  					/* one round can affect upto 5 slots */
> +#define WB_FRN_MAX_IN_FLIGHT	1024	/* don't queue too many concurrently */
>  
>  static atomic_t isw_nr_in_flight = ATOMIC_INIT(0);
>  static struct workqueue_struct *isw_wq;
> @@ -489,18 +490,13 @@ static void inode_switch_wbs(struct inod
>  	if (inode->i_state & I_WB_SWITCH)
>  		return;
>  
> -	/*
> -	 * Avoid starting new switches while sync_inodes_sb() is in
> -	 * progress.  Otherwise, if the down_write protected issue path
> -	 * blocks heavily, we might end up starting a large number of
> -	 * switches which will block on the rwsem.
> -	 */
> -	if (!down_read_trylock(&bdi->wb_switch_rwsem))
> +	/* avoid queueing a new switch if too many are already in flight */
> +	if (atomic_read(&isw_nr_in_flight) > WB_FRN_MAX_IN_FLIGHT)
>  		return;
>  
>  	isw = kzalloc(sizeof(*isw), GFP_ATOMIC);
>  	if (!isw)
> -		goto out_unlock;
> +		return;
>  
>  	/* find and pin the new wb */
>  	rcu_read_lock();
> @@ -534,15 +530,12 @@ static void inode_switch_wbs(struct inod
>  	call_rcu(&isw->rcu_head, inode_switch_wbs_rcu_fn);
>  
>  	atomic_inc(&isw_nr_in_flight);
> -
> -	goto out_unlock;
> +	return;
>  
>  out_free:
>  	if (isw->new_wb)
>  		wb_put(isw->new_wb);
>  	kfree(isw);
> -out_unlock:
> -	up_read(&bdi->wb_switch_rwsem);
>  }
>  
>  /**
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
