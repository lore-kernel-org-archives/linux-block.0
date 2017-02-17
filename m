Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37965 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754564AbdBQJOi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2017 04:14:38 -0500
Subject: Re: [PATCH 2/2] block/sed-opal: allocate struct opal_dev dynamically
To: Christoph Hellwig <hch@lst.de>
References: <20170216201053.1190-1-hch@lst.de>
 <20170216201053.1190-2-hch@lst.de>
 <10ec775b-cbdc-7cac-336b-015d97c486de@suse.de>
 <20170217091139.GA19393@lst.de>
Cc: scott.bauer@intel.com, keith.busch@intel.com,
        jonathan.derrick@intel.com, axboe@fb.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
From: Johannes Thumshirn <jthumshirn@suse.de>
Message-ID: <88777e26-532a-4445-5258-7cf22ff771d7@suse.de>
Date: Fri, 17 Feb 2017 10:14:36 +0100
MIME-Version: 1.0
In-Reply-To: <20170217091139.GA19393@lst.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/17/2017 10:11 AM, Christoph Hellwig wrote:
> I just moved the existing definition around 1:1.

Just saw it's - anyways. So sorry for the noise and I'll grab another coffee

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
