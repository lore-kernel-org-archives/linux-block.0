Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:56191 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751784AbdGESBs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jul 2017 14:01:48 -0400
Date: Wed, 5 Jul 2017 11:01:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] mtip32xx: avoid to read HOST_CAP from HW in .queue_rq()
Message-ID: <20170705180146.GA7059@infradead.org>
References: <20170705041427.9887-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170705041427.9887-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

mmio reads in the fast path are always a bad idea..

Reviewed-by: Christoph Hellwig <hch@lst.de>
