Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47325 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750755AbdFFG1X (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Jun 2017 02:27:23 -0400
Subject: Re: [PATCH 1/6] libata: move ata_read_log_page to libata-core.c
To: Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>
Cc: Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Rafael Antognolli <rafael.antognolli@intel.com>,
        Robert Elliott <elliott@hpe.com>, linux-ide@vger.kernel.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20170604124225.27032-1-hch@lst.de>
 <20170604124225.27032-2-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <7bda2948-1e81-da25-9fef-9b5519dc8545@suse.de>
Date: Tue, 6 Jun 2017 08:27:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170604124225.27032-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/04/2017 02:42 PM, Christoph Hellwig wrote:
> It is core functionality, and only one of the users is in the EH code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/ata/libata-core.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/ata/libata-eh.c   | 64 -----------------------------------------------
>  drivers/ata/libata.h      |  4 +--
>  3 files changed, 66 insertions(+), 66 deletions(-)
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
