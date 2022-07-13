Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBCDC43334
	for <linux-block@archiver.kernel.org>; Wed, 13 Jul 2022 10:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiGMKmB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jul 2022 06:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbiGMKmB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jul 2022 06:42:01 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4337CFD53D
        for <linux-block@vger.kernel.org>; Wed, 13 Jul 2022 03:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657708919; x=1689244919;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pkpcmkO7u0lbyZKuvyoG1Z/HLSvk+Czehx95KjRBWmo=;
  b=ek0fS02feCHfNFPm7tqfXC3m1zMmtupc4fFR8PIM8dH/2fILu+O1u5/b
   Ks14C/T+xdRGMuA1QQeCSGWzbg+mele//U0jFR2PiyOBhRZ6UUxtNZBRD
   OIorfZHsgC7oFmTcEaZxvc0IzcXBiS34bo5cRhqIDOrH0f8+cCC0B6Gb4
   YgtJuwOQCnyzRw6bkatR6KVtDH0I9FnqKNPBjdqeawCypft47tLEBh8lA
   wNaoiSvj+mXvvjKsJbKXzwUrF7Y1hbQGIZT9X3D7g1PvdQfhnpQEQUHcd
   /K8+AgX1gnASqG5HnozylX4mexvVyycVbBt7RopWaOYm1TMXRD0XiOTUD
   g==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650902400"; 
   d="scan'208";a="206283147"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2022 18:41:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBkRnTKeO86p9ezqp5zPHTF1f9dX5HJeivTj2wc1lYF5g1DlxoXRhAOmTKBqyebUSfiRbqKnT+irW8iICvMTn8J/ErO0QCDDmMXamm9vFKb2JCohdyrl3RwzhPNby9+2dO260RK96IvItK+XIbF/Qzk7fiHteBlopQ3Npb0JfuGRZGrZVxv42ciO2OKio4e61YTZywOQAEH36BzPC8wlu/AU9Qq1U4FioqFVcu4j9dgEseY67Skfr/KVSyTcBioY8NDng7qlu0sLpQ+owqyyfmZmc+Hc/4+L10pCTqn5YJjE621UoNWmbSgyd1trtR6aTRUEnakmDoJUdvRPqcpv+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sr3Im9FbMq3rMgSrqXSJ0qpUmoeVW68AwACcMFDmiAs=;
 b=WNEcGjB+fI6mmmL2A6ltmjyM3v+m9BOEXeil5aoAGy4pKJC8Fn5heW2icz9KwLbX7ZjF8J4U1cRgbrel3vsbfAINUmGy06vH8mC8ou1GZzvEK7X72ffDW0gFS/MfWTx4MASrKs6ZQPSHD395K+3Gd73VMrN7EVcDbCjzXNfLCtWOFoc6nTONNalWLFPdnGCBsJaSHlBAJmQt7MYqH8r9O0vAAve+Ad2n+Ufnh2k/CRmNMOGV3mnMYf3ETe7/N0RWzDMfHD/M7yxreg5iBVInjM5N559ZeL3gDLWzGA5nNRytbEfp5VqPNxoL63AQ2+DKhgq1lBa6T8yzL9iJunqmRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sr3Im9FbMq3rMgSrqXSJ0qpUmoeVW68AwACcMFDmiAs=;
 b=VGHZgxVHWdTe1oej86UJfvn2/QMMGUYbvZDE8PQHdIlTlz4bBoW8iORAQ2fJPRCD+QINk0UGnQhoPNZCU5wmfjJsD2N2zGgm4knI9oqpal5EVEgScp7U/fcCA254QlABkQ69lMwRgoFI9nNvFC8BFqcJgfzidZY5OnBrcKuzLH8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB5372.namprd04.prod.outlook.com (2603:10b6:5:10f::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.26; Wed, 13 Jul 2022 10:41:56 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833%8]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 10:41:56 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: [PATCH blktests v2] common, tests: Support printing multiple skip
 reasons
Thread-Topic: [PATCH blktests v2] common, tests: Support printing multiple
 skip reasons
