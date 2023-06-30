Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5B7EB64DA
	for <linux-block@archiver.kernel.org>; Fri, 30 Jun 2023 08:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjF3ItF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Jun 2023 04:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjF3ItB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2023 04:49:01 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF612110
        for <linux-block@vger.kernel.org>; Fri, 30 Jun 2023 01:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688114939; x=1719650939;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rTIWXF05jMafsAvAvXhiwhPICnNuovtx+xMiUzEE1r8=;
  b=dszm6rgTQSYdxRyo60GWKI5DfrZFwOsHv+mshxAS9TMZ5QXS2jv8+D5v
   8eCw4pMTSPBh3qhcz8VEGGO4X3mjaHPgOc21kej5TyMtnOPy2hJKQ8JRc
   T010/v9G74dRjYWpEl6Ur/fHJDJ1EkWggqse71UpOmIBc+BwBmruSrUAY
   GhLdYguf+p/cZomKzSe7MkAZaMrRJIgE/HFZ68AOoMfx+KQZPURubJyHW
   ZtiUdtBzm+YQjNo6YYW+XOKDBrBEfsWD/xCvbu07Owcr3xR2VUiUmCs2C
   LG+jPKc/LRcmHANp7AzBPH0gnd89OczRmTThGv6etk/p+HqdVcZ7CJiRz
   A==;
X-IronPort-AV: E=Sophos;i="6.01,170,1684771200"; 
   d="scan'208";a="341961879"
Received: from mail-mw2nam04lp2170.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.170])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2023 16:48:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQw2v3Dbq6pNY/6mhQDmvfg61QQb4LJkzpffuAl7jAUgbWoD7VfefdXwNJFz1B0Bo+RxAC9pVk9U7BO0GeS67rbkB1uwaDIkLyXL6B1nFzthpuxf2jWWVRXyXiFNUueo80RgfFRUUCwDLTBHN/Xe/GnuMZXHuIc8TWiEpcZxRan/hf+N2y5DKc1GrSWeVlvoS/c46CjHP/6h9ErRnaziR/w2i2WDh8kqU2QvmHO4RdSFnKaXhbZ08I2SSnxp52sg175npKLbeGVD4v/g5JoKShHIu9Z4DzpIUWFf8m7TbmUwpEG9Ov1gnrguRrx0LV4aS5CXGy3Xt9yXV5tMwZvn4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjkiaW2b4hDnqX7sLEU79PtczpGrwdY1f5sks4BwaRU=;
 b=HpDg6RdFQuL+/yHIKM0gbdyJWVmrzjlLiyzJmLtPUJMQyxDULL9KYsoGubLsDIYYBnk/i4pNtvfgEakyilXVQMxSLtlF/z0A0FHyCadpqMY5XNrTu7QIrzPzBlf+1H8EDVIfIm7SA6W0MSwrKYZ5MzbWwpf4CBA2YczYfM4+d88isUxO5xwjCKMjudvu9SdMLOALNyIODRZpwgasyrJcAL2VTI4Q9wOMxGseFgIt87Regqw/SwCRvNpAbVAppuLCDFcJ2wzg7gQ6fi116Vf4GY4A9cP8js+TdIeP+Qes6LkvwbMvLZblXdNZp81dA8XYXEXpLdrspadEtkxfQZyYIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjkiaW2b4hDnqX7sLEU79PtczpGrwdY1f5sks4BwaRU=;
 b=Wr7TjiS89WVgjnldWdb3PeJiSj8T1VNT+vaJO5dkdDCHT1vMafd+zvtQpiNhBZBammL84bVIfNj1HYhImtblo56prme27976hk8UDm3byiLsZqxVFZV8qmloYZHCk+xVh7n8W8yp8TT+q1NAh8vAESjc4wvx/wxHBZUUkbSHVlo=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7663.namprd04.prod.outlook.com (2603:10b6:a03:324::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 30 Jun
 2023 08:48:56 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%7]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 08:48:55 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [bug report] most of blktests nvme/ failed on the latest linux
 tree
Thread-Topic: [bug report] most of blktests nvme/ failed on the latest linux
 tree
