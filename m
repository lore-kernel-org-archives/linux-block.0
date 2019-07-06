Return-Path: <SRS0=GXCF=VD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77A4C0650E
	for <linux-block@archiver.kernel.org>; Sat,  6 Jul 2019 21:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8278520830
	for <linux-block@archiver.kernel.org>; Sat,  6 Jul 2019 21:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfGFVIp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Jul 2019 17:08:45 -0400
Received: from smtp.infotech.no ([82.134.31.41]:33315 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbfGFVIp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 6 Jul 2019 17:08:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 924B320417C;
        Sat,  6 Jul 2019 23:08:40 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eeN6os5p3loz; Sat,  6 Jul 2019 23:08:30 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id C5EEF204165;
        Sat,  6 Jul 2019 23:08:29 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com
Subject: [PATCH 1/1] fio: add sgv4 engine
Date:   Sat,  6 Jul 2019 17:08:26 -0400
Message-Id: <20190706210826.17964-1-dgilbert@interlog.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With its existing sg engine the fio utility supports many block
devices (e.g. like /dev/sdb) and SCSI Generic (sg) character
devices (e.g. like /dev/sg2). In both cases it uses the sg
version 3 interface based on interface structure: sg_io_hdr. The
sg engine cannot use bsg devices (e.g. like /dev/bsg/0:0:0:2)
because bsg uses the sg version 4 (sgv4) interface based on
interface structure: sg_io_v4 .

This patch adds a new "sgv4" engine that can be used with bsg
device nodes. Additionally a patchset has been sent to the linux
scsi list titled "sg: add v4 interface" on 20190616. With that
patchset (or a later one) applied the sg driver will accept the
v4 interface (both sync and async).

This patch includes a minor clean-up of the existing sg engine
to make it a bit more widely applicable. A variable is renamed
to stress that it is using the sg v3 interface.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---

The sgv4 engine is a copy of the sg engine with the interface
structure changed from struct sg_io_hdr to sg_io_v4 . The
write()/read() async interface is replaced by ioctl(SG_IOSUBMIT)
and ioctl(SG_IORECEIVE) calls. No capabilities have been added
or removed. At the current time the bsg driver no longer supports
an async interface (it was previousy based on write()/read() but
that code has been removed).

 Makefile       |    2 +-
 engines/sg.c   |   22 +-
 engines/sgv4.c | 1316 ++++++++++++++++++++++++++++++++++++++++++++++++
 io_u.h         |    5 +-
 os/os-linux.h  |    2 +
 5 files changed, 1335 insertions(+), 12 deletions(-)
 create mode 100644 engines/sgv4.c

diff --git a/Makefile b/Makefile
index d7e5fca7..8c7756fe 100644
--- a/Makefile
+++ b/Makefile
@@ -157,7 +157,7 @@ endif
 
 ifeq ($(CONFIG_TARGET_OS), Linux)
   SOURCE += diskutil.c fifo.c blktrace.c cgroup.c trim.c engines/sg.c \
-		oslib/linux-dev-lookup.c engines/io_uring.c
+		engines/sgv4.c oslib/linux-dev-lookup.c engines/io_uring.c
   LIBS += -lpthread -ldl
   LDFLAGS += -rdynamic
 endif
diff --git a/engines/sg.c b/engines/sg.c
index c46b9aba..3029c74e 100644
--- a/engines/sg.c
+++ b/engines/sg.c
@@ -359,7 +359,7 @@ re_read:
 
 			if (hdr->info & SG_INFO_CHECK) {
 				/* record if an io error occurred, ignore resid */
-				memcpy(&io_u->hdr, hdr, sizeof(struct sg_io_hdr));
+				memcpy(&io_u->hdr3, hdr, sizeof(struct sg_io_hdr));
 				sd->events[i + trims]->error = EIO;
 			}
 
@@ -380,7 +380,7 @@ re_read:
 #endif
 					if (hdr->info & SG_INFO_CHECK) {
 						/* record if an io error occurred, ignore resid */
-						memcpy(&st->trim_io_us[j]->hdr, hdr, sizeof(struct sg_io_hdr));
+						memcpy(&st->trim_io_us[j]->hdr3, hdr, sizeof(struct sg_io_hdr));
 						sd->events[i + trims]->error = EIO;
 					}
 				}
