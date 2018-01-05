Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme fixes for Linux 4.15
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20180105171502.tacdqy5kh3knh4hg@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ef7ba239-5d28-9cf7-3212-1aab79a76cb0@kernel.dk>
Date: Fri, 5 Jan 2018 10:41:06 -0700
MIME-Version: 1.0
In-Reply-To: <20180105171502.tacdqy5kh3knh4hg@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/5/18 10:15 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> I have a few more small nvme fixes for you for Linux 4.15:
> 
> The following changes since commit 6d0e4827b72afc71349784336d5eb6df4df106e6:
> 
>   Revert "bdi: add error handle for bdi_debug_register" (2017-12-21 10:01:30 -0700)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.15

Looks fine to me, pulled.

4.16 is coming up, would be nice to get at least the preliminary nvme
stuff pulled in for that.

-- 
Jens Axboe
