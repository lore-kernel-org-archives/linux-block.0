Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44216 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753447AbdDEGhH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Apr 2017 02:37:07 -0400
Subject: Re: [PATCH 5/9] bio-integrity: fold bio_integrity_enabled to
 bio_integrity_prep
To: Dmitry Monakhov <dmonakhov@openvz.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
References: <1491332201-26926-1-git-send-email-dmonakhov@openvz.org>
 <1491332201-26926-6-git-send-email-dmonakhov@openvz.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <14063093-89ea-4a1e-957f-eb0dfa3a9cf3@suse.de>
Date: Wed, 5 Apr 2017 08:37:05 +0200
MIME-Version: 1.0
In-Reply-To: <1491332201-26926-6-git-send-email-dmonakhov@openvz.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/04/2017 08:56 PM, Dmitry Monakhov wrote:
> Currently all integrity prep hooks are open-coded, and if prepare fails
> we ignore it's code and fail bio with EIO. Let's return real error to
> upper layer, so later caller may react accordingly.
> 
> In fact no one want to use bio_integrity_prep() w/o bio_integrity_enabled,
> so it is reasonable to fold it in to one function.
> 
> Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
> ---
>  Documentation/block/data-integrity.txt |  3 --
>  block/bio-integrity.c                  | 88 ++++++++++++++++++----------------
>  block/blk-core.c                       |  5 +-
>  block/blk-mq.c                         |  8 +---
>  drivers/nvdimm/blk.c                   | 13 +----
>  drivers/nvdimm/btt.c                   | 13 +----
>  include/linux/bio.h                    |  6 ---
>  7 files changed, 55 insertions(+), 81 deletions(-)
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
