Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:45086 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934277AbdCWOHp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Mar 2017 10:07:45 -0400
Date: Thu, 23 Mar 2017 07:07:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jens Axboe <axboe@fb.com>, Ming Lei <tom.leiming@gmail.com>,
        Mike Christie <mchristi@redhat.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hannes Reinecke <hare@suse.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] block: make nr_iovecs unsigned in bio_alloc_bioset()
Message-ID: <20170323140721.GA8416@infradead.org>
References: <20170323102455.GA20154@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170323102455.GA20154@mwanda>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
