Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44812 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751991AbdEDLVk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 May 2017 07:21:40 -0400
Subject: Re: [PATCH v2 03/12] blk-mq-debugfs: error on long write to queue
 "state" file
To: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
References: <cover.1493882751.git.osandov@fb.com>
 <859ef1939e07171f902b4fbb5bebbb274d68df18.1493882751.git.osandov@fb.com>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>, kernel-team@fb.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <6eac857d-a8e1-09cb-4705-76f6632b6e39@suse.de>
Date: Thu, 4 May 2017 13:21:38 +0200
MIME-Version: 1.0
In-Reply-To: <859ef1939e07171f902b4fbb5bebbb274d68df18.1493882751.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/04/2017 09:31 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> blk_queue_flags_store() currently truncates and returns a short write if
> the operation being written is too long. This can give us weird results,
> like here:
> 
> $ echo "run            bar"
> echo: write error: invalid argument
> $ dmesg
> [ 1103.075435] blk_queue_flags_store: unsupported operation bar. Use either 'run' or 'start'
> 
> Instead, return an error if the user does this. While we're here, make
> the argument names consistent with everywhere else in this file.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  block/blk-mq-debugfs.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
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