@@ -408,7 +408,7 @@ static enum fio_q_status fio_sgio_ioctl_doio(struct thread_data *td,
 					     struct io_u *io_u)
 {
 	struct sgio_data *sd = td->io_ops_data;
-	struct sg_io_hdr *hdr = &io_u->hdr;
+	struct sg_io_hdr *hdr = &io_u->hdr3;
 	int ret;
 
 	sd->events[0] = io_u;
@@ -428,7 +428,7 @@ static enum fio_q_status fio_sgio_rw_doio(struct thread_data *td,
 					  struct fio_file *f,
 					  struct io_u *io_u, int do_sync)
 {
-	struct sg_io_hdr *hdr = &io_u->hdr;
+	struct sg_io_hdr *hdr = &io_u->hdr3;
 	int ret;
 
 	ret = write(f->fd, hdr, sizeof(*hdr));
@@ -504,7 +504,7 @@ static void fio_sgio_rw_lba(struct sg_io_hdr *hdr, unsigned long long lba,
 
 static int fio_sgio_prep(struct thread_data *td, struct io_u *io_u)
 {
-	struct sg_io_hdr *hdr = &io_u->hdr;
+	struct sg_io_hdr *hdr = &io_u->hdr3;
 	struct sg_options *o = td->eo;
 	struct sgio_data *sd = td->io_ops_data;
 	unsigned long long nr_blocks, lba;
@@ -623,7 +623,7 @@ static void fio_sgio_unmap_setup(struct sg_io_hdr *hdr, struct sgio_trim *st)
 static enum fio_q_status fio_sgio_queue(struct thread_data *td,
 					struct io_u *io_u)
 {
-	struct sg_io_hdr *hdr = &io_u->hdr;
+	struct sg_io_hdr *hdr = &io_u->hdr3;
 	struct sgio_data *sd = td->io_ops_data;
 	int ret, do_sync = 0;
 
@@ -642,7 +642,7 @@ static enum fio_q_status fio_sgio_queue(struct thread_data *td,
 			assert(st->unmap_range_count == 1);
 			assert(io_u == st->trim_io_us[0]);
 #endif
-			hdr = &io_u->hdr;
+			hdr = &io_u->hdr3;
 
 			fio_sgio_unmap_setup(hdr, st);
 
@@ -693,7 +693,7 @@ static int fio_sgio_commit(struct thread_data *td)
 
 	st = sd->trim_queues[sd->current_queue];
 	io_u = st->trim_io_us[0];
-	hdr = &io_u->hdr;
+	hdr = &io_u->hdr3;
 
 	fio_sgio_unmap_setup(hdr, st);
 
@@ -865,6 +865,7 @@ static int fio_sgio_init(struct thread_data *td)
 {
 	struct sgio_data *sd;
 	struct sgio_trim *st;
+	struct sg_io_hdr *h3p;
 	int i;
 
 	sd = calloc(1, sizeof(*sd));
@@ -880,12 +881,13 @@ static int fio_sgio_init(struct thread_data *td)
 #ifdef FIO_SGIO_DEBUG
 	sd->trim_queue_map = calloc(td->o.iodepth, sizeof(int));
 #endif
-	for (i = 0; i < td->o.iodepth; i++) {
+	for (i = 0, h3p = sd->sgbuf; i < td->o.iodepth; i++, ++h3p) {
 		sd->trim_queues[i] = calloc(1, sizeof(struct sgio_trim));
 		st = sd->trim_queues[i];
 		st->unmap_param = calloc(td->o.iodepth + 1, sizeof(char[16]));
 		st->unmap_range_count = 0;
 		st->trim_io_us = calloc(td->o.iodepth, sizeof(struct io_u *));
+		h3p->interface_id = 'S';
 	}
 
 	td->io_ops_data = sd;
@@ -974,7 +976,7 @@ static int fio_sgio_open(struct thread_data *td, struct fio_file *f)
  */
 static char *fio_sgio_errdetails(struct io_u *io_u)
 {
-	struct sg_io_hdr *hdr = &io_u->hdr;
+	struct sg_io_hdr *hdr = &io_u->hdr3;
 #define MAXERRDETAIL 1024
 #define MAXMSGCHUNK  128
 	char *msg, msgchunk[MAXMSGCHUNK];
diff --git a/engines/sgv4.c b/engines/sgv4.c
new file mode 100644
index 00000000..59360444
--- /dev/null
+++ b/engines/sgv4.c
@@ -0,0 +1,1316 @@
+/*
+ * sgv4 engine
+ *
+ * IO engine that uses the Linux SG v4 interface to talk to SCSI devices.
+ * Can only talk to /dev/sgY or /dev/bsg/<htcl> device nodes
+ *
+ * This ioengine can operate in two modes:
+ *	sync 	with character devices (/dev/sgY and /dev/bsg/<hctl> )
+ *              and with sync=1
+ *	async	with sg v4 driver devices with direct=0 and sync=0
+ *
+ * What value does queue() return for the different cases?
+ *				queue() return value
+ * In sync mode:
+ *  /dev/sgY		RWT	FIO_Q_COMPLETED
+ *  /dev/bsg/<h:c:t:l>  RWT     FIO_Q_COMPLETED
+ *   with sync=1
+ *
+ * In async mode:
+ *  /dev/sgY		RWT	FIO_Q_QUEUED
+ *   direct=0 and sync=0
+ *
+ * Because FIO_SYNCIO is set for this ioengine td_io_queue() will fill in
+ * issue_time *before* each IO is sent to queue()
+ *
+ *
+ * Note that only sg devices using the sg v4 driver are accepted. A
+ * patchset titled "sg: add v4 interface" was sent to the linux-scsi
+ * list on 20190616. There will be later patchsets.
+ *
+ * Note that the colons withing a bsg node name need to be escaped with
+ * a leading backslash when given to "filename=". For example:
+ *      filename=/dev/bsg/0\:0\:0\:2
+ * for the /dev/bsg/0:0:0:2 device node.
+ *
+ * Where are the IO counting functions called for the different cases?
+ *
+ * In sync mode:
+ *
+ *  /dev/sgY with direct=1 or sync=1 (commit does nothing)
+ *   RWT
+ *    io_u_mark_depth()			called in td_io_queue()
+ *    io_u_mark_submit/complete()	called in queue()
+ *    issue_time			set in td_io_queue()
+ *  
+ * In async mode:
+ *  /dev/sgY with direct=0 and sync=0
+ *   RW: read and write operations are submitted in queue()
+ *    io_u_mark_depth()			called in td_io_commit()
+ *    io_u_mark_submit()		called in queue()
+ *    issue_time			set in td_io_queue()
+ *   T: trim operations are queued in queue() and submitted in commit()
+ *    io_u_mark_depth()			called in td_io_commit()
+ *    io_u_mark_submit()		called in commit()
+ *    issue_time			set in commit()
+ *
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <poll.h>
+
+#include "../fio.h"
+#include "../optgroup.h"
+
+#ifndef SG_IOCTL_MAGIC_NUM
+#define SG_IOCTL_MAGIC_NUM 0x22
+#endif
+#ifndef SG_IOSUBMIT
+#define SG_IOSUBMIT _IOWR(SG_IOCTL_MAGIC_NUM, 0x41, struct sg_io_v4)
+#endif
+#ifndef SG_IORECEIVE
+#define SG_IORECEIVE _IOWR(SG_IOCTL_MAGIC_NUM, 0x42, struct sg_io_v4)
+#endif
+
+#ifdef FIO_HAVE_SGV4IO
+
+enum {
+	FIO_SGV4_WRITE		= 1,
+	FIO_SGV4_WRITE_VERIFY	= 2,
+	FIO_SGV4_WRITE_SAME	= 3
+};
+
+struct sgv4_options {
+	void *pad;
+	unsigned int readfua;
+	unsigned int writefua;
+	unsigned int write_mode;
+};
+
+static struct fio_option options[] = {
+	{
+		.name	= "readfua",
+		.lname	= "sgv4 engine read fua flag support",
+		.type	= FIO_OPT_BOOL,
+		.off1	= offsetof(struct sgv4_options, readfua),
+		.help	= "Set FUA flag (force unit access) for all Read operations",
+		.def	= "0",
+		.category = FIO_OPT_C_ENGINE,
+		.group	= FIO_OPT_G_SG,
+	},
+	{
+		.name	= "writefua",
+		.lname	= "sgv4 engine write fua flag support",
+		.type	= FIO_OPT_BOOL,
+		.off1	= offsetof(struct sgv4_options, writefua),
+		.help	= "Set FUA flag (force unit access) for all Write operations",
+		.def	= "0",
+		.category = FIO_OPT_C_ENGINE,
+		.group	= FIO_OPT_G_SG,
+	},
+	{
+		.name	= "sg_write_mode",
+		.lname	= "specify sgv4 write mode",
+		.type	= FIO_OPT_STR,
+		.off1	= offsetof(struct sgv4_options, write_mode),
+		.help	= "Specify SCSI WRITE mode",
+		.def	= "write",
+		.posval = {
+			  { .ival = "write",
+			    .oval = FIO_SGV4_WRITE,
+			    .help = "Issue standard SCSI WRITE commands",
+			  },
+			  { .ival = "verify",
+			    .oval = FIO_SGV4_WRITE_VERIFY,
+			    .help = "Issue SCSI WRITE AND VERIFY commands",
+			  },
+			  { .ival = "same",
+			    .oval = FIO_SGV4_WRITE_SAME,
+			    .help = "Issue SCSI WRITE SAME commands",
+			  },
+		},
+		.category = FIO_OPT_C_ENGINE,
+		.group	= FIO_OPT_G_SG,
+	},
+	{
+		.name	= NULL,
+	},
+};
+
+#define MAX_10B_LBA  0xFFFFFFFFULL
+#define SCSI_TIMEOUT_MS 30000   // 30 second timeout; currently no method to override
+#define MAX_SB 64               // sense block maximum return size
+// /*
+#define FIO_SGV4IO_DEBUG
+// */
+
+struct sgv4io_cmd {
+	unsigned char cdb[16];      // enhanced from 10 to support 16 byte commands
+	unsigned char sb[MAX_SB];   // add sense block to commands
+	int nr;
+};
+
+struct sgv4io_trim {
+	uint8_t *unmap_param;
+	unsigned int unmap_range_count;
+	struct io_u **trim_io_us;
+};
+
+struct sgv4io_data {
+	struct sgv4io_cmd *cmds;
+	struct io_u **events;
+	struct pollfd *pfds;
+	int *fd_flags;
+	void *sgbuf;
+	unsigned int bs;
+	int type_checked;
+	bool bsg_dev;
+	struct sgv4io_trim **trim_queues;
+	int current_queue;
+#ifdef FIO_SGV4IO_DEBUG
+	unsigned int *trim_queue_map;
+#endif
+};
+
+static inline uint32_t sgio_get_be32(uint8_t *buf)
+{
+	return be32_to_cpu(*((uint32_t *) buf));
+}
+
+static inline uint64_t sgio_get_be64(uint8_t *buf)
+{
+	return be64_to_cpu(*((uint64_t *) buf));
+}
+
+static inline void sgio_set_be16(uint16_t val, uint8_t *buf)
+{
+	uint16_t t = cpu_to_be16(val);
+
+	memcpy(buf, &t, sizeof(uint16_t));
+}
+
+static inline void sgio_set_be32(uint32_t val, uint8_t *buf)
+{
+	uint32_t t = cpu_to_be32(val);
+
+	memcpy(buf, &t, sizeof(uint32_t));
+}
+
+static inline void sgio_set_be64(uint64_t val, uint8_t *buf)
+{
+	uint64_t t = cpu_to_be64(val);
+
+	memcpy(buf, &t, sizeof(uint64_t));
+}
+
+static inline bool sgio_unbuffered(struct thread_data *td)
+{
+	return (td->o.odirect || td->o.sync_io);
+}
+
+static void sgv4io_hdr_init(struct sgv4io_data *sd, struct sg_io_v4 *hdr,
+			    struct io_u *io_u, bool mv_data)
+{
+	struct sgv4io_cmd *sc = &sd->cmds[io_u->index];
+
+	memset(hdr, 0, sizeof(*hdr));
+	memset(sc->cdb, 0, sizeof(sc->cdb));
+
+	hdr->guard = 'Q';	/* ->protocol and ->subprotocol both 0 */
+	hdr->request = (uint64_t)(uintptr_t)sc->cdb;
+	hdr->request_len = sizeof(sc->cdb);
+	hdr->response = (uint64_t)(uintptr_t)sc->sb;
+	hdr->max_response_len = sizeof(sc->sb);
+	hdr->request_extra = io_u->index;
+	hdr->usr_ptr = (uint64_t)(uintptr_t)io_u;
+	hdr->timeout = SCSI_TIMEOUT_MS;
+
+	if (mv_data) {	/* setup for READ, needs adjustment for WRITE */
+		hdr->din_xferp = (uint64_t)(uintptr_t)io_u->xfer_buf;
+		hdr->din_xfer_len = io_u->xfer_buflen;
+	}
+}
+
+static int pollin_events(struct pollfd *pfds, int fds)
+{
+	int i;
+
+	for (i = 0; i < fds; i++)
+		if (pfds[i].revents & POLLIN)
+			return 1;
+
+	return 0;
+}
+
+static int sgv4_fd_read(int fd, struct sg_io_v4 *h4p)
+{
+	int err = 0;
+	ssize_t ret;
+
+	while (true) {
+// fprintf(stderr, "%s: guard=%d, din_xferp=%p, dout_xferp=%p\n", __func__, h4p->guard, (void *)h4p->din_xferp, (void *)h4p->dout_xferp);
+assert(h4p->guard == 0x51);
+		ret = ioctl(fd, SG_IORECEIVE, h4p);
+		if (ret < 0) {
+// fprintf(stderr, "%s: ioctl(SG_IORECEIVE) errno=%d\n", __func__, errno);
+			if (errno == EAGAIN || errno == EINTR)
+				continue;
+			err = errno;
+		} else
+			err = 0;
+		break;
+	}
+	return -err;
+}
+
+static int fio_sgv4io_getevents(struct thread_data *td, unsigned int min,
+				unsigned int max,
+				const struct timespec fio_unused *t)
+{
+	struct sgv4io_data *sd = td->io_ops_data;
+	int left = max, eventNum, ret, r = 0, trims = 0;
+	void *buf = sd->sgbuf;
+	unsigned int i, j, events;
+	struct fio_file *f;
+	struct io_u *io_u;
+
+	/*
+	 * Fill in the file descriptors
+	 */
+	for_each_file(td, f, i) {
+		/*
+		 * don't block for min events == 0
+		 */
+		if (!min)
+			sd->fd_flags[i] = fio_set_fd_nonblocking(f->fd, "sgv4");
+		else
+			sd->fd_flags[i] = -1;
+
+		sd->pfds[i].fd = f->fd;
+		sd->pfds[i].events = POLLIN;
+	}
+
+	/*
+	** There are two counters here:
+	**  - number of SCSI commands completed
+	**  - number of io_us completed
+	**
+	** These are the same with reads and writes, but
+	** could differ with trim/unmap commands because
+	** a single unmap can include multiple io_us
+	*/
+
+	while (left > 0) {
+		struct sg_io_v4 *h4p;
+
+		dprint(FD_IO, "sgv4io_getevents: sd %p: min=%d, max=%d, left=%d\n", sd, min, max, left);
+
+		do {
+			if (!min)
+				break;
+
+			ret = poll(sd->pfds, td->o.nr_files, -1);
+			if (ret < 0) {
+				if (!r)
+					r = -errno;
+				td_verror(td, errno, "poll");
+				break;
+			} else if (!ret)
+				continue;
+
+			if (pollin_events(sd->pfds, td->o.nr_files))
+				break;
+		} while (1);
+
+		if (r < 0)
+			break;
+
+re_read:
+		h4p = buf;
+		events = 0;
+		for_each_file(td, f, i) {
+			for (eventNum = 0; eventNum < left; eventNum++) {
+				ret = sgv4_fd_read(f->fd, h4p);
+				dprint(FD_IO, "sgv4io_getevents: sgv4_fd_read ret: %d\n", ret);
+				if (ret) {
+					r = -ret;
+					td_verror(td, r, "sgv4_read");
+					break;
+				}
+				io_u = (struct io_u *)(h4p->usr_ptr);
+				if (io_u->ddir == DDIR_TRIM) {
+					events += sd->trim_queues[io_u->index]->unmap_range_count;
+					eventNum += sd->trim_queues[io_u->index]->unmap_range_count - 1;
+				} else
+					events++;
+
+				++h4p;
+				dprint(FD_IO, "sgv4io_getevents: events: %d, eventNum: %d, left: %d\n", events, eventNum, left);
+			}
+		}
+
+		if (r < 0 && !events)
+			break;
+		if (!events) {
+			usleep(1000);
+			goto re_read;
+		}
+
+		left -= events;
+		r += events;
+
+		for (i = 0; i < events; i++) {
+			struct sg_io_v4 *hdr = (struct sg_io_v4 *) buf + i;
+			io_u = (struct io_u *)(hdr->usr_ptr);
+			sd->events[i + trims] = io_u;
+
+			if (hdr->info & SG_INFO_CHECK) {
+				/* record if an io error occurred, ignore resid */
+				memcpy(&io_u->hdr4, hdr, sizeof(struct sg_io_v4));
+				sd->events[i + trims]->error = EIO;
+			}
+
+			if (io_u->ddir == DDIR_TRIM) {
+				struct sgv4io_trim *st = sd->trim_queues[io_u->index];
+#ifdef FIO_SGV4IO_DEBUG
+				assert(st->trim_io_us[0] == io_u);
+				assert(sd->trim_queue_map[io_u->index] == io_u->index);
+				dprint(FD_IO, "sgv4io_getevents: reaping %d io_us from trim queue %d\n", st->unmap_range_count, io_u->index);
+				dprint(FD_IO, "sgv4io_getevents: reaped io_u %d and stored in events[%d]\n", io_u->index, i+trims);
+#endif
+				for (j = 1; j < st->unmap_range_count; j++) {
+					++trims;
+					sd->events[i + trims] = st->trim_io_us[j];
+#ifdef FIO_SGV4IO_DEBUG
+					dprint(FD_IO, "sgv4io_getevents: reaped io_u %d and stored in events[%d]\n", st->trim_io_us[j]->index, i+trims);
+					assert(sd->trim_queue_map[st->trim_io_us[j]->index] == io_u->index);
+#endif
+					if (hdr->info & SG_INFO_CHECK) {
+						/* record if an io error occurred, ignore resid */
+						memcpy(&st->trim_io_us[j]->hdr4, hdr, sizeof(struct sg_io_v4));
+						sd->events[i + trims]->error = EIO;
+					}
+				}
+				events -= st->unmap_range_count - 1;
+				st->unmap_range_count = 0;
+			}
+		}
+	}
+
+	if (!min) {
+		for_each_file(td, f, i) {
+			if (sd->fd_flags[i] == -1)
+				continue;
+
+			if (fcntl(f->fd, F_SETFL, sd->fd_flags[i]) < 0)
+				log_err("fio: sgv4 failed to restore fcntl flags: %s\n", strerror(errno));
+		}
+	}
+
+	return r;
+}
+
+static enum fio_q_status fio_sgv4io_ioctl_doio(struct thread_data *td,
+					       struct fio_file *f,
+					       struct io_u *io_u)
+{
+	struct sgv4io_data *sd = td->io_ops_data;
+	struct sg_io_v4 *hdr = &io_u->hdr4;
+	int ret;
+
+	sd->events[0] = io_u;
+
+	ret = ioctl(f->fd, SG_IO, hdr);
+	if (ret < 0)
+		return ret;
+
+	/* record if an io error occurred */
+	if (hdr->info & SG_INFO_CHECK)
+		io_u->error = EIO;
+
+	return FIO_Q_COMPLETED;
+}
+
+static enum fio_q_status fio_sgv4io_rw_doio(struct thread_data *td,
+					    struct fio_file *f,
+					    struct io_u *io_u, bool do_sync)
+{
+	struct sg_io_v4 *hdr = &io_u->hdr4;
+	int ret;
+
+	ret = ioctl(f->fd, SG_IOSUBMIT, hdr);
+	if (ret < 0)
+		return ret;
+
+	if (do_sync) {
+		/*
+		 * We can't just read back the first command that completes
+		 * and assume it's the one we need, it could be any command
+		 * that is inflight.
+		 */
+		do {
+			struct io_u *__io_u;
+
+			ret =  ioctl(f->fd, SG_IORECEIVE, hdr);
+			if (ret < 0) {
+// fprintf(stderr, "%s: ioctl(SG_IORECEIVE) errno=%d\n", __func__, errno);
+				return ret;
+}
+
+			__io_u = (void *)hdr->usr_ptr;
+
+			/* record if an io error occurred */
+			if (hdr->info & SG_INFO_CHECK)
+				__io_u->error = EIO;
+
+			if (__io_u == io_u)
+				break;
+
+			if (io_u_sync_complete(td, __io_u)) {
+				ret = -1;
+				break;
+			}
+		} while (1);
+
+		return FIO_Q_COMPLETED;
+	}
+
+	return FIO_Q_QUEUED;
+}
+
+static enum fio_q_status fio_sgv4io_doio(struct thread_data *td,
+					 struct io_u *io_u, bool do_sync)
+{
+	struct fio_file *f = io_u->file;
+	struct sgv4io_data *sd = td->io_ops_data;
+	enum fio_q_status ret;
+
+	if (f->filetype == FIO_TYPE_BLOCK || (sd && sd->bsg_dev)) {
+		ret = fio_sgv4io_ioctl_doio(td, f, io_u);
+		if (io_u->error)
+			td_verror(td, io_u->error, __func__);
+	} else {
+		ret = fio_sgv4io_rw_doio(td, f, io_u, do_sync);
+		if (io_u->error && do_sync)
+			td_verror(td, io_u->error, __func__);
+	}
+
+	return ret;
+}
+
+#define SGV4_HDR_CMD(u64asp) (uint8_t *)(u64asp)
+
+static void fio_sgv4io_rw_lba(struct sg_io_v4 *hdr, unsigned long long lba,
+			      unsigned long long nr_blocks)
+{
+	uint8_t *cmdreq = SGV4_HDR_CMD(hdr->request);
+
+	if (lba < MAX_10B_LBA) {
+		sgio_set_be32((uint32_t) lba, cmdreq + 2);
+		sgio_set_be16((uint16_t) nr_blocks, cmdreq + 7);
+	} else {
+		sgio_set_be64(lba, cmdreq + 2);
+		sgio_set_be32((uint32_t) nr_blocks, cmdreq + 10);
+	}
+
+	return;
+}
+
+
+static int fio_sgv4io_prep(struct thread_data *td, struct io_u *io_u)
+{
+	struct sg_io_v4 *hdr = &io_u->hdr4;
+	struct sgv4_options *o = td->eo;
+	struct sgv4io_data *sd = td->io_ops_data;
+	uint8_t *cmdreq;
+	unsigned long long nr_blocks, lba;
+	int offset;
+
+	if (io_u->xfer_buflen & (sd->bs - 1)) {
+		log_err("read/write not sector aligned\n");
+		return EINVAL;
+	}
+
+	nr_blocks = io_u->xfer_buflen / sd->bs;
+	lba = io_u->offset / sd->bs;
+
+	if (io_u->ddir == DDIR_READ) {
+		sgv4io_hdr_init(sd, hdr, io_u, true);
+
+		cmdreq = SGV4_HDR_CMD(hdr->request);
+		if (lba < MAX_10B_LBA)
+			cmdreq[0] = 0x28; // read(10)
+		else
+			cmdreq[0] = 0x88; // read(16)
+
+		if (o->readfua)
+			cmdreq[1] |= 0x08;
+
+		fio_sgv4io_rw_lba(hdr, lba, nr_blocks);
+
+	} else if (io_u->ddir == DDIR_WRITE) {
+		sgv4io_hdr_init(sd, hdr, io_u, true);
+
+		cmdreq = SGV4_HDR_CMD(hdr->request);
+		hdr->dout_xferp = hdr->din_xferp;
+		hdr->dout_xfer_len = hdr->din_xfer_len;
+		hdr->din_xferp = 0;
+		hdr->din_xfer_len = 0;
+		switch(o->write_mode) {
+		case FIO_SGV4_WRITE:
+			if (lba < MAX_10B_LBA)
+				cmdreq[0] = 0x2a; // write(10)
+			else
+				cmdreq[0] = 0x8a; // write(16)
+			if (o->writefua)
+				cmdreq[1] |= 0x08;
+			break;
+		case FIO_SGV4_WRITE_VERIFY:
+			if (lba < MAX_10B_LBA)
+				cmdreq[0] = 0x2e; // write and verify(10)
+			else
+				cmdreq[0] = 0x8e; // write and verify(16)
+			break;
+			// BYTCHK is disabled by virtue of the memset in sgv4io_hdr_init
+		case FIO_SGV4_WRITE_SAME:
+			hdr->dout_xfer_len = sd->bs;
+			if (lba < MAX_10B_LBA)
+				cmdreq[0] = 0x41; // write same(10)
+			else
+				cmdreq[0] = 0x93; // write same(16)
+			break;
+		};
+
+		fio_sgv4io_rw_lba(hdr, lba, nr_blocks);
+
+	} else if (io_u->ddir == DDIR_TRIM) {
+		struct sgv4io_trim *st;
+
+		if (sd->current_queue == -1) {
+			sgv4io_hdr_init(sd, hdr, io_u, false);
+
+			cmdreq = SGV4_HDR_CMD(hdr->request);
+			hdr->request_len = 10;
+			cmdreq[0] = 0x42; // unmap
+			sd->current_queue = io_u->index;
+			st = sd->trim_queues[sd->current_queue];
+			hdr->dout_xferp = (uint64_t)(uintptr_t)st->unmap_param;
+#ifdef FIO_SGV4IO_DEBUG
+			assert(sd->trim_queues[io_u->index]->unmap_range_count == 0);
+			dprint(FD_IO, "sgv4: creating new queue based on io_u %d\n", io_u->index);
+#endif
+		}
+		else
+			st = sd->trim_queues[sd->current_queue];
+
+		dprint(FD_IO, "sgv4: adding io_u %d to trim queue %d\n", io_u->index, sd->current_queue);
+		st->trim_io_us[st->unmap_range_count] = io_u;
+#ifdef FIO_SGV4IO_DEBUG
+		sd->trim_queue_map[io_u->index] = sd->current_queue;
+#endif
+
+		offset = 8 + 16 * st->unmap_range_count;
+		sgio_set_be64(lba, &st->unmap_param[offset]);
+		sgio_set_be32((uint32_t) nr_blocks, &st->unmap_param[offset + 8]);
+
+		st->unmap_range_count++;
+
+	} else if (ddir_sync(io_u->ddir)) {
+		sgv4io_hdr_init(sd, hdr, io_u, false);
+		cmdreq = SGV4_HDR_CMD(hdr->request);
+		if (lba < MAX_10B_LBA)
+			cmdreq[0] = 0x35; // synccache(10)
+		else
+			cmdreq[0] = 0x91; // synccache(16)
+	} else
+		assert(0);
+
+	return 0;
+}
+
+static void fio_sgv4io_unmap_setup(struct sg_io_v4 *hdr,
+				   struct sgv4io_trim *st)
+{
+	uint16_t cnt = st->unmap_range_count * 16;
+	uint8_t *cmdreq = SGV4_HDR_CMD(hdr->request);
+
+	hdr->dout_xfer_len = cnt + 8;
+	sgio_set_be16(cnt + 8, cmdreq + 7);
+	sgio_set_be16(cnt + 6, st->unmap_param);
+	sgio_set_be16(cnt, &st->unmap_param[2]);
+
+	return;
+}
+
+static enum fio_q_status fio_sgv4io_queue(struct thread_data *td,
+					  struct io_u *io_u)
+{
+	struct sg_io_v4 *hdr = &io_u->hdr4;
+	struct sgv4io_data *sd = td->io_ops_data;
+	int ret;
+	bool do_sync = false;
+
+	fio_ro_check(td, io_u);
+
+	if (sgio_unbuffered(td) || ddir_sync(io_u->ddir))
+		do_sync = true;
+
+	if (io_u->ddir == DDIR_TRIM) {
+		if (do_sync || io_u->file->filetype == FIO_TYPE_BLOCK) {
+			struct sgv4io_trim *st = sd->trim_queues[sd->current_queue];
+
+			/* finish cdb setup for unmap because we are
+			** doing unmap commands synchronously */
+#ifdef FIO_SGV4IO_DEBUG
+			assert(st->unmap_range_count == 1);
+			assert(io_u == st->trim_io_us[0]);
+#endif
+			hdr = &io_u->hdr4;
+
+			fio_sgv4io_unmap_setup(hdr, st);
+
+			st->unmap_range_count = 0;
+			sd->current_queue = -1;
+		} else
+			/* queue up trim ranges and submit in commit() */
+			return FIO_Q_QUEUED;
+	}
+
+	ret = fio_sgv4io_doio(td, io_u, do_sync);
+
+	if (ret < 0)
+		io_u->error = errno;
+	else if (hdr->device_status) {
+		io_u->resid = hdr->din_resid;
+		io_u->error = EIO;
+	} else if (td->io_ops->commit != NULL) {
+		if (do_sync && !ddir_sync(io_u->ddir)) {
+			io_u_mark_submit(td, 1);
+			io_u_mark_complete(td, 1);
+		} else if (io_u->ddir == DDIR_READ || io_u->ddir == DDIR_WRITE) {
+			io_u_mark_submit(td, 1);
+			io_u_queued(td, io_u);
+		}
+	}
+
+	if (io_u->error) {
+		td_verror(td, io_u->error, "xfer");
+		return FIO_Q_COMPLETED;
+	}
+
+	return ret;
+}
+
+static int fio_sgv4io_commit(struct thread_data *td)
+{
+	struct sgv4io_data *sd = td->io_ops_data;
+	struct sgv4io_trim *st;
+	struct io_u *io_u;
+	struct sg_io_v4 *hdr;
+	struct timespec now;
+	unsigned int i;
+	int ret;
+
+	if (sd->current_queue == -1)
+		return 0;
+
+	st = sd->trim_queues[sd->current_queue];
+	io_u = st->trim_io_us[0];
+	hdr = &io_u->hdr4;
+
+	fio_sgv4io_unmap_setup(hdr, st);
+
+	sd->current_queue = -1;
+
+	ret = fio_sgv4io_rw_doio(td, io_u->file, io_u, false);
+
+	if (ret < 0 || hdr->device_status) {
+		int error;
+
+		if (ret < 0)
+			error = errno;
+		else {
+			error = EIO;
+			ret = -EIO;
+		}
+
+		for (i = 0; i < st->unmap_range_count; i++) {
+			st->trim_io_us[i]->error = error;
+			clear_io_u(td, st->trim_io_us[i]);
+			if (hdr->device_status)
+				st->trim_io_us[i]->resid = hdr->din_resid;
+		}
+
+		td_verror(td, error, "xfer");
+		return ret;
+	}
+
+	if (fio_fill_issue_time(td)) {
+		fio_gettime(&now, NULL);
+		for (i = 0; i < st->unmap_range_count; i++) {
+			memcpy(&st->trim_io_us[i]->issue_time, &now, sizeof(now));
+			io_u_queued(td, io_u);
+		}
+	}
+	io_u_mark_submit(td, st->unmap_range_count);
+
+	return 0;
+}
+
+static struct io_u *fio_sgv4io_event(struct thread_data *td, int event)
+{
+	struct sgv4io_data *sd = td->io_ops_data;
+
+	return sd->events[event];
+}
+
+static int fio_sgv4io_read_capacity(struct thread_data *td, unsigned int *bs,
+				    unsigned long long *max_lba)
+{
+	/*
+	 * need to do read capacity operation w/o benefit of sd or
+	 * io_u structures, which are not initialized until later.
+	 */
+	struct sg_io_v4 hdr;
+	unsigned long long hlba;
+	unsigned int blksz = 0;
+	unsigned char cmd[16];
+	unsigned char sb[64];
+	unsigned char buf[32];  // read capacity return
+	int ret;
+	int fd = -1;
+
+	struct fio_file *f = td->files[0];
+
+	/* open file independent of rest of application */
+	fd = open(f->file_name, O_RDONLY);
+	if (fd < 0)
+		return -errno;
+
+	memset(&hdr, 0, sizeof(hdr));
+	memset(cmd, 0, sizeof(cmd));
+	memset(sb, 0, sizeof(sb));
+	memset(buf, 0, sizeof(buf));
+
+	/* First let's try a 10 byte read capacity. */
+	hdr.guard = 'Q';
+	hdr.request = (uint64_t)(uintptr_t)cmd;
+	hdr.request_len = 10;
+	hdr.response = (uint64_t)(uintptr_t)sb;
+	hdr.max_response_len = sizeof(sb);
+	hdr.timeout = SCSI_TIMEOUT_MS;
+	cmd[0] = 0x25;  // Read Capacity(10)
+	hdr.din_xferp = (uint64_t)(uintptr_t)buf;
+	hdr.din_xfer_len = sizeof(buf);
+
+	ret = ioctl(fd, SG_IO, &hdr);
+	if (ret < 0) {
+		close(fd);
+		return ret;
+	}
+
+	if (hdr.info & SG_INFO_CHECK) {
+		/* RCAP(10) might be unsupported by device. Force RCAP(16) */
+		hlba = MAX_10B_LBA;
+	} else {
+		blksz = sgio_get_be32(&buf[4]);
+		hlba = sgio_get_be32(buf);
+	}
+
+	/*
+	 * If max lba masked by MAX_10B_LBA equals MAX_10B_LBA,
+	 * then need to retry with 16 byte Read Capacity command.
+	 */
+	if (hlba == MAX_10B_LBA) {
+		hdr.request_len = 16;
+		cmd[0] = 0x9e; // service action
+		cmd[1] = 0x10; // Read Capacity(16)
+		sgio_set_be32(sizeof(buf), cmd + 10);
+
+		hdr.din_xferp = (uint64_t)(uintptr_t)buf;
+		hdr.din_xfer_len = sizeof(buf);
+
+		ret = ioctl(fd, SG_IO, &hdr);
+		if (ret < 0) {
+			close(fd);
+			return ret;
+		}
+
+		/* record if an io error occurred */
+		if (hdr.info & SG_INFO_CHECK)
+			td_verror(td, EIO, "fio_sgv4io_read_capacity");
+
+		blksz = sgio_get_be32(&buf[8]);
+		hlba = sgio_get_be64(buf);
+	}
+
+	if (blksz) {
+		*bs = blksz;
+		*max_lba = hlba;
+		ret = 0;
+	} else {
+		ret = EIO;
+	}
+
+	close(fd);
+	return ret;
+}
+
+static void fio_sgv4io_cleanup(struct thread_data *td)
+{
+	struct sgv4io_data *sd = td->io_ops_data;
+	int i;
+
+	if (sd) {
+		free(sd->events);
+		free(sd->cmds);
+		free(sd->fd_flags);
+		free(sd->pfds);
+		free(sd->sgbuf);
+#ifdef FIO_SGV4IO_DEBUG
+		free(sd->trim_queue_map);
+#endif
+
+		for (i = 0; i < td->o.iodepth; i++) {
+			free(sd->trim_queues[i]->unmap_param);
+			free(sd->trim_queues[i]->trim_io_us);
+			free(sd->trim_queues[i]);
+		}
+
+		free(sd->trim_queues);
+		free(sd);
+	}
+}
+
+static int fio_sgv4io_init(struct thread_data *td)
+{
+	struct sgv4io_data *sd;
+	struct sgv4io_trim *st;
+	struct sg_io_v4 *h4p;
+	int i;
+
+	sd = calloc(1, sizeof(*sd));
+	sd->cmds = calloc(td->o.iodepth, sizeof(struct sgv4io_cmd));
+	sd->sgbuf = calloc(td->o.iodepth, sizeof(struct sg_io_v4));
+	sd->events = calloc(td->o.iodepth, sizeof(struct io_u *));
+	sd->pfds = calloc(td->o.nr_files, sizeof(struct pollfd));
+	sd->fd_flags = calloc(td->o.nr_files, sizeof(int));
+	sd->type_checked = 0;
+
+	sd->trim_queues = calloc(td->o.iodepth, sizeof(struct sgv4io_trim *));
+	sd->current_queue = -1;
+#ifdef FIO_SGV4IO_DEBUG
+	sd->trim_queue_map = calloc(td->o.iodepth, sizeof(int));
+#endif
+	for (i = 0, h4p = sd->sgbuf; i < td->o.iodepth; i++, ++h4p) {
+		sd->trim_queues[i] = calloc(1, sizeof(struct sgv4io_trim));
+		st = sd->trim_queues[i];
+		st->unmap_param = calloc(td->o.iodepth + 1, sizeof(char[16]));
+		st->unmap_range_count = 0;
+		st->trim_io_us = calloc(td->o.iodepth, sizeof(struct io_u *));
+		h4p->guard = 'Q';
+	}
+
+	td->io_ops_data = sd;
+
+	/*
+	 * we want to do it, regardless of whether odirect is set or not
+	 */
+	td->o.override_sync = 1;
+	return 0;
+}
+
+static int fio_sgv4io_type_check(struct thread_data *td, struct fio_file *f)
+{
+	struct sgv4io_data *sd = td->io_ops_data;
+	unsigned int bs = 0;
+	unsigned long long max_lba = 0;
+
+	if (f->filetype == FIO_TYPE_CHAR) {
+		int version, num, ret;
+
+		if (ioctl(f->fd, SG_GET_VERSION_NUM, &version) < 0) {
+			td_verror(td, errno, "ioctl");
+			return 1;
+		}
+		/* Supported by real sg device node, if not assume it's bsg */
+		if (ioctl(f->fd, SG_GET_NUM_WAITING, &num) < 0)
+			sd->bsg_dev = true;
+		else if (version < 40000) {
+			td_verror(td, EINVAL, "wrong sg driver version");
+			log_err("ioengine sgv4 needs sg v4 driver\n");
+			return 1;
+		} else
+			sd->bsg_dev = false;
+
+		ret = fio_sgv4io_read_capacity(td, &bs, &max_lba);
+		if (ret) {
+			td_verror(td, td->error, "fio_sgv4io_read_capacity");
+			log_err("ioengine sgv4 unable to read capacity successfully\n");
+			return 1;
+		}
+	} else {
+		td_verror(td, EINVAL, "wrong file type");
+		log_err("ioengine sgv4 only works on sg (>= 4) and bsg devices\n");
+		return 1;
+	}
+
+	sd->bs = bs;
+	// Determine size of commands needed based on max_lba
+	if (max_lba >= MAX_10B_LBA) {
+		dprint(FD_IO, "sgio_type_check: using 16 byte read/write "
+			"commands for lba above 0x%016llx/0x%016llx\n",
+			MAX_10B_LBA, max_lba);
+	}
+
+	if (f->filetype == FIO_TYPE_BLOCK) {
+		td->io_ops->getevents = NULL;
+		td->io_ops->event = NULL;
+		td->io_ops->commit = NULL;
+		/*
+		** Setting these functions to null may cause problems
+		** with filename=/dev/sda:/dev/sg0 since we are only
+		** considering a single file
+		*/
+	}
+	sd->type_checked = 1;
+
+	return 0;
+}
+
+static int fio_sgv4io_open(struct thread_data *td, struct fio_file *f)
+{
+	struct sgv4io_data *sd = td->io_ops_data;
+	int ret;
+
+	ret = generic_open_file(td, f);
+	if (ret)
+		return ret;
+
+	if (sd && !sd->type_checked && fio_sgv4io_type_check(td, f)) {
+		ret = generic_close_file(td, f);
+		return 1;
+	}
+
+	return 0;
+}
+
+/*
+ * Build an error string with details about the driver, host or scsi
+ * error contained in the sg header Caller will use as necessary.
+ */
+static char *fio_sgv4io_errdetails(struct io_u *io_u)
+{
+	struct sg_io_v4 *hdr = &io_u->hdr4;
+#define MAXERRDETAIL 1024
+#define MAXMSGCHUNK  128
+	uint8_t *cmdreq = SGV4_HDR_CMD(hdr->request);
+	uint8_t *sbp = SGV4_HDR_CMD(hdr->response);
+	char *msg, msgchunk[MAXMSGCHUNK];
+	int i;
+
+	msg = calloc(1, MAXERRDETAIL);
+	strcpy(msg, "");
+
+	/*
+	 * can't seem to find sg_err.h, so I'll just echo the define values
+	 * so others can search on internet to find clearer clues of meaning.
+	 */
+	if (hdr->info & SG_INFO_CHECK) {
+		if (hdr->transport_status) {
+			snprintf(msgchunk, MAXMSGCHUNK, "SG Host Status: 0x%02x; ",
+				 hdr->transport_status);
+			strlcat(msg, msgchunk, MAXERRDETAIL);
+			switch (hdr->transport_status) {
+			case 0x01:
+				strlcat(msg, "SG_ERR_DID_NO_CONNECT", MAXERRDETAIL);
+				break;
+			case 0x02:
+				strlcat(msg, "SG_ERR_DID_BUS_BUSY", MAXERRDETAIL);
+				break;
+			case 0x03:
+				strlcat(msg, "SG_ERR_DID_TIME_OUT", MAXERRDETAIL);
+				break;
+			case 0x04:
+				strlcat(msg, "SG_ERR_DID_BAD_TARGET", MAXERRDETAIL);
+				break;
+			case 0x05:
+				strlcat(msg, "SG_ERR_DID_ABORT", MAXERRDETAIL);
+				break;
+			case 0x06:
+				strlcat(msg, "SG_ERR_DID_PARITY", MAXERRDETAIL);
+				break;
+			case 0x07:
+				strlcat(msg, "SG_ERR_DID_ERROR (internal error)", MAXERRDETAIL);
+				break;
+			case 0x08:
+				strlcat(msg, "SG_ERR_DID_RESET", MAXERRDETAIL);
+				break;
+			case 0x09:
+				strlcat(msg, "SG_ERR_DID_BAD_INTR (unexpected)", MAXERRDETAIL);
+				break;
+			case 0x0a:
+				strlcat(msg, "SG_ERR_DID_PASSTHROUGH", MAXERRDETAIL);
+				break;
+			case 0x0b:
+				strlcat(msg, "SG_ERR_DID_SOFT_ERROR (driver retry?)", MAXERRDETAIL);
+				break;
+			case 0x0c:
+				strlcat(msg, "SG_ERR_DID_IMM_RETRY", MAXERRDETAIL);
+				break;
+			case 0x0d:
+				strlcat(msg, "SG_ERR_DID_REQUEUE", MAXERRDETAIL);
+				break;
+			case 0x0e:
+				strlcat(msg, "SG_ERR_DID_TRANSPORT_DISRUPTED", MAXERRDETAIL);
+				break;
+			case 0x0f:
+				strlcat(msg, "SG_ERR_DID_TRANSPORT_FAILFAST", MAXERRDETAIL);
+				break;
+			case 0x10:
+				strlcat(msg, "SG_ERR_DID_TARGET_FAILURE", MAXERRDETAIL);
+				break;
+			case 0x11:
+				strlcat(msg, "SG_ERR_DID_NEXUS_FAILURE", MAXERRDETAIL);
+				break;
+			case 0x12:
+				strlcat(msg, "SG_ERR_DID_ALLOC_FAILURE", MAXERRDETAIL);
+				break;
+			case 0x13:
+				strlcat(msg, "SG_ERR_DID_MEDIUM_ERROR", MAXERRDETAIL);
+				break;
+			default:
+				strlcat(msg, "Unknown", MAXERRDETAIL);
+				break;
+			}
+			strlcat(msg, ". ", MAXERRDETAIL);
+		}
+		if (hdr->driver_status) {
+			snprintf(msgchunk, MAXMSGCHUNK, "SG Driver Status: 0x%02x; ", hdr->driver_status);
+			strlcat(msg, msgchunk, MAXERRDETAIL);
+			switch (hdr->driver_status & 0x0F) {
+			case 0x01:
+				strlcat(msg, "SG_ERR_DRIVER_BUSY", MAXERRDETAIL);
+				break;
+			case 0x02:
+				strlcat(msg, "SG_ERR_DRIVER_SOFT", MAXERRDETAIL);
+				break;
+			case 0x03:
+				strlcat(msg, "SG_ERR_DRIVER_MEDIA", MAXERRDETAIL);
+				break;
+			case 0x04:
+				strlcat(msg, "SG_ERR_DRIVER_ERROR", MAXERRDETAIL);
+				break;
+			case 0x05:
+				strlcat(msg, "SG_ERR_DRIVER_INVALID", MAXERRDETAIL);
+				break;
+			case 0x06:
+				strlcat(msg, "SG_ERR_DRIVER_TIMEOUT", MAXERRDETAIL);
+				break;
+			case 0x07:
+				strlcat(msg, "SG_ERR_DRIVER_HARD", MAXERRDETAIL);
+				break;
+			case 0x08:
+				strlcat(msg, "SG_ERR_DRIVER_SENSE", MAXERRDETAIL);
+				break;
+			default:
+				strlcat(msg, "Unknown", MAXERRDETAIL);
+				break;
+			}
+			strlcat(msg, "; ", MAXERRDETAIL);
+			switch (hdr->driver_status & 0xF0) {
+			case 0x10:
+				strlcat(msg, "SG_ERR_SUGGEST_RETRY", MAXERRDETAIL);
+				break;
+			case 0x20:
+				strlcat(msg, "SG_ERR_SUGGEST_ABORT", MAXERRDETAIL);
+				break;
+			case 0x30:
+				strlcat(msg, "SG_ERR_SUGGEST_REMAP", MAXERRDETAIL);
+				break;
+			case 0x40:
+				strlcat(msg, "SG_ERR_SUGGEST_DIE", MAXERRDETAIL);
+				break;
+			case 0x80:
+				strlcat(msg, "SG_ERR_SUGGEST_SENSE", MAXERRDETAIL);
+				break;
+			}
+			strlcat(msg, ". ", MAXERRDETAIL);
+		}
+		if (hdr->device_status) {
+			snprintf(msgchunk, MAXMSGCHUNK, "SG SCSI Status: 0x%02x; ",
+				 hdr->device_status);
+			strlcat(msg, msgchunk, MAXERRDETAIL);
+			// SCSI 3 status codes
+			switch (hdr->device_status) {
+			case 0x02:
+				strlcat(msg, "CHECK_CONDITION", MAXERRDETAIL);
+				break;
+			case 0x04:
+				strlcat(msg, "CONDITION_MET", MAXERRDETAIL);
+				break;
+			case 0x08:
+				strlcat(msg, "BUSY", MAXERRDETAIL);
+				break;
+			case 0x10:
+				strlcat(msg, "INTERMEDIATE", MAXERRDETAIL);
+				break;
+			case 0x14:
+				strlcat(msg, "INTERMEDIATE_CONDITION_MET", MAXERRDETAIL);
+				break;
+			case 0x18:
+				strlcat(msg, "RESERVATION_CONFLICT", MAXERRDETAIL);
+				break;
+			case 0x22:
+				strlcat(msg, "COMMAND_TERMINATED", MAXERRDETAIL);
+				break;
+			case 0x28:
+				strlcat(msg, "TASK_SET_FULL", MAXERRDETAIL);
+				break;
+			case 0x30:
+				strlcat(msg, "ACA_ACTIVE", MAXERRDETAIL);
+				break;
+			case 0x40:
+				strlcat(msg, "TASK_ABORTED", MAXERRDETAIL);
+				break;
+			default:
+				strlcat(msg, "Unknown", MAXERRDETAIL);
+				break;
+			}
+			strlcat(msg, ". ", MAXERRDETAIL);
+		}
+		if (hdr->response_len) {
+			snprintf(msgchunk, MAXMSGCHUNK, "Sense Data (%d bytes):",
+				 hdr->response_len);
+			strlcat(msg, msgchunk, MAXERRDETAIL);
+			for (i = 0; i < hdr->response_len; i++) {
+				snprintf(msgchunk, MAXMSGCHUNK, " %02x", sbp[i]);
+				strlcat(msg, msgchunk, MAXERRDETAIL);
+			}
+			strlcat(msg, ". ", MAXERRDETAIL);
+		}
+		if (hdr->din_resid != 0) {
+			snprintf(msgchunk, MAXMSGCHUNK, "SG Driver: %d bytes out of %d not "
+				 "transferred. ", hdr->din_resid, hdr->din_xfer_len);
+			strlcat(msg, msgchunk, MAXERRDETAIL);
+		}
+		if (cmdreq) {
+			strlcat(msg, "cdb:", MAXERRDETAIL);
+			for (i = 0; i < hdr->request_len; i++) {
+				snprintf(msgchunk, MAXMSGCHUNK, " %02x", cmdreq[i]);
+				strlcat(msg, msgchunk, MAXERRDETAIL);
+			}
+			strlcat(msg, ". ", MAXERRDETAIL);
+			if (io_u->ddir == DDIR_TRIM) {
+				unsigned char *param_list = (void *)hdr->dout_xferp;
+				strlcat(msg, "dxferp:", MAXERRDETAIL);
+				for (i = 0; i < hdr->dout_xfer_len; i++) {
+					snprintf(msgchunk, MAXMSGCHUNK, " %02x", param_list[i]);
+					strlcat(msg, msgchunk, MAXERRDETAIL);
+				}
+				strlcat(msg, ". ", MAXERRDETAIL);
+			}
+		}
+	}
+
+	if (!(hdr->info & SG_INFO_CHECK) && !strlen(msg))
+		strncpy(msg, "SG Driver did not report a Host, Driver or Device check",
+			MAXERRDETAIL - 1);
+
+	return msg;
+}
+
+/*
+ * get max file size from read capacity.
+ */
+static int fio_sgv4io_get_file_size(struct thread_data *td, struct fio_file *f)
+{
+	/*
+	 * get_file_size is being called even before sgio_init is
+	 * called, so none of the sg_io structures are
+	 * initialized in the thread_data yet.  So we need to do the
+	 * ReadCapacity without any of those helpers.  One of the effects
+	 * is that ReadCapacity may get called 4 times on each open:
+	 * readcap(10) followed by readcap(16) if needed - just to get
+	 * the file size after the init occurs - it will be called
+	 * again when "type_check" is called during structure
+	 * initialization I'm not sure how to prevent this little
+	 * inefficiency.
+	 */
+	unsigned int bs = 0;
+	unsigned long long max_lba = 0;
+	int ret;
+
+	if (fio_file_size_known(f))
+		return 0;
+
+	if (f->filetype != FIO_TYPE_CHAR) {
+		td_verror(td, EINVAL, "wrong file type");
+		log_err("ioengine sgv4 only works on sg_bsg character devices\n");
+		return 1;
+	}
+
+	ret = fio_sgv4io_read_capacity(td, &bs, &max_lba);
+	if (ret ) {
+		td_verror(td, td->error, "fio_sgv4io_read_capacity");
+		log_err("ioengine sgv4 unable to successfully execute read capacity to get block size and maximum lba\n");
+		return 1;
+	}
+
+	f->real_file_size = (max_lba + 1) * bs;
+	fio_file_set_size_known(f);
+	return 0;
+}
+
+
+static struct ioengine_ops ioengine = {
+	.name		= "sgv4",
+	.version	= FIO_IOOPS_VERSION,
+	.init		= fio_sgv4io_init,
+	.prep		= fio_sgv4io_prep,
+	.queue		= fio_sgv4io_queue,
+	.commit		= fio_sgv4io_commit,
+	.getevents	= fio_sgv4io_getevents,
+	.errdetails	= fio_sgv4io_errdetails,
+	.event		= fio_sgv4io_event,
+	.cleanup	= fio_sgv4io_cleanup,
+	.open_file	= fio_sgv4io_open,
+	.close_file	= generic_close_file,
+	.get_file_size	= fio_sgv4io_get_file_size,
+	.flags		= FIO_SYNCIO | FIO_RAWIO,
+	.options	= options,
+	.option_struct_size	= sizeof(struct sgv4_options)
+};
+
+#else /* FIO_HAVE_SGV4IO */
+
+/*
+ * When we have a proper configure system in place, we simply wont build
+ * and install this io engine. For now install a crippled version that
+ * just complains and fails to load.
+ */
+static int fio_sgv4io_init(struct thread_data fio_unused *td)
+{
+	log_err("fio: ioengine sgv4 not available\n");
+	return 1;
+}
+
+static struct ioengine_ops ioengine = {
+	.name		= "sgv4",
+	.version	= FIO_IOOPS_VERSION,
+	.init		= fio_sgv4io_init,
+};
+
+#endif
+
+static void fio_init fio_sgv4io_register(void)
+{
+	register_ioengine(&ioengine);
+}
+
+static void fio_exit fio_sgv4io_unregister(void)
+{
+	unregister_ioengine(&ioengine);
+}
diff --git a/io_u.h b/io_u.h
index e75993bd..35a71b6f 100644
--- a/io_u.h
+++ b/io_u.h
@@ -122,7 +122,10 @@ struct io_u {
 		os_aiocb_t aiocb;
 #endif
 #ifdef FIO_HAVE_SGIO
-		struct sg_io_hdr hdr;
+		struct sg_io_hdr hdr3;
+#endif
+#ifdef FIO_HAVE_SGV4IO
+		struct sg_io_v4 hdr4;
 #endif
 #ifdef CONFIG_GUASI
 		guasi_req_t greq;
diff --git a/os/os-linux.h b/os/os-linux.h
index 36339ef3..33eb5fff 100644
--- a/os/os-linux.h
+++ b/os/os-linux.h
@@ -17,6 +17,7 @@
 #include <linux/raw.h>
 #include <linux/major.h>
 #include <linux/fs.h>
+#include <linux/bsg.h>
 #include <scsi/sg.h>
 
 #ifdef ARCH_HAVE_CRC_CRYPTO
@@ -36,6 +37,7 @@
 #define FIO_HAVE_CPU_AFFINITY
 #define FIO_HAVE_DISK_UTIL
 #define FIO_HAVE_SGIO
+#define FIO_HAVE_SGV4IO
 #define FIO_HAVE_IOPRIO
 #define FIO_HAVE_IOPRIO_CLASS
 #define FIO_HAVE_IOSCHED_SWITCH
-- 
2.17.1

