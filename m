Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44005 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752944AbdDEGgC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Apr 2017 02:36:02 -0400
Subject: Re: [PATCH 4/9] bio-integrity: fix interface for bio_integrity_trim
 v2
To: Dmitry Monakhov <dmonakhov@openvz.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
References: <1491332201-26926-1-git-send-email-dmonakhov@openvz.org>
 <1491332201-26926-5-git-send-email-dmonakhov@openvz.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <aa53b744-e931-bb1f-11be-d130903ba4b4@suse.de>
Date: Wed, 5 Apr 2017 08:36:01 +0200
MIME-Version: 1.0
In-Reply-To: <1491332201-26926-5-git-send-email-dmonakhov@openvz.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/04/2017 08:56 PM, Dmitry Monakhov wrote:
> bio_integrity_trim inherent it's interface from bio_trim and accept
> offset and size, but this API is error prone because data offset
> must always be insync with bio's data offset. That is why we have
> integrity update hook in bio_advance()
> 
> So only meaningful values are: offset == 0, sectors == bio_sectors(bio)
> Let's just remove them completely.
> 
> changes from v1:
>  - remove 'sectors' arguments
> 
> Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
> ---
>  block/bio-integrity.c | 11 ++---------
>  block/bio.c           |  4 ++--
>  drivers/md/dm.c       |  2 +-
>  include/linux/bio.h   |  5 ++---
>  4 files changed, 7 insertions(+), 15 deletions(-)
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
