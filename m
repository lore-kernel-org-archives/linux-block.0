Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96177C2D0C6
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 15:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7092467A
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 15:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rTSGHl4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387452AbfLKP3t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:29:49 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42541 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733306AbfLKP3s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 10:29:48 -0500
Received: by mail-pl1-f194.google.com with SMTP id x13so1546768plr.9
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 07:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LqLfKfxDfr9ThyOm7S1FFMSYyKBD7N45F7A7qNmdNr0=;
        b=rTSGHl4r+r2nUquOl4X1P6mjxf6DJJue9R2uF6r06BuX5SNKubnOS2GOE0GcvYJEWV
         JPLfl77WzwgBSKgnRw5NQnJRZ4WKMfFCfksjoFx+sxGxEIJM/SLOsqXG7GDbqLKNPkE2
         Rpq3U2T1f536DIOijDyiAEoq2P9aYyUzxEVUuDUubXkqimuNg5FWRpuFi+LREg+l6L93
         5tu3Rrf3PM7hw58oztC6y7V9hNHCH+neTIGcy/VO3c8iJzC8eapKDKSKw/cmywg9CZ8E
         Z91T9XPei0hvJmqCd7qG++n92W004XeJCM9BdTQ+ijDuuQODyO7tNWRzJUv/49PN/nDB
         gYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LqLfKfxDfr9ThyOm7S1FFMSYyKBD7N45F7A7qNmdNr0=;
        b=XIy1+3+6vK+PL/D9TEayV7m6wwk7EwbQFtYpJvFVWH30hz0AbXYUYD6/hCZjVhsPRf
         yms6vj3cOHnX4BJO2igbJh177IW5kkxnxZV+BK6h2w6XC6jOolveW9zoqgUL5ccnw2G2
         SkM/l9odvM7T9nedTpi0zaVZy9MGrjD1i0sBtx+uKIRIcH4PT4dNN8IBDUn8IMfnHdAk
         lvz9BNHROCqCuBDyfa+F3SKLz/8Sbj1eKpDza53ioTZ8LuPlHLR/sftJCxrlRcCHNAtJ
         ZrKMX0MQw54yFFXPhX+GifENtfo89Ew7vTPc2gEZvvSmewaFVd0cmYYNEpIc+q9uNUCI
         Y3cg==
X-Gm-Message-State: APjAAAVmwyxMYIpTOX45yhK989t3QFSCtbRf5n+EJlABEFRkb9x+lYAa
        /CjW6txB7wY5m2iYpRll4/0jAw==
X-Google-Smtp-Source: APXvYqx1nknDUWAcCtnWR4lgVgOM29qBVuBTOdNVDNynssnsLxodyXf0nZ5cI9x5HuC2fXenMSA+ug==
X-Received: by 2002:a17:902:848e:: with SMTP id c14mr4032994plo.36.1576078187819;
        Wed, 11 Dec 2019 07:29:47 -0800 (PST)
Received: from x1.thefacebook.com ([2620:10d:c090:180::50da])
        by smtp.gmail.com with ESMTPSA id n26sm3661882pgd.46.2019.12.11.07.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 07:29:46 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     willy@infradead.org, clm@fb.com, torvalds@linux-foundation.org,
        david@fromorbit.com
Subject: [PATCHSET v3 0/5] Support for RWF_UNCACHED
Date:   Wed, 11 Dec 2019 08:29:38 -0700
Message-Id: <20191211152943.2933-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
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
  is served to/from that.

- If the data is NOT in cache, we add it while performing the IO. When
  the IO is done, we remove it again.

With this, I can do 100% smooth buffered reads or writes without pushing
the kernel to the state where kswapd is sweating bullets. In fact it
doesn't even register.

Comments appreciated! This should work on any standard file system,
using either the generic helpers or iomap. I have tested ext4 and xfs
for the right read/write behavior, but no further validation has been
done yet. Patches are against current git, and can also be found here:

https://git.kernel.dk/cgit/linux-block/log/?h=buffered-uncached

 fs/ceph/file.c          |  2 +-
 fs/dax.c                |  2 +-
 fs/ext4/file.c          |  2 +-
 fs/iomap/apply.c        | 26 ++++++++++-
 fs/iomap/buffered-io.c  | 54 ++++++++++++++++-------
 fs/iomap/direct-io.c    |  3 +-
 fs/iomap/fiemap.c       |  5 ++-
 fs/iomap/seek.c         |  6 ++-
 fs/iomap/swapfile.c     |  2 +-
 fs/nfs/file.c           |  2 +-
 include/linux/fs.h      |  7 ++-
 include/linux/iomap.h   | 10 ++++-
 include/uapi/linux/fs.h |  5 ++-
 mm/filemap.c            | 95 ++++++++++++++++++++++++++++++++++++-----
 14 files changed, 181 insertions(+), 40 deletions(-)

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


