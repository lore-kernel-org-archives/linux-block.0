Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D07DC433FE
	for <linux-block@archiver.kernel.org>; Sun, 13 Dec 2020 10:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E1E222D04
	for <linux-block@archiver.kernel.org>; Sun, 13 Dec 2020 10:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgLMKcx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Dec 2020 05:32:53 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:1788 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgLMKcw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Dec 2020 05:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607855573; x=1639391573;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SltVk6KTMbPxcyL/cYnUQ5LDq+j5BC2XgUBxaEf2Np0=;
  b=n9LrV7xYDkohgse65qwsjPt+oY1ZNmT53vMMyz8QTwDn9b0C9f+8xD1C
   ziG2DTaGDQNwF7i0Q7Yg/QYZKRhAhIjDr9L8XfZrAwcupkUjqssNnVCAb
   baVSB+WUMSXlGTX7JSXt2Sbs4c/IH/MJIjHDW+fG4udWh4t0HPr1CPJ6+
   9ILXBwBB8WZ3u765xTl3YBvEFbcUcyFZ9tYAcJ914hJbWOAYDJKWrsoD+
   /zO26vpHGDKSoVdogenoXD8rbgK8tYbERgJ05hjHF3ldZ7vlpYOdCq4GR
   ReHhtfF661LMHUhQvlcAkT6sPiPAP07mxNDODnpWBZRQ9n7Tj3zzeIRBU
   Q==;
IronPort-SDR: IJdhVxahHZHGM2yZ0/REObP7QE8f4s/EF6okNon6ZxNb7FbrGURcC7xQuZ77w6ZL2U8fUgcpNR
 gIVvYiFPdQdEUqqoBycwd1ic2LZ2L14+yAMsqpDjOpJ+rqmVSo1w8j4pAObs/b/dcXQP2k6xQS
 xaJIKeoO9c3DuXIrl53SIT2IEFkU9n//aBvD+dXie1VAM6vL7OR8GYekExlCH7WFXCfgYKeVtg
 ac9mohtsHGEKJXp7yjwF5t/re/04nmnA9L/F4vU0GpCz9gHASYw9B30aWYgjk5+MBtTkeitsSi
 M3o=
X-IronPort-AV: E=Sophos;i="5.78,416,1599494400"; 
   d="scan'208";a="156238129"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2020 18:31:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYAQy2fJSeYH8p5JN8s6pqNHhusWZCjttAd6TG954Ubd/jgpCpjrISmheSe7YjBYQrMPFsq4J8JsMzrE8K+1+QzMqy1fJazQcFFp7277Q+AQHO+yf7ZquTjAlc/+8/sE0ILI7iAMwNwnG/TMSXFNJL4s6jX1EgGc4om7PjNzzPO0aGVwCwotdndvOkPV165WUhSCO0+b9tb7aw+lqhjmE4Z95FKMVD4l+xu3iupwBH05qevJokomJj3LEjDj90dIETzNP3YhmHumlc0Pwu1DUNh2x24siL/UnqtmKY6nEbY7HjDRr13yb7u6x2n3zjIPbAqIYKLPqMxCLwUG0rSL6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SltVk6KTMbPxcyL/cYnUQ5LDq+j5BC2XgUBxaEf2Np0=;
 b=TBoqOifEtr3k7/zXx4TldlsG63Lh67X4MjLeTyKLt7SysojtgsK4uxKnIbRWRX3zj4hrda6eHW3AJ6DrVPZqzGZ4CTGNAE+5O8ykyyC06bDK+FK60Oo3v+9+r+zKBlrCWDC89nuQmk7ZA2IbiqVCkz8hlxihM1o143h8RjAxc8Gy3k75MUVpZGKDkSQkLNTDQltGY4WmVcG/6ynfrjukm8/Jk5+wcaXXyTF0nSxg6NgL6SETuc57auErFu19EKk/8Xpna/aOyQAwA05znnYKeMtLORzCJZ0amNvi/EGAZls+rrtFVLz5xDDMnGg8DJ6V2IYbuYUF8W2iZBs2DdmmNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SltVk6KTMbPxcyL/cYnUQ5LDq+j5BC2XgUBxaEf2Np0=;
 b=b8zOw6TnTBnJTsVwCa2yZLmf/7z8/pinGwgUdPgRpLW0nRq/CQa9zZH7E/dd2yeAbpyYU/gxWdSF9bGpgGTC2mPlOL4N42VQD0CpSyaf/BAdBBc6wIHkKC9oAdxwDzoPvuXzQL6hYCFOTF3IsE9ptX9j5/PwSzNuZkY0kAjV65g=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB7013.namprd04.prod.outlook.com (2603:10b6:610:96::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.19; Sun, 13 Dec
 2020 10:31:44 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3632.023; Sun, 13 Dec 2020
 10:31:44 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V6 4/6] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V6 4/6] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHW0RPvmJIFNb+IOkaBuk4iq3d6e6n01CSA
