Return-Path: <SRS0=ruTu=VG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39207C73C53
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 19:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C682073D
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 19:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SMGybQwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfGITVi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Jul 2019 15:21:38 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:63317 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGITVi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Jul 2019 15:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562700097; x=1594236097;
  h=from:to:cc:subject:date:message-id;
  bh=/dVhlprkuvuYl6IHLpPQbv28l0utyPav2MpGwuufLAo=;
  b=SMGybQwCs6iGHJBGKo5zzSfPz56rabmHvrPUgKVriyh6X6dxjoEgxnoR
   a6eQQ8UbAFLZvygVakupTyiLlv5pTSAI7qTnmAl8mD2qFLJ1FkDbXDUIc
   s+ezNUIDp1zZLVG2t8/YWsYtww5STALdbrJkOAsXVG41LlNtDGTDs5Qb0
   xppV0s7MMX5lB2MnyWRtRXiBzUsWhiW4Kw99R/9FX8zg1vKxhIm13dBY/
   +fydWMVZQjPhOL/z452/fh5jJ4Ev/Uwf+QQffcOwNQO3Mteg0w2rd2g5h
   OHfNFUnlzb27wtxVErfXD1xdz0TQm/Bpv2K+ZrzIbMwdbiHjZuMdwPrVH
   w==;
IronPort-SDR: AWXRD3JWq7S6GO2Ur92e/iYHhnh7BJW6tk6PEGk0qbiIFSGRN9rFoGwWWQhGZuvR2HPE+7Q8Pv
 29Y/LfeMo6H2jp49A8WbpDtmkRK7vaypgrWkRDvtwnYPuHiee7IZQruoXQbVo0xjiL/0ytOs97
 iz4SG4eMVc+A2y5AEjRWiQTNqNTbK/GeXos5Ue/tEyi5BT7lxmURv0z2RlwREwkDRIuczLkk/9
 sv0WTn1vLZsA0t/Ee1v8e8XCGf2jbfPPAXYDvF5Lj5vHhaldlxWUMpwEcZqSovQhcCSsryCT/c
 gfA=
X-IronPort-AV: E=Sophos;i="5.63,471,1557158400"; 
   d="scan'208";a="114198792"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2019 03:21:37 +0800
IronPort-SDR: iFVQBTmjXKRuA18QxHYLMnZNZqJDfZujuhqrlVZtCBv/XJBGCo9UH5SAJffVqS+qw2LhkfKo3g
 lW7gN0XAthwEG2dKUI/1LKjEJsRcEE9nhtHwR7SWZ4/U3XTZv4vAwm98EC6v8MBmGYIWKGmpwT
 M4XMbNk15UiVBfzzpU3oiCriyAeEMBnZ36dRtz3aDO2dmwCfeX2xy3QnBJJpUfsnelWLzusxAO
 O1yuMYIfzwPRsBGuUD9jk1Y4PdXqhxwAfGCxf0yQPY8gow0IH3FZIyMYwimcn6qsdjcotsvVzy
 f94GGQHLaPglfwt0uptxAHbV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 09 Jul 2019 12:20:23 -0700
IronPort-SDR: uT5uKZ6QK1WqZm5Sw9kyXF48K27orPA6XdDzZItuj8LN3m26uy3Qtf0R7bXLNxEuSUZWoBwZIe
 Fz4ICafA8op2cnrp0fEE6Z2i6lox1QzJ3Cy8JbWz50IR6kIOAo1IrJPZU4swh9YUpwrDt3ZggO
 6Bm0Dm86N4h392fRDSnN8C67KyFwTz2tMxKok0tO5LrJRfDGCmNW135XBXf5NqhOJv75MX8EA9
 Z3QDIIbEtzblGUX8EiItWTTqkbu7yFMisGLwuhRZut4In5wxP4Upl3dlQ3bx6x6lOrC0OQM7AK
 +08=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Jul 2019 12:21:37 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 0/6] null_blk: simplify null_handle_cmd()
Date:   Tue,  9 Jul 2019 12:21:26 -0700
Message-Id: <20190709192132.24723-1-chaitanya.kulkarni@wdc.com>
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

 drivers/block/null_blk.h       |  20 ++--
 drivers/block/null_blk_main.c  | 178 +++++++++++++++++++--------------
 drivers/block/null_blk_zoned.c |  29 +++---
 3 files changed, 128 insertions(+), 99 deletions(-)

-- 
2.17.0

