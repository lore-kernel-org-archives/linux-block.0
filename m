Received: from mail-m128101.netease.com (mail-m128101.netease.com [103.209.128.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421B9500943
	for <linux-block@vger.kernel.org>; Sat, 17 Jan 2026 05:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.209.128.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768627131; cv=none; b=MAVlDbqg0bAFeKEHZH6SrZps8rMdO9BiCNFkqGzJf7VwBItcnJZkzh2sa2JIoaQ97BS4PAsiNC7n1RCFJddTLxqKeFSmhsAZurW4OIZFP2ZR6P8sMU63T3o+HUjefwLPQEz8efdeSuxaVn0ncksar5DTyE2nU2C4DN5q3FDMsM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768627131; c=relaxed/simple;
	bh=8r5wFucXdMyxtTFpFZa7H2Vcm+iryunWmBHPSU4k1yk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pLwfv4EdibHT6qeK6695d3MAOYCgDTNfY4ia0G15gRdvEOWvBgVI/WM/j+e8WKqeUJsbDHrmBFIL2PXN4y6ip907vj+mS2hGomFbf1hRe/WC2VqhwhPCkncXNpIxa+xb+pDetKX+DYmysWIL0f5K0it3vBhoyeUC3DNVhMqOyzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deepseek.com; spf=pass smtp.mailfrom=deepseek.com; dkim=pass (1024-bit key) header.d=deepseek.com header.i=@deepseek.com header.b=JVg5Xaug; arc=none smtp.client-ip=103.209.128.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deepseek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepseek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepseek.com header.i=@deepseek.com header.b="JVg5Xaug"
Received: from localhost.localdomain (unknown [IPV6:2402:f000:5:c001:5d8e:8961:95e5:4104])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30fafaaea;
	Sat, 17 Jan 2026 13:18:39 +0800 (GMT+08:00)
From: huang-jl <huang-jl@deepseek.com>
To: ming.lei@redhat.com
Cc: huang-jl@deepseek.com,
	linux-block@vger.kernel.org,
	axboe@kernel.dk
Subject: Re: [BUG] ublk: ublk server hangs in D state during STOP_DEV
Date: Sat, 17 Jan 2026 13:18:39 +0800
Message-Id: <20260117051839.48905-1-huang-jl@deepseek.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <aWpSHIBn_1W_Xo9h@fedora>
References: <aWpSHIBn_1W_Xo9h@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bca6426b809d9kunm7733a37671c814
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSEJPVkhIQxhMTBgdTENPS1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlJT0tJQR1LS0tBTkEYS0tKQU4fQx5BQ0JNSkFCTh5OQU9KS09ZV1kWGg
	8SFR0UWUFZT0tIVUpLSUJNS0pVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=JVg5XaugK0qjls/zKK6aCg10+BGCFEo39mAxlaaptHP2LGRqAn2EsaFPB6MBC154TKTUTNArZOIftRUqx7BYbG8s3vRMcS22BmpPMZ43c8sWL98oJCX+r1kSzaU4VG7MamIRTycv03eCQkW70/ROYOAi3/wE+RICWGbxx0J7QPE=; c=relaxed/relaxed; s=default; d=deepseek.com; v=1;
	bh=AoiUSLR4xgnaeiGAGXVhouOnUnFfUseLDKmhlT/do0Y=;
	h=date:mime-version:subject:message-id:from;

Hi Ming,

I've completed further investigation and share my thoughts.

## Summary

The deadlock is caused by WBT (Writeback Throttling) holding a folio lock
while waiting for I/O completion that will never happen because the ublk
server is dead.

## Stuck Tasks Analysis

There are three tasks in D state:

- 348911 (iou-wrk): wchan=folio_wait_bit_common
  ublk server's io-wq worker, waiting for folio lock

- 77625 (kworker/303:0+events): wchan=folio_wait_bit_common
  Waiting for folio lock

- 355239 (kworker/u775:1+flush-259:11): wchan=rq_qos_wait
  **Holds folio lock**, stuck in WBT throttle

## Root Cause

The flush worker (355239) is the key. Its stack:

[<0>] rq_qos_wait
[<0>] wbt_wait
[<0>] __rq_qos_throttle
[<0>] blk_mq_submit_bio
[<0>] __submit_bio
[<0>] submit_bio_noacct_nocheck
[<0>] submit_bio_noacct
[<0>] submit_bio
[<0>] submit_bh_wbc
[<0>] __block_write_full_folio      <- folio is LOCKED here
[<0>] block_write_full_folio
[<0>] write_cache_pages
...

Looking at __block_write_full_folio() in fs/buffer.c:

    int __block_write_full_folio(...)
    {
        // ... prepare buffers ...

        folio_start_writeback(folio);

        do {
            struct buffer_head *next = bh->b_this_page;
            if (buffer_async_write(bh)) {
                submit_bh_wbc(...);    // <- 355239 stuck HERE in wbt_wait()
                nr_underway++;
            }
            bh = next;
        } while (bh != head);

        folio_unlock(folio);           // <- Never reached!
    }

The folio lock is acquired before submit_bh_wbc() and released after.
When WBT throttles inside submit_bh_wbc(), the folio remains locked.

## WBT State

From debugfs on the stuck device:

    $ cat /sys/kernel/debug/block/ublkb197/rqos/wbt/wb_normal
    48
    $ cat /sys/kernel/debug/block/ublkb197/rqos/wbt/wb_background
    24
    $ cat /sys/kernel/debug/block/ublkb197/rqos/wbt/inflight
    0: inflight 58
    1: inflight 0
    2: inflight 0

There are 58 inflight requests, exceeding the wb_normal limit of 48.
WBT is throttling new submissions, waiting for inflight I/O to complete.
But since the ublk server is dead, these I/Os will never complete, and
wbt_done() will never be called to wake up the waiter.

## Deadlock Chain

1. ublk server receives SIGINT
   -> Sends STOP_DEV via io_uring

2. io-wq worker (348911) handles STOP_DEV
   -> ublk_stop_dev() -> del_gendisk() -> bdev_mark_dead()
   -> Triggers writeback of dirty pages

3. Flush worker (355239) is already doing writeback
   -> Locks folio, calls submit_bh_wbc()
   -> WBT throttles (58 inflight > 48 limit)
   -> Stuck in wbt_wait(), HOLDING folio lock

4. ublk server receives SIGKILL
   -> Cannot handle any I/O requests
   -> 58 inflight requests stuck forever
   -> wbt_done() never called
   -> 355239 never wakes up, holds folio lock forever

5. io-wq worker (348911) tries to flush pages
   -> Tries to lock the same folio
   -> Stuck in folio_wait_bit_common()

6. Main ublk server thread (348910)
   -> do_exit() -> io_wq_put_and_exit()
   -> Waiting for worker 348911 to finish
   -> DEADLOCK

This seems like a general issue might affect any userspace block device
(ublk, tcmu, nbd, etc.) when WBT is enabled. Has this been discussed
before?

Thanks,
huang-jl
