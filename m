Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44747 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750758AbdEDLUr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 May 2017 07:20:47 -0400
Subject: Re: [PATCH v2 02/12] blk-mq-debugfs: clean up flag definitions
To: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
References: <cover.1493882751.git.osandov@fb.com>
 <a7ef9bfaa9756e211fa480d84c7f832a8f8c1d4f.1493882751.git.osandov@fb.com>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>, kernel-team@fb.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <8958af23-1b93-fd6c-a229-5b4e50cdfd9c@suse.de>
Date: Thu, 4 May 2017 13:20:43 +0200
MIME-Version: 1.0
In-Reply-To: <a7ef9bfaa9756e211fa480d84c7f832a8f8c1d4f.1493882751.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/04/2017 09:31 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Make sure the spelled out flag names match the definition. This also
> adds a missing hctx state, BLK_MQ_S_START_ON_RUN, and a missing
> cmd_flag, __REQ_NOUNMAP.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  block/blk-mq-debugfs.c | 201 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 108 insertions(+), 93 deletions(-)
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
