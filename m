Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:51498 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbdHJLcN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2017 07:32:13 -0400
Date: Thu, 10 Aug 2017 04:32:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 17/49] block: comments on bio_for_each_segment[_all]
Message-ID: <20170810113210.GH20308@infradead.org>
References: <20170808084548.18963-1-ming.lei@redhat.com>
 <20170808084548.18963-18-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170808084548.18963-18-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The comments should be added in the patches where semantics change,
not separately.
