Return-Path: <SRS0=vyV1=AD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373A0C433E1
	for <linux-block@archiver.kernel.org>; Mon, 22 Jun 2020 16:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1305D2075A
	for <linux-block@archiver.kernel.org>; Mon, 22 Jun 2020 16:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QDvXvjlf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="U7mfHXMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbgFVQsO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:48:14 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:58903 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729492AbgFVQsL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jun 2020 12:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592844490; x=1624380490;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=f36As1wtGxtI05AwHlUtiNRWVyZoHMrz6RHJrtweLCc=;
  b=QDvXvjlfQNkU8xVHU3u7RTzH9QXAXHzFOmFtuc5QIKC+9QPbsHgcFh78
   v+nxW431aiVkKd75UurlDPzd/rXdDp75XEVB3TdP1Eg1cnxM3cZReBz90
   1B3RRyYDzSyrLkVnSEzJVPX5ql+43817AjeuB4ieoZoR4i3Of8kH3PMjB
   MxEVcBjRFJjCAhDPmokaMzB4LK/mXq/m9EzxP/h9qs2qKhoZQnLvLWR35
   UQCWViVP0Jil4E1NGoZDUkTMKIxkT5HBrNxm/ZswnE/kibUpTtF66ky9Y
   jD3jqoV5aZ66LaSjwgijCgHhAZqxjHbf+b2acnd+RRhLJGrrgNJPqMmea
   Q==;
IronPort-SDR: Xyl3+4h1HToykfMKNHELX6bj5V2BlITKgPs/tggkPyYCgFjsvw9AbKJTUx/Pmd4j68KRvDcYeo
 qx0fzNB456mRweOvSqi23p6Qb0LE+ugSfyZr6RPtCdoBlK+7xVOReyj1jy1z653mDzogbXlg+k
 JOHwyfzeUFITbieETnXpU2SWwo701AZMjxx4vtEtghXivIuwQHIprdIS8ZYX9j/MAiILUJF56p
 cq1CcMdJ/VjgOT424Zb/6TOlE5pqCohRlS11w/kXEdqPQ6jChve1KcwsWk8bvX/iCPe9eubRMm
 bdw=
X-IronPort-AV: E=Sophos;i="5.75,268,1589212800"; 
   d="scan'208";a="140623049"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2020 00:48:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkA5hzJz8lhBgh8CuSYzNPU+CewD0HKyRZnFDuqiIObymx2pyCjqqtzfrxSzfz3nE/cp07zDmuHV8qw/1amSK5UKY4WGhfofeAW7B963Gf0rHGJ7gbckWxoxXJGjcjsUP9MSzFFl8Uo6UqDpGiE8wBzextU/zY2JTnIDioGrBDQcRR8+r2TdJcwLbt2GO6oeUEghZaNgFZXf2hBA3n4nKP3huMnR64DqUwZh9xJL5Eqq7rBqp3H5U7Yz1Fsw5/zwIsRQef6/om9X8ej/48A5dSpWr06YxVTzJ3dnW6oWtPGyauWxDFTg9wJPCBBinEZWI5t72hOqQegAygbUhoTfHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBCOjXWSWHHfPA9t76KT+jggOJofhPOYee5e6ZslRhg=;
 b=Ju7ItjlVMEtjyXEPS8NQKhUvnGQ77i3/n/SJmUPnH1uRaQP+qEhcw4+4R/aJuctS9CL0eNbn3yDNwBfFoe+q0sWm3ko2nICHu1Q+NiliR8nGWonmb3P3MdzDKoQrEvFfY7GU6wOsQYo7lWO+CE8pSiPxr1I0osxZBauakvQb8pupevY11Va8uQ+ihA9S411S91bt2YK6hLgtlx2wnrrlijtDdf9Tu8ljN06vO2l/zCsXspuXV4AGqPOK+v4MKwOUDu172qGfc7ZnKkVAS1ou375L0+hAXk/GcTFZoMhMWf2I69WTKwwfKfeTWRhWJdRb2RaJp5SUR9FKCJ5FzEet5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBCOjXWSWHHfPA9t76KT+jggOJofhPOYee5e6ZslRhg=;
 b=U7mfHXMCvSWunZmGfgMfTXrBdPQ0rmV/pa+c/KthsRZS2coXZTTqoY2aYUyEWJ2Nu3p7rbfONP1OBQy5K98ZY5c50xOfF4xPa0eTrN6a92LiCWhxe2QuBzPqVCfIVWMeIYdhY1/vh2aBLMdsFvkDM4VhAYDKQF0kkFhT2ReZzxw=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4541.namprd04.prod.outlook.com
 (2603:10b6:805:a8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Mon, 22 Jun
 2020 16:48:07 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 16:48:07 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Keith Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     Keith Busch <Keith.Busch@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCHv3 5/5] nvme: support for zoned namespaces
