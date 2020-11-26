Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4609CC56202
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 08:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D21CE20DD4
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 08:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="g7VUNTYP";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jWzb0fl9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbgKZIkl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 03:40:41 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:45061 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728862AbgKZIkk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 03:40:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606380039; x=1637916039;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ud+R0/bGz5+xs86z5o36jmuf1wjfD2QnB1d5C44x9qs=;
  b=g7VUNTYPALchYusulR7YfybP/y3Tu2Mi2O0aL1++vnU3e1XRez1Pyshi
   SiD/32TBuub0ISNebxsjmYaCgXeQGo58LHBd7M5HyiJ887PS4XGtNI9cz
   PqBaJf12ERxQEYaPT1EjlK6+d0/Xjr6Tr+huxluEerEDljntlu8rIXbm5
   Nsg1r4tDdLTjV5I5ggTXHvnPGPppldMaI7TN1knfHAq9U75PVJuJVeV2A
   7vpwz5PzTcWo8aizBUuIe+JomZxIEG79yEPO6RXHYRdQ5VMQEG4BxtiR0
   z6wZcvEcyATDzcPbf1aN+PquE5Y4zDSDd6wlzkLA71pN6nxFTRkDgxTxl
   g==;
IronPort-SDR: gEScAS1F07eDMwXU+gqG57GIpMbQTH1olY+9u6OEZfMB/Omu3cQ4AffhWAPXGjQhbOIfnjtwnL
 WdVnX5R6WLksDwADVJj1IMZvRLCBQdwc+22NoZTQdjhS8LAzJ7Yb4pf0SYQaxaogTN+No1IVRx
 MpImE6YWEmL6zXpByPvbMF3BJITarMQehh6O96xksVhZ7YCGi4tmCwzP5i/C2d4vpaGLu+0t/W
 uZP49dpemtMWqefiv9hE9HQMqmlnFFCZIkxoSin1ObC+RLLuRA9v3YOG3ufGs/NgDfndHS93sA
 RgI=
X-IronPort-AV: E=Sophos;i="5.78,371,1599494400"; 
   d="scan'208";a="153470810"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 16:40:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEollcqTotnjOTyznOfCLppo897NOEL8hSizHejIRGTU65qAn/2SsTnWyhKHtAR1BAEH2fKfRpVuOMYxlsYsuNnNGsyrq2L7HJ+kmaWJRh6uPIX1ySGN2WsLIjOEznWgxmNIBnEhylp3vrG2zxxMwKSLUlEo1RpCxYWI6G99iRt2LEWKWn0Va/rrwHXp7l2LDDesknjjhjauWx1lp9beGwTrJQBYvMQKBHJE0YJPWlTtYdoNd0SEzWqX9eP3rWtUKo/qCBjE7qLqR0zAhFmj+9UFwhEKCc4sb3ydM6L3WKPi53ldqF04kB1VxsgzqZDYVIuCnvASoSBFXqFg3Ng7QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWdSP+gBfX5Ko0tBCW1V0XkbyCYbMPs4wrLGaDE3Xr0=;
 b=lZW7huDKlgREQRQYpji2C4oDcyyqNmggFJAujomZbTQlZCtD2TPUCeK+GIvHsV/GRz4hAvyM/7yOG0WydzCmeV3TgzjYJ9DTnBA+CbtUXdP76lkjh5UNFE6GmXU5wGDVDh0xG+hZpTRnzRbr3MII8p5Gi1x/s8Xs3LmIDmbN35AEmTstidsuzJcT2C8etlqlUSDyujCuI8s97M9WniCkHDLzTMGS8wZEj2JvxbxnWzT48XnjQ369/rmgGWHEVSFq5OsnCyJxzaGguyaLHiLlgGEfoBhjnhSxhlctnVyB8AjMmk+yIBUPUR5rXWEhA0PAjvJCFhJlYSNgcM1mzmn5bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWdSP+gBfX5Ko0tBCW1V0XkbyCYbMPs4wrLGaDE3Xr0=;
 b=jWzb0fl98MJu+4nY4R8wgkIPCC5gdUHeiwu4r6f5QXu22thoa/3OiumXGT0yb/MQwjzJyEk21doU+Kbsv4iO1ejWAviTWkW3wrdgjppAWgOFA5wQ4OZyHh60vh1K7sjEQUdqQd4W5iCiTha0wjgaB8Tq/5x/M0fAo3mlA3ATx5w=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6981.namprd04.prod.outlook.com (2603:10b6:610:a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Thu, 26 Nov
 2020 08:40:38 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Thu, 26 Nov 2020
 08:40:38 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 7/9] nvmet: add zns cmd effects to support zbdev
Thread-Topic: [PATCH 7/9] nvmet: add zns cmd effects to support zbdev
Thread-Index: AQHWw53EFEA8L9B6Ykykan/g0NuNYw==
Date:   Thu, 26 Nov 2020 08:40:38 +0000
Message-ID: <CH2PR04MB6522D1576DD709698B997830E7F90@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
 <20201126024043.3392-8-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:7477:1782:371:aeb9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1904398-9c78-48cd-1026-08d891e6f36c
