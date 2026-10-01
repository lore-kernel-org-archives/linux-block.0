Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B4B2DECBF
	for <linux-block@vger.kernel.org>; Thu,  1 Oct 2026 03:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790824246; cv=none; b=gieLcEQF5amozbNAUeNgepDG+JpYWsc7Pi4F3I4IGqQ+5IRl45ur4BFM1rr89ydfenwfSR7V5g/e6sKa9ojmwRt8HRnwYQ66C5185vASye/pmxHJ9bMfU2rjZQ/UZQRWyr1GxRdLB+N7c4URGII6VmRboaQMc0FgEXfNy2T+ASQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790824246; c=relaxed/simple;
	bh=7//85heVGXO9H7UfS8HzbcjadhZneA7l3g7DTGwUt4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dILUKIZ6sNJbbD4g0LU2pGrx5BEr6qWM17B7os15q8MTlDIwei6WTKXeAqs11vYkeNSZ2RFbyCwREzLD2m4g2JaTirptB3UHIQQdTywyCMxzMl97CXoy6VPY68LdlOuyh+aaALaLM2ObTvtzwLl6QLZect38znVhggnKZtL/280=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqdTAd1N; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqdTAd1N"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd025d07so5321590c88.2
        for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 20:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790824244; x=1791429044; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=du/Qj4NGycFo/+y1OZ+i6rvXhibgURTGLPw6IzkgrIM=;
        b=QqdTAd1NJqRaqEOPthZLgo3Uldv9YmO90+cu/ylqIf4yUlBBUBr0UmVVDX0GW3Ktzq
         QXQ0Ypo5BtV3LHJTv2TCzMoOJKVfW2MMsKv0PK3J4AUoiuubkoHoJT85e9z/9HvKkWAJ
         7MNASBeI0Ky+bohLUEtaNtqYhMEiRQmWSoMJDcPctkMTp7/euy9yhJkG4RaQ0d6nc7yy
         6BtDfqFfMRCVMnuDubaqmz3Z3YtGJ+hKp5OOGIU2gXMWDnvm4guhQrJxrwH6Nnugsiq1
         Iow2qejziQcqH9UBxXmM0Z3bA3rr6vjqFmA2BDPMm3RKWQLD1wPhwvclWskTwd1m57FN
         asdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790824244; x=1791429044;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=du/Qj4NGycFo/+y1OZ+i6rvXhibgURTGLPw6IzkgrIM=;
        b=y8eIeTkEqOIAcRUctac3QNDtVymhkxAS/N8EFMAtTDU/T2dRQJunUjW83bUperLsIO
         vOPW3z+ujL10WH91lkKHeyaWoC62aOcF9PEq8Hn0bRSCSgrCAQqMNqZG3tnYz4CZoiU6
         Pw3d2ajxQFvJPeOoYeKvHtre0yRJGY63gcsjV+QS+zJNaFZ1Rc9FQ12q3Hj9SSRgY+sY
         QDWQopNXqRZWiJUOucOtvIJqOxlt1eGCSg3TejV2s3RXtYPr1NROh8QfNQ1lUEakGdhp
         Molk0E0IkFrze9BHc44uhOM1vsWu+A5SKbw7cYRP9PVrP8JXv725ypUul1NH0r8qbrG2
         hmcQ==
X-Gm-Message-State: AFq9FYI/LWieeTOXw0+az8YTlNHEEdnH4esp+1fXjhD+vEZfSCgaNc8F
	7DNcqC5MppPQ2gXldHoblFBtWG7DYnmW+G+JYibpGsbCMfn1aQx9FbNw
