Return-Path: <SRS0=KrPA=UR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933CBC31E51
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 07:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F34420665
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 07:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f6mZM0Ew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfFRHEK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:04:10 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:7915 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFRHEK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jun 2019 03:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560841450; x=1592377450;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DYP0IhPlDbDvmFFl2HcXvA2JQRtUY8p81IhbJHsjHZ8=;
  b=f6mZM0EwxPK8q+j0m6CoyzIKHC0kK/9HZyqGryouS0VcC0p2TZ8q1xIJ
   FZ+zZJl3K1BkDDc5pGKMAA9u7dGfsnIlPNbvfKc9gS0k9e/TF+hGF3ii6
   7RM9xxaTEn7SCHlA7jJJzX1nPQSm8k6Jm0tvF8/Mvz1EH9MRVA+rbKHp4
   n0U37uFEcNW7P5FLpFLL8dUlN120aJVN9gHvbJQ68RIxfdGd+UqTfUwPJ
   pDvZTbrXGR8+ZIMN33/ppfPLd1QJvLvhDcSAvkzq/bf4FdJ4RSrnmPv6u
   zBky5esCMsU9ZX704krrIRsY2JIBJz9YQb0OcDIOpICXRiTVrXIi28Msr
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,388,1557158400"; 
   d="scan'208";a="115733424"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 13:42:26 +0800
IronPort-SDR: b5ukUqnvwJzIMUBtTTWdc+vETM7oOqJe18PDNB54i3NMGS1R9t526QCglSGmmZa36AdWgg5FnB
 nEnqJpJhqj1Oh6SNpSOSEQ5UQ6/jjJ8awz8CvsbqF6HalMPJ+mVevCUroRu7eOUDjFB5W8cRCm
 Y6ELfcxBUSqaZaVq5NbzQ97Z1a5PkthLmh8hUm/hiRPB2qtvMOqZEOBVG+NX4ZyC59D6J7JAjq
 sABiZ4oslQNAG1icoAAuAZ0Nz4rcACtgSGckn15w0yecjhO1gOaMHCEK2GXL0xfU+8rm79qjJ2
 MGS4novQbRaxx1uG8DjBprxz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 17 Jun 2019 22:41:55 -0700
IronPort-SDR: FMtDrzWn/22TzFOcwOnVHgX1vPkKpEWF9yrxBtYDoIN7QNrs7FqrwgHTFsB5WQFhgQJdRzt1KO
 8FcrI07kEb8/vJUR4OdGtBeMDXzSt5Xv//ly4YaEqx+f/XcmHci8I8lZV7RZMAbwFeb5b990+h
 jmCAklwbH8xHAtZd43IBsxCDOfT4M35vbd80YGOSr78yhSZoocwUTB4koqz4TnK5hV9OMWkWzB
 TyvLJvmm0g6H43ycrS63dyOapzzs0xTp9ZEwdyzCmd5xNXeTfYBsyvsLte4mdKzsyCWWLDhMRU
 LTk=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Jun 2019 22:42:25 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     jaegeuk@kernel.org, yuchao0@huawei.com, bvanassche@acm.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 0/6] block: improve print_req_error
Date:   Mon, 17 Jun 2019 22:42:18 -0700
Message-Id: <20190618054224.25985-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This patch-series is based on the initial patch posted by
Christoph Hellwig <hch@lst.de>. While debugging the driver and block
layer this print message is very meaningful. Also, we centralize the
REQ_OP_XXX to the string conversion in the blk-core.c so that other
dependent subsystems can use this helper without having to duplicate
the code e.g. f2fs, blk-mq-debugfs.c.

Please consider this for 5.3.

In case someone is interested please find the test log for print_err_req
with null_blk, f2fs tracing and blk-mq-debugfs->blk_mq_debugfs_rq_show()
at the end of this patch.

Regards,
Chaitanya

Changes since V2:-

1. Add a centralized definition of the REQ_OP_XXX string array in the
   blk-core so that it will be available to other dependent subsystems
   as well.
2. Adjust the code and use blk_op_str() in the blk-mq-debugfs.c
3. Adjust the code and use blk_op_str() in the f2fs tracing.

Chaitanya Kulkarni (5):
  block: add centralize REQ_OP_XXX to string helper
  block: use blk_op_str() in blk-mq-debugfs.c
  block: update print_req_error()
  f2fs: use block layer helper for REQ_OP_XXX
  f2fs: get rid of duplicate code for in tracing

