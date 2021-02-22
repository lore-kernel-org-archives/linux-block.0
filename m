Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6146FC433E6
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 05:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E20064E12
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 05:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhBVFbI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 00:31:08 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:29572 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhBVFbH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 00:31:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613971867; x=1645507867;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e9Ez0d2FDNgJluGJ7p/bbpstR82OKeUfC3KGCLVw26o=;
  b=VIPtazcXys79FbL2OGV/h1j6FiHJcAzVMpB6duEiLBjkLa4cqK8/OpNm
   RYzng9m1aNJzvFUd5zELefPE6JKnUFxuyDnU9kTAvsUbift7+AF+TI5OB
   mYWKFNUdwW+xAniu0gkaN1cAqofPiQerPbKX0dcXuWmyxISRswgDzcg0E
   o88l01HMoKCuRKRa1vxmaWDCOS54tmQDF5qSWTHoQuqSwq7T/8hqwrsN1
   E5a4Jn06Fw5nJQypX+m8Hz6O6pwlh0IKuX5IDg2V+OuCNMLbj/31EUBQk
   ukDaXGz49SiQ4QrKVICxWB9r20iGradYLJnDXkBg6DSqwgwi6yt5TzjiA
   A==;
IronPort-SDR: 0AoeIhPgEwsNs9vjmydT9d34fkC7JG7LmavcRccfYYyJCOwMq/BiPsg5Z1XAJIYCxmtFFXV84/
 4fGqugCsZyDr/244GThDa1/Z4fxMxRdREq1lGDQrkwrQHEeHoQ1xnLQvWm3U3y7es100zDMlH3
 SIofmxj8OsPGf/V4rIuRSUNLW0p0Tuo5HRBwb6sj8RBo654Hz96DHsiiOBfUjc2vg+jRWG9S5l
 oJKICenbK5SojNN2Az01d/aELNUUhE8P4Wm8yy2Llt7VaVoUad6SM0SFMAJ/X0yces81+ZrGE8
 +Hk=
X-IronPort-AV: E=Sophos;i="5.81,196,1610380800"; 
   d="scan'208";a="164956394"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2021 13:30:01 +0800
IronPort-SDR: T1FPbhnhDqrQvNWkBS0Psz0pEygmiVQqLo3HHAZLPyz0J6Rsx3Dvs7e75ZBBWTLIRVB06mwrYE
 1xj3+CkzvFfSzOb8VY6qFZcc3NjJo67jZqVq3gNCvUHpfdiYQcxXyh+5Zp4tFr1e51fG5FWbvv
 r32rHWnXXlhqZaR2BN+kPbVgNckjwidl1CJBbCqBUyWmTDNb20/+q9VjvrV3g6mJUUBgtxlOpM
 f2w34h7oFdTkBKOkjKnc71AAwF75dLqyoXG9kekVy/4Qr0rH+JlSzzxiXkt0KwQLM3jrQ3vvFQ
 rApKPzLItVin3eYtzHbGKCE+
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2021 21:13:21 -0800
IronPort-SDR: jjdmuc4VyQZDFJ6ZWHDJEdO6s5PFf5akd1xtdT1gPr6dJLDz1EyUe6mXmNseTOKWNqbudmEQ2e
 gP91j5f+JfPw1/G+C8zNagcr0YNjzHSEpReqKouYBkO6aMfedWML1Qdl5czT0ucLP2XQ2r+fMb
 weeIebvflBlzsiELKtAH5kKRs8uQFQWBBSlsYF95bi2NN0+uxquCVpd9S/24oQ6cZbcGXVJlwn
 i5RzTVfEXAdJYCsTI8znXYg9QkfJX1TB3OnCNitXEmINK2oJgIovVrDFgCePJXJ4hjH1pavJQX
 YWs=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Feb 2021 21:30:02 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     paolo.valente@linaro.org, axboe@kernel.dk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        akpm@linux-foundation.org, hare@suse.de, colyli@suse.de,
        tj@kernel.org, rdunlap@infradead.org, jack@suse.cz, hch@lst.de
Subject: [PATCH V3 0/5] blktrace: few cleanup
Date:   Sun, 21 Feb 2021 21:29:54 -0800
Message-Id: <20210222052959.23155-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

These are few cleanups for the block trace.

