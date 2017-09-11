Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme fixes for 4.14
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20170911154601.GA32239@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d2176987-a16f-7a83-d891-9d67b141f599@kernel.dk>
Date: Mon, 11 Sep 2017 09:54:35 -0600
MIME-Version: 1.0
In-Reply-To: <20170911154601.GA32239@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/11/2017 09:46 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> below are a few small fixes for the current merge window:
> 
>  - fix string.h compilation failures with the new memcpy_and_pad
>    helper (Martin Wilck)
>  - fix incorrect dereference of a PCI data structure in the lightnvm
>    support code (me)
>  - HMB fixes (Akinobu Mita and me)
> 
> The following changes since commit 40a5fce495715c48c2e02668144e68a507ac5a30:
> 
>   nvme-fabrics: generate spec-compliant UUID NQNs (2017-09-01 09:48:01 +0200)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.14
> 
> for you to fetch changes up to 47256a9529757b56f6ffca09c9fcf778ce61f0f5:
> 
>   string.h: un-fortify memcpy_and_pad (2017-09-11 13:56:09 +0200)

This is throwing rejects against current master, in pci.c. Can you base it
on the current master tree?

-- 
Jens Axboe
