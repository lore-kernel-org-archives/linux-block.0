Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC069C43334
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 00:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbiGVArh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 20:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbiGVArg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 20:47:36 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE63295C34
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 17:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658450853; x=1689986853;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ilwqFapV0bl4nERPqQwAfFP50tuQ9EoXhFN3OI+IO2w=;
  b=NphoPmAPcIfTmXSxyod1SGOeAeXdS3O9UrXK6ik8ooghSW2jFdweKJ/8
   F5Ken/JQl/xqQb1qWfvZUwY0B1Sn8cjyKhqAFKGL2V6yqk0RdKNW9Vc2a
   cMRabhIFe+awQodZC6fbGNfW4eJxXOyKrrgBNNLPz2M63RTOvVBYjHa58
   CV6HVypNZnOMzARhPtS+fzrmNBAr/3GH0zwuE+e63A2stSm3Kre2OohJK
   K/hTDp9JD81mt9FdF3DOg/W0vb7LZfVvrp+eRoIXTgKSRjVxQAh+0SeS3
   zVN5dIj/+RThQqEIGVzoge6TJHjVSLGuGdtyIhSFzxXHrvygTXzmI94ga
   A==;
X-IronPort-AV: E=Sophos;i="5.93,184,1654531200"; 
   d="scan'208";a="206595164"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2022 08:47:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIN87Ieo/NUgLdHQTSDUDmmm2bd0HyBewc6FlYvnuxisX9aJkF/3XyfA64sAWV81SsGRvZCQS9ajpoJTY/yoky7twqVu3jAbdHpwEkGCwwz8SkgFcPYY6cbcnS3sAm7RNUM0kn7SxLnZIm3hkRqzjfr390+O0fCI2YKkxCvtFSei96rucXqO64EeQsMoNaVRliyMkdJvyo6fvpJtvB6izM82Dd6+7aMG4eA1ItW6DuFQgC4mJVkn6gzOiLysUB8zOC49qgMyXQLNc5IczXunpCEbPrSobcw9IyzvqPCRUwN+42EVprlaulW03poocuYxaFhjZBiwdcbAeicayOCcVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilwqFapV0bl4nERPqQwAfFP50tuQ9EoXhFN3OI+IO2w=;
 b=lC1sjaBK2K5e2+7H5yS+i2IufKX5fQ12ex1Nou9T5BQUKMaR3qy0LYKxRrOW9v7Ym7eCnWgtse8VctrkhrJBFhZRZbuQuL4uV13TVDNFTISH121Nc9HeblQ0E6iI4AOrYTrqDP8BcVUTL+AjfZOOF85zQnmAnMp39bSyBLRoPU02m4jk2xFpiebLaeAvujZJdc/bhDBKMmdKSE9qzxv1xpsBBp56ROTSBMf992ERmUWxamjx84zYVadjnvIsIA+d+0ZE4kzA9r5hj8P4QT8PqNarMT5YijVbkNr8sb+uZwMdMP3lS85oRPrGcscbG9sdwjFIPsQsFEyapWhsq67fUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilwqFapV0bl4nERPqQwAfFP50tuQ9EoXhFN3OI+IO2w=;
 b=Tg9sygNdT9pLvRLwlnUvlNxmebhmIYf/Eb+fZhFrPrDvCo3zFazrGgv80DvV9oxiM58skhxAd3Y4rT/V0OWA2/1ktEj0yqY/OHwm02u2vMTBX8qMt7Jm51NqK6on4RiZC0inJQMYma2eoMpWX90/33BGUhkJCAHQIcJq74uEia0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO6PR04MB7732.namprd04.prod.outlook.com (2603:10b6:303:af::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.19; Fri, 22 Jul 2022 00:47:31 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833%9]) with mapi id 15.20.5438.024; Fri, 22 Jul 2022
 00:47:31 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Sun Ke <sunke32@huawei.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH blktests v3] nbd: add a module load and device connect
 test
Thread-Topic: [PATCH blktests v3] nbd: add a module load and device connect
 test
