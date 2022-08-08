Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8561AC25B08
	for <linux-block@archiver.kernel.org>; Mon,  8 Aug 2022 12:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243005AbiHHMp4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Aug 2022 08:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242949AbiHHMpr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Aug 2022 08:45:47 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C342C8
        for <linux-block@vger.kernel.org>; Mon,  8 Aug 2022 05:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1659962744; x=1691498744;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=C35YcU+XQ9QZLoTZKerAjNk2Hh+KuYXzancX1XpVHVg=;
  b=flcG2m+E66SfDvB/aL8fNHd2xlsT/vUYmJog52Bz0kN4i0D0KF3/4EUS
   KTg8gBisTy8fDLDsN9FxlQHSrGzBOVSbgtFa8zPQBw8Y06UQ9XDMBk2Zn
   F/KZf53z/ffb2RaXWQy115P1/PI3BHHfxanYffmD/BFvJj2mB+GhK/3SX
   zvw99zvpa41hDFnGGZLA3MX6ZlMltJRBLFeFzAm9eiysulzKo7eK0qHgJ
   LbSUg1E8O4mk3IYbria7x0QWXICdss+wATNHeu7Dg32DS09qQHWcQx2oQ
   v7tLlXo31Pq3xknjXKtj1TCb01ClYJsBv+JxDUwaz1M4O+ps2tviOl2EW
   g==;
X-IronPort-AV: E=Sophos;i="5.93,222,1654531200"; 
   d="scan'208";a="208135284"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2022 20:45:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLYceA90MZl9/8wKjZeB6QnKYnIRT1AffTGtBnKVAtxLWl2B7hbAYIZaCMXUCppxQkkYz5rYShXaT7szXIOyUMFUX7JF1YVsYmGFpDdm5tGov684iGQDGrVdc75W52rKbwoxDhneyQ+oiXHBf+9CY5Hg5z9vVS3MBDBU6uNOcrzCZEwavccopq4XNaA/eqhGVbIYMfESqFKHZBXozTDvNC3Tk0IQBl5KYg/7RzmxJJ1Vx2ULmdWNCGMRGkNTRMJmo6O24wEy3O3dqY2eqjgkfYPLbDpvLj8FFmZ27uxMx0/QqXhhtc8SiyHHpBqEayNy6r4yVntl8tMkRqAtIcRW4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C35YcU+XQ9QZLoTZKerAjNk2Hh+KuYXzancX1XpVHVg=;
 b=In0ZolKHk3drJ+mJaTp9tewyM2/YWDF9hVWjq+jIBA3FMWTOJ4Wr+N5Qau6UnkMswYDiHfMlHY4INyPKQtbZNXGuopCylh+kLX2X7dEp+o4joqkaiC6zelpTspj5ZIdFwgspxpaPtnwwfUfIIbgJmQV9ZANff2wtsRuRLUOLOVRME/TfnUsPwQWRDkbeRKTcl28OfYjRLrFXJ/SoHMTlOJaUPwvnRSfE2qTZoT+ZNKiXe6U2WGbkjM7QI6DYhjj7zQpe5Gs1SxYX02CBjORklRsuGSWUxsGYB5DQWWOOurZ6qFqMg7Kyjc2QFDRmoRh3+tj/AXo8eiWONnjnJ0UkJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C35YcU+XQ9QZLoTZKerAjNk2Hh+KuYXzancX1XpVHVg=;
 b=o32oW8EaJMO3u4g2y0XK7nGOytN06Kq1SWJeB3NQWxD6KI0+4fr83Y/WZrZfrxtGuzGTs4QQECqa3xROWspK8Fp60s8uCpeijNxNFyiYwhIh1C33KCE54c/trJ/hCxErwp+/dzio+Zo5tnrD364VNb2xjTr3IjXWVprc0+8j4V0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB4745.namprd04.prod.outlook.com (2603:10b6:5:24::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.15; Mon, 8 Aug 2022 12:45:42 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::59dc:25d4:781e:2a89]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::59dc:25d4:781e:2a89%5]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 12:45:42 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sunke32@huawei.com" <sunke32@huawei.com>
