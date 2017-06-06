Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47501 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750755AbdFFGa5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Jun 2017 02:30:57 -0400
Subject: Re: [PATCH 5/6] libata: implement SECURITY PROTOCOL IN/OUT
To: Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>
Cc: Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Rafael Antognolli <rafael.antognolli@intel.com>,
        Robert Elliott <elliott@hpe.com>, linux-ide@vger.kernel.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20170604124225.27032-1-hch@lst.de>
 <20170604124225.27032-6-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <72baa72f-92f1-977a-7854-692c21f949b3@suse.de>
Date: Tue, 6 Jun 2017 08:30:50 +0200
MIME-Version: 1.0
In-Reply-To: <20170604124225.27032-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/04/2017 02:42 PM, Christoph Hellwig wrote:
> This allows us to use the generic OPAL code with ATA devices.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/ata/libata-core.c | 32 ++++++++++++++++++++
>  drivers/ata/libata-scsi.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/ata.h       |  1 +
>  include/linux/libata.h    |  1 +
>  4 files changed, 110 insertions(+)
> Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
