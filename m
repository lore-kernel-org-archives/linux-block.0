Return-Path: <SRS0=q1Dd=2J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAF3C43603
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 10:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3BE2146E
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 10:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lTPzULDo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fJwL2TaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfLSKFN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:05:13 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:59256 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfLSKFN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Dec 2019 05:05:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576749914; x=1608285914;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=pBU+swombyKBVilj489x49FSji64f6TwZUYtkix2GFs=;
  b=lTPzULDoSUcabdGM1t0atU98yYfjccNUzJPp61iBVmN6U2HEXg+qSZTn
   hyxt8z1Lb4yH2OY3ItuhSKuYVLenBCsCxRxjk+HdmkMjBz7xs4+RItAVG
   UInn30WQIaPgD7ML9fMi0Qr0RwIBTRxcWbKCa8GbabIlL5jqc2pa6sOus
   dYgjeqeRnGkZV9BRFZzg2qMOc43Bv8g6rPMRx1vyP4n8B06hk86LZ0uID
   vHEkhBjEGpr6q2kfJLN/ODzQe744dypphAR01EVeq0Gjx5sC9DhAuK/73
   AAHIFDRCUpdVwqRXuJMJAuwdAhTvOuv9yvpEO1THBYTO1nP39Il2KZwwn
   Q==;
IronPort-SDR: QEoeEd39WOSQO58Sxe/OnHWVA3umLxZmfqPhwVZu8wuRat3Ui4yp/IvjygBU9kHwiuAQFTLKA8
 WUxA+Xesg1iLXMg8E0ZrK0ds8dUa7Vkl1AYOeVTNwREpPXYa35zomEEOziSvh6ItZ41C1mX8xB
 Rre+LZGPUCcFNDLVNgKM7RBX178nCiglYZWDsbsJB72INXjPFbsrTx68ftzGL8gtHhiU8cy/il
 pG5QDOjB+odY08Zvz/9HmQImkhsB0C0148GYki/M5WwizOWRPImfZ6Or9ZtthgDBtl6wGNVeJL
 I+o=
X-IronPort-AV: E=Sophos;i="5.69,331,1571673600"; 
   d="scan'208";a="130148130"
