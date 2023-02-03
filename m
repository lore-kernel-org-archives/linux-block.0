Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13A9C6379F
	for <linux-block@archiver.kernel.org>; Fri,  3 Feb 2023 07:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbjBCH7d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Feb 2023 02:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjBCH7C (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Feb 2023 02:59:02 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D13170D
        for <linux-block@vger.kernel.org>; Thu,  2 Feb 2023 23:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675411141; x=1706947141;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WYVOpVRcJ9ViNkfnXKw0GfYzDD3V+1zRahFLfsLYuMY=;
  b=S0bjk3XrFIYSYlRhHv4Zdr7x6XnSAdFqlZhA5FhMAx99wbCwg7ZHlH15
   /hMgaT37+fOL5YG511vTBpfEkxvsN+kZkIqeFK3irBx50H5n8Up9hp0UE
   FC+PQXwowX7Z8hgpU92u+nxTOPkGEL2HguUYSvFflOixYR0jS+BtSoj2f
   f7MoHSid4/tp+52nHi1+NWpg5h4NzMOnKQk89MBWMHzQMn3MFQyjpwyRV
   GyIHYU1LQ/uQ76jtnjfNs5qVro591Z+PgIAAPzcViO39l5tRk34bTFRKd
   z6PDemv0RXFHysNpuGdNTGromm8kvmHA2X9djFdP3Xu/Y6tr50j3+PsO8
   A==;
X-IronPort-AV: E=Sophos;i="5.97,269,1669046400"; 
   d="scan'208";a="222482908"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2023 15:59:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwL6i8936r6Xht+1EyX4DAibG3w9AA9b65Ppk1RDri5p7FIG4z2y5aY9+oYYA0KDOmXYU5YVwyoN13u4wMeiHU2XD/CW4y3xcMLX7JDXCtq9Yk9Pnx6EAOnS3CIgbHbq6MO8I6OzF6jsADsRQfElMGKQvCvci03RU8gXrCL/PXeYqDyy+570Kbu2PmweEeEJuwEXFlCPFkQDaOKF2DxbfpfroiuUypsSQ0pwK1WQ0C6f/UjAZKMAr2hOfS+MouOO3HDqiJyDNH5oU8Xapu5Dvu41s2qv/yOHOlK/tTkFnVgo7EmV+q/+8kAztYdv1YpSWXfpqfOioWmLYR/IIsVMIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYVOpVRcJ9ViNkfnXKw0GfYzDD3V+1zRahFLfsLYuMY=;
 b=iTaCrU5NR0gwRNFRtbLYcvp7tNZZsILqlACP++l0hi60F4jEzInsas6y2X4LMLtxmXxv7z5zMQp7rwGbGs7UNEbB9j2rF9hcbX3TzntHBlsjvbfSFy9Vl9uj5nvA8Y1sUvp0i8oQ+O7Lyfbnptx6CYgUR3/wRHVrRtFzz2CEPBHCMhLtunUG7xw2a4NOZI4bi060PXazJ76y0i99OiIcOwHF6To1T0ab5o+HOelg0n/WGD1xbMMySiHcHPN5rAFySaBjsLTv6QIMxO1K/sM6ZSfR2RL7ojmIxIqvRGAnP8T4lq2nS7KN10tyrSdtDejuv4qzPr+0+z/2rk7P4OvxVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYVOpVRcJ9ViNkfnXKw0GfYzDD3V+1zRahFLfsLYuMY=;
 b=fiwzo+EPImey2DSGqPZPkRe4tIboZ9R6iL+7gumMTV+67DUaifm+JAP9TcByWpnFMBtPsnSxO6ooRI013stW5AeWRhtZwEzQMmNF8T/1etqBxQ3DX8T7W2gUU8KeF6X4JvOkcPgdVF2XsUmb0v03RwTMAx6+21AUBDjHI13uOdU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH7PR04MB8522.namprd04.prod.outlook.com (2603:10b6:510:2b2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29; Fri, 3 Feb
 2023 07:58:54 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::e5db:3a3e:7571:6871]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::e5db:3a3e:7571:6871%9]) with mapi id 15.20.6064.027; Fri, 3 Feb 2023
 07:58:54 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Yi Zhang <yi.zhang@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [bug report]blktests: g++ discontiguous-io.cpp failed
