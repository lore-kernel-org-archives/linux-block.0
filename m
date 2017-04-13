Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:22699 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752106AbdDMQWZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2017 12:22:25 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "jth@kernel.org" <jth@kernel.org>
Subject: Re: [PATCH] block: fix bio_will_gap()
Date: Thu, 13 Apr 2017 16:22:22 +0000
Message-ID: <1492100540.5176.6.camel@sandisk.com>
References: <20170413160626.14635-1-ming.lei@redhat.com>
In-Reply-To: <20170413160626.14635-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 2017-04-14 at 00:06 +0800, Ming Lei wrote:
> But if one rq starts with non-aligned buffer(the 1st bvec's
> bv_offset isn't zero) and if we allow to merge, it is quite
> difficult to respect sg gap limit, especially the segment
> can't be at maximum segment size, otherwise the segment
> ends in unaligned virt boundary. This patch trys to avoid the
> issue by not allowing to merge if the req starts with non-aligned
> buffer.

Hello Ming,

Why is it considered difficult to detect whether or not a gap exists if
the offset of the first bio is non-zero? Please note that a thoroughly
tested version of gap detection code that supports non-zero offsets for
the first element is already upstream. See also ib_map_mr_sg() and
ib_sg_to_pages() in drivers/infiniband/core/verbs.c.

Thanks,

Bart.=
