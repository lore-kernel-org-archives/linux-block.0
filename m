Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF7CC54EBE
	for <linux-block@archiver.kernel.org>; Fri, 13 Jan 2023 01:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240355AbjAMBE1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Jan 2023 20:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjAMBET (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Jan 2023 20:04:19 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B53A62196
        for <linux-block@vger.kernel.org>; Thu, 12 Jan 2023 17:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673571848; x=1705107848;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jg1ICVgiDgVgsJXU4SchR0lWjwipnFKum+gwhucN4J4=;
  b=Nirmivtjv7xSfkjn0XuhJ1mxZFklbypADE8/P8zA8TEVrBhpaDdmtVzf
   soykyaDa2qUX0+vcEzW8z9UHE+7GVm8PTA39qjRMw4MO2KEZGH/VibPUx
   lXDJb1vOVb8L5HIXNYPiee4lgZ+Czyaw08E1e8jsMxe3Pj1FT70JqSzzs
   anw3+gZ4aoC0anYpFgK7TiFPaicGyD2nmit6y9KoGa8ETzQjUxS1Sfbtf
   b3Qm5/CqK5YjxxNqpchTVpemzheXCD3bwlphHsAfCvi4VdLCyIE+WQgec
   n+Pfxdg76QOP857ItkswIAw/WZs+C/szSh6JGplUllfP+Od3FvkAleufE
   w==;
X-IronPort-AV: E=Sophos;i="5.97,212,1669046400"; 
   d="scan'208";a="219023609"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2023 09:04:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3sydb7nihtb/lepWB/j2H2vM24XiZMGiXCape2IysXtd5Sfq1ykrMt805IEIm6cDNoc8hp3kWA/6aFpXEvIiDEESNlPGM+VW5RnyBKM/8kGBY4BIwKhSB4uYbBTN+Mljl7j/lJOnc4g2fc9iKeYJCC/EQ7jMsTQFem4FzXmHG6y+q47KhUvhnaawhtCgCIAiu/pGvFAc/F0HGzf/+o/PSKn7rV/JsRL4wau3aPBFwTC1RIwerpOb/N02YwWUhsM84bkCZTRyArdhR7kq1nJS6KSuUpHBV1N1cPFsc00OQqM7LlRdhNKIsMgrjZvKwQQ7ww2ZZjsSGOOLciR4D9mcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jg1ICVgiDgVgsJXU4SchR0lWjwipnFKum+gwhucN4J4=;
 b=XmNGUZwCGY2b2ASjnhFbxr9KnIqbTcFmePb89JjSF2cNc69hFwcYUH/F5iLiZTwTr1ZjigOb/UljGpw4Ody4SBSwhGXao0t3I2Jglc4MBK2GadChr94hwCdF7eviAM7wvBnIkxaVQFX7Dj1f/yjuwbmpA5G4hBMmawVg+PwqcMKAlv02erkLJB5ZWWPEVE2Q8iz80fTlPRtVbsK9iqUX2Ye0FARTAFmM7Sa96V2gN32Dq6ABarFJyuFyDEhsk1z5bcLSy1NXJbhPUZ62yRsad9bD6TK4sgiiOfF7cZPdDHI1lNI7y1XKkz1LKYgA1cEQbzvnsGIuhDuKhSAA3jvyaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jg1ICVgiDgVgsJXU4SchR0lWjwipnFKum+gwhucN4J4=;
 b=VNjQ21kpjfT74xOBQP5231g+xtv8VPY0zZF76VwRiDfiFLiCfy8Zob4qbK8xvh3594fcTXtcz3cHQEQ9S2sWv6lFcjbz31iFovHkL5XhgvlrgRhw0+fxzjbXgXreIZ1/r6/QaHwOTgdLooDp2lo/HfsW4tW8GfnAqn5KL65TGWI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7181.namprd04.prod.outlook.com (2603:10b6:a03:2a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 01:04:00 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::e5db:3a3e:7571:6871]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::e5db:3a3e:7571:6871%9]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 01:04:00 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [bug report] BUG: KASAN: use-after-free in bic_set_bfqq
