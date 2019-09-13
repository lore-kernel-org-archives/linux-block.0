Return-Path: <SRS0=03jz=XI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62745C4CEC5
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 23:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F3B72089F
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 23:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oTv9/sMA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ExKAMp7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404236AbfIMXC2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Sep 2019 19:02:28 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:54551 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404024AbfIMXC2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Sep 2019 19:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1568415748; x=1599951748;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=4mIhv7wcRoD+NQUuBVBR4EiECmhztDEHr8YMlKctSwQ=;
  b=oTv9/sMA/2fAcBRh7Yiukwk8IOCtNF8PvvJxNpE3ih4zbD9HLOaALayW
   8SZtVVKGWqUOST++1wXRtnSgtFAj4AC+ptRxRaUQjVOeopBr9ur5gl3HV
   JXkuqyNBpTcVrpNb8z7BebXrL+HREJMtVhDYPdawMzqU9+hhDG/L/Oa46
   O5FBWl/3wZedWYoDUZMpjcTIDonb2VgVDuVKqN6D5toK7yYnqCERNB54Q
   dyaKvu/wXpJbMkHORCR7FsDsppUw6G5h0rkFWVYfUw1I7N0wsRNdyweAP
   FWjl4nrzp1xBrTrtVlXITG4OWJMxcM4SGNlwqmbVhsLXuh1mmpZ9rpPrC
   w==;
IronPort-SDR: WQ4Np73b79MHJjSk7oQPnYqPSm/dCvV0lDAZT15lV7ZDZ28wan+QJjDh7fNpx0old1UUvnwQFX
 JuZ59zEHPh2R8gstk+YpV0BmTgAqzOAeIEipUH4eiGkD5BYnYXCi1Cww020CiyhsAbtqBlfEr8
 zd2vci66ZrsiaDKwQemq+KAI9XKRiHis9CENJSNlZnAeZWNCT6dba6ey3Mc1JqtxNiZ4QyOAyw
 O5Ov/9501kGUpQYZ3uhVCfvTvO9LQFcvvjbrWMpfYN+pM4PASDT9nbLULAxECnx9e1LSMz+KGs
 dyE=
X-IronPort-AV: E=Sophos;i="5.64,501,1559491200"; 
   d="scan'208";a="122736842"
Received: from mail-dm3nam05lp2058.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.58])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2019 07:02:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hd/zoHINrjENjT+uGpk1qZsoaWWzirdd+IK4aEi6ovRh9yuhOBpIlSDMB4TbMb/2nhyFOBCPz8rH9eKtrUEhGbxY8mBabDQ9cmVgJTCa1XwPcGLpWbka5s+bRzBO4rUWwgJzBXlvXqrL24eL5SVTun/OY2FHlnqn4GMOXD4ngrUriBovfe6MFIQPLsQcfKM2KZDwzM71isgKb9Nx5LFcS6s491D/4j4qkpvwY0M/3Vo8gCVS+f+dOl8gOSVp3lgLiHADXWg0uJ6XuEMBse3sDremNbFAn5zRhl91unLHUE6NOcEBKOMgrXfC46I5tQ4seS6KM7ronm+UsennqWboAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mIhv7wcRoD+NQUuBVBR4EiECmhztDEHr8YMlKctSwQ=;
 b=GRSxWak7ZusqftMqB+wnAt4/A6KPM0GKhKHeoyj3p5bUH+XSzyBTGgUD5XbaZopxq9p5jnRlNSLGuI+ualbEa8R1Mgvx6FFOt9O4YXfpLdngVripJlWg5c/8eFmJV0v1DLVw+Ihs4EiUdcyoJE/NZka5S821JWRN3DLdjlstp5VH9Dz6K3o6u4Y0Par2yCHKzbiq2lAv0rx0yfy5tNA71Wa6QE68zLKAP3sdiCra8905cLgELNA4rXU91tcx8XDv1CYsAKkXPH2SRs1aCZ/cLC827Xq1zGDcgawK+oSnUT7AoCz10dpRHS4Rnc2F1EGQq3Zi9ozIzjJBdZzn/O9SmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mIhv7wcRoD+NQUuBVBR4EiECmhztDEHr8YMlKctSwQ=;
 b=ExKAMp7UMwAxGxPauBBG0J/AXlmJLjvvOv19CvFNSoiA7AvRSDMaJxVZDbdGaZY9HiDWwq9wfVTTvSvw+/hHHqCoJTIzk8oCCd/1TPsXTDKT87icV0k83o6ZVlafgN2sQbzj7IrCLGUkQHqUujG92wC7YrZv3Hf748o409BJIMM=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5109.namprd04.prod.outlook.com (52.135.233.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Fri, 13 Sep 2019 23:02:14 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2263.018; Fri, 13 Sep 2019
 23:02:14 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH v2 2/5] block: Document the bio splitting functions
