Return-Path: <SRS0=+9gR=V5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE84DC433FF
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 01:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76872206A2
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 01:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ko0sdWwN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hGgRuuzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfHABDL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 21:03:11 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:18385 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfHABDL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 21:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564621413; x=1596157413;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Q/Ed+vRJrKl6Gcl0RoZS2yjGTYMYCAs1pzBkbMkrLvY=;
  b=ko0sdWwNs+JOzEc2B6B2ekotEshC+9bgGTmF43TKSjfiUL9luXGUoOLu
   7vwB1k34A+fg/C6mxZzE7wfcMaIWVHXrYNeo7uvq8y6pWB74oAQJGO3CT
   RWvZYUwD7LHTdbtsLXcf+d4QNaUGsSKkyXjS/hXwVQM9MuvSCKNQFit90
   itA6iuedupBR04+6keTxonv+vnE44bhkvLimhr90heAYII73SHaiOoa8g
   cDTczJukdgc6DXLDZCUx4et//vujF2nGot0VH6PVC0T5MAZgw7cKh3MD8
   T7uG5faOrlMG9ZRh6z7/TIQIXOh2w1dzbkh7vsIJiTLD0B3QjviU7qqzF
   A==;
IronPort-SDR: WX5D/G16O7qRdLLJIBP9GDMWVljfapJqdF3AHxAqaGp+AV4FP3nFZAEIwEABd1PmJzexvodf7J
 Z5Zbn2Yvoxr9svu9M0pT4musfwz9Gr354loYkGQlYvA7Y38bOYcH4s0ZrcQorax6Z1vLH+pqdL
 W4b6z+Kf030KB4m7PRIXGL3tzk+BQ4gcAYy42UqZorelKQ3OBc+t02X0WF765eaj02a3AByzLn
 2ptZyG1PQjGNRzcAm+p1mPb4aav5PcL1UTfmC+1pYSR5Ppz3m+QOeZPf8fUesSqC5bpy9733a3
 VbQ=
X-IronPort-AV: E=Sophos;i="5.64,332,1559491200"; 
   d="scan'208";a="214849330"
