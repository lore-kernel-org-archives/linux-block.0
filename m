Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02855C433B4
	for <linux-block@archiver.kernel.org>; Tue, 18 May 2021 10:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFB77610CC
	for <linux-block@archiver.kernel.org>; Tue, 18 May 2021 10:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhERKqD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 May 2021 06:46:03 -0400
Received: from mail-vi1eur05olkn2078.outbound.protection.outlook.com ([40.92.90.78]:4334
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243964AbhERKqB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 May 2021 06:46:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eooGnCFbb8fvNdFCNIT6QpQaqh8GaSNmFZIqRSpOaK8dSlRsGe8xeBVzyEhXPza4R6b+zFFU5ShYjrkzGE103z9vkKSuprgih6DlX4zkJiaizcw2rvnZrOTORJpDOcyA9EBZ0vU5a4Y23M/1loXMQ/8g0knpEZjTXINXhcFgy1enQrXdqClOuNsmy125jHJMHZVS6S1xS+5d6aMMX8AGiDZV4B5Q9IIhDpPvl3WTxuWZL6kxL5eaiBJY/TI+NgckC5kockNXKR3ZPNVhXX4iMg90pnNQQt2+4HO1/za9vBKA0FvIwY1mEJO/NJwgf5s6xvx3s1UhrrnP/Mr6bYIZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3RG02hXVvGDJtt09qzjuUVRKJz4vrf0lbkdyWkuhYg=;
 b=hnfFw8UgziBDicc5uxldKCK9cpY0HWIaXpgY50XLUN2CUqT85C3jj+slttz5x3z1sBMZm1u2msylORyPaJiITaq1e2pwziSY85QbJYTYdbE6Rovi60g/U+Wi4FF2Tgh9XL2gAZUnGeyr3iEpMUso9CKwHf6vFpwuir+rlRIpFv1tD52o5k7iCwflidSSgD/SA72utZdAadfCFP1kldfORiRHky6x8rWcKh1RFF4iMCIaHh7pzxNZylBfUZJ95HpRaug/0O0n9MWQLcuzGlu6OPJtSZQDt9YvoQjkgroHOQBj5k4bgAGFe5RoGPsnLDac84nhqwFOmzywWrn6Tb8LuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM6EUR05FT048.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc11::45) by
 AM6EUR05HT182.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc11::130)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 18 May
 2021 10:44:41 +0000
Received: from DB8PR01MB5964.eurprd01.prod.exchangelabs.com
 (2a01:111:e400:fc11::41) by AM6EUR05FT048.mail.protection.outlook.com
 (2a01:111:e400:fc11::479) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend
 Transport; Tue, 18 May 2021 10:44:41 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:AEFD4423A401162E778A016753EF68026FD31F9C570416C1078C31139E6D922A;UpperCasedChecksum:3C9A26CF2AFBB3ADD1708266DF01049EA8FB452E0A92DEE129F16C8E482FA72E;SizeAsReceived:7538;Count:45
