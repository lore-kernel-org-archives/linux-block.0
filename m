Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74518C43334
	for <linux-block@archiver.kernel.org>; Thu,  7 Jul 2022 10:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiGGK6M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Jul 2022 06:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbiGGK6K (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Jul 2022 06:58:10 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0CB57233
        for <linux-block@vger.kernel.org>; Thu,  7 Jul 2022 03:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657191488; x=1688727488;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EnxzCyHz7xvq5N6ib30HqgcYfaJLZPtLb3Du3wxA4HE=;
  b=GXtrWwAEK3e/J7CT7e+HK63TE8IPQSIcYeUTNSHTM3ReC2LQwZbLV+37
   FvdAekFgiU4lQqeAT6+2YMb/yibfzr+1FTEDyUunoqxCjtv1cvYIts4ZD
   FrHlXPMH4uuA1qE9hdXZlbsys5NKGAgFdRqoCP9D67/+RxBAeydEp5e60
   TxnaRLkDj+1dws+yKScooLuTdXJRoOeDsygomMf6z/vt1if7/xMqIH3/P
   0UwJ8NEFzoZv6vOx0Ww/0amvApC07Qoz1Gghw9YgtOseHkQ3yGnRLG3Ye
   lOUcUY7/dKiDdhFlcHbazCT8pX85dFfKczloivUYMlIAzH1co0i2QpgC5
   A==;
X-IronPort-AV: E=Sophos;i="5.92,252,1650902400"; 
   d="scan'208";a="203727005"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2022 18:58:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgZuybeolmq9xdr1MtPbMueBMp8zwb5y+clFYHL+FrruNvgpUr3mfW/wJKVO/o7cNrWrGAgLdJ3EgQF8IMkxT/brt5u/mLsii45OTUNh3GNueyVZ908VMnrFAEF3JlFmuzahbS23XF5HtbUezxOwFr5y5AwQXlCMTVh3o/OfDCFOQtOomipDsXVMA0YHS+p4LEhmKcRPOvKfdaqFkHFMDSna8LOuMWxp9hsozzGErfFZzBrLLoEChWP+TltN3BU9zaVY+qMXQSMPGBgAuQpNHKWvQSvxztpUb23PMxURO/wQsiKWEXrNE1wKIfvDobhYnxfbiZPpHG5NCniN02Ta6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pI6JxVNG3TjSANuo9fhlszICPdKv81ETb+7O5nBMaAA=;
 b=Pej9Ue1zYQmjoFsqlvUspObK866ujBcZ0OwGzBABfRda5hm/kypM6rf8d4sX3p8IO2ZdctFQqeK1T8btPaFgsyFQ/FLvaehLDsZRDgxckHB9RJgD3O9qeYXH1neyKZrww1mOt4AbOw18hrRkv43CbgmrmNyoGLJ0xoESt5F4RBoInrnm0Asm5fZKUs+g801C93/yKi1GGyL6tiiZQ6F306o5be1v+qR+z3u16BNT6pbUvLRdqvp1KzH+SD1eGi5mmaG64mGIeWPPV81eahof5tIEmJNHZssRfNFVASXfUfpzMS9bfRpHYn4/1SINg617pbrRIxeYENF5MJ/Ea7mhSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pI6JxVNG3TjSANuo9fhlszICPdKv81ETb+7O5nBMaAA=;
 b=Vedve648KU4K6VjZzc3ve/K+RKSO4tUlktSbPtYJDf75/rmzuah897T1lRfwMOH6YaAkVlVGZRyriWnyJS6EM+9+RHfpHKx+RFfkPmyqp8KhZ5Q4aXyL6ZYSpRCknoWuVljZqy0Akk2z3/AtSrx926Ad2V30yLICv+Y/9USNvZs=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MWHPR04MB1007.namprd04.prod.outlook.com (2603:10b6:301:3c::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.18; Thu, 7 Jul 2022 10:58:05 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833%7]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 10:58:05 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: [PATCH blktests] common, tests: Support printing multiple skip
 reasons
Thread-Topic: [PATCH blktests] common, tests: Support printing multiple skip
 reasons
Thread-Index: AQHYkbRJkUvbHQedkkOfHUgIgL5Mh61yvXQA
Date:   Thu, 7 Jul 2022 10:58:05 +0000
Message-ID: <20220707105804.dzxchu7tgeynsttb@shindev>
References: <20220707035435.1794716-1-lizhijian@fujitsu.com>
In-Reply-To: <20220707035435.1794716-1-lizhijian@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3691e089-af9a-419b-92a1-08da6007921e
x-ms-traffictypediagnostic: MWHPR04MB1007:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CA8yF+pIueZdO/yyQcCYKqtplMk6unamhB1GPnIjtPK046uZV1lURtmJuKOKIuOLOXwYhmDFBVaDAqjJkAqTinc0Zz8diuCcGyeDUi8Wv+yEelnwGQw3KyWbYZChR9ZWsd3ZEo8epkIFBHI0LgPfOCVBarFrTlTkB8Zug1OLb8iVUayF6u214WZd9grNVdznT1xeh0UAfhqIuLBqkpinp77q5Jq+AjM4KGnR0Z+uhMLVHb73vFDIU7GEPufieafREiOmX1QmG+3BJsqvdQz7wbnW1ecc5ib6dFRcIDYWSSjlZgHwFsEGEap2PLZph6775XABEtOpR5GhatVOm0ZIeswKESswkj/r2psNwO3hkF2a4W5bqnhQwvDDYyDvQ22JX7ypP8W+JBNt9IGFx4ekJoFDEv/jqJBmZC6N7bqeTHtB7DIdQNEIxDsapdgnG2U8OuCh4gTdIO49tRdyC4L34k44SmKvMHh+6P/hrnT/k1z0k/XeUVWHt20ADP/4WWYgFdn+hy5IeGKYO2PNjN4E4gJNMKJt6/bYoMZeEhCXhg2XWKTl0ljno+65HfVJtjSJIbnfBbKAojzgAb16ElxVIzTkfNve04R5xhcFJwnSE3vzKb8uMuNH/jlQWCeUT8awuKcH/V6qEBfP+jXtZcbF/G7Kef3pb5WjuXdTXdWVsLac3tXFFkBpDECCoo/TNYnrXaS/uNwkEY1p2SHoZNs807R23gjMmNkStGKa3gMlTVIp5mXiLxV8oFEi38LAwXA3y0b/+zlFyBAlyNGUhB+cIt2q+h0bOLxuWGLE2OfGnNdKJm0oA0SNJi71qwalzz1O
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(5660300002)(8936002)(38070700005)(44832011)(33716001)(54906003)(122000001)(6916009)(1076003)(6512007)(4326008)(478600001)(6486002)(82960400001)(9686003)(186003)(26005)(71200400001)(316002)(86362001)(66446008)(66946007)(91956017)(38100700002)(2906002)(83380400001)(64756008)(76116006)(6506007)(8676002)(66556008)(41300700001)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CS9WD0AT1iXIDG9WZJBz2Ae555/hVfwVYwFq8AIXmsbkfdYP5BwxKUWmiHEd?=
 =?us-ascii?Q?NQEkZD4KCAVBHrAbstdDyDEFnsGyxCZyQUKoE8+LqfTg7MaZVNau46pvNuSy?=
 =?us-ascii?Q?tnuGhjWk/JouV0Pda4MI6ezdYkfYfqaVjJdnAB8yRNI5QOTNl1bMXyvyEmi9?=
 =?us-ascii?Q?vz/A0dfcT3oX/cKMCfj33y+U+aEi427+Xxci+z010InUEirImIPwvyvM/mDx?=
 =?us-ascii?Q?oNWGR0AF+PmIesXhm6vt7DI2DoK/YkM7cCIJfEL43vKplgn342AsaObch/40?=
 =?us-ascii?Q?yxrBhmpvIq4J1aP4WGHPdEPRW/118/8qrPXsCPVpED2bl+Z2EL4bnwZwcPmc?=
 =?us-ascii?Q?C551+S7jx84hZ6C9JxXIWrbv4JuwkLKWEZ+0mzMx0Y/GhvZkumLNOAjOhwoY?=
 =?us-ascii?Q?yTMkJMadmjwEvYMDb5lhNKuAWWx83D+ZN7dRmgJDX2gR1xzQ+tAQ7xvm9kNr?=
 =?us-ascii?Q?8FNSpzI4EcZVem/pdDQ3B3xHxWk0i9B9SWJ0Bm1Oe7CM2RoXyupY4/q/Tw5g?=
 =?us-ascii?Q?0vZI/65qxO1JmkpOQ/R/6EogmOJ7cqZxdxz5buaYXMpvREed6mMooxDo0U9w?=
 =?us-ascii?Q?ar16gZFImXKMbvbXuuLyKIPc9789Vm+HM4us37qC9OxSBLKSHw/oMdetCug8?=
 =?us-ascii?Q?DYiGKz/A42gl3Al0xsfacM5UNDmjlX94irTSXcK4XBwkitxSA875BSJGZHSz?=
 =?us-ascii?Q?W8nSAqexw++r1reQVty7s1lKneBu2ABtsElohwnPTWvs0orivKOoFAz1Dtnw?=
 =?us-ascii?Q?DBHBDV3STWPyr827KoBbjaObbJ0ZxNrt9l5p7OlDbEhY8whKIqjkiNE+NX/0?=
 =?us-ascii?Q?ynuWK2tckjEFNoze5jhKdTKjXFpBaVZdIWukvLrKUqgpae30dWYtuz8DJoK7?=
 =?us-ascii?Q?O16WHo7QbPBftyUyzI7VHnMlMHuNrgLMPyepbIXO2vGiigRt4YhXR8AyrnD6?=
 =?us-ascii?Q?dRA5SyAsh+N+2EGKwXhOFCWYML3hCgnG54naEFkFapJ5WcctuPbrlbVXEGn2?=
 =?us-ascii?Q?tycnlV+orq7oJIA1wq0p8TSVVPPHxrlOVrR8zKeffxfra4ockXF19bbrfBUk?=
 =?us-ascii?Q?y/1CGSvQwWBMkdIbl7YYZ+wtAihn08x8uMROXgYJRdp77UwWUybenILEF7Nl?=
 =?us-ascii?Q?rDaWp7TlpLZMkkX6d7ddt3W7wE6zQ+QDCljXU1sccWQC+3eF5wHSfsjK3lVd?=
 =?us-ascii?Q?hTo4KNDw78DNulVH83DkqbMaQjaP12ik+I6qWzrndGZHRG3t40OTh6bBvR4i?=
 =?us-ascii?Q?ehGHp/4Glq/lGwb+VFi9rhNySgaEDk9PiFvJmNN7LSYu853feyN4df37q6Du?=
 =?us-ascii?Q?2U+T7Q0/hVGKlem6dRJx/8IPc26EKRnqs5R6vffQwMqIcTUwd3TjX3ms18Yh?=
 =?us-ascii?Q?Pc7ZjkKHXulfwVFqDSFcPhNK2XxUFaU62yHf5VTwV6npYwaghFCKq73TsdZV?=
 =?us-ascii?Q?Ei+q62Ek6JljiRF05MEawRkLCdefgCyFF59erF/hi9GVacoDlQZmBTME5ayg?=
 =?us-ascii?Q?+lfbTqkzpUkE+QETB6LheUMQiFiHOB6VtabLYOwKhRriZQ5ueDHEMEyWaH6Y?=
 =?us-ascii?Q?Kx7A214LVbW5WrWOxbY6/nQGB1vakyVv8BxLfZ45tnquVZXbb937WJaVQO+u?=
 =?us-ascii?Q?wSQXMW40Jk8pj4bWtFD2GiA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0372412EC884B14285214C38BBE5064E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3691e089-af9a-419b-92a1-08da6007921e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 10:58:05.8705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tYIhH840mvw47BTKWP7vyKaGjI+cAzCyX8sAHOWBS7srIlHLl/l20SYhUcGFdjXR3TlYLuZPAro+qWR2I1Rm19j5HL3E6lWQ4dy3W1EHBuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1007
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Li, thank you for posting this from your github pull request. Please fin=
d
my comments in line. Other than those comments, this change looks good to m=
e.
I ran blktests with this change and observed same result.

On Jul 07, 2022 / 03:47, lizhijian@fujitsu.com wrote:
> Some test cases or test groups have rather large number of test
> run requirements and then they may have multiple skip reasons. However,
> blktests can report only single skip reason. To know all of the skip
> reasons, we need to repeat skip reason resolution and blktests run.
> This is a troublesome work.
>=20
> In this patch, we add skip reasons to SKIP_REASONS array, then all of
> the skip reasons will be printed by iterating SKIP_REASONS at one shot
> run.

As I commented on the github pull request, Bart's idea to use array for
SKIP_REASONS looks good to me, since new helper function is not required.

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
> ---

[...]

> diff --git a/new b/new
> index 41f8b8d5468b..9f83d303830d 100755
> --- a/new
> +++ b/new
> @@ -64,18 +64,18 @@ if [[ ! -e tests/${group} ]]; then
> =20
>  # TODO: if this test group has any extra requirements, it should define =
a
>  # group_requires() function. If tests in this group cannot be run,
> -# group_requires() should set the \$SKIP_REASON variable.
> +# group_requires() should set the \$SKIP_REASONS variable.

To be precise, SKIP_REASONS is not to set, but to add description. I sugges=
t to
change the text as follows:

... group_requires() should add strings to the \$SKIP_REASONS array which
describe why the group cannot be run.

>  #
>  # Usually, group_requires() just needs to check that any necessary progr=
ams and
>  # kernel features are available using the _have_foo helpers. If
> -# group_requires() sets \$SKIP_REASON, all tests in this group will be s=
kipped.
> +# group_requires() sets \$SKIP_REASONS, all tests in this group will be =
skipped.

... group_requires() adds strings to \$SKIP_REASONS, all tests in this ...

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
> +# group cannot be run on the test device, it should set the \$SKIP_REASO=
NS

Same here, and same for following changes in this "new" file.

>  # variable. \$TEST_DEV is the full path of the block device (e.g., /dev/=
nvme0n1
>  # or /dev/sda1), and \$TEST_DEV_SYSFS is the sysfs path of the disk (not=
 the
>  # partition, e.g., /sys/block/nvme0n1 or /sys/block/sda). If the target =
device
> @@ -85,7 +85,7 @@ group_requires() {
>  #
>  # Usually, group_device_requires() just needs to check that the test dev=
ice is
>  # the right type of hardware or supports any necessary features using th=
e
> -# _require_test_dev_foo helpers. If group_device_requires() sets \$SKIP_=
REASON,
> +# _require_test_dev_foo helpers. If group_device_requires() sets \$SKIP_=
REASONS,
>  # all tests in this group will be skipped on that device.
>  # group_device_requires() {
>  # 	_require_test_dev_is_foo && _require_test_dev_supports_bar
> @@ -149,17 +149,17 @@ DESCRIPTION=3D""
>  # CAN_BE_ZONED=3D1
> =20
>  # TODO: if this test has any extra requirements, it should define a requ=
ires()
> -# function. If the test cannot be run, requires() should set the \$SKIP_=
REASON
> +# function. If the test cannot be run, requires() should set the \$SKIP_=
REASONS
>  # variable. Usually, requires() just needs to check that any necessary p=
rograms
>  # and kernel features are available using the _have_foo helpers. If requ=
ires()
> -# sets \$SKIP_REASON, the test is skipped.
> +# sets \$SKIP_REASONS, the test is skipped.
>  # requires() {
>  # 	_have_foo
>  # }
> =20
>  # TODO: if this test has extra requirements for what devices it can be r=
un on,
>  # it should define a device_requires() function. If this test cannot be =
run on
> -# the test device, it should set \$SKIP_REASON. \$TEST_DEV is the full p=
ath of
> +# the test device, it should set \$SKIP_REASONS. \$TEST_DEV is the full =
path of
>  # the block device (e.g., /dev/nvme0n1 or /dev/sda1), and \$TEST_DEV_SYS=
FS is
>  # the sysfs path of the disk (not the partition, e.g., /sys/block/nvme0n=
1 or
>  # /sys/block/sda). If the target device is a partition device,
> @@ -169,7 +169,7 @@ DESCRIPTION=3D""
>  #
>  # Usually, device_requires() just needs to check that the test device is=
 the
>  # right type of hardware or supports any necessary features using the
> -# _require_test_dev_foo helpers. If device_requires() sets \$SKIP_REASON=
, the
> +# _require_test_dev_foo helpers. If device_requires() sets \$SKIP_REASON=
S, the
>  # test will be skipped on that device.
>  # device_requires() {
>  # 	_require_test_dev_is_foo && _require_test_dev_supports_bar
> @@ -185,7 +185,7 @@ DESCRIPTION=3D""
>  # failure. You should prefer letting the test fail because of broken out=
put
>  # over, say, checking the exit status of every command you run.
>  #
> -# If the test cannot be run, this function may set the \$SKIP_REASON var=
iable
> +# If the test cannot be run, this function may set the \$SKIP_REASONS va=
riable
>  # and return. In that case, the return value and output are ignored, and=
 the
>  # test is considered skipped. This should only be done when the requirem=
ents
>  # can only be detected with a non-trivial amount of setup; use

[...]

--=20
Shin'ichiro Kawasaki=
