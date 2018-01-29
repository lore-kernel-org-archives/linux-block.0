Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751412AbeA2VdF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jan 2018 16:33:05 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B4A733B54D
        for <linux-block@vger.kernel.org>; Mon, 29 Jan 2018 21:33:05 +0000 (UTC)
Date: Mon, 29 Jan 2018 16:33:00 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [LSF/MM TOPIC] block: extend generic biosets to allow per-device
 frontpad
Message-ID: <20180129213300.GC5744@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

I'd like to enable bio-based DM to _not_ need to clone bios.  But to do
so each bio-based DM target's required per-bio-data would need to be
provided by upper layer biosets (as opposed to the bioset DM currently
creates).

So my thinking is that all system-level biosets (e.g. fs_bio_set,
blkdev_dio_pool) would redirect to a device specific variant bioset IFF
the underlying device advertises the need for a specific per-bio-data
payload to be provided.

I know this _could_ become a rathole but I'd like to avoid reverting DM
back to the days of having to worry about managing mempools for the
purpose of per-io allocations.  I've grown spoiled by the performance
and elegance that comes with having the bio and per-bio-data allocated
from the same bioset.

Thoughts?
Mike
