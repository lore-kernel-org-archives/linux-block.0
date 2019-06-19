Return-Path: <SRS0=VMX8=US=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27759C31E5B
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 17:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CD420657
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 17:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KKalABWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfFSRNw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:13:52 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:10796 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfFSRNv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jun 2019 13:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560964431; x=1592500431;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TInAL4Oc2J2XiF8ddUq/9Gu8GiCkPGcYzpL3RShKoHw=;
  b=KKalABWaF7r2QAdTXBkz7Ybmz8dcSBgNUg+RSLTM1uaT0cC0i3fUqBOY
   qVuNCtm2Y+fZ9X21tLU4c4NUk984u83lQHn1uOVSEir5Fkj9ypIz6Kzuy
   jqJnWFQoPcFSAvVYTibw9OIEGBiw0BZTp6SxdAlS7ooWgzsD0GViPI7xz
   cU202zVacWvBQyMKX4bGtobKAnxoDtEQBAasosHEqW+weZ5o7jAhu76dC
   iJ2q2qusmF2uIMFoLgDjkg6qC7r8LVOkEN5e3YWJF5u3VByQmZjxfSU5o
   t3cHzelfTwj4ZLt4YulYZb/EjjZ6ZuRovyWwvXiGHPoAnRW2vQHnVti1d
   g==;
X-IronPort-AV: E=Sophos;i="5.63,393,1557158400"; 
   d="scan'208";a="115883793"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2019 01:13:50 +0800
IronPort-SDR: s4Ef86Z79GKvllbpuIn0pGl7RRyrvnJqtvSuWx1/nOzobo6H0MJ8ahEk+mpE39ophAsfq1Lg+G
 8hECkM6xcheeM8+hxALonsPBugppn2TVc8srUkNnXhZ6g8mSnnelJEDz1FwBDikFwtpeaLYtMM
 tkLjk8ZLz8yNtAdZ9HAD7lRTnePC2+C2JP68NiZ+7lvqHNMtcRE57QECTK6LxiR8pS1Kmuwnar
 sni5cnrRcCyYAapSVT+KFiFMsQdHZUj/YMQGxAMhfrsU0unpY4m9v+H6gNvDGzc0YJN/YUvPb1
 5exMI28bO9REG1IkblYQ40vx
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Jun 2019 10:13:15 -0700
IronPort-SDR: dNiM4rTE6sNRLuCY4nuoGP8Bh7zU1lK+zSC7Pxi9BcMJYEjPahJjXa3Psg/Kg9G+EBXYcpRn3W
 BBgAquvRy5EGJ7PZiJ8JxS8vMOlHFQlNmkxA6OP0maAIRQTVtUtr8afHuCR/J2PF9IavttzxMG
 C+iaH+ksewqOrrvIIbty53MfBuv1pefi+QEcrRGxIhbmXcncpJ4gBrlPwpcpV/2/jPKR1epV5O
 y/f//4NyqvhCfN5+Mn0h5LmEUNLbhgc477ukDyxYb3ZuoO49MHO/OGdWbHPVLdTLrfFqxIr4Iq
 cbA=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Jun 2019 10:13:49 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     jaegeuk@kernel.org, yuchao0@huawei.com, bvanassche@acm.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V4 0/5] block: improve print_req_error
Date:   Wed, 19 Jun 2019 10:12:57 -0700
Message-Id: <20190619171302.10146-1-chaitanya.kulkarni@wdc.com>
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

Changes from V3:-

1. Use unsigned int for op parameter in the blk_op_str(). (Bart)
2. Keep Christoph's signed-off first in the first patch in the series.
   (Bart).
3. Merge patch 5-6. (Bart, Chao)
4. Just modify the show_bio_op() macro and with call to blk_op_str().
   (Chao).

Chaitanya Kulkarni (4):
  block: add centralize REQ_OP_XXX to string helper
  block: use blk_op_str() in blk-mq-debugfs.c
  block: update print_req_error()
  f2fs: use block layer helper for show_bio_op macro

Christoph Hellwig (1):
  block: improve print_req_error

 block/blk-core.c            | 55 ++++++++++++++++++++++++++++++++-----
 block/blk-mq-debugfs.c      | 24 +++-------------
 include/linux/blkdev.h      |  3 ++
 include/trace/events/f2fs.h | 11 +-------
 4 files changed, 56 insertions(+), 37 deletions(-)

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

