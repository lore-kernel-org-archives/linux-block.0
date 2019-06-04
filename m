Return-Path: <SRS0=GlWt=UD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E8CC04AB5
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 02:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4FA261E1
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 02:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WKl2I6u4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rYJfLmoX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfFDC7j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Jun 2019 22:59:39 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:18926 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFDC7j (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Jun 2019 22:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559617178; x=1591153178;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=jZr67NIYtj08w5Kr6SX1PXhTim0PoAy4scHKknIVJZU=;
  b=WKl2I6u4QmBh+FX7DolN81rX0KXP6wNJgGFZKaxrKy52QjeaDeg6Wrxi
   kLL3aH3uQ7dPCrC7wlCC9adbury5/Rm6mp1UXdqwoKq81YbLmTykHz71G
   V/udlsgYyrcyiaMN9HZOm9jCT/kstgwB8hUlr6fspL68lkfeKoPMieR/Y
   pt57jRwMfnOHBE1HgiZiS1+aJcpDNs+6MkvjeneNtD2va4mV4dDf9wsug
   L3qj6Q7+ENx10fyGbbvK8tCuweMVLFgPWhYvqEIVb3uMHmcKMKjKhODKq
   dlaZaAmwP+2EQgpH2ZznXwVHcRtVQX1+QTOSX/bet2fOy1ZophFWMNINf
   w==;
X-IronPort-AV: E=Sophos;i="5.60,549,1549900800"; 
   d="scan'208";a="111396261"
Received: from mail-co1nam03lp2056.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.56])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2019 10:59:38 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyNdhV8to8Nx5DxwTrCsDMGlLLcBauhht+JtNMF9snM=;
 b=rYJfLmoXed8nyEOF3rnhM7rT6e272se2LK3UtXBMXxNN/TTb/VsPo8JD3to1YTfJbPW6kdOk6hwDuAcGpLa/KzEaHOzVVxY8rlgTeaRxOJ42OsiUL48ws1GgA3axWlBEsnWmLiZnU/vkN3xz+XJQ8/EjMgb9PY0r8PPp4HFfCv8=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5461.namprd04.prod.outlook.com (20.178.51.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Tue, 4 Jun 2019 02:59:36 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5%4]) with mapi id 15.20.1943.018; Tue, 4 Jun 2019
 02:59:36 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [RFC] block: add counter to track io request's d2c time
