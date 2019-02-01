Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3E2C282D8
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 21:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE3F2146E
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 21:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfBAV6V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 16:58:21 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:52354 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfBAV6V (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Feb 2019 16:58:21 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gpgoy-0007aK-1C; Fri, 01 Feb 2019 22:58:00 +0100
Date:   Fri, 1 Feb 2019 22:57:59 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Hannes Reinecke <hare@suse.de>
cc:     John Garry <john.garry@huawei.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: Question on handling managed IRQs when hotplugging CPUs
In-Reply-To: <745609be-b215-dd2d-c31f-0bd84572f49f@suse.de>
Message-ID: <alpine.DEB.2.21.1902012255550.8200@nanos.tec.linutronix.de>
References: <f6f6e031-8b79-439d-c2af-8d3e76f30710@huawei.com> <20190129154433.GF15302@localhost.localdomain> <757902fc-a9ea-090b-7853-89944a0ce1b5@huawei.com> <20190129172059.GC17132@localhost.localdomain> <3fe63dab-0791-f476-69c4-9866b70e8520@huawei.com>
 <alpine.DEB.2.21.1901301338170.5537@nanos.tec.linutronix.de> <86d5028d-44ab-3696-f7fe-828d7655faa9@huawei.com> <745609be-b215-dd2d-c31f-0bd84572f49f@suse.de>
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

On Fri, 1 Feb 2019, Hannes Reinecke wrote:
> Thing is, if we have _managed_ CPU hotplug (ie if the hardware provides some
> means of quiescing the CPU before hotplug) then the whole thing is trivial;
> disable SQ and wait for all outstanding commands to complete.
> Then trivially all requests are completed and the issue is resolved.
> Even with todays infrastructure.
> 
> And I'm not sure if we can handle surprise CPU hotplug at all, given all the
> possible race conditions.
> But then I might be wrong.

The kernel would completely fall apart when a CPU would vanish by surprise,
i.e. uncontrolled by the kernel. Then the SCSI driver exploding would be
the least of our problems.

Thanks,

	tglx