Below is the test log on latest linux-block/for-next.

-ck

V2->V3:-
1. Rebase on block/for-next 5.11.

V1->V2:-

1. Add fixes tags.
2. Move EXPORT_TRACEPOINT_SYMBOL_GPL(blk_rq_insert) to
   block/blk-core.c.
3. Add reviewed-by tags.
4. Remove the null_blk patches fro now, create a separate series.

Chaitanya Kulkarni (5):
  block: remove superfluous param in blk_fill_rwbs()
  blktrace: add blk_fill_rwbs documentation comment
  blktrace: fix blk_rq_issue documentation
  blktrace: fix blk_rq_merge documentation
  block: get rid of the trace rq insert wrapper

 block/bfq-iosched.c           |  4 +++-
 block/blk-core.c              |  1 +
 block/blk-mq-sched.c          |  6 ------
 block/blk-mq-sched.h          |  1 -
 block/kyber-iosched.c         |  4 +++-
 block/mq-deadline.c           |  4 +++-
 include/linux/blktrace_api.h  |  2 +-
 include/trace/events/bcache.h | 10 +++++-----
 include/trace/events/block.h  | 20 ++++++++++----------
 kernel/trace/blktrace.c       | 12 +++++++++++-
 10 files changed, 37 insertions(+), 27 deletions(-)

Scheduler, Bounce, Merge and usual tracepoint testing :-

