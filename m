Return-Path: <SRS0=+9gR=V5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629BFC433FF
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 00:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23EA4206A2
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 00:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cWtBwhzX";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="e71GYUCA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfHAAxX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 20:53:23 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:61312 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfHAAxX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 20:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564620803; x=1596156803;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=BAWhRZkUxvsEn/dwkWcxCRNdhGJLXFDVmVG6DHuYoOI=;
  b=cWtBwhzX+w1qTG9ozUNmXep3rOnOzeYw2HjFVTzaLVXfEGIYI4vUDhct
   Bw6CXHE/0ZongUNATUFcd+novi1TwKXRGs4l12r/ZX4f+09YoeIoXaPxL
   gqFtTbbTvlnh5H18HTlFSeQnz5g04Wn9vfeEmdEJEP679/am23iLZeTEy
   m/knidAcWlxxyhpv86bDrtSWMTNS0re40PumMyUavErmrBeoXEzj6SZpZ
   ygpen2awcvFCWZUDqpwg68rPVn1/nFwaJ4+p0LT8OdAYHT2tXoXgQ7Y5a
   Dw4Hz5CXp7KIkK+GpXk/WY+zwBPd6eBiqTQzZHjVXGEFKssswypAttkL2
   w==;
IronPort-SDR: wuO8uuxOSreyqM031muxDrqso7KAH1LKmSzJJ/dEd2BZBDBcfzGKQs5BY+HhVZj2xG87oxGeYJ
 kIskDjGFcA5W2KQ1GjbzZMA9+iYGTlnDOUzoY3S4hPeKmXA9y6bTehIhgyryJUNWcizKW7okFu
 eo1wXa8RrxfMx0wQOV+QSDO48bkp67a/6RTaaHJ5Z9eV6ztG/8f8J0OwJnISt40KHh/cZwyAyd
 nl7vhcrIWW+jD28bWewsnI59NEI76scQhYtRAz7ndrmEK+B1AQZRTEqSX7JuacQ2qObKTeChxw
 wec=
X-IronPort-AV: E=Sophos;i="5.64,332,1559491200"; 
   d="scan'208";a="116246942"
