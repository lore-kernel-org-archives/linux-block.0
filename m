Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59349 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767AbcGMFmt (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Wed, 13 Jul 2016 01:42:49 -0400
Subject: Re: [PATCH] block: Fix front merge check
To: Damien Le Moal <damien.lemoal@hgst.com>,
	linux-block@vger.kernel.org, axboe@fb.com, hch@lst.de
References: <1468387413-2754-1-git-send-email-damien.lemoal@hgst.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <19a4051a-a804-8fb1-746d-a4bccdb31cee@suse.de>
Date: Wed, 13 Jul 2016 07:42:12 +0200
MIME-Version: 1.0
In-Reply-To: <1468387413-2754-1-git-send-email-damien.lemoal@hgst.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 07/13/2016 07:23 AM, Damien Le Moal wrote:
> For a front merge, the maximum number of sectors of the
> request must be checked against the front merge BIO sector,
> not the current sector of the request.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@hgst.com>
> ---
>  block/blk-merge.c      | 6 +++---
>  include/linux/blkdev.h | 5 +++--
>  2 files changed, 6 insertions(+), 5 deletions(-)
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