###################     kyber     #####################
252,0   43        1     0.000000000  1095  Q  WS 0 + 8 [systemd-udevd]
252,0   43        2     0.000011001  1095  B  WS 0 + 8 [systemd-udevd]
252,0   43        3     0.000025768  1095  G  WS 0 + 8 [systemd-udevd]
252,0   43        4     0.000040316  1095  Q  WS 8 + 8 [systemd-udevd]
252,0   43        5     0.000045996  1095  B  WS 8 + 8 [systemd-udevd]
252,0   43        6     0.000048882  1095  M  WS 8 + 8 [systemd-udevd]
252,0   43        7     0.000062577  1095  Q  WS 16 + 8 [systemd-udevd]
252,0   43        8     0.000067837  1095  B  WS 16 + 8 [systemd-udevd]
252,0   43        9     0.000068949  1095  M  WS 16 + 8 [systemd-udevd]
252,0   43       10     0.000082375  1095  Q  WS 24 + 8 [systemd-udevd]
252,0   43       11     0.000088215  1095  B  WS 24 + 8 [systemd-udevd]
252,0   43       12     0.000089708  1095  M  WS 24 + 8 [systemd-udevd]
252,0   43       13     0.000102192  1095  Q  WS 32 + 8 [systemd-udevd]
252,0   43       14     0.000107261  1095  B  WS 32 + 8 [systemd-udevd]
252,0   43       15     0.000108333  1095  M  WS 32 + 8 [systemd-udevd]
252,0   43       16     0.000114124  1095  I  WS 0 + 40 [systemd-udevd]
252,0   43       17     0.000124734  1095  D  WS 0 + 40 [systemd-udevd]
252,0   43       18     0.000159740   227  C  WS 0 + 40 [0]
252,0   43       19     0.000165801   227  C  WS 0 + 8 [0]
252,0   43       20     0.000258675   227  C  WS 8 + 8 [0]
252,0   43       21     0.000265378   227  C  WS 16 + 8 [0]
252,0   43       22     0.000271098   227  C  WS 24 + 8 [0]
252,0   43       23     0.000276959   227  C  WS 32 + 8 [0]
CPU43 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           5,       20KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        1,       20KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        6,       40KiB
 Read Merges:            0,        0KiB	 Write Merges:            4,       16KiB
 Read depth:             0        	 Write depth:             1
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 23 entries
Skips: 0 forward (0 -   0.0%)
####################     bfq     #####################
252,0   43        1     0.000000000  1095  Q  WS 0 + 8 [systemd-udevd]
252,0   43        2     0.000011562  1095  B  WS 0 + 8 [systemd-udevd]
252,0   43        3     0.000035136  1095  G  WS 0 + 8 [systemd-udevd]
252,0   43        4     0.000051967  1095  Q  WS 8 + 8 [systemd-udevd]
252,0   43        5     0.000057017  1095  B  WS 8 + 8 [systemd-udevd]
252,0   43        6     0.000059291  1095  M  WS 8 + 8 [systemd-udevd]
252,0   43        7     0.000073007  1095  Q  WS 16 + 8 [systemd-udevd]
252,0   43        8     0.000078357  1095  B  WS 16 + 8 [systemd-udevd]
252,0   43        9     0.000079499  1095  M  WS 16 + 8 [systemd-udevd]
252,0   43       10     0.000092914  1095  Q  WS 24 + 8 [systemd-udevd]
252,0   43       11     0.000098384  1095  B  WS 24 + 8 [systemd-udevd]
252,0   43       12     0.000099456  1095  M  WS 24 + 8 [systemd-udevd]
252,0   43       13     0.000114314  1095  Q  WS 32 + 8 [systemd-udevd]
252,0   43       14     0.000119464  1095  B  WS 32 + 8 [systemd-udevd]
252,0   43       15     0.000120556  1095  M  WS 32 + 8 [systemd-udevd]
252,0   43       16     0.000128411  1095  I  WS 0 + 40 [systemd-udevd]
252,0   43       17     0.000172744  1095  D  WS 0 + 40 [systemd-udevd]
252,0   43       18     0.000216646   227  C  WS 0 + 40 [0]
252,0   43       19     0.000223078   227  C  WS 0 + 8 [0]
252,0   43       20     0.000255329   227  C  WS 8 + 8 [0]
252,0   43       21     0.000261390   227  C  WS 16 + 8 [0]
252,0   43       22     0.000266890   227  C  WS 24 + 8 [0]
252,0   43       23     0.000273533   227  C  WS 32 + 8 [0]
CPU43 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           5,       20KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        1,       20KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        6,       40KiB
 Read Merges:            0,        0KiB	 Write Merges:            4,       16KiB
 Read depth:             0        	 Write depth:             1
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 23 entries
Skips: 0 forward (0 -   0.0%)
####################     mq-deadline     #####################
252,0   43        1     0.000000000  1095  Q  WS 0 + 8 [systemd-udevd]
252,0   43        2     0.000011601  1095  B  WS 0 + 8 [systemd-udevd]
252,0   43        3     0.000022672  1095  G  WS 0 + 8 [systemd-udevd]
252,0   43        4     0.000037821  1095  Q  WS 8 + 8 [systemd-udevd]
252,0   43        5     0.000043651  1095  B  WS 8 + 8 [systemd-udevd]
252,0   43        6     0.000045836  1095  M  WS 8 + 8 [systemd-udevd]
252,0   43        7     0.000059191  1095  Q  WS 16 + 8 [systemd-udevd]
252,0   43        8     0.000064220  1095  B  WS 16 + 8 [systemd-udevd]
252,0   43        9     0.000065382  1095  M  WS 16 + 8 [systemd-udevd]
252,0   43       10     0.000211276  1095  Q  WS 24 + 8 [systemd-udevd]
252,0   43       11     0.000218459  1095  B  WS 24 + 8 [systemd-udevd]
252,0   43       12     0.000220323  1095  M  WS 24 + 8 [systemd-udevd]
252,0   43       13     0.000237204  1095  Q  WS 32 + 8 [systemd-udevd]
252,0   43       14     0.000243075  1095  B  WS 32 + 8 [systemd-udevd]
252,0   43       15     0.000244158  1095  M  WS 32 + 8 [systemd-udevd]
252,0   43       16     0.000250850  1095  I  WS 0 + 40 [systemd-udevd]
252,0   43       17     0.000259286  1095  D  WS 0 + 40 [systemd-udevd]
252,0   43       18     0.000290404   227  C  WS 0 + 40 [0]
252,0   43       19     0.000296305   227  C  WS 0 + 8 [0]
252,0   43       20     0.000324508   227  C  WS 8 + 8 [0]
252,0   43       21     0.000328345   227  C  WS 16 + 8 [0]
252,0   43       22     0.000343283   227  C  WS 24 + 8 [0]
252,0   43       23     0.000347291   227  C  WS 32 + 8 [0]
CPU43 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           5,       20KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        1,       20KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        6,       40KiB
 Read Merges:            0,        0KiB	 Write Merges:            4,       16KiB
 Read depth:             0        	 Write depth:             1
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 23 entries
Skips: 0 forward (0 -   0.0%)
####################     none     #####################
252,0   43        1     0.000000000  1095  Q  WS 0 + 8 [systemd-udevd]
252,0   43        2     0.000009768  1095  B  WS 0 + 8 [systemd-udevd]
252,0   43        3     0.000078246  1095  G  WS 0 + 8 [systemd-udevd]
252,0   43        4     0.000097001  1095  Q  WS 8 + 8 [systemd-udevd]
252,0   43        5     0.000103293  1095  B  WS 8 + 8 [systemd-udevd]
252,0   43        6     0.000105477  1095  M  WS 8 + 8 [systemd-udevd]
252,0   43        7     0.000121207  1095  Q  WS 16 + 8 [systemd-udevd]
252,0   43        8     0.000126116  1095  B  WS 16 + 8 [systemd-udevd]
252,0   43        9     0.000127248  1095  M  WS 16 + 8 [systemd-udevd]
252,0   43       10     0.000145482  1095  Q  WS 24 + 8 [systemd-udevd]
252,0   43       11     0.000150552  1095  B  WS 24 + 8 [systemd-udevd]
252,0   43       12     0.000152455  1095  M  WS 24 + 8 [systemd-udevd]
252,0   43       13     0.000166011  1095  Q  WS 32 + 8 [systemd-udevd]
252,0   43       14     0.000171030  1095  B  WS 32 + 8 [systemd-udevd]
252,0   43       15     0.000172102  1095  M  WS 32 + 8 [systemd-udevd]
252,0   43       16     0.000178625  1095  D  WS 0 + 40 [systemd-udevd]
252,0   43       17     0.000223148   227  C  WS 0 + 40 [0]
252,0   43       18     0.000229290   227  C  WS 0 + 8 [0]
252,0   43       19     0.000250139   227  C  WS 8 + 8 [0]
252,0   43       20     0.000256100   227  C  WS 16 + 8 [0]
252,0   43       21     0.000261931   227  C  WS 24 + 8 [0]
252,0   43       22     0.000268052   227  C  WS 32 + 8 [0]
CPU43 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           5,       20KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        1,       20KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        6,       40KiB
 Read Merges:            0,        0KiB	 Write Merges:            4,       16KiB
 Read depth:             0        	 Write depth:             1
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 22 entries
Skips: 0 forward (0 -   0.0%)
####################     split     #####################
252,0   29        1     0.000000000  5312  Q  DS 0 + 80 [blkdiscard]
252,0   29        2     0.000007694  5312  X  DS 0 / 0 [blkdiscard]
252,0   29        3     0.000020688  5312  G  DS 0 + 4 [blkdiscard]
252,0   29        4     0.000025297  5312  X  DS 4 / 0 [blkdiscard]
252,0   29        5     0.000028403  5312  G  DS 4 + 4 [blkdiscard]
252,0   29        6     0.000031429  5312  X  DS 8 / 0 [blkdiscard]
252,0   29        7     0.000034114  5312  G  DS 8 + 4 [blkdiscard]
252,0   29        8     0.000037049  5312  X  DS 12 / 0 [blkdiscard]
252,0   29        9     0.000039714  5312  G  DS 12 + 4 [blkdiscard]
252,0   29       10     0.000042489  5312  X  DS 16 / 0 [blkdiscard]
252,0   29       11     0.000050755  5312  I  DS 0 + 4 [blkdiscard]
252,0   29       12     0.000052658  5312  I  DS 4 + 4 [blkdiscard]
252,0   29       13     0.000053911  5312  I  DS 8 + 4 [blkdiscard]
252,0   29       14     0.000055073  5312  I  DS 12 + 4 [blkdiscard]
252,0   29       15     0.000096581   920  D  DS 0 + 4 [kworker/29:1H]
252,0   29       16     0.000108413   920  D  DS 4 + 4 [kworker/29:1H]
252,0   29       17     0.000110777   920  D  DS 8 + 4 [kworker/29:1H]
252,0   29       18     0.000112891   920  D  DS 12 + 4 [kworker/29:1H]
252,0   29       19     0.000128030   157  C  DS 0 + 4 [0]
252,0   29       20     0.000136405   157  C  DS 0 + 8 [0]
252,0   29       21     0.000151444   157  C  DS 0 + 12 [0]
252,0   29       22     0.000154589   157  C  DS 0 + 16 [0]
252,0   29       23     0.000164077  5312  G  DS 16 + 4 [blkdiscard]
252,0   29       24     0.000168125  5312  X  DS 20 / 0 [blkdiscard]
252,0   29       25     0.000171161  5312  G  DS 20 + 4 [blkdiscard]
252,0   29       26     0.000173936  5312  X  DS 24 / 0 [blkdiscard]
252,0   29       27     0.000176571  5312  G  DS 24 + 4 [blkdiscard]
252,0   29       28     0.000179316  5312  X  DS 28 / 0 [blkdiscard]
252,0   29       29     0.000181901  5312  G  DS 28 + 4 [blkdiscard]
252,0   29       30     0.000184626  5312  X  DS 32 / 0 [blkdiscard]
252,0   29       31     0.000189114  5312  I  DS 16 + 4 [blkdiscard]
252,0   29       32     0.000190417  5312  I  DS 20 + 4 [blkdiscard]
252,0   29       33     0.000191559  5312  I  DS 24 + 4 [blkdiscard]
252,0   29       34     0.000192671  5312  I  DS 28 + 4 [blkdiscard]
252,0   29       35     0.000210294   920  D  DS 16 + 4 [kworker/29:1H]
252,0   29       36     0.000217558   920  D  DS 20 + 4 [kworker/29:1H]
252,0   29       37     0.000219782   920  D  DS 24 + 4 [kworker/29:1H]
252,0   29       38     0.000221816   920  D  DS 28 + 4 [kworker/29:1H]
252,0   29       39     0.000229660   157  C  DS 0 + 20 [0]
252,0   29       40     0.000233197   157  C  DS 0 + 24 [0]
252,0   29       41     0.000243516   157  C  DS 0 + 28 [0]
252,0   29       42     0.000246352   157  C  DS 0 + 32 [0]
252,0   29       43     0.000254377  5312  G  DS 32 + 4 [blkdiscard]
252,0   29       44     0.000258304  5312  X  DS 36 / 0 [blkdiscard]
252,0   29       45     0.000261219  5312  G  DS 36 + 4 [blkdiscard]
252,0   29       46     0.000263985  5312  X  DS 40 / 0 [blkdiscard]
252,0   29       47     0.000266640  5312  G  DS 40 + 4 [blkdiscard]
252,0   29       48     0.000269425  5312  X  DS 44 / 0 [blkdiscard]
252,0   29       49     0.000271980  5312  G  DS 44 + 4 [blkdiscard]
252,0   29       50     0.000274695  5312  X  DS 48 / 0 [blkdiscard]
252,0   29       51     0.000278953  5312  I  DS 32 + 4 [blkdiscard]
252,0   29       52     0.000280175  5312  I  DS 36 + 4 [blkdiscard]
252,0   29       53     0.000281307  5312  I  DS 40 + 4 [blkdiscard]
252,0   29       54     0.000282379  5312  I  DS 44 + 4 [blkdiscard]
252,0   29       55     0.000346269   920  D  DS 32 + 4 [kworker/29:1H]
252,0   29       56     0.000353793   920  D  DS 36 + 4 [kworker/29:1H]
252,0   29       57     0.000355927   920  D  DS 40 + 4 [kworker/29:1H]
252,0   29       58     0.000357951   920  D  DS 44 + 4 [kworker/29:1H]
252,0   29       59     0.000366286   157  C  DS 0 + 36 [0]
252,0   29       60     0.000370284   157  C  DS 0 + 40 [0]
252,0   29       61     0.000380523   157  C  DS 0 + 44 [0]
252,0   29       62     0.000383338   157  C  DS 0 + 48 [0]
252,0   29       63     0.000391484  5312  G  DS 48 + 4 [blkdiscard]
252,0   29       64     0.000395742  5312  X  DS 52 / 0 [blkdiscard]
252,0   29       65     0.000398807  5312  G  DS 52 + 4 [blkdiscard]
252,0   29       66     0.000401593  5312  X  DS 56 / 0 [blkdiscard]
252,0   29       67     0.000404147  5312  G  DS 56 + 4 [blkdiscard]
252,0   29       68     0.000406943  5312  X  DS 60 / 0 [blkdiscard]
252,0   29       69     0.000409538  5312  G  DS 60 + 4 [blkdiscard]
252,0   29       70     0.000412273  5312  X  DS 64 / 0 [blkdiscard]
252,0   29       71     0.000416821  5312  I  DS 48 + 4 [blkdiscard]
252,0   29       72     0.000417993  5312  I  DS 52 + 4 [blkdiscard]
252,0   29       73     0.000419136  5312  I  DS 56 + 4 [blkdiscard]
252,0   29       74     0.000420228  5312  I  DS 60 + 4 [blkdiscard]
252,0   29       75     0.000438342   920  D  DS 48 + 4 [kworker/29:1H]
252,0   29       76     0.000445515   920  D  DS 52 + 4 [kworker/29:1H]
252,0   29       77     0.000447679   920  D  DS 56 + 4 [kworker/29:1H]
252,0   29       78     0.000449693   920  D  DS 60 + 4 [kworker/29:1H]
252,0   29       79     0.000457197   157  C  DS 0 + 52 [0]
252,0   29       80     0.000460473   157  C  DS 0 + 56 [0]
252,0   29       81     0.000470261   157  C  DS 0 + 60 [0]
252,0   29       82     0.000473017   157  C  DS 0 + 64 [0]
252,0   29       83     0.000480691  5312  G  DS 64 + 4 [blkdiscard]
252,0   29       84     0.000484478  5312  X  DS 68 / 0 [blkdiscard]
252,0   29       85     0.000487313  5312  G  DS 68 + 4 [blkdiscard]
252,0   29       86     0.000490099  5312  X  DS 72 / 0 [blkdiscard]
252,0   29       87     0.000492724  5312  G  DS 72 + 4 [blkdiscard]
252,0   29       88     0.000496821  5312  G  DS 76 + 4 [blkdiscard]
252,0   29       89     0.000501580  5312  I  DS 64 + 4 [blkdiscard]
252,0   29       90     0.000502732  5312  I  DS 68 + 4 [blkdiscard]
252,0   29       91     0.000503844  5312  I  DS 72 + 4 [blkdiscard]
252,0   29       92     0.000504977  5312  I  DS 76 + 4 [blkdiscard]
252,0   29       93     0.000523030   920  D  DS 64 + 4 [kworker/29:1H]
252,0   29       94     0.000529763   920  D  DS 68 + 4 [kworker/29:1H]
252,0   29       95     0.000531827   920  D  DS 72 + 4 [kworker/29:1H]
252,0   29       96     0.000533861   920  D  DS 76 + 4 [kworker/29:1H]
252,0   29       97     0.000541275   157  C  DS 0 + 68 [0]
252,0   29       98     0.000544591   157  C  DS 0 + 72 [0]
252,0   29       99     0.000547266   157  C  DS 0 + 76 [0]
252,0   29      100     0.000549881   157  C  DS 0 + 80 [0]
CPU29 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           1,       40KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:       20,       40KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:       20,      420KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             0        	 Write depth:             4
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 100 entries
Skips: 0 forward (0 -   0.0%)
####################     requeue     #####################
252,0   29        1     0.000000000  5404  Q  WS 0 + 8 [dd]
252,0   29        2     0.000013586  5404  G  WS 0 + 8 [dd]
252,0   29        3     0.000019647  5404  I  WS 0 + 8 [dd]
252,0   29        4     0.000065293   920  D  WS 0 + 8 [kworker/29:1H]
252,0   29        5     0.000069881   920  R  WS 0 + 8 [0]
252,0   29        6     0.000082565   920  I  WS 0 + 8 [kworker/29:1H]
252,0   29        7     0.000087063   920  D  WS 0 + 8 [kworker/29:1H]
252,0   29        8     0.000115106   157  C  WS 0 + 8 [0]
252,0   29        9     0.000160140  5404  Q  WS 8 + 8 [dd]
252,0   29       10     0.000163998  5404  G  WS 8 + 8 [dd]
252,0   29       11     0.000167524  5404  I  WS 8 + 8 [dd]
252,0   29       12     0.000185177   920  D  WS 8 + 8 [kworker/29:1H]
252,0   29       13     0.000198763   157  C  WS 8 + 8 [0]
252,0   29       14     0.000230382  5404  Q  WS 16 + 8 [dd]
252,0   29       15     0.000233849  5404  G  WS 16 + 8 [dd]
252,0   29       16     0.000237075  5404  I  WS 16 + 8 [dd]
252,0   29       17     0.000253005   920  D  WS 16 + 8 [kworker/29:1H]
252,0   29       18     0.000265608   157  C  WS 16 + 8 [0]
252,0   29       19     0.000295935  5404  Q  WS 24 + 8 [dd]
252,0   29       20     0.000299362  5404  G  WS 24 + 8 [dd]
252,0   29       21     0.000366467  5404  I  WS 24 + 8 [dd]
252,0   29       22     0.000385343   920  D  WS 24 + 8 [kworker/29:1H]
252,0   29       23     0.000387797   920  R  WS 24 + 8 [0]
252,0   29       24     0.000396844   920  D  WS 24 + 8 [kworker/29:1H]
252,0   29       25     0.000410941   157  C  WS 24 + 8 [0]
252,0   29       26     0.000452308  5404  Q  WS 32 + 8 [dd]
252,0   29       27     0.000456556  5404  G  WS 32 + 8 [dd]
252,0   29       28     0.000460053  5404  I  WS 32 + 8 [dd]
252,0   29       29     0.000477676   920  D  WS 32 + 8 [kworker/29:1H]
252,0   29       30     0.000490159   157  C  WS 32 + 8 [0]
252,0   29       31     0.000521779  5404  Q  WS 40 + 8 [dd]
252,0   29       32     0.000525205  5404  G  WS 40 + 8 [dd]
252,0   29       33     0.000528361  5404  I  WS 40 + 8 [dd]
252,0   29       34     0.000544030   920  D  WS 40 + 8 [kworker/29:1H]
252,0   29       35     0.000556514   157  C  WS 40 + 8 [0]
252,0   29       36     0.000588003  5404  Q  WS 48 + 8 [dd]
252,0   29       37     0.000591379  5404  G  WS 48 + 8 [dd]
252,0   29       38     0.000594525  5404  I  WS 48 + 8 [dd]
252,0   29       39     0.000610535   920  D  WS 48 + 8 [kworker/29:1H]
252,0   29       40     0.000612709   920  R  WS 48 + 8 [0]
252,0   29       41     0.000621175   920  I  WS 48 + 8 [kworker/29:1H]
252,0   29       42     0.000624601   920  D  WS 48 + 8 [kworker/29:1H]
252,0   29       43     0.000637155   157  C  WS 48 + 8 [0]
252,0   29       44     0.000667993  5404  Q  WS 56 + 8 [dd]
252,0   29       45     0.000671509  5404  G  WS 56 + 8 [dd]
252,0   29       46     0.000674705  5404  I  WS 56 + 8 [dd]
252,0   29       47     0.000691447   920  D  WS 56 + 8 [kworker/29:1H]
252,0   29       48     0.000703780   157  C  WS 56 + 8 [0]
252,0   29       49     0.000735710  5404  Q  WS 64 + 8 [dd]
252,0   29       50     0.000739116  5404  G  WS 64 + 8 [dd]
252,0   29       51     0.000742322  5404  I  WS 64 + 8 [dd]
252,0   29       52     0.000757531   920  D  WS 64 + 8 [kworker/29:1H]
252,0   29       53     0.000769643   157  C  WS 64 + 8 [0]
252,0   29       54     0.000800051  5404  Q  WS 72 + 8 [dd]
252,0   29       55     0.000803487  5404  G  WS 72 + 8 [dd]
252,0   29       56     0.000806633  5404  I  WS 72 + 8 [dd]
252,0   29       57     0.000821411   920  D  WS 72 + 8 [kworker/29:1H]
252,0   29       58     0.000833834   157  C  WS 72 + 8 [0]
CPU29 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:          10,       40KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:       13,       40KiB
 Reads Requeued:         0		 Writes Requeued:         3
 Reads Completed:        0,        0KiB	 Writes Completed:       10,       40KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             0        	 Write depth:             1
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 58 entries
Skips: 0 forward (0 -   0.0%)
# 

-- 
2.22.1

