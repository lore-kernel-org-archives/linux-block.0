Return-Path: <SRS0=KrPA=UR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B40C31E64
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 21:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F4C2084A
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 21:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560892031;
	bh=u2JpIRW/55R+MxFRXl+sr56fi9lHiFXiuv0EKpb/0Js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZHtAlhvg9RwYg205hO3KhOPUjbJuyMTI9krSPP+HUCBaFo33rV2p+7CXC0Mk7Jgg+
	 8sgZkPHXC56Ah1xkdxplKD8231GHWvbC/yAdgJetUh2xJcbHbdgxZnHhE+x5+GDELq
	 2ZjlP4SnY+gZsQkZI+b/M3nt5fyRAvbgVG5cjrUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbfFRVFy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jun 2019 17:05:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34484 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730781AbfFRVFx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jun 2019 17:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qOr789l/TswLnF4O/npW1sS+KMtfhcPpGSKYaQtwk5w=; b=J5i7SHm6vVcHoArXsm8NRBLJcc
        ab4LxX+UxUuTFrWtGNzwyqwlnkqdPs8TDqJy9y+hOcgw4KCODqAW6RMcfKjB1pf7Z+3/7/hH5VMvu
        rXitO6ADl6uCSDckF2g1kKOqpYNuyUzKHAaHOSQUJIzKP14oFqqdqvIuiCKlUGkaK8awiaMsctRAa
        lRnXzW4lMzMuXmUU0Zuw0FfPCfZmF121fHKnkpb1MuvwORm7k5RwJaIAHZwaY24woyySu8i1elxr0
        Dgk/txVp5J3/7gBv4DuRohfRolkpw2zxKbHWFMNtclZcjG+SW4pnUKaeO+GzgePs4b7kvfEtuSQiG
        gQMWPcWw==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdLIc-0006yf-2W; Tue, 18 Jun 2019 21:05:51 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hdLIZ-0002CK-SU; Tue, 18 Jun 2019 18:05:47 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH v1 09/22] docs: block: convert to ReST
Date:   Tue, 18 Jun 2019 18:05:33 -0300
Message-Id: <5c4b92b06ce69f686569e6490034958592d649c9.1560891322.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560891322.git.mchehab+samsung@kernel.org>
References: <cover.1560891322.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Rename the block documentation files to ReST, add an
index for them and adjust in order to produce a nice html
output via the Sphinx build system.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |   8 +-
 .../{bfq-iosched.txt => bfq-iosched.rst}      |  66 ++--
 .../block/{biodoc.txt => biodoc.rst}          | 364 +++++++++++-------
 .../block/{biovecs.txt => biovecs.rst}        |  20 +-
 .../block/{capability.txt => capability.rst}  |  17 +-
 ...ne-partition.txt => cmdline-partition.rst} |  13 +-
 ...{data-integrity.txt => data-integrity.rst} |  60 +--
 ...dline-iosched.txt => deadline-iosched.rst} |  21 +-
 Documentation/block/index.rst                 |  25 ++
 .../block/{ioprio.txt => ioprio.rst}          |  95 +++--
 .../{kyber-iosched.txt => kyber-iosched.rst}  |   3 +-
 .../block/{null_blk.txt => null_blk.rst}      |  65 +++-
 Documentation/block/{pr.txt => pr.rst}        |  18 +-
 .../{queue-sysfs.txt => queue-sysfs.rst}      |   7 +-
 .../block/{request.txt => request.rst}        |  47 ++-
 Documentation/block/{stat.txt => stat.rst}    |  13 +-
 ...witching-sched.txt => switching-sched.rst} |  28 +-
 ...ontrol.txt => writeback_cache_control.rst} |  12 +-
 Documentation/blockdev/zram.rst               |   2 +-
 MAINTAINERS                                   |   2 +-
 block/Kconfig                                 |   2 +-
 block/Kconfig.iosched                         |   2 +-
 block/bfq-iosched.c                           |   2 +-
 block/blk-integrity.c                         |   2 +-
 block/ioprio.c                                |   2 +-
 block/mq-deadline.c                           |   2 +-
 block/partitions/cmdline.c                    |   2 +-
 27 files changed, 550 insertions(+), 350 deletions(-)
 rename Documentation/block/{bfq-iosched.txt => bfq-iosched.rst} (95%)
 rename Documentation/block/{biodoc.txt => biodoc.rst} (83%)
 rename Documentation/block/{biovecs.txt => biovecs.rst} (92%)
 rename Documentation/block/{capability.txt => capability.rst} (40%)
 rename Documentation/block/{cmdline-partition.txt => cmdline-partition.rst} (92%)
 rename Documentation/block/{data-integrity.txt => data-integrity.rst} (91%)
 rename Documentation/block/{deadline-iosched.txt => deadline-iosched.rst} (89%)
 create mode 100644 Documentation/block/index.rst
 rename Documentation/block/{ioprio.txt => ioprio.rst} (75%)
 rename Documentation/block/{kyber-iosched.txt => kyber-iosched.rst} (86%)
 rename Documentation/block/{null_blk.txt => null_blk.rst} (60%)
 rename Documentation/block/{pr.txt => pr.rst} (93%)
 rename Documentation/block/{queue-sysfs.txt => queue-sysfs.rst} (99%)
 rename Documentation/block/{request.txt => request.rst} (59%)
 rename Documentation/block/{stat.txt => stat.rst} (89%)
 rename Documentation/block/{switching-sched.txt => switching-sched.rst} (67%)
 rename Documentation/block/{writeback_cache_control.txt => writeback_cache_control.rst} (94%)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a15295e180fe..d11b8a745897 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -430,7 +430,7 @@
 
 	blkdevparts=	Manual partition parsing of block device(s) for
 			embedded devices based on command line input.
-			See Documentation/block/cmdline-partition.txt
+			See Documentation/block/cmdline-partition.rst
 
 	boot_delay=	Milliseconds to delay each printk during boot.
 			Values larger than 10 seconds (10000) are changed to
@@ -1199,9 +1199,9 @@
 
 	elevator=	[IOSCHED]
 			Format: { "mq-deadline" | "kyber" | "bfq" }
-			See Documentation/block/deadline-iosched.txt,
-			Documentation/block/kyber-iosched.txt and
-			Documentation/block/bfq-iosched.txt for details.
+			See Documentation/block/deadline-iosched.rst,
+			Documentation/block/kyber-iosched.rst and
+			Documentation/block/bfq-iosched.rst for details.
 
 	elfcorehdr=[size[KMG]@]offset[KMG] [IA64,PPC,SH,X86,S390]
 			Specifies physical address of start of kernel core
diff --git a/Documentation/block/bfq-iosched.txt b/Documentation/block/bfq-iosched.rst
similarity index 95%
rename from Documentation/block/bfq-iosched.txt
rename to Documentation/block/bfq-iosched.rst
index b2265cf6c9c3..3fd9e8029347 100644
--- a/Documentation/block/bfq-iosched.txt
+++ b/Documentation/block/bfq-iosched.rst
@@ -1,9 +1,11 @@
+==========================
 BFQ (Budget Fair Queueing)
 ==========================
 
 BFQ is a proportional-share I/O scheduler, with some extra
 low-latency capabilities. In addition to cgroups support (blkio or io
 controllers), BFQ's main features are:
+
 - BFQ guarantees a high system and application responsiveness, and a
   low latency for time-sensitive applications, such as audio or video
   players;
@@ -55,18 +57,18 @@ sustainable throughputs, on the same systems as above:
 
 BFQ works for multi-queue devices too.
 
-The table of contents follow. Impatients can just jump to Section 3.
+.. The table of contents follow. Impatients can just jump to Section 3.
 
-CONTENTS
+.. CONTENTS
 
-1. When may BFQ be useful?
- 1-1 Personal systems
- 1-2 Server systems
-2. How does BFQ work?
-3. What are BFQ's tunables and how to properly configure BFQ?
-4. BFQ group scheduling
- 4-1 Service guarantees provided
- 4-2 Interface
+   1. When may BFQ be useful?
+    1-1 Personal systems
+    1-2 Server systems
+   2. How does BFQ work?
+   3. What are BFQ's tunables and how to properly configure BFQ?
+   4. BFQ group scheduling
+    4-1 Service guarantees provided
+    4-2 Interface
 
 1. When may BFQ be useful?
 ==========================
@@ -77,17 +79,20 @@ BFQ provides the following benefits on personal and server systems.
 --------------------
 
 Low latency for interactive applications
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 Regardless of the actual background workload, BFQ guarantees that, for
 interactive tasks, the storage device is virtually as responsive as if
 it was idle. For example, even if one or more of the following
 background workloads are being executed:
+
 - one or more large files are being read, written or copied,
 - a tree of source files is being compiled,
 - one or more virtual machines are performing I/O,
 - a software update is in progress,
 - indexing daemons are scanning filesystems and updating their
   databases,
+
 starting an application or loading a file from within an application
 takes about the same time as if the storage device was idle. As a
 comparison, with CFQ, NOOP or DEADLINE, and in the same conditions,
@@ -95,13 +100,14 @@ applications experience high latencies, or even become unresponsive
 until the background workload terminates (also on SSDs).
 
 Low latency for soft real-time applications
-
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 Also soft real-time applications, such as audio and video
 players/streamers, enjoy a low latency and a low drop rate, regardless
 of the background I/O workload. As a consequence, these applications
 do not suffer from almost any glitch due to the background workload.
 
 Higher speed for code-development tasks
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 If some additional workload happens to be executed in parallel, then
 BFQ executes the I/O-related components of typical code-development
@@ -109,6 +115,7 @@ tasks (compilation, checkout, merge, ...) much more quickly than CFQ,
 NOOP or DEADLINE.
 
 High throughput
+^^^^^^^^^^^^^^^
 
 On hard disks, BFQ achieves up to 30% higher throughput than CFQ, and
 up to 150% higher throughput than DEADLINE and NOOP, with all the
@@ -117,6 +124,7 @@ and with all the workloads on flash-based devices, BFQ achieves,
 instead, about the same throughput as the other schedulers.
 
 Strong fairness, bandwidth and delay guarantees
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 BFQ distributes the device throughput, and not just the device time,
 among I/O-bound applications in proportion their weights, with any
@@ -133,15 +141,15 @@ Most benefits for server systems follow from the same service
 properties as above. In particular, regardless of whether additional,
 possibly heavy workloads are being served, BFQ guarantees:
 
-. audio and video-streaming with zero or very low jitter and drop
+* audio and video-streaming with zero or very low jitter and drop
   rate;
 
-. fast retrieval of WEB pages and embedded objects;
+* fast retrieval of WEB pages and embedded objects;
 
