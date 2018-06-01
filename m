Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme updates for 4.18
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20180601125045.GA27290@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <db0908f9-f746-1664-27f1-79e9580f9936@kernel.dk>
Date: Fri, 1 Jun 2018 07:45:43 -0600
MIME-Version: 1.0
In-Reply-To: <20180601125045.GA27290@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/1/18 6:50 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> below is another set of NVMe updates for 4.18.  Besides the usual bug fixes
> this includes more feature completness in terms of AEN and log page handling
> on the target.
> 
> The following changes since commit 5de815a7eedfacf593817ef34634eaa9b75a1482:
> 
>   block: remove parent device reference from struct bsg_class_device (2018-05-29 13:00:25 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.18

Pulled, thanks.

-- 
Jens Axboe
