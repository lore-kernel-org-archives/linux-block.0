Return-Path: <SRS0=BuC1=RE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5874FC43381
	for <linux-block@archiver.kernel.org>; Fri,  1 Mar 2019 16:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2F320851
	for <linux-block@archiver.kernel.org>; Fri,  1 Mar 2019 16:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DxWNprN8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="M+r4F59M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfCAQAA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:00:00 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:44037 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbfCAQAA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Mar 2019 11:00:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1551456000; x=1582992000;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=R2lJJe3hiAqGllAzJEaaBfOv+6EUdUxFl6kILumWops=;
  b=DxWNprN8bhNIS9g9D6J8uwYo5uHjSCZEnA1uZCEjcSIR/0Xkyzt4aucU
   FUZ+dEGfP4dr//h+11L3ZXWrkVwGwNPT4nh0EfH4Uv1Gh7Taoun5S51pu
   iISpk8TGmL/i8DPBx72IAingZtDxryu58FQ1pWSSF+C0uGUXn9QVcbdRy
   q/sD8kXmsKKCOvDA+JFzbUKAulVClf+/9G73PE9pgBZJRt4Gt/wdJmr07
   yfK5zb7Lsz1W51cZUuTKykYnN8+yonikzedYsVvIdztFM+NNqE88kf5EE
   XvenYT9shC7csKyW3zG/ZIF6ic7E72R+seXnMc8O9abfUxPCeo6d2GUMI
   g==;
X-IronPort-AV: E=Sophos;i="5.58,428,1544457600"; 
   d="scan'208";a="104223354"
Received: from mail-by2nam03lp2059.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.59])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2019 00:00:00 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2lJJe3hiAqGllAzJEaaBfOv+6EUdUxFl6kILumWops=;
 b=M+r4F59Mcm4lT8FHcTUl8FquofRdJ25AT2zFvWyZO5sAmVagyLF/5FYLBRuO4Y7HPMx7x/fKDvVr+FxozjDhUwVaGlIyrh5rlkw7oOiBEoc+mTZzVwu6yQtOmCzE/QDlB77Q+NIKk0jTxID2y48vey0ZPI78t3HsHeFB/PjUV1Q=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4686.namprd04.prod.outlook.com (52.135.122.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.17; Fri, 1 Mar 2019 15:59:54 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::adbe:cbf2:4b33:dbd]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::adbe:cbf2:4b33:dbd%4]) with mapi id 15.20.1665.017; Fri, 1 Mar 2019
 15:59:54 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V2 0/8] nvme: misc cleanups
Thread-Topic: [PATCH V2 0/8] nvme: misc cleanups
Thread-Index: AQHUyZ/pMsngZe/B6UuFPW973pdLwaX0B0uAgAKhPwA=
Date:   Fri, 1 Mar 2019 15:59:53 +0000
Message-ID: <80D74B0F-BB8E-4E83-ACE2-990E3B9389A8@wdc.com>
References: <20190221044248.11096-1-chaitanya.kulkarni@wdc.com>
 <20190227185013.GA11806@vader>
