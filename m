Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBAFC54EBD
	for <linux-block@archiver.kernel.org>; Thu, 12 Jan 2023 13:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjALNOf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Jan 2023 08:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjALNOe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Jan 2023 08:14:34 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BB019285
        for <linux-block@vger.kernel.org>; Thu, 12 Jan 2023 05:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673529272; x=1705065272;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VNuDnr6j0FwJggFhTgGZEvfgAKuZo7UI4jKpgnbiW8s=;
  b=XAHwuGIADXGwqYdufpZjoHRIZS0SnDeNd4qcEI5FOmPmK4Z6r6Dh6mhK
   6af1PDcoZahpZptt1mJrOQVhYljkrA6VJzb/V5x8OrV9j9gHn1W7fGW5N
   ShMGu7vnsz6pWjqrfJE/nmir+X53VJMVqc1nu+15JkpNkyvY2kuXz/B+l
   VvDxlSLgmA4MQVFgaJ7l5470rH9wib9vdzsds4HAuiuj2ohwmCO4cqGUQ
   L8XpWz0SVdpsrcs4EFu6QdZD0fbZt0Bc86/9VjTIPEW5iLP5esg4v6E5a
   kHUhUFEHQangtEWynaugIldrL1ol80m2/t0aQqO/+jjthK8NrQnu0AlCT
   A==;
X-IronPort-AV: E=Sophos;i="5.97,319,1669046400"; 
   d="scan'208";a="332629359"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2023 21:14:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vbs5kDHRCtDc51VoPzkG5EgacNHjrsLhH1CFp0ooMUu9Up0BOdSTu4Nztivs9AdSJELx75ya/CzAbWVQX3NH+5+nIZVlhugWn/DG8WpH9ZvwzuXIEns/6OM42a6SABM6hczyqWPFwG5yauw/9Vy3tzWZwbfdzW5gnfk1PWyOsZgxgZGFIsU0bcIyyzDSAcxidgiYv14MGnOznUi7ShlBDFplKq3gYXnqM7C9I4GBoAsjxN0BMHBjQuSqUDk3rt/B3XhXeTBpudwHBfCAAdoYXgOIKfojpIpKP+iQf/PNK+Qms43x2UP1JoW7zF8qzvDpKLomnl/3r0LGFRi9O8YHfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNuDnr6j0FwJggFhTgGZEvfgAKuZo7UI4jKpgnbiW8s=;
 b=MqH05R70IjW408LarGyeKYZyam63cjoKfkuVYQz/ZK1YaveRgEPpDo0dRiF9dviUclLH5eoRbkjjgjq1PkX51g/7SNlj8Z+TlI8WvxPUVTlY8MFyWm+02qDLURATs/RDq33n/6+p8MdWQpqy1Z15u2c7HGSepcF7Oko7SrS+WFYL+Jx06L83gWUQx8PXlqsk3XH3bEl3o4E1VdllWRAP47AvTxTdbpKo3RDNc4fUSA9yXZG0g2sWiIk3Oe6FWgHl6bYOmxmvLugxvX5E2srP6rIsj7Zisb6qQrEVM7angsnludsGdxszbokN1gcMXm2mT2lD8ULHZ5cqipH2uvcdjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNuDnr6j0FwJggFhTgGZEvfgAKuZo7UI4jKpgnbiW8s=;
 b=Nrh7N8l0a8a7eC9AQcTUi1mcXEDKoecTDvWyFWu/gNFjZ2QWudKgAGGnKuJI2UNfUm+4rZbxTFf13ZJFEtV5I84emyMfaANxRhcydzoUO6m0UA4U2FUUPftYLwQPuxqrqFqQ/3xW7hLND8y2kuav84q0KV7DwllCJZqR3NkgBRg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN6PR04MB0708.namprd04.prod.outlook.com (2603:10b6:404:d3::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13; Thu, 12 Jan 2023 13:14:27 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::e5db:3a3e:7571:6871]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::e5db:3a3e:7571:6871%9]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 13:14:27 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [bug report] BUG: KASAN: use-after-free in bic_set_bfqq
Thread-Topic: [bug report] BUG: KASAN: use-after-free in bic_set_bfqq
Thread-Index: AQHZJnpnPtmIPiOF+0WDV5g4YvQloq6aqkOAgAAYXwA=
Date:   Thu, 12 Jan 2023 13:14:27 +0000
Message-ID: <20230112131426.bjosgrpfq6xmazci@shindev>
References: <20230112113833.6zkuoxshdcuctlnw@shindev>
 <6933fa2d-014c-8773-39d9-680ad9fca98c@huaweicloud.com>
