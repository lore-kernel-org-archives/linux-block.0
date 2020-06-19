Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BB5C433DF
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 07:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2AE62078D
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 07:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Xt9UwECh";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="T/pwCh4s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbgFSHyp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 03:54:45 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:6347 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730880AbgFSHyo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 03:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592553283; x=1624089283;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=QVOVqevNWv1z62xsCV/7/btmwXY802vd/Owq/onzX5I=;
  b=Xt9UwEChikUHATXl/g6K4BMWxRm43+w80OZqud85mGYcXCZj8CLcGdK2
   lUIFIIuh8EMPukb1FlSl49fNBQWin2owGTTE/gV456NcFw51pvyeAfGeW
   1e/TXzCSEuT6anfd4wbmOi/wbDzZANEQx+WHsdQlt/l1QbMFSCz1HEsjI
   Zogd3/E3f7TK3yIEvLtN6szV0uxMhLN2NheQyXLwbtgdQ8NBqmDUBOWvr
   4jhPmH8/tFpcsoIolbL9iymrNheKqUAzVU0F11AUBXSvUnVtEdMyE6bUh
   P/giKvWK8yHvJMtLaK5U2m334FE+tVxYkWrrXXvm59KZ4xZTm/9C0la0h
   Q==;
IronPort-SDR: voT2mdNSf3PlrEdetbStl04aOedDKtrDSXgHL8qZMth8KGX003bBfQ8n45PVz3PK20Synsh+7I
 vjYlATXFF0pE037IpyY9p7DRvY1gHILCgH/1PWIIFNj47GFHVZ8lcrFvlzhBtPwLNkprUnEAOZ
 FisNqQzCMKl5cWugzGL0MnDezc+DqP/9RYK5jqDGxGUVRE/fPFpbrW4lsK/YNwTv7/AI9JkO5Y
 NkBCVkzSKtvltYOFcRLYta6PjNGpFRdS1zkXCzEhE+So2wKAiAMU3SVxGfnGAZUQSX1hkiaCzp
 Tpc=
