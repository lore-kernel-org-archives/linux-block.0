Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BB0C64E7C
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 04:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85006221FB
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 04:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgLBESY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 23:18:24 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:46434 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgLBESY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Dec 2020 23:18:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606882703; x=1638418703;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ke7xjwN/Qeqg7QfxZDnKzn9/w2R5beS8O54Onoykmf8=;
  b=m7pc1iPULGS8f9jJ9GqCOKRETQaUO+YhYrI7Bbw9oD70XbIb8c4KIpE/
   0jHRF4ZMNve9UuxDcRE2UYmOd6IzOX257Ypnhkko2QahZiOV1Bx0REL+u
   jfKSfL0gxPAihZQguumm15P2/ms6pde/8zGN9VmvBfTBlvPP0jgh9/RgC
   L47Z4N/HGBdkjVBo7WfnRh15phArWDiTMWTU8V0W+2ubKzVHUbbRL52du
   PjYTz3HCD0yxc2HTQhne4yR1+JkSEGBwKZDfgKGno+ytU22Eh2A58W8f8
   /8Re8XifIjYgX65mVPTmEHWmuwARYoqQHZ1LsSoGjR6l1tUi3L2bp3qA7
   w==;
IronPort-SDR: OisK1dzPkRYHpVs3O3i011uEzF1GIhqj5Gl1ngcPMKX0wNeyHIwrnEqj6lB0DEKNkR+/MdFBIA
 dlzG8/qaw8dZVvzGguIixvgDt/C4tgHKBAEgBtHM5Kkh80AACfG7jMTGpfzwWb/ABQSnjbAEYi
 vzijVh2TFs0SQWuXjOQ1Q/Hc+XUsnUPORi8zn1M7dpJ4aH9o7SSg09UO7Yh7WcoKntMUqPpUWS
 A5dVm5ajzJggJaCf7bziY+gbf6Ev54VCtEjT8uPNGYRCSyjunF/akg7kzo3or8cxUj1COHQozw
 U4k=
X-IronPort-AV: E=Sophos;i="5.78,385,1599494400"; 
   d="scan'208";a="154053684"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2020 12:17:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfUDN2CZ27zECFkF16haOEROpCfslrEYiWZkO82fnJs6xy5k/pPsel1fhTFCwo7UXTYUx07Z+z0rYZN+LdSRlLQ5c514VZJg9Jnwak5YyDGVMnDeiasXRU5KC/400B68bjsj/Mu/6cMTUsMCLkQaMFjT9lIOizqKB/vF9DA4oQFbqBySyqwxAzAObr+QNk+Mp+YxMRDulgGt4iA9wqhIuJuFVFI7QvpxWAyY0eI2HoVyko34aY37rU9UhmAxuJIOXw8x+rKREsoYdH0i5ZLrIIjH/Ge82X1gwheC53E16HO138Rs+vYf87iI+ZjvELt47iEQ/bPwBrHEYZXZhK2qAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIBesZqvcYlspZ1AOj1sjvbCBjFUTt9K+BDA1qracZg=;
 b=TKAlznwoT7nCj7UZCYd8TnX/8i3WATduVusFbqs6ulD9HDTAtqn2sD0XfbhgRXd5BVK3Tgs3g/KKkG5a0ZvzYELVg41nO5S3RTmTxR/el6b3Ft7Z5o7IMp2YCLXm9lTG49Sr5REH0AEHgKmb2co6bW/C8RSa3QxQFgGnKWGePR6PR4EVjUxJZdl/WjNVDLB+aNidcuYaaD/cw30FJtXaliqMLPn0nb47sfTHWWeVLQp/nOASpTxKL1PhGWjv2BCwVaX1Eds6htsSL2jwZh/dD/r+/h3W4376pH7lFJtY5KOfYmytq+xEXDwzbbEj372mBY5wZMHj430lANFDCYVaTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIBesZqvcYlspZ1AOj1sjvbCBjFUTt9K+BDA1qracZg=;
 b=W9NSyPnIGUbdnR+UAD1VbJZAoCiMaMwV3ReQBrGMdw57W1/WhQL4EsRTN2erDkXuCM8pzNvlG6tZTRnW6KXDLj+ANTf3td/ViwkWtz3wteug7rLT1Dp2uq7JM+jlFHHBsm0yAQFOUPv1l4YFsCFB+sGQf0DEARWBUiunTST0H7k=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB7128.namprd04.prod.outlook.com (2603:10b6:610:9a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Wed, 2 Dec
 2020 04:17:17 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Wed, 2 Dec 2020
 04:17:17 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V3 0/9] nvmet: add ZBD backend support