Thread-Index: AQHYmz06RA1orcrcikqFUq3b8/Ptp62JksWA
Date:   Fri, 22 Jul 2022 00:47:31 +0000
Message-ID: <20220722004731.7hhudyv5uzywybta@shindev>
References: <20220719071216.1555636-1-sunke32@huawei.com>
In-Reply-To: <20220719071216.1555636-1-sunke32@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dca05622-7f8a-437f-c8b4-08da6b7bc2b3
x-ms-traffictypediagnostic: CO6PR04MB7732:EE_
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +k4NLYSCEUD4eStvUC7wgJwIKKrcwIl1lp0BaAZzW5Y8pg6QAZzKN/VUu8D9i2Pc5qD18oqQVpZCrZPPL7HiTPQ1TdscxzrpQa9mBQGXkOuveAS5O2zBAxYEq9AnHCB9j4KcLGPrOVzAUk3elz/zKyuw35O0esvqvHMIGqqg0h+ZHELdV/Yv5O6orZIMEfYzJl6018VHqppeFS49G1rKrJejCFB1KgaSDBtX4XZ3KtuTKFnxzNG6gmNDPFH/jfN17IeVGY6+5iMVjoDzvMR+MHpmj2AkkhO/CrXnZ+KQatxf9kDK9xJ8hmqUX5UEFiNuUJKDJrX7zDxgCXA9stYMLYji3u/60FTVhYIrXmy9H21icDuzhzHggul8RuR3OnmZ2hdPZQAtTKzdgKOXtsmfJLRcGp9w8M01TwDNBrlrRxkeKNLiM+YubaX5xN0jBLm0p9fjYZnuH7H31wmY0YZJbBHLTsYx/BBfHd8MVMhcI5aUZp8IkT7NWqHaqVWkrkVO16+rhVOYj0wmpC75NLxk6lzz3F+XBWyeH1984uVQdABrMHSOzfHv6/LlbL/UwYj+dexyRKoOEZk/5aOzVaRE87kuVmlg14MhDN+WtTzegEF1Lb44faSTVjLFr21SMRfp61JIgC7L4lUeHRwiLkfSNVOsdz2gxN7+r1hibFOAmsgOxVr0fnK1STDbL4osRFqR7haLjs7zfWpwxi0Z7cb9PW8EtEVPFTvFan1KPcdvZPzNN4ghJri93Dhwc5hO8g0V5EjQv/AjIvbfjV4HFwe9BejhTKc0bmX1sVhONcKBaRaGTRVhPhC/swSZCXp3JsF6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(346002)(376002)(136003)(396003)(366004)(39860400002)(6506007)(26005)(6512007)(86362001)(9686003)(2906002)(478600001)(6486002)(122000001)(41300700001)(76116006)(5660300002)(38070700005)(66446008)(1076003)(8936002)(4744005)(44832011)(186003)(66556008)(33716001)(82960400001)(91956017)(38100700002)(316002)(54906003)(4326008)(8676002)(64756008)(71200400001)(66476007)(6916009)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mm5oOVg4SDB0NER1N0hJY3AvS2pFNWhyUnkvSisvcHRoMTVyeFd6bzZQTEFq?=
 =?utf-8?B?OHVYeEMvRVFKL0FlM1JtRm1HVjFLVHFkN0E2YmdlSXMrMFFKdzVBT1dQTnJJ?=
 =?utf-8?B?bnJkUjlENnZTSXBxZk54M0ZSR0U1WVFwUzJMMi9MQ2taTjBIRjVPSzFaZmRo?=
 =?utf-8?B?citNWUl0dFRGYjhLU1dsQlVpekZpZjNpNksvcFloendjZlhUS2hxRGw3aTZa?=
 =?utf-8?B?ZENxa3d1WmM3K3BENS9Cb3ByaHRORGNRbXRINFNPa3pTcGJ6UldNUWFqWFJY?=
 =?utf-8?B?NUorSUVSVDFnOUNkTWkxcHpFeGQzUEdYUWlIM2J0TkVOWjZVSGZPTGhkODE3?=
 =?utf-8?B?ekhzMHF4QVhQOXQyampEOTh6ZVU3QVpXZkdKQ0hmbUJWRjVwRmxqZ2RaNUVo?=
 =?utf-8?B?eTZqZWJzYVFFb0o1QVF1d29RT1lIVmRRTUxEWERYaUJSUmNaQ1ZQWkIwSldk?=
 =?utf-8?B?dng1dk54aG96SE0yWkhwQmxYUVhKM0R4WExPY2JBK1hkUVZDSTRMVjR3TEtK?=
 =?utf-8?B?YVdWM0NpY2p2cDJXdzFsL3lyWlhqVXhSUFFidzB4OVpBSDRkVjZaODR0RVMx?=
 =?utf-8?B?d2lqeTB3OElhK09UbjlLcEpEdG01SmVnejJUcGZTYkoyK2JYcEh1RWEwWkk4?=
 =?utf-8?B?Z0Q1VkRuRHlCTE0yWTFwV21Nd25WR3JnNTdLNUpBcnFvNXhiTXR2ditHanNs?=
 =?utf-8?B?Q0JOOVRIVDJIZFcvcE1qcUd4bEhGMUdjai9CMXJiMDllczB4MEQwTjl0N2tm?=
 =?utf-8?B?R3JVcVhPSXVINDRBL2VBV3VieDR2cHg1S3NpNktTejNYWjNGa04reHZRb1pB?=
 =?utf-8?B?dlFDa2VYanZ2bFg2UjVWN3RUdWVlbHVMdVlUWXhqSGVpZUJ5QzYyWE9pb0Rm?=
 =?utf-8?B?My9vTzlzNGV4WHdKRXkyQ3QvYXdmOFU0a21PNkUwV1pvYzVYSFVtRGszT2tZ?=
 =?utf-8?B?elh0NDZhaEtpRExnMzF5VjB0ZUtySjRzdmFORWtlaGZvU0R5NVJyY3VDUDcy?=
 =?utf-8?B?S2FaS0EyMjJWdm9Tdkc5UFVYUUhqU1NZUXJuNnIrMStvT3Z2T1NudDhaZFpT?=
 =?utf-8?B?d1puL1Vwc3RSSGpaRzIyTnd5YWFDSnZzQnUxS0JJdjdYMVB6Sko1cjhSTVc2?=
 =?utf-8?B?Zmd4N0RmaXFnOWVvV3NPQUFDc3dzRVdhaGpxWGU1Z1UzOCs2RVFPV2g4dERy?=
 =?utf-8?B?akJDV09oYmdRcmhMV1prWnpYYkl1R3FMeGd4aXh2Q0JKbVZUVERrU1J1NWhH?=
 =?utf-8?B?VTQ4a3pldG0yb0JraDk4aTJ6bVVWRUJXM2l5UnlKTzNDZEhldDdJenhDK0hV?=
 =?utf-8?B?bHQ0c2JXSUoycWxRMGp4dFlWSkZoYnVBL0E5NXlqYVNWNlJNNXY5dXNSQS9L?=
 =?utf-8?B?b1g3N3IzaExaYUFIS0l6OExOZGJ2bHk4d3pJSTBlL3F6STNuRThDSXBkdUlN?=
 =?utf-8?B?TjBFSURuNGJ4UjM0TlE0UE81alJaNGljMURFd3dIdm9QTENYRUhBYnRuUDcy?=
 =?utf-8?B?V1hmaDZZcGRYc3VBUGtlSElXTHpPQ0VlbnFSY0hxbkNmKytveXdNQ2R1R2tk?=
 =?utf-8?B?L3JkN3prcjRqTnh5bjN3RWdtNG9tM0E0N0RIWUo1ODJzNmVhaEpVT3dBTDhF?=
 =?utf-8?B?YXl3QnRIV0FiOURUTmhqdlZVUjFBSGRrN3RFOXZRTktsVzl6OWRLQVkvR2N1?=
 =?utf-8?B?WnZUS3R6MnlxeGZYMDd0OThGb0xSRjFJWGxOZ0tqb2EvQ1JmZVZlS2labnFB?=
 =?utf-8?B?WnhXTWlLeXBwWS8wVndMN1RGcUZCSXdubkZCNEllV3NqSGhIM3Rmc2diaTR6?=
 =?utf-8?B?L2wvTXVtUU9zWEZFNC9tMVY2OGJibWhmT0FEdDdLdXlhVHBYS3lYNXRvS1Fk?=
 =?utf-8?B?dFBrMVA0bnIrVWh2NUFxZzlreDAybURySDdzZkZxNmNvbm40OTZ1YjdBUGNJ?=
 =?utf-8?B?WVRReGtCOVh5dWpCQWlRT2tOeXBsQkJscGdmTXR4aGV6NDYwTk9qL2JXNVA1?=
 =?utf-8?B?YUs3L2JYTTBtQi9mR3QvVElkTEkzbHVGK2VDaDFVdWlsRTVROFREQUdpckZh?=
 =?utf-8?B?djh4dUlMTDEzUWpwMndqOVdyaDh6MWczZkIxUXdOem0yb1pPV0R4VWNVZkhP?=
 =?utf-8?B?V0gyNWZHNjh3QkFLbHRhK1crVHNNYjJubjVsSU55L0pQM2xXTWpKUnkzOWhH?=
 =?utf-8?Q?LENdQBtCjPiCPyz9xtryO4s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8AD5A74C1F26747A999852E4C21ECF5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca05622-7f8a-437f-c8b4-08da6b7bc2b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 00:47:31.7745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ps/uyow3BUHhVy4Vpe+W4BV63x3OHBLzeC+fgdjivZ5sD66ofyW+Gw9dojSMde6a8m1zwdCRKLzv8h4ym66TCaBZv8D931EyIXBWpZVyzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7732
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gSnVsIDE5LCAyMDIyIC8gMTU6MTIsIFN1biBLZSB3cm90ZToNCj4gVGhpcyBpcyBhIHJlZ3Jl
c3Npb24gdGVzdCBmb3IgY29tbWl0IDA2YzRkYTg5YzI0ZQ0KPiBuYmQ6IGNhbGwgZ2VubF91bnJl
Z2lzdGVyX2ZhbWlseSgpIGZpcnN0IGluIG5iZF9jbGVhbnVwKCkNCj4gDQo+IFR3byBjb25jdXJy
ZW50IHByb2Nlc3Nlc++8jG9uZSBsb2FkIGFuZCB1bmxvYWQgbmJkIG1vZHVsZQ0KPiBjeWNsaWNh
bGx5LCB0aGUgb3RoZXIgb25lIGNvbm5lY3QgYW5kIGRpc2Nvbm5lY3QgbmJkIGRldmljZSBjeWNs
aWNhbGx5Lg0KPiBMYXN0IGZvciAxMCBzZWNvbmRzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU3Vu
IEtlIDxzdW5rZTMyQGh1YXdlaS5jb20+DQoNClRoYW5rcywgYXBwbGllZC4NCg0KLS0gDQpTaGlu
J2ljaGlybyBLYXdhc2FraQ==
