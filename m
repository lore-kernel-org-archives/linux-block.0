Return-Path: <SRS0=NzS0=76=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D81C433E0
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 09:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 296CB20707
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 09:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Zg4cSiPo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KCQ+eU+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgFQJuY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:50:24 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:51523 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFQJuX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 05:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592387422; x=1623923422;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=untCL2jWKvmXLTQwXdSvntI66lb9+XXKFm1BYNNgvew=;
  b=Zg4cSiPoMawA8wZU2hsTMpzld0MGz7Uu4SDyTcjLpX9o8spfELPy7hDy
   8NgyyhCvNN/as6tZZZrGXV+hYmVZgMNzOoBo6n6TcVaKULlBYYuIM4SDt
   XDo15ogVjMKfakNA/D5whdTeNCeRjCIxWoDA7nh0W8TDb96n/JiZCfNHp
   oBrCQ7qaVkkjkWzuEIaoLDiNVFe6+zU8winBNFjgypfFeM0KjPzD8iWic
   E3NeCH3tcUYJRVxbvFYwF0PUpdq9GP+x5zhWO8bE0n5FtgXjJ6PIoDe0x
   1YqnElz3GDgMXoS3AzxOUdVbnvQUFl66qthVQR0zZ635Gq1X5GOIbnfDE
   w==;
IronPort-SDR: oMaZSwk73jVgtOWYpcf6/N+A7e+zFAi9J390C/e8+GHv5uUkOJXrQdYLgg0NsQ/vSR6W3ZAqFu
 AnWIdcIZ6LmiiTnPS/arX0gXLyD97pTzfmQOz/hwLfucA5kguhvmxzrBw6n2ullM7rBWeOTVBL
 889yZXwsloy6ZGa5R03zv+Gur0ZMgM5THT3w6OJpZGwC6fYYMD4nm2rieIoPBAtSb8RiwAA+M8
 cZRkVxKP2jF71OA7u5WJ4WZc8Ned3FslsPrRoL/wz6YhaIGV2PRr+xW1i7v/7MChMQe7YB1fRv
 SNM=
X-IronPort-AV: E=Sophos;i="5.73,522,1583164800"; 
   d="scan'208";a="140210010"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2020 17:50:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHJ5fo9ZiaccpfzMTrpFnhsx38CZqQM3coJ+toKTlw2R5huZ1xBWttg/1PwnG382prar/dPXr/6StmTGqbju68r2IeZRaXH3zBk9j6atK4yCEspw0yVAM7YTqdyyEnen8BshF6usLAhs2+E24V7K6Am2BayrYBjXRFjrZhZmvu2K8AVfc7cUI4IjoDbS25pi9T+G2UZ/7TJY6gwBtdlfcmOhbkGG+DElQQjgtT6e3E3fmsJY/UUp9yBLR7VieX2xqw6DmBjTVEU1vwgk5x+LVYg6FGtLdh6hdaytWYNTdeb/UAPyUra67w9T7Qjbroz/OaO3+x41sagiaJxWhWm9EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3Ldu728ta5uL24jTASHGH2RXkGQMZC5XvKKQm8JeBM=;
 b=jYTNZFV8fnu8sOWrjTt4ZYylJV+Bp/qiy5x7Um3SEx7Pg9n3ojSCJ/02jpPMNC4SRIk4SBt3wP/WNszWU0wkaNvEgXDW3Zg7MW0mG1LPVFUW2PpGhVaV0R+3pB09fryFK3PZFeT62UvQ37yciO17lTjyo5rukHrweuNvpuoTI8VILI3n1GwUXavi/LLdvKqU6HLoG7KhCgl48DSK96kwtR95KllKIfZah6voSqf5SWjj9c3vE24T3GVDZLXm6LKrBizvPiORt9eUswyRMMIHcDM8l5qxzZV/Q+cg/kV+WbDEhyKtU5Pnk7Yh8GW1G6vQLDGel2RHUzi3++10fkyEFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3Ldu728ta5uL24jTASHGH2RXkGQMZC5XvKKQm8JeBM=;
 b=KCQ+eU+FXnH/OwJnXLC2jtW8ezwRB2R4/HjTCRjeiZBPC7Ho3jfseNAMq9rR71jFE/aoKYBQxDgvgdW7PDggEPJGmZeL/38vMHepdA01I9YLcZi58iv1qj6X1Db/HyAe3e64xCzEunOoWzkGroxeLIhTbCf6jk5L0oBufOs+qv0=
