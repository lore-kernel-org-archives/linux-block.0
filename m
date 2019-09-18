Return-Path: <SRS0=kmcw=XN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC54CC4CEC9
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 00:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9212421855
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 00:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Q3kRWtQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfIRAzO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 20:55:14 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:55329 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfIRAzN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 20:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1568768111; x=1600304111;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yqLl6gPsDThKHIEBueIaMMItyKoUVfvDwI8vMIav42o=;
  b=Q3kRWtQu0fxjR6SlyT0KAmpzK6pftFVMw1I1mosJZTQEQjwbxsuEAr9/
   ngKgrw+/f7ujg/K2GKuIQJ5jgweOupVc8cC/zXUY96ppp7Rc4owRiLtD9
   oEofkrhAn2FxRSEI1Bk4Sax8PRlqzO3ZJEP7OT62/aZmZ1KfnZpZGBDO5
   +ZouBkuQ/iaeEEMQlokAb8i5SpQ/SIDG4Zhr8kjchKbVwchySSP1TSdjY
   M1V4EJTgdSbr76yGq4aCoUtY0VEMgSVbbUlRH5p7OaEF3MIebeghW4IZR
   Tel15GG9a3GakADV2m9/jvm7G6NvC1Z1DRMTcVZe76h/yXR7TFEInGFo2
   Q==;
IronPort-SDR: MRfapL8TuzdgtWDr2/JOEp8UipDGLXh6eEoDM9+tnWXPxF5G6kDWwg+2kccGS2tLhvxjAZNzCj
 YkrxzoLUlTpmLKzaz8xHXOffm5GsHTORVulkWsaLtzlVxmuRcgPUUcptaprhbIvxZfBEw+kE8b
 1FDtmSg9LoVuZ7gxd8lWrhOVy++p6I3rR8lH5Vz4en8SMMbEtKRLtuHBoI9e2zkdoqQnxsIO/6
 C1W+w66q/u3i/EKBm/+cugqfJ3u8GuO4GRoXCI/hcKM9oM8YLajcYjiSo+7iDUKiJYNaXa6WAE
 8qw=
X-IronPort-AV: E=Sophos;i="5.64,518,1559491200"; 
   d="scan'208";a="122978163"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2019 08:55:04 +0800
IronPort-SDR: De7tbTlaLNwFN0lcYDDSNdUgyfUxFj3mafdZcuv92jDFnI6XlRXVlHQR5D4qT3cSnKsDnCalzj
 eCqHOo35skaoi40lF9mbZK2GgCHntZdRLvn1IyV1Qc6kT2voeo8x9ALEKFakht3nuxUVSR5+Dz
 O1gyEeLsaiUnd6Cwa2o93q8Y/HTK85e2MiNTi+7KCfwPkEhUuMZS/8UrZ3gkOlfAmOUixJFqin
 TcpEGeE7ew1QBjUSm1BBKTkqLxmGjLtFIiENW9Gsjhw9u/xEhn6j6bN7cBUFY044aSM+b8d6w5
 GTDsjS0ScB7Ow7n9vlRXJcMH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2019 17:51:38 -0700
IronPort-SDR: lO6j28QDFVYcVt70GphNkHLC7+1cXJs3KkLOt/TlxP2opXzyjJF49D7CCTHSHhhctJ7EBc1Aj/
 egijbsTtJ/vT36BpcrEIw9uha3QW4SAwRpxIKsmNCG4uV8UoDftBPswZ0z5PiUVHqFRRrPI9Rn
 IjW+Enpqmi1MtmiMkASX6BjgOGY/vad0a69UUzEm2E4ndkiirj5fqyRxFqFlnJUPAtDpv3Gdfb
 yahw00+uMBTGdLKmOfvQFa07Pup1zK9pX/q6Y2roR7KvoPU3gNcxfSht4zaeVnw8XGebnYi88R
 OUk=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Sep 2019 17:55:03 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, osandov@fb.com, bvanassche@acm.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 0/2] block: track per requests type merged count
Date:   Tue, 17 Sep 2019 17:54:52 -0700
Message-Id: <20190918005454.6872-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

With current debugfs block layer infrastructure, we only get the total
merge count which includes all the requests types, but we don't get 
the per request type merge count.

This patch-series replaces the rq_merged variable into the 
rq_merged array so that we can track the per request type merged stats.

Instead of having one number for all the requests which are merged,
with this now we can get the detailed number of the merged requests                                    
per request type which is mergeable.

This is helpful in the understanding merging of the requests under
different workloads and for the special requests such as discard which
implements request specific merging mechanism.

* Changes since V1 :-

 1. Add a reusable helper.
 2. Only print merged stats for the requests which are mergeable.
 3. Adjust the code for the latest block/for-next branch.

Chaitanya Kulkarni (2):
  block: add helper to check mergeable req op
  block: track per requests type merged count

 block/blk-mq-debugfs.c | 12 ++++++++++--
 block/blk-mq-sched.c   |  2 +-
 block/blk-mq.h         |  2 +-
 include/linux/blkdev.h | 24 +++++++++++++++++-------
 4 files changed, 29 insertions(+), 11 deletions(-)

-- 
2.17.0

