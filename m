Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B1BC54FD2
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 03:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24E72074D
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 03:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ky+En8mp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eMbh+s3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbgCYD24 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Mar 2020 23:28:56 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:50651 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCYD24 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Mar 2020 23:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585106935; x=1616642935;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=dGzt4XeinHWTGWwN8E37M60szImI5Pgdxezo1OhCMh8=;
  b=ky+En8mpkpkKEI0yZeSEfpfTigRChd+1c/MrAhbDR9pQ9AKurhTIvE0v
   gtHWMu/6S+N8uZi4ovDXQ9bsSnFgBSt0cuvJMnMyRdGCzK1S4EVMcEqwe
   YOuY+VniLQrajkrllY0sGoOqRhacLCIgzM1AaERhaA6pfqtQeitXn/K0I
   M5IUdYnDMPDqWmSo+P7Wlesjg5s/HfPq2u1Cl+kHYYXixLbUDHxzH2jGc
   nKfOrpBlUD8J5vwfkMIpsYunEnSEGGZjQzYg05aItjvKO+n6cnKmtN9w4
   bltVKXtfrMi2ciW4S6vXlJ4CG2BX9QgLwVHBSWCqptknYvIfE4IsSolDF
   Q==;
IronPort-SDR: WITTGbN31tv6B1cy8vXkle4GyQk3yO9AGy7UXQYG/OIA8T6s5OoWYanUAY6CILG/mVIC7gMi2E
 4iz/zZZwGGSiH8LAE5ZzcvyP+5iiRGkvQ3i5+0eQx8qZHOGgttUyomcMVzaz3x3BAcY0wBDvng
 p2qT8+SdfRJoNS7ofkgxnDA7AM8wcMGcIqYbo5Ul5VBpAIC58U831S4U0dQxFqBTGq80Hv1Q9B
 1abEzlivvk4QrpqoCyx08SYFMgfKfSNJ1QDj+vAwgvhF5lUOXW3kFhY+BcVMby+3Y2yGDEqifk
 sa4=
X-IronPort-AV: E=Sophos;i="5.72,302,1580745600"; 
   d="scan'208";a="133424332"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2020 11:28:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uu7PyS9ho8LCI9IzOklsAklzdk6epo9Q9Vsi3bBvGdTBSTopa6wfI29cUqIl+MtjLHJ2pKv/qKT6lzzHEvClFQRXicXqiD/CwMpeW97BzKbuYqjfD57qz5OxC68BLd+TLnYKaxJfyvL87iPaCUY0T7H2QfMlKatBacv3hH+DjlriGx1q2EDc0/pXFO6ySgmDmneoxl2W2E8YyCP57fI53+AWQ3BnyVZpuvDqao0e4tKblm0EfUTXgXBvUTx6fNJXxcretgkW5P4kdzWWCoUCJnuEsQsniR5Hn000HzAVfnZx4VSNYGbUVqSeHgHznnqeAYAatjwbzCmkZ7x1p6uHhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7mqU5t/b24q8JRr5g1vjZBk5gvgRpjbQw+4bOAs6ic=;
 b=ZfOdkBy1LwT/lF/8HCpZYUKyhZGtR6aRGSjJfKRst/y+IOoYYrg4ZHtZvfRv+p4nTREwOAOm5D775DbT7CzDZrLOa+DcDbj/MBPNBx9SqMRseeTYuMPbYxW2lth5+qr9QGtujhhWRdqb2P/Iiz4RDg2uhSO3adyAOHTKm+4bod916ofJ9CHfagQlwz3zHLBGRmrsoLE5J+JQ0zIXxRHOhOR48QsgEHyaIoCrfRBv9478z5+QBEIScj9RFkWHrsucykYsr7TC2t1z0ePvi8ekIjIxXbtTxdG7fpI75x17VoD+B7UhOj7ZovMZgHFv09uWNb/QY/MCteFPffXykahh0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7mqU5t/b24q8JRr5g1vjZBk5gvgRpjbQw+4bOAs6ic=;
 b=eMbh+s3r22lCarot47ly5hMEXv6tJG4aAW26QCwaCHI04oR4DyIY08pQXa742nFb+PkOe31R3gt7782e6rtsXbuAK+E6Rjl/E7V1t4Lndo9BQ0oK/0dl4Ijau7qvXRIA9dB0DVxhR73Y9Y3OewYOfIHxEXPFTKwIwO8saeHL+IM=
