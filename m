Return-Path: <kent.overstreet@gmail.com>
Return-Path: <kent.overstreet@gmail.com>
Date: Thu, 3 Nov 2016 03:30:46 -0800
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@fb.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
	Mike Christie <mchristi@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH 28/60] block: introduce QUEUE_FLAG_SPLIT_MP
Message-ID: <20161103113046.s2sx7t4et2pha3on@kmo-pixel>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
 <1477728600-12938-29-git-send-email-tom.leiming@gmail.com>
 <20161031153915.GL30919@infradead.org>
 <20161102030813.spwwymvdrym3lrah@kmo-pixel>
 <CACVXFVMgtt=8bi3KzQWOsPhfj55eFW0x9iRmnMyBw_Lyykp4EA@mail.gmail.com>
 <20161103112012.ehqnfeswdf3eo4kd@kmo-pixel>
 <CACVXFVOkPodSDwfv4jHZ__t6dLBh-dnB9+v9esZ-1ReW7Rrj5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVOkPodSDwfv4jHZ__t6dLBh-dnB9+v9esZ-1ReW7Rrj5g@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Nov 03, 2016 at 07:26:52PM +0800, Ming Lei wrote:
> On Thu, Nov 3, 2016 at 7:20 PM, Kent Overstreet
> <kent.overstreet@gmail.com> wrote:
> > On Thu, Nov 03, 2016 at 06:38:57PM +0800, Ming Lei wrote:
> >> On Wed, Nov 2, 2016 at 11:08 AM, Kent Overstreet
> >> <kent.overstreet@gmail.com> wrote:
> >> > On Mon, Oct 31, 2016 at 08:39:15AM -0700, Christoph Hellwig wrote:
> >> >> On Sat, Oct 29, 2016 at 04:08:27PM +0800, Ming Lei wrote:
> >> >> > Some drivers(such as dm) should be capable of dealing with multipage
> >> >> > bvec, but the incoming bio may be too big, such as, a new singlepage bvec
> >> >> > bio can't be cloned from the bio, or can't be allocated to singlepage
> >> >> > bvec with same size.
> >> >> >
> >> >> > At least crypt dm, log writes and bcache have this kind of issue.
> >> >>
> >> >> We already have the segment_size limitation for request based drivers.
> >> >> I'd rather extent it to bio drivers if really needed.
> >> >>
> >> >> But then again we should look into not having this limitation.  E.g.
> >> >> for bcache I'd be really surprised if it's that limited, given that
> >> >> Kent came up with this whole multipage bvec scheme.
> >> >
> >> > AFAIK the only issue is with drivers that may have to bounce bios - pages that
> >> > were contiguous in the original bio won't necessarily be contiguous in the
> >> > bounced bio, thus bouncing might require more than BIO_MAX_SEGMENTS bvecs.
> >> >
> >> > I don't know what Ming's referring to by "singlepage bvec bios".
> >> >
> >> > Anyways, bouncing comes up in multiple places so we probably need to come up
> >> > with a generic solution for that. Other than that, there shouldn't be any issues
> >> > or limitations - if you're not bouncing, there's no need to clone the bvecs.
> >>
> >> AFAIK, the only special case is bch_data_verify(): drivers/md/bcache/debug.c,
> >> for other bio_clone(), no direct access to io vec table, so default
> >> multipage bvec
> >> copy is fine.
> >>
> >> I will remove the flag and try to fix bch_data_verify() by using multiple bio,
> >> and I remembered I cooked patch to do that long time ago, :-)
> >
> > You can #ifdef out the bch_data_verify() code, it's debug code that hasn't been
> > used in ages.
> 
> Though you didn't test it ages, it is sitll working in my last test, :-)
> 
> But someone can enable that for debug too, I don't want to make him/her sad.

Up to you :)

It's not useful for anything but debugging though, so I wouldn't worry about
impacting end users.