X-IronPort-AV: E=Sophos;i="5.75,254,1589212800"; 
   d="scan'208";a="249595025"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 15:54:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnBEJyPm1pJtXgkUw/7xOvR0/30d/mU08onc9R+kK+qbY74AFB0yCzlA8mDzj1lPmXwaNcYl7RarQQ/gRfsVRr/pa+axrZGRCRVSFUtQqSoBxu9HI6iHouDMfNOD8B0MxuPiSBYwgCw6r0WYmW/RlYrcszU5uKgkyp2g7yfcVH1jwqyKRWTMLPYJMgmByIMSeP8qg29C27esRhUjmpfLm4snnC3606lEzK4CdNzpXKYJirUTF5haHDq0OHUP/FBCoA4WULcwx0CcTcXR8gaXLnw24mreOFARrugN+nHpWtnN1AdzyQEZWH6IgYymn9gfRJuxiqg2jDY7XQvL6KgCIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pLCc5va72/0/MbOS09iTXn2m/OiMBhJfPGIIJU9zHM=;
 b=OnERjfCcntLZ68onEi+Vv6h6w1v86lTyJkJnZ/h7i5PdRtG222TQmRRkLJ/4R8WBnb/YLYRDeGQw/6QgeluGVdFXAWtKJC9BrirM/NeEk/g4fV9TLYXi5ofX6ipOLWlVaGejHOJBv/kfK5GMT1Xq6ZSflN1Yd169IaX9PMQUrwAY5rkQ0sdd4/puRODq05c1w3kyADhpzO7zivKwQxR5iNX2kf13uVOLQ1Cz3fSJYa1svTaiIrTVSLB5SkW/f27+5CoR+r5YtfKnz8jypqutwEWyoRGrIPzgfUJUnip7a6H7GadNV62PAeqWkcbWR6vCs96N6GSkLcmo0Pwy0cP5vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pLCc5va72/0/MbOS09iTXn2m/OiMBhJfPGIIJU9zHM=;
 b=T/pwCh4sWi8HAFPrtAd+CNPD0Mcn6EkSnTL4H/vpgVQ36pkvAeSKf9ZExKAslBtZZuaHsOQpAeRHSVZdXZHET4ElNCtvNd+xF0Ks5w9ipkQJ0U7UJXXrkn4+PZMwTWaPis3k1NOImaqVc/VIyxKlEtjFY1h+zkkMChZzXJhRJlk=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR0401MB3636.namprd04.prod.outlook.com (2603:10b6:910:91::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.23; Fri, 19 Jun
 2020 07:54:27 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3109.023; Fri, 19 Jun 2020
 07:54:27 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Mike Snitzer <snitzer@redhat.com>
CC:     "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [RFC PATCH 2/2] dm: don't try to split REQ_OP_ZONE_APPEND bios
Thread-Topic: [RFC PATCH 2/2] dm: don't try to split REQ_OP_ZONE_APPEND bios
Thread-Index: AQHWRgczjPsIYl+9xUe/paWaQEGH6A==
Date:   Fri, 19 Jun 2020 07:54:27 +0000
Message-ID: <CY4PR04MB37514CDC42E7F545244D66C6E7980@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200619065905.22228-1-johannes.thumshirn@wdc.com>
 <20200619065905.22228-3-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3d1434b9-65a9-4665-b176-08d81425fd85
x-ms-traffictypediagnostic: CY4PR0401MB3636:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR0401MB36369DB17886292E58A79E23E7980@CY4PR0401MB3636.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0439571D1D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e1tg/lQc7mMZYgrCVYU5R+wfDSQfP+dva+x8SpZe7pf/U8b5QEq2hGepMojJdiIzqLarF9bz/vJXkA2D84hNqKM11DeIYBq2tO9R+NP2ivcBYEOVui61GcA0eaWFbhBs5F4PfqZkMikXirl0nHVSkwAs6cPQa0nfqt63ZNVMcrnlqXp9MYRQVR4vueIuMszPX3HeoWXfupUGn6vtdVmvCHJLXa3UOX8pVZzPOiju5LU2etLPr0qsZwGaR6rMKEWSiKawy0IDwtMNfR6Kvu8yq48Tzq+38wQ3vFTg5VzGgJGph2M/rh2XeauCnV7Q5sU1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(186003)(316002)(33656002)(8936002)(91956017)(66476007)(66946007)(110136005)(76116006)(52536014)(66446008)(6506007)(53546011)(4326008)(26005)(478600001)(54906003)(7696005)(66556008)(83380400001)(8676002)(64756008)(86362001)(2906002)(4744005)(71200400001)(5660300002)(55016002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: NMB5wfYGuJnHKmrKwvzkIyhwTxjtnHcaTm/PfFyT2YR5x8YmSQa0ACpbkWan4L9oa9rTjCvNB746JtPyL33s5VpQ/zMDDp2RbUpECw8buslX+8vVPGUOrbRMBsRYy3B0lB2LOIcN4S2Kn0ysxvNCneaNV76rbOmgQ5mq/78aBjk3D8LXiLkDE8yHlHrXZkipDLsLBljzknP1VIkjA3QFqN3t57iRN9S9gZAyIoz1K+yWZzdUGVX+2Q0UcUmpXN8wMrzUVXlRXqpiFmHIn89jVPg0hormfI845+HSaPsZ6dqYC2QE7E7J4w6INX0Fr9C/Df9S6q+y45Nm1FITIQaEjqxqNw0ucigZWGOz/YU24HU22J9NrRULU/ZKShEm5+lMJvfSZxHt3bdvUYV2jkNw84bngcmoOM1xqDBtJgUJb9b7G3iTkHRy+Ny+gaAMA5vWU6y2wbYkWkyg1nn8k5CiXdJLd6+5j9VQwgu3LizWP0istUJlaz9zUUN+oTWSYAyc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1434b9-65a9-4665-b176-08d81425fd85
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2020 07:54:27.1578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HvZyI52liZ2TcwX81fWpRN+ZHXaGw7lkYnh3YWQtUMDJV6UZAUU1wZO6n0bDnffzp1t40XyQyiVq7qURmw1deA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3636
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/19 15:59, Johannes Thumshirn wrote:=0A=
> REQ_OP_ZONE_APPEND bios cannot be split so return EIO if we can't fit it=
=0A=
> into one IO.=0A=
> =0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> ---=0A=
>  drivers/md/dm.c | 3 +++=0A=
>  1 file changed, 3 insertions(+)=0A=
> =0A=
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c=0A=
> index 058c34abe9d1..c720a7e3269a 100644=0A=
> --- a/drivers/md/dm.c=0A=
> +++ b/drivers/md/dm.c=0A=
> @@ -1609,6 +1609,9 @@ static int __split_and_process_non_flush(struct clo=
ne_info *ci)=0A=
>  =0A=
>  	len =3D min_t(sector_t, max_io_len(ci->sector, ti), ci->sector_count);=
=0A=
>  =0A=
> +	if (bio_op(ci->bio) =3D=3D REQ_OP_ZONE_APPEND && len < ci->sector_count=
)=0A=
> +		return -EIO;=0A=
> +=0A=
>  	r =3D __clone_and_map_data_bio(ci, ti, ci->sector, &len);=0A=
>  	if (r < 0)=0A=
>  		return r;=0A=
> =0A=
=0A=
I think this is OK. The stacked max_zone_append_sectors limit should have=
=0A=
prevented that to happen  in the first place I think, but better safe than =
sorry.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
