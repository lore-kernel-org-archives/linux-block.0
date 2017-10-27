Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] one nvme fix for 4.14
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20171027062319.gvxuxxffwcfh2v4q@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8d69e358-756b-6ab9-5c18-0671d926cbd4@kernel.dk>
Date: Fri, 27 Oct 2017 08:18:15 -0600
MIME-Version: 1.0
In-Reply-To: <20171027062319.gvxuxxffwcfh2v4q@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/27/2017 12:23 AM, Christoph Hellwig wrote:
> The following changes since commit f04b9cc87b5fc466b1b7231ba7b078e885956c5b:
> 
>   nvme-rdma: Fix error status return in tagset allocation failure (2017-10-19 17:13:51 +0200)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.14
> 
> for you to fetch changes up to 7db814465395f3196ee98c8bd40d214d63e4f708:
> 
>   nvme-rdma: fix possible hang when issuing commands during ctrl removal (2017-10-23 16:27:44 +0200)
> 
> ----------------------------------------------------------------
> Sagi Grimberg (1):
>       nvme-rdma: fix possible hang when issuing commands during ctrl removal

Pulled, thanks.

-- 
Jens Axboe
