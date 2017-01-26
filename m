Return-Path: <dan.j.williams@intel.com>
MIME-Version: 1.0
In-Reply-To: <20170126174532.15189-4-jack@suse.cz>
References: <20170126174532.15189-1-jack@suse.cz> <20170126174532.15189-4-jack@suse.cz>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 26 Jan 2017 12:41:30 -0800
Message-ID: <CAPcyv4isSTrk5kAnko6zFWhYGSbsOdqMx2pjpppoQKOWrN8UcA@mail.gmail.com>
Subject: Re: [PATCH 3/4] block: Dynamically allocate and refcount backing_dev_info
To: Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Laurent Dufour <ldufour@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Thu, Jan 26, 2017 at 9:45 AM, Jan Kara <jack@suse.cz> wrote:
> Instead of storing backing_dev_info inside struct request_queue,
> allocate it dynamically, reference count it, and free it when the last
> reference is dropped. Currently only request_queue holds the reference
> but in the following patch we add other users referencing
> backing_dev_info.
>
> Signed-off-by: Jan Kara <jack@suse.cz>
[..]
> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> index e850e76acaaf..4282f21b1611 100644
> --- a/include/linux/backing-dev-defs.h
> +++ b/include/linux/backing-dev-defs.h
> @@ -144,7 +144,9 @@ struct backing_dev_info {
>
>         char *name;
>
> -       unsigned int capabilities; /* Device capabilities */
> +       atomic_t refcnt;        /* Reference counter for the structure */
> +       unsigned int capabilities:31;   /* Device capabilities */
> +       unsigned int free_on_put:1;     /* Structure will be freed on last bdi_put() */
>         unsigned int min_ratio;
>         unsigned int max_ratio, max_prop_frac;
>

Any reason to not just use struct kref for this? The "free on final
put" should be implicit. In other words, if there is a path that would
ever clear this flag, then it really should just be holding its own
reference.
