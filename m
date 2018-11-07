Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33090 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbeKHBlV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Nov 2018 20:41:21 -0500
Message-ID: <1541607019.196084.210.camel@acm.org>
Subject: Re: [PATCH] block: respect virtual boundary mask in bvecs
From: Bart Van Assche <bvanassche@acm.org>
To: Sagi Grimberg <sagi@grimberg.me>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Jens Axboe <axboe@fb.com>
Cc: Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Date: Wed, 07 Nov 2018 08:10:19 -0800
In-Reply-To: <950a7996-e0f7-ff34-04da-47581a9496f0@grimberg.me>
References: <20181105102301.9752-1-jthumshirn@suse.de>
         <a97f3d77-d23b-b418-abce-2d93ed725bdb@acm.org>
         <c15244a4-9085-5255-edea-b92a9ed1307c@suse.de>
         <950a7996-e0f7-ff34-04da-47581a9496f0@grimberg.me>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, 2018-11-06 at 19:30 -0800, Sagi Grimberg wrote:
+AD4 +AD4 +AD4 How about changing that expression into the following to make it easier
+AD4 +AD4 +AD4 for the compiler to optimize this code?
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 (offset +AHw (bprv-+AD4-bv+AF8-offset +- bprv-+AD4-bv+AF8-len)) +ACY queue+AF8-virt+AF8-boundary(q)
+AD4 +AD4 
+AD4 +AD4 Uhm I have to admit I'm not really able to parse the above expression.
+AD4 +AD4 Sure GCC will do it but I think it's less readable (at least for me).
+AD4 +AD4 Let's see what other's think.
+AD4 
+AD4 I personally not a huge fan of decoding complicated expressions. But if
+AD4 others are fine with it then I am too...

What I proposed is not a new pattern. It is a pattern that is already used
elsewhere in the Linux kernel. A few examples:

>From dmabounce.c:

		/+ACo Figure out if we need to bounce from the DMA mask. +ACo-/
		if ((dma+AF8-addr +AHw (dma+AF8-addr +- size - 1)) +ACY +AH4-mask)
			return 1+ADs

>From dma-direct.h:

	if ((addr +AHw (addr +- size - 1)) +ACY +AH4-mask)
		return 0+ADs

Bart.
