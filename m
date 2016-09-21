Return-Path: <viro@ftp.linux.org.uk>
Date: Wed, 21 Sep 2016 22:52:26 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [rfc] weirdness in bio_map_user_iov()
Message-ID: <20160921215226.GU2356@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-block@vger.kernel.org>

What happens if we feed it a 3-element iovec array, one page in each?
AFAICS, bio_add_pc_page() is called for each of those pages, even if
the previous calls have failed - break is only out of the inner loop.

Sure, failure due to exceeded request size means that everything after
that one will fail, but what of e.g.
                /*
                 * If the queue doesn't support SG gaps and adding this
                 * offset would create a gap, disallow it.
                 */
                if (bvec_gap_to_prev(q, prev, offset))
                        return 0;
in there?  Won't we risk having the first and the third pages added, with
the second one quietly skipped?  Jens, looks like it had come from you
(by way of jejb).  Am I missing something subtle here?
