Return-Path: <mst@redhat.com>
Date: Thu, 1 Nov 2018 17:25:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Daniel Verkamp <dverkamp@chromium.org>,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Changpeng Liu <changpeng.liu@intel.com>
Subject: Re: [PATCH v8] virtio_blk: add discard and write zeroes support
Message-ID: <20181101172153-mutt-send-email-mst@kernel.org>
References: <1528258740-6581-1-git-send-email-changpeng.liu@intel.com>
 <20181012210628.226361-1-dverkamp@chromium.org>
 <20181026080838.GB4234@stefanha-x1.localdomain>
 <20181026104636-mutt-send-email-mst@kernel.org>
 <20181029050521.GB31012@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181029050521.GB31012@stefanha-x1.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Mon, Oct 29, 2018 at 05:05:21AM +0000, Stefan Hajnoczi wrote:
> On Fri, Oct 26, 2018 at 10:47:16AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Oct 26, 2018 at 09:08:38AM +0100, Stefan Hajnoczi wrote:
> > > On Fri, Oct 12, 2018 at 02:06:28PM -0700, Daniel Verkamp wrote:
> > > > +		range[n].flags = cpu_to_le32(flags);
> > > > +		range[n].num_sectors = cpu_to_le32(num_sectors);
> > > > +		range[n].sector = cpu_to_le64(sector);
> > > ...
> > > > +/* Discard/write zeroes range for each request. */
> > > > +struct virtio_blk_discard_write_zeroes {
> > > > +	/* discard/write zeroes start sector */
> > > > +	__virtio64 sector;
> > > > +	/* number of discard/write zeroes sectors */
> > > > +	__virtio32 num_sectors;
> > > > +	/* flags for this range */
> > > > +	__virtio32 flags;
> > > 
> > > cpu_to_le32() is being used on __virtio32 fields instead of cpu_to_virtio32().
> > > 
> > > From include/uapi/linux/virtio_types.h:
> > > 
> > >   /*
> > >    * __virtio{16,32,64} have the following meaning:
> > >    * - __u{16,32,64} for virtio devices in legacy mode, accessed in native endian
> > >    * - __le{16,32,64} for standard-compliant virtio devices
> > >    */
> > > 
> > > From the VIRTIO specification:
> > > 
> > >   struct virtio_blk_discard_write_zeroes {
> > >          le64 sector;
> > >          le32 num_sectors;
> > >          struct {
> > >                  le32 unmap:1;
> > >                  le32 reserved:31;
> > >          } flags;
> > >   };
> > > 
> > > 
> > > Since the VIRTIO spec says these fields are little-endian, I think these
> > > fields should be declared just __u32 and __u64 instead of __virtio32 and
> > > __virtio64.
> > > 
> > > Stefan
> > 
> > 
> > __le32/__le64 rather?
> 
> Yes.
> 
> Stefan

I agree. And further using bitfields for this is questionable -
it is preferable to set bits in a full 32 bit field using "|".


-- 
MST
