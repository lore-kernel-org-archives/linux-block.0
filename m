Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4069C433E1
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 19:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3071207DD
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 19:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mVplEwmt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="It085cds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbgFRTCW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 15:02:22 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:25364 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbgFRTCV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 15:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592506940; x=1624042940;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=OLYVsriUwYvORHkt1MBnAMwIY3r5vA6/9vs6yVzUPbI=;
  b=mVplEwmtFpjPIpGl21baqSrXmk7NSxc/d0UYkunj+k09OX3RqFg8ZjG1
   TY/oEAv1l+5oUgzUqpsMANAI4yNzPXsOV0ur3HSv9w4qkE+5EjXt8wE8E
   iEsSK5TTomsB0WQ5kf2NVmLI9vvWArAWDh7Weq40LmEaQZHI3GhxKuhDC
   wXftJnaW90mS1LVLhu1Yqu8Aw+Fvz5peL9kTAAVz1+k84Yz75krN4d0O3
   tWpCYFtPY/p0i8i6lDCLrw9ZsMQQ+yZ32ZrWl4YkpeCUa+uxqyPj12ofL
   gk8o2cVSC5PlJLJX1ZlD51rBdsZGLl04hHmFZXkEySXS9gzPTqCErkkhO
   g==;
IronPort-SDR: JEz1GmmwZD63q6GTUYJHkcnS48C4Qwdab8qyskRxSXXbDRFqcnRb33GQZ/j8pVPyzuho0I8LCu
 T7vozoVrIusOoON8171APNg0YmPr1p3Kd0gUG2e48dlXtZT0qrYuUolopRm4aU8rSzJdL7yofw
 Wwoc9DbyfaNqRJzUv9AqNgEC64T40z7KKpeR+kBDn6hHvauAL/cPu7YIEDPKEidwpOpgCTvhmC
 DrdNjk8LaZWEdnQTKG/VhWxqJ5d9+oZNx/f5TuOJLqnbX/zdckMtJtPZs7iWQQ07/UKFB8PuhP
 sFY=
X-IronPort-AV: E=Sophos;i="5.75,252,1589212800"; 
   d="scan'208";a="140347613"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 03:02:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hm8fWV/rB4eBoUHtJTQzorvIzG6O6lllx/otL/sEmzFDaq2cECZTtWawe/QPSSUP9ylLpNd/8BYGmMisfS6vGwAGDjERqDIY5gJ89E8TB9WuJQWynLB5RqnuUEnejcQ/SQBQvyopi4ylcAgqP7LFYmPndzXwZ9bB4Xu6E6y45LOM8qnWc6z6Hk7jVLb2h+52v3jIzoE9th1rINvuV9VyVyeQ8Zo9Ff9wqen+80gQV6+K8dWNVguuwYpsaQTl6O0oowkWGwXglYeZAXMlq6XxmhXqdkawciyCWpeDSpLT6VFytzyyz25X0ceAaCh/h4Ifi4/eFAZKzbwVD8POiMTdLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4UjFNilsCgEMM6dng7EiT2WwSyhXLpO0aAaDp4EN2o=;
 b=cILgunUi5S7tfiU4RVJH7WrteKxym43lJUi/Cv64JBl/BxF0Ac82ZbsiPFKPktEVowHr4QvIsrK5p3iWjnCxHZYYMuz/2sxnmRzy+s5gsA06WTNMDpK3V1BIcDAaex4kjHOt4xLwQxK9RWgyJgQER8hvSPahKKreu9JJldEFujuasXLHTtkQUcvedFlc/m9aXVm578elTRTWk9PO2RsuOT8UElipyEmfKYZUXx/IdOwYlxQKey8rcLwojzMXprS1VElyLKdzZ1mjROO0YbFT6dRX2gKleJwa3x3L96Kh3QnHlOShz/SowXOU8GUaUxVh3aqN0Pc7P4ql7I/jIwpb3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4UjFNilsCgEMM6dng7EiT2WwSyhXLpO0aAaDp4EN2o=;
 b=It085cdsf5zlvTN9rrjEHu1uy+2MZ49gP2d3Fs00Mw/Cbu/AbR2tYCyoEmLLbI2QQHGG9kSgAWlKvzO56MhVvyYs5z721J5CxOr0z1UpjKhw8RUhruGYMOlnVz1LxToceRlmr36ZRrwANv9AL4HElC4/ygsJKARu9UT4kzHfxf8=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5248.namprd04.prod.outlook.com
 (2603:10b6:805:fc::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 19:02:17 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3088.028; Thu, 18 Jun 2020
 19:02:17 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Keith Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        Keith Busch <Keith.Busch@wdc.com>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv2 4/5] nvme: support for multi-command set effects