x-ms-traffictypediagnostic: CH2PR04MB6981:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB69812C94BECB6E37A0FC2F5EE7F90@CH2PR04MB6981.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: btvjLlnPihjk04+Qc3Fb5JrCsqpoS1L2hsDfFpj3+tqHv01hQsIM6iRNszcrAh0sspQSVLtlVukuFQHXpFql6AwCRhdOTSHpYliknH1q/HRdJ//HoDQr41VRrK3zJAoKJ+16Dy2H69++DrEk437aTF2RS8Z3OKRC3l8btOflasuAT9Zr+vCtzHhINHCbDPj6ii3alTE40OUCix1EDMuF9weN3KoEpE+QhQ/sjzRqQBntNKHT+J6V3tXtQvUfAcvEf+xEY3izLCJBUl6GIKkVDtpeBdb2ikRqx5BCjj1J/LD3tUN3fOpfJIsn+qzF+0oC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(64756008)(66446008)(186003)(4326008)(66946007)(9686003)(54906003)(110136005)(53546011)(6506007)(2906002)(7696005)(55016002)(478600001)(316002)(33656002)(76116006)(66556008)(66476007)(91956017)(8936002)(5660300002)(86362001)(8676002)(4744005)(71200400001)(52536014)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?U7CDW3pzdyUcQ3BNbH98UyFqOiqpeV0AK6LgDV/b3RXly9infmXlywV5gQtU?=
 =?us-ascii?Q?icX9vj0HEreXsSlpNu7QOCGnRry/MyiW3kQaqzbDpDMK73ZyDgRhvUAj5PY5?=
 =?us-ascii?Q?lmeMzmgoAqSrNycBwxSNTKmfQCFww2V2LvUJuw8yYRRH06jg3FxDuUISq7Dg?=
 =?us-ascii?Q?rKWaNjHSxUIWjkYvwTuYkblR5LYn0PMz5oipHonlz9yS0iJgfXHvWIWv+4FY?=
 =?us-ascii?Q?VJxe3h58L/wbjYerq9z6ASiNBYp4C3Qa6cLwkdpqfUiZUZihCxv/ECncNU+k?=
 =?us-ascii?Q?e/8WTjJDKZOCfwTe08ttaxk+p14llqlnc+eQwhJZBCxaSSvFQLGEi1N3A4TT?=
 =?us-ascii?Q?KZ3ibx6wKdAH/Oueh5i5/xQKwov8pw/gje9oZOEZu8j92OLV+ywoJ3DpG/nv?=
 =?us-ascii?Q?PhLGke/jiSdbCZlHbyxm6Ox+klYffRGHtPMeMNNqar4gnEWXLH40vHgCpv5X?=
 =?us-ascii?Q?ereY1h/CYRsBPeZK1eFydv+8TGRYrYAEEYDpN55qq4m4LQdA8S70LJQY5O8O?=
 =?us-ascii?Q?XbRnLR73wlcV6NP5MMUyxtnKekmu4kI4OA3vHnW555+qAOFQoEAlGT0bcNFH?=
 =?us-ascii?Q?mPyqru7FUAQvOQESEP+OC7sQB38ry6QALq5mo9z/EI+e1StKhEgMmYbNpp4M?=
 =?us-ascii?Q?TiIHiRWssPRJ4CNOklTcM0nv4GcvPSS7leATd7EF6OPQbn2KU+OnvhfKIMwO?=
 =?us-ascii?Q?3t/cnufZNzKngRUZc14Bki4MORdOxUZNDN4MqEwRrE2p3TjXyzlPiR2bMSf3?=
 =?us-ascii?Q?93Q3gqa+eOFcBQng626eiqjZQFL/L+qKmB9+rQRXZaRoUyEMCxQKv6iO5xil?=
 =?us-ascii?Q?WF+AtKLXXdeksk28OTuk2n+ES2YpH1tFUxBbzla1Tdm26C4P4xw59j+Hw1VF?=
 =?us-ascii?Q?NqUYNs2V4jPgZXypVzVfivTORUvNdYI6FtfLqmUiPc2vGi4wfL48bhVzoDou?=
 =?us-ascii?Q?VFmtL2+pE/U9Aw8fQUFGDNFd+hEuaKnTk1nAsHw5IiXMz1iZrL4plpHO7MeL?=
 =?us-ascii?Q?LBYh8IuUO1rHUa9CpNnPTvu1Sfwhe16E9KZ4vQwuMyAOg83XvZ2I35aeska9?=
 =?us-ascii?Q?CVNmUxOG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1904398-9c78-48cd-1026-08d891e6f36c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2020 08:40:38.4121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iMlfuIgDqDHVI0v/ss34PCwT8Fq/Q2uUkKCO5DvAt75cJPCwXQ+JBDdXsbsl/y4d1zpgzna9vdFLex8YzM4I+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6981
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/11/26 11:42, Chaitanya Kulkarni wrote:=0A=
> Update the target side command effects logs with support for=0A=
> ZNS commands for zbdev.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  drivers/nvme/target/admin-cmd.c | 2 ++=0A=
>  1 file changed, 2 insertions(+)=0A=
> =0A=
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c=0A=
> index cd368cbe3855..0099275951da 100644=0A=
> --- a/drivers/nvme/target/admin-cmd.c=0A=
> +++ b/drivers/nvme/target/admin-cmd.c=0A=
> @@ -191,6 +191,8 @@ static void nvmet_execute_get_log_cmd_effects_ns(stru=
ct nvmet_req *req)=0A=
>  	log->iocs[nvme_cmd_dsm]			=3D cpu_to_le32(1 << 0);=0A=
>  	log->iocs[nvme_cmd_write_zeroes]	=3D cpu_to_le32(1 << 0);=0A=
>  =0A=
> +	nvmet_zns_add_cmd_effects(log);=0A=
> +=0A=
>  	status =3D nvmet_copy_to_sgl(req, 0, log, sizeof(*log));=0A=
>  =0A=
>  	kfree(log);=0A=
> =0A=
=0A=
This could be squashed with patch 5, no ?=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