Date:   Sun, 13 Dec 2020 10:31:44 +0000
Message-ID: <3fa59aa6a579b58ffff9fc0f95a34f93c9354618.camel@wdc.com>
References: <20201213055017.7141-1-chaitanya.kulkarni@wdc.com>
         <20201213055017.7141-5-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20201213055017.7141-5-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.1 (3.38.1-1.fc33) 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:8d3e:27aa:85c2:44b5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 502b9887-9dbd-45c9-94de-08d89f5249a5
x-ms-traffictypediagnostic: CH2PR04MB7013:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB70131EB7B2A2E9E5034BA2F8E7C80@CH2PR04MB7013.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1PhZhlognbK72oGR0eXY2O0LnwcIHmyW8OyuIyRtPXxOf+Z/c9O4sxfvWs/eMilf5jS1nLff3iQgVHm3QV7aA/9ZaxrcM2xHBuiVrxnvxwDcoUzCjjgnwI4Xe6k5/hkWoluXVHzuKF8z6ducGQUQWnekfd79H/35aXW1cJxGKl4LeezYm2rVAnQMpcYrRuR3xtazxCqYNqj6SLfCNNidLhTxOSPUtVguyIuTMT8hnwK860DYHe64oL53pZmExoAJaPdk8Ef+BTAZPKAvWCGABOujNR6pawjqpAYYv9X+RUdSvTfrklK8T4NCTVfMx2L6kjB+tsVUozLBwT+efpXpxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(8676002)(186003)(5660300002)(6512007)(6506007)(4001150100001)(2616005)(71200400001)(91956017)(66476007)(66446008)(2906002)(6486002)(76116006)(66946007)(36756003)(110136005)(54906003)(66556008)(64756008)(508600001)(4326008)(8936002)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Z0tMT1lCYzdhcnp6bUppajlDNERkT3dGMXM5MGswOTJuSGw0Z1k2M25BUHNM?=
 =?utf-8?B?Sk5vRWx1N2ZNM1VDRVNFYTlqTmx1cHlGaVhDL1dBVWZRejdhZHlHVW5EMC9O?=
 =?utf-8?B?d05KT2VGTzVNUDRMaGZ6elc4N05aU2hXSTRvcnN6Z0Y1eit2Y1lBM291SGJ5?=
 =?utf-8?B?OEx6b25DR3BQYnNTY2NpQ3BRVm1rdFNXMGhiU2hEMlNQRTNpVUJPZDlXL2JM?=
 =?utf-8?B?RXQrWGU3WDV3RzVxeUxCbFFBTlhSOEMreERsQ2V6U2syMUNlSnpBNC9XenVI?=
 =?utf-8?B?QkRZUFpFN1hoMXo3N05KczZPak1xRDBGVENuRzZaZklRRFBvRGxhdUJtWUlZ?=
 =?utf-8?B?UEpoeWpGZ1RGdXp0M2VBTlRIcnR2NlhocGFRSmx2ZzdEQlhlMzF0ZWRyaE9H?=
 =?utf-8?B?VFNJeGk4Nk1zeVhKaUxPYmxPZllXT2xKMWdXK3p6S003R2I0KytrUW96RHVX?=
 =?utf-8?B?SmpYbnFFQllGTVUzcDhFVFBPVjl6RXlORUZiN0dRRmRGNzlpRTJRTCtONjRi?=
 =?utf-8?B?Qm95cytMSzExcFJoYUplSnY2bjMzZkV1K051dTNiRERIZzJVWWJRVkRhNm5F?=
 =?utf-8?B?MFVxaGtyYlhVWXg4OFdnRU52a0pNWWlYMFNZWjl4aTM0VzJOUlF3WTg2WmhX?=
 =?utf-8?B?aWJQbGdycUhOdFhkclNVc1MwWTdHZ0NkUDdyMjAzcEdoY3hOeHN3dEZmaDJW?=
 =?utf-8?B?S3NkZGRMMDI1WFhGTUZWZTFqSURUd3dlL281VG5rQWRBVnQvQnNHeGFJeXdQ?=
 =?utf-8?B?U2U1bXF2cEFMQVE3VzJIVjQxSzM3RitxUTFnS3Jad3B4c1BFS09ORlcyb0JQ?=
 =?utf-8?B?WG9Jc2pxeVM4Si85ZlozMU5aRXVJUFZvTmxML0dOSXJ4T3BJZDJodzZJcWVB?=
 =?utf-8?B?SWdFdkZsUGpncjBSVVRHbTZCNGZlelFCU2tjQXNEQWlUNzB5ejlkUGtndHZY?=
 =?utf-8?B?SUl0U0JNVTlTV2VyTXl2b0tiOFUwM2FCbjBmTEhKZEo3ZWtOSkN3WFIwSmoy?=
 =?utf-8?B?N0I4NkhIL29FN3NaVzVrSytTUWJ1YmNWaDNRZ01IUXdhSGRmNllvdTM0VlZh?=
 =?utf-8?B?Y2F4Z2R2bFRnOXh1bFAyZ21ZK2c2V2xOeTIyQmlFMGdKQTJMYS9ubzdjTlBL?=
 =?utf-8?B?Vm1aeDRRRlJuMDhOOEVCcStsZG16NnJFR3V6VmVKaU9jNlp2NEJtaitLdTlz?=
 =?utf-8?B?VGY0WVNVZVFIOThWdWc2VDNlemhGOFM1eTRudWF0cXhiZGRXbVRmVVlsQmFC?=
 =?utf-8?B?VittVEZUWlpRZmU4YnNSRHpnalk0UmtiRTJ6N1g3Z0ZsWkM5MTFIQnJhM1ho?=
 =?utf-8?B?RE9ucVhWK25DV2dmYmpqRWhnZUhQT1Z2aE9QU3JvUFFPbEhTOW85bzdvSDhQ?=
 =?utf-8?B?WDNQeUtTLzRWdkpHREdwbzdmRjRDbHltYzFuVHZPTjNQN3NtS3ZFVkprditT?=
 =?utf-8?Q?cAOmjQy6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81517740E566214380B3B9A7920A1540@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 502b9887-9dbd-45c9-94de-08d89f5249a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2020 10:31:44.3323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sN3s0eZz1RUxDw4AoBKnHGvZf3gtCbBuvDMEaswv5Z9/LGI1z9ErHL9vydMzOw9sjUeqaL0KrWA735MIYyUkVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7013
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gU2F0LCAyMDIwLTEyLTEyIGF0IDIxOjUwIC0wODAwLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3Jv
dGU6DQpbLi4uXQ0KPiArc3RhdGljIGludCBudm1ldF9iZGV2X3ZhbGlkYXRlX3puc196b25lc19j
YihzdHJ1Y3QgYmxrX3pvbmUgKnosDQo+ICsJCXVuc2lnbmVkIGludCBpZHgsIHZvaWQgKmRhdGEp
DQo+ICt7DQo+ICsJc3RydWN0IGJsa196b25lICp6b25lID0gZGF0YTsNCj4gKw0KPiArCW1lbWNw
eSh6b25lLCB6LCBzaXplb2Yoc3RydWN0IGJsa196b25lKSk7DQoNClNlZSBiZWxvdy4gVGhpcyBp
cyBub3QgbmVjZXNzYXJ5Lg0KDQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiArc3Rh
dGljIGJvb2wgbnZtZXRfYmRldl9oYXNfY29udl96b25lcyhzdHJ1Y3QgYmxvY2tfZGV2aWNlICpi
ZGV2KQ0KPiArew0KPiArCXN0cnVjdCBibGtfem9uZSB6b25lOw0KPiArCWludCByZXBvcnRlZF96
b25lczsNCj4gKwl1bnNpZ25lZCBpbnQgem5vOw0KPiArDQo+ICsJaWYgKGJkZXYtPmJkX2Rpc2st
PnF1ZXVlLT5jb252X3pvbmVzX2JpdG1hcCkNCj4gKwkJcmV0dXJuIGZhbHNlOw0KDQpCdWcuDQoN
Cj4gKw0KPiArCWZvciAoem5vID0gMDsgem5vIDwgYmxrX3F1ZXVlX25yX3pvbmVzKGJkZXYtPmJk
X2Rpc2stPnF1ZXVlKTsgem5vKyspIHsNCg0KTGFyZ2UgY2FwYWNpdHkgU01SIGRyaXZlcyBoYXZl
IG92ZXIgNzUsMDAwIHpvbmVzIHRoZXNlIGRheXMuIERvaW5nIGEgcmVwb3J0DQp6b25lcyBvbmUg
em9uZSBhdCBhIHRpbWUgd2lsbCB0YWtlIGZvcmV2ZXIuIFRoaXMgbmVlZHMgdG8gYmUgb3B0aW1p
emVkOiBzZWUNCmJlbG93Lg0KDQo+ICsJCXJlcG9ydGVkX3pvbmVzID0gYmxrZGV2X3JlcG9ydF96
b25lcyhiZGV2LA0KPiArCQkJCXpubyAqIGJkZXZfem9uZV9zZWN0b3JzKGJkZXYpLCAxLA0KPiAr
CQkJCW52bWV0X2JkZXZfdmFsaWRhdGVfem5zX3pvbmVzX2NiLA0KPiArCQkJCSZ6b25lKTsNCj4g
Kw0KPiArCQlpZiAocmVwb3J0ZWRfem9uZXMgIT0gMSkNCj4gKwkJCXJldHVybiB0cnVlOw0KPiAr
DQo+ICsJCWlmICh6b25lLnR5cGUgPT0gQkxLX1pPTkVfVFlQRV9DT05WRU5USU9OQUwpDQo+ICsJ
CQlyZXR1cm4gdHJ1ZTsNCg0KVGhpcyB0ZXN0IHNob3VsZCBiZSBpbiB0aGUgbnZtZXRfYmRldl92
YWxpZGF0ZV96bnNfem9uZXNfY2IoKSBjYWxsYmFjay4gVGhhdA0KY2FsbGJhY2sgY2FuIHJldHVy
biBhbiBlcnJvciBpZiBpdCBmaW5kcyBhIGNvbnZlbnRpb25hbCB6b25lLiBUaGF0IHdpbGwgc3Rv
cA0KYmxrZGV2X3JlcG9ydF96b25lcygpLg0KDQoNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gZmFs
c2U7DQo+ICt9DQoNCldoYXQgYWJvdXQgdGhpczoNCg0Kc3RhdGljIGludCBudm1ldF9iZGV2X3Zh
bGlkYXRlX3puc196b25lc19jYihzdHJ1Y3QgYmxrX3pvbmUgKnosDQoJCQkJCSAgICB1bnNpZ25l
ZCBpbnQgaWR4LCB2b2lkICpkYXRhKQ0Kew0KCWlmICh6LT50eXBlID09IEJMS19aT05FX1RZUEVf
Q09OVkVOVElPTkFMKQ0KCQlyZXR1cm4gLUVOT1RTVVBQOw0KCXJldHVybiAwOw0KfQ0KDQpzdGF0
aWMgYm9vbCBudm1ldF9iZGV2X2hhc19jb252X3pvbmVzKHN0cnVjdCBibG9ja19kZXZpY2UgKmJk
ZXYpDQp7DQoJaW50IHJldDsNCg0KCWlmIChiZGV2LT5iZF9kaXNrLT5xdWV1ZS0+Y29udl96b25l
c19iaXRtYXApDQoJCXJldHVybiB0cnVlOw0KDQoJcmV0ID0gYmxrZGV2X3JlcG9ydF96b25lcyhi
ZGV2LA0KCQkJZ2V0X2NhcGFjaXR5KGJkZXYtPmJkX2Rpc2spLCBiZGV2X25yX3pvbmVzKGJkZXYp
LA0KCQkJbnZtZXRfYmRldl92YWxpZGF0ZV96bnNfem9uZXNfY2IsIE5VTEwpOw0KCWlmIChyZXQg
PCAxKQ0KCQlyZXR1cm4gdHJ1ZTsNCg0KCXJldHVybiBmYWxzZTsNCn0NCg0KQWxsIHpvbmVzIGFy
ZSBjaGVja2VkIHVzaW5nIHRoZSBjYWxsYmFjayB3aXRoIHRoZSBsb29wIGluDQpibGtkZXZfcmVw
b3J0X3pvbmVzKCkuDQoNClsuLi5dDQo+ICt2b2lkIG52bWV0X2JkZXZfZXhlY3V0ZV96b25lX2Fw
cGVuZChzdHJ1Y3QgbnZtZXRfcmVxICpyZXEpDQo+ICt7DQo+ICsJc2VjdG9yX3Qgc2VjdCA9IG52
bWV0X2xiYV90b19zZWN0KHJlcS0+bnMsIHJlcS0+Y21kLT5ydy5zbGJhKTsNCj4gKwlzdHJ1Y3Qg
cmVxdWVzdF9xdWV1ZSAqcSA9IHJlcS0+bnMtPmJkZXYtPmJkX2Rpc2stPnF1ZXVlOw0KPiArCXVu
c2lnbmVkIGludCBtYXhfc2VjdHMgPSBxdWV1ZV9tYXhfem9uZV9hcHBlbmRfc2VjdG9ycyhxKTsN
Cj4gKwl1MTYgc3RhdHVzID0gTlZNRV9TQ19TVUNDRVNTOw0KPiArCXVuc2lnbmVkIGludCB0b3Rh
bF9sZW4gPSAwOw0KPiArCXN0cnVjdCBzY2F0dGVybGlzdCAqc2c7DQo+ICsJaW50IHJldCA9IDAs
IHNnX2NudDsNCj4gKwlzdHJ1Y3QgYmlvICpiaW87DQo+ICsNCj4gKwlpZiAoIW52bWV0X2NoZWNr
X3RyYW5zZmVyX2xlbihyZXEsIG52bWV0X3J3X2RhdGFfbGVuKHJlcSkpKQ0KPiArCQlyZXR1cm47
DQo+ICsNCj4gKwlpZiAoIXJlcS0+c2dfY250KSB7DQo+ICsJCW52bWV0X3JlcV9jb21wbGV0ZShy
ZXEsIDApOw0KPiArCQlyZXR1cm47DQo+ICsJfQ0KPiArDQo+ICsJaWYgKHJlcS0+dHJhbnNmZXJf
bGVuIDw9IE5WTUVUX01BWF9JTkxJTkVfREFUQV9MRU4pIHsNCj4gKwkJYmlvID0gJnJlcS0+Yi5p
bmxpbmVfYmlvOw0KPiArCQliaW9faW5pdChiaW8sIHJlcS0+aW5saW5lX2J2ZWMsIEFSUkFZX1NJ
WkUocmVxLT5pbmxpbmVfYnZlYykpOw0KPiArCX0gZWxzZSB7DQo+ICsJCWJpbyA9IGJpb19hbGxv
YyhHRlBfS0VSTkVMLCByZXEtPnNnX2NudCk7DQo+ICsJfQ0KPiArDQo+ICsJYmlvX3NldF9kZXYo
YmlvLCByZXEtPm5zLT5iZGV2KTsNCj4gKwliaW8tPmJpX2l0ZXIuYmlfc2VjdG9yID0gc2VjdDsN
Cj4gKwliaW8tPmJpX29wZiA9IFJFUV9PUF9aT05FX0FQUEVORCB8IFJFUV9TWU5DIHwgUkVRX0lE
TEU7DQo+ICsJaWYgKHJlcS0+Y21kLT5ydy5jb250cm9sICYgY3B1X3RvX2xlMTYoTlZNRV9SV19G
VUEpKQ0KPiArCQliaW8tPmJpX29wZiB8PSBSRVFfRlVBOw0KPiArDQo+ICsJZm9yX2VhY2hfc2co
cmVxLT5zZywgc2csIHJlcS0+c2dfY250LCBzZ19jbnQpIHsNCj4gKwkJc3RydWN0IHBhZ2UgKnAg
PSBzZ19wYWdlKHNnKTsNCj4gKwkJdW5zaWduZWQgaW50IGwgPSBzZy0+bGVuZ3RoOw0KPiArCQl1
bnNpZ25lZCBpbnQgbyA9IHNnLT5vZmZzZXQ7DQo+ICsJCWJvb2wgc2FtZV9wYWdlID0gZmFsc2U7
DQo+ICsNCj4gKwkJcmV0ID0gYmlvX2FkZF9od19wYWdlKHEsIGJpbywgcCwgbCwgbywgbWF4X3Nl
Y3RzLCAmc2FtZV9wYWdlKTsNCj4gKwkJaWYgKHJldCAhPSBzZy0+bGVuZ3RoKSB7DQo+ICsJCQlz
dGF0dXMgPSBOVk1FX1NDX0lOVEVSTkFMOw0KPiArCQkJZ290byBvdXRfYmlvX3B1dDsNCj4gKwkJ
fQ0KPiArCQlpZiAoc2FtZV9wYWdlKQ0KPiArCQkJcHV0X3BhZ2UocCk7DQo+ICsNCj4gKwkJdG90
YWxfbGVuICs9IHNnLT5sZW5ndGg7DQo+ICsJfQ0KPiArDQo+ICsJaWYgKHRvdGFsX2xlbiAhPSBu
dm1ldF9yd19kYXRhX2xlbihyZXEpKSB7DQo+ICsJCXN0YXR1cyA9IE5WTUVfU0NfSU5URVJOQUwg
fCBOVk1FX1NDX0ROUjsNCj4gKwkJZ290byBvdXRfYmlvX3B1dDsNCj4gKwl9DQo+ICsNCj4gKwly
ZXQgPSBzdWJtaXRfYmlvX3dhaXQoYmlvKTsNCj4gKwlzdGF0dXMgPSByZXQgPCAwID8gTlZNRV9T
Q19JTlRFUk5BTCA6IHN0YXR1czsNCj4gKw0KPiArCXJlcS0+Y3FlLT5yZXN1bHQudTY0ID0gbnZt
ZXRfc2VjdF90b19sYmEocmVxLT5ucywNCj4gKwkJCQkJCSBiaW8tPmJpX2l0ZXIuYmlfc2VjdG9y
KTsNCg0KV2h5IHNldCB0aGlzIGlmIHRoZSBCSU8gZmFpbGVkID8gVGhlcmUgbWF5IGJlIG5vIHBy
b2JsZW1zIGRvaW5nIHNvLCBidXQgSSBkbw0Kbm90IHNlZSB0aGUgcG9pbnQgZWl0aGVyLg0KDQo+
ICsNCj4gK291dF9iaW9fcHV0Og0KPiArCWlmIChiaW8gIT0gJnJlcS0+Yi5pbmxpbmVfYmlvKQ0K
PiArCQliaW9fcHV0KGJpbyk7DQo+ICsJbnZtZXRfcmVxX2NvbXBsZXRlKHJlcSwgc3RhdHVzKTsN
Cj4gK30NCg0KLS0gDQpEYW1pZW4gTGUgTW9hbA0KV2VzdGVybiBEaWdpdGFsDQo=
