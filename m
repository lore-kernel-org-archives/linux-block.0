Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808DFC07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394F420645
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="B9TN+0ZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394F420645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbeLGWUY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:20:24 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35809 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbeLGWUY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 17:20:24 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so2440485plo.2
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 14:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=kYBYRBZUHwoDm0BoahsBqe6jiRozov4zN2LIfTugP4I=;
        b=B9TN+0ZUG6+XniT+C9kjYBqtSb5gZaSueLgGD4WzAnNZ1YzNORjsz3xLGflHwoBs6+
         Ir4MhTcfwpSuy59KLwELw+5op5OkxUonWrP2nDZ9stODIE2TcngdVM4d6i5DHi9fM9j9
         GYBl5IriIYSiwgXQJJYUvtS7AHdcPMvVkz43vNBMrKUyxtsjoMj9OXsUrbDroVJ7ojHV
         qZcQOZ0HbfX6bBJC5mPehE8GB87Q7U6ADa/ar4Tn3VK09+i6ybacqMpGS+QAMRLfl2Sh
         Q9+stIegrR4Hz442tfZuv1P+ui9uxpTxSmmFcFQo57aWgCLd8O2sJbITJKr4+IvXekvm
         UNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kYBYRBZUHwoDm0BoahsBqe6jiRozov4zN2LIfTugP4I=;
        b=efl8gXWZpwD8Ci2Cgl/f5LUp7WTSF7gWzpSGF2ByB4GpPlpxaG3ZLXDc866Ix2I0F0
         IYF5m7nvFbVTSTb15jysX/jqqo9N9gz85nZpnPgNlGoQKK8mk0excmxbrugXFRO3D2Mn
         AKmzIZG0BZ5P4sjKkcex2r7MlwqfwRAjMzGVsoESRfk+/vGxRFqjQ3q4/r09b+mRJP+0
         shaNb3AzW/LhyB1VrihLiFJky/Imoj+4O/MtvHjWWtkIWArvF6eRKqiw7sWX5Px9lXVb
         FyF0BLzBLKO1PZOAnnUDG0soulQ4RdHsXh0knIT3FThXvsySgzkC9z2URifyYLRZauo2
         5yyw==
X-Gm-Message-State: AA+aEWb4xmLieEu/b2RowEyTbf0m0fJnPk9Tc3rztakeFW2WDCZ44M9f
        N0MojVjcdqwdbj+fW6honsGzq4EJdNg=
X-Google-Smtp-Source: AFSGD/V3LiddxuUwS9m7jaEtVmF5Cl+X/2hMycWYlo7EN69QXBV/rdGGp7p/nFhd0dijhf/DKN/Ong==
X-Received: by 2002:a17:902:298a:: with SMTP id h10mr3857215plb.312.1544221223004;
        Fri, 07 Dec 2018 14:20:23 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e9sm5282511pff.5.2018.12.07.14.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 14:20:22 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com
Subject: [PATCHSET v6] Support for polled aio (and more)
Date:   Fri,  7 Dec 2018 15:19:50 -0700
Message-Id: <20181207222016.29387-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For the grand introduction to this feature, see my original posting
here:

https://lore.kernel.org/linux-block/20181117235317.7366-1-axboe@kernel.dk/

and refer to the previous postings of this patchset for whatever
features were added there. Particularly v4 has some performance results:

https://lore.kernel.org/linux-block/20181130165646.27341-1-axboe@kernel.dk/

No new features in this version, I think we've got what we need. Just
a collection of fixes. Especially interesting is probably that XFS is
tested in all configurations now, it works with both IO polling and
fixed user buffers.

Find it here for your cgit browsing:

http://git.kernel.dk/cgit/linux-block/log/?h=aio-poll

or clone/pull from this branch:

git://git.kernel.dk/linux-block aio-poll


Since v5

- Correct spin/no-spin condition for polling
- Add some comments
- Fix missing io_event_ring(2) if !CONFIG_AIO
- Make sure XFS works for all cases
- Fix cq/sq ring sizing
- Make cq/sq ring work with non-polled IO
- Make cq/sq ring work without fixed buffers
- Ensure that io_ring_enter() doesn't race with kill_ioctx()
- Rebase on top of for-4.21/block


 Documentation/filesystems/vfs.txt      |    3 +
 arch/x86/entry/syscalls/syscall_64.tbl |    2 +
 block/bio.c                            |   33 +-
 fs/aio.c                               | 1538 +++++++++++++++++++++---
 fs/block_dev.c                         |   34 +-
 fs/file.c                              |   15 +-
 fs/file_table.c                        |   10 +-
 fs/gfs2/file.c                         |    2 +
 fs/iomap.c                             |   57 +-
 fs/xfs/xfs_file.c                      |    1 +
 include/linux/bio.h                    |    1 +
 include/linux/blk_types.h              |    2 +
 include/linux/file.h                   |    2 +
 include/linux/fs.h                     |    5 +-
 include/linux/iomap.h                  |    1 +
 include/linux/syscalls.h               |    5 +
 include/uapi/asm-generic/unistd.h      |    4 +-
 include/uapi/linux/aio_abi.h           |   32 +
 kernel/sys_ni.c                        |    2 +
 19 files changed, 1552 insertions(+), 197 deletions(-)

-- 
Jens Axboe



