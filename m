Return-Path: <mwilck@suse.com>
Message-ID: <f6f3f16b66622a9b16acd0d8be7ef311e4da807a.camel@suse.com>
Subject: Re: Silent data corruption in blkdev_direct_IO()
From: Martin Wilck <mwilck@suse.com>
To: Jens Axboe <axboe@kernel.dk>, Ming Lei <tom.leiming@gmail.com>, Hannes
	Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, "linux-block@vger.kernel.org"
	 <linux-block@vger.kernel.org>
Date: Sat, 14 Jul 2018 00:29:46 +0200
In-Reply-To: <c5073ab4-6b06-16bd-f358-d4c18e18b3e0@kernel.dk>
References: <e36f28d8-0eb8-1600-f327-8b066eeaf45c@suse.de>
	 <CACVXFVPVb_8pUkGXPt5joDE4JRu0b4kgTQy7Pd0sL+kXDwys+A@mail.gmail.com>
	 <c5073ab4-6b06-16bd-f358-d4c18e18b3e0@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Hi Ming & Jens,

On Fri, 2018-07-13 at 12:54 -0600, Jens Axboe wrote:
> On 7/12/18 5:29 PM, Ming Lei wrote:
> > 
> > Maybe you can try the following patch from Christoph to see if it
> > makes a
> > difference:
> > 
> > https://marc.info/?l=linux-kernel&m=153013977816825&w=2
> 
> That's not a bad idea.

Are you saying that the previous "nasty hack"  in
bio_iov_iter_get_pages() was broken, and the new one is not?
I've scratched my head over that (old) code lately, but I couldn't spot
an actual error in it.

Unfortunately we can only do one test at a time. We're currently trying
to find out more about the IO sizes at which the problem occurs. As you
noted, currently we know no more than that it happens somewhere between
16k and 1M.

Martin

-- 
Dr. Martin Wilck <mwilck@suse.com>, Tel. +49 (0)911 74053 2107
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
