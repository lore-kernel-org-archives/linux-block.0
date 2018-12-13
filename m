Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0366BC67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCAB20851
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kPVxXha/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBCAB20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbeLMR4y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:56:54 -0500
Received: from mail-io1-f43.google.com ([209.85.166.43]:38912 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729289AbeLMR4x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 12:56:53 -0500
Received: by mail-io1-f43.google.com with SMTP id k7so2302355iob.6
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 09:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=8QqqOPjqGZnsWA9nTT8r4TUCmlZBlg5xisCy+Y0w6EI=;
        b=kPVxXha/ZDXz6R7kuMm733J80D7LQSeBhgjm84Cgwam7YOq6BJAUbxf4/NUnPY67Sl
         N+UwNHe1wqzHpWjHcC6oQBEMYMRT6tCfo0IF0BjpYC9OBcqsgdCyW7bwQ8styc60smIP
         rYYrCcljr+v+YVC2eNp602sWEHILrcEDUCQlGQCAkmE4GAhxdjq+bS4oeRxvDM1AWJQy
         Rd/yf8kRzFZisiQH1JlF0fBdhwzclsaV9E55I1na4pBhSbr5Y+4m4BgMdriVUXcznHyc
         v3BPDPL2dlTX9Rscpgxk0u+KlK46/6Eh4pvJaBjErUZOLMEVcG9A7ZI9VWMkR91cVK30
         zASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8QqqOPjqGZnsWA9nTT8r4TUCmlZBlg5xisCy+Y0w6EI=;
        b=KB2IgxYpdUMEqyu09MTzkJdSqq3Yp7s+fhBhdKrGVW5/0LNwfJ62MIQSujuvgSdy/L
         aD/rsgpLNIcvWUhZaPNoAfnXvJsBmZmsJV91BlZ270AXK2XcNSR3dayhkRo4uuUQqrkz
         ODiBP/rrYx7FkbqMey7J0RkTMlio3ZRrg3l+nLOafl0LHZoNPROGJeHlIOmSe6wJ3fhX
         QZH+ChrPS5TD4z6rpTijAB5VcqewJDz5TszZSYreZwopk6hs12gbQnM8imDnL/wnlVeW
         sHLVIfb4uqbgTc7lokrC8rtNKf3nwbR0aDuVjE6cM341qbFcGlWX5FDasxQjL/sVeYjK
         2YGg==
X-Gm-Message-State: AA+aEWaftF1yrFvcns/i0iAowVdWNwnXwkHr5AWWMK7mmBcHsgWDP4AA
        6YnYrg6p4FJNIHWQ+WNbcnvZzIwulwGJNg==
X-Google-Smtp-Source: AFSGD/VGTNVNGBPE7y/eI2GxpCBVDjimRIihAHxTZLljtbrCAZKI+6f06TQcVrTmuBIXaMlWVrIlLA==
X-Received: by 2002:a6b:9188:: with SMTP id t130mr20469607iod.261.1544723812161;
        Thu, 13 Dec 2018 09:56:52 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k6sm1022261ios.69.2018.12.13.09.56.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 09:56:51 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com
Subject: [PATCHSET v8] Support for polled and buffered aio (and more)
Date:   Thu, 13 Dec 2018 10:56:19 -0700
Message-Id: <20181213175645.22181-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We're getting closer... Some good bug fixes in this release, fully
stable for me.

I decided to make the SQ/CQ ring interface the primary innovation
here, and build the new features on top of that. This means that
the io_submit/io_getevents interface doesn't get any of the advanced
features, outside of polled IO. If you want any of the new fancy,
you really sould use the ring interface, it's more efficient.

As before, there's a sample application as an introduction to how
to use the ring interface:

http://git.kernel.dk/cgit/fio/plain/t/aio-ring.c

Outside of that, I also built a fio engine for it yesterday. If you
update your fio to current -git, you'll have an aio-ring engine. As
an example, if you want to run buffered async IO, you would do:

[aio-buffered]
ioengine=aio-ring
sqwq=1
filename=/dev/nvme1n1
direct=0
ramp_time=2
runtime=10s
iodepth=64
rw=randread
norandommap
bs=4k

which enables the SQ/CQ workqueue offload. As before, cached data is
served without punting to a workqueue.

aio-ring also supports the sqthread interface, and it supports fixed
buffers, and (of course) polled IO. For a speed run, you'd do:

[aio-polled]
ioengine=aio-ring
hipri=1
fixedbufs=1
filename=/dev/nvme1n1
direct=1
ramp_time=2
runtime=10s
iodepth=64
iodepth_batch_complete_max=64
iodepth_batch=32
rw=randread
norandommap
bs=4k
cpus_allowed=0

which enables polling (hipri=1) and fixed buffers (fixedbufs=1).

Interface wise, I made an important change to how the SQ ring works.
Previously the ring was just an index into an array of iocbs. This
was somewhat inflexible, as I found out when I converted applications
to use it, as it requires an ordered relationship between application
IO units and iocbs. Now the ring is just indexes into the iocb array,
so you can submit multiple iocbs in one go without having to rely
on iocbs being ordered in the array.

As before, find this in my aio-poll branch:

http://git.kernel.dk/cgit/linux-block/log/?h=aio-poll

or clone it here:

git://git.kernel.dk/linux-block aio-poll

and the code is based on the pending 4.21 block changes, for-4.21/block.

Since v7:

- Fix fput error handling in aio_prep_rw()
- Dropped USERIOCB for non-ring interface
- Fix CQ ring sizing
- Change sq_ring to be ring of indexes, not iocbs
- Rename aio_iocb_ring -> aio_sq_ring, aio_io_event_ring -> aio_cq_ring
- Fix not passing submission state always, if setup
- Fix double mmget/use_mm for SQTHREAD for rare conditions
- Fix __kthread_bind_mask() warning for SQTHREAD exit
- Comments
- Various bug fixes

 Documentation/filesystems/vfs.txt      |    3 +
 Documentation/sysctl/fs.txt            |    8 +-
 arch/x86/entry/syscalls/syscall_64.tbl |    2 +
 block/bio.c                            |   33 +-
 fs/aio.c                               | 1891 ++++++++++++++++++++++--
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
 include/linux/syscalls.h               |    4 +
 include/uapi/asm-generic/unistd.h      |    4 +-
 include/uapi/linux/aio_abi.h           |   37 +
 kernel/sys_ni.c                        |    2 +
 20 files changed, 1916 insertions(+), 198 deletions(-)

-- 
Jens Axboe


