Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA38C433ED
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 11:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFD9B61425
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 11:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhDWLhZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Apr 2021 07:37:25 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:36808 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbhDWLhY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Apr 2021 07:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619177806; x=1650713806;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=xnoTUoY3id3GnalsDObj/uLrBHySt240ti7m69noBX4=;
  b=cDkpTppkwf3JNniewJdpd7Z2a8EoAb7doYdRzBqFh/4f/RlChy31kIvM
   0KKdbph617Rm6ZhCpM+0OoAd0sHtSD+mBfv7Vnb3WMEQSc+oNSo62fbLh
   dF2Ty4cvy0NX+/Sq0alc0Kyioh3TpZ+51FQVPqiYWMdWYwXTIfVdoazYz
   6j77SDtyFGt4wigdqYAVmpgomJ4dnWmD3na0eaSHLVJgUzDEPcoiRIN/E
   umO4CVGIZ+OzS6/IBfvIYd+iTTUVbfW+AEUc1oWa3HkG7P4Ne8BHTEr89
   oq9GseX7EdnclkF7Un41EsA7xtIRghc2AnA+5Kug06uq4IzpldOKW4BIl
   g==;
IronPort-SDR: 78SL++A2mlZf8upMwhcrXnQ4ONmR9lJvn8lJ+kI5Dk7cl9fFfC/VykY1DRWS26TlAzVr9cErEj
 y1SN7s3ZaT1fFVPoJKY0BnN1WEBuj7mR3BV6JHc0+VACHjeqW0UYTBI++Fz3m+iB8lkka0YMlK
 eEwsAIpRUk5P8XiMui+3yoHyFggXqlRjVqUeWSaApiM9gKN5l4THd5IA9/JdOKg+v97Q/ctcjd
 yTLT2N+BxjO6y2iecg443kVXK44Enkqo2Ohp/FKYE2ASRPvnTTwIBEahzNVo3D7Scp4dGBQTkF
 Ty0=
X-IronPort-AV: E=Sophos;i="5.82,245,1613404800"; 
   d="scan'208";a="170574205"
Received: from mail-cys01nam02lp2051.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.51])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2021 19:36:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxeoFBOISHlLG4Tj9JU8984hQC+ELZb33bYWth29x07IbBwIlWiP1k4Anlq6AzmAL2qeLmGxKKdLe9M41/iVVWHlRHGYMWgVoIGIljVmvT1rH4R/omocudhCJ8bOrFO1xloeXenelD0wjlwNlhJlxf669xu/ys9ToUtheqQztrGTmDHAcUKJp2+fM/IUDFl5h8RHc9v3WdE0Y0EK0weVbv9JVVuRp90IbSfCjgk6KASX99y9EjWzj2DW9gtOyX21pIS9UsAFGAhaMR9OBT2flEq13uONfcFZgV0wvr2X3U+A/bBchm4XbvvpUC7K7PpGw4oNNZTIVpmlVNT7mMwItQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aur33bAOLxAoM903KD4Owsf7uVu3WPkiCPMCpdcKgls=;
 b=ANwNg6rFNoKB1BIm2C8HnjcutkNQ/prj9c68+nOzQ4ch4DqOxwW5zJtM6V+RFIvG1wlPwhfL0BsYH+kfn3m54/F8zhIyWZGfy3eYadNAQOFVVx0EyBzZ0CfeP+ylxMqK9Mkow9AtjulCkeO6YuMr9/WqDhFgofRFusD5waNeeBrSVM/PpjfwWR+3kmEftm2I5lY2SsC9+ekPTPBdOXZpEleV6WjcrCdF3OI55LeYUa069CJeJNUi04fE3B7Pjlymuv3bJxnCYqsZaDmmflzV8iNURFYqMKnrFvqAWxqzKoZ2VfcO0ubYd1q3MZ5NnPEnpHzOlCyeaR+Jg2PMKr9eeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aur33bAOLxAoM903KD4Owsf7uVu3WPkiCPMCpdcKgls=;
 b=FaoN00lzFhlnqVN7wE9SRVRQdEwAWNheuvb+qsrO3pQMDSkn2nfXxXDBGcxTaAMKNSQPrzXlwam92AtMxu3Qb3xlQlgBiPi/km7PSDV3INwRMOCSr3saoIytv99FS+8NYYgz1CHGdiHNe3Ilp9ZX92k/KvBLbc9l1TPi7NXJnqY=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4740.namprd04.prod.outlook.com (2603:10b6:208:43::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Fri, 23 Apr
 2021 11:36:44 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78%3]) with mapi id 15.20.4065.023; Fri, 23 Apr 2021
 11:36:44 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Changheun Lee <nanich.lee@samsung.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "asml.silence@gmail.com" <asml.silence@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "patchwork-bot@kernel.org" <patchwork-bot@kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>
