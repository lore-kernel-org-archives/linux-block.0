Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33673 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751062AbdHUF6y (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Aug 2017 01:58:54 -0400
Subject: Re: [PATCH v2 2/3] loop: use queue limit instead of private
 lo_logical_blocksize
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Ming Lei <ming.lei@redhat.com>,
        Karel Zak <kzak@redhat.com>
References: <cover.1503084216.git.osandov@fb.com>
 <561f8505816afb6d0dacd4697087141c95566225.1503084216.git.osandov@fb.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <645c909a-4f93-30d2-4d10-28b131b686df@suse.de>
Date: Mon, 21 Aug 2017 07:58:52 +0200
MIME-Version: 1.0
In-Reply-To: <561f8505816afb6d0dacd4697087141c95566225.1503084216.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/18/2017 09:27 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> There's no reason to track this separately; just use the
> logical_block_size queue limit.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  drivers/block/loop.c | 44 ++++++++++++++++++--------------------------
>  drivers/block/loop.h |  1 -
>  2 files changed, 18 insertions(+), 27 deletions(-)
> 

Curiously enough, this is what I attempted initially.
But that got shut down due to incompability.
In the hope that you'll succeed:

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
