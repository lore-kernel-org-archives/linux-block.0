Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAF4C4708F
	for <linux-block@archiver.kernel.org>; Wed,  2 Jun 2021 12:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22934613D7
	for <linux-block@archiver.kernel.org>; Wed,  2 Jun 2021 12:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhFBMzA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jun 2021 08:55:00 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:44297 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhFBMzA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jun 2021 08:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622638396; x=1654174396;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=rk5l15pXsg1cf8V92DaJpo1LWwRVPI7K8FD2mFqOqzY=;
  b=VccH4ey8FDPuZbzg8b8nyHZA0DY95EVPLE42KfgqHnuAlrOGRuiKqN1K
   FP1QX9roTo8NFYIXKyQSi5yZOk1clm/JaOdmqNGY30w6nuGhkjdP/fZm1
   i2H47q+vZU4Rlf8EZzGzOVLYOGq/TutCAKUrEl8v2BaPsdCYSar0m0rC1
   bdCbmDpWCNUmPXUcrcU6Ix2j2La+WDLNkfuXId75FeuqbDHaoTG/caB7p
   NgmMrVhbFapn3FulmykkIbvJtl90q+f9HHkyezX5GM36PpCTowDVmrtwL
   cxI2XBUZ0gUtM40DkOT9VmDrN3NYeRhwwZBsgaJKJBwgCJYzklEnXLhhl
   A==;
IronPort-SDR: dbQORegygKUy8Zf6yNU6ePG1hVwKID9HoU4ypHnvcTSDowfX6OmjNS7oQxYv29tUY6iWr147Rb
 HMn+OdC5DEDUbO2wAvWLkMvEsBL7W8p9/oPqpuG9qUNBIzziLv1DNZX0sTUnu3G/oG+kkf1dtf
 eIsdzFqBvejcwBCuCakC1kOpyQi/b/kNkTqt3PpYgYp6Xa7chfkgF1giMeS74IfdB6HcdIyxE7
 UMep6yiZdFEUX8joZjMqS5/LEddyv1/OeOlJWkERUH1lXVXf8NapRnBCDnl4Kj/zwemQ8ONuKI
 FIU=
