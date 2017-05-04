Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45153 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751905AbdEDLZW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 May 2017 07:25:22 -0400
Subject: Re: [PATCH v2 06/12] blk-mq-debugfs: get rid of a bunch of
 boilerplate
To: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
References: <cover.1493882751.git.osandov@fb.com>
 <fe05c2e075a1f02a952760f38a3854942f38478f.1493882751.git.osandov@fb.com>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>, kernel-team@fb.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <ec28179d-5a0b-3e64-f705-264bf304f561@suse.de>
Date: Thu, 4 May 2017 13:25:20 +0200
MIME-Version: 1.0
In-Reply-To: <fe05c2e075a1f02a952760f38a3854942f38478f.1493882751.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/04/2017 09:31 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> A large part of blk-mq-debugfs.c is file_operations and seq_file
> boilerplate. This sucks as is but will suck even more when schedulers
> can define their own debugfs entries. Factor it all out into a single
> blk_mq_debugfs_fops which multiplexes as needed. We store the
> request_queue, blk_mq_hw_ctx, or blk_mq_ctx in the parent directory
> dentry, which is kind of hacky, but it works.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  block/blk-mq-debugfs.c | 464 +++++++++++++++----------------------------------
>  1 file changed, 136 insertions(+), 328 deletions(-)
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