Thread-Index: AQHYlchYp+hJb/1IDEaA2XEJcTS1ha18HsaA
Date:   Wed, 13 Jul 2022 10:41:56 +0000
Message-ID: <20220713104155.m57oodbmwhemjre6@shindev>
References: <20220712082810.1868224-1-lizhijian@fujitsu.com>
In-Reply-To: <20220712082810.1868224-1-lizhijian@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52e138c4-4951-498e-dbe1-08da64bc4e8f
x-ms-traffictypediagnostic: DM6PR04MB5372:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xalqC53s3telcCuPGclwxfO6Odm/K41pR7PeIdnOp9eP0dNHV/PXiyfPt6TLfsAeeht1GLQcLgZ88RtbDU3HrU+N1v5QFKpkE106iSwQ5qwh6aofaf/igQXeIFFKSCDcq2UB8YO5dMW2d0iKqtwgSWIuXnd9/fj/bA5NS5gK0dFhcB/ykNHqH0qIdG0IBbKVHP9Mr8Eorxs2HabH3nH5s+tkmeTbrILSaIsNuhl8mme5u8y8vyFljhp8MMHR06wl2SyBIRSRlpHyJO2X5eEzg1okO3zHv8rNhmlky61uPYai7dut5k0QbcCqBLfhDFgyPbWsyAkvtW4vNoxbb8Vr0PpBQN9S8H1aV00+JBlLq84ArfhOZABWx+DrVfo3VPUaUSBy1zn/w4WnaJeFRIXogkCbmBOxdmsQ9AhbI7V+CnESveNXxBfcNteOyNVL07JpoFdn/HcR4Z90P7g8XkG7JutGJPhwPtCWhq6/nIowE2PGGzWIbYkoBwj90wa+ElHQuOWHmKPJC8t1XLx/EhFyaun5euRc7geWMKB9IMmsSp4Pr708/yvMy8d3BWEMbdgNtaqia9mRHZK7V7LPVWUTtAefOGJ5vUtGeGDq3nDqgjuGEA0TiRl33VqiSJOhqJ6TU9Sggd9abN1ww1py0y+iE3JQvB+lTCAlKWOpDHv+/mbN2xPs0JlqUORDXucNE4f4um6V+GLiWhZ7Cs5CmByjd+Ol5JGxNlrHKCn93U2n2znyYd46zCjUBaN57EjEMJr2/2UtlLwJZfzaLdqIIQ/0LLTQtsW45sM+5ZWubub+vt5Ga3LH2U6m8dFe7hCL+FLr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(136003)(346002)(39860400002)(366004)(376002)(396003)(2906002)(71200400001)(6486002)(8936002)(86362001)(83380400001)(38100700002)(5660300002)(9686003)(6512007)(26005)(122000001)(478600001)(4326008)(66446008)(44832011)(1076003)(316002)(186003)(82960400001)(66946007)(76116006)(33716001)(66556008)(41300700001)(64756008)(8676002)(66476007)(91956017)(54906003)(6506007)(6916009)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9Uv2agWeUb/xwmn+riswHKKXm9CfpNoF4U/2GcHCLlZ62abKfo3huyMN8eg0?=
 =?us-ascii?Q?zLskJ+a7h4socV7WYUJu/lrmeNHuKFEtzKMjsZhsaUxWrxxgso2cPjS/aBTz?=
 =?us-ascii?Q?3UmtLtV1S62vArelmGdjKSTvvdrvxNlqSbkPTGQIQftwzayfS854nlh/DZQW?=
 =?us-ascii?Q?XZxdQt2i4PKVbbw3nC0+wgR1fiAb5KG1MAOaZCkVipAr502J0zyhVSQ6unW9?=
 =?us-ascii?Q?Nj2Y0mHI/Wsgism7eLi3qk+1IUBgnm4nsAJDQqPV8AdyI+EtQvamjCHXcKlo?=
 =?us-ascii?Q?eOij2cmbUlACFeQvy0xgTXycoxyiBVjIguHKPaUG8JK/NIxf379tKh9glJgQ?=
 =?us-ascii?Q?zN7TlZaWlRNUSMWZAZp0DsebIjfMOcJwLDy407n8dgxcaPB5xRn0vZqBJsxp?=
 =?us-ascii?Q?gwBqbRnSKog3daa06L6cyMHBjVsi3aI0J4ttgpVi4xg7NTCoUFIVAAYSQIen?=
 =?us-ascii?Q?PjJ58/SjHxufU3uj2Fy1F8+UjekkczcKW0My3QoFVQtnMcOqYRus+T+7l1Se?=
 =?us-ascii?Q?NEX8r8v34BrVgmZhkodwOBwjfZR7FJC5XKQcxmFazGB5zCs2TPO/aIC71t1Y?=
 =?us-ascii?Q?BajJqhGaTB85p0kfOHzHBBxVt8HelAbpWQ+mu5Mq9BUI6OC2Zj8i7LG5Fq0l?=
 =?us-ascii?Q?bFZoHXLHmH5IxpTp1tCnQRXjbdlQKW3CtJBObN6Y5KEiyn5/DUWfr8Cvt6V5?=
 =?us-ascii?Q?H/xAAnWmUIG+Uv3oAR5U1KJe/bLqaf1uday7hUGsDt1cFPSkR7cy9UV9e4sX?=
 =?us-ascii?Q?5BwH/hI5NXCGzzsD7bZBJRERtUhEXNiSwTIsQCf7XOunUZvkQMl/oB4lqTJW?=
 =?us-ascii?Q?a1+F6rhU2tRxiZrBr6gV0PuhXiC51ft8CspEZL4Y1P6YcqD+bZfvFypc75tl?=
 =?us-ascii?Q?fmswWDTOQVbKIVWWZM1Rb8x6nXaxg73G/xWlKxuWgQBbDrAcGhmEwv+/3g/g?=
 =?us-ascii?Q?D5Ifh3Phr0VoQAsszEXdQV132bp7H5Ul3vcEreVERIrovTTybMYN7LtwlPRE?=
 =?us-ascii?Q?ys7RXwaKCyDZWHHu70wNVOAcGSYYhU1MyD7Q1IWi06Lo2Y2cwmtBoGcbr4qz?=
 =?us-ascii?Q?FgHjM9rbOxcw5rNVaOjq29mp1JaMXqXOiNWS/lwwlhYhKMpJ9vJmGREH70IP?=
 =?us-ascii?Q?xJAQ56TzZjJs01V/U4xm08ngo7NfCeW3/D2yeTkj1S6zkXjduOu9cZkuZk2l?=
 =?us-ascii?Q?5d7G8hphw6ApZpSzK+2S3nP09V95ZDayXgorQ29UPFYewi61CJXAvD01CvYv?=
 =?us-ascii?Q?mHyWUpVGWAotsTi6xi4b+do5TQdh57/rzbdI9ATlSsp97fA8AIfj3z7ZlpK1?=
 =?us-ascii?Q?AiMGF/cOHvOS74o4Q32xPZDE2vfLcRS8+52H16iDAhKzRS3wqlLgmTsqlZ9e?=
 =?us-ascii?Q?ccX1asYSJZ4gBkLFWOMBg0S9gGIpcd2ghH76LFT4slOCCd5bxCS1flEYjfjH?=
 =?us-ascii?Q?hKJxp4HhEYO5f3NNflJd2hBXZanOpp7IeU+ii7C73z8TGvXISDRqy6YL50ey?=
 =?us-ascii?Q?j1IGrMYJ025kuPu1K1plr7IkUcI/Dy7zaIllkf/jdIOtMz7Q5o/apjRNqDkI?=
 =?us-ascii?Q?tl83nFLR7P9Zo2HvfTtfvAFBCXvb8WTG0DYe8VaAK3plU8g4jX3+aa+hLwxb?=
 =?us-ascii?Q?fFVr1QYBpMAxt0bwqAyWMQQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6772B97434388D44A813F395BF4BDC7F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e138c4-4951-498e-dbe1-08da64bc4e8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 10:41:56.0557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ug8zZ/RTI13hjyybieJFyTfTEFP0IGumlVt3eTt9PcWBM+2tTeCM4AxLvFY/aUoXHNNtYOVLO+kzT8Z0eylvKqZpiwAyEUyRtLFzLCaXN04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5372
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Zhijian, thanks for this v2 patch. I found a few minor nits in the chang=
es
in the "new" script. Please find my comments in line. Also, the word
"Supporting" in the commit title is not so meaningful. It could be
"common, tests: Print multiple skip reasons".

