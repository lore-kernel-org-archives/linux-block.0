Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B702FC636C9
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 05:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9935161003
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 05:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhGUEYQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jul 2021 00:24:16 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:55514 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbhGUEYC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jul 2021 00:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1626843878; x=1658379878;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sKGeNJOcfQdZza9e6Vbp8hFPbBbdp4KyohY5G9iLp1w=;
  b=WLGAXm4fuXMfYQt8KyrQ28k8b867c/0oFlCIz4k93Di7B2hTXPKF6CiY
   jQyjEcTQUpMAABkgBxlxmkfATtH7vHa7/h0Qy1yOMN/UcFGl07KA99iCD
   MRuVYfSng6zTIKXPNBJgrUDJG7dwbYlrMBQC4adIZC4m/Ztky87cuB+Su
   fmgLNwgXa0+rFS53EimpC/QaJ9FFhhaUFFBDwrGzS/MrM/0R7YntUVdLr
   9AaEzx55PxodpnQEvvGfoZSrq0HRmIJnz6vOIjSXL+FaYOD+5tOVmzILH
   J0+8I750urY2DIid/KmfHSs+0cwsf4OrnY4oWwKhABX9T75tF+y7QXAWt
   w==;
X-IronPort-AV: E=Sophos;i="5.84,257,1620662400"; 
   d="scan'208";a="179919260"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jul 2021 13:04:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlRJakT0/7jGdcTYmCXMzRz6gjjx/n+5GY1B4chPBRpjhOMYg1FMDC9n+PaICc1Iv9IVO5u611dob4hnJViRW4JcS8poMnSf6mL81SzwSlmOU5BAr2f8MOz1FW1yYf7znO+59WW4tkJHEw8xz0vTb1S03XqMoh/r0fDAvLAFItEz41f8CnQfDJ/mtNh8+2m1Ng96bYVjTiPOk8UlsoESazIIQyjXKhIjzkGb5eVxIE/OYH8MlLiwpW2AVJB8ZpDLbJtjL42lluWr4kChnhx03htp8lC164Qh/Weu+X/sArnABA9q+FUmJn5Jq1gjnSdlkMw4cMO5CoZurAf1RmZP2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKdmTyjW12BsE+PZGzFxkufGo0G2iPTMI1yMge1ptf0=;
 b=NJKQBROST8BK8ctDcyHVqtLd3cOU6uSzACNYR/zrc1S94WlE1cANibIm+13ptvQoZYG4Z8HBQh47xWdArSuKHx6J768lazkOy0+RxE+ns/i3fw4APSd0AAVc2OYzPeURW2ReSidiWu0yJ2tZtIp9ONhuW7wCOTmbQlsIvffwNJ9dM9p9i49//p8fDaPqmI7fd37HrjumLlVsb4QhSTVIxtpdwGz4Jxme6YzT/EHdH0jxgwNaiVx0AgJeXepo6AtYRcQtc4LfFFf+c7eixyqWh7Xil8P+Rdw+alL/bkinWqvNpNU1kOhQycen6/9Z5pG+PBS0MeUqqf0A9Cn0JGjMxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKdmTyjW12BsE+PZGzFxkufGo0G2iPTMI1yMge1ptf0=;
 b=tqSSvWYTQKUHKqYA6PKBz05MyIxY3wUg/M+515+wzm8iDrAGQbm0MA3HaeqEDF0+YQbruYq2X9uAN4O8qiptj0Qc6x/qshjrJXatoCE/3otz8SnPLPnrkd5VTxdaSi9Cz5YFJ8PeVd/5g15VRR70gz23o7rdgwejyGRfI5pJDjc=
