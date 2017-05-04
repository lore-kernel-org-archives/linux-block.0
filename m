Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44622 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752337AbdEDLTR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 May 2017 07:19:17 -0400
Subject: Re: [PATCH v2 01/12] blk-mq-debugfs: separate flags with |
To: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
References: <cover.1493882751.git.osandov@fb.com>
 <a93a27c6300f9a129b8d897bff289a19e4d59704.1493882751.git.osandov@fb.com>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>, kernel-team@fb.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <6503166d-ba56-1698-9d0c-62a8f0f78e2c@suse.de>
Date: Thu, 4 May 2017 13:19:15 +0200
MIME-Version: 1.0
In-Reply-To: <a93a27c6300f9a129b8d897bff289a19e4d59704.1493882751.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/04/2017 09:31 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This reads more naturally than spaces.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  block/blk-mq-debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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
