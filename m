Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5467C433F5
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 08:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A80FE60F70
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 08:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhKBIWT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 04:22:19 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:4227 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhKBIWM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Nov 2021 04:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635841177; x=1667377177;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FZ2lYTUm2UWqxmLyQGNS7wADnVfRizmFqHZB7kQEDHo=;
  b=kH4XsGYkaquSn2ZVogj/xDl9XhjAQABZ6GOBtcTOkU9r47ZKmUT8tGGc
   v4DBmdj/721/Rv1u7zpvaJEcgpVRUURs/WfqLg4e7C15Egl1eNhsLVf/a
   jdgCMUPgHmu/wpv9QC0Nch8Bt8ocWcHUDL0UXexHcQ3pCrQ6V3gfw3o7T
   qOdYZ+jAbwVVALgmTxK35/XQdajlHyfVFLl0W+6mRYALC+wCg3VrwlaXf
   Z3M1Q8UZiTtFdsi1Jev9XaU57NJgx9ouhGAgBUnSNSGqbwh9m85f1VkCu
   RYGeT5JswsjY6mV1m87OL/0e9EQKDrxQr+rqmuqswi3KKrBLkD6wnRqGC
   A==;
X-IronPort-AV: E=Sophos;i="5.87,202,1631548800"; 
   d="scan'208";a="184462977"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2021 16:19:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THN/aOhuMPAh+xcIs++YEOFhF1Kd0dfZJp17BR6pThvM/lO0ZEDZuwUfGmGfDKLDQIodXLjeGynSCgg20Dddx59hfGJL7LDzxIhr22qGiY04qjX4Rzond8KXjDRtMOd7KO8k+M7xRh0vljzkF2Xp/H7TmBI6p2wS71OV7635VVFcYDRaCb0Ug8yJM4uYHOSEB8YcS2vOmFiXgQrNVhHiOO9h4LsQOHpq/lA+JrPMJ/z8tSWgIzO0Zkqpk2hYl//3gbXt1hMsMPtc7cEsYn8tvLWoVCkPHqRiLyaG6QLSLFQgsYhrdqZoNtImOztjXLxoZOSOU6doswJeynlTVgrrgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZ2lYTUm2UWqxmLyQGNS7wADnVfRizmFqHZB7kQEDHo=;
 b=OBenuwaIHi6bhTT4yLZdF46sN3GqKy49WlW7kGEVMUZoYEuBMNl2x0Onff2IAQ0os6owmnKhRImsy8632igcGX5gLB1om79DxX+DeR8X3kuMI90z5IQSxbmzHhq0/zDWPEzec+YtF4SVpYoVRfs+uphpxs5Z0r0gBYgzU5FKRrmL9E2EZI76rwdVhkABSEIFrgKnoWsGNIbETZSfLiNGLc050eobpqYvXdC82l7j2N7BYkBHXM1+y0hRix1P9zFgHUEoEd2nwRCB766g8Gdg6jI6MWdS26Ij6fpeDVWWqLWNKIZUy9a/ZTSkMOVhlMlYYUR7D714itaCNBFgjXsZJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZ2lYTUm2UWqxmLyQGNS7wADnVfRizmFqHZB7kQEDHo=;
 b=J6PtP2E6Ggo9NQi+5Se3a5siFsZoSY7GW1pFinwDaQo0fvF87gAKq9fzYwsmu39TryHwU4IoDkHeICsoc+vdGFubGpWnEFHmBdXWdPRPxnQak6DkmO6+52hr+TfDI4jqDhdQL7EkaHTKsNkZfDl15zdDasP/390w/yQjmNv6X/Q=
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com (2603:10b6:a03:291::7)
 by BYAPR04MB3880.namprd04.prod.outlook.com (2603:10b6:a02:ab::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Tue, 2 Nov
 2021 08:19:30 +0000
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::49e:8e59:823a:fb61]) by SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::49e:8e59:823a:fb61%3]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 08:19:30 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [bug report] block/005 hangs with NVMe device and
 linux-block/for-next
Thread-Topic: [bug report] block/005 hangs with NVMe device and
 linux-block/for-next
Thread-Index: AQHXzvtCAnSg404Q90iJ/hTDak5dVqvunZKAgACtRQCAADgYAIAADJuAgABXNYA=
Date:   Tue, 2 Nov 2021 08:19:30 +0000
Message-ID: <20211102081929.s6eyxawq32phvufr@shindev>
References: <20211101083417.fcttizyxpahrcgov@shindev>
 <30d7ccec-c798-3936-67bd-e66ae59c318b@kernel.dk>
 <f56c7b71-cef4-10be-7804-b171929cfb76@kernel.dk>
 <20211102022214.7hetxsg4z2yqafyd@shindev>
 <9e22ece3-d080-945d-5011-b0009b781798@nvidia.com>
