Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DF4C10F04
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 20:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311A5222A1
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 20:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550175286;
	bh=4gGv1UmLYdG5lQFoHAkvRd+k3yDccrs8esQwELrrZk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tw5SaOWF2ZKhjO2z2etg1yuaWdhfmiI3AbHVc6/8lCzY9GVr1XPf5ng8dO+YhUdf+
	 qRqTy9plQE8hMvfTryQ/GQRdmTUOS7FL9oWtBLJKqfqFINDL77iFGAF+U19SfP0Nzo
	 UMGZAz3/K/5ZMjpxDu3SDNX1YHHv4qAnAmt2Bmss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406089AbfBNUOp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:14:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:42342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391479AbfBNUOp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 15:14:45 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BA462229F;
        Thu, 14 Feb 2019 20:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550175283;
        bh=4gGv1UmLYdG5lQFoHAkvRd+k3yDccrs8esQwELrrZk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C/HOcgTuIk3m6J00n4S8kG4dSTXUd/w0s5hOzBdkATuxbJNbSLNAg4Zd+Odqdr6U3
         mNhBIoGAkHQHTMCoR9v1QLxohcnOjdF1q1dzTBPN4/Vg+zc1mpt0xdi+46QzsWbcLL
         2ZD/rlyQUhaHvac3cBMznro0JFuQLcqV2YSQR+/k=
Date:   Thu, 14 Feb 2019 14:14:41 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH V4 2/4] genirq/affinity: add new callback for caculating
 interrupt sets size
Message-ID: <20190214201441.GM96272@google.com>
References: <20190214122347.17372-1-ming.lei@redhat.com>
 <20190214122347.17372-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214122347.17372-3-ming.lei@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 14, 2019 at 08:23:45PM +0800, Ming Lei wrote:
> The interrupt affinity spreading mechanism supports to spread out
> affinities for one or more interrupt sets. A interrupt set contains one
> or more interrupts. Each set is mapped to a specific functionality of a
> device, e.g. general I/O queues and read I/O queus of multiqueue block
> devices.
> 
> The number of interrupts per set is defined by the driver. It depends on
> the total number of available interrupts for the device, which is
> determined by the PCI capabilites and the availability of underlying CPU
> resources, and the number of queues which the device provides and the
> driver wants to instantiate.
> 
> The driver passes initial configuration for the interrupt allocation via
> a pointer to struct affinity_desc.
> 
> Right now the allocation mechanism is complex as it requires to have a
> loop in the driver to determine the maximum number of interrupts which
> are provided by the PCI capabilities and the underlying CPU resources.
> This loop would have to be replicated in every driver which wants to
> utilize this mechanism. That's unwanted code duplication and error
> prone.
> 
> In order to move this into generic facilities it is required to have a
> mechanism, which allows the recalculation of the interrupt sets and
> their size, in the core code. As the core code does not have any
> knowledge about the underlying device, a driver specific callback will
> be added to struct affinity_desc, which will be invoked by the core
> code. The callback will get the number of available interupts as an
> argument, so the driver can calculate the corresponding number and size
> of interrupt sets.
> 
> To support this, two modifications for the handling of struct
> affinity_desc are required:
> 
> 1) The (optional) interrupt sets size information is contained in a
>    separate array of integers and struct affinity_desc contains a
>    pointer to it.
> 
>    This is cumbersome and as the maximum number of interrupt sets is
>    small, there is no reason to have separate storage. Moving the size
>    array into struct affinity_desc avoids indirections makes the code
>    simpler.
> 
> 2) At the moment the struct affinity_desc pointer which is handed in from
>    the driver and passed through to several core functions is marked
>    'const'.
> 
> This patch adds callback to recalculate the number and size of interrupt sets,
> also removes the 'const' qualifier for 'affd'.
> 
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

I know you have something to work out in the affinity.c part of this, but
I'm fine with the PCI part, so:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
