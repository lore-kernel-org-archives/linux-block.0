Return-Path: <SRS0=tPwK=PU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5D8C43387
	for <linux-block@archiver.kernel.org>; Sat, 12 Jan 2019 21:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08E920872
	for <linux-block@archiver.kernel.org>; Sat, 12 Jan 2019 21:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1gRq5157"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfALVaU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Jan 2019 16:30:20 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42063 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfALVaU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Jan 2019 16:30:20 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so7785521pga.9
        for <linux-block@vger.kernel.org>; Sat, 12 Jan 2019 13:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=IbJfq8FCmhDPooa8/j2eXvqahKXF7IZHL0mOUhIMpP8=;
        b=1gRq5157nl99m/VsoBf/EYdSJG+higKd4k5haK5rnewufCClktH1JE5q/Hl6HRNwrv
         ADZal534voeUXYS6EW64UTaqfiphQglByzyAmRIiG48yPGEnpvejCcYVHVEV8hsY1QSj
         CpA4AecOAIml61bE/creFZYHPmo7Xk7pcbGIQ0c5biNzeG6lOdIyFIndIz1BuVMAfJZs
         uHF8htOQ3nrtvabZF1lyBfUkot4hcFsjUE2nVQpBO9Z8Fq5Bit/8xTu8MjkGLK+aveC3
         YJQeFh6s3KGhAkY2tvof7jTDoB4RhjovAJkQ1hsXVX1APZXmW8CHDJ58Zt5C0J+rmH2I
         nqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IbJfq8FCmhDPooa8/j2eXvqahKXF7IZHL0mOUhIMpP8=;
        b=AzRSas4c70YSH4b8suOgoUWly/BFKRZCqCGk0GjnRCszKLtwnJnz1jSQSejl/zsZ5E
         A8BdW8kIjAIfA1U0hgLfQV77rvwdh8MLtceBJvW/e9/nXwynJyGdue+c8CaIUQ3Uzy3j
         wORucq/6jhZP9WnBCBB1OCSXoT25fEzhzcrUOqyZgn782CYCmtaHNUmMidI2hN/d0aaf
         n2/RfV7cwzgl/rILE310en+sBMqQuyZXoFqOqzbCgOeBMNBKsokOBlBFj5l3nwqDL7uM
         s757jHWvOhTDysyJlfBh8mqaCOfKaXGDI+Hhq5dD6xROros7eSKdwqVDn+o9XnQ/yzNv
         4uTg==
X-Gm-Message-State: AJcUukcktj/b5P97cJtPphaTFxnsvcSNKWjDeltr0JCC5kWuog+55Pvb
        5KppJ1sh+RWhYbqJ0OcQFR5ubw==
X-Google-Smtp-Source: ALg8bN4m/zbKe2ji8INLkfJsgc+pImQzCsqo7iEz9nnuxZjK8KGAjYrFyYammh0IcBmVl2qGZ8ToYA==
X-Received: by 2002:a62:62c5:: with SMTP id w188mr19964310pfb.160.1547328619470;
        Sat, 12 Jan 2019 13:30:19 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id y6sm151629818pfd.104.2019.01.12.13.30.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 13:30:18 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
Subject: [PATCHSET v3] io_uring IO interface
Date:   Sat, 12 Jan 2019 14:29:55 -0700
Message-Id: <20190112213011.1439-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Here's v3 of the io_uring interface. Since data structures etc have
changed since the v1 posting, here's a refresher of what io_uring
is and how it works.

io_uring is a submission queue (SQ) and completion queue (CQ) pair that
an application can use to communicate with the kernel for doing IO. This
isn't aio/libaio, but it provides a similar set of features, as well as
some new ones:

- io_uring is a lot more efficient than aio. A lot, and in many ways.

- io_uring supports buffered aio. Not just that, but efficiently as
  well. Cached data isn't punted to an async context.

- io_uring supports polled IO, it takes advantage of the blk-mq polling
  work that went into 5.0-rc.

- io_uring supports kernel side submissions for polled IO. This enables
  IO without ever having to do a system call.

- io_uring supports fixed buffers for O_DIRECT. Buffers can be
  registered after an io_uring context has been setup, which eliminates
  the need to do get_user_pages() / put_pages() for each and every IO.

To use io_uring, you must first setup an io_uring context. This is done
through the first of three new system calls:

io_uring_setup(entries, params)
	Sets up a context for doing async IO. On success, returns a file
	descriptor that the application can mmap to gain access to the
	SQ ring, CQ ring, and io_uring_sqe's.

Once the rings are setup, the application then mmap's these rings to
communicate with the kernel. See a sample application I wrote that
natively does this:

http://git.kernel.dk/cgit/fio/plain/t/io_uring.c

IO is done by filling out an io_uring_sqe, and updating the SQ ring. The
format of the sqe is as follows:

