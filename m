Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 11/11] nvme-fabrics: pass non-blocking flag to connect
 request allocation
To: Christoph Hellwig <hch@lst.de>, keith.busch@intel.com, axboe@kernel.dk
References: <1465389066-19119-1-git-send-email-hch@lst.de>
 <1465389066-19119-12-git-send-email-hch@lst.de>
Cc: linux-block@vger.kernel.org, ming.l@ssi.samsung.com,
 linux-nvme@lists.infradead.org, sagi@lightbits.io
From: Sagi Grimberg <sagigrim@gmail.com>
Message-ID: <575823DD.8080000@gmail.com>
Date: Wed, 8 Jun 2016 16:55:41 +0300
MIME-Version: 1.0
In-Reply-To: <1465389066-19119-12-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

Looks fine,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Would be nice to reduce the number of arguments
passed to __nvme_submit_sync_cmd() at some point..
