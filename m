Return-Path: <SRS0=H7KM=7Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA4FC433E0
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 01:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64581206FA
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 01:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KVkgTf93";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SnVDpHRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgFKBxL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jun 2020 21:53:11 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:52130 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgFKBxK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jun 2020 21:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591840390; x=1623376390;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PBVGmCAS87s/B2Av5zQpx7M52b6/bvJ/yTlX3m6JnbI=;
  b=KVkgTf93BvKQMqQdPPKOpze3te01m6ahuBaPXg24BFdRKuB/73AbHx0a
   qL/5AmQ+O63G6S4/bzwOBFK29slPhLs8f6z46Mb1NFJQX5yqdWqY1ROhg
   Iv0uIdkY5giRjsif/s+EDEhSYFgFmC4isECVCsYSsTF/50aqfGPI9vFBy
   WfP4x2IW3IcR+aSyf+IKZiUlVd6JH/zfMRJJCzEuHavKHU2XowtKClvJa
   y4b9b2PW5d2u2ZMxlZgqyhE8YbvE7X0yILWAy0VrSMKgX4S0Xj1FDmA5/
   55ZJO9Kbw86CJrP6q9dowZXEpDAw9Hdjro+u7Mf4bCdS8wfviiQ11Ft1t
   g==;
IronPort-SDR: 1wjlCAFPtM9bP9vbLZG8nJUZUnLGq0sFrg5pO0N9midYf7DRnIH/IYYdskFZ7q019/KcUDrBZ3
 AyGfYkW56IGcN4YF6xdiF49R7TAOvJsGJr3+pwOnoiTyuBCTEkjCRqPlqUXKwQ1zMWaktLpiww
 qgjDUSYIX/DDoEjTrTMMMTeLt8khrfzB+Hs0qcVyJz/iAYVCt320kFRPDXvOhEz4Lk5UMzxgVi
 rOC5j2cjcjFF+cFM4nk53U795sU10W5x8dm7tynCBpSQtjm9Ptd8oVAHvUEHpaPKqC10WW9KYe
 cn0=
