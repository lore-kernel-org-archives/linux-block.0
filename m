Return-Path: <SRS0=EWGC=2A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF98C43603
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 20:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAF82073B
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 20:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="m8m8ZT9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfLJUnI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:43:08 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39486 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfLJUnI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Dec 2019 15:43:08 -0500
Received: by mail-pl1-f194.google.com with SMTP id o9so329738plk.6
        for <linux-block@vger.kernel.org>; Tue, 10 Dec 2019 12:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s7qF6J4+kfCdNYIhE+VeOO24tCbKP12EfLQkj1+TVq0=;
        b=m8m8ZT9LbSH+6397QexjFYMYA/TSnmBtije5DrEL2vT5jKPx6ywHwRrH+jCIt9ziwr
         W68NheEGh8s8PQ6cG6i+DYbyBpy42ggFpvLcgdozZJ3L0DZ/QcIC2brNDVPzmaD5IbAF
         OsVnEb6NmA2ClRYlgI+oAzFeM7IcrwI+TntuMmVGrT9LOioR1aHpbafDDYGq3YFUoJEX
         Pd3ge5KnOcRjHAwSQoK2OrVyoCaPGCzpCMR3Rc4BQNvBklXaYqIOh36K4/CBM+srGfSL
         pSKakh8mg+b3kGhhXTUA/ZOvPQGH41Kra0Nzak6ytSzu7NUVX1HRw7rTevg8xfxg8U0e
         4VCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s7qF6J4+kfCdNYIhE+VeOO24tCbKP12EfLQkj1+TVq0=;
        b=q7vKcuuKU00mE/IZvAwTjvlQ6BL1RFY6AsifOUkJO03SMCDgB8wvgGBJl9T83DDZrP
         6kLwKR3If4N5fRD6LFf2XrH9hpj3KUPhru2+S8WcxbWqz4dwEIsDib1C8TEEVvJjnCvE
         qVET1qo54oS0QTGx26YYBXKICgaV6wCfyDL29isJiy2A1fOXCXhKlC0xXsBFe+MwruQ+
         O8hc6GgEZW/wPb+eucyJrANcYKhcD8oS2iJLuuXFUAnGhXPrvA2sfaBjta5xmT3s3z87
         8hiAH8Kl9Ge+V7GYJ6sQcdEqsPjShOJ5RIVYLbF0JFqja7h3VhGdKFo7D/dHMrWbfqgJ
         1T8A==
X-Gm-Message-State: APjAAAUGBPumezbs1zIqcsZJsjjdn2HiaG8G4oinNyDUajTthCgEJZgv
        Uk79/kQ3UbOgE4LGdU0cnkANtqa5LEeieA==
X-Google-Smtp-Source: APXvYqxpemjCBrWIc0y7uOpoxMcKjgw7vgpTEU1r3q89vKhHdmtLk0DYwE/mhHsML2jXvO+Fc+G9Aw==
X-Received: by 2002:a17:90a:d152:: with SMTP id t18mr7393332pjw.126.1576010587801;
        Tue, 10 Dec 2019 12:43:07 -0800 (PST)
Received: from x1.thefacebook.com ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id o15sm4387829pgf.2.2019.12.10.12.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 12:43:06 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     willy@infradead.org, clm@fb.com
Subject: [PATCHSET v2 0/5] Support for RWF_UNCACHED
Date:   Tue, 10 Dec 2019 13:42:59 -0700
Message-Id: <20191210204304.12266-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ecently someone asked me how io_uring buffered IO compares to mmaped
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
using either the generic helpers or iomap. Patches are against current
git, and can also be found here:

https://git.kernel.dk/cgit/linux-block/log/?h=buffered-uncached

 fs/ceph/file.c          |   2 +-
 fs/dax.c                |   2 +-
 fs/ext4/file.c          |   2 +-
 fs/iomap/apply.c        |   2 +-
 fs/iomap/buffered-io.c  |  89 +++++++++++++++++++------
 fs/iomap/direct-io.c    |   3 +-
 fs/iomap/fiemap.c       |   5 +-
 fs/iomap/seek.c         |   6 +-
 fs/iomap/swapfile.c     |   2 +-
 fs/nfs/file.c           |   2 +-
 include/linux/fs.h      |  11 +++-
 include/linux/iomap.h   |   6 +-
 include/uapi/linux/fs.h |   5 +-
 mm/filemap.c            | 139 ++++++++++++++++++++++++++++++++++++----
 14 files changed, 230 insertions(+), 46 deletions(-)

Changes since v1:
- Switch to pagevecs for write_drop_cached_pages()
- Use page_offset() instead of manual shift
- Ensure we hold a reference on the page between calling ->write_end()
  and checking the mapping on the locked page
- Fix XFS multi-page streamed writes, we'd drop the UNCACHED flag after
  the first page

-- 
Jens Axboe