Thread-Topic: [PATCH V3 0/9] nvmet: add ZBD backend support
Thread-Index: AQHWx5hxyX5y33697USsRw2vyDa0aA==
Date:   Wed, 2 Dec 2020 04:17:16 +0000
Message-ID: <CH2PR04MB6522AD27DCACDEBC04EF6A00E7F30@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
 <CH2PR04MB6522A2943EFDF118FEBA264EE7F40@CH2PR04MB6522.namprd04.prod.outlook.com>
 <BYAPR04MB49651C09824B2C82E44DB79C86F40@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:18de:edc1:5ede:e698]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 20fe59c0-7125-442a-6bf6-08d896792777
x-ms-traffictypediagnostic: CH2PR04MB7128:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB71287BF9F677854813C1A2DAE7F30@CH2PR04MB7128.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XHGif+v6a1FvOrovTfWJV0u6WGphreXw6ANs7J3cEp9FSKFvFmwlia2o7l6mPXcgItebtbApTWBIO6jTbUMj49ndU9FxGsyw65ZZLSeuXl38EockdNYe6+PRZOvjvnVsZvis098j+X4kaUYlakPybsQmRt2sq+cSYs6qefiupMKOT6djWRsN8g72Olvuk0DgUwADwkcFLWfixTM55rWzw9vfNleghucXs/G3zjD3MEyTGHhkatWKR9Gw8x2rwIevgGJqQbjU1Jno8G2P+k6C0ZwmyCx1UiLmJYV5tFIEt/GYE9d0n2jXhIJ6dLWNKWeC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(33656002)(52536014)(8676002)(8936002)(83380400001)(91956017)(5660300002)(71200400001)(76116006)(86362001)(66446008)(66476007)(66556008)(66946007)(478600001)(2906002)(6506007)(55016002)(316002)(110136005)(53546011)(9686003)(4326008)(7696005)(64756008)(186003)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Q4Yi+0Y075A5bLodlhTf1z0Geswsyqi3P7DFGBkG7/qgaCTZvorhkuGwgxmK?=
 =?us-ascii?Q?DdsTMG0sFdmKm8wDl4ib7caj3AQ/jZG90qL+dSaU5g0c6o9qmw4rZLXeU8EE?=
 =?us-ascii?Q?PhF0+RBLAgb9lQEkLj3fyzjjhNp7QHbKOh3jwRmbGHV7P705dIvMcpocp5Wc?=
 =?us-ascii?Q?nz1p3w4gcVBNYu1Bfx3efqadAmKWrQQ8Endx6ErFQ5yluO8KNLd5/3OGtu1G?=
 =?us-ascii?Q?aBAbrCukIo5PBWkx6dATDQVfMFtb6rt6lEocSihzPY0uAzpbKQnz5mrh+2xA?=
 =?us-ascii?Q?+iYvMqIMUcY/BaWBsiE9LZ1ZB0UzIprEl5cG9msptEnlsUNXsvdtYoOnlJS/?=
 =?us-ascii?Q?abfRRlp3hYQ0bwyWbPZNQL/3Q5Q6cwvbXpqNBWN/R9/Ekl3gvF0dtDAd756R?=
 =?us-ascii?Q?1BKiRW/6wIxxMXity6ZlVFSA19nhXNpDOklpHr9XowICGoid6MR81ZcS2SOZ?=
 =?us-ascii?Q?IxlJwcv0csYH/2BA0evNIGJw4tMiUHl0ZbcWmrz/g+ggTHKy9wFXkS/1bbi5?=
 =?us-ascii?Q?fw/fkLsyqIypSjF4XD1t1/Lg8Jfkx4dJuQc3QVinUTeeDlXjHn8pbLlHlCgV?=
 =?us-ascii?Q?dB0OPfEQTG75Z4/niC8ZYtSiLxk6OZtHn1NoJWRnna3ImQcFnfyXZk3esQlu?=
 =?us-ascii?Q?HFi0AFDGLUKdxXycKWi89SRUtfjaun2mBb2mkjUjEjvNxL/3dPBZB+vM6MU1?=
 =?us-ascii?Q?sR+GgmWax90x1s2aGfc38GxL04hmYk0PIR7ygGF1r9DD3oQ4pjankvhxu0OC?=
 =?us-ascii?Q?FXu5XlJV5EtDq/z7PyIU/Jcxtj1C1Wt4qzcJ7a7jwyaMy4VDYSrccT26S4wb?=
 =?us-ascii?Q?RhX214aTQ5f3J5gO8ZyyWkGly7XpN0L6IXB+oEIejSSjycq8JURTodNU1F3S?=
 =?us-ascii?Q?B5WiSpBtYvWsQ7qugf6uZtB7tNEaJBcVbl7+mWbmlur9BPFo5sH4B9xctgv7?=
 =?us-ascii?Q?k2xkEZGUlOKfYanUeXcybRWehcmQ76c94Q/J94MG9yx9PxT2u8IEcb5nHImc?=
 =?us-ascii?Q?n5ERQY8B5pqC61hEeku92zteIEc1HV2vu+pRtH25d28IflgEkCiNYkWANL7n?=
 =?us-ascii?Q?PTcZoGU+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fe59c0-7125-442a-6bf6-08d896792777
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 04:17:16.8838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8o38lKuONtv6Tb5xWmhtqVQt/htfUm7D3kTbFfrn4wrVjMWx/1DMTgWASIEkK+cm/NE+LsT2Du1L9Y1S8Ab7/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7128
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/12/02 7:34, Chaitanya Kulkarni wrote:=0A=
> On 11/30/20 22:47, Damien Le Moal wrote:=0A=
>> This passes for me:=0A=
>>=0A=
>> ./zonefs-tests.sh -t 0012 /dev/nullb0=0A=
>> Gathering information on /dev/nullb0...=0A=
>> zonefs-tests on /dev/nullb0:=0A=
>>   4 zones (0 conventional zones, 4 sequential zones)=0A=
>>   524288 512B sectors zone size (256 MiB)=0A=
>>   1 max open zones=0A=
>> Running tests=0A=
>>   Test 0012:  mkzonefs (invalid device)                            ... P=
ASS=0A=
>>=0A=
>> 1 / 1 tests passed=0A=
>>=0A=
>> This test create a a regular nullb device and tries mkzonefs on it, whic=
h should=0A=
>> fail since the block device is not zoned. In your case, it looks like th=
e test=0A=
>> endup using an existing zoned nullb device, which should not happen (nul=
lb4 and=0A=
>> nullb5). How many nullb devices do you have on that system ?=0A=
> =0A=
> True, my test script creates random number nvmet namespaces and nullblk=
=0A=
> devices.=0A=
> =0A=
> I think testcase is reading the wrong device, let me finish the V4 with=
=0A=
> removing=0A=
> =0A=
> bio checks as per your comments and I'll look into this.=0A=
=0A=
I pushed in zonefs test fix for this. Please try again, it should pass now.=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
