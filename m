Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43099 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750816AbdAXNVm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 08:21:42 -0500
Subject: Re: [PATCH 15/16] block: split scsi_request out of struct request
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>
References: <1485185361-29786-1-git-send-email-hch@lst.de>
 <1485185361-29786-16-git-send-email-hch@lst.de>
Cc: Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <4a5c941f-5fc2-bb9d-b22f-8fc3bede3ae9@suse.de>
Date: Tue, 24 Jan 2017 14:21:39 +0100
MIME-Version: 1.0
In-Reply-To: <1485185361-29786-16-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/23/2017 04:29 PM, Christoph Hellwig wrote:
> And require all drivers that want to support BLOCK_PC to allocate it
> as the first thing of their private data.  To support this the legacy
> IDE and BSG code is switched to set cmd_size on their queues to let
> the block layer allocate the additional space.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
