Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme fixes for Linux 4.14-rc4
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20171005163654.walnk7642obfyjp6@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8f1e6bc2-f511-7209-bc28-3876ed806755@kernel.dk>
Date: Thu, 5 Oct 2017 10:45:12 -0600
MIME-Version: 1.0
In-Reply-To: <20171005163654.walnk7642obfyjp6@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/05/2017 10:36 AM, Christoph Hellwig wrote:
> A trivial one-liner from Martin to fix the visible of the uuid attr,
> and another one (originally from Abhishek Shah, rewritten by me) to
> fix the CMB addresses passed back to the controller in case of a system
> that remaps BAR addresses between host and device.
> 
> The following changes since commit a5f3d8a5eaaf917878f07998e6f1ea46024e6bab:
> 
>   bcache: use llist_for_each_entry_safe() in __closure_wake_up() (2017-09-27 14:54:49 -0600)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.14
> 
> for you to fetch changes up to 8969f1f8291762c13147c1ba89d46238af01675b:
> 
>   nvme-pci: Use PCI bus address for data/queues in CMB (2017-10-04 11:42:53 +0200)
> 
> ----------------------------------------------------------------
> Christoph Hellwig (1):
>       nvme-pci: Use PCI bus address for data/queues in CMB
> 
> Martin Wilck (1):
>       nvme: fix visibility of "uuid" ns attribute

Pulled, thanks.

-- 
Jens Axboe
