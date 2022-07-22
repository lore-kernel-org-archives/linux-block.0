Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFFCC43334
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 00:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiGVAnv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 20:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGVAnu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 20:43:50 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D819395C1C
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 17:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658450629; x=1689986629;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mflNGKKiLcFwK5Aucl8Q02AvM8WlbnU+7k9kvK5tHm4=;
  b=RClRbh9DyAk2ixxL1dCeKssYl5by5//yvZKunx8eWoPU8j4u5xWLozsC
   mzC9/q2Ak6pPDx5KYWGcRbpD6KHtEPJXH6EvcjrKM2E5IkDYJk6ns21VK
   sh+fX13YbDLY90FXg8mo0oIkROuSHFnK92EcmrfSOVRkqOwyGOtPGduks
   CqvKHYYqoJVACk9fze8YiubJd5eVsJiCMEYe9bYE8RjUKxK8DqyWQ4PnT
   kTQdF1WKTZ2TpOcyO/meKPYBpI48e5y8b6EdZWqGnsoeShKVUtzWeRT8k
   NNewHiy33FLfua0OZnGq6xxFpMX/txPCr1neudf5Gn4EvEq0RUm/Juv3z
   g==;
X-IronPort-AV: E=Sophos;i="5.93,184,1654531200"; 
   d="scan'208";a="310927378"
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2022 08:43:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhL7A94GhbxOFWq9xqgzrk8qZF2mgBefE2eBUPYuYA0GjxyF/c+jNf2GOKusmIomRETRFAo3AMJ0t33YVWiSyyZWwTKSNv3ZeDZUuUcKZPV592P7bu7vPgImPctnkhAkM0FYUXZ8nML58RIrtCUjuISJcAOju85DB2L6h5H3DOg3aCB7d46LP9Gy4ogbkDbT6FB3nr31kQ8yoMVZthMwBOMuLLpBVWI9pkkNX4660UcKA0P+C/T6NGrWUTtyJUvvHg6+rYWmInx2qeErebb3nl7Y8trThd9qGGy4QYzfF6bhn0hrbDVNVMVdxKafW25CheixrVBwdwp8/RfdzPrBKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mflNGKKiLcFwK5Aucl8Q02AvM8WlbnU+7k9kvK5tHm4=;
 b=VxbYRNO8VfwHRgLGXQ2cnwoD1zoUgNdBg2SPNVU2qgcSviHN3hp/e/tp24ro8BhWXMj/Ec1aF4fSmORizxp7oMcojuFGqOqVRpGT9NnyKpAC4ylETza92SFh6K3kvDrKOM7ElKFQAgqHoPcSMmMOTNCqjiFrxQ+lNqTL1KBU+A/3dmA9ailSX0ZijShgM6g6Nci1w7DKnPvjaJQ7WAYeECSEYDbfV91hMH1HHeH+4qTZL7PFxbA3OwY8bGcXSV2ZU1BmnyW2Ont6v9TFwRFSBBAw2bs/32+EU8k0FplbiDd95uvxHszfWqc5hbWNkQCqhyjXth6j3K7ptx5kfMCNQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mflNGKKiLcFwK5Aucl8Q02AvM8WlbnU+7k9kvK5tHm4=;
 b=KJrrsM49i8I9jH/Ia0eQ66f9xB/j3Dti2wRGjOElVfwWFzlrjnB7EYQdzPnHUhQDLhPgg96tPKiHYy6bK1jtSfFhUMmr6NQ2NpFMCRWf2aQp1AYo73aP+4ejOfiRT14SZZm5ZaDs5pZFwT+I0LnhftdiFIx1M1q4s4xUFxj7Ej4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB5996.namprd04.prod.outlook.com (2603:10b6:5:122::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.21; Fri, 22 Jul 2022 00:43:38 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833%9]) with mapi id 15.20.5438.024; Fri, 22 Jul 2022
 00:43:38 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Sun Ke <sunke32@huawei.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH blktests v2] nbd: add a module load and device connect
 test
