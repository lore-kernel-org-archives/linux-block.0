Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54704 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966972AbdEXHwN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2017 03:52:13 -0400
Subject: Re: [PATCH 08/31] sd, sr: Convert two assignments into warning
 statements
To: Bart Van Assche <bart.vanassche@sandisk.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>
References: <20170524003420.5381-1-bart.vanassche@sandisk.com>
 <20170524003420.5381-9-bart.vanassche@sandisk.com>
From: Johannes Thumshirn <jthumshirn@suse.de>
Message-ID: <7452f775-f802-8454-d929-b2953ee7955b@suse.de>
Date: Wed, 24 May 2017 09:52:11 +0200
MIME-Version: 1.0
In-Reply-To: <20170524003420.5381-9-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/24/2017 02:33 AM, Bart Van Assche wrote:
> Before scsi_prep_fn() calls the ULP .init_command() callback
> function it stores the SCSI command pointer in request.special.
> This means that the SCpnt = rq->special assignments in the sd
> and sr drivers assign a pointer to itself. Hence convert these
> two assignment statements into warning statements.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> ---

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