In-Reply-To: <9e22ece3-d080-945d-5011-b0009b781798@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b228adc6-f276-4b49-649c-08d99dd97ea7
x-ms-traffictypediagnostic: BYAPR04MB3880:
x-microsoft-antispam-prvs: <BYAPR04MB38805FA48E9703B2BE965C4BED8B9@BYAPR04MB3880.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3EPRmN6V+E59PtE0bZ3CcumUnRKb84R6zjabPBuAEVbTOK9Ivm1n0pNVsjLVwL/L3EniQ6OJ8KEgOBopvOnTxSmBeh6kVjgYHJoxoxI5WzNbCMOag8+mYJjV+OEmO8Pnlg7r/b4J9EQmaWxddH0cWJ2naTIPSLXcpM8B+74GqlP5EXF9P8mvuWBcBqOgbmz/Zu2OQO3a/AGlSv3G2vIq7qi/BB5nq0racqDcpXbdyIXx8okYLPW77u1n2TgUuCGCsM0szOf1uIFwtsO8WI/YyYiOZraodJ2k4DIsDz9hPGFF594iE+1dOE/0yUUUIPckO2g5JJMGR22ZhRA1qvXXUUA9lh4XAuMYdW+Q3UrAEnzQsUfJMrOcz48jPKQJADcj3jzHaQ4QCWqPGJ5cxRNueYBcB5Z3SnFy1bF5Ynia1C7d9WlXh5K4JrdDqn8JLWxlncqea6HhNWAPHyCaOeb/5lJKGPR2hZqKT5jBKnFzTAzDikBJCEj5koEtXNwG3AyZYpdXZTVaS+19xR8S8RHP3pf9y4v8H0VGOfV4HSQ3Wv1jFx6NDwtG8vSm2ChA55HWF2CE4Esm8CnSvNM4NvS8eqyur6oe92r84kuqMF0xSiazlslLy6Bu0wbjjk0lQh4wrOK4mhwNuu+ziSgPV9laRTDlFuNU9efAiWAd5YnpTpzV0Swx0va2Vo64TuDDJos6F/6Pa7C/JRLkivBeXqHHHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7184.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(6506007)(5660300002)(71200400001)(4326008)(2906002)(26005)(66476007)(66556008)(76116006)(33716001)(66946007)(91956017)(86362001)(82960400001)(64756008)(122000001)(6486002)(38070700005)(38100700002)(44832011)(8936002)(508600001)(1076003)(6916009)(186003)(9686003)(6512007)(54906003)(316002)(8676002)(83380400001)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T2GYLoD3xsRV3G0thxEmSrTM6YNJesYmGleqhjCwASBXQq+Rvbn+/wy7Jf9c?=
 =?us-ascii?Q?zSNVH+OzWXzq3ALI61ru2pobX4xxSwn3f90FITteY1aCKJEimTfN9skY4kwG?=
 =?us-ascii?Q?u/WJN5W+9A8a79tduCKSJCNgqMRCzATVMpUM5C0FlEPr/vVqnDNgvPHDBkLs?=
 =?us-ascii?Q?wyfhBTH0osSG5M5lWn5YkTSRDnb3rO8TGrhxbPelFVOn0UXrokL3vHF8/Tt7?=
 =?us-ascii?Q?VHO9qZXcqq4hE9BOCJjNksL1npm46Y8bD7+SXPC4PkOVVi8+5QfBe/yYeCXE?=
 =?us-ascii?Q?NTbQuaLWGdSKoCDNXf74HLYDfErZmjRieZlZ5Q3Vf533DQAsrxLPKHf6R35f?=
 =?us-ascii?Q?zfayQOSwTUHSMt1zIDujISfIW4ahXy73PPAWd10xodrj4JZDOaf8hcOzlCqt?=
 =?us-ascii?Q?Pvse73p6o9NdgL7oQaLO4sWpEa8vHz5BvGfrG5zcKSMcg8BTsL4gMhWwtM4x?=
 =?us-ascii?Q?NPHkl2QPU4oBwFCuUz5RbEwzygZXDyh6gtlM2ath5PZlH6wlZYfK0kYdnnPB?=
 =?us-ascii?Q?ycsZ+m+AQdxEBeO03Ul6WSqIOp8YM7ARc2Zrpvks3GI4ohlDaKpcwKNs5Xi6?=
 =?us-ascii?Q?+5RJgjLWnYX33MByk4H7ft0t8BYJYzfQ+EgRxxS0wxTWAHpGjfrGmKmBAH4/?=
 =?us-ascii?Q?cOklTdu37iIW0RvPRHGyr3XNBhu9uwnbLJv4MB4g2Y9HTciNGpRptVouzQam?=
 =?us-ascii?Q?MkSwmNfAjVJAl+AfmEJociJc8Uu1NBy0Xk9xQ1bmP+vmeaSWSdf/OA7RXO9Q?=
 =?us-ascii?Q?95i2ZgQ/VYC6AreSzNbvKldXG6V9qp2daK5rvXUgeSh1gZzMFOQjMSBvmraF?=
 =?us-ascii?Q?iIv7faH7Rw1n6nLmzMmYc+LD7FTYJ4VKmzEAiyS2ClYzhH75xQ2moHMPvkrb?=
 =?us-ascii?Q?Qaxr7jB1+9c5tnMvlw6TvQHxAXVTMeXJxnHYRRxhJM5hOvCZsjCemfUT7DkP?=
 =?us-ascii?Q?iZ8fCB37FX1SgnnfMqVA9Esh4eB1NYbl9POlfqfdRHORnmPeQm3yvITILTkM?=
 =?us-ascii?Q?4u6V/9GJEB6kAPaCMI5nS94LVEbm4+ON3khPnAXqtyJUMnEgN5uF1nFlnXaC?=
 =?us-ascii?Q?8PYSYS5sq8lgjW6sOvK3P268KmAam2aePZWJpQhC/qi1YGHVTxCcaotf93XD?=
 =?us-ascii?Q?7rFJUsXXJ7vmnjHH5+jm14cR9stgKjLeTbWdoGMKYmlgZewoDoP42nKPMb9x?=
 =?us-ascii?Q?b+F5u9SM2MZwfAUYJekXWfr8RQXUlU8w3qLaua8rklKWrKP7sy/mcp83E9rH?=
 =?us-ascii?Q?YPWc5WUWZ5+5SAtGtMkAIk5ekkBIlR0zu+aRfFbiHI90o0YdWLjo4s15Jfkl?=
 =?us-ascii?Q?mQ0NCacPRRcsp0918Y45dH7KjSSBk9rZa4TufTCI53037V73mc9pYAWVqTqF?=
 =?us-ascii?Q?89Hwa73Iy1/hhl71M7Uj8LH16ztIaHEKWc3PsE1ewI//21KJOkk1vPWDvzq0?=
 =?us-ascii?Q?zh6e6DFUOXhYeUR7AhjaU/rVZIC1dUfWNcMP8ptqjiVpNL8gih9q27oGWY9G?=
 =?us-ascii?Q?WOMzzF+MxlUyPjLRp3f54Q7Gd4Ssca7WgFpgqLTCXbqoyjP39K+x4Wdlo9zd?=
 =?us-ascii?Q?AJP01LxoCaS3IVYnwjn2/ok066eKqGnJRq2ePPggGxuguyhYKvFi1wWc4/P0?=
 =?us-ascii?Q?sZ50KtOgL5U7ZFKxNW2Z3HskZdabWhXPGXw8L0nkOQyHo3hLLtrHjtaYd6hc?=
 =?us-ascii?Q?QoQTGqLPZdBEKbmgha26o3e7gNY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1D67E92EEA5F4D4FB78E2143F303FB3D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7184.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b228adc6-f276-4b49-649c-08d99dd97ea7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2021 08:19:30.6695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NRxtjlkCLvPntIMje8yjG1d8QxJWmkDg1lSaARoIsNW8gyl96/z5/fAZzhJzrzc9gIsnc6QPGHXlKYp/bwTO668X+TRAiPFFhAJ34hR3hVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3880
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Nov 02, 2021 / 03:07, Chaitanya Kulkarni wrote:
>=20
> > The NVMe device I use is a U.2 NVMe ZNS SSD. It has a zoned name space =
and
> > a regular name space, and the hang is observed with both name spaces. I=
 have