Received: from mail-cys01nam02lp2050.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.50])
  by ob1.hgst.iphmx.com with ESMTP; 19 Dec 2019 18:05:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkbLz9IyIXGp77FLNFVbkaG2V9fAt84EGe7ebwi52PC/xtDwUtfD4NaLQr3v84yuS/w3tCbEI444ABqnjPU0roIIo6N1LaI6rDS+PWIulxHi/4XaEmFq3Zcgt9FNCfzAZRT8pp/qpM7fdUIzMK1tN0E4UiB3dgAi7wSCUPi8wtQrQ/PnI8Nmy+xZSnp+lbIyXpTCWAomIx+HNPWqIep+gZ0LwRJv0HRspF7bLxLd+aRl4M7Icirtisbd0o6/Wv9I1KKc9N2NpvvBo91Qp2zhjsLg0Aey3T3ugj3hkrP/jV7f0g23WweJJUlpl6RAuayaCcmot73jiVdUQ4t+j15cVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LsL9KPpC36m0i2yg9SlzvPgGMrRzE/9rz/ICKpnu2M=;
 b=MIXZKgyRtnS+2B6PuOvbK7Ftsy5R5EiawyPcUAmzVa5iqlWultFtqPoheb9oa+TkSpn6KtMROBIfKftxa7CMq8i5d4hNOlKN1/yWhNAUuzz22sHhQFAz9YEgFDNXCTi+wIL0+rqHlRTJAaqSgZEX2sW3Q8yXrwtZGmkxg4wqLQNdFo63gLZH3PhewmveNWvAIeFVuO3GghYX5g/g7ASmsuLjGtdxuramlUDqrqfPTOtlA6jUEiqd7m5HAcsLTe922ynphrVlyZQkagythxMc2RVzavZY4xA8tXK+9UV3GJfMMdo4e73y3gcgg30PeJbcYHdB3IoJAgYUpwQObm41Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LsL9KPpC36m0i2yg9SlzvPgGMrRzE/9rz/ICKpnu2M=;
 b=fJwL2TaMFxuzXJSjs5lYRSj3w0PYV259BR/QMsvNU3Es47ipHRGC3xxZFCG59rd2VqTkmhMQtDMsCA0LoiTN5tDZueY8TehJvzZ5UVXKySho0d8+FBmEcQx1naawHW+dcCQ5i8d3zre39Q1nxo7okzf2hleFMTZDJHifhZbdeP0=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB5973.namprd04.prod.outlook.com (20.178.232.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.13; Thu, 19 Dec 2019 10:05:11 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 10:05:11 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: streamline merge possibility checks
Thread-Topic: [PATCH] block: streamline merge possibility checks
Thread-Index: AQHVtds3gvv758TRjk2Vxwq5MwJGAQ==
Date:   Thu, 19 Dec 2019 10:05:11 +0000
Message-ID: <BYAPR04MB58169E41866049EFBF1C1E67E7520@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20191218194156.29430-1-dmitry.fomichev@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b94070a2-8aa7-42bc-db35-08d7846aef50
x-ms-traffictypediagnostic: BYAPR04MB5973:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB59732BEC5ED1DDFA645489E6E7520@BYAPR04MB5973.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(189003)(199004)(26005)(7696005)(53546011)(6506007)(186003)(64756008)(76116006)(66476007)(71200400001)(66946007)(66556008)(33656002)(66446008)(52536014)(5660300002)(86362001)(110136005)(91956017)(81156014)(81166006)(8676002)(55016002)(2906002)(9686003)(478600001)(316002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5973;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XhKJWaiqNRygKTP4FCmxspL4oTizhkwiZrbsG/NkAqSSTF+LrP5TnoJkp13QWiFk/gnFF+1T7/VFKbBZC03bigAKQI/fgEiLbqsSmLlx1sBVSS+3k1GYShsyFvl77v0c1r+J0BVDpbKurVdO2yA9gxwpzRwUJ7EBB2VIIINz0VABDFHY0wJFgpcjhK7vueJJfzQSG0dRdWS5VUCedEe+LiVD2wWALaE/NoamK1qQUX1jSujEmPHYf0IWfzlSet9HrqOErvBK1nj1TWx7UTijFaT67weN7LzdxUiK8VIJR6ek9IGEJ35cYJBH30FMN+PJMPs7SLVPM3dj6mgEddbLQi9df5RqdHm7uYFd9tegzshO3conIe7YWNPYiDRgib3LHVsFguoob1ZDYdn0AoZXIqja+W52rr69zc9cDnj4MGHbzwKI6CMLNdYgnhqh2WkW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b94070a2-8aa7-42bc-db35-08d7846aef50
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 10:05:11.1208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ax+bXNSxUYkQswSm1Ic35GIAJWBZCvQyOi/UhAkapV1ZME3Wx1CruYfCupmYijmabeQd52rHk9+gZvbkrEdiZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5973
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/12/19 4:42, Dmitry Fomichev wrote:=0A=
> Checks for data direction in attempt_merge() and blk_rq_merge_ok()=0A=
> are redundant and will always succeed when the both I/O request=0A=
> operations are equal. Therefore, remove them.=0A=
> =0A=
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>=0A=
> ---=0A=
>  block/blk-merge.c | 7 +------=0A=
>  1 file changed, 1 insertion(+), 6 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-merge.c b/block/blk-merge.c=0A=
> index d783bdc4559b..796451aed7d6 100644=0A=
> --- a/block/blk-merge.c=0A=
> +++ b/block/blk-merge.c=0A=
> @@ -745,8 +745,7 @@ static struct request *attempt_merge(struct request_q=
ueue *q,=0A=
>  	if (req_op(req) !=3D req_op(next))=0A=
>  		return NULL;=0A=
>  =0A=
> -	if (rq_data_dir(req) !=3D rq_data_dir(next)=0A=
> -	    || req->rq_disk !=3D next->rq_disk)=0A=
> +	if (req->rq_disk !=3D next->rq_disk)=0A=
>  		return NULL;=0A=
>  =0A=
>  	if (req_op(req) =3D=3D REQ_OP_WRITE_SAME &&=0A=
> @@ -868,10 +867,6 @@ bool blk_rq_merge_ok(struct request *rq, struct bio =
*bio)=0A=
>  	if (req_op(rq) !=3D bio_op(bio))=0A=
>  		return false;=0A=
>  =0A=
> -	/* different data direction or already started, don't merge */=0A=
> -	if (bio_data_dir(bio) !=3D rq_data_dir(rq))=0A=
> -		return false;=0A=
> -=0A=
>  	/* must be same device */=0A=
>  	if (rq->rq_disk !=3D bio->bi_disk)=0A=
>  		return false;=0A=
> =0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
