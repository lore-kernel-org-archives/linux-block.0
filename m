Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45512 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751272AbdEDL2u (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 May 2017 07:28:50 -0400
Subject: Re: [PATCH v2 10/12] blk-mq-debugfs: allow schedulers to register
 debugfs attributes
To: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
References: <cover.1493882751.git.osandov@fb.com>
 <006e6393f62e9ac84d7ee76634b80cb4fe49b66e.1493882751.git.osandov@fb.com>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>, kernel-team@fb.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <83a92ac6-aa6e-6720-c4eb-7507dc96e921@suse.de>
Date: Thu, 4 May 2017 13:28:47 +0200
MIME-Version: 1.0
In-Reply-To: <006e6393f62e9ac84d7ee76634b80cb4fe49b66e.1493882751.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/04/2017 09:31 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This provides the infrastructure for schedulers to expose their internal
> state through debugfs. We add a list of queue attributes and a list of
> hctx attributes to struct elevator_type and wire them up when switching
> schedulers.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  block/blk-mq-debugfs.c   | 74 ++++++++++++++++++++++++++++++++++++++++++------
>  block/blk-mq-debugfs.h   | 34 ++++++++++++++++++++++
>  block/blk-mq-sched.c     | 24 ++++++++++------
>  include/linux/blk-mq.h   |  1 +
>  include/linux/blkdev.h   |  1 +
>  include/linux/elevator.h |  7 +++++
>  6 files changed, 124 insertions(+), 17 deletions(-)
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
