Return-Path: <mchristi@redhat.com>
Subject: Re: [PATCH 2/3] block: simplify and cleanup bvec pool handling
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
References: <1465829315-23137-1-git-send-email-hch@lst.de>
 <1465829315-23137-3-git-send-email-hch@lst.de>
Cc: linux-block@vger.kernel.org
From: Mike Christie <mchristi@redhat.com>
Message-ID: <2e78bda0-0b38-55bf-7d12-363e212bf76f@redhat.com>
Date: Mon, 20 Jun 2016 19:36:55 -0500
MIME-Version: 1.0
In-Reply-To: <1465829315-23137-3-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 06/13/2016 09:48 AM, Christoph Hellwig wrote:
> Instead of a flag and an index just make sure an index of 0 means
> no need to free the bvec array.  Also move the constants related
> to the bvec pools together and use a consistent naming scheme for
> them.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Mike Christie <mchristi@redhat.com>