Received: from mail-by2nam05lp2052.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.52])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2019 08:53:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcgG1cl0pCayLeRcUt33RK0zAk+g7/JufQjp+pR+QKh8oFx0ZO+31BSPNN7YrHUXFPNyPVglQuCTCwfeaTjr0AUlAkugMB34jTiAXgzlgSSqkIqcF9fMopGdUjg44LXgR1QOnzoIEfa2fA3vX5GiwyX1WxSikZzUj2RxMKC3HPMNxaDG+LT1muKA3qcxuW+zeP7S4C5FUwsaQ00uZiVos81amkZyRV8YhgbZCfxWdMC2Clh140OQSOayQm8JrWwImityun6/a555vXCktySaoMeSGqBppvni8CQTKUseovL2rsIEPjC1OhyRtZ7GiG271zf81mPA2BpTSavK7DwzTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/Q+sMbhr5tHuR9BlxqaJL5ngOe+Fed7EoEgEWhquVk=;
 b=W5Aq4HwzqrG+3gFLu6YaWOyXAUnZVDi0ZE9al1/frrQBvGPd+pk7NH2Vqajsg4It5mWb3oqfgMuP6ky1KJMUC+LG3UEu94eqQVocqzZ8lFJvR7H4cqisY4++cppCFBJUVRMhUrHgeZe++kMo1GXtREh5EXUN+uFmtjz0l9vBM3Ta9MBfLRxVEQAzp8Ij1BeVPkfNUUqV3An9lggKBxW5qwo4HWUwJi2Lf8rS8a2aq1O8JVZgL0/55sBq2QNQB5I7HqA/ptOcvcnDnvzpRMjOZhOoq8hIZgW20YyKJF5ZYqvhkL4W/WOJ8T3MVtxTbHIJxjHblkOOcjOthnDQFkmRyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/Q+sMbhr5tHuR9BlxqaJL5ngOe+Fed7EoEgEWhquVk=;
 b=e71GYUCA6gzgh3ie6f1AgGfIqnpymoJ6hvG/3dTFL2iH9pem4sLpFdtrRdkCek2hcnAzG94PX+XSrofNy5h4PooinVmQiynd5whQVtiNM6trLOXSuO8FZy8mfyXM3dOV0fUrwYh21v9T33b7IdqeFcOq76sCXSpSjmV3U575SVY=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4888.namprd04.prod.outlook.com (52.135.232.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.13; Thu, 1 Aug 2019 00:53:21 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 00:53:21 +0000
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
Subject: Re: [PATCH 1/4] block: add req op to reset all zones and flag
Thread-Topic: [PATCH 1/4] block: add req op to reset all zones and flag
Thread-Index: AQHVR+MlYq1Yh2zGykm2rP4UhuLTIw==
Date:   Thu, 1 Aug 2019 00:53:21 +0000
Message-ID: <BYAPR04MB5816258729B9EE74E81129CAE7DE0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190731210102.3472-1-chaitanya.kulkarni@wdc.com>
 <20190731210102.3472-2-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65841d84-cedc-44f1-0e2d-08d7161aa670
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4888;
x-ms-traffictypediagnostic: BYAPR04MB4888:
x-microsoft-antispam-prvs: <BYAPR04MB488855168BC6A5E75C322C0DE7DE0@BYAPR04MB4888.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(199004)(189003)(14444005)(68736007)(186003)(478600001)(256004)(2201001)(7736002)(66066001)(76116006)(110136005)(66446008)(33656002)(446003)(55016002)(8676002)(2501003)(53936002)(53546011)(305945005)(71200400001)(71190400001)(91956017)(102836004)(9686003)(476003)(64756008)(6506007)(66556008)(66476007)(66946007)(54906003)(486006)(5660300002)(7416002)(3846002)(76176011)(8936002)(86362001)(4326008)(81156014)(81166006)(6116002)(25786009)(229853002)(52536014)(26005)(6436002)(14454004)(7696005)(99286004)(74316002)(6246003)(316002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4888;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Wm3zmx8z2bRHPY3N64R00FSnOOSF6P2sbzlKok9LMEm4CdS6gw2TExMYxFLlquFZcCOGtGU1IqQSOCWuQmQJJaJ8Q2DVeScttEnSuh5L92SYhRbTe79V4G6N1TlEuaKfIx3uiykZTdoZWqXsOY0ZD+kEW8Uoz6a7if0uqMS1mNUenxn3RmAs+kBKaK6P99cVkCoBq/3nkEZJ3OOZjSenaQM6UW5adN0EhYAkzd+ediXSM/H0eyOJjiacUwDgT7TVDR3wZAwk9KPRgYZ6tOc+Kx6F6I3/s/jNt2HGX/MCiO2hfNXyIQk3LOIr2Mai0gnxZb39QWXIky8h6axF0Juuz+dLs4ylgog7yHozP15y+sfKLv7Ta0mYGDcQ07/8g864YmOXRKxMuXy0VU9VU2IpITR61phSGpRRcHg6ANnm6vo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65841d84-cedc-44f1-0e2d-08d7161aa670
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 00:53:21.3087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4888
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/08/01 6:01, Chaitanya Kulkarni wrote:=0A=
> This patch introduces a new request operation REQ_OP_ZONE_RESET_ALL.=0A=
> This is useful for the applications like mkfs where it needs to reset=0A=
> all the zones present on the underlying block device. As part for this=0A=
> patch we also introduce new QUEUE_FLAG_ZONE_RESETALL which indicates the=
=0A=
> queue zone reset all capability and corresponding helper macro.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  include/linux/blk_types.h | 2 ++=0A=
>  include/linux/blkdev.h    | 3 +++=0A=
>  2 files changed, 5 insertions(+)=0A=
> =0A=
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h=0A=
> index feff3fe4467e..3991b580d6bd 100644=0A=
> --- a/include/linux/blk_types.h=0A=
> +++ b/include/linux/blk_types.h=0A=
> @@ -282,6 +282,8 @@ enum req_opf {=0A=
>  	REQ_OP_ZONE_RESET	=3D 6,=0A=
>  	/* write the same sector many times */=0A=
>  	REQ_OP_WRITE_SAME	=3D 7,=0A=
> +	/* reset all the zone present on the device */=0A=
> +	REQ_OP_ZONE_RESET_ALL	=3D 8,=0A=
>  	/* write the zero filled sector many times */=0A=
>  	REQ_OP_WRITE_ZEROES	=3D 9,=0A=
>  =0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index 1ef375dafb1c..474008bffee2 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -611,6 +611,7 @@ struct request_queue {=0A=
>  #define QUEUE_FLAG_SCSI_PASSTHROUGH 23	/* queue supports SCSI commands *=
/=0A=
>  #define QUEUE_FLAG_QUIESCED	24	/* queue has been quiesced */=0A=
>  #define QUEUE_FLAG_PCI_P2PDMA	25	/* device supports PCI p2p requests */=
=0A=
> +#define QUEUE_FLAG_ZONE_RESETALL 26	/* supports Zone Reset All */=0A=
>  =0A=
>  #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\=0A=
>  				 (1 << QUEUE_FLAG_SAME_COMP))=0A=
> @@ -630,6 +631,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, s=
truct request_queue *q);=0A=
>  #define blk_queue_io_stat(q)	test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_fl=
ags)=0A=
>  #define blk_queue_add_random(q)	test_bit(QUEUE_FLAG_ADD_RANDOM, &(q)->qu=
eue_flags)=0A=
>  #define blk_queue_discard(q)	test_bit(QUEUE_FLAG_DISCARD, &(q)->queue_fl=
ags)=0A=
> +#define blk_queue_zone_resetall(q)	\=0A=
> +	test_bit(QUEUE_FLAG_ZONE_RESETALL, &(q)->queue_flags)=0A=
>  #define blk_queue_secure_erase(q) \=0A=
>  	(test_bit(QUEUE_FLAG_SECERASE, &(q)->queue_flags))=0A=
>  #define blk_queue_dax(q)	test_bit(QUEUE_FLAG_DAX, &(q)->queue_flags)=0A=
> =0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
