Return-Path: <SRS0=MEbK=2Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C699C32767
	for <linux-block@archiver.kernel.org>; Sat,  4 Jan 2020 22:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D35522B48
	for <linux-block@archiver.kernel.org>; Sat,  4 Jan 2020 22:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eM773IWe";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tOWtEZ5M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgADW1o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Jan 2020 17:27:44 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:1587 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgADW1o (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Jan 2020 17:27:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1578176863; x=1609712863;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=gakPB6rTAngt8S1xhMDCIEtthQgCXm/tp/gUF1daSB0=;
  b=eM773IWeQ9/HwIGTRs+xkC9irWA5npPbOqTYawnE4DJC+4oIh6Q+d9H1
   GMJMIFOtNoV/UIyxnTju5+EPxEPQlCzG1fdNRlnYrceMUprnyVD2ed8ik
   +U/iTBUyDDHM2qUmjLyTkesJbgNihyz3NYvHtnp5Q3FuZdzGy7dMsOTLR
   uTwLF/0PW2UTuROSXPgKJ8DeQr3aF6s5E1uvCARYwnZ1lKVIjLUjAmALl
   oinCR2xsj++ta1k+STCdlDWT27PvzJJQdo34IG4MPgVkRSfuP1zPM3kdS
   eIzDeTlMtVqxvDR4MoEJgTGrlju6tt+B7syq1GF2uEk7N7cAoRq4KIO+N
   A==;
IronPort-SDR: +iLJQ4KnATKypVW/wfC3iSAgCTY01+LcENEAqn0Vsq0u642MOusIXsbdfo67PcJPvzjgyk63U3
 e3690yuqvKmeDYf6L3Kpcd+JsvEYfVNhsEZYAcpHh8thgzVhM1B02AALeOd0gcYtdaaTe7gGAJ
 YYzQ9z0VZUeQRsodk+6Ap6tzyxSS7kduo99QPjAm6+7o9cX5wY0Vq3b+/tytxkXfxxHLFp2A2w
 hrGMYEEsRI8lIMomS3AWceQqeWDmcPYnfBsTX5mEIBBsSgn4Q0jNY8QWy4+bpPEvPhZFV9mar7
 RiI=
X-IronPort-AV: E=Sophos;i="5.69,396,1571673600"; 
   d="scan'208";a="234468264"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jan 2020 06:27:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKysshTGKG8Iz3Ah0eIrq1NZeyyo8mheOCLphJa67oJFobsrUTsnQowok44Q5bI28LfYYS7J7dR3+AVh2ayl/Jr/e1nmflRegbi2/ov1ecNHNsjgOz6Ztuzy/96uS5awP5esjkSBPQFqkRFSgzqxfZmNBPTIflM+tZ6TJUkizzMXLXA4moF8h0ufdWIJDfdVY7fVWinejxNpzkXZYGngq1sb1r11YuCkWQBWD39T89g090+4dEQgEVDDi9c+K3uDcad3upJLrhvET2CJBOJyZ7cH0SpuoBCxv/PTyLSszViPIdHPMMlZnRzFBTbDAtxdhfK7HicABYJ6zHDAt0JLaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szmrbNYnS7HRYBEOsnAyzvwyhE+xJsGyvu0dKJtfA3c=;
 b=HG/A+JZnQOA9KiPYc+HbmGDKJNwR2r2n7m8WydRBDGw2KEhbjsWt4g6dxfdCM+qrKKcribiVs+YkoWoO489p5vz62Wuwvob1UCS4zEhdbJ58YiqOqvaD+ffx5MRdooJs1/AEUapOBkJITPa0PF4ytpeRFMO+6c3REaOdKJ6Pi8rRgBQRyRsuqpQ5JUsAd8dSeqWsCu7/3K0HzFS/e90qSlMzVVZnlkTcFt2QifPfoOds9nimjDRsm9RQOozjpADNZGAEgjDnWxV8AzcsfmsJaTfNr49bVji1CoovKvdoLbfeAsKcOfOPcnjC/ffYDiz8w9dIODa4P+IMDpDGjP5/Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szmrbNYnS7HRYBEOsnAyzvwyhE+xJsGyvu0dKJtfA3c=;
 b=tOWtEZ5MXMbv//iVzh2TdNNAcV4KDSLuA0t71EOb8lFDlRzBoadqIXbmIiUxGHuV3Y8i5mv8sVVePIvK/ax+8r0zdE99qcBnSNuaiCCG0FwB7kRx476M7ztoRwmepZR7l6Ql6pMLXebFVfuYH7f932ywrltjltMf+RKNLZ/0Pis=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4904.namprd04.prod.outlook.com (52.135.233.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Sat, 4 Jan 2020 22:27:40 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2602.015; Sat, 4 Jan 2020
 22:27:39 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Balbir Singh <sblbir@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "ssomesh@amazon.com" <ssomesh@amazon.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "hch@lst.de" <hch@lst.de>, "mst@redhat.com" <mst@redhat.com>
