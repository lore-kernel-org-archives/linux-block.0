Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33949 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751755AbdJDIwi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Oct 2017 04:52:38 -0400
Date: Wed, 4 Oct 2017 10:52:36 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Benjamin Block <bblock@linux.vnet.ibm.com>
Subject: Re: [PATCH 9/9] bsg: split handling of SCSI CDBs vs transport
 requeues
Message-ID: <20171004085236.bz7x4gb5g3b3sbpt@linux-x5ow.site>
References: <20171003104845.10417-1-hch@lst.de>
 <20171003104845.10417-10-hch@lst.de>
 <mqd7ewbidos.fsf@linux-x5ow.site>
 <20171004072059.GA21411@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20171004072059.GA21411@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Oct 04, 2017 at 09:20:59AM +0200, Christoph Hellwig wrote:
> It's a different level of callback - ops are the type of request
> passed through (scsi vs transport) and ->release is s whacky
> implementation detail of the SAS passthrough.  If at all ->release
> should go away eventually by cleaning that mess up.

OK then,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