CC:     "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>,
        "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
        "mj0123.lee@samsung.com" <mj0123.lee@samsung.com>,
        "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
        "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
        "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>,
        "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>
Subject: Re: [PATCH v8] bio: limit bio max size
Thread-Topic: [PATCH v8] bio: limit bio max size
Thread-Index: AQHXNpXqF7AsXoOwSUG6kQu0CPLJbw==
Date:   Fri, 23 Apr 2021 11:36:44 +0000
Message-ID: <BL0PR04MB65143E72BE89BD60334E994AE7459@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <CGME20210421100544epcas1p13c2c86e84102f0955dd591f72e45756a@epcas1p1.samsung.com>
 <20210421094745.29660-1-nanich.lee@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:d5c5:972e:46c9:492]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6484402a-4767-4ead-447d-08d9064c127d
x-ms-traffictypediagnostic: BL0PR04MB4740:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB4740796EB82B9519D0DAE8D2E7459@BL0PR04MB4740.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MRURFSmVDVJPWxnHCVhgMr2FPTdOHgZ7DGioPfWuPe7gAEq1lRZUhFANfuFnKgp0TiTRKBrzrsXFh0tyWtFt866QD4+fb2QNV/nYD+Vtsb7C7yLhmumJePB1mVS2BtXFqBLZpPmWO9MBzigIgY8yeWQDCykIKI6Z4pNF5gdRivpTEu6U761N9Abm+I41iuEb5voG/BhqjvHczNuuTDhUSL1gR3LbMr6VLQZGF24nfwXI/ur9qQbW/1a722wfclbOtMhsgFjGVn4wbpj92VnxXF6RgI+HUCJbhyvyrBRg7nsYWxT9M/qLcFFcP9981o4vylDvDgzfFwzyZfZC1C3RvI8QqJNTBW9WrRp9BfQKXWUwQnPrVYGjisHAGWczME+MqTB5FFBl8RN3zaX/uJZ04uUtLuudaU6UxrcN6GC2khzEwWlIaaakNPBwjrBQ5dkU10mCoZ658mdY4jWXdMYV7TGvO4nnFcgR53ySlJcWL9W3EgENTmxDF3ver0KL9WDe5CbFf1Dlu9gUplw2HZ3lvxFxlnzO0T+gFjmKf6xb4CkLPTlMVLIOTtMVasNcohYH5+KMPRHr7kk+bGuQyk3JQWNO5EahSSt8gLSh1KhvYmL4LpiCzWjZq63R2k/VPb0hf8Loxy7lvwYt0rFmHkfUOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(38100700002)(33656002)(55016002)(5660300002)(71200400001)(7416002)(9686003)(83380400001)(122000001)(921005)(86362001)(91956017)(66946007)(7696005)(316002)(76116006)(8676002)(52536014)(66556008)(2906002)(66476007)(8936002)(6506007)(4326008)(110136005)(66446008)(186003)(54906003)(478600001)(53546011)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rfojwVwwQrQF3XxjP5+BeGPdKqw3xWEDEklBRlRZMojpDv8oQnlBRSmZqj5J?=
 =?us-ascii?Q?IUKVyGVZG6eFRa2Fppgyo943F1Z9/0uOK5IGBY00Yk84uuYHyBREKECc/nLx?=
 =?us-ascii?Q?JRgH/JJ5FA7Nw0a/Wdx99NNLjF5n6IpTzLE66xhz9ORRdFao1cQU21bN9oyZ?=
 =?us-ascii?Q?+hdc/amCCCxEQlV6+CiK29CZq3Tx/FMp0Whrr+LimEFbYXAGB3+blLcWtcDE?=
 =?us-ascii?Q?644C1x0Xq7UIdTKmRhPweqJoiDKt5sp9gZ+jnExunPYStK9bZmFfp3D10Foy?=
 =?us-ascii?Q?O2QISaauR8RjvP1eGg9b0b8sT4C8KpF2Ed9iP5x4Rb6jREChENBODCCiR4F+?=
 =?us-ascii?Q?vQyT8GrbYxpRU9E2cVhFqv12GETjrYenQjzUb4+UGjdDt5xeKM08lc6hU+hV?=
 =?us-ascii?Q?fVICoi3eUi24JOgh6Haz3/EasR05zAzRfa6XCaLvBwKYQKopshklPPwxzO94?=
 =?us-ascii?Q?g/T2EaLuYDnQz2JgvBH3/gg2SHvF3/O+oCWxMzQnbVsRq+e7TpEQdxWonXa7?=
 =?us-ascii?Q?DWJcYdTrWNf5XpZw59iCGiiskqN7kNoxr76T1BE4/9DdzsLZL7nKBctOa+80?=
 =?us-ascii?Q?zQieM89UxzA3O1rI/gWP65YSkxIlen2A7tNuO7Gwl/tD09459uSD6pzX4KHm?=
 =?us-ascii?Q?qwSoG14tbDGDFeM1B4qRpDxeXtz7IW2EdwB9EG5/fE2DJverinj/w9Dvham6?=
 =?us-ascii?Q?G6cII5c+eWAdefgM9VxKdOw6XZJgs09EjvMInaUzwVdWVzkEnv6w9QvHDTxV?=
 =?us-ascii?Q?1nHwD60KUTdmFVD8zV4CAtrxgRI+rXlnwPMasW7qA5qEU6r9bOT8SFXEN8Ib?=
 =?us-ascii?Q?oXj3pTcNDdLuQ/GvGXMH2F9ufaDcs5g+saQ0MKec02XSVYCfy5B6zAKqhaZv?=
 =?us-ascii?Q?WBXA2fU7Cv81CA8ZimY0AQlB7UOXMpp1GJvK8WRbFz5n0LwU5xxaj6DQLapW?=
 =?us-ascii?Q?ajToH+NpnT7GSEyU0M7r9UUczbmBJgyw5LeEWIZUPt5SeIc1Au3ytEH0f0Nv?=
 =?us-ascii?Q?W9MJad3Hh/lZGYG0mfOgUGWv71SouyrrDUsvbC+yO2W+IiomdyVaGUljREJd?=
 =?us-ascii?Q?KTnTyo1syka8YaS4DCt1RHEEC/gfa9rdCib+DnsS13sNSOkq5sjM773tBwNu?=
 =?us-ascii?Q?j/4/uuqSrKPV8om3YUYCD1Tw6n3pPjZ3J2ze2PeZtEAuTZOfzULEKwr1y/qT?=
 =?us-ascii?Q?C5o3fI0zim87sAkw4bOPjBGCIGs0ZemPiIcOceWt+tKeoENGYCR3gHBm4dUF?=
 =?us-ascii?Q?cY9XJzQ4g1utzasmZ67o/MqR6cOfcBW/3Q+oHc9wFiTkgrsv59Sijwa7DJvU?=
 =?us-ascii?Q?ZFw1uW9b9bUJTiARx/yLN4qgLNxQQMfV3m4FwfBOUfn7pgNTO6Dg0NnB/7tT?=
 =?us-ascii?Q?zm5GyVB2OsXst+lqDZrDkCBp9iIvB/2CTWb2QTYfFyEcK5gO4Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6484402a-4767-4ead-447d-08d9064c127d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 11:36:44.5822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LLiR5yXUwMHX2b/5fjP5MDF8LC39NBD7K/4joy2h2bzIHAr3bGsnvTAf2HTq/0sk2i1Q+tr75Khk7Uw7xQZN2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4740
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/04/21 19:05, Changheun Lee wrote:=0A=
> bio size can grow up to 4GB when muli-page bvec is enabled.=0A=
> but sometimes it would lead to inefficient behaviors.=0A=
> in case of large chunk direct I/O, - 32MB chunk read in user space -=0A=
> all pages for 32MB would be merged to a bio structure if the pages=0A=
> physical addresses are contiguous. it makes some delay to submit=0A=
> until merge complete. bio max size should be limited to a proper size.=0A=
=0A=
And what is the "proper size" ? You should be specific here and mention=0A=
max_sectors or max_hw_sectors.=0A=
=0A=
> =0A=
> When 32MB chunk read with direct I/O option is coming from userspace,=0A=
> kernel behavior is below now in do_direct_IO() loop. it's timeline.=0A=
> =0A=
>  | bio merge for 32MB. total 8,192 pages are merged.=0A=
>  | total elapsed time is over 2ms.=0A=
>  |------------------ ... ----------------------->|=0A=
>                                                  | 8,192 pages merged a b=
io.=0A=
>                                                  | at this time, first bi=
o submit is done.=0A=
>                                                  | 1 bio is split to 32 r=
ead request and issue.=0A=
>                                                  |--------------->=0A=
>                                                   |--------------->=0A=
>                                                    |--------------->=0A=
>                                                               ......=0A=
>                                                                    |-----=
---------->=0A=
>                                                                     |----=
----------->|=0A=
>                           total 19ms elapsed to complete 32MB read done f=
rom device. |=0A=
> =0A=
> If bio max size is limited with 1MB, behavior is changed below.=0A=
> =0A=
>  | bio merge for 1MB. 256 pages are merged for each bio.=0A=
>  | total 32 bio will be made.=0A=
>  | total elapsed time is over 2ms. it's same.=0A=
>  | but, first bio submit timing is fast. about 100us.=0A=
>  |--->|--->|--->|---> ... -->|--->|--->|--->|--->|=0A=
>       | 256 pages merged a bio.=0A=
>       | at this time, first bio submit is done.=0A=
>       | and 1 read request is issued for 1 bio.=0A=
>       |--------------->=0A=
>            |--------------->=0A=
>                 |--------------->=0A=
>                                       ......=0A=
>                                                  |--------------->=0A=
>                                                   |--------------->|=0A=
>         total 17ms elapsed to complete 32MB read done from device. |=0A=
> =0A=
> As a result, read request issue timing is faster if bio max size is limit=
ed.=0A=
> Current kernel behavior with multipage bvec, super large bio can be creat=
ed.=0A=
> And it lead to delay first I/O request issue.=0A=
=0A=
The above message describes the problem very well, but there is no explanat=
ion=0A=
of the solution implemented. So one cannot check if the implementation matc=
hes=0A=
the intent. Please add a description of the solution, more detailed than ju=
st=0A=
saying "limit bio size".=0A=
=0A=
> =0A=
> Signed-off-by: Changheun Lee <nanich.lee@samsung.com>=0A=
> ---=0A=
>  block/bio.c            | 9 ++++++++-=0A=
>  block/blk-settings.c   | 5 +++++=0A=
>  include/linux/bio.h    | 4 +++-=0A=
>  include/linux/blkdev.h | 2 ++=0A=
>  4 files changed, 18 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/block/bio.c b/block/bio.c=0A=
> index 50e579088aca..9e5061ecc317 100644=0A=
> --- a/block/bio.c=0A=
> +++ b/block/bio.c=0A=
> @@ -255,6 +255,13 @@ void bio_init(struct bio *bio, struct bio_vec *table=
,=0A=
>  }=0A=
>  EXPORT_SYMBOL(bio_init);=0A=
>  =0A=
> +unsigned int bio_max_size(struct bio *bio)=0A=
> +{=0A=
> +	struct request_queue *q =3D bio->bi_bdev->bd_disk->queue;=0A=
> +=0A=
> +	return q->limits.bio_max_bytes;=0A=
> +}=0A=
> +=0A=
>  /**=0A=
>   * bio_reset - reinitialize a bio=0A=
>   * @bio:	bio to reset=0A=
> @@ -866,7 +873,7 @@ bool __bio_try_merge_page(struct bio *bio, struct pag=
e *page,=0A=
>  		struct bio_vec *bv =3D &bio->bi_io_vec[bio->bi_vcnt - 1];=0A=
>  =0A=
>  		if (page_is_mergeable(bv, page, len, off, same_page)) {=0A=
> -			if (bio->bi_iter.bi_size > UINT_MAX - len) {=0A=
> +			if (bio->bi_iter.bi_size > bio_max_size(bio) - len) {=0A=
>  				*same_page =3D false;=0A=
>  				return false;=0A=
>  			}=0A=
> diff --git a/block/blk-settings.c b/block/blk-settings.c=0A=
> index b4aa2f37fab6..cd3dcb5afe50 100644=0A=
> --- a/block/blk-settings.c=0A=
> +++ b/block/blk-settings.c=0A=
> @@ -37,6 +37,7 @@ EXPORT_SYMBOL_GPL(blk_queue_rq_timeout);=0A=
>   */=0A=
>  void blk_set_default_limits(struct queue_limits *lim)=0A=
>  {=0A=
> +	lim->bio_max_bytes =3D UINT_MAX;=0A=
>  	lim->max_segments =3D BLK_MAX_SEGMENTS;=0A=
>  	lim->max_discard_segments =3D 1;=0A=
>  	lim->max_integrity_segments =3D 0;=0A=
> @@ -168,6 +169,10 @@ void blk_queue_max_hw_sectors(struct request_queue *=
q, unsigned int max_hw_secto=0A=
>  				 limits->logical_block_size >> SECTOR_SHIFT);=0A=
>  	limits->max_sectors =3D max_sectors;=0A=
>  =0A=
> +	if (check_shl_overflow(max_sectors, SECTOR_SHIFT,=0A=
> +				&limits->bio_max_bytes))=0A=
> +		limits->bio_max_bytes =3D UINT_MAX;=0A=
=0A=
	limits->bio_max_bytes =3D min_t(sector_t,=0A=
			(sector_t)max_sectors << SECTOR_SHIFT, UINT_MAX);=0A=
=0A=
is easier to understand in my opinion.=0A=
=0A=
> +=0A=
>  	q->backing_dev_info->io_pages =3D max_sectors >> (PAGE_SHIFT - 9);=0A=
>  }=0A=
>  EXPORT_SYMBOL(blk_queue_max_hw_sectors);=0A=
> diff --git a/include/linux/bio.h b/include/linux/bio.h=0A=
> index d0246c92a6e8..e5add63da3af 100644=0A=
> --- a/include/linux/bio.h=0A=
> +++ b/include/linux/bio.h=0A=
> @@ -106,6 +106,8 @@ static inline void *bio_data(struct bio *bio)=0A=
>  	return NULL;=0A=
>  }=0A=
>  =0A=
> +extern unsigned int bio_max_size(struct bio *bio);=0A=
=0A=
No need for extern.=0A=
=0A=
> +=0A=
>  /**=0A=
>   * bio_full - check if the bio is full=0A=
>   * @bio:	bio to check=0A=
> @@ -119,7 +121,7 @@ static inline bool bio_full(struct bio *bio, unsigned=
 len)=0A=
>  	if (bio->bi_vcnt >=3D bio->bi_max_vecs)=0A=
>  		return true;=0A=
>  =0A=
> -	if (bio->bi_iter.bi_size > UINT_MAX - len)=0A=
> +	if (bio->bi_iter.bi_size > bio_max_size(bio) - len)=0A=
>  		return true;=0A=
>  =0A=
>  	return false;=0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index 158aefae1030..c205d60ac611 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -312,6 +312,8 @@ enum blk_zoned_model {=0A=
>  };=0A=
>  =0A=
>  struct queue_limits {=0A=
> +	unsigned int		bio_max_bytes;=0A=
=0A=
Please move this below in the structure together with all other fields that=
 are=0A=
unsigned int too.=0A=
=0A=
> +=0A=
>  	unsigned long		bounce_pfn;=0A=
>  	unsigned long		seg_boundary_mask;=0A=
>  	unsigned long		virt_boundary_mask;=0A=
> =0A=
=0A=
As far as I can tell, bio_max_bytes is UINT_MAX by default, becomes equal t=
o=0A=
max_hw_sectors when that limit is set by a driver and cannot take any other=
=0A=
value. So why introduce this new limit at all ? Why not use max_hw_sectors=
=0A=
directly as a bio size limit ?=0A=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
