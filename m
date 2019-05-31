Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0F0C28CC0
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 02:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBEF6254CA
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 02:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bwDz4upC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mZoBtwTZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfEaCCd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 22:02:33 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10855 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfEaCCc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 May 2019 22:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559268152; x=1590804152;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ao3uuPOrdQxbFwLU7vXrSZ5EI+q7i7qJtJbHi6tyXT0=;
  b=bwDz4upCEGgZdVKVmtGKVYHKAhhcChGmhF1+WEbIKhp+Ed43kEKhbcNN
   il2NlS3EWquTN6DH6dgfCtoROENNyZVxs7tUHUSgIFH4A9Vq6RjXPjQSR
   hOX1uMgA0InDxt1uvxKjMIKPRGABrMVZgqjLTNjjvRNYB1g+YUrqZkSHW
   SeE22jl7V3ir5kqDUAZxQorJUtZbkV+bIRfg6soFOA0AQnqiG4iU6i7Ue
   Reo7M9rKMpWMtCBSdYIfyySkXaRF/PVFjcEjuipxrmQaNOUG1ouHQkNEe
   KnAOGfpb4VkrmRAiWOSNR+leGlfw0Z3NHLtA95lsDQ27JVQQjYDhovIJg
   g==;
X-IronPort-AV: E=Sophos;i="5.60,533,1549900800"; 
   d="scan'208";a="215702542"
Received: from mail-bn3nam04lp2053.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.53])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2019 10:02:31 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGKIDFPyE1IkZjgEW/hYe2xcISFBVi6J+RQIRudGn/4=;
 b=mZoBtwTZ8Dj+ctvvTfdvWCncbQBRn/G0gKKT4Y+zil3hQPATxqY4fdpSpt8Ifg1Zk+iZTiB2u/TLhr6UXoITvYfQUdtb/WD6vpm8PtJaNcfpPEpa/+VdJpi/UdJ5Ebzz1XRLEwVyzPZPuzt/bQigi70XrFny23EOOde1tBJqjsg=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5670.namprd04.prod.outlook.com (20.179.57.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.17; Fri, 31 May 2019 02:02:21 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5%4]) with mapi id 15.20.1943.016; Fri, 31 May 2019
 02:02:21 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/8] block: Fix rq_qos_wait() kernel-doc header
Thread-Topic: [PATCH 5/8] block: Fix rq_qos_wait() kernel-doc header
Thread-Index: AQHVF0P2JCu/OE+Z+0+RrXfXCEoQAQ==
Date:   Fri, 31 May 2019 02:02:20 +0000
Message-ID: <BYAPR04MB57498194BD3966E4D2367DC686190@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190531000053.64053-1-bvanassche@acm.org>
 <20190531000053.64053-6-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9716436e-b1bd-433e-cc7d-08d6e56c044b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB5670;
x-ms-traffictypediagnostic: BYAPR04MB5670:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB56706ABE56CC67F9C491A7DF86190@BYAPR04MB5670.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(136003)(346002)(366004)(199004)(189003)(4326008)(256004)(14454004)(478600001)(305945005)(7736002)(54906003)(110136005)(26005)(8676002)(8936002)(66066001)(486006)(9686003)(33656002)(71190400001)(81156014)(81166006)(71200400001)(186003)(55016002)(72206003)(316002)(25786009)(6436002)(66476007)(66556008)(66946007)(66446008)(64756008)(102836004)(76116006)(73956011)(3846002)(53546011)(6116002)(6506007)(5660300002)(53936002)(2906002)(76176011)(86362001)(74316002)(52536014)(68736007)(476003)(99286004)(7696005)(446003)(6246003)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5670;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UrUv/87BbrGXemMECZ5b1EVgTujsCFnYQo+DYvYIfGBY25Rqv5PG2O35U4+fper6KiUxr+aq5QjQdMf3NrLl8EvHypNzaxnpWLeY8lGMHGCPecJXyjt8bbx2J5hL2LIBIMQ9b67KqtJEhUL66T7iHB4XKAlk3Q8scdwa8Fn3J3LYynBqsHk/HYBBo9ms018j3fbD8rg6vz+MY6jdBN6NjL4QhYZhpdYzC3KKSLW2cqAAIDJKWiRcXszgZ07Hp2QfuN1RyRc5jhm4aieTb6hi8N6g98aeoGVgygqyVSTyDCPdO275Jd+vFPI3tKb6Dpplmi2G9fM7ueYISBgtdLl0WBp3h+2isyFQ7X76Rjr6R9DopHIm3goHaqOvtzlQJ61nAdydimXU9jmDDXB+3ibt3PzEo267Rv19m9uzmH1jWGc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9716436e-b1bd-433e-cc7d-08d6e56c044b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 02:02:20.9339
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
> Add documentation for the @rqw argument and change " - " into ": ".=0A=
> =0A=
> Fixes: 84f603246db9 ("block: add rq_qos_wait to rq_qos") # v5.0-rc1~52^2~=
140.=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>   block/blk-rq-qos.c | 7 ++++---=0A=
>   1 file changed, 4 insertions(+), 3 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c=0A=
> index 3f55b56f24bc..659ccb8b693f 100644=0A=
> --- a/block/blk-rq-qos.c=0A=
> +++ b/block/blk-rq-qos.c=0A=
> @@ -209,9 +209,10 @@ static int rq_qos_wake_function(struct wait_queue_en=
try *curr,=0A=
>   =0A=
>   /**=0A=
>    * rq_qos_wait - throttle on a rqw if we need to=0A=
> - * @private_data - caller provided specific data=0A=
> - * @acquire_inflight_cb - inc the rqw->inflight counter if we can=0A=
> - * @cleanup_cb - the callback to cleanup in case we race with a waker=0A=
> + * @rqw: rqw to throttle on=0A=
> + * @private_data: caller provided specific data=0A=
> + * @acquire_inflight_cb: inc the rqw->inflight counter if we can=0A=
> + * @cleanup_cb: the callback to cleanup in case we race with a waker=0A=
>    *=0A=
>    * This provides a uniform place for the rq_qos users to do their throt=
tling.=0A=
>    * Since you can end up with a lot of things sleeping at once, this man=
ages the=0A=
> =0A=
=0A=
