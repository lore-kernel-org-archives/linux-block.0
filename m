Return-Path: <SRS0=+9gR=V5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4B5C433FF
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 04:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C866206A3
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 04:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ilmvTO/s";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dVT9jgJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbfHAEvS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Aug 2019 00:51:18 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:61040 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfHAEvR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Aug 2019 00:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564635077; x=1596171077;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6bMaRZo3xXodSQRTUvULyPX/TC0tmYpZCVG6bWTxKDs=;
  b=ilmvTO/sP1RywvsuqHMA/OyRPRc7kFnRnAiq2393c8pQAqaEA9ATyd8T
   Q/f8/GFSlcfWzBWwMVgGcMSbfFnqhJFl6AxEQ5/4q+Jsxg2/mM3YgKvCq
   JlxLdtdXPc8P1SDuo19NsLUrjHwZVqTJV3xPiAZMQ8fqMhIGzIYFkhybo
   2Wizf3/ndDBaY/MmU7PVp4oLZw0LuGKYuRGFKDgIswIZamBfhkSEKuX1O
   sg/gjId9tMEyHD5nvKJcctxi2BfrI9PJKQuBhueHpJ1L10YsIBIw6BLzj
   QnvSam+q7dOTlrZ8nW4J/8oQ+e1QDjwtWt1J87tLRVKzxpOYhfinwwEvT
   g==;
IronPort-SDR: RVeP5VHVN1b/wprtZRuhwYF4jy91oePoTedGUVOcprWUu7iQ52s8qyZUAtAiHvuGNBgsFVrnbu
 BMtaYZyX3njNVLI2+ltdXeKrXFG4NY2GQ4qOqkit6u8Gf3CYicsfbRWdYO9c5iIlp7cxRIl+k0
 q+C01kIr82ZOZYNMG8heDwdM3xZRrHGKVq9eAems8BAOrs2+NGM/5sE/A1vmUYhoG5wi8PrWTL
 5ZccmpHrvTaVgeCp4v6cfc/ZXsTyPij4PN/VaIWkBe8HaGczl0PntKkONqdbaeleqVugzh7Rq4
 Vgg=
X-IronPort-AV: E=Sophos;i="5.64,333,1559491200"; 
   d="scan'208";a="119333659"
Received: from mail-bl2nam02lp2059.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.59])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2019 12:51:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Upf1aK1EjPTpGWicJYnOFZuhZjt7o1SzST3JCcFtmZU3XDqOXx8UlprZYuP50sMGCyGMkLJzzNJtzjdYwIUpnQp8vTFynRKUqzvcP24zpr29fVlS9JumgxTDqfZiExug2D2MdPPzi6JbDO9+EbY3SORK88jYCBJ2yL2oKWBtTxSqqOXE2TtCr5Ne9fVW4Fc5h7MjKS/Lzm/XZ8Wx0sNixTfMEJexG7Ak7SfwuxyHw+a8sQf3K5375aTgwzp8+fZwMUhD93g7Nc34dqjRHQLOnT4b08obt17XfTZjMhiwPi755Fv8C2WM2+47+VZ55CMEOxOvYxsHIuImwbdEaw0uQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bMaRZo3xXodSQRTUvULyPX/TC0tmYpZCVG6bWTxKDs=;
 b=LBSU+ZJFydcIsH+6NuPpra0fMCB5pjsWG7THzip4rlfQXkCwMNqelkqXe3BrpkiaXlJdgZZ0EgtIjeP8rEqScAtRQ407iyoaw+veAiQXxZzQxmg9Xb11bgnFTRDcIuk4+22/Xe7P/mRN3PK1Zjralkr1jXLmlgwelkZuAIPWBoJmglM0cO8Ga8fGPVnkC0o0vHD8cZZhG1t4B6kmAukJmarxftZ19VWQ0jT0tXScHvlCGMYHQc3WoaFU7/hoZ+wxxuxXSj2Hn+5VfDa58og0bhLAG1oVGg7LHYi7cwLj3Q/n9hOSA9aDnyVgcGh/v1I589n4OYZ+Uhl0mE9mZg74HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bMaRZo3xXodSQRTUvULyPX/TC0tmYpZCVG6bWTxKDs=;
 b=dVT9jgJkh3KwVPCNqJcRvBfJs8SyN6/gGGT+6iykMj00FH5ES6exzg+/FzsT78gpK8UODIy/8bW7uq3iwc58jlYZyGpBz9dlDm+8kRwusaP7fxS68sKGFAXhnkdKzfzaxhV7for15jYKdzZhgRTSiIY2mdcFJWhwtDbDpb84bJc=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4086.namprd04.prod.outlook.com (52.135.215.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Thu, 1 Aug 2019 04:51:13 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::8025:ccea:a0e6:9078]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::8025:ccea:a0e6:9078%5]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 04:51:12 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "dennis@kernel.org" <dennis@kernel.org>,
        "hare@suse.com" <hare@suse.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "dennisszhou@gmail.com" <dennisszhou@gmail.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "osandov@fb.com" <osandov@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [PATCH 2/4] blk-zoned: implement REQ_OP_ZONE_RESET_ALL
