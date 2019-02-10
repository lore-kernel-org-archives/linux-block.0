Return-Path: <SRS0=XSHr=QR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B837C282D7
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 18:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C59B21736
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 18:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfBJSt0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Feb 2019 13:49:26 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:37242 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfBJStZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Feb 2019 13:49:25 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gsuAC-00089D-Rx; Sun, 10 Feb 2019 19:49:12 +0100
Date:   Sun, 10 Feb 2019 19:49:12 +0100 (CET)
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
Message-ID: <alpine.DEB.2.21.1902101815260.8784@nanos.tec.linutronix.de>
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
> +static int nvme_setup_affinity(const struct irq_affinity *affd,
> +			       struct irq_affinity_desc *masks,
> +			       unsigned int nmasks)
> +{
> +	struct nvme_dev *dev = affd->priv;
> +	int affvecs = nmasks - affd->pre_vectors - affd->post_vectors;
> +	int curvec, usedvecs;
> +	int i;
> +
> +	nvme_calc_io_queues(dev, nmasks);

So this is the only NVME specific information. Everything else can be done
in generic code. So what you really want is:

	struct affd {
		...
+		calc_sets(struct affd *, unsigned int nvecs);
		...
	}

And sets want to be actually inside of the affinity descriptor structure:

        unsigned int num_sets;
	unsigned int set_vectors[MAX_SETS];

We surely can define a sensible maximum of sets for now. If that ever turns
out to be insufficient, then struct affd might become to large for the
stack, but for now, using e.g. 8, there is no need to do so.

So then the logic in the generic code becomes exactly the same as what you
added to nvme_setup_affinity():

	if (affd->calc_sets) {
		affd->calc_sets(affd, nvecs);
	} else if (!affd->num_sets) {
		affd->num_sets = 1;
		affd->set_vectors[0] = affvecs;
	}

	for (i = 0; i < affd->num_sets; i++) {
	    ....
	}

See?

Thanks,

	tglx
