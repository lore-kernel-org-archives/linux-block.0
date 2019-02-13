Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4B5C282CE
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 20:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC60218D9
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 20:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389961AbfBMU7F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:59:05 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:47681 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731303AbfBMU7F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 15:59:05 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gu1cP-0005Vc-2Z; Wed, 13 Feb 2019 21:58:57 +0100
Date:   Wed, 13 Feb 2019 21:58:56 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH V3 3/5] genirq/affinity: add new callback for caculating
 set vectors
In-Reply-To: <20190213151149.GD96272@google.com>
Message-ID: <alpine.DEB.2.21.1902132157060.1659@nanos.tec.linutronix.de>
References: <20190213105041.13537-1-ming.lei@redhat.com> <20190213105041.13537-4-ming.lei@redhat.com> <20190213151149.GD96272@google.com>
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

On Wed, 13 Feb 2019, Bjorn Helgaas wrote:
> > Add a new callback of .calc_sets into 'struct irq_affinity' so that
> > driver can caculate set vectors after IRQ vector is allocated and
> > before spread IRQ vectors. Add 'priv' so that driver may retrieve
> > its private data via the 'struct irq_affinity'.
> 
> s/caculate/calculate/
> 
> I *think* "set vectors" here has something to do with an affinity
> cpumask?  "Set vectors" doesn't seem like quite the right terminology.

See previous mail. Let's stay with 'interrupt sets' and get rid of the
vector naming completely.

Thanks,

	tglx
