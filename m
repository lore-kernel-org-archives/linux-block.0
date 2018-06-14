Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:43028 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752876AbeFNIUA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jun 2018 04:20:00 -0400
Date: Thu, 14 Jun 2018 01:19:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: why does __split_and_process_bio use bio_clone_bioset?
Message-ID: <20180614081947.GA23375@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Neil,

In commit 18a25da8 ("dm: ensure bio submission follows a depth-first
tree walk") you've added a call to bio_clone_bioset to
__split_and_process_bio.  Unlike all other bio splitting code this
actually allocates a new bio_vec array instead of just splitting the bio
and the iterator.  I can't actually find a good reason for that either
in a cursory review of the code, the commit or the comments.

Do you remember why this can't just use bio_clone_fast?