Received: from BYAPR04MB5112.namprd04.prod.outlook.com (2603:10b6:a03:45::10)
 by BYAPR04MB5942.namprd04.prod.outlook.com (2603:10b6:a03:110::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 17 Jun
 2020 09:50:19 +0000
Received: from BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b]) by BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b%6]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 09:50:19 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch <Keith.Busch@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 3/5] nvme: implement I/O Command Sets Command Set support
Thread-Topic: [PATCH 3/5] nvme: implement I/O Command Sets Command Set support
Thread-Index: AQHWQ22jQiOvuxhpcESNmwORkrTj76jbZ1M0gAARZ4CAARnTgA==
Date:   Wed, 17 Jun 2020 09:50:19 +0000
Message-ID: <20200617095017.GA539436@localhost.localdomain>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-4-keith.busch@wdc.com>
 <yq1ftavm29u.fsf@ca-mkp.ca.oracle.com>
 <20200616170135.GC521206@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20200616170135.GC521206@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.224.200.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a3367ce6-8850-46d1-70c3-08d812a3d8a2
x-ms-traffictypediagnostic: BYAPR04MB5942:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5942FC59F0F715F0358621F6F29A0@BYAPR04MB5942.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O+7mR0FHGVnCc+Edlx0m7FZfvPPQoBr3a9722hMQH2Q64vYldrOvSO1kKcgr29gQn4TB11LTds6CjGNMDVV1WipghggA+Jq7XXFi1XDzQzVsrC6Bwx5i6hKrraVmd6JIJyvZTRQC92zjGjWciS1qklWoutjtmSPnsMlbd8TNJPVhKXZalvLTNWTHRwovqj8p+J+gcJQ/iBnxOcPdPkSNiUy3XmhjHcnzeEhTe6N76ScoEF03MPdM1ZjCi44SVvdNYTSlDqMD2ndYeHb5O0g9TXPToF++2m8QXMiyuvPmyj37e/aNXGMjhwF/jaWBh3lstcihrg6iETGtomjY1ps6Zw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB5112.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(8936002)(186003)(5660300002)(86362001)(71200400001)(2906002)(6506007)(26005)(33656002)(83380400001)(8676002)(4326008)(6916009)(1076003)(478600001)(316002)(6512007)(9686003)(66556008)(66946007)(66476007)(64756008)(91956017)(66446008)(76116006)(54906003)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: iJchm2I9cqbXuHwe3EeuKiaSMPNDk9cFoJRFjy+pOuQHDx4BY4OK5hGK6xWTRYM+3MbJ86MalyZtDcCmoeivdVpRyQ5jcPQCxdshlftZNtznqhRwjkimDSK/lQhR8I7ZHaMOh0gsKikoldjROA/ooCbVhZL6ImWBI/cpXoYGxh+y5/y4mtiX0iWGTvUSV1/Y7k5XQvVMRTI+pYHq8mQ06JTXYip4Zts58d45Kg2+BHMEO6p3X+kH2/mFQdNmoZJ2/kfRCAziIXpl2dKBndUgMu89DvuqGAN0dHcQUKgUYo/+eEqM1puuyTOuuZmYfpluI4CfNytf03osX67/oUGAWhIOHtee0fR9Ldjcx1n7thOTEycTy0Wt9pabv1IFQqE/g2EHrMbk55O5Twc4tely0unzLbGF9fQHgGWQ09MrPeJGWKb2aqjrJo/zM/QvBKx1/UaLEcRTiwzh5kz1w9IjY8ofuDaTMElHWQGTvcLd+ktSLzLIZUzURbgvX30ilKAF
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C9058668F145054282449AB0F4FFFBC2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3367ce6-8850-46d1-70c3-08d812a3d8a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 09:50:19.4232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ANxJqbtn0GPHeodiDCpbxxh9BYGvlTylW8lp/u2DwcgnfwTFnWFIopAw1tmhm/ZuQXujbWHNfCV+TCUCPZHnZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5942
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 16, 2020 at 10:01:35AM -0700, Keith Busch wrote:
> On Tue, Jun 16, 2020 at 11:58:59AM -0400, Martin K. Petersen wrote:
> > > @@ -1113,8 +1126,9 @@ static int nvme_identify_ns_descs(struct nvme_c=
trl *ctrl, unsigned nsid,
> > >  	status =3D nvme_submit_sync_cmd(ctrl->admin_q, &c, data,
> > >  				      NVME_IDENTIFY_DATA_SIZE);
> > >  	if (status) {
> > > -		dev_warn(ctrl->device,
> > > -			"Identify Descriptors failed (%d)\n", status);
> > > +		if (ctrl->vs >=3D NVME_VS(1, 3, 0))
> > > +			dev_warn(ctrl->device,
> > > +				"Identify Descriptors failed (%d)\n", status);
> >=20
> > Not a biggie but maybe this should be a separate patch?
>=20
> Actually I think we can just get rid of this check before the warning.
> We only call this function if the version is >=3D 1.3 or if multi-css was
> selected. Both of those require this identification be supported.

I agree, since implementing/supporting multiple command sets also requires
you to implement the Namespace Identification Descriptor list command,
this command shouldn't fail even if a base spec < 1.3.0 was used,
so the best thing is probably just to drop this change.


Kind regards,
Niklas=
