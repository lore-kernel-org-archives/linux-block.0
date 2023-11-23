Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF3C2694
	for <linux-block@vger.kernel.org>; Thu, 23 Nov 2023 07:30:12 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 92247227AAD; Thu, 23 Nov 2023 16:30:08 +0100 (CET)
Date: Thu, 23 Nov 2023 16:30:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: "kundan.kumar" <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de,
	linux-block@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH] block: skip QUEUE_FLAG_STATS and rq-qos for
 passthrough io
Message-ID: <20231123153007.GA3853@lst.de>
References: <CGME20231123103102epcas5p2aee268735dc9e0c357e6d3b98d16fe21@epcas5p2.samsung.com> <20231123102431.6804-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123102431.6804-1-kundan.kumar@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 23, 2023 at 03:54:31PM +0530, kundan.kumar wrote:
> -	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {
> +	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)
> +			&& !blk_rq_is_passthrough(rq)) {

&& goes on the starting line in the kernel code style.

The rest looks good, but that stats overhead seems pretty horrible..

