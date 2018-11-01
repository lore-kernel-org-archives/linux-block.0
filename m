Return-Path: <dverkamp@chromium.org>
Return-Path: <dverkamp@chromium.org>
MIME-Version: 1.0
References: <1528258740-6581-1-git-send-email-changpeng.liu@intel.com>
 <20181012210628.226361-1-dverkamp@chromium.org> <20181026080838.GB4234@stefanha-x1.localdomain>
 <20181026104636-mutt-send-email-mst@kernel.org> <20181029050521.GB31012@stefanha-x1.localdomain>
 <20181101172153-mutt-send-email-mst@kernel.org>
In-Reply-To: <20181101172153-mutt-send-email-mst@kernel.org>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Thu, 1 Nov 2018 15:18:35 -0700
Message-ID: <CABVzXAnO=pPcdjkvVw7RyX4LSqtuqDK+uvxavMsLAUJo6zn3Rg@mail.gmail.com>
Subject: Re: [PATCH v8] virtio_blk: add discard and write zeroes support
To: mst@redhat.com
Cc: stefanha@redhat.com, virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org, jasowang@redhat.com, axboe@kernel.dk,
	Changpeng Liu <changpeng.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Thu, Nov 1, 2018 at 2:25 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Oct 29, 2018 at 05:05:21AM +0000, Stefan Hajnoczi wrote:
> > On Fri, Oct 26, 2018 at 10:47:16AM -0400, Michael S. Tsirkin wrote:
> > > On Fri, Oct 26, 2018 at 09:08:38AM +0100, Stefan Hajnoczi wrote:
> > > > On Fri, Oct 12, 2018 at 02:06:28PM -0700, Daniel Verkamp wrote:
> > > > > +               range[n].flags = cpu_to_le32(flags);
> > > > > +               range[n].num_sectors = cpu_to_le32(num_sectors);
> > > > > +               range[n].sector = cpu_to_le64(sector);
> > > > ...
> > > > > +/* Discard/write zeroes range for each request. */
> > > > > +struct virtio_blk_discard_write_zeroes {
> > > > > +       /* discard/write zeroes start sector */
> > > > > +       __virtio64 sector;
> > > > > +       /* number of discard/write zeroes sectors */
> > > > > +       __virtio32 num_sectors;
> > > > > +       /* flags for this range */
> > > > > +       __virtio32 flags;
> > > >
> > > > cpu_to_le32() is being used on __virtio32 fields instead of cpu_to_virtio32().
> > > >
> > > > From include/uapi/linux/virtio_types.h:
> > > >
> > > >   /*
> > > >    * __virtio{16,32,64} have the following meaning:
> > > >    * - __u{16,32,64} for virtio devices in legacy mode, accessed in native endian
> > > >    * - __le{16,32,64} for standard-compliant virtio devices
> > > >    */
> > > >
> > > > From the VIRTIO specification:
> > > >
> > > >   struct virtio_blk_discard_write_zeroes {
> > > >          le64 sector;
> > > >          le32 num_sectors;
> > > >          struct {
> > > >                  le32 unmap:1;
> > > >                  le32 reserved:31;
> > > >          } flags;
> > > >   };
> > > >
> > > >
> > > > Since the VIRTIO spec says these fields are little-endian, I think these
> > > > fields should be declared just __u32 and __u64 instead of __virtio32 and
> > > > __virtio64.
> > > >
> > > > Stefan
> > >
> > >
> > > __le32/__le64 rather?
> >
> > Yes.
> >
> > Stefan
>
> I agree. And further using bitfields for this is questionable -
> it is preferable to set bits in a full 32 bit field using "|".

The bitfield is only in the specification, not the code - the actual
implementation in this patch (quoted above from earlier in the thread)
uses a 32-bit field with a flag #define.

I did misunderstand the meaning of __virtio32 vs __le32 - I'll fix
that up (I think the spec definition and code for these is already
correct; the structure definition just needs to change to match).

Thanks,
-- Daniel