Could you respin the patch one more time?

On Jul 12, 2022 / 08:21, lizhijian@fujitsu.com wrote:
> Some test cases or test groups have rather large number of test
> run requirements and then they may have multiple skip reasons. However,
> blktests can report only single skip reason. To know all of the skip
> reasons, we need to repeat skip reason resolution and blktests run.
> This is a troublesome work.
>=20
> In this patch, we add skip reasons to SKIP_REASONS array, then all of
> the skip reasons will be printed by iterating SKIP_REASONS at one shot
> run.
>=20
> Most of the works are done by following script:
>=20
> sed -i 's/SKIP_REASON/SKIP_REASONS/' $(git ls-files)
> git grep -h 'SKIP_REASONS=3D' | awk -F'SKIP_REASONS=3D' '{print $2}' | so=
rt | uniq |
> while read -r r
> do
> 	s=3D"SKIP_REASONS=3D$r"
> 	f=3D$(git grep -l "$s")
> 	sed -i "s@$s@SKIP_REASONS+=3D($r)@" $f
> done
>=20
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

[...]

> diff --git a/new b/new
> index 41f8b8d5468b..817656fac97b 100755
> --- a/new
> +++ b/new
> @@ -64,29 +64,31 @@ if [[ ! -e tests/${group} ]]; then
> =20
>  # TODO: if this test group has any extra requirements, it should define =
a
>  # group_requires() function. If tests in this group cannot be run,
> -# group_requires() should set the \$SKIP_REASON variable.
> +# group_requires() should add strings to the \$SKIP_REASONS array which
> +# describe why the group cannot be run.
>  #
>  # Usually, group_requires() just needs to check that any necessary progr=
ams and
>  # kernel features are available using the _have_foo helpers. If
> -# group_requires() sets \$SKIP_REASON, all tests in this group will be s=
kipped.
> +# group_requires() adds strings to \$SKIP_REASONS, all tests in this gro=
up will
> +# be skipped.
>  group_requires() {
>  	_have_root
>  }
> =20
>  # TODO: if this test group has extra requirements for what devices it ca=
n be
>  # run on, it should define a group_device_requires() function. If tests =
in this
> -# group cannot be run on the test device, it should set the \$SKIP_REASO=
N
> -# variable. \$TEST_DEV is the full path of the block device (e.g., /dev/=
nvme0n1
> -# or /dev/sda1), and \$TEST_DEV_SYSFS is the sysfs path of the disk (not=
 the
