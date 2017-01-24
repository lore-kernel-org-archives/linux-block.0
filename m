Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44122 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750826AbdAXNcM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 08:32:12 -0500
Subject: Re: [PATCH 10/10] blk-mq: move hctx and ctx counters from sysfs to
 debugfs
To: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
References: <cover.1485197480.git.osandov@fb.com>
 <594c3becb32cb126ea5b47ddd43745cf829c7a0d.1485197480.git.osandov@fb.com>
Cc: kernel-team@fb.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <c98be25e-c720-dcbb-7adc-38a0da4e2d3f@suse.de>
Date: Tue, 24 Jan 2017 14:32:10 +0100
MIME-Version: 1.0
In-Reply-To: <594c3becb32cb126ea5b47ddd43745cf829c7a0d.1485197480.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/23/2017 07:59 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> These counters aren't as out-of-place in sysfs as the other stuff, but
> debugfs is a slightly better home for them.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  block/blk-mq-debugfs.c | 181 +++++++++++++++++++++++++++++++++++++++++++++++++
>  block/blk-mq-sysfs.c   |  64 -----------------
>  2 files changed, 181 insertions(+), 64 deletions(-)
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
