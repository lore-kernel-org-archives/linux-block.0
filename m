Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44057 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750834AbdAXNbT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 08:31:19 -0500
Subject: Re: [PATCH 09/10] blk-mq: move hctx io_poll, stats, and dispatched
 from sysfs to debugfs
To: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
References: <cover.1485197480.git.osandov@fb.com>
 <5ba845d8d2921d385b05fb6b83568eb5568764ce.1485197480.git.osandov@fb.com>
Cc: kernel-team@fb.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <7522c663-23db-c0d5-0356-32816e7acf1e@suse.de>
Date: Tue, 24 Jan 2017 14:31:16 +0100
MIME-Version: 1.0
In-Reply-To: <5ba845d8d2921d385b05fb6b83568eb5568764ce.1485197480.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/23/2017 07:59 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> These statistics _might_ be useful to userspace, but it's better not to
> commit to an ABI for these yet. Also, the dispatched file in sysfs
> couldn't be cleared, so make it clearable like the others in debugfs.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  block/blk-mq-debugfs.c | 132 +++++++++++++++++++++++++++++++++++++++++++++++++
>  block/blk-mq-sysfs.c   |  92 ----------------------------------
>  2 files changed, 132 insertions(+), 92 deletions(-)
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
