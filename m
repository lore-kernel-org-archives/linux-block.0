Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A07C43334
	for <linux-block@archiver.kernel.org>; Fri, 15 Jul 2022 08:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiGOIqY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jul 2022 04:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiGOIqW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jul 2022 04:46:22 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80115814A9
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 01:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657874780; x=1689410780;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0JSZsx4dfmXZNYuUl/Hs336NK49B91eCNBorx5lSrgI=;
  b=ThtoU4QbC2gLkytOJu++w4uGJPhmjjSSiKejMU+cVqBNN5+Idx6r55qk
   sJNXhHaS0s/xvQRsxHfyOzUGrTX5+f9CFxXU4YUUlArtfhwsgabwvvqZT
   to2ADo7MTqW+/WymBIAUW3azk812EZG6So/hf0HlY+ArNBg3wHHMqmVIH
   oJRx3UOisqg/1c+Itc5o3NlIf0yCcH2/fDoZgCno24P8hX37jTk8VKahm
   CdAs4GrTDifHCYZ+aoouD7M7vemNKTM+EeONGo2sMX+QSOCdeQOr/qJfv
   Bo5Jml7PiQpGFVOjn3hFX5DWsI2S4kkwzByOXqATP8EOY21YAlLz1M17Q
   A==;
X-IronPort-AV: E=Sophos;i="5.92,273,1650902400"; 
   d="scan'208";a="204457158"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2022 16:46:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5vNrbPv/Z6PBt0Gpc46g+/q1voJs3bkbkTHPqnzAfgmNCbxrBKMVgL1nqgeRrO7hIE9LEU9VspOAPMP1ZSf+r0vwZE/IKPPw3tsrz5qhFOLMCK+MUBTXLAZtqEwxJrTDAwzczkUa7yZFqJm2bh1XAJolRDqlVFv7qtcnNHtyqtwXLaAupogLwiMVeTIkzEam/kWwS2KZHytzc44eJGA+eE5Buwicj72PZwMsJH9O+hTDfdhi5qU+x16c+kL3NfLaz3BYCqGlYLCwnCgrrvG1MBh6R0wShePGcrF+Utwo573mBp6Q43B0PoK2XcVcLD8I1iyeHLtCEQ9TYn0ZwXrYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JSZsx4dfmXZNYuUl/Hs336NK49B91eCNBorx5lSrgI=;
 b=E5e7HhkJ2fkURz3kLD1t5ptRjs5EnfILnIsxrz7NgGefggcZ3LYUe+b7q0OJuofwiqoMFm3X2XpvkIv//jb3zuJ821ebJAXSff9tO43Pgr1D/ntxTnwqYW5xzQbSeGfEVz8RH1cktYvRtOVOy4YhGgHAIgfU5bMeDQXjuzchulULMqadZt+5sHJiVJtUR7oqHLI4c00cvCB0c0PgBHCz2VIDmVlDybzVrMv+OXllZostIxaJ/nEkONqhm7iKpUrjajGSG9VhEVEkaTkdV12q8WbcPZMyHs1Qeka2ndnUTYv6QCyiz3lx5ENhhI+rbo0e8QNuSCW1GGRmvuiM56ksDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JSZsx4dfmXZNYuUl/Hs336NK49B91eCNBorx5lSrgI=;
 b=luUrFIa3U+h5YlSoEW0j940x7Ssf2jqBk8F1NIzlv6BTZLo18SfvoUXIZUvv03EF5ptEm7iaf3VyZHHR3nVbJibbNvdzj+DQKWANA5KIkFXHhEWh9kzDM6A3p335GK2AarJWx+I0gbjDxkdGFhcZFPNK+U7vdfra/9nUvyu1H8w=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BYAPR04MB5480.namprd04.prod.outlook.com (2603:10b6:a03:ec::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.14; Fri, 15 Jul 2022 08:46:18 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833%9]) with mapi id 15.20.5438.017; Fri, 15 Jul 2022
 08:46:17 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Alan Adamson <alan.adamson@oracle.com>