Received: from CO2PR04MB2343.namprd04.prod.outlook.com (2603:10b6:102:12::9)
 by CO2PR04MB2136.namprd04.prod.outlook.com (2603:10b6:102:11::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Wed, 25 Mar
 2020 03:28:53 +0000
Received: from CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b]) by CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b%7]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 03:28:53 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH V3 2/3] null_blk: add tracepoint helpers for zoned mode
Thread-Topic: [PATCH V3 2/3] null_blk: add tracepoint helpers for zoned mode
Thread-Index: AQHWAlSH8p39FZsxq0qdBvBUiVsizg==
Date:   Wed, 25 Mar 2020 03:28:53 +0000
Message-ID: <CO2PR04MB2343BF7AABB1273251C8C474E7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
References: <20200325021629.15103-1-chaitanya.kulkarni@wdc.com>
 <20200325021629.15103-3-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 79a6ae98-ba7f-4c81-78ed-08d7d06ca4b7
x-ms-traffictypediagnostic: CO2PR04MB2136:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO2PR04MB21360C20F5F609DF91EA73B4E7CE0@CO2PR04MB2136.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:374;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(71200400001)(33656002)(8936002)(9686003)(91956017)(66476007)(4326008)(66556008)(66946007)(66446008)(55016002)(186003)(76116006)(86362001)(64756008)(52536014)(110136005)(2906002)(26005)(7696005)(316002)(5660300002)(81156014)(478600001)(53546011)(81166006)(8676002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR04MB2136;H:CO2PR04MB2343.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MEHmIaywD3+DrwyeB6rqU4+dUiG0UoFQybRvKKmkUXdZaM17fTBL57f9bo78TVmyg8ak0UDVI1AofbHUSqXfMV7XzNjuoD42VLds4ysEDQwj/A3jYKkwuMaKT8/Rkb+07+8tm9VFnRqAQJXC46VH7ljQNvExaJmFz83NBRiEPFWb0KoK/cXUGVhgi1+kDB5Ob7zEbUTEawAplo2729akz+4C/CBsdh314ehpqFcYIDdbGNu6ZSxV33rFQfbFZrtWZN5bdeRS8gk+GB9RNQU5mvaVrpplaqaCLPyvijdatmDHG4ntudAS/mGjF/THKCzLTA020g235y4k4mLzIcR58WOThgO3LSV4x14UZP8imqMQX5TDQoSgoxb0jPBuPoR/tOmkx7h2wxT93lk4m2Lo613wQ1Jy2TJMZamh2ozyIHo25JqfgNp3mnerdlTnkVlf
x-ms-exchange-antispam-messagedata: NPceU21trMwu1JO+rFu+byTdtRffCeVh35oLVz5jZmuFLeeLL5e5nyMuX3WO5CS8VDHYjVkVrxQofO87dhFR7M40kORY8XTfywoa9GM2S3wG5/tGPBXu63MZH4r8SAqrWkudwzcbj7Dq4QmLFD5TCQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a6ae98-ba7f-4c81-78ed-08d7d06ca4b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 03:28:53.2728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Vj4KIHSntfEjN3Px2MHY0q0kFcYrhWRNC/rXUlPbl1cfzYIcjbU4Y8I/GT1T4CN/OSZ2SN5oGOgK1J1BQtmaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2136
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/03/25 12:21, Chaitanya Kulkarni wrote:=0A=
> This patch adds two new tracpoints for null_blk_zoned.c that allows us=0A=
> to trace report-zones, zone-mgmt-op and zone-write operations which has=
=0A=
> direct effect on the zone condition state machine.=0A=
> =0A=
> Also, we update drivers/block/Makefile so that new null_blk related=0A=
> tracefiles can be compiled.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
Looks good to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
=0A=
> ---=0A=
>  drivers/block/Makefile         |  6 +++=0A=
>  drivers/block/null_blk_trace.c | 21 +++++++++=0A=
>  drivers/block/null_blk_trace.h | 79 ++++++++++++++++++++++++++++++++++=
=0A=
>  3 files changed, 106 insertions(+)=0A=
>  create mode 100644 drivers/block/null_blk_trace.c=0A=
>  create mode 100644 drivers/block/null_blk_trace.h=0A=
> =0A=
> diff --git a/drivers/block/Makefile b/drivers/block/Makefile=0A=
> index a53cc1e3a2d3..795facd8cf19 100644=0A=
> --- a/drivers/block/Makefile=0A=
> +++ b/drivers/block/Makefile=0A=
> @@ -6,6 +6,9 @@=0A=
>  # Rewritten to use lists instead of if-statements.=0A=
>  # =0A=
>  =0A=
> +# needed for trace events=0A=
> +ccflags-y				+=3D -I$(src)=0A=
> +=0A=
>  obj-$(CONFIG_MAC_FLOPPY)	+=3D swim3.o=0A=
>  obj-$(CONFIG_BLK_DEV_SWIM)	+=3D swim_mod.o=0A=
>  obj-$(CONFIG_BLK_DEV_FD)	+=3D floppy.o=0A=
> @@ -39,6 +42,9 @@ obj-$(CONFIG_ZRAM) +=3D zram/=0A=
>  =0A=
>  obj-$(CONFIG_BLK_DEV_NULL_BLK)	+=3D null_blk.o=0A=
>  null_blk-objs	:=3D null_blk_main.o=0A=
> +ifeq ($(CONFIG_BLK_DEV_ZONED), y)=0A=
> +null_blk-$(CONFIG_TRACING) +=3D null_blk_trace.o=0A=
> +endif=0A=
>  null_blk-$(CONFIG_BLK_DEV_ZONED) +=3D null_blk_zoned.o=0A=
>  =0A=
>  skd-y		:=3D skd_main.o=0A=
> diff --git a/drivers/block/null_blk_trace.c b/drivers/block/null_blk_trac=
e.c=0A=
> new file mode 100644=0A=
> index 000000000000..f246e7bff698=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/null_blk_trace.c=0A=
> @@ -0,0 +1,21 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +/*=0A=
> + * null_blk trace related helpers.=0A=
> + *=0A=
> + * Copyright (C) 2020 Western Digital Corporation or its affiliates.=0A=
> + */=0A=
> +#include "null_blk_trace.h"=0A=
> +=0A=
> +/*=0A=
> + * Helper to use for all null_blk traces to extract disk name.=0A=
> + */=0A=
> +const char *nullb_trace_disk_name(struct trace_seq *p, char *name)=0A=
> +{=0A=
> +	const char *ret =3D trace_seq_buffer_ptr(p);=0A=
> +=0A=
> +	if (name && *name)=0A=
> +		trace_seq_printf(p, "disk=3D%s, ", name);=0A=
> +	trace_seq_putc(p, 0);=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> diff --git a/drivers/block/null_blk_trace.h b/drivers/block/null_blk_trac=
e.h=0A=
> new file mode 100644=0A=
> index 000000000000..4f83032eb544=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/null_blk_trace.h=0A=
> @@ -0,0 +1,79 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
> +/*=0A=
> + * null_blk device driver tracepoints.=0A=
> + *=0A=
> + * Copyright (C) 2020 Western Digital Corporation or its affiliates.=0A=
> + */=0A=
> +=0A=
> +#undef TRACE_SYSTEM=0A=
> +#define TRACE_SYSTEM nullb=0A=
> +=0A=
> +#if !defined(_TRACE_NULLB_H) || defined(TRACE_HEADER_MULTI_READ)=0A=
> +#define _TRACE_NULLB_H=0A=
> +=0A=
> +#include <linux/tracepoint.h>=0A=
> +#include <linux/trace_seq.h>=0A=
> +=0A=
> +#include "null_blk.h"=0A=
> +=0A=
> +const char *nullb_trace_disk_name(struct trace_seq *p, char *name);=0A=
> +=0A=
> +#define __print_disk_name(name) nullb_trace_disk_name(p, name)=0A=
> +=0A=
> +#ifndef TRACE_HEADER_MULTI_READ=0A=
> +static inline void __assign_disk_name(char *name, struct gendisk *disk)=
=0A=
> +{=0A=
> +	if (disk)=0A=
> +		memcpy(name, disk->disk_name, DISK_NAME_LEN);=0A=
> +	else=0A=
> +		memset(name, 0, DISK_NAME_LEN);=0A=
> +}=0A=
> +#endif=0A=
> +=0A=
> +TRACE_EVENT(nullb_zone_op,=0A=
> +	    TP_PROTO(struct nullb_cmd *cmd, unsigned int zone_no,=0A=
> +		     unsigned int zone_cond),=0A=
> +	    TP_ARGS(cmd, zone_no, zone_cond),=0A=
> +	    TP_STRUCT__entry(=0A=
> +		__array(char, disk, DISK_NAME_LEN)=0A=
> +		__field(enum req_opf, op)=0A=
> +		__field(unsigned int, zone_no)=0A=
> +		__field(unsigned int, zone_cond)=0A=
> +	    ),=0A=
> +	    TP_fast_assign(=0A=
> +		__entry->op =3D req_op(cmd->rq);=0A=
> +		__entry->zone_no =3D zone_no;=0A=
> +		__entry->zone_cond =3D zone_cond;=0A=
> +		__assign_disk_name(__entry->disk, cmd->rq->rq_disk);=0A=
> +	    ),=0A=
> +	    TP_printk("%s req=3D%-15s zone_no=3D%u zone_cond=3D%-10s",=0A=
> +		      __print_disk_name(__entry->disk),=0A=
> +		      blk_op_str(__entry->op),=0A=
> +		      __entry->zone_no,=0A=
> +		      blk_zone_cond_str(__entry->zone_cond))=0A=
> +);=0A=
> +=0A=
> +TRACE_EVENT(nullb_report_zones,=0A=
> +	    TP_PROTO(struct nullb *nullb, unsigned int nr_zones),=0A=
> +	    TP_ARGS(nullb, nr_zones),=0A=
> +	    TP_STRUCT__entry(=0A=
> +		__array(char, disk, DISK_NAME_LEN)=0A=
> +		__field(unsigned int, nr_zones)=0A=
> +	    ),=0A=
> +	    TP_fast_assign(=0A=
> +		__entry->nr_zones =3D nr_zones;=0A=
> +		__assign_disk_name(__entry->disk, nullb->disk);=0A=
> +	    ),=0A=
> +	    TP_printk("%s nr_zones=3D%u",=0A=
> +		      __print_disk_name(__entry->disk), __entry->nr_zones)=0A=
> +);=0A=
> +=0A=
> +#endif /* _TRACE_NULLB_H */=0A=
> +=0A=
> +#undef TRACE_INCLUDE_PATH=0A=
> +#define TRACE_INCLUDE_PATH .=0A=
> +#undef TRACE_INCLUDE_FILE=0A=
> +#define TRACE_INCLUDE_FILE null_blk_trace=0A=
> +=0A=
> +/* This part must be outside protection */=0A=
> +#include <trace/define_trace.h>=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
