Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45554 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750758AbdEDL3d (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 May 2017 07:29:33 -0400
Subject: Re: [PATCH v2 11/12] kyber: add debugfs attributes
To: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
References: <cover.1493882751.git.osandov@fb.com>
 <13ff6ed57d5acc649cb34415596bfd75c96471eb.1493882751.git.osandov@fb.com>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>, kernel-team@fb.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <34a2bd6e-355e-6dd5-11d8-8473f9bf0c5f@suse.de>
Date: Thu, 4 May 2017 13:29:31 +0200
MIME-Version: 1.0
In-Reply-To: <13ff6ed57d5acc649cb34415596bfd75c96471eb.1493882751.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/04/2017 09:31 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Expose the domain token pools, asynchronous sbitmap depth, domain
> request lists, and batching state.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  block/blk-mq-debugfs.c |   3 +-
>  block/blk-mq-debugfs.h |   2 +
>  block/kyber-iosched.c  | 130 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 134 insertions(+), 1 deletion(-)
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