Thread-Topic: [bug report]blktests: g++ discontiguous-io.cpp failed
Thread-Index: AQHZNsQ8d5k/ZVOS/E+aP2mQ5d3BU667+WAAgADjzoA=
Date:   Fri, 3 Feb 2023 07:58:54 +0000
Message-ID: <20230203075853.bmcx22uxll32ml2e@shindev>
References: <CAHj4cs8WN_OyT0ZZAG81UP-cW49cL6=ve5dzVFqLd_-zkfp6aA@mail.gmail.com>
 <5fc60de1-be59-3630-242b-fb6ea3a17da6@acm.org>
In-Reply-To: <5fc60de1-be59-3630-242b-fb6ea3a17da6@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH7PR04MB8522:EE_
x-ms-office365-filtering-correlation-id: cc6d3d95-f61d-40d3-3eb6-08db05bc7f1f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WljRVJFp/0Ou6fh+N3TS/yb+LazYaS//7WJp91JD7zWEmy/sPJRxFOxCKdRk7SfMt+KyuQGs0Bn4Ne//avy0b1ygRVpwqTXnBgsHr4NHy2VpOFDlDJFCovhBLRkpvL5MZ3RsBy6MdANjd8UQLqoV4EgwO4fLYZkp72Luwv3RnD/KFqyryYAIrUUDRUY9v+vTD5kiu9L2BhEevdcPuS7b/7UuhtT0tmtrqhHuDjB88nvtLra/kn7K4TnNl14MvXUX+Dmo5nGdI3C70DgdIDxVQsS3eslJvVNZkoeLFsT1DTlZv0fyrgNfB+mpDJV3jCT/h6xQVp5O8IFDFHJiPU0D9dH1bwN2GlCeA68dvAVUv+WRlOQ852rAY5pNqi1yCjviJTflFK5og90R76YNKWQdHXmXtn3wbwv6k1BCHpq74ODGQUvPULy+e3pi08GFiHfjBq/Zt09YQu0Z5SQZI5Kd93MCOOPvTHDeacrqyBdMi1qHnyUm7fHsA5jfjvqvcdl/5o6yWaTS/U9C+XBWZzvQMPBvn3ex76C8Gg/7C7KE4M5PsZSz4hyg8kmb5/RvFeOdOk8b/v75nAxJtHyco7Z8Tc2RVtrVoCc8QZ+Q3nr7Ch5/4fKQABK+PYc/d9DNKxypZhjhCZ3qXYHh7aYb1mhC6hjjfOTLDJSRbTeseSUAZ1ENrE/D0O08e2XsIok4x9JbmL+ffC+rtTdn3JgCC+sYBDx/87q83uBGZnImtw73gEM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199018)(41300700001)(6916009)(4326008)(66946007)(66556008)(8676002)(64756008)(66446008)(66476007)(76116006)(86362001)(2906002)(122000001)(83380400001)(8936002)(1076003)(6506007)(82960400001)(5660300002)(53546011)(186003)(26005)(6512007)(9686003)(44832011)(4744005)(38100700002)(6486002)(966005)(38070700005)(478600001)(316002)(33716001)(54906003)(71200400001)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2gvMjkrcW10Ykhtekx6MG0wZTBURUdjcHA2WUV1ZFR6ZmhEUCtZSUVlOElQ?=
 =?utf-8?B?V0p0empDVnRybFJxRWJHUkJEaENybnlTbVE0ckJ5eTg1Q0g0ckM4SVBITi8w?=
 =?utf-8?B?SmNiRlVPeHk2UlZ6ZkZtdERyb3VTZWRvRUdWM2FBYUlpdUYwNVJNWGk5MS9t?=
 =?utf-8?B?ODkwZzF2bG9lZ2VkeDN6WHorcUVvelVXR1Z0QTBjVFppODBkQUFQSEFCaFY1?=
 =?utf-8?B?MGdFaUFnSGdMc1V3TFlCRTRmSUptSytaRWVXQVdsS0FUeHZGTjU0aVh4cG42?=
 =?utf-8?B?NWprMnd0VGorQVBTY2VqQW5qdm1aNnJKem82TzV1a2JIWGgwYlRWckZjeGlV?=
 =?utf-8?B?S3ZQSHAwdC9xYjdPQll2QzZkWm9xa09xd284c3d4YzhkbkxQUkN0STlPUkVn?=
 =?utf-8?B?MGNMcDNsVllYL3h0YmtBRFdjZXQ2b0lNZkRwQjR4dTF4MEYwTC9sYjd1dExs?=
 =?utf-8?B?MlBzSmhrZndWblREbllscW1UQ2hLK3gwVVpJeXJEU3lkR2VERVcydWlFUGxH?=
 =?utf-8?B?ek04SXZvM0lhNHBGRk1kRGEzSHRxSzZ2Nkt5YUVOWERPTlJPZjc0SEgyVlVO?=
 =?utf-8?B?TXdJNVB6QWdDUGRVNGxwVndmR1FDT3FwS29keHlMY3lDVzFHYSs1dUNxUCtD?=
 =?utf-8?B?ODMzSjFUNXZhaFJzZ3paNHdVZnRWL1Q1Nk1UWG9KVVd0L2pQOWR2aGpLcEZP?=
 =?utf-8?B?TEJGS0V4VlU5MVhwTS9ISmI1cGtET1Z5RWlpb1BTc1Z2ZlRJVnBUd1M4TSti?=
 =?utf-8?B?aWJXYjZscjdZSG9aMHlaNXRoKzlaR3R3OEFrYUx1bGFpamR6b3BhaDN0TDFZ?=
 =?utf-8?B?SEhSTTI0ekNjOGw1dElPWmxBdUNDY2QxNy9VNjFRamQ5YlFDRjRBVHVnNXdm?=
 =?utf-8?B?MVZmdTVEQnhMZnMrWUNJbk53TG5DaVlDTDhnOEtVQjVFMUxRcDlLV3RZUG13?=
 =?utf-8?B?RitiLzdyRkF4SU5wcmNXcFp3cVVrUkY2clhaSHRyN0JRZGtpMC9CR3YxS1dU?=
 =?utf-8?B?c2VQZEpFTVR6bnhSa3FhQ2lLQk5KOG5Gc1ltQUNCbXF0YXpla3VpQnJZckhZ?=
 =?utf-8?B?Y0xEcTZEalZPWnhDTzEwcDN2L0kyaWFDYWUyUDV2akRkNnN3dFMxUjFCZ3hJ?=
 =?utf-8?B?SXBxM3U4VVZocGhiQjFKaThMSlAvR2tFNVhoS01uVVNKay9ITXQ4R1IzZTFX?=
 =?utf-8?B?REpmYjFhdEZ0OGxRT1hhdlArKzhFai96OGpTVExOZU8ybEZBNWhmTG51aml4?=
 =?utf-8?B?bVlnMXo2akdXdjdrVk1ZSWFIWFpYY1N0WVJHMUVpKzI2RGdDakFUdU9tVVhB?=
 =?utf-8?B?TnoyOTBMNlJCSkJ5QmRUajkwdzVTRVpsb2F0bFY2SG80NHBETTFzSXN3bCto?=
 =?utf-8?B?TFNkRm12cWE4ZjNMc3I4SmlUQ25ySjEvNCtuTlFscmhUbm4yV0d4Ukhlbit3?=
 =?utf-8?B?cko0OTduQWtVQXA2dHRpdDZPM2RLdnlDM0lxcXdIZlZ0cUF5Q0VOYllCOFRJ?=
 =?utf-8?B?Vmk3L045MktzRTA0RDhRb2NjVzh3bFBQUXZEOFdYdkI2czEzR1d0eVhRQjZ4?=
 =?utf-8?B?blFLLzBlZVVOdGw5SDNDcEhQdU40bmpKd2M3amh5cVJIOStObDFJRjFpNVhx?=
 =?utf-8?B?YURxOFEvblJkNm5NU1dJRDN0clRwODRRaWFvMUk2T0pWRFcrWVpxUHVpREpv?=
 =?utf-8?B?WHp0MDd2WlZ3TGVTSldpVmgyRUZSQXNXNzFmaDZXeHQ4ZVg0eFNHVXNPWFh4?=
 =?utf-8?B?WVJrNWwwbmszM0pCOCtOYWpqdkJqUHlLMXBuTXFaSVhRSXp6MGFxazYxaysv?=
 =?utf-8?B?TDNBN1laUi9ZQndNRjVnOXphdjhwY3FaVU1rY0pIdUt4V1JiUnRYcGIrT0Jv?=
 =?utf-8?B?emF4bXFyVHhIWE4wVktaMlBtYThZaTBmN0h6Z2d2UnRvT2hMTkdhUUV1ZG50?=
 =?utf-8?B?YjBZVWF0WE5MQW1sRjMrSDdLL2dhSTNuTy9nUUYxTFdWd1A4Wk9nclBoRHl4?=
 =?utf-8?B?OHRJU2tlTTRZN2pwVWVYeDFzQ2NJRko0bXBCQlhDMXo2WWVBZGdsUHBoeEZz?=
 =?utf-8?B?Mk94M1VRbVl0OTd4aUJLK3M1MkUzOEMrRjNoYzV5d1BhVTY5elNzT01iMEVt?=
 =?utf-8?B?bW9GTW16MnBHVFBIWkxtWEFpRWJiNlFic1gzOWtpMXRaTGRtMEtxWUNUSVY3?=
 =?utf-8?Q?xevWEzJxjiZPKnmjBXumus8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A98DE7DDE1A68C4889A5A5391B63CA30@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: J0429sQipH4mgs6aq/zFbm4Bych41vCc2C5LJfZQUHvpaCxwgmViQ0lWL106kUCIpT7p6A3ht0fMungDIvmpql7CtOyCz0j+GByE9lI7zQGxLCaKG78b4df5tbr/HS/ZzaYIDu7UyQfQ79WWDXYN6bFdHhj5/rjmrrr58LNyf0oX6GJ4HaB33MiIwWyq2prUWiUC9C5YotJryVYwbBXsam1ZJl0SzNX19COm71qJNSb9pzJBNE+3HQ97ld7yxp5nAxYkyJeXXsrY1HJ0q89YFLYcA/nUs+fFkayso2qdZPFZVISmOtAcdoMmlA1lNfvEgSbZOsngcjvTLR5H1fvXNlHZVOeXfRceSw6P5N4d1WFM3jBxO/O87xdRBAN+zyjNzx8TgZ1zDCznEe870bnwSqc42Fwf29rRL7a8OBa8vmInm0wxWppfLZGTCgfuZO24xu5yYLS8Vi1F8zXYsMfIpPzi4Msd0IBNKRbrgEhhyISW8lNzJCPOphJ/lblioQ5hv7UnMV/jsz4/86XVUAXZI4QOJaqBa7OdDAuoSRZWEg0uwDSce3Rar8gDi8IDGCONhF67PE6GX+Ics1a3LoSHeY2JbMcTJ4jQt0342I6OLmpWvXW0XQlkLhsmEocTsYpQbqqXMaIQC9QU6WO5JJbPilhWVsfAR2YrvxK5pSXPY45Zz3GVmgGTi/6DeyAUb6pcktlImWkwS6xY10yf4s49Ti1G6FBgA40oNI5Ekv+QdSp0yKdBt2xymxpaSTKcgqcd81bBRJoeor2X23R1AslqEtOVDRCiAc7qgiZWbUrGbwVLQNiB6FW3V3HC4YyyNrXzISB8nRh0TIqaYYqhaZ9oHw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6d3d95-f61d-40d3-3eb6-08db05bc7f1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 07:58:54.7644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A1joYardjuWoFom0QsEi+v2yGaZ8uHuQ1FpnmIFQBmMLn57FWp3Ashppt8jjQ6tu78M34pMmoTLsI0bMz7oyhl2vgE1ATTaSD1htyu0CAy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8522
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gRmViIDAyLCAyMDIzIC8gMTA6MjMsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gT24gMi8x
LzIzIDIxOjA3LCBZaSBaaGFuZyB3cm90ZToNCj4gPiBkaXNjb250aWd1b3VzLWlvLmNwcDoxNTox
OiBub3RlOiDigJh1aW50cHRyX3TigJkgaXMgZGVmaW5lZCBpbiBoZWFkZXINCj4gPiDigJg8Y3N0
ZGludD7igJk7IGRpZCB5b3UgZm9yZ2V0IHRvIOKAmCNpbmNsdWRlIDxjc3RkaW50PuKAmT8NCj4g
DQo+IEEgcHVsbCByZXF1ZXN0IHRoYXQgaW1wbGVtZW50cyB0aGlzIHN1Z2dlc3Rpb24gaXMgYXZh
aWxhYmxlIGhlcmU6DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9vc2FuZG92L2Jsa3Rlc3RzL3B1bGwv
MTEwDQoNClRoYW5rcywgYXBwbGllZCB0aGUgZml4Lg0KDQotLSANClNoaW4naWNoaXJvIEthd2Fz
YWtp
