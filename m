Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:51922 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751208AbdL2J6e (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Dec 2017 04:58:34 -0500
Date: Fri, 29 Dec 2017 10:58:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yi Zhang <yi.zhang@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH V2 2/6] blk-mq: support concurrent
        blk_mq_quiesce_queue()
Message-ID: <20171229095833.GB24507@lst.de>
References: <20171214023103.18272-1-ming.lei@redhat.com> <20171214023103.18272-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171214023103.18272-3-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The quiesce count looks good to me.  But I'm really worried about
the force unquiesce in nvme.  I'd feel much better if we could find
a way to move this into the core.
