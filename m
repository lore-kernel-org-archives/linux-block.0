Return-Path: <SRS0=O1WO=4F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FFDC3B1BF
	for <linux-block@archiver.kernel.org>; Mon, 17 Feb 2020 01:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E936208C3
	for <linux-block@archiver.kernel.org>; Mon, 17 Feb 2020 01:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iarKfSLN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FG6DRAUl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgBQBE0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Feb 2020 20:04:26 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:62421 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgBQBEZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Feb 2020 20:04:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581901465; x=1613437465;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=l29eGw7N6jvuVTaElLKawE5aPhiuQgn6OfSedNIpLnk=;
  b=iarKfSLN1fR99tKa1KbkuOi5NF9gr9WxNm87W8bULz7Di7l41KAj04pz
   GyDvkEZbfr0Ey6oU8XAnqsdyDtvK8FDs9hHXXoDuYukrE7aTyGxKy1wek
   u6/FejE7Q+b7+Rez2IIGAJZi5iXSVIskqKOzp5t1bmK1PXvzB/ntuZKQM
   TSX+NYkVXHN5dnQ2mf3MaBqSW7vuW1WBno1Iqjdapg2gOyYieMgBQTAp1
   7rq/rbSWJxCCmBacW37ZOr3R/5jtzbAznAbv+WpvTwO+sroJKXnlekHV/
   U5JEMwpV5sneCdwDeuhP+367CXN9zBs1n+ZVuyATmMIq6bB1bffLRwft4
   A==;
IronPort-SDR: ribYWxcDtw9+L7UoRTawjvprjOIclf01qfovM267jIK4GkN6M5hAfGMO9SUhmcbaFUlnH9BSQc
 8+UCbIQs9EA2DrHvb1oIJ10mFgZuC2xp5dHDG7xePo8C4PSeJOveMu4RNrn+igwgcBGik9F4bw
 3eZVs4UsYPTCni6j/Z4oOLhuGbKwQSc3j4AYcsGgn2Yb5aJSaVyi8KhcPoIUYMhtyFnXTqbJ+Q
 4h0rcUd/u4+jHF4cSysHwwn1JOpnKVptjjn87CCODnqM/QrafQIV+eWyATfjgtQaKHO51eQlQQ
 nuU=
X-IronPort-AV: E=Sophos;i="5.70,450,1574092800"; 
   d="scan'208";a="238040127"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2020 09:04:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiVvWsn7Ls2usBKBPKuiRbQdaXQEGWzxpVQt/GVRUjmIP/URhDWezRM97jPnBWfV2OfZu58QF58Gc5cCCEXZdcBK84Y8qqCJBW03j2mSsFRU559LxrqEWqHpBo80du8xC1iSEqiWgWF47MuC0mVmNhTOlKXrbKNBHsba5Jgvvdd9dcNQ1XEi5ZAlLJD8TLMY2a+sLe2WRmiStbMBZazRy37PB0qi1hyJeG6BXce+oDjfTR4ST384+erqmOPwDQbX1NwQL4WvWCHCZD79dK1sE28hGi5PguH//2jrTU7NnU+uDJ5Ei+cZk7E8sLOR5USVPyrnQLljPXfZiRp9roJiVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgEpzUzoLwmLJn9OSgnnE8OtNNxSbUCDbGKvnQ4APnE=;
 b=WWljv6z6Yc2ozkw7d5VY+mph2BiHyihVSY6nMX+9bb9dGdAkdYg+H6ljrkBCDrDv1888RZdlNuBcSdy4OkfWpd4G5IFMs8vqohUDoJDI/WDGDL/Rrjn6XAAoTTmD40dCItrfTUweYiykrYckQ4fFzaPVZYuQ5q7XpV9iqX/pAoHr5JQO8uwwSuZ7XXGexg6H9xYfed8Ds0V3KSBmHL6ZyI6+kQ6CvAGloBRk3chKSOJ4tWysDuHKWKoFfkeqXqwDQdjWtJzg0kRXWpMxHhG5uv//UbbBRpRT6p1rmRXR9qPFxKWxqSBzLqQ9tQn+P5hQq9Vq6Y6fe/toHrmsjDplgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgEpzUzoLwmLJn9OSgnnE8OtNNxSbUCDbGKvnQ4APnE=;
 b=FG6DRAUlXdHYxqXFMcmckVwAnS8GoU1dXB+203Ybvq6W38rnvb427lsDOxF4bZFLXdWoI0rFQVLQ6+6jTH++XtZ+GdVLEvpzmk2w9ygdoCmDWfCTsHlJrBuOg3q3xTmbMSZ+glrLU38113e01J1dMXBuirdCFt/fQ/ZaQ2N2R68=
Received: from BN8PR04MB5812.namprd04.prod.outlook.com (20.179.75.75) by
 BN8PR04MB5668.namprd04.prod.outlook.com (20.179.72.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Mon, 17 Feb 2020 01:04:22 +0000
Received: from BN8PR04MB5812.namprd04.prod.outlook.com
 ([fe80::59a2:b03:15e5:7c02]) by BN8PR04MB5812.namprd04.prod.outlook.com
 ([fe80::59a2:b03:15e5:7c02%7]) with mapi id 15.20.2729.031; Mon, 17 Feb 2020
 01:04:22 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/3] null_blk: add tracepoint helpers for zoned mode
Thread-Topic: [PATCH 2/3] null_blk: add tracepoint helpers for zoned mode
Thread-Index: AQHV45r92o2p6B7KHU23Uq05PpyQVA==
Date:   Mon, 17 Feb 2020 01:04:22 +0000
Message-ID: <BN8PR04MB5812963364CBCB8C05C03192E7160@BN8PR04MB5812.namprd04.prod.outlook.com>
References: <20200215005758.3212-1-chaitanya.kulkarni@wdc.com>
 <20200215005758.3212-3-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bf870a88-8991-4955-49b3-08d7b345534c
