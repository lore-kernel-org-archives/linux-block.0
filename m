Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754526AbeFNBYN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jun 2018 21:24:13 -0400
Date: Thu, 14 Jun 2018 09:23:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        David Sterba <dsterba@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH V6 11/30] block: implement bio_pages_all() via
 bio_for_each_segment_all()
Message-ID: <20180614012352.GC19828@ming.t460p>
References: <20180609123014.8861-1-ming.lei@redhat.com>
 <20180609123014.8861-12-ming.lei@redhat.com>
 <20180613144412.GB4693@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180613144412.GB4693@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 13, 2018 at 07:44:12AM -0700, Christoph Hellwig wrote:
> Given that we have a single, dubious user of bio_pages_all I'd rather
> see it as an opencoded bio_for_each_ loop in the caller.

Yeah, that is fine since there is only one user in btrfs.

Thanks,
Ming
