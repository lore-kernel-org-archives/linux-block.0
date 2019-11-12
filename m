Return-Path: <SRS0=0oGL=ZE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEFFC43331
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 00:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67BA2184C
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 00:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FqKFOjkR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RQrDyX/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfKLABf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Nov 2019 19:01:35 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:44756 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKLABe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Nov 2019 19:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1573516922; x=1605052922;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=vNsinSFag91lR1pHap9zeZadOKms5VVYHWx0GL0k0kY=;
  b=FqKFOjkRV0tIUKKH0rrVnczoKyPa0L/Z1wOQ7AUmSMeF8B5FqBpogn4z
   jcdL4kAaMby0lw9LsbxKI7nmQuJlkUbTMseiThz7dL2QMniw5SrkiWHiB
   ZznOmRl6us7HZFmwOHfNxY4Sp6hotADEXWA/PJ53XZQmfQzR8MscliSY6
   UNTMs+jcRVTBE2SROCdo4WgRqWzd5JYdNJSRhwcNsyY0tqqDUeQuB0WOf
   YZS+kfeAQNwjwk/NNeCppXhFOFKKz8tZv6YZNPQowqYAhaLNZ4bqVuJTQ
   BXEChqWcq3D07r1KSPRUynYbOir94Fmasygf/28TPrjxkXa/SlQ9+9iAW
   A==;
IronPort-SDR: t7RLu566SxiJxS0qQsz5rU1oxtadoAO7xcWZYRZaKUYIaKSkTXDykmWGMUkCjQ99bCFHbN3wmI
 lPSAyOVhls8LsikK+8w2HWyLjkjmstK8Q6PG975aO/zrpBrARgsyOIF5YoB1U89CBWyvzEDfGJ
 qSJAeMu6dtGV2m9Bz5WHV++E1V0iFi8oKLC1ly0gVpa5YaOppDyHmWR4TSEcPursKAWhCgBjYB
 jgGdqNXuqOAxszb5FxnUYvFHvDjA/1IbyckkrPGji0rwkEFC8frBU9Oyr/7aB79L/WTeewVojF
 kDM=
X-IronPort-AV: E=Sophos;i="5.68,294,1569254400"; 
   d="scan'208";a="223959780"
Received: from mail-bn3nam04lp2053.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.53])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2019 08:02:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQIkDXnAnei3gMvZo5hKt+7oMX942aVr0o1ipjTyHsvpjXAX316T8J6VEr4/5hUIYi4eTQZivWl8bFJGgIpGmh2Vc30+KFPVuMbPCpLXSVXNlOZbfWyzcS6gmbw1qT+2/YLWUIyAJSabOWlpCtz2dLMnaYSrS+KyEqyrPkp30GRiXoDbAn40r285UxKBrSkciLyOsm0EVpsiOhcWUtudp65Yr1sfF4j1RJyVoPc+UjwfucMkW5J5M/Bss+/wNbpOQ8fXU4m4ggGKe1hSj5yUA4QDNLrWzu2msfqI4buekzBG/pc3kl8CEuE+lAE4JrEdYVbu4FDTZKd5mSL8toyXRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmq5HxN3FDOrK3r6r4a5EtWDCwzWpO3nzaxPBET9Mtg=;
 b=KEPMzOV4TZhy5EpmsHc1hv/hnYIet4vFfT0VD8TIBuqy7pfVdhSSBnl6LBc1wt9+WMP5lKu1WSI/NPsEOwbmeFVSx5n3stdmzv71XGrJdbhVdzy3edw6IFMtn98cGvQameqA0988ltTLnJuS5LnlbR3t1dALUNq94XT8SOhIf4E9Li0vt3BIvU2KgUBg07wSdJ5/diZpgCU2gKtisUBEtAHododMnDaFRvG9B0T9mvoRQWAm2UHVFlimA5PtnOMXlQq65u4FY9h6h/UDcc5wduuwVSbgVksdYBZ5H3bsXZSdG0l0QAv2zDP1FvDIJdyVwFcs5M6Hu8XAmzsB+0xwoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmq5HxN3FDOrK3r6r4a5EtWDCwzWpO3nzaxPBET9Mtg=;
 b=RQrDyX/orvORNKDrNrtj/52E+7MrMcWD85UUfoKHibrSOBb7ulkdwWYkV+1KPIdXB/PX1y17D3wWWaQ8ZKW4097CfCEMsDIV29LxXaSEpEMec1nTjVCWxy2eXJhFsJ46owY4ssKTs5vL8IN+4R+inldEa7i/SCYU/CRYiHwep2g=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4199.namprd04.prod.outlook.com (20.176.251.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 00:01:31 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40%7]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 00:01:31 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH V2 1/2] block: export blk_should_abort()
