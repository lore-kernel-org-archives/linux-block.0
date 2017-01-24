Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43693 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750916AbdAXN17 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 08:27:59 -0500
Subject: Re: [PATCH 05/10] sbitmap: add helpers for dumping to a seq_file
To: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
References: <cover.1485197480.git.osandov@fb.com>
 <6b27fe00b778210934d798880357ffc4dfea2086.1485197480.git.osandov@fb.com>
Cc: kernel-team@fb.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a70bd4fe-1995-4faa-8bd2-2ab381ac3715@suse.de>
Date: Tue, 24 Jan 2017 14:27:56 +0100
MIME-Version: 1.0
In-Reply-To: <6b27fe00b778210934d798880357ffc4dfea2086.1485197480.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/23/2017 07:59 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This is useful debugging information that will be used in the blk-mq
> debugfs directory.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  include/linux/sbitmap.h | 34 ++++++++++++++++++++
>  lib/sbitmap.c           | 83 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 117 insertions(+)
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
