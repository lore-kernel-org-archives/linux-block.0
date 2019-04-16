Return-Path: <SRS0=7JUc=SS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A69AC10F0E
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 03:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AAB32075B
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 03:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hNBwHjpa";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CWnXAIZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfDPDe1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Apr 2019 23:34:27 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:34814 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfDPDe1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Apr 2019 23:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555385667; x=1586921667;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TNKDPbVSOBmRy1vQS8AmbAESFKJCX/K79MlFXaNqRmI=;
  b=hNBwHjpalOnME7fs+CqFxJGzpx2q4IC7DZkmLVXp7OiUoB41O08KeTjj
   Fk+oFNK1TTBnECfOzDVGaUqJ2+rleKCIV+ni62vUtvxdILEpqDGus3gA7
   CM5jbFoleC6zpH5Z44uDw6KVphMreOhJ29LnDLXGjzL0WsVALpEBDPLDN
   8s+/uFValU2hOZF61I+IJ/+OzzEX7PZ5E598mOZ9ytbg3UOT3r5Z0CzCo
   8mRS9PQd8f81RZWtxrftvI39fcYBMkVRrS9Esr5fc/+JsxLIPYgq2SKel
   RO3rfdC+GAAbHrNXCsWPQMGhF2LGyDg23v6NmGhAUiY2rgV46gmi0skUk
   g==;
X-IronPort-AV: E=Sophos;i="5.60,355,1549900800"; 
   d="scan'208";a="106051810"
Received: from mail-by2nam01lp2058.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.58])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2019 11:34:27 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNKDPbVSOBmRy1vQS8AmbAESFKJCX/K79MlFXaNqRmI=;
 b=CWnXAIZvHUPqjK4n/SfeXXKz2r7y+8nNfgTZuxGgNr/pS6sF2yn3gsaSUiYPTzyoTC7DCItWzAE2HfiIy3j9GFHymoT7wf0E54JOQl1AlVm6MV+rHRn1fCuI0QmwhETI6dEkn11rBxE51UtiSrzLbQFeC5W+T+6L/oSvKCwLwkM=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4750.namprd04.prod.outlook.com (52.135.122.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Tue, 16 Apr 2019 03:34:25 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%3]) with mapi id 15.20.1792.018; Tue, 16 Apr 2019
 03:34:25 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v2 3/3] Documentation: kernel-api.rst: Add block/blk-mq.c
Thread-Topic: [PATCH v2 3/3] Documentation: kernel-api.rst: Add block/blk-mq.c
Thread-Index: AQHU9ARzz62xPEqQ1Uq8unW1AFA2EKY9rTAA
Date:   Tue, 16 Apr 2019 03:34:25 +0000
Message-ID: <861CA549-6044-47DA-80C7-4285688C0143@wdc.com>
References: <20190416032801.200694-1-marcos.souza.org@gmail.com>
 <20190416032801.200694-3-marcos.souza.org@gmail.com>
In-Reply-To: <20190416032801.200694-3-marcos.souza.org@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.17.1.190326
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [2605:e000:3e45:f500:a40c:71d7:63f8:b285]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 668f3735-bba0-431b-6f34-08d6c21c6c8c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4750;
x-ms-traffictypediagnostic: SN6PR04MB4750:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4750D537EA8E0E20BB5B62BF86240@SN6PR04MB4750.namprd04.prod.outlook.com>
x-forefront-prvs: 000947967F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(136003)(346002)(366004)(199004)(189003)(6246003)(14454004)(5660300002)(2906002)(6486002)(58126008)(316002)(86362001)(68736007)(33656002)(54906003)(110136005)(53936002)(4326008)(25786009)(6116002)(256004)(6436002)(6512007)(82746002)(229853002)(4744005)(2501003)(305945005)(478600001)(81156014)(81166006)(72206003)(97736004)(11346002)(2616005)(476003)(36756003)(446003)(46003)(102836004)(76176011)(186003)(8936002)(99286004)(71200400001)(71190400001)(83716004)(8676002)(6506007)(105586002)(106356001)(486006)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4750;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /ZUf1hHDcj0RuumbcWJGEMxU4nW77pGcDLeR2njeksAXHjkLcKThppRnXclMDHkVA+rHY3n/25UCNB8PXTrPfOX3TlrKaYuu1shCaznxzuV2+eagjOYS611FtBAvRm0LCCkWiEh+VytsczoU2p1KsNrfSi5cj835ANPijPB05Lb7tUvkaTBHZOmuGJlpfYgGVhdeSNzXXcaWug2mItqQXoS5nz3P3NHU9H3xbUAMHzmLA7S1smxZYXOvlZH03VP53dVG0EtSodKsyKyGzrw9xHC8+ya43fxtwXsjts1on6HI90Kv4bbwUm5kNMPRZXGwzkT7OY6SI9gsPLogYu6sdSfCvOi+H/iryFhZCZnqbQX7wxgR4uYpNM5h1kLeCvyI0DwbN3dk+FFZ3Nd8aK9WGb6rLYZZwqNVnKFp3wenYbM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC535CF2F30B7D4DBC00ADB79785460C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 668f3735-bba0-431b-6f34-08d6c21c6c8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2019 03:34:25.4378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4750
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

