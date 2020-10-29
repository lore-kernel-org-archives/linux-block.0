Return-Path: <SRS0=RRdq=EE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFC6C2D0A3
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 13:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9184920732
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 13:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V34W1Irm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6Y/ir7ld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgJ2NMQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Oct 2020 09:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ2NMQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Oct 2020 09:12:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042DCC0613CF;
        Thu, 29 Oct 2020 06:12:16 -0700 (PDT)
Date:   Thu, 29 Oct 2020 14:12:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603977134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fk+WZY2xbXIMgNTW2+py6Qdo4VO/MHiXMiqy2JiYuFs=;
        b=V34W1Irmj1MqCOsurIeCIYkcascqvX5NWXsotBazInc303wJ5B/aHw6/WorbIvud+40+rN
        kM3bJ6UpgZjNuU4x/Pv5bjDJ+OpaiIlOT2aeIn04TwLS3f392QwTb84qkz7Zg7h+LA/vNb
        K2WLrDfx9yhagAkFI3czCrQ80jB+djytXPuqwyaYYMtZpViehaVHo1uryAM6ZG407XqUgD
        8090Up5eDZKXj50MkYHjLJL1ikAau0npjDOYlh6BzaW0W79VFFQtcMK0dKuj+fmg3b0JrN
        5bo8jfHq+flHgksGogzjGkGNFIBkEvW4Ms1/RpFSPTW9SWbb1EvDnMV34515/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603977134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fk+WZY2xbXIMgNTW2+py6Qdo4VO/MHiXMiqy2JiYuFs=;
        b=6Y/ir7ld4hBHwYpzAGj+QoR+Vu3ZGiHndkC3r0svch47vF50XJ9gZr7vD+czNX6CegTwDd
        OvXaS2/RE2SFNZCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Runge <dave@sleepmap.de>, linux-rt-users@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>, Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 3/3] blk-mq: Use llist_head for blk_cpu_done
Message-ID: <20201029131212.dsulzvsb6pahahbs@linutronix.de>
References: <20201028065616.GA24449@infradead.org>
 <20201028141251.3608598-1-bigeasy@linutronix.de>
 <20201028141251.3608598-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201028141251.3608598-3-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-10-28 15:12:51 [+0100], To linux-block@vger.kernel.org wrote:
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -667,14 +632,21 @@ bool blk_mq_complete_request_remote(struct request =
*rq)
>  		return false;
> =20
>  	if (blk_mq_complete_need_ipi(rq)) {
=E2=80=A6
>  	} else {
>  		if (rq->q->nr_hw_queues > 1)
>  			return false;
> -		blk_mq_trigger_softirq(rq);
> +		cpu_list =3D this_cpu_ptr(&blk_cpu_done);
> +		if (llist_add(&rq->ipi_list, cpu_list))
> +			raise_softirq(BLOCK_SOFTIRQ);
>  	}
> =20
>  	return true;

So Mike posted this:
| BUG: using smp_processor_id() in preemptible [00000000] code: usb-storage=
/841
| caller is blk_mq_complete_request_remote.part.0+0xa2/0x120
| CPU: 0 PID: 841 Comm: usb-storage Not tainted 5.10.0-rc1+ #61
| Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-1 04/01/2=
014
| Call Trace:
|  dump_stack+0x77/0x97
|  check_preemption_disabled+0xbe/0xc0
|  blk_mq_complete_request_remote.part.0+0xa2/0x120
|  blk_mq_complete_request+0x2e/0x40
|  usb_stor_control_thread+0x29a/0x300
|  kthread+0x14b/0x170
|  ret_from_fork+0x22/0x30

This comes from this_cpu_ptr() because usb_stor_control_thread() runs
with enabled preemption.

Adding preempt_disable() around it will make the warning go away but
will wake the ksoftirqd (this happens now, too).
Adding local_bh_disable() around it would perform the completion
immediately (instead of waking kssoftirqd) but local_bh_enable() feels
slightly more expensive.

Are there many drivers completing the SCSI requests in preemtible
context? In this case it would be more efficient to complete the request
directly (usb_stor_control_thread() goes to sleep after that anyway and
there is only one request at a time).

Sebastian
