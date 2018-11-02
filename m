Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme fixes for 4.20
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20181102063742.GA16758@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <30db0ba7-8df4-fa51-6477-1360c3d843a6@kernel.dk>
Date: Fri, 2 Nov 2018 08:15:23 -0600
MIME-Version: 1.0
In-Reply-To: <20181102063742.GA16758@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/2/18 12:37 AM, Christoph Hellwig wrote:
> The following changes since commit a5185607787e030fcb0009194d3b12f8bcca59d6:
> 
>   block: brd: associate with queue until adding disk (2018-10-31 08:43:09 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.20
> 
> for you to fetch changes up to ae172db3b3f389c363ec7f3683b2cad41091580d:
> 
>   nvme-pci: fix conflicting p2p resource adds (2018-11-01 08:44:47 +0200)
> 
> ----------------------------------------------------------------
> James Smart (1):
>       nvme-fc: fix request private initialization
> 
> Keith Busch (1):
>       nvme-pci: fix conflicting p2p resource adds
> 
>  drivers/nvme/host/fc.c  | 2 +-
>  drivers/nvme/host/pci.c | 5 ++++-
>  2 files changed, 5 insertions(+), 2 deletions(-)

Applied these manually, since I had rebased for-linus yesterday to drop
a buggy patch from Ming. JFYI.

-- 
Jens Axboe
