Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41230 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750753AbdAXM5N (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 07:57:13 -0500
Subject: Re: [PATCH 13/16] scsi: allocate scsi_cmnd structures as part of
 struct request
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>
References: <1485185361-29786-1-git-send-email-hch@lst.de>
 <1485185361-29786-14-git-send-email-hch@lst.de>
Cc: Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <76d411db-299d-9b8f-ec83-e4867da4cdc8@suse.de>
Date: Tue, 24 Jan 2017 13:57:09 +0100
MIME-Version: 1.0
In-Reply-To: <1485185361-29786-14-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/23/2017 04:29 PM, Christoph Hellwig wrote:
> Rely on the new block layer functionality to allocate additional driver
> specific data behind struct request instead of implementing it in SCSI
> itѕelf.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/scsi/hosts.c      |  20 +--
>  drivers/scsi/scsi.c       | 319 ----------------------------------------------
>  drivers/scsi/scsi_error.c |  17 ++-
>  drivers/scsi/scsi_lib.c   | 122 ++++++++++++------
>  drivers/scsi/scsi_priv.h  |   8 +-
>  include/scsi/scsi_host.h  |   3 -
>  6 files changed, 95 insertions(+), 394 deletions(-)
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
