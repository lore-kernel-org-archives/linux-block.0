Return-Path: <b.zolnierkie@samsung.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] block: remove redundant 'default n' from Kconfig-s
Date: Tue, 9 Oct 2018 16:32:54 +0200
MIME-Version: 1.0
Message-Id: <20181009143255eucas1p2fa83e06a951634e4359b4492d54ec7cb~b90V1TQEm3273032730eucas1p2h@eucas1p2.samsung.com>
Content-Type: text/plain; charset="utf-8"
References: <CGME20181009143255eucas1p2fa83e06a951634e4359b4492d54ec7cb@eucas1p2.samsung.com>
List-ID: <linux-block@vger.kernel.org>

'default n' is the default value for any bool or tristate Kconfig
setting so there is no need to write it explicitly.

Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
is not set' for visible symbols") the Kconfig behavior is the same
regardless of 'default n' being present or not:

    ...
    One side effect of (and the main motivation for) this change is making
    the following two definitions behave exactly the same:
    
        config FOO
                bool
    
        config FOO
                bool
                default n
    
    With this change, neither of these will generate a
    '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
    That might make it clearer to people that a bare 'default n' is
    redundant.
    ...

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 block/Kconfig         |    7 -------
 block/Kconfig.iosched |    3 ---
 2 files changed, 10 deletions(-)

Index: b/block/Kconfig
===================================================================
--- a/block/Kconfig	2018-10-09 15:58:37.031122890 +0200
+++ b/block/Kconfig	2018-10-09 16:30:22.959170887 +0200
@@ -74,7 +74,6 @@ config BLK_DEV_BSG
 
 config BLK_DEV_BSGLIB
 	bool "Block layer SG support v4 helper lib"
-	default n
 	select BLK_DEV_BSG
 	select BLK_SCSI_REQUEST
 	help
@@ -107,7 +106,6 @@ config BLK_DEV_ZONED
 config BLK_DEV_THROTTLING
 	bool "Block layer bio throttling support"
 	depends on BLK_CGROUP=y
-	default n
 	---help---
 	Block layer bio throttling support. It can be used to limit
 	the IO rate to a device. IO rate policies are per cgroup and
@@ -119,7 +117,6 @@ config BLK_DEV_THROTTLING
 config BLK_DEV_THROTTLING_LOW
 	bool "Block throttling .low limit interface support (EXPERIMENTAL)"
 	depends on BLK_DEV_THROTTLING
-	default n
 	---help---
 	Add .low limit interface for block throttling. The low limit is a best
 	effort limit to prioritize cgroups. Depending on the setting, the limit
@@ -130,7 +127,6 @@ config BLK_DEV_THROTTLING_LOW
 
 config BLK_CMDLINE_PARSER
 	bool "Block device command line partition parser"
-	default n
 	---help---
 	Enabling this option allows you to specify the partition layout from
 	the kernel boot args.  This is typically of use for embedded devices
@@ -141,7 +137,6 @@ config BLK_CMDLINE_PARSER
 
 config BLK_WBT
 	bool "Enable support for block device writeback throttling"
-	default n
 	---help---
 	Enabling this option enables the block layer to throttle buffered
 	background writeback from the VM, making it more smooth and having
@@ -152,7 +147,6 @@ config BLK_WBT
 config BLK_CGROUP_IOLATENCY
 	bool "Enable support for latency based cgroup IO protection"
 	depends on BLK_CGROUP=y
-	default n
 	---help---
 	Enabling this option enables the .latency interface for IO throttling.
 	The IO controller will attempt to maintain average IO latencies below
@@ -163,7 +157,6 @@ config BLK_CGROUP_IOLATENCY
 
 config BLK_WBT_SQ
 	bool "Single queue writeback throttling"
-	default n
 	depends on BLK_WBT
 	---help---
 	Enable writeback throttling by default on legacy single queue devices
Index: b/block/Kconfig.iosched
===================================================================
--- a/block/Kconfig.iosched	2018-09-03 18:11:21.201792278 +0200
+++ b/block/Kconfig.iosched	2018-10-09 16:30:54.207171674 +0200
@@ -36,7 +36,6 @@ config IOSCHED_CFQ
 config CFQ_GROUP_IOSCHED
 	bool "CFQ Group Scheduling support"
 	depends on IOSCHED_CFQ && BLK_CGROUP
-	default n
 	---help---
 	  Enable group IO scheduling in CFQ.
 
@@ -82,7 +81,6 @@ config MQ_IOSCHED_KYBER
 
 config IOSCHED_BFQ
 	tristate "BFQ I/O scheduler"
-	default n
 	---help---
 	BFQ I/O scheduler for BLK-MQ. BFQ distributes the bandwidth of
 	of the device among all processes according to their weights,
@@ -94,7 +92,6 @@ config IOSCHED_BFQ
 config BFQ_GROUP_IOSCHED
        bool "BFQ hierarchical scheduling support"
        depends on IOSCHED_BFQ && BLK_CGROUP
-       default n
        ---help---
 
        Enable hierarchical scheduling in BFQ, using the blkio
