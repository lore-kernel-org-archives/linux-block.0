Return-Path: <SRS0=VsgY=DB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FB4C4346E
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 07:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4C5F2376F
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 07:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tnzOUnib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgIXHR1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Sep 2020 03:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgIXHR0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Sep 2020 03:17:26 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED54C0613D3
        for <linux-block@vger.kernel.org>; Thu, 24 Sep 2020 00:17:26 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id m15so1189156pls.8
        for <linux-block@vger.kernel.org>; Thu, 24 Sep 2020 00:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CFgKLZ7Chsmv5ba86marh1hlJNBQ4kPm3t3GCKLPml0=;
        b=tnzOUnibaVnZjz/w0brUvBmsEmOq/BGhQqgrZjaQ0SwTgQHhjOQV2zIsY8oXJ3Sgk6
         NSlYAUzZLabEJE7iFo8sov1kyce5oWbMnmYNSiAe4vbYtv9mYlsQQ4ZqsTM5aEBONFWp
         rnnHeagk+Zm0UBuzUW2dDmKaTKkEL8Iwltn+0i3z9Cs/9cHaBYgMBF9iE2qPI786WCrF
         RveXqYdIA0h3WnLTrcFZbgNWNjbBISbVlDkbozW3dh7oQRrH9EFhg1yCRcT2IzS3qgce
         gDIkHwgMur4TcZ7DU4NS45kHswIKrYiRU1rjqAND05NDiZlTbohex6UejvKBcV9kZAmI
         JuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CFgKLZ7Chsmv5ba86marh1hlJNBQ4kPm3t3GCKLPml0=;
        b=pCbm+oQdXQBYvSlIFjRMoOA3+pxsEBAOE2DQMjKrzszvVLyEohqYyuza5/JyRTOR+/
         D7lUGM2f07quC3dvNgDeMrqlQLcDIhkmOr2TfoMsJVUdVwqpgHytS3HWNIJhTdvSMFAG
         Almlyg7x2RIbqr5scdX3osCRHXQ6LB9bQW5/oaeDblJANs+5588RB/CIARef0JT9yLwC
         MZnIbi8BsP2ARc+biNfsEYnGnObqPYm1CQN1pEqG/aEy63LBEUPlFoJ0GNbh6F0QL3tl
         voqwRQbeyai03pFIWTsIPa3XiNXTCdvtK/eZulPuRuGaN7s3Rt5UOrqe4y2KDKTFRUyU
         bn+Q==
X-Gm-Message-State: AOAM5308nwvL9jr+TNC0FbNO+BqdN1Yj3Z28FS5unUs/sgMvWtq2XNWm
        QGNeBfwG9vcrfWQQBqmogm+yUw==
X-Google-Smtp-Source: ABdhPJxQiQR+5YMuZzB7wYPdkRNQV4iS231LLBb539HsxqXhmnu9M/EZBMrF5eFgYRnlpfZ3ffkakg==
X-Received: by 2002:a17:902:d68c:b029:d2:23a6:f6d7 with SMTP id v12-20020a170902d68cb02900d223a6f6d7mr3360335ply.45.1600931846100;
        Thu, 24 Sep 2020 00:17:26 -0700 (PDT)
Received: from google.com (124.190.199.35.bc.googleusercontent.com. [35.199.190.124])
        by smtp.gmail.com with ESMTPSA id q193sm1724860pfq.127.2020.09.24.00.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 00:17:25 -0700 (PDT)
Date:   Thu, 24 Sep 2020 07:17:21 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH 2/3] dm: add support for passing through inline crypto
 support
Message-ID: <20200924071721.GA1883346@google.com>
References: <20200909234422.76194-1-satyat@google.com>
 <20200909234422.76194-3-satyat@google.com>
 <20200922003255.GC32959@sol.localdomain>
 <20200924011438.GD10500@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924011438.GD10500@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 23, 2020 at 09:14:39PM -0400, Mike Snitzer wrote:
