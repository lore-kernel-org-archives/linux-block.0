Return-Path: <SRS0=WP4r=WL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB98C3A589
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 13:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9856D208C2
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 13:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732122AbfHONs4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Aug 2019 09:48:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:55786 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732504AbfHONsz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Aug 2019 09:48:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 14CD9AF9F;
        Thu, 15 Aug 2019 13:48:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 87ACA1E4200; Thu, 15 Aug 2019 15:48:53 +0200 (CEST)
Date:   Thu, 15 Aug 2019 15:48:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH block 1/2] writeback, cgroup: Adjust WB_FRN_TIME_CUT_DIV
 to accelerate foreign inode switching
Message-ID: <20190815134853.GH14313@quack2.suse.cz>
References: <20190802190738.GB136335@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802190738.GB136335@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri 02-08-19 12:07:38, Tejun Heo wrote:
> WB_FRN_TIME_CUT_DIV is used to tell the foreign inode detection logic
> to ignore short writeback rounds to prevent getting confused by a
> burst of short writebacks.  The parameter is currently 2 meaning that
> anything smaller than half of the running average writback duration
> will be ignored.
> 
> This is unnecessarily aggressive.  The detection logic uses 16 history
> slots and is already reasonably protected against some short bursts
> confusing it and the current parameter can lead to tens of seconds of
> missed detection depending on the writeback pattern.
> 
> Let's change the parameter to 8, so that it only ignores writeback
> with are smaller than 12.5% of the current running average.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Makes sense to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -227,7 +227,7 @@ static void wb_wait_for_completion(struc
>  /* parameters for foreign inode detection, see wb_detach_inode() */
>  #define WB_FRN_TIME_SHIFT	13	/* 1s = 2^13, upto 8 secs w/ 16bit */
>  #define WB_FRN_TIME_AVG_SHIFT	3	/* avg = avg * 7/8 + new * 1/8 */
> -#define WB_FRN_TIME_CUT_DIV	2	/* ignore rounds < avg / 2 */
> +#define WB_FRN_TIME_CUT_DIV	8	/* ignore rounds < avg / 8 */
>  #define WB_FRN_TIME_PERIOD	(2 * (1 << WB_FRN_TIME_SHIFT))	/* 2s */
>  
>  #define WB_FRN_HIST_SLOTS	16	/* inode->i_wb_frn_history is 16bit */
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
