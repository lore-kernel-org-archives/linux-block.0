Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51367 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751007AbdBOIAs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Feb 2017 03:00:48 -0500
Subject: Re: [PATCH 2/6] sd: improve TUR handling in sd_check_events
To: Christoph Hellwig <hch@lst.de>, axboe@kernek.dk
References: <20170214191600.17480-1-hch@lst.de>
 <20170214191600.17480-3-hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
From: Hannes Reinecke <hare@suse.de>
Message-ID: <235244db-9821-b6b8-7926-e937a06d25d6@suse.de>
Date: Wed, 15 Feb 2017 09:00:45 +0100
MIME-Version: 1.0
In-Reply-To: <20170214191600.17480-3-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/14/2017 08:15 PM, Christoph Hellwig wrote:
> Remove bogus evaluations of retval and sshdr when the device is offline,
> and fix a possible NULL pointer dereference by allocating the 8 byte
> sized sense header on stack.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/scsi/sd.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
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