Received: from BYAPR04MB4056.namprd04.prod.outlook.com (2603:10b6:a02:b4::22)
 by BY5PR04MB6963.namprd04.prod.outlook.com (2603:10b6:a03:228::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 21 Jul
 2021 05:04:36 +0000
Received: from BYAPR04MB4056.namprd04.prod.outlook.com
 ([fe80::dd7f:fbd4:321b:870f]) by BYAPR04MB4056.namprd04.prod.outlook.com
 ([fe80::dd7f:fbd4:321b:870f%3]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 05:04:36 +0000
From:   Aravind Ramesh <Aravind.Ramesh@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: RE: [PATCH v3 0/2] allow blk-zoned ioctls without CAP_SYS_ADMIN
Thread-Topic: [PATCH v3 0/2] allow blk-zoned ioctls without CAP_SYS_ADMIN
Thread-Index: AQHXYRgPtP8+uBs1gU68gsGoV+YyFqspGeKAgAtFQACAGAKAgA==
Date:   Wed, 21 Jul 2021 05:04:36 +0000
Message-ID: <BYAPR04MB4056026E85897DA145B45BB08CE39@BYAPR04MB4056.namprd04.prod.outlook.com>
References: <20210614122303.154378-1-Niklas.Cassel@wdc.com>
 <YNl4LXUKOftl15M9@x1-carbon.lan> <YOLsgFzIBlg/H/ba@x1-carbon.lan>
In-Reply-To: <YOLsgFzIBlg/H/ba@x1-carbon.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: acb74c69-de42-4583-2ce3-08d94c05092c
x-ms-traffictypediagnostic: BY5PR04MB6963:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB6963E6B57A87CDFD10A8B4908CE39@BY5PR04MB6963.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qpQ0AQHfBsqD5fGvu7YVUxPPWFfiImJDoHTLDPmwYMM0Y+pFdnYTz9vjHKdL6jJC9Z8If0JDJoD5VegjXkZ2dSk8QdQTW/dynBLFOC9oVTEEKNXhmMwUWaZdB4HFGzO1GnOqVKe8vLrL8aTghY82blvctx7AqS8ejxyb0JUaw2WC84Ye+f+cWGZRPK+HSkN6uUYhULDRajp5q3yACuxYCuCKZ1l5pny8H+Ke5wMzOvaqUG7Y2szobLcOQsCEuheGL3B3ViwdtwXM0Tst6zwWnKLPhYctB13gX6Cd5kI2sRaM8C0NSh+ApOTsNEJX3SjwNy7AGxeh9CoCfbe3KN1BAp7+yxmy8GWAxS6ZtNZ8cJlQ8Jjt4YaeFvZgzIXxi9K+cC3UHviCjdQAPU3ACqYRTh99xh8Oi+onB/K3F2i4+6E6MG5wwhvvS/6o8rxfQxtKrMkXc0miZiHesEDCNqGF1pNnaMoe8RKoMvAjFZo/KvH+Rq6wbOBl5Gjey31wpCkVp0zjCPPy2XD2sTs8PanAI+QnZqzkF38Z38IxrNuAUegr2krVwNxB+WTMnk6dqyGahrLy7GAgsQ+q0n+KrRi4iFTAe7E7fHnbleP1IzPcbcEm92CCEaT6ii6wGb9CEkbQ1nsrgGvDaqPwJf51W/XE9LRos7es+R3wbYW0+oC+DuJEHX0MsaUhxcxbbDw8N+uRkEA6DpQaiyte29+EMGGowQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4056.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(76116006)(5660300002)(6506007)(52536014)(66946007)(66446008)(64756008)(110136005)(54906003)(316002)(53546011)(186003)(55016002)(66556008)(8676002)(4326008)(26005)(7696005)(66476007)(9686003)(8936002)(2906002)(478600001)(38100700002)(71200400001)(86362001)(122000001)(33656002)(83380400001)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vjZikROkv44DHYABtkYHwVugW2VZEkb21PiebylrG5CH3kRPB4yQ6+N9ihDE?=
 =?us-ascii?Q?VILwHjdyAMv3yZKLa/8HZSB1Ht2QRtDk6EFnHTARlA7FFNwRQRcxQgWgScYE?=
 =?us-ascii?Q?YHkelcPcVt0U2lEh8upXKLmJpEsbdBIP8XdAsmxYqTA6VAi5S/kegg3ipk6z?=
 =?us-ascii?Q?sYC0MngnPvTcRvBSPMpytQoIhsINIRgQyuT6eeZcCB82BBI0/LpwRCpHjJBQ?=
 =?us-ascii?Q?z6trGCTiRiFeZQDybOL25tWPgwSMfJJQ8Z/06YLosPgtawwaV2WuikDuWOpI?=
 =?us-ascii?Q?5yB5TVCsQ+UO226x37Ms1K8pM8tApshgodZ0A/Yp+SkS80BPjXKpD967a0CZ?=
 =?us-ascii?Q?NJNa3qYyTnkrIBH8D/B8n5om6jKKxA1jik7MZbxy07ZOLVz8bA1SFuycI+pD?=
 =?us-ascii?Q?VjDdi0DcSVBvrEoWcujkttBUNRDO+epaaizBaKHV4Bpvtkx0DIkjPbL/PGvL?=
 =?us-ascii?Q?t4ix+i/hGwHQ3zm/BjSapQ5/H4SN2DPUSktexLovQveZ9OubFQ9weP2TUrl1?=
 =?us-ascii?Q?EoSD/xgRP9t340EoMh+GDz+ujs2oQ1AgYZMtOFGmSYGyelN4P13dzQg6qcce?=
 =?us-ascii?Q?2/iIw74fTjOOlwfFLOn4mlHpSw9q2xt/OvLELvyLpcMxFWn/cnGJCLjtaPur?=
 =?us-ascii?Q?G84s69IK3kYUPO9cAZskd92XFR1jDtEpo8s1MuCrgJjEQtksQKuoftU8iwMe?=
 =?us-ascii?Q?P2+vi1Tatb+xkrYRtj3FhR+aoguCb5v+3EiduBDjEUfMxJSv6KhmzJBp6Omr?=
 =?us-ascii?Q?CgZDB7lNXHbL4DAZqouGbgmkfhH2oGRXdj4eg1IbSXNJRo2aOVuN01QwkJ2c?=
 =?us-ascii?Q?J25SUo0YnCtYo2hPBKNT7qdNX/vH/n/448OCwuAXgvL2qCpo/lxyoVTtFyRr?=
 =?us-ascii?Q?8WNJvUtRaMIAhRMtf89kCKVpytPvxMpVAYPFDAJeyEoGM/EF77yM7wq34Un7?=
 =?us-ascii?Q?i/TRY+J/I8aPxBW2YQNKcnNiICu7gUhP884fwc3xQ80ZJG+PSxiWnq+VmG0Y?=
 =?us-ascii?Q?oF4JVf2mpXD+CDuMEmDJaf0vP1/o+06rImAZyk2lWLZ+JW9PLFndbpnRl/PP?=
 =?us-ascii?Q?SVuDRDJAv0Set7xCBncwX8W4L0ecY/cQJOw+7krXw5mcrCwWv37KPMkCHQaT?=
 =?us-ascii?Q?f94MPYJ6u/oluEhFSrEYqS7obb36vmQdjSI3Y34KCSOixIx5iMxHvPgFKkqL?=
 =?us-ascii?Q?FrlArxE20+BeGGBHLo7BSJrrxczbgH9Zq0hy/6b6ou7U6W0xXn+ETdqXIP5t?=
 =?us-ascii?Q?Ne+HvIWgiVn8KE5JY/t4wv2oBN513cECTGu4zX+imGqbhdz0+4BqndVl6BFM?=
 =?us-ascii?Q?A0QFjKwUKF9hJoz/tlag60Sb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4056.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb74c69-de42-4583-2ce3-08d94c05092c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2021 05:04:36.0734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TndyF6cpCl3dZpcABTs8oj0goM8JE2XcLXIs4uHEqfp1MCMqtmoMWFMC8gXG9bHwMbzCCaUHuo2N572QkahPYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6963
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> -----Original Message-----
> From: Niklas Cassel <Niklas.Cassel@wdc.com>
> Sent: Monday, July 5, 2021 4:57 PM
> To: Jens Axboe <axboe@kernel.dk>; Jens Axboe <axboe@fb.com>
> Cc: linux-block@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3 0/2] allow blk-zoned ioctls without CAP_SYS_ADMIN
>=20
> On Mon, Jun 28, 2021 at 09:20:15AM +0200, Niklas Cassel wrote:
> > On Mon, Jun 14, 2021 at 12:23:19PM +0000, Niklas Cassel wrote:
> > > From: Niklas Cassel <niklas.cassel@wdc.com>
> > >
> > > Allow the following blk-zoned ioctls: BLKREPORTZONE, BLKRESETZONE,
> > > BLKOPENZONE, BLKCLOSEZONE, and BLKFINISHZONE to be performed without
> > > CAP_SYS_ADMIN.
> > >
> > > Neither read() nor write() requires CAP_SYS_ADMIN, and considering
> > > the close relationship between read()/write() and these ioctls,
> > > there is no reason to require CAP_SYS_ADMIN for these ioctls either.
> > >
> > > Changes since v2:
> > > -Drop the FMODE_READ check from patch 2/2.
> > > Right now it is possible to open() the device with O_WRONLY and get
> > > the zone report from that fd. Therefore adding a FMODE_READ check on
> > > BLKREPORTZONE would break existing applications.
> > > Instead, just remove the existing CAP_SYS_ADMIN check.
> > >
> > >
> > > Niklas Cassel (2):
> > >   blk-zoned: allow zone management send operations without CAP_SYS_AD=
MIN
> > >   blk-zoned: allow BLKREPORTZONE without CAP_SYS_ADMIN
> > >
> > >  block/blk-zoned.c | 6 ------
> > >  1 file changed, 6 deletions(-)
> > >
> > > --
> > > 2.31.1
> >
> > Hello Jens,
> >
> >
> > A gentle ping on this series.
> >
> > I think it has sufficient Reviewed-by tags by now.
> >
> >
> > Kind regards,
> > Niklas
>=20
> Hello again Jens,
>=20
>=20
> any chance of this series being picked up?
>=20
Hello Jens,

Gentle ping.
Could you please take a look at this series ?

Thanks,
Aravind

>=20
> Kind regards,
> Niklas
