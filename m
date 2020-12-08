Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E3DC433FE
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 11:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11BA223A7F
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 11:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgLHLuU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 06:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgLHLuU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Dec 2020 06:50:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A68C061749
        for <linux-block@vger.kernel.org>; Tue,  8 Dec 2020 03:49:39 -0800 (PST)
Date:   Tue, 8 Dec 2020 12:49:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607428178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Pb1rVhIfpewZR47jfH1Wqr+hPpU7hoFsPzT02R8Enk=;
        b=W3Z1wivLzXwmHP7dx8fEXX63HpFJSCJEfn7D1zd8QhyDYf5PGjKLnuasjTRFyyoS0eXnnQ
        KJ6f12cdi+2mf70+bYb9SGlfeAqzwfXFQabWuM8R3RcOfWpPbstyvW1HTV8Aglnpxby2DL
        q6zViBCb3uhb+ADjknu8OQRkn1bZGM7Qn78M5XWaI4Qqmeji7qwsZDIwb9g/9JiTkDV5uB
        hWQOWMQcqMV0D20wi3kZFthRLzRd+ICEDSgs/FkO3KhOcYn1ALx6eTuuQaTnQFRkCrdjpL
        khcrXUfWkVIelPXP1CIME/w14BH/0AuQsWfvijXAHeCDmh4ojkY0uuGhZnhicA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607428178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Pb1rVhIfpewZR47jfH1Wqr+hPpU7hoFsPzT02R8Enk=;
        b=Ck0Zm1EHW84Q5zj/1N5V2j8EcIHiS1BYc184v4UZsJVx98P0TGVCYV0WTqhCQccyyRgpyh
        ta91UQ29DhTZrICQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <efault@gmx.de>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/3] blk-mq: Always complete remote completions requests
 in softirq
Message-ID: <20201208114936.sfe2jpmbjulcpyjk@linutronix.de>
References: <20201204191356.2516405-1-bigeasy@linutronix.de>
 <20201204191356.2516405-3-bigeasy@linutronix.de>
 <de7f392a-fbac-f7bc-662a-5f40dd4c0aa6@kernel.dk>
 <20201208082220.hhel5ubeh4uqrwnd@linutronix.de>
 <20201208084409.koeftbpnvesp4xtv@beryllium.lan>
 <20201208113653.awqz4zggmy37vbog@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201208113653.awqz4zggmy37vbog@beryllium.lan>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-12-08 12:36:53 [+0100], Daniel Wagner wrote:
> Obvious in this configuration there are no remote completions (verified
> it).

do you complete on a remote CPU if you limit the queues to one (this is
untested of course)?

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3be352403839a..f35224a64a56e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2126,7 +2126,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	 * If tags are shared with admin queue (Apple bug), then
 	 * make sure we only use one IO queue.
 	 */
-	if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)
+	if (1 || dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)
 		nr_io_queues = 1;
 	else
 		nr_io_queues = min(nvme_max_io_queues(dev),

> Thanks,
> Daniel

Sebastian
