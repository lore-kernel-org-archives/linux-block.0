Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1737C433ED
	for <linux-block@archiver.kernel.org>; Wed,  5 May 2021 20:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA9B1613AA
	for <linux-block@archiver.kernel.org>; Wed,  5 May 2021 20:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbhEEUMA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 May 2021 16:12:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39022 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230227AbhEEUMA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 May 2021 16:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620245463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GBjBuvXE2zdfbkNFPE3Y99JvsZ5ACCeZzTetq8hkZVc=;
        b=Beb/0M5Do8KK8dPxgZP/dCewXvbx99qltD9D2PB7lfyHj//vTkmuD1C+zM+EqxCdZQUEEG
        Hdm6DtFwAl17LzIz/coQ4k/3Gmy2q97jXUCQBjKecNF3lHxZAsOxtXM16VdX7yg0wlfH/c
        xMLNsTlvKoeIwJX4PH88ZO63tbZz1s8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-rtJL4E3GPsGMaKdeIFd08w-1; Wed, 05 May 2021 16:11:01 -0400
X-MC-Unique: rtJL4E3GPsGMaKdeIFd08w-1
Received: by mail-wr1-f69.google.com with SMTP id i102-20020adf90ef0000b029010dfcfc46c0so1160957wri.1
        for <linux-block@vger.kernel.org>; Wed, 05 May 2021 13:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GBjBuvXE2zdfbkNFPE3Y99JvsZ5ACCeZzTetq8hkZVc=;
        b=jIfCBP4K/iEnhcMa8gBtxih3ctHGcFTAgKampukwwBtrI3V0rhqYPB1ogcn7kIpR7D
         Z+VVV6uZbqUBVVzB1MXn9SeDwY1T0125uukjPh4xwEG69gxD40xr8AZUgNFkqWO8nJKi
         EtrC6wAml+ymsuE8T0WQ0n9jFcxWxDKtWns688P4saJ87qq0tv6uilpctuAwDz6tgY85
         EHcp1o+G9wbe5lRYBfXrJFzBw2tY1k+iMKWpHniVCdrpwRiyo1yfjRx84F69Lp4I5UnJ
         MMazG0ebfXmRxjoeYa7PrLDsfnt1nyPq1SEJZwqMHwu9MJHGbI15ya3PtjWLqVmzhlJV
         RI1w==
X-Gm-Message-State: AOAM532QY8Nihxn9YuykHzu9MorcHUSL1jaVgI1RU8Iy2r7R0Zwqc9n5
        Nj6C4pH+v775XNUzJ49mpgH7Lf0mick1zRy8ub5klu5YIJtULw77RkdT40s5sLZ9zsXvnZGmMA3
        izBbeD/P1ApT81DwkeuzqQzo=
X-Received: by 2002:adf:8b02:: with SMTP id n2mr791494wra.259.1620245459320;
        Wed, 05 May 2021 13:10:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDflhaV7bAW0iap9r6++Bu8H9qbZHW9/oqickGwKuCFU5RhENuf37swcdkBGO2bwY6uiQ9Mw==
X-Received: by 2002:adf:8b02:: with SMTP id n2mr791483wra.259.1620245459202;
        Wed, 05 May 2021 13:10:59 -0700 (PDT)
Received: from redhat.com ([2a10:800c:8fce:0:8e1b:40f0:6a74:513b])
        by smtp.gmail.com with ESMTPSA id p5sm372953wma.45.2021.05.05.13.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 13:10:58 -0700 (PDT)
Date:   Wed, 5 May 2021 16:10:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Enrico Granata <egranata@google.com>,
        virtio-dev@lists.oasis-open.org, linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] Provide detailed specification of virtio-blk lifetime
 metrics
Message-ID: <20210505161022-mutt-send-email-mst@kernel.org>
References: <20210420162556.217350-1-egranata@google.com>
 <20210505054314.GA4179527@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505054314.GA4179527@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 05, 2021 at 06:43:14AM +0100, Christoph Hellwig wrote:
> On Tue, Apr 20, 2021 at 04:25:56PM +0000, Enrico Granata wrote:
> > In the course of review, some concerns were surfaced about the
> > original virtio-blk lifetime proposal, as it depends on the eMMC
> > spec which is not open
> > 
> > Add a more detailed description of the meaning of the fields
> > added by that proposal to the virtio-blk specification, as to
> > make it feasible to understand and implement the new lifetime
> > metrics feature without needing to refer to JEDEC's specification
> > 
> > This patch does not change the meaning of those fields nor add
> > any new fields, but it is intended to provide an open and more
> > clear description of the meaning associated with those fields.
> > 
> > Signed-off-by: Enrico Granata <egranata@google.com>
> 
> Still not a fan of the encoding, but at least it is properly documented
> now:
> 
> Acked-by: Christoph Hellwig <hch@lst.de>

With that, would you like to ack the virtip-blk patch too?
The format didn't actually change ...

-- 
MST

