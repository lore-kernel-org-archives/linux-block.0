Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:55387 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbdJBNcU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Oct 2017 09:32:20 -0400
Date: Mon, 2 Oct 2017 06:32:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Cathy Avery <cavery@redhat.com>,
        Martin Steigerwald <martin@lichtvoll.de>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: Re: [PATCH V7 2/6] block: tracking request allocation with
 q_usage_counter
Message-ID: <20171002133219.GB19119@infradead.org>
References: <20170930061214.10622-1-ming.lei@redhat.com>
 <20170930061214.10622-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170930061214.10622-3-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

I think I already gate it to basically the same patch as queued
up by Bart, but here again:

Reviewed-by: Christoph Hellwig <hch@lst.de>
