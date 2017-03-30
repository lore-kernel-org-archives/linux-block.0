Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40444 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754808AbdC3Fu0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2017 01:50:26 -0400
Subject: Re: [PATCH] blk-mq: Export queue state through
 /sys/kernel/debug/block/*/state
To: Bart Van Assche <Bart.VanAssche@sandisk.com>,
        Jens Axboe <axboe@fb.com>
References: <1D08B61A9CF0974AA09887BE32D889DA12B851@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Cc: Omar Sandoval <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <824697ce-3fe4-f7ab-e23b-237b280196fb@suse.de>
Date: Thu, 30 Mar 2017 07:50:23 +0200
MIME-Version: 1.0
In-Reply-To: <1D08B61A9CF0974AA09887BE32D889DA12B851@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 03/29/2017 10:20 PM, Bart Van Assche wrote:
> Make it possible to check whether or not a block layer queue has
> been stopped. Make it possible to run a blk-mq queue from user
> space.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
> ---
>  block/blk-mq-debugfs.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
About bloody time :-)

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