Received: from mail-dm3nam03lp2051.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.51])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2019 09:03:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocO4GJ03TMDlwaBZbm9SnjkHRX9NmXqaNF7V4O45GBxFWhQDkjBNOAGLON9tKZXRPL95LxLHB6AhN1Kpyp61GbfR9oifjyrrYnWnF+0UpKuib4qFHhoFM9coFuQLlpIj/8RIEptSCrrgE/t36YoWejj667Fbkj7ckK8KmfhU0qQ5+cLu5zaC/Gnm+teISD8vAufFdR5YmpQm8uowyaodlkdofrUxhR39QnLLxcF5sz4PqypSyZwqyLkztufXGldxQ+jUHVKW5UCn+HLmpBGPudQQ7O7NrMl0DVeiBcJRbUhWZXg8dZnCFvrdA1txtQNAP2jFN/DD1Ly6Ug8URcnx7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//COLcpiS9qJ0W9fkCP1bQYJS/tjDNumZLOL7wlqBRQ=;
 b=KfPmUHGG7KmioZGj+6wTTUcZtvcv6L99O4EG+qPXwKZz0sbXz5GUSocVbnxm711YH70WdosY9s1PcYjE1DAGKWT+Hp0+que5UrHijzHXilwcUjlM2uiee9qMs7RPHTeV/Mt9jU5bh3NH4ZHUE1u3k+2m66fMjW/RzSoY+SR8E4K0CBrRSpQSsHgAU2sJ0CCeGD6cr06u//hp/fXyxQtZ9ryh5JSkfc3PblgRnt4iQ6uE3OB7Ealafqc0YqO1bzqN0du4hw2G2D2kKD7Z2j0GhaRxKSyNsBCf8QTbJViplspihyKrX1EA6J4DTLCshshcRqiD8/41ibvuFnVjKc9ZZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//COLcpiS9qJ0W9fkCP1bQYJS/tjDNumZLOL7wlqBRQ=;
 b=hGgRuuzGulKB9SmZZ4OkISZoTm86dAIPCmg6SCDUSGnx00oLsdP/ZqwelPtzZuRbDTdoa8gcwLWdJER1vtnzXtJHlf599IJ26EqW+tC/tyPgkOed0YmettBmb7aCIMMp4fj7U093ZAA6IhdZA3bmccEw93Kazjws6FuPcuPst40=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4406.namprd04.prod.outlook.com (20.176.252.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Thu, 1 Aug 2019 01:03:02 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 01:03:02 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "dennis@kernel.org" <dennis@kernel.org>,
        "hare@suse.com" <hare@suse.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "dennisszhou@gmail.com" <dennisszhou@gmail.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "osandov@fb.com" <osandov@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [PATCH 4/4] null_blk: implement REQ_OP_ZONE_RESET_ALL
Thread-Topic: [PATCH 4/4] null_blk: implement REQ_OP_ZONE_RESET_ALL
Thread-Index: AQHVR+M6z7fLv5/iAUalRnpmDCPqmw==
Date:   Thu, 1 Aug 2019 01:03:02 +0000
Message-ID: <BYAPR04MB5816425944393735F14C0DFFE7DE0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190731210102.3472-1-chaitanya.kulkarni@wdc.com>
 <20190731210102.3472-5-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 132adda0-6379-42c1-25bd-08d7161c011a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4406;
x-ms-traffictypediagnostic: BYAPR04MB4406:
x-microsoft-antispam-prvs: <BYAPR04MB4406E6ECAF53F14170DF7581E7DE0@BYAPR04MB4406.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:741;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(189003)(14454004)(476003)(76116006)(71190400001)(7696005)(6506007)(53936002)(53546011)(2906002)(316002)(478600001)(86362001)(66556008)(76176011)(64756008)(66446008)(110136005)(66476007)(26005)(6246003)(52536014)(71200400001)(186003)(5660300002)(68736007)(102836004)(66946007)(91956017)(9686003)(2201001)(256004)(7416002)(229853002)(6116002)(4326008)(7736002)(25786009)(54906003)(99286004)(486006)(81156014)(81166006)(8936002)(6436002)(66066001)(305945005)(8676002)(33656002)(3846002)(55016002)(74316002)(2501003)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4406;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GVjgWj15wTgJQjXzRaq6diX31nPjBC7Ex1OG10megMD5xaS6fJC4jIt7SxSopn4/j3L2HshLPWlm+F8siuzPE8iDv2Q1UxacGz3Oa7Z4DaJNdDSXFFS0V/rNGrB3YsqboKUfCMlJv4L0dNQaHguyChvCjFZ67hhccJjtWhVCcKXMtRCZJK+d+VMzJN9pKxQedz9lSiFps+qFaD4huI7MdK/JrFbPi+9em6X0Qk6+0sRpG5YwfgdmiuqFkszeXSuPlh1QMhklofGK2ORYul8IXDXb0mNGepQuIDu+dX2rOy9g7F27jKRHLeUFTQiVz58PH4u596PGRIiEaLhOiT3PJ7iKXR+uONRQWY/kE8tGbM0A4D5o0naVHN83DHnrJIL1jy2mYItVK2DR8Ekh62oNDaHMMOV25AJ2YpcT1HLCTWg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132adda0-6379-42c1-25bd-08d7161c011a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 01:03:02.7202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4406
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/08/01 6:02, Chaitanya Kulkarni wrote:=0A=
> This patch implements newly introduced zone reset all operation for=0A=
> null_blk driver.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  drivers/block/null_blk_main.c  |  3 +++=0A=
>  drivers/block/null_blk_zoned.c | 28 ++++++++++++++++++++++------=0A=
>  2 files changed, 25 insertions(+), 6 deletions(-)=0A=
> =0A=
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.=
c=0A=
> index 99328ded60d1..99c56d72ff78 100644=0A=
> --- a/drivers/block/null_blk_main.c=0A=
> +++ b/drivers/block/null_blk_main.c=0A=
> @@ -1214,6 +1214,8 @@ static blk_status_t null_handle_cmd(struct nullb_cm=
d *cmd)=0A=
>  			null_zone_write(cmd, sector, nr_sectors);=0A=
>  		else if (op =3D=3D REQ_OP_ZONE_RESET)=0A=
>  			null_zone_reset(cmd, sector);=0A=
> +		else if (op =3D=3D REQ_OP_ZONE_RESET_ALL)=0A=
> +			null_zone_reset(cmd, 0);=0A=
>  	}=0A=
>  out:=0A=
>  	/* Complete IO by inline, softirq or timer */=0A=
> @@ -1688,6 +1690,7 @@ static int null_add_dev(struct nullb_device *dev)=
=0A=
>  =0A=
>  		blk_queue_chunk_sectors(nullb->q, dev->zone_size_sects);=0A=
>  		nullb->q->limits.zoned =3D BLK_ZONED_HM;=0A=
> +		blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, nullb->q);=0A=
>  	}=0A=
>  =0A=
>  	nullb->q->queuedata =3D nullb;=0A=
> diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zone=
d.c=0A=
> index cb28d93f2bd1..8c7f5bf81975 100644=0A=
> --- a/drivers/block/null_blk_zoned.c=0A=
> +++ b/drivers/block/null_blk_zoned.c=0A=
> @@ -125,12 +125,28 @@ void null_zone_reset(struct nullb_cmd *cmd, sector_=
t sector)=0A=
>  	struct nullb_device *dev =3D cmd->nq->dev;=0A=
>  	unsigned int zno =3D null_zone_no(dev, sector);=0A=
>  	struct blk_zone *zone =3D &dev->zones[zno];=0A=
> +	size_t i;=0A=
> +=0A=
> +	switch (req_op(cmd->rq)) {=0A=
> +	case REQ_OP_ZONE_RESET_ALL:=0A=
> +		for (i =3D 0; i < dev->nr_zones; i++) {=0A=
> +			if (zone[i].type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
> +				continue;=0A=
> +			zone[i].cond =3D BLK_ZONE_COND_EMPTY;=0A=
> +			zone[i].wp =3D zone[i].start;=0A=
> +		}=0A=
> +		break;=0A=
> +	case REQ_OP_ZONE_RESET:=0A=
> +		if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL) {=0A=
> +			cmd->error =3D BLK_STS_IOERR;=0A=
> +			return;=0A=
> +		}=0A=
>  =0A=
> -	if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL) {=0A=
> -		cmd->error =3D BLK_STS_IOERR;=0A=
> -		return;=0A=
> +		zone->cond =3D BLK_ZONE_COND_EMPTY;=0A=
> +		zone->wp =3D zone->start;=0A=
> +		break;=0A=
> +	default:=0A=
> +		cmd->error =3D BLK_STS_NOTSUPP;=0A=
> +		break;=0A=
>  	}=0A=
> -=0A=
> -	zone->cond =3D BLK_ZONE_COND_EMPTY;=0A=
> -	zone->wp =3D zone->start;=0A=
>  }=0A=
> =0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
