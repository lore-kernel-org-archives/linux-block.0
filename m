Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0A4C433EF
	for <linux-block@archiver.kernel.org>; Thu,  7 Jul 2022 12:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235040AbiGGMtv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Jul 2022 08:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbiGGMtu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Jul 2022 08:49:50 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A7827163
        for <linux-block@vger.kernel.org>; Thu,  7 Jul 2022 05:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657198189; x=1688734189;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=E+yoIBTOsSkwtnKmepY3LM4oR/VvEh0KE73iF2/zLJM=;
  b=DNti/WUCu6ZTMeIKiNgI+mdlYWhhzTDaXr/KQz+tKNM1FDOmEzll5hAO
   sQp3XGgFkX5T6+rGaW+l1QN97BSVnISBzNAowD7t+B+mxVipmdcB+sbKa
   GY4HWbTzh03FggAGYIgv7nrErYF3BktzUysNPCfi7PGuKF5PxezZ2j5Im
   MfB/a10tC5Ivc7gJPD7k652AZnph//qwHlK1VcpK3tCGjEwhjK78w9e3P
   hcAzGKIbLVspMVfZQRQd0a4j8Kwu8ANMTyFjwhC+BaDYFbG55MmJmkry/
   3NG2Z39S6BHKjy6EtTSykKshvMpXHgv9xT2CwZrwWmOTwe9ywoB8tSUeL
   g==;
X-IronPort-AV: E=Sophos;i="5.92,252,1650902400"; 
   d="scan'208";a="205080991"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2022 20:49:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQn7LDLDuNc13I0HGOGDCm18LvBPPDSozw4nXws15m5L+Z+4+5SgHnSAJQhcso9DmvEDJzV6aF0cA+AywuzTbjgNYYoG34W58su2IoqosrJgWzwspENVE+7fnji6Np9YklH9DzhEl4utPuP8iuftms12xwW0gatjg6Ya5qU9jTlNNL/fAo8s1A1saDP0wwmrebhMm3/+kGQJLbuen6Tl+Ou73ZMfGod1sA9A/zUU+7CNsWyp2lZDT9+5xZW9DluhXbxV+KJ6OgUchr678mMcrneskmys18a+Un0nynBBvK+qJ1/246rhkdJ7asi0NcwFW++RtpC5bJFGItxewDym5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+yoIBTOsSkwtnKmepY3LM4oR/VvEh0KE73iF2/zLJM=;
 b=Gm53JCbwSXyULEFKNYQ/DND42CUaGQMfvekEfQg1+tuJwBvZZojTeS9aaP4QUae4nnSGdTe8mkhhfX4ciw7V72Vt0L+qqgaZT6lqDhsHUeCyjhEGfC/XUdYisX9W1cTCyPh0uv5dH+uAVyq9IrclyUiCcntJjY4zQ/L16bavgR+TScn6BV2vE7m+78fXNDFmls4UDAHI4aVJ2oMg9BEZa4musMpw+EQA3Q60f0fNR/17cxBvxQqEqHrQt57DX03Fr7AFujunA9wmAl3tnx44P1aXMgD7SSumQ2RMyIbwup1OqA5nO9ZJdO3LPAHEqloaOWC0jw4ahlOqnYgTszGDMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+yoIBTOsSkwtnKmepY3LM4oR/VvEh0KE73iF2/zLJM=;
 b=eTLh/8xcnnpmndnR48bl2t4b8cMnJMArn/RWIw6kCV/Z6JBHsgYo7KqFjUjsAXHBLLbwhlkdgaZ6NW8JL0/tWCdH9juJ5XdQtSy+jIb8LJMb4lBCxx4DyUASqorqdNzfMqHOwE8bkjZUqw+fa56JubsZuzdhQmyk67NbZBCLhVw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BYAPR04MB5525.namprd04.prod.outlook.com (2603:10b6:a03:f1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.18; Thu, 7 Jul 2022 12:49:46 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833%7]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 12:49:46 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Sun Ke <sunke32@huawei.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH blktests v2] nbd: add a module load and device connect
 test
Thread-Topic: [PATCH blktests v2] nbd: add a module load and device connect
 test
