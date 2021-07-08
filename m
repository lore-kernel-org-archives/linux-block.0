Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB1FC07E96
	for <linux-block@archiver.kernel.org>; Thu,  8 Jul 2021 13:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B36876141A
	for <linux-block@archiver.kernel.org>; Thu,  8 Jul 2021 13:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbhGHN70 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Jul 2021 09:59:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51882 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbhGHN7Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Jul 2021 09:59:25 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625752602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VPQ2ZA0HOLGPExkWK2cisFIdzBiZzdwbASzr51cJpYU=;
        b=UD1BJ0YUNUmAwL3JPxUEsyS3kgo6ysO2QLwV2gj57lGgc+PDqkyFwRjrJ4mr8aR3eDDUB7
        Dtj+t7Heglo50HUG1s+0OUcAggIA1m2UYrOfXo688h2O8JHImrDoxkfK7r1NQ1Pn6qaHXk
        PfEkNLTIWQn1uZh73o3NJZtsCHtg1z/ac/Jf1Zt45U74+YINUC6Y4Gi03cHSn2jW0W9/QM
        15dW+TmEOap8/d4On4vG5iTmro2MnejN80HqUmZpCXe046L6co0Pjr5JOpypftNC6Us3xg
        p3FbmHTLOx3CA/ND/teLgQgzTkpdRFKBhHbW88cMs20B5n4bS8HDbIPEg57kjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625752602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VPQ2ZA0HOLGPExkWK2cisFIdzBiZzdwbASzr51cJpYU=;
        b=svXx/Vvotn0GziFiXLpEPUJBSMqeFHe4hPQkHiOocKoxnYstASX4p+Mg29CNq5Xs0AWPFu
        BbUNOvbLrnANX+BQ==
To:     Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: build default queue map via irq_create_affinity_masks
In-Reply-To: <YN2Q3XFSS7T23bih@infradead.org>
References: <20210630035153.2099975-1-ming.lei@redhat.com> <YN2Q3XFSS7T23bih@infradead.org>
Date:   Thu, 08 Jul 2021 15:56:42 +0200
Message-ID: <877di0q57p.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 01 2021 at 10:54, Christoph Hellwig wrote:
>> Address the issue by reusing irq_create_affinity_masks() for building
>> the default queue mapping, so that we can re-use the mapping created
>> for managed irq.
>
> This looks sensible, but adding Thomas to see if he is fine with
> using an irq function like this.  Maybe it needs to move out of the
> irq code and grow a new name if we use it like this.

Yes, making it less irq centric and sticking it into lib makes sense.

The usage sites then can have their specific wrappers around it.

Thanks,

        tglx
