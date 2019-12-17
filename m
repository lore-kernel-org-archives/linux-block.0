Return-Path: <SRS0=G4H8=2H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50681C43603
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 14:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183152465E
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 14:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZFmHNFAd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfLQOjw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:39:52 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:39549 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbfLQOjw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 09:39:52 -0500
Received: by mail-io1-f68.google.com with SMTP id c16so9327941ioh.6
        for <linux-block@vger.kernel.org>; Tue, 17 Dec 2019 06:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0sZEnSkiYQNg6SRJmFflI3w/YPx9FXg9wqpG+aZiUIM=;
        b=ZFmHNFAdcG7mQJRZW+JQhhU6M5I9mUsiClpOEIcm4l+zxMdF3+8vNscaoLE6Ixz8cK
         Fwwh4HpRBW135LiR/ts9XPRvQCkGIqz3NYGkoG01rCaxt8Y6ZSkM3q3E4JDgVusCk0Nz
         wyD8BSgwt1xouzFrZsdMhlmtVl91gLdHXF+xnPxxhzLIiJS5UnLvf/gtpGwDhIeC1UJF
         f2buPPaMh2zmMyy3MfluQl7rimW4fGJZh09GFb7sD3QbvmC98i1/TD16veiObym089bw
         o8RqmSmla8kCTNssOdDZrKgbj/Lcv+D5RjWhOuj3/8n4kKqm/pxYb/KeWDHSRQrjMFCS
         0y5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0sZEnSkiYQNg6SRJmFflI3w/YPx9FXg9wqpG+aZiUIM=;
        b=I7fIKIxK8chwGUI/v6CDlUSGmRJzQ/X9099Tkf1GAH8WBvKJaW/dylipNbHr8+aFDs
         +3F7CfgXqaJJumdEZbcymJJwrQSNsK3xrdbqwrmqQ4n9L3qxWC6IBqcX0BXaJdr8Qy0z
         WnBtJfgfF4rrbxBZCYq3eicBFkyfwXKgpkGS31X85xDPUovgw9hYgzx/oRWd1xG8sLkV
         XKoFFDuAvCmBb5fQTQcAJkdvLBY06kobEtiNCj4zYNL3+pLpnFgm7dB8sNB8KRK1RIiG
         LsY98ADJvYDrD8ck6z7O/dHKte27eZgLKNFObiSABb0LroTkYifKRUXUt3UOaEenfo4v
         wtIQ==
X-Gm-Message-State: APjAAAXm+qqJzYTKMi7LXUPM3zXfoAdIza74dNwBufNycBh5X3xtfIZi
        61euZtRwTJZXJUg5KyNH72tCTg==
X-Google-Smtp-Source: APXvYqzDsH+MCOmq9YfOhpFDx//rJABZlfmdvz8nIgn21DdebL9/fB5mPQh0kVogMn7XFjwVW9bkYg==
X-Received: by 2002:a6b:731a:: with SMTP id e26mr3843894ioh.254.1576593591067;
        Tue, 17 Dec 2019 06:39:51 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w21sm5285255ioc.34.2019.12.17.06.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 06:39:50 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     willy@infradead.org, clm@fb.com, torvalds@linux-foundation.org,
        david@fromorbit.com
Subject: [PATCHSET v5 0/6] Support for RWF_UNCACHED
Date:   Tue, 17 Dec 2019 07:39:42 -0700
Message-Id: <20191217143948.26380-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Recently someone asked me how io_uring buffered IO compares to mmaped
IO in terms of performance. So I ran some tests with buffered IO, and
found the experience to be somewhat painful. The test case is pretty
basic, random reads over a dataset that's 10x the size of RAM.
Performance starts out fine, and then the page cache fills up and we
hit a throughput cliff. CPU usage of the IO threads go up, and we have
kswapd spending 100% of a core trying to keep up. Seeing that, I was
reminded of the many complaints I here about buffered IO, and the fact
that most of the folks complaining will ultimately bite the bullet and
move to O_DIRECT to just get the kernel out of the way.

But I don't think it needs to be like that. Switching to O_DIRECT isn't
always easily doable. The buffers have different life times, size and
alignment constraints, etc. On top of that, mixing buffered and O_DIRECT
can be painful.

Seems to me that we have an opportunity to provide something that sits
somewhere in between buffered and O_DIRECT, and this is where
RWF_UNCACHED enters the picture. If this flag is set on IO, we get the
following behavior:

- If the data is in cache, it remains in cache and the copy (in or out)
  is served to/from that. This is true for both reads and writes.

- For writes, if the data is NOT in cache, we add it while performing the
  IO. When the IO is done, we remove it again.

- For reads, if the data is NOT in the cache, we allocate a private page
  and use that for IO. When the IO is done, we free this page. The page
  never sees the page cache.

With this, I can do 100% smooth buffered reads or writes without pushing
the kernel to the state where kswapd is sweating bullets. In fact it
doesn't even register.

Comments appreciated! This should work on any standard file system,
using either the generic helpers or iomap. I have tested ext4 and xfs
for the right read/write behavior, but no further validation has been
done yet. This version contains the bigger prep patch of switching
iomap_apply() and actors to struct iomap_data, and I hope I didn't
mess that up too badly. I'll try and exercise it all, I've done XFS
mounts and reads+writes and it seems happy from that POV at least.

The core of the changes are actually really small, the majority of
the diff is just prep work to get there.

Patches are against current git, and can also be found here:

https://git.kernel.dk/cgit/linux-block/log/?h=buffered-uncached

 fs/ceph/file.c          |   2 +-
 fs/dax.c                |  25 +++--
 fs/ext4/file.c          |   2 +-
 fs/iomap/apply.c        |  61 ++++++++---
 fs/iomap/buffered-io.c  | 230 +++++++++++++++++++++++++---------------
 fs/iomap/direct-io.c    |  57 +++++-----
 fs/iomap/fiemap.c       |  48 +++++----
 fs/iomap/seek.c         |  64 ++++++-----
 fs/iomap/swapfile.c     |  27 ++---
 fs/iomap/trace.h        |   4 +-
 fs/nfs/file.c           |   2 +-
 fs/xfs/xfs_iomap.c      |   7 +-
 include/linux/fs.h      |   7 +-
 include/linux/iomap.h   |  20 +++-
 include/uapi/linux/fs.h |   5 +-
 mm/filemap.c            |  87 +++++++++++++--
 16 files changed, 439 insertions(+), 209 deletions(-)

Changes since v4:
- Add patch for disabling delalloc on buffered writes on xfs
- Fixup an XFS flags mishap
- Add iomap flag trace definitions
- Fixup silly add_to_page_cache() vs add_to_page_cache_lru() mistake

Changes since v3:
- Add iomap_actor_data to cut down on arguments
- Fix bad flag drop in iomap_write_begin()
- Remove unused IOMAP_WRITE_F_UNCACHED flag
- Don't use the page cache at all for reads

Changes since v2:
- Rework the write side according to Chinners suggestions. Much cleaner
  this way. It does mean that we invalidate the full write region if just
  ONE page (or more) had to be created, where before it was more granular.
  I don't think that's a concern, and on the plus side, we now no longer
  have to chunk invalidations into 15/16 pages at the time.
- Cleanups

Changes since v1:
- Switch to pagevecs for write_drop_cached_pages()
- Use page_offset() instead of manual shift
- Ensure we hold a reference on the page between calling ->write_end()
  and checking the mapping on the locked page
- Fix XFS multi-page streamed writes, we'd drop the UNCACHED flag after
  the first page

--
Jens Axboe


