Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C699C49361
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 19:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6687961264
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 19:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbhFRTVY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jun 2021 15:21:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58504 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbhFRTVY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jun 2021 15:21:24 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624043953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sSLxGC3VTRMA2Whz78he85SSFCN5pOWp9Ja2rRincrE=;
        b=Nh4soZq81bzyJPDPuk6OzK7HF4t54zEr2or1xJZHbE/JpRDaIB2XoDCYU9n1UiBMxI+SpZ
        gYAStHegI/oNOuab4hNo8UKqfktYNa6DHie9NnNhpHnOi3ZTmOnHBRS9t6Mwni1Sw0CrRv
        2++Ypt6yi9HJswKEy/4ehOO1ygPmj9JcbMcNedlZGwJwRriy8Sdg1U6HWjRRrw9tto4BTC
        /TfF50Bzzxe/CTixRdGbI9ln6URYNxw0lM/9SNRLk1Q9BPybWFiwTOEWlCLd3VT237g679
        Kl5ANInl8B/rrHu6xEerRqfVGkFhf2eavm+zWxVhvBbP6DegejfN/f65ELFQeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624043953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sSLxGC3VTRMA2Whz78he85SSFCN5pOWp9Ja2rRincrE=;
        b=RSZzBGebnC17LsPojYK3bBoRQRgGmd+zjyPW5m11as59RHQl5NDNcQRPMID7YkOywbpvre
        Lg6856XaSEqMB/AA==
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>
Subject: Re: [patch v6 3/7] genirq/affinity: Add new callback for (re)calculating interrupt sets
In-Reply-To: <20210615195707.GA2909907@bjorn-Precision-5520>
References: <20210615195707.GA2909907@bjorn-Precision-5520>
Date:   Fri, 18 Jun 2021 21:19:12 +0200
Message-ID: <878s37f0b3.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 15 2021 at 14:57, Bjorn Helgaas wrote:
>
>> @@ -1196,6 +1196,13 @@ int pci_alloc_irq_vectors_affinity(struc
>>  	/* use legacy irq if allowed */
>>  	if (flags & PCI_IRQ_LEGACY) {
>>  		if (min_vecs == 1 && dev->irq) {
>> +			/*
>> +			 * Invoke the affinity spreading logic to ensure that
>> +			 * the device driver can adjust queue configuration
>> +			 * for the single interrupt case.
>> +			 */
>> +			if (affd)
>> +				irq_create_affinity_masks(1, affd);
>
> This looks like a leak because irq_create_affinity_masks() returns a
> pointer to kcalloc()ed space, but we throw away the pointer.
>
> Or is there something very subtle going on here, like this special
> case doesn't allocate anything?  I do see the "Nothing to assign?"
> case that returns NULL with no alloc, but it's not completely trivial
> to verify that we take that case here.

Yes, it's subtle and it's subtle crap. Sorry that I did not catch that.

Thanks,

        tglx
