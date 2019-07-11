Return-Path: <SRS0=DuRR=VI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761D9C742A2
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 18:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A6D21019
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 18:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="j3oLMIOW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Fyn1u0mg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfGKSIS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jul 2019 14:08:18 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22077 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbfGKSIS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jul 2019 14:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562868499; x=1594404499;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=RpvP7RFzYkA8zxEhAPdG8n5sUkp+N36hBQ0wU4Esmlg=;
  b=j3oLMIOW6xdmzA6yeUumkKdbOFk7JoNl8lpKaDwxTz/KWivgcqvgrpjt
   72m2hntj1eaeLc+XQ1L16xJLpaGr8yyLma7orVrfueNvOP01OJ9y4n/Ha
   NlLZOeldGvm/TergEUtQ5qQ/GxlYXQhmG647l8VhciogFb3uwdqQ4r+zG
   Z1HElQdeGVgrJNHjtzPVhsAz2DfICqYgvdDkc2VHSpo3vEE7qwG3R0Xk1
   aEAglo1XLkKvmQWuR+aPdbNsp8lM5EwTUU9wFNIlTvQtKAI/yUx8gJ7Ss
   lWU17/XC7a/iBY3zsBtUrDiHgoE05cAQHA9mkG59HqThAXw4/pUxx1lyy
   g==;
IronPort-SDR: Lp51FmrP6GHAyXD1PJ/7QetcEp4oqwybfYJ19v6yTAsSFBDo4FYD704coizx6rDVQqLg/YVx5+
 uZkS3piH3supFybvYGsVBR09iuZg000UJDLJDZBUT/HjWJaPmeR5/tCbtX2PR3zRbcF5OB9rVf
 gRYqyZpEAkyimcpLEvXh+W2aFSSjAoiQ38L0gIEkmHIWZXjx2X/3ZMjzyuFo8bhyzjKYx+CByp
 p4vtw4of6eOgHywGmpeePKnErO6/eO6u/no/vBZwXSX5MWeYSev8BU3nj0lzItEh55ES26MLLW
 PBs=
X-IronPort-AV: E=Sophos;i="5.63,479,1557158400"; 
   d="scan'208";a="212744709"
Received: from mail-bn3nam04lp2054.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.54])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jul 2019 02:08:17 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZb+sQlMNor7BTg5f1SjuMGcqw508rVVlIGGVytGXkg=;
 b=Fyn1u0mgW9W4xCuhBdthO3igppM7x3AMrsXIvGVSxNQjnaysIefyVW4BrOe6YER+8UvRTSK54FvAW9huCq0Gm6/CF1Z0tYb7i5iFB8DzTfqa6S29RptmPuR2G7TSvBoU2UMFius3tkJbyjEasR1zkVBi++d3vHuMRTJqGQ9LujM=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5301.namprd04.prod.outlook.com (20.178.49.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Thu, 11 Jul 2019 18:08:14 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::8025:ccea:a0e6:9078]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::8025:ccea:a0e6:9078%5]) with mapi id 15.20.2073.008; Thu, 11 Jul 2019
 18:08:14 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: tidy up blk_mq_plug