X-Gm-Gg: AYBFou2lVQOrEZtBAhBqQnTx69EYqBNua9FU7SAakgAT9z+L2jB+sWKg3cp5IJURpPT
	cSori/RkIuqhQd2ZXkmhFz4IKxgfTVo6HGEK493WkKsLA5pJpSLEXoc8ucqLJVzwD+1HCqLta3v
	Qh4osVRXz4z+EUYGMb+ZTw77ib4ZWj6lf8xIGMuEkyMtbDbMLgDVdTLUSj7xgxa7An7baR4C6vv
	I4faLWYDkpRx3u8f57zcTIGhevDp5rQBe+bzpmYmvI1J3HMyBKcNz+hiBPaf4FhsWlY0+025SSX
	tUjuNxytTE12XbW5O9Uw36MiuyNs5wGE1Vxu69qUnP7KLZAr0FpyoAue37CPoO3fWzvXgxnqpf2
	ZBrTMhFIW7HnJLVgUPqT7KarCOtRsaZNt/3XP8lOyn0aB3U5bQqBFBwllsRfGc+GvevWtbym/oi
	mfhMjUo0/6XpPpraETR/1YMrExnQ5xddQhbKmqQFtXWdyTAsUoPeetKga6Pay5qS+Mlg==
X-Received: by 2002:a05:7301:3a94:b0:339:79c9:a711 with SMTP id 5a478bee46e88-34cdcfaaccbmr3339009eec.33.1790824243878;
        Wed, 30 Sep 2026 20:10:43 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34db4926277sm3131875eec.25.2026.09.30.20.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 20:10:43 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Thu, 01 Oct 2026 11:10:40 +0800
Subject: [PATCH] ublk: don't use an I/O scheduler by default
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-bug-ublk-no-sched-by-default-v1-1-0bc91b6f075e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAC/PvWoC/x3MQQ6DIBAAwK+YPXcTsJaoX2l6AFlwo0EDpdEY/
 i7pcS5zQaLIlGBsLoj048RbqJCPBqZZB0/Ithpa0SophESTPWazLhg2TNNMFs2JlpzO6xeVez2
 d7vp+IAW12CM5Pv79+1PKDf8HhtpuAAAA
To: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

Requests of a ublk device are handed to the ublk server through
io_uring, and the server does its own queueing and ordering, so an I/O
scheduler in front of the device only adds overhead. A single-queue
ublk device still gets mq-deadline by default, which costs throughput
on every I/O and an elevator setup on every START_DEV.

Set BLK_MQ_F_NO_SCHED_BY_DEFAULT so that add_disk() selects "none", as
loop does since commit 2112f5c1330a ("loop: Select I/O scheduler 'none'
from inside add_disk()"). Doing it in the kernel also avoids switching
the scheduler from user space after the device has been added, which
waits for RCU grace periods. A scheduler can still be selected through
sysfs. Zoned ublk devices don't need mq-deadline either, zone write
plugging serializes writes per zone in the block layer since
commit fde02699c242 ("block: mq-deadline: Remove support for zone write
locking").

ublk null target, single-queue devices with depth 16, fio io_uring 4k
randread at iodepth=16, 16 vCPU KVM guest:

                                 mq-deadline       none
  1 device                          111K IOPS   342K IOPS
  4 devices                         286K IOPS  1070K IOPS
  START_DEV p50 (1000 devices)        8.53ms      0.36ms

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
Zoned ublk devices were not tested at runtime: none of the ublk servers
at hand (ublksrv, the kublk selftest server) serves zoned I/O.
---
 drivers/block/ublk_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 66eb55e7162e5..8053666c04482 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -4389,6 +4389,7 @@ static int ublk_add_tag_set(struct ublk_device *ub)
 	ub->tag_set.nr_hw_queues = ub->dev_info.nr_hw_queues;
 	ub->tag_set.queue_depth = ub->dev_info.queue_depth;
 	ub->tag_set.numa_node = NUMA_NO_NODE;
+	ub->tag_set.flags = BLK_MQ_F_NO_SCHED_BY_DEFAULT;
 	ub->tag_set.driver_data = ub;
 	return blk_mq_alloc_tag_set(&ub->tag_set);
 }

---
base-commit: 551c722f40809618230001baccf219193e22fc5a
change-id: 20261001-bug-ublk-no-sched-by-default-6f53fa4889e6

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