Christoph Hellwig (1):
  block: improve print_req_error

 block/blk-core.c            | 55 ++++++++++++++++++++++++++++++++-----
 block/blk-mq-debugfs.c      | 24 +++-------------
 include/linux/blkdev.h      |  3 ++
 include/trace/events/f2fs.h | 20 +++-----------
 4 files changed, 59 insertions(+), 43 deletions(-)


A. Following is the sample error message with forced REQ_OP_WRITE,
   REQ_OP_WRITE_ZEROES and REQ_OP_DISCARD failure from modified
   null_blk for testing :-
------------------------------------------------------------------

[  489.013530] blk_update_request: I/O error, dev nullb0, sector 0 op 0x1:(WRITE) flags 0x8800 phys_seg 1 prio class 0
[  510.569833] blk_update_request: I/O error, dev nullb0, sector 0 op 0x9:(WRITE_ZEROES) flags 0x400800 phys_seg 0 prio class 0
[  557.009194] blk_update_request: I/O error, dev nullb0, sector 0 op 0x3:(DISCARD) flags 0x800 phys_seg 1 prio class 0

B. F2FS Tracing with this patch-series :-
-----------------------------------------
# 1. Format and mount device with f2fs :-
linux-block (for-next) # mkfs.f2fs -f  /dev/nvme0n1

	F2FS-tools: mkfs.f2fs Ver: 1.12.0 (2018-11-12)
        <snip>
	Info: format successful
linux-block (for-next) # mount /dev/nvme0n1 /mnt/nvme0n1

# 2.  Enable f2fs traces which are associated with the bio:-
linux-block (for-next) # cat /sys/kernel/debug/tracing/events/f2fs/f2fs_prepare_read_bio/enable
1
linux-block (for-next) # cat /sys/kernel/debug/tracing/events/f2fs/f2fs_prepare_write_bio/enable
1
linux-block (for-next) # cat /sys/kernel/debug/tracing/events/f2fs/f2fs_submit_page_bio/enable
1
linux-block (for-next) # cat /sys/kernel/debug/tracing/events/f2fs/f2fs_submit_read_bio/enable
1
linux-block (for-next) # cat /sys/kernel/debug/tracing/events/f2fs/f2fs_submit_write_bio/enable
1
# 3.  Issue I/O using dd(1) :-
linux-block (for-next) # dd of=/mnt/nvme0n1/data if=/dev/zero bs=4k count=100
100+0 records in
100+0 records out
409600 bytes (410 kB) copied, 0.00315802 s, 130 MB/s
linux-block (for-next) #
linux-block (for-next) #
# 4, Collect the trace
linux-block (for-next) # cat /sys/kernel/debug/tracing/trace_pipe
# 5. Following is the trimmed trace where we get rid of first few columns :-
f2fs_trace_pid: 103:  0 1af2 dd
f2fs_trace_ios: 103:  0    0 ----------------  3     0  2000         1600    1
f2fs_trace_pid: 103:  0  1e8 kworker/u24:5
f2fs_prepare_write_bio: dev = (259,0)/(259,0), rw = WRITE(S), DATA, sector = 53256, size = 4096
f2fs_submit_write_bio: dev = (259,0)/(259,0), rw = WRITE(S), DATA, sector = 53256, size = 4096
f2fs_trace_ios: 103:  0 1ace ----------------  1     1   800         1a01    1
f2fs_trace_ios: 103:  0  1e8 ----------------  2     1   800         1401    1
f2fs_prepare_write_bio: dev = (259,0)/(259,0), rw = WRITE(S), NODE, sector = 40968, size = 4096
f2fs_submit_write_bio: dev = (259,0)/(259,0), rw = WRITE(S), NODE, sector = 40968, size = 4096
f2fs_prepare_write_bio: dev = (259,0)/(259,0), rw = WRITE(S), NODE, sector = 45056, size = 4096
f2fs_submit_write_bio: dev = (259,0)/(259,0), rw = WRITE(S), NODE, sector = 45056, size = 4096
f2fs_trace_ios: 103:  0 1ace ----------------  2     1   800         1600    1
f2fs_prepare_write_bio: dev = (259,0)/(259,0), rw = WRITE(S|M|P), META, sector = 8192, size = 8192
f2fs_submit_write_bio: dev = (259,0)/(259,0), rw = WRITE(S|M|P), META, sector = 8192, size = 8192
f2fs_prepare_write_bio: dev = (259,0)/(259,0), rw = WRITE(S|M|P|PF|FUA), META_FLUSH, sector = 8208, size = 4096
f2fs_submit_write_bio: dev = (259,0)/(259,0), rw = WRITE(S|M|P|PF|FUA), META_FLUSH, sector = 8208, size = 4096
f2fs_trace_ios: 103:  0  1e8 ----------------  3     1  3800          400    3
f2fs_prepare_write_bio: dev = (259,0)/(259,0), rw = WRITE(), DATA, sector = 53264, size = 40960
f2fs_submit_write_bio: dev = (259,0)/(259,0), rw = WRITE(), DATA, sector = 53264, size = 40960
f2fs_trace_pid: 103:  0 1b16 dd
f2fs_trace_ios: 103:  0 1af2 ----------------  0     1 100000         1a02    a
f2fs_prepare_write_bio: dev = (259,0)/(259,0), rw = WRITE(), DATA, sector = 1064960, size = 409600
f2fs_submit_write_bio: dev = (259,0)/(259,0), rw = WRITE(), DATA, sector = 1064960, size = 409600

