Return-Path: <SRS0=VsgY=DB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FEBC4363D
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 16:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 206602395C
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 16:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600966654;
	bh=JNiJdDRQsrPnbeS7IK9+G/bFB5hGKoZITwaUtsAZbH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hnX68RePngPsmAdfGYjqJ72UX2TSb/D7Unbrzw78tjf/+pvQRSFHX1/OmeHQr7OXX
	 b80vHgGFDA8hYGHt6M4UJIEAwjX19xDH7FHZYQG23mmHbM/GuDzRPJWBohFVrUuJPD
	 Bejpmg/mgQ05VXuozR/fbpiJGlf36KUwP8RcNGoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgIXQ5d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Sep 2020 12:57:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgIXQ5d (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Sep 2020 12:57:33 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4537D2311A;
        Thu, 24 Sep 2020 16:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600966652;
        bh=JNiJdDRQsrPnbeS7IK9+G/bFB5hGKoZITwaUtsAZbH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lLJMRSPRXNQpBy6MpCRUPNVcZlvb7Ii/52Iwmk9hYjDZuKapjwutazBuwHQVH57rt
         aHFaZueFZ55NCbuBf3qvo0malxcF4sFiVNpuKbI7uUL3Rp/db5ImVMIu+VqZawx5Im
         V9WOuYfP4EUhH+SJqOq2EFhQa9ieD/XLtmsxbhaM=
Date:   Thu, 24 Sep 2020 09:57:30 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Satya Tangirala <satyat@google.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH 2/3] dm: add support for passing through inline crypto
 support
Message-ID: <20200924165730.GA2865480@gmail.com>
References: <20200909234422.76194-1-satyat@google.com>
 <20200909234422.76194-3-satyat@google.com>
 <20200922003255.GC32959@sol.localdomain>
 <20200924011438.GD10500@redhat.com>
 <20200924071721.GA1883346@google.com>
 <20200924134649.GB13849@redhat.com>
 <20200924154550.GA1266@sol.localdomain>
 <20200924161624.GC14369@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924161624.GC14369@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 24, 2020 at 12:16:24PM -0400, Mike Snitzer wrote:
> On Thu, Sep 24 2020 at 11:45am -0400,
> Eric Biggers <ebiggers@kernel.org> wrote:
> 
> > On Thu, Sep 24, 2020 at 09:46:49AM -0400, Mike Snitzer wrote:
> > > > > Can you help me better understand the expected consumer of this code?
> > > > > If you have something _real_ please be explicit.  It makes justifying
> > > > > supporting niche code like this more tolerable.
> > > >
> > > > So the motivation for this code was that Android currently uses a device
> > > > mapper target on top of a phone's disk for user data. On many phones,
> > > > that disk has inline encryption support, and it'd be great to be able to
> > > > make use of that. The DM device configuration isn't changed at runtime.
> > > 
> > > OK, which device mapper target is used?
> > 
> > There are several device-mapper targets that Android can require for the
> > "userdata" partition -- potentially in a stack of more than one:
> > 
> > dm-linear: required for Dynamic System Updates
> > (https://developer.android.com/topic/dsu)
> > 
> > dm-bow: required for User Data Checkpoints on ext4
> > (https://source.android.com/devices/tech/ota/user-data-checkpoint)
> > (https://patchwork.kernel.org/patch/10838743/)
> > 
> > dm-default-key: required for metadata encryption
> > (https://source.android.com/security/encryption/metadata)
> 
> Please work with all google stakeholders to post the latest code for the
> dm-bow and dm-default-key targets and I'll work through them.
> 
> I think the more code we have to inform DM core's implementation the
> better off we'll be in the long run.  Could also help improve these
> targets as a side-effect of additional review.
> 
> I know I largely ignored dm-bow before but that was more to do with
> competing tasks, etc.  I'll try my best...

I'm not sure what happened with dm-bow; I'll check with the person maintaining
it.

We expect that dm-default-key would be controversial, since it's sort of a
layering violation; metadata encryption really should be a filesystem-level
thing.  Satya has been investigating implementing it in filesystems instead.
I think we need to see how that turns out first.

> > We're already carrying this patchset in the Android common kernels since late
> > last year, as it's required for inline encryption to work when any of the above
> > is used.  So this is something that is needed and is already being used.
> > 
> > Now, you don't have to "count" dm-bow and dm-default-key since they aren't
> > upstream; that leaves dm-linear.  But hopefully the others at least show that
> > architecturally, dm-linear is just the initial use case, and this patchset also
> > makes it easy to pass through inline crypto on any other target that can support
> > it (basically, anything that doesn't change the data itself as it goes through).
> 
> Sure, that context really helps.
> 
> About "basically, anything that doesn't change the data itself as it
> goes through": could you be a bit more precise?  Very few DM targets
> actually change the data as associated bios are remapped.
> 
> I'm just wondering if your definition of "doesn't change the data"
> includes things more subtle than the data itself?

The semantics expected by upper layers (e.g. filesystems) are that a "write" bio
that has an encryption context is equivalent to a "write" bio with no encryption
context that contains the data already encrypted.  Similarly, a "read" bio with
an encryption context is equivalent to submitting a "read" bio with no
encryption context, then decrypting the resulting data.

blk-crypto-fallback obviously works in that way.  However, when actual inline
encryption hardware is used, the encryption/decryption actually happens at the
lowest level in the stack.

To maintain the semantics in that case, the data can't be modified anywhere in
the stack.  For example, if the data also passes through a dm-crypt target that
encrypted/decrypted the data (again) in software, that would break things.

You're right that it's a bit more than that, though.  The targets also have to
behave the same way regardless of whether the data is already encrypted or not.
So if e.g. a target hashes the data, then it can't set
may_passthrough_inline_crypto, even if it doesn't change the data.  It can't
sometimes be hashing the plaintext data and sometimes the ciphertext data.
(And also, storing hashes of the plaintext on-disk would be insecure, as it
would leak information that encryption is meant to protect.)

- Eric
