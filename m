Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <149266673005.27388.9415706764616504556.stgit@noble>
References: <149266645258.27388.14083229348123176454.stgit@noble> <149266673005.27388.9415706764616504556.stgit@noble>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 21 Apr 2017 23:41:18 +0800
Message-ID: <CACVXFVMa_Qo2eFhSnt+URaubsr2VSnhW=ypsyjEo5e=L2FG7_w@mail.gmail.com>
Subject: Re: [PATCH 09/11] bcache: use kmalloc to allocate bio in bch_data_verify()
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kent Overstreet <kent.overstreet@gmail.com>,
	"open list:BCACHE (BLOCK LAYER CACHE)" <linux-bcache@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 20, 2017 at 1:38 PM, NeilBrown <neilb@suse.com> wrote:
> This function allocates a bio, then a collection
> of pages.  It copes with failure.
>
> It currently uses a mempool() to allocate the bio,
> but alloc_page() to allocate the pages.  These fail
> in different ways, so the usage is inconsistent.
>
> Change the bio_clone() to bio_clone_kmalloc()
> so that no pool is used either for the bio or the pages.
>
> Signed-off-by: NeilBrown <neilb@suse.com>

Reviewed-by : Ming Lei <ming.lei@redhat.com>


Thanks,
Ming Lei
