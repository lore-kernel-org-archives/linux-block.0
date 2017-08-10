Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:41550 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751709AbdHJL3G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2017 07:29:06 -0400
Date: Thu, 10 Aug 2017 04:29:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH v3 10/49] dm: limit the max bio size as BIO_MAX_PAGES *
 PAGE_SIZE
Message-ID: <20170810112900.GF20308@infradead.org>
References: <20170808084548.18963-1-ming.lei@redhat.com>
 <20170808084548.18963-11-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170808084548.18963-11-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> +	ti->max_io_len = min_t(uint32_t, len,
> +			       (BIO_MAX_PAGES * PAGE_SIZE));

No need for the inner braces.  Also all of the above fits nicely
onto a single < 80 char line.

Otherwise this looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
