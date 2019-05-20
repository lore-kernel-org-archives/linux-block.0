Return-Path: <SRS0=zuir=TU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1D3C04AAC
	for <linux-block@archiver.kernel.org>; Mon, 20 May 2019 17:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F50A208C3
	for <linux-block@archiver.kernel.org>; Mon, 20 May 2019 17:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J7jsJ4Ij";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uf+Zpchv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391292AbfETRe3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 May 2019 13:34:29 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:3646 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387560AbfETRe3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 May 2019 13:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1558373670; x=1589909670;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=7ASYOlWhpSc7o7o4tV1EysiI3VvKo/aaS5b3NIJB2LQ=;
  b=J7jsJ4Ijk3z/VyOZls8r5foQidsk9busGauBB/GV6vxxjzcGdaxJDzu4
   ZRppTZFw4yZGrWdXEVZbkYh8h95yBY64xakLGTd/oS/tM/UdGVNYRjtS4
   z9qYeVjvybmW89c8q82Cq+AZlpHGYr45jcHHdl28zed9Y+eVuo9cAf/jF
   6X8jZop8Yae8/oo1MtzgmFqqeLeBSNUoHDj2fqBSufLsh9z6aAop3hido
   V1vF7jVyNlCFiFszkl1chDBMiWWOVg3Uf0NKXKI0n0B7aeHJbJxRd6Vb1
   a/fnG0cAPvjwpZBf+VhE2FppkaceEpkNfIFz5apvDFLkOLYri5gwkLYNx
   A==;
X-IronPort-AV: E=Sophos;i="5.60,492,1549900800"; 
   d="scan'208";a="108679520"
Received: from mail-co1nam03lp2057.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.57])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2019 01:34:29 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DGIaz6EDyFzxC3QArwh3aPzMq35NzCQYOtQIxjIQek=;
 b=uf+ZpchvQ6EK+T7XjR3hsNVPxzaER6Tfk8GzVG1UiLv3ANcFGW+adCm11mLIGIETeHOtVDeK32hht2cOsGz3OquQ1Ikx7hn78sboxxU45Gw1i4j5fxoUUwFKK6/HOutdrqz5kc7nmkpPI8Xhvp/LiYE2POACvLsupQhMgWtfVx4=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5270.namprd04.prod.outlook.com (20.178.49.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Mon, 20 May 2019 17:34:27 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5%4]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 17:34:27 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: improve print_req_error
