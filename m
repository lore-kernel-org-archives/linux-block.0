Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10E4C636CD
	for <linux-block@archiver.kernel.org>; Tue,  7 Feb 2023 12:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjBGMus (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Feb 2023 07:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjBGMur (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Feb 2023 07:50:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4BC10C7
        for <linux-block@vger.kernel.org>; Tue,  7 Feb 2023 04:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675774200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QVyaeCDDo0OwqkmAZHvFR+VX7j0JvRc9V6wXEOCTi90=;
        b=TGFqkgcWXXsaswUtMRXjqlmF7rtFZqJY/tUPMiqt9cwk4NKE9KTybOOPvkRBbG1BPNBo2f
        Ig0AKZPvQnMPXrOTha7NKfNKNT3o3gClV6au0witpJN21hBBrn4BbZxFf5ysYXjeRVXKxn
        ml/TcZ6XRXf7+Ikf0CEH4Gj6TUE8+Uw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-CdWJhwiqOMah8ACynzhTPQ-1; Tue, 07 Feb 2023 07:49:55 -0500
X-MC-Unique: CdWJhwiqOMah8ACynzhTPQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE7CD1C02D43;
        Tue,  7 Feb 2023 12:49:54 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 285C41431C7C;
        Tue,  7 Feb 2023 12:49:44 +0000 (UTC)
Date:   Tue, 7 Feb 2023 20:49:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Dennis Maisenbacher <dennis.maisenbacher@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        =?iso-8859-1?Q?J=F8rgen?= Hansen <Jorgen.Hansen@wdc.com>,
        "andreas@metaspace.dk" <andreas@metaspace.dk>,
        "javier@javigon.com" <javier@javigon.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "hans@owltronix.com" <hans@owltronix.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "guokuankuan@bytedance.com" <guokuankuan@bytedance.com>,
        "viacheslav.dubeyko@bytedance.com" <viacheslav.dubeyko@bytedance.com>,
        "hch@lst.de" <hch@lst.de>, ming.lei@redhat.com
Subject: Re: [LSF/MM/BPF BoF]: A host FTL for zoned block devices using UBLK
Message-ID: <Y+JI47f6qylPpXxU@T590>
References: <20230206100019.GA6704@gsv>
 <Y+D3Sy8v3taelXvF@T590>
 <CGME20230207103212epcas5p41c50a45f9d892a53915e04b604a40149@epcas5p4.samsung.com>
 <20230207103141.GC27856@green5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207103141.GC27856@green5>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 07, 2023 at 04:01:41PM +0530, Nitesh Shetty wrote:
> On Mon, Feb 06, 2023 at 08:49:15PM +0800, Ming Lei wrote:
> > On Mon, Feb 06, 2023 at 10:00:20AM +0000, Hans Holmberg wrote:
> > > I think we're missing a flexible way of routing random-ish
> > > write workloads on to zoned storage devices. Implementing a UBLK
> > > target for this would be a great way to provide zoned storage
> > > benefits to a range of use cases. Creating UBLK target would
> > > enable us experiment and move fast, and when we arrive
> > > at a common, reasonably stable, solution we could move this into
> > > the kernel.
> > 
> > Yeah, UBLK provides one easy way for fast prototype.
> > 
> > > 
> > > We do have dm-zoned [3]in the kernel, but it requires a bounce
> > > on conventional zones for non-sequential writes, resulting in a write
> > > amplification of 2x (which is not optimal for flash).
> > > 
> > > Fully random workloads make little sense to store on ZBDs as a
> > > host FTL could not be expected to do better than what conventional block
> > > devices do today. Fully sequential writes are also well taken care of
> > > by conventional block devices.
> > > 
> > > The interesting stuff is what lies in between those extremes.
> > > 
> > > I would like to discuss how we could use UBLK to implement a
> > > common FTL with the right knobs to cater for a wide range of workloads
> > > that utilize raw block devices. We had some knobs in  the now-dead pblk,
> > > a FTL for open channel devices, but I think we could do way better than that.
> > > 
> > > Pblk did not require bouncing writes and had knobs for over-provisioning and
> > > workload isolation which could be implemented. We could also add options
> > > for different garbage collection policies. In userspace it would also 
> > > be easy to support default block indirection sizes, reducing logical-physical
> > > translation table memory overhead.
> > > 
> > > Use cases for such an FTL includes SSD caching stores such as Apache
> > > traffic server [1] and CacheLib[2]. CacheLib's block cache and the apache
> > > traffic server storage workloads are *almost* zone block device compatible
> > > and would need little translation overhead to perform very well on e.g.
> > > ZNS SSDs.
> > > 
> > > There are probably more use cases that would benefit.
> > > 
> > > It would also be a great research vehicle for academia. We've used dm-zap
> > > for this [4] purpose the last couple of years, but that is not production-ready
> > > and cumbersome to improve and maintain as it is implemented as a out-of-tree
> > > device mapper.
> > 
> > Maybe it is one beginning for generic open-source userspace SSD FTL,
> > which could be useful for people curious in SSD internal. I have
> > google several times for such toolkit to see if it can be ported to
> > UBLK easily. SSD simulator isn't great, which isn't disk and can't handle
> > real data & workloads. With such project, SSD simulator could be less
> > useful, IMO.
> > 
> > > 
> > > ublk adds a bit of latency overhead, but I think this is acceptable at least
> > > until we have a great, proven solution, which could be turned into
> > > an in-kernel FTL.
> > 
> > We will keep improving ublk io path, and I am working on ublk
> > copy. Once it is done, big chunk IO latency could be reduced a lot.
> > 
> 
> Just curious, will this also involve running do_splice_direct*() in async style
> like normal async read/write, instead of offloading to iowq context ?

Follows the idea:

- adding new type of buffer(splice buffer) to io_uring, this
buffer will be populated into bvec table(reusing io_mapped_ubuf) by
passing (splice_fd, offset, len) from SQE.

- The buffer is filled from ublk ->read_splice() with help of
splice_direct_to_actor() over direct pipe, probably we can add one
private splice flag to just allow ublk ->read_splice() to be available
in kernel(io_uring) & direct pipe

- It requires the pipe buffer ownership not transferred, so nop_pipe_buf_ops
is needed for such usage, and this way is pretty fine for ublk & fuse.

- The buffer can be allocated & populated from ->prep() of io_uring rw/net,
then handled just like READ[WRITE]_FIXED.

So it is like normal async read/write, then two pin pages are avoided,
and one time of io data copy is saved.

This way is also flexible to allow read/write over any part of the buffer.

Thanks,
Ming