Thread-Topic: [PATCHv2 4/5] nvme: support for multi-command set effects
Thread-Index: AQHWRYBY6dkcvfj5QEOv6Tpz1l2QgQ==
Date:   Thu, 18 Jun 2020 19:02:17 +0000
Message-ID: <SN4PR0401MB359866A04F054377B6F748B09B9B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200618145354.1139350-1-kbusch@kernel.org>
 <20200618145354.1139350-5-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5cc809c2-acfa-406e-32ee-08d813ba1ef0
x-ms-traffictypediagnostic: SN6PR04MB5248:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB52484653B08A3D6FC0AF3E1C9B9B0@SN6PR04MB5248.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q0Gcx+65JTBr/46qrcBlTJP21n6KfNu5nUnHodRUG3s3kevmSTH4EUWRu6sVBgqh2winDZD/BuwyWfjhsLQMZh5WlX20rfuiIwrkoOmm8wv3Dbo1MOyh3MOphLG12IGBcEpDfAZIDElZEmb9LdVlVFeMT+8nD2745WFebsvX8eV5yKhBShtncdHP8O9cn4340dTMBZFRPFmQo9GqFPmAVS3H7ei52QkMl+LvUVjREcoRwCp5qv3VnZdJlODa2d/4YBEvG5TtKvHhu9w1Id//nI87fl4T9EaeEHoZDN4Y+n4eZVhRSZPdDnp4PNMwH58C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(186003)(26005)(8676002)(316002)(6506007)(53546011)(54906003)(478600001)(2906002)(4744005)(52536014)(71200400001)(33656002)(7696005)(5660300002)(66446008)(4326008)(110136005)(66946007)(91956017)(76116006)(66476007)(66556008)(64756008)(9686003)(55016002)(8936002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: TJ8nzrqlPRay4nzBYYQWY/q4cf8qnB6EH06u4golgXqK/VWEuc9GHx2+/EbasHtx2gOzjIAzzX8MDTTkjQUgPN/wn6VMGm2arNbC3ymrR5hpUdJ7qSg35GpjSHmyVGwqfadfWjQ1nVy1itIG6+gJCo1PqOF43Kqyip+V0MIyCG1RBPigjiD9JGHch2CVA7UEfr6MlaIvFTv2Ah3UDoxSr/iPOKrXNgjxInX66WMqN8kUjTtB9NHzduIehRpSQGvrUcRZZxu8YED9Y2xy8CXwuCkxlmauazleGI0ro5744/Q2R8ZtUz1yuSZe1JNab3YQBa8bsS0Hgd7i6xpjHK3mq24APxwe16DMO/6WdaDqWQSEFIEAqh6Nfq5BRNn8smEXWPhSmLBguVNdBmwOSUozLR6cPbk/CYlrT5g3VX7pzQN8hxdBKi1k63Htwx8iz83AalxOACE4dtcZqQW6r5tDldDmSd5bw479sNPRiK8ZP+Y55uodHtFG+M0QwpcKwY23
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc809c2-acfa-406e-32ee-08d813ba1ef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 19:02:17.5079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1bXeVks9e416/ErTQEpLBpfAo0eARnl8i2CpCmlL8BMDyKoOuGmIuNpt1uWrhhW9Ddmp22EO4Ns5pre1r8dB3DL0IIq+looNkvlHUtON7l8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5248
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18/06/2020 16:54, Keith Busch wrote:=0A=
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h=0A=
> index a84f71459caa..58428e3a590e 100644=0A=
> --- a/drivers/nvme/host/nvme.h=0A=
> +++ b/drivers/nvme/host/nvme.h=0A=
> @@ -191,6 +191,13 @@ struct nvme_fault_inject {=0A=
>  #endif=0A=
>  };=0A=
>  =0A=
> +=0A=
> +struct nvme_cel {=0A=
> +	struct list_head	entry;=0A=
> +	struct nvme_effects_log	log;=0A=
> +	u8			csi;=0A=
> +};=0A=
> +=0A=
=0A=
Nit this adds a double newline=0A=
=0A=
Otherwise:=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