> > not yet tried other NVME devices, so I will try them.

I tried another NVMe device, WD Black SN750, but it did not recreate the ha=
ng.

> >=20
>=20
> See if you can produce this with QEMU NVMe emulation (ZNS and NON-ZNS
> mode), if you can then it will be easier to reproduce for everyone.

Chaitanya, thank you for the advice. I have managed to reproduce the hang w=
ith
QEMU NVMe emulation. Actually, ZNS mode is not required. I tried some devic=
e
set up configuration with QEMU, and the hang was recreated when a single NV=
Me
device has two namespaces. With single namespace in a single NVMe device, t=
he
hang is not observed.

So it looks like that the number of namespaces may be related to the cause.=
 The
WD Black SN750 without hang has single namespace. I reduced the number of
namespaces of the U.2 NVMe ZNS SSD from 2 to 1, then the hang was not obser=
ved.

FYI, the QEMU command line options that I used was as follows. It prepares
/dev/nvme0n1 and /dev/nvme0n2, and the block/005 run on /dev/nvme0n1 recrea=
ted
the hang.

-device nvme,id=3Dnvme0,serial=3Dqemunvme,logical_block_size=3D4096,physica=
l_block_size=3D4096 \
-drive file=3D(path)/nvme0n1.img,id=3Dnvme0n1,format=3Draw,if=3Dnone \
-device nvme-ns,drive=3Dnvme0n1,bus=3Dnvme0,nsid=3D1 \
-drive file=3D(path)/nvme0n2.img,id=3Dnvme0n2,format=3Draw,if=3Dnone \
-device nvme-ns,drive=3Dnvme0n2,bus=3Dnvme0,nsid=3D2

Regarding the two image files, I created them beforehand with the command b=
elow:

$ qemu-img create -f raw "${image_file_path}" 1024M

Hope this helps.

--=20
Best Regards,
Shin'ichiro Kawasaki=
