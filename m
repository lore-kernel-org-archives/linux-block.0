Return-Path: <SRS0=1fuv=XR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD49C3A5A2
	for <linux-block@archiver.kernel.org>; Sun, 22 Sep 2019 09:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1B820830
	for <linux-block@archiver.kernel.org>; Sun, 22 Sep 2019 09:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="VMcCAgQT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfIVJjC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Sep 2019 05:39:02 -0400
Received: from mail-eopbgr40073.outbound.protection.outlook.com ([40.107.4.73]:13029
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727741AbfIVJjB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Sep 2019 05:39:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsfehrsfROu7VCyuXTrSKDxrJ0Z5y3s0mhm4LxQyKG12lSxSLYPB0IOtsbkAV1B6iD3QO9zrQ7kQRmyy/orUKsaQm0CKRlevEPk0My8efcFMy57oBjohR3MSz/OlsB4I7gsjzS74t9ouih+pBTl9IQPdsHaPBjk5/h4A+OCWm7kIMWxQjrtjldoIzslKMcftgU43gl1hF8OGVF92HtYg95SaKTyDZdOW/0IECbLacGaHvrA+v7nwMOx1axhaRzWGQvfcq4sVFTXdAS907ol1XQcajGAfqSoU4bPh6nzfGZU+0YTdod889eabetIaA8MnSO+2cGK3jfWnfjgd4Xl6uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ug//OF1Vdf7VVzMWcTTqWDG1xI6Xp0k4wCO/QDQP6W0=;
 b=Z/Tap9OJcErzpwtz9MMQAn0PMrJeq7j9THL5vHXxl6bvl22F5mbg/a4tL5yjHv9Gnr8htSf2k1VldF1RspvNuIE3XaeavmHeEXlT3QCW9+r2IPDD/qqlWhzJJcT2yEJaEmvJp0RdnTQRPt4oYKvxWuTYKGtUJlcACS4FDTE7oWT3jrdTBnfpo/pksN9xQsI4Vzvy6Z4KUeo2IDxJcSFkV9O7ziDu42pR0qovEx8XY+NXzK1shoGkQRA1bShExlDlz55C8oCxkIQLvjT4RljRaAX4u3cd4X5L/nc4jjtYR0zeMg5sDXrPpASuKe9LJYWKncCPVemhoCjASOzoJPVGgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=arndb.de smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ug//OF1Vdf7VVzMWcTTqWDG1xI6Xp0k4wCO/QDQP6W0=;
 b=VMcCAgQTyfOf2QSFSJTiOGBTWhs7JkdLUqETV70uFzNeCV2hFSvAmBAJ7480OgwbS6Zmp+7KMWw35TJt4Pe6AF+iybbBQQJwyM0Pue2ZEAaPOTN565AX7an1E3X7BuU7ze+bXjScoZ5+2vbQv/eNVRpYCgproqgOc+nyNw6fL1I=
Received: from AM0PR05CA0016.eurprd05.prod.outlook.com (2603:10a6:208:55::29)
 by DB6PR0502MB3080.eurprd05.prod.outlook.com (2603:10a6:4:97::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.18; Sun, 22 Sep
 2019 09:38:55 +0000
Received: from VE1EUR03FT061.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::205) by AM0PR05CA0016.outlook.office365.com
 (2603:10a6:208:55::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20 via Frontend
 Transport; Sun, 22 Sep 2019 09:38:55 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT061.mail.protection.outlook.com (10.152.19.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2284.20 via Frontend Transport; Sun, 22 Sep 2019 09:38:55 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Sun, 22 Sep 2019 12:38:54
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Sun,
 22 Sep 2019 12:38:54 +0300
Received: from [10.223.0.54] (10.223.0.54) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Sun, 22 Sep 2019 12:38:02
 +0300
Subject: Re: [PATCH 1/1] block: add default clause for unsupported T10_PI
 types
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     <linux-block@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
References: <1569103249-24018-1-git-send-email-maxg@mellanox.com>
 <6e99fefd-ff7c-e3ee-087c-ed42baa7f4f5@kernel.dk> <yq1tv955kfy.fsf@oracle.com>
 <a0505439-2bf3-3297-2e8d-5cc0b24cafee@kernel.dk>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <423a031c-a016-96c6-97ee-fb4e49a0f247@mellanox.com>
Date:   Sun, 22 Sep 2019 12:38:02 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a0505439-2bf3-3297-2e8d-5cc0b24cafee@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.223.0.54]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(136003)(346002)(189003)(199004)(50466002)(229853002)(186003)(81166006)(81156014)(16526019)(54906003)(4326008)(8676002)(106002)(70206006)(11346002)(446003)(476003)(2616005)(6246003)(76176011)(65956001)(65806001)(47776003)(8936002)(2486003)(23676004)(316002)(16576012)(478600001)(58126008)(486006)(70586007)(26005)(31686004)(110136005)(36906005)(336012)(3846002)(14444005)(5024004)(2870700001)(7736002)(36756003)(126002)(356004)(6116002)(53546011)(305945005)(86362001)(2906002)(31696002)(5660300002)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0502MB3080;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9795dde3-8426-45ed-310a-08d73f40afa0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB6PR0502MB3080;
X-MS-TrafficTypeDiagnostic: DB6PR0502MB3080:
X-Microsoft-Antispam-PRVS: <DB6PR0502MB3080AFA9A8478C20CAB128CFB68A0@DB6PR0502MB3080.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-Forefront-PRVS: 016885DD9B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: iLvzeubDzCOVTnspvnb5yrohcj+0VQs7ZheRvq6yxK/xZ1ercdzW8rhn6R0EiluoxUjjzUEX3tSy7Kw9GwbwZRvu+4DC6FnBy6HMwZVewnRQb29Dv0DS45FB8MjkJhuBbAhtvLfdWj17VX0q5xI1uLvMkKri+JrWRvXYwGLEm9lywYImmHZtQwFxWqW698zqDlUEB6VsyBWPeQVCCGenZJ2//DL0XLeoo9oGCTUMallKAUv0p4EMGjOPMb7Y4gy7to1XGjGqKJo7ZQG/KbCNzsv2QQQj4704MIiO/EjJfcbUyc/r7VXInS/zJcx6TVg7j1jgj78iRNmq9WqDxy6dJ7mNf61poOjzg4YeLfEA57HRafNbY1Hsfblf/JLfyGwKs4WYMHzWbDUTljAwILYR/a//rZCZzCrA8zMNop3Oqs0=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2019 09:38:55.0640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9795dde3-8426-45ed-310a-08d73f40afa0
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0502MB3080
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 9/22/2019 2:29 AM, Jens Axboe wrote:
> On 9/21/19 4:54 PM, Martin K. Petersen wrote:
>> Jens,
>>
>>>> block/t10-pi.c: In function 't10_pi_verify':
>>>> block/t10-pi.c:62:3: warning: enumeration value 'T10_PI_TYPE0_PROTECTION'
>>>>                         not handled in switch [-Wswitch]
>>>>          switch (type) {
>>>>          ^~~~~~
>>> This commit message is woefully lacking. It doesn't explain
>>> anything...?  Why aren't we just flagging this as an error? Seems a
>>> lot saner than adding a BUG().
>> The fundamental issue is that T10_PI_TYPE0_PROTECTION means "no attached
>> protection information". So it's a block layer bug if we ever end up in
>> this function and the protection type is 0.
>>
>> My main beef with all this is that I don't particularly like introducing
>> a nonsensical switch case to quiesce a compiler warning. We never call
>> t10_pi_verify() with a type of 0 and there are lots of safeguards
>> further up the stack preventing that from ever happening. Adding a Type
>> 0 here gives the reader the false impression that it's valid input to
>> the function. Which it really isn't.
>>
>> Arnd: Any ideas how to handle this?
> Why not just add the default catch, that logs, and returns the error?
> Would seem like the cleanest way to handle it to me. Since the
> compiler knows the type, it'll complain if we have missing cases.

what about removing the switch/case and do the following change:

diff --git a/block/t10-pi.c b/block/t10-pi.c
index 0c0120a..9803c7e 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -55,13 +55,14 @@ static blk_status_t t10_pi_verify(struct 
blk_integrity_iter *iter,
  {
         unsigned int i;

+       BUG_ON(type == T10_PI_TYPE0_PROTECTION);
+
         for (i = 0 ; i < iter->data_size ; i += iter->interval) {
                 struct t10_pi_tuple *pi = iter->prot_buf;
                 __be16 csum;

-               switch (type) {
-               case T10_PI_TYPE1_PROTECTION:
-               case T10_PI_TYPE2_PROTECTION:
+               if (type == T10_PI_TYPE1_PROTECTION ||
+                   type == T10_PI_TYPE2_PROTECTION) {
                         if (pi->app_tag == T10_PI_APP_ESCAPE)
                                 goto next;

@@ -73,12 +74,10 @@ static blk_status_t t10_pi_verify(struct 
blk_integrity_iter *iter,
                                        iter->seed, 
be32_to_cpu(pi->ref_tag));
                                 return BLK_STS_PROTECTION;
                         }
-                       break;
-               case T10_PI_TYPE3_PROTECTION:
+               } else if (type == T10_PI_TYPE3_PROTECTION) {
                         if (pi->app_tag == T10_PI_APP_ESCAPE &&
                             pi->ref_tag == T10_PI_REF_ESCAPE)
                                 goto next;
-                       break;
                 }

                 csum = fn(iter->data_buf, iter->interval);

