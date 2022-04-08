Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D14AC433EF
	for <linux-block@archiver.kernel.org>; Fri,  8 Apr 2022 15:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237735AbiDHPpM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Apr 2022 11:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237732AbiDHPpK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Apr 2022 11:45:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6414D8F98D
        for <linux-block@vger.kernel.org>; Fri,  8 Apr 2022 08:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649432582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uh9C/0cIrjIkPvPWnpHllBVIfwXhKDgyixfW2DYR0Ew=;
        b=KNPN9jVc5Uy4gbevGVXI2icBTz8dy7IZzs2R7i4LxB1yx2xc3SgRQGE+0ZA1kEWl7XJl8b
        9MvO3AVhMnOci/fOK1Yl58yr9URuzz9YaDWTj+GpTWYX9pM5zhM+PV4lrzNQxwqDAMv2mE
        i8BxibgR2RtmXcLAAv0RXqrrrU+gySg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-D0TwLVhyOmCwTyMBj4omQg-1; Fri, 08 Apr 2022 11:42:54 -0400
X-MC-Unique: D0TwLVhyOmCwTyMBj4omQg-1
Received: by mail-qt1-f198.google.com with SMTP id e5-20020ac85985000000b002e217abd72fso8018272qte.9
        for <linux-block@vger.kernel.org>; Fri, 08 Apr 2022 08:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uh9C/0cIrjIkPvPWnpHllBVIfwXhKDgyixfW2DYR0Ew=;
        b=fdUt44TkJZEV/m6von103EvZ4lVXbeatRKxMHCDibYYykpfi5X11XhUIJ26CjNkPom
         IJQNNHDS0Md0hgvLUahYG2x/SprrmcOX2T3fMKR/2DscA1MMilg2FJFQ6cZgncImh0JO
         +jyd3m/NlXT4gFndMlsU830pNDLCMpg5aeWvwNyXG+HNgNAurKqLg0MgmAZgnm/gic3r
         9Ma/kfhGxK9qZkZusgGRctEsCvir+5CoFaL3FKLnlujsp1C9mT524RmQyMTwGf+HguTB
         S2On2Z09FYULtH7BUcTj8JyVAkDMe7ZXHbbn9siAadRHVg6aiq7jteM5ycehAuF8g4oy
         ZwBg==
X-Gm-Message-State: AOAM533nrO6ftW5fEPbzvpVezC7hGPk48yfBuFQOfiX5vDG93S2VmhHq
        QkXtfn9IqrjiPrhBwi/1efAAXsUkNiDMFkJSG8yU89Tgmr1PQ4r6x0W/zPsU98roX+lzWaq5JHK
        tGTVkZxql5cKuo/Jo+Sisaw==
X-Received: by 2002:ac8:5b86:0:b0:2e2:72c:9e06 with SMTP id a6-20020ac85b86000000b002e2072c9e06mr16437924qta.113.1649432573616;
        Fri, 08 Apr 2022 08:42:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUfLlWE2Smd+oFO5ffih62dgSw8HBW5GxPWKP/2qDKZQAiBqeEt3sbfXtDD+mcuNQwhgeoNw==
X-Received: by 2002:ac8:5b86:0:b0:2e2:72c:9e06 with SMTP id a6-20020ac85b86000000b002e2072c9e06mr16437906qta.113.1649432573399;
        Fri, 08 Apr 2022 08:42:53 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id a21-20020a376615000000b0069a110a481dsm2597335qkc.41.2022.04.08.08.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 08:42:52 -0700 (PDT)
Date:   Fri, 8 Apr 2022 11:42:51 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dennis Zhou <dennis@kernel.org>, Mike Snitzer <snitzer@kernel.org>,
        tj@kernel.org, axboe@kernel.dk, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: Re: can we reduce bio_set_dev overhead due to bio_associate_blkg?
Message-ID: <YlBX+ytxxeSj2neQ@redhat.com>
References: <YkSK6mU1fja2OykG@redhat.com>
 <YkRM7Iyp8m6A1BCl@fedora>
 <YkUwmyrIqnRGIOHm@infradead.org>
 <YkVBjUy9GeSMbh5Q@fedora>
 <YkVxLN9p0t6DI5ie@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkVxLN9p0t6DI5ie@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 31 2022 at  5:15P -0400,
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Mar 30, 2022 at 10:52:13PM -0700, Dennis Zhou wrote:
> > I took a quick look. It seems with the new interface,
> > bio_clone_blkg_association() is unnecessary given the correct
> > association should be derived from the bio_alloc*() calls with the
> > passed in bdev. Also, blkcg_bio_issue_init() in clone seems wrong.
> 
> Yes, I think you are right.
> 
> > Maybe the right thing to do here for md-linear and btrfs (what I've
> > looked at) is to delay cloning until the map occurs and the right device
> > is already in hand?
> 
> That would in general be the preferred option where possible.

Delaying cloning until remap is a problem for DM given the target_type
->map interface for all DM targets assumes the passed bio is already a
clone that needs to be remapped accordingly.

I think we can achieve the goal of efficient cloning/remapping for
both usecases simply by splitting out the bio_set_dev() and leaving it
to the caller to pick which interface to use (e.g. clone vs
clone_and_remap).

Christoph is this something you're open to doing as continuation of
your bio alloc/clone related audit/changes?  Or would you prefer
someone else deal with it?  I could take a closer look next week if
needed.

Mike