Subject: Re: [PATCH v2 blktests] src/mount_clear_sock.c: fix compiling error
Thread-Topic: [PATCH v2 blktests] src/mount_clear_sock.c: fix compiling error
Thread-Index: AQHYqxLC5RD3a6NmvE2nbQ8jKQGsPa2k82OA
Date:   Mon, 8 Aug 2022 12:45:42 +0000
Message-ID: <20220808124541.jy73fz4f4c3xrmc4@shindev>
References: <20220808103623.821142-1-yi.zhang@redhat.com>
In-Reply-To: <20220808103623.821142-1-yi.zhang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 425e7565-71c2-4049-bc0f-08da793be7a0
x-ms-traffictypediagnostic: DM6PR04MB4745:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yu/rtqk+W8K1GcKiZYhK7VVXPR1upoUqJpzCJsHq6IoY877uW9zf9TxmR42UegogJBUuw3BRDVW8niZPgsRkUMfvo2utfSqMRg5CLs9g1SvUQaHVvGDphl1km4oY2gpf/tVJfh+MjWTeI6n8+3vlzE0nSdenb3LzRFhPICEgjW54Es73gggtmiorVJY+V6bY8TEt+pmYjQYCn1uadecD9hClYQvj1+mWgmITUwOK4FINXXQ+K3BSsY+dZU9Ky8H1Es3NPWj0EhvqLYPgIjQZoVKfnvefcI1SjA4uIdhT/Ifb2rZ1cQZ1ceZrJ81cYagk2Ogvgo0zbYowRbyQ9SO4hksns/Oy9biBeNetLaaWHS7/AxecLc82fzX5U7dO5i/8LTAwAwx5cJdRHhqAyQrNcN2GTcbg+BWECChJLKeUw1l0sWpmNYGlxx556cQwvQUD5agBe87jJpXRpe7d/Rv/H1bBDCrBpIKuLzxnO1K6j+g8l8rn5dzM4wEbjQge77oX1vmdHkkrwDo17kIWLQ0xcp2ywYeIwTWn/KhYhEdcGjmyHTw6QQAWYWxTo0TF455D+No1dtvw8t1eHtzn9cP+1Vj+Q6ozIud0n9CjTe0LKZJ+QoAAP6FuO5B+7N8mU8wnMN9OEs2vc/WPe8JUJcUqZEJ/9GwWQpMfy8jLSD9NeOJM3DkblpRzaAxyk9l7HjucQOFFJ9ekuX/RQ30dOcGdPvU644wzvk/hpM/lAne+1dtc9VGFNtnWfyUQe/nJ/oX51nymRscGBCQLeGCzwhhyN8POTwKFD4py4KUSb67p4FTBZD8CTRA/Ly1yIY+bU20gHROl0QvcGVBmcOozoHgzUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(39860400002)(366004)(376002)(346002)(396003)(136003)(4744005)(66946007)(66556008)(66476007)(4326008)(8676002)(71200400001)(44832011)(66446008)(64756008)(33716001)(2906002)(478600001)(6916009)(966005)(54906003)(316002)(6486002)(5660300002)(76116006)(91956017)(8936002)(6506007)(9686003)(38070700005)(6512007)(41300700001)(82960400001)(26005)(186003)(86362001)(1076003)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXBDbVIyRHZzbWpMWEFwZ3ZPZEZQaG9lMldHc0srcndjb2ZYR0xDRkpBV2g1?=
 =?utf-8?B?cFlhSzM4ZzViL3loaDdYOThzc1gzYU9xTFdWNnpDZkUvVEQ3cXUreUdDQm9a?=
 =?utf-8?B?azZ5MGdHdDQ5a3lmcGJiY0tqeW1ISTc0M21DdmlReExMSkZGZk1yK1RUSE5G?=
 =?utf-8?B?aDMzZ1NCcEVRSFVLak5Ta3IwTVNrbUFKZnZTOHpNSzFndnQwWWo2Q2NsWUc4?=
 =?utf-8?B?NWtOeEhCU0QzcVFVK0E1aWJmWkJsNG1TaC94djBNWkdsbDVCN3BVb1ZaY3pk?=
 =?utf-8?B?T0xYSTdGK0NkRnhVTjVXRHBJVms2QjQ4eFZHZm9PYWN4Mmg1WW91SEZOeDVL?=
 =?utf-8?B?eTlDVm5VQXd2WjhGbmZsa205SDFlVlpSMG5sT0JVUXN2QWhoeEZQU0pWM2ls?=
 =?utf-8?B?eWhxYnBvTmZaUlNOWllHS2JUMUdwbXR3NnA5SFo5cy9xRXdOVmd6TTNyc2Fv?=
 =?utf-8?B?QjNjRVJDVHBtR0lCa2JLdGpCeEpMVTFzcExqdEJGZ1hWQjFtUHBhajhNa2l3?=
 =?utf-8?B?ak83M3ZPTWhJU0xBMXBIUnhjK1FBT1ZYU1ROWG52UitaUGgzUDZGTE5iZk1J?=
 =?utf-8?B?QTFvamlpS0E1TTA2cERsSTJZbVgzZnp1MUZTWmRtMTZuY3EzemJIcnRYOER0?=
 =?utf-8?B?TnBiUUVtRzlhK0ZMakJVVmRKYjE3MHQrOW9XQTRIZ0QvdVgzUVhyTUdVY3px?=
 =?utf-8?B?ZCt3MnFNNW8vdTkyRXFLVzEyTFdxNWl6bzZwOThJZzNtSi8xYW0zcUJETU14?=
 =?utf-8?B?Zkd2TzFMalMwUnZ0ekE0bXp3QWJDQ05vOXBRUzVZdjZJdXdLOEhMd1JucHRn?=
 =?utf-8?B?ajRDeHNIRS96a2lPNnhzZzNYL1Z3ZE5McnVzMStHQytVMXUyZ0hjS3h5V0c5?=
 =?utf-8?B?azUzRWZtNUE4SGcvV3NyallncUxrTGRRak1kMmxvSDdHeDJLSW5saUVaakRy?=
 =?utf-8?B?eUZOUUkwNTZJd2V6TEFGTDVPcWlOTC85RUw0cDY0SDZXaERLVUdiQjFXUU83?=
 =?utf-8?B?Y2RaaGpEaUM3UzEyaFJZb0FKYzN2c2QrQ2Juem95R2xIMHJtWks0UGgwcjFR?=
 =?utf-8?B?aFVJdlZzR1JoOGkyOTFsWjVWb3dDNndWeFQ2ZG5odTQxT0x0dVNaZDRsaTB4?=
 =?utf-8?B?K0lncWFDbFNLOVhWWTIyZDFOSFFNRFJiY2pqZjZxdnRobTdEKzFrSW81UHgw?=
 =?utf-8?B?R1VyRmlYTWhmVXFOWW53bGdrZGhWM2xORkwyaFk3ak9WWklMUmRBbmdVT0s2?=
 =?utf-8?B?SVpvNVVDYWhURC81aG9rMGw2SmMzOFlCak5UMi9GTndWK0R6dXFpMVd3eUQr?=
 =?utf-8?B?V2FqV2xJZk5RUHRTTW5RZWVqOG5ucUdheEgzNVhTaHVEUUUwRFR3bmdVbTBR?=
 =?utf-8?B?a3Q0NVIrQjdPUUJBZEVDbFovWWxhZWdCSDFmVUsyRTZCRkhYRUhOeVRvVCs0?=
 =?utf-8?B?V3ViOGNrSmlSV1h4WEt2UUNteWRhVFcvZ3RkWFBwMFkvcS8zOHIzRENrTXlq?=
 =?utf-8?B?alBqZjNOWlROOFNVRyt2UmJ0WUxaOXNiZ2hHalZ6OFVNQnNDSGJ2M2ZmZVV5?=
 =?utf-8?B?N1pweVFlYXFabXBML0RLZEdFK1BRY3hBNnQ3NEZibUpHWnVGK2UwdjhwTWts?=
 =?utf-8?B?WXVXLzJENUtLNVJTWStGell2U0haWXN6YnRsV3p6UXB4OXhLamtWRzVzeG83?=
 =?utf-8?B?Mnp2MHJqMW5RY3pRT0pPMUdNdnBwdTUwa1F3a1V6R1gxMlZ1eHU3YStFMkxr?=
 =?utf-8?B?M2tQQWNTYjNZSFhFTXRKWDRBZDAzeTJ5NlNkbDd2U0Q1VjB4bUJybXpiTHA0?=
 =?utf-8?B?dU1saHhHbndSNkVjZHlhR1AwMCtqbldPT0VzYU13d2NmSUkyTUJ2SmZ6Z1dJ?=
 =?utf-8?B?akJuWDRZMVE0YnJzVkJ0WDVCd1hCaHZFaERuUytpRlJvQ1hyTi9mN0JzaHZv?=
 =?utf-8?B?WEd3b0VpOVg0emYrRjNja0lGUDhZR3IwMEhtNlRXU0F5bjh3Ky8wd2g1ZlhJ?=
 =?utf-8?B?RS81MW5XRGg0RWtYUC8xNmlxZWdiS05oZE1JQVhQVUpwVFYwZWZVZXRDWFZJ?=
 =?utf-8?B?Si9DcXRvNzFZanIrOXpvKzVFZW9ib0xWd0pwdDJqZmhaVk5CMVJGMXd5ZzRs?=
 =?utf-8?B?Q1M1OUpxYjQ0azhlZ0lya1JHTkd3QytGR1RLZ1E5VHhGNVVMM0hUQWtrcmZl?=
 =?utf-8?Q?eaZM13LbbyEc+0bEI5RXcqE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBF92FCA305BA1478C5FC8B77FF04F74@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 425e7565-71c2-4049-bc0f-08da793be7a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2022 12:45:42.2136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L/EH59hYdsGLVhDEnR9qwaxcFiqY4mlAPBhOtvAWzGZ7GsvP/CDXFK7zSXCHJ5EB02S6cqsS01Vf0dUCvp/5Rv9eYdM70yliZ7rsrdgUtYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4745
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gQXVnIDA4LCAyMDIyIC8gMTg6MzYsIFlpIFpoYW5nIHdyb3RlOg0KPiA8bGludXgvbW91bnQu
aD4gYW5kIDxzeXMvbW91bnQuaD4gYXJlIGtub3duIHBhaXJzIG9mIGhlYWRlcnMgdGhhdCBjb25m
bGljdA0KPiBTZWUgaHR0cHM6Ly9zb3VyY2V3YXJlLm9yZy9nbGliYy93aWtpL1N5bmNocm9uaXpp
bmdfSGVhZGVycw0KPiAkIG1ha2UNCj4gbWFrZSAtQyBzcmMgYWxsDQo+IG1ha2VbMV06IEVudGVy
aW5nIGRpcmVjdG9yeSAnL3Jvb3QvYmxrdGVzdHMvc3JjJw0KPiBjYyAgLU8yIC1XYWxsIC1Xc2hh
ZG93ICAtREhBVkVfTElOVVhfQkxLWk9ORURfSCAtbyBtb3VudF9jbGVhcl9zb2NrIG1vdW50X2Ns
ZWFyX3NvY2suYw0KPiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gL3Vzci9pbmNsdWRlL2xpbnV4L2Zz
Lmg6MTksDQo+ICAgICAgICAgICAgICAgICAgZnJvbSBtb3VudF9jbGVhcl9zb2NrLmM6MTU6DQo+
IC91c3IvaW5jbHVkZS9saW51eC9tb3VudC5oOjk1OjY6IGVycm9yOiByZWRlY2xhcmF0aW9uIG9m
IOKAmGVudW0gZnNjb25maWdfY29tbWFuZOKAmQ0KPiAgICA5NSB8IGVudW0gZnNjb25maWdfY29t
bWFuZCB7DQo+ICAgICAgIHwgICAgICBefn5+fn5+fn5+fn5+fn5+DQoNClRoYW5rcywgYXBwbGll
ZCENCg0KLS0gDQpTaGluJ2ljaGlybyBLYXdhc2FraQ==
