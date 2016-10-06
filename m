Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.avalus.com ([89.16.176.221]:34807 "EHLO mail.avalus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755569AbcJFLFC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Oct 2016 07:05:02 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Nbd] [PATCH][V3] nbd: add multi-connection support
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20161006101506.evrrkoly5cifdtxq@grep.be>
Date: Thu, 6 Oct 2016 12:04:57 +0100
Cc: Alex Bligh <alex@alex.org.uk>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <jbacik@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Message-Id: <D2B0B120-AF23-47AC-95D2-76C64BC53AED@alex.org.uk>
References: <F4CD5523-E3BC-4151-B9B8-ADFE9040F6E3@alex.org.uk> <2B49072B-6F83-4CD2-863B-5AB21E1F7816@fb.com> <20161003072049.GA16847@infradead.org> <20161003075149.u3ppcnk2j55fci6h@grep.be> <20161003075701.GA29457@infradead.org> <97C12880-A095-4F7B-B828-1837E65F7721@alex.org.uk> <20161003210714.ukgojallutalpjun@grep.be> <2AEFCBE9-E2C9-400E-9FF8-91901D7CE442@alex.org.uk> <20161006090415.xme3mgcjtkdx2j5f@grep.be> <BB210E6A-0B67-4963-B4AB-AE801987C5DE@alex.org.uk> <20161006101506.evrrkoly5cifdtxq@grep.be>
To: Wouter Verhelst <w@uter.be>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> On 6 Oct 2016, at 11:15, Wouter Verhelst <w@uter.be> wrote:
> 
>> 
>> 
>> .... but I still think it would be helpful if the protocol helped out
>> the end user of the client and refused to negotiate multichannel
>> connections when they are unsafe. How is the end client meant to know
>> whether the back end is not on Linux, not on a block device, done
>> via a Ceph driver etc?
> 
> Well, it isn't. The server, if it provides certain functionality, should
> also provide particular guarantees. If it can't provide those
> guarantees, it should not provide that functionality.
> 
> e.g., if a server runs on a backend with cache coherency issues, it
> should not allow multiple connections to the same device, etc.

Sure. I'm simply saying that the connection flags should say "I can't
support multiple connections to this device" (available at
NBD_OPT_INFO time) rather than errorring out. This is a userspace
protocol issue.

>> I still think it's pretty damn awkward that with a ceph back end
>> (for instance) which would be one of the backends to benefit the
>> most from multichannel connections (as it's inherently parallel),
>> no one has explained how flush could be done safely.
> 
> If ceph doesn't have any way to guarantee that a write is available to
> all readers of a particular device, then it *cannot* be used to map
> block device semantics with multiple channels.

Thinking about it I believe Ceph actually may be able to do that,
it's just harder than a straightforward flush.

> Therefore, it should not
> allow writing to the device from multiple clients, period, unless the
> filesystem (or other thing) making use of the nbd device above the ceph
> layer actually understands how things may go wrong and can take care of
> it.
> 
> As such, I don't think that the problems inherent in using multiple
> connections to a ceph device (which I do not deny) have any place in a
> discussion on how NBD should work in the face of multiple channels with
> a sane/regular backend.

On which note, I am still not convinced that fsync() provides such
semantics on all operating systems and on Linux on non-block devices.
I'm not sure all those backends are 'insane'! However, if the server
could signal lack of support for multiple connections (see above)
my concerns would be significantly reduced. Note his requires no
kernel change (as you pointed out).

-- 
Alex Bligh




