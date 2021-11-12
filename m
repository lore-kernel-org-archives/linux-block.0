Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5466C433F5
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 06:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 881B360FBF
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 06:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhKLGXI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Nov 2021 01:23:08 -0500
Received: from verein.lst.de ([213.95.11.211]:60189 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230439AbhKLGXH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Nov 2021 01:23:07 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6C98468AA6; Fri, 12 Nov 2021 07:20:15 +0100 (CET)
Date:   Fri, 12 Nov 2021 07:20:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [syzbot] possible deadlock in __loop_clr_fd (3)
Message-ID: <20211112062015.GA28294@lst.de>
References: <00000000000089436205d07229eb@google.com> <0e91a4b0-ef91-0e60-c0fc-e03da3b65d57@I-love.SAKURA.ne.jp> <YYxqHhzEwCqhsy1Y@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com> <9e583550-7cc8-e8a9-59bf-69d415fffe16@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e583550-7cc8-e8a9-59bf-69d415fffe16@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Tetsuo,

I think this approach is fine, but we can further simplify it.

> +	/*
> +	 * Since ioctl(LOOP_CLR_FD) depends on lo->lo_state == Lo_bound, it is
> +	 * a sign of something going wrong if lo->lo_backing_file was not
> +	 * assigned by ioctl(LOOP_SET_FD) or ioctl(LOOP_CONFIGURE).
> +	 */
>  	filp = lo->lo_backing_file;
> -	if (filp == NULL) {
> -		err = -EINVAL;
> -		goto out_unlock;
> -	}
> +	BUG_ON(!filp);

I'd just drop the check here entirely.

>  	if (test_bit(QUEUE_FLAG_WC, &lo->lo_queue->queue_flags))
>  		blk_queue_write_cache(lo->lo_queue, false, false);
> @@ -1121,7 +1125,20 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
>  	/* freeze request queue during the transition */
>  	blk_mq_freeze_queue(lo->lo_queue);
>  
> +	/*
> +	 * To avoid circular locking dependency, call destroy_workqueue()
> +	 * without holding lo->lo_mutex.
> +	 */
> +	mutex_unlock(&lo->lo_mutex);
>  	destroy_workqueue(lo->workqueue);
> +	mutex_lock(&lo->lo_mutex);

As far as I can tell there is absolutely no need to hold lo_mutex
above these changes at all, as the Lo_rundown check prevents
access to all the other fields we're changing.  So I think we can
drop this entire critical section and just keep the one at the
end of the funtion where lo_state is changed.