In-Reply-To: <6933fa2d-014c-8773-39d9-680ad9fca98c@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BN6PR04MB0708:EE_
x-ms-office365-filtering-correlation-id: 3071b27a-8a44-45e9-6677-08daf49eee9f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CAFGAPJPnM1pmuxGeZupRy+Y6JSsgBh0Wz0etlpjBLHe7xrgrs3fUNJcJhA19jIpYZBtKObtLdHRKiB25Se8FcLqzkkWcjRvufq5ABDgzIMxyF8cT5X0v+AuxKYuvb8K0+6Sv5wfM9RmnPkYIIjaCLdylbRyvBT9T5cSajEZwxnBgO6BhD/Wpxnh29i1KaeAN+iXZIY/EalRrZfcnAhce3NdBGjaHetI3B/eU6/PrBDibZ9/XihMMPoWKK8I+mK2S1eTKrrbxvx64sNaHo2cGCx8kaMe79wwsb+pOtZ/dq9XQHQGtUj5Um2tmuzSIaSZDRkhSNzhEnQ3cb/lm2x2KSmBwiJvTMddYIZ3CqwKKvAyVZ0xBTAm9gmz6JgX45Qnh5/KBXwE3y56aYZiVAK5iBrxs5h0lFCuvXUmhuQBX3pIf4XW/QNKKRHJIt5k//CJihmWMepsqyAJ9mEL8jO/hfX9jt+AuLr/CRnQLeMTFDfI3JzueN1nAmtt9polF9vAhaEb7Nf26YdWApMU8N2ijpH4WWFdfF1Jr6Cd0yjlAEXYDKon1nHiuVHaAHrOv0BbKaMpOi3ts2ms1TCxUmQDeh1R9Lg0eqgCZVyjuQNkV0FwC0yyDoXEl0hC0MO2W5UC/IivK7L/WNNScd55ImT1hbVt/Ieit+wlrI/+mOqAH/BP2pycGxB+4mIfNRAH0UXGY3xIAhOyypXuYn6g9ckvbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199015)(71200400001)(66946007)(8676002)(66476007)(91956017)(76116006)(64756008)(66446008)(66556008)(6486002)(9686003)(6506007)(478600001)(6512007)(26005)(186003)(4326008)(6916009)(83380400001)(41300700001)(5660300002)(44832011)(8936002)(2906002)(38100700002)(122000001)(33716001)(82960400001)(38070700005)(316002)(54906003)(1076003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUFnanBzTVpmdk9DenE0d0pJQm9vRXdSejlvNThQWm1md1dKT2FsTkp1eVc4?=
 =?utf-8?B?b2tjMDJYUmw3UXlxK0hkRkdqL2dMWThWcFcxa0NXWmg0L3JwYzlFeDNXTklH?=
 =?utf-8?B?OUoyVlpvakgvR29WYXZpQ3hPQitBdEhpMXRYd2p4Znp5TjV4dnVQNERvbHFX?=
 =?utf-8?B?TVMrN0lIaDJRSVpVQVlFczh6RUlZOGN0Wm9GNlRZdEM1YUVzQTNNZ2tMbTdL?=
 =?utf-8?B?QUVmVFZ3aHNaMHdFaG5lQ0RpK3lEYWg5NXR0ZVBydWhJUkVJUnd4TkdwSXNs?=
 =?utf-8?B?OWVDZDlMQ1F1bElrZHAzb0RZUGZpWW1scldUYlR2RDdYajZkaUY5ZFVnVXd1?=
 =?utf-8?B?MGZxNDJQUitQZC9hZC9FWWFMMko5T3F6dVliY0Vpb09EQlkranAvckZIMjkr?=
 =?utf-8?B?U2dyRzJZTVkvczlEbWE2ZGwwMnlPL0pmdEhHYjRRa0pDdytzM29oK0ZOazVD?=
 =?utf-8?B?MlFIUWVBYThYQTVtV3hBSGh3VnhCOS9admhVV0lJb3pBN1FGQ2dwL2Y5dkty?=
 =?utf-8?B?dFlyenZTbTlMeTBqUzIrY2JydmJiRVkrS0hYVGFXMHlCTlVlUHhHOWtoQzRF?=
 =?utf-8?B?QUtQSzJ6dkNMWGJ1Nzd1cWdQczJIV0phUGVyc2VQZGl5SVNuWnppZm1wbzNn?=
 =?utf-8?B?SEJZb2o2dXdCd2ZCbXpOcUhmQ3Y2RmRIc0JTRDRNSG1FS2RNV3lOcWNUVldM?=
 =?utf-8?B?MGpLZkZBTkRxN1NPWmk5dFlwNzFtZDQzQmp1RFU5Y3BpNktqY05GWUswY1lY?=
 =?utf-8?B?aXFqNVdERWh0WGU0dHpoMUg2YWZpclB6VXBlRTgzZWh1RUlIWlFrejJoNlg5?=
 =?utf-8?B?MU5WbWduNGdhN250ZUw3MXNkU2pVVmFEWHZnckdsNlU2K3pJS1hMTW4ySGxj?=
 =?utf-8?B?NUUvRnBpUXVyUk1CVDA3ZnI5RFhmQWlwRW9uR0dpaGZhKzdLSUt4N1hFVVpp?=
 =?utf-8?B?c0xiM1JFYnBJWEQ5dm9Id0FDMGtSZHFPanJzRnhPOElSeE9mUHhPUDkrTUdQ?=
 =?utf-8?B?ZXBneUNtT3YySUxkNDhCeUgyeGx3SWlpU3hrK25pc1QzUUFQRnNOaExpV1hY?=
 =?utf-8?B?VzZBMmpOMTdWdEloWlpya2h2WGZqSFNJNXljQ1VHNEJ6dndBbk9KeWFlV3lV?=
 =?utf-8?B?MWtNWlhUcVZRS09jRHhxQ3RyQ08raE9tVTlaL05pemxQRDVrek1hTkwyUDZk?=
 =?utf-8?B?YmJLV2dhbHVMYUtrbWEwUEI2cWxWelR4MmI2eFBFUmxBU2Jmb3VUSzlHUTQv?=
 =?utf-8?B?ZHhTYlo2d2g1UnhORmNVcEhyTUlKU0d3VlRSbTBISlIwdUVkWk5hU3BaVjVh?=
 =?utf-8?B?b2JKZW1LSHZ3Y2pyUTZhcTJDNTVMSnlCOUg1QmtJa0dBeDZXVVBFeFRlQ1Ur?=
 =?utf-8?B?RXhWbCtBKys2ZHpCOHRLT2liOGtTM21RRGxROXExQW5CVEFOdDR2UzBEMlZW?=
 =?utf-8?B?ZWViUE1OQWdnRnhXTS9DUVpjUUtCK2lwajV2VmZFM1k4aStGKzVKWmpxZDk0?=
 =?utf-8?B?d1llRGZOQThiMTFMMDJqYVNBdWhUVlhSQ29vNVVYaDluVnZBV0RjYndxY2ps?=
 =?utf-8?B?dGNyK0JuVTVHNEJKUGc2T2M2dUZDYjZsM3JuV1V6WjMxbkR6Rm14T3FMQjhT?=
 =?utf-8?B?OW9MS3VIMGJBeGdvMWNoay9nZHNwR0RyY1hGc3hzTFFFS3NMSzNTYjBSWk9F?=
 =?utf-8?B?c0VvRXd6MTR4RmdSRDNiV2VrVldlRzdWZ1MvanN0SkorTmtGY1NxdjZJcGRw?=
 =?utf-8?B?bXpZRkFRcXNNNFVKTW1RMXBjQWVYeFRLNHlZbDdoVHh0Z3dWMnZrU2VvL2ly?=
 =?utf-8?B?TG50NnV0eVBZRGdKajJJUGJBSUdOWDVzZ2VCSWl4dE1OaVRaamtlNnZDTnV5?=
 =?utf-8?B?YTFxLzNCcWRTZko2c2pzbnRtNGxwTnoxanR6b29za3Y0U2NPOE9Lb3hCTVR0?=
 =?utf-8?B?NVNGNXArQm13RTd5OXJialNtZks4YUVTUUt5YUl3eTdyWkFqS2FON0hhWmQ5?=
 =?utf-8?B?NmZocmZTWmRUemRiQXgrY1VBcE0rRkhQbHd2SkZza3ZmcWZJRzZvaW5iQ1Vh?=
 =?utf-8?B?TWcwYmRCZzZ0RHh2TUNPUHZKWm93d2lHTTlUUmdtbzVsY1phQkFkc2RsZmVl?=
 =?utf-8?B?YkdYK0gwWjB2YS8rUldPOG5mVHlQRUNJeGtuRWY4SFU3ckE0MzU2Rk5vTDlD?=
 =?utf-8?Q?8ucvL4NBxHhaVLToEZp/OT8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C74A04B9414FF4DAE33EB45FB49C227@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Q7cwFGkr1kumdYgnsVU6hNHwo6Nx8gnQ5qmW75Beo1cD/RZ6GqOcCeMmHv++KgIXTcnuf7blX1VArE24E4NzlhKC0j6bXf8R3M1LHF32iDBC6y/RtL5+V27c947vQEASR+R41xXAiGwAUAH4AP8MEGNKnoYyPKpgFw8afKwfvpzytq9QbMtaLOIsWYDQrnwypfTCJaNjZ3wC428Pe0CyDCHUqSGHJrKoAQyjHtfRfhSQj8SK5igGp8SeCzK0UjcsVt0iy0sLT/DaiSbYo+r2i3rUZ5cPL7eTSJsbODKE28kORH4jyrXl81p29+k84+Xr75NH5yCOH55HJCjONAEQTTnSJO77wqItk10jzJx5D1RkYsIyePmTJSAd8yqqwz6FX0AIae/5KitQ7pnTJJKM0J0ihO7FSW5bvqzR9TXb7R6GSr07MDUkNB9EuLSo+waZ6ZL3vqJw4a+8jL2aHoY+wlOWesRtCW3PsjLB8gW79YYf08lBak8L3DD9G/oYMmgYvSwX+KPGSvXt/V1Yf3ql3owHHEfdSJS3+c7ID8EGpk40RBjBZC3xMqN4rNX6O2Y0s+oJjv5h89JRv6nz6tAmFv1U83RYSaRrMJVGVnLV1wU2fBPQzJgaqGLuH2D5WyAKwMKrVuINRjApfMBQKHiACesVg/BSfP4bGiTNqEZyoI7lPE8rGGQunPfpllb8eMRur/QV40BLruU3jX2857IFNchzEE4ct9nugFHf13ySIG04n6FtDgdMAdyRwNIvvk1i/WwTG9WUePlIRg6m/DsbTCwj1FQ78i7+v9/RTOCgKtnRapPcBUaG1vo0nPOR6PGYdDx0thgWqhCyf+LKUTQSt29puitEJurdj6voBwtlnS1nEhdub7Snm6O5pe7G/RRumRnuRhQWPRB74K4muY/BIg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3071b27a-8a44-45e9-6677-08daf49eee9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 13:14:27.1624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9twmho1IzW552M78rP+pR/X5t2JB5VeqSQQ60oi1qeXCesFbEHDIh4cVB2SrO2s9uVQDBdnZ2byY8jAwXjSwmabOfKJTpayBOjaeEuCFiOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0708
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gSmFuIDEyLCAyMDIzIC8gMTk6NDcsIFl1IEt1YWkgd3JvdGU6DQo+IEhpLA0KPiANCj4g5Zyo
IDIwMjMvMDEvMTIgMTk6MzgsIFNoaW5pY2hpcm8gS2F3YXNha2kg5YaZ6YGTOg0KPiA+IEkgb2Jz
ZXJ2ZWQgYW5vdGhlciBLQVNBTiB1YWYgcmVsYXRlZCB0byBiZnEuIEkgd291bGQgbGlrZSB0byBh
c2sgYmZxIGV4cGVydHMNCj4gPiB0byB0YWtlIGEgbG9vayBpbiBpdC4gV2hvbGUgS0FTQU4gbWVz
c2FnZSBpcyBhdHRhY2hlZCBiZWxvdy4gSXQgbG9va3MgZGlmZmVyZW50DQo+ID4gZnJvbSBhbm90
aGVyIHVhZiBmaXhlZCB3aXRoIDI0NmNmNjZlMzAwYiAoImJsb2NrLCBiZnE6IGZpeCB1YWYgZm9y
IGJmcXEgaW4NCj4gPiBiZnFfZXhpdF9pY3FfYmZxcSIpLg0KPiA+IA0KPiA+IEl0IHdhcyBvYnNl
cnZlZCBmaXJzdCB0aW1lIGR1cmluZyBibGt0ZXN0cyB0ZXN0IGNhc2UgYmxvY2svMDI3IHJ1biBv
biBrZXJuZWwNCj4gPiB2Ni4yLXJjMy4gRGVwZW5kaW5nIG9uIHRlc3QgbWFjaGluZXMsIGl0IHdh
cyByZWNyZWF0ZWQgZHVyaW5nIHN5c3RlbSBib290IG9yIHNzaA0KPiA+IGxvZ2luIG9jY2FzaW9u
YWxseS4gV2hlbiBJIHJlcGVhdCBzeXN0ZW0gcmVib290IGFuZCBzc2gtbG9naW4gdHdpY2UsIHRo
ZSB1YWYgaXMNCj4gPiByZWNyZWF0ZWQuDQo+ID4gDQo+ID4gSSBndWVzcyA2NGRjOGM3MzJmNWMg
KCJibG9jaywgYmZxOiBmaXggcG9zc2libGUgdWFmIGZvciAnYmZxcS0+YmljJyIpIGNvdWxkIGJl
DQo+ID4gdGhlIHRyaWdnZXIgY29tbWl0LiBJIGNoZXJyeS1waWNrZWQgdGhlIHR3byBjb21taXRz
IDY0ZGM4YzczMmY1YyBhbmQNCj4gPiAyNDZjZjY2ZTMwMGIgb24gdG9wIG9mIHY2LjEuIFdpdGgg
dGhpcyBrZXJuZWwsIEkgb2JzZXJ2ZWQgdGhlIEtBU0FOIHVhZiBpbg0KPiA+IGJpY19zZXRfYmZx
cS4NCj4gPiANCj4gPiANCj4gPiBCVUc6IEtBU0FOOiB1c2UtYWZ0ZXItZnJlZSBpbiBiaWNfc2V0
X2JmcXErMHgxNWYvMHgxOTANCj4gPiBkZXZpY2Ugb2ZmbGluZSBlcnJvciwgZGV2IHNkciwgc2Vj
dG9yIDI0NTM1Mjk2OCBvcCAweDA6KFJFQUQpIGZsYWdzIDB4MCBwaHlzX3NlZyAxIHByaW8gY2xh
c3MgMg0KPiA+IFJlYWQgb2Ygc2l6ZSA4IGF0IGFkZHIgZmZmZjg4ODExZGU4NWY4OCBieSB0YXNr
IGluOmltam91cm5hbC84MTUNCj4gPiANCj4gVGhhbmtzIGZvciB0aGUgcmVwb3J0LCBpcyB0aGUg
cHJvYmxlbSBlYXN5IHRvIHJlcG9yZHVjZT8gSWYgc28sIGNhbiB5b3UNCj4gdHJ5IHRoZSBmb2xs
b3dpbmcgcGF0Y2g/DQo+IA0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svYmZxLWNncm91cC5jIGIvYmxv
Y2svYmZxLWNncm91cC5jDQo+IGluZGV4IDFiMjgyOWU5OWRhZC4uODFkMmY0MDFmYTNmIDEwMDY0
NA0KPiAtLS0gYS9ibG9jay9iZnEtY2dyb3VwLmMNCj4gKysrIGIvYmxvY2svYmZxLWNncm91cC5j
DQo+IEBAIC03NzEsOCArNzcxLDggQEAgc3RhdGljIHZvaWQgX19iZnFfYmljX2NoYW5nZV9jZ3Jv
dXAoc3RydWN0IGJmcV9kYXRhDQo+ICpiZnFkLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAqIHJlcXVlc3QgZnJvbSB0aGUgb2xkIGNncm91cC4NCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgKi8NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBi
ZnFfcHV0X2Nvb3BlcmF0b3Ioc3luY19iZnFxKTsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBiZnFfcmVsZWFzZV9wcm9jZXNzX3JlZihiZnFkLCBzeW5jX2JmcXEpOw0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJpY19zZXRfYmZxcShiaWMsIE5VTEwsIHRydWUp
Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJmcV9yZWxlYXNlX3Byb2Nlc3Nf
cmVmKGJmcWQsIHN5bmNfYmZxcSk7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gICAg
ICAgICAgICAgICAgIH0NCj4gICAgICAgICB9DQoNClRoYW5rcyBmb3IgdGhlIHF1aWNrIHJlc3Bv
bnNlLiBZZXMsIEkgY2FuIHJlY3JlYXRlIHRoZSBwcm9ibGVtIHJlbGlhYmx5IHVzaW5nDQpvbmUg
b2YgbXkgdGVzdCBtYWNoaW5lcy4gV2l0aCB5b3VyIGZpeCBwYXRjaCBhYm92ZSwgdGhlIHByb2Js
ZW0gZGlzYXBwZWFyZWQgOikNCkkgcmVwZWF0ZWQgc3lzdGVtIHJlYm9vdCBhbmQgc3NoIGxvZ2lu
IDYgdGltZXMgYW5kIHRoZSBwcm9ibGVtIHdhcyBub3Qgb2JzZXJ2ZWQuDQoNCi0tIA0KU2hpbidp
Y2hpcm8gS2F3YXNha2k=
