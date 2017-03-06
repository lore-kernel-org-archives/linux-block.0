Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36249 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753186AbdCFKp0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Mar 2017 05:45:26 -0500
Date: Mon, 6 Mar 2017 19:45:42 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@fb.com>, Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Hannes Reinecke <hare@suse.de>, yizhan@redhat.com,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zram: set physical queue limits to avoid array out of
 bounds accesses
Message-ID: <20170306104542.GA366@jagdpanzerIV.localdomain>
References: <20170306102335.9180-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170306102335.9180-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On (03/06/17 11:23), Johannes Thumshirn wrote:
> zram can handle at most SECTORS_PER_PAGE sectors in a bio's bvec. When using
> the NVMe over Fabrics loopback target which potentially sends a huge bulk of
> pages attached to the bio's bvec this results in a kernel panic because of
> array out of bounds accesses in zram_decompress_page().
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Cc Andrew
Link: lkml.kernel.org/r/20170306102335.9180-1-jthumshirn@suse.de


Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

thanks!

	-ss