Thread-Topic: [PATCHv3 5/5] nvme: support for zoned namespaces
Thread-Index: AQHWSLHIJgF9UbkqjUq8YxPc9nylHA==
Date:   Mon, 22 Jun 2020 16:48:07 +0000
Message-ID: <SN4PR0401MB3598FCE2EED54F51902754779B970@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-6-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1597:de01:50b:1cf3:953b:431c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f652f7a2-7ce2-4856-92f7-08d816cc0a78
x-ms-traffictypediagnostic: SN6PR04MB4541:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB45418CF0134B65ECE906B43E9B970@SN6PR04MB4541.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0442E569BC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f/fgujWX+nBNYucwfe13lZLqWwRLBjkgFG3fPJBkYEGDycJDyknTtRG7N53VE7JMWApguwX0+wlt2XpiVaDVH9eKE+uOL9/kYG2Q8z0O24v3kevcLylmbQCmVI5y6U/HKhV+WAxikCaSQlahQqF0WzccpIIfpEhLU7YvJkYnwYcuAZNshGggKlfyOLfZkaZlUa07Z2Pui+kQ3vNZFbCtpv1WaODYqwJ/2+ZFaB2QipcJs9OhJj/qOOMs4kUEZiRGQUELQd3fhpHypIQbz5TX4vM+MOAzYMVbgAvMAAvltNcbTUE62aCYY/6qE0UdhBt1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(83380400001)(7696005)(66946007)(186003)(8676002)(4326008)(8936002)(33656002)(6506007)(53546011)(86362001)(9686003)(5660300002)(55016002)(54906003)(91956017)(76116006)(52536014)(110136005)(64756008)(2906002)(66476007)(66556008)(66446008)(478600001)(316002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: WrRZZMVNNiBxQKzDxYgXOx3ReRi/YshNiZJTnkEci+Q2b6B52666xtrKx5bgQef4Eoez/T0y3PFw2bLCcQOvuSg+Y3K6hFZSPB7F4BEuoSVeAwlxR1aeJJsFxdf7jsJgGB2dSHbgdjGddXz+PbSb1kspsQlGLu++8mUOKCwLiDdSwzxLNmUD1la+b9zxdjceWLSbIyuCsckQhKwjasAseqD1ufkdFa4QyybdRmDJDuqcmlQ48PSVWV3ZgAiub6ELlhtGEUADSiDJyK8uBFOMjN7HvHtcZkwLwi/Mdu+9x75Ta/q1Ufa9BTt5q/MFyeiS/SUreVpomIR3sJg6QDvdxgGFoHA9Ix4eKXf9hPTWLHjkj7dRyb5C6zS2ncO4er848pHAaFmn6ktvILhkF9vjYQrxvhI94mIK3PwSVyIC+cHX/dThJdEZbOdtFBmZorhugWGxsjk9OkMUlJi3w83I9F+gcFKWeFQLDJQ9Xlqaf6EQUS5Tg75MdbCC0+BtZU7ZPNPi6snwm3uMvWTs8nCuU8536OfYGCay7EQFh76U5cm2WkXnef99IrvMd13+MnWw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f652f7a2-7ce2-4856-92f7-08d816cc0a78
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2020 16:48:07.5942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pXV00rsOVDRVUnfy9CVPZGgPAPohUNRy2NQHNhHXKEAISpnMOGeNKDSgtcFy/SzN4blo9nOBtywrI5Lx8hcRKzNe3zZkXj4rRFI4CEjkUng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4541
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 22/06/2020 18:25, Keith Busch wrote:=0A=
[...]=0A=
> +static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,=0A=
> +					  unsigned int nr_zones, size_t *buflen)=0A=
> +{=0A=
> +	struct request_queue *q =3D ns->disk->queue;=0A=
> +	size_t bufsize;=0A=
> +	void *buf;=0A=
> +=0A=
> +	const size_t min_bufsize =3D sizeof(struct nvme_zone_report) +=0A=
> +				   sizeof(struct nvme_zone_descriptor);=0A=
> +=0A=
> +	nr_zones =3D min_t(unsigned int, nr_zones,=0A=
> +			 get_capacity(ns->disk) >> ilog2(ns->zsze));=0A=
> +=0A=
> +	bufsize =3D sizeof(struct nvme_zone_report) +=0A=
> +		nr_zones * sizeof(struct nvme_zone_descriptor);=0A=
> +	bufsize =3D min_t(size_t, bufsize,=0A=
> +			queue_max_hw_sectors(q) << SECTOR_SHIFT);=0A=
> +	bufsize =3D min_t(size_t, bufsize, queue_max_segments(q) << PAGE_SHIFT)=
;=0A=
> +=0A=
> +	while (bufsize >=3D min_bufsize) {=0A=
> +		buf =3D __vmalloc(bufsize,=0A=
> +				GFP_KERNEL | __GFP_ZERO | __GFP_NORETRY);=0A=
=0A=
=0A=
Nit: The __GFP_ZERO flag isn't needed as nvme_ns_report_zones() =0A=
calls memset() on the report buffer before submitting it.=0A=
=0A=
[...]=0A=
=0A=
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h=0A=
> index 95cd03e240a1..d862e5d70818 100644=0A=
> --- a/include/linux/nvme.h=0A=
> +++ b/include/linux/nvme.h=0A=
> @@ -1,6 +1,7 @@=0A=
>  /* SPDX-License-Identifier: GPL-2.0 */=0A=
>  /*=0A=
> - * Definitions for the NVM Express interface=0A=
> + * Definitions for the NVM Ex=0A=
> + * ress interface=0A=
Accidental line break.=0A=
=0A=
Otherwise:=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
