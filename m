Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43597 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750767AbdEBGMz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 May 2017 02:12:55 -0400
Subject: Re: [PATCH 4/7] blk-mq: add and export helper to tell if a request is
 reserved
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
References: <1493391340-24629-1-git-send-email-axboe@fb.com>
 <1493391340-24629-5-git-send-email-axboe@fb.com>
Cc: ming.lei@redhat.com, hch@lst.de
From: Hannes Reinecke <hare@suse.de>
Message-ID: <e14def6c-3b7e-257e-a462-161505d21c9a@suse.de>
Date: Tue, 2 May 2017 08:12:53 +0200
MIME-Version: 1.0
In-Reply-To: <1493391340-24629-5-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/28/2017 04:55 PM, Jens Axboe wrote:
> We only have an internal helper for checking a tag value. Add
> an exported helper that takes a request and hardware queue,
> and check against the driver tags.
> 
> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---
>  block/blk-mq-tag.c     | 6 ++++++
>  include/linux/blk-mq.h | 1 +
>  2 files changed, 7 insertions(+)
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
