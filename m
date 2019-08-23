Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3C8C3A589
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 04:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC3B233FD
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 04:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EVvYv8YL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391753AbfHWEpe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Aug 2019 00:45:34 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41996 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389942AbfHWEpd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Aug 2019 00:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566535648; x=1598071648;
  h=from:to:cc:subject:date:message-id;
  bh=ngp3V21INu5p08MZ9LrB1i6xVJvn9FxaCtUYzy2gqVA=;
  b=EVvYv8YLpCMsLpw307bPsns/FsZ6OOzChE6jY++//kQTvsG8Iz8Oijlm
   ZBblR+4VD0BgVL/u37klCtFAi87dG7b7+uhNb90x5yq06j42SL6Ru+qU9
   EgVwVUn8hUl2k6pIgHbDjQsWV5esmrH6qTzKBxpyIqC65hSPiCVP5emD9
   0KoAyyDekv3Apu5L2He71ygk43OL2UhbulpuWB8rByBqUg7+e9zmG5OXq
   4q+8vFJw1Up1OBZwRTnmjlxH0X8y7cB+Gr2rahyjr4O+LjaiEYGmt+AHa
   caEfWY3eKt0tnRq8aF5N4upgXl61KvP8LOtSDVRxsk1W2WIjz9mftBIcb
   Q==;
IronPort-SDR: IE4VHztmL0IdklLtv0EmCKZo7y/vr0Lv6oN6+Y6ulHfjxpcf2vjqq3YeyIRjnehFa2VjXBssRu
 2qe85vu7o66oxP/21o46JIPvPq2cErzRtwFkqsg7N22eRX7bXk2bDqy5rf+wrQrR6o+Znj3Jss
 yerrtSObqbkFMjMP6VlKgPN8lx8tKXQPBmkHMhCjop+61QDceQjYRb5CBKQlPpblyL8v14Agsv
 UHIV50GKhDqN1+OOvnaJj9z4hv2pOVYH3C6MQvoI3L5QSGx6zHvSEmZTN9U2HaCmeNYC/SrbMO
 SSs=
X-IronPort-AV: E=Sophos;i="5.64,420,1559491200"; 
   d="scan'208";a="216934481"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 12:47:15 +0800
IronPort-SDR: 7xT8nE1tDtxERWJEk5Y7wjbTdyAoH5L4Cb+K78ScYBWX6oKg8FQJNh7S2ZA72TSmKivRcEwwBV
 luEiktN5PJyiVQiX6Qsy3Q2I32P6ovRTA5HdkHio1j/VszvcT5FZmFNxtQUcFNiHkJ51kenATl
 ri4l4RfrEt20gpNykAaYpK8t2WdTtKh/vGNUMrPDAsDcT6dd41MCY5e65zOlxtuoAM1/jceCGS
 1txzLoXN3dLde5Xkke/Hr0/fY97/hFbE0zhvXHUkr4sMtasFDcSjy4p507lOvAkebe0nRBGdvH
 XtAkB9Nxj7NOVvXSQkQh0x4x
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 21:42:43 -0700
IronPort-SDR: foE0jRrQkmelAUXchyhwnv5vBdDlLtrG4RU9OlZPyTqj4gVTnyte6VsMOwE7UX0r3dbVrJpjy5
 fA/soHSn9K8AqL+FfTB4EifXr0VppSOmldW4/E6/Yz6ZDCqibIK0QpB3OmV8ftFqTO+He5Oq1E
 FMeuPyMrg3C+cuoKXuc30RZcn2ghw/oSquIitb7dSquu7x+xl1S3jhxtNIj1ZT1Ds9OHJpLjnC
 RGAFWKPEzwM4wCynqm0agmRZaCBOZwdZc5PYQNJw5SB/8s5z9sJVmSF4O+2PPxSuzckR3VMx0t
 Crk=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Aug 2019 21:45:24 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, axboe@kernel.dk,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V4 0/6] null_blk: simplify null_handle_cmd()
Date:   Thu, 22 Aug 2019 21:45:13 -0700
Message-Id: <20190823044519.3939-1-chaitanya.kulkarni@wdc.com>
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

Regards,
Chaitanya

[1] https://www.spinics.net/lists/linux-block/msg41884.html
[2] https://www.spinics.net/lists/linux-block/msg41883.html
[3] https://github.com/torvalds/linux/blob/master/drivers/nvme/host/pci.c

* Changes from V3:-
1. Rename nullb_handle_cmd_completion () -> nullb_complete_cmd().
2. Move null_handle_zoned() to null_blk_zoned.c and adjust rest of the
   code in null_blk_zoned.c.
3. Fixed the bug in null_handle_cmd() for REQ_OP_ZONE_RESET_ALL.

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

 drivers/block/null_blk.h       |  13 +--
 drivers/block/null_blk_main.c  | 162 +++++++++++++++++----------------
 drivers/block/null_blk_zoned.c |  38 +++++---
 3 files changed, 115 insertions(+), 98 deletions(-)

-- 
2.17.0

