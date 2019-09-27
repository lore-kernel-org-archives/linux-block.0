Return-Path: <SRS0=f8eR=XW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FB4C4360C
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 17:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685F9207FF
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 17:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="M0qeOsIR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GDxnbCyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfI0R0D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Sep 2019 13:26:03 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44764 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfI0R0C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Sep 2019 13:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1569605162; x=1601141162;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=HObij8lhNStiAAL3HAubDZylVbUOxoVYLdJ2jkD9g9g=;
  b=M0qeOsIRRAy0N+rDLEsM2EfgbCmKQGOIGPe7nUnd2LBbIBCxB0QTvrw9
   I0/V2ZmrLhx6IhbWhlPvkWO3Jx1SM4eBhcMKmVyBOQxQKynRR1kWlrXqr
   H9YOarQ40miuBYfqD2gZqaSHkmMEEf3FEQNBiG73OSWd3cr7F+QenDgoo
   y/xdjewJhog355mn9JSh7KQk8v2pZZRAD4XPOA8DWq7KrlT2yNE8kbqVS
   FhO3MvNPNrOoxSdK43TLdIl1yDNcFuIwkLi3ZtlQ7ULAstrm26J22D/Qn
   D9z2syZku79ySgQPM9ehfGwOGMcGoxmmnqz5W7TzZJgL5VLiHXgJAVJq5
   A==;
IronPort-SDR: lhHbfccBTdEcA0H20bu/mn9j4IU5E4cMb34lKtx+vzGdCX7w2kDFswJtzeFJqO8giy1XwqOluN
 1k5gzN8nQBtLQgZAC+TT0zKbJJUWV0XTw3BKSrFk+0gv3JSZ9NRCBhCkZA4Xpnzik7+kfG7U+B
 Z3cZUj+AnS2iFfJXlUZ32KRocKncJRjkQbl7WJKzzRzg2RgIz5uegDGN6Wrei2NrqUQlngvhIk
 IIvDeuyPaxFlKahlkmZ+E8EgTOFu08lEoPgUUHvUBu+uUeW5AfYYNBngs/glGzf3WIPcO4mpz+
 vvo=
X-IronPort-AV: E=Sophos;i="5.64,556,1559491200"; 
   d="scan'208";a="119289938"
Received: from mail-dm3nam05lp2055.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.55])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2019 01:26:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gl3+vV6qq8/raetRS5Neqmrdf4hPUosyP7Ohrt9DjphU/ktKwwhRBwbDVYlYObluJJaO/oFh2VX1gnNMmDl81zbQd++AP7HUuOYH/muQJwbFgkx5bDkDu9H1rPiAb7Iy/nxwITgDxUwH5//MWQRcts5UKgq3s0J/hdnLFR66/FwKuy6soKglDSszOMsLbMPcibIsIKSSO4FE6/+D6b9AJ8yi212hFelEzl/gCpxfsiKosN0dY/jV9rmFPBAYwE4x2Tv0BxhDy10fCm6vg3mtGfSb6Uto4JqBaCITi/OvZgD5c3rv2osNTGv5PUbwYMadoYIQKIe2RVcNK0km+geGQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJNZBNbdki5ROdFHtOXeQTi05SGaNQ5n8bWH4f717ew=;
 b=WXjvOLBTVmZNbgRTBsPHt6IOFOoQhTgHF2ES69PznM/dTLZNFz9s9zmCKZCZVoVzqET7XbSn7sEWQuEYKISuPrVQVbnPmYFf6SfQ1ZSEfb0slPdiHOw2Evg4UUWhI9Ngp9f9vDS8bBbqtj5C3fafViKrA3hoWuAaJ6NNPgLYDj8NrEU+FCUdtFfbEQf9oXHhcPtCGuqhFhLxVt7UhFMgB5Xh+MMsAzeBYhKhEI+HT3oTWsRIjZ0pKLWRotYHy2BKTak+RW3QTA/ROpchiHH8EJF+QvNrHqIFSH2Gt+W8/OJ7SNGkwVnZg5IclS3iIytQpRbDVD4QsBplWl/n9Khxmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJNZBNbdki5ROdFHtOXeQTi05SGaNQ5n8bWH4f717ew=;
 b=GDxnbCyqnsnoePtF6FGwhJi8VglN0ob60PGBr1WkJ2H1bZL6lpca4cheK1ibJkPXGW9PDqzpzimxq1ujFR7SYuaioqRpzL9+Vw7pz0REVDhrFhb4NZV1owt65IVE26pz/XqDKFVVkta0iddIcKxPd9zVwJsFmnpqdvqy3v8W8ZI=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4071.namprd04.prod.outlook.com (52.135.215.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Fri, 27 Sep 2019 17:26:00 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::9821:67e1:9799:b117]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::9821:67e1:9799:b117%3]) with mapi id 15.20.2284.028; Fri, 27 Sep 2019
 17:26:00 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 1/2] blk-mq: respect io scheduler
Thread-Topic: [PATCH 1/2] blk-mq: respect io scheduler
Thread-Index: AQHVdQSz1R5UWPhzK0WufyKE7KOizQ==
Date:   Fri, 27 Sep 2019 17:25:59 +0000
Message-ID: <BYAPR04MB58166A77C55B3B8667B37554E7810@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190927072431.23901-1-ming.lei@redhat.com>
 <20190927072431.23901-2-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 238f637c-9a6e-43d7-8429-08d7436fc3c6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB4071;
