Return-Path: <SRS0=D4S7=UT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAAEC43613
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 05:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0825208CB
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 05:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IuHK9ufu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pbapG/ku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbfFTFHC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jun 2019 01:07:02 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:47906 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfFTFHC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jun 2019 01:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561007221; x=1592543221;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=KuceavLUe2MC95OMIsOUVvZtzWS2vVuKEM27lkGlAjA=;
  b=IuHK9ufu5WI4jqYQaSuZeZJZm3sosotLOG4Rh0BMeaFz9zNCeu5o/rbq
   4sUTZh6TSCRnvVOdOpS/rRDZ4YNwO67v/IS1rGcNQMv0tkmzDIIv/SDKS
   F32YmeztkrynGxRs9ZBkVwxad70m+him82a3n4gmTlQZTPpZVqV/Mbqyc
   k6AZhfyK9So3jaw47rmuEgZ4xmXzlytQxIw303coi+6iO/BSAUR7okVn8
   f9/aFygIO0kjhFYCGX/5zA7O8n5OYSf0heb8p6ahpT0n+mpT2LAkFzXtN
   RO0YYqR5DnIQTTpKke2CpkeMu4+SZHEDrZr5FO8d01yooHyEzMz74hwAK
   g==;
X-IronPort-AV: E=Sophos;i="5.63,395,1557158400"; 
   d="scan'208";a="217385415"
Received: from mail-by2nam03lp2050.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.50])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2019 13:07:01 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LBpEHjvgTwJw+CPe1Ly4CUbeKaZkeW4xl1DehAr1PQ=;
 b=pbapG/kuLcI+Q4pw4apJzERmQCSF0mk8JfqGStju6pEAYbxcqNd8W8WXfE2gaja5E8ZXHBih+ckwshs1giygJuRR2wQ6apA5xpCn1PiEHjV6hV5ni/aWETBC3q8dfwzVQ0w3bCHV4RI75pqBBW+ltf20FCDjZmkv1/wQxR+sFpA=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5848.namprd04.prod.outlook.com (20.179.59.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Thu, 20 Jun 2019 05:07:00 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6%7]) with mapi id 15.20.1987.014; Thu, 20 Jun 2019
 05:07:00 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "yuchao0@huawei.com" <yuchao0@huawei.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: [PATCH V4 4/5] block: update print_req_error()
Thread-Topic: [PATCH V4 4/5] block: update print_req_error()
Thread-Index: AQHVJsJtx7s89xV5ZEiccamtWv567Q==
Date:   Thu, 20 Jun 2019 05:07:00 +0000
Message-ID: <BYAPR04MB5749ECD7140A106FF33EA40C86E40@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190619171302.10146-1-chaitanya.kulkarni@wdc.com>
 <20190619171302.10146-5-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.170]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 325dd34b-c495-4a64-5a42-08d6f53d208b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5848;
x-ms-traffictypediagnostic: BYAPR04MB5848:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB584884F721308841A927A77E86E40@BYAPR04MB5848.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:193;
x-forefront-prvs: 0074BBE012
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(136003)(376002)(346002)(199004)(189003)(6506007)(74316002)(446003)(6436002)(186003)(66476007)(72206003)(3846002)(486006)(9686003)(76116006)(73956011)(7736002)(4326008)(102836004)(76176011)(53936002)(476003)(2351001)(305945005)(66446008)(25786009)(6246003)(64756008)(316002)(86362001)(26005)(33656002)(229853002)(7696005)(99286004)(71200400001)(8936002)(256004)(478600001)(8676002)(14454004)(66946007)(2501003)(6116002)(53546011)(2906002)(5640700003)(55016002)(66066001)(71190400001)(6916009)(81166006)(14444005)(5660300002)(54906003)(81156014)(68736007)(66556008)(52536014)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5848;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7c19Y/wUGs9szzETtDwk/M0WVqiD/2u0XT6SK+VaRRZRda6KBKkrM3zrl8R4h7i5z/ZDtoQ48JMfNghrMQHmtDFjEy0WjX8JjD5DTUH59zCNtiFdx7bgVzIZjotY63PF/liBQY0h3FNS7/ONevMwLbRNzYqnKCsSZGeKUcXjDFP6Aqcrph+zuOpGVwKbKcqehLebYdVOaQUSKQJmVHTGQUKKwpKn9mZGcCgG9ASdvOf26BKUKr2Oc++bmpWSwHm1hrvoLFYlAAKly3oxNybk3qxVGn3ZB+AP1pk5vtEEFHsFZviRMkd1yyYMvKIE74prExENTNBqWdMY4UJaAt548U54HHciZqYTCYjROITW5fkY8RdanfdHtg9wXH9CtojmdK9WNBp3VLiIu1wPM9KtTfQ2tBWhbbIZ1QIecxgklBM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 325dd34b-c495-4a64-5a42-08d6f53d208b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2019 05:07:00.6378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5848
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Rest of the patches in this series are reviewed by Bart and Chao.=0A=
=0A=
Can someone please take a look at this patch and provide some feedback ?=0A=
On 6/19/19 10:14 AM, Chaitanya Kulkarni wrote:=0A=
> Improve the print_req_error with additional request fields which are=0A=
> helpful for debugging. Use newly introduced blk_op_str() to print the=0A=
> REQ_OP_XXX in the string format.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>   block/blk-core.c | 11 +++++++----=0A=
>   1 file changed, 7 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-core.c b/block/blk-core.c=0A=
> index c92b5a16a27a..88a716c3dc56 100644=0A=
> --- a/block/blk-core.c=0A=
> +++ b/block/blk-core.c=0A=
> @@ -212,11 +212,14 @@ static void print_req_error(struct request *req, bl=
k_status_t status,=0A=
>   		return;=0A=
>   =0A=
>   	printk_ratelimited(KERN_ERR=0A=
> -		"%s: %s error, dev %s, sector %llu op 0x%x flags 0x%x\n",=0A=
> +		"%s: %s error, dev %s, sector %llu op 0x%x:(%s) flags 0x%x "=0A=
> +		"phys_seg %u prio class %u\n",=0A=
>   		caller, blk_errors[idx].name,=0A=
> -		req->rq_disk ?  req->rq_disk->disk_name : "?",=0A=
> -		blk_rq_pos(req), req_op(req),=0A=
> -		req->cmd_flags & ~REQ_OP_MASK);=0A=
> +		req->rq_disk ? req->rq_disk->disk_name : "?",=0A=
> +		blk_rq_pos(req), req_op(req), blk_op_str(req_op(req)),=0A=
> +		req->cmd_flags & ~REQ_OP_MASK,=0A=
> +		req->nr_phys_segments,=0A=
> +		IOPRIO_PRIO_CLASS(req->ioprio));=0A=
>   }=0A=
>   =0A=
>   static void req_bio_endio(struct request *rq, struct bio *bio,=0A=
> =0A=
=0A=
