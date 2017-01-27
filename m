Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:59247 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933146AbdA0QND (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2017 11:13:03 -0500
Date: Fri, 27 Jan 2017 17:12:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-raid@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH 05/18] block: allow specifying size for extra command
        data
Message-ID: <20170127161254.GA16557@lst.de>
References: <1485365126-23210-1-git-send-email-hch@lst.de> <1485365126-23210-6-git-send-email-hch@lst.de> <yq160l2a4us.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <yq160l2a4us.fsf@oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jan 25, 2017 at 10:15:55PM -0500, Martin K. Petersen wrote:
> +static void *alloc_request_size(gfp_t gfp_mask, void *data)
> 
> I like alloc_request_simple() but alloc_request_size() seems a bit
> contrived. _reserve? _extra? _special? Don't have any good suggestions,
> I'm afraid.

Not that I'm a fan of _size, but I like the other suggestions even less.
