Received: from mta1.migadu.com (out-39.mta1.migadu.com [95.215.58.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5419449B5BF
	for <linux-block@vger.kernel.org>; Mon, 19 Oct 2026 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399379; cv=none; b=Mw5oQV/Lxpmz1/rw+029gWCbwlTty3ogUNl2AFRGqHKLeyxgpJQ5O3QAAvabRQfdhTL1rVzFi8X6hzTv+6PXwZj8Wgzf57UXi5AWkQ6Go3X3y00QgF9e5q7iI826RR/Aq/cAfgEKWRnP00+OTorwOVHdWDmcSApS1M858/rnvD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399379; c=relaxed/simple;
	bh=PxVkzj46/gEPQHFQbfiCvZ2NotPzASoJFZQgsVtwf7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8ilzKQeaZZ9yN4GrVt4DiI+c7xNBlUISXgdg8VaGcgRfcW1sQuZ9U6dWf4UK//zCkq5fYco0yS8AekCj7CfYc+LMcGP1H40xSc2VPSX6nOHep+RkOGHZUEcuGB/jUlf+ZP/Yjn5b7jzqrMfEPyFwBiDtYXt3L/4LhTwZw7KpKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gDfW04lZ; arc=none smtp.client-ip=95.215.58.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gDfW04lZ"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=PxVkzj46/gEPQHFQbfiCvZ2NotPzASoJFZQgsVtwf7E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792399375; v=1; x=1793004175;
 b=gDfW04lZ1E9y0f65E1YT46KDhxlOd5cpUS9JqBagB7r8kkzW2nCJr/QmpbzbQ0KBMFvnHxhx
 ZTITkU02SAJOg+w4cWo008a/sO4uLxdRSHedFXNSrCufOB1WMrFnWi5V1GIRVvSnzNs/LRWfdfl
 Voan/Ain/9tQ1xVMpSw5e9mM=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 14f6769b919e0019;
	Mon, 19 Oct 2026 08:42:55 +0000
X-Mizu-Trace-ID: 14f6769b919e0019
X-Migadu-Flow: FLOW_OUT
From: Jackie Liu <liu.yun@linux.dev>
To: josef@toxicpanda.com
Cc: axboe@kernel.dk,
	shuah@kernel.org,
	tom.leiming@gmail.com,
	yukuai@fygo.io,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/4] selftests: nbd: test concurrent device starts
Date: Mon, 19 Oct 2026 16:42:25 +0800
Message-ID: <43fe4ee554aff0b97377cbb7be55ef0a0bdad5f6.1792399225.git.liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1792399225.git.liuyun01@kylinos.cn>
References: <cover.1792399225.git.liuyun01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jackie Liu <liuyun01@kylinos.cn>

Add an NBD selftest that races two NBD_DO_IT callers and checks that the
loser returns EBUSY while the sysfs pid attribute retains the successful
caller's PID. Prime the device with a different connection count before
each attempt so that the hardware queue update cannot take its no-op
path.

Use socket pairs and an exclusively opened unused device, with bounded
waits and cleanup of the test's own configuration. Skip the test when
CAP_SYS_ADMIN, at least two CPUs, or an unused NBD device is unavailable.
Register the new nbd target with kselftest.

The test uses scheduling stress rather than kernel instrumentation, so a
passing run only means that no regression was observed during that run.
The number of attempts, delays and random seed can be set on the command
line. Load nbd with nbds_max=4 max_part=0 before running the test.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 MAINTAINERS                                |   1 +
 tools/testing/selftests/Makefile           |   1 +
 tools/testing/selftests/nbd/.gitignore     |   1 +
 tools/testing/selftests/nbd/Makefile       |   8 +
 tools/testing/selftests/nbd/config         |   7 +
 tools/testing/selftests/nbd/nbd_common.c   | 465 +++++++++++++++++++++
 tools/testing/selftests/nbd/nbd_common.h   |  53 +++
 tools/testing/selftests/nbd/nbd_pid_race.c |  86 ++++
 8 files changed, 622 insertions(+)
 create mode 100644 tools/testing/selftests/nbd/.gitignore
 create mode 100644 tools/testing/selftests/nbd/Makefile
 create mode 100644 tools/testing/selftests/nbd/config
 create mode 100644 tools/testing/selftests/nbd/nbd_common.c
 create mode 100644 tools/testing/selftests/nbd/nbd_common.h
 create mode 100644 tools/testing/selftests/nbd/nbd_pid_race.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 782389bd5cd3..f4495cb942d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18884,6 +18884,7 @@ F:	Documentation/admin-guide/blockdev/nbd.rst
 F:	drivers/block/nbd.c
 F:	include/trace/events/nbd.h
 F:	include/uapi/linux/nbd.h
+F:	tools/testing/selftests/nbd/
 
 NETWORK DROP MONITOR
 M:	Neil Horman <nhorman@tuxdriver.com>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index bc4fdb6f5337..67ab46cb173b 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -82,6 +82,7 @@ TARGETS += mount_setattr
 TARGETS += move_mount_set_group
 TARGETS += mqueue
 TARGETS += mseal_system_mappings
+TARGETS += nbd
 TARGETS += nci
 TARGETS += net
 TARGETS += net/af_unix
diff --git a/tools/testing/selftests/nbd/.gitignore b/tools/testing/selftests/nbd/.gitignore
new file mode 100644
index 000000000000..5516e34b30f2
--- /dev/null
+++ b/tools/testing/selftests/nbd/.gitignore
@@ -0,0 +1 @@
+/nbd_pid_race
diff --git a/tools/testing/selftests/nbd/Makefile b/tools/testing/selftests/nbd/Makefile
new file mode 100644
index 000000000000..e49ee6cfc82e
--- /dev/null
+++ b/tools/testing/selftests/nbd/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+CFLAGS += -O2 -Wall -Wextra $(KHDR_INCLUDES)
+TEST_GEN_PROGS := nbd_pid_race
+LOCAL_HDRS += nbd_common.h
+
+include ../lib.mk
+
+$(TEST_GEN_PROGS): nbd_common.c
diff --git a/tools/testing/selftests/nbd/config b/tools/testing/selftests/nbd/config
new file mode 100644
index 000000000000..390cd288cec6
--- /dev/null
+++ b/tools/testing/selftests/nbd/config
@@ -0,0 +1,7 @@
+CONFIG_MODULES=y
+CONFIG_BLOCK=y
+CONFIG_BLK_DEV_NBD=m
+CONFIG_NET=y
+CONFIG_UNIX=y
+CONFIG_SMP=y
+CONFIG_SYSFS=y
diff --git a/tools/testing/selftests/nbd/nbd_common.c b/tools/testing/selftests/nbd/nbd_common.c
new file mode 100644
index 000000000000..b686c02fbd8e
--- /dev/null
+++ b/tools/testing/selftests/nbd/nbd_common.c
@@ -0,0 +1,465 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 KylinSoft Co., Ltd. All rights reserved.
+ *
+ * Exercise the nbd_start_device() config_lock window introduced by
+ * 8b428f42f3ed ("nbd: fix lockdep deadlock warning"). Prime the hardware
+ * queue count before each race so the update cannot take its no-op path.
+ * A passing stress run means that no regression was observed in that run;
+ * scheduling alone cannot guarantee that both callers entered the window.
+ */
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <limits.h>
+#include <linux/capability.h>
+#include <linux/nbd.h>
+#include <poll.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <sys/syscall.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+
+#include "../kselftest.h"
+#include "nbd_common.h"
+
+#define MAX_DEVICES	32
+
+static int devices[MAX_DEVICES];
+static int nr_devices;
+
+long long nbd_now_ms(void)
+{
+	struct timespec ts;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	return (long long)ts.tv_sec * 1000 + ts.tv_nsec / 1000000;
+}
+
+static int read_timeout(int fd, void *buf, size_t len, int timeout)
+{
+	long long end = nbd_now_ms() + timeout;
+	struct pollfd pfd = { .fd = fd, .events = POLLIN };
+	size_t done = 0;
+
+	while (done < len) {
+		long long left = end - nbd_now_ms();
+		ssize_t n;
+		int ret;
+
+		ret = poll(&pfd, 1, left > 0 ? left : 0);
+		if (ret < 0 && errno == EINTR)
+			continue;
+		if (ret <= 0)
+			return ret ? -errno : -ETIMEDOUT;
+		n = read(fd, (char *)buf + done, len - done);
+		if (n < 0 && errno == EINTR)
+			continue;
+		if (n <= 0)
+			return n ? -errno : -EPIPE;
+		done += n;
+	}
+	return 0;
+}
+
+static void close_fd(int *fd)
+{
+	if (*fd >= 0)
+		close(*fd);
+	*fd = -1;
+}
+
+/* An absent pid attribute denotes an unstarted device, not a read error. */
+int nbd_device_pid(int index)
+{
+	char path[64], buf[32], *end;
+	long pid;
+	int fd, error;
+	ssize_t n;
+
+	snprintf(path, sizeof(path), "/sys/block/nbd%d/pid", index);
+	fd = open(path, O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return errno == ENOENT ? 0 : -errno;
+	do {
+		n = read(fd, buf, sizeof(buf) - 1);
+	} while (n < 0 && errno == EINTR);
+	error = errno;
+	close(fd);
+	if (n <= 0) {
+		/* Only a removed attribute confirms that the device has stopped. */
+		if (access(path, F_OK) < 0 && errno == ENOENT)
+			return 0;
+		return n < 0 ? -error : -EIO;
+	}
+	buf[n] = '\0';
+	errno = 0;
+	pid = strtol(buf, &end, 10);
+	if (errno || end == buf || (*end && *end != '\n') ||
+	    pid <= 0 || pid > INT_MAX)
+		return -EPROTO;
+	return pid;
+}
+
+static int open_unused(int index)
+{
+	char path[64];
+	int fd, pid;
+
+	snprintf(path, sizeof(path), "/dev/nbd%d", index);
+	fd = open(path, O_RDWR | O_EXCL | O_CLOEXEC);
+	if (fd < 0)
+		return -errno;
+	pid = nbd_device_pid(index);
+	if (pid) {
+		close(fd);
+		return pid < 0 ? pid : -EBUSY;
+	}
+	return fd;
+}
+
+static int find_device(void)
+{
+	struct dirent *entry;
+	DIR *dir;
+
+	nr_devices = 0;
+	dir = opendir("/sys/block");
+	if (!dir)
+		return -1;
+	while ((entry = readdir(dir))) {
+		char tail;
+		int candidate, fd;
+
+		if (sscanf(entry->d_name, "nbd%d%c", &candidate, &tail) != 1)
+			continue;
+		fd = open_unused(candidate);
+		if (fd < 0)
+			continue;
+		close(fd);
+		devices[nr_devices] = candidate;
+		if (++nr_devices >= MAX_DEVICES)
+			break;
+	}
+	closedir(dir);
+	return nr_devices ? devices[0] : -1;
+}
+
+int nbd_session_open(struct session *s, int index, int connections,
+		     unsigned long flags)
+{
+	int i;
+
+	memset(s, 0, sizeof(*s));
+	s->index = index;
+	s->fd = -1;
+	for (i = 0; i < 2; i++) {
+		s->sockets[i][0] = -1;
+		s->sockets[i][1] = -1;
+		s->go[i] = -1;
+		s->ready[i] = -1;
+		s->result[i] = -1;
+	}
+	s->fd = open_unused(index);
+	if (s->fd < 0) {
+		ksft_print_msg("nbd%d: exclusive open: %s\n", index,
+			       strerror(-s->fd));
+		return s->fd;
+	}
+	for (i = 0; i < 2; i++) {
+		if (socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0,
+			       s->sockets[i]))
+			return -errno;
+		if (i >= connections)
+			continue;
+		if (ioctl(s->fd, NBD_SET_SOCK, s->sockets[i][0])) {
+			int error = errno;
+
+			ksft_print_msg("nbd%d: set socket %d: %s\n", index, i,
+				       strerror(error));
+			return -error;
+		}
+		/* Never clear another setup task's sockets after -EBUSY. */
+		s->owns_config = true;
+	}
+	if (ioctl(s->fd, NBD_SET_FLAGS, flags))
+		return -errno;
+	return 0;
+}
+
+int nbd_pick_device(int round)
+{
+	return devices[round % nr_devices];
+}
+
+int nbd_get_result(struct session *s, int timeout)
+{
+	struct result *r;
+	int ret;
+
+	if (s->nr_results >= s->nr_children)
+		return -EINVAL;
+	r = &s->results[s->nr_results];
+	ret = read_timeout(s->result[0], r, sizeof(*r), timeout);
+	if (!ret)
+		s->nr_results++;
+	return ret;
+}
+
+int nbd_launch(struct session *s, int children, struct options *o)
+{
+	char ready[2], go[2] = { 'g', 'g' };
+	int i, ret;
+
+	if (pipe2(s->go, O_CLOEXEC) || pipe2(s->ready, O_CLOEXEC) ||
+	    pipe2(s->result, O_CLOEXEC))
+		return -errno;
+	for (i = 0; i < children; i++) {
+		unsigned int spread = i ? o->spread_b : o->spread_a;
+		unsigned int delay = spread ? rand_r(&o->seed) % spread : 0;
+		pid_t child = fork();
+
+		if (child < 0)
+			return -errno;
+		if (!child) {
+			struct result r = { .pid = getpid() };
+			char token;
+
+			close(s->go[1]);
+			close(s->ready[0]);
+			close(s->result[0]);
+			if (write(s->ready[1], "r", 1) != 1 ||
+			    read(s->go[0], &token, 1) != 1)
+				_exit(1);
+			if (delay)
+				usleep(delay);
+			/* Use the inherited exclusive fd; DO_IT has no owner check. */
+			if (ioctl(s->fd, NBD_DO_IT, 0))
+				r.error = errno;
+			if (write(s->result[1], &r, sizeof(r)) != sizeof(r))
+				_exit(1);
+			_exit(0);
+		}
+		s->children[s->nr_children++] = child;
+	}
+	close_fd(&s->go[0]);
+	close_fd(&s->ready[1]);
+	close_fd(&s->result[1]);
+	ret = read_timeout(s->ready[0], ready, children, IO_TIMEOUT_MS);
+	if (ret)
+		return ret;
+	if (write(s->go[1], go, children) != children)
+		return -EIO;
+	return 0;
+}
+
+static int reap_child(pid_t pid)
+{
+	long long end = nbd_now_ms() + IO_TIMEOUT_MS;
+	int status;
+
+	for (;;) {
+		pid_t ret = waitpid(pid, &status, WNOHANG);
+
+		if (ret == pid)
+			return WIFEXITED(status) && !WEXITSTATUS(status) ? 0 : -ECHILD;
+		if (ret < 0 && errno != EINTR)
+			return -errno;
+		if (nbd_now_ms() >= end)
+			break;
+		usleep(1000);
+	}
+	kill(pid, SIGKILL);
+	while (waitpid(pid, &status, 0) < 0 && errno == EINTR)
+		;
+	return -ETIMEDOUT;
+}
+
+int nbd_session_close(struct session *s)
+{
+	int i, ret = 0;
+
+	close_fd(&s->go[1]);
+	close_fd(&s->ready[1]);
+	close_fd(&s->result[1]);
+	if (s->owns_config && ioctl(s->fd, NBD_CLEAR_SOCK, 0))
+		ret = -errno;
+	for (i = 0; i < 2; i++) {
+		if (s->sockets[i][1] >= 0)
+			shutdown(s->sockets[i][1], SHUT_RDWR);
+	}
+	for (i = 0; i < s->nr_children; i++) {
+		int err = reap_child(s->children[i]);
+
+		if (err && !ret)
+			ret = err;
+	}
+	while (s->nr_results < s->nr_children) {
+		int err = nbd_get_result(s, IO_TIMEOUT_MS);
+
+		if (err) {
+			if (!ret)
+				ret = err;
+			break;
+		}
+	}
+	for (i = 0; i < 2; i++) {
+		close_fd(&s->sockets[i][0]);
+		close_fd(&s->sockets[i][1]);
+		close_fd(&s->go[i]);
+		close_fd(&s->ready[i]);
+		close_fd(&s->result[i]);
+	}
+	close_fd(&s->fd);
+	/* Last file release can be deferred; do not reuse its configuration. */
+	if (s->owns_config) {
+		long long end = nbd_now_ms() + IO_TIMEOUT_MS;
+		int pid;
+
+		while ((pid = nbd_device_pid(s->index)) > 0 && nbd_now_ms() < end)
+			usleep(1000);
+		if (pid && !ret)
+			ret = pid < 0 ? pid : -ETIMEDOUT;
+	}
+	return ret;
+}
+
+/* Return 0 for an ioctl result and 1 once startup has published its PID. */
+int nbd_wait_state(struct session *s)
+{
+	long long end = nbd_now_ms() + IO_TIMEOUT_MS;
+
+	while (nbd_now_ms() < end) {
+		int ret = nbd_get_result(s, 0);
+
+		if (!ret)
+			return 0;
+		if (ret != -ETIMEDOUT)
+			return ret;
+		ret = nbd_device_pid(s->index);
+		if (ret < 0)
+			return ret;
+		if (ret)
+			return 1;
+		usleep(1000);
+	}
+	return -ETIMEDOUT;
+}
+
+int nbd_prime(int index, int connections, struct options *o)
+{
+	struct session s;
+	int ret, cleanup;
+
+	ret = nbd_session_open(&s, index, connections,
+			       connections > 1 ? NBD_FLAG_CAN_MULTI_CONN : 0);
+	if (!ret)
+		ret = nbd_launch(&s, 1, o);
+	if (!ret)
+		ret = nbd_wait_state(&s) == 1 ? 0 : -EIO;
+	cleanup = nbd_session_close(&s);
+	if (!ret)
+		ret = cleanup;
+	if (!ret && (s.nr_results != 1 || s.results[0].error))
+		ret = -EIO;
+	return ret;
+}
+
+static unsigned int parse_number(const char *arg, unsigned int limit)
+{
+	char *end;
+	unsigned long value;
+
+	errno = 0;
+	value = strtoul(arg, &end, 0);
+	if (errno || end == arg || *end || value > limit)
+		ksft_exit_fail_msg("invalid numeric option: %s\n", arg);
+	return value;
+}
+
+static void usage(const char *prog)
+{
+	printf("Usage: %s [options]\n", prog);
+	printf("  -r, --rounds N     Race attempts (1..10000, default 20)\n");
+	printf("  -a, --spread-a US  First operation delay (0..100000, default 0)\n");
+	printf("  -b, --spread-b US  Second operation delay (0..100000, default 1000)\n");
+	printf("  -s, --seed N       Random seed (default: time and PID)\n");
+	printf("  -h, --help         Show this help\n");
+	printf("NBD_START_RACE_ROUNDS overrides --rounds.\n");
+	printf("Load nbd with nbds_max=4 max_part=0 before running.\n");
+}
+
+void nbd_parse_options(int argc, char **argv, struct options *o)
+{
+	const struct option options[] = {
+		{ "rounds", required_argument, NULL, 'r' },
+		{ "spread-a", required_argument, NULL, 'a' },
+		{ "spread-b", required_argument, NULL, 'b' },
+		{ "seed", required_argument, NULL, 's' },
+		{ "help", no_argument, NULL, 'h' },
+		{ NULL, 0, NULL, 0 }
+	};
+	const char *env;
+	int option;
+
+	*o = (struct options) { .rounds = 20, .spread_b = 1000 };
+	while ((option = getopt_long(argc, argv, "r:a:b:s:h", options, NULL)) != -1) {
+		switch (option) {
+		case 'r':
+			o->rounds = parse_number(optarg, 10000);
+			break;
+		case 'a':
+			o->spread_a = parse_number(optarg, 100000);
+			break;
+		case 'b':
+			o->spread_b = parse_number(optarg, 100000);
+			break;
+		case 's':
+			o->seed = parse_number(optarg, UINT_MAX);
+			break;
+		case 'h':
+			usage(argv[0]);
+			exit(KSFT_PASS);
+		default:
+			usage(argv[0]);
+			ksft_exit_fail_msg("invalid option\n");
+		}
+	}
+	env = getenv("NBD_START_RACE_ROUNDS");
+	if (env)
+		o->rounds = parse_number(env, 10000);
+	if (optind != argc || o->rounds < 1)
+		ksft_exit_fail_msg("use --rounds 1..10000\n");
+}
+
+int nbd_init_test(struct options *o)
+{
+	struct __user_cap_header_struct header = {
+		.version = _LINUX_CAPABILITY_VERSION_3,
+	};
+	struct __user_cap_data_struct caps[2];
+	int index;
+
+	if (syscall(SYS_capget, &header, caps) ||
+	    !(caps[CAP_SYS_ADMIN / 32].effective & (1U << (CAP_SYS_ADMIN % 32))))
+		ksft_exit_skip("CAP_SYS_ADMIN is required\n");
+	if (sysconf(_SC_NPROCESSORS_ONLN) < 2)
+		ksft_exit_skip("at least two CPUs are needed to change the queue count\n");
+	index = find_device();
+	if (index < 0)
+		ksft_exit_skip("no unused NBD device; load nbd with nbds_max=4 max_part=0\n");
+	if (!o->seed)
+		o->seed = (unsigned int)time(NULL) ^ getpid();
+	ksft_print_msg("nbd%d: rounds=%d seed=%u; scheduling stress, no instrumentation\n",
+		       index, o->rounds, o->seed);
+	signal(SIGPIPE, SIG_IGN);
+	return index;
+}
diff --git a/tools/testing/selftests/nbd/nbd_common.h b/tools/testing/selftests/nbd/nbd_common.h
new file mode 100644
index 000000000000..c310484166fd
--- /dev/null
+++ b/tools/testing/selftests/nbd/nbd_common.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2026 KylinSoft Co., Ltd. All rights reserved.
+ */
+
+#ifndef NBD_SELFTEST_COMMON_H
+#define NBD_SELFTEST_COMMON_H
+
+#include <stdbool.h>
+#include <sys/types.h>
+
+#define IO_TIMEOUT_MS 5000
+
+struct options {
+	int rounds;
+	unsigned int spread_a;
+	unsigned int spread_b;
+	unsigned int seed;
+};
+
+struct result {
+	pid_t pid;
+	int error;
+};
+
+struct session {
+	int index;
+	int fd;
+	int sockets[2][2];
+	int go[2];
+	int ready[2];
+	int result[2];
+	pid_t children[2];
+	struct result results[2];
+	int nr_children;
+	int nr_results;
+	bool owns_config;
+};
+
+long long nbd_now_ms(void);
+int nbd_device_pid(int index);
+int nbd_pick_device(int round);
+int nbd_session_open(struct session *s, int index, int connections,
+		     unsigned long flags);
+int nbd_get_result(struct session *s, int timeout);
+int nbd_launch(struct session *s, int children, struct options *o);
+int nbd_session_close(struct session *s);
+int nbd_wait_state(struct session *s);
+int nbd_prime(int index, int connections, struct options *o);
+void nbd_parse_options(int argc, char **argv, struct options *o);
+int nbd_init_test(struct options *o);
+
+#endif /* NBD_SELFTEST_COMMON_H */
diff --git a/tools/testing/selftests/nbd/nbd_pid_race.c b/tools/testing/selftests/nbd/nbd_pid_race.c
new file mode 100644
index 000000000000..0f4407ae9c28
--- /dev/null
+++ b/tools/testing/selftests/nbd/nbd_pid_race.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 KylinSoft Co., Ltd. All rights reserved.
+ *
+ * Concurrent NBD_DO_IT callers must preserve the successful starter's PID.
+ */
+#include <errno.h>
+#include <linux/nbd.h>
+#include <string.h>
+
+#include "../kselftest.h"
+#include "nbd_common.h"
+
+struct stats {
+	int rounds;
+	int rejected;
+	int hits;
+	int errors;
+};
+
+static int duplicate_start(int index, struct options *o, struct stats *st)
+{
+	struct session s;
+	struct result *loser;
+	pid_t winner;
+	int ret, cleanup, pid;
+
+	ret = nbd_prime(index, 1, o);
+	if (ret)
+		return ret;
+	ret = nbd_session_open(&s, index, 2, NBD_FLAG_CAN_MULTI_CONN);
+	if (!ret)
+		ret = nbd_launch(&s, 2, o);
+	if (!ret)
+		ret = nbd_get_result(&s, IO_TIMEOUT_MS);
+	if (!ret) {
+		loser = &s.results[0];
+		pid = nbd_device_pid(index);
+		winner = loser->pid == s.children[0] ? s.children[1] : s.children[0];
+		st->rounds++;
+		if (loser->error == EEXIST || pid == loser->pid) {
+			st->hits++;
+			ksft_print_msg("nbd%d: losing pid %d errno=%d, sysfs pid=%d\n",
+				       index, loser->pid, loser->error, pid);
+		} else if (loser->error == EBUSY && pid == winner) {
+			st->rejected++;
+		} else {
+			ksft_print_msg("nbd%d: unexpected errno=%d or pid=%d (winner %d)\n",
+				       index, loser->error, pid, winner);
+			ret = -EIO;
+		}
+	}
+	cleanup = nbd_session_close(&s);
+	if (!ret)
+		ret = cleanup;
+	if (!ret && (s.nr_results != 2 || s.results[1].error))
+		ret = -EIO;
+	return ret;
+}
+
+int main(int argc, char **argv)
+{
+	struct stats st = { 0 };
+	struct options o;
+	int i;
+
+	nbd_parse_options(argc, argv, &o);
+	ksft_print_header();
+	nbd_init_test(&o);
+	ksft_set_plan(1);
+	for (i = 0; i < o.rounds; i++) {
+		int ret = duplicate_start(nbd_pick_device(i), &o, &st);
+
+		if (ret) {
+			ksft_print_msg("PID race round %d: %s (%d)\n", i + 1,
+				       strerror(-ret), ret);
+			st.errors++;
+		}
+		if (st.errors || st.hits)
+			break;
+	}
+	ksft_test_result(!st.errors && !st.hits && st.rounds == o.rounds,
+			 "concurrent NBD_DO_IT preserves the winning PID: rounds=%d EBUSY=%d regressions=%d errors=%d\n",
+			 st.rounds, st.rejected, st.hits, st.errors);
+	ksft_finished();
+}
