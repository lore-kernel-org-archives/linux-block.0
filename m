Return-Path: <SRS0=V8DZ=QZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C7EC43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Feb 2019 08:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68C021479
	for <linux-block@archiver.kernel.org>; Mon, 18 Feb 2019 08:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfBRIne (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:43:34 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53856 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727423AbfBRIne (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Feb 2019 03:43:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F365A78;
        Mon, 18 Feb 2019 00:43:33 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF6513F589;
        Mon, 18 Feb 2019 00:43:30 -0800 (PST)
Date:   Mon, 18 Feb 2019 08:43:26 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>
Subject: Re: [patch v6 0/7] genirq/affinity: Overhaul the multiple interrupt
 sets support
Message-ID: <20190218084326.40e544e2@why.wild-wind.fr.eu.org>
In-Reply-To: <20190216171306.403545970@linutronix.de>
References: <20190216171306.403545970@linutronix.de>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 16 Feb 2019 18:13:06 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> This is the final update to the series with a few corner cases fixes
> vs. V5 which can be found here:
> 
>    https://lkml.kernel.org/r/20190214204755.819014197@linutronix.de
> 
> The series applies against:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
> 
> and is also available from:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.irq
> 
> Changes vs. V5:
> 
>   - Change the invocation for the driver callback so it is invoked even
>     when there are no interrupts left to spread out. That ensures that the
>     driver can adjust to the situation (in case of NVME a single interrupt)
> 
>   - Make sure the callback is invoked in the legacy irq fallback case so
>     the driver is not in a stale state from a failed MSI[X} allocation
>     attempt.
> 
>   - Fix the adjustment logic in the NVME driver as pointed out by Ming and
>     Marc, plus another corner case I found during testing.
> 
>   - Simplify the unmanaged set support
> 
> Thanks,
> 
> 	tglx
> 
> 8<-------------
>  drivers/nvme/host/pci.c         |  117 +++++++++++++---------------------------
>  drivers/pci/msi.c               |   39 +++++--------
>  drivers/scsi/be2iscsi/be_main.c |    2 
>  include/linux/interrupt.h       |   35 ++++++++---
>  include/linux/pci.h             |    4 -
>  kernel/irq/affinity.c           |  116 ++++++++++++++++++++++++---------------
>  6 files changed, 153 insertions(+), 160 deletions(-)
> 
> 

For the series (with or without patch 7), feel free to add my

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