TG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8Y2hhaXRhbnlh
Lmt1bGthcm5pQHdkYy5jb20+DQoNCu+7v09uIDQvMTUvMTksIDg6MjggUE0sICJNYXJjb3MgUGF1
bG8gZGUgU291emEiIDxtYXJjb3Muc291emEub3JnQGdtYWlsLmNvbT4gd3JvdGU6DQoNCiAgICBO
b3cgZG9jdW1lbnRlZCBmdW5jdGlvbnMgb2YgYmxrLW1xLmMgd2lsbCBhcHBlYXIgaW4gdGhlIG9m
ZmljaWFsIGtlcm5lbA0KICAgIGRvY3VtZW50YXRpb24uDQogICAgDQogICAgU2lnbmVkLW9mZi1i
eTogTWFyY29zIFBhdWxvIGRlIFNvdXphIDxtYXJjb3Muc291emEub3JnQGdtYWlsLmNvbT4NCiAg
ICAtLS0NCiAgICANCiAgICAgTm8gY2hhbmdlcyBmcm9tIHYxLg0KICAgIA0KICAgICBEb2N1bWVu
dGF0aW9uL2NvcmUtYXBpL2tlcm5lbC1hcGkucnN0IHwgNiArKysrKysNCiAgICAgMSBmaWxlIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KICAgIA0KICAgIGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2NvcmUtYXBpL2tlcm5lbC1hcGkucnN0IGIvRG9jdW1lbnRhdGlvbi9jb3JlLWFwaS9rZXJu
ZWwtYXBpLnJzdA0KICAgIGluZGV4IDcxZjVkMmZlMzliNy4uY2MzMjM0ODBjZTBlIDEwMDY0NA0K
ICAgIC0tLSBhL0RvY3VtZW50YXRpb24vY29yZS1hcGkva2VybmVsLWFwaS5yc3QNCiAgICArKysg
Yi9Eb2N1bWVudGF0aW9uL2NvcmUtYXBpL2tlcm5lbC1hcGkucnN0DQogICAgQEAgLTI3Niw2ICsy
NzYsMTIgQEAgQmxvY2sgRGV2aWNlcw0KICAgICAuLiBrZXJuZWwtZG9jOjogYmxvY2svYmxrLW1h
cC5jDQogICAgICAgIDpleHBvcnQ6DQogICAgIA0KICAgICsuLiBrZXJuZWwtZG9jOjogYmxvY2sv
YmxrLW1xLmMNCiAgICArICAgOmV4cG9ydDoNCiAgICArDQogICAgKy4uIGtlcm5lbC1kb2M6OiBi
bG9jay9ibGstbXEuYw0KICAgICsgICA6aW50ZXJuYWw6DQogICAgKw0KICAgICAuLiBrZXJuZWwt
ZG9jOjogYmxvY2svYmxrLXN5c2ZzLmMNCiAgICAgICAgOmludGVybmFsOg0KICAgICANCiAgICAt
LSANCiAgICAyLjE2LjQNCiAgICANCiAgICANCg0K
