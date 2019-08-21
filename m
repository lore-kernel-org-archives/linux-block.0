Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3006C3A59E
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 06:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AA02339E
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 06:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Lv4WnB8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfHUGNS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 02:13:18 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:37509 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbfHUGNS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 02:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566367998; x=1597903998;
  h=from:to:cc:subject:date:message-id;
  bh=a/B/kiSKuTD4zOM3hZkiKEo3z0oKXLOl44eq88KllDA=;
  b=Lv4WnB8JOYSOjVkoBNwQ7Cjp48hFi7oyacMPFLmXrX9AYHdcFMdGuDIQ
   e+rg+6BEfAieMfIkUf4JFv3aUOZ/L4cQGQ9YznOheNwV98leklQEl7At5
   JX91ftT4l3V91KiQu6umDGED5+Xummp3J0qcudpjTnnf1ucI0Su6T9sgD
   9J64G2D0dHYAKj2SQLiPHzmSDysiyfUeT1LF0xB8yOS5jy1VJPqSm/FRw
   3Es2Yn8z0m2hGdGqdxGAlR3FQZ1qOplbgdPIOwn68jShHYPOosOfujCFl
   OMR6yx0q9jrCYnuxcev2p1k2MnizVHbCNre+dEC5LyQfQ5kb2GnsNH2Ad
   A==;
IronPort-SDR: CetNun2+W87yVKrmJpyWsRAK2iIQTbXT/PbkTYIQFDBMOtUog3p+ZH7Bp37mksGYrsPb6bz58k
 Q/RzPLYGaPlEVDq9/Jx/hZIi8SDD1GgZi7q2awgQJAowEt40TleKIbZ3XIyUD90O9M82p97rZP
 SLdUn55A/NgPv2mX71fdWj6WkSANkqEIZXiNhA8e4BhbAee3aPcpqaeghQiDukW8a9aTkVAe44
 I781xVECekYWVKKmaFDPtxEHCtL5aCHqG9T/0TZ0ljW14fQfSexXN9TDdy9zkI4dAiLdXUkzOv
 c00=
X-IronPort-AV: E=Sophos;i="5.64,411,1559491200"; 
   d="scan'208";a="117238996"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2019 14:13:17 +0800
IronPort-SDR: XvrM7jCXSdV0/ulshYApZi1JsxPirCOT3foOKhq+bD8JV1r4N/s8s/kSRyqPpktOayRPOghAmn
 Qyn7i+P1rrPK1+8dehuG146ZY1WGi7Dy53W5UNbbhj7pbEDLWOqLw+ndXpxg3ATIWjRrt4c0Mc
 lDpC6yxtqTVEGsHz6tyqjLhxhIyN4GLn6cYRdFYgffXs3JRg4hYFqukx8kXiR2Zi8KT4iAvnlQ
 jj8vyv+SxLVooAPJVkiggUCzQXsRLEphSQqI04Zq0pL53qGpovETwPm/xjJMRPL3aqOodv0hiC
 xn6VwauIsAY0OsrnWTPOzIhx
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 23:10:38 -0700
IronPort-SDR: vJZBNRxkG7ePAv8YJzaRb6ekWrxSn0jg2HrTXGDeimtbkhK0g2oLOYbQvZW1UI48s4D5kD87Y7
 nSWurNLnmYEWoqxUCljgg0flrKsKiwLVsaYWBdQCFiBUH2yJIcEsHEhXogGzYMPj2Lwu5ULfzn
 wU/YK5yv9/hk1POVq/sf9KQhnDyTDFq57w6KFeU6Bdt9c4DqRH7LLbFr7gQZp3sojlGwNpi/SS
 M1VBurWa7q0NnWiimQXFAwiTEcLtX7AxQ502fB+HtzB3OZTnLfaFimRlIpPvLfLAhzrI6hFuNe
 3Mc=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Aug 2019 23:13:17 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, axboe@kernel.dk,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 0/6] null_blk: simplify null_handle_cmd()
Date:   Tue, 20 Aug 2019 23:13:08 -0700
Message-Id: <20190821061314.3262-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The core function where we handle the request null_handle_cmd() in the
null_blk does various things based on how null_blk is configured :-

1. Handle throttling.
2. Handle badblocks.
3. Handle Memory backed device operations.
4. Handle Zoned Block device operations.
5. Completion of the requests.

With all the above functionality present in the one function,
null_handle_cmd() is growing and becoming unreasonably lengthy when
we want to add more features such as new Zone requests which is being
worked on (See [1], [2]).

This is a cleanup patch-series which refactors the code in the
null_handle_cmd(). We create a clear interface for each of the above
mentioned functionality which leads to having null_handle_cmd() more
clear and easy to manage with future changes. Please have a look at
NVMe PCIe Driver (nvme_queue_rq()) (See [3]) which has a similar code
structure and nicely structured code for doing various things such as
setting up commands, mapping of the block layer requests, mapping
PRPs/SGLs, handling integrity requests and finally submitting the
NVMe Command etc.

With this patch-series we fix the following issues with the current 
code :-

1. Get rid of the multiple nesting levels (> 2).
2. Easy to read, debug and extend the code for specific feature.
3. Get rid of the various line foldings which are there in the code
   due to multiple level of nesting under if conditions.
4. Precise definition for the null_handle_cmd() and clear error
   handling as helpers are responsible for handling errors.

Please consider this for 5.3.

Cc: hch@lst.de

Regards,
Chaitanya

[1] https://www.spinics.net/lists/linux-block/msg41884.html
[2] https://www.spinics.net/lists/linux-block/msg41883.html
[3] https://github.com/torvalds/linux/blob/master/drivers/nvme/host/pci.c

* Changes from V2:-
1. Adjust the code to latest upstream code.

* Changes from V1:-
1. Move bio vs req code into the callers for the null_handle_cmd() and
   add required arguments to simplify the code in the same function.
2. Get rid of the extra braces for the null_handle_zoned().
3. Get rid of the multiple returns style and the goto.
4. For throttling, code keep the check in the caller.
5. Add uniform code format for setting the cmd->error in the
   null_handle_cmd() and make required code changes so that each
   feature specific function will return blk_status_t value.

Chaitanya Kulkarni (6):
  null_blk: move duplicate code to callers
  null_blk: create a helper for throttling
  null_blk: create a helper for badblocks
  null_blk: create a helper for mem-backed ops
  null_blk: create a helper for zoned devices
  null_blk: create a helper for req completion

 drivers/block/null_blk.h       |  19 ++--
 drivers/block/null_blk_main.c  | 180 +++++++++++++++++++--------------
 drivers/block/null_blk_zoned.c |  23 ++---
 3 files changed, 125 insertions(+), 97 deletions(-)

-- 
2.17.0

