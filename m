Return-Path: <shli@kernel.org>
Date: Tue, 10 Oct 2017 15:36:56 -0700
From: Shaohua Li <shli@kernel.org>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH v2 0/9] Nowait support for stacked block devices
Message-ID: <20171010223656.uv5t4oigfmjutj7u@kernel.org>
References: <20171004135511.26110-1-rgoldwyn@suse.de>
 <20171005171938.hob45bzeebvaigu2@kernel.org>
 <0bf484f7-1e95-86c4-c00d-125e22f73a8d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0bf484f7-1e95-86c4-c00d-125e22f73a8d@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Fri, Oct 06, 2017 at 07:01:19AM -0500, Goldwyn Rodrigues wrote:
> 
> 
> On 10/05/2017 12:19 PM, Shaohua Li wrote:
> > On Wed, Oct 04, 2017 at 08:55:02AM -0500, Goldwyn Rodrigues wrote:
> >> This is a continuation of the nowait support which was incorporated
> >> a while back. We introduced REQ_NOWAIT which would return immediately
> >> if the call would block at the block layer. Request based-devices
> >> do not wait. However, bio based devices (the ones which exclusively
> >> call make_request_fn) need to be trained to handle REQ_NOWAIT.
> >>
> >> This effort covers the devices under MD and DM which would block
> >> for any reason. If there should be more devices or situations
> >> which need to be covered, please let me know.
> >>
> >> The problem with partial writes discussed during v1 turned out
> >> to be a bug in partial writes during direct I/O and is fixed
> >> by the submitted patch[1].
> >>
> >> Changes since v1:
> >>  - mddev to return early in case the device is suspended, within the md code as opposed to ->make_request()
> >>  - Check for nowait support with all the lower devices. Same with if adding a device which does not support nowait.
> >>  - Nowait under each raid is checked before the final I/O submission for the entire I/O.
> >>
> >> [1] https://patchwork.kernel.org/patch/9979887/
> > 
> > Does this fix the partial IO issue we discussed before? It looks not to me. The
> > partial IO bailed out could be any part of an IO, so simply returning the
> > successed size doesn't help. Am I missing anything? I didn't follow the
> > discussion, maybe Jens knew.
> > 
> 
> If the partial IO bailed out is any part of IO, isn't it supposed to
> return the size of the IO succeeded _so far_? If a latter part of the IO
> succeeds (with a failure in between) what are you supposed to return to
> user in case of direct write()s? Would that even be correct in case it
> is a file overwrite?

I didn't argue about the return value. To me the partial IO issue can't be
fixed simply by whatever 'return value'.