Received: from DB8PR01MB5964.eurprd01.prod.exchangelabs.com
 ([fe80::c4b2:4d8a:6f76:92c9]) by DB8PR01MB5964.eurprd01.prod.exchangelabs.com
 ([fe80::c4b2:4d8a:6f76:92c9%3]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 10:44:41 +0000
From:   Luca Mariotti <mariottiluca1@hotmail.it>
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Mariotti <mariottiluca1@hotmail.it>,
        Pietro Pedroni <pedroni.pietro.96@gmail.com>
Subject: [PATCH BUGFIX] block, bfq: fix delayed stable merge check
Date:   Tue, 18 May 2021 12:43:34 +0200
Message-ID: <DB8PR01MB59647C41BF6C964467EAFE0D882C9@DB8PR01MB5964.eurprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [JTYmMSWLhSXfhtpJCAFY4+dThY1pqlX+]
X-ClientProxiedBy: ZR0P278CA0049.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::18) To DB8PR01MB5964.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:ee::21)
X-Microsoft-Original-Message-ID: <20210518104334.3573-1-mariottiluca1@hotmail.it>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from luca-HP-Pavilion-Laptop-15-cs2xxx.homenet.telecomitalia.it (82.52.108.137) by ZR0P278CA0049.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend Transport; Tue, 18 May 2021 10:44:40 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 45
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: f3825843-339b-4c3e-2b03-08d919e9f098
X-MS-Exchange-SLBlob-MailProps: CaK+F7me6ClC5amMR9yXfP1hv5sNhc7zeEXdgikGLSYiLZpa5Osw8bybqNB5O43mfQpBhIu3YjRnYAHh/H08TthS/tJYsLPfcnoH8pUmsLbUbaqt1BJyr0MJcQ1q8c74xJM74l/fU7f9JvntYdgwxgkCHJZpWPza6jKDig+ScaVSjYQbzea9QTl9soObo00b/WM/T3f8Xasl+wmafNiPrTP686mQ49Ezp1K9Jso2UdfxIaPFPyPRTwSWwAnuUZrZKKsI9Unez6GCETv9WpQZgiycub22CFRjpr2yKlKKnqp0zKkUsB7JddilDSl5xyi1M7t/CK2a/19HKS05FRuKjYdGlRubZ66bh/LPzWbziYN26VoV/whL17K89NIMHBXFGh1EIHNqp5iAjayDABaRqTF/5sxCtuwu8dYbX8S5vbIFHvZmHiozEf777vj+JZHFLaHVvGOfyKvEFAFuhRrXvfj9CyfRUcOgSfy9938O+Lad7kQLbu5eOhJRe7ZfD86GkOQhJCYGujsLag01trkmJIrJZVTaEm/pWGFvOl/rcQ1Q2orWRuQGAgPyXOCVMtMQLHrFNa7tfpKtEBNsVP2NWHfxz31UFP7EpBPzZeMGBtrCZ39Y1BJNY1hM2aQ16ygmM4ZstbrMfAcSmtu0zVcu86cBEb1d4zZ26+nEcy9BvEML4u8mL0G7SyoQUQ+rvuolDLc1+HO+FcdawAdeaj6iEgX9L3Vt8Gu/lJm88byPIesevDxTSqtM6w==
X-MS-TrafficTypeDiagnostic: AM6EUR05HT182:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rjn5qsyhOgybeTDDq9zwMvq2PrP6AEbOnTspy0Ih+eq6BqpHC0eQHfx0CM65pI7A0Iskpj+yCRfiN0SnlR3vPvJvH8otbsK+yFWMiF2q6Jt1wMS1Fj3/rkxQ2ZFBSufSn4APEoWFTJN9vcbdw/KaccZ31FvbX7uC0mwT0LE+zto8lBarjuvdgBJr/t45uO6IHN09CYvvWWYaa7JJ07+YMFsxeVbpMX0xT3Y7GakuS1GEoys5YyU28l+PmtA2f9iHcwk+fHM4nbsNCnYU1vPlWTGDNX9vKSkb6lKZ52CCw53QO34mKZvAw1pQQTB2/Pucv6IQQuBI9Kyc1Lpkj4yoom6BkCf0B3fxPl8uYDXRQx8a+BvJ20n2N2Gjpw33OdfnGXRwI0+uePd+lZxgxAWRsQ==
X-MS-Exchange-AntiSpam-MessageData: D6WeEBpJjXB7zITA8tDQoFl9p5qyQ8Jr8+WWiBnI1DE4Gp3/SPGPAn0jdWieWrv/9k1q6Dk4LLtnTA8+XUDQA+dwUDdsemCUCdd913RGEdAE2JoUSxe0lhvF7szMWlAqFKmSKgF2DaIepArADgH/rQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3825843-339b-4c3e-2b03-08d919e9f098
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 10:44:40.9941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT048.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6EUR05HT182
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When attempting to schedule a merge of a given bfq_queue with the currently
in-service bfq_queue or with a cooperating bfq_queue among the scheduled
bfq_queues, delayed stable merge is checked for rotational or non-queueing
devs. For this stable merge to be performed, some conditions must be met.
If the current bfq_queue underwent some split from some merged bfq_queue,
one of these conditions is that two hundred milliseconds must elapse from
split, otherwise this condition is always met.

Unfortunately, by mistake, time_is_after_jiffies() was written instead of
time_is_before_jiffies() for this check, verifying that less than two
hundred milliseconds have elapsed instead of verifying that at least two
hundred milliseconds have elapsed.

Fix this issue by replacing time_is_after_jiffies() with
time_is_before_jiffies().

Signed-off-by: Luca Mariotti <mariottiluca1@hotmail.it>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Pietro Pedroni <pedroni.pietro.96@gmail.com>
---
 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index acd1f881273e..2adb1e69c9d2 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2697,7 +2697,7 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	if (unlikely(!bfqd->nonrot_with_queueing)) {
 		if (bic->stable_merge_bfqq &&
 		    !bfq_bfqq_just_created(bfqq) &&
-		    time_is_after_jiffies(bfqq->split_time +
+		    time_is_before_jiffies(bfqq->split_time +
 					  msecs_to_jiffies(200))) {
 			struct bfq_queue *stable_merge_bfqq =
 				bic->stable_merge_bfqq;
-- 
2.27.0