C. blk-mq-debugfs.c tests for __blk_mq_debugfs_rq_show() :-
-----------------------------------------------------------

# 1. Issue write-zeroes, disacrd and write operation on the null_blk
     with modified null_blk 

@@ -1180,6 +1207,20 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
                }
        }
+       /* just discard for write zeroes for now */
+       switch (req_op(cmd->rq)) {
+       case REQ_OP_DISCARD:
+               /* fall through */
+       case REQ_OP_WRITE_ZEROES:
+               mdelay(10000);
+               break;
+       case REQ_OP_WRITE:
+               mdelay(10000);
+       }
+
linux-block (for-next) # blkdiscard -z  -o 0 -l 40960 /dev/nullb0 
linux-block (for-next) # blkdiscard -o 0 -l 40960 /dev/nullb0 
linux-block (for-next) # dd if=/dev/zero of=/dev/nullb0 bs=4k count=1 oflag=direct

#2. Read the hctx busy file every second, each type of request should
    be block for 10 seconds and must appear in the hctx->busy file in
    the debugfs. This will lead to from block/blk-mq-debugfs.c : 
	{"busy", 0400, hctx_busy_show}
		hctx_show_busy_rq()
			__blk_mq_debugfs_rq_show()
				blk_op_str()

linux-block (for-next) # while [ 1 ]; do cat /sys/kernel/debug/block/nullb0/hctx0/busy ; sleep 1; done

