Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:41055 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1166079AbdDXH2t (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Mon, 24 Apr 2017 03:28:49 -0400
Subject: Re: [PATCH v4 07/10] blk-mq: Make blk_flags_show() callers append a
 newline character
To: Bart Van Assche <bart.vanassche@sandisk.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20170421234026.18970-1-bart.vanassche@sandisk.com>
 <20170421234026.18970-8-bart.vanassche@sandisk.com>
Cc: linux-block@vger.kernel.org
From: Hannes Reinecke <hare@suse.com>
Message-ID: <77a8e219-f7f7-ef86-6a69-1c8c8cac3c65@suse.com>
Date: Mon, 24 Apr 2017 09:28:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170421234026.18970-8-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/22/2017 01:40 AM, Bart Van Assche wrote:
> This patch does not change any functionality but makes it possible
> to produce a single line of output with multiple flag-to-name
> translations.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Reviewed-by: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
> ---
>  block/blk-mq-debugfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
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
