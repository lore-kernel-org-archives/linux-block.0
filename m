Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39185 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751561AbdHXMZf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2017 08:25:35 -0400
Subject: Re: [PATCH 4/4] loop: fold loop_switch() into callers
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Ming Lei <ming.lei@redhat.com>,
        Karel Zak <kzak@redhat.com>, Milan Broz <gmazyland@gmail.com>
References: <cover.1503558155.git.osandov@fb.com>
 <1f86996dec0b19370c4be16e0ec6399f6c8eeb5a.1503558155.git.osandov@fb.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a07e24eb-7b09-c4d7-6176-1f1820398c56@suse.de>
Date: Thu, 24 Aug 2017 14:25:33 +0200
MIME-Version: 1.0
In-Reply-To: <1f86996dec0b19370c4be16e0ec6399f6c8eeb5a.1503558155.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/24/2017 09:03 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> The comments here are really outdated, and blk-mq made flushing much
> simpler, so just fold the two cases into the callers.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  drivers/block/loop.c | 76 ++++++++--------------------------------------------
>  1 file changed, 11 insertions(+), 65 deletions(-)
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