Thread-Topic: [PATCH] block: improve print_req_error
Thread-Index: AQHVDxZnERwNjGgWekC8vuLVmvfbsQ==
Date:   Mon, 20 May 2019 17:34:27 +0000
Message-ID: <BYAPR04MB5749C90479944A17FC1A1E8886060@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190520141359.30027-1-hch@lst.de>
 <BYAPR04MB5749883CDC6A481E97C3D51086060@BYAPR04MB5749.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88d9cb80-0a2c-4a72-99e6-08d6dd496879
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5270;
x-ms-traffictypediagnostic: BYAPR04MB5270:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB52709160AF1F622BFAD12AB386060@BYAPR04MB5270.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:590;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(136003)(376002)(396003)(199004)(189003)(99286004)(71200400001)(71190400001)(110136005)(33656002)(7736002)(229853002)(8936002)(68736007)(305945005)(4326008)(25786009)(446003)(81166006)(26005)(9686003)(2906002)(2501003)(81156014)(8676002)(14454004)(52536014)(66476007)(66946007)(73956011)(76116006)(64756008)(5660300002)(66556008)(3846002)(53936002)(6246003)(66446008)(6116002)(6436002)(14444005)(316002)(72206003)(256004)(66066001)(86362001)(76176011)(486006)(478600001)(55016002)(186003)(7696005)(53546011)(102836004)(6506007)(74316002)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5270;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JFhHa/tB8rJitg2jF1dkLR4xxwPi0+J4hSMJmkCI7TK8zyOtCEOYPrDjPIHFwwNHO7e4wM37WkX8IOLT+Y4BiHV6h7bVi++G65qRfYI3txOrgT1gApjtaAJjJwvWXiknr8nEyereonwhQeMWG0WZmvoIRIjZoKQ8lm7JoWQuJiK0cT//NFP5z1hH9WwNstqybvSzkzAg6q2esVleYmQcbsi8U9qgj6JvEeu9GZwCq9OsiY7vPMeTzvQp6pvI/t7W2iWqfZ3r+nmCywYg2pMrBzjNSwjsDKtf3hQOh9ZOdGXvU65KkR6jny5hgxBli9oRb3l/Ub29MPtpUygPMYXag+Ur+xtX7FkrAKAafOAbI3nBmlHhCljxRVsSnHUUxW289qO9PLh+h13iDUcorZvkaw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d9cb80-0a2c-4a72-99e6-08d6dd496879
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 17:34:27.3495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5270
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If you are okay, we can print the req_op in string format,=0A=
compile tested patch on the top of yours below, not that this is=0A=
needed but it is just a nice way to present debug data:-=0A=
=0A=
+static inline const char *req_op_str(struct request *req)=0A=
+{=0A=
+       char *ret;=0A=
+=0A=
+       switch (req_op(req)) {=0A=
+       case REQ_OP_READ:=0A=
+               ret =3D "read";=0A=
+               break;=0A=
+       case REQ_OP_WRITE:=0A=
+               ret =3D "write";=0A=
+               break;=0A=
+       case REQ_OP_FLUSH:=0A=
+               ret =3D "flush";=0A=
+               break;=0A=
+       case REQ_OP_DISCARD:=0A=
+               ret =3D "discard";=0A=
+               break;=0A=
+       case REQ_OP_SECURE_ERASE:=0A=
+               ret =3D "secure_erase";=0A=
+               break;=0A=
+       case REQ_OP_ZONE_RESET:=0A=
+               ret =3D "zone_reset";=0A=
+               break;=0A=
+       case REQ_OP_WRITE_SAME:=0A=
+               ret =3D "write_same";=0A=
+               break;=0A=
+       case REQ_OP_WRITE_ZEROES:=0A=
+               ret =3D "write_zeroes";=0A=
+               break;=0A=
+       case REQ_OP_SCSI_IN:=0A=
+               ret =3D "scsi_in";=0A=
+               break;=0A=
+       case REQ_OP_SCSI_OUT:=0A=
+               ret =3D "scsi_out";=0A=
+               break;=0A=
+       case REQ_OP_DRV_IN:=0A=
+               ret =3D "drv_in";=0A=
+               break;=0A=
+       case REQ_OP_DRV_OUT:=0A=
+               ret =3D "drv_out";=0A=
+               break;=0A=
+       default:=0A=
+               ret =3D "unknown";=0A=
+       }=0A=
+       return ret;=0A=
+}=0A=
+=0A=
  static void print_req_error(struct request *req, blk_status_t status,=0A=
                 const char *caller)=0A=
  {=0A=
@@ -176,11 +223,14 @@ static void print_req_error(struct request *req, =0A=
blk_status_t status,=0A=
                 return;=0A=
=0A=
         printk_ratelimited(KERN_ERR=0A=
-               "%s: %s error, dev %s, sector %llu op 0x%x flags 0x%x\n",=
=0A=
+               "%s: %s error, dev %s, sector %llu op 0x%x:(%s) flags 0x%x =
"=0A=
+               "phys_seg %u prio class %u\n",=0A=
                 caller, blk_errors[idx].name,=0A=
                 req->rq_disk ?  req->rq_disk->disk_name : "?",=0A=
-               blk_rq_pos(req), req_op(req),=0A=
-               req->cmd_flags & ~REQ_OP_MASK);=0A=
+               blk_rq_pos(req), req_op(req), req_op_str(req),=0A=
+               req->cmd_flags & ~REQ_OP_MASK,=0A=
+               req->nr_phys_segments,=0A=
+               IOPRIO_PRIO_CLASS(req->ioprio));=0A=
  }=0A=