Thread-Topic: [RFC] block: add counter to track io request's d2c time
Thread-Index: AQHVGnTsudsivqad0kyq92iSvm/I+w==
Date:   Tue, 4 Jun 2019 02:59:36 +0000
Message-ID: <BYAPR04MB5749B89B96684EA3540E0DE886150@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190604012855.1679-1-xiaoguang.wang@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2db8022-2ead-4a2a-b7e3-08d6e898ad80
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB5461;
x-ms-traffictypediagnostic: BYAPR04MB5461:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5461A45C95E8E2F1555A671686150@BYAPR04MB5461.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 0058ABBBC7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(39860400002)(366004)(396003)(199004)(189003)(6506007)(305945005)(53546011)(102836004)(26005)(7696005)(7736002)(6246003)(76176011)(8676002)(81156014)(81166006)(66556008)(52536014)(14454004)(86362001)(186003)(316002)(5660300002)(66446008)(64756008)(73956011)(66946007)(66476007)(53936002)(76116006)(72206003)(486006)(8936002)(14444005)(71190400001)(2501003)(25786009)(68736007)(66066001)(478600001)(256004)(33656002)(2906002)(476003)(110136005)(74316002)(4326008)(229853002)(55016002)(9686003)(3846002)(6116002)(99286004)(446003)(71200400001)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5461;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Tn0L80B7bJNRkd5/5MOTOMPWp8XZVu75sXiIWBdo90YC06AX89LQxUOB+J6ZAFiHqGbE3rz8qN2ItHrlVD0FusA/DlpC9UNLNHTpbw0uAwUFygfzZEz7ZiczKIXael4JWJuffF4eviuVAK3x0ihd/EA+V14pvQQHPt4+c4GViTW9Ie2tag4k33eFOLqRjCrVrRUSpkhKwgp42sIbCMW0oIi5oxhQMQp4q/Bk9sJ/XsS972lZqW2bSjiOIULSoEiSY9dPfQ0eYSyhoKwWdwGihdBwh3d0A1Ef+hk/jBX7MQ4zeXRi4DHUTdonnQI9vscSZgTSEOIauc/akuYalc0Khhx4zoeauRW9k50sgBy2w8a+mw5yzPMliR5kTA3pIzwOBCZm0Ar66s7laTxITjrFngenI/aaQYebHTj8m11O+O4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2db8022-2ead-4a2a-b7e3-08d6e898ad80
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2019 02:59:36.1241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5461
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In case I missed, is it possible to include iostat patch corresponding =0A=
to this kernel patch ?=0A=
=0A=
On 6/3/19 6:29 PM, Xiaoguang Wang wrote:=0A=
> Indeed tool iostat's await is not good enough, which is somewhat sketchy=
=0A=
> and could not show request's latency on device driver's side.=0A=
> =0A=
> Here we add a new counter to track io request's d2c time, also with this=
=0A=
> patch, we can extend iostat to show this value easily.=0A=
> =0A=
> Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>=0A=
> ---=0A=
>   block/blk-core.c          | 3 +++=0A=
>   block/genhd.c             | 7 +++++--=0A=
>   block/partition-generic.c | 8 ++++++--=0A=
>   include/linux/genhd.h     | 4 ++++=0A=
>   4 files changed, 18 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-core.c b/block/blk-core.c=0A=
> index ee1b35fe8572..b0449ec80a7d 100644=0A=
> --- a/block/blk-core.c=0A=
> +++ b/block/blk-core.c=0A=
> @@ -1257,6 +1257,9 @@ void blk_account_io_done(struct request *req, u64 n=
ow)=0A=
>   		update_io_ticks(part, jiffies);=0A=
>   		part_stat_inc(part, ios[sgrp]);=0A=
>   		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);=0A=
> +		if (req->io_start_time_ns)=0A=
> +			part_stat_add(part, d2c_nsecs[sgrp],=0A=
> +				      now - req->io_start_time_ns);=0A=
>   		part_stat_add(part, time_in_queue, nsecs_to_jiffies64(now - req->star=
t_time_ns));=0A=
>   		part_dec_in_flight(req->q, part, rq_data_dir(req));=0A=
>   =0A=
> diff --git a/block/genhd.c b/block/genhd.c=0A=
> index 24654e1d83e6..727bc1de1a74 100644=0A=
> --- a/block/genhd.c=0A=
> +++ b/block/genhd.c=0A=
> @@ -1377,7 +1377,7 @@ static int diskstats_show(struct seq_file *seqf, vo=
id *v)=0A=
>   			   "%lu %lu %lu %u "=0A=
>   			   "%lu %lu %lu %u "=0A=
>   			   "%u %u %u "=0A=
> -			   "%lu %lu %lu %u\n",=0A=
> +			   "%lu %lu %lu %u %u %u %u\n",=0A=
>   			   MAJOR(part_devt(hd)), MINOR(part_devt(hd)),=0A=
>   			   disk_name(gp, hd->partno, buf),=0A=
>   			   part_stat_read(hd, ios[STAT_READ]),=0A=
> @@ -1394,7 +1394,10 @@ static int diskstats_show(struct seq_file *seqf, v=
oid *v)=0A=
>   			   part_stat_read(hd, ios[STAT_DISCARD]),=0A=
>   			   part_stat_read(hd, merges[STAT_DISCARD]),=0A=
>   			   part_stat_read(hd, sectors[STAT_DISCARD]),=0A=
> -			   (unsigned int)part_stat_read_msecs(hd, STAT_DISCARD)=0A=
> +			   (unsigned int)part_stat_read_msecs(hd, STAT_DISCARD),=0A=
> +			   (unsigned int)part_stat_read_d2c_msecs(hd, STAT_READ),=0A=
> +			   (unsigned int)part_stat_read_d2c_msecs(hd, STAT_WRITE),=0A=
> +			   (unsigned int)part_stat_read_d2c_msecs(hd, STAT_DISCARD)=0A=
>   			);=0A=
>   	}=0A=
>   	disk_part_iter_exit(&piter);=0A=
> diff --git a/block/partition-generic.c b/block/partition-generic.c=0A=
> index aee643ce13d1..0635a46a31dd 100644=0A=
> --- a/block/partition-generic.c=0A=
> +++ b/block/partition-generic.c=0A=
> @@ -127,7 +127,7 @@ ssize_t part_stat_show(struct device *dev,=0A=
>   		"%8lu %8lu %8llu %8u "=0A=
>   		"%8lu %8lu %8llu %8u "=0A=
>   		"%8u %8u %8u "=0A=
> -		"%8lu %8lu %8llu %8u"=0A=
> +		"%8lu %8lu %8llu %8u %8u %8u %8u %8u"=0A=
>   		"\n",=0A=
>   		part_stat_read(p, ios[STAT_READ]),=0A=
>   		part_stat_read(p, merges[STAT_READ]),=0A=
> @@ -143,7 +143,11 @@ ssize_t part_stat_show(struct device *dev,=0A=
>   		part_stat_read(p, ios[STAT_DISCARD]),=0A=
>   		part_stat_read(p, merges[STAT_DISCARD]),=0A=
>   		(unsigned long long)part_stat_read(p, sectors[STAT_DISCARD]),=0A=
> -		(unsigned int)part_stat_read_msecs(p, STAT_DISCARD));=0A=
> +		(unsigned int)part_stat_read_msecs(p, STAT_DISCARD),=0A=
> +		(unsigned int)part_stat_read_msecs(p, STAT_DISCARD),=0A=
> +		(unsigned int)part_stat_read_d2c_msecs(p, STAT_READ),=0A=
> +		(unsigned int)part_stat_read_d2c_msecs(p, STAT_WRITE),=0A=
> +		(unsigned int)part_stat_read_d2c_msecs(p, STAT_DISCARD));=0A=
>   }=0A=
>   =0A=
>   ssize_t part_inflight_show(struct device *dev, struct device_attribute =
*attr,=0A=
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h=0A=
> index 8b5330dd5ac0..f80ba947cac2 100644=0A=
> --- a/include/linux/genhd.h=0A=
> +++ b/include/linux/genhd.h=0A=
> @@ -85,6 +85,7 @@ struct partition {=0A=
>   =0A=
>   struct disk_stats {=0A=
>   	u64 nsecs[NR_STAT_GROUPS];=0A=
> +	u64 d2c_nsecs[NR_STAT_GROUPS];=0A=
>   	unsigned long sectors[NR_STAT_GROUPS];=0A=
>   	unsigned long ios[NR_STAT_GROUPS];=0A=
>   	unsigned long merges[NR_STAT_GROUPS];=0A=
> @@ -367,6 +368,9 @@ static inline void free_part_stats(struct hd_struct *=
part)=0A=
>   #define part_stat_read_msecs(part, which)				\=0A=
>   	div_u64(part_stat_read(part, nsecs[which]), NSEC_PER_MSEC)=0A=
>   =0A=
> +#define part_stat_read_d2c_msecs(part, which)				\=0A=
> +	div_u64(part_stat_read(part, d2c_nsecs[which]), NSEC_PER_MSEC)=0A=
> +=0A=
>   #define part_stat_read_accum(part, field)				\=0A=
>   	(part_stat_read(part, field[STAT_READ]) +			\=0A=
>   	 part_stat_read(part, field[STAT_WRITE]) +			\=0A=
> =0A=
=0A=
