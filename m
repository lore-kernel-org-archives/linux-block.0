Received: from mail-oo2-f35.google.com (mail-oo2-f35.google.com [74.125.231.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A49352003
	for <linux-block@vger.kernel.org>; Thu,  1 Oct 2026 12:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859305; cv=none; b=olvusNz/JV6EKBbn7e1PxNmmdTxxnHvc6QCT+rUpiAqTpBUanj3HACTaSqTRQsZ3Dwe9P74B3F4/zjDWT+BjbTbDBCkY8Tlrhod+e61ADCiZKGKMuVY7ISvsEwT27VHJVNe+gQyGF3i23TYChfjqRr+9NXQghmCc0tDk1uTXWYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859305; c=relaxed/simple;
	bh=dw3zJjc1I8bH8qjtFPdXnrz9Ck3rJ8P/Hvx1fYZzcAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTyN2IKsM1+KGUCe0N64SPfNJm+55J61mJVPb2ZTfNzbhGiWFOCx4MZ96P4x/FUISV3ZbtgsoO8P/QDTjay2Nn1ZwZA1kLmLAD0UlR4q94MCCtGppATEn8URgew2CmfvMHIF1SFvhAjVM2YmgJaYAJ7BPjr1XWPnlGR5aGmgUiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qEwz+FiP; arc=none smtp.client-ip=74.125.231.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEwz+FiP"
Received: by mail-oo2-f35.google.com with SMTP id 46e09a7af769-821ab84c100so292425a34.1
        for <linux-block@vger.kernel.org>; Thu, 01 Oct 2026 05:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790859302; x=1791464102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zaOn4qIYogduqbPep7kdoQ/ZPmfFfKk7bxfs29Oidpw=;
        b=qEwz+FiPbAnfNFy3KNE/i/PUTUWBggznE8A+SOQ3jYjSxV0ye+80GhV1BeSpsnIHdm
         NKTr5mPB6Mk+Yv0dTVWItm3tFWWieZFQf933zjzmxAwjgqQR1dsyD+dDQgr7FLluQ7E9
         T9PSk2yhvbYxXVEYUbvQ+eFylj3ocCIB5W+K57/0WnT/m9LzGusHUT5Fdrd2u/JGLLmE
         erRCtqfxlUpLe0O3TBAEI+Uu+lhYR/n2LhdMYuA7R0e2LTehUaZiCznKeiAqT0nzRASJ
         gy2BrGULmNHuzbCnkzuj/6S3+V84H5X9sj8gknga5bbUsqzYVdDuKoB1+NHjPinzBaZ6
         auqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790859302; x=1791464102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zaOn4qIYogduqbPep7kdoQ/ZPmfFfKk7bxfs29Oidpw=;
        b=qZW9LTE/7C2+tQuVCbQQpsLOdT8OLTZ/A1pYiBnX1y1M/yTFMs1e4Z4LPX4hl95lDa
         tWY42bZ4Z5qGBsShgWEYrftx3udKeQBohhYZBO7pzoWZFrMdSv+sB2AYV0QfUMF+6k80
         TIpuO6rSfS6K/f89TnwQtIp1CSCTLvatN+46UYFQo5UNYT8++CITRJD+J+5/W8+rcpIK
         8UoxbZ7cvZL6rxZroAm8q8fsMChX2FZkl1+7R+SnZIwzHF0XMARKDp73uSoL1BnRv3Fc
         SU7fMzGAN3YsYCABGrU4uCKNsI1TYjPw7iUWH3D60tmd2mGOWqtta5409RyIFqT4DrKd
         iTSQ==
X-Gm-Message-State: AFuF++lRNfFtCw5ah8jGcaeLw0bbzIrYn41VJhYttdle2xKK2FyHvY+6
	gxFhz1ZVfqVvrebKDQ6tRMGrt12RacNY2u1Xw18h2mjix95WzZhBLrn7rKd61g==
X-Gm-Gg: AYBFou09HBJxhYLJIWqFAG2bkHUPwmFMsyAbODzm3/otCqzAihuyNuhTCJQZnKBohLu
	a9JpPHIlWr/CKF7q4ikstRdyrI/IxpZbEn4t7c3Y9j4pt2ZpCNz150lju/olpmzgHvNKR/CiAY7
	jtQrj5QzUvvmfJfur8acUkY2mHzrz8CSWDbcUFvAiMdLuEpznKzs/37MZSm5a4sgoOgYNfGueze
	ll4cHTRtN+fOofRDz/b4NDApndFF5Sq4/nN1lfm7DB9iictB8CU0wbZ6FhqXgGrRbbAtxNH/UeK
	Q7n+oXatajN9NVOZysUxpfSiJ1TRfGXGHTfVmFNeaXU/Wm6rdDreWwuesrB4Bz37bpaEyjnUWFs
	NoL3Uu03v/H0iqpWjvEV65kw5ZmZUHTHOY+TWyVWaZ575/5S8Z2/nEfljEUOBul45POPBq/18EW
	smJTX1gvwdpazNfD7qC8LUzsaXD6aR35mI9qYgf6NVXQRfCVZtgBD3lmpQXR7ONdM9SORscpYBg
	dnIHErIlMsmAtuABvIkn2U8OMZAhAX1Skd9CwFqju8pcsskEaPAtPuLx0TK6OIPbqfz52iA3sEg
	3S1D8X6ULfovXhFdrdhnCRmL7hM=
X-Received: by 2002:a9d:3e08:0:b0:822:539b:24d1 with SMTP id 46e09a7af769-822539b5ee3mr46712a34.2.1790859301460;
        Thu, 01 Oct 2026 05:55:01 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8212b937bf2sm2504806a34.27.2026.10.01.05.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 05:55:01 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: linux-block@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 8/8] selftests: ublk: add test for going live over canceled io commands
Date: Thu,  1 Oct 2026 07:54:22 -0500
Message-ID: <20261001125422.1364260-9-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001125422.1364260-1-tom.leiming@gmail.com>
References: <20261001125422.1364260-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ublk_cancel_ready, a small liburing program which sends control
commands with kublk's helpers from ctrl.c, and test_generic_18.sh,
which runs its modes:

  mode               what it does                     expected
  stop_start         STOP_DEV before START_DEV        START_DEV -EBUSY
  partial_fetch      task A fetches tags 0-2 and      START_DEV -ENODEV, or
                     dies, then task B fetches tag 3  live and reads -EIO
  recovery           in user recovery, queue 0's      END_USER_RECOVERY
                     task dies before queue 1 is      -ENODEV, or live and
                     ready                            reads -EIO
  stop_restart       STOP_DEV on a new device, then   START_DEV 0,
                     a server starts it               reads succeed
  stop_attached      STOP_DEV after open, before      FETCH ABORT and
                     FETCH, then a new server         START_DEV -EBUSY,
                                                      then a new one works
  stop_live_restart  STOP_DEV on a live device, then  FETCH and START_DEV
                     a new server starts it           0, reads succeed
  race_start         STOP_DEV and START_DEV at the    START_DEV 0 and
                     same time, 50 times              reads complete,
                                                      or -EBUSY
  race_fetch         STOP_DEV while a server opens    START_DEV 0 and
                     and fetches, then START_DEV,     reads succeed,
                     50 times                         or -EBUSY
  race_async_fetch   IOSQE_ASYNC FETCH while STOP_DEV no crash (KASAN
                     cancels, then close the ring     finds the bug)

If the device goes live, the test reads it, so an unfixed kernel shows
the oops in ublk_queue_cmd(). In stop_live_restart, an unfixed kernel
doesn't reset the FETCH round in ublk_ch_release() once the disk is
gone, so the new server's FETCH gets -EBUSY.

A dying task is a child process which fetches and then calls exec().
exec() cancels the task's uring_cmds before it returns, so the cancel
is done once the child is reaped, with no sleep. kublk can't be used:
its failure injection kills the whole process, which closes
/dev/ublkcN and starts a new round.

Link: https://lore.kernel.org/linux-block/20260928-b4-ublk-cancel-stop-v1-0-4a4360232a46@toxicpanda.com/
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
Assisted-by: LLM
---
 tools/testing/selftests/ublk/.gitignore       |   1 +
 tools/testing/selftests/ublk/Makefile         |   6 +-
 .../testing/selftests/ublk/test_generic_18.sh |  37 +
 .../selftests/ublk/ublk_cancel_ready.c        | 984 ++++++++++++++++++
 4 files changed, 1026 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_18.sh
 create mode 100644 tools/testing/selftests/ublk/ublk_cancel_ready.c

diff --git a/tools/testing/selftests/ublk/.gitignore b/tools/testing/selftests/ublk/.gitignore
index e17bd28f27e0..d8e93fef7fcd 100644
--- a/tools/testing/selftests/ublk/.gitignore
+++ b/tools/testing/selftests/ublk/.gitignore
@@ -3,3 +3,4 @@
 /tools
 kublk
 metadata_size
+ublk_cancel_ready
diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 37883e9d50ec..fc64b8f02833 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -19,6 +19,7 @@ TEST_PROGS += test_generic_12.sh
 TEST_PROGS += test_generic_13.sh
 TEST_PROGS += test_generic_16.sh
 TEST_PROGS += test_generic_17.sh
+TEST_PROGS += test_generic_18.sh
 
 TEST_PROGS += test_batch_01.sh
 TEST_PROGS += test_batch_02.sh
@@ -76,13 +77,14 @@ TEST_FILES := settings
 TEST_FILES += test_common.sh
 TEST_FILES += trace
 
-TEST_GEN_PROGS_EXTENDED = kublk metadata_size
-STANDALONE_UTILS := metadata_size.c
+TEST_GEN_PROGS_EXTENDED = kublk metadata_size ublk_cancel_ready
+STANDALONE_UTILS := metadata_size.c ublk_cancel_ready.c
 
 LOCAL_HDRS += $(wildcard *.h)
 include ../lib.mk
 
 $(OUTPUT)/kublk: $(filter-out $(STANDALONE_UTILS),$(wildcard *.c))
+$(OUTPUT)/ublk_cancel_ready: ublk_cancel_ready.c ctrl.c
 
 check:
 	shellcheck -x -f gcc *.sh
diff --git a/tools/testing/selftests/ublk/test_generic_18.sh b/tools/testing/selftests/ublk/test_generic_18.sh
new file mode 100755
index 000000000000..223944dba149
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_18.sh
@@ -0,0 +1,37 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+ERR_CODE=0
+CANCEL_PROG="$(_ublk_test_top_dir)/ublk_cancel_ready"
+
+_prep_test "generic" "start device over canceled io commands"
+
+# the modes are described in ublk_cancel_ready.c
+for mode in stop_start partial_fetch recovery stop_restart stop_attached \
+		stop_live_restart race_start race_fetch race_async_fetch; do
+	dmesg_before=$(dmesg | wc -l)
+	timeout 60 "$CANCEL_PROG" "$mode" > "$UBLK_TMP" 2>&1
+	res=$?
+	msg=""
+
+	if dmesg | tail -n +"$((dmesg_before + 1))" | \
+			grep -q -e "BUG:" -e "Oops" -e "WARNING:"; then
+		msg="$mode: kernel oops/warning"
+		ERR_CODE=255
+	elif [ "$res" -eq "$UBLK_SKIP_CODE" ]; then
+		[ "$ERR_CODE" -eq 0 ] && ERR_CODE=$UBLK_SKIP_CODE
+	elif [ "$res" -ne 0 ]; then
+		msg="$mode: failed ($res)"
+		ERR_CODE=255
+	fi
+	# the output once: on failure, or always when not quiet
+	[ -n "$msg" ] && echo "$msg"
+	if [ -n "$msg" ] || [ "$UBLK_TEST_QUIET" -eq 0 ]; then
+		cat "$UBLK_TMP"
+	fi
+done
+
+_cleanup_test
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/ublk_cancel_ready.c b/tools/testing/selftests/ublk/ublk_cancel_ready.c
new file mode 100644
index 000000000000..0ed0d01fa74a
--- /dev/null
+++ b/tools/testing/selftests/ublk/ublk_cancel_ready.c
@@ -0,0 +1,984 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Bring a ublk device live while some of its fetched io commands are
+ * canceled.
+ *
+ * A cancel completes a fetched command and clears io->cmd, but the io
+ * still counts as ready. Only ubq->canceling keeps ublk_queue_rq() away
+ * from the NULL io->cmd. Each mode below loses ->canceling in another way:
+ *
+ * stop_start:    fetch every tag, STOP_DEV before START_DEV, START_DEV.
+ *                STOP_DEV cancels the commands of the attached server,
+ *                so START_DEV must get -EBUSY until that server is gone.
+ *                An unfixed kernel starts the device over them.
+ *
+ * partial_fetch: task A fetches tags 0..depth-2 and dies, so its
+ *                commands are canceled. Task B fetches the last tag, and
+ *                an unfixed kernel clears ->canceling when the queue gets
+ *                ready. /dev/ublkcN stays open all the time, so
+ *                ublk_ch_release() never resets the queue.
+ *
+ * recovery:      a UBLK_F_USER_RECOVERY device with two queues loses its
+ *                server. During recovery task Q0 fetches queue 0, which
+ *                clears q0->canceling, then dies. An unfixed kernel still
+ *                has ub->canceling set because queue 1 is not ready, so
+ *                ublk_start_cancel() does not mark queue 0 again. Reads
+ *                are issued on a CPU mapped to queue 0.
+ *
+ * In partial_fetch and recovery, START_DEV / END_USER_RECOVERY may refuse
+ * with -ENODEV, or bring the device live with its queue still canceling:
+ * then every read has to complete, with -EIO. An unfixed kernel oopses
+ * in ublk_queue_cmd() on a NULL io->cmd.
+ *
+ * stop_restart:  control mode. STOP_DEV on a new device, before any
+ *                server opened it, takes no command. A server started
+ *                afterwards has to start the device and serve I/O.
+ *
+ * stop_attached: STOP_DEV on a device whose server opened it but fetched
+ *                nothing stops that server too: FETCH gets ABORT and
+ *                START_DEV -EBUSY, until a new server opens the device.
+ *
+ * stop_live_restart: STOP_DEV on a live device; once its server is gone,
+ *                a new server has to fetch and start it again. An unfixed
+ *                ublk_ch_release() skips the reset once the disk is gone,
+ *                so the new FETCH gets -EBUSY.
+ *
+ * race_start:    STOP_DEV and START_DEV at the same time on a device whose
+ *                server fetched every tag. START_DEV either wins, and
+ *                reads complete (they fail once STOP_DEV removes the
+ *                disk), or gets -EBUSY. An unfixed kernel cancels the
+ *                commands of the live disk.
+ *
+ * race_fetch:    STOP_DEV while a server opens the device and fetches,
+ *                then START_DEV. If STOP_DEV came before the open, it must
+ *                not take any command, so START_DEV works and every read
+ *                succeeds; otherwise START_DEV gets -EBUSY. An unfixed
+ *                kernel takes commands fetched after its unlock and goes
+ *                live over them.
+ *
+ * race_async_fetch: FETCH with IOSQE_ASYNC while STOP_DEV cancels,
+ *                then close the ring. An unfixed FETCH marks its command
+ *                cancelable only after publishing it and dropping
+ *                ub->mutex; a cancel in between completes a command which
+ *                is then put on io_uring's cancelable list. Closing the
+ *                ring walks that list: KASAN reports a use after free.
+ *                Needs a KASAN kernel to see the bug; otherwise it must
+ *                just not crash.
+ *
+ * A dying task is a child process which fetches and then calls exec().
+ * exec() cancels the task's uring_cmds before it returns, so the cancel
+ * is done once the child is reaped. A thread exit does not cancel them,
+ * and closing the ring cancels them later, from io_ring_exit_work().
+ */
+#include <sched.h>
+
+#include "kublk.h"
+#include "../kselftest.h"
+
+#define NR_QUEUES	2
+#define DEPTH		4
+#define BUF_SIZE	(64 << 10)
+#define DEV_SECTORS	(64 << 11)	/* 64MB */
+#define NR_READS	(DEPTH * 2)
+#define SERVE_DELAY_US	200000
+#define RACE_LOOPS	50
+#define ASYNC_LOOPS	300
+
+/* one control handle per thread, the race modes send commands from two */
+static __thread struct ublk_dev *ctrl_dev;
+static int cdev_fd = -1;
+static int dev_id = -1;
+static int nr_queues;
+static void *bufs[NR_QUEUES][DEPTH];
+static const struct ublksrv_io_desc *iods[NR_QUEUES];
+static size_t iods_len;
+
+static struct io_uring_sqe *get_sqe(struct io_uring *ring)
+{
+	struct io_uring_sqe *sqe = io_uring_get_sqe(ring);
+
+	if (!sqe) {
+		fprintf(stderr, "out of sqes\n");
+		exit(KSFT_FAIL);
+	}
+	return sqe;
+}
+
+static struct ublk_dev *ctrl(void)
+{
+	if (!ctrl_dev) {
+		ctrl_dev = ublk_ctrl_init();
+		if (!ctrl_dev) {
+			fprintf(stderr, "ublk_ctrl_init failed\n");
+			exit(KSFT_FAIL);
+		}
+	}
+	ctrl_dev->dev_info.dev_id = dev_id;
+	return ctrl_dev;
+}
+
+static void ctrl_put(void)
+{
+	if (ctrl_dev)
+		ublk_ctrl_deinit(ctrl_dev);
+	ctrl_dev = NULL;
+}
+
+static int dev_state(void)
+{
+	struct ublk_dev *dev = ctrl();
+	int ret = ublk_ctrl_get_info(dev);
+
+	return ret ? ret : dev->dev_info.state;
+}
+
+static int open_cdev(void)
+{
+	size_t max_len = UBLK_MAX_QUEUE_DEPTH * sizeof(struct ublksrv_io_desc);
+	int pg = getpagesize();
+	char path[64];
+
+	snprintf(path, sizeof(path), "/dev/ublkc%d", dev_id);
+	for (int i = 0; i < 100 && cdev_fd < 0; i++) {
+		cdev_fd = open(path, O_RDWR);
+		if (cdev_fd < 0)
+			usleep(50000);
+	}
+	if (cdev_fd < 0)
+		return -errno;
+
+	/* queue q's descriptors start at q * the size for the max depth */
+	max_len = (max_len + pg - 1) & ~(size_t)(pg - 1);
+	iods_len = (DEPTH * sizeof(struct ublksrv_io_desc) + pg - 1) &
+		~(size_t)(pg - 1);
+	for (int q = 0; q < nr_queues; q++) {
+		void *p = mmap(NULL, iods_len, PROT_READ,
+			       MAP_SHARED | MAP_POPULATE, cdev_fd,
+			       UBLKSRV_CMD_BUF_OFFSET + q * max_len);
+
+		if (p == MAP_FAILED)
+			return -errno;
+		iods[q] = p;
+	}
+	return 0;
+}
+
+/* the last reference to /dev/ublkcN runs ublk_ch_release() */
+static void close_cdev(void)
+{
+	for (int q = 0; q < nr_queues; q++) {
+		if (iods[q])
+			munmap((void *)iods[q], iods_len);
+		iods[q] = NULL;
+	}
+	if (cdev_fd >= 0)
+		close(cdev_fd);
+	cdev_fd = -1;
+}
+
+/* ADD_DEV and SET_PARAMS, without opening /dev/ublkcN */
+static int add_dev_noopen(int queues, __u64 flags)
+{
+	struct ublk_dev *dev = ctrl();
+	struct ublksrv_ctrl_dev_info info = {
+		.nr_hw_queues	= queues,
+		.queue_depth	= DEPTH,
+		.max_io_buf_bytes = BUF_SIZE,
+		.dev_id		= -1,
+		.flags		= UBLK_F_NO_AUTO_PART_SCAN | flags,
+	};
+	struct ublk_params p = {
+		.types	= UBLK_PARAM_TYPE_BASIC,
+		.basic	= {
+			.logical_bs_shift	= 9,
+			.physical_bs_shift	= 12,
+			.io_opt_shift		= 12,
+			.io_min_shift		= 9,
+			.max_sectors		= BUF_SIZE >> 9,
+			.dev_sectors		= DEV_SECTORS,
+		},
+	};
+	int ret;
+
+	nr_queues = queues;
+	dev->dev_info = info;
+	ret = ublk_ctrl_add_dev(dev);
+	if (ret)
+		return ret;
+	dev_id = dev->dev_info.dev_id;
+
+	ret = ublk_ctrl_set_params(ctrl(), &p);
+	if (ret)
+		return ret;
+
+	for (int q = 0; q < queues; q++)
+		for (int i = 0; i < DEPTH; i++)
+			if (!bufs[q][i] &&
+			    posix_memalign(&bufs[q][i], getpagesize(), BUF_SIZE))
+				return -ENOMEM;
+	return 0;
+}
+
+static int add_dev(int queues, __u64 flags)
+{
+	return add_dev_noopen(queues, flags) ?: open_cdev();
+}
+
+static void cleanup(void)
+{
+	if (dev_id < 0)
+		return;
+	ublk_ctrl_stop_dev(ctrl());
+	close_cdev();
+	ublk_ctrl_del_dev(ctrl());
+	dev_id = -1;
+}
+
+/* race_async_fetch sets IOSQE_ASYNC on the io commands */
+static int io_cmd_sqe_flags;
+
+static void queue_io_cmd(struct io_uring *ring, __u32 op, int q, int tag,
+			 int res)
+{
+	struct io_uring_sqe *sqe = get_sqe(ring);
+	struct ublksrv_io_cmd *cmd = (struct ublksrv_io_cmd *)sqe->cmd;
+
+	memset(sqe, 0, sizeof(*sqe));
+	sqe->fd = cdev_fd;
+	sqe->opcode = IORING_OP_URING_CMD;
+	sqe->flags = io_cmd_sqe_flags;
+	ublk_set_sqe_cmd_op(sqe, op);
+	cmd->q_id = q;
+	cmd->tag = tag;
+	cmd->result = res;
+	cmd->addr = (__u64)(uintptr_t)bufs[q][tag];
+	io_uring_sqe_set_data64(sqe, (q << 16) | tag);
+}
+
+struct async_arg {
+	pthread_barrier_t go, stopped;
+};
+
+/*
+ * FETCH every tag with IOSQE_ASYNC, racing STOP_DEV, then close the ring once
+ * STOP_DEV returned: that walks io_uring's list of cancelable commands.
+ */
+static void *race_async_fn(void *data)
+{
+	struct async_arg *a = data;
+	struct io_uring ring;
+	int ok = !io_uring_queue_init(DEPTH, &ring, 0);
+
+	if (ok)
+		for (int tag = 0; tag < DEPTH; tag++)
+			queue_io_cmd(&ring, UBLK_U_IO_FETCH_REQ, 0, tag, 0);
+	pthread_barrier_wait(&a->go);
+	if (ok)
+		io_uring_submit(&ring);
+	pthread_barrier_wait(&a->stopped);
+	if (ok)
+		io_uring_queue_exit(&ring);
+	return NULL;
+}
+
+/* reap @nr completions of canceled fetch commands, return how many */
+static int reap_aborts(struct io_uring *ring, int nr)
+{
+	struct __kernel_timespec ts = { .tv_sec = 2 };
+	struct io_uring_cqe *cqe;
+	int aborted = 0;
+
+	while (nr--) {
+		if (io_uring_wait_cqe_timeout(ring, &cqe, &ts))
+			break;
+		if (cqe->res == UBLK_IO_RES_ABORT)
+			aborted++;
+		io_uring_cqe_seen(ring, cqe);
+	}
+	return aborted;
+}
+
+/*
+ * A server thread fetches @nr_tags tags of queue @q, then completes each
+ * request after @delay_us, until its commands are aborted.
+ */
+struct server {
+	int q, first_tag, nr_tags, delay_us;
+	int failed;	/* result which ended the serve loop, 0 if none */
+	pthread_t thread;
+	pthread_barrier_t fetched;
+	/* race_fetch: wait for @go and @race_delay_us, open, fetch one by one */
+	pthread_barrier_t go;
+	int race, race_delay_us;
+};
+
+static void *server_fn(void *data)
+{
+	struct server *s = data;
+	struct io_uring ring;
+	struct io_uring_cqe *cqe;
+
+	if (io_uring_queue_init(DEPTH, &ring, 0)) {
+		pthread_barrier_wait(&s->fetched);
+		return NULL;
+	}
+	if (s->race) {
+		pthread_barrier_wait(&s->go);
+		usleep(s->race_delay_us);
+		if (open_cdev()) {
+			pthread_barrier_wait(&s->fetched);
+			io_uring_queue_exit(&ring);
+			return NULL;
+		}
+	}
+	for (int tag = s->first_tag; tag < s->first_tag + s->nr_tags; tag++) {
+		queue_io_cmd(&ring, UBLK_U_IO_FETCH_REQ, s->q, tag, 0);
+		if (s->race)
+			io_uring_submit(&ring);
+	}
+	io_uring_submit(&ring);
+	pthread_barrier_wait(&s->fetched);
+
+	while (!io_uring_wait_cqe(&ring, &cqe)) {
+		int tag = cqe->user_data & 0xffff;
+		const struct ublksrv_io_desc *iod = &iods[s->q][tag];
+		int res = cqe->res;
+
+		io_uring_cqe_seen(&ring, cqe);
+		if (res != UBLK_IO_RES_OK) {
+			__atomic_store_n(&s->failed, res, __ATOMIC_RELEASE);
+			break;
+		}
+		usleep(s->delay_us);
+		res = ublksrv_get_op(iod) <= UBLK_IO_OP_WRITE ?
+			iod->nr_sectors << 9 : 0;
+		queue_io_cmd(&ring, UBLK_U_IO_COMMIT_AND_FETCH_REQ, s->q, tag,
+			     res);
+		io_uring_submit(&ring);
+	}
+	io_uring_queue_exit(&ring);
+	return NULL;
+}
+
+/* returns once the fetch commands are issued; with @race, call race_go() */
+static void server_start(struct server *s)
+{
+	pthread_barrier_init(&s->fetched, NULL, 2);
+	pthread_barrier_init(&s->go, NULL, 2);
+	pthread_create(&s->thread, NULL, server_fn, s);
+	if (!s->race)
+		pthread_barrier_wait(&s->fetched);
+}
+
+/* wait up to 5s for the serve loop of @s to end, return its result */
+static int server_wait_failed(struct server *s)
+{
+	int res = 0;
+
+	for (int i = 0; i < 500 && !res; i++) {
+		res = __atomic_load_n(&s->failed, __ATOMIC_ACQUIRE);
+		if (!res)
+			usleep(10000);
+	}
+	return res;
+}
+
+/*
+ * A task fetches @nr_tags tags of queue @q and dies. Returns once its
+ * commands are canceled, see the top of this file.
+ */
+static int fetch_and_die(int q, int first_tag, int nr_tags)
+{
+	int status;
+	pid_t pid = fork();
+
+	if (pid < 0)
+		return -1;
+	if (!pid) {
+		struct io_uring ring;
+
+		if (io_uring_queue_init(DEPTH, &ring, 0))
+			_exit(1);
+		for (int tag = first_tag; tag < first_tag + nr_tags; tag++)
+			queue_io_cmd(&ring, UBLK_U_IO_FETCH_REQ, q, tag, 0);
+		if (io_uring_submit(&ring) != nr_tags)
+			_exit(1);
+		execlp("true", "true", NULL);
+		_exit(1);
+	}
+	if (waitpid(pid, &status, 0) != pid || !WIFEXITED(status) ||
+	    WEXITSTATUS(status))
+		return -1;
+	printf("q%d: task died with %d fetch cmds in flight\n", q, nr_tags);
+	return 0;
+}
+
+struct reads {
+	struct io_uring ring;
+	void *buf;
+	int fd, done, ok, eio, other;
+};
+
+/*
+ * Issue NR_READS reads at once, from @cpu if it is not negative: blk-mq
+ * maps the submitting CPU to the hw queue. A server holding its live
+ * tags for a while makes the other reads take the canceled tags.
+ */
+static int open_tries = 100;	/* 50ms each */
+
+static int reads_submit(struct reads *r, int cpu)
+{
+	char path[64];
+	cpu_set_t set, old;
+
+	snprintf(path, sizeof(path), "/dev/ublkb%d", dev_id);
+	r->fd = -1;
+	for (int i = 0; i < open_tries && r->fd < 0; i++) {
+		r->fd = open(path, O_RDONLY | O_DIRECT);
+		if (r->fd < 0)
+			usleep(50000);
+	}
+	if (r->fd < 0) {
+		fprintf(stderr, "open %s: %s\n", path, strerror(errno));
+		return -1;
+	}
+	if (posix_memalign(&r->buf, 4096, NR_READS * 4096) ||
+	    io_uring_queue_init(NR_READS, &r->ring, 0))
+		return -1;
+
+	for (int i = 0; i < NR_READS; i++)
+		io_uring_prep_read(get_sqe(&r->ring), r->fd,
+				   r->buf + i * 4096, 4096, i * 4096);
+
+	if (cpu >= 0) {
+		sched_getaffinity(0, sizeof(old), &old);
+		CPU_ZERO(&set);
+		CPU_SET(cpu, &set);
+		sched_setaffinity(0, sizeof(set), &set);
+	}
+	io_uring_submit(&r->ring);
+	if (cpu >= 0)
+		sched_setaffinity(0, sizeof(old), &old);
+	return 0;
+}
+
+static void reads_reap(struct reads *r, int timeout_s)
+{
+	struct __kernel_timespec ts = { .tv_sec = timeout_s };
+	struct io_uring_cqe *cqe;
+
+	while (r->done < NR_READS &&
+	       !io_uring_wait_cqe_timeout(&r->ring, &cqe, &ts)) {
+		if (cqe->res == 4096)
+			r->ok++;
+		else if (cqe->res == -EIO)
+			r->eio++;
+		else
+			r->other++;
+		r->done++;
+		io_uring_cqe_seen(&r->ring, cqe);
+	}
+}
+
+static void reads_put(struct reads *r)
+{
+	io_uring_queue_exit(&r->ring);
+	close(r->fd);
+	free(r->buf);
+}
+
+static int reads_result(struct reads *r)
+{
+	printf("reads: %d ok, %d -EIO, %d other, %d not completed\n",
+	       r->ok, r->eio, r->other, NR_READS - r->done);
+	reads_put(r);
+	return r->other || r->done < NR_READS ? KSFT_FAIL : KSFT_PASS;
+}
+
+static int start_dev(void)
+{
+	int ret = ublk_ctrl_start_dev(ctrl(), getpid());
+
+	printf("START_DEV: %d\n", ret);
+	return ret;
+}
+
+static int expect_err(const char *what, int ret, int want)
+{
+	if (ret == want)
+		return KSFT_PASS;
+	fprintf(stderr, "%s: %d, expected %d\n", what, ret, want);
+	return KSFT_FAIL;
+}
+
+/* START_DEV must fail with @want; if it went live, show what a read does */
+static int start_dev_expect(int want)
+{
+	struct reads r = {};
+	int ret = start_dev();
+
+	if (!ret && !reads_submit(&r, -1)) {
+		reads_reap(&r, 10);
+		reads_result(&r);
+	}
+	return expect_err("START_DEV", ret, want);
+}
+
+/* -ENODEV, or live over a canceling queue: then reads must complete */
+static int expect_enodev_or_reads(const char *what, int ret, struct reads *r)
+{
+	if (ret == -ENODEV)
+		return KSFT_PASS;
+	if (ret) {
+		fprintf(stderr, "%s: %d, expected 0 or %d\n", what, ret,
+			-ENODEV);
+		return KSFT_FAIL;
+	}
+	reads_reap(r, 10);
+	return reads_result(r);
+}
+
+static int test_stop_start(void)
+{
+	struct io_uring ring;
+	int ret;
+
+	if (add_dev(1, 0))
+		return KSFT_FAIL;
+	if (io_uring_queue_init(DEPTH, &ring, 0))
+		return KSFT_FAIL;
+	for (int tag = 0; tag < DEPTH; tag++)
+		queue_io_cmd(&ring, UBLK_U_IO_FETCH_REQ, 0, tag, 0);
+	io_uring_submit(&ring);
+
+	/* device is ready but not started: state is UBLK_S_DEV_DEAD */
+	ret = ublk_ctrl_stop_dev(ctrl());
+	printf("STOP_DEV: %d, canceled fetch cmds: %d/%d\n", ret,
+	       reap_aborts(&ring, DEPTH), DEPTH);
+
+	/* STOP_DEV canceled the attached server: no start until it exits */
+	ret = start_dev_expect(-EBUSY);
+	io_uring_queue_exit(&ring);
+	return ret;
+}
+
+static int test_partial_fetch(void)
+{
+	struct server b = { .q = 0, .first_tag = DEPTH - 1, .nr_tags = 1,
+			    .delay_us = SERVE_DELAY_US };
+	struct reads r = {};
+	int ret;
+
+	if (add_dev(1, 0) || fetch_and_die(0, 0, DEPTH - 1))
+		return KSFT_FAIL;
+
+	/* the last FETCH makes the queue ready and clears ->canceling */
+	server_start(&b);
+
+	ret = start_dev();
+	if (!ret && reads_submit(&r, -1))
+		ret = KSFT_FAIL;
+	else
+		ret = expect_enodev_or_reads("START_DEV", ret, &r);
+
+	cleanup();
+	pthread_join(b.thread, NULL);
+	return ret;
+}
+
+static int test_stop_restart(void)
+{
+	struct server s = { .q = 0, .nr_tags = DEPTH };
+	struct reads r = {};
+	int ret;
+
+	if (add_dev_noopen(1, 0))
+		return KSFT_FAIL;
+
+	/* no server is attached, so there is nothing to cancel */
+	ret = ublk_ctrl_stop_dev(ctrl());
+	printf("STOP_DEV: %d\n", ret);
+	if (open_cdev())
+		return KSFT_FAIL;
+
+	server_start(&s);
+	if (start_dev()) {
+		ret = KSFT_FAIL;
+	} else if (reads_submit(&r, -1)) {
+		ret = KSFT_FAIL;
+	} else {
+		reads_reap(&r, 10);
+		ret = reads_result(&r);
+		if (r.ok != NR_READS)
+			ret = KSFT_FAIL;
+	}
+
+	cleanup();
+	pthread_join(s.thread, NULL);
+	return ret;
+}
+
+struct start_arg {
+	pthread_barrier_t go;
+	int ret, reads_ok;
+};
+
+static void *race_start_fn(void *data)
+{
+	struct start_arg *a = data;
+	struct reads r = {};
+
+	pthread_barrier_wait(&a->go);
+	a->ret = ublk_ctrl_start_dev(ctrl(), getpid());
+	a->reads_ok = 1;
+	/*
+	 * The disk may be gone already if STOP_DEV came right after, and
+	 * reads may fail then: they only have to complete.
+	 */
+	if (!a->ret && !reads_submit(&r, -1)) {
+		reads_reap(&r, 5);
+		a->reads_ok = r.done == NR_READS;
+		if (a->reads_ok)
+			reads_put(&r);
+		else
+			reads_result(&r);
+	}
+	ctrl_put();
+	return NULL;
+}
+
+static int test_race_start(void)
+{
+	int live = 0, ebusy = 0;
+
+	open_tries = 4;
+	for (int i = 0; i < RACE_LOOPS; i++) {
+		struct server s = { .q = 0, .nr_tags = DEPTH };
+		struct start_arg a = {};
+		pthread_t t;
+
+		if (add_dev(1, 0))
+			return KSFT_FAIL;
+		server_start(&s);
+		pthread_barrier_init(&a.go, NULL, 2);
+		pthread_create(&t, NULL, race_start_fn, &a);
+		pthread_barrier_wait(&a.go);
+		ublk_ctrl_stop_dev(ctrl());
+		pthread_join(t, NULL);
+		cleanup();
+		pthread_join(s.thread, NULL);
+
+		if (a.ret == 0)
+			live++;
+		else if (a.ret == -EBUSY)
+			ebusy++;
+		if ((a.ret && a.ret != -EBUSY) || !a.reads_ok) {
+			fprintf(stderr, "loop %d: START_DEV %d, reads %s\n",
+				i, a.ret, a.reads_ok ? "ok" : "failed");
+			return KSFT_FAIL;
+		}
+	}
+	printf("%d loops: START_DEV won %d, got -EBUSY %d\n", RACE_LOOPS,
+	       live, ebusy);
+	return KSFT_PASS;
+}
+
+static int test_race_fetch(void)
+{
+	int live = 0, ebusy = 0;
+
+	for (int i = 0; i < RACE_LOOPS; i++) {
+		/* vary who goes first: STOP_DEV, or the server's open */
+		struct server s = { .q = 0, .nr_tags = DEPTH, .race = 1,
+				    .race_delay_us = (i % 10) * 50 };
+		struct reads r = {};
+		int ret;
+
+		if (add_dev_noopen(1, 0))
+			return KSFT_FAIL;
+		server_start(&s);
+		pthread_barrier_wait(&s.go);
+		ublk_ctrl_stop_dev(ctrl());
+		pthread_barrier_wait(&s.fetched);
+
+		ret = ublk_ctrl_start_dev(ctrl(), getpid());
+		if (!ret) {
+			/* nothing was taken, so every read has to succeed */
+			live++;
+			if (reads_submit(&r, -1))
+				return KSFT_FAIL;
+			reads_reap(&r, 5);
+			if (r.ok != NR_READS) {
+				fprintf(stderr, "loop %d: live, but ", i);
+				reads_result(&r);
+				return KSFT_FAIL;
+			}
+			reads_put(&r);
+		} else if (ret == -EBUSY) {
+			ebusy++;
+		} else {
+			fprintf(stderr, "loop %d: START_DEV %d\n", i, ret);
+			return KSFT_FAIL;
+		}
+		cleanup();
+		pthread_join(s.thread, NULL);
+	}
+	printf("%d loops: START_DEV worked %d, got -EBUSY %d\n", RACE_LOOPS,
+	       live, ebusy);
+	return KSFT_PASS;
+}
+
+static int test_race_async_fetch(void)
+{
+	io_cmd_sqe_flags = IOSQE_ASYNC;
+	for (int i = 0; i < ASYNC_LOOPS; i++) {
+		struct async_arg a;
+		pthread_t t;
+
+		if (add_dev(1, 0))
+			return KSFT_FAIL;
+		pthread_barrier_init(&a.go, NULL, 2);
+		pthread_barrier_init(&a.stopped, NULL, 2);
+		pthread_create(&t, NULL, race_async_fn, &a);
+		pthread_barrier_wait(&a.go);
+		/* vary where STOP_DEV lands relative to the FETCHes */
+		usleep((i % 5) * 1000);
+		ublk_ctrl_stop_dev(ctrl());
+		pthread_barrier_wait(&a.stopped);
+		pthread_join(t, NULL);
+		cleanup();
+	}
+	printf("%d loops done\n", ASYNC_LOOPS);
+	return KSFT_PASS;
+}
+
+/*
+ * The stopped server is gone: reopen /dev/ublkcN, start a new server and
+ * the device, and read from it.
+ */
+static int restart_server(void)
+{
+	struct server s = { .q = 0, .nr_tags = DEPTH };
+	struct reads r = {};
+	int ret;
+
+	close_cdev();
+	if (open_cdev())
+		return KSFT_FAIL;
+	server_start(&s);
+	usleep(200000);
+	if (s.failed) {
+		fprintf(stderr, "new server: FETCH failed %d\n", s.failed);
+		cleanup();
+		pthread_join(s.thread, NULL);
+		return KSFT_FAIL;
+	}
+	/* -EEXIST until the old disk is freed, e.g. after a udev probe */
+	for (int i = 0; i < 100; i++) {
+		ret = start_dev();
+		if (ret != -EEXIST)
+			break;
+		usleep(50000);
+	}
+	if (ret || reads_submit(&r, -1)) {
+		fprintf(stderr, "new server: START_DEV %d\n", ret);
+		ret = KSFT_FAIL;
+	} else {
+		reads_reap(&r, 10);
+		ret = reads_result(&r);
+		if (r.ok != NR_READS)
+			ret = KSFT_FAIL;
+	}
+	cleanup();
+	pthread_join(s.thread, NULL);
+	return ret;
+}
+
+/*
+ * stop_attached: STOP_DEV while a server has the device open but has
+ * fetched nothing stops that server too: its FETCH gets ABORT and
+ * START_DEV -EBUSY. Once it is gone, a new server can start the device.
+ */
+static int test_stop_attached(void)
+{
+	struct server s = { .q = 0, .nr_tags = DEPTH };
+	int ret;
+
+	if (add_dev(1, 0))
+		return KSFT_FAIL;
+	ret = ublk_ctrl_stop_dev(ctrl());
+	printf("STOP_DEV: %d\n", ret);
+
+	server_start(&s);
+	ret = server_wait_failed(&s);
+	printf("FETCH after STOP_DEV: %d\n", ret);
+	if (ret != UBLK_IO_RES_ABORT) {
+		cleanup();
+		pthread_join(s.thread, NULL);
+		return KSFT_FAIL;
+	}
+	pthread_join(s.thread, NULL);
+	if (expect_err("START_DEV", start_dev(), -EBUSY))
+		return KSFT_FAIL;
+	return restart_server();
+}
+
+/*
+ * stop_live_restart: STOP_DEV on a live device; once its server is gone,
+ * a new server has to fetch and start it again.
+ */
+static int test_stop_live_restart(void)
+{
+	struct server s = { .q = 0, .nr_tags = DEPTH };
+	int ret;
+
+	if (add_dev(1, 0))
+		return KSFT_FAIL;
+	server_start(&s);
+	if (expect_err("START_DEV", start_dev(), 0))
+		return KSFT_FAIL;
+	ret = ublk_ctrl_stop_dev(ctrl());
+	printf("STOP_DEV: %d\n", ret);
+	pthread_join(s.thread, NULL);
+	return restart_server();
+}
+
+/* first CPU which blk-mq maps to hw queue @q */
+static int queue_cpu(int q)
+{
+	char path[96];
+	FILE *f;
+	int cpu = -1;
+
+	snprintf(path, sizeof(path), "/sys/block/ublkb%d/mq/%d/cpu_list",
+		 dev_id, q);
+	for (int i = 0; i < 100 && !(f = fopen(path, "r")); i++)
+		usleep(50000);
+	if (!f)
+		return -1;
+	if (fscanf(f, "%d", &cpu) != 1)
+		cpu = -1;
+	fclose(f);
+	return cpu;
+}
+
+static int test_recovery(void)
+{
+	struct server q1 = { .q = 1, .nr_tags = DEPTH };
+	struct io_uring ring;
+	struct reads r = {};
+	int ret, cpu;
+
+	if (add_dev(NR_QUEUES, UBLK_F_USER_RECOVERY))
+		return KSFT_FAIL;
+
+	/* the first server: fetch everything, start, then die */
+	if (io_uring_queue_init(NR_QUEUES * DEPTH, &ring, 0))
+		return KSFT_FAIL;
+	for (int q = 0; q < NR_QUEUES; q++)
+		for (int tag = 0; tag < DEPTH; tag++)
+			queue_io_cmd(&ring, UBLK_U_IO_FETCH_REQ, q, tag, 0);
+	io_uring_submit(&ring);
+	if (start_dev())
+		return KSFT_FAIL;
+	cpu = queue_cpu(0);
+	if (cpu < 0) {
+		printf("no CPU maps to queue 0, can't aim the reads\n");
+		return KSFT_SKIP;
+	}
+
+	io_uring_queue_exit(&ring);
+	close_cdev();
+	for (int i = 0; i < 100 && dev_state() != UBLK_S_DEV_QUIESCED; i++)
+		usleep(50000);
+	printf("server exited, state %d (QUIESCED is %d)\n", dev_state(),
+	       UBLK_S_DEV_QUIESCED);
+
+	for (int i = 0; i < 100; i++) {
+		ret = ublk_ctrl_start_user_recovery(ctrl());
+		if (ret != -EBUSY)
+			break;
+		usleep(50000);
+	}
+	printf("START_USER_RECOVERY: %d\n", ret);
+	if (ret || open_cdev())
+		return KSFT_FAIL;
+
+	/* queue 0 gets ready, then its task dies before queue 1 is ready */
+	if (fetch_and_die(0, 0, DEPTH))
+		return KSFT_FAIL;
+
+	printf("reads on cpu %d, which maps to queue 0\n", cpu);
+	if (reads_submit(&r, cpu))
+		return KSFT_FAIL;
+
+	server_start(&q1);
+	ret = ublk_ctrl_end_user_recovery(ctrl(), getpid());
+	printf("END_USER_RECOVERY: %d\n", ret);
+	if (ret && ret != -ENODEV) {
+		fprintf(stderr, "END_USER_RECOVERY: %d, expected 0 or %d\n",
+			ret, -ENODEV);
+		ret = KSFT_FAIL;
+	} else {
+		ret = KSFT_PASS;
+	}
+
+	/*
+	 * After -ENODEV, requests held back on queue 0 wait for STOP_DEV to
+	 * fail them. Close the disk before DEL_DEV, which waits for its last
+	 * reference.
+	 */
+	reads_reap(&r, 1);
+	ublk_ctrl_stop_dev(ctrl());
+	reads_reap(&r, 5);
+	if (reads_result(&r))
+		ret = KSFT_FAIL;
+	cleanup();
+	pthread_join(q1.thread, NULL);
+	return ret;
+}
+
+static const struct {
+	const char *name;
+	int (*fn)(void);
+} modes[] = {
+	{ "stop_start",		test_stop_start },
+	{ "partial_fetch",	test_partial_fetch },
+	{ "recovery",		test_recovery },
+	{ "stop_restart",	test_stop_restart },
+	{ "race_start",		test_race_start },
+	{ "race_fetch",		test_race_fetch },
+	{ "race_async_fetch",	test_race_async_fetch },
+	{ "stop_attached",	test_stop_attached },
+	{ "stop_live_restart",	test_stop_live_restart },
+};
+
+int main(int argc, char **argv)
+{
+	int (*fn)(void) = NULL;
+	int ret;
+
+	for (int i = 0; argc == 2 && i < ARRAY_SIZE(modes); i++)
+		if (!strcmp(argv[1], modes[i].name))
+			fn = modes[i].fn;
+	if (!fn) {
+		fprintf(stderr, "usage: %s MODE, modes:", argv[0]);
+		for (int i = 0; i < ARRAY_SIZE(modes); i++)
+			fprintf(stderr, " %s", modes[i].name);
+		fprintf(stderr, "\n");
+		return KSFT_FAIL;
+	}
+
+	/* keep the output of a run that ends in an oops */
+	setvbuf(stdout, NULL, _IOLBF, 0);
+
+	if (access(CTRL_DEV, F_OK)) {
+		perror(CTRL_DEV);
+		return KSFT_SKIP;
+	}
+	printf("%s\n", argv[1]);
+	ret = fn();
+	cleanup();
+	ctrl_put();
+	return ret;
+}
-- 
2.55.0

