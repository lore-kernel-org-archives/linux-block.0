Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E13EC433E0
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 00:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C192075D
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 00:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bhQpHvO6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pZW3R2AU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgFZAEq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 20:04:46 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:17713 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgFZAEp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 20:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593129926; x=1624665926;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Sqq34wXvJR81h7HZh69nOO/PXeYzUmNfTybrXo32of4=;
  b=bhQpHvO6qSx2gwX4SZRMOs2KctUo5+V0C0BcFj+rEgRFJT2fB6jheit3
   ly0fXtsF8VIkGZmGQ5TQCrlTEL4D4o8ui50bY/L5MV8GhotEpOF4tBO5Z
   YNHPGT2e0VGFOcKJqs1R1RvFjxa+LfZfIJ1KnBHleoVp9AnBvh/FAruYL
   xJ+zJeB7w+VViyZc7qFAmQHzo38ofv0fBEH3sI4bgt2WM1eQdlEDL92pO
   RHJRu77ZFzODw3IyMqy1DlghMbW2BazpUXOvMDxATNbt6Dpc+Z2VF5nps
   1xIDc/h0tQG8QKFYb5/QR/Y+knO2BJSAUG0MgVKqu4Jj6tza/CoFGiPud
   g==;
IronPort-SDR: M7x9uyriq4jMRaH7od8iZedEcnI3OSbbrF0rQORieZM+oh4r4+b9V1fZVm1F5IMq1DBB6ZzR/K
 sn2NoNjz0K/OxuOYFsCFuhx8tC7+3bAwqnH6+ZI6th8PFSxkvllUhh+8S03zFcAF7rfmDmzQ2q
 KfZoxk+LrWTp8L7doWxEnztcSWXMbJyKXv5iGWI7gBgo95DpHiuRXMdJdDrEJma8bLAOSnmMNB
 dTXDwQnb5R+CYLLRntj4xuls6KRWUfgwqBx7y6WaRycs57hCt21M4aKke/a9YZZutp0dtk6ykX
 fNw=
X-IronPort-AV: E=Sophos;i="5.75,281,1589212800"; 
   d="scan'208";a="243968610"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 08:05:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hidECiji9z2bM3EZCjfXN2PEpGjSxQLh3dJm7gkgIT4ENRch65bR5fUy+4pBrjMd6Thzgi3V+Vw9rBHGPoyvKOkD/IZIUAf/4+n6a//6xz4Agug13I4n+GOedVRZsuX5ozfK9oUyxrEwz0i4Hfe2aeYvVVJ25PJUEyBFj2KNXwOE+SJCyJrzmEeZADQU2ZYhmJnnaZHMoPBbDlsfBtsqhCADgYShtku/VkalXbAqWtSGXuLa8Yjjvf42hyzknjXiyuGo7Ex5ZTQRf8nQZ9iUJGpX3IA5WqGAb/ODPBpF321FMsgyIzzfC20HgHg7ZsrLzjtZYOX2u267Tvj6g5iDQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03ZuOA6ZlODxP8cZns6CmVCAA+EXV7Nqdwa/traGYlM=;
 b=ggxEPkeFAPUdieb41jsCPpm7IgefHgjkLjuHZWBmUB1BfOURpyLtOx1TqBCMpJuEXI/h4CVIEEayyowFSYOe8a1bmOsLELpOmRej9HhUCasTNSBrpnbpdBG96hh03oSskOmyuizAzUl1dNJ8UcVgK1JaPIU/emwDmkQBN9swmstb/o0wN0JINHqdWoTL47f5oEX/W2eFT9ADN4osjPbgEYmfTUWUkqOs2exjcqC/ILiH9tZec+1MAb4m1I1S+yP3qcYB+GYR535bQmXBnQrIIk1jQYJzX0xaV6ipEfvKw0p6Tdis9HLCQbU5Rp60GSwgYs5kxP9Vz00mlrNL6wp0+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03ZuOA6ZlODxP8cZns6CmVCAA+EXV7Nqdwa/traGYlM=;
 b=pZW3R2AUeBt4O58Wnvf5v8Xz3oMvgZIx/SWTz2iZASQRGCuEww4DnZ9/QcpaB/vezbt4J6a8VQ+6l0EX8e3NpwpkE71a/WJdbIiV3c9YYkxm3cX7sPyyA+WdQ2uisw14gvia6pzcr13ZjeVfqK0SaUadBw0jEvZaF0aTCwrRKoA=
Received: from MWHPR04MB3758.namprd04.prod.outlook.com (2603:10b6:300:fb::8)
 by MWHPR04MB1135.namprd04.prod.outlook.com (2603:10b6:300:77::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Fri, 26 Jun
 2020 00:04:42 +0000
Received: from MWHPR04MB3758.namprd04.prod.outlook.com
 ([fe80::1177:cc76:4553:479d]) by MWHPR04MB3758.namprd04.prod.outlook.com
 ([fe80::1177:cc76:4553:479d%8]) with mapi id 15.20.3131.021; Fri, 26 Jun 2020
 00:04:42 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Keith Busch <kbusch@kernel.org>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 6/6] nvme: Add consistency check for zone count
