Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0093EC2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 23:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD754600EF
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 23:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhFVXX2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 19:23:28 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:61517 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhFVXX1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 19:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624404071; x=1655940071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BuJA9NFnzcyZCKSjmej6LJK8UsPzKQjsqj/RGHYligI=;
  b=WxUtREpTpjtmsw0NjUwjC3c9Pux3aUKQMd1i/OaSZGNA9V1kOwbIFKpH
   xOCGmdeHP9OyJEQhfqa5+GApsMpo2k813K0hQAqID2o8BhqWoi3mN1S6d
   yaFwXhgB14YEKYSZFPfB592ZYzgKIshV+0g7+T/YeTHiPS1YCDrZm0sFn
   ebr7E6eOcLO5dAs2zGaa39DWtn1JOShMldRhLeHxxsQeeoHEpOC3L1xfh
   H+AOSViI90j2KEYtubUGaNZD294gDKgkhQeLKki+O0SSL9EPtXQrhnx51
   g4NZe9OnSMOUal2c2HbN4kkHma5xKKijdmhCfGjDWixcO6RxFfZhxS6gN
   g==;
IronPort-SDR: DSopaqNY533BZ16axO8khiDS88U5mVwGK3Va8z/iaNJOCExAzCPxYpxKxqcESOIdJ0IvCClqwX
 S6UQdjFjfuTFEylYNyh8pZMm9xK0CdGinfC71CWVrKH7CLKxtlzX5war4tUncQk2HdL1En+ech
 qqAC1nl/pBwt+kLgGsZS/Kkj9JMoZmW6uM1qLns30NUaLaBUfCjJR6Tp1niTIVb4Y1q6R9zB61
 yOUbmhFOgknEqhwQg1z0qLiAu7cFyu/T3nLFOlVpUyiiGjFLvAkBui4P7DvM7/MTFs3DqSo+WB
 89w=
X-IronPort-AV: E=Sophos;i="5.83,292,1616428800"; 
   d="scan'208";a="173199020"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2021 07:21:11 +0800
IronPort-SDR: Hm7rLE8E8YNuYosrsFY9IziTCzlwhSZWEk85FLHOhUKiEJlAorw/SnPXLRZ/v11BTqKQrOBJ3T
 n/Ec39SlGGRnr8W4oMMXQ+4C9aLzHNjJAQG/3iJdl3to4f761N7V5/upjYgUGXTdyANY0MW5Kw
 9nA6gw1u5HkYilvwy8/gj0W9jwOet56ruKTXN48dwa9JKI/S2HRKG0H4r1rU7XmlUMAg4fE9qk
 qgUrjrvyCCozsLMeVYNq3PJ3tGz31dk0+zPasipo3yA/GnhA8gL+j6vz9wWPvJIbwgtvA2Mn+k
 Pf0jL5u9ZfJr+aA4lS7SE1n3
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 15:59:48 -0700
IronPort-SDR: rQMcRMmHveJVZnMXmybCxXh8x1+62x1sTwsVSa03pf0GvEDaJt75sr+SATZ+9TfzicOxswXkjb
 bw1DTLrYRu2s5adm5ZpzJFrnc4kzlmifcQPWm1+pwDwqRwSwYiks/dfYUfFc77R+OuCr4DBnqK
 dt77VVqWnpj84WfBXG+1SAMi/35inCqa99DZbnlzlMKe6UrPwLMeq6yhSRtn07DXsUOUkxlZva
 +F28dhxy89zFFpyBFRLM+bAzKqxpe/lzROV6611A8lDKeNBEqmfuOyQkOwFjeGSpmplZAoCbwD
 IGw=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Jun 2021 16:21:11 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 7/9] loop: remove extra variable in lo_req_flush
Date:   Tue, 22 Jun 2021 16:19:49 -0700
Message-Id: <20210622231952.5625-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210622231952.5625-1-chaitanya.kulkarni@wdc.com>
References: <20210622231952.5625-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The local variable file is used to pass it to the vfs_fsync(). We can
get away with using lo->lo_backing_file instead of storing in a local
variable which is not used anywhere else.

No functional change in this patch.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 52f0b68466c0..58b315342af2 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -455,8 +455,7 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 
 static int lo_req_flush(struct loop_device *lo, struct request *rq)
 {
-	struct file *file = lo->lo_backing_file;
-	int ret = vfs_fsync(file, 0);
+	int ret = vfs_fsync(lo->lo_backing_file, 0);
 	if (unlikely(ret && ret != -EINVAL))
 		ret = -EIO;
 
-- 
2.22.1

