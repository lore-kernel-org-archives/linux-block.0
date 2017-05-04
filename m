Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45633 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750758AbdEDLaC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 May 2017 07:30:02 -0400
Subject: Re: [PATCH v2 12/12] mq-deadline: add debugfs attributes
To: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
References: <cover.1493882751.git.osandov@fb.com>
 <8ece93631367ee691383605c057e048e0f9a78a2.1493882751.git.osandov@fb.com>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>, kernel-team@fb.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <30224062-c8fb-e5f2-922e-38be47dacd24@suse.de>
Date: Thu, 4 May 2017 13:29:58 +0200
MIME-Version: 1.0
In-Reply-To: <8ece93631367ee691383605c057e048e0f9a78a2.1493882751.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/04/2017 09:31 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Expose the fifo lists, cached next requests, batching state, and
> dispatch list. It'd also be possible to add the sorted lists, but there
> aren't already seq_file helpers for rbtrees.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  block/blk-mq-debugfs.c |   9 +++-
>  block/blk-mq-debugfs.h |   1 +
>  block/mq-deadline.c    | 123 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 131 insertions(+), 2 deletions(-)
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
