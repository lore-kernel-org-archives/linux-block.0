Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3CFC2D0E4
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 22:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4F122083E
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 22:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KTCOU6z7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r3f45/W7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731523AbgKXWTu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Nov 2020 17:19:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46036 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgKXWTu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Nov 2020 17:19:50 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606256388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UQPfZ1J61H/ekBBAaR7V+BMvtX4EMI5nVnNHoIml4cY=;
        b=KTCOU6z7nYzCZBSY4aJF/Aw1YsI/0XmAB81NTW165bZxAvN6oPmLaSaBFZhUZVWjynlOxq
        nCqWsnt4RieChFXuP867sMeXaPnmW8u9fsV/Gbn1BRdJFB0VNGb0IMyJuyKWV5fpQyC6Jt
        Q2+/iL9J5edexGyDWyELgePpPZ/YShwU3DYFxcjZYOgjnfc4gYsnB7RdcnNPrWff7unbZG
        ZaY9pqTia2ITN3vQpLhyzkscxHZNhl11PdmcdDEZzzZQZGjxDtppP10EiOsvCL4XOkbx9r
        wAODJhjVw1jxFk0zsJcwnnxhVVX+iuhSgj/FNYp2v3UlVTFEEzGMaR8nasrQfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606256388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UQPfZ1J61H/ekBBAaR7V+BMvtX4EMI5nVnNHoIml4cY=;
        b=r3f45/W7npRZRZ1ON6VohbAgkqBJpwE8zrsNWH62oAgAok6llT9gv4Vwh4nOwx5LB/Q3g3
        Ri3BgRrqGnP3aaDw==
To:     Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-block@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Marc Zyngier <maz@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 1/2] genirq: add an affinity parameter to irq_create_mapping()
In-Reply-To: <20201124200308.1110744-2-lvivier@redhat.com>
References: <20201124200308.1110744-1-lvivier@redhat.com> <20201124200308.1110744-2-lvivier@redhat.com>
Date:   Tue, 24 Nov 2020 23:19:47 +0100
Message-ID: <87h7pel7ng.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 24 2020 at 21:03, Laurent Vivier wrote:
> This parameter is needed to pass it to irq_domain_alloc_descs().
>
> This seems to have been missed by
> o06ee6d571f0e ("genirq: Add affinity hint to irq allocation")

No, this has not been missed at all. There was and is no reason to do
this.

> This is needed to implement proper support for multiqueue with
> pseries.

And because pseries needs this _all_ callers need to be changed?

>  123 files changed, 171 insertions(+), 146 deletions(-)

Lots of churn for nothing. 99% of the callers will never need that.

What's wrong with simply adding an interface which takes that parameter,
make the existing one an inline wrapper and and leave the rest alone?

Thanks,

        tglx



