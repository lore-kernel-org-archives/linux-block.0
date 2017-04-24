Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:50559 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1166155AbdDXH1n (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Mon, 24 Apr 2017 03:27:43 -0400
Subject: Re: [PATCH v4 05/10] blk-mq: Unregister debugfs attributes earlier
To: Bart Van Assche <bart.vanassche@sandisk.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20170421234026.18970-1-bart.vanassche@sandisk.com>
 <20170421234026.18970-6-bart.vanassche@sandisk.com>
Cc: linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
From: Hannes Reinecke <hare@suse.com>
Message-ID: <22228381-33a3-b381-a3e0-4ba3ce889b6b@suse.com>
Date: Mon, 24 Apr 2017 09:27:41 +0200
MIME-Version: 1.0
In-Reply-To: <20170421234026.18970-6-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/22/2017 01:40 AM, Bart Van Assche wrote:
> One of the debugfs attributes allows to run a queue. Since running
> a queue after a queue has entered the "dead" state is not allowed
> and even can cause a kernel crash, unregister the debugfs attributes
> before a queue reaches the "dead" state.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
> ---
>  block/blk-core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
