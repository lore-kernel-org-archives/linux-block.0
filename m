Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39014 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751272AbdHXMWv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2017 08:22:51 -0400
Subject: Re: [PATCH 1/4] loop: get rid of lo_blocksize
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Ming Lei <ming.lei@redhat.com>,
        Karel Zak <kzak@redhat.com>, Milan Broz <gmazyland@gmail.com>
References: <cover.1503558155.git.osandov@fb.com>
 <ef0f206cb2c75da3b850c59ea7b7efc0b94f4b32.1503558155.git.osandov@fb.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <d4e08c2c-0954-a8fd-e72d-db511df1cf45@suse.de>
Date: Thu, 24 Aug 2017 14:22:49 +0200
MIME-Version: 1.0
In-Reply-To: <ef0f206cb2c75da3b850c59ea7b7efc0b94f4b32.1503558155.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/24/2017 09:03 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This is only used for setting the soft block size on the struct
> block_device once and then never used again.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  drivers/block/loop.c | 10 ++--------
>  drivers/block/loop.h |  1 -
>  2 files changed, 2 insertions(+), 9 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