CC:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] tests/nvme: Set clear_ids for passthru targets
Thread-Topic: [PATCH] tests/nvme: Set clear_ids for passthru targets
Thread-Index: AQHYkL5n6NLp1alVRUe39BVZOzdS361wenOAgAEGq4CADJowgIABEeaA
Date:   Fri, 15 Jul 2022 08:46:17 +0000
Message-ID: <20220715084617.evi53gtxem7npkii@shindev>
References: <20220705205632.1720-1-alan.adamson@oracle.com>
 <cd910676-cf1d-ae13-94f2-e1ccd59d431d@nvidia.com>
 <85D002C4-B3F7-4EE1-8C0B-B2E41F234046@oracle.com>
 <4AB40A37-F3CA-496D-80D9-13845D6DC3E1@oracle.com>
In-Reply-To: <4AB40A37-F3CA-496D-80D9-13845D6DC3E1@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b1b30fd-b367-4cb2-3f2b-08da663e7be3
x-ms-traffictypediagnostic: BYAPR04MB5480:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rMOcvAh+F5PxMlcZ13q2b6XdJ4d6WuBMoTEHQFaz/ZGmxw/XDtE+Pn1KquQYcPfvCuhuevzGuhhH/cLu8KcA5MA2CRPgxcs5iKXoRkaafc3IEAeJGFpkwPSHBmHKX6oGP2NxiL+AfhHtkxRk2WlIe6emQ/dCTPZI8GgJLHoUXp90tWnn+HTvD/MQJ2IfSoZCa3SWnr5jAZgUNZsGEtUWb7tomGuM4QoQtfLcF0d2ir3C+WttWr8ka0Y4kHUE1NPLJvMXFlj07IcooP3//Kb1r0wM7tK4oS1ZwBLXKXUnk/kfqEcN6KI0ov5wYxRKmK0vdHjJG7ebc4R2ovYB98DoLuQ6c86mAWG9D7b82HlE6ilpQBuKKSLOcmJk3FeQxm05QF80q+vMd6JvBG/k6KU0UKqxwErYx3hXCdiyUu+hnwGk7qO+wAHxqkBmLXby32pDbqs5yMBFS/bJGroE6faj40yhzmjA37Z01Q+6UwGWNbwqZtIX6wMA7OU6s++b7svIBx6IfxVDu1wE2yYeEYlNjWxw7sNt6btLgD6fKRXZGMJBJTd88eHlvB6R/4k9UYRPj5G0jkSVpoh0GYd3j6gca6MXAoZSufAZLy1gl0BQwVxLMQACH75o3lzal5zRknOoQxa23toCKyVVhlZDAVgciesH00VPluhEsFaT7NhkBYrrz6mEoETCloaegqOd1PvpIeRB7RHPyq+Km108eGKF/JTXbt3KabgKAYXnJ132aJneit0xMvd+biNbAbDAxGEw1bf+GDqu8lCbzH1z+WqK8erTkwk/hiW6uLLhMV5vx2y93JF7NwGvyRJSZ46d1ufK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(376002)(396003)(346002)(366004)(39860400002)(136003)(38100700002)(8936002)(66476007)(66446008)(64756008)(4326008)(8676002)(86362001)(66556008)(66946007)(91956017)(76116006)(122000001)(82960400001)(54906003)(38070700005)(33716001)(316002)(6916009)(41300700001)(186003)(44832011)(53546011)(2906002)(26005)(83380400001)(9686003)(6512007)(6506007)(1076003)(5660300002)(478600001)(6486002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1JDa1dadGc1MnFEcG5WTnFEdEV0cjJwL3VVOFhsRzRIemZ3d3BNQlNzVCt2?=
 =?utf-8?B?Z2ZVOHpCQXZ2MG1sYzdwVkF3V0p0R0JGNDA2eUtwQWhLL2VGYnJqS25qVzlw?=
 =?utf-8?B?aXg1MSt3RkZJUVFVU3FKWlh6QkZJMXJGeXpveWZ1QndYK2kxS25YdTN4VFZZ?=
 =?utf-8?B?QXpQejMydWYyMUszZjhMcFVFMVJFcnZFcm9FV2Y5T3l5dzdMdjVGVk11YU5Z?=
 =?utf-8?B?M2VVOUtGa2hjamJDU2lQM2orM3JFTCt0bjFIMzhJa0FwQUdseTczUTJVV3da?=
 =?utf-8?B?NCtxQjZxVUR6UnVROFcweTBZNUUyZ25OZklGUHBxZFJSblVsYitjU2RmVTgw?=
 =?utf-8?B?NkVHTzFKT3VYbEVxZk4xM0FXWkZtSWw4K3pUMHppWTBZNXRBdzBQNUtVakIy?=
 =?utf-8?B?V1VwdzRIYlpkSGNMcWtLN0lTU28rcnhhdkczZURDQzg5UU8rVnhxRXJHK2pF?=
 =?utf-8?B?Qy9zdE54SDdnRFJYdys0ZVl3WW1xUnVSajg0RGNPMHdocHQzdXJmTXlZMDJl?=
 =?utf-8?B?Yk9xQ3llRzFralpDclhTMHpZTVJtNEpaNTlTWVZROExvL0tDU1BzY3VidCt3?=
 =?utf-8?B?S0d3RnlPZ1JENk5OTXdFN3VxK1BXYXBJakM1V3kzTFRxTHJiTnY3eDlzcVpt?=
 =?utf-8?B?dFUvRHJYcTRZM2lrQndhZHpkM2RjUW5ER2EvM2YrUWV5OXl5RmdPYS9HSFFs?=
 =?utf-8?B?WlhHek5kUGRjL3FUYmlxaFhMU203eURtMUZ3UDdsZmQwWHJ4VnNFdjdydE1S?=
 =?utf-8?B?THZlb29zSUU3QlJxemhScUgxaFAvS0pxVm5tMDFlWDJ5RWNQQ0pLbEVrUkJu?=
 =?utf-8?B?MldKeGlsMDFNelg1M0pTblR1USs5K2o1VXpnK0I1dk5qSitCTTJUM0RFZHJ2?=
 =?utf-8?B?bm94WnUvekh1bFY4Y0FrSHNwZ0d1akY3ekoxaW9zRjA1UGU3OHM0c0luUnd4?=
 =?utf-8?B?VkdCZnhRVkhTTmJxUG9ZY1IzYVgyN0dmbTFUcS9NRk5uVTBTckNHSEZwUDV2?=
 =?utf-8?B?U0t0UXpsdVFvSGFDbnVGRjFTSWdZc1UyQk5DZ1Y3TFhHdWtTYVJpSnpkbEUr?=
 =?utf-8?B?dHkvL3J4N2RTQUlPL2QrTmpLelJ0UURQbkY5VEVDZ2VEV292MFdrYjZkUnBr?=
 =?utf-8?B?dlpKS0NzK0tETUNzUklzK1A5dXJLMGp2ZmZWb2VmY1hscEJBQURKRUVlRjNS?=
 =?utf-8?B?QjlZK1VFam1Sem5RaWxKSXA2ZWlLT0JJQjgxRnpTKzF4RDliQW4reFFEZ2N2?=
 =?utf-8?B?bWk5aXVIUjB3Y1k4N0NWVUZGdW1rbHd4OTFXQTdVR0R2MWltRE5KZGRCT0Vj?=
 =?utf-8?B?YWxwc1RxU21WRmt6VUg0VUlUb09YcFVJVXFBdStpYkdvR2FsNjM1dFczNWsz?=
 =?utf-8?B?N3hIbTNvOXZOaldrNjY5ajRpczVjcTMydjN2L2hGZkhtV1BNWklhbk9HR3JH?=
 =?utf-8?B?cWZHcHM3UDByaWRFelJyVjIyQzBZVUtoUGcxdGxCemZOc29XT1NtcC9LVklS?=
 =?utf-8?B?RUtRckxDaWxCWExJRTdRYnN3ZmpiRktXUHlzeVNyMm9HTkk1YWpjV1J3eXgy?=
 =?utf-8?B?OHcvZ09CeUh2dWVpdjBFZkRUTk1lWWpLYWNHM1NJc0R3bFBCcHFWYTBFRGZZ?=
 =?utf-8?B?ejVoZmF1NW91a1BpNm15d1IrNzE5eXc3K004emJ4WUsvWVdkcTJSeTlPZWFQ?=
 =?utf-8?B?NzQvY2dGVHZSdlBWNTBnTUlkK1FjQnBEOFkvWklUcFdmNksxUXNIcFJ0K2d6?=
 =?utf-8?B?QWo2NnRhMG1ZQWVOMUlYVGMxSWoxVnZVUzNWbmYxbjkyNGpxeUVBN2JIemNa?=
 =?utf-8?B?VGQ2b1hjeXhteDB2cFdjc3BoRkVZZmJpb0RDQzN0SUVXeCs4cDBha3NnU2dk?=
 =?utf-8?B?bUQ3dnpLQldUQ0RxbjRXOFZ0aXBtUW16b3BFMHptWjlQVWRzWjRqenpCM1M5?=
 =?utf-8?B?eWk5U21IZ1Zuai9WVHlwN014ZjVQU1Nralhhc1BCcHJrWDlJcWxxdEZuVTlp?=
 =?utf-8?B?TDVUTlRublZJNVBadWwwWEdOeXBnRDhvMmcxUG1Rbm45bG9iQTgxakRnZWl1?=
 =?utf-8?B?SkdaVEpBaTV6dVdkbjN2dnhCaUpHNkw3a1NPSFRwYzJOVlJ2NTlwdXJnd3A5?=
 =?utf-8?B?Y1M2WkhTRUMzS1l4eXVaMEM4YVo1SkthUkxrMUJiNjVnOWJYSitvQVcxQXlB?=
 =?utf-8?Q?2mBy4XPPd3ZDopBwiGRTRzo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD0192724655E2499DF1C840816B695E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1b30fd-b367-4cb2-3f2b-08da663e7be3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 08:46:17.8686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7k5IfCdYk5GM2okk6UoH0+EejCP3m0DBnmk9EzN0IlgWHC1wQ0t+bV1QTMeIJeebnUnZOWBXf4oRTipotw2PkBqbyA7IdxBNsK0+yIyCshA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5480
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gSnVsIDE0LCAyMDIyIC8gMTY6MjUsIEFsYW4gQWRhbXNvbiB3cm90ZToNCj4gDQo+IA0KPiA+
IE9uIEp1bCA2LCAyMDIyLCBhdCA4OjU4IEFNLCBBbGFuIEFkYW1zb24gPGFsYW4uYWRhbXNvbkBv
cmFjbGUuY29tPiB3cm90ZToNCj4gPiANCj4gPiANCj4gPiANCj4gPj4gT24gSnVsIDUsIDIwMjIs
IGF0IDU6MTggUE0sIENoYWl0YW55YSBLdWxrYXJuaSA8Y2hhaXRhbnlha0BudmlkaWEuY29tPiB3
cm90ZToNCj4gPj4gDQo+ID4+IE9uIDcvNS8yMiAxMzo1NiwgQWxhbiBBZGFtc29uIHdyb3RlOg0K
PiA+Pj4gVGhpcyBhbGxvd3MgdG8gY29ubmVjdCB0byBwYXNzdGhydSB0YXJnZXRzIHdoZW4gdGhl
IGNsaWVudCBhbmQgdGFyZ2V0DQo+ID4+PiBhcmUgb24gdGhlIHNhbWUgaG9zdC4NCj4gPj4+IA0K
PiA+Pj4gU2lnbmVkLW9mZi1ieTogQWxhbiBBZGFtc29uIDxhbGFuLmFkYW1zb25Ab3JhY2xlLmNv
bT4NCj4gPj4+IC0tLQ0KPiA+Pj4gdGVzdHMvbnZtZS9yYyB8IDMgKysrDQo+ID4+PiAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+ID4+PiANCj4gPj4+IGRpZmYgLS1naXQgYS90ZXN0
cy9udm1lL3JjIGIvdGVzdHMvbnZtZS9yYw0KPiA+Pj4gaW5kZXggNGJlYmJjNzYyY2JiLi41ZTUw
ZTY5ZmIzZjAgMTAwNjQ0DQo+ID4+PiAtLS0gYS90ZXN0cy9udm1lL3JjDQo+ID4+PiArKysgYi90
ZXN0cy9udm1lL3JjDQo+ID4+PiBAQCAtMzAzLDYgKzMwMyw5IEBAIF9jcmVhdGVfbnZtZXRfcGFz
c3RocnUoKSB7DQo+ID4+PiANCj4gPj4+IAlfdGVzdF9kZXZfbnZtZV9jdHJsID4gIiR7cGFzc3Ro
cnVfcGF0aH0vZGV2aWNlX3BhdGgiDQo+ID4+PiAJZWNobyAxID4gIiR7cGFzc3RocnVfcGF0aH0v
ZW5hYmxlIg0KPiA+Pj4gKwlpZiBbIC1mICIke3Bhc3N0aHJ1X3BhdGh9L2NsZWFyX2lkcyIgXTsg
dGhlbg0KPiA+Pj4gKwkJZWNobyAxID4gIiR7cGFzc3RocnVfcGF0aH0vY2xlYXJfaWRzIg0KPiA+
Pj4gKwlmaQ0KPiA+Pj4gfQ0KPiA+Pj4gDQo+ID4+PiBfcmVtb3ZlX252bWV0X3Bhc3NodHJ1KCkg
ew0KPiA+PiANCj4gPj4gd2l0aG91dCBsb29raW5nIGludG8gdGhlIGNvZGUsIGp1c3Qgd29uZGVy
aW5nIHdoZXRoZXIgd2UgbmVlZA0KPiA+PiBhbiBleHBsaWNpdCBjaGVjayB0byBlbnN1cmUgdGhh
dCBib3RoIGhvc3QgYW5kIHRhcmdldCBvbiB0aGUNCj4gPj4gc2FtZSBtYWNoaW5lIHNvbWV0aGlu
ZyBsaWtlIGNoZWNraW5nIG52bWVfdHJ0eXBlPWxvb3AgPw0KPiA+IA0KPiA+IElmIG52bWVfdHJ0
eXBlPWxvb3AsIHRoaXMgY29kZSBpc27igJl0IG5lY2Vzc2FyeSBiZWNhdXNlIGxvb3AgZGVmYXVs
dHMNCj4gPiB0byBjbGVhcl9pZHMsIGJ1dCBpdCBpcyBuZWNlc3NhcnkgZm9yIHRjcCBhbmQgcmRt
YS4gIFRoZSBjaGVjayBpcw0KPiA+IGZvciBuZWNlc3Nhcnkgd2hlbiBydW5uaW5nIGEgcHJlIDUu
MTkga2VybmVsIHdoZXJlIGNsZWFyX2lkcw0KPiA+IGlzbuKAmXQgcHJlc2VudCBqdXN0IHRvIHBy
ZXZlbnQgYSBlcnJvciBtZXNzYWdlLg0KPiA+IA0KPiA+IEFsYW4NCj4gDQo+IEFueSBvdGhlciBj
b21tZW50cyBvciBmZWVkYmFjaz8NCg0KSSd2ZSBhcHBsaWVkIHRoZSBwYXRjaCB3aXRoIGFuIGVk
aXQgdG8gcmVwbGFjZSBzaW5nbGUgYnJhY2tldCB0byBkb3VibGUNCmJyYWNrZXRzLiBXaXNoIHRo
aXMgZWRpdCBpcyBvayBmb3IgeW91LiBUaGFua3MhDQoNCi0tIA0KU2hpbidpY2hpcm8gS2F3YXNh
a2k=
