Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33766 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935703AbeFMO7N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jun 2018 10:59:13 -0400
Date: Wed, 13 Jun 2018 10:59:08 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Sterba <dsterba@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH V6 00/30] block: support multipage bvec
Message-ID: <20180613145908.GB17340@kmo-pixel>
References: <20180609123014.8861-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180609123014.8861-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Jun 09, 2018 at 08:29:44PM +0800, Ming Lei wrote:
> Hi,
> 
> This patchset brings multipage bvec into block layer:

Ming, what's going on with the chunk naming? I haven't been paying attention
because it feels like it's turned into bike shedding, but I just saw something
about a 3rd way of iterating over bios? (page/segment/chunk...?)
