Return-Path: <jack@suse.cz>
Date: Mon, 30 Jan 2017 13:47:07 +0100
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/4] block: Dynamically allocate and refcount
 backing_dev_info
Message-ID: <20170130124707.GB21673@quack2.suse.cz>
References: <20170126174532.15189-1-jack@suse.cz>
 <20170126174532.15189-4-jack@suse.cz>
 <CAPcyv4isSTrk5kAnko6zFWhYGSbsOdqMx2pjpppoQKOWrN8UcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPcyv4isSTrk5kAnko6zFWhYGSbsOdqMx2pjpppoQKOWrN8UcA@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Thu 26-01-17 12:41:30, Dan Williams wrote:
> On Thu, Jan 26, 2017 at 9:45 AM, Jan Kara <jack@suse.cz> wrote:
> > Instead of storing backing_dev_info inside struct request_queue,
> > allocate it dynamically, reference count it, and free it when the last
> > reference is dropped. Currently only request_queue holds the reference
> > but in the following patch we add other users referencing
> > backing_dev_info.
> >
> > Signed-off-by: Jan Kara <jack@suse.cz>
> [..]
> > diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> > index e850e76acaaf..4282f21b1611 100644
> > --- a/include/linux/backing-dev-defs.h
> > +++ b/include/linux/backing-dev-defs.h
> > @@ -144,7 +144,9 @@ struct backing_dev_info {
> >
> >         char *name;
> >
> > -       unsigned int capabilities; /* Device capabilities */
> > +       atomic_t refcnt;        /* Reference counter for the structure */
> > +       unsigned int capabilities:31;   /* Device capabilities */
> > +       unsigned int free_on_put:1;     /* Structure will be freed on last bdi_put() */
> >         unsigned int min_ratio;
> >         unsigned int max_ratio, max_prop_frac;
> >
> 
> Any reason to not just use struct kref for this? The "free on final
> put" should be implicit. In other words, if there is a path that would
> ever clear this flag, then it really should just be holding its own
> reference.

The free_on_put is there for static incarnations of this structure...
However yes, I can have a look into grabbing the reference on module init
for these cases so that we can avoid the flag.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
