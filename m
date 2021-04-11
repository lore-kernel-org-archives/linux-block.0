Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B76C433B4
	for <linux-block@archiver.kernel.org>; Sun, 11 Apr 2021 23:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 096B960230
	for <linux-block@archiver.kernel.org>; Sun, 11 Apr 2021 23:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbhDKXfE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 11 Apr 2021 19:35:04 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:22087 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbhDKXfE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Apr 2021 19:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618184087; x=1649720087;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=aigELwnHkPv59m6OqFXTpEbXuv92Xiy7WpMd3X6+wlM=;
  b=CG3OXUKxKS0Q2LH84SWvbZ+3skbEmtO1p7HmnFic7Kk8TrQYb+WnVblv
   7T7UiJqllszjYPPA1Qem1vA5DFgP583k6D9qUlYEOpnijEmmyLHD7txng
   Br08MJnO8ouogI4AJSboWxH+uZZrnC3om+R+MN9J6oFw2f0uVvA/jt5Gj
   TurTxkCEma1vRs5QoV4hDOp2hoJBrnXYkM0CfArJvg1DSYHi+Gi0Y+zct
   j+A938qgoVMybCCsa4z3jaeG2kWDlc+6fVjqAVvUlnsukkB9mlh1NMcu4
   D0BoI5gHhWA7MIXVX/X332rxKpUUWvs5fl6dgUVzRMRUBm/OBe3sSh6LR
   Q==;
IronPort-SDR: A/ohXy6csJKYXMIMi6soraypeBJjxWxio84+iMLWG4mryP/CApse+fCab/WhUbmAtEib23LcU/
 kKe6mPxfQ7vOja3/YOkY/GZTgQelaLcsYSD5JLRBIcydTuRJSGSHVKpUCp82BODJcvQutWAHkf
 5l/8Dtn4mq8h9Up9qL4O01VkHu0cYVaRy7m4MWllC19Jm1/j/AD8ArGQPq8EOaiNCSVB6vquUz
 ZX9/yNM3Fw7jbwQPx5XFobDq4v3Zsfd9q0N6tz4UE0lYmdq5TsJQOF1qfL955vVxwujG3EPCTD
 TBI=
X-IronPort-AV: E=Sophos;i="5.82,214,1613404800"; 
   d="scan'208";a="168936469"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
  by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2021 07:34:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPQpSb84bkmM/+dROnfvIBAzixh3ykI4BSQDNH671dpZLv4Io5g2Xv4rjhDVWNX77ZwJz8ZSbF10rQkIrdCOarsKTCGMYnMWtrdKv2HKgDLXVPCs/Jjr/fHE2DOl1XvCcnP/Bn6vCs6uyRwWMiiIgSdUSX4vgk61nDrG4mRm2fw7ZXaELRfAoBVXtmE7PqGkwy9mq7F/9XYSwkzFeJyc1cdsBCVEhKzj9y+QwHFdJ3s319Q+lN6y5Knhr5fRsmpJBDCHt0fbBj1uz91KIRQMtdhA/gmV+uBAd7OzEiROmREg5/WxQdFeWR6hPJtXi2XXaWiuZbTwmzUGmEbL2H7oew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIE5tvGGgYwcDjTVtSM88pLr9booQsF8OF5Wh2ska4Y=;
 b=NPc4+Zz0AzoKNp0Zs3eNjp5PbFUjkxIjs4falmZS/wTYu1i4CBUSQdgu6oNYrzCluvs6r2guEAEoatjUEsP51a+bxYKtQz9Z0toO+G0Mpm7jqZQU1E3kDO6OSUpjQ3vpj0Cp6hbNcwk3q8lne2pQ89VFH8HyC1BZtF0+VHVKDm5E0y9+3+hZ/9ifve/GgDPXcHKB1KO7d9OfRhFu4TtMJAkJmHug6osgauSSnhMDSf5eeJNoTDIBPA+ofkqFhc5o9WGmRWL42OBN1dwnFhmaJmi/p766L7ORGh38ao4LibiVghVxx4yrYx1mbxFf5r3ZeHbmdAMDNi3o17x+iUYhuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIE5tvGGgYwcDjTVtSM88pLr9booQsF8OF5Wh2ska4Y=;
 b=CiqZBmSw9lWOv9AIBFVt7CBn3/n1h10GIhlqM8DXNBg1QbBjgJXBeLotMfF/3AhQn9ngu5ZhamDiAls3YZiFRge+Cos7LMsi0PH71IQtoxRgtRezAyP2TuTI7cbPbmTJOR8OxOMovredOVLTvQnmSAwOkzAz7IWVbPyvRLTImh0=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB7071.namprd04.prod.outlook.com (2603:10b6:208:1ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Sun, 11 Apr
 2021 23:34:44 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78%3]) with mapi id 15.20.4020.022; Sun, 11 Apr 2021
 23:34:44 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "oren@nvidia.com" <oren@nvidia.com>,
        "idanb@nvidia.com" <idanb@nvidia.com>,
        "yossike@nvidia.com" <yossike@nvidia.com>