In-Reply-To: <20190227185013.GA11806@vader>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.16.1.190220
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [209.117.102.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57b830f5-24f4-4ea6-d19f-08d69e5ef1d4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4686;
x-ms-traffictypediagnostic: SN6PR04MB4686:
x-ms-exchange-purlcount: 1
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtTTjZQUjA0TUI0Njg2OzIzOlNDNkVIOGc4VVVEL2x4OENwc3cyTTdSbGxh?=
 =?utf-8?B?YVhyK3pRRnNrb0RiTElDWnRCTk5kRlNUQUFCZ3JoaWMwdlRUTVI2dlArMSsy?=
 =?utf-8?B?Q3NlcWJ2UDhhaWtuV1dpS3Z4RTJCZXc4eEJ5Nk5SRktPSS9wTi8yekE1ODRI?=
 =?utf-8?B?R1BXdWtSRUJmaEtHREhPSFVja08zTnpNSFpKb1JUa3gzaFlXQlc0MVZrTVlQ?=
 =?utf-8?B?QTI5V0lnaXh0QlZrcUNvSVdFK0g0M0VlUUtEMmV6TEdkVmhOV29oa05CMXNN?=
 =?utf-8?B?eFJlaTN4MmUzcy9Tbzc3cWZybmZPQzg0dGZSZytMS3lkQTFhODFja0UyQWkx?=
 =?utf-8?B?ZUJoTm5DdjVBWGJaZEtqamJzU3F3MzZKaDFObUlsaTRJUmJPUmI1SldUWmNv?=
 =?utf-8?B?Q2hVc0VGd2xHeWo2SysvcDliNU1qVVhHMDJLanp5ZGJySkJLd25sUXp2OHQr?=
 =?utf-8?B?VXNIdnlOcXI0MkZVS1Q5RjFZSG1zdExxYmp2MGNad0h2ZWZsOCtxOFBXT3Z1?=
 =?utf-8?B?STdlU3JtZit3QmYwc09TckxsQ1p0SXYwWCtOZjlaU2xMbWZOWGY1NUJyY09r?=
 =?utf-8?B?eXE5ODZFZWlKYTFvbE1KNndxcURxc283MUR5M3BxSWQvdTAyR2RVcDF0eWtF?=
 =?utf-8?B?TnRkZDh3WnpxUXNyK3dJS2VLUmhZanVGeEx1djAvMDY4VjZCQU5FbFQwS3BL?=
 =?utf-8?B?YmQvNnM2dUhqTWEzWHhwbEJlaTNNeVd4Unp1VlBuVWszcDRTK3o3VWVIbDky?=
 =?utf-8?B?N05ER0QzZ1hza0pKSHZrbi9vSm9hVm1oQWhxRHNLOHB1aG85V3RmZ0xaT2o5?=
 =?utf-8?B?UmFpbUFjcVFEb3pXZXAwYTRRanIyeDU0QzRISnd5cU1Hd2dsc3NDZWpUZGNP?=
 =?utf-8?B?T0tTQnFtYW9kOWw1bG9GMEFHY3dGa0pQU1FGVmtVZjhvcC9na1RYZG9DRWVm?=
 =?utf-8?B?RjZXNjNaZCtLMHNBNm1MWFFrYmw0WnN3SkZsL29TOXFqby9Uc2FKd1NqRGxs?=
 =?utf-8?B?enFnemZWQVpjaG4rSHlQTEtlcnV4cjB0YUxMZ29IMEs3dHZKZVJKUUh0K2dr?=
 =?utf-8?B?UFV4SHhWK1BpcVlobG10WkVmNGluZVNtVWxjc1ZYUy9RQ2g2UGt2NHZJZlZ5?=
 =?utf-8?B?dGRrTVIxRENGclNVT3M2dlNKNFc2ejYxRUxNK2taVVJWZk93N0xXQzh6SzJQ?=
 =?utf-8?B?czA3ZGt6ZjlmWnpYbWxIMmNIR2s5WndrYmxJSEpjM2xtT01sYjBEMGZwR1g0?=
 =?utf-8?B?QzQzZUVSRlFjQzJHS3dHeVI2NjFSNlhXU1R3RlMyRnNmNlNYTm43MDlITHQ5?=
 =?utf-8?B?SDdwemp3SlphbndHMXBwZGtEdnVMSGUvZDM3Zk96VUhXWEQ0a1dLa1JTWFpM?=
 =?utf-8?B?L0tqTFJ4SFU4OGI0c0RDWUtYR1hvUmhvbFAvcFNkVldqY2g1S3FTcFVXMGpG?=
 =?utf-8?B?MFhkbUIxMnpYU1hMUUxkNHFjZ3dRdFEzYW1TZGZoL0hJMC9yRVB5ZDJGMHd1?=
 =?utf-8?B?cnB0ZzJvR0VPRVZWdUJTenZ1bFF0c0NjWmMzOWtZbmxBVUVwcU50NVlwSEZZ?=
 =?utf-8?B?aFZURnh2RmJvMDFWM0tOenZlUHp1amZDODdYR240b3B5OXRwRXVTcm5FakFF?=
 =?utf-8?B?S3FGVFp1TUpuTCsvYjVMYjBmNVpiUVBYeXd5ejRNT2g4MGFDU0JyU3VBeVc4?=
 =?utf-8?B?aHNVU2lGQ0VDRDBad0lkUTUxek5qcVQyU1hTZ1BaK3BlWXlOcENQbDdoNjlz?=
 =?utf-8?B?a1RaajZzV3ZjcXhqaDdQUmdhaktqRC9JeEwwQUNKYTdNQ0MyWllaWGZEMXlC?=
 =?utf-8?Q?lZs2zXDb5f32S?=
x-microsoft-antispam-prvs: <SN6PR04MB468683727F692359D1B5F48886760@SN6PR04MB4686.namprd04.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(376002)(396003)(136003)(189003)(199004)(966005)(71190400001)(229853002)(58126008)(6512007)(11346002)(6306002)(6246003)(14454004)(33656002)(316002)(446003)(8676002)(81166006)(6486002)(53936002)(6436002)(25786009)(4326008)(305945005)(7736002)(476003)(3846002)(6116002)(66066001)(68736007)(81156014)(2906002)(2616005)(186003)(97736004)(5660300002)(6916009)(105586002)(86362001)(8936002)(82746002)(4744005)(102836004)(6506007)(36756003)(486006)(106356001)(99286004)(72206003)(478600001)(26005)(83716004)(14444005)(256004)(71200400001)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4686;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uRW+XXLY5cjWIzzfeNxNB5tn6EljopVI8XmPciSxMjyIgGAhQXu57f+qqW5f21AQQhhltrHeOgalo/fAAKutAYO1iWIPSlDPsun04WULDyVxt6Y1vMQ1Eh9t9DVk4xeYER2YC1OBYsgEKvkwBMr9SpUaMmCMjMzIf179DWStZO7T7WuYVx2QgtdXvzsIGQrk2nLM2UVx4qYNWqdv8eceU7H9ozSQ0LRSpPBcktYDAy5tKnjtv+K6KpUh1rFPULIoXOHYPCWZrNXkUXCyrkjpOUj02e/CQ6pqhHwHUftzAVZpF0ZpIkZ5wz8eT+dU26wgf1zXNSNB5kSVqoHw+cs2/zYG1YngQzIJTHstVsrq1Hd0w0x1/NkZhgadXt3o7ZuHl6XbaI6XkD8SKi/3Ff2e2rPK3iiOL9sKPQ+lyefrWfY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08B9639503B2934993B590FE65E2962A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b830f5-24f4-4ea6-d19f-08d69e5ef1d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 15:59:53.9233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4686
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SGkgT21hciwNCg0KRXZlcnl0aGluZyBsb29rcyBnb29kLiANCg0K77u/T24gMi8yNy8xOSwgMTo1
MCBQTSwgIk9tYXIgU2FuZG92YWwiIDxvc2FuZG92QG9zYW5kb3YuY29tPiB3cm90ZToNCg0KICAg
IE9uIFdlZCwgRmViIDIwLCAyMDE5IGF0IDA4OjQyOjQwUE0gLTA4MDAsIENoYWl0YW55YSBLdWxr
YXJuaSB3cm90ZToNCiAgICA+IEhpIE9tYXIsDQogICAgPiBUaGlzIGlzIGEgc21hbGwgcGF0Y2gg
c2VyaWVzIHdoaWNoIGZvbGxvd3MgdGhlIGJsa3Rlc3RzIGNvZGluZw0KICAgID4gc3R5bGUgZm9y
bWF0IGFzIHBvaW50ZWQgb3V0IGJ5IEJhcnQuIEFsc28gbWluaW1pemVzIHRoZSBvdmVyYWxsDQog
ICAgPiBjb2RlIGZvciB0aGUgcmV2aWV3Lg0KICAgID4gDQogICAgPiAtUmVnYXJkcywNCiAgICA+
IENoYWl0YW55YQ0KICAgID4gDQogICAgPiBDaGFuZ2VzIHNpbmNlIFYxOi0NCiAgICA+IDEuIEFk
ZCB0ZXN0Y2FzZSBzcGVjaWZpYyBlcnJvciBtZXNzYWdlIG9uIGZhaWx1cmUuDQogICAgDQogICAg
SSBhbHNvIG1hZGUgdGhlc2UgcmVkaXJlY3QgdG8gJEZVTEwgaW5zdGVhZCBvZiAvZGV2L251bGwu
IFRoZSByZXN1bHQgaXMNCiAgICBwdXNoZWQgdG8gaHR0cHM6Ly9naXRodWIuY29tL29zYW5kb3Yv
YmxrdGVzdHMvY29tbWl0cy9udm1lLWNsZWFudXBzLA0KICAgIGNvdWxkIHlvdSB0YWtlIGEgcXVp
Y2sgbG9vaz8NCiAgICANCiAgICBBbHNvLCBJIGFzc3VtZSBJIGNhbiBhZGQgeW91ciBzaWduZWQt
b2ZmLWJ5IHRvIGFsbCBvZiB0aGVzZSBjb21taXRzPw0KWWVzLCBmZWVsIGZyZWUgdG8gYWRkIHRo
YXQuDQogICAgDQoNCg==