Thread-Topic: [PATCH 2/4] blk-zoned: implement REQ_OP_ZONE_RESET_ALL
Thread-Index: AQHVR+MrecJm/4ZQfkuoGjf1UQftVKbluEsW
Date:   Thu, 1 Aug 2019 04:51:12 +0000
Message-ID: <BYAPR04MB5749C69F6D0A1321DD21B5CD86DE0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190731210102.3472-1-chaitanya.kulkarni@wdc.com>
 <20190731210102.3472-3-chaitanya.kulkarni@wdc.com>,<BYAPR04MB581622D19EDA3071AE618634E7DE0@BYAPR04MB5816.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB581622D19EDA3071AE618634E7DE0@BYAPR04MB5816.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e889af9-04e4-48ff-ccfb-08d7163be0fe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4086;
x-ms-traffictypediagnostic: BYAPR04MB4086:
x-microsoft-antispam-prvs: <BYAPR04MB408694A7068FFDCF35BF326B86DE0@BYAPR04MB4086.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(199004)(189003)(2501003)(4326008)(2201001)(99286004)(53936002)(54906003)(8936002)(33656002)(68736007)(81156014)(8676002)(478600001)(316002)(7696005)(14444005)(102836004)(71200400001)(71190400001)(6506007)(53546011)(76176011)(26005)(186003)(2906002)(110136005)(7416002)(66066001)(74316002)(476003)(486006)(11346002)(81166006)(14454004)(256004)(6246003)(64756008)(66556008)(25786009)(66476007)(86362001)(7736002)(6436002)(446003)(305945005)(3846002)(66946007)(66446008)(6116002)(5660300002)(52536014)(76116006)(55016002)(229853002)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4086;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Dtp/LHz9QkrqhrzAVym5+Auq72gO1K0wPs+kH3HTg+oj9L7hlvzPoKumlsb2ybRzsKu5+ZXflkSisZPTfPPrMcEkL7lbucw0zja9fklqxIRIBqnw8x6dqeJBEpN99B3YpNmvqti542ckgZKQ5NZ7SMI/JLdav3bHxJnH6Nz2NjPjvDijND0S/D6jSig8tcGgkzJLpCV4+asYrjQzTayKOQzOtXAmXeSJjPyLIzXkOxanj+j05Ex3cpfcwDCsIlM0fCqhYSyNcnXSUQmApdicsxxpXd0Gs44F1LQ8BRAlQl5ifuIG5S1GI5ybHu5p8ZIbJiXuw8rc4Mhmt2cYhwaszLkShsBZfIrGkgqetikN3cyTpECqn4LNr1EkZovl4Dg0/rbLd2ViBerSf81+7eNL7wDgtgly0s9ESyejMB7LPv4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e889af9-04e4-48ff-ccfb-08d7163be0fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 04:51:12.8791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4086
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
From: Damien Le Moal <Damien.LeMoal@wdc.com>=0A=
=0A=
Sent: Wednesday, July 31, 2019 5:55 PM=0A=
=0A=
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>; linux-block@vger.kerne=
l.org <linux-block@vger.kernel.org>; linux-scsi@vger.kernel.org <linux-scsi=
@vger.kernel.org>=0A=
=0A=
Cc: axboe@kernel.dk <axboe@kernel.dk>; jejb@linux.ibm.com <jejb@linux.ibm.c=
om>; dennis@kernel.org <dennis@kernel.org>; hare@suse.com <hare@suse.com>; =
sagi@grimberg.me <sagi@grimberg.me>; dennisszhou@gmail.com <dennisszhou@gma=
il.com>; jthumshirn@suse.de=0A=
 <jthumshirn@suse.de>; osandov@fb.com <osandov@fb.com>; ming.lei@redhat.com=
 <ming.lei@redhat.com>; tj@kernel.org <tj@kernel.org>; bvanassche@acm.org <=