Subject: Re: [PATCH 1/1] null_blk: add option for managing virtual boundary
Thread-Topic: [PATCH 1/1] null_blk: add option for managing virtual boundary
Thread-Index: AQHXLu/rk/KcLC3fD0u7SRVgJvswXQ==
Date:   Sun, 11 Apr 2021 23:34:44 +0000
Message-ID: <BL0PR04MB65147B275F17A60AEA672651E7719@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210411162658.251456-1-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:1134:9421:2151:4ee3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 797b0895-49e4-4f09-83c9-08d8fd4262f2
x-ms-traffictypediagnostic: MN2PR04MB7071:
x-microsoft-antispam-prvs: <MN2PR04MB70712AC38D229A7C37A381D3E7719@MN2PR04MB7071.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gELXauRAYifDhmTk56MBxDgmGl/AAOGKCvogopSI/2w7jUqHWCx8Yv8TEsfc2H7W/7tNl4uUql15ucjL6meYUZQr7b/oIknG3MnuU/jsEVGIp3ZWrUASBXj3mtjuhnebvt/dipY6P9Ph+GYTciCQ7D2xMdncx71CBkWDLKZKQylXc73qvcV5LD45wMooPU8Gkef2AOlQ5yV5nY8jwHluu+YuZ2jRWoHF36ueESYAWYgQAw4dy2z+u275fHnSLBi+2cbAyojpOVxHhlPu6bbi3xlYGWWtoARxp1l0qAAhwELxzoAzABfQTdXF6tMQYlzLPrxRDhUfPsk0M6CY3nnaLNKTsK9TfdOYV/XbGerx4EKnZAc1An6KCU5paGCWhClKafKzgFnXoWxgfWnZT7bPWau2t+HHQgXbKGeXUx95FKrA2nw4tKxBxpROT5KOcb/8Z84sKWwgLdHNvVms0RoOE+30RqQlxn4MpS29La5WVz5K1q0n9GQn63quoniVt/hwSgTeVL+cHMrqr+vLUxi7MIwLqFJfC0NSL4Lg3wR/CgbYwP0MrjTjxEDF3C4Gr8GJuHcvMsqlJCVXqbfBNzJ6sTb100kluuCDsKeVu5GPp88=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(2906002)(6506007)(53546011)(7696005)(91956017)(76116006)(71200400001)(38100700002)(52536014)(66556008)(86362001)(66476007)(54906003)(64756008)(110136005)(316002)(33656002)(186003)(9686003)(55016002)(8936002)(8676002)(83380400001)(66946007)(66446008)(5660300002)(4326008)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fpPxZVhKIMMk/wF95uB/LCQHL76hSkI38CGXMuCDtlJWFYsXnrlmCeMnMN69?=
 =?us-ascii?Q?Zb2gPvBnesZ6amVLqDxl48kTFinj2KlV8ME26HFoPs+uFRHcb1/jFJT/2P8i?=
 =?us-ascii?Q?l17lpkLu3/iM1Iz3V5Tdy8byW6lHXu/yPZ3Vgvfks+6YQWob2Y8LorYxbcPg?=
 =?us-ascii?Q?QgaxlfrWvh76H8oQYdnzVNGTUaTdtJpRgF6797ZJdueHo/GxtWPb0hSbDBIk?=
 =?us-ascii?Q?Zkgg6QtF2Z+hukHEQg58cixW22GY8lrAGPy41ghWt4uOyb5eqAQkehA+qrnD?=
 =?us-ascii?Q?Fd1A9+sp63XFsMguAwYwEd5ShZEOXgwBW+LSaGpCGVjJYdmer/xRBCeQytAm?=
 =?us-ascii?Q?Lpm0cYT+0/SVLyplKvRYl/esCDYj9vLDZrgS4BsGySr3PwmNNaC2aytgA6qr?=
 =?us-ascii?Q?cx+GFWoWVOxuoyr28DphpH3z8uZmR0EVIkAu12NHbA9HU/MBL1IB0g174Hbl?=
 =?us-ascii?Q?oL65pGkIDXqw32BwVwgijXeiU82SbzqNfaIaIVRrMe7v5lPkgtPy9DVjCb7h?=
 =?us-ascii?Q?no0DCdIHqDaHjdAvstuM+5QLILMpHnfwTZgIEjshAi0f47c3eS6TRK1cJjmo?=
 =?us-ascii?Q?m9Dqov47/EN0bhYbn6flyJHp0GOPKeHv7EvbkzZawc0nJC0XUnvdlx04BH99?=
 =?us-ascii?Q?EI34aaSa9AkHEgunkYpNXz6hApdXnXDmLYRPjO9sYvEbucx4AgI8PnRSu42t?=
 =?us-ascii?Q?YmK+qIIrbZ4BuEyhbcx0n417G+jfEMB2WnKYnO8UZs9foK+2AB+8dUmdkcNL?=
 =?us-ascii?Q?JAyNTUL4HE+Ye0j1eqjbihv9jjSYiIl3+gSaAUW57yl1w2jLK0miXMP1wZw4?=
 =?us-ascii?Q?awS6/INKDeFXdYMZGN/5frZOpGOAB0O+GXuzpZ5sKw93q/UdG2CtVL55H2Hd?=
 =?us-ascii?Q?daqmrwWmjUP3k2Ax+jPcQ4B6ULxzGL0pTeDgjckj4FJRSJRxQmal59Kbhz2/?=
 =?us-ascii?Q?+PUad0r0D1iDUa9ZbuKxF9iOig8YNg2L5DEXUfRtgNGoMN2l+5Au28bwe2po?=
 =?us-ascii?Q?JAxKMjKpTmMhmo7fy/MKD5iqpFNAeRi+hQEVp90UsrYW7mcJSvZDkts9hd77?=
 =?us-ascii?Q?Mzq5yPvNrELLSXb5XVQCwxdT3EBwb/FfwV+RtCV92D5v7p1E5EEodXsb8w7Z?=
 =?us-ascii?Q?F1qh09vZoGymThvyJQuF1c1yxZ173SyU1iyOBkAlv9ccsLk4/aPbFe/x0PUz?=
 =?us-ascii?Q?Xfju5vfLiIyPKj090zw5+7R5JrbQiyvYHwesp3Ns9Q/4MTV0Qk6EGmoVZq9C?=
 =?us-ascii?Q?7af8NrGxiElRrBt2RN0OCiOWzQR8g5rOKt4FzsWlQVmc8WCoYU//Qn33VlzM?=
 =?us-ascii?Q?HajYBwii7EEew19Ioc5aOMcCLyugn7QVTeoYaCGfU23UiqtuYwE51ywCT1+t?=
 =?us-ascii?Q?Tu1ZHDQdLwXODLqMcy/idFl1JqbpI9VUsJcfCgv7s+H0IXvMpQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 797b0895-49e4-4f09-83c9-08d8fd4262f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2021 23:34:44.0464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gaPxM63kt/+NBDyGzOSduCrV2vvayDf1w3o3Qunj3ffjQLfTwSi8palw/sAYfmqGvi8wCrvd5dLmIXtDkUzX7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7071
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/04/12 1:30, Max Gurtovoy wrote:=0A=
> This will enable changing the virtual boundary of null blk devices. For=
=0A=
> now, null blk devices didn't have any restriction on the scatter/gather=
=0A=
> elements received from the block layer. Add a module parameter that will=
=0A=
> control the virtual boundary. This will enable testing the efficiency of=
=0A=
> the block layer bounce buffer in case a suitable application will send=0A=
> discontiguous IO to the given device.=0A=
> =0A=
> Initial testing with patched FIO showed the following results (64 jobs,=
=0A=
> 128 iodepth):=0A=
> IO size      READ (virt=3Dfalse)   READ (virt=3Dtrue)   Write (virt=3Dfal=
se)  Write (virt=3Dtrue)=0A=
> ----------  ------------------- -----------------  ------------------- --=
-----------------=0A=
>  1k            10.7M                8482k               10.8M            =
  8471k=0A=