Thread-Index: AQHZqZoWAREYOa2JLUG7L6op2T/M7K+hZqYAgAGlcQA=
Date:   Fri, 30 Jun 2023 08:48:55 +0000
Message-ID: <l7vk7fnzltpmvkwujsbf2btrzip6wh7ug62iwa3totqcda25l6@siqx7tj6lt3l>
References: <8a15d10e-f94b-54b7-b080-1887d9c0bdac@nvidia.com>
 <0c4b16a5-17da-02d9-754a-3c7a158daa56@nvidia.com>
 <CAHj4cs9ayQ8J+wDCWVKjmBTWTi7Bc3uqqTCDzL2ZY6JhpdDhsQ@mail.gmail.com>
 <1fda4154-50f4-c09d-dbb1-3b53ed63d341@nvidia.com>
 <CAHj4cs_+yBbs+MgrC8Z8J7X8cKYwwr6wcR5tLfUCcYkftL7N1Q@mail.gmail.com>
 <52df24f1-ebb7-cd24-3aaf-7b946acab3ee@grimberg.me>
 <CAHj4cs9=8fPRtXj4uyjN9MV1OMNNXwcVGte7CDnFxXYYbnnX0A@mail.gmail.com>
 <b3377b27-28de-c8ed-d45a-c3f241c24415@grimberg.me>
 <lfwwdbrtexufmsjbrw5j36jay2m56kdnuzwcrmcwnickzmgb4i@b5d32kl3oaps>
 <zftdt4pmjiwnbkje2zpl2kp5oraapsrawpbwf3l5qppmegpylj@so52n3f5zd6u>
