Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230AEC11F68
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 08:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02E2361D06
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 08:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhF3ISd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jun 2021 04:18:33 -0400
Received: from de-smtp-delivery-105.mimecast.com ([194.104.109.105]:48530 "EHLO
        de-smtp-delivery-105.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232954AbhF3ISd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jun 2021 04:18:33 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Jun 2021 04:18:32 EDT
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2058.outbound.protection.outlook.com [104.47.20.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-12-Dc0_KYCqOtCL84aVUVYo6g-1; Wed, 30 Jun 2021 10:09:40 +0200
X-MC-Unique: Dc0_KYCqOtCL84aVUVYo6g-1
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:89::10)
 by CWLP265MB2580.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 30 Jun
 2021 08:09:39 +0000
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::259d:65ac:ae6d:409d]) by CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::259d:65ac:ae6d:409d%9]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 08:09:39 +0000
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
Subject: [PATCH] block: prevent sending events from removed device
Thread-Topic: [PATCH] block: prevent sending events from removed device
Thread-Index: AQHXbYcPaY+gyAaNCEO3EseEwW+vDg==
Date:   Wed, 30 Jun 2021 08:09:39 +0000
Message-ID: <CWXP265MB2680EBAF4FEE64FBE80FAF25C4019@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.80.168.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff1c51c8-8fb8-4e12-cf00-08d93b9e68c7
x-ms-traffictypediagnostic: CWLP265MB2580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CWLP265MB2580B15B543A557598E6EEAEC4019@CWLP265MB2580.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: dc5GgzqLci+Or4h5A27tJsXx+F034tg90MvyaZLDRzjIfsYcs+M/Ooesb4xwEVKU6ZtzZIXeSKkZUoCvEp59AmyY2yDDCnYid2/DPd4TYipAr/DDWsDzi1aZCLMdMoIjt3ijtoA5exXRBphAg2t9jAlIO5pAi0GAyw/hq2ywWaSc/D7AZruQWT0pbOnZvuuOZwrqLRyPo0JNabfpOTB++sRcR+q8TDvVTVs8NveWMhsORk9pptYyBigaq2WAR8dBIFZw659QR/rqTmt2eLnr3esFvNWR8AUrN8AoDSQ7C3Pd85jMubNGix/xrv99WcpoQ1zaJ5EqzroWwJQTEkoiG+v+Gt+EJ24PN7EWnPpCZEfeZEIz39OjiczMAmCIyueZ4Z/vSKi1cxRxsAbI6SkfzRl8828DAwab8Uj6OVJ8WMCPZjWsM8W6ywcbDzLV6e+z1tuvS7WYx/pulpR/rcZiUJUoHYEP1aClBE6raRxDYehGb2/KZ67/nkqHfjwE1mg4gjokWfbqIwnCsqzLXf5KV5RjS2FfqDVWD8X+d3GyuxUoikox2GcK98CXrIY0OZRdqJS8s1Np5kqAVo1kDGQQFgUcw2Je8YMl4kzpOu7pPVsBR9OCe+U6XBUV6Hr7URxHtiZglBSz1F3ciax4G9zfrg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(39840400004)(136003)(396003)(346002)(2906002)(52536014)(110136005)(8936002)(83380400001)(8676002)(316002)(64756008)(66476007)(91956017)(66946007)(76116006)(66556008)(66446008)(71200400001)(86362001)(6506007)(26005)(5660300002)(4744005)(33656002)(55016002)(9686003)(186003)(478600001)(38100700002)(7696005)(122000001);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2CJvUtTdhsz5AI7VMbEmn+HgU4ma90M921B/1K1wWFPbIiy8QS+GEOtQig?=
 =?iso-8859-1?Q?S2fCov/24tJwm64QLVsyjWxpDAAKmzHkVt44nY+QAqp3K9M9GacybJygHB?=
 =?iso-8859-1?Q?AeDe1kASdTKiGYl1X32xkTwfObxu+MwZOkpgwq+2f3hXnVOCdobXNI04B5?=
 =?iso-8859-1?Q?G0y1kZrfMaxJS/Kb5pZn5J6PRMlqE6+m+DJFax4apj5vRLzBW6ba+HhxIm?=
 =?iso-8859-1?Q?qDPwtIlqDjcW7OUfTegIcW7LsaeM20wTmtQO9eRgQTncuOEl6R5DX11zNi?=
 =?iso-8859-1?Q?l8ZiVmK/s9t+Y66mzDyBbU+YnQDdRwGGdPdj4oq285qvhjjIcFkDbL4JBH?=
 =?iso-8859-1?Q?5cZKP8QKlUPTA2N4MLNIJEXzAotPqhEmXbKh/UnHOwLsIFhle2lb1RZoqL?=
 =?iso-8859-1?Q?HKWTHgnqlmNrmZD9zNYmbw5VaDmJfQrSa6z7N70Pdh5txhZL9DpxwAW5OU?=
 =?iso-8859-1?Q?JcTbD5qxUInCGEY+5J7wlNsBbo8eR0WZC6OPk8yL1hAQp5d9VXFRJ+7c7v?=
 =?iso-8859-1?Q?YL1l9gXLFP1IfmPPIUOGslcR4V2QjuBKk/8MrXOL+sQUfSd4GEjnfNQC6H?=
 =?iso-8859-1?Q?ZBwsxlbo/U57uo2NoGZMut7a68lDtFmWrfyUQhOsWisZwAQp8/L2p2v8Rh?=
 =?iso-8859-1?Q?eleKPImnCaJAQyrOFYk9UZ2ae5KpWvzvyDdN4E5va1nOoL3pIIgJoA1VbW?=
 =?iso-8859-1?Q?DO283UoKLKPLnyhi2HgO8Op33LQ6PtFxXjOMc9C/T/A48ccwxd46dx7TwU?=
 =?iso-8859-1?Q?8mp8XtlFhsKYjINJNmH1AJOLASi7lHXjEGsj/Jq4GDXTafUN7rzitrpGOf?=
 =?iso-8859-1?Q?Kr3K0PujFkyrnZzsza+9ZDP/1GOigvPGA44R0UFqZP2f/WdRPiSptX86ya?=
 =?iso-8859-1?Q?fI8kvI33VV+yoIKmDaWKMeVat+XXQ7KkVgWZZxG2Ow2Yf5cFpvXxS0sMAy?=
 =?iso-8859-1?Q?YEjKuj6y97SN+FQ59bL+j8S9OLlT6LIQW7XAdIXKgWzZu8p4wmAysVVmsN?=
 =?iso-8859-1?Q?F/TRRay3/Nt+zDNH8oU8nMZgVd5iHQD6iasxP7R7Q0MtfnAJqxwK0vY5X8?=
 =?iso-8859-1?Q?ffg42CmqGf1+LI2KpOpbpKEwqA2dwwOHrr+Etx2iLG5W5ylU0fnGG7VuYL?=
 =?iso-8859-1?Q?PrVD52yWLPwwk8xRNSe02mKqDSUdVRs5xFW7rSYbG0LUYrluMxmQwaWO+f?=
 =?iso-8859-1?Q?Keb+rwVv3dQgj706zlvYbUZq1SecVBETvy0EjaqWkdzo7ttFq7CnQ8kxFP?=
 =?iso-8859-1?Q?VkMVc9vBI8d1Kd6RZr8ixFUILPrGiqwWA3NnAnkJ0WdDWzUGOqhw0+xQvQ?=
 =?iso-8859-1?Q?zkfiW77DZvdjPPK/m55k/FmO4elEKyXCgusv745oq5OLGP4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: hyperstone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1c51c8-8fb8-4e12-cf00-08d93b9e68c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 08:09:39.7317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f203eb-e878-4188-b297-34c118c18b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0vHi4OWiuLcZHP4bvmIuaxBzblSMFXbAEck3GmdfcAa19jZTqFDNakJ531nOXnwm4uH2GHd4fsfSB8COgmlpLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2580
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
 
-	if (nr_events)
-		kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);
+	if (nr_events) {
+		struct kobject *dev_kobj = kobject_get(&disk_to_dev(disk)->kobj);
+		/* The device kobject might have been removed in the
+		 * meantime, so check for it first.
+		 * If it was removed there is no need to signal events
+		 */
+		if (!dev_kobj)
+			kobject_uevent_env(dev_kobj, KOBJ_CHANGE, envp);
+		kobject_put(dev_kobj);
+	}
 }
 
 /*
-- 
2.32.0

Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

