Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34616 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751746AbdJDIy3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Oct 2017 04:54:29 -0400
Date: Wed, 4 Oct 2017 10:54:28 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Benjamin Block <bblock@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/9] libfc: don't assign resid_len in fc_lport_bsg_request
Message-ID: <20171004085428.vvbrwcphe5cpsvwf@linux-x5ow.site>
References: <20171003104845.10417-1-hch@lst.de>
 <20171003104845.10417-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20171003104845.10417-4-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
