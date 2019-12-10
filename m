Return-Path: <SRS0=EWGC=2A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC899C43603
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 16:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD74207FF
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 16:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LTyUtTOi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfLJQY5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Dec 2019 11:24:57 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:36303 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfLJQY5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Dec 2019 11:24:57 -0500
Received: by mail-il1-f193.google.com with SMTP id b15so16672907iln.3
        for <linux-block@vger.kernel.org>; Tue, 10 Dec 2019 08:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NL2wx8OhT9nqgeYI97q9VsOTFKCtkP5TFUuqwTv6H6w=;
        b=LTyUtTOiDdot1XqLMl7i53d11nkIkpHsXZo5aA5qNQorELxc9mAR1aNsmM5j49z653
         ZyfAKvcNIpn1QLWUtIJWJTWvGsFYz9Vi7ZUKgfVki4us09AZkRrdPaTzyk+l0Uj0IHku
         5NvFFAaXeBYP9Woq9eCHZMJZ4s5Cj2UOgxNzWtlOuK0mCUUofkS0QaxBBB7CP6G4it0P
         PDteFrR7FCMx+hQ7BOW+4f8mEsHSJj4kVM+sH7x/xHqjdFzZ2Z9t9y/1ym7bs7xZxScO
         pKMMgV2UsdiOS5yIu8odu9AUzU7WGUIu0q30XMeOp7GP8DzAeoXj+2WJA49O3UI/WEgi
         aihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NL2wx8OhT9nqgeYI97q9VsOTFKCtkP5TFUuqwTv6H6w=;
        b=XlBABRNVQwOFw4b3tBTDOOrRdF3VAQT6+QufTz4t2MSlICq1P2+2efuQWCztdws3pw
         TViFw5kTCWyBA1D1XIk47KTTsngNX9rzuhsBKjzCbscVjl4xUWH0BnIyyBtlCp685wC7
         YgUnoHBi3XvHPUcElIBBClFJzV4TLbJna9HDJIZpnPh0bBDBAEAyOunBvP/oIuVfSDkq
         /Rk6R4glJ55oR5NrR5f5D1zgFG0dbmQzuqzPh8KaRVVBwMUDwRovgIglvPK0sDX/NqhH
         3nqCvkJgrA64dH0iTIMt9tqFJdi1n+EW4vujzi1GQhU45dKFFJ+B2K/ZaW00mGdFbSB+
         cCXw==
X-Gm-Message-State: APjAAAXNFOx3jNlXfwVneHC9dhgoSTpNMW7fE+GkjeXrKEWWnh8XUl8l
        +aaFbOaXHk9r4V/AUw9O2wtI1g==
X-Google-Smtp-Source: APXvYqzFCnW3bCJ9SgM7zc9uOwPn6XurQF380D0hDP/vO67nas52IiaHd40QcaYT8aulE0gULhfCqw==
X-Received: by 2002:a92:d7c1:: with SMTP id g1mr35930204ilq.192.1575995096800;
        Tue, 10 Dec 2019 08:24:56 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y11sm791174iol.23.2019.12.10.08.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 08:24:56 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCHSET 0/5] Support for RWF_UNCACHED
Date:   Tue, 10 Dec 2019 09:24:49 -0700
Message-Id: <20191210162454.8608-1-axboe@kernel.dk>
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

Comments appreciated! Patches are against current git (ish), and can
also be found here:

https://git.kernel.dk/cgit/linux-block/log/?h=buffered-uncached

 fs/ceph/file.c          |   2 +-
 fs/dax.c                |   2 +-
 fs/ext4/file.c          |   2 +-
 fs/iomap/apply.c        |   2 +-
 fs/iomap/buffered-io.c  |  75 +++++++++++++++++------
 fs/iomap/direct-io.c    |   3 +-
 fs/iomap/fiemap.c       |   5 +-
 fs/iomap/seek.c         |   6 +-
 fs/iomap/swapfile.c     |   2 +-
 fs/nfs/file.c           |   2 +-
 include/linux/fs.h      |   9 ++-
 include/linux/iomap.h   |   6 +-
 include/uapi/linux/fs.h |   5 +-
 mm/filemap.c            | 132 ++++++++++++++++++++++++++++++++++++----
 14 files changed, 208 insertions(+), 45 deletions(-)

-- 
Jens Axboe


