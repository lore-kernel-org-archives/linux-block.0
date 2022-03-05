Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63608C433F5
	for <linux-block@archiver.kernel.org>; Sat,  5 Mar 2022 02:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiCECPO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Mar 2022 21:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiCECPN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Mar 2022 21:15:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D32DA1DC9AC
        for <linux-block@vger.kernel.org>; Fri,  4 Mar 2022 18:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646446464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mQ3j752MT2c0Va4+BHXixIvzPf7SXNYhTYkAyxToXME=;
        b=fcuNgEXsoc5IQDVoekh0/ln2Jte5HveDlgtizYQt/vwDrr4UM3iM4CudoZe04lfeCvYCLS
        uzI6cXxzUHgXEfgh1GKZGOXIL2wYrAORrqVz3m6XhH6B398yU1wKDixTpTsXbAgKe0Yi/v
        TmXUIZ882j9U/ImLdY3H+DPhowAZooU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-XUjGTAA6NVG8xRSo4qHE2A-1; Fri, 04 Mar 2022 21:14:23 -0500
X-MC-Unique: XUjGTAA6NVG8xRSo4qHE2A-1
Received: by mail-qt1-f199.google.com with SMTP id b3-20020ac84f03000000b002e038c19f71so7647882qte.2
        for <linux-block@vger.kernel.org>; Fri, 04 Mar 2022 18:14:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mQ3j752MT2c0Va4+BHXixIvzPf7SXNYhTYkAyxToXME=;
        b=iP2ChZIdlgGuRkjgjUM4Yv/a0qwt2MDP7nZW9od8uK6+fcNVpNa+U9tJCmU30At4XA
         EDzg7xwQub8N8M9xYw9vyoY2qzuiSdFGgjZaAccYJykpNDdJ9wA5qLgHHwRuX1E/6uV4
         VmYushVvwkJZF1JrmKuo73UGwGJol4WL2fq1GrcVWQoeKkbG/xcKG9WmxDsJmqNkskfx
         CMR0GOHOgBsHLVR0YAXXI15Bc2ChU0EA/Ro09kmkK4+ZOgpMy/KKYLrWFLWvgEvjwkvo
         eql6MK1bpNlQ4ZBFvXkP1wUsNB1iUMAwqec7Z4TU+V9gihrTRhjOGUGSOY/DvEfTlaTB
         P6VA==
X-Gm-Message-State: AOAM531it9sktrVkqM2UfvrghHtwaAjMhQ6iZFz5hT7JC3I7F1XArsv8
        K/j9wLk0B9uvRO9H4Ae3RNBnXUH1CuJs7jicYKp7KSW9GiEY+gaCuE1FIcvHfTgteDavIa01MOb
        fTzx6jjjYG93s9svEgVFwuw==
X-Received: by 2002:ad4:5f0e:0:b0:432:e889:810c with SMTP id fo14-20020ad45f0e000000b00432e889810cmr1361639qvb.37.1646446462506;
        Fri, 04 Mar 2022 18:14:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxMC+u1zy14ii7oCjULtwAClNOzsgkoDddDB0O4sbnNOAbYlXBNmZaVvJ/Fj9elFqDGl9rI5Q==
X-Received: by 2002:ad4:5f0e:0:b0:432:e889:810c with SMTP id fo14-20020ad45f0e000000b00432e889810cmr1361628qvb.37.1646446462303;
        Fri, 04 Mar 2022 18:14:22 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id a19-20020ac85b93000000b002e0023473edsm4515100qta.95.2022.03.04.18.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 18:14:21 -0800 (PST)
Date:   Fri, 4 Mar 2022 21:14:21 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v4 0/2] block/dm: support bio polling
Message-ID: <YiLHfRYPDryUAO2D@redhat.com>
References: <20220304212623.34016-1-snitzer@redhat.com>
 <YiLAJIOZz9UHbUKq@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiLAJIOZz9UHbUKq@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 04 2022 at  8:43P -0500,
Ming Lei <ming.lei@redhat.com> wrote:

> On Fri, Mar 04, 2022 at 04:26:21PM -0500, Mike Snitzer wrote:
> > Hi,
> > 
> > I've rebased Ming's latest [1] ontop of dm-5.18 [2] (which is based on
> > for-5.18/block). End result available in dm-5.18-biopoll branch [3]
> > 
> > These changes add bio polling support to DM.  Tested with linear and
> > striped DM targets.
> > 
> > IOPS improvement was ~5% on my baremetal system with a single Intel
> > Optane NVMe device (555K hipri=1 vs 525K hipri=0).
> > 
> > Ming has seen better improvement while testing within a VM:
> >  dm-linear: hipri=1 vs hipri=0 15~20% iops improvement
> >  dm-stripe: hipri=1 vs hipri=0 ~30% iops improvement
> > 
> > I'd like to merge these changes via the DM tree when the 5.18 merge
> > window opens.  The first block patch that adds ->poll_bio to
> > block_device_operations will need review so that I can take it
> > through the DM tree.  Reason for going through the DM tree is there
> > have been some fairly extensive changes queued in dm-5.18 that build
> > on for-5.18/block.  So I think it easiest to just add the block
> > depenency via DM tree since DM is first consumer of ->poll_bio
> > 
> > FYI, Ming does have another DM patch [4] that looks to avoid using
> > hlist but I only just saw it.  bio_split() _is_ involved (see
> > dm_split_and_process_bio) so I'm not exactly sure where he is going
> > with that change. 
> 
> io_uring(polling) workloads often cares latency, so big IO request
> isn't involved usually, I guess. Then bio_split() is seldom called in
> dm_split_and_process_bio(), such as if 4k random IO is run on dm-linear
> or dm-stripe via io_uring, bio_split() won't be run into.
> 
> Single list is enough here, and efficient than hlist, just need
> a little care to delete element from the list since linux kernel doesn't
> have generic single list implementation.

OK, makes sense, thanks for clarifying. But yeah its a bit fiddley for sure.

> > But that is DM-implementation detail that we'll
> > sort out.
> 
> Yeah, that patch also needs more test.

Yeap, sounds good.

