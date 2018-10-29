Return-Path: <changpeng.liu@intel.com>
From: "Liu, Changpeng" <changpeng.liu@intel.com>
To: Christoph Hellwig <hch@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>
CC: Daniel Verkamp <dverkamp@chromium.org>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: RE: [PATCH v8] virtio_blk: add discard and write zeroes support
Date: Mon, 29 Oct 2018 03:21:35 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B76B458@SHSMSX103.ccr.corp.intel.com>
References: <1528258740-6581-1-git-send-email-changpeng.liu@intel.com>
 <20181012210628.226361-1-dverkamp@chromium.org>
 <20181015092740.GA3964@infradead.org>
 <486afcff-a8bd-a05b-e331-e395d4d14853@redhat.com>
 <20181026082640.GA1147@infradead.org>
In-Reply-To: <20181026082640.GA1147@infradead.org>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Return-Path: changpeng.liu@intel.com
List-ID: <linux-block@vger.kernel.org>



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@infradead.org]
> Sent: Friday, October 26, 2018 4:27 PM
> To: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Christoph Hellwig <hch@infradead.org>; Daniel Verkamp
> <dverkamp@chromium.org>; Jens Axboe <axboe@kernel.dk>; Michael S. Tsirkin
> <mst@redhat.com>; virtualization@lists.linux-foundation.org; linux-
> block@vger.kernel.org; Stefan Hajnoczi <stefanha@redhat.com>; Liu, Changp=
eng
> <changpeng.liu@intel.com>
> Subject: Re: [PATCH v8] virtio_blk: add discard and write zeroes support
>=20
> On Fri, Oct 26, 2018 at 01:28:54AM +0200, Paolo Bonzini wrote:
> > On 15/10/2018 11:27, Christoph Hellwig wrote:
> > > There is some issues in this spec.  For one using the multiple ranges
> > > also for write zeroes is rather inefficient.  Write zeroes really sho=
uld
> > > use the same format as read and write.
> >
> > What makes it inefficient?
>=20
> We require a memory allocation for each write zeroes instead of encoding
> the lba/len in the command.
Make sense to me, but need to change the spec first.
