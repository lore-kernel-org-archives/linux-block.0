Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43798 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750838AbdAXN3k (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 08:29:40 -0500
Subject: Re: [PATCH 07/10] blk-mq: move tags and sched_tags info from sysfs to
 debugfs
To: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
References: <cover.1485197480.git.osandov@fb.com>
 <89aae47362fe4563ed62951727a5b7de1000d69e.1485197480.git.osandov@fb.com>
Cc: kernel-team@fb.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <d1f5b346-5f36-f8c1-4ad1-5f803e58138e@suse.de>
Date: Tue, 24 Jan 2017 14:29:37 +0100
MIME-Version: 1.0
In-Reply-To: <89aae47362fe4563ed62951727a5b7de1000d69e.1485197480.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/23/2017 07:59 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> These are very tied to the blk-mq tag implementation, so exposing them
> to sysfs isn't a great idea. Move the debugging information to debugfs
> and add basic entries for the number of tags and the number of reserved
> tags to sysfs.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  block/blk-mq-debugfs.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  block/blk-mq-sysfs.c   | 33 ++++++++++++------------
>  block/blk-mq-tag.c     | 27 -------------------
>  block/blk-mq-tag.h     |  1 -
>  4 files changed, 86 insertions(+), 45 deletions(-)
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
