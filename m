Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme updates for Linux 4.15
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20171110143407.zapukx3fhfcr4fm5@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e4ae08a2-4724-6ae5-6e64-7f42fb825bad@kernel.dk>
Date: Fri, 10 Nov 2017 08:18:06 -0700
MIME-Version: 1.0
In-Reply-To: <20171110143407.zapukx3fhfcr4fm5@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/10/2017 07:34 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> another round of NVMe updates for 4.15.
> 
> The biggest items are:
> 
>  - native multipath support (me + Hannes)
>  - userspace notifications for AENs (Keith)
>  - obey the command effects log page (Keith)
> 
> in addition to that lots of fixes from a wide variety of people.

Pulled. It had two conflicts with master, but both pretty trivial.

-- 
Jens Axboe