In-Reply-To: <zftdt4pmjiwnbkje2zpl2kp5oraapsrawpbwf3l5qppmegpylj@so52n3f5zd6u>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7663:EE_
x-ms-office365-filtering-correlation-id: 0a03bfc5-1c2e-41ba-1b23-08db7946d67c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j+MZT8k4gbVlrTc+dq+ba/veTqrGzzhEJiwQia9NERcv5uZVkE5Okj8HwE2SCwI6nvJ7/BctyyP1WtMIRs+MDz3coSJW/uKVBBwv2Lww/Qn0gZ93zq+sOUeeRYPTyaY2Q7OGuW4VZ8f08e2Ll0HRosNWgwkhnx2iE/08jLxNgjGrEwVbgjfyKDNigy1LhEze/lXG13OW8p2uUwlP6Sk3T9410Cl/0m5qVXh0qFOWsa3Ql6CHRpfhQ11+X6Jyou0Yahb9LpvllWT6dFQuLvXOt1AwyelPLs2W9QpqkFZPsBHm+uUlx0dnJTBFWYuG/ED5r5E0gQ69OuLOHYIu36/6ZDVUmd7oG5Z5/XkfMQ50QjXHi6eE9rUJ8wB2ZmtVzE7Mik89ArVbr5LegDxdCmv7K0h3NJ0L7gqLnejibYVOumWCoFG9s6h+HI5E9bOkM9ehbCreuyyFwIxMbnBu/k2nToK500DBiogBjKDDBgV/op7N80KZ/u8CsxSYnDEs33Mw4ZNKuXEgHBqwdbyKNAwOh/JJUNHcmmdBtCyodPC0/d6jMRAx2ZbhBSaWyv5CwzAi4Hevwv1upg8W7xwtbtI7cNAXawhcStRcnWOIDJlSuxa9R4jSqkAlcrNvY6FSdpYo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199021)(66476007)(64756008)(66946007)(66556008)(76116006)(4326008)(91956017)(478600001)(6916009)(66446008)(54906003)(82960400001)(83380400001)(26005)(86362001)(38100700002)(122000001)(8676002)(41300700001)(33716001)(8936002)(6486002)(6512007)(6506007)(9686003)(186003)(2906002)(38070700005)(71200400001)(44832011)(316002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bhFI/gc+t8py97fEIKAsbbTUOxiVBoG0DPXrOE8J9A7o+rV7CMKkFC+Ar1Xa?=
 =?us-ascii?Q?aokMz1gQCqN6/62AKebrU6MXzTVpYmJhfCVMdIJ+EAEebSuaggsUSxOEkKdC?=
 =?us-ascii?Q?tN4d523hG8fDn2M27Z7gxjRuDqer907qDyOkpwUXBD48THgZUqucqm3n5qN8?=
 =?us-ascii?Q?9kp3LKQI3FIHg4Rjrm1vdtVse7HKoG7dBZiLVQwAPAStUxPrv60Jw7Io60ca?=
 =?us-ascii?Q?ldQedfPqnFPjKkwRjKTZEe7OwoTiJNmb2c2d/7gEfs9EHQaytWFIdhM4GVmB?=
 =?us-ascii?Q?ff2TzKocISgWgZfKT5sHYidmpIFvjvAZuuTe0Wqg1bzOmy0emACpH8CiWXvw?=
 =?us-ascii?Q?v/IkaqBM8IglKw/YFaY0b7GlIVypWIGSy67y1H+cEUEKIRUJ+3GBoonBPEXE?=
 =?us-ascii?Q?BXxcF/c1CTDqJXFhjEzvuxUSPyvhyn/l3lQuajJU/SSYQvygqfJay86iIEux?=
 =?us-ascii?Q?dacRRJCH85elvYS2SDOHQ0IZqlBMnVncuXQ13rP7yWHpacjnGX+DXJavfxIH?=
 =?us-ascii?Q?UiPpLcCT4MrURySlkN66zL+l2ELaP/vWWwK/P1PQNO54RAkAAY3zOnUZroA8?=
 =?us-ascii?Q?sxaPKp2OkUEOD7EaVJJpHcmdtgBpLlW4RuMxbPUsb7RBXMha/iU+3JJBc+PR?=
 =?us-ascii?Q?3yEFlwPs6HWfgOsGmQQ11tfTM4dO8jfTBjMXSR2LJmJzvIbWklX37K2rEXR/?=
 =?us-ascii?Q?nBe3TIfVD3QGJa0GDDGmIe3fn/tc0JPd8XY9JzfaT8uT6WrzPKv6YiM/RYkY?=
 =?us-ascii?Q?dbyWbSp5fPHB/siOqphFQbm549xsA1pGUO3tXwbJzm0ZNQ/SLwzRut0UAMSZ?=
 =?us-ascii?Q?CEyr6boUXC9Nog0zVsOWCnAyxLaDP8YuqNFTrtFhtLBV36W7oROzYtk3uTos?=
 =?us-ascii?Q?WPvnEc2RUjMKwWSMNKo7mjS+d/qgjId4ziJs6dltLIyOmApQhyc3k+P/M/JU?=
 =?us-ascii?Q?wXLLvpzqMgXLsTlpk5kaDxE+XoI2VA0jvE9770YXVq/lFJiwPU1By16+UD19?=
 =?us-ascii?Q?t2iWyb5qR+0XkmWNVHA39HHiJKQSTdtC1snH7kQlgG8ALjue4zelT39EjX5m?=
 =?us-ascii?Q?BYc1Bx6cwfh8o2tP1LxXnD2T8uJU54AYZdpvw0V9NmvF2dDFqnpkS/ywpSbV?=
 =?us-ascii?Q?8UjXxOQ2KtMErcQ3FhqsgVrOxtfsSa0rs5IgGK0l7dNiHNlicSZoGcIEx5us?=
 =?us-ascii?Q?lnZ/ZG2PohyPN8W+iw1VQpUlRmm2BedoKu9nsIIsmtO3tRSt+p/4DzmDgMra?=
 =?us-ascii?Q?OV7IvKeDrFZjcoQN53IAdMbx0xBAjVR3k44ic+HkNtNKiexcTOJ10w0+Liak?=
 =?us-ascii?Q?88iJQTjOeYLHBf07pPkWevPm/0QmkhMK0bjCcTscddzZ7e/4hTn3WfAyWcLR?=
 =?us-ascii?Q?0tXTRDcpPt2Y+1+UxJ8kMhfC2EbIckoYobw77Ln2G7xiuprA5d19M13KEjko?=
 =?us-ascii?Q?WAujDJ9FQ7QhH3rVwytxcUfqDihllNylgxH5B51mMdifz7XCFCXK9pZItEab?=
 =?us-ascii?Q?Qh+iXJE3i2Rj/3jMCVJbwjOwAINOHyuRSW75MjZ7qnlrDhRBbGXJWINNL+rf?=
 =?us-ascii?Q?2jAi4FjRo4/9/N0Yrm5YnmP4bKjhQ3ljUr706zGcS4fVL0WtkmATlzT+OrPL?=
 =?us-ascii?Q?5RElvOV22cWME3IrtYEgZ9U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DC793F53780EF94BBCE0DD64ABC86575@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?UHSbOP8HECRTwbBop0UhOCJ6JWSQEQSuoeb62EtrgELnimApGqyWZ/v43T+D?=
 =?us-ascii?Q?JDaf6ZcgelPSyx6XVHGHX7IfnGGylu6Ntkgqaxhd3JUke5MvXQZ6F4I5hiaD?=
 =?us-ascii?Q?WY/t2oErNi7srpXpAVH3SMSYLFLJrINYGPlp4QZgZSjUbRN4ZW748HvdAJoV?=
 =?us-ascii?Q?MpEUHEIfGrEckkMDmS58/K4pNHRvoQefJ5c/HTzTW1I79Vx8kxe9d9D0vSHx?=
 =?us-ascii?Q?eWGGoFwjn4zOzBjApVWNZfyKrNpyvNNQDYahE1vWaaSzibm8gdzA7sNJxfPk?=
 =?us-ascii?Q?TY0q1bunjro/7FcXcdaNziExl0g6idQ8xk1CGeFH2mI8iz71603tnbJoNq3Z?=
 =?us-ascii?Q?gLWVB7x5wuij2UFMKC2ypY5AFG98P6u6chTdKc+06pi6a5X3TuTWBYMSN8++?=
 =?us-ascii?Q?3WE6S5O9mBPlSxLGPo+JnzEzMYOiW9BYB4pjIUzJ0pSt0rimTgJ0DQeuRBGW?=
 =?us-ascii?Q?yNb+ewfi1OLbPeG/NSio9/aGjUyme0fucwb5oo8ft701bLmPMvKUw8/0b2h/?=
 =?us-ascii?Q?5msmb0OnK1EiDhpIQ7m1uiDSc3lEAcUpQ6xZtlyoSHYltsMXP65EMBhvI6G+?=
 =?us-ascii?Q?x0Jd5CTAyrRTSYeUov9Xm+6T6WwmHK6s9oTAEGLNfTi/yK2dIZi7+VZSPYZF?=
 =?us-ascii?Q?HCefKZi3KqFzCRwrPqc1YB7Rn/bGzTSPD/pKh4LiT/1lgwv9QtjTENhdJkvt?=
 =?us-ascii?Q?e1phpCejXv6NajKBAgjq1HIFnkz7ss4OQvjnGDAU5Ni8JxNQumk5ll5ygMXv?=
 =?us-ascii?Q?wBjz3tGpZ2VmvcoHDwMQD0cQrz5R5KH5VfIYBqXolrzBkEiWpzmm5U9o7JNz?=
 =?us-ascii?Q?B8YotqZWChXX+Yp0+K5V+BpTZG6xvff6acf62gW4mdaCg4ThvAS5r4WBGlwj?=
 =?us-ascii?Q?x0UhmeT3iNOU8bgyWWaLWw4kBpE2ZtjZAAIS1ABm4wrJmZ3wMcCIS0Pl7DcN?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a03bfc5-1c2e-41ba-1b23-08db7946d67c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 08:48:55.5611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L8QoW3RALUp9OxC5nacOje2iPVzFERkjsuhTer2uF/bg48Ffc5bTneRzDbNQTv/fK57bYJqaWIfrlqEZCH8HB5i4lfq6aKOHavFIjZo1+KI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7663
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 29, 2023 / 09:40, Daniel Wagner wrote:
> On Wed, Jun 28, 2023 at 08:25:24AM +0000, Shinichiro Kawasaki wrote:
> > I looked in nvme-cli code. When it generates hostnqn, it does not set h=
ostid.
> > A quick dirty patch below for nvme-cli avoided the failures for nvme_tr=
type=3Dloop
> > condition. If this is the fix approach, the kernel commit will need
> > corresponding change in the nvme-cli side.
> >=20
> >=20
> > diff --git a/fabrics.c b/fabrics.c
> > index ac240cad..f1981206 100644
> > --- a/fabrics.c
> > +++ b/fabrics.c
> > @@ -753,8 +753,13 @@ int nvmf_discover(const char *desc, int argc, char=
 **argv, bool connect)
> >  	hostid_arg =3D hostid;
> >  	if (!hostnqn)
> >  		hostnqn =3D hnqn =3D nvmf_hostnqn_from_file();
> > -	if (!hostnqn)
> > +	if (!hostnqn) {
> > +		char *uuid;
> >  		hostnqn =3D hnqn =3D nvmf_hostnqn_generate();
> > +		uuid =3D strstr(hostnqn, "uuid:");
> > +		if (uuid)
> > +			hostid =3D hid =3D strdup(uuid + strlen("uuid:"));
> > +	}
> >  	if (!hostid)
> >  		hostid =3D hid =3D nvmf_hostid_from_file();
> >  	h =3D nvme_lookup_host(r, hostnqn, hostid);
> > @@ -966,8 +971,13 @@ int nvmf_connect(const char *desc, int argc, char =
**argv)
> > =20
> >  	if (!hostnqn)
> >  		hostnqn =3D hnqn =3D nvmf_hostnqn_from_file();
> > -	if (!hostnqn)
> > +	if (!hostnqn) {
> > +		char *uuid;
> >  		hostnqn =3D hnqn =3D nvmf_hostnqn_generate();
> > +		uuid =3D strstr(hostnqn, "uuid:");
> > +		if (uuid)
> > +			hostid =3D hid =3D strdup(uuid + strlen("uuid:"));
> > +	}
> >  	if (!hostid)
> >  		hostid =3D hid =3D nvmf_hostid_from_file();
> >  	h =3D nvme_lookup_host(r, hostnqn, hostid);
>=20
> Looks reasonable. Though I would propably also add a warning iff
> nvmf_hostid_from_file() does return a not matching hostid.

Thanks for the comment. I revised the patch as below, and it looks working.
The blktests failures are already fixed, but I still think this fix in nvme=
-
cli will avoid confusions. Will post as a formal patch later.

diff --git a/fabrics.c b/fabrics.c
index ac240cad..2eeea48c 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -677,6 +677,26 @@ static int nvme_read_volatile_config(nvme_root_t r)
 	return ret;
 }