bvanassche@acm.org>; martin.petersen@oracle.com <martin.petersen@oracle.com=
>=0A=
=0A=
Subject: Re: [PATCH 2/4] blk-zoned: implement REQ_OP_ZONE_RESET_ALL=0A=
=0A=
=A0=0A=
=0A=
=0A=
On 2019/08/01 6:01, Chaitanya Kulkarni wrote:=0A=
=0A=
> This implements REQ_OP_ZONE_RESET_ALL as a special case of the block=0A=
=0A=
> device zone reset operations where we just simply issue bio with the=0A=
=0A=
> newly introduced req op.=0A=
=0A=
> =0A=
=0A=
> We issue this req op when the number of sectors is equal to the device's=
=0A=
=0A=
> partition's number of sectors and device has no partitions.=0A=
=0A=
> =0A=
=0A=
> We also add support so that blk_op_str() can print the new reset-all=0A=
=0A=
> zone operation.=0A=
=0A=
> =0A=
=0A=
> This patch also adds a generic make request check for newly=0A=
=0A=
> introduced REQ_OP_ZONE_RESET_ALL req_opf. We simply return error=0A=
=0A=
> when queue is zoned and reset-all flag is not set for=0A=
=0A=
> REQ_OP_ZONE_RESET_ALL.=0A=
=0A=
> =0A=
=0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
> ---=0A=
=0A=
>=A0 block/blk-core.c=A0 |=A0 5 +++++=0A=
=0A=
>=A0 block/blk-zoned.c | 40 ++++++++++++++++++++++++++++++++++++++++=0A=
=0A=
>=A0 2 files changed, 45 insertions(+)=0A=
=0A=
> =0A=
=0A=
> diff --git a/block/blk-core.c b/block/blk-core.c=0A=
=0A=
> index d0cc6e14d2f0..1b53ab56228b 100644=0A=
=0A=
> --- a/block/blk-core.c=0A=
=0A=
> +++ b/block/blk-core.c=0A=
=0A=
> @@ -129,6 +129,7 @@ static const char *const blk_op_name[] =3D {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 REQ_OP_NAME(DISCARD),=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 REQ_OP_NAME(SECURE_ERASE),=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 REQ_OP_NAME(ZONE_RESET),=0A=
=0A=
> +=A0=A0=A0=A0 REQ_OP_NAME(ZONE_RESET_ALL),=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 REQ_OP_NAME(WRITE_SAME),=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 REQ_OP_NAME(WRITE_ZEROES),=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 REQ_OP_NAME(SCSI_IN),=0A=
=0A=
> @@ -931,6 +932,10 @@ generic_make_request_checks(struct bio *bio)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!blk_queue_is_zoned(q))=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto=
 not_supported;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> +=A0=A0=A0=A0 case REQ_OP_ZONE_RESET_ALL:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!blk_queue_is_zoned(q) || !blk_=
queue_zone_resetall(q))=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto not_su=
pported;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 case REQ_OP_WRITE_ZEROES:=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!q->limits.max_write_zer=
oes_sectors)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto=
 not_supported;=0A=
