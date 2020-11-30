Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FF8C3E8C5
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 00:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF76220757
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 00:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BZ6XPqpk";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KQEkDLkh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgK3ATa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Nov 2020 19:19:30 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:24662 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbgK3AT3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Nov 2020 19:19:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606695568; x=1638231568;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=gdFKOEyT+nZWrFxKFqdCr4mHIIMhRtFSD7eBS+30HYQ=;
  b=BZ6XPqpkP21BfBjs2uOG245S60y0R7OTLtUo2QmoaxZSzvqXF/QMWhl9
   E5+BuRLttWOyEU/QOeza3hl6XV8Avr3mEnzB5/whM8sc1vh1Erk7XXp6k
   1HA3ad2Bla+dMnidwkJHvI6hkEvwC2gIRtegreH3XD/9t7+16wi/LHdej
   jGaHVArtCPquJzQhUQ+PefhPbEhnimCC0FEIdi1fiW6y18S9QY4a5LE4Y
   FzpG2C41jB6/vxN0b0QkcgRLkg4gXS25blrj9dEWQQJLlfpgUMY66tTLB
   y8ZqiUvoXewI2gt3cKCcOzOwlIO0LWvQtYrI+/b04Mf8M5nxUIIR8jX2O
   A==;
IronPort-SDR: 4eF/Hg3uuKxsuJV06UwVfs5c3iJ3AXSXc2LDanZth8Z8z23xc60DbxgS0kEgqpshS99/XYv+kd
 v7+eblShoGqG1rPS9Bgsf1HcQTgrh+ee/+x6X4oFeI4Wer69t0KPw8wWVzbPTXgu7PVaufqBPD
 MOZfRkgXWOqJxlG64NwGKMNt4rBM4dGIF7YOPHFPOyF5JR6R7dHd0jRJJaNyvev/K4fNZtBWlv
 pI4oQ48V9bHCF083WwJJENz5SQhocKv2kDm/aQ0CkRJ3Q9gNb7KU3lTS1nM/TjGbRXQ2rMUtId
 3mk=
X-IronPort-AV: E=Sophos;i="5.78,379,1599494400"; 
   d="scan'208";a="158231755"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 08:18:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3Ed1XXswnaGY0iuoNChRpycN+lMNCSIshAEMZdLA/RMOM2jyge0DF2YEsVrtmIt7diQvWKqbJeaEFx14IBeveAg5dPpO5tsIMt6yBAqaZ3rSWcf6tdeyAnTcW9YW7QBIFs3nG/7Ztyq+jnJrxbkTevbEdHmR1GJkyNjoVOUuKTzO8UDLzkBDaRVzHgn1CXfUGyXhyvRQvXDGn/3BBf1PDQ+nZjyTGFpdr2EsvriB6vAnuJme9vxe97ALSDEFrTh/tAN+tX1dPP5JNW/fzP+Y6YYf64nz99mgjdc70PhtnLEItlasZAUz/jgjDBeMtsvx9FMJ7bdeDi5NrC5XNfZtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4/IA6yDWwQQsK2x0sIVufi8IDCQEhr69WkZ1p4ySPY=;
 b=hssd37Xy6MVS1uOfffDsbVuZEEhA5MYcUl83+X/bvGsoCk8AuLgcbp9dMy7S5r41ffLtodly16muN2lU+3HZhcHTau1uT/NT29lMd5WlpP30uGBB/VxYjacwmjGPYyugfdB70iMTHsO/gv7i2vRt4T1OsL1BaXvNhujIgE8WmSEXrEZh+DjI33IxdLhNSR0bkVUiF3BSuCuckQlVFOIRZSRcnO12UnTgnvwRa87GGzACEnKyyuBZKaVSaFj9x7SHE4WZK/4WQqcTyRh4PdBIF9rlW9S/3CVr5AjDBFU0niMMn4F5RTE/lmT3nmMgInbDPb7hE/emQLfm/T74qvpuRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4/IA6yDWwQQsK2x0sIVufi8IDCQEhr69WkZ1p4ySPY=;
 b=KQEkDLkh73SkqPAXnJOvwfW7H+qMZZkMBl0+wrjyzfBM6yvua8sRdS1DQ0tYV+n0WnN+UjZYUyR01r3DYZ7nXBDDDPCt3u0Of+9zRiP35CEpA7BtWLASpdIGc+xUOLX67UIrx8qb7MVvHPMIB+4OvJK7Cx3AjzPMLyOHTtBpA64=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6949.namprd04.prod.outlook.com (2603:10b6:610:97::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.21; Mon, 30 Nov
 2020 00:18:22 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Mon, 30 Nov 2020
 00:18:22 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 2/9] nvmet: add ZNS support for bdev-ns
