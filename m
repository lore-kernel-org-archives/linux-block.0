Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35442 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754576AbeALKrD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Jan 2018 05:47:03 -0500
Date: Fri, 12 Jan 2018 11:47:01 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] blk-mq: support physical CPU hotplug
Message-ID: <20180112104701.4nxixn4nru4f7uib@linux-x5ow.site>
References: <20180112025306.28004-1-ming.lei@redhat.com>
 <64c62449-27d2-a0a1-c7db-d2d08a3eb893@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <64c62449-27d2-a0a1-c7db-d2d08a3eb893@de.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jan 12, 2018 at 09:12:24AM +0100, Christian Borntraeger wrote:
> I think we also need cc stable for this. The bug was introduced with 
>  
> commit 4b855ad37194f7bdbb200ce7a1c7051fecb56a08 upstream.
> ("blk-mq: Create hctx for each present CPU")
> 
> and that was even backported into 4.12 stable.

Yes, and Ming (or Jens?), can you please add a Fixes tag as well? It helps
with identifying patches which fix backports.

Thanks,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
