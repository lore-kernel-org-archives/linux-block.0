Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45191 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751913AbdEDLZu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 May 2017 07:25:50 -0400
Subject: Re: [PATCH v2 07/12] blk-mq: Do not invoke queue operations on a dead
 queue
To: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
References: <cover.1493882751.git.osandov@fb.com>
 <71712db1ecbe0432055c4976314a57485fff7f18.1493882751.git.osandov@fb.com>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>, kernel-team@fb.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <e6bb2a84-9fff-4fba-0ee5-e56b655f1668@suse.de>
Date: Thu, 4 May 2017 13:25:48 +0200
MIME-Version: 1.0
In-Reply-To: <71712db1ecbe0432055c4976314a57485fff7f18.1493882751.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/04/2017 09:31 AM, Omar Sandoval wrote:
> From: Bart Van Assche <bart.vanassche@sandisk.com>
> 
> In commit e869b5462f83 ("blk-mq: Unregister debugfs attributes
> earlier"), we shuffled the debugfs cleanup around so that the "state"
> attribute was removed before we freed the blk-mq data structures.
> However, later changes are going to undo that, so we need to explicitly
> disallow running a dead queue.
> 
> [Omar: rebased and updated commit message]
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> ---
>  block/blk-mq-debugfs.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
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