X-IronPort-AV: E=Sophos;i="5.83,242,1616428800"; 
   d="scan'208";a="175151928"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2021 20:53:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAq9xhD7r7SfeaE7Ib9AwnOv+4dF14iUAMx+hDrZII9TWK7SeRuOyJCVX5tSK3CCrcXmHbp7oWwReYXzWDEX1c1F3R6x40RqIacUFvFp1vy7Vj5PflOObQ3x6UIOPQZyKx/B8bPoW0jd5Q1Yfr77l0VJ16ILtRysXKz3gnL0ITx9YNDoWcpexg14G9gHOb3klNvwbfvD+W2+fVC/aQeoaeHA93APa/LQ0tF9/i2kIrcFDa77hSi1pkppVr3QpImrwi7K5ws9uaegshT7EZPbFX7ZbFKcuC7UcgSQ2pDmbgqmtYJAtH/TynLIEbQR/aU07Eqe6ojkyb6ocvvVjZq7sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7svqxpMd+EOkEWWF5ZKUJ67uKzp+Cj7OiAT3Flwx92o=;
 b=T6/rRFD+YpsWM2Srhv5t8VKET/pyN4j07Ec62SmKyHnHYPwimMcIIHrKetiMpKQ6cuAjjcyaXdk44TprD0sB3OReMvfPPvwri2dcbyykCs6xXH4bNYdSmZ/TDLkaiUcAKAtXgi6Va4JR+T4ZdGofs8EG7ezi5/I/WwGkEqWc9BCqxXQdjICFCGf1XOvK9l2yOnv0xV3/tY3mMXtKBw8EPwVHvmaDYc0ysb2E5VQ1A9K4Bs/cXtOEmfYlvSyOZt8ZmCuXG6Jc3UZx9MgrAM5pI/FhwqNpANYcNrluQ4p9qEEl84g5gAAI1wcv0O5a0WEIh63GL4W1FF62F22aIAi/0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7svqxpMd+EOkEWWF5ZKUJ67uKzp+Cj7OiAT3Flwx92o=;
 b=u+CO1E9BPHXpJKJaD+QigpHoNYpPwuc8CdiasNBIO/FbY4U++UUjwk/claFOLog/lAb2crlcHPycAhFjSOM0gpRBNGkXyhQ532LahlR2KAXKrUjzCVhQ+LlXDEB3URHMrOtNMatl9dyAgWWngxKQA5na6Ol7ny4ycKRc6x/Uork=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB3884.namprd04.prod.outlook.com (2603:10b6:5:b7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.27; Wed, 2 Jun
 2021 12:53:11 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 12:53:11 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Changheun Lee <nanich.lee@samsung.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "alex_y_xu@yahoo.ca" <alex_y_xu@yahoo.ca>,
        "asml.silence@gmail.com" <asml.silence@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "bgoncalv@redhat.com" <bgoncalv@redhat.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "patchwork-bot@kernel.org" <patchwork-bot@kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>
CC:     "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>,
        "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
        "mj0123.lee@samsung.com" <mj0123.lee@samsung.com>,
        "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
        "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
        "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>,
        "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>
Subject: Re: [PATCH v11 3/3] scsi: set max_bio_bytes with queue max sectors
Thread-Topic: [PATCH v11 3/3] scsi: set max_bio_bytes with queue max sectors
Thread-Index: AQHXV6r0LoEZlz08ZEum8DPleuIEgw==
Date:   Wed, 2 Jun 2021 12:53:11 +0000
Message-ID: <DM6PR04MB7081BDEC7ECFB63D3E6345D0E73D9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210602121037.11083-1-nanich.lee@samsung.com>
 <CGME20210602122912epcas1p4faff714cc9457b0d482fc1a4b63a49a9@epcas1p4.samsung.com>
 <20210602121037.11083-4-nanich.lee@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:8d7b:9386:76d5:60d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3cad6a67-4850-469d-44eb-08d925c560cc
x-ms-traffictypediagnostic: DM6PR04MB3884:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB3884AD1415EC02CDC939497DE73D9@DM6PR04MB3884.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IIHy5kmNjAOM4cUYFvx4rniTLIP/Qj/kBSaPk88vPcMXPOux/OY3WIZL/CJBUdlj6uFbhFmlBxU1kFOAgMH+RKofsm8kA7X9fWAdF3+V2NguW0OGAtxvR7ltjZf3wSoMICZu6wyeDhczpI9mY9d4q+31otJigYgPi3s9X6cW+Pq2L0nYT0TVVmrrUbwYK1cbMzT/S5GYJIwKwqn4udkI87l0IuJb4arTh1svHMS0DjVUHSuTDAFlPYTy5uFnyzZ6y/dfoyMw/uCN6f96IO3r2Fz6voObwbuKBIACtoYOThtJLYbSoUt6fWUn2Q0AVDPPXtTD6KHr+pIwRg03lcMgZrswVSz4BTpFyeVDTfGQ6jn2l1QCfmc8agKjfbcWpcOCKXjDmSqbswBGRe34AM7tCYAsqSV0KRGFm+MdVDjQsU18zVmK13LAxAQk51dgWf54BxBwu1sxfAw49DKv2BAbMKaSijSohNFxQYPvFdRVjQUjFnFRU+UVqxV81pBjhiG82jMJUcUcKD2I6h8IXwwXMcdUrYCptOsQbD0XlT67GSeHvq5ZEYmobQK8YbqMO8ACAs5xyKx1f0iwMOOVXwWZfaPcbiVlKb1kMZY5gmgr/JT29rx3SAG/cyO6B2aNRsBdGN6tAnMVyIjQhkC2AxoMOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(7696005)(8936002)(64756008)(5660300002)(316002)(55016002)(71200400001)(76116006)(83380400001)(53546011)(478600001)(8676002)(54906003)(110136005)(4326008)(921005)(86362001)(122000001)(66476007)(186003)(66556008)(2906002)(66946007)(66446008)(91956017)(52536014)(7416002)(9686003)(33656002)(38100700002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XhqHkSOIm/G6vZCFFSDKOqTpP6c/NhIAWEBtxXsl7qD4JLNFHIwdTb1D3UXu?=
 =?us-ascii?Q?4X62xt7RCoD5BZvwq0SFvnJ/RK1isZI4QOk4eOFv2/3fjvlKNX3RJ8Jr9tOG?=
 =?us-ascii?Q?B1wkUx/hDimvEKtTANjDZXJXNT9U32hdMXyE9l7bQa8zX3FyY9hh6ibjRQ2x?=
 =?us-ascii?Q?hiQlJiBo6qZHLxYDFLESE4MlTJmL7jSnVjSlzyGmSE8Hhk4AODwYWk10SGPN?=
 =?us-ascii?Q?fki6BBjkMMiKfeBsMUyhuXfrBR1UYvY6JpNFmMbd8UQCmveMLevRJuRXzMa8?=
 =?us-ascii?Q?Q3GXgVEqJpZPapXrA0zPBhkWgk+Kje7z0HoZu+vB5UUQxWiZrN1643BreQ/G?=
 =?us-ascii?Q?b1krPuc2anD+X3ar9e1sh227AGBDlNKsVSGfQfT1YHgPiClVhIf6zHXfe/I4?=
 =?us-ascii?Q?uUauYUQg5/H1s1GdU6rV02wWRzF/itijQ6epJg4JXUwhBD3GsEgW6YUL65Bq?=
 =?us-ascii?Q?ee0J6yhSsmgaEbS6oThUhqeaksGALHSKKKt6+QngJMxnDxa2lJWcXqSd5nxM?=
 =?us-ascii?Q?3oWGBZcD1JAQZdI1Jcd3mnBZWDbgC1AXxKbYljBwBc8Y2bbsygAEuDk9KfIS?=
 =?us-ascii?Q?mXmRun1bppkzXhNqWDfAdEpcOtrenGsiUyxOpJJIICvMXG3/QwMaNaYu47t+?=
 =?us-ascii?Q?mYwGb6COmEbMWZeBb5Ug+NzHZD3Ot8FWSHy0UWHbzFBfSiPK4UUkbvaQApiM?=
 =?us-ascii?Q?OmxUKVbqGa1eP+PdFoaTVmUouheO0mv0W+4NoaCHm8Zq1qWgGRq2wvDsug5Y?=
 =?us-ascii?Q?TH4y8Z0ItE3jcSauqqTKHqyC6Sb3RppFvv3yy9e1RErkCkgmBcpS/OlMmkfe?=
 =?us-ascii?Q?jjMxEQevCLY2n+ZX21L+BUqTKE8gFdCPFO1IZlXgjKZGqq3UuPgPjrKBX66T?=
 =?us-ascii?Q?052o+ehKZ4PmgA15aYovmyW0b9GkoW+kfd5O5SqGIqVvDvzS7CziLBE/LV8+?=
 =?us-ascii?Q?g4ESpwkm7tkLYu695cbaJFjJxZ1KwJ6CE1ffh4nlNYvUbNS5SnESJ5oa5tfh?=
 =?us-ascii?Q?yObnJrZF+EcgHWQD/8EuzHMu3MK9HujeUUC14eKNji4rHnkUrohtnqF3PKI2?=
 =?us-ascii?Q?Ui7Ez3imU3sXeelVEU1hqwemxbAKRRw8AzWycHOrPLR/FpwEjr1tf32RwoYh?=
 =?us-ascii?Q?OMP7OjRyxX1HaPfFqISVZoDeXgJfV+aGF6jZlNpcCLwgb71pbJRPh61bDmRL?=
 =?us-ascii?Q?xUNaQZ4WZaO2RWS6jBHAOrrGchCXu+XvFz1J+Y7uOmGejMAB6qbR3f+iOpSj?=
 =?us-ascii?Q?tHJFTgwv8MmaLSJLW0vvFk6XctUMvXtgntZAvVMkPTa52JfBfC+lghIyfbkY?=
 =?us-ascii?Q?ktnVFmTYnhLjec9oJmsPUAwBFhe3RaYIGEWZ9TttyoSWG88nmq9B3CQfGHJK?=
 =?us-ascii?Q?orI9DD8waOsuImcL2BFLuqgjBmr28CMMgND7x5PifcmzvtwiBg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cad6a67-4850-469d-44eb-08d925c560cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2021 12:53:11.1763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1W3YLmQ1Yot6tg74JpfvK6mQT1kzq6/JBzrRgWr+eBoknE/9mpVNrRXvpDWhZ3PYXOnjIMx+9T4o0hLIox6APA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB3884
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/06/02 21:29, Changheun Lee wrote:=0A=
> Set max_bio_bytes same with queue max sectors. It will lead to fast bio=
=0A=
> submit when bio size is over than queue max sectors. And it might be help=
ful=0A=
> to align submit bio size in some case.=0A=
> =0A=
> Signed-off-by: Changheun Lee <nanich.lee@samsung.com>=0A=
> ---=0A=
>  drivers/scsi/scsi_lib.c | 2 ++=0A=
>  1 file changed, 2 insertions(+)=0A=
> =0A=
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c=0A=
> index 532304d42f00..f6269268b0e0 100644=0A=
> --- a/drivers/scsi/scsi_lib.c=0A=
> +++ b/drivers/scsi/scsi_lib.c=0A=
> @@ -1837,6 +1837,8 @@ void __scsi_init_queue(struct Scsi_Host *shost, str=
uct request_queue *q)=0A=
>  	blk_queue_virt_boundary(q, shost->virt_boundary_mask);=0A=
>  	dma_set_max_seg_size(dev, queue_max_segment_size(q));=0A=
>  =0A=
> +	blk_queue_max_bio_bytes(q, queue_max_sectors(q));=0A=
=0A=
Doing this unconditionally for all scsi block devices is probably not a goo=
d=0A=
idea. Cannot this be moved to the LLD handling the devices that actually ne=
ed it ?=0A=
=0A=
> +=0A=
>  	/*=0A=
>  	 * Set a reasonable default alignment:  The larger of 32-byte (dword),=
=0A=
>  	 * which is a common minimum for HBAs, and the minimum DMA alignment,=
=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
