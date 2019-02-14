Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1E9C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 14:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414C02229F
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 14:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbfBNOuz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:50:55 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49977 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407338AbfBNOuw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 09:50:52 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1guILU-00012y-Ia; Thu, 14 Feb 2019 15:50:36 +0100
Date:   Thu, 14 Feb 2019 15:50:35 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>
cc:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH V4 2/4] genirq/affinity: add new callback for caculating
 interrupt sets size
In-Reply-To: <20190214122347.17372-3-ming.lei@redhat.com>
Message-ID: <alpine.DEB.2.21.1902141547320.1561@nanos.tec.linutronix.de>
References: <20190214122347.17372-1-ming.lei@redhat.com> <20190214122347.17372-3-ming.lei@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 14 Feb 2019, Ming Lei wrote:
> +	if (affd->calc_sets) {
> +		affd->calc_sets(affd, nvecs);
> +	} else if (!affd->nr_sets) {
> +		affd->nr_sets = 1;
> +		affd->set_size[0] = affvecs;

Hrmpf. I suggested that to you to get rid of the nr_sets local variable,
but that's actually broken. The reason is that on the first invocation from
the pci code, which is with maxvecs usually, the size is stored and if that
allocation failed, the subsequent invocation with maxvecs - 1 will not
update set_size[0] because affd->nr_sets == 1.

/me scratches head and stares at the code some more...

Thanks,

	tglx


