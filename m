Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750807AbdHRJWp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Aug 2017 05:22:45 -0400
Date: Fri, 18 Aug 2017 11:22:39 +0200
From: Karel Zak <kzak@redhat.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
        kernel-team@fb.com, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 1/2] loop: always return block size in LOOP_GET_STATUS
Message-ID: <20170818092239.sxdpayiyukpwaoge@ws.net.home>
References: <cover.1503036471.git.osandov@fb.com>
 <9ff9b291e3e872698a040a281549c39c0637565f.1503036471.git.osandov@fb.com>
 <c54bc65f-7106-0dee-77dc-32bbaf1a3d1d@suse.de>
 <20170818073838.GG2459@vader>
 <3f01f907-0443-4961-d4fd-a5a3ffe8e688@suse.de>
 <20170818074700.GH2459@vader>
 <d5d61484-9aa9-5161-8abf-cce924521df1@suse.de>
 <20170818080539.GI2459@vader>
 <3a42bb8d-1850-8d6c-11c6-bf8632af5e7a@suse.de>
 <20170818082226.GK2459@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170818082226.GK2459@vader>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Aug 18, 2017 at 01:22:26AM -0700, Omar Sandoval wrote:
> On Fri, Aug 18, 2017 at 10:12:51AM +0200, Hannes Reinecke wrote:
> > On 08/18/2017 10:05 AM, Omar Sandoval wrote:
> > > On Fri, Aug 18, 2017 at 09:56:26AM +0200, Hannes Reinecke wrote:
> > >> On 08/18/2017 09:47 AM, Omar Sandoval wrote:
> > [ .. ]
> > >>>
> > >>> I actually checked losetup, it works just fine with LO_FLAGS_BLOCKSIZE
> > >>> always set and lo_init[0] always filled in.
> > >>>
> > >> The original argument I had with the util-linux maintainer did not
> > >> revolve so much around technical details :-)
> > > 
> > > Karel, what were your concerns here?
> > > 
> > It wasn't Karel, it was our guy.
> > Doesn't make it any better, though...
> 
> I just went through the code and util-linux doesn't mention lo_init at
> all except for the definition, and everywhere it's using lo_flags would
> work fine with the behavior I implemented here. Unless there's an actual
> issue someone can point out, I see no reason to not do it this way.

 Hmm.. we have loopdev API enhancement in Linus' tree and losetup
 maintainer have no clue about it ;-)


 Anyway, I like the idea with LO_FLAGS_BLOCKSIZE and lo_init[]. It
 seems like a backwardly compatible way how to make loopdevs usable
 for dd(1) images from non-512 devices, etc.

 For now nothing uses lo_init[], so it seems no problem to use it for
 LOOP_GET_STATUS64. 
 
 Note that we use LOOP_GET_STATUS64 and struct loop_info64 only, old API 
 around "struct loop_info" is no more used by util-linux.

 The important detail is that for losetup (to show mapped devices) is
 more important /sys than LOOP_GET_STATUS64. The /sys is better
 because it does not require root permissions and it makes losetup
 (and lsblk) usable for regular users. 
 
 I guess /sys/block/loopN/queue/minimum_io_size is affected by Hannes'
 LO_FLAGS_BLOCKSIZE patches, so non-512 I/O sizes for loopdevs are 
 visible in "lsblk -t /dev/loopN" output, right?

 I'll add --blocksize <size> to losetup, and BLKSZ column to output to
 make the new feature usable also for end-users.

 Thanks for CC:

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
