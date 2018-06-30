Return-Path: <kent.overstreet@gmail.com>
Return-Path: <kent.overstreet@gmail.com>
Date: Sat, 30 Jun 2018 19:38:30 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH] block: Make __bio_clone_fast() copy bi_vcnt
Message-ID: <20180630233830.GC31305@kmo-pixel>
References: <20180627201231.15641-1-bart.vanassche@wdc.com>
 <20180627235005.GE7583@ming.t460p>
 <4995fc0c-e9d7-d747-7331-67396827a596@wdc.com>
 <20180628003007.GG7583@ming.t460p>
 <5e78949d-6169-5a5a-869b-731a3468e2de@wdc.com>
 <CACVXFVNzb9j_KwJLor4O=T_fgRRR12KOkZ2DXtniYp=u3Ru3bg@mail.gmail.com>
 <20180628231616.GA31305@kmo-pixel>
 <dc3a20ab-b72a-46c9-1f93-7f835b24b854@wdc.com>
 <20180629000424.GB31305@kmo-pixel>
 <914493fc-d2c0-19a1-533e-c9e72340c8e9@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <914493fc-d2c0-19a1-533e-c9e72340c8e9@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jun 29, 2018 at 01:00:33PM -0700, Bart Van Assche wrote:
> On 06/28/18 17:04, Kent Overstreet wrote:
> > On Thu, Jun 28, 2018 at 04:54:44PM -0700, Bart Van Assche wrote:
> > > Thanks for chiming in. The linux-block mailing list is archived by multiple
> > > websites. The entire e-mail thread is available on e.g.
> > > https://www.mail-archive.com/linux-block@vger.kernel.org/msg23006.html.
> > > 
> > > I have a question for you: at least in kernel v4.17 bio_clone_bioset()
> > > copies bi_vcnt from the source to the destination bio. However,
> > > __bio_clone_fast() doesn't copy bi_vcnt. Isn't that an inconsistency?
> > 
> > No - when you use bio_clone_bioset() you get a bio that you own and can do
> > whatever you want with, so it does make sense for it to initialize bi_vcnt.
> > 
> > e.g. you could use bio_clone_bioset() when you're going to be bouncing a bio,
> > iterating over each bvec and allocating a new page and copying data from the old
> > page to the new page.
> 
> Hello Kent,
> 
> Have you considered to explain this in a comment above __bio_clone_fast() to
> avoid that the next person who reads that function gets confused?

Well, there is a large comment in bio_clone_bioset() that you must have found...