Thread-Topic: [PATCH V2 1/2] block: export blk_should_abort()
Thread-Index: AQHVmNWebvl53hOUQEKP9JEy5TQ3yg==
Date:   Tue, 12 Nov 2019 00:01:31 +0000
Message-ID: <BYAPR04MB5816C47CA07F4A83CB160E10E7770@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20191111211844.5922-1-chaitanya.kulkarni@wdc.com>
 <20191111211844.5922-2-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3f318b5f-48dc-49f8-b474-08d76703798f
x-ms-traffictypediagnostic: BYAPR04MB4199:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4199688833578E5261A77A94E7770@BYAPR04MB4199.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(199004)(189003)(8936002)(256004)(14444005)(186003)(476003)(66066001)(74316002)(71200400001)(76176011)(33656002)(229853002)(91956017)(446003)(71190400001)(66476007)(66556008)(64756008)(6116002)(76116006)(9686003)(3846002)(66946007)(7696005)(66446008)(486006)(14454004)(6436002)(81156014)(81166006)(110136005)(4326008)(5660300002)(102836004)(2906002)(6246003)(86362001)(25786009)(8676002)(26005)(52536014)(478600001)(55016002)(7736002)(53546011)(305945005)(2501003)(99286004)(316002)(6506007)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4199;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p3Z9gDSrx300BSK+mwN+S5n5bn1kBK/MWfyrPKkPRO4I7N5NQBViXNprRHrMzVvE3lyGCw4L+KOqE5QvgP1ZawRS7/HjbM0RyhqwGKC/sfRLdRZJCAZmGS25vcTQmSz0GP+qSreKfiYyvLJCPL9Otabm4IOVlxYo/gIOaRdii4ub0lc1q0EZcrijVBSp4HdgZ0T2ZznQrxHG2HfC8XA0oZdPA1iwY/WsYh6aDFUqJKAYMTwhTjRPnLVWnVS/sw+FmbriZbBuSxgwjsZRIoWOGb2CUw/ePhFeW/J/uE6asII4cur+cNzqZg8eI5mv2MzisQu/B0d5a2TarQM/5/E+dwnHuPPEAdmjFIStaRaW8EoUtr8NvE91dHdrr5z59zma8dGI554mj9yTSBdGONYm+1On3Nr9Xy74oIusZpPjlyTOkNJ6ft9Mh+ycbBR4XOo+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f318b5f-48dc-49f8-b474-08d76703798f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 00:01:31.7158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qkESsJ+AWCtXQja0AtQohaZj5PcAB8J8b5sBP+CoLEdgI8wofFpyJd+emC6jxEX+wU1XXKcPPhUiZjbUl5qyVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4199
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/11/12 6:18, Chaitanya Kulkarni wrote:=0A=
> This patch exports blk_should_abort() function to avoid dulicate code.=0A=
=0A=
s/dulicate/duplicate=0A=
=0A=
And why export this symbol ? It is not used in kernel modules so I do=0A=
not see the need for it.=0A=
=0A=
In any case, the export should be EXPORT_SYMBOL_GPL().=0A=
=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  block/blk-lib.c | 3 ++-=0A=
>  block/blk.h     | 2 ++=0A=
>  2 files changed, 4 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/block/blk-lib.c b/block/blk-lib.c=0A=
> index 6ca7cae62876..c0afddb2a67b 100644=0A=
> --- a/block/blk-lib.c=0A=
> +++ b/block/blk-lib.c=0A=
> @@ -11,7 +11,7 @@=0A=
>  =0A=
>  #include "blk.h"=0A=
>  =0A=
> -static int blk_should_abort(struct bio *bio)=0A=
> +int blk_should_abort(struct bio *bio)=0A=
>  {=0A=
>  	int ret;=0A=
>  =0A=
> @@ -22,6 +22,7 @@ static int blk_should_abort(struct bio *bio)=0A=
>  	bio_put(bio);=0A=
>  	return ret ? ret : -EINTR;=0A=
>  }=0A=
> +EXPORT_SYMBOL(blk_should_abort);=0A=
>  =0A=
>  struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t g=
fp)=0A=
>  {=0A=
> diff --git a/block/blk.h b/block/blk.h=0A=
> index 2bea40180b6f..63fa4694d333 100644=0A=
> --- a/block/blk.h=0A=
> +++ b/block/blk.h=0A=
> @@ -297,6 +297,8 @@ static inline struct io_context *create_io_context(gf=
p_t gfp_mask, int node)=0A=
>  	return current->io_context;=0A=
>  }=0A=
>  =0A=
> +int blk_should_abort(struct bio *bio);=0A=
> +=0A=
>  /*=0A=
>   * Internal throttling interface=0A=
>   */=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
