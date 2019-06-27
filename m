Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFBBC48BD7
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 08:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6F02082F
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 08:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="X5P8jop+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SIB9p9zW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfF0Igc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 04:36:32 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:45715 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0Igb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 04:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561624591; x=1593160591;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=VTnag0kFBUam+ChtYwKrb91bkSl8+F0Thk+24f0TgUs=;
  b=X5P8jop+5StuKJUdxK8ZgiZhZxisNFCtOCGYgGtjrmtiilLQ+lceCSPm
   991+uyA0pN0Z/SjfuLk00Cho9OcOgQVTvH5ModEcsc+ov9vxgulAjfbkx
   tsgLnNWJKzyb6ReJP7afiIC4T8m7koka8Qqv+eFhVJBO7rpJkNhlmbxcA
   kfYB3bsjmWOlKbEEOAGpxfiENhXM2eC0eIWRteOeJCHtIHEke8j4RwEGI
   LeCC9f5l5m3YtSf8UWRdLhlRaJN7A/IG8pnRsUVJMoWEadab8/n7nChxR
   MIW+CjUCOh61PeMpk2L4bC80fIW6lX8S0iCB1HG6Adn5DW0qMYwjQzIRY
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,423,1557158400"; 
   d="scan'208";a="113299421"
Received: from mail-by2nam01lp2058.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.58])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2019 16:36:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=hBU+Ji/Ya8DUjGYrLPbua6ZGon9USxPbsv182KEXKu9v3mI84JZOGKopeQYxHhZYSf8DdheXx1fSFjdHobtG8D4eYD/bDqm++eRUV/yPaLyZwGa1lMoBft8mVKoIw1kgyu0D7Freg1YEv3rl9sV/9QmrwUfFz/ufw67HA7dosT4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBm/88B2pqI9XdO+nSlPL5jC+AYtW1ra9NlC6tWjWfQ=;
 b=ZU+OYGEhbUjCK2lHSHaDbCcua2aqGjTb9MxC+5GPRQK2YFLdLsrcVpENBp0F1TiCUZPhUYePXwrczS4X88tdGz/gSip5jz2InD2ozaU/gjAF2CEfOTr6Vy+prfGJn4OnwwNvPUUxtH6LCbSUNzyUlEVMDKTk1WWGnrmAgoPPVqU=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBm/88B2pqI9XdO+nSlPL5jC+AYtW1ra9NlC6tWjWfQ=;
 b=SIB9p9zWqxZR3PxocxIiS3wU1AXhapcmpuvIkuJRHs/MlRpnE7Qj+r6qeh6MY9EUXEh6XRF5dTT11YqzTYnUBEadKudjczZQnsaBBy2Y0nhJw+J4lK5hpMKnIneTD1LvoY3apLtEDSiYcpf9NAQQJY6z3UNO3lDb+UgyRaXsW38=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB3832.namprd04.prod.outlook.com (52.135.214.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.17; Thu, 27 Jun 2019 08:36:30 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6%7]) with mapi id 15.20.2008.017; Thu, 27 Jun 2019
 08:36:30 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Ming Lei <ming.lei@redhat.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V4 1/3] block: Allow mapping of vmalloc-ed buffers
Thread-Topic: [PATCH V4 1/3] block: Allow mapping of vmalloc-ed buffers
Thread-Index: AQHVLJMD9dFUXSCKoEarjaRxND+ocQ==
Date:   Thu, 27 Jun 2019 08:36:30 +0000
Message-ID: <BYAPR04MB5816C9C9B2E142F3A09F7603E7FD0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190627024910.23987-1-damien.lemoal@wdc.com>
 <20190627024910.23987-2-damien.lemoal@wdc.com>
 <20190627074720.GB24671@ming.t460p>
 <BYAPR04MB581604217983C81B2BA5BA4FE7FD0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20190627082513.GA11043@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26941f6b-eec2-4595-fd0a-08d6fada8d5e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB3832;
x-ms-traffictypediagnostic: BYAPR04MB3832:
x-microsoft-antispam-prvs: <BYAPR04MB38328D93A94E2CDC2635E016E7FD0@BYAPR04MB3832.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:397;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(6436002)(53936002)(478600001)(54906003)(86362001)(6916009)(7736002)(316002)(71190400001)(71200400001)(55016002)(6246003)(9686003)(64756008)(6116002)(2906002)(3846002)(229853002)(5660300002)(4744005)(52536014)(73956011)(66476007)(76116006)(66446008)(66556008)(91956017)(66946007)(14454004)(186003)(33656002)(66066001)(26005)(72206003)(8676002)(81166006)(486006)(68736007)(256004)(25786009)(14444005)(102836004)(74316002)(76176011)(305945005)(446003)(7696005)(99286004)(53546011)(81156014)(8936002)(476003)(6506007)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3832;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Llc+SUayGzjTjO5yCLW1ux+K58EFrBuiOEflSNgeW862S/qxL0Ab8iW1qwqyph6Y0fqbehJm2pnKdNqPCkTrT2VAQsQ91XnI/+NPjtfsgO/mVzMPJPH4qn3JeepclpoNHVq+GDt+wteBU8HuGXFRXKwAl63DEWKCN9sagyR2VvfQG3Dnqhy3AJCnVHkDKJhyWN/f/Lew0YtjT6FeD+PgXR8T6Xp8YiIWmSJ7uZ/6w3EikC7J7CjVEyDRWJVe9vZq0Hrhs7JhOlrV83mAUVBaLMf+RUfjXRY9AQotuzfWYGUmHkgUYLT7FxcTaUPixEiZrz/W/TZDSFZVTHp4yfMnfOkJVTDDWwXUYBicbW+zhc5XhCpPHt5VcWyjCjluat6btt44RExh4o4Jl0s9z1F1ubz4R7skT9nqY/GHzow2Tbo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26941f6b-eec2-4595-fd0a-08d6fada8d5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 08:36:30.0641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3832
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/06/27 17:25, Christoph Hellwig wrote:=0A=
> On Thu, Jun 27, 2019 at 08:17:08AM +0000, Damien Le Moal wrote:=0A=
>>> Are your sure that invalidate[|flush]_kernel_vmap_range is needed for=
=0A=
>>> bio_copy_kernel? The vmalloc buffer isn't involved in IO, and only=0A=
>>> accessed by CPU.=0A=
>>=0A=
>> Not sure at all. I am a little out of my league here.=0A=
>> Christoph mentioned that this is necessary.=0A=
>>=0A=
>> Christoph, can you confirm ?=0A=
> =0A=
> Ming is right.  Sorry for misleading you.=0A=
=0A=
No problem. Sending a V5 with cleanups.=0A=
=0A=
Thanks !=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