=20
+char *nvmf_hostid_from_hostnqn(const char *hostnqn)
+{
+	const char *uuid;
+	const char *hostid_from_file;
+
+	if (!hostnqn)
+		return NULL;
+
+	uuid =3D strstr(hostnqn, "uuid:");
+	if (!uuid)
+		return NULL;
+	uuid +=3D strlen("uuid:");
+
+	hostid_from_file =3D nvmf_hostid_from_file();
+	if (hostid_from_file && strcmp(uuid, hostid_from_file))
+		fprintf(stderr, "warning: use generated hostid instead of hostid file\n"=
);
+
+	return strdup(uuid);
+}
+
 int nvmf_discover(const char *desc, int argc, char **argv, bool connect)
 {
 	char *subsysnqn =3D NVME_DISC_SUBSYS_NAME;
@@ -753,8 +773,10 @@ int nvmf_discover(const char *desc, int argc, char **a=
rgv, bool connect)
 	hostid_arg =3D hostid;
 	if (!hostnqn)
 		hostnqn =3D hnqn =3D nvmf_hostnqn_from_file();
-	if (!hostnqn)
+	if (!hostnqn) {
 		hostnqn =3D hnqn =3D nvmf_hostnqn_generate();
+		hostid =3D hid =3D nvmf_hostid_from_hostnqn(hostnqn);
+	}
 	if (!hostid)
 		hostid =3D hid =3D nvmf_hostid_from_file();
 	h =3D nvme_lookup_host(r, hostnqn, hostid);
@@ -966,8 +988,10 @@ int nvmf_connect(const char *desc, int argc, char **ar=
gv)
=20
 	if (!hostnqn)
 		hostnqn =3D hnqn =3D nvmf_hostnqn_from_file();
-	if (!hostnqn)
+	if (!hostnqn) {
 		hostnqn =3D hnqn =3D nvmf_hostnqn_generate();
+		hostid =3D hid =3D nvmf_hostid_from_hostnqn(hostnqn);
+	}
 	if (!hostid)
 		hostid =3D hid =3D nvmf_hostid_from_file();
 	h =3D nvme_lookup_host(r, hostnqn, hostid);
--=20
2.39.2
