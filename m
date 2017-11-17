Return-Path: <hch@lst.de>
Date: Fri, 17 Nov 2017 16:08:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Michael Lyle <mlyle@lyle.org>
Cc: Jens Axboe <axboe@kernel.dk>, Campbell Steven <casteven@gmail.com>,
	Pavel Goran <via-bcache@pvgoran.name>,
	linux-bcache <linux-bcache@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Kent Overstreet <kent.overstreet@gmail.com>, hch@lst.de
Subject: Re: Regression in 4.14: wrong data being read from bcache device
Message-ID: <20171117150828.GA24694@lst.de>
References: <1321800569.20171116152838@pvgoran.name> <CAPerZE-KiYVWXtBsu+SR0wCgbSJgzZAufm+3NYdoybjq+6ySbQ@mail.gmail.com> <aa11e8f1-5120-9089-c1ad-43ac5057c029@lyle.org> <8a3d34b9-c49f-3870-fc7f-d337f7077c32@kernel.dk> <3474003b-b49f-d811-4116-e2d5fac730ce@lyle.org> <CAJ+L6qf=6-dBxNf+LdeXNNu0qkXNE_xEUqU_rb6ZASonV6=1sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJ+L6qf=6-dBxNf+LdeXNNu0qkXNE_xEUqU_rb6ZASonV6=1sw@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Nov 16, 2017 at 07:07:40PM -0800, Michael Lyle wrote:
> I think the probable cause is this: we construct bios based on
> previously completed bios in a few places,

That is an extremely bad idea in many ways, so I think we'll need
to fix this as the priority.
