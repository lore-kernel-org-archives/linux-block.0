Return-Path: <BATV+77ddf8e9b1b344f28472+5381+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 18 May 2018 09:04:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: adam.manzanares@wdc.com
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
	bcrl@kvack.org, mingo@kernel.org, peterz@infradead.org,
	pombredanne@nexb.com, gregkh@linuxfoundation.org,
	bigeasy@linutronix.de, rgoldwyn@suse.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-aio@kvack.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v4 1/3] block: add ioprio_check_cap function
Message-ID: <20180518160415.GF22791@infradead.org>
References: <20180517203803.2664-1-adam.manzanares@wdc.com>
 <20180517203803.2664-2-adam.manzanares@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180517203803.2664-2-adam.manzanares@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 17, 2018 at 01:38:01PM -0700, adam.manzanares@wdc.com wrote:
> From: Adam Manzanares <adam.manzanares@wdc.com>
> 
> Aio per command iopriority support introduces a second interface between
> userland and the kernel capable of passing iopriority. The aio interface also
> needs the ability to verify that the submitting context has sufficient
> priviledges to submit IOPRIO_RT commands. This patch creates the
> ioprio_check_cap function to be used by the ioprio_set system call and also by
> the aio interface.
> 
> Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
