Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6380AC7EE23
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 23:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjEWXGa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 19:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjEWXG2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 19:06:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7EADA
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 16:06:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB4B962C06
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 23:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AFF2C433EF;
        Tue, 23 May 2023 23:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684883186;
        bh=otmhU4S7ou6bVyDNcFDaXH738DN936HzMUHXJdG94uc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m44I/8M+Ad301U/L0OHP4zX7kSnmZ940d5ILQll9JprZ2EszjlSCMJ2MxooVhE8hE
         5PXcZm33znjcKmZmh+R5wlghntJ0qzL42IsBLbmp25ichbTTwMhOeEAOFTwXoKn/Gi
         GeBvp0N5SiKPAaVi4OyR4Pd4T1VswmqsbfwLKEd6sT8NwpWGCdjl5FLn9uetUKOn0m
         Gfe0kTqPGL3GhMlksy3gf/PEO+BKhGCskxW7LzcHpvLbaIrn2HVG1IzbHo3ggr+9DS
         27qpvedSsG6bjDhDumqH9BtOVTEGIXRJmBgxCTLXdvo6AVZ5YsliuG5Z0bxkUrEa5/
         5uhYhbbPUqgeA==
Date:   Tue, 23 May 2023 23:06:24 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     corwin <corwin@redhat.com>
Cc:     linux-block@vger.kernel.org, vdo-devel@redhat.com,
        dm-devel@redhat.com
Subject: Re: [dm-devel] [PATCH v2 02/39] Add the MurmurHash3 fast hashing
 algorithm.
Message-ID: <20230523230624.GF888341@google.com>
References: <20230523214539.226387-1-corwin@redhat.com>
 <20230523214539.226387-3-corwin@redhat.com>
 <20230523220618.GA888341@google.com>
 <0d3d1835-d945-9fa2-f3b7-6a60aae3d1df@redhat.com>
 <20230523222501.GD888341@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523222501.GD888341@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 23, 2023 at 10:25:01PM +0000, Eric Biggers wrote:
> On Tue, May 23, 2023 at 06:13:08PM -0400, corwin wrote:
> > On 5/23/23 6:06 PM, Eric Biggers wrote:
> > > On Tue, May 23, 2023 at 05:45:02PM -0400, J. corwin Coburn wrote:
> > > > MurmurHash3 is a fast, non-cryptographic, 128-bit hash. It was originally
> > > > written by Austin Appleby and placed in the public domain. This version has
> > > > been modified to produce the same result on both big endian and little
> > > > endian processors, making it suitable for use in portable persistent data.
> > > > 
> > > > Signed-off-by: J. corwin Coburn <corwin@redhat.com>
> > > > ---
> > > >   drivers/md/dm-vdo/murmurhash3.c | 175 ++++++++++++++++++++++++++++++++
> > > >   drivers/md/dm-vdo/murmurhash3.h |  15 +++
> > > >   2 files changed, 190 insertions(+)
> > > >   create mode 100644 drivers/md/dm-vdo/murmurhash3.c
> > > >   create mode 100644 drivers/md/dm-vdo/murmurhash3.h
> > > 
> > > Do we really need yet another hash algorithm?
> > > 
> > > xxHash is another very fast non-cryptographic hash algorithm that is already
> > > available in the kernel (lib/xxhash.c).
> > > 
> > > - Eric
> > 
> > The main reason why vdo uses Murmur3 and not xxHash is that vdo has been in
> > deployment since 2013, and, if I am reading correctly, xxHash did not have a
> > 128 bit variant until 2019.
> 
> Why do you need a 128-bit non-cryptographic hash algorithm?  What problem are
> you trying to solve?

To elaborate a bit: the reason this seems strange to me is that when people say
they need a 128-bit (or larger) non-cryptographic hash function, usually they
are either mistaken and 64-bit would suffice, or they actually need a
cryptographic hash function.

In this case, the hash function seems to be used for data deduplication.  This
is unusual, since data deduplication normally requires a cryptographic hash
algorithm.

I see that this is touched on by the following paragraph in vdo-design.rst
(though it incorrectly calls the hash an "identifier for the block"):

    Each block of data is hashed to produce a 16-byte block name which serves as
    an identifier for the block. An index record consists of this block name
    paired with the presumed location of that data on the underlying storage.
    However, it is not possible to guarantee that the index is accurate. Most
    often, this occurs because it is too costly to update the index when a block
    is over-written or discarded. Doing so would require either storing the
    block name along with the blocks, which is difficult to do efficiently in
    block-based storage, or reading and rehashing each block before overwriting
    it. Inaccuracy can also result from a hash collision where two different
    blocks have the same name. In practice, this is extremely unlikely, but
    because vdo does not use a cryptographic hash, a malicious workload can be
    constructed. Because of these inaccuracies, vdo treats the locations in the
    index as hints, and reads each indicated block to verify that it is indeed a
    duplicate before sharing the existing block with a new one.

So, dm-vdo handles hash collisions by reading back and verifying that the data
matches before allowing deduplication.

That solves the security problem.  However, it does seem strange, and it's more
complex than the usual solution of just using a cryptographic hash.  Note that
cryptographic hashing is very fast on modern CPUs with modern algorithms.

So, some more details about the rationale for designing the data deduplication
in this (IMO unusual) way should be included.

- Eric
