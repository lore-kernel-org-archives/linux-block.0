Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F17C28CC0
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 02:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1F326008
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 02:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DHlad+jj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bbK/sYVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfEaCBE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 22:01:04 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:35936 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfEaCBE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 May 2019 22:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559268065; x=1590804065;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=f6MP6ZCZLsBeniAYBpAixFI8MsphpJhRCvOjnEQYUIY=;
  b=DHlad+jjsMx4ejB6m1GxEkwT5eceHUBlSZC6wn8UbKEvVxofskBphFb+
   +0ChcUG1K11al8wCkdkWH6zd44kLGPtVYFtkjW4uoBWdHSHUu3QKEsu1e
   OiqsE/onIJ+JEF1mafYCZ/wjQyTVR5xAzymAyl67mfs2SLMPRtcbNw8fE
   OQO+7x37HyumO2WYxJtV77i5rkTCI2spt2E5IG8YCaGtMv+s3ipQWi2ZA
   +q9uvx3IDfBM54qJ0xpj+GDFA+T0/prbPh6H6jYIwWl4Ulfj7ceHbqg/M
   ZEdHzrMzdmMSRADcYeEkETUzmFeYhUO2z2vjGE4sMhdPKu4vHiM+5VNwl
   A==;
X-IronPort-AV: E=Sophos;i="5.60,533,1549900800"; 
   d="scan'208";a="114412673"
Received: from mail-dm3nam05lp2054.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.54])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2019 10:01:04 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APdEh8L1OFoxw56Dija342GbmHwzLAKGbzKAsYZ9UQk=;
 b=bbK/sYVTbz3mvEWMnrElB6ZMNdXelSeXWeUL+6QiiFfAoVtAOOt9oWpY1w7Krdbv47JGdVYJmah3lxd8trj+qyBPMCRPP5tQgoBPSX/Z2f3ZAs0Z95e2A1Nj+X731pTPdignBqOye3mE3rxCPMDvPYKUGARp4dDPr0of6avoXMc=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5670.namprd04.prod.outlook.com (20.179.57.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.17; Fri, 31 May 2019 02:01:02 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5%4]) with mapi id 15.20.1943.016; Fri, 31 May 2019
 02:01:01 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 3/8] block: Fix throtl_pending_timer_fn() kernel-doc
 header
Thread-Topic: [PATCH 3/8] block: Fix throtl_pending_timer_fn() kernel-doc
 header
Thread-Index: AQHVF0P1DB1pHpbq6EqCF0sj1PDvKw==
Date:   Fri, 31 May 2019 02:01:01 +0000
Message-ID: <BYAPR04MB57499ACAFA6737B74783CAC486190@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190531000053.64053-1-bvanassche@acm.org>
 <20190531000053.64053-4-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.171]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39352a99-fe7a-48a9-ac26-08d6e56bd525
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB5670;
x-ms-traffictypediagnostic: BYAPR04MB5670:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5670A7D8D5D3C8C66E0DC13D86190@BYAPR04MB5670.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(376002)(39860400002)(136003)(346002)(366004)(199004)(189003)(4326008)(256004)(14454004)(478600001)(305945005)(7736002)(54906003)(110136005)(26005)(8676002)(8936002)(14444005)(66066001)(486006)(9686003)(33656002)(71190400001)(81156014)(81166006)(71200400001)(186003)(55016002)(72206003)(316002)(25786009)(6436002)(66476007)(66556008)(66946007)(66446008)(64756008)(102836004)(76116006)(73956011)(3846002)(53546011)(6116002)(6506007)(5660300002)(53936002)(2906002)(76176011)(86362001)(74316002)(52536014)(68736007)(476003)(99286004)(7696005)(446003)(6246003)(229853002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5670;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: m8iHfCSDNWXPd/0HxPi8edC7o7kV53Xb/gtOyLzjl4ZdSHKvUZXDxLVUwcsa4J1tyFJfFWxlEv3/ysvgZyH8KhSIkeml27hJWqYFHBE+mAA2F2AbwP1A1M5s2wtBuJgqCbSuswnwAnsHVMl4k8YuIQz7J81dK2wOUJ76/cvgShjBbkL8/sa28nKv9nP4K4bEufGV1KDdwc4rAe2J0FimIevmeFYmHo1/TucUmOWmV7haVUd7xsyiqxk3wOnZL3OVfDgSfQk1JXoTeKzQk+DnkrTy2gPvUq/zf7ky7ZpdcqMU2uAhonvDDNqNw+7VYSygkNhnSHAfUMkZ3J/1/vCVCZvF3E1jbGx2Fr/YPvG99fRXeckal1EoQ17fIgHwirPP73i0IiUaceED3S24foYDCGqiZbHX/gsoot8eUrOXmfQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39352a99-fe7a-48a9-ac26-08d6e56bd525
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 02:01:01.8302
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
> Commit e99e88a9d2b0 renamed a function argument without updating the=0A=
> corresponding kernel-doc header. Update the kernel-doc header.=0A=
> =0A=
> Cc: Kees Cook <keescook@chromium.org>=0A=
> Fixes: e99e88a9d2b0 ("treewide: setup_timer() -> timer_setup()") # v4.15.=
=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>   block/blk-throttle.c | 2 +-=0A=
>   1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c=0A=
> index 1b97a73d2fb1..9ea7c0ecad10 100644=0A=
> --- a/block/blk-throttle.c=0A=
> +++ b/block/blk-throttle.c=0A=
> @@ -1220,7 +1220,7 @@ static bool throtl_can_upgrade(struct throtl_data *=
td,=0A=
>   	struct throtl_grp *this_tg);=0A=
>   /**=0A=
>    * throtl_pending_timer_fn - timer function for service_queue->pending_=
timer=0A=
> - * @arg: the throtl_service_queue being serviced=0A=
> + * @t: the pending_timer member of the throtl_service_queue being servic=
ed=0A=
>    *=0A=
>    * This timer is armed when a child throtl_grp with active bio's become=
=0A=
>    * pending and queued on the service_queue's pending_tree and expires w=
hen=0A=
> =0A=
=0A=