Thread-Index: AQHYkbPG0qKoEERDRUSuUBLWei8a4q1y3KmA
Date:   Thu, 7 Jul 2022 12:49:46 +0000
Message-ID: <20220707124945.c2rd677hjwkd7mim@shindev>
References: <20220707035610.3175550-1-sunke32@huawei.com>
In-Reply-To: <20220707035610.3175550-1-sunke32@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5deaaf6c-9f5f-4985-6c6c-08da60172bfa
x-ms-traffictypediagnostic: BYAPR04MB5525:EE_
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yzCZxHkBngQxtaCQRZGNinP3y0Tu/SdGER+fnNBizhTNDzaU/XqSNqfChqgonwCLCkoGJ3VSvUmlKNc3fmbv/FqNd+giNgRGB9wEBgRTCmF2wXMKGMrhZYsZr4F2UOT7T5ipAV3iD+r+43sBjYRRZ0EMrf+zmVuLAxqlcixPXrs/mKh16r41llLrVGQ3pTqMrAa+b+I8GBGSIdhVZPvI450vhoEWPj0FEK/7FgoNuevJ9wtvVEDAEePVWAb0vI10H3l1qbA1QbbMgDJCbz8Spcm22M5TYURrjiN0KhDCW286VQKIdV4/LQcsYCJBYVAmitnZdmu5lzI6HoS10RwuSf32NxME1YOpvKH/NN/TnJklwsjjhE/yM8BDFxwL9YMI0CjOw4TPlZoMaAGxe+/DleXXn6TN4aA1WF5AmVAcya0JwbVZ9Oo1e4k5r5DnW/irxicChX425l0whBz7UhO3JaJfu/KOiu4LpE/aJjHIO76RPJMC6Bv1luSZbdR2jYr1qdcrxfwxiIccJH/OX0x6ykplPLhGzRgFhfJLS6OAitTHpBg9LBKoE99hBO0iiJCDtZzGp2X9Amjj+qunat9JfQEPKRsuIvQyGmOfx/PphOlT1ypv54vGRobZOs+LHxPMbenJrY5czjwIma7dibJHRM1bq2HvZbVlj1DFO9k4Bphu5c/6rGNoKTUOKNNsGv+YuCCuBTsvZJbT3OMDQOozHL9W5n1ckOOHCceNjKmnHRa1jQBrkq5yBqW5ZmjeHlk/wTLSihzi+C8+zRoK34d3VvKuDz26iRb9vMrt3AiUvNFMbHD2aIjzTaPo/EsxqG5+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(366004)(39860400002)(396003)(346002)(136003)(376002)(66946007)(4326008)(122000001)(66446008)(66556008)(76116006)(64756008)(8676002)(8936002)(91956017)(38100700002)(66476007)(33716001)(2906002)(5660300002)(82960400001)(86362001)(83380400001)(41300700001)(478600001)(6512007)(316002)(186003)(9686003)(44832011)(1076003)(6506007)(6486002)(38070700005)(54906003)(71200400001)(6916009)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkZPMmhxZXJjczRMbzZSZVZwYlZtMHhxMy9JRXpIb2FQUHRSeUNaTkdYeHZ0?=
 =?utf-8?B?RmpzOW44YzZLZk9LeUlaNmN5S0xTNWw0UXBpRkxpNUNxY2dPL2dLdjZvZHE4?=
 =?utf-8?B?TU1HamZiNXBBZmp3bkR1LzVWOGtzajV1aEM2ak5DSEc0dkFFS3pCVFlCb3Fx?=
 =?utf-8?B?NEpOQzFKQmJ3dGdEcVVNQ1JoS0ZXR1Z4V2RseFlDTTluYlp2dkxmLzN6MmlM?=
 =?utf-8?B?WmM5L0FCL09KS200U21OenQySFJBZ1o1dTd2bzA5UUxLMWMvVG04ZVlkOHJQ?=
 =?utf-8?B?WnpkL21uejQ4VW4vci9zc3ZnVDRKb2RidUdMWTZXaTdFU251M2l5TTZsaHhE?=
 =?utf-8?B?ZXhKVEI2YllOanhtbmdkbGJwUWxWcjd6NkhsUmhiQlA1N3VuaEpnTzM0WmpV?=
 =?utf-8?B?bUFlYVUwaTR2Ukw0a0FZY1Jld0ZQQ3FacFlHajY5YjhwaEZMSnJDMmIzSHUw?=
 =?utf-8?B?a2VaRWxKemxrRkhLSG1WUjJ5MVpkTUJ6MDQvMi9FZENYWGZsWEhsWHBRQXow?=
 =?utf-8?B?RFJ0WEY4MDFkcUJ3UzloZHY0aEszeXR4Q094UStjS2hKaVI2MVJ6V094Rk1k?=
 =?utf-8?B?RUtXRGV3d2ZwRjNOMTgyMWlZeGtHSDNEYkJ0UmNsWkNsNklrUjNEVEZiZ1d3?=
 =?utf-8?B?eCs3ay9qTERQTDhsVG94YSs3UlVMZnFnYkhxV05lenpybzZsZ2dpOU02em02?=
 =?utf-8?B?UnduUGFzUG9ZK2VFTVV4WHFMQ0JMb1FNclVlYlp4cmVxVTBGVlZRbWxZUzRL?=
 =?utf-8?B?QURrOStoMXNKKzQ1VDBJWTE5MHBtY0h1NUppeGpKcWNOcTR5UWNSSy9iNmhp?=
 =?utf-8?B?TTI3ZXl3VnRpZ2VyaDlwSHJmZTNkZ0lhZjhSKzRtd1Qva0JCV3doSWtWaHBu?=
 =?utf-8?B?YWJic2QxZnhKK3ZGdG5DU3MzS1krTCtTR2tDMkEyTy9mV0FJNm1LN0ZSMnhp?=
 =?utf-8?B?Z2FZTnBzSnAwQktxaW5qQ3ZRSDA2U0w5VlYyREUzTUljVW80R2ppNkhTOTVH?=
 =?utf-8?B?S21kdDBabktMZ3cyUTkwbVhzbktSUlFidUNYaXdBa0QreEdGbDM4cHFTdjdX?=
 =?utf-8?B?aGhFNVBWNzlGWUc1cWRPMXBDZkNkVHFNbTBXcWR5cGFvWmh3eHVwbXRwL0dj?=
 =?utf-8?B?bGEwZTNWM25Ma2tUZkUvTGtSQTI4ZHg5dnNzQnUwRnZCb1AwMzM1Y0pqSEdo?=
 =?utf-8?B?V2J0M202ZmZHTENuWDVNaFZJZmE5NEt5YWZvUnpwYlUwYXZpMlZINEFXZ3pX?=
 =?utf-8?B?bVgrbkY3UlBJenpJRTl4dDVHK093aXV1VlFTYndiazlpRWpuczZUMXJ0aFJ5?=
 =?utf-8?B?WFhuQUNHRm5EM0ovWTM1cUUwSWYvS3lEbERNWEdhWUFFenI5OExmUWJNNWZO?=
 =?utf-8?B?RHBpLy9UZ2RlVTh3NDFoWHFHWHUyVjlVUEo4aXRGb1F5MFVtYUFsY2NFaVdo?=
 =?utf-8?B?M25Pb2pjdHZBSmZGSVpWYlJMakxjOWdSZFVBUjMrMHBDSWtpRkluRkVPUlpj?=
 =?utf-8?B?OVcwbldBekJYbzcxaEFPQXRleGFMcWw5VytoMWlsZDJFQUF1SHN5WjljcEFw?=
 =?utf-8?B?T0ZvYVZaWWd0SVUrL1VlazlaNmpndmVUY2p2ZFRaU2tsOS82SkNqZTY5ci8x?=
 =?utf-8?B?c0ZpSkphZHg5WWVsQUZzVHJQbnFPVVFFcTNWTVJFektTZnJNZzVEbDdWYVIy?=
 =?utf-8?B?eGxWMmozcUZvQWM4aEdBRk8xVkN2dktNU1AxNHpYdjBnYkV5T1ZNS0lvM094?=
 =?utf-8?B?WkxiaVZBc09UcVh1bzhDOTFVSk84YW96Mnp3VEZEQTE1TE9XVGdSSVlCZlBv?=
 =?utf-8?B?WUhNUmZEQ0kyMnM4Q3h4d1dlWStLdW53dGpRYXdXd1JLVGNGMUg5ZzVxUEF4?=
 =?utf-8?B?TTFkS3pnZW0zTW1mZ3FCVnZ5TldkUlYya0g5Umx0WkZaSzVwNUdrTzV5YUVX?=
 =?utf-8?B?OHZMd3o3dWkxK2tPSHFUb2J0V2FjeFVtUXB6SzdwNVBRVWpJbUxaNytRMllE?=
 =?utf-8?B?UmNVejkrd0ZMcHlGWEhUeVNaTE9GSlhtd1hnbmJpYTBUa3MwZVVBdlRIRUhy?=
 =?utf-8?B?Y3M3QUYvUStKS1ppTU1keTVmdjRtazN0TEV0VmxkZ2dCTDRsVlJUSERjeUpo?=
 =?utf-8?B?YkZGYzM0OU5iZkZvTm5CRlhyZE1DQzZqK1ZNS3l0dzFkNEgySm9SMkd2Nnov?=
 =?utf-8?Q?Lip9VdRvupaErUnrovOU1us=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBF2826DB787B54C90473CB07502D3ED@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5deaaf6c-9f5f-4985-6c6c-08da60172bfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 12:49:46.3812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nYAFOD8GN9Nz9v4hvJCpMngVdzOVW9YPyroh1sH4Ei9/hsLUDbUVlma8jjqfRQQi0LGT7iqu/I/s5/cKq6xLMIGicRKYQzC4gIQK1vAtDiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5525
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gSnVsIDA3LCAyMDIyIC8gMTE6NTYsIFN1biBLZSB3cm90ZToNCj4gVGhpcyBpcyBhIHJlZ3Jl
c3Npb24gdGVzdCBmb3IgY29tbWl0IDA2YzRkYTg5YzI0ZQ0KPiBuYmQ6IGNhbGwgZ2VubF91bnJl
Z2lzdGVyX2ZhbWlseSgpIGZpcnN0IGluIG5iZF9jbGVhbnVwKCkNCg0KSGVsbG8gU3VuLCB0aGFu
a3MgZm9yIHRoZSBwYXRjaC4NCg0KSSByZXZlcnRlZCB0aGUgY29tbWl0IDA2YzRkYTg5YzI0ZSBm
cm9tIHRoZSBrZXJuZWwgdjUuMTktcmM1IGFuZCBvYnNlcnZlZCB0aGlzDQp0ZXN0IGNhc2UgcGFz
c2VzLiBJIGNoZWNrZWQgZG1lc2cgYW5kIHNhdyBrZXJuZWwgbWVzc2FnZSBiZWxvdy4gS2VybmVs
IGRpZCBub3QNCnJlcG9ydCB0aGUgQlVHIHdoaWNoIHdhcyBub3RlZCBpbiB0aGUgY29tbWl0IDA2
YzRkYTg5YzI0ZS4gSW5zdGVhZCwgbmJkIGRyaXZlcg0KcHJpbnRlZCBvdXQgYW4gZXJyb3IgImNv
dWxkbid0IGFsbG9jYXRlIGNvbmZpZyIuDQoNCkp1bCAwNyAyMDo0NzowMSByZWRzdW40NXEgdW5r
bm93bjogcnVuIGJsa3Rlc3RzIG5iZC8wMDQgYXQgMjAyMi0wNy0wNyAyMDo0NzowMQ0KSnVsIDA3
IDIwOjQ3OjAxIHJlZHN1bjQ1cSBrZXJuZWw6IGNvdWxkbid0IGFsbG9jYXRlIGNvbmZpZw0KSnVs
IDA3IDIwOjQ3OjAxIHJlZHN1bjQ1cSBrZXJuZWw6IGNvdWxkbid0IGFsbG9jYXRlIGNvbmZpZw0K
SnVsIDA3IDIwOjQ3OjAxIHJlZHN1bjQ1cSBrZXJuZWw6IGNvdWxkbid0IGFsbG9jYXRlIGNvbmZp
Zw0KSnVsIDA3IDIwOjQ3OjAxIHJlZHN1bjQ1cSBrZXJuZWw6IHN5c2ZzOiBjYW5ub3QgY3JlYXRl
IGR1cGxpY2F0ZSBmaWxlbmFtZSAnL2RldmljZXMvdmlydHVhbC9ibG9jay9uYmQwJw0KSnVsIDA3
IDIwOjQ3OjAxIHJlZHN1bjQ1cSBrZXJuZWw6IENQVTogMCBQSUQ6IDEwNDMgQ29tbTogbW9kcHJv
YmUgTm90IHRhaW50ZWQgNS4xOS4wLXJjNSsgIzINCkp1bCAwNyAyMDo0NzowMSByZWRzdW40NXEg
a2VybmVsOiBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAx
OTk2KSwgQklPUyByZWwtMS4xNi4wLTAtZ2QyMzk1NTJjZTcyMi1wcmVidWlsdC5xZW11Lm9yZyAw
NC8wMS8yMDE0DQpKdWwgMDcgMjA6NDc6MDEgcmVkc3VuNDVxIGtlcm5lbDogQ2FsbCBUcmFjZToN
Ckp1bCAwNyAyMDo0NzowMSByZWRzdW40NXEga2VybmVsOiAgPFRBU0s+DQpKdWwgMDcgMjA6NDc6
MDEgcmVkc3VuNDVxIGtlcm5lbDogIGR1bXBfc3RhY2tfbHZsKzB4NWIvMHg3NA0KSnVsIDA3IDIw
OjQ3OjAxIHJlZHN1bjQ1cSBrZXJuZWw6ICBzeXNmc193YXJuX2R1cC5jb2xkKzB4MTcvMHgyMw0K
Li4uDQoNCm9yIHN5c2ZzIHByaW50ZWQgb3V0IGFuIHdhcm5pbmc6DQoNClsgIDM2Ni4wOTg0Nzld
IHJ1biBibGt0ZXN0cyBuYmQvMDA0IGF0IDIwMjItMDctMDcgMjE6MTc6MjINClsgIDM2Ni43NDcx
ODBdIHN5c2ZzOiBjYW5ub3QgY3JlYXRlIGR1cGxpY2F0ZSBmaWxlbmFtZSAnL2RldmljZXMvdmly
dHVhbC9ibG9jay9uYmQwJw0KWyAgMzY2Ljc0OTY1M10gQ1BVOiAwIFBJRDogMTUwOCBDb21tOiBt
b2Rwcm9iZSBOb3QgdGFpbnRlZCA1LjE5LjAtcmM1KyAjMg0KWyAgMzY2Ljc1MTY4MF0gSGFyZHdh
cmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1MgcmVs
LTEuMTYuMC0wLWdkMjM5NTUyY2U3MjItcHJlYnVpDQpsdC5xZW11Lm9yZyAwNC8wMS8yMDE0DQpb
ICAzNjYuNzU1MTY5XSBDYWxsIFRyYWNlOg0KWyAgMzY2Ljc1NTk5MV0gIDxUQVNLPg0KWyAgMzY2
Ljc1NjcyMl0gIGR1bXBfc3RhY2tfbHZsKzB4NWIvMHg3NA0KWyAgMzY2Ljc1NzkwOV0gIHN5c2Zz
X3dhcm5fZHVwLmNvbGQrMHgxNy8weDIzDQouLi4NCg0KSXQgd291bGQgYmUgdGhlIGJldHRlciB0
byBjYXRjaCB0aGVzZSBlcnJvciBhbmQgd2FybmluZyBtZXNzYWdlIGluIHRoZSB0ZXN0DQpjYXNl
LiBGb3IgZXhhbXBsZSwgZm9sbG93aW5nIGh1bmsgd2lsbCBjYXRjaCBpdC4NCg0KZGlmZiAtLWdp
dCBhL3Rlc3RzL25iZC8wMDQgYi90ZXN0cy9uYmQvMDA0DQppbmRleCA2YjJjNWZmLi45Mjc3YzEw
IDEwMDc1NQ0KLS0tIGEvdGVzdHMvbmJkLzAwNA0KKysrIGIvdGVzdHMvbmJkLzAwNA0KQEAgLTQ3
LDYgKzQ3LDEyIEBAIHRlc3QoKSB7DQogICAgICAgIH0gMj4vZGV2L251bGwNCg0KICAgICAgICBf
c3RvcF9uYmRfc2VydmVyX25ldGxpbmsNCisNCisgICAgICAgaWYgX2RtZXNnX3NpbmNlX3Rlc3Rf
c3RhcnQgfCBncmVwIC1xIC1lICJjb3VsZG4ndCBhbGxvY2F0ZSBjb25maWciIFwNCisgICAgICAg
ICAgLWUgImNhbm5vdCBjcmVhdGUgZHVwbGljYXRlIGZpbGVuYW1lIjsgdGhlbg0KKyAgICAgICAg
ICAgICAgIGVjaG8gIkZhaWwiDQorICAgICAgIGZpDQorDQogICAgICAgIGVjaG8gIlRlc3QgY29t
cGxldGUiDQogfQ0KDQoNCj4gDQo+IFR3byBjb25jdXJyZW50IHByb2Nlc3Nlc++8jG9uZSBsb2Fk
IGFuZCB1bmxvY2sgbmJkIG1vZHVsZQ0KPiBjeWNsaWNhbGx5LCB0aGUgb3RoZXIgb25lIGNvbm5l
Y3QgYW5kIGRpc2Nvbm5lY3QgbmJkIGRldmljZSBjeWNsaWNhbGx5Lg0KPiBMYXN0IGZvciAxMCBz
ZWNvbmRzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU3VuIEtlIDxzdW5rZTMyQGh1YXdlaS5jb20+
DQo+IC0tLQ0KPiB2MS0+djI6IA0KPiAxLmNoYW5nZSBpbnN0YWxsL3VuaW5zdGFsbCB0byBsb2Fk
L3VubG9jaw0KDQpNeSBndWVzcyBpcyB0aGF0IENocmlzdG9waCBtZWFudCAibG9hZC91bmxvYWQi
Lg0KDQo+IDIudXNlIF9oYXZlX21vZHVsZXMgaW5zdGVhZA0KPiANCj4gIHRlc3RzL25iZC8wMDQg
ICAgIHwgNTIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKw0KPiAgdGVzdHMvbmJkLzAwNC5vdXQgfCAgMiArKw0KPiAgdGVzdHMvbmJkL3JjICAgICAg
fCAxOCArKysrKysrKysrKysrKysrKysNCj4gIDMgZmlsZXMgY2hhbmdlZCwgNzIgaW5zZXJ0aW9u
cygrKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNzU1IHRlc3RzL25iZC8wMDQNCj4gIGNyZWF0ZSBtb2Rl
IDEwMDY0NCB0ZXN0cy9uYmQvMDA0Lm91dA0KPiANCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL25iZC8w
MDQgYi90ZXN0cy9uYmQvMDA0DQo+IG5ldyBmaWxlIG1vZGUgMTAwNzU1DQo+IGluZGV4IDAwMDAw
MDAuLjZiMmM1ZmYNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi90ZXN0cy9uYmQvMDA0DQo+IEBA
IC0wLDAgKzEsNTIgQEANCj4gKyMhL2Jpbi9iYXNoDQo+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMy4wKw0KPiArIyBDb3B5cmlnaHQgKEMpIDIwMjIgU3VuIEtlDQo+ICsjDQo+ICsj
IFJlZ3Jlc3Npb24gdGVzdCBmb3IgY29tbWl0IDA2YzRkYTg5YzI0ZQ0KPiArIyBuYmQ6IGNhbGwg
Z2VubF91bnJlZ2lzdGVyX2ZhbWlseSgpIGZpcnN0IGluIG5iZF9jbGVhbnVwKCkNCj4gKw0KPiAr
LiB0ZXN0cy9uYmQvcmMNCj4gKw0KPiArREVTQ1JJUFRJT049Im1vZHVsZSBsb2FkL3VubG9jayBj
b25jdXJyZW50bHkgd2l0aCBjb25uZWN0L2Rpc2Nvbm5lY3QiDQo+ICtRVUlDSz0xDQo+ICsNCj4g
K3JlcXVpcmVzKCkgew0KPiArCV9oYXZlX21vZHVsZXMNCg0KVGhpcyBoZWxwZXIgZnVuY3Rpb24g
bmVlZHMgYW4gYXJndW1lbnQgYXMgdGhlIG1vZHVsZSBuYW1lIHRvIGNoZWNrLCBuYmQuDQoNCi0t
IA0KU2hpbidpY2hpcm8gS2F3YXNha2k=
