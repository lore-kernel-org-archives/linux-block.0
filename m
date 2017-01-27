Return-Path: <linux-scsi-owner@vger.kernel.org>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "j-nomura@ce.jp.nec.com" <j-nomura@ce.jp.nec.com>
Subject: Re: [PATCH 05/18] block: allow specifying size for extra command
 data
Date: Fri, 27 Jan 2017 17:21:28 +0000
Message-ID: <1485537668.4267.7.camel@sandisk.com>
References: <1485365126-23210-1-git-send-email-hch@lst.de>
         <1485365126-23210-6-git-send-email-hch@lst.de> <yq160l2a4us.fsf@oracle.com>
         <20170127161254.GA16557@lst.de>
In-Reply-To: <20170127161254.GA16557@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Fri, 2017-01-27 at 17:12 +0100, Christoph Hellwig wrote:
> On Wed, Jan 25, 2017 at 10:15:55PM -0500, Martin K. Petersen wrote:
> > +static void *alloc_request_size(gfp_t gfp_mask, void *data)
> >=20
> > I like alloc_request_simple() but alloc_request_size() seems a bit
> > contrived. _reserve? _extra? _special? Don't have any good suggestions,
> > I'm afraid.
>=20
> Not that I'm a fan of _size, but I like the other suggestions even less.

Hello Christoph and Martin,

How about using the function names alloc_full_request() / free_full_request=
()
together with a comment that mentions that cmd_size is set by the LLD?

Bart.=