-. real-time recording of data in live-dumping applications (e.g.,
+* real-time recording of data in live-dumping applications (e.g.,
   packet logging);
 
-. responsiveness in local and remote access to a server.
+* responsiveness in local and remote access to a server.
 
 
 2. How does BFQ work?
@@ -151,7 +159,7 @@ BFQ is a proportional-share I/O scheduler, whose general structure,
 plus a lot of code, are borrowed from CFQ.
 
 - Each process doing I/O on a device is associated with a weight and a
-  (bfq_)queue.
+  `(bfq_)queue`.
 
 - BFQ grants exclusive access to the device, for a while, to one queue
   (process) at a time, and implements this service model by
@@ -540,11 +548,12 @@ created, and kept up-to-date by bfq, depends on whether
 CONFIG_DEBUG_BLK_CGROUP is set. If it is set, then bfq creates all
 the stat files documented in
 Documentation/cgroup-v1/blkio-controller.rst. If, instead,
-CONFIG_DEBUG_BLK_CGROUP is not set, then bfq creates only the files
-blkio.bfq.io_service_bytes
-blkio.bfq.io_service_bytes_recursive
-blkio.bfq.io_serviced
-blkio.bfq.io_serviced_recursive
+CONFIG_DEBUG_BLK_CGROUP is not set, then bfq creates only the files::
+
+  blkio.bfq.io_service_bytes
+  blkio.bfq.io_service_bytes_recursive
+  blkio.bfq.io_serviced
+  blkio.bfq.io_serviced_recursive
 
 The value of CONFIG_DEBUG_BLK_CGROUP greatly influences the maximum
 throughput sustainable with bfq, because updating the blkio.bfq.*
@@ -567,17 +576,22 @@ weight of the queues associated with interactive and soft real-time
 applications. Unset this tunable if you need/want to control weights.
 
 
-[1] P. Valente, A. Avanzini, "Evolution of the BFQ Storage I/O
+[1]
+    P. Valente, A. Avanzini, "Evolution of the BFQ Storage I/O
     Scheduler", Proceedings of the First Workshop on Mobile System
     Technologies (MST-2015), May 2015.
+
     http://algogroup.unimore.it/people/paolo/disk_sched/mst-2015.pdf
 
-[2] P. Valente and M. Andreolini, "Improving Application
+[2]
+    P. Valente and M. Andreolini, "Improving Application
     Responsiveness with the BFQ Disk I/O Scheduler", Proceedings of
     the 5th Annual International Systems and Storage Conference
     (SYSTOR '12), June 2012.
+
     Slightly extended version:
-    http://algogroup.unimore.it/people/paolo/disk_sched/bfq-v1-suite-
-							results.pdf
 
-[3] https://github.com/Algodev-github/S
+    http://algogroup.unimore.it/people/paolo/disk_sched/bfq-v1-suite-results.pdf
+
+[3]
+   https://github.com/Algodev-github/S
diff --git a/Documentation/block/biodoc.txt b/Documentation/block/biodoc.rst
similarity index 83%
rename from Documentation/block/biodoc.txt
rename to Documentation/block/biodoc.rst
index ac504de0cb93..59bd93bec8fc 100644
--- a/Documentation/block/biodoc.txt
+++ b/Documentation/block/biodoc.rst
@@ -1,15 +1,24 @@
-	Notes on the Generic Block Layer Rewrite in Linux 2.5
-	=====================================================
+=====================================================
+Notes on the Generic Block Layer Rewrite in Linux 2.5
+=====================================================
+
+.. note::
+
+	It seems that there are lot of outdated stuff here. This seems
+	to be written somewhat as a task list. Yet, eventually, something
+	here might still be useful.
 
 Notes Written on Jan 15, 2002:
-	Jens Axboe <jens.axboe@oracle.com>
-	Suparna Bhattacharya <suparna@in.ibm.com>
+	- Jens Axboe <jens.axboe@oracle.com>
+	- Suparna Bhattacharya <suparna@in.ibm.com>
 
 Last Updated May 2, 2002
+
 September 2003: Updated I/O Scheduler portions
-	Nick Piggin <npiggin@kernel.dk>
+	- Nick Piggin <npiggin@kernel.dk>
 
-Introduction:
+Introduction
+============
 
 These are some notes describing some aspects of the 2.5 block layer in the
 context of the bio rewrite. The idea is to bring out some of the key
@@ -17,11 +26,11 @@ changes and a glimpse of the rationale behind those changes.
 
 Please mail corrections & suggestions to suparna@in.ibm.com.
 
-Credits:
----------
+Credits
+=======
 
 2.5 bio rewrite:
-	Jens Axboe <jens.axboe@oracle.com>
+	- Jens Axboe <jens.axboe@oracle.com>
 
 Many aspects of the generic block layer redesign were driven by and evolved
 over discussions, prior patches and the collective experience of several
@@ -29,62 +38,63 @@ people. See sections 8 and 9 for a list of some related references.
 
 The following people helped with review comments and inputs for this
 document:
-	Christoph Hellwig <hch@infradead.org>
-	Arjan van de Ven <arjanv@redhat.com>
-	Randy Dunlap <rdunlap@xenotime.net>
-	Andre Hedrick <andre@linux-ide.org>
+
+	- Christoph Hellwig <hch@infradead.org>
+	- Arjan van de Ven <arjanv@redhat.com>
+	- Randy Dunlap <rdunlap@xenotime.net>
+	- Andre Hedrick <andre@linux-ide.org>
 
 The following people helped with fixes/contributions to the bio patches
 while it was still work-in-progress:
-	David S. Miller <davem@redhat.com>
 
+	- David S. Miller <davem@redhat.com>
 
-Description of Contents:
-------------------------
 
-1. Scope for tuning of logic to various needs
-  1.1 Tuning based on device or low level driver capabilities
+.. Description of Contents:
+
+   1. Scope for tuning of logic to various needs
+     1.1 Tuning based on device or low level driver capabilities
 	- Per-queue parameters
 	- Highmem I/O support
 	- I/O scheduler modularization
-  1.2 Tuning based on high level requirements/capabilities
+     1.2 Tuning based on high level requirements/capabilities
 	1.2.1 Request Priority/Latency
-  1.3 Direct access/bypass to lower layers for diagnostics and special
-      device operations
+     1.3 Direct access/bypass to lower layers for diagnostics and special
+	 device operations
 	1.3.1 Pre-built commands
-2. New flexible and generic but minimalist i/o structure or descriptor
-   (instead of using buffer heads at the i/o layer)
-  2.1 Requirements/Goals addressed
-  2.2 The bio struct in detail (multi-page io unit)
-  2.3 Changes in the request structure
-3. Using bios
-  3.1 Setup/teardown (allocation, splitting)
-  3.2 Generic bio helper routines
-    3.2.1 Traversing segments and completion units in a request
-    3.2.2 Setting up DMA scatterlists
-    3.2.3 I/O completion
-    3.2.4 Implications for drivers that do not interpret bios (don't handle
- 	  multiple segments)
-  3.3 I/O submission
-4. The I/O scheduler
-5. Scalability related changes
-  5.1 Granular locking: Removal of io_request_lock
-  5.2 Prepare for transition to 64 bit sector_t
-6. Other Changes/Implications
-  6.1 Partition re-mapping handled by the generic block layer
-7. A few tips on migration of older drivers
-8. A list of prior/related/impacted patches/ideas
-9. Other References/Discussion Threads
+   2. New flexible and generic but minimalist i/o structure or descriptor
+      (instead of using buffer heads at the i/o layer)
+     2.1 Requirements/Goals addressed
+     2.2 The bio struct in detail (multi-page io unit)
+     2.3 Changes in the request structure
+   3. Using bios
+     3.1 Setup/teardown (allocation, splitting)
+     3.2 Generic bio helper routines
+       3.2.1 Traversing segments and completion units in a request
+       3.2.2 Setting up DMA scatterlists
+       3.2.3 I/O completion
+       3.2.4 Implications for drivers that do not interpret bios (don't handle
+	  multiple segments)
+     3.3 I/O submission
+   4. The I/O scheduler
+   5. Scalability related changes
+     5.1 Granular locking: Removal of io_request_lock
+     5.2 Prepare for transition to 64 bit sector_t
+   6. Other Changes/Implications
+     6.1 Partition re-mapping handled by the generic block layer
+   7. A few tips on migration of older drivers
+   8. A list of prior/related/impacted patches/ideas
+   9. Other References/Discussion Threads
 
----------------------------------------------------------------------------
 
 Bio Notes
---------
+=========
 
 Let us discuss the changes in the context of how some overall goals for the
 block layer are addressed.
 
 1. Scope for tuning the generic logic to satisfy various requirements
+=====================================================================
 
 The block layer design supports adaptable abstractions to handle common
 processing with the ability to tune the logic to an appropriate extent
@@ -97,6 +107,7 @@ and application/middleware software designed to take advantage of these
 capabilities.
 
 1.1 Tuning based on low level device / driver capabilities
+----------------------------------------------------------
 
 Sophisticated devices with large built-in caches, intelligent i/o scheduling
 optimizations, high memory DMA support, etc may find some of the
@@ -133,12 +144,12 @@ Some new queue property settings:
 		Sets two variables that limit the size of the request.
 
 		- The request queue's max_sectors, which is a soft size in
-		units of 512 byte sectors, and could be dynamically varied
-		by the core kernel.
+		  units of 512 byte sectors, and could be dynamically varied
+		  by the core kernel.
 
 		- The request queue's max_hw_sectors, which is a hard limit
-		and reflects the maximum size request a driver can handle
-		in units of 512 byte sectors.
+		  and reflects the maximum size request a driver can handle
+		  in units of 512 byte sectors.
 
 		The default for both max_sectors and max_hw_sectors is
 		255. The upper limit of max_sectors is 1024.
@@ -234,6 +245,7 @@ I/O scheduler wrappers are to be used instead of accessing the queue directly.
 See section 4. The I/O scheduler for details.
 
 1.2 Tuning Based on High level code capabilities
+------------------------------------------------
 
 i. Application capabilities for raw i/o
 
@@ -258,9 +270,11 @@ would need an additional mechanism either via open flags or ioctls, or some
 other upper level mechanism to communicate such settings to block.
 
 1.2.1 Request Priority/Latency
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-Todo/Under discussion:
-Arjan's proposed request priority scheme allows higher levels some broad
+Todo/Under discussion::
+
+  Arjan's proposed request priority scheme allows higher levels some broad
   control (high/med/low) over the priority  of an i/o request vs other pending
   requests in the queue. For example it allows reads for bringing in an
   executable page on demand to be given a higher priority over pending write
@@ -272,7 +286,9 @@ Arjan's proposed request priority scheme allows higher levels some broad
 
 
 1.3 Direct Access to Low level Device/Driver Capabilities (Bypass mode)
-    (e.g Diagnostics, Systems Management)
+-----------------------------------------------------------------------
+
+(e.g Diagnostics, Systems Management)
 
 There are situations where high-level code needs to have direct access to
 the low level device capabilities or requires the ability to issue commands
@@ -308,28 +324,32 @@ involved. In the latter case, the driver would modify and manage the
 request->buffer, request->sector and request->nr_sectors or
 request->current_nr_sectors fields itself rather than using the block layer
 end_request or end_that_request_first completion interfaces.
-(See 2.3 or Documentation/block/request.txt for a brief explanation of
+(See 2.3 or Documentation/block/request.rst for a brief explanation of
 the request structure fields)
 
-[TBD: end_that_request_last should be usable even in this case;
-Perhaps an end_that_direct_request_first routine could be implemented to make
-handling direct requests easier for such drivers; Also for drivers that
-expect bios, a helper function could be provided for setting up a bio
-corresponding to a data buffer]
+::
 
-<JENS: I dont understand the above, why is end_that_request_first() not
-usable? Or _last for that matter. I must be missing something>
-<SUP: What I meant here was that if the request doesn't have a bio, then
- end_that_request_first doesn't modify nr_sectors or current_nr_sectors,
- and hence can't be used for advancing request state settings on the
- completion of partial transfers. The driver has to modify these fields 
- directly by hand.
- This is because end_that_request_first only iterates over the bio list,
- and always returns 0 if there are none associated with the request.
- _last works OK in this case, and is not a problem, as I mentioned earlier
->
+  [TBD: end_that_request_last should be usable even in this case;
+  Perhaps an end_that_direct_request_first routine could be implemented to make
+  handling direct requests easier for such drivers; Also for drivers that
+  expect bios, a helper function could be provided for setting up a bio
+  corresponding to a data buffer]
+
+  <JENS: I dont understand the above, why is end_that_request_first() not
+  usable? Or _last for that matter. I must be missing something>
+
+  <SUP: What I meant here was that if the request doesn't have a bio, then
+   end_that_request_first doesn't modify nr_sectors or current_nr_sectors,
+   and hence can't be used for advancing request state settings on the
+   completion of partial transfers. The driver has to modify these fields
+   directly by hand.
+   This is because end_that_request_first only iterates over the bio list,
+   and always returns 0 if there are none associated with the request.
+   _last works OK in this case, and is not a problem, as I mentioned earlier
+  >
 
 1.3.1 Pre-built Commands
+^^^^^^^^^^^^^^^^^^^^^^^^
 
 A request can be created with a pre-built custom command  to be sent directly
 to the device. The cmd block in the request structure has room for filling
@@ -360,9 +380,11 @@ Aside:
   the pre-builder hook can be invoked there.
 
 
-2. Flexible and generic but minimalist i/o structure/descriptor.
+2. Flexible and generic but minimalist i/o structure/descriptor
+===============================================================
 
 2.1 Reason for a new structure and requirements addressed
+---------------------------------------------------------
 
 Prior to 2.5, buffer heads were used as the unit of i/o at the generic block
 layer, and the low level request structure was associated with a chain of
@@ -378,26 +400,26 @@ which were generated for each such chunk.
 The following were some of the goals and expectations considered in the
 redesign of the block i/o data structure in 2.5.
 
-i.  Should be appropriate as a descriptor for both raw and buffered i/o  -
+1.  Should be appropriate as a descriptor for both raw and buffered i/o  -
     avoid cache related fields which are irrelevant in the direct/page i/o path,
     or filesystem block size alignment restrictions which may not be relevant
     for raw i/o.
-ii. Ability to represent high-memory buffers (which do not have a virtual
+2.  Ability to represent high-memory buffers (which do not have a virtual
     address mapping in kernel address space).
-iii.Ability to represent large i/os w/o unnecessarily breaking them up (i.e
+3.  Ability to represent large i/os w/o unnecessarily breaking them up (i.e
     greater than PAGE_SIZE chunks in one shot)
-iv. At the same time, ability to retain independent identity of i/os from
+4.  At the same time, ability to retain independent identity of i/os from
     different sources or i/o units requiring individual completion (e.g. for
     latency reasons)
-v.  Ability to represent an i/o involving multiple physical memory segments
+5.  Ability to represent an i/o involving multiple physical memory segments
     (including non-page aligned page fragments, as specified via readv/writev)
     without unnecessarily breaking it up, if the underlying device is capable of
     handling it.
-vi. Preferably should be based on a memory descriptor structure that can be
+6.  Preferably should be based on a memory descriptor structure that can be
     passed around different types of subsystems or layers, maybe even
     networking, without duplication or extra copies of data/descriptor fields
     themselves in the process
-vii.Ability to handle the possibility of splits/merges as the structure passes
+7.  Ability to handle the possibility of splits/merges as the structure passes
     through layered drivers (lvm, md, evms), with minimal overhead.
 
 The solution was to define a new structure (bio)  for the block layer,
@@ -408,6 +430,7 @@ bh structure for buffered i/o, and in the case of raw/direct i/o kiobufs are
 mapped to bio structures.
 
 2.2 The bio struct
+------------------
 
 The bio structure uses a vector representation pointing to an array of tuples
 of <page, offset, len> to describe the i/o buffer, and has various other
@@ -417,34 +440,36 @@ performing the i/o.
 Notice that this representation means that a bio has no virtual address
 mapping at all (unlike buffer heads).
 
-struct bio_vec {
-       struct page     *bv_page;
-       unsigned short  bv_len;
-       unsigned short  bv_offset;
-};
+::
 
-/*
- * main unit of I/O for the block layer and lower layers (ie drivers)
- */
-struct bio {
-       struct bio          *bi_next;    /* request queue link */
-       struct block_device *bi_bdev;	/* target device */
-       unsigned long       bi_flags;    /* status, command, etc */
-       unsigned long       bi_opf;       /* low bits: r/w, high: priority */
+  struct bio_vec {
+	 struct page     *bv_page;
+	 unsigned short  bv_len;
+	 unsigned short  bv_offset;
+  };
 
-       unsigned int	bi_vcnt;     /* how may bio_vec's */
-       struct bvec_iter	bi_iter;	/* current index into bio_vec array */
+  /*
+   * main unit of I/O for the block layer and lower layers (ie drivers)
+   */
+  struct bio {
+	 struct bio          *bi_next;    /* request queue link */
+	 struct block_device *bi_bdev;	/* target device */
+	 unsigned long       bi_flags;    /* status, command, etc */
+	 unsigned long       bi_opf;       /* low bits: r/w, high: priority */
 
-       unsigned int	bi_size;     /* total size in bytes */
-       unsigned short 	bi_phys_segments; /* segments after physaddr coalesce*/
-       unsigned short	bi_hw_segments; /* segments after DMA remapping */
-       unsigned int	bi_max;	     /* max bio_vecs we can hold
-                                        used as index into pool */
-       struct bio_vec   *bi_io_vec;  /* the actual vec list */
-       bio_end_io_t	*bi_end_io;  /* bi_end_io (bio) */
-       atomic_t		bi_cnt;	     /* pin count: free when it hits zero */
-       void             *bi_private;
-};
+	 unsigned int	bi_vcnt;     /* how may bio_vec's */
+	 struct bvec_iter	bi_iter;	/* current index into bio_vec array */
+
+	 unsigned int	bi_size;     /* total size in bytes */
+	 unsigned short 	bi_phys_segments; /* segments after physaddr coalesce*/
+	 unsigned short	bi_hw_segments; /* segments after DMA remapping */
+	 unsigned int	bi_max;	     /* max bio_vecs we can hold
+					  used as index into pool */
+	 struct bio_vec   *bi_io_vec;  /* the actual vec list */
+	 bio_end_io_t	*bi_end_io;  /* bi_end_io (bio) */
+	 atomic_t		bi_cnt;	     /* pin count: free when it hits zero */
+	 void             *bi_private;
+  };
 
 With this multipage bio design:
 
@@ -454,7 +479,7 @@ With this multipage bio design:
 - Splitting of an i/o request across multiple devices (as in the case of
   lvm or raid) is achieved by cloning the bio (where the clone points to
   the same bi_io_vec array, but with the index and size accordingly modified)
-- A linked list of bios is used as before for unrelated merges (*) - this
+- A linked list of bios is used as before for unrelated merges [*]_ - this
   avoids reallocs and makes independent completions easier to handle.
 - Code that traverses the req list can find all the segments of a bio
   by using rq_for_each_segment.  This handles the fact that a request
@@ -463,10 +488,12 @@ With this multipage bio design:
   field to keep track of the next bio_vec entry to process.
   (e.g a 1MB bio_vec needs to be handled in max 128kB chunks for IDE)
   [TBD: Should preferably also have a bi_voffset and bi_vlen to avoid modifying
-   bi_offset an len fields]
+  bi_offset an len fields]
 
-(*) unrelated merges -- a request ends up containing two or more bios that
-    didn't originate from the same place.
+.. [*]
+
+	unrelated merges -- a request ends up containing two or more bios that
+	didn't originate from the same place.
 
 bi_end_io() i/o callback gets called on i/o completion of the entire bio.
 
@@ -484,10 +511,11 @@ which in turn means that only raw I/O uses it (direct i/o may not work
 right now). The intent however is to enable clustering of pages etc to
 become possible. The pagebuf abstraction layer from SGI also uses multi-page
 bios, but that is currently not included in the stock development kernels.
-The same is true of Andrew Morton's work-in-progress multipage bio writeout 
+The same is true of Andrew Morton's work-in-progress multipage bio writeout
 and readahead patches.
 
 2.3 Changes in the Request Structure
+------------------------------------
 
 The request structure is the structure that gets passed down to low level
 drivers. The block layer make_request function builds up a request structure,
@@ -500,11 +528,11 @@ request structure.
 Only some relevant fields (mainly those which changed or may be referred
 to in some of the discussion here) are listed below, not necessarily in
 the order in which they occur in the structure (see include/linux/blkdev.h)
-Refer to Documentation/block/request.txt for details about all the request
+Refer to Documentation/block/request.rst for details about all the request
 structure fields and a quick reference about the layers which are
-supposed to use or modify those fields.
+supposed to use or modify those fields::
 
-struct request {
+  struct request {
 	struct list_head queuelist;  /* Not meant to be directly accessed by
 					the driver.
 					Used by q->elv_next_request_fn
@@ -549,11 +577,11 @@ struct request {
 	.
 	struct bio *bio, *biotail;  /* bio list instead of bh */
 	struct request_list *rl;
-}
-	
+  }
+
 See the req_ops and req_flag_bits definitions for an explanation of the various
 flags available. Some bits are used by the block layer or i/o scheduler.
-	
+
 The behaviour of the various sector counts are almost the same as before,
 except that since we have multi-segment bios, current_nr_sectors refers
 to the numbers of sectors in the current segment being processed which could
@@ -579,8 +607,10 @@ a driver needs to be careful about interoperation with the block layer helper
 functions which the driver uses. (Section 1.3)
 
 3. Using bios
+=============
 
 3.1 Setup/Teardown
+------------------
 
 There are routines for managing the allocation, and reference counting, and
 freeing of bios (bio_alloc, bio_get, bio_put).
@@ -607,10 +637,13 @@ case of bio, these routines make use of the standard slab allocator.
 The caller of bio_alloc is expected to taken certain steps to avoid
 deadlocks, e.g. avoid trying to allocate more memory from the pool while
 already holding memory obtained from the pool.
-[TBD: This is a potential issue, though a rare possibility
- in the bounce bio allocation that happens in the current code, since
- it ends up allocating a second bio from the same pool while
- holding the original bio ]
+
+::
+
+  [TBD: This is a potential issue, though a rare possibility
+   in the bounce bio allocation that happens in the current code, since
+   it ends up allocating a second bio from the same pool while
+   holding the original bio ]
 
 Memory allocated from the pool should be released back within a limited
 amount of time (in the case of bio, that would be after the i/o is completed).
@@ -636,14 +669,18 @@ same bio_vec_list). This would typically be used for splitting i/o requests
 in lvm or md.
 
 3.2 Generic bio helper Routines
+-------------------------------
 
 3.2.1 Traversing segments and completion units in a request
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 The macro rq_for_each_segment() should be used for traversing the bios
 in the request list (drivers should avoid directly trying to do it
 themselves). Using these helpers should also make it easier to cope
 with block changes in the future.
 
+::
+
 	struct req_iterator iter;
 	rq_for_each_segment(bio_vec, rq, iter)
 		/* bio_vec is now current segment */
@@ -654,6 +691,7 @@ which don't make a distinction between segments and completion units would
 need to be reorganized to support multi-segment bios.
 
 3.2.2 Setting up DMA scatterlists
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 The blk_rq_map_sg() helper routine would be used for setting up scatter
 gather lists from a request, so a driver need not do it on its own.
@@ -684,6 +722,7 @@ of physical data segments in a request (i.e. the largest sized scatter list
 a driver could handle)
 
 3.2.3 I/O completion
+^^^^^^^^^^^^^^^^^^^^
 
 The existing generic block layer helper routines end_request,
 end_that_request_first and end_that_request_last can be used for i/o
@@ -692,8 +731,10 @@ request can be kicked of) as before. With the introduction of multi-page
 bio support, end_that_request_first requires an additional argument indicating
 the number of sectors completed.
 
-3.2.4 Implications for drivers that do not interpret bios (don't handle
- multiple segments)
+3.2.4 Implications for drivers that do not interpret bios
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+(don't handle multiple segments)
 
 Drivers that do not interpret bios e.g those which do not handle multiple
 segments and do not support i/o into high memory addresses (require bounce
@@ -708,15 +749,18 @@ be used if only if the request has come down from block/bio path, not for
 direct access requests which only specify rq->buffer without a valid rq->bio)
 
 3.3 I/O Submission
+------------------
 
 The routine submit_bio() is used to submit a single io. Higher level i/o
 routines make use of this:
 
 (a) Buffered i/o:
+
 The routine submit_bh() invokes submit_bio() on a bio corresponding to the
 bh, allocating the bio if required. ll_rw_block() uses submit_bh() as before.
 
 (b) Kiobuf i/o (for raw/direct i/o):
+
 The ll_rw_kio() routine breaks up the kiobuf into page sized chunks and
 maps the array to one or more multi-page bios, issuing submit_bio() to
 perform the i/o on each of these.
@@ -739,6 +783,7 @@ Todo/Observation:
 
 
 (c) Page i/o:
+
 Todo/Under discussion:
 
  Andrew Morton's multi-page bio patches attempt to issue multi-page
@@ -754,6 +799,7 @@ Todo/Under discussion:
  abstraction, but intended to be as lightweight as possible).
 
 (d) Direct access i/o:
+
 Direct access requests that do not contain bios would be submitted differently
 as discussed earlier in section 1.3.
 
@@ -781,11 +827,13 @@ Aside:
 
 
 4. The I/O scheduler
+====================
+
 I/O scheduler, a.k.a. elevator, is implemented in two layers.  Generic dispatch
 queue and specific I/O schedulers.  Unless stated otherwise, elevator is used
 to refer to both parts and I/O scheduler to specific I/O schedulers.
 
-Block layer implements generic dispatch queue in block/*.c.
+Block layer implements generic dispatch queue in `block/*.c`.
 The generic dispatch queue is responsible for requeueing, handling non-fs
 requests and all other subtleties.
 
@@ -803,8 +851,11 @@ doesn't implement a function, the switch does nothing or some minimal house
 keeping work.
 
 4.1. I/O scheduler API
+----------------------
 
 The functions an elevator may implement are: (* are mandatory)
+
+=============================== ================================================
 elevator_merge_fn		called to query requests for merge with a bio
 
 elevator_merge_req_fn		called when two requests get merged. the one
@@ -863,8 +914,11 @@ elevator_deactivate_req_fn	Called when device driver decides to delay
 elevator_init_fn*
 elevator_exit_fn		Allocate and free any elevator specific storage
 				for a queue.
+=============================== ================================================
 
 4.2 Request flows seen by I/O schedulers
+----------------------------------------
+
 All requests seen by I/O schedulers strictly follow one of the following three
 flows.
 
@@ -878,9 +932,12 @@ flows.
  -> put_req_fn
 
 4.3 I/O scheduler implementation
+--------------------------------
+
 The generic i/o scheduler algorithm attempts to sort/merge/batch requests for
 optimal disk scan and request servicing performance (based on generic
 principles and device capabilities), optimized for:
+
 i.   improved throughput
 ii.  improved latency
 iii. better utilization of h/w & CPU time
@@ -934,15 +991,19 @@ Aside:
   a big request from the broken up pieces coming by.
 
 4.4 I/O contexts
+----------------
+
 I/O contexts provide a dynamically allocated per process data area. They may
 be used in I/O schedulers, and in the block layer (could be used for IO statis,
-priorities for example). See *io_context in block/ll_rw_blk.c, and as-iosched.c
+priorities for example). See `*io_context` in block/ll_rw_blk.c, and as-iosched.c
 for an example of usage in an i/o scheduler.
 
 
 5. Scalability related changes
+==============================
 
 5.1 Granular Locking: io_request_lock replaced by a per-queue lock
+------------------------------------------------------------------
 
 The global io_request_lock has been removed as of 2.5, to avoid
 the scalability bottleneck it was causing, and has been replaced by more
@@ -957,20 +1018,23 @@ request_fn execution which it means that lots of older drivers
 should still be SMP safe. Drivers are free to drop the queue
 lock themselves, if required. Drivers that explicitly used the
 io_request_lock for serialization need to be modified accordingly.
-Usually it's as easy as adding a global lock:
+Usually it's as easy as adding a global lock::
 
 	static DEFINE_SPINLOCK(my_driver_lock);
 
 and passing the address to that lock to blk_init_queue().
 
 5.2 64 bit sector numbers (sector_t prepares for 64 bit support)
+----------------------------------------------------------------
 
 The sector number used in the bio structure has been changed to sector_t,
 which could be defined as 64 bit in preparation for 64 bit sector support.
 
 6. Other Changes/Implications
+=============================
 
 6.1 Partition re-mapping handled by the generic block layer
+-----------------------------------------------------------
 
 In 2.5 some of the gendisk/partition related code has been reorganized.
 Now the generic block layer performs partition-remapping early and thus
@@ -985,6 +1049,7 @@ sent are offset from the beginning of the device.
 
 
 7. A Few Tips on Migration of older drivers
+===========================================
 
 Old-style drivers that just use CURRENT and ignores clustered requests,
 may not need much change.  The generic layer will automatically handle
@@ -1018,12 +1083,12 @@ blk_init_queue time.
 
 Drivers no longer have to map a {partition, sector offset} into the
 correct absolute location anymore, this is done by the block layer, so
-where a driver received a request ala this before:
+where a driver received a request ala this before::
 
 	rq->rq_dev = mk_kdev(3, 5);	/* /dev/hda5 */
 	rq->sector = 0;			/* first sector on hda5 */
 
-  it will now see
+it will now see::
 
 	rq->rq_dev = mk_kdev(3, 0);	/* /dev/hda */
 	rq->sector = 123128;		/* offset from start of disk */
@@ -1040,38 +1105,65 @@ a bio into the virtual address space.
 
 
 8. Prior/Related/Impacted patches
+=================================
 
 8.1. Earlier kiobuf patches (sct/axboe/chait/hch/mkp)
+-----------------------------------------------------
+
 - orig kiobuf & raw i/o patches (now in 2.4 tree)
 - direct kiobuf based i/o to devices (no intermediate bh's)
 - page i/o using kiobuf
 - kiobuf splitting for lvm (mkp)
 - elevator support for kiobuf request merging (axboe)
+
 8.2. Zero-copy networking (Dave Miller)
+---------------------------------------
+
 8.3. SGI XFS - pagebuf patches - use of kiobufs
+-----------------------------------------------
 8.4. Multi-page pioent patch for bio (Christoph Hellwig)
+--------------------------------------------------------
 8.5. Direct i/o implementation (Andrea Arcangeli) since 2.4.10-pre11
+--------------------------------------------------------------------
 8.6. Async i/o implementation patch (Ben LaHaise)
+-------------------------------------------------
 8.7. EVMS layering design (IBM EVMS team)
-8.8. Larger page cache size patch (Ben LaHaise) and
-     Large page size (Daniel Phillips)
+-----------------------------------------
+8.8. Larger page cache size patch (Ben LaHaise) and Large page size (Daniel Phillips)
+-------------------------------------------------------------------------------------
+
     => larger contiguous physical memory buffers
+
 8.9. VM reservations patch (Ben LaHaise)
+----------------------------------------
 8.10. Write clustering patches ? (Marcelo/Quintela/Riel ?)
+----------------------------------------------------------
 8.11. Block device in page cache patch (Andrea Archangeli) - now in 2.4.10+
-8.12. Multiple block-size transfers for faster raw i/o (Shailabh Nagar,
-      Badari)
+---------------------------------------------------------------------------
+8.12. Multiple block-size transfers for faster raw i/o (Shailabh Nagar, Badari)
+-------------------------------------------------------------------------------
 8.13  Priority based i/o scheduler - prepatches (Arjan van de Ven)
+------------------------------------------------------------------
 8.14  IDE Taskfile i/o patch (Andre Hedrick)
+--------------------------------------------
 8.15  Multi-page writeout and readahead patches (Andrew Morton)
+---------------------------------------------------------------
 8.16  Direct i/o patches for 2.5 using kvec and bio (Badari Pulavarthy)
+-----------------------------------------------------------------------
 
-9. Other References:
+9. Other References
+===================
+
+9.1 The Splice I/O Model
+------------------------
+
+Larry McVoy (and subsequent discussions on lkml, and Linus' comments - Jan 2001
+
+9.2 Discussions about kiobuf and bh design
+------------------------------------------
+
+On lkml between sct, linus, alan et al - Feb-March 2001 (many of the
+initial thoughts that led to bio were brought up in this discussion thread)
 
-9.1 The Splice I/O Model - Larry McVoy (and subsequent discussions on lkml,
-and Linus' comments - Jan 2001)
-9.2 Discussions about kiobuf and bh design on lkml between sct, linus, alan
-et al - Feb-March 2001 (many of the initial thoughts that led to bio were
-brought up in this discussion thread)
 9.3 Discussions on mempool on lkml - Dec 2001.
-
+----------------------------------------------
diff --git a/Documentation/block/biovecs.txt b/Documentation/block/biovecs.rst
similarity index 92%
rename from Documentation/block/biovecs.txt
rename to Documentation/block/biovecs.rst
index ce6eccaf5df7..86fa66c87172 100644
--- a/Documentation/block/biovecs.txt
+++ b/Documentation/block/biovecs.rst
@@ -1,6 +1,6 @@
-
-Immutable biovecs and biovec iterators:
-=======================================
+======================================
+Immutable biovecs and biovec iterators
+======================================
 
 Kent Overstreet <kmo@daterainc.com>
 
@@ -121,10 +121,12 @@ Other implications:
 Usage of helpers:
 =================
 
-* The following helpers whose names have the suffix of "_all" can only be used
-on non-BIO_CLONED bio. They are usually used by filesystem code. Drivers
-shouldn't use them because the bio may have been split before it reached the
-driver.
+* The following helpers whose names have the suffix of `_all` can only be used
+  on non-BIO_CLONED bio. They are usually used by filesystem code. Drivers
+  shouldn't use them because the bio may have been split before it reached the
+  driver.
+
+::
 
 	bio_for_each_segment_all()
 	bio_first_bvec_all()
@@ -132,13 +134,13 @@ driver.
 	bio_last_bvec_all()
 
 * The following helpers iterate over single-page segment. The passed 'struct
-bio_vec' will contain a single-page IO vector during the iteration
+  bio_vec' will contain a single-page IO vector during the iteration::
 
 	bio_for_each_segment()
 	bio_for_each_segment_all()
 
 * The following helpers iterate over multi-page bvec. The passed 'struct
-bio_vec' will contain a multi-page IO vector during the iteration
+  bio_vec' will contain a multi-page IO vector during the iteration::
 
 	bio_for_each_bvec()
 	rq_for_each_bvec()
diff --git a/Documentation/block/capability.txt b/Documentation/block/capability.rst
similarity index 40%
rename from Documentation/block/capability.txt
rename to Documentation/block/capability.rst
index 2f1729424ef4..2cf258d64bbe 100644
--- a/Documentation/block/capability.txt
+++ b/Documentation/block/capability.rst
@@ -1,15 +1,18 @@
+===============================
 Generic Block Device Capability
-===============================================================================
+===============================
+
 This file documents the sysfs file block/<disk>/capability
 
 capability is a hex word indicating which capabilities a specific disk
 supports.  For more information on bits not listed here, see
 include/linux/genhd.h
 
-Capability				Value
--------------------------------------------------------------------------------
-GENHD_FL_MEDIA_CHANGE_NOTIFY		4
-	When this bit is set, the disk supports Asynchronous Notification
-	of media change events.  These events will be broadcast to user
-	space via kernel uevent.
+GENHD_FL_MEDIA_CHANGE_NOTIFY
+----------------------------
 
+Value: 4
+
+When this bit is set, the disk supports Asynchronous Notification
+of media change events.  These events will be broadcast to user
+space via kernel uevent.
diff --git a/Documentation/block/cmdline-partition.txt b/Documentation/block/cmdline-partition.rst
similarity index 92%
rename from Documentation/block/cmdline-partition.txt
rename to Documentation/block/cmdline-partition.rst
index 760a3f7c3ed4..530bedff548a 100644
--- a/Documentation/block/cmdline-partition.txt
+++ b/Documentation/block/cmdline-partition.rst
@@ -1,5 +1,6 @@
+==============================================
 Embedded device command line partition parsing
-=====================================================================
+==============================================
 
 The "blkdevparts" command line option adds support for reading the
 block device partition table from the kernel command line.
@@ -22,12 +23,15 @@ blkdevparts=<blkdev-def>[;<blkdev-def>]
 <size>
     partition size, in bytes, such as: 512, 1m, 1G.
     size may contain an optional suffix of (upper or lower case):
+
       K, M, G, T, P, E.
+
     "-" is used to denote all remaining space.
 
 <offset>
     partition start address, in bytes.
     offset may contain an optional suffix of (upper or lower case):
+
       K, M, G, T, P, E.
 
 (part-name)
@@ -36,11 +40,14 @@ blkdevparts=<blkdev-def>[;<blkdev-def>]
     User space application can access partition by partition name.
 
 Example:
+
     eMMC disk names are "mmcblk0" and "mmcblk0boot0".
 
-  bootargs:
+  bootargs::
+
     'blkdevparts=mmcblk0:1G(data0),1G(data1),-;mmcblk0boot0:1m(boot),-(kernel)'
 
-  dmesg:
+  dmesg::
+
     mmcblk0: p1(data0) p2(data1) p3()
     mmcblk0boot0: p1(boot) p2(kernel)
diff --git a/Documentation/block/data-integrity.txt b/Documentation/block/data-integrity.rst
similarity index 91%
rename from Documentation/block/data-integrity.txt
rename to Documentation/block/data-integrity.rst
index 934c44ea0c57..4f2452a95c43 100644
--- a/Documentation/block/data-integrity.txt
+++ b/Documentation/block/data-integrity.rst
@@ -1,5 +1,9 @@
-----------------------------------------------------------------------
-1. INTRODUCTION
+﻿==============
+Data Integrity
+==============
+
+1. Introduction
+===============
 
 Modern filesystems feature checksumming of data and metadata to
 protect against data corruption.  However, the detection of the
@@ -28,8 +32,8 @@ integrity of the I/O and reject it if corruption is detected.  This
 allows not only corruption prevention but also isolation of the point
 of failure.
 
-----------------------------------------------------------------------
-2. THE DATA INTEGRITY EXTENSIONS
+2. The Data Integrity Extensions
+================================
 
 As written, the protocol extensions only protect the path between
 controller and storage device.  However, many controllers actually
@@ -75,8 +79,8 @@ Extensions.  As these extensions are outside the scope of the protocol
 bodies (T10, T13), Oracle and its partners are trying to standardize
 them within the Storage Networking Industry Association.
 
-----------------------------------------------------------------------
-3. KERNEL CHANGES
+3. Kernel Changes
+=================
 
 The data integrity framework in Linux enables protection information
 to be pinned to I/Os and sent to/received from controllers that
@@ -123,10 +127,11 @@ access to manipulate the tags from user space.  A passthrough
 interface for this is being worked on.
 
 
-----------------------------------------------------------------------
-4. BLOCK LAYER IMPLEMENTATION DETAILS
+4. Block Layer Implementation Details
+=====================================
 
-4.1 BIO
+4.1 Bio
+-------
 
 The data integrity patches add a new field to struct bio when
 CONFIG_BLK_DEV_INTEGRITY is enabled.  bio_integrity(bio) returns a
@@ -145,7 +150,8 @@ attached using bio_integrity_add_page().
 bio_free() will automatically free the bip.
 
 
-4.2 BLOCK DEVICE
+4.2 Block Device
+----------------
 
 Because the format of the protection data is tied to the physical
 disk, each block device has been extended with a block integrity
@@ -163,10 +169,11 @@ and MD linear, RAID0 and RAID1 are currently supported.  RAID4/5/6
 will require extra work due to the application tag.
 
 
-----------------------------------------------------------------------
-5.0 BLOCK LAYER INTEGRITY API
+5.0 Block Layer Integrity API
+=============================
 
-5.1 NORMAL FILESYSTEM
+5.1 Normal Filesystem
+---------------------
 
     The normal filesystem is unaware that the underlying block device
     is capable of sending/receiving integrity metadata.  The IMD will
@@ -174,25 +181,26 @@ will require extra work due to the application tag.
     in case of a WRITE.  A READ request will cause the I/O integrity
     to be verified upon completion.
 
-    IMD generation and verification can be toggled using the
+    IMD generation and verification can be toggled using the::
 
       /sys/block/<bdev>/integrity/write_generate
 
-    and
+    and::
 
       /sys/block/<bdev>/integrity/read_verify
 
     flags.
 
 
-5.2 INTEGRITY-AWARE FILESYSTEM
+5.2 Integrity-Aware Filesystem
+------------------------------
 
     A filesystem that is integrity-aware can prepare I/Os with IMD
     attached.  It can also use the application tag space if this is
     supported by the block device.
 
 
-    bool bio_integrity_prep(bio);
+    `bool bio_integrity_prep(bio);`
 
       To generate IMD for WRITE and to set up buffers for READ, the
       filesystem must call bio_integrity_prep(bio).
@@ -204,14 +212,15 @@ will require extra work due to the application tag.
       Complete bio with error if prepare failed for some reson.
 
 
-5.3 PASSING EXISTING INTEGRITY METADATA
+5.3 Passing Existing Integrity Metadata
+---------------------------------------
 
     Filesystems that either generate their own integrity metadata or
     are capable of transferring IMD from user space can use the
     following calls:
 
 
-    struct bip * bio_integrity_alloc(bio, gfp_mask, nr_pages);
+    `struct bip * bio_integrity_alloc(bio, gfp_mask, nr_pages);`
 
       Allocates the bio integrity payload and hangs it off of the bio.
       nr_pages indicate how many pages of protection data need to be
@@ -220,7 +229,7 @@ will require extra work due to the application tag.
       The integrity payload will be freed at bio_free() time.
 
 
-    int bio_integrity_add_page(bio, page, len, offset);
+    `int bio_integrity_add_page(bio, page, len, offset);`
 
       Attaches a page containing integrity metadata to an existing
       bio.  The bio must have an existing bip,
@@ -241,21 +250,21 @@ will require extra work due to the application tag.
       integrity upon completion.
 
 
-5.4 REGISTERING A BLOCK DEVICE AS CAPABLE OF EXCHANGING INTEGRITY
-    METADATA
+5.4 Registering A Block Device As Capable Of Exchanging Integrity Metadata
+--------------------------------------------------------------------------
 
     To enable integrity exchange on a block device the gendisk must be
     registered as capable:
 
-    int blk_integrity_register(gendisk, blk_integrity);
+    `int blk_integrity_register(gendisk, blk_integrity);`
 
       The blk_integrity struct is a template and should contain the
-      following:
+      following::
 
         static struct blk_integrity my_profile = {
             .name                   = "STANDARDSBODY-TYPE-VARIANT-CSUM",
             .generate_fn            = my_generate_fn,
-       	    .verify_fn              = my_verify_fn,
+	    .verify_fn              = my_verify_fn,
 	    .tuple_size             = sizeof(struct my_tuple_size),
 	    .tag_size               = <tag bytes per hw sector>,
         };
@@ -278,4 +287,5 @@ will require extra work due to the application tag.
       0 depending on the value of the Control Mode Page ATO bit.
 
 ----------------------------------------------------------------------
+
 2007-12-24 Martin K. Petersen <martin.petersen@oracle.com>
diff --git a/Documentation/block/deadline-iosched.txt b/Documentation/block/deadline-iosched.rst
similarity index 89%
rename from Documentation/block/deadline-iosched.txt
rename to Documentation/block/deadline-iosched.rst
index 2d82c80322cb..9f5c5a4c370e 100644
--- a/Documentation/block/deadline-iosched.txt
+++ b/Documentation/block/deadline-iosched.rst
@@ -1,3 +1,4 @@
+==============================
 Deadline IO scheduler tunables
 ==============================
 
@@ -7,15 +8,13 @@ of interest to power users.
 
 Selecting IO schedulers
 -----------------------
-Refer to Documentation/block/switching-sched.txt for information on
+Refer to Documentation/block/switching-sched.rst for information on
 selecting an io scheduler on a per-device basis.
 
-
-********************************************************************************
-
+------------------------------------------------------------------------------
 
 read_expire	(in ms)
------------
+-----------------------
 
 The goal of the deadline io scheduler is to attempt to guarantee a start
 service time for a request. As we focus mainly on read latencies, this is
@@ -25,15 +24,15 @@ milliseconds.
 
 
 write_expire	(in ms)
------------
+-----------------------
 
 Similar to read_expire mentioned above, but for writes.
 
 
 fifo_batch	(number of requests)
-----------
+------------------------------------
 
-Requests are grouped into ``batches'' of a particular data direction (read or
+Requests are grouped into ``batches`` of a particular data direction (read or
 write) which are serviced in increasing sector order.  To limit extra seeking,
 deadline expiries are only checked between batches.  fifo_batch controls the
 maximum number of requests per batch.
@@ -45,7 +44,7 @@ generally improves throughput, at the cost of latency variation.
 
 
 writes_starved	(number of dispatches)
---------------
+--------------------------------------
 
 When we have to move requests from the io scheduler queue to the block
 device dispatch queue, we always give a preference to reads. However, we
@@ -56,7 +55,7 @@ same criteria as reads.
 
 
 front_merges	(bool)
-------------
+----------------------
 
 Sometimes it happens that a request enters the io scheduler that is contiguous
 with a request that is already on the queue. Either it fits in the back of that
@@ -71,5 +70,3 @@ rbtree front sector lookup when the io scheduler merge function is called.
 
 
 Nov 11 2002, Jens Axboe <jens.axboe@oracle.com>
-
-
diff --git a/Documentation/block/index.rst b/Documentation/block/index.rst
new file mode 100644
index 000000000000..8cd226a0e86e
--- /dev/null
+++ b/Documentation/block/index.rst
@@ -0,0 +1,25 @@
+:orphan:
+
+=====
+Block
+=====
+
+.. toctree::
+   :maxdepth: 1
+
+   bfq-iosched
+   biodoc
+   biovecs
+   capability
+   cmdline-partition
+   data-integrity
+   deadline-iosched
+   ioprio
+   kyber-iosched
+   null_blk
+   pr
+   queue-sysfs
+   request
+   stat
+   switching-sched
+   writeback_cache_control
diff --git a/Documentation/block/ioprio.txt b/Documentation/block/ioprio.rst
similarity index 75%
rename from Documentation/block/ioprio.txt
rename to Documentation/block/ioprio.rst
index 8ed8c59380b4..f72b0de65af7 100644
--- a/Documentation/block/ioprio.txt
+++ b/Documentation/block/ioprio.rst
@@ -1,3 +1,4 @@
+===================
 Block io priorities
 ===================
 
@@ -40,81 +41,81 @@ class data, since it doesn't really apply here.
 Tools
 -----
 
-See below for a sample ionice tool. Usage:
+See below for a sample ionice tool. Usage::
 
-# ionice -c<class> -n<level> -p<pid>
+	# ionice -c<class> -n<level> -p<pid>
 
 If pid isn't given, the current process is assumed. IO priority settings
 are inherited on fork, so you can use ionice to start the process at a given
-level:
+level::
 
-# ionice -c2 -n0 /bin/ls
+	# ionice -c2 -n0 /bin/ls
 
 will run ls at the best-effort scheduling class at the highest priority.
-For a running process, you can give the pid instead:
+For a running process, you can give the pid instead::
 
-# ionice -c1 -n2 -p100
+	# ionice -c1 -n2 -p100
 
 will change pid 100 to run at the realtime scheduling class, at priority 2.
 
----> snip ionice.c tool <---
+ionice.c tool::
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <getopt.h>
-#include <unistd.h>
-#include <sys/ptrace.h>
-#include <asm/unistd.h>
+  #include <stdio.h>
+  #include <stdlib.h>
+  #include <errno.h>
+  #include <getopt.h>
+  #include <unistd.h>
+  #include <sys/ptrace.h>
+  #include <asm/unistd.h>
 
-extern int sys_ioprio_set(int, int, int);
-extern int sys_ioprio_get(int, int);
+  extern int sys_ioprio_set(int, int, int);
+  extern int sys_ioprio_get(int, int);
 
-#if defined(__i386__)
-#define __NR_ioprio_set		289
-#define __NR_ioprio_get		290
-#elif defined(__ppc__)
-#define __NR_ioprio_set		273
-#define __NR_ioprio_get		274
-#elif defined(__x86_64__)
-#define __NR_ioprio_set		251
-#define __NR_ioprio_get		252
-#elif defined(__ia64__)
-#define __NR_ioprio_set		1274
-#define __NR_ioprio_get		1275
-#else
-#error "Unsupported arch"
-#endif
+  #if defined(__i386__)
+  #define __NR_ioprio_set		289
+  #define __NR_ioprio_get		290
+  #elif defined(__ppc__)
+  #define __NR_ioprio_set		273
+  #define __NR_ioprio_get		274
+  #elif defined(__x86_64__)
+  #define __NR_ioprio_set		251
+  #define __NR_ioprio_get		252
+  #elif defined(__ia64__)
+  #define __NR_ioprio_set		1274
+  #define __NR_ioprio_get		1275
+  #else
+  #error "Unsupported arch"
+  #endif
 
-static inline int ioprio_set(int which, int who, int ioprio)
-{
+  static inline int ioprio_set(int which, int who, int ioprio)
+  {
 	return syscall(__NR_ioprio_set, which, who, ioprio);
-}
+  }
 
-static inline int ioprio_get(int which, int who)
-{
+  static inline int ioprio_get(int which, int who)
+  {
 	return syscall(__NR_ioprio_get, which, who);
-}
+  }
 
-enum {
+  enum {
 	IOPRIO_CLASS_NONE,
 	IOPRIO_CLASS_RT,
 	IOPRIO_CLASS_BE,
 	IOPRIO_CLASS_IDLE,
-};
+  };
 
-enum {
+  enum {
 	IOPRIO_WHO_PROCESS = 1,
 	IOPRIO_WHO_PGRP,
 	IOPRIO_WHO_USER,
-};
+  };
 
-#define IOPRIO_CLASS_SHIFT	13
+  #define IOPRIO_CLASS_SHIFT	13
 
-const char *to_prio[] = { "none", "realtime", "best-effort", "idle", };
+  const char *to_prio[] = { "none", "realtime", "best-effort", "idle", };
 
-int main(int argc, char *argv[])
-{
+  int main(int argc, char *argv[])
+  {
 	int ioprio = 4, set = 0, ioprio_class = IOPRIO_CLASS_BE;
 	int c, pid = 0;
 
@@ -175,9 +176,7 @@ int main(int argc, char *argv[])
 	}
 
 	return 0;
-}
-
----> snip ionice.c tool <---
+  }
 
 
 March 11 2005, Jens Axboe <jens.axboe@oracle.com>
diff --git a/Documentation/block/kyber-iosched.txt b/Documentation/block/kyber-iosched.rst
similarity index 86%
rename from Documentation/block/kyber-iosched.txt
rename to Documentation/block/kyber-iosched.rst
index e94feacd7edc..3e164dd0617c 100644
--- a/Documentation/block/kyber-iosched.txt
+++ b/Documentation/block/kyber-iosched.rst
@@ -1,5 +1,6 @@
+============================
 Kyber I/O scheduler tunables
-===========================
+============================
 
 The only two tunables for the Kyber scheduler are the target latencies for
 reads and synchronous writes. Kyber will throttle requests in order to meet
diff --git a/Documentation/block/null_blk.txt b/Documentation/block/null_blk.rst
similarity index 60%
rename from Documentation/block/null_blk.txt
rename to Documentation/block/null_blk.rst
index 41f0a3d33bbd..31451d80783c 100644
--- a/Documentation/block/null_blk.txt
+++ b/Documentation/block/null_blk.rst
@@ -1,33 +1,43 @@
+========================
 Null block device driver
-================================================================================
+========================
 
-I. Overview
+1. Overview
+===========
 
 The null block device (/dev/nullb*) is used for benchmarking the various
 block-layer implementations. It emulates a block device of X gigabytes in size.
 The following instances are possible:
 
   Single-queue block-layer
+
     - Request-based.
     - Single submission queue per device.
     - Implements IO scheduling algorithms (CFQ, Deadline, noop).
+
   Multi-queue block-layer
+
     - Request-based.
     - Configurable submission queues per device.
+
   No block-layer (Known as bio-based)
+
     - Bio-based. IO requests are submitted directly to the device driver.
     - Directly accepts bio data structure and returns them.
 
 All of them have a completion queue for each core in the system.
 
-II. Module parameters applicable for all instances:
+2. Module parameters applicable for all instances
+=================================================
 
 queue_mode=[0-2]: Default: 2-Multi-queue
   Selects which block-layer the module should instantiate with.
 
-  0: Bio-based.
-  1: Single-queue.
-  2: Multi-queue.
+  =  ============
+  0  Bio-based
+  1  Single-queue
+  2  Multi-queue
+  =  ============
 
 home_node=[0--nr_nodes]: Default: NUMA_NO_NODE
   Selects what CPU node the data structures are allocated from.
@@ -45,12 +55,14 @@ nr_devices=[Number of devices]: Default: 1
 irqmode=[0-2]: Default: 1-Soft-irq
   The completion mode used for completing IOs to the block-layer.
 
-  0: None.
-  1: Soft-irq. Uses IPI to complete IOs across CPU nodes. Simulates the overhead
+  =  ===========================================================================
+  0  None.
+  1  Soft-irq. Uses IPI to complete IOs across CPU nodes. Simulates the overhead
      when IOs are issued from another CPU node than the home the device is
      connected to.
-  2: Timer: Waits a specific period (completion_nsec) for each IO before
+  2  Timer: Waits a specific period (completion_nsec) for each IO before
      completion.
+  =  ===========================================================================
 
 completion_nsec=[ns]: Default: 10,000ns
   Combined with irqmode=2 (timer). The time each completion event must wait.
@@ -66,30 +78,45 @@ hw_queue_depth=[0..qdepth]: Default: 64
 III: Multi-queue specific parameters
 
 use_per_node_hctx=[0/1]: Default: 0
-  0: The number of submit queues are set to the value of the submit_queues
+
+  =  =====================================================================
+  0  The number of submit queues are set to the value of the submit_queues
      parameter.
-  1: The multi-queue block layer is instantiated with a hardware dispatch
+  1  The multi-queue block layer is instantiated with a hardware dispatch
      queue for each CPU node in the system.
+  =  =====================================================================
 
 no_sched=[0/1]: Default: 0
-  0: nullb* use default blk-mq io scheduler.
-  1: nullb* doesn't use io scheduler.
+
+  =  ======================================
+  0  nullb* use default blk-mq io scheduler
+  1  nullb* doesn't use io scheduler
+  =  ======================================
 
 blocking=[0/1]: Default: 0
-  0: Register as a non-blocking blk-mq driver device.
-  1: Register as a blocking blk-mq driver device, null_blk will set
+
+  =  ===============================================================
+  0  Register as a non-blocking blk-mq driver device.
+  1  Register as a blocking blk-mq driver device, null_blk will set
      the BLK_MQ_F_BLOCKING flag, indicating that it sometimes/always
      needs to block in its ->queue_rq() function.
+  =  ===============================================================
 
 shared_tags=[0/1]: Default: 0
-  0: Tag set is not shared.
-  1: Tag set shared between devices for blk-mq. Only makes sense with
+
+  =  ================================================================
+  0  Tag set is not shared.
+  1  Tag set shared between devices for blk-mq. Only makes sense with
      nr_devices > 1, otherwise there's no tag set to share.
+  =  ================================================================
 
 zoned=[0/1]: Default: 0
-  0: Block device is exposed as a random-access block device.
-  1: Block device is exposed as a host-managed zoned block device. Requires
+
+  =  ======================================================================
+  0  Block device is exposed as a random-access block device.
+  1  Block device is exposed as a host-managed zoned block device. Requires
      CONFIG_BLK_DEV_ZONED.
+  =  ======================================================================
 
 zone_size=[MB]: Default: 256
   Per zone size when exposed as a zoned block device. Must be a power of two.
diff --git a/Documentation/block/pr.txt b/Documentation/block/pr.rst
similarity index 93%
rename from Documentation/block/pr.txt
rename to Documentation/block/pr.rst
index ac9b8e70e64b..30ea1c2e39eb 100644
--- a/Documentation/block/pr.txt
+++ b/Documentation/block/pr.rst
@@ -1,4 +1,4 @@
-
+===============================================
 Block layer support for Persistent Reservations
 ===============================================
 
@@ -23,22 +23,18 @@ The following types of reservations are supported:
 --------------------------------------------------
 
  - PR_WRITE_EXCLUSIVE
-
 	Only the initiator that owns the reservation can write to the
 	device.  Any initiator can read from the device.
 
  - PR_EXCLUSIVE_ACCESS
-
 	Only the initiator that owns the reservation can access the
 	device.
 
  - PR_WRITE_EXCLUSIVE_REG_ONLY
-
 	Only initiators with a registered key can write to the device,
 	Any initiator can read from the device.
 
  - PR_EXCLUSIVE_ACCESS_REG_ONLY
-
 	Only initiators with a registered key can access the device.
 
  - PR_WRITE_EXCLUSIVE_ALL_REGS
@@ -48,21 +44,21 @@ The following types of reservations are supported:
 	All initiators with a registered key are considered reservation
 	holders.
 	Please reference the SPC spec on the meaning of a reservation
-	holder if you want to use this type. 
+	holder if you want to use this type.
 
  - PR_EXCLUSIVE_ACCESS_ALL_REGS
-
 	Only initiators with a registered key can access the device.
 	All initiators with a registered key are considered reservation
 	holders.
 	Please reference the SPC spec on the meaning of a reservation
-	holder if you want to use this type. 
+	holder if you want to use this type.
 
 
 The following ioctl are supported:
 ----------------------------------
 
 1. IOC_PR_REGISTER
+^^^^^^^^^^^^^^^^^^
 
 This ioctl command registers a new reservation if the new_key argument
 is non-null.  If no existing reservation exists old_key must be zero,
@@ -74,6 +70,7 @@ in old_key.
 
 
 2. IOC_PR_RESERVE
+^^^^^^^^^^^^^^^^^
 
 This ioctl command reserves the device and thus restricts access for other
 devices based on the type argument.  The key argument must be the existing
@@ -82,12 +79,14 @@ IOC_PR_REGISTER_IGNORE, IOC_PR_PREEMPT or IOC_PR_PREEMPT_ABORT commands.
 
 
 3. IOC_PR_RELEASE
+^^^^^^^^^^^^^^^^^
 
 This ioctl command releases the reservation specified by key and flags
 and thus removes any access restriction implied by it.
 
 
 4. IOC_PR_PREEMPT
+^^^^^^^^^^^^^^^^^
 
 This ioctl command releases the existing reservation referred to by
 old_key and replaces it with a new reservation of type for the
@@ -95,11 +94,13 @@ reservation key new_key.
 
 
 5. IOC_PR_PREEMPT_ABORT
+^^^^^^^^^^^^^^^^^^^^^^^
 
 This ioctl command works like IOC_PR_PREEMPT except that it also aborts
 any outstanding command sent over a connection identified by old_key.
 
 6. IOC_PR_CLEAR
+^^^^^^^^^^^^^^^
 
 This ioctl command unregisters both key and any other reservation key
 registered with the device and drops any existing reservation.
@@ -111,7 +112,6 @@ Flags
 All the ioctls have a flag field.  Currently only one flag is supported:
 
  - PR_FL_IGNORE_KEY
-
 	Ignore the existing reservation key.  This is commonly supported for
 	IOC_PR_REGISTER, and some implementation may support the flag for
 	IOC_PR_RESERVE.
diff --git a/Documentation/block/queue-sysfs.txt b/Documentation/block/queue-sysfs.rst
similarity index 99%
rename from Documentation/block/queue-sysfs.txt
rename to Documentation/block/queue-sysfs.rst
index 83b457e24bba..9022249208b5 100644
--- a/Documentation/block/queue-sysfs.txt
+++ b/Documentation/block/queue-sysfs.rst
@@ -1,3 +1,4 @@
+=================
 Queue sysfs files
 =================
 
@@ -10,7 +11,7 @@ Files denoted with a RO postfix are readonly and the RW postfix means
 read-write.
 
 add_random (RW)
-----------------
+---------------
 This file allows to turn off the disk entropy contribution. Default
 value of this file is '1'(on).
 
@@ -21,13 +22,13 @@ used by CPU-addressable storage to bypass the pagecache.  It shows '1'
 if true, '0' if not.
 
 discard_granularity (RO)
------------------------
+------------------------
 This shows the size of internal allocation of the device in bytes, if
 reported by the device. A value of '0' means device does not support
 the discard functionality.
 
 discard_max_hw_bytes (RO)
-----------------------
+-------------------------
 Devices that support discard functionality may have internal limits on
 the number of bytes that can be trimmed or unmapped in a single operation.
 The discard_max_bytes parameter is set by the device driver to the maximum
diff --git a/Documentation/block/request.txt b/Documentation/block/request.rst
similarity index 59%
rename from Documentation/block/request.txt
rename to Documentation/block/request.rst
index 754e104ed369..747021e1ffdb 100644
--- a/Documentation/block/request.txt
+++ b/Documentation/block/request.rst
@@ -1,26 +1,37 @@
-
+============================
 struct request documentation
+============================
 
 Jens Axboe <jens.axboe@oracle.com> 27/05/02
 
-1.0
-Index
 
-2.0 Struct request members classification
+.. FIXME:
+   No idea about what does mean - seems just some noise, so comment it
 
-	2.1 struct request members explanation
+   1.0
+   Index
+
+   2.0 Struct request members classification
+
+       2.1 struct request members explanation
+
+   3.0
+
+
+   2.0
 
-3.0
 
 
-2.0
 Short explanation of request members
+====================================
 
 Classification flags:
 
+	=	====================
 	D	driver member
 	B	block layer member
 	I	I/O scheduler member
+	=	====================
 
 Unless an entry contains a D classification, a device driver must not access
 this member. Some members may contain D classifications, but should only be
@@ -28,14 +39,13 @@ access through certain macros or functions (eg ->flags).
 
 <linux/blkdev.h>
 
-2.1
+=============================== ======= =======================================
 Member				Flag	Comment
-------				----	-------
-
+=============================== ======= =======================================
 struct list_head queuelist	BI	Organization on various internal
 					queues
 
-void *elevator_private		I	I/O scheduler private data
+``void *elevator_private``	I	I/O scheduler private data
 
 unsigned char cmd[16]		D	Driver can use this for setting up
 					a cdb before execution, see
@@ -71,18 +81,19 @@ unsigned int hard_cur_sectors	B	Used to keep current_nr_sectors sane
 
 int tag				DB	TCQ tag, if assigned
 
-void *special			D	Free to be used by driver
+``void *special``		D	Free to be used by driver
 
-char *buffer			D	Map of first segment, also see
+``char *buffer``		D	Map of first segment, also see
 					section on bouncing SECTION
 
-struct completion *waiting	D	Can be used by driver to get signalled
+``struct completion *waiting``	D	Can be used by driver to get signalled
 					on request completion
 
-struct bio *bio			DBI	First bio in request
+``struct bio *bio``		DBI	First bio in request
 
-struct bio *biotail		DBI	Last bio in request
+``struct bio *biotail``		DBI	Last bio in request
 
-struct request_queue *q		DB	Request queue this request belongs to
+``struct request_queue *q``	DB	Request queue this request belongs to
 
-struct request_list *rl		B	Request list this request came from
+``struct request_list *rl``	B	Request list this request came from
+=============================== ======= =======================================
diff --git a/Documentation/block/stat.txt b/Documentation/block/stat.rst
similarity index 89%
rename from Documentation/block/stat.txt
rename to Documentation/block/stat.rst
index 0aace9cc536c..9c07bc22b0bc 100644
--- a/Documentation/block/stat.txt
+++ b/Documentation/block/stat.rst
@@ -1,3 +1,4 @@
+===============================================
 Block layer statistics in /sys/block/<dev>/stat
 ===============================================
 
@@ -6,9 +7,12 @@ This file documents the contents of the /sys/block/<dev>/stat file.
 The stat file provides several statistics about the state of block
 device <dev>.
 
-Q. Why are there multiple statistics in a single file?  Doesn't sysfs
+Q.
+   Why are there multiple statistics in a single file?  Doesn't sysfs
    normally contain a single value per file?
-A. By having a single file, the kernel can guarantee that the statistics
+
+A.
+   By having a single file, the kernel can guarantee that the statistics
    represent a consistent snapshot of the state of the device.  If the
    statistics were exported as multiple files containing one statistic
    each, it would be impossible to guarantee that a set of readings
@@ -18,8 +22,10 @@ The stat file consists of a single line of text containing 11 decimal
 values separated by whitespace.  The fields are summarized in the
 following table, and described in more detail below.
 
+
+=============== ============= =================================================
 Name            units         description
-----            -----         -----------
+=============== ============= =================================================
 read I/Os       requests      number of read I/Os processed
 read merges     requests      number of read I/Os merged with in-queue I/O
 read sectors    sectors       number of sectors read
@@ -35,6 +41,7 @@ discard I/Os    requests      number of discard I/Os processed
 discard merges  requests      number of discard I/Os merged with in-queue I/O
 discard sectors sectors       number of sectors discarded
 discard ticks   milliseconds  total wait time for discard requests
+=============== ============= =================================================
 
 read I/Os, write I/Os, discard I/0s
 ===================================
diff --git a/Documentation/block/switching-sched.txt b/Documentation/block/switching-sched.rst
similarity index 67%
rename from Documentation/block/switching-sched.txt
rename to Documentation/block/switching-sched.rst
index 7977f6fb8b20..42042417380e 100644
--- a/Documentation/block/switching-sched.txt
+++ b/Documentation/block/switching-sched.rst
@@ -1,35 +1,39 @@
+===================
+Switching Scheduler
+===================
+
 To choose IO schedulers at boot time, use the argument 'elevator=deadline'.
 'noop' and 'cfq' (the default) are also available. IO schedulers are assigned
 globally at boot time only presently.
 
 Each io queue has a set of io scheduler tunables associated with it. These
 tunables control how the io scheduler works. You can find these entries
-in:
+in::
 
-/sys/block/<device>/queue/iosched
+	/sys/block/<device>/queue/iosched
 
 assuming that you have sysfs mounted on /sys. If you don't have sysfs mounted,
-you can do so by typing:
+you can do so by typing::
 
-# mount none /sys -t sysfs
+	# mount none /sys -t sysfs
 
 It is possible to change the IO scheduler for a given block device on
 the fly to select one of mq-deadline, none, bfq, or kyber schedulers -
 which can improve that device's throughput.
 
-To set a specific scheduler, simply do this:
+To set a specific scheduler, simply do this::
 
-echo SCHEDNAME > /sys/block/DEV/queue/scheduler
+	echo SCHEDNAME > /sys/block/DEV/queue/scheduler
 
 where SCHEDNAME is the name of a defined IO scheduler, and DEV is the
 device name (hda, hdb, sga, or whatever you happen to have).
 
 The list of defined schedulers can be found by simply doing
 a "cat /sys/block/DEV/queue/scheduler" - the list of valid names
-will be displayed, with the currently selected scheduler in brackets:
+will be displayed, with the currently selected scheduler in brackets::
 
-# cat /sys/block/sda/queue/scheduler
-[mq-deadline] kyber bfq none
-# echo none >/sys/block/sda/queue/scheduler
-# cat /sys/block/sda/queue/scheduler
-[none] mq-deadline kyber bfq
+  # cat /sys/block/sda/queue/scheduler
+  [mq-deadline] kyber bfq none
+  # echo none >/sys/block/sda/queue/scheduler
+  # cat /sys/block/sda/queue/scheduler
+  [none] mq-deadline kyber bfq
diff --git a/Documentation/block/writeback_cache_control.txt b/Documentation/block/writeback_cache_control.rst
similarity index 94%
rename from Documentation/block/writeback_cache_control.txt
rename to Documentation/block/writeback_cache_control.rst
index 8a6bdada5f6b..2c752c57c14c 100644
--- a/Documentation/block/writeback_cache_control.txt
+++ b/Documentation/block/writeback_cache_control.rst
@@ -1,6 +1,6 @@
-
+==========================================
 Explicit volatile write back cache control
-=====================================
+==========================================
 
 Introduction
 ------------
@@ -31,7 +31,7 @@ the blkdev_issue_flush() helper for a pure cache flush.
 
 
 Forced Unit Access
------------------
+------------------
 
 The REQ_FUA flag can be OR ed into the r/w flags of a bio submitted from the
 filesystem and will make sure that I/O completion for this request is only
@@ -62,14 +62,14 @@ flags themselves without any help from the block layer.
 
 
 Implementation details for request_fn based block drivers
---------------------------------------------------------------
+---------------------------------------------------------
 
 For devices that do not support volatile write caches there is no driver
 support required, the block layer completes empty REQ_PREFLUSH requests before
 entering the driver and strips off the REQ_PREFLUSH and REQ_FUA bits from
 requests that have a payload.  For devices with volatile write caches the
 driver needs to tell the block layer that it supports flushing caches by
-doing:
+doing::
 
 	blk_queue_write_cache(sdkp->disk->queue, true, false);
 
@@ -77,7 +77,7 @@ and handle empty REQ_OP_FLUSH requests in its prep_fn/request_fn.  Note that
 REQ_PREFLUSH requests with a payload are automatically turned into a sequence
 of an empty REQ_OP_FLUSH request followed by the actual write by the block
 layer.  For devices that also support the FUA bit the block layer needs
-to be told to pass through the REQ_FUA bit using:
+to be told to pass through the REQ_FUA bit using::
 
 	blk_queue_write_cache(sdkp->disk->queue, true, true);
 
diff --git a/Documentation/blockdev/zram.rst b/Documentation/blockdev/zram.rst
index 2111231c9c0f..6eccf13219ff 100644
--- a/Documentation/blockdev/zram.rst
+++ b/Documentation/blockdev/zram.rst
@@ -215,7 +215,7 @@ User space is advised to use the following files to read the device statistics.
 
 File /sys/block/zram<id>/stat
 
-Represents block layer statistics. Read Documentation/block/stat.txt for
+Represents block layer statistics. Read Documentation/block/stat.rst for
 details.
 
 File /sys/block/zram<id>/io_stat
diff --git a/MAINTAINERS b/MAINTAINERS
index 2f8e1543caff..d850d7f15a38 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2930,7 +2930,7 @@ M:	Jens Axboe <axboe@kernel.dk>
 L:	linux-block@vger.kernel.org
 S:	Maintained
 F:	block/bfq-*
-F:	Documentation/block/bfq-iosched.txt
+F:	Documentation/block/bfq-iosched.rst
 
 BFS FILE SYSTEM
 M:	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>
diff --git a/block/Kconfig b/block/Kconfig
index 56cb1695cd87..b16b3e075d31 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -110,7 +110,7 @@ config BLK_CMDLINE_PARSER
 	which don't otherwise have any standardized method for listing the
 	partitions on a block device.
 
-	See Documentation/block/cmdline-partition.txt for more information.
+	See Documentation/block/cmdline-partition.rst for more information.
 
 config BLK_WBT
 	bool "Enable support for block device writeback throttling"
diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 4626b88b2d5a..eabd4328b228 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -26,7 +26,7 @@ config IOSCHED_BFQ
 	regardless of the device parameters and with any workload. It
 	also guarantees a low latency to interactive and soft
 	real-time applications.  Details in
-	Documentation/block/bfq-iosched.txt
+	Documentation/block/bfq-iosched.rst
 
 config BFQ_GROUP_IOSCHED
        bool "BFQ hierarchical scheduling support"
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index f8d430f88d25..37996013a301 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -17,7 +17,7 @@
  * low-latency capabilities. BFQ also supports full hierarchical
  * scheduling through cgroups. Next paragraphs provide an introduction
  * on BFQ inner workings. Details on BFQ benefits, usage and
- * limitations can be found in Documentation/block/bfq-iosched.txt.
+ * limitations can be found in Documentation/block/bfq-iosched.rst.
  *
  * BFQ is a proportional-share storage-I/O scheduling algorithm based
  * on the slice-by-slice service scheme of CFQ. But BFQ assigns
diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 825c9c070458..ca39b4624cf8 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -383,7 +383,7 @@ static const struct blk_integrity_profile nop_profile = {
  * send/receive integrity metadata it must use this function to register
  * the capability with the block layer. The template is a blk_integrity
  * struct with values appropriate for the underlying hardware. See
- * Documentation/block/data-integrity.txt.
+ * Documentation/block/data-integrity.rst.
  */
 void blk_integrity_register(struct gendisk *disk, struct blk_integrity *template)
 {
diff --git a/block/ioprio.c b/block/ioprio.c
index 2e0559f157c8..77bcab11dce5 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -17,7 +17,7 @@
  *
  * ioprio_set(PRIO_PROCESS, pid, prio);
  *
- * See also Documentation/block/ioprio.txt
+ * See also Documentation/block/ioprio.rst
  *
  */
 #include <linux/gfp.h>
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 1876f5712bfd..4fa0ae242880 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -25,7 +25,7 @@
 #include "blk-mq-sched.h"
 
 /*
- * See Documentation/block/deadline-iosched.txt
+ * See Documentation/block/deadline-iosched.rst
  */
 static const int read_expire = HZ / 2;  /* max time before a read is submitted. */
 static const int write_expire = 5 * HZ; /* ditto for writes, these limits are SOFT! */
diff --git a/block/partitions/cmdline.c b/block/partitions/cmdline.c
index 60fb3df9897c..f1edd5452249 100644
--- a/block/partitions/cmdline.c
+++ b/block/partitions/cmdline.c
@@ -11,7 +11,7 @@
  *
  * The format for the command line is just like mtdparts.
  *
- * For further information, see "Documentation/block/cmdline-partition.txt"
+ * For further information, see "Documentation/block/cmdline-partition.rst"
  *
  */
 
-- 
2.21.0

