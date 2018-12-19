Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E5FC43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 11:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BA220815
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 11:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgV94P3v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbeLSLcn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:32:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38724 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbeLSLcn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Dec 2018 06:32:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so19136224wrw.5;
        Wed, 19 Dec 2018 03:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5cNZS7evFTFSuXmMPyBEfnlXRcsOfk928yjxP33/FaA=;
        b=KgV94P3v1mmWrphbDKxeSPaJ26/B4cCwvhrdc3MQVvKSD2T22m/0Izwn0KvVoxUeSv
         qFPqHOGPghQqHIW5XVsbvZZyj4wN/xoh8KkpSe5TDsupTzDHso79qOmPzoHdBQ5dc9iK
         Cdu5Zofe1iaVElLw1p1NsvzlHTvcBd9UejAVmCZmxsexch12iO2aqWeaMsALPA7nH9uD
         8Q4SPvzf8KJ8O9uUnTlONSn4ZcQ7A82QvakfsdYWKDfkrkZyZ6LXtU6iX9KgDRxaef8q
         SHa4bkHJuIsR46JZLQxwkSzAt3SUMzTwotrgAMl8+uyDjf5VaX7OP15s09AQ3XM0/gyL
         Z/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5cNZS7evFTFSuXmMPyBEfnlXRcsOfk928yjxP33/FaA=;
        b=Z1S27VrkQBNcvnJA2Fj6VFMWJLa8RseUQMusCFOp3w/fvYUxCjOLZ7D0zO01ToFCxi
         MGNp2WqNO7tzhj+DZsVLBNdIOPc2Z6ipeCUSlD89sjZpYzQtINg9uVQYTMQLRhsqF+Wd
         ZpAbhiH5wmXWtFvDWEI5j0oPgZ6MeBODLydXJTBUVi33C/wD4WThpNN8+Lg0x9y4FiXZ
         BgYK5YqIS6H03UaMv7SRSyJfVdJFbsvsQdWIUKZ1JYKDRb7w7NoTlK8xEeXbSxOvfnZ9
         HENlPXh8U46kgZs+Lm2EUREGTupB64v4C3pJnJ21BPZoixc8KWo9oT5LpQrTh3UCnJ/w
         kKAQ==
X-Gm-Message-State: AA+aEWbe24hW0g25rJJVJZP/9QyAurTweYiGrohLeYMk+Hz7V4Oivoax
        zbMnRouQWMi/cIQW2IbrnQ==
X-Google-Smtp-Source: AFSGD/Vl7M8DXkE/BAnu4j7Lsslhfe6P6EbeNoPHtVxSjMnZEj+yDghmCfzXnIXpiY3Tq9iMkNJTrg==
X-Received: by 2002:adf:db51:: with SMTP id f17mr17194787wrj.90.1545219161308;
        Wed, 19 Dec 2018 03:32:41 -0800 (PST)
Received: from kmo-pixel ([93.240.4.121])
        by smtp.gmail.com with ESMTPSA id b129sm3128976wmd.24.2018.12.19.03.32.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 03:32:40 -0800 (PST)
Date:   Wed, 19 Dec 2018 06:32:38 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Junhui Tang <tang.junhui.linux@gmail.com>
Cc:     colyli@suse.de, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] bcache: treat stale && dirty keys as bad keys
Message-ID: <20181219113238.GA13550@kmo-pixel>
References: <CA+NNRhE8438XuoZ25kdCRjYvZv6nHJU+Yoyg6hacWuptjWWDfA@mail.gmail.com>
 <20181218140157.GB7144@kmo-pixel>
 <CA+NNRhFgAqHSxYP2TqDx_bLNGYOEe8paHU9dz7Nos=dhMDK9gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+NNRhFgAqHSxYP2TqDx_bLNGYOEe8paHU9dz7Nos=dhMDK9gQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 19, 2018 at 09:32:55AM +0800, Junhui Tang wrote:
> hello Kent
> 
> Long long no see, glad to hear you again.
> 
> >> Then two steps:
> >> A) update k1 to k2 in btree node memory;
> >>    bch_btree_insert_keys(b, op, insert_keys, replace_key)
> >> B) Write the bset(contains k2) to cache disk by a 30s delay work
> >>    bch_btree_leaf_dirty(b, journal_ref).
> >> But before the 30s delay work write the bset to cache device,
> >> these things happend:
> >> A) GC works, and reclaim the bucket k2 point to;
> >> B) Allocator works, and invalidate the bucket k2 point to,
> >>    and increase the gen of the bucket, and place it into free_inc
> >>    fifo;
> >> C) Until now, the 30s delay work still does not finish work,
> >>    so in the disk, the key still is k1, it is dirty and stale
> >>    (its gen is smaller than the gen of the bucket). and then the
> >>    machine power off suddenly happens;
> >> D) When the machine power on again, after the btree reconstruction,
> >>    the stale dirty key appear.
> 
> > Only prior to journal replay, right? Or did you uncover something more severe?
> No, it's after the journal replay, and in write_dirty_finish(), when
> replace a dirty key with a clean key by calling bch_btree_insert(),
> no journal will write.

Holy crap you're right, this was from before I moved journalling to be driven by
the btree update path.

I think a better fix here would be to journal the btree updates writeback does,
but given that we haven't been journalling those updates all this time your fix
does make sense too.

> 
> >> In bch_extent_bad(), when expensive_debug_checks is off, it would
> >> treat the dirty key as good even it is stale keys, and it would
> >> cause bellow probelms:
> >> A) In read_dirty() it would cause machine crash:
> >>    BUG_ON(ptr_stale(dc->disk.c, &w->key, 0));
> >> B) It could be worse when reads hits stale dirty keys, it would
> >>    read old incorrect data.
> 
> >Neither of these can happen until after journal replay is finished. Prior to
> >journal replay we expect to find stale dirty keys - if we find any after journal
> >replay then it's indicative of a real bug.
> As I said previous, since no journal writes after inserting a replace key in
> writeback, so this issue has nothing to do with journal.
> 
> This is a real problem in my environment, after running IO sometimes, I turn off
> the power suddenly,  then turn on the power, and the machine crash in
> read_dirty() due to the stale && dirty keys.
