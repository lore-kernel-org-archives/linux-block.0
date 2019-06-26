Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99EEC48BD6
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 20:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9D0208E3
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 20:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Y9Iy2kie";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="f0MDcq5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfFZUru (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:47:50 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38112 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfFZUrt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 16:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561582070; x=1593118070;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=9l6AC/z7ZenHtVCh5FNjcZrWGLh8XIXJjxuO15vEmPI=;
  b=Y9Iy2kie93cqPXyV6IBh3kEpv+8pi3jby7sxw6oJIkJ1g3eD58KKW0m3
   8il4X+DHKyJ0ZuDulg1LHc9efK+dyuN+xZWKkXNm1DqDq+GdR8NPo3O+0
   3g5mIk9gdEBiQes7wfLBGeE/dhrBW5+r+fe0TVmFmbLHwX9l/E/lbvzqd
   GETaGH/pIfSWUaq1j5woeUnhJEkHuKpA5GWK+oGciUQOJ7YfWASnz3jDt
   r5DeX5HN/VIGjI5B0SwYO1zkuNJT0w/LCcHOJDasfyf6TZKPo1fMiUmsF
   MvWnDA52wbmrjAzSO7Kstv0cebFVU694y2AGuXu0necWpi52gndA7hLnX
   A==;
X-IronPort-AV: E=Sophos;i="5.63,421,1557158400"; 
   d="scan'208";a="112835608"
Received: from mail-by2nam05lp2055.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.55])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2019 04:47:50 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEfshNpNu9N4oTJNJDZASXqE7HRErw7Wm6+3nQyCAIY=;
 b=f0MDcq5Lbsc3pigqIMtbwWEiO8gLv4B49oI4G7DqjEGl0ARVRHObNqQkAv2qevZPzCdvVT+F8n51sn2eKb2RXV5rnhOE1TRlJZ++CXgwW4A8lCdCjJnYXTcK7LMMxWjnj87KcdaOa6wRAC3VRH+cvoZShS2hB0Li51nLki4UA50=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4262.namprd04.prod.outlook.com (20.176.251.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Wed, 26 Jun 2019 20:47:48 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6%7]) with mapi id 15.20.2008.018; Wed, 26 Jun 2019
 20:47:48 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 6/9] block_dev: use bio_release_pages in blkdev_bio_end_io
Thread-Topic: [PATCH 6/9] block_dev: use bio_release_pages in
 blkdev_bio_end_io
Thread-Index: AQHVLCYGHzfYXtvo20KpFuCaSdZqUA==
Date:   Wed, 26 Jun 2019 20:47:48 +0000
Message-ID: <BYAPR04MB5749D4918B689FACEFAF8DEC86E20@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190626134928.7988-1-hch@lst.de>
 <20190626134928.7988-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cea52588-e7ff-4e87-03fb-08d6fa778c64
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4262;
x-ms-traffictypediagnostic: BYAPR04MB4262:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB4262C3E8E33FBDF39AD8426E86E20@BYAPR04MB4262.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:65;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(396003)(376002)(366004)(199004)(189003)(71190400001)(486006)(6116002)(81166006)(66476007)(99286004)(66556008)(476003)(5660300002)(81156014)(66446008)(66946007)(74316002)(316002)(64756008)(53936002)(52536014)(14454004)(55016002)(68736007)(71200400001)(4326008)(3846002)(9686003)(446003)(72206003)(33656002)(102836004)(110136005)(6436002)(73956011)(7696005)(186003)(478600001)(26005)(229853002)(7736002)(76116006)(6246003)(53546011)(8676002)(2906002)(305945005)(256004)(25786009)(76176011)(86362001)(4744005)(66066001)(8936002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4262;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: b5vjITFTtO7dM1ySJj4RhcbeY8j0ctgaP7DE/Y/3kVnOFqM/9p5PGjBOvx6vK1HBcW3CExhKNBy3NfOmMq+8oOM4h+h7OM9HV7sB/jKFTRHW3TfZ0nSdxr14+vkP4FGAtai7g1KM3ScNvjsElyioQ2amTaS/Hq+3bFzn+rO0gpXODvmAmgU22U3+RrpvgBisixUpfUEK0bAE5BWZNXVmfm2UeE0WBhq+0Mv20mcuXCqoM7U5/nSUh4ePN/jzxZCxNYMX3Ml0zqmq7VGqSHjF4iPzXwSkVfQ2jZwaPZIEbDYX4ANGP6qN0mxi29v8Q9D98lIO6YYF6bDebZcIZZFT1MEOK3KuSph7avwV2GNIVygOPstZHOK/iSRPAYc0wSSCfXl7164ejt43kyBN0Qa5nAx/Zft9H0BqYGxB9O1CSZw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cea52588-e7ff-4e87-03fb-08d6fa778c64
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 20:47:48.1411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4262
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 06/26/2019 06:49 AM, Christoph Hellwig wrote:=0A=
> Use bio_release_pages instead of duplicating it.=0A=
>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>   fs/block_dev.c | 8 +-------=0A=
>   1 file changed, 1 insertion(+), 7 deletions(-)=0A=
>=0A=
> diff --git a/fs/block_dev.c b/fs/block_dev.c=0A=
> index 749f5984425d..a6572a811880 100644=0A=
> --- a/fs/block_dev.c=0A=
> +++ b/fs/block_dev.c=0A=
> @@ -335,13 +335,7 @@ static void blkdev_bio_end_io(struct bio *bio)=0A=
>   	if (should_dirty) {=0A=
>   		bio_check_pages_dirty(bio);=0A=
>   	} else {=0A=
> -		if (!bio_flagged(bio, BIO_NO_PAGE_REF)) {=0A=
> -			struct bvec_iter_all iter_all;=0A=
> -			struct bio_vec *bvec;=0A=
> -=0A=
> -			bio_for_each_segment_all(bvec, bio, iter_all)=0A=
> -				put_page(bvec->bv_page);=0A=
> -		}=0A=
> +		bio_release_pages(bio, false);=0A=
>   		bio_put(bio);=0A=
>   	}=0A=
>   }=0A=
>=0A=
=0A=