x-ms-traffictypediagnostic: BN8PR04MB5668:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR04MB56681493A2AD6FF9807FEDA6E7160@BN8PR04MB5668.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-forefront-prvs: 0316567485
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(199004)(189003)(66946007)(52536014)(5660300002)(64756008)(66556008)(66446008)(66476007)(54906003)(9686003)(91956017)(110136005)(316002)(76116006)(86362001)(55016002)(4326008)(7696005)(71200400001)(478600001)(8936002)(8676002)(26005)(186003)(53546011)(6506007)(81166006)(81156014)(2906002)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR04MB5668;H:BN8PR04MB5812.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YzdLrKySzxKMA1C16B79OhOhTQgKJuwLLhv9Kbq/13zZlqgC0Oo1pwWuh9b0ZQMCY3jq0edFrvLbQx8nbHN2Z4+d/ALq1nHogM3khr8ZoNob0BLrt9WGWjNs89sV3H80zrylgvBTq8yRTUsq7wZnaJ+WIKFQ903T5xqVDE0wHscmqoOpshfksDgWnXALI/b+QBvnGPUsz5I+gEYPOWvWe3oWy9Vrt57VU+wtGiwGHHymNTNhI+PvWcgomuA6u06TnZ1CClTW3b+bNbf4yugblGNq/ljDD8zxjqfPnEZP3Mv5VBs18N2c8USLzu1unV5gUKOTiuCWHrxzabCFoqDj8meLbiC4wZa1RJEDYW/cJSxMVMzj9ZINguVdmb01IZ0vIwpyvT9mhHWGqzdn292Mi6/fKfIQZAJbN8HAj31e/Nj28zngwexdYDAGCxsGahFN
x-ms-exchange-antispam-messagedata: tq88XgqWvZFImSB3vKkU6SIRj/ZybUxetWLBIFMbGrXc6jBzJ4Ey62JJtBra2OdcP8Qsz6iz+EHH6JMpc1GRjNOxYZbqIxhRpU/2Tbfp/uyCrm4DpppXWDeGxz6RXcMwO7rt5y2QcuZhkdAcGoW+BA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf870a88-8991-4955-49b3-08d7b345534c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2020 01:04:22.5499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MqYeP1jsxef5k8THJOPRiowSLeHysyJMknWDKECbtbgYeOK4ikyQam/YnvgwIljwUcy26M1d3orWGU+5VHkhUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5668
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/02/15 9:58, Chaitanya Kulkarni wrote:=0A=
> This patch adds two new tracpoints for null_blk_zoned.c that allows us=0A=
> to trace report-zones, zone-mgmt-op and zone-write operations which has=
=0A=
> direct effect on the zone condition state machine.=0A=
> =0A=
> Also, we update drivers/block/Makefile so that new null_blk related=0A=
> tracefiles can be compiled.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  drivers/block/Makefile         |  3 ++=0A=
>  drivers/block/null_blk_trace.c | 20 +++++++++=0A=
>  drivers/block/null_blk_trace.h | 78 ++++++++++++++++++++++++++++++++++=
=0A=
>  3 files changed, 101 insertions(+)=0A=
>  create mode 100644 drivers/block/null_blk_trace.c=0A=
>  create mode 100644 drivers/block/null_blk_trace.h=0A=
> =0A=
> diff --git a/drivers/block/Makefile b/drivers/block/Makefile=0A=
> index a53cc1e3a2d3..b05aa413f7c0 100644=0A=
> --- a/drivers/block/Makefile=0A=
> +++ b/drivers/block/Makefile=0A=
> @@ -6,6 +6,8 @@=0A=
>  # Rewritten to use lists instead of if-statements.=0A=
>  # =0A=
>  =0A=
> +ccflags-y				+=3D -I$(src)=0A=
> +=0A=
>  obj-$(CONFIG_MAC_FLOPPY)	+=3D swim3.o=0A=
>  obj-$(CONFIG_BLK_DEV_SWIM)	+=3D swim_mod.o=0A=
>  obj-$(CONFIG_BLK_DEV_FD)	+=3D floppy.o=0A=
> @@ -39,6 +41,7 @@ obj-$(CONFIG_ZRAM) +=3D zram/=0A=
>  =0A=
>  obj-$(CONFIG_BLK_DEV_NULL_BLK)	+=3D null_blk.o=0A=
>  null_blk-objs	:=3D null_blk_main.o=0A=
> +null_blk-$(CONFIG_TRACING)	+=3D null_blk_trace.o=0A=
=0A=
Since the traces are for zoned operations only, why compile this if=0A=
CONFIG_BLK_DEV_ZONED is not enabled ?=0A=
=0A=
>  null_blk-$(CONFIG_BLK_DEV_ZONED) +=3D null_blk_zoned.o=0A=
>  =0A=
>  skd-y		:=3D skd_main.o=0A=
> diff --git a/drivers/block/null_blk_trace.c b/drivers/block/null_blk_trac=
e.c=0A=
> new file mode 100644=0A=
> index 000000000000..bd066130ff39=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/null_blk_trace.c=0A=
> @@ -0,0 +1,20 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +=0A=
> +/*=0A=
> + * All trace related helpers for null_blk goes here.=0A=
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
> index 000000000000..8171bc26f6d1=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/null_blk_trace.h=0A=
> @@ -0,0 +1,78 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
> +/*=0A=
> + * null_blk device driver tracepoints.=0A=
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
> +#define __print_disk_name(name)				\=0A=
> +	nullb_trace_disk_name(p, name)=0A=
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