struct io_uring_sqe {
	__u8	opcode;		/* type of operation for this sqe */
	__u8	flags;		/* IOSQE_ flags */
	__u16	ioprio;		/* ioprio for the request */
	__s32	fd;		/* file descriptor to do IO on */
	__u64	off;		/* offset into file */
	union {
		void	*addr;	/* buffer or iovecs */
		__u64	__pad;
	};
	__u32	len;		/* buffer size or number of iovecs */
	union {
		__kernel_rwf_t	rw_flags;
		__u32		fsync_flags;
	};
	__u16	buf_index;	/* index into fixed buffers, if used */
	__u16	__pad2;
	__u32	__pad3;
	__u64	user_data;	/* data to be passed back at completion time */
};

Most of this is self explanatory. The ->user_data field is passed back
through a completion event, so the application can track IOs
individually.

Completions are posted on the CQ ring when an sqe completes, they are a
struct io_uring_cqe and the format is as follows:

struct io_uring_cqe {
	__u64	user_data;	/* sqe->data submission passed back */
	__s32	res;		/* result code for this event */
	__u32	flags;
};

To either submit IO or reap completions, there's a 2nd new system call:

io_uring_enter(fd, to_submit, min_complete, flags)
	Initiates IO against the rings mapped to this fd, or waits for
	them to complete, or both The behavior is controlled by the
	parameters passed in. If 'min_complete' is non-zero, then we'll
	try and submit new IO. If IORING_ENTER_GETEVENTS is set, the
	kernel will wait for 'min_complete' events, if they aren't
	already available.

The sample application mentioned above uses the rings directly, but for
most uses cases, I intend to have the necessary support in a liburing
library that abstracts it enough for application to use in a performant
way, without having to deal with the intricacies of the ring. There's
already some basic support there and a few test applications, but that
side definitely needs some work. Find that repo here:

git://git.kernel.dk/liburing

io_uring is designed to be fast and scalable. I've demonstrated 1.6M 4k
IOPS from a single core on my aging test box, and on the latency front,
we're also doing extremely well. It's designed to both be async and
batching, if you wish, the application gets to control how to use that
side.

If you want to play with io_uring, see the sample app above, the
liburing repo, or the fio io_uring engine as well.

Patches are against 5.0-rc1 (ish), and can also be found in my
'io_uring' git branch:

git://git.kernel.dk/linux-block io_uring


Since v2
- Separate fixed buffers from sqe entries. register/unregister them
  through the new io_uring_register(2) system call
- sqe->index is now sqe->buf_index to make it clearer
- fixed buffers require sqe->flags to have IOSQE_FIXED_BUFFER set
- Add sqe field that is passed back at completion through the cqe, instead
  of passing back the original sqe index. This is more useful as it allows
  per-life of IO data, ->index did not.
- Cleanup async IO punting
- Don't punt O_DIRECT writes to async handling
- Make sq thread just for polling (submissions and completions)
- Always enable sq workqueue for async offload
- Use GFP_ATOMIC for req allocation
- Fix bio_vec being an unknown type on some kconfigs
- New IORING_OP_FSYNC implementation
- Add fixed fileset support through io_uring_register(2)
- Integrate workqueue support into main patchset
- Fix io_sq_thread() logic for when to grab current->mm
- Fix io_sq_thread() off-by-one
- Improve polling performance for multiple files in an io_uring context
- Have CONFIG_IO_URING select ANON_INODES
- Don't make io_kiocb->ki_flags atomic
- Be fully consistent in naming, for some reason we used the same
  mess that aio.c is, where io_kiocb,kiocb,iocb are used interchangably.
  'req' is now always io_kiocb, 'kiocb' is always kiocb.
- Rename KIOCB_F_* flags as they are req flags, REQ_F_*.


 Documentation/filesystems/vfs.txt      |    3 +
 arch/x86/entry/syscalls/syscall_64.tbl |    3 +
 block/bio.c                            |   59 +-
 fs/Makefile                            |    1 +
 fs/block_dev.c                         |   19 +-
 fs/file.c                              |   15 +-
 fs/file_table.c                        |    9 +-
 fs/gfs2/file.c                         |    2 +
 fs/io_uring.c                          | 2023 ++++++++++++++++++++++++
 fs/iomap.c                             |   48 +-
 fs/xfs/xfs_file.c                      |    1 +
 include/linux/bio.h                    |   14 +
 include/linux/blk_types.h              |    1 +
 include/linux/file.h                   |    2 +
 include/linux/fs.h                     |    6 +-
 include/linux/iomap.h                  |    1 +
 include/linux/syscalls.h               |    7 +
 include/uapi/linux/io_uring.h          |  147 ++
 init/Kconfig                           |    9 +
 kernel/sys_ni.c                        |    3 +
 20 files changed, 2334 insertions(+), 39 deletions(-)

-- 
Jens Axboe


