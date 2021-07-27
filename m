Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1269FC4338F
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 16:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAA1161B93
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 16:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbhG0QSW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 12:18:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43844 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229441AbhG0QSW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 12:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627402701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cM9tfLQOTWB4GCopgnP+9Qx/IyO9Pq6B7ebTSKwOWBY=;
        b=i9oO9hrR3oxlopJ44WEB7o+y7AwaGrw3WNVg0MbpRmH9RgGeqmiujdEVpyRNnh07kh5s0Q
        rqLQhrPEOtG3NGAVqLTqX0OnhBb4YbGErf3OrRupo6eJYOX8y1YeqwvFKCyY8m42aG49JG
        t/fnGdWzfCMqoLqwT0a120MTV2FKsKE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-oUDOmTZ6NXeaTL2w9Br4pA-1; Tue, 27 Jul 2021 12:18:20 -0400
X-MC-Unique: oUDOmTZ6NXeaTL2w9Br4pA-1
Received: by mail-qt1-f199.google.com with SMTP id g10-20020ac8768a0000b029023c90fba3dcso6621885qtr.7
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 09:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cM9tfLQOTWB4GCopgnP+9Qx/IyO9Pq6B7ebTSKwOWBY=;
        b=kS9f/OpaxhjopUB0mj2yNbjGmJ9VMF1LOZK4eUK163m/+nChJAFIkwvzMwjvk27rps
         lj/aA6eVMqMIx1DFZGyzsHoydQst+v07HvDJKh6QA19k3eY/q8g24PJzJGNan4pwqqwg
         SDleMfFsHNpL8UjmhQ4IeFp1zJkVglc286EWwsHA3S2v/e+Kqhzugb2N7sZqueTH7GMG
         SlQU4wAPBvdkQYnlfP5OdfrJ4cRx9ncKdGAOSustWxvIkLxPC+6N+EBYTAt7pMJ7EnSq
         QagSJTOO8dQ5/KFX8zHBD0MxRYOKsLiItQWMEpTjpmbYwZfCa+Q2t0xIelDdlNt8ualE
         Dn2w==
X-Gm-Message-State: AOAM532TRpcoQ9etsrlynRvEbg3sW9qj6S5Y/jNug7SL4Os6GlmcNQRK
        Hn17G9W1U1JScUCkDnN9zcwAXAcRfADwHu8mLn2p2xlhzOdr77ifpk2KWxbYqEboHXMJUTyWcXH
        VQNFv+HHL9q3EWLLRzsis4Q==
X-Received: by 2002:ac8:65da:: with SMTP id t26mr20558902qto.145.1627402700226;
        Tue, 27 Jul 2021 09:18:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcE/DRxSGmin8HOdxgpUGEuj7cvwjyi0toYmkFRns5e91de0cpGjH7LdY+CMdfWbVROh+tUA==
X-Received: by 2002:ac8:65da:: with SMTP id t26mr20558889qto.145.1627402700053;
        Tue, 27 Jul 2021 09:18:20 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id s19sm1609729qtx.5.2021.07.27.09.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 09:18:19 -0700 (PDT)
Date:   Tue, 27 Jul 2021 12:18:18 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: use regular gendisk registration in device mapper
Message-ID: <YQAxyjrGJpl7UkNG@redhat.com>
References: <20210725055458.29008-1-hch@lst.de>
 <YQAtNkd8T1w/cSLc@redhat.com>
 <20210727160226.GA17989@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727160226.GA17989@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 27 2021 at 12:02P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> On Tue, Jul 27, 2021 at 11:58:46AM -0400, Mike Snitzer wrote:
> > > This did not make a different to my testing
> > > using dmsetup and the lvm2 tools.
> > 
> > I'll try these changes running through the lvm2 testsuite.
> 
> Btw, is ther documentation on how to run it somewhere?  I noticed
> tests, old-tests and unit-tests directories, but no obvious way
> to run them.

I haven't tracked how it has changed in a while, but I always run:
make check_local

(but to do that you first need to ./configure how your distro does
it... so that all targets are enabled, etc. Then: make).

Will revisit this shortly and let you know if my process needed to
change at all due to lvm2 changes.