=0A=
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
=0A=
> index 6c503824ba3f..d1ed728b7464 100644=0A=
=0A=
> --- a/block/blk-zoned.c=0A=
=0A=
> +++ b/block/blk-zoned.c=0A=
=0A=
> @@ -202,6 +202,43 @@ int blkdev_report_zones(struct block_device *bdev, s=
ector_t sector,=0A=
=0A=
>=A0 }=0A=
=0A=
>=A0 EXPORT_SYMBOL_GPL(blkdev_report_zones);=0A=
=0A=
>=A0 =0A=
=0A=
> +/*=0A=
=0A=
> + * Special case of zone reset operation to reset all zones in one comman=
d,=0A=
=0A=
> + * useful for applications like mkfs.=0A=
=0A=
> + */=0A=
=0A=
> +static int __blkdev_reset_all_zones(struct block_device *bdev, gfp_t gfp=
_mask)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct bio *bio =3D NULL;=0A=
=0A=
=0A=
=0A=
There is no need to initialize the bio to NULL here.=0A=
=0A=
[CK] Would you prefer something like following that declares and allocate=
=0A=
in one line which is similar in blk-lib.c:-blk_next_bio() function ? or we =
should keep=0A=
declaration and allocation on the different line :-=0A=
/*=0A=
=A0* Special case of zone reset operation to reset all zones in one command=
,=0A=
=A0* useful for applications like mkfs.=0A=
=A0*/=0A=
static int __blkdev_reset_all_zones(struct block_device *bdev, gfp_t gfp_ma=
sk)=0A=
{=0A=
=A0 =A0 =A0 =A0 struct bio *bio =3D bio_alloc(gfp_mask, 0); =0A=
=A0 =A0 =A0 =A0 int ret; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =0A=
=0A=
=A0 =A0 =A0 =A0 /* across the zones operations, don't need any sectors */=
=0A=
=A0 =A0 =A0 =A0 bio_set_dev(bio, bdev);=0A=
=A0 =A0 =A0 =A0 bio_set_op_attrs(bio, REQ_OP_ZONE_RESET_ALL, 0); =0A=
=0A=
=A0 =A0 =A0 =A0 ret =3D submit_bio_wait(bio);=0A=
=A0 =A0 =A0 =A0 bio_put(bio);=0A=
=0A=
=A0 =A0 =A0 =A0 return ret;=0A=
}=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* across the zones operations, don't need any sectors */=
=0A=
=0A=
> +=A0=A0=A0=A0 bio =3D bio_alloc(gfp_mask, 0);=0A=
=0A=
> +=A0=A0=A0=A0 bio_set_dev(bio, bdev);=0A=
=0A=
> +=A0=A0=A0=A0 bio_set_op_attrs(bio, REQ_OP_ZONE_RESET_ALL, 0);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D submit_bio_wait(bio);=0A=
=0A=
> +=A0=A0=A0=A0 bio_put(bio);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return ret;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static inline bool blkdev_allow_reset_all_zones(struct block_device *bde=
v,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sector_t nr_se=
ctors)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 if (!blk_queue_zone_resetall(bdev_get_queue(bdev)))=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return false;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 if (nr_sectors !=3D part_nr_sects_read(bdev->bd_part))=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return false;=0A=
=0A=
> +=A0=A0=A0=A0 /*=0A=
=0A=
> +=A0=A0=A0=A0=A0 * REQ_OP_ZONE_RESET_ALL can be executed only if the bloc=
k device is=0A=
=0A=
> +=A0=A0=A0=A0=A0 * the entire disk, that is, if the blocks device start o=
ffset is 0 and=0A=
=0A=
> +=A0=A0=A0=A0=A0 * its capacity is the same as the entire disk.=0A=
=0A=
> +=A0=A0=A0=A0=A0 */=0A=
=0A=
> +=A0=A0=A0=A0 return get_start_sect(bdev) =3D=3D 0 &&=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 part_nr_sects_read(bdev->bd_part) =3D=
=3D get_capacity(bdev->bd_disk);=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
>=A0 /**=0A=
=0A=
>=A0=A0 * blkdev_reset_zones - Reset zones write pointer=0A=
=0A=
>=A0=A0 * @bdev:=A0=A0=A0 Target block device=0A=
=0A=
> @@ -235,6 +272,9 @@ int blkdev_reset_zones(struct block_device *bdev,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Out of range */=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
>=A0 =0A=
=0A=
> +=A0=A0=A0=A0 if (blkdev_allow_reset_all_zones(bdev, nr_sectors))=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return=A0 __blkdev_reset_all_zones(=
bdev, gfp_mask);=0A=
=0A=
> +=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* Check alignment (handle eventual smaller last zon=
e) */=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 zone_sectors =3D blk_queue_zone_sectors(q);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (sector & (zone_sectors - 1))=0A=
=0A=
> =0A=
=0A=
=0A=
=0A=
=0A=
=0A=
-- =0A=
=0A=
Damien Le Moal=0A=
=0A=
Western Digital Research=0A=
=0A=
