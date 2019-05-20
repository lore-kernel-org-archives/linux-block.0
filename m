Return-Path: <SRS0=zuir=TU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642ADC04AAC
	for <linux-block@archiver.kernel.org>; Mon, 20 May 2019 17:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C65620675
	for <linux-block@archiver.kernel.org>; Mon, 20 May 2019 17:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DV17RIay";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Zx0uj1K3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390582AbfETRPN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 May 2019 13:15:13 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:2421 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388626AbfETRPN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 May 2019 13:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1558372512; x=1589908512;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=BFcggl4F19RCc7P8VMles48l+sk3ifH16mSi3tmm1qg=;
  b=DV17RIaycR0TSqxxu7ohZRDOhqHJynEl0X4nVTkLjIf2NTBTF75fPVlx
   K1EOEsY1ouwMjfctpDWSB1VHl1p26H1LHNvqBIDnY7KxucqgVLfTV8wCA
   v22EEgwdInak6U++4i9O/2iA36Jy0Sh5lxvEdG6lStUZhTbssPMEsCkJ9
   cOfKL7OFLAOkf5HasZ206wRj6uHx9T9lixBhGvYhG5EPwyhoHBy+F2cUl
   4Do/BTsagYEFOaZrM3P7yVrfi+nivikW9Km4qolzgwyK7x/XO6MtT/+KZ
   hoFofWyU7OpBjPpUyeBTYetHggjKmcMuImcFcNOgnZfBkOUjKyWyKr0Qw
   w==;
X-IronPort-AV: E=Sophos;i="5.60,492,1549900800"; 
   d="scan'208";a="108678289"
Received: from mail-sn1nam02lp2050.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.50])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2019 01:15:12 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2Qc6yhOmyirdtdWTkOSVeddgomwitmNYlouxC0Rkog=;
 b=Zx0uj1K3dHj2Mb8D4FVzfegt4m4+wvblqB8esIFRvqOthLQqIr8vPTi7z1KmQpMOzAiQrRwdf/+hDQ2NPkFvZDGXA+rXjUrC705MSk973UI5T20AZd1s2zlbbfOaf85Vlcrp01iMYfCvg0kcTng4105+5S3q3WedfQ1WZy9TXAA=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4006.namprd04.prod.outlook.com (52.135.215.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Mon, 20 May 2019 17:15:09 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5%4]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 17:15:09 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: improve print_req_error
Thread-Topic: [PATCH] block: improve print_req_error
Thread-Index: AQHVDxZnERwNjGgWekC8vuLVmvfbsQ==
Date:   Mon, 20 May 2019 17:15:09 +0000
Message-ID: <BYAPR04MB5749883CDC6A481E97C3D51086060@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190520141359.30027-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 687722de-6705-4201-35a8-08d6dd46b620
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4006;
x-ms-traffictypediagnostic: BYAPR04MB4006:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB400665B05948D7393C6CE99A86060@BYAPR04MB4006.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:133;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(229853002)(305945005)(55016002)(7736002)(7696005)(446003)(73956011)(76176011)(25786009)(66476007)(66556008)(64756008)(66446008)(76116006)(102836004)(52536014)(66946007)(316002)(14454004)(9686003)(476003)(110136005)(68736007)(74316002)(33656002)(72206003)(478600001)(86362001)(99286004)(486006)(53936002)(71190400001)(71200400001)(81166006)(81156014)(5660300002)(8676002)(8936002)(4326008)(6436002)(53546011)(66066001)(6506007)(2501003)(186003)(6246003)(2906002)(3846002)(6116002)(256004)(14444005)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4006;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rSixXn8pR8GQXBT/82klX06ajwJrafpqbU3iFeRrBn8jQ/pqrlzbXVAKMKUj/zgOGGIW4Xfo12si06unGU+7Vxjg1FWts2tqc2NmosQziHM8xhIBIW2JcRsfztbfRlOsdaSjDhPMZ0Jr0wk6Gagw03O+WXGHRXTT4TTDOEy0odzzSBny8lcZUzMtT6TVrC4e/XYZhKTY8vDSD1oNNh2s3/wHQ8PhTmkvn+gRGJME7sOG04l2rKN1az274ur98i7MZiv/k+6MIVKGqoD/iElPglQeh+pWA2CP+BAZSJs7TArGnfIR1kLjMCrx/3P8jCv7tDryNrbdvaPlZwBU49qh1WqURXZTDqamY0LjACZTdSXuY1CLSDu9oceCa2y+SK13h2RHgQFb5CITG8WimDDY9mkexAnEJJqcflKGAVRkYIU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 687722de-6705-4201-35a8-08d6dd46b620
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 17:15:09.1597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4006
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Printing separate operations and flags is useful.=0A=
=0A=
How about we also add couple of more fields ?=0A=
=0A=
Compile tested patch on the top of this patch :-=0A=
=0A=
@@ -176,11 +176,14 @@ static void print_req_error(struct request *req, =0A=
blk_status_t status,=0A=
                 return;=0A=
=0A=
         printk_ratelimited(KERN_ERR=0A=
-               "%s: %s error, dev %s, sector %llu op 0x%x flags 0x%x\n",=
=0A=
+               "%s: %s error, dev %s, sector %llu op 0x%x flags 0x%x "=0A=
+               "phys_seg %u prio class %u\n",=0A=
                 caller, blk_errors[idx].name,=0A=
                 req->rq_disk ?  req->rq_disk->disk_name : "?",=0A=
nit:- extra space after '?', if that is not intentional.=0A=
                 blk_rq_pos(req), req_op(req),=0A=
-               req->cmd_flags & ~REQ_OP_MASK);=0A=
+               req->cmd_flags & ~REQ_OP_MASK,=0A=
+               req->nr_phys_segments,=0A=
+               IOPRIO_PRIO_CLASS(req->ioprio));=0A=
  }=0A=
