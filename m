Return-Path: <dan.j.williams@gmail.com>
MIME-Version: 1.0
In-Reply-To: <57476FC1.6020702@bjorling.me>
References: <5742B023.2040503@bjorling.me>
	<CAA9_cmfVKoEw1XpJJ4j4+QHWB29-cRvdDp1hmtyegxSpBy0fNw@mail.gmail.com>
	<57473C2D.2060700@bjorling.me>
	<CAA9_cmeVeQzL7kJS1s--N9r-9Pap=KWz42Pmwd1r_4Bd03cL0g@mail.gmail.com>
	<57476FC1.6020702@bjorling.me>
Date: Thu, 26 May 2016 15:06:04 -0700
Message-ID: <CAA9_cmczkSBgLj5BwjVRVAq5b3SYGHbNSyu2qO1_TRguYRQ1pg@mail.gmail.com>
Subject: Re: gendisk and lightnvm
From: Dan Williams <dan.j.williams@gmail.com>
To: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Keith Busch <keith.busch@intel.com>, Simon Lund <slund@cnexlabs.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Thu, May 26, 2016 at 2:50 PM, Matias Bj=C3=B8rling <m@bjorling.me> wrote=
:
> On 05/26/2016 09:05 PM, Dan Williams wrote:
[..]
> In that case, the holder kobject is maintained by the request queue. That
> moves the block device naming earlier in the initialization process, and =
the
> request queue would properly need to hold the (struct gendisk)->diskname.=
 I
> wonder if there is a better way.

I don't see why it is necessary to move the block device naming
earlier.  The block device kobject can link to the mq/ kobject created
by lightnvm rather than include it as a child of the gendisk.
