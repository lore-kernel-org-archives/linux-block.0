Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAF4C5519F
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 07:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0784020872
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 07:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fA9CICIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgKYHaT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 02:30:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47305 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726027AbgKYHaT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 02:30:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606289418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D3DSrYj+gqE7fmTGGcLGiNd0q/oeDN1ODN+0Xluwkpc=;
        b=fA9CICIbgyXjS69Z6vTqpHdS8ITgmWbSy2XevqJNelZW0fnX01zkFd1otHTyJbgcFiWQa0
        o5KhkAO4dXq4epX5JilmW9dDm2dDIbJjeHGvVCVVQWDkCtFyTFtKZYlO6sJR1eMeGsd5C9
        k6a0pf1GjYFKCvot8A3oovlTcwkLyds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-HGAXgTQcP7C0r00a5_OLvQ-1; Wed, 25 Nov 2020 02:30:15 -0500
X-MC-Unique: HGAXgTQcP7C0r00a5_OLvQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 161A618C89E0;
        Wed, 25 Nov 2020 07:30:13 +0000 (UTC)
Received: from [10.36.113.83] (ovpn-113-83.ams2.redhat.com [10.36.113.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DDFAF10023B0;
        Wed, 25 Nov 2020 07:30:06 +0000 (UTC)
Subject: Re: [PATCH 1/2] genirq: add an affinity parameter to
 irq_create_mapping()
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-block@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Marc Zyngier <maz@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20201124200308.1110744-1-lvivier@redhat.com>
 <20201124200308.1110744-2-lvivier@redhat.com>
 <87h7pel7ng.fsf@nanos.tec.linutronix.de>
From:   Laurent Vivier <lvivier@redhat.com>
Message-ID: <8e9002d0-086f-1e7d-4b94-45b6d49f7917@redhat.com>
Date:   Wed, 25 Nov 2020 08:30:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <87h7pel7ng.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 24/11/2020 23:19, Thomas Gleixner wrote:
> On Tue, Nov 24 2020 at 21:03, Laurent Vivier wrote:
>> This parameter is needed to pass it to irq_domain_alloc_descs().
>>
>> This seems to have been missed by
>> o06ee6d571f0e ("genirq: Add affinity hint to irq allocation")
> 
> No, this has not been missed at all. There was and is no reason to do
> this.
> 
>> This is needed to implement proper support for multiqueue with
>> pseries.
> 
> And because pseries needs this _all_ callers need to be changed?
> 
>>  123 files changed, 171 insertions(+), 146 deletions(-)
> 
> Lots of churn for nothing. 99% of the callers will never need that.
> 
> What's wrong with simply adding an interface which takes that parameter,
> make the existing one an inline wrapper and and leave the rest alone?

Nothing. I'm going to do like that.

Thank you for your comment.

Laurent