Thread-Topic: [PATCH 2/9] nvmet: add ZNS support for bdev-ns
Thread-Index: AQHWw53W//+mWSEaQk2ZMnl01vomXw==
Date:   Mon, 30 Nov 2020 00:18:21 +0000
Message-ID: <CH2PR04MB652265309D7C6395773CF44AE7F50@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
 <20201126024043.3392-3-chaitanya.kulkarni@wdc.com>
 <CH2PR04MB652267A218F1EAD32E2DC8BAE7F90@CH2PR04MB6522.namprd04.prod.outlook.com>
 <BYAPR04MB496572575C9B29E682B0C25286F70@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:3811:272:f33b:9d56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 76be8ab4-febc-43f4-4858-08d894c5724e
x-ms-traffictypediagnostic: CH2PR04MB6949:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB6949ED358F50FF2C1CA5197AE7F50@CH2PR04MB6949.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bK3/WlrFUMHWqBq334uNlbbujwZUEQqxMz9dZNSOCxF54zYid0I5iCYOglyq5X1xSq2dzHjEVZKsyYVg0PiYdC4wMiZEbFl3tH6LmIr5T2LZPaci7ztMSN1lQvKW4LApforxJg5ktpga6UvGKAOx2OhRVLXWwMy7ck+A6zVw+ZPGaEol6PKPt4JGtKllAeJFg/24zA4mzd2f8ugVw4IAS7jxj8rSW2snTDhXWB1+iat5GhrQOO3rm1Al4Cy4XHugmvdJUSUIV26h59gQLy5Ir210xcFnxLL49DNxEhZSa4g5VpNYNsm2E7YcpfVZMrwZy8GMzWvlfrvZcmsfyiDcDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(33656002)(6506007)(53546011)(54906003)(186003)(4326008)(76116006)(91956017)(110136005)(9686003)(316002)(86362001)(2906002)(7696005)(8676002)(8936002)(55016002)(71200400001)(66946007)(478600001)(66476007)(5660300002)(66446008)(66556008)(64756008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gnjtm7qc+Fcj8IrhfgOAaSiDyp6pUoVP9yJQTZw5kFc7/AbVXQi8pOfW+rif?=
 =?us-ascii?Q?z9OZOwJpngjYdl9Pq0T63DpeZ358OkqxoJ2lt+wXXZlHHfAl5ekakiXcRE9/?=
 =?us-ascii?Q?G7SQACIYLZMYVi/hLQuzn8tQmoi01jZ/CtZ/c0XkUed2cmfpPs3+PYzhySDX?=
 =?us-ascii?Q?xbdXqwj5VacmyM/qt6v+7sPuenfdETZpUucGet+ImSPww3K9sHFM4MYi80ap?=
 =?us-ascii?Q?DaMrwP19tPVrbHG8CZ2ozEvLh3IT0U68KihMvaAnAs1xphQ0rXDvLnaJwCSQ?=
 =?us-ascii?Q?Mp5J4m3tx0jV4sTNrvrTcr1lgDS8T3Elum0R80lwMRN3F3zbRVIUDfWOTqzV?=
 =?us-ascii?Q?cdMuHDvR+u7AiO3GGG0ounAqqdRy7ybAB4KxHMie8vG9v29Hum/gMlxB9nnv?=
 =?us-ascii?Q?0e7w41CxCCiixdcb+mLwuEkcecGUOCFQBU6kM4DO+/6tjQdgADBEGL0Qgkr8?=
 =?us-ascii?Q?c4q4NXncNYCJAiGH3QaGk+9NQm63K/l0ddibukaX+00/9ZTM5D+vAR0JwbU8?=
 =?us-ascii?Q?r+tc1ZZxJiYlg6fdUyDoQkauHYU1WQ7/r0uFXW21daPFJbUXmJkhMnvd8LQ4?=
 =?us-ascii?Q?luS/cZOqUnuWD3btD2NmY9acRFfbxiLTLfCeIR1CMU4FtmAaBRDPDHQ7ok54?=
 =?us-ascii?Q?DGTFakZ4GBbno3i4721VEBMvR6gmpOcqFiCoz+S1bvScrfLPr00yvplaGpSQ?=
 =?us-ascii?Q?EA6ZjRu6A6ds66Z20taWvGhCh25P3vLzWFY7k5TQkNAO/YiUnLI6Bg1VpECv?=
 =?us-ascii?Q?wn0L0rCaOQHhHYCOdSL2e/VnC9gPlSuNBuA4H/ZX8u61W5txmGLPXz3RyPAX?=
 =?us-ascii?Q?hqcK+Oh2BdfEln83gAQUNTNJgsB49TdeDFLrCww9dUKujvXRC8ByxT6oIv8d?=
 =?us-ascii?Q?K+zVaeV7s+ZAXhd9dpqMvdyod07IkvISyn/q5OQlTOWkptsJAP//hhbkcVZJ?=
 =?us-ascii?Q?x3AF7m30wyH1N7y39kv+2QRAiXGP4KTvQyQyiJ3PEVYFj8wCiKy0uv77oWor?=
 =?us-ascii?Q?jVJXAbXdYXeUYmYzVQJVDw0qZls3q39u5J9b7u0K2xaVbt4GNF0L7f0P4aEq?=
 =?us-ascii?Q?SNsbqlEv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76be8ab4-febc-43f4-4858-08d894c5724e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 00:18:21.9240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 241iyjMx0rlYOCiNj3tR11fVQ7Jcj87zHk3B1Gx191TWQYqMP8Jfs5AmrO2JAbW3whV9C5oMh5hOTPr6En+G5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6949
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/11/28 9:11, Chaitanya Kulkarni wrote:=0A=
> On 11/26/20 01:06, Damien Le Moal wrote:=0A=
>>> +=0A=
>>> +	desc_size =3D nvmet_zones_to_descsize(blk_queue_nr_zones(q));=0A=
>>> +	status =3D nvmet_bdev_zns_checks(req);=0A=
>>> +	if (status)=0A=
>>> +		goto out;=0A=
>>> +=0A=
>>> +	zones =3D kvcalloc(blkdev_nr_zones(nvmet_bdev(req)->bd_disk),=0A=
>>> +			      sizeof(struct blk_zone), GFP_KERNEL);=0A=
>>> +	if (!zones) {=0A=
>>> +		status =3D NVME_SC_INTERNAL;=0A=
>>> +		goto out;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	rz =3D __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);=0A=
>>> +	if (!rz) {=0A=
>>> +		status =3D NVME_SC_INTERNAL;=0A=
>>> +		goto out_free_zones;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	sect =3D nvmet_lba_to_sect(req->ns, le64_to_cpu(req->cmd->zmr.slba));=
=0A=
>>> +=0A=
>>> +	for (nz =3D blk_queue_nr_zones(q); desc_size >=3D bufsize; nz--)=0A=
>>> +		desc_size =3D nvmet_zones_to_descsize(nz);=0A=
>> desc_size is actually not used anywhere to do something. So what is the =
purpose=0A=
>> of this ? If only to determine nz, the number of zones that can be repor=
ted,=0A=
>> surely you can calculate it instead of using this loop.=0A=
>>=0A=
> It reads nicely. Let me see if I can get rid of the loop without having t=
o=0A=
> add complex calculations.=0A=
=0A=
I do not think it reads nicely at all: it makes what is being "calculated" =
hard=0A=
to understand. And that definitely looks to me like a waste of CPU cycles=
=0A=
compared to a real calculation.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