Thread-Topic: [PATCH blktests v2] nbd: add a module load and device connect
 test
Thread-Index: AQHYkbPG0qKoEERDRUSuUBLWei8a4q1y3KmAgBJ22QCABFE/gA==
Date:   Fri, 22 Jul 2022 00:43:37 +0000
Message-ID: <20220722004337.zldwcmtigttaaawl@shindev>
References: <20220707035610.3175550-1-sunke32@huawei.com>
 <20220707124945.c2rd677hjwkd7mim@shindev>
 <06a95726-8811-eca2-2039-e0686d87fb87@huawei.com>
In-Reply-To: <06a95726-8811-eca2-2039-e0686d87fb87@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f13e5a4a-dd52-4521-f7ad-08da6b7b379c
x-ms-traffictypediagnostic: DM6PR04MB5996:EE_
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oKh50HlNRaa5YMFvqSy9XLbGnj+v81q6DDcszd5eRy3T8VPlrEjnTHym2sKV0RxPZgnQG7nwg4gG8bQKgJJRWEBv2k5NwViLAlqkrqFEECmpAY2e9PDq70mgk8z2quRjPaduF2YdpV/W+Gt4VyujQgED5a/yZkfQEaTlvj/vLguJ3XI6F2BPaY8NEw0A78M2+ckA0Z85OhmLBNGYv84Lza55ZY0YbxBoqyTnSlDe7HyUN91ADyAot4i/wRcyIepkfWEQcJyQeprD/HElrPBQElHLJs2KchoWgo1z6YndJ9OsCljQ2inqH/kO57ipVh0vMIugoveQVNxbRsPAW6PhxQ+i3x1tYRXvCslvYJzMGw/NETC1yOm8Hxb6MeQvjZ1NT9co8AwAhg8gQndGR2gwjoFJbJ14dgLjdQhvPXAPpmxdQkIZkFBzWPnIb7k2Ty/RX0azZ26YiUtOF/e0JzgGvtethVAOpeCJokVTyN4385UDa7NYmaeO1Z45YZMN/Mu6wnVn6ZgMb2dQxXV0UAo5eYCE3Pxhbw/XCYgRwMhItmBfX0RdYrOclxYLZghURoc2fzURGZqeocYEf6FoscLfDxY40e2bRmLD4pi+yqDzUoj1MHPqxJgr6bevO52CBe90eGLqiQRCFrzrzbnhZNrUrKW5sSMh5jJyfTRXjEw/MfOFduWypHi30+j5suhSdFzos41PLsni7fxYRTHWBQgq9xC9+UPLDrrwKiQTmW1j15huG2OGxVu2w7tbScfE4rHKyQWghBT95Xrx7G331aMfx4hiQhnOrLVO09WLc16bGNuKKyzQGoM3MHJ40COv63KV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(39860400002)(136003)(366004)(346002)(376002)(396003)(66946007)(76116006)(38100700002)(33716001)(186003)(1076003)(66476007)(4326008)(26005)(8676002)(64756008)(66446008)(83380400001)(66556008)(9686003)(6512007)(6506007)(8936002)(6486002)(38070700005)(41300700001)(71200400001)(478600001)(122000001)(6916009)(44832011)(5660300002)(2906002)(3716004)(82960400001)(91956017)(54906003)(86362001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTF4OTZPR1d6b1lVakpJbllXM3VhMDRLRFRJRU0zUFYrY0MrWGY1MzgyS1FN?=
 =?utf-8?B?S3VlYUtrc05yNlZvcWVybEoySWFRMWhxK2l3UFhUejlxMTRmYTdhdDh6cXhN?=
 =?utf-8?B?Z0l4emMvWEd3d0V0Y2IxeTlZMEZVWURjczdzbWZEUEZzbHM4WlV1OSszcTlH?=
 =?utf-8?B?Vm5SWWdCVkRUWVEyYWlJcFF6b1pVUWlXZ1VPMmhxd243TmF0S2I2U2Uzb2ZK?=
 =?utf-8?B?OTVFRG5pNSt1VlROZHNNZ0FpTlJyYjRQZGhNVlp0YkVPSVNYSFBSaUNsRkpG?=
 =?utf-8?B?YzhxbHkvM1AreURkMGRkOWhSREZwdzRvVVRTOFFKQ3A4aHNLR3k4dUJlL05Q?=
 =?utf-8?B?TW44UFNzL280WUlyV09oRXN5UlUzci80YmRyOXd5UlA5czVacGtMMEpoT0g5?=
 =?utf-8?B?VjZFbjZVZWFwb2ltTDZHN0lLd1FiSDdXTTJ4T1d4dW8yWittV3cxSC9LQ2Zu?=
 =?utf-8?B?b2UzYmlLUXlidytoYWlnV3hqWnBRd3pQS0ZhdVlZZW8vTmt3WVZIYkFLMHg3?=
 =?utf-8?B?OG5nb1lFRkxtUXlFb2VPdUVyeUZDQ1lRNlJHM1BpMkhGMk9yUGl2UzZiUnFh?=
 =?utf-8?B?cEdRQW1DY2FHSkJnaFlxVHR1a0ZQSzc0SENXdjJKN2pZZ1hDOEZrcnNpNitZ?=
 =?utf-8?B?SjlRa2k1TkJZVTYwd2JmNXM2RkgyOUVPRUM2ZkhWd1ROVmZuWWpDUTE1ZzNP?=
 =?utf-8?B?bnpGbzFJZlNvNGIvSk1uN2dpK0tRSWxrRkwySktzYXd5bHV5cVFtWEg1ckxo?=
 =?utf-8?B?ZGJKckE5OEN3Wm52Wkt4WUtxZkZlbzNCdDYxZkNuc1hEZlpQNkxYYVlYTllW?=
 =?utf-8?B?M1FKYjNJa2djbmt1Ym52OXE5ZzNiYmFsbHZNTFBWN0NJQzBWMkh3STlyNlAv?=
 =?utf-8?B?YWRDUFJua2haRmFFc25YOVhoSEJKRGVzN3ByUWZoZnhyNjNaWm12TE5hYTFP?=
 =?utf-8?B?UHovcmhPanVWZTg3SGRqNC9BVjlmQXZtWEtDU2NmcTBucnNXZEdCcWlXaGYz?=
 =?utf-8?B?Sy9MSGVibXc0Wk1nZWJXUStxczRQR3FXUTRWMVpQTXVvTWJ6ZFhTeFMzOVht?=
 =?utf-8?B?UFhyczVHRDZPc3UwbHhXT1ZHMkJzTlB0OU5WMkZUY0xhQUlZbXlsdmt6OFY4?=
 =?utf-8?B?eFJMU292dTlMNHVna1ZMZEhiUEtOL1NSN0pPSHVBclR6dE82Z2tPNXRwbUlt?=
 =?utf-8?B?UXl3ajRTQ2ZnYzM3dVFUQVdKYitKcGFoZW5BdlFubkdQUVg4b1ozY3MwK2hC?=
 =?utf-8?B?QUVmTkdHaytBMlVldEFnQUZzcFRlZUR5dGNIK0FKTDJMemZmZEpWTnVBZTEw?=
 =?utf-8?B?TXhuK1VxVXdjQmtPU2MrdzFONDVhR0lnM25mdTZYOFFpSng1aVQ3UlJNc1RG?=
 =?utf-8?B?Tk16bEpRQU5kcXgrZjQvaTFCOTZiNythdldOM200RU13b0hCRXdxS3YwaFkw?=
 =?utf-8?B?d25ZSDVJOVRGWVZHMnEwbE9qUU9KUURHR20vbzViK1ZCVDlGMXlUbEd0RHpu?=
 =?utf-8?B?YkltWDNGdEpZdG5hWlJCR05DMVNDMjlZSTNSaDNNdUROOXVrUCt2ZFNpUzUx?=
 =?utf-8?B?WWF2K3l1ZElTRmtKZENtd2JWNkQ4ajZ1dDAzNEhreTIwelBMTEk1VXA2aHdN?=
 =?utf-8?B?dUFMZmMvYzhaYjBNSUhFRXpCeXpXTElhd21iZnZkR1M4UmVBUHVnMWlWVGVP?=
 =?utf-8?B?UWlYUG8xZUFVTmFsbHdXT3QzamN6T0h6K0xyenRhWW0wS3luL1k4a1RPOGk0?=
 =?utf-8?B?dnAwSm5wUGVNRFZGNEpsa1oyVC9RbnE0ayszVGJjTEs3ZlVoWkNoWUpldk44?=
 =?utf-8?B?ZVZrVDVqWDFDZ1dnRlhjV04ydEhvalRyNWh2K1dZckpVcDNZYjBOS2YvNVp1?=
 =?utf-8?B?ZUxjcDRGTXlyUmhwdTR3UkRja2pBZ3g2eG9XaTQ4T2VzZXk5UVFEQVFQTGlB?=
 =?utf-8?B?WDBubGUvYWdRbWNaMW5tckZGYytlNy9BVk1JUFU2Rm13QTlaQTlPdHJQa2JZ?=
 =?utf-8?B?L1paeUVjYkxuaW5McUp2TWVIVkk4N0wwUUk2aXhBMGlqYk0zZDZVWUwvakp3?=
 =?utf-8?B?Vzg1NFlwbDJKYVErSUFuWndMZDZNTVg3K2VXdklyejgzclI2b0JzeVRFcy82?=
 =?utf-8?B?cmpmQm8rRkxNMk9VM1pvRmYyeGJGeWgrbmtaNzVLMXQvVjdQb3hkNmprZzd6?=
 =?utf-8?Q?56f5kQ8v1SY09pI6aRdeITU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E89DF1C81303043AD6E07B646CC5ECE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f13e5a4a-dd52-4521-f7ad-08da6b7b379c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 00:43:38.4217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VuiB2CqXcIiFAdMiWfaKHZ59VoHY815TlsfYwl0VCA9s5s8sEM/LsZ0avEyY8UGcb19gHW/3e7bWmVNo2FcwKVUJ7fXLDG02FdDP7QnATsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5996
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gSnVsIDE5LCAyMDIyIC8gMTQ6NDcsIFN1biBLZSB3cm90ZToNCj4gDQo+IA0KPiDlnKggMjAy
Mi83LzcgMjA6NDksIFNoaW5pY2hpcm8gS2F3YXNha2kg5YaZ6YGTOg0KPiA+IE9uIEp1bCAwNywg
MjAyMiAvIDExOjU2LCBTdW4gS2Ugd3JvdGU6DQo+ID4gPiBUaGlzIGlzIGEgcmVncmVzc2lvbiB0
ZXN0IGZvciBjb21taXQgMDZjNGRhODljMjRlDQo+ID4gPiBuYmQ6IGNhbGwgZ2VubF91bnJlZ2lz
dGVyX2ZhbWlseSgpIGZpcnN0IGluIG5iZF9jbGVhbnVwKCkNCj4gPiANCj4gPiBIZWxsbyBTdW4s
IHRoYW5rcyBmb3IgdGhlIHBhdGNoLg0KPiA+IA0KPiA+IEkgcmV2ZXJ0ZWQgdGhlIGNvbW1pdCAw
NmM0ZGE4OWMyNGUgZnJvbSB0aGUga2VybmVsIHY1LjE5LXJjNSBhbmQgb2JzZXJ2ZWQgdGhpcw0K
PiA+IHRlc3QgY2FzZSBwYXNzZXMuIEkgY2hlY2tlZCBkbWVzZyBhbmQgc2F3IGtlcm5lbCBtZXNz
YWdlIGJlbG93LiBLZXJuZWwgZGlkIG5vdA0KPiA+IHJlcG9ydCB0aGUgQlVHIHdoaWNoIHdhcyBu
b3RlZCBpbiB0aGUgY29tbWl0IDA2YzRkYTg5YzI0ZS4gSW5zdGVhZCwgbmJkIGRyaXZlcg0KPiA+
IHByaW50ZWQgb3V0IGFuIGVycm9yICJjb3VsZG4ndCBhbGxvY2F0ZSBjb25maWciLg0KPiA+IA0K
PiA+IEp1bCAwNyAyMDo0NzowMSByZWRzdW40NXEgdW5rbm93bjogcnVuIGJsa3Rlc3RzIG5iZC8w
MDQgYXQgMjAyMi0wNy0wNyAyMDo0NzowMQ0KPiA+IEp1bCAwNyAyMDo0NzowMSByZWRzdW40NXEg
a2VybmVsOiBjb3VsZG4ndCBhbGxvY2F0ZSBjb25maWcNCj4gPiBKdWwgMDcgMjA6NDc6MDEgcmVk
c3VuNDVxIGtlcm5lbDogY291bGRuJ3QgYWxsb2NhdGUgY29uZmlnDQo+ID4gSnVsIDA3IDIwOjQ3
OjAxIHJlZHN1bjQ1cSBrZXJuZWw6IGNvdWxkbid0IGFsbG9jYXRlIGNvbmZpZw0KPiA+IEp1bCAw
NyAyMDo0NzowMSByZWRzdW40NXEga2VybmVsOiBzeXNmczogY2Fubm90IGNyZWF0ZSBkdXBsaWNh
dGUgZmlsZW5hbWUgJy9kZXZpY2VzL3ZpcnR1YWwvYmxvY2svbmJkMCcNCj4gPiBKdWwgMDcgMjA6
NDc6MDEgcmVkc3VuNDVxIGtlcm5lbDogQ1BVOiAwIFBJRDogMTA0MyBDb21tOiBtb2Rwcm9iZSBO
b3QgdGFpbnRlZCA1LjE5LjAtcmM1KyAjMg0KPiA+IEp1bCAwNyAyMDo0NzowMSByZWRzdW40NXEg
a2VybmVsOiBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAx
OTk2KSwgQklPUyByZWwtMS4xNi4wLTAtZ2QyMzk1NTJjZTcyMi1wcmVidWlsdC5xZW11Lm9yZyAw
NC8wMS8yMDE0DQo+ID4gSnVsIDA3IDIwOjQ3OjAxIHJlZHN1bjQ1cSBrZXJuZWw6IENhbGwgVHJh
Y2U6DQo+ID4gSnVsIDA3IDIwOjQ3OjAxIHJlZHN1bjQ1cSBrZXJuZWw6ICA8VEFTSz4NCj4gPiBK
dWwgMDcgMjA6NDc6MDEgcmVkc3VuNDVxIGtlcm5lbDogIGR1bXBfc3RhY2tfbHZsKzB4NWIvMHg3
NA0KPiA+IEp1bCAwNyAyMDo0NzowMSByZWRzdW40NXEga2VybmVsOiAgc3lzZnNfd2Fybl9kdXAu
Y29sZCsweDE3LzB4MjMNCj4gPiAuLi4NCj4gPiANCj4gPiBvciBzeXNmcyBwcmludGVkIG91dCBh
biB3YXJuaW5nOg0KPiA+IA0KPiA+IFsgIDM2Ni4wOTg0NzldIHJ1biBibGt0ZXN0cyBuYmQvMDA0
IGF0IDIwMjItMDctMDcgMjE6MTc6MjINCj4gPiBbICAzNjYuNzQ3MTgwXSBzeXNmczogY2Fubm90
IGNyZWF0ZSBkdXBsaWNhdGUgZmlsZW5hbWUgJy9kZXZpY2VzL3ZpcnR1YWwvYmxvY2svbmJkMCcN
Cj4gPiBbICAzNjYuNzQ5NjUzXSBDUFU6IDAgUElEOiAxNTA4IENvbW06IG1vZHByb2JlIE5vdCB0
YWludGVkIDUuMTkuMC1yYzUrICMyDQo+ID4gWyAgMzY2Ljc1MTY4MF0gSGFyZHdhcmUgbmFtZTog
UUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1MgcmVsLTEuMTYuMC0w
LWdkMjM5NTUyY2U3MjItcHJlYnVpDQo+ID4gbHQucWVtdS5vcmcgMDQvMDEvMjAxNA0KPiA+IFsg
IDM2Ni43NTUxNjldIENhbGwgVHJhY2U6DQo+ID4gWyAgMzY2Ljc1NTk5MV0gIDxUQVNLPg0KPiA+
IFsgIDM2Ni43NTY3MjJdICBkdW1wX3N0YWNrX2x2bCsweDViLzB4NzQNCj4gPiBbICAzNjYuNzU3
OTA5XSAgc3lzZnNfd2Fybl9kdXAuY29sZCsweDE3LzB4MjMNCj4gPiAuLi4NCj4gPiANCj4gSSBy
ZXRyeSBpdCBvbiBjb21taXQgOThkNDBlNzY2NTJlLCBpdCBjYW4gcmVwcm9kdWNlIHRoZSBCdWcu
DQoNCkkgc2VlLCB0aGVuIHNvbWUgY29uZGl0aW9ucyBpbiBteSBlbnZpcm9ubWVudCBhcmUgaGlk
aW5nIHRoZSBCdWcuDQoNCj4gDQo+ID4gSXQgd291bGQgYmUgdGhlIGJldHRlciB0byBjYXRjaCB0
aGVzZSBlcnJvciBhbmQgd2FybmluZyBtZXNzYWdlIGluIHRoZSB0ZXN0DQo+ID4gY2FzZS4gRm9y
IGV4YW1wbGUsIGZvbGxvd2luZyBodW5rIHdpbGwgY2F0Y2ggaXQuDQo+ID4gDQo+ID4gZGlmZiAt
LWdpdCBhL3Rlc3RzL25iZC8wMDQgYi90ZXN0cy9uYmQvMDA0DQo+ID4gaW5kZXggNmIyYzVmZi4u
OTI3N2MxMCAxMDA3NTUNCj4gPiAtLS0gYS90ZXN0cy9uYmQvMDA0DQo+ID4gKysrIGIvdGVzdHMv
bmJkLzAwNA0KPiA+IEBAIC00Nyw2ICs0NywxMiBAQCB0ZXN0KCkgew0KPiA+ICAgICAgICAgIH0g
Mj4vZGV2L251bGwNCj4gPiANCj4gPiAgICAgICAgICBfc3RvcF9uYmRfc2VydmVyX25ldGxpbmsN
Cj4gPiArDQo+ID4gKyAgICAgICBpZiBfZG1lc2dfc2luY2VfdGVzdF9zdGFydCB8IGdyZXAgLXEg
LWUgImNvdWxkbid0IGFsbG9jYXRlIGNvbmZpZyIgXA0KPiA+ICsgICAgICAgICAgLWUgImNhbm5v
dCBjcmVhdGUgZHVwbGljYXRlIGZpbGVuYW1lIjsgdGhlbg0KPiA+ICsgICAgICAgICAgICAgICBl
Y2hvICJGYWlsIg0KPiA+ICsgICAgICAgZmkNCj4gPiArDQo+ID4gICAgICAgICAgZWNobyAiVGVz
dCBjb21wbGV0ZSINCj4gPiAgIH0NCg0KU3RpbGwgSSB0aGluayB0aGUgaHVuayBhYm92ZSBhZGRz
IHZhbHVlIHRvIHRoZSBuZXcgdGVzdCBjYXNlLCBzaW5jZSBpdCBjYW4gY2F0Y2gNCnRoZSBCdWcg
YXMgd2VsbCBhcyB0aGUgdW5leHBlY3RlZCBrZXJuZWwgbWVzc2FnZXMuIEkgc2F3IHlvdSBhZGRl
ZCB0aGUgaHVuayB0bw0KdjMuIFRoYW5rcy4NCg0KLS0gDQpTaGluJ2ljaGlybyBLYXdhc2FraQ==