x-ms-traffictypediagnostic: BYAPR04MB4071:
x-microsoft-antispam-prvs: <BYAPR04MB40719DFA789C9A789A50B23AE7810@BYAPR04MB4071.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(189003)(199004)(2906002)(66946007)(256004)(3846002)(6116002)(486006)(316002)(8936002)(52536014)(476003)(446003)(478600001)(74316002)(26005)(53546011)(7696005)(86362001)(99286004)(6506007)(71190400001)(229853002)(71200400001)(7736002)(66066001)(33656002)(5660300002)(14444005)(76176011)(186003)(14454004)(25786009)(76116006)(6246003)(4326008)(305945005)(6436002)(110136005)(54906003)(81156014)(81166006)(8676002)(55016002)(66556008)(9686003)(66446008)(102836004)(66476007)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4071;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ys/bb0/E5fS/cjskou9eoAz1I7NKHDEyZxJlbKjaeX7iwizjzGt4bBQI248qNt3E+3v4slBn5uaFsYQiqhVhi0Yt5ZI5c7P/8bvO2J8kCt3FXA92+Im0pZZtxd2/IvfYkQ0JXZPLFjWboqcbyBOliZOgTEppcg0+3MpyKyuGngBnkWioBo/23fPeeVtn9CE3Qxi60mzdHr7dWYWCv7XD2EUV2YZaVpphy+pgAm+0NMbRZqbjHmi2HfSfiYgfLxIe4ifCTs5HBUiozgbgw3M6sVCRujvMVMp3u2CO+rjENCEAH5999qYaRubOMibXBH87om0RQ4E+vJdzvRjT+2fTkJyCZ2sj8rpbvl8Exz+g/IQalWAsY2cGSE+dpmzrh3cM2sHYtaM2sTeUnmYIjxWiK3FpN4N3s7cfAC3qWqi/21Y=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238f637c-9a6e-43d7-8429-08d7436fc3c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 17:25:59.9673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hYMJnjWzVnVk8euXa8t3udbX5aAKfvHFVk6pek93TV25PY1Jl60IPDCKu6uAVSP1Q+k5D7RAHEgh1XM3j9NpEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4071
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/09/27 0:25, Ming Lei wrote:=0A=
> Now in case of real MQ, io scheduler may be bypassed, and not only this=
=0A=
> way may hurt performance for some slow MQ device, but also break zoned=0A=
> device which depends on mq-deadline for respecting the write order in=0A=
> one zone.=0A=
> =0A=
> So don't bypass io scheduler if we have one setup.=0A=
> =0A=
> This patch can double sequential write performance basically on MQ=0A=
> scsi_debug when mq-deadline is applied.=0A=
> =0A=
> Cc: Bart Van Assche <bvanassche@acm.org>=0A=
> Cc: Hannes Reinecke <hare@suse.com>=0A=
> Cc: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Cc: Dave Chinner <dchinner@redhat.com>=0A=
> Signed-off-by: Ming Lei <ming.lei@redhat.com>=0A=
> ---=0A=
>  block/blk-mq.c | 6 ++++--=0A=
>  1 file changed, 4 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-mq.c b/block/blk-mq.c=0A=
> index 20a49be536b5..d7aed6518e62 100644=0A=
> --- a/block/blk-mq.c=0A=
> +++ b/block/blk-mq.c=0A=
> @@ -2003,6 +2003,8 @@ static blk_qc_t blk_mq_make_request(struct request_=
queue *q, struct bio *bio)=0A=
>  		}=0A=
>  =0A=
>  		blk_add_rq_to_plug(plug, rq);=0A=
> +	} else if (q->elevator) {=0A=
> +		blk_mq_sched_insert_request(rq, false, true, true);>  	} else if (plug=
 && !blk_queue_nomerges(q)) {=0A=
>  		/*=0A=
>  		 * We do limited plugging. If the bio can be merged, do that.=0A=
> @@ -2026,8 +2028,8 @@ static blk_qc_t blk_mq_make_request(struct request_=
queue *q, struct bio *bio)=0A=
>  			blk_mq_try_issue_directly(data.hctx, same_queue_rq,=0A=
>  					&cookie);=0A=
>  		}=0A=
> -	} else if ((q->nr_hw_queues > 1 && is_sync) || (!q->elevator &&=0A=
> -			!data.hctx->dispatch_busy)) {=0A=
> +	} else if ((q->nr_hw_queues > 1 && is_sync) ||=0A=
> +			!data.hctx->dispatch_busy) {=0A=
>  		blk_mq_try_issue_directly(data.hctx, rq, &cookie);=0A=
>  	} else {=0A=
>  		blk_mq_sched_insert_request(rq, false, true, true);=0A=
> =0A=
=0A=
I think this patch should have a Cc: stable@vger.kernel.org=0A=
This fixes a problem existing since we added deadline zone write-locking wi=
th=0A=
commit 5700f69178e9 ("mq-deadline: Introduce zone locking support").=0A=
=0A=
Otherwise:=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
