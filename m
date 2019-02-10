Return-Path: <SRS0=XSHr=QR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98A9C282C2
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 16:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D9121773
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 16:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfBJQjb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Feb 2019 11:39:31 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:37170 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfBJQja (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Feb 2019 11:39:30 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gss8Y-0006jE-Ej; Sun, 10 Feb 2019 17:39:22 +0100
Date:   Sun, 10 Feb 2019 17:39:20 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>
cc:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/5] nvme-pci: simplify nvme_setup_irqs() via .setup_affinity
 callback
In-Reply-To: <20190125095347.17950-5-ming.lei@redhat.com>
Message-ID: <alpine.DEB.2.21.1902101731370.8784@nanos.tec.linutronix.de>
References: <20190125095347.17950-1-ming.lei@redhat.com> <20190125095347.17950-5-ming.lei@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 25 Jan 2019, Ming Lei wrote:

> Use the callback of .setup_affinity() to re-caculate number
> of queues, and build irqs affinity with help of irq_build_affinity().
> 
> Then nvme_setup_irqs() gets simplified a lot.

I'm pretty sure you can achieve the same by reworking the core code without
that callback.
 
> +	/* Fill out vectors at the beginning that don't need affinity */
> +	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
> +		cpumask_copy(&masks[curvec].mask, cpu_possible_mask);

cpu_possible_mask is wrong.  Why are you deliberately trying to make this
special? There is absolutely no reason to do so.

These interrupts are not managed and therefore the initial affinity has to
be irq_default_affinity. Setting them to cpu_possible_mask can and probably
will evade a well thought out default affinity mask, which was set to
isolate a set of cores from general purpose interrupts.

This is exactly the thing which happens with driver special stuff and which
needs to be avoided. There is nothing special about this NVME setup and
yes, I can see why the current core code is a bit tedious to work with, but
that does not justify that extra driver magic by any means.

Thanks,

	tglx

