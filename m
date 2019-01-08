Return-Path: <SRS0=D8nw=PQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C79C43387
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 16:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B53A214C6
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 16:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YPsacoZe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfAHQ4y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:56:54 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:53994 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729062AbfAHQ4y (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 11:56:54 -0500
Received: by mail-it1-f195.google.com with SMTP id g85so7227531ita.3
        for <linux-block@vger.kernel.org>; Tue, 08 Jan 2019 08:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=qaAxuNQDs/bh6Zyc6no3EpA970dYVqrCLLnmdWVRe4Q=;
        b=YPsacoZeZgSeS1ebR1Ge+apRz7CpHNRNAwf+2btygnUCdfHxX6lj52Pwr+XYHonZoD
         PC6GNyucyVE7NzUh4AT++f6CU5lmPF1IpE0kpAf3jXA4GW7HOioxOke3K1nKGfCWeiGs
         gyv34bSqFUUIcXpBnoaBWEtT1BosOLV2KcItnIR+z2x/BWJOSGVqaxdCo4f0sj1xsUTN
         xEdIH1IApULRKKacqlKcMFRzFrfLpL/4MJhd4NipzvtaEqmI+k/Lxwed+VBn97JP5Vv4
         q9MfIEab+nYVcgxxokkmN6qs0qkOvR4ss6Ho1dwHQlpe7QH3Rq++TTFBhHYDIRSuvy4B
         BcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qaAxuNQDs/bh6Zyc6no3EpA970dYVqrCLLnmdWVRe4Q=;
        b=DveKfvC/kLBI9d6bhMn4bclydtpo5aw+nD0NPfcnDqW3C5xXuwnfWYfdLbR4GdH7GI
         hiVfktLJk6KM0CSpfujb2zVxaQdbBrsvg/Diu3E0yjfeGY2lNBCOIgdHM0gOYiPllvQ+
         ZtU/gQsNIQbWHB6Ea7Br+6xvAO1prWH6RdEzTasc4Ekz9eCUlpN1gWqIWScnci4tcJKi
         ZNN3dSmR+8uCNqe79kZDt2uq+h1KkrxwMu+cdogtiFTtzM2vrw1yU36l+DDtfRSGUFHp
         FXQ0YDZ40Gy/BDDkCmH5TpOCKAcwjOXOCvf7KhvghPLqlUNxgovk2KLSmhRGbRQYrSlF
         s8WQ==
X-Gm-Message-State: AJcUukdid2DUlyeVMam0bKkK0PuSoCnRwAEfpP1zhiJU4uVEHeBsjWxN
        RBKQpVPR80zQLGTdkaQnuvOwwg==
X-Google-Smtp-Source: ALg8bN7Ekal5HKIhELqA7WZ9CgYqAJpm6etTB4oRu6sOcHJoX5H/UAkNUiChIr8tgxBo5hIVZ3W8yw==
X-Received: by 2002:a02:c943:: with SMTP id u3mr1610207jao.96.1546966613018;
        Tue, 08 Jan 2019 08:56:53 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m10sm17563442ioq.25.2019.01.08.08.56.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 08:56:51 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
Subject: [PATCHSET v1] io_uring IO interface
Date:   Tue,  8 Jan 2019 09:56:29 -0700
Message-Id: <20190108165645.19311-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

After some arm twisting from Christoph, I finally caved and divorced the
aio-poll patches from aio/libaio itself. The io_uring interface itself
is useful and efficient, and after rebasing all the new goodies on top
of that, there was little reason to retail the aio connection.

Hence io_uring was born. This is what I previously called scqring for
aio, but now as a standalone entity. Patch #5 adds the core of this
interface, but in short, it has two main data structures:

struct io_uring_iocb {
	__u8	opcode;
	__u8	flags;
	__u16	ioprio;
	__s32	fd;
	__u64	off;
	union {
		void	*addr;
		__u64	__pad;
	};
	__u32	len;
	union {
		__kernel_rwf_t	rw_flags;
		__u32		__resv;
	};
};

struct io_uring_event {
	__u64	index;		/* what iocb this event came from */
	__s32	res;		/* result code for this event */
	__u32	flags;
};

The SQ ring is an array of indexes into an array of io_uring_iocbs,
which describe the IO to be done. The SQ ring is an array of
io_uring_events, which describe a completion event. Both of these rings
are mapped into the application through mmap(2), at special magic
offsets. The application manipulates the ring directly, and then
communicates with the kernel through these two system calls:

io_uring_setup(entries, iovecs, params)
	Sets up a context for doing async IO. On success, returns a file
	descriptor that the application can mmap to gain access to the
	SQ ring, CQ ring, and io_uring_iocbs.

io_uring_enter(fd, to_submit, min_complete, flags)
	Initiates IO against the rings mapped to this fd, or waits for
	them to complete, or both The behavior is controlled by the
	parameters passed in. If 'min_complete' is non-zero, then we'll
	try and submit new IO. If IORING_ENTER_GETEVENTS is set, the
	kernel will wait for 'min_complete' events, if they aren't
	already available.

I've started a liburing git repo for this, which contains some helpers
for doing IO without having to muck with the ring directly, setting up
an io_uring context, etc. Clone that here:

git://git.kernel.dk/liburing

In terms of usage, there's also a small test app here:

http://git.kernel.dk/cgit/fio/plain/t/io_uring.c

and if you're into fio, there's a io_uring engine included with that as
well for test purposes.

In terms of features, this has everything that the prior aio-poll
postings did. Later patches add support for polled IO, fixed buffers,
kernel side submission and polling, buffered aio, etc. Also a number of
bug fixes in here from previous postings.

Series is against 5.0-rc1, and can also be found in my io_uring branch.
For now just x86-64 has the system calls wired up, and liburing also
only supports x86-64. The latter just needs system call numbers and
reasonable read/write barrier defines to work, however.

 Documentation/filesystems/vfs.txt      |    3 +
 arch/x86/entry/syscalls/syscall_64.tbl |    2 +
 block/bio.c                            |   59 +-
 fs/Makefile                            |    2 +-
 fs/block_dev.c                         |   19 +-
 fs/file.c                              |   15 +-
 fs/file_table.c                        |    9 +-
 fs/gfs2/file.c                         |    2 +
 fs/io_uring.c                          | 1907 ++++++++++++++++++++++++
 fs/iomap.c                             |   48 +-
 fs/xfs/xfs_file.c                      |    1 +
 include/linux/bio.h                    |   14 +
 include/linux/blk_types.h              |    1 +
 include/linux/file.h                   |    2 +
 include/linux/fs.h                     |    6 +-
 include/linux/iomap.h                  |    1 +
 include/linux/syscalls.h               |    5 +
 include/uapi/linux/io_uring.h          |  115 ++
 kernel/sys_ni.c                        |    2 +
 19 files changed, 2173 insertions(+), 40 deletions(-)

-- 
Jens Axboe