Thread-Topic: [bug report] BUG: KASAN: use-after-free in bic_set_bfqq
Thread-Index: AQHZJnpnPtmIPiOF+0WDV5g4YvQloq6aqkOAgAABqgCAABffAIAAxRWA
Date:   Fri, 13 Jan 2023 01:04:00 +0000
Message-ID: <20230113010359.wdyndfb5cfxu6sut@shindev>
References: <20230112113833.6zkuoxshdcuctlnw@shindev>
 <6933fa2d-014c-8773-39d9-680ad9fca98c@huaweicloud.com>
 <3cbab38c-5b8d-131a-d80a-886a0febc692@huaweicloud.com>
 <20230112131836.vvbckhhefjp5bmgn@shindev>
In-Reply-To: <20230112131836.vvbckhhefjp5bmgn@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7181:EE_
x-ms-office365-filtering-correlation-id: b3bf05bd-ae8d-4d77-f930-08daf5020e68
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y+/3+ZxSEwLwzfjy63PUKy7EAgr7m+WBWHqOOjuHUEQTnZrB9FoMxxtLu+L8BfM69iignEv1OYd52FaR4fKqKIzZ5XyYZXPZgWBpMxJuSOiqxjHUK0MM5WPeYdqHdWI62E5zYeSuPUocYAFjc0yWT28ryveKgvfdOJvV/AG4w+ZoJeMF2bDpt7CrGjFB77K811I1W4vqWMVWcueTKbDPHq6Svmlfy4BAH0IgHB8vYn/LYcPNs+njgBeiJUbhKzTYfciEoJEqzQzyzJUk0A73vrSpx3V4GYUAjpKuL+1koO6tF8MGtJUZxr6RydWiZZqi8Ka/+jLtsYbOKHPrWKBdyktI9NooTrA9qqlAv+WaAgx8/qipmfxBQ3C7X9Ox7/Mh8TzzTulw1Q1k5VhrFbKJCo1C8nWfIYZ/DhmjdUIWBfCPpOd/zBAp5xZzlaJkMJfyijEIynopXu5DF5IldN6OKPaXMGbPYlESMXp3Pf9F0ZjNYNMaUE4DnuSgqZ2L3Q0zeDjkiYLuwNCne0/EbuvJv4LkWnPy2JNmp/xyB6dnnXe3mfp68+tE2TkTgVcCywHghItAOHYWZ5Bys8aT3BN+whuhtKKiySlV0ss8Jf1mSLuK2OVHfDnejChZUX4HQWDsXQDwjcDxD3MP7RLelrwK4CH8ESSaY/dUu+PJIwbLDmvG2Ad806xTW6n5jAqgNstiXp1iNEIbfbvG9YLTV0j8JA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199015)(82960400001)(478600001)(38070700005)(6486002)(41300700001)(6512007)(38100700002)(1076003)(71200400001)(86362001)(316002)(54906003)(91956017)(26005)(33716001)(66556008)(66946007)(186003)(76116006)(66476007)(4326008)(5660300002)(6506007)(2906002)(44832011)(66446008)(9686003)(64756008)(8676002)(6916009)(8936002)(83380400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Um5CUHN0QzlUM0ozQUlRVE5NM2RtdHFCaVhXK1o2QmRON2dpK2dabFowQzJl?=
 =?utf-8?B?RExhL1FkOEFrZWJ4eHM4b1BjQ1V5bU9kNS81YzVXWURtU3FPYkpoVE9CSjhy?=
 =?utf-8?B?NmpSSEVxSXJCOE5EUkVDb0lyTTd2RE1ucysxcnlFdzVLOURHVzRmeTQxbG8z?=
 =?utf-8?B?VmFtMDgvS1JmeHhwSU1PYzhEVUIyWENuV2w2WUI0ZEVhSVZKYStUMlUxTG1p?=
 =?utf-8?B?V2RFV3NXc0U2N0NWb0JJbWpxUTRmMVhkQUhUUHIyc1c1WGVTTk8va0NBOENm?=
 =?utf-8?B?Sk0zQ1BQbm1rVFNVTU9Wc3dldnNIeCtqRmF4VjdpNU5ENzFFd2hrWFVmRUl6?=
 =?utf-8?B?T2cweGh4THlzUW5JVnZmUi9RV3BkKzhsM0RjaEhvQkszSmF5VzlDTUdFaWE2?=
 =?utf-8?B?SnZvVmxBSGRvc3U1YUw2SzBwc0dJUHhhUS95YVg2M0I2dXpPeVBzb21lTHNa?=
 =?utf-8?B?dGFxeDdJUkhBZUl1TTBNMDdta1RPdlZqRVk5R0pxYVlRTkJvSzZNWFk5M0RD?=
 =?utf-8?B?ZVc3MzczdXdVZTZkQm9QZk5Wa201ZWpzdlVuK2RUNTdRbEdEaUtxQmhudFdJ?=
 =?utf-8?B?Z2xVTmhMaW9CZ2pJc1lpTG5xN3RwOEdKdnhpTzJ1b3RaWDZiMno5ZGduV1RL?=
 =?utf-8?B?Y0lnWWhFRGJqbkxkaWNHMDNJcHkxaFY2UU5IVGdqOTBjTE4rQ3AvWGNhR3FS?=
 =?utf-8?B?UFR4WXMvK09rd3BjZ1RUOGQxWC9jeGpQbzVTWHZlenpPQWJkbGRTV0JzOExr?=
 =?utf-8?B?SkVMNGxUMGN3ditydG8xaEtPR0Z1SG80ZVBnUW9kMTk1cVI2WEg3MFljSnZ0?=
 =?utf-8?B?V3psdWFWa05yRXQ5ZHBJUGZhOHdOeDFIUkI4SndrOE00d3NSaXprSlBibHUw?=
 =?utf-8?B?Ui9zbi8xTC82c0VDZnJpcmN2MmlLTFZmalhiMDQrVnYrdmozZVZTNFMvSVM5?=
 =?utf-8?B?bEt0MjFFdVg3dVBUb0psamk4MWdGZkh1ODhtSG5RR2RReURyVmZseHpJY1dT?=
 =?utf-8?B?NlhBLzg2ZlZJSzNtQ2lFajFaNXZhU3V1MVkwN2c1c2psamFJVjdLcnJzR245?=
 =?utf-8?B?akNSamVCN3NZdjlCOHFmZWFJcEdEbFNJaUZyZDk2WENUNGJNUVVXWWdWSVJB?=
 =?utf-8?B?SGpoZ2FCSXFoT0l2TytoUGp1MXhFWk5zZ28vR1d6R1JrTmt3TlA5L1d0RFVX?=
 =?utf-8?B?ekFCTGh1elNrdlZQWVBsRWMwZnFiVzJHbHBVUFhKV2hFcjJIdUdWZFJtOVFz?=
 =?utf-8?B?cDN3UGdWOW5jQ0hVR3pwZlMvblIxSGVhOUhxOGc3cVBRbEdZTFRrUlVFc3N5?=
 =?utf-8?B?ZTR2dHlWS0QzdUFhWjBvRFpQOGVnamJGYnV2NTZOZFp5U1FWWlhMWkluMGJ4?=
 =?utf-8?B?R3Yya3JWVWZXeGtScHJpN2JFNjdBRlc1b1NXZGc2emxUNXVNUEZyaGVQTlpl?=
 =?utf-8?B?WWkya3FXNEpldzIzOEZBY053VTBWN3RsZ3NVMm1YWE5UR1Z5cW9acDJKTjgx?=
 =?utf-8?B?ZzFSa3E5ZUd2T2lrUEREejhHMHY1K25LWGUxdDVsc2VvWVJHd2ZjSDRhczZV?=
 =?utf-8?B?aHpoYjRCaHN4ekhQcnR5MmluSzBhdkFoTEJZbmJMS0VuMjIvdHRtQ2Y4T3Qx?=
 =?utf-8?B?d2RvelBQeG1RbUc5diszM2piUWpsejM1eTFSOTgwR0U1NnpNUzBzYXhhTGlG?=
 =?utf-8?B?aUc4NllWZ2orZlZoTndrcGZvdlQ5QmtXNmNNeVlXZEx3Z1hITnF0L2ZNVnhm?=
 =?utf-8?B?ZjJqbmN3YWNEQUYyMzBBL1dLd1dLYVZyTWoxeGFsM0V1K3JvRkFQMGM5b3RH?=
 =?utf-8?B?d3lDNVlBeEZmRGppWkF5akp6WkVjcjJqUW9HYU9Id3FpMkR0Y21NVSt0ZnBv?=
 =?utf-8?B?Ky9CYng4WVVWalZvbmFFNWYvTitLWGw0bjR0WVhQemoxblh4cEhpQ2N2REYw?=
 =?utf-8?B?MjN2VWdPcWg0ckpnRkJCeE1wWiswRkcxVHVIQlVhQ3VwSzRXOUphNjVTdk9W?=
 =?utf-8?B?bllEcGhvTGdhNkxNZ0orUVlFdk9ScUVkRlVaQ0ZmVWdwZnd4R0RIUW1wT3Iv?=
 =?utf-8?B?aFk4Wkt4SFpnZndqNnlSU0ZMVCtFRnkzQk5uYlQyTFlVejhrZkw4ekJiT2ta?=
 =?utf-8?B?SnZjZ2dkeHBmSlEzMmdpb3JzNm9VZDZYanhCV2VCMjMvd0FxS2J5Sm1XYzVu?=
 =?utf-8?Q?XAol7VzlzKt4ysidLRSD8/Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCC0D7A5AF0DE448BEED32A22DC96E11@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wyR4WWILULuy2A9M2UuGtZtB9EcqRdDllWIS0tgBbcbIvmURbelQvDTI7M49SCDvsdBdkRdVc0D06FPPC2L0P5x/G+F2SoxLr2yKx530zvCww0N1Vu4CENQbituSrt3DCRkeT9AvfnD4QprRdqUIXrQwPX0QIRAauKVRDsLVuTgot1sgg015bggQ6FjJMDttAMqsvXNJcCOa6G839JV/mkRz4QpTdDoj+8xj8TomkLuKWNVt0bMIfc6GVXk2SmaHhMWZvCXkECqo9ZOsqzWY3QBPhRpfm+YJAvRb/KV34E7j/jSHDnNOSHlBdycwxtDEyVRjgqfa+zgqjfrJYAVPmBg8JcTA0JrgiMsA/8ZRRLaHauiRWvJTkoL3ykFy/Hn/Rp1pRsdjQkyUOS+vW+fEPtoN2PurqiuqVQWmM8WF/1swDUTIuumQ83vHbe5JXnCt7yxIaVIFf/z+U2I2lcAfJ741gxlBFdaVVLH4Ut9/3UbywRn9wJLSH9pMzG4eokghP/IElF/9uRyVp4SP4lqfcKP820vJc2Agy41F/TM3ixZEzz+9pdmoBFBAnyhb+xxGHAdKrNd922zA+t2eONPiUqeuDQYvZWcf2B6fhphR4rriSiagV1nMCWzdhyFzjfmB9g3818zxGSnlnpa4rv7LixuEFm/r5/PfSGZoBTrQaiBwwWuUUXXHZzaoo41enae0UvYI5PyOt1XC3OobL5+5LT78X9hsxLipZWTI7U9o0Jd9p7L/RL+ihxly7oCC+Xq7NhuuOLdVjPDQoRecLTyqnjht5kOsYNvvdMRzJ4AIhFlpV7KD1FdCWU/XDRNplrlJqg2h5wFWPb7sMurlTwYVDFh66OAkrpPdqbw8xgvFBfrfJLeu0LlKWHwzAnsdDOq2ZLOmoNmOCNyHMOkSSHbuQg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3bf05bd-ae8d-4d77-f930-08daf5020e68
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 01:04:00.6534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RVOQeIkMrgK6Jun8aS3G5pY0/HeU/OR9LbbWsziFCWRSGSqAq0vIb/J6UDQcM+ktSJu667PESIhO42a5lPYrptk74ILdTK9dsSAx+DRsliM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7181
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gSmFuIDEyLCAyMDIzIC8gMjI6MTgsIFNoaW4naWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiBP
biBKYW4gMTIsIDIwMjMgLyAxOTo1MywgWXUgS3VhaSB3cm90ZToNCj4gPiBIaSwNCj4gPiANCj4g
PiDlnKggMjAyMy8wMS8xMiAxOTo0NywgWXUgS3VhaSDlhpnpgZM6DQo+ID4gPiBUaGFua3MgZm9y
IHRoZSByZXBvcnQsIGlzIHRoZSBwcm9ibGVtIGVhc3kgdG8gcmVwb3JkdWNlPyBJZiBzbywgY2Fu
IHlvdQ0KPiA+ID4gdHJ5IHRoZSBmb2xsb3dpbmcgcGF0Y2g/DQo+ID4gPiANCj4gPiA+IGRpZmYg
LS1naXQgYS9ibG9jay9iZnEtY2dyb3VwLmMgYi9ibG9jay9iZnEtY2dyb3VwLmMNCj4gPiA+IGlu
ZGV4IDFiMjgyOWU5OWRhZC4uODFkMmY0MDFmYTNmIDEwMDY0NA0KPiA+ID4gLS0tIGEvYmxvY2sv
YmZxLWNncm91cC5jDQo+ID4gPiArKysgYi9ibG9jay9iZnEtY2dyb3VwLmMNCj4gPiA+IEBAIC03
NzEsOCArNzcxLDggQEAgc3RhdGljIHZvaWQgX19iZnFfYmljX2NoYW5nZV9jZ3JvdXAoc3RydWN0
IGJmcV9kYXRhDQo+ID4gPiAqYmZxZCwNCj4gPiA+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogcmVxdWVzdCBmcm9tIHRo
ZSBvbGQgY2dyb3VwLg0KPiA+ID4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8NCj4gPiA+ICDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBiZnFfcHV0X2Nv
b3BlcmF0b3Ioc3luY19iZnFxKTsNCj4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmZxX3JlbGVhc2VfcHJvY2Vzc19yZWYo
YmZxZCwgc3luY19iZnFxKTsNCj4gPiA+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBiaWNfc2V0X2JmcXEoYmljLCBOVUxMLCB0
cnVlKTsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgYmZxX3JlbGVhc2VfcHJvY2Vzc19yZWYoYmZxZCwgc3luY19iZnFx
KTsNCj4gPiA+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IH0NCj4gPiA+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPiA+ID4gIMKgwqDC
oMKgwqDCoMKgIH0NCj4gPiA+IA0KPiA+IEp1c3QgaW4gY2FzZSB5b3UgaGl0IHRoZSBwcm9ibGVt
IGluIGFub3RoZXIgcGxhY2UsIHBsZWFzZSB1c2luZyB0aGUNCj4gPiBmb2xsb3dpbmcgcGF0Y2g6
DQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2Jsb2NrL2JmcS1jZ3JvdXAuYyBiL2Jsb2NrL2JmcS1j
Z3JvdXAuYw0KPiA+IGluZGV4IDFiMjgyOWU5OWRhZC4uODFkMmY0MDFmYTNmIDEwMDY0NA0KPiA+
IC0tLSBhL2Jsb2NrL2JmcS1jZ3JvdXAuYw0KPiA+ICsrKyBiL2Jsb2NrL2JmcS1jZ3JvdXAuYw0K
PiA+IEBAIC03NzEsOCArNzcxLDggQEAgc3RhdGljIHZvaWQgX19iZnFfYmljX2NoYW5nZV9jZ3Jv
dXAoc3RydWN0IGJmcV9kYXRhDQo+ID4gKmJmcWQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKiByZXF1ZXN0IGZyb20gdGhlIG9sZCBjZ3JvdXAuDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKi8NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGJmcV9wdXRfY29vcGVyYXRvcihzeW5jX2JmcXEpOw0KPiA+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgYmZxX3JlbGVhc2VfcHJvY2Vzc19yZWYoYmZxZCwgc3luY19iZnFx
KTsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJpY19zZXRfYmZxcShiaWMs
IE5VTEwsIHRydWUpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYmZxX3Jl
bGVhc2VfcHJvY2Vzc19yZWYoYmZxZCwgc3luY19iZnFxKTsNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICB9DQo+ID4gICAgICAgICAgICAgICAgIH0NCj4gPiAgICAgICAgIH0NCj4gPiBkaWZm
IC0tZ2l0IGEvYmxvY2svYmZxLWlvc2NoZWQuYyBiL2Jsb2NrL2JmcS1pb3NjaGVkLmMNCj4gPiBp
bmRleCAxNmY0M2JiYzU3NWEuLjY4NzI4NTYxMmU1NyAxMDA2NDQNCj4gPiAtLS0gYS9ibG9jay9i
ZnEtaW9zY2hlZC5jDQo+ID4gKysrIGIvYmxvY2svYmZxLWlvc2NoZWQuYw0KPiA+IEBAIC01NDI1
LDkgKzU0MjUsMTAgQEAgc3RhdGljIHZvaWQgYmZxX2NoZWNrX2lvcHJpb19jaGFuZ2Uoc3RydWN0
IGJmcV9pb19jcQ0KPiA+ICpiaWMsIHN0cnVjdCBiaW8gKmJpbykNCj4gPiANCj4gPiAgICAgICAg
IGJmcXEgPSBiaWNfdG9fYmZxcShiaWMsIGZhbHNlKTsNCj4gPiAgICAgICAgIGlmIChiZnFxKSB7
DQo+ID4gLSAgICAgICAgICAgICAgIGJmcV9yZWxlYXNlX3Byb2Nlc3NfcmVmKGJmcWQsIGJmcXEp
Ow0KPiA+ICsgICAgICAgICAgICAgICBzdHJ1Y3QgYmZxX3F1ZXVlICpvbGRfYmZxcSA9IGJmcXE7
DQo+ID4gICAgICAgICAgICAgICAgIGJmcXEgPSBiZnFfZ2V0X3F1ZXVlKGJmcWQsIGJpbywgZmFs
c2UsIGJpYywgdHJ1ZSk7DQo+ID4gICAgICAgICAgICAgICAgIGJpY19zZXRfYmZxcShiaWMsIGJm
cXEsIGZhbHNlKTsNCj4gPiArICAgICAgICAgICAgICAgYmZxX3JlbGVhc2VfcHJvY2Vzc19yZWYo
YmZxZCwgb2xkX2JmcXEpOw0KPiA+ICAgICAgICAgfQ0KPiA+IA0KPiA+ICAgICAgICAgYmZxcSA9
IGJpY190b19iZnFxKGJpYywgdHJ1ZSk7DQo+ID4gDQo+IA0KPiBBaCwgSSd2ZSBqdXN0IG5vdGlj
ZWQgdGhpcyBlLW1haWwuIFdpbGwgdGVzdCB0aGlzIHBhdGNoIHRvbW9ycm93Lg0KDQpUaGlzIHNl
Y29uZCB0cmlhbCBwYXRjaCBhbHNvIGF2b2lkZWQgdGhlIEtBU0FOIHVhZiBtZXNzYWdlLiBJIHJl
cGVhdGVkIHRoZQ0Kc3lzdGVtIGJvb3QgYW5kIHNzaCBsb2dpbiA2IHRpbWVzIGFuZCBkaWQgbm90
IG9ic2VydmUgdGhlIGZhaWx1cmUuIExvb2tzIGdvb2QuDQoNCi0tIA0KU2hpbidpY2hpcm8gS2F3
YXNha2k=