Thread-Topic: [PATCH] block: tidy up blk_mq_plug
Thread-Index: AQHVN9o/NMvYOQQFDkWlXc2bhIQf0w==
Date:   Thu, 11 Jul 2019 18:08:13 +0000
Message-ID: <BYAPR04MB57490CAC59A77556A820D0A186F30@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190711111714.4802-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4bec641d-32e2-46f8-61db-08d7062abde2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5301;
x-ms-traffictypediagnostic: BYAPR04MB5301:
x-microsoft-antispam-prvs: <BYAPR04MB5301AA3999519B72622AFCD386F30@BYAPR04MB5301.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(199004)(189003)(14454004)(81156014)(81166006)(8676002)(53546011)(6506007)(186003)(316002)(478600001)(6246003)(229853002)(68736007)(25786009)(256004)(71200400001)(71190400001)(5660300002)(14444005)(86362001)(486006)(4326008)(74316002)(53936002)(476003)(446003)(99286004)(33656002)(2501003)(305945005)(7736002)(6116002)(3846002)(66446008)(64756008)(66946007)(91956017)(76116006)(76176011)(54906003)(110136005)(102836004)(2906002)(26005)(6436002)(55016002)(9686003)(66066001)(7696005)(66476007)(66556008)(52536014)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5301;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hjZWxL+u6gUNMFwpiiB5zpqMToBX0MbKh6ZZ05QNDTf3BHO9+0oCssV5v4qVfJvpQr6/8tXmsTEaKttrQY5EgXj5rLTnGWrh3lEQfMrRF3We8EfUn1gk45CpCwTSCrWiIzxClkwHeeUqxwBRq8bARehqeFmc3v6TjDWenuYBRmvoiuwSHQ9fFrMJwGvach4Mj7pItfuh02+UxB/86H7RIOuU5oqTatVMfGKj18ViNYlfOrXnSB+u5U9kBMhTspf2hKudHI+YgJWbIF1ZkyN1vLTXVicz11EDiuD5JOzqKdJ6f+xVap7NGPXw47Y06Ea1bNa0vuo87SqrW+zbWYMxfyUit8E6rm8rEjh9YqIvVJi+/dilGvt7D5DsaewxJ/WVsbEeJcl826ONni4gyHHDrJIbTfAfHafTNGsS/xkgI1s=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bec641d-32e2-46f8-61db-08d7062abde2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 18:08:13.9967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5301
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good, we should avoid "!" conditions when possible it=0A=
makes code much easier to read.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 07/11/2019 04:17 AM, Christoph Hellwig wrote:=0A=
> Make the zoned device write path the special case and just fall=0A=
> though to the defaul case to make the code easier to read.  Also=0A=
> update the top of function comment to use the proper kdoc format=0A=
> and remove the extra in-function comments that just duplicate it.=0A=
>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>   block/blk-mq.h | 14 ++++----------=0A=
>   1 file changed, 4 insertions(+), 10 deletions(-)=0A=
>=0A=
> diff --git a/block/blk-mq.h b/block/blk-mq.h=0A=
> index 32c62c64e6c2..ab80fd2b3803 100644=0A=
> --- a/block/blk-mq.h=0A=
> +++ b/block/blk-mq.h=0A=
> @@ -233,7 +233,7 @@ static inline void blk_mq_clear_mq_map(struct blk_mq_=
queue_map *qmap)=0A=
>   		qmap->mq_map[cpu] =3D 0;=0A=
>   }=0A=
>=0A=
> -/*=0A=
> +/**=0A=
>    * blk_mq_plug() - Get caller context plug=0A=
>    * @q: request queue=0A=
>    * @bio : the bio being submitted by the caller context=0A=
> @@ -254,15 +254,9 @@ static inline void blk_mq_clear_mq_map(struct blk_mq=
_queue_map *qmap)=0A=
>   static inline struct blk_plug *blk_mq_plug(struct request_queue *q,=0A=
>   					   struct bio *bio)=0A=
>   {=0A=
> -	/*=0A=
> -	 * For regular block devices or read operations, use the context plug=
=0A=
> -	 * which may be NULL if blk_start_plug() was not executed.=0A=
> -	 */=0A=
> -	if (!blk_queue_is_zoned(q) || !op_is_write(bio_op(bio)))=0A=
> -		return current->plug;=0A=
> -=0A=
> -	/* Zoned block device write operation case: do not plug the BIO */=0A=
> -	return NULL;=0A=
> +	if (blk_queue_is_zoned(q) && op_is_write(bio_op(bio)))=0A=
> +		return NULL;=0A=
> +	return current->plug;=0A=
>   }=0A=
>=0A=
>   #endif=0A=
>=0A=
=0A=
