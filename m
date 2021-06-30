Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C95C11F65
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 11:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF7C61481
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 11:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbhF3Ltb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jun 2021 07:49:31 -0400
Received: from de-smtp-delivery-105.mimecast.com ([194.104.109.105]:26019 "EHLO
        de-smtp-delivery-105.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234148AbhF3Lta (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jun 2021 07:49:30 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2053.outbound.protection.outlook.com [104.47.20.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-29-sKloBjCBMeCVMqH8IGB00w-1; Wed, 30 Jun 2021 13:46:58 +0200
X-MC-Unique: sKloBjCBMeCVMqH8IGB00w-1
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:89::10)
 by CWLP265MB3217.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Wed, 30 Jun
 2021 11:46:57 +0000
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::259d:65ac:ae6d:409d]) by CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::259d:65ac:ae6d:409d%9]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 11:46:57 +0000
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
Subject: [PATCHv2] block: prevent sending events from removed device
Thread-Topic: [PATCHv2] block: prevent sending events from removed device
Thread-Index: AQHXbaWhnC4F2rAZIUirytfsa24BGg==
Date:   Wed, 30 Jun 2021 11:46:57 +0000
Message-ID: <CWXP265MB2680C04F5A68F11BFD36F441C4019@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
References: <CWXP265MB2680EBAF4FEE64FBE80FAF25C4019@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <CWXP265MB2680EBAF4FEE64FBE80FAF25C4019@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.80.168.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55d5ea2c-af7b-40e8-9345-08d93bbcc41c
x-ms-traffictypediagnostic: CWLP265MB3217:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CWLP265MB32172650910288D2A5592F52C4019@CWLP265MB3217.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: S6zR9unI4IDFjXNAj2UeLEuBzoVv18J6PgP/QJTUdRWkLm95YJ9+7QUggNe4MtPA3CHJtkRfempGwbsFqSWr27zllYBoslNwhnmB/ZpsmPHKZCZXpVgH3otqTkRPrDkfjPtMsvN3ow+z7PT0k2OPZvWfnV9BbK9FVqkKUzgNBX8Go3i62rulfn6TtspGyPMmr9NTTjo1JeMwah7bjSAKCVkWGgoSzEr9079+lPI6xynHzDnTzQBuquOGhxXj58mA/G/WIjBDYe5PeLVlOM1rkqw85lJPIyPgwM5OtvtsbL02QIamt4AR5fWylR993aSmqKbJVsr7/TxopCr2O02AMpOTKXbPPySjWfN03845yWnxx7l855Hqh3vMxLkWYeeTlEu0a2dFUlXwNje4intMtxRWXqS4d9acnhiCeW3p+3X5EVdqqOQh9GLJ8fKHH4uGjyjTlV3RWPMIHYqv0lbBlVOMEYztps6Jln9UGY++e2/2TJJwySjq0KzeK9WAE5kTr6AxwUbmQIz0d408rmNsoPTArIwzSVsczDmGDasjknq4d0d68HYH2eF2xD2NW3HZ4uxcK5GbI+oSlT7nnOZCQQYyhyAoKOxSvLJOZSyD/PDzwoYHrwap+YeP/OjE3R07nAgRHPMDX7pfjUivYL0TyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(39830400003)(396003)(346002)(83380400001)(55016002)(9686003)(7696005)(86362001)(33656002)(5660300002)(478600001)(6506007)(26005)(2906002)(110136005)(8676002)(316002)(8936002)(4744005)(66556008)(52536014)(66446008)(186003)(38100700002)(2940100002)(122000001)(71200400001)(64756008)(66476007)(91956017)(76116006)(66946007);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ctRuNUabVCMoO0BSirzlXkMsbnysSoxO+0U4I5Osbeebxw1O2J/LIWvzFT?=
 =?iso-8859-1?Q?srop+cwLzVl5cQ3OzX76H6OQkuryDqOQr86x+FIgkFMpeMgwLs2td/I2nj?=
 =?iso-8859-1?Q?E8+KSqBOk+TQpepASebMdbxmDSPIBC3tnNeCcb5YrBa0KOJjQQtgc+PI5j?=
 =?iso-8859-1?Q?ObFGFp9rwzy59GOHkCMx8R12XoJyUG+DWuhNUPZNIo0iHElioO88SZPYBQ?=
 =?iso-8859-1?Q?cuP2CS+Lgu4UFsTjk38eumKq6mZZCGrxMBgZ/W5gteArfG+lLwcvv2gG8M?=
 =?iso-8859-1?Q?yF5Rq6yT9tEqFNOb3ylcb/aH5OcRGSzY0pLbY59ikSUbH/jToAi6NfHGg7?=
 =?iso-8859-1?Q?5IASrPOWZPIFCwnzwOenLKgTweV4VzQbN0JlZmXv6cflYemM8tyU+jwfvD?=
 =?iso-8859-1?Q?qKC+NQ9paSVqSHtY6NcIosorhO52svNNN1d2zp2DE3xO36prMAuxB34pi7?=
 =?iso-8859-1?Q?VsorIxnSReep1Sg4y4bQUyGJ8R71ptD6vdRyfRNqrKs0vHIbR2o0KeGRXV?=
 =?iso-8859-1?Q?suymRb8BC7FMDZwtRdGScle9F9p4JQdbT4DVB5G6GMItDFQnz37wWz1GIg?=
 =?iso-8859-1?Q?amFy90OBlKhV1M8Dc+RhwKAr40DYZ3eutYs8gkxQ/bp6cGOAbsKQ45jg2C?=
 =?iso-8859-1?Q?T/qE/TYxXX98qOeALpjCAd+XfKb6913hHRLVFe3MWkOQSVjcjle+9e2qmw?=
 =?iso-8859-1?Q?Iy61EKuuBPiFXPxRV6ttm1oXKHwDOd5WMswTot7GNL6aYVoeHT2JnIKyd+?=
 =?iso-8859-1?Q?cA2csRAhP2ORw7VOnhpXN+pBu60oWvqVW6qZlidPCRmnegvucBcV1/THCz?=
 =?iso-8859-1?Q?+tGnlX8Y5DKiM81XNzc1ajQrRusi/TdjEKFLiMdUVAv3AsKesVeEyERGCA?=
 =?iso-8859-1?Q?nKc/Fk/qi4N+oiRWUv1W1RNmQX/WvGJL4sCBo9hy0EZ22eRCOoQbyH+7cI?=
 =?iso-8859-1?Q?nVwTyHPLXpvAOo1K/KZc8x3rZ4QjWB8ws+u5HHT/pxH2AyA/BEn/e19r9V?=
 =?iso-8859-1?Q?5shw98e+XMOqJhiPDezgsaDgt9JVrBcsOc8qpxG270CTtBYU+UVc33x1Iz?=
 =?iso-8859-1?Q?q2qkBUizS4i0saFlBJMEXtcxjhrSxmGso7IgJpBI/spMsbUnCQ0nI+YtyD?=
 =?iso-8859-1?Q?UcPqXCO9hnEXKcOJiDU7rGbQ7JJtQrtk57m+muFLc1q2Yruey5J2qiKbLP?=
 =?iso-8859-1?Q?I/vnqgF/UXEYEJOAjV2i2tPfvIfZoW2vHI/DdCocQxqnVti3FFHJp6yvDw?=
 =?iso-8859-1?Q?2n7vjL5RGZrVxgr9jePJONE7P72V17bDnb2teO/Ur3t7Cm6QtaWUxyW8Va?=
 =?iso-8859-1?Q?Eap8Akwd4I9e9SR5FPykV0JnASSKKnQEm/Y5fECERVAN1rs=3D?=
