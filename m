Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:47942 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750945AbdJDG6p (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Oct 2017 02:58:45 -0400
Date: Wed, 4 Oct 2017 08:58:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        =Oleksandr Natalenko <oleksandr@natalenko.name>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v5 5/8] block: Add the QUEUE_FLAG_PREEMPT_ONLY request
        queue flag
Message-ID: <20171004065844.GC20879@lst.de>
References: <20171002225218.18548-1-bart.vanassche@wdc.com> <20171002225218.18548-6-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171002225218.18548-6-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> +EXPORT_SYMBOL(blk_set_preempt_only);

EXPORT_SYMBOL_GPL please.

Except for that this looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
