Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45027 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753140AbdCFKZV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 Mar 2017 05:25:21 -0500
Subject: Re: [PATCH] zram: set physical queue limits to avoid array out of
 bounds accesses
To: Johannes Thumshirn <jthumshirn@suse.de>, Jens Axboe <axboe@fb.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
References: <20170306102335.9180-1-jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        yizhan@redhat.com,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <8386966d-8f97-5d6f-66b5-6a5131e9198f@suse.de>
Date: Mon, 6 Mar 2017 11:25:14 +0100
MIME-Version: 1.0
In-Reply-To: <20170306102335.9180-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 03/06/2017 11:23 AM, Johannes Thumshirn wrote:
> zram can handle at most SECTORS_PER_PAGE sectors in a bio's bvec. When using
> the NVMe over Fabrics loopback target which potentially sends a huge bulk of
> pages attached to the bio's bvec this results in a kernel panic because of
> array out of bounds accesses in zram_decompress_page().
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  drivers/block/zram/zram_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
