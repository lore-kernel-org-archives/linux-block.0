Return-Path: <SRS0=AIgI=CD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA08C433E3
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 23:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED5E620738
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 23:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prgmr.com header.i=@prgmr.com header.b="N0dEF/fI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgHYX4J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Aug 2020 19:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgHYX4I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Aug 2020 19:56:08 -0400
Received: from mail.prgmr.com (mail.prgmr.com [IPv6:2605:2700:0:5::4713:9506])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76904C061574
        for <linux-block@vger.kernel.org>; Tue, 25 Aug 2020 16:56:08 -0700 (PDT)
Received: from [10.0.0.5] (c-69-181-255-113.hsd1.ca.comcast.net [69.181.255.113])
        (Authenticated sender: srn)
        by mail.prgmr.com (Postfix) with ESMTPSA id 4787F720108;
        Tue, 25 Aug 2020 19:47:04 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.prgmr.com 4787F720108
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prgmr.com;
        s=default; t=1598399224;
        bh=UzkhGebzUoyl2dVdvTEKF9RrJ0HujijtDqj9bjFVx0k=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=N0dEF/fI11x0RouNawETzimCJQ+7aWuZIwbY4J8/FpPee4F6wFI7/GklXrDp1sxCP
         0lHt5FoRritvdCaMAkMT+GeykOfa4vmXTY3Gs5uWSWN2M2+x8mTN2Hd2ZdIT/BlJfu
         fy3KkQoDpjfqFyVtQQKunen5lMbZWG4u9ZmC31PI=
Subject: Re: [PATCH] block: drbd: add missing kref_get in
 handle_write_conflicts
To:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        axboe@kernel.dk
References: <20200819054926.30758-1-srn@prgmr.com>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org
From:   Sarah Newman <srn@prgmr.com>
Message-ID: <71f60e04-8470-ae0d-3bda-17572b569b28@prgmr.com>
Date:   Tue, 25 Aug 2020 16:47:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819054926.30758-1-srn@prgmr.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/18/20 10:49 PM, Sarah Newman wrote:
> The other place that drbd_send_acks_wf was called from already
> calls kref_get.
> 
> This can be reproduced with the following for an existing
> connection:
> 
> drbdsetup net-options local_addr remote_addr \
>    --protocol=C \
>    --allow-two-primaries
> 
> drbsetup primary minor
> dd if=/dev/drbd<minor> of=sector bs=512 count=1
> while true; do dd if=sector of=/dev/drbd<minor>; done
> 
> During this, if we have function tracing enabled for e_send_superseded, it
>    triggers:
> 
> $ sudo cat /sys/kernel/tracing/trace_pipe
>      kworker/u4:2-14838 [001] .... 113244.465689: e_send_superseded <-drbd_finish_peer_reqs
>      kworker/u4:2-14838 [001] .... 113244.468237: e_send_superseded <-drbd_finish_peer_reqs
>      kworker/u4:2-14838 [001] .... 113244.482757: e_send_superseded <-drbd_finish_peer_reqs
>      kworker/u4:1-15502 [001] .... 113244.485092: e_send_superseded <-drbd_finish_peer_reqs
> 
> This eventually results in behavior like:
> 
> [113418.435846] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [dd:15505]
> 
> Or a message similar to
> 
> block drbd0: ASSERT( device->open_cnt == 0 )
>    in drivers/block/drbd/drbd_main.c:2232
> 
> Signed-off-by: Sarah Newman <srn@prgmr.com>
> ---
>   drivers/block/drbd/drbd_receiver.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
> index 2b3103c30857..1ad693a5aab5 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -2531,7 +2531,11 @@ static int handle_write_conflicts(struct drbd_device *device,
>   			peer_req->w.cb = superseded ? e_send_superseded :
>   						   e_send_retry_write;
>   			list_add_tail(&peer_req->w.list, &device->done_ee);
> -			queue_work(connection->ack_sender, &peer_req->peer_device->send_acks_work);
> +			/* put is in drbd_send_acks_wf() */
> +			kref_get(&device->kref);
> +			if (!queue_work(connection->ack_sender,
> +					&peer_req->peer_device->send_acks_work))
> +				kref_put(&device->kref, drbd_destroy_device);
>   
>   			err = -ENOENT;
>   			goto out;
> 

Added linux-block as a CC. I can resend this patch if necessary.

Checking in to see if any changes or additional testing is required for this patch before it's accepted.

Thanks, Sarah
