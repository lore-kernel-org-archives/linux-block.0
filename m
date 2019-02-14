Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7EDC10F04
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 18:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6DB222D0
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 18:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390218AbfBNSjO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:39:14 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:50833 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390182AbfBNSjO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 13:39:14 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1guLua-0007aU-Tu; Thu, 14 Feb 2019 19:39:05 +0100
Date:   Thu, 14 Feb 2019 19:38:53 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>
cc:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH V4 1/4] genirq/affinity: store interrupt sets size in
 'struct irq_affinity'
In-Reply-To: <20190214122347.17372-2-ming.lei@redhat.com>
Message-ID: <alpine.DEB.2.21.1902141937240.1646@nanos.tec.linutronix.de>
References: <20190214122347.17372-1-ming.lei@redhat.com> <20190214122347.17372-2-ming.lei@redhat.com>
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

On Thu, 14 Feb 2019, Ming Lei wrote:
> The driver passes initial configuration for the interrupt allocation via
> a pointer to struct affinity_desc.

Btw, blindly copying a suggestion without proof reading is a bad idea. That
want's to be 'struct irq_affinity' obviously. Tired brain confused them
yesterday night.

Thanks,

	tglx
