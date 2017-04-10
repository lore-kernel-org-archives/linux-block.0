Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:40417 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751448AbdDJJGN (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Mon, 10 Apr 2017 05:06:13 -0400
Date: Mon, 10 Apr 2017 11:05:38 +0200
From: Andreas Herrmann <aherrmann@suse.com>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: bfq-mq performance comparison to cfq
Message-ID: <20170410090538.GA11473@suselix.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Paolo,

I've looked at your WIP branch as of 4.11.0-bfq-mq-rc4-00155-gbce0818
and did some fio tests to compare the behavior to CFQ.

My understanding is that bfq-mq is supposed to be merged sooner or
later and then it will be the only reasonable I/O scheduler with
blk-mq for rotational devices. Hence I think it is interesting to see
what to expect performance-wise in comparison to CFQ which is usually
used for such devices with the legacy block layer.

I've just done simple tests iterating over number of jobs (1-8 as the
test system had 8 CPUs) for all (random/sequential) read/write
patterns. Fixed set of fio parameters used were '-size=5G
--group_reporting --ioengine=libaio --direct=1 --iodepth=1
--runtime=10'.

I've done 10 runs for each such configuration. The device used was an
older SAMSUNG HD103SJ 1TB disk, SATA attached. Results that stick out
the most are those for sequential reads and sequential writes:

 * sequential reads
  [0] - cfq, intel_pstate driver, powersave governor
  [1] - bfq_mq, intel_pstate driver, powersave governor

 jo             [0]               [1]
 bs       mean     stddev    mean       stddev
  1 & 17060.300 &  77.090 & 17657.500 &  69.602
  2 & 15318.200 &  28.817 & 10678.000 & 279.070
  3 & 15403.200 &  42.762 &  9874.600 &  93.436
  4 & 14521.200 & 624.111 &  9918.700 & 226.425
  5 & 13893.900 & 144.354 &  9485.000 & 109.291
  6 & 13065.300 & 180.608 &  9419.800 &  75.043
  7 & 12169.600 &  95.422 &  9863.800 & 227.662
  8 & 12422.200 & 215.535 & 15335.300 & 245.764

 * sequential writes
  [0] - cfq, intel_pstate driver, powersave governor
  [1] - bfq_mq, intel_pstate driver, powersave governor

 jo            [0]               [1]
 bs      mean     stddev    mean       stddev
  1 & 14171.300 & 80.796 & 14392.500 & 182.587
  2 & 13520.000 & 88.967 &  9565.400 & 119.400
  3 & 13396.100 & 44.936 &  9284.000 &  25.122
  4 & 13139.800 & 62.325 &  8846.600 &  45.926
  5 & 12942.400 & 45.729 &  8568.700 &  35.852
  6 & 12650.600 & 41.283 &  8275.500 & 199.273
  7 & 12475.900 & 43.565 &  8252.200 &  33.145
  8 & 12307.200 & 43.594 & 13617.500 & 127.773

With performance instead of powersave governor results were
(expectedly) higher but the pattern was the same -- bfq-mq shows a
"dent" for tests with 2-7 fio jobs. At the moment I have no
explanation for this behavior.


Regards,
Andreas
