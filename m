Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA133C4338F
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 22:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A520960F9B
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 22:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhG0Ww7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 18:52:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36094 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231730AbhG0Ww6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 18:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627426377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7stv5u1stx7EtQfdU5hPoXwvmtwChIwUztGz5KP4CR0=;
        b=Np1Wj03MofUKzPtR+J4NPmt4QrohSovDkRxMIGYYd/zNr1VMpvAAKn6/cTuafRmRfQ/kjg
        FCNsTX3PpZG19pO1geiSCRmU7TkO3h+QkCBVNYyiDQPqfWvTKH9TYmi8kTLyBYskmI244+
        nhMFwMQocV7nnaIy/medmY5nwvkRNpw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-KnvixSVVMU6ebB_E9xv3WA-1; Tue, 27 Jul 2021 18:52:56 -0400
X-MC-Unique: KnvixSVVMU6ebB_E9xv3WA-1
Received: by mail-qk1-f198.google.com with SMTP id s186-20020a3790c30000b02903b9ade0af31so434869qkd.1
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 15:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7stv5u1stx7EtQfdU5hPoXwvmtwChIwUztGz5KP4CR0=;
        b=hN6wbOP7WTOK4TSlX/fYECPAU7tboGipG4KE3CfHk/SAuZDsu+qlXCLRz0aiBv1tlG
         8U1MLz08FDLXcTS6mzwywwWUuHqcz7CnJhzaav6KfLaLZempsVuZW3RTxnhHU25CkCUh
         9UhAxQrs+NpNmYUWN0iN/tjeIMsQDotenwIfe4pFesbhsNGkZP47XAX8ym40R0ALePL0
         DKOs7axfceHqCWfBwr3cne/11+8Y8Lb0PHWGdzgRWiSAGa0DuADxOWqXiTSpwbBTnOeR
         WD4yxMAOLY/vtF7BvYUKNSEVIxVHh9pwiRImLylv6jOsF8WoSZpnfjV+MfP8QA3LbmL2
         +FTg==
X-Gm-Message-State: AOAM530gM0qWhNlLJ/uLi1dCOZmryj6FzKV6YnCV/bgZHF1wMOn3GIhK
        cMwUxpxHOIEo3bz6uaTC7tsPUHpoFkRMQWeu1f2z4mjCT5xen3JRXWWM0VNH3tWQfDvykDpPeiJ
        ++h/TiclwOsFvNG8LWrO8Eg==
X-Received: by 2002:ac8:5508:: with SMTP id j8mr21740853qtq.56.1627426375959;
        Tue, 27 Jul 2021 15:52:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzk+mrtnxazRJZvhMSqIaKNemzV0sRD5t5okETA1xc/6rn87do3W+YESqL8IACFSOGwAZ82Ag==
X-Received: by 2002:ac8:5508:: with SMTP id j8mr21740847qtq.56.1627426375766;
        Tue, 27 Jul 2021 15:52:55 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id f12sm2438087qke.37.2021.07.27.15.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 15:52:55 -0700 (PDT)
Date:   Tue, 27 Jul 2021 18:52:54 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: use regular gendisk registration in device mapper
Message-ID: <YQCORvuQJ2AGR2Ks@redhat.com>
References: <20210725055458.29008-1-hch@lst.de>
 <YQAtNkd8T1w/cSLc@redhat.com>
 <20210727160226.GA17989@lst.de>
 <YQAxyjrGJpl7UkNG@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQAxyjrGJpl7UkNG@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 27 2021 at 12:18P -0400,
Mike Snitzer <snitzer@redhat.com> wrote:

> On Tue, Jul 27 2021 at 12:02P -0400,
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > On Tue, Jul 27, 2021 at 11:58:46AM -0400, Mike Snitzer wrote:
> > > > This did not make a different to my testing
> > > > using dmsetup and the lvm2 tools.
> > > 
> > > I'll try these changes running through the lvm2 testsuite.
> > 
> > Btw, is ther documentation on how to run it somewhere?  I noticed
> > tests, old-tests and unit-tests directories, but no obvious way
> > to run them.
> 
> I haven't tracked how it has changed in a while, but I always run:
> make check_local
> 
> (but to do that you first need to ./configure how your distro does
> it... so that all targets are enabled, etc. Then: make).
> 
> Will revisit this shortly and let you know if my process needed to
> change at all due to lvm2 changes.

Yeap, same process as I described above.

Same 6 tests fail in the lvm2 testsuite with or without your changes,
so nothing to do with your changes.

I'll review your patches closer tomorrow (first pass it all looked
pretty good).

Mike

