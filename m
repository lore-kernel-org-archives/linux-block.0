Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43705 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750767AbdEBGO2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 May 2017 02:14:28 -0400
Subject: Re: [PATCH 5/7] mtip32xx: convert internal command issue to block IO
 path
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
References: <1493391340-24629-1-git-send-email-axboe@fb.com>
 <1493391340-24629-6-git-send-email-axboe@fb.com>
Cc: ming.lei@redhat.com, hch@lst.de
From: Hannes Reinecke <hare@suse.de>
Message-ID: <e17116c3-c48e-8411-7879-840aa0ee6b69@suse.de>
Date: Tue, 2 May 2017 08:14:27 +0200
MIME-Version: 1.0
In-Reply-To: <1493391340-24629-6-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/28/2017 04:55 PM, Jens Axboe wrote:
> The driver special cases certain things for command issue, depending
> on whether it's an internal command or not. Make the internal commands
> use the regular infrastructure for issuing IO.
> 
> Since this is an 8-group souped up AHCI variant, we have to deal
> with NCQ vs non-queueable commands. Do this from the queue_rq
> handler, by backing off unless the drive is idle.
> 
> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---
>  drivers/block/mtip32xx/mtip32xx.c | 106 +++++++++++++++++++++++++++-----------
>  1 file changed, 76 insertions(+), 30 deletions(-)
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
