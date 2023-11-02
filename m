Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA17C4332F
	for <linux-block@archiver.kernel.org>; Thu,  2 Nov 2023 00:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbjKBAsF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Nov 2023 20:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbjKBAsE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Nov 2023 20:48:04 -0400
X-Greylist: delayed 1994 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Nov 2023 17:47:58 PDT
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FD4DB
        for <linux-block@vger.kernel.org>; Wed,  1 Nov 2023 17:47:58 -0700 (PDT)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168]) by mx-outbound12-254.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 02 Nov 2023 00:47:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gmpvgcfa8nwZPEjtz2oX+c3UnRIqG51y+AaHQUfKpqgKShprD6WKbenyLTxvX1pqj+c7mY/GvC8SBTd5PNMrhpWYZbRSOSNgs5b4722+3I57eXKcayDWXojlB2XPdea/+s2+VkVkvlPEQWKLIlMJe97GdH/lRlOUvWETc9KHOP/l3AqhnsiNjNMvBLbGN3fmAG52ONAcBhGZApGcMC7L2TlVCJk2mT7cIdATvAJxT7f+FmMY3ffhR/ZIRXhk/v6K/Lv/4B/LEM8RLP+SISX1Op4AAYxBSt1CWggc0jLUpPBOxir4CaPT955ndAMzF+LrCMKAGG6Kk5nqqldTNCaYZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imL0tRoe4o69+kHLt9ssdP5f4ZTh0nWl5RVozdU/p8M=;
 b=FtI7yLQyI7yzl5L9uAptZau3hXXlixfhc2SstFHCvSgkL2vegmcKr7TJt8CM0X8fDQ4FMhsuSpfg32mNNPK8t0rCPfOwi71qoPMDFlz9tf3lJCcvHHf50me5M4HuAFDO3HqgdNorSHCfKsTZCNOeJiFEBA+m/FP6dx4xXgpEV0YIj2YRfSkT/dwU9OIM88O4Wt+lxeyhPE5qTKN8ed6gi9hXLU3jKSoDqI3yrc2PsVlF46I4doIu3W2EPdKg7uhhL6BbxvDO7Mz/cUkcnPtPpaneybNVcH5F2Qp8a9EgqzgcvPpMoUCOLZVbH+3GlCUlmAP8BJTvvw/xPhfi7WrpIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imL0tRoe4o69+kHLt9ssdP5f4ZTh0nWl5RVozdU/p8M=;
 b=ORLdktWiChRi67Ghv5XbJIhB0j6yXtJrwIC62xzR9zA7xoAM5hQuxERQGkBvxA3/yLYLVSaKAPFGDHQ6WVQrFdsOefaFi4smeOjiO+YqtQn94YPLKi6XjbgSjs0SvsLWU3ZqK8KlAvow3git7TX3BuR1R8qHoTYIpaKJlGNfOz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DS7PR19MB5711.namprd19.prod.outlook.com (2603:10b6:8:72::19) by
 SA0PR19MB4603.namprd19.prod.outlook.com (2603:10b6:806:b3::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.19; Thu, 2 Nov 2023 00:14:37 +0000
Received: from DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::d7a0:ac28:9211:7962]) by DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::d7a0:ac28:9211:7962%7]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 00:14:37 +0000
From:   Li Dongyang <dongyangli@ddn.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, adilger.kernel@dilger.ca
Subject: [PATCH] block: add SB_I_STABLE_WRITES to bdev sb flag
Date:   Thu,  2 Nov 2023 11:14:30 +1100
Message-ID: <20231102001430.385337-1-dongyangli@ddn.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0145.ausprd01.prod.outlook.com
 (2603:10c6:10:1ba::19) To DS7PR19MB5711.namprd19.prod.outlook.com
 (2603:10b6:8:72::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB5711:EE_|SA0PR19MB4603:EE_
X-MS-Office365-Filtering-Correlation-Id: b3131166-6c44-47e4-6064-08dbdb38b29e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ez7qxhf73dp9/+DOhQBdBIG744JJsm/4FFQi08xNuJhWi1N9kp4H8fKfETNhF54frea4HfLnYe4cO79+kA7IvfNad2IycAGIPnW0qKJETnZKB/jO6A2rJoYInVR4r6TuG5y88Kl5UrdZXZaROhEQVC18KOaTvKeopStwbWrEZL54T58kXa/JU9n4WhH/X4ds8Ny50eaFpXfIys6cQOXs176hZ9fHo61SffwYWukJ1w+r7IBDMqN3C9az9BwrI8YsL7UM/+qY/D0VUOSTIb8sxWE440DumRpUFOb2NaUFAi6Y7njjORuaj7elgM+QKoWHVDvCtUj+T6+uDhXY871NhUHejJFRg7GN6o/I//dpwn0qzmK+lxQeX0E3bRXr/sGGjrB+ccp/8Vb4mwRqjwrza0kGefCGQHfImvAZ19IjhEMqVtRiHeSbCHAKyuQ7GFwzX+lZKv0nz91JKGK/Dvcgf/ZRW2gKducitRqntRtfGBvlIlDLXhPmsC2rDt8KPjLqYcXGYf7Z6QZKxYOEsFjU+yadcWHizzmZrTjvQ2eg8z6nXXkkAuMB2jud6ceSS6pA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5711.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(396003)(366004)(136003)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(2616005)(5660300002)(1076003)(26005)(6506007)(6486002)(6666004)(478600001)(2906002)(66556008)(55236004)(36756003)(66476007)(66946007)(6916009)(316002)(38100700002)(41300700001)(6512007)(83380400001)(8936002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jJUOAn7MGbjt8O28oRwYZIXFjJsgXvO/PlAT4onJYnItoMVf8+qKyq4R+z7M?=
 =?us-ascii?Q?Wx7oqKbCfDXoU14EPDvEZwoZtOMUnMdrj/td0QDK+IUmjCs9sWmOEEaiYzT2?=
 =?us-ascii?Q?H1MXk7BR93cSd2QMw/2nX3A3ni/g7koNTUGEIUMFro3FoMsBoi89uVUoxJHJ?=
 =?us-ascii?Q?OSFQz3QET8lPnKxdx+9BklAbtW3YKVByL9IapTjAIIEcDY9D/BUMQqhU+FO3?=
 =?us-ascii?Q?p4YhiPq5hX+MCVFc0PsjPJGrNqcIkSKHqzqmdO+1G7MxkukjQQCCRGO5HGCZ?=
 =?us-ascii?Q?FDEwTo/5hoKjaLRiJeQ/GSNMvEn/l4INej3R2BkFUAufyTdld2uL+9Gd90nP?=
 =?us-ascii?Q?OjTvCQLt7c5jBPNOubAKdn2vCWlkop623qnst30li+1B5qpfdVrUoPApHPzv?=
 =?us-ascii?Q?IH0BsPmwDfQbyoR6hC+xn5iv5nDKNwVkAt+TyPRrwNRB/FJX248kOPDft6qM?=
 =?us-ascii?Q?pxmb5Qy4o/isk8BOLdXHicO0XkceLAKpufk8vGIS7Hvej5ajj7HO3QC75BMN?=
 =?us-ascii?Q?kKrUXbFG/mKuiscPtDhgVwR5OmUCpbuf+/e/I7CTugHDlkOsI8n5A5ud2kIy?=
 =?us-ascii?Q?kQsHZ8mg1reCpJCBZLrG4pDtkQl0FVOeHhkggY1u5OeFKGuM9DiJn4beCl+3?=
 =?us-ascii?Q?qW5oIMiGFO2c/DLVmYHY/+j+tIDsgrIGUKSJMrMPBXcuwGJXt/WEhai8plMm?=
 =?us-ascii?Q?z7CT3X4JyU50f+N5f2L9+dIg11F+hkFLjfEZ8xNrvUtP+OMn4Q7cLJg+m5sE?=
 =?us-ascii?Q?fASeM+x7G7uqi3fmgPD/0PvxKhNHBDAvQEliwSV1jzTZkMc6D7sWpxD7ufrp?=
 =?us-ascii?Q?hdQj0pHyutbngk7Wh8VmJ4iILWeLIn+uiGfVA/kATxJ5TtnEddCvSSxdBR5O?=
 =?us-ascii?Q?6ypzJ/z7B1YUtd6w+04lcgd/zaqtkyPpmnXsYThsZ0jMy8akmqSf1l2vCZlo?=
 =?us-ascii?Q?lHlMMpdCHztGbjDDCDVOFFKvZn92HNKqwNPPrGgnbgaf23vX/5681YfXImzp?=
 =?us-ascii?Q?NEMsHxc7gDHJfhq7MFrUsMxEr7NJq+hCAqKiMx4vg9UGeRVeh1XY4Om0Tyxk?=
 =?us-ascii?Q?KIUZfN/5p9XA61B0LZ5BhoGm8zaNVOFCCwEwh7J6u6hF85LR2fvWCDRxz0V6?=
 =?us-ascii?Q?nxc7pYoJbRgi+DsXeuEKbhOgplK072sVF4wMEOdltDXDdKqNTy3LEma/w/wT?=
 =?us-ascii?Q?BbOzoM6De1u+bwWxp/TTQQjwPgErwr1Ds5qXoWAPDFmrgKjnudcUxUyPUQwz?=
 =?us-ascii?Q?dxoXjv6UVlw8X9Jm6z29SxWzV6Qy7oUwOsCKavNONKnxYvok62JTQD4zUZck?=
 =?us-ascii?Q?CU+huTHLNpLRxdv/xFSywVm1UCN1HvUMS5ie7VNkwmZo9WHYbCP8UTsq3fur?=
 =?us-ascii?Q?TdgrkCuilAWRHjnOe8ayQYGS/LLES/4NqioBVjpmzT9BJU0vXO3Vxyisu1AC?=
 =?us-ascii?Q?otVHDXW2xjE6aZZb9+wIyqmko0LusHb71PZSz1Gaf72Wzq/JHsWq/zXBiebU?=
 =?us-ascii?Q?7DQAt/S4GCsFx/jri9NJnwDkwNNOlt4VO3aWIb9EpS3SfVj6O2Nxz7Mxg941?=
 =?us-ascii?Q?6J+EZbc46tLQPG6jND8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ULI4i4JBovPrX7gXOHXY3mVScQIoK2W/FuSD5fNf4itCt6eL31d1GvsNMJn7z4Kwn8tOm9Dujq7eWL6vouDZM2L5U4qB5K4tMDf87rqne/UJmcu2gu1PLTXsjsvKinBdTrA4HYmCTpE9vdUyTuCsLU6vXNNE0MHM3Tkq91bG6Z41C3geWp0JyaKUdWCMzfLgxI35VhelRgNwEihOn+mP4gHUP84HtYQY6x7zYdKkPZ4rG76sQjFLGht6RFtufLKXHmZppZwUZtf05Ql0KlbzsVqPx9Yyd2U0t2B6o0qUrrHTjEj+JyIx6Z40OcEqb+LyhJ/9u3X8KL0U01o9awCL2wR4uzBsCmdrpSixTxfZgMEiJ3rIpkkqDenE5g1XDRgIFJza59CEUXlw9ZFGZuIoMwEcbFXYgtqvBBfH/ncNP+6o/98CGfVG1V6kJeV2DJ7ytGzkW/hYngAdn4y8gqJOeFvLkf8tiXzmvbievNDp6M+rSCp4SbIlPkygHAP13bZyeCejkX3rDa06RdCeMAZUAeW6wDV1cwdDnGt1bMV8oQenveCCy31+uApEGZkxTZaHsmL/3Jy6+H61uhtAX7r6rqOlCYqdU0Xs1m97CSONGB+C5kxUZUSdMXPw7PCR+cFac6YGI7L3Xu+VEppELHlA+lC7CT/GpEI8SGVhzymc0OkTL7r5H9ESKlmPAEDpRxYBeoJKTbqsbdoUMk/8Kc2FVovTZVThtC/cBB10lHf/ahIZOfz/k6YR60hLnkzdb6Ry5kRGC9wVBbFrQBzrxCk5ZstFpXsDMNkreyRkhQsAea9jba7BFq20yPweEKpP6LpMSOu8LMUr+wuzQ5ziBOR3aXvMDZWtQtDkzVU8wUaOwWQ=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3131166-6c44-47e4-6064-08dbdb38b29e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5711.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 00:14:36.6397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3pJmf5zhDppnFr4VztrEM7nx0hQf+Nh8vzD72ms6btt2nxya27wEqyfE/V4JDAK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4603
X-OriginatorOrg: ddn.com
X-BESS-ID: 1698886076-103326-12361-17186-1
X-BESS-VER: 2019.1_20231024.1900
X-BESS-Apparent-Source-IP: 104.47.56.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaG5gZAVgZQMNHY1DQlzdDE2C
        AlLS3JyMg8yTLFzCjV0Cw5LdnEOM1UqTYWAN4nmuBBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.251846 [from 
        cloudscan19-60.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

wait_for_stable_page() now checks SB_I_STABLE_WRITES
flag on the superblock instead of backing_dev_info,
this could trigger a false block integrity error when
doing buffered write directly to the block device,
as wait_for_stable_page() is a noop for bdev and the
content of the page could be modified during writeback.

Add SB_I_STABLE_WRITES to bdev superblock flag to
prevent this, one downside is we now wait for the
page writeback for all devices doing write via bdev,
regardless if stable_writes is required or not by
the device.

Fixes: 1cb039f3dc16 ("bdi: replace BDI_CAP_STABLE_WRITES with a queue and a sb flag")
Signed-off-by: Li Dongyang <dongyangli@ddn.com>
---
 block/bdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index 2018d250e131..b1536f069aba 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -350,7 +350,7 @@ static int bd_init_fs_context(struct fs_context *fc)
 	struct pseudo_fs_context *ctx = init_pseudo(fc, BDEVFS_MAGIC);
 	if (!ctx)
 		return -ENOMEM;
-	fc->s_iflags |= SB_I_CGROUPWB;
+	fc->s_iflags |= SB_I_CGROUPWB | SB_I_STABLE_WRITES;
 	ctx->ops = &bdev_sops;
 	return 0;
 }
-- 
2.42.0

