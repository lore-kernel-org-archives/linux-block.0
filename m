Return-Path: <keith.busch@intel.com>
Date: Tue, 15 Mar 2016 16:03:22 +0000
From: Keith Busch <keith.busch@intel.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Dan Williams <dan.j.williams@intel.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sagi Grimberg <sagig@mellanox.com>,
	Mike Snitzer <snitzer@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Cathy Avery <cavery@redhat.com>
Subject: Re: [PATCH RFC] block: fix bio merge checks when virt_boundary is
 set
Message-ID: <20160315160321.GA30533@localhost.lm.intel.com>
References: <1458055076-2175-1-git-send-email-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1458055076-2175-1-git-send-email-vkuznets@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Mar 15, 2016 at 04:17:56PM +0100, Vitaly Kuznetsov wrote:
> The reason of the slowdown is the fact that bios don't get merged and we
> end up sending many short requests to the host. My investigation led me to
> the following code (__bvec_gap_to_prev()):
> 
>     return offset ||
>            ((bprv->bv_offset + bprv->bv_len) & queue_virt_boundary(q));
> 
> Here is an example: we have two bio_vec with the following content:
>     bprv.bv_offset = 512
>     bprv.bv_len = 512
> 
>     bnxt.bv_offset = 1024
>     bnxt.bv_len = 512
> 
>     bprv.bv_page == bnxt.bv_page
>     virt_boundary is set to PAGE_SIZE-1
> 
> The above mentioned code will report that a gap will appear if we merge
> these two (as offset = 1024) but this doesn't look sane. On top of that,
> we have the following optimization in bio_add_pc_page():
> 
>     if (page == prev->bv_page &&
>         offset == prev->bv_offset + prev->bv_len) {
>             prev->bv_len += len;
>             bio->bi_iter.bi_size += len;
>             goto done;
>         }

This part sounds odd. Why is a filesystem using bio_add_pc_page? Shouldn't
these go through "bio_add_page" instead? That already has an optimization
to combine bio's within the same page.