> On Mon, Sep 21 2020 at  8:32pm -0400,
> Eric Biggers <ebiggers@kernel.org> wrote:
> 
> > On Wed, Sep 09, 2020 at 11:44:21PM +0000, Satya Tangirala wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > Update the device-mapper core to support exposing the inline crypto
> > > support of the underlying device(s) through the device-mapper device.
> > > 
> > > This works by creating a "passthrough keyslot manager" for the dm
> > > device, which declares support for encryption settings which all
> > > underlying devices support.  When a supported setting is used, the bio
> > > cloning code handles cloning the crypto context to the bios for all the
> > > underlying devices.  When an unsupported setting is used, the blk-crypto
> > > fallback is used as usual.
> > > 
> > > Crypto support on each underlying device is ignored unless the
> > > corresponding dm target opts into exposing it.  This is needed because
> > > for inline crypto to semantically operate on the original bio, the data
> > > must not be transformed by the dm target.  Thus, targets like dm-linear
> > > can expose crypto support of the underlying device, but targets like
> > > dm-crypt can't.  (dm-crypt could use inline crypto itself, though.)
> > > 
> > > When a key is evicted from the dm device, it is evicted from all
> > > underlying devices.
> > > 
> > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > Co-developed-by: Satya Tangirala <satyat@google.com>
> > > Signed-off-by: Satya Tangirala <satyat@google.com>
> > 
> > Looks good as far as Satya's changes from my original patch are concerned.
> > 
> > Can the device-mapper maintainers take a look at this?
> 
> In general it looks like these changes were implemented very carefully
> and are reasonable if we _really_ want to enable passing through inline
> crypto.
> 
> I do have concerns about the inability to handle changes at runtime (due
> to a table reload that introduces new devices without the encryption
> settings the existing devices in the table are using).  But the fallback
> mechanism saves it from being a complete non-starter.
Unfortunately, the fallback doesn't completely handle that situation
right now. The DM device could be suspended while an upper layer like
fscrypt is doing something like "checking if encryption algorithm 'A'
is supported by the DM device". It's possible that fscrypt thinks
the DM device supports 'A' even though the DM device is suspended, and
the table is about to be reloaded to introduce a new device that doesn't
support 'A'. Before the DM device is resumed with the new table, fscrypt
might send a bio that uses encryption algorithm 'A' without initializing
the blk-crypto-fallback ciphers for 'A', because it believes that the DM
device supports 'A'. When the bio gets processed by the DM (or when
blk-crypto does its checks to decide whether to use the fallback on that
bio), the bio will fail because the fallback ciphers aren't initialized.

Off the top of my head, one thing we could do is to always allocate the
fallback ciphers when the device mapper is the target device for the bio
(by maybe adding a "encryption_capabilities_may_change_at_runtime" flag
to struct blk_keyslot_manager that the DM will set to true, and that
the block layer will check for and decide to appropriately allocate
the fallback ciphers), although this does waste memory on systems
where we know the DM device tables will never change....

This patch also doesn't handle the case when the encryption capabilities
of the new table are a superset of the old capabilities.  Currently, a
DM device's capabilities can only shrink after the device is initially
created. They can never "expand" to make use of capabilities that might
be added due to introduction of new devices via table reloads.  I might
be forgetting something I thought of before, but looking at it again
now, I don't immediately see anything wrong with expanding the
advertised capabilities on table reload....I'll look carefully into that
again.
> 
> Can you help me better understand the expected consumer of this code?
> If you have something _real_ please be explicit.  It makes justifying
> supporting niche code like this more tolerable.
So the motivation for this code was that Android currently uses a device
mapper target on top of a phone's disk for user data. On many phones,
that disk has inline encryption support, and it'd be great to be able to
make use of that. The DM device configuration isn't changed at runtime.
> 
> Thanks,
> Mike
> 
