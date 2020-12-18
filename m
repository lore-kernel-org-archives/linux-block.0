Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79515C4361B
	for <linux-block@archiver.kernel.org>; Fri, 18 Dec 2020 15:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D23E23AFD
	for <linux-block@archiver.kernel.org>; Fri, 18 Dec 2020 15:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgLRPTH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Dec 2020 10:19:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53056 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgLRPTH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Dec 2020 10:19:07 -0500
Date:   Fri, 18 Dec 2020 16:18:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608304706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D+1YCuCH9hM9IVcSXQdudiOho6peNELZuBFeD+bzDcY=;
        b=t3kOuIh7S2w6pT0OqoMDDZ5GTqYZpGwAC32VOqQCMBgvkZcswEDjIV1kk2ciRqBDi8Veck
        NL0D9Txv4zV9XsLDJTDCnpeDk8oRwAumEAy2wUpoJE+kKlaWlfztI+qxABp+BuLlQDPcV8
        dWYQPiF7xOzYI0/uEoMlspHmfcShbWZVFivjZfECOOAFRt82UG2nfDlTfN47TS5rB/Qabl
        OGk2zyAVKchBBRAIxlqCqZ/E4hrzEtnv7hqBzmfm72iWN4Gw/cuCc23jmrHLWIjU08l3Xy
        FcPHNzqnhfGLEhIgNVaJWO8QPqmWW5FxW/dAr20Cc4ZLqKIoTCtFXSrrEljupw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608304706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D+1YCuCH9hM9IVcSXQdudiOho6peNELZuBFeD+bzDcY=;
        b=HEep+2p632Dd/yBWaxQRMvvZoTlNBtYTHakSDDDHrRHoYqbuRYKFsBX3VkzPultKto0DK/
        vw59ZrGCCY5YWcBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: "blk-mq: Use llist_head for blk_cpu_done" causing warnings
Message-ID: <20201218151824.quxry5bmaqlpohkr@linutronix.de>
References: <1ee4b31b-350e-a9f5-4349-cfb34b89829a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ee4b31b-350e-a9f5-4349-cfb34b89829a@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-12-18 08:02:59 [-0700], Jens Axboe wrote:
> Hi Sebastian,
Hi Jens,

> I'm running into these when that last patch is applied:
> 
> NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #10!!!
> 
> on at least my kvm test bed on the laptop. I'm going to revert this
> series for now.

Okay. Can you keep #1 from the series?

Anyway, could you please throw a .config and the test in my inbox so I
can reproduce it and then I will look at this next year.

Sebastian
