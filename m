Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECABEC43460
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 02:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D215061244
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 02:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237381AbhESC4x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 May 2021 22:56:53 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:5175 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237388AbhESC4x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 May 2021 22:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621392933; x=1652928933;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=e15Ea9cootfyBzy+8E0nVCIAqVY5pQ16BoohXVVok1A=;
  b=FJ30N7kcH74lr6TRuFI5WkC+ludLHp0Z4O7qK5u+5WVF0uT0Mg3FiKFU
   yMpy9V99VI+VDOYsfSqUo59fyUco2pEPjhyekDHJr9gua1peMy2kNybWG
   rcesRIP7Cd/nsGk2OAWSY8wDvp4qPkLhiout8UsiQQG2llbH4EpsM9YCz
   bfRhv9q8O/qxYuhFqLIuneqM/gJq+93QGBFbVeRwbsdjPFCVmozHOZv82
   +4ob0He4BYg+Xs1Q0ZuPaiKyPCKeAhFLyAZEMMUFAdbxnN1U+FlPD1R+2
   BLB4lsMFuBDhSbU8sKXymy978+MZR1w6d+PyoHPS5q7Zza1qiF6rD8Wqc
   g==;
IronPort-SDR: cXtQ53VjUP41GXtUT8+jNo5zraZPdJtkE3DRNptd44O/z5JoI87cX/K0MNNYcpjTBJfcVrpcYg
 s6pXqRWuoF42VPN8sAL1+KLsEepAI9Z4TSdAfpZyb38yiHMGAlTlv/HKbQp/0RNCGt59bYpJRi
 FhbXwtc9zSH5cr6k2VxeDP9zf1himMI9jecKn6wKS9zRfSWkGvppsVcTOEEwvNhhRAH0oegfri
 a91gVa7lh4/Ka8vTEGw8vAySllyq/gvY10F1PR+fK99kIrWYwGFdmabYx9I/2/IyFl6zP9bm//
 EBs=
X-IronPort-AV: E=Sophos;i="5.82,311,1613404800"; 
   d="scan'208";a="173265894"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2021 10:55:33 +0800
IronPort-SDR: IhXfFcUreBwGD996aGaBoqbZnsdjGP7DXGGuAWS7TxDrLgMyfRhoOOKmQxifj4009NABjS3GO7
 /iD9aS5E9X+vk8rROSyFdPN6CQmS/spVZ1HpBWQdY3+OQHIC8i1IrmDeoX67jj0UIrdRelLIgy
 oe4JA2hwMlJOmx3/VvQIAdROS0wHnkH2TvF0Wh2tXZBu6QnLSP5Ixbyz15wDcN5U+w+5eLN0xv
 ij7D12myRB4QBjDP8gTHyKGEcLzR7KBtGJVpU6UP4yXml7LxMxo4HAd9k/D630LgPwq78fkSdP
 cFLlln1M/b/YxaVh3FqQ+qk6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 19:35:13 -0700
IronPort-SDR: 9QM6sLf0b8XHcEBsjPanwKimxiG2FUfJgW45SQ+uT3Hcy6oXqx8Yf5xX761X7A2hSpq7ffIQn/
 XcAU0a0dQ16bebCHFZ4/elLaf+MVv2pexH+fqiNzaGIMKLWI9gyQu+E3jKDrSXgOfz8hVUaQ7B
 aG0Q1DoK+WauGjOU3e/hbGU3ZLnJ2go+XYuauwt0wAIJXLyoa2of0OeiNnwkp6gFFKnZhmzHSZ
 Tun2aj9/fC2iqEC0fmt+AAa2HK0mcMZ3qiN2e7hSGw6HEc3RlDYYpYYPlR5/EUqhMyWCPv50MC
 qzw=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 May 2021 19:55:33 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/11] block: introduce BIO_ZONE_WRITE_LOCKED bio flag
Date:   Wed, 19 May 2021 11:55:21 +0900
Message-Id: <20210519025529.707897-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519025529.707897-1-damien.lemoal@wdc.com>
References: <20210519025529.707897-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce the BIO flag BIO_ZONE_WRITE_LOCKED to indicate that a BIO owns
the write lock of the zone it is targeting. This is the counterpart of
the struct request flag RQF_ZONE_WRITE_LOCKED. This new BIO flag is
reserved for now for zone write locking control for device mapper
targets exposing a zoned block device.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 include/linux/blk_types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index db026b6ec15a..e5cf12f102a2 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -304,6 +304,7 @@ enum {
 	BIO_CGROUP_ACCT,	/* has been accounted to a cgroup */
 	BIO_TRACKED,		/* set if bio goes through the rq_qos path */
 	BIO_REMAPPED,
+	BIO_ZONE_WRITE_LOCKED,	/* Owns a zoned device zone write lock */
 	BIO_FLAG_LAST
 };
 
-- 
2.31.1

