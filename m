Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:33719 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933313AbdDFLvq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Apr 2017 07:51:46 -0400
Date: Thu, 6 Apr 2017 13:51:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] blk-mq-pci: Remove unneeded includes
Message-ID: <20170406115144.GA4786@lst.de>
References: <1491474816-15422-1-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491474816-15422-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Stephen added the first two includes after a linux-next build
failure.  Did this go through a long buildbot cycle to verify
it's really not needed anymore?

On Thu, Apr 06, 2017 at 01:33:36PM +0300, Sagi Grimberg wrote:
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  block/blk-mq-pci.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c
> index 0c3354cf3552..70b8a6765cc7 100644
> --- a/block/blk-mq-pci.c
> +++ b/block/blk-mq-pci.c
> @@ -10,12 +10,9 @@
>   * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>   * more details.
>   */
> -#include <linux/kobject.h>
> -#include <linux/blkdev.h>
>  #include <linux/blk-mq.h>
>  #include <linux/blk-mq-pci.h>
>  #include <linux/pci.h>
> -#include <linux/module.h>
>  
>  /**
>   * blk_mq_pci_map_queues - provide a default queue mapping for PCI device
> -- 
> 2.7.4
---end quoted text---