>  2k            10.4M                8266k               10.4M            =
  8271k=0A=
>  4k            10.4M                8274k               10.3M            =
  8226k=0A=
>  8k            10.2M                8131k               9800k            =
  7933k=0A=
>  16k           9567k                7764k               8081k            =
  6828k=0A=
>  32k           8865k                7309k               5570k            =
  5153k=0A=
>  64k           7695k                6586k               2682k            =
  2617k=0A=
>  128k          5346k                5489k               1320k            =
  1296k=0A=
> =0A=
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>=0A=
> ---=0A=
>  drivers/block/null_blk/main.c | 7 +++++++=0A=
>  1 file changed, 7 insertions(+)=0A=
> =0A=
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c=0A=
> index d6c821d48090..9ca80e38f7e5 100644=0A=
> --- a/drivers/block/null_blk/main.c=0A=
> +++ b/drivers/block/null_blk/main.c=0A=
> @@ -84,6 +84,10 @@ enum {=0A=
>  	NULL_Q_MQ		=3D 2,=0A=
>  };=0A=
>  =0A=
> +static bool g_virt_boundary =3D false;=0A=
> +module_param_named(virt_boundary, g_virt_boundary, bool, 0444);=0A=
> +MODULE_PARM_DESC(virt_boundary, "Require a virtual boundary for the devi=
ce. Default: False");=0A=
> +=0A=
>  static int g_no_sched;=0A=
>  module_param_named(no_sched, g_no_sched, int, 0444);=0A=
>  MODULE_PARM_DESC(no_sched, "No io scheduler");=0A=
> @@ -1880,6 +1884,9 @@ static int null_add_dev(struct nullb_device *dev)=
=0A=
>  				 BLK_DEF_MAX_SECTORS);=0A=
>  	blk_queue_max_hw_sectors(nullb->q, dev->max_sectors);=0A=
>  =0A=
> +	if (g_virt_boundary)=0A=
> +		blk_queue_virt_boundary(nullb->q, PAGE_SIZE - 1);=0A=
> +=0A=
>  	null_config_discard(nullb);=0A=
>  =0A=
>  	sprintf(nullb->disk_name, "nullb%d", nullb->index);=0A=
> =0A=
=0A=
Looks good to me, but could you also add the configfs equivalent setting ?=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
