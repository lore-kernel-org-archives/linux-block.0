Return-Path: <SRS0=zsIv=D4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97AAC5517A
	for <linux-block@archiver.kernel.org>; Wed, 21 Oct 2020 05:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5000E22242
	for <linux-block@archiver.kernel.org>; Wed, 21 Oct 2020 05:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RWYA4HDj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407793AbgJUF2B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Oct 2020 01:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407778AbgJUF2B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Oct 2020 01:28:01 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540F1C0613CE
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2020 22:28:01 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t22so612529plr.9
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2020 22:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7GB5y84r6xMSGeFUmcejHOzMFE3WByKQWJdu7wCKtTc=;
        b=RWYA4HDjyZRR/gOIdhaMUvs6IOrXEQ7pFlvkdy5B1AY+pEfSru5e/kxQXIs2jIARnG
         fW7TnyQVYuoWoErldkcgG3slDRoi4tq7RkYTAZtJ1NQuUdnK0RflcDnO6jU1c2F8ExIJ
         CCp8bLDyIoiI1qyt3/HuIlCI0G1l6Tf2iu9aUj2jVfRCez2hf2t6aIClifyB54An/nC/
         jCAykXyhzTQDSaa87W07nHg5+d6v5TTjRSC+84Dst1jFWKubk0dXOvh54JZYzILHIK+L
         uHY6LnpAr0a9id+prj0iNIKObARtsh8b1QV+J3pK+oVMu5oprB1f0rk4AxgcxEVju2i5
         8mfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7GB5y84r6xMSGeFUmcejHOzMFE3WByKQWJdu7wCKtTc=;
        b=pUOQS1A46dN1/XKU0bZ4VK1AM00vg4fIk6RMj6G1emoo6PCYrgrBl8DhHl4cWTGiZr
         6RT7lX2WedahRHxEI4vTFTVERA5YUwC+9J+5Jifr+FlyHVqlpNbhRPI4uKxKeawr9T3J
         lvsQugY3CNEdorO2jbmCyqvtU1fQZLvgx26AQlx7AfVE8kFZcUI49G5sonYVSTm04KmH
         HMUXjtAWEiZVMsluadPSqFNeBd2yhfD2mlAnSO51MOKtekwvTILh73z63mWcj1eQUmWb
         OnN0PKGErCp+Ck4qO7ttvlpuGf2r97KuUP/jTZ8xi7M8oVAfDah5u8GifQ4V8jJZsebh
         ijXA==
X-Gm-Message-State: AOAM5302mcv7Kj1SUMWOfgXjbWruuIl7wTcU4S4T1lSQcS7ft8toJ5oG
        dBY9VNLhm8gjQ3jv+Xx4dx88+A==
X-Google-Smtp-Source: ABdhPJz/C1gaOL5hjy8zFTXccY3UyWJy8F9I2GVGOtdTnA9WyL1I4Sz6zoWRWPflnNBRW2alRjjx8A==
X-Received: by 2002:a17:902:c697:b029:d3:df24:163e with SMTP id r23-20020a170902c697b02900d3df24163emr1837466plx.18.1603258080533;
        Tue, 20 Oct 2020 22:28:00 -0700 (PDT)
Received: from google.com (154.137.233.35.bc.googleusercontent.com. [35.233.137.154])
        by smtp.gmail.com with ESMTPSA id 194sm713228pfz.182.2020.10.20.22.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 22:27:59 -0700 (PDT)
Date:   Wed, 21 Oct 2020 05:27:55 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@redhat.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v2 1/4] block: keyslot-manager: Introduce passthrough
 keyslot manager
Message-ID: <20201021052755.GA1165871@google.com>
References: <20201015214632.41951-1-satyat@google.com>
 <20201015214632.41951-2-satyat@google.com>
 <20201016072044.GB14885@infradead.org>
 <20201021044423.GB3939@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021044423.GB3939@sol.localdomain>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 20, 2020 at 09:44:23PM -0700, Eric Biggers wrote:
> On Fri, Oct 16, 2020 at 08:20:44AM +0100, Christoph Hellwig wrote:
> > And this just validates my argument that calling the inline crypto work
> > directly from the block layer instead of just down below in blk-mq was
> > wrong.  We should not require any support from stacking drivers at the
> > keyslot manager level.
> 
> I'm not sure what you're referring to here; could you clarify?
> 
> It's true that device-mapper devices don't need the actual keyslot management.
> But they do need the ability to expose crypto capabilities as well as a key
> eviction function.  And those are currently handled by
> "struct blk_keyslot_manager".  Hence the need for a "passthrough keyslot
> manager" that does those other things but not the actual keyslot management.
> 
> FWIW, I suggested splitting these up, but you disagreed and said you wanted the
> crypto capabilities to remain part of the blk_keyslot_manager
> (https://lkml.kernel.org/linux-block/20200327170047.GA24682@infradead.org/).
> If you've now changed your mind, please be clear about it.
> 
I thought what Christoph meant (and of course, please let us know
if I'm misunderstanding you, Christoph) was that if blk-mq
handled all the blk-crypto stuff including deciding whether to
use the blk-crypto-fallback, and blk-mq was responsible for
calling out to blk-crypto-fallback if required, then the device
mapper wouldn't need to expose any capabilities at all... or at
least not for bio-based device mapper devices, since bios would
go through the device mapper and eventually hit blk-mq which
would then handle crypto appropriately.

We couldn't do that because the crypto ciphers for the
blk-crypto-fallback couldn't be allocated on the data path (so we
needed fscrypt to ask blk-crypto to check whether the underlying
device supported the crypto capabilities it required, and
allocate ciphers appropriately, before the data path required the
ciphers). I'm checking to see if anything has changed w.r.t
allocating crypto ciphers on the data path (and checking if
memalloc_noio_save/restore() helps with that).
> - Eric
