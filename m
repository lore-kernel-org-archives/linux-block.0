Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] skd: use pci_alloc_irq_vectors
To: Christoph Hellwig <hch@lst.de>
References: <1478546047-12777-1-git-send-email-hch@lst.de>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a5d1245f-a6f9-6f0a-e0bf-64365f47909c@kernel.dk>
Date: Mon, 7 Nov 2016 21:38:24 -0700
MIME-Version: 1.0
In-Reply-To: <1478546047-12777-1-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/07/2016 12:14 PM, Christoph Hellwig wrote:
> Switch the skd driver to use pci_alloc_irq_vectors.  We need to two calls to
> pci_alloc_irq_vectors as skd only supports multiple MSI-X vectors, but not
> multiple MSI vectors.
>
> Otherwise this cleans up a lot of cruft and allows to a lot more common code.

Nice cleanup, added for 4.10.

-- 
Jens Axboe
