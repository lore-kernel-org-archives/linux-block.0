Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B237C28CC0
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 02:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379DB25715
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 02:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DawiDCoJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="r3a5Dq0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfEaCC6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 22:02:58 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:31605 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfEaCC6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 May 2019 22:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559268178; x=1590804178;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=wlbF5Cm1XG1TgPwDdwuwsNUJegg8VC6lHDGBRQDP37Y=;
  b=DawiDCoJOA6xvdHVxYnSZlPyVZ/mh8e8q83taP9/qdsbAt9E1m/m9VRi
   mTQPboPlUuOsCYY42i+6MEuK3lm9H6G6K9CTfqsaBB1DsZtdhOBeRjNRV
   LD/kJLr0fNe/wF4rySv2NWBuvPiMXFrAkuoaDg8zXaEfb6X0GBk0EPNSf
   uG1ZJib/VVNNWjNC89JUUgbhdAWXEjgBsNycJz8x97+7KIssBYcxtwOtZ
   PDa+cqyWQm9UO4/BPN3IOpb50KsrDjIucVsbhCbP3dvuD86ZNmFVY/xkv
   V9h2e8SVw5c5wEe6ZVDh1hMsrQOmZhYIXadNpJ5Bg0gd77yEakJJb36/V
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,533,1549900800"; 
   d="scan'208";a="109456132"
Received: from mail-bn3nam04lp2056.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.56])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2019 10:02:57 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyoytCHt4aQ+BkGtw74OWiNfkNggEZLBrdU8gS5qSD8=;
 b=r3a5Dq0ravCaV6K7EfIqVvqiHdZpghhM7RjA5+SDvUp2QRkVaWkn3qf/ccykEeBpREZQb/AZShOvD6Lfxosi995mqSmJM8WZCOAA3OtoxUSXdhcHDkdRr3rSwBdLHJJ3+r7cuDzetXl+q2oqaJcvULs7Ehsp2VzW28TL8AzeUzA=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5670.namprd04.prod.outlook.com (20.179.57.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.17; Fri, 31 May 2019 02:02:55 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5%4]) with mapi id 15.20.1943.016; Fri, 31 May 2019
 02:02:55 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 6/8] block: Fix bsg_setup_queue() kernel-doc header
Thread-Topic: [PATCH 6/8] block: Fix bsg_setup_queue() kernel-doc header
Thread-Index: AQHVF0P3LvGECpIobUaLAX48SYOKug==
Date:   Fri, 31 May 2019 02:02:55 +0000
Message-ID: <BYAPR04MB574983F989396BDF43CEEC8D86190@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190531000053.64053-1-bvanassche@acm.org>
 <20190531000053.64053-7-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65ffcca4-188a-43cd-0217-08d6e56c18b7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB5670;
x-ms-traffictypediagnostic: BYAPR04MB5670:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB567084D6FD5768811001A84486190@BYAPR04MB5670.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(136003)(346002)(366004)(199004)(189003)(4326008)(256004)(14454004)(478600001)(305945005)(7736002)(54906003)(110136005)(26005)(8676002)(8936002)(14444005)(66066001)(486006)(9686003)(33656002)(5024004)(71190400001)(81156014)(81166006)(71200400001)(186003)(55016002)(72206003)(316002)(25786009)(6436002)(66476007)(66556008)(66946007)(66446008)(64756008)(102836004)(76116006)(73956011)(3846002)(53546011)(6116002)(4744005)(6506007)(5660300002)(53936002)(2906002)(76176011)(86362001)(74316002)(52536014)(68736007)(476003)(99286004)(7696005)(446003)(6246003)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5670;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6ALmCnXo42UAC+d485ZLq9JaRNbnR+8K2+iR9wivkRZNRPfia5TxyFr1d8Azpa7Al1vdKn/uTazlmSUZr9/CN7GO0pJ8pfEU8mWRlpSVjvtuFWdURAWindLO+qiOLyFNPf8EKWz0Spuz8j8truYD6cxTSCMaCCLCkEXCG2nUxCacvGJZbMFt7/diJ7xEh1QiLlg0W3CX6SXxSqhCmGtktXg/M5/0fr4niRgdJAjlAk7DGoNuGaVJqOFs3/O7e8trKgOAtOb9Y21Czo/yOYf4yqqaizMUQOuYhmLyAiAx1rVAm1ufJRySToSndejvbuLm836pCrR6/NsAB1+squH2uNdeQyY4eADdfoJZBvAJcxqHt19mYetqnG9vQ7OXmF1DU9HB/YmOGftbZqzW5i6s99N9v+7eh0On/t77XS6l14Q=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ffcca4-188a-43cd-0217-08d6e56c18b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 02:02:55.2499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5670
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chiatanya.kulkarni@wdc.com>=0A=
=0A=
On 5/30/19 5:01 PM, Bart Van Assche wrote:=0A=
> Document all bsg_setup_queue() arguments as required.=0A=
> =0A=
> Fixes: aae3b069d5ce ("bsg: pass in desired timeout handler") # v5.0.=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>   block/bsg-lib.c | 1 +=0A=
>   1 file changed, 1 insertion(+)=0A=
> =0A=
> diff --git a/block/bsg-lib.c b/block/bsg-lib.c=0A=
> index b898a1cdf872..785dd58947f1 100644=0A=
> --- a/block/bsg-lib.c=0A=
> +++ b/block/bsg-lib.c=0A=
> @@ -354,6 +354,7 @@ static const struct blk_mq_ops bsg_mq_ops =3D {=0A=
>    * @dev: device to attach bsg device to=0A=
>    * @name: device to give bsg device=0A=
>    * @job_fn: bsg job handler=0A=
> + * @timeout: timeout handler function pointer=0A=
>    * @dd_job_size: size of LLD data needed for each job=0A=
>    */=0A=
>   struct request_queue *bsg_setup_queue(struct device *dev, const char *n=
ame,=0A=
> =0A=
=0A=