Thread-Topic: [PATCH 6/6] nvme: Add consistency check for zone count
Thread-Index: AQHWSutTIAjD46n2JES6Jp1duZEotg==
Date:   Fri, 26 Jun 2020 00:04:42 +0000
Message-ID: <MWHPR04MB3758829D20916B73DDB5581EE7930@MWHPR04MB3758.namprd04.prod.outlook.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-7-javier@javigon.com>
 <20200625214921.GA1773527@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2273a0f1-7ddd-4cd4-c101-08d8196486e3
x-ms-traffictypediagnostic: MWHPR04MB1135:
x-microsoft-antispam-prvs: <MWHPR04MB11355E946683CCCF5C47D0BBE7930@MWHPR04MB1135.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z69hoxZ0GClpZZwJfs0Wiz5sHvZcTMSwjAMlDahd5i6DrxuO9XFXop39L50d6dOFNGaXeXq1gwRpzXNFFlLJQU/vLnrdYHXDtF5JCtPPp65ul5xKffC1AYRvtrx3yEWTEgABiCMzniSMbt+3P3O3jLgZw2QTRNFNI737IkwOQnrNP3RwPPAHjo2CP9t4oCvIpfMN98K6kf511wuljDorpkf8PDMJZkck6TD3SzA8BAaePKeDa6HACm9l3K2eNHrQQYRrRDjJCDTjf7JcM+FN7Qmyy9IiLxqlSfmYtO7yarL3mNbBBM9kDqlqNMlPMrTaOXW39aebOjHEwMskLHrTSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR04MB3758.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(26005)(8936002)(33656002)(66946007)(316002)(110136005)(54906003)(52536014)(5660300002)(64756008)(66556008)(66476007)(76116006)(91956017)(66446008)(4326008)(71200400001)(6506007)(55016002)(83380400001)(7416002)(86362001)(478600001)(186003)(8676002)(2906002)(9686003)(7696005)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: FX9syFmEDkIIQ6IJJptadaB/PHVXq/++96m7mGrK+U3XpnzkpQlCAgfi0Td56yEbPlwbzD9wr7cbsSHKYbo47teIr28yfEsKvuE613+ciq7ThT1/uBaH9CXsFE4CXeZhOmkFmYratvaFNBd4Gvacdnd+7ShGxEBK2w4zwLt7jQgJ9IhttBFZhkRpDRteNTjhKoKHnkhEJI5sUzRNkkoapjPnFiyQsog2v8I3pvN1siHlV7DpftKb+zE/7k2OHOe7dZVEi4/3Kb3TTWN5mHBOr32cZ64joXAC2LZWaLRZ+A3TrVDl8Nl2mEEYXVOA9F4yOI9kBLb89ZUbkt2B6UaFj+J6lqxwrbb8GyEmDxlBOO8PKFpV9jzWEfHmQlpD53X/he3f7q6iDylctuaGLxO82+envKm16dUQhEA3DR9hHD4IXuRggrpGeEzWMFvbBQcVm5B5S5fMSv/5XVoTBBPhT+HdKHSkAkzau0D3EBugo7nAcZe+3ueBDm+ZCtAzIi2j
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR04MB3758.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2273a0f1-7ddd-4cd4-c101-08d8196486e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 00:04:42.2312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nTmA69JWXlDhraMLh4lpGT177nC4UFp+XSfWVaDQuhlhwbYfn1uFgSKe+ZgGxYzyFPNh9aVDAUFNIksUP29tRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1135
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/26 6:49, Keith Busch wrote:=0A=
> On Thu, Jun 25, 2020 at 02:21:52PM +0200, Javier Gonz=E1lez wrote:=0A=
>>  drivers/nvme/host/zns.c | 7 +++++++=0A=
>>  1 file changed, 7 insertions(+)=0A=
>>=0A=
>> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c=0A=
>> index 7d8381fe7665..de806788a184 100644=0A=
>> --- a/drivers/nvme/host/zns.c=0A=
>> +++ b/drivers/nvme/host/zns.c=0A=
>> @@ -234,6 +234,13 @@ static int nvme_ns_report_zones(struct nvme_ns *ns,=
 sector_t sector,=0A=
>>  		sector +=3D ns->zsze * nz;=0A=
>>  	}=0A=
>>  =0A=
>> +	if (nr_zones < 0 && zone_idx !=3D ns->nr_zones) {=0A=
>> +		dev_err(ns->ctrl->device, "inconsistent zone count %u/%u\n",=0A=
>> +				zone_idx, ns->nr_zones);=0A=
>> +		ret =3D -EINVAL;=0A=
>> +		goto out_free;=0A=
>> +	}=0A=
>> +=0A=
>>  	ret =3D zone_idx;=0A=
> =0A=
> nr_zones is unsigned, so it's never < 0.=0A=
> =0A=
> The API we're providing doesn't require zone_idx equal the namespace's=0A=
> nr_zones at the end, though. A subset of the total number of zones can=0A=
> be requested here.=0A=
> =0A=
=0A=
Yes, absolutely. zone_idx is not an absolute zone number. It is the index o=
f the=0A=
reported zone descriptor in the current report range requested by the user,=
=0A=
which is not necessarily for the entire drive (i.e., provided nr zones is l=
ess=0A=
than the total number of zones of the disk and/or start sector is > 0). So=
=0A=
zone_idx indicates the actual number of zones reported, it is not the total=
=0A=
number of zones of the drive.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