0000000095104d0a {.op=WRITE_ZEROES, .cmd_flags=SYNC|NOUNMAP, .rq_flags=STARTED|ELVPRIV|IO_STAT|STATS, .state=in_flight, .tag=48, .internal_tag=96}
0000000095104d0a {.op=WRITE_ZEROES, .cmd_flags=SYNC|NOUNMAP, .rq_flags=STARTED|ELVPRIV|IO_STAT|STATS, .state=in_flight, .tag=48, .internal_tag=96}
0000000095104d0a {.op=WRITE_ZEROES, .cmd_flags=SYNC|NOUNMAP, .rq_flags=STARTED|ELVPRIV|IO_STAT|STATS, .state=in_flight, .tag=48, .internal_tag=96}
0000000095104d0a {.op=WRITE_ZEROES, .cmd_flags=SYNC|NOUNMAP, .rq_flags=STARTED|ELVPRIV|IO_STAT|STATS, .state=in_flight, .tag=48, .internal_tag=96}
0000000095104d0a {.op=WRITE_ZEROES, .cmd_flags=SYNC|NOUNMAP, .rq_flags=STARTED|ELVPRIV|IO_STAT|STATS, .state=in_flight, .tag=48, .internal_tag=96}
0000000095104d0a {.op=WRITE_ZEROES, .cmd_flags=SYNC|NOUNMAP, .rq_flags=STARTED|ELVPRIV|IO_STAT|STATS, .state=in_flight, .tag=48, .internal_tag=96}
0000000095104d0a {.op=WRITE_ZEROES, .cmd_flags=SYNC|NOUNMAP, .rq_flags=STARTED|ELVPRIV|IO_STAT|STATS, .state=in_flight, .tag=48, .internal_tag=96}
0000000095104d0a {.op=WRITE_ZEROES, .cmd_flags=SYNC|NOUNMAP, .rq_flags=STARTED|ELVPRIV|IO_STAT|STATS, .state=in_flight, .tag=48, .internal_tag=96}
0000000095104d0a {.op=WRITE_ZEROES, .cmd_flags=SYNC|NOUNMAP, .rq_flags=STARTED|ELVPRIV|IO_STAT|STATS, .state=in_flight, .tag=48, .internal_tag=96}
0000000095104d0a {.op=WRITE_ZEROES, .cmd_flags=SYNC|NOUNMAP, .rq_flags=STARTED|ELVPRIV|IO_STAT|STATS, .state=in_flight, .tag=48, .internal_tag=96}
0000000051de04b0 {.op=DISCARD, .cmd_flags=SYNC, .rq_flags=STARTED|ELVPRIV|IO_STAT|STATS, .state=in_flight, .tag=49, .internal_tag=47}
0000000051de04b0 {.op=DISCARD, .cmd_flags=SYNC, .rq_flags=STARTED|ELVPRIV|IO_STAT|STATS, .state=in_flight, .tag=49, .internal_tag=47}
0000000051de04b0 {.op=DISCARD, .cmd_flags=SYNC, .rq_flags=STARTED|ELVPRIV|IO_STAT|STATS, .state=in_flight, .tag=49, .internal_tag=47}
0000000051de04b0 {.op=DISCARD, .cmd_flags=SYNC, .rq_flags=STARTED|ELVPRIV|IO_STAT|STATS, .state=in_flight, .tag=49, .internal_tag=47}
0000000051de04b0 {.op=DISCARD, .cmd_flags=SYNC, .rq_flags=STARTED|ELVPRIV|IO_STAT|STATS, .state=in_flight, .tag=49, .internal_tag=47}
0000000051de04b0 {.op=DISCARD, .cmd_flags=SYNC, .rq_flags=STARTED|ELVPRIV|IO_STAT|STATS, .state=in_flight, .tag=49, .internal_tag=47}
0000000051de04b0 {.op=DISCARD, .cmd_flags=SYNC, .rq_flags=STARTED|ELVPRIV|IO_STAT|STATS, .state=in_flight, .tag=49, .internal_tag=47}
0000000051de04b0 {.op=DISCARD, .cmd_flags=SYNC, .rq_flags=STARTED|ELVPRIV|IO_STAT|STATS, .state=in_flight, .tag=49, .internal_tag=47}
0000000051de04b0 {.op=DISCARD, .cmd_flags=SYNC, .rq_flags=STARTED|ELVPRIV|IO_STAT|STATS, .state=in_flight, .tag=49, .internal_tag=47}
0000000051de04b0 {.op=DISCARD, .cmd_flags=SYNC, .rq_flags=STARTED|ELVPRIV|IO_STAT|STATS, .state=in_flight, .tag=49, .internal_tag=47}
0000000037e18909 {.op=WRITE, .cmd_flags=SYNC|IDLE, .rq_flags=STARTED|ELVPRIV|IO_STAT|STATS, .state=in_flight, .tag=49, .internal_tag=97}
0000000037e18909 {.op=WRITE, .cmd_flags=SYNC|IDLE, .rq_flags=STARTED|ELVPRIV|IO_STAT|STATS, .state=in_flight, .tag=49, .internal_tag=97}
0000000037e18909 {.op=WRITE, .cmd_flags=SYNC|IDLE, .rq_flags=STARTED|ELVPRIV|IO_STAT|STATS, .state=in_flight, .tag=49, .internal_tag=97}
0000000037e18909 {.op=WRITE, .cmd_flags=SYNC|IDLE, .rq_flags=STARTED|ELVPRIV|IO_STAT|STATS, .state=in_flight, .tag=49, .internal_tag=97}
0000000037e18909 {.op=WRITE, .cmd_flags=SYNC|IDLE, .rq_flags=STARTED|ELVPRIV|IO_STAT|STATS, .state=in_flight, .tag=49, .internal_tag=97}
0000000037e18909 {.op=WRITE, .cmd_flags=SYNC|IDLE, .rq_flags=STARTED|ELVPRIV|IO_STAT|STATS, .state=in_flight, .tag=49, .internal_tag=97}
0000000037e18909 {.op=WRITE, .cmd_flags=SYNC|IDLE, .rq_flags=STARTED|ELVPRIV|IO_STAT|STATS, .state=in_flight, .tag=49, .internal_tag=97}
0000000037e18909 {.op=WRITE, .cmd_flags=SYNC|IDLE, .rq_flags=STARTED|ELVPRIV|IO_STAT|STATS, .state=in_flight, .tag=49, .internal_tag=97}
0000000037e18909 {.op=WRITE, .cmd_flags=SYNC|IDLE, .rq_flags=STARTED|ELVPRIV|IO_STAT|STATS, .state=in_flight, .tag=49, .internal_tag=97}
0000000037e18909 {.op=WRITE, .cmd_flags=SYNC|IDLE, .rq_flags=STARTED|ELVPRIV|IO_STAT|STATS, .state=in_flight, .tag=49, .internal_tag=97}


-- 
2.19.1

