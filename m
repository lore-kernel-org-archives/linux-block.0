Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2625677F
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BC6D768CFE; Thu, 11 Jan 2024 17:18:46 +0100 (CET)
Date: Thu, 11 Jan 2024 17:18:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] blk-mq: ensure a q_usage_counter reference is held
 when splitting bios
Message-ID: <20240111161846.GA17045@lst.de>
References: <20240111135705.2155518-1-hch@lst.de> <20240111135705.2155518-3-hch@lst.de> <d713fe1b-3eaa-4de4-99a6-5910247ffad5@kernel.dk> <20240111161440.GA16626@lst.de> <d91cb6ee-50bd-4397-b82f-d34dfc135b4a@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d91cb6ee-50bd-4397-b82f-d34dfc135b4a@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 11, 2024 at 09:17:41AM -0700, Jens Axboe wrote:
> Don't think it's .config related, hit it on my test box and then in my
> vm as well. It's likely due to batched allocations, would be my guess.
> I can start/halt the vm fine with just a boot, but if I do:
> 
> $ ~/git/fio/t/io_uring -p1 -d128 -b512 -s32 -c32 -F1 -B1 -R0 -X1 -P1 /dev/nvme0n1
> 
> for just a brief moment, nvme0 will hang on shutdown.

Thanks, I'll look into it.