X-IronPort-AV: E=Sophos;i="5.73,498,1583164800"; 
   d="scan'208";a="144013691"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2020 09:53:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZtgLZ6bwj6R1wPRrLb/t4lgfEy2sUb2ybdBkbnWPdiFs/v+ho2ZJLD1uni8v4HJiMce11ZwvfjmF8cN9GQiP07cpdWpWaHIrh9k1b6HQIcNWEon2jX3C7jB99xCv2nmlFA5pM1/GWHUQ7jX3UxOUGS9BGeDB7ovyVN+SyWd/EMw1ZdBa7AtMRgsw/s4bVSgxpwIvyAtYB4Acqb+1jsIM9Y2OQ0L4nDSF0kGHG+NpC0rpjziWNmyLeIvsJM5AtikkkohA6Ylf1x1J48X7m2hwMGJicZUm+5CdjhrYV9oCKsfVJXT0QD/byLOg8VWnYcuR/Is9EKqCElQU7yRojHuHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mk3fmKp6Ye4Xi+ksKXbp0FVG988g61HDqudHbzsv8Sk=;
 b=cPHuhPledD6+OBARqhe2YUbwShwo8Ic9R4EL9SfV/doj18clcg7+sGPbxkNoemlY/a818IJlKp78GPAi6//ylhsn22ykl5spO8MVps9v9BcKtcrTwBoZC5erQhJW33wu+ZGWcAiKILwzUtQqAw9vg2VPOFQL4dVjuMs4s/Kr32IOw03bgTQl1g+9pBioFJNzCGmrpYutHOZMGIrHReE+ztrtnOiXFZewtIX5bnY1P+tw5wOfvcM4mo4M2WVkIgIQaKIWXfpyorZ09A9LeWR1dc8Ypvb/1OpEhZU7HtIGvcWvaVJHpHXUKynqEsU+RdKAk1V33qmTVEw3iUqg95tg1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mk3fmKp6Ye4Xi+ksKXbp0FVG988g61HDqudHbzsv8Sk=;
 b=SnVDpHRvwl/oUT4m1+fLcYTA4j94V4HMnCwXFzBugZDoVGvwywxwuJvb5gxnEtClA0JNSldan67x5Pj1KaOvGypusmnpJVyGdOGNfBkPwn3uLJEw/fRFEWR8njSFKIIfGmxVG0xV+Yyivf8nMaqDdDMoWdskUG2VLE0vWnMPHyk=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6884.namprd04.prod.outlook.com (2603:10b6:a03:222::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Thu, 11 Jun
 2020 01:53:07 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 01:53:06 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: [PATCH v2] blktrace: put bounds on BLKTRACESETUP buf_size and
 buf_nr
Thread-Topic: [PATCH v2] blktrace: put bounds on BLKTRACESETUP buf_size and
 buf_nr
Thread-Index: AQHWP5BXDx26ID9vUECrnGzQKUaQfA==
Date:   Thu, 11 Jun 2020 01:53:06 +0000
Message-ID: <BYAPR04MB4965F7009BA4E07B57B0E0CE86800@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200611013326.218542-1-harshadshirwadkar@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 891fb5f4-5861-42a4-6a5e-08d80daa2fc1
x-ms-traffictypediagnostic: BY5PR04MB6884:
x-microsoft-antispam-prvs: <BY5PR04MB68845DAECE679E6AD74F257886800@BY5PR04MB6884.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2AoLVAoQYHBidvmaaSOW41+UoVEuj7hixtlMvWn+138sgJm7YnJUaQxR+h6WLrSnKjg1amUi0mkVptfMMXzawEBu/vmq7+SwfreGx7+fy2DBuBxhRjRl7sMGPRdtZ14fC6bYgYCSMkv70w1tK/z688SAbIUHQ6Xox82rTFYrG0qAnRnBeuHMhGMndR9GNiXwtsTNKMUZYw/XFN2W5zk/r4Pm7jG2QN1VLSNOCV5SVGSFzS6B5AD5LjVFPMcp2RdQgwgukxAAjbbOTglY9Uad4Xx44hRIFlHMnlZ/n3icixcpFEKj1g4I37CjzFj1Gbcc9gNnwuMuweCF2l0N84bUvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(478600001)(53546011)(316002)(26005)(110136005)(7696005)(186003)(6506007)(33656002)(4326008)(83380400001)(71200400001)(5660300002)(52536014)(66556008)(76116006)(66946007)(55016002)(8936002)(8676002)(9686003)(66476007)(86362001)(66446008)(64756008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: X9LSrIAO5Tqlf9uryQpOQdVKXZcZRzDsjNwlz5iXOf67ay9obBWuNPwoYST/7kJ7Q4sbBZVtpn5S32wn+qGG+UpT4TTGb2tnoGIB0tRoCeymjiYkrq0D5S+bdIC3YSeTQYyi9qY0VtAeVrEfMZq2Q4zLkMxNMIVJ1+nU0aSsFdrkveMmcsxEfnlT6pbYcwXTSigA6dAogyEb5q+OuOkdYIKrxCZZne10m/qqLsCZBrKCu6+o4hBGxOFMo4nZYPTqx4QlhYBm89CIQUh+fz9QfWAY5std6rvcH5mbAQq6CxVK5Vqhvm6v6UA7OXohPo8QOyGvrlXINe1o2JTWtWDq5Vuz9+cyrREZ4QDz6+/K+321k9Rh1X3Q6HDcwXcgMAlBTyrk3pR8pIsRp7d0F73WGEDxReJQ4YaJJuKgciPlm2UZ+joqJvC0PQu9ZyHqSE+0AKfNh01GMGLLy+HUIuXFaWRpVoNZdr4we4RPRxqD07w=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891fb5f4-5861-42a4-6a5e-08d80daa2fc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 01:53:06.8532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9sn55FOfuKhvr7w1r5oAbpczVIhVgRpbgDuyc2AH8zIlRACZhv64TepKFqTkiiHye77LUiOwjGeztHrH45EtFJENPokD85o6MVOGYZx27Zo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6884
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/10/20 6:33 PM, Harshad Shirwadkar wrote:=0A=
> Make sure that user requested memory via BLKTRACESETUP is within=0A=
> bounds. This can be easily exploited by setting really large values=0A=
> for buf_size and buf_nr in BLKTRACESETUP ioctl.=0A=
> =0A=
> blktrace program has following hardcoded values for bufsize and bufnr:=0A=
> BUF_SIZE=3D(512 * 1024)=0A=
> BUF_NR=3D(4)=0A=
> =0A=
> This is very easy to exploit. Setting buf_size / buf_nr in userspace=0A=
> program to big values make kernel go oom.=0A=
> =0A=
> This patch adds a new new sysfs tunable called "blktrace_max_alloc"=0A=
> with the default value as:=0A=
> blktrace_max_alloc=3D(1024 * 1024 * 16)=0A=
> =0A=
> Verified that the fix makes BLKTRACESETUP return -E2BIG if the=0A=
> buf_size * buf_nr crosses the configured upper bound in the device's=0A=
> sysfs file. Verified that the bound checking is turned off when we=0A=
> write 0 to the sysfs file.=0A=
> =0A=
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>=0A=
> ---=0A=
>   Documentation/block/queue-sysfs.rst |  8 ++++++++=0A=
>   block/blk-settings.c                |  1 +=0A=
>   block/blk-sysfs.c                   | 27 +++++++++++++++++++++++++++=0A=
>   include/linux/blkdev.h              |  5 +++++=0A=
>   kernel/trace/blktrace.c             |  8 ++++++++=0A=
>   5 files changed, 49 insertions(+)=0A=
> =0A=
> diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/qu=
eue-sysfs.rst=0A=
> index 6a8513af9201..ef4eec68cd24 100644=0A=
> --- a/Documentation/block/queue-sysfs.rst=0A=
> +++ b/Documentation/block/queue-sysfs.rst=0A=
> @@ -251,4 +251,12 @@ devices are described in the ZBC (Zoned Block Comman=
ds) and ZAC=0A=
>   do not support zone commands, they will be treated as regular block dev=
ices=0A=
>   and zoned will report "none".=0A=
>   =0A=
> +blktrace_max_alloc (RW)=0A=
> +----------=0A=
nit:-based on the pattern present in the same file how about following?=0A=
=0A=
blk_trace_max_alloc (RW)=0A=
------------------------=0A=
=0A=
> +BLKTRACESETUP ioctl takes the number of buffers and the size of each=0A=
> +buffer as an argument and uses these values to allocate kernel memory=0A=
> +for tracing purpose. This is the limit on the maximum kernel memory=0A=
> +that can be allocated by BLKTRACESETUP ioctl. The default limit is=0A=
> +16MB. Value of 0 indicates that this bound checking is disabled.=0A=
> +=0A=
>   Jens Axboe <jens.axboe@oracle.com>, February 2009=0A=
> diff --git a/block/blk-settings.c b/block/blk-settings.c=0A=
> index 9a2c23cd9700..38535aa146f4 100644=0A=
> --- a/block/blk-settings.c=0A=
> +++ b/block/blk-settings.c=0A=
> @@ -60,6 +60,7 @@ void blk_set_default_limits(struct queue_limits *lim)=
=0A=
>   	lim->io_opt =3D 0;=0A=
>   	lim->misaligned =3D 0;=0A=
>   	lim->zoned =3D BLK_ZONED_NONE;=0A=
> +	lim->blktrace_max_alloc =3D BLKTRACE_MAX_ALLOC;=0A=
>   }=0A=
>   EXPORT_SYMBOL(blk_set_default_limits);=0A=
>   =0A=
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c=0A=
> index 02643e149d5e..e849e80930c4 100644=0A=
> --- a/block/blk-sysfs.c=0A=
> +++ b/block/blk-sysfs.c=0A=
> @@ -496,6 +496,26 @@ static ssize_t queue_wb_lat_store(struct request_que=
ue *q, const char *page,=0A=
>   	return count;=0A=
>   }=0A=
>   =0A=
> +static ssize_t queue_blktrace_max_alloc_show(struct request_queue *q, ch=
ar *page)=0A=
> +{=0A=
> +	return queue_var_show(q->limits.blktrace_max_alloc, page);=0A=
> +}=0A=
> +=0A=
> +static ssize_t queue_blktrace_max_alloc_store(struct request_queue *q,=
=0A=
> +					      const char *page,=0A=
> +					      size_t count)=0A=
> +{=0A=
> +	unsigned long blktrace_max_alloc;=0A=
> +	int ret;=0A=
> +=0A=
> +	ret =3D queue_var_store(&blktrace_max_alloc, page, count);=0A=
> +	if (ret < 0)=0A=
> +		return ret;=0A=
> +=0A=
> +	q->limits.blktrace_max_alloc =3D blktrace_max_alloc;=0A=
> +	return count;=0A=
> +}=0A=
> +=0A=
>   static ssize_t queue_wc_show(struct request_queue *q, char *page)=0A=
>   {=0A=
>   	if (test_bit(QUEUE_FLAG_WC, &q->queue_flags))=0A=
> @@ -731,6 +751,12 @@ static struct queue_sysfs_entry queue_wb_lat_entry =
=3D {=0A=
>   	.store =3D queue_wb_lat_store,=0A=
>   };=0A=
>   =0A=
> +static struct queue_sysfs_entry queue_blktrace_max_alloc_entry =3D {=0A=
> +	.attr =3D {.name =3D "blktrace_max_alloc", .mode =3D 0644 },=0A=
> +	.show =3D queue_blktrace_max_alloc_show,=0A=
> +	.store =3D queue_blktrace_max_alloc_store,=0A=
> +};=0A=
> +=0A=
>   #ifdef CONFIG_BLK_DEV_THROTTLING_LOW=0A=
>   static struct queue_sysfs_entry throtl_sample_time_entry =3D {=0A=
>   	.attr =3D {.name =3D "throttle_sample_time", .mode =3D 0644 },=0A=
> @@ -779,6 +805,7 @@ static struct attribute *queue_attrs[] =3D {=0A=
>   #ifdef CONFIG_BLK_DEV_THROTTLING_LOW=0A=
>   	&throtl_sample_time_entry.attr,=0A=
>   #endif=0A=
> +	&queue_blktrace_max_alloc_entry.attr,=0A=
Is above attribute needs to be under CONFIG_BLK_DEV_IO_TRACE guard ?=0A=
>   	NULL,=0A=
>   };=0A=
>   =0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index 8fd900998b4e..3a72b0fd723e 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -309,6 +309,10 @@ enum blk_queue_state {=0A=
>   #define BLK_SCSI_MAX_CMDS	(256)=0A=
>   #define BLK_SCSI_CMD_PER_LONG	(BLK_SCSI_MAX_CMDS / (sizeof(long) * 8))=
=0A=
>   =0A=
> +#define BLKTRACE_MAX_BUFSIZ	(1024 * 1024)=0A=
nit:- macro name ending with SIZ is unusual for include/linux/blkdev.h.=0A=
Consider renaming it to BLKTRACE_MAX_BUF_SIZE.=0A=
> +#define BLKTRACE_MAX_BUFNR	16=0A=
nit:- just like BLKTRACE_MAX_BUFSIZ value of BLKTRACE_MAX_BUFNR needs to =
=0A=
be guarded by () ?=0A=
> +#define BLKTRACE_MAX_ALLOC	((BLKTRACE_MAX_BUFSIZ) * (BLKTRACE_MAX_BUFNR)=
)=0A=
nit:- The macro BLKTRACE_MAX_BUFSIZ already has () we can get rid of the =
=0A=
extra inner () for BLKTRACE_MAX_BUFSIZ in BLKTRACE_MAX_ALLOC.=0A=
> +=0A=
>   /*=0A=
>    * Zoned block device models (zoned limit).=0A=
>    */=0A=
> @@ -322,6 +326,7 @@ struct queue_limits {=0A=
>   	unsigned long		bounce_pfn;=0A=
>   	unsigned long		seg_boundary_mask;=0A=
>   	unsigned long		virt_boundary_mask;=0A=
> +	unsigned long		blktrace_max_alloc;=0A=
>   =0A=
>   	unsigned int		max_hw_sectors;=0A=
>   	unsigned int		max_dev_sectors;=0A=
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c=0A=
> index ea47f2084087..de028bdbb148 100644=0A=
> --- a/kernel/trace/blktrace.c=0A=
> +++ b/kernel/trace/blktrace.c=0A=
> @@ -477,11 +477,19 @@ static int do_blk_trace_setup(struct request_queue =
*q, char *name, dev_t dev,=0A=
>   {=0A=
>   	struct blk_trace *bt =3D NULL;=0A=
>   	struct dentry *dir =3D NULL;=0A=
> +	u32 alloc_siz;=0A=
nit:- please use full names 's/alloc_siz/alloc_size/'=0A=
>   	int ret;=0A=
>   =0A=
>   	if (!buts->buf_size || !buts->buf_nr)=0A=
>   		return -EINVAL;=0A=
>   =0A=
> +	if (check_mul_overflow(buts->buf_size, buts->buf_nr, &alloc_siz))=0A=
> +		return -E2BIG;=0A=
> +=0A=
> +	if (q->limits.blktrace_max_alloc &&=0A=
> +	    alloc_siz > q->limits.blktrace_max_alloc)=0A=
> +		return -E2BIG;=0A=
> +=0A=
>   	if (!blk_debugfs_root)=0A=
>   		return -ENOENT;=0A=
>   =0A=
> =0A=
=0A=
