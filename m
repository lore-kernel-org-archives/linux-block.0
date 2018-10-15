Return-Path: <dverkamp@chromium.org>
Return-Path: <dverkamp@chromium.org>
MIME-Version: 1.0
References: <1528258740-6581-1-git-send-email-changpeng.liu@intel.com>
 <20181012210628.226361-1-dverkamp@chromium.org> <20181015092740.GA3964@infradead.org>
In-Reply-To: <20181015092740.GA3964@infradead.org>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Mon, 15 Oct 2018 16:16:03 -0700
Message-ID: <CABVzXAn1vhC=TBAzcVuKw7S63t5HUQWgWjMGX-yEXd=hx_1KHA@mail.gmail.com>
Subject: Re: [PATCH v8] virtio_blk: add discard and write zeroes support
To: hch@infradead.org
Cc: virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
	mst@redhat.com, jasowang@redhat.com, axboe@kernel.dk, stefanha@redhat.com,
	Changpeng Liu <changpeng.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Mon, Oct 15, 2018 at 2:27 AM Christoph Hellwig <hch@infradead.org> wrote=
:
> On Fri, Oct 12, 2018 at 02:06:28PM -0700, Daniel Verkamp wrote:
> > From: Changpeng Liu <changpeng.liu@intel.com>
> >
> > In commit 88c85538, "virtio-blk: add discard and write zeroes features
> > to specification" (https://github.com/oasis-tcs/virtio-spec), the virti=
o
>
> There is some issues in this spec.  For one using the multiple ranges
> also for write zeroes is rather inefficient.  Write zeroes really should
> use the same format as read and write.

I wasn't involved in the writing of the spec, so I'll defer to Michael
and Changpeng here, but I'm not sure how "set in stone" the virtio
specification is, or if it can be updated somehow without breaking
compatibility.

I agree that Write Zeroes would be simpler to implement as a single
LBA + length rather than a list.  However, it's not really possible to
use the same format as the regular virtio block read/write commands
(VIRTIO_BLK_T_IN/VIRTIO_BLK_T_OUT), since the read/write commands do
not specify a length explicitly; length is implied by the length of
the data buffer as defined by the virtio descriptor, but a Write
Zeroes command does not require a data buffer.  At best, this could be
a separate command mirroring the layout of struct virtio_blk_req but
with data replaced with a length field; I'm not sure that buys much in
the way of consistency.

> Second the unmap flag isn't properly specified at all, as nothing
> says the device may not unmap without the unmap flag.  Please take
> a look at the SCSI or NVMe =D1=95pec for some guidance.

This could probably use some clarifying text in the specification, but
given that there is nothing in the spec describing what the device
needs to do when unmap =3D 0, I would assume that the device can do
whatever it likes, as long as the blocks read back as 0s afterwards.
Reading back 0s is required by the definition of the Write Zeroes
command in the same virtio spec change.  It would probably be good to
clarify this and explicitly define what the device is allowed to do in
response to both settings of the unmap bit.

My understanding of the corresponding feature in NVMe (the Deallocate
bit in the Write Zeroes command) is that the only difference between
Deallocate =3D 1 and 0 is that the device "should" versus "may" (no
"shall" on either side) deallocate the corresponding blocks, but only
if the device supports reading 0s back after blocks are deallocated.
If the device does not support reading 0s after deallocation, it is
not allowed to deallocate blocks as part of a Write Zeroes command
regardless of the setting of the Deallocate bit.

Some similar wording could probably be added to the virtio spec to
clarify the meaning of unmap, although I would prefer something that
makes it a little clearer that the bit is only intended as a hint from
the driver to indicate whether the device should attempt to keep
storage allocated for the zeroed blocks, if that is indeed the
intended behavior.

Is there some in-kernel doc that describes what behavior the Linux
block layer needs from a write zeroes command?

> > +static inline int virtblk_setup_discard_write_zeroes(struct request *r=
eq,
> > +                                             bool unmap)
>
> Why is this an inline function?

I don't think there's any reason it needs to be inline; I can drop the
inline in the next revision.

Given (as far as I can tell) your concerns seem to apply to the Write
Zeroes command specifically, would it be reasonable to start with a
patch that just adds support for the Discard command (along with fixes
for Ming's feedback)?  This would be sufficient for my particular use
case (although I can't speak for Changpeng), and we can revisit Write
Zeroes once the spec concerns are worked out.

Thanks,
-- Daniel