=0A=
On 05/20/2019 07:14 AM, Christoph Hellwig wrote:=0A=
> Print the calling function instead of print_req_error as a prefix, and=0A=
> print the operation and op_flags separately instrad of the whole field.=
=0A=
Also, s/instrad/instead/.=0A=
=0A=
>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>   block/blk-core.c | 16 +++++++++-------=0A=
>   1 file changed, 9 insertions(+), 7 deletions(-)=0A=
>=0A=
> diff --git a/block/blk-core.c b/block/blk-core.c=0A=
> index 419d600e6637..b1f7e244340e 100644=0A=
> --- a/block/blk-core.c=0A=
> +++ b/block/blk-core.c=0A=
> @@ -167,18 +167,20 @@ int blk_status_to_errno(blk_status_t status)=0A=
>   }=0A=
>   EXPORT_SYMBOL_GPL(blk_status_to_errno);=0A=
>=0A=
> -static void print_req_error(struct request *req, blk_status_t status)=0A=
> +static void print_req_error(struct request *req, blk_status_t status,=0A=
> +		const char *caller)=0A=
>   {=0A=
>   	int idx =3D (__force int)status;=0A=
>=0A=
>   	if (WARN_ON_ONCE(idx >=3D ARRAY_SIZE(blk_errors)))=0A=
>   		return;=0A=
>=0A=
> -	printk_ratelimited(KERN_ERR "%s: %s error, dev %s, sector %llu flags %x=
\n",=0A=
> -				__func__, blk_errors[idx].name,=0A=
> -				req->rq_disk ?  req->rq_disk->disk_name : "?",=0A=
> -				(unsigned long long)blk_rq_pos(req),=0A=
> -				req->cmd_flags);=0A=
> +	printk_ratelimited(KERN_ERR=0A=
> +		"%s: %s error, dev %s, sector %llu op 0x%x flags 0x%x\n",=0A=
> +		caller, blk_errors[idx].name,=0A=
> +		req->rq_disk ?  req->rq_disk->disk_name : "?",=0A=
> +		blk_rq_pos(req), req_op(req),=0A=
> +		req->cmd_flags & ~REQ_OP_MASK);=0A=
>   }=0A=
>=0A=
>   static void req_bio_endio(struct request *rq, struct bio *bio,=0A=
> @@ -1418,7 +1420,7 @@ bool blk_update_request(struct request *req, blk_st=
atus_t error,=0A=
>=0A=
>   	if (unlikely(error && !blk_rq_is_passthrough(req) &&=0A=
>   		     !(req->rq_flags & RQF_QUIET)))=0A=
> -		print_req_error(req, error);=0A=
> +		print_req_error(req, error, __func__);=0A=
>=0A=
>   	blk_account_io_completion(req, nr_bytes);=0A=
>=0A=
>=0A=
=0A=