=0A=
  static void req_bio_endio(struct request *rq, struct bio *bio,=0A=
=0A=
On 05/20/2019 10:16 AM, Chaitanya Kulkarni wrote:=0A=
> Printing separate operations and flags is useful.=0A=
>=0A=
> How about we also add couple of more fields ?=0A=
>=0A=
> Compile tested patch on the top of this patch :-=0A=
>=0A=
> @@ -176,11 +176,14 @@ static void print_req_error(struct request *req,=0A=
> blk_status_t status,=0A=
>                   return;=0A=
>=0A=
>           printk_ratelimited(KERN_ERR=0A=
> -               "%s: %s error, dev %s, sector %llu op 0x%x flags 0x%x\n",=
=0A=
> +               "%s: %s error, dev %s, sector %llu op 0x%x flags 0x%x "=
=0A=
> +               "phys_seg %u prio class %u\n",=0A=
>                   caller, blk_errors[idx].name,=0A=
>                   req->rq_disk ?  req->rq_disk->disk_name : "?",=0A=
> nit:- extra space after '?', if that is not intentional.=0A=
>                   blk_rq_pos(req), req_op(req),=0A=
> -               req->cmd_flags & ~REQ_OP_MASK);=0A=
> +               req->cmd_flags & ~REQ_OP_MASK,=0A=
> +               req->nr_phys_segments,=0A=
> +               IOPRIO_PRIO_CLASS(req->ioprio));=0A=
>    }=0A=
>=0A=
> On 05/20/2019 07:14 AM, Christoph Hellwig wrote:=0A=
>> Print the calling function instead of print_req_error as a prefix, and=
=0A=
>> print the operation and op_flags separately instrad of the whole field.=
=0A=
> Also, s/instrad/instead/.=0A=
>=0A=
>>=0A=
>> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
>> ---=0A=
>>    block/blk-core.c | 16 +++++++++-------=0A=
>>    1 file changed, 9 insertions(+), 7 deletions(-)=0A=
>>=0A=
>> diff --git a/block/blk-core.c b/block/blk-core.c=0A=
>> index 419d600e6637..b1f7e244340e 100644=0A=
>> --- a/block/blk-core.c=0A=
>> +++ b/block/blk-core.c=0A=
>> @@ -167,18 +167,20 @@ int blk_status_to_errno(blk_status_t status)=0A=
>>    }=0A=
>>    EXPORT_SYMBOL_GPL(blk_status_to_errno);=0A=
>>=0A=
>> -static void print_req_error(struct request *req, blk_status_t status)=
=0A=
>> +static void print_req_error(struct request *req, blk_status_t status,=
=0A=
>> +		const char *caller)=0A=
>>    {=0A=
>>    	int idx =3D (__force int)status;=0A=
>>=0A=
>>    	if (WARN_ON_ONCE(idx >=3D ARRAY_SIZE(blk_errors)))=0A=
>>    		return;=0A=
>>=0A=
>> -	printk_ratelimited(KERN_ERR "%s: %s error, dev %s, sector %llu flags %=
x\n",=0A=
>> -				__func__, blk_errors[idx].name,=0A=
>> -				req->rq_disk ?  req->rq_disk->disk_name : "?",=0A=
>> -				(unsigned long long)blk_rq_pos(req),=0A=
>> -				req->cmd_flags);=0A=
>> +	printk_ratelimited(KERN_ERR=0A=
>> +		"%s: %s error, dev %s, sector %llu op 0x%x flags 0x%x\n",=0A=
>> +		caller, blk_errors[idx].name,=0A=
>> +		req->rq_disk ?  req->rq_disk->disk_name : "?",=0A=
>> +		blk_rq_pos(req), req_op(req),=0A=
>> +		req->cmd_flags & ~REQ_OP_MASK);=0A=
>>    }=0A=
>>=0A=
>>    static void req_bio_endio(struct request *rq, struct bio *bio,=0A=
>> @@ -1418,7 +1420,7 @@ bool blk_update_request(struct request *req, blk_s=
tatus_t error,=0A=
>>=0A=
>>    	if (unlikely(error && !blk_rq_is_passthrough(req) &&=0A=
>>    		     !(req->rq_flags & RQF_QUIET)))=0A=
>> -		print_req_error(req, error);=0A=
>> +		print_req_error(req, error, __func__);=0A=
>>=0A=
>>    	blk_account_io_completion(req, nr_bytes);=0A=
>>=0A=
>>=0A=
>=0A=
>=0A=
=0A=
