Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36689 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753398AbcKBDBm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2016 23:01:42 -0400
Date: Tue, 1 Nov 2016 19:01:37 -0800
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Ming Lei <tom.leiming@gmail.com>,
        Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bart.vanassche@sandisk.com>
Subject: Re: [PATCH 45/60] block: bio: introduce
 bio_for_each_segment_all_rd() and its write pair
Message-ID: <20161102030137.6qfjzp3rf2wtbtti@kmo-pixel>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
 <1477728600-12938-46-git-send-email-tom.leiming@gmail.com>
 <20161031135943.36crigad55hwmmrl@thunk.org>
 <20161031151123.GA3193@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161031151123.GA3193@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Oct 31, 2016 at 08:11:23AM -0700, Christoph Hellwig wrote:
> On Mon, Oct 31, 2016 at 09:59:43AM -0400, Theodore Ts'o wrote:
> > What is _rd and _wt supposed to stand for?
> 
> I think it's read and write, but I think the naming is highly
> unfortunate.  I started dabbling around with the patches a bit,
> and to keep my sanity a started reaming it to _pages and _bvec
> which is the real semantics - the _rd or _pages gives you a synthetic
> bvec for each page, and the other one gives you the full bvec.

My original naming was bio_for_each_segment() and bio_for_each_page().