> -# partition, e.g., /sys/block/nvme0n1 or /sys/block/sda). If the target =
device
> -# is a partition device, \$TEST_DEV_PART_SYSFS is the sysfs path of the
> -# partition device (e.g., /sys/block/nvme0n1/nvme0n1p1 or /sys/block/sda=
/sda1).
> -# Otherwise, \$TEST_DEV_PART_SYSFS is an empty string.
> +# group cannot be run on the test device, it should adds strings to

s/adds/add/

> +# \$SKIP_REASONS. \$TEST_DEV is the full path of the block device (e.g.,
> +# /dev/nvme0n1 # or /dev/sda1), and \$TEST_DEV_SYSFS is the sysfs path o=
f the
> +# disk (not the # partition, e.g., /sys/block/nvme0n1 or /sys/block/sda)=
. If

Two #s are left in the two lines above.

> +# the target device is a partition device, \$TEST_DEV_PART_SYSFS is the =
sysfs
> +# path of the partition device (e.g., /sys/block/nvme0n1/nvme0n1p1 or
> +# /sys/block/sda/sda1). Otherwise, \$TEST_DEV_PART_SYSFS is an empty str=
ing.
>  #
>  # Usually, group_device_requires() just needs to check that the test dev=
ice is
>  # the right type of hardware or supports any necessary features using th=
e
> -# _require_test_dev_foo helpers. If group_device_requires() sets \$SKIP_=
REASON,
> -# all tests in this group will be skipped on that device.
> +# _require_test_dev_foo helpers. If group_device_requires() adds strings=
 to
> +# \$SKIP_REASONS, all tests in this group will be skipped on that device=
.
>  # group_device_requires() {
>  # 	_require_test_dev_is_foo && _require_test_dev_supports_bar
>  # }
> @@ -149,28 +151,28 @@ DESCRIPTION=3D""
>  # CAN_BE_ZONED=3D1
> =20
>  # TODO: if this test has any extra requirements, it should define a requ=
ires()
> -# function. If the test cannot be run, requires() should set the \$SKIP_=
REASON
> -# variable. Usually, requires() just needs to check that any necessary p=
rograms
> -# and kernel features are available using the _have_foo helpers. If requ=
ires()
> -# sets \$SKIP_REASON, the test is skipped.
> +# function. If the test cannot be run, requires() should add strings to
> +# \$SKIP_REASONS. Usually, requires() just needs to check that any neces=
sary
> +# programs and kernel features are available using the  _have_foo helper=
s.

Double spaces in the live above.

> +# If requires() adds strings to \$SKIP_REASONS, the test is skipped.
>  # requires() {
>  # 	_have_foo
>  # }

[...]

--=20
Shin'ichiro Kawasaki=