MIME-Version: 1.0
X-OriginatorOrg: hyperstone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d5ea2c-af7b-40e8-9345-08d93bbcc41c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 11:46:57.8538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f203eb-e878-4188-b297-34c118c18b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Z2qen/lmKcH4qJ/TAwCfedKChTYvAZhtDaENUqM2TJQjzE76hUsdRqTkF5iJ2/Zem/f0rDF8wfoRpP/YhuQHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3217
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE5A68 smtp.mailfrom=cloehle@hyperstone.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hyperstone.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Skip kobject_uevent_env in case the associated kobject
no longer exists, as calling kobject_uevent_env with
NULL is not safe.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 block/genhd.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 9f8cb7beaad1..46629fbe23ae 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1655,8 +1655,16 @@ static void disk_check_events(struct disk_events *ev,
                     (disk->event_flags & DISK_EVENT_FLAG_UEVENT))
                         envp[nr_events++] = disk_uevents[i];
 
-       if (nr_events)
-               kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);
+       if (nr_events) {
+               struct kobject *dev_kobj = kobject_get(&disk_to_dev(disk)->kobj);
+               /* The device kobject might have been removed in the
+                * meantime, so check for it first.
+                * If it was removed there is no need to signal events
+                */
+               if (dev_kobj)
+                       kobject_uevent_env(dev_kobj, KOBJ_CHANGE, envp);
+               kobject_put(dev_kobj);
+       }
 }
 
 /*
-- 
2.32.0
Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