Thread-Topic: [PATCH v2 2/5] block: Document the bio splitting functions
Thread-Index: AQHVSLucVzVEov8uFkWSoTjYwgK01g==
Date:   Fri, 13 Sep 2019 23:02:13 +0000
Message-ID: <BYAPR04MB5749FAFD19DCFFBAD38A34C186B30@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190801225044.143478-1-bvanassche@acm.org>
 <20190801225044.143478-3-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c42dc93f-bbce-4e28-b56d-08d7389e6a9b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5109;
x-ms-traffictypediagnostic: BYAPR04MB5109:
x-microsoft-antispam-prvs: <BYAPR04MB5109B084B5F6B4B941AFF3DE86B30@BYAPR04MB5109.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(199004)(189003)(9686003)(7696005)(4744005)(8676002)(71200400001)(71190400001)(53936002)(81156014)(33656002)(81166006)(86362001)(25786009)(6116002)(8936002)(110136005)(99286004)(3846002)(2906002)(446003)(55016002)(186003)(14454004)(54906003)(5660300002)(316002)(486006)(6436002)(305945005)(476003)(7736002)(66556008)(66946007)(6246003)(66446008)(74316002)(66476007)(66066001)(229853002)(64756008)(76176011)(76116006)(102836004)(256004)(26005)(478600001)(53546011)(6506007)(4326008)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5109;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BoT4jbUlcnYXCTKe2m2d3KHR1JuSgJLZfFH/FSkE3MPL1YnY2knuRUYCd7Aj5Ij/ix6bge1sa79bkv8AvgcTuJJDgG4iyomfIcpAwFBXrGCcAydvst07wSd9du+ZEOl623JBSC5sN6LgiKletBKWrTSTrM2/v2LZ+5oksUpBFAvNxUMEj3fSsviqg1c2KEc/7xkYAo48hYpxxZc3lXQPtk8PgvcCrDjCBj2lwNxAo0J3VS6KFTQn4zh/QCAlN6l5wj4NIKpun97CaDIKLGW0gDm7c1lZNr3w9i9tZv9kIHB2MdYrct3WG4fwP0EPZxjuH5j45TLQsCsIbJjEY0JMLgXiqTHm1Y9UgoTHVpuM1mpwexWZqKedfYmyczD44ZuciKv/SsAyfiorsuRmdgBBTKYZ7xe6wTld+Iw//guFEqw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c42dc93f-bbce-4e28-b56d-08d7389e6a9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 23:02:13.9862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FmHiyq62gdbiJkxp3Gf07pR+2ss2658jkfRXEKGZppoYW+D7pBSoexLupZIWAa4mNggd0HhvaBLtFz7EK8Je2TflTMZ1dkNRDGAiyFbivjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5109
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 08/01/2019 03:51 PM, Bart Van Assche wrote:=0A=
> Since what the bio splitting functions do is nontrivial, document these=
=0A=
> functions.=0A=
>=0A=
> Reviewed-by: Johannes Thumshirn<jthumshirn@suse.de>=0A=
> Cc: Christoph Hellwig<hch@infradead.org>=0A=
> Cc: Ming Lei<ming.lei@redhat.com>=0A=
> Cc: Hannes Reinecke<hare@suse.com>=0A=
> Signed-off-by: Bart Van Assche<bvanassche@acm.org>=0A=
=0A=
