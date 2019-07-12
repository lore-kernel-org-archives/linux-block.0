Return-Path: <SRS0=GKUn=VJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED91C742A1
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 00:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1679021019
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 00:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VMC+z0Gu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YkGeuHrB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfGLAwI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jul 2019 20:52:08 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:15118 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbfGLAwI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jul 2019 20:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562892727; x=1594428727;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=vNeUAl7sNMj2d9vYIXTchLpR6N22JmonanZ+iSOedhs=;
  b=VMC+z0Gu7JQC4Q1gfLbefS3XxMxSb/QMmDgRZpqPVGzhobDMN3UXra+U
   1aQCTVxiaHSSP6FflSn4b6gig131bbKNl4N7krcPrp2X6KMDhFH/Ugc+/
   6YQNZoBk2BIJG1DPZ/LtsMU3C2Nka6ney3+4jO/wLkPY0nRJAWzkzBcBb
   Yunrf6km6kU2dqDuzWmU17gnWO2kpAJ7DQ4LVJTUa5e8GeOzTUG5SRG3U
   3uKpFvbncW+mAQjlfOdJNsMzsi9Zh0whyv63T6+IhQX1C680qAh6cGTZU
   yOEripadBdtJbOxpEOPNmF0UonecRaTkv9heKyIE0AXCSqsz3SjRA+mnO
   Q==;
IronPort-SDR: 12atzZ1Pm52tkCdIU28oKZMuOsdIb/LBXMCGqTpVX5Mvj8VmHlAHklxX9Bt/D4mSeuo0I+lAgk
 4DbefdD1Lqp3J+K40lkHNC/nyQlQfaXNddx/suyHoCuAdq5uoyIyoKkOlWMnCds6/OcbEp+bqO
 WHnYhU8ZeUcml1fEM7UlN6KzYjv/jnifnPbUbK8CSD9BcUzXgQP07VLLwC2AT0JbwJk8JT1Z0I
 yIRs2lSTC4dCNTpLJCvjZ6yMS+qIYAYJBYzyO2DS0dQHw7mZCEra/KKITr8JVn03irG7yNfMvW
 Gcs=
X-IronPort-AV: E=Sophos;i="5.63,480,1557158400"; 
   d="scan'208";a="219259508"
Received: from mail-bn3nam04lp2051.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.51])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jul 2019 08:52:06 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNeUAl7sNMj2d9vYIXTchLpR6N22JmonanZ+iSOedhs=;
 b=YkGeuHrB4wyV5L152Wy8lu14uPYwzlBz0OZXA/lMSJov3wWLiUxBIjQN5xDi/2iMP22ygxXq4SpD7Z5b4B7Um+D5KK8fbxKkHb32Ot40o+xdPKOQ7M68vdPqxmn+/LKv4qhWSZSyjMZIzsWNjhzIPc/Q8qVMVwcSBkI+zYBx3C8=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4630.namprd04.prod.outlook.com (52.135.238.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.17; Fri, 12 Jul 2019 00:52:05 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2073.008; Fri, 12 Jul 2019
 00:52:05 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V6 3/4] sd_zbc: Fix report zones buffer allocation
Thread-Topic: [PATCH V6 3/4] sd_zbc: Fix report zones buffer allocation
Thread-Index: AQHVL8sveLyE842Ki02oZZ+qoDG8mg==
Date:   Fri, 12 Jul 2019 00:52:05 +0000
Message-ID: <BYAPR04MB58168DD2A9F429D515E377A1E7F20@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190701050918.27511-1-damien.lemoal@wdc.com>
 <20190701050918.27511-4-damien.lemoal@wdc.com> <yq1wogo85c6.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23f6199b-c36b-4af5-a0dc-08d7066328b9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4630;
x-ms-traffictypediagnostic: BYAPR04MB4630:
x-microsoft-antispam-prvs: <BYAPR04MB4630A65B44B9B6D9542D4E77E7F20@BYAPR04MB4630.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(9686003)(6436002)(7416002)(71200400001)(55016002)(66946007)(91956017)(2906002)(6116002)(64756008)(66476007)(76116006)(81156014)(6916009)(66446008)(8936002)(14444005)(33656002)(71190400001)(53936002)(8676002)(229853002)(86362001)(316002)(25786009)(256004)(446003)(52536014)(66556008)(68736007)(3846002)(26005)(478600001)(14454004)(53546011)(54906003)(7696005)(476003)(6506007)(74316002)(102836004)(186003)(305945005)(6246003)(76176011)(81166006)(66066001)(5660300002)(7736002)(99286004)(4326008)(486006)(3714002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4630;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ON4hoFoQyaNYDZARdyMnqFHp1OJh8lUr2ji2Mwdrzjw0Wo7u/0g/+5OAr/HHRIlumjHIXYyMNw3VOFfQBD3q9FOeL7gAxHipVcyumxdmuo7gP+N9cf8bcCxQ3+5Gi9MEh9N7XDdib6dZ+YuI6CO1D9xHdOgjoo15JTqXyLSCpWmiApf3812GtJuQamEXyZ7swd38ZTzMZQgGwcotk8b5VInMmJLEcir1WRq8rY+dRvdAR2VcHC6//+R7orMr5oaUH3kQ+PYbWJo49q5eRvKjN+3dkayC9n5/e/hbb2Rf6Lleck3pGW9k6uVKuJ7kanwzSHZNNXqC+wZC2BSt4NyPEyTgDOJQFemp8PHo5+mCmPr0Ftp4DYz8+2koCUPAc+g8shqjacfr/lt7ycHOEiu8DddO3WN6iXudYRJpVXGiBOQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f6199b-c36b-4af5-a0dc-08d7066328b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 00:52:05.0187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4630
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Martin,=0A=
=0A=
On 2019/07/12 9:28, Martin K. Petersen wrote:=0A=
> =0A=
> Damien,=0A=
> =0A=
>> During disk scan and revalidation done with sd_revalidate(), the zones=
=0A=
>> of a zoned disk are checked using the helper function=0A=
>> blk_revalidate_disk_zones() if a configuration change is detected=0A=
>> (change in the number of zones or zone size). The function=0A=
>> blk_revalidate_disk_zones() issues report_zones calls that are very=0A=
>> large, that is, to obtain zone information for all zones of the disk=0A=
>> with a single command. The size of the report zones command buffer=0A=
>> necessary for such large request generally is lower than the disk=0A=
>> max_hw_sectors and KMALLOC_MAX_SIZE (4MB) and succeeds on boot (no=0A=
>> memory fragmentation), but often fail at run time (e.g. hot-plug=0A=
>> event). This causes the disk revalidation to fail and the disk=0A=
>> capacity to be changed to 0.=0A=
> =0A=
> Probably easiest to funnel this through block with the rest of the=0A=
> series.=0A=
=0A=
Sounds good to me.=0A=
=0A=
Jens,=0A=
=0A=
Could you please consider this series for 5.3 ? We have been using it in te=
sts=0A=
since 2-3 weeks ago (5.2-rc6) without any problems. All revalidation proble=
ms=0A=
disappeared and with no side effects detected.=0A=
=0A=
Thank you.=0A=
=0A=
> Acked-by: Martin K. Petersen <martin.petersen@oracle.com>=0A=
=0A=
Thanks !=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
