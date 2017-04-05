Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44423 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753776AbdDEGjJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Apr 2017 02:39:09 -0400
Subject: Re: [PATCH 7/9] Guard bvec iteration logic v3
To: Dmitry Monakhov <dmonakhov@openvz.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
References: <1491332201-26926-1-git-send-email-dmonakhov@openvz.org>
 <1491332201-26926-8-git-send-email-dmonakhov@openvz.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <074ed7cb-fbe1-688a-3ab8-25dc74c784d4@suse.de>
Date: Wed, 5 Apr 2017 08:39:07 +0200
MIME-Version: 1.0
In-Reply-To: <1491332201-26926-8-git-send-email-dmonakhov@openvz.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/04/2017 08:56 PM, Dmitry Monakhov wrote:
> Currently if some one try to advance bvec beyond it's size we simply
> dump WARN_ONCE and continue to iterate beyond bvec array boundaries.
> This simply means that we endup dereferencing/corrupting random memory
> region.
> 
> Sane reaction would be to propagate error back to calling context
> But bvec_iter_advance's calling context is not always good for error
> handling. For safity reason let truncate iterator size to zero which
> will break external iteration loop which prevent us from unpredictable
> memory range corruption. And even it caller ignores an error, it will
> corrupt it's own bvecs, not others.
> 
> This patch does:
> - Return error back to caller with hope that it will react on this
> - Truncate iterator size
> 
> Code was added long time ago here 4550dd6c, luckily no one hit it
> in real life :)
> 
> changes since V1:
>  - Replace  BUG_ON with error logic.
> 
> Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
> ---
>  drivers/nvdimm/blk.c |  4 +++-
>  drivers/nvdimm/btt.c |  4 +++-
>  include/linux/bio.h  |  8 ++++++--
>  include/linux/bvec.h | 11 ++++++++---
>  4 files changed, 20 insertions(+), 7 deletions(-)
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