Subject: Re: [resend v1 4/5] drivers/nvme/host/core.c: Convert to use
 disk_set_capacity
Thread-Topic: [resend v1 4/5] drivers/nvme/host/core.c: Convert to use
 disk_set_capacity
Thread-Index: AQHVwUHMcV4G7Nsdi0W8ganO7VoHBg==
Date:   Sat, 4 Jan 2020 22:27:39 +0000
Message-ID: <BYAPR04MB57490FFCC025A88F4D97D40A86220@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200102075315.22652-1-sblbir@amazon.com>
 <20200102075315.22652-5-sblbir@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c6f5ad70-ca49-4468-f9db-08d791654f02
x-ms-traffictypediagnostic: BYAPR04MB4904:
x-microsoft-antispam-prvs: <BYAPR04MB4904FE471C69C2F2C9E505F986220@BYAPR04MB4904.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:530;
x-forefront-prvs: 02723F29C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(199004)(189003)(55016002)(478600001)(54906003)(110136005)(9686003)(52536014)(316002)(71200400001)(5660300002)(86362001)(4744005)(7696005)(8936002)(6506007)(26005)(53546011)(4326008)(2906002)(66556008)(66446008)(76116006)(186003)(81166006)(81156014)(33656002)(66946007)(8676002)(66476007)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4904;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lEwSrVNtdbmA5ceEFoh6rRQQZBI6j/UKyUj2S/985Qncb8UAkC/Jst1TZEPUp/FVSmdaUMveTiW8vj4OPrS48WMXX2gJCw6k+p+S2YLkD/W9OsR2HbdlnGgkEbq3dEUnJV+Mn2UD/5xQo+LOVWk/XcM3yUKOtg6EVI6pOZ3JaqYKHLFmmp1/IAwPsQ2aIWQsVs1XiOzFD3WdKUplZXJL/hP6B0sbPheQDwnYpdZ9Z1z4pFWh3f0zB2eSqeNC4BPDeZb+0EbHCYBs5d3zmwfO6emFkcpNuleiiis6WyJrrH+xYAxUbkFmh7yPW2epLoiQoT/asB9dJW9WkIX+0mB43V+lBM4Dr6lnnCdwV/NdfrC7fNokscw5/+1qalnwsJkn2sfNmNwRnapeRp63IAzR9TMXIa0iPniZ7t1fidm47YvRLvSzWckeHLC/cW//5xAA
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f5ad70-ca49-4468-f9db-08d791654f02
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2020 22:27:39.6905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JXlLn7L45wsIed3TqlYX5yI9pf/FcuSJ3Y/S+9vfDiHyL3Gi5b2Al4niHugcFxudr0lGGbI33Sbez1m5938y/R6qOI+XOSKqcd2mGlqxBjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4904
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Quick question here if user executes nvme ns-rescan /dev/nvme1=0A=
will following code result in triggering uevent(s) for=0A=
the namespace(s( for which there is no change in the size ?=0A=
=0A=
If so is that an expected behavior ?=0A=
=0A=
On 01/01/2020 11:54 PM, Balbir Singh wrote:=0A=
> block/genhd provides disk_set_capacity() for sending=0A=
> RESIZE notifications via uevents. This notification is=0A=
> newly added to NVME devices=0A=
>=0A=
> Signed-off-by: Balbir Singh <sblbir@amazon.com>=0A=
> ---=0A=
>   drivers/nvme/host/core.c | 2 +-=0A=
>   1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
> index 667f18f465be..cb214e914fc2 100644=0A=
> --- a/drivers/nvme/host/core.c=0A=
> +++ b/drivers/nvme/host/core.c=0A=
> @@ -1808,7 +1808,7 @@ static void nvme_update_disk_info(struct gendisk *d=
isk,=0A=
>   	    ns->lba_shift > PAGE_SHIFT)=0A=
>   		capacity =3D 0;=0A=
>=0A=
> -	set_capacity(disk, capacity);=0A=
> +	disk_set_capacity(disk, capacity);=0A=
>=0A=
>   	nvme_config_discard(disk, ns);=0A=
>   	nvme_config_write_zeroes(disk, ns);=0A=
>=0A=
=0A=
