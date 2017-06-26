Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54842 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751639AbdFZQn4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2017 12:43:56 -0400
Date: Mon, 26 Jun 2017 18:42:45 +0200
From: David Sterba <dsterba@suse.cz>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 00/51] block: support multipage bvec
Message-ID: <20170626164245.GO2866@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20170626121034.3051-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170626121034.3051-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jun 26, 2017 at 08:09:43PM +0800, Ming Lei wrote:
>   btrfs: avoid access to .bi_vcnt directly
>   btrfs: avoid to access bvec table directly for a cloned bio
>   btrfs: comment on direct access bvec table
>   btrfs: use bvec_get_last_page to get bio's last page
>   fs/btrfs: convert to bio_for_each_segment_all_sp()

Acked-by: David Sterba <dsterba@suse.com>

for all the btrfs patches.
