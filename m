Return-Path: <SRS0=iV0P=SO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC92BC10F0E
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 07:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FA4218FC
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 07:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="SmR0KV6T";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="t4bQlPkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfDLHPC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Apr 2019 03:15:02 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:54292 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726061AbfDLHPC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Apr 2019 03:15:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1F80B8EE0ED;
        Fri, 12 Apr 2019 00:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1555053301;
        bh=2BunNTfgNoT1vOgJqr554E2Bpm9yhHNS3FY1WNdiUzA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SmR0KV6T0/bdBqigVeOQsO3iayUB4/2hFO9gBbRCbFwK6UdZ1EpP6QxL5m9hkbhHD
         9V5GscqdEx5BAT7pLxKhZBu0FnFgQgN49RnUie73xbwX+2VUmgUZpzgViFM2onb0zd
         VYvxNY5a0AaA+c1qmiv4c/ny7fLRnOSZAsMXgyAo=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AeXKMzV0d67I; Fri, 12 Apr 2019 00:15:00 -0700 (PDT)
Received: from [10.4.223.204] (unknown [147.83.201.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id EF82A8EE0CF;
        Fri, 12 Apr 2019 00:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1555053300;
        bh=2BunNTfgNoT1vOgJqr554E2Bpm9yhHNS3FY1WNdiUzA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=t4bQlPkrh/y3auChWG9MleFMd/Wvy6WCvPExpcOBYQMdi5cbmNqfeD6tvdnVDFB/N
         yAOe6HtK/GN/KM8tmh/7MmLTKToFPYHPiyRKQV47xQZpkLBMOMjxl2ELFklD+Q6ZeZ
         rxVvrptVJ/NFJC3LH5wJU8BgTIzS+oU67H17SMtE=
Message-ID: <1555053293.3046.4.camel@HansenPartnership.com>
Subject: Re: [LSF/MM TOPIC] guarantee natural alignment for kmalloc()?
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Vlastimil Babka <vbabka@suse.cz>, lsf-pc@lists.linux-foundation.org
Cc:     Linux-FSDevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-block@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Ming Lei <ming.lei@redhat.com>, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Date:   Fri, 12 Apr 2019 09:14:53 +0200
In-Reply-To: <790b68b7-3689-0ff6-08ae-936728bc6458@suse.cz>
References: <790b68b7-3689-0ff6-08ae-936728bc6458@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2019-04-11 at 14:52 +0200, Vlastimil Babka wrote:
> Hi,
> 
> here's a late topic for discussion that came out of my patchset [1].
> It would likely have to involve all three groups, as FS/IO people
> would benefit, but it's MM area.
> 
> Background:
> The recent thread [2] inspired me to look into guaranteeing alignment
> for kmalloc() for power-of-two sizes. IIUC some usecases (see [2])
> don't know the required sizes in advance in order to create named
> caches via kmem_cache_create() with explicit alignment parameter
> (which is the only way to guarantee alignment right now). Moreover,
> in most cases the alignment happens naturally as the slab allocators
> split power-of-two-sized pages into smaller power-of-two-sized
> objects. kmalloc() users then might rely on the alignment even
> unknowingly, until it breaks when e.g. SLUB debugging is enabled.
> 
> Turns out it's not difficult to add the guarantees [1] and in the
> production SLAB/SLUB configurations nothing really changes as
> explained above. Then folks wouldn't have to come up with workarounds
> as in [2]. Technical downsides would be for SLUB debug mode
> (increased memory fragmentation, should be acceptable in a bug
> hunting scenario?), and SLOB (potentially worse performance due to
> increased packing effort, but this slab variant is rather marginal).
> 
> In the session I hope to resolve the question whether this is indeed
> the right thing to do for all kmalloc() users, without an explicit
> alignment requests, and if it's worth the potentially worse
> performance/fragmentation it would impose on a hypothetical new slab
> implementation for which it wouldn't be optimal to split power-of-two
> sized pages into power-of-two-sized objects (or whether there are any
> other downsides).

I think so.  The question is how aligned?  explicit flushing arch's
definitely need at least cache line alignment when using kmalloc for
I/O and if allocations cross cache lines they have serious coherency
problems.   The question of how much more aligned than this is
interesting ... I've got to say that the power of two allocator implies
same alignment as size and we seem to keep growing use cases that
assume this.  I'm not so keen on growing a separate API unless there's
a really useful mm efficiency in breaking the kmalloc alignment
assumptions.

James

