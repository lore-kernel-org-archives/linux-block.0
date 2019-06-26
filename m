Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94272C48BD6
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 20:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682E0216FD
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 20:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mQ9JAXKA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KbmUI03n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfFZUrV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:47:21 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1905 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfFZUrU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 16:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561582057; x=1593118057;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=H0J412rl7bxYW6HxW44BbhhD36/E7neAPR6opMrZZMM=;
  b=mQ9JAXKAsSMLhwFILbi4hHBz7YXaFgrW+tDZ+7Rup9z4TKC2+z8W7lj6
   4DAsX+gSpcnE1CSQ8/wgqbzn3em/US1+iRLiMixegb7QQF0+66B4OiDih
   6YNpEe5x0wHTQVdAln5YzwNNmZ6z/OYEEvRO2MUsfPmFASsxc0kbdexqe
   vIRU/Msm6InSgdP39OzpYqYxmjcDztLi+ueMB3sYsmRQYygc5XfLKjVU+
   3fDN7Bisq+EfScebPpYzG+jJv6HuNfSuizIHsfK9Lx5mEvst3A8KEs3K0
   AmN4YSMsXblv1RDUcNhnBvsMTcyseRaZV/ZZ+9GiMXhKtoma1rci5EoRz
   A==;
X-IronPort-AV: E=Sophos;i="5.63,421,1557158400"; 
   d="scan'208";a="211429859"
Received: from mail-sn1nam04lp2053.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.53])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2019 04:47:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=YDc/hdkgU9h5ZbuXQ2EDZ+kurHlUcS+MyBkyTo+ONtZE3Uaewr6tBA5rKiy3Wc69oz85TVi6rbDDBUnZnmLHFh/pHORDR9KIqjLkXuJ3g+K5lB38BwjbAZyKGrAOdwcNYtA2mJ/bHZpChuObucVKMu7ZRqCvo7ojZorTQnxBDTU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2EDxbD/QkrnQvjKpBdd2FpHFbwjDrWdw1rO+797fb0=;
 b=Y36qgkxObY9+Wzcn6MCgOKPejRoILvn+5lbbOArAKRpzbVsMUSDpbOBEFgDvlOA+/7qp95YINDRPZdnqUwhlc2UtEHMfyubLc8NCz32RK/5g+xe2xt0rVkETfwuKB/OzgKRgEbw2+33yTMNQtIjEtnSZpIcu5wS37AkziGj5fok=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2EDxbD/QkrnQvjKpBdd2FpHFbwjDrWdw1rO+797fb0=;
 b=KbmUI03nV9l8/EEpnzZDsTUKqQy5IK+tIADuGCkayEeD4QYKuOv0qva0znPjtDspCfXHeAkXWQq73Y9sGaNHw231em3VZDeNLWgLbFxWyUQHc6LSbtVXAx7suVJZL5jwN7d2jwqwoQe8FUjBYypV523LFEh1z9f7avU7sScr0RE=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5109.namprd04.prod.outlook.com (52.135.235.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.17; Wed, 26 Jun 2019 20:47:18 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6%7]) with mapi id 15.20.2008.018; Wed, 26 Jun 2019
 20:47:18 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 4/9] block: use bio_release_pages in bio_map_user_iov
Thread-Topic: [PATCH 4/9] block: use bio_release_pages in bio_map_user_iov
Thread-Index: AQHVLCYE6NWpddcEOkmRSoIxfn35xw==
Date:   Wed, 26 Jun 2019 20:47:18 +0000
Message-ID: <BYAPR04MB5749CC2028165E2E8FE4819486E20@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190626134928.7988-1-hch@lst.de>
 <20190626134928.7988-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d5ba857-6982-4487-78ff-08d6fa777ad4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB5109;
x-ms-traffictypediagnostic: BYAPR04MB5109:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB51095A6E97102E427406254086E20@BYAPR04MB5109.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:568;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39860400002)(136003)(189003)(199004)(186003)(305945005)(66066001)(74316002)(7736002)(26005)(71190400001)(33656002)(71200400001)(8936002)(6436002)(102836004)(6246003)(25786009)(55016002)(81166006)(68736007)(99286004)(110136005)(4326008)(478600001)(8676002)(7696005)(81156014)(53546011)(6506007)(76176011)(53936002)(9686003)(86362001)(316002)(66946007)(66476007)(2906002)(5660300002)(66556008)(64756008)(66446008)(73956011)(52536014)(76116006)(3846002)(6116002)(72206003)(476003)(4744005)(486006)(14454004)(256004)(229853002)(446003)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5109;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ocsO5mss1jwnfXoOcjUhGoXn+17dE0KR+85pYYTlydCdvCsJb4QUbpqv+8CUYI6QWJMV8N1U44VDfjdRHMgXvs4uwB93IunVaGkUgsLyWR+6mbJuV10jRBRtXpF19yx9kbRAAAoOHUM5oNG0mm4OhTuyiHNOiUwlZu/jFXJFby4ViiBw6smTShwhF3G1nlt9WJiHgH75pYgxbZL9HhCvG71lmRF1Bytt4xXLoKh8mH6jK6dc4m4COGGayVp7ijCEdmFt8T6gtfSZ4fj4PPnTJKoM7QcPWLIlNKcbn/P2+D8kg+3K8zUxrQxVtPsSWNjxn82tBGnBOwxNv2QzKwG9kZHsPqIX2V4DwwW4zqpaJxy4ix0Og7N5dYABT/+f3u4tFako6+pHRvcnRxZKmrdss1EKVzCWmVQmQ/I4YeliZv0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5ba857-6982-4487-78ff-08d6fa777ad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 20:47:18.6781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5109
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 06/26/2019 06:49 AM, Christoph Hellwig wrote:=0A=
> Use bio_release_pages instead of open coding it.=0A=
>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>   block/bio.c | 6 +-----=0A=
>   1 file changed, 1 insertion(+), 5 deletions(-)=0A=
>=0A=
> diff --git a/block/bio.c b/block/bio.c=0A=
> index 20a16347bcbb..a96d33d2de44 100644=0A=
> --- a/block/bio.c=0A=
> +++ b/block/bio.c=0A=
> @@ -1362,8 +1362,6 @@ struct bio *bio_map_user_iov(struct request_queue *=
q,=0A=
>   	int j;=0A=
>   	struct bio *bio;=0A=
>   	int ret;=0A=
> -	struct bio_vec *bvec;=0A=
> -	struct bvec_iter_all iter_all;=0A=
>=0A=
>   	if (!iov_iter_count(iter))=0A=
>   		return ERR_PTR(-EINVAL);=0A=
> @@ -1430,9 +1428,7 @@ struct bio *bio_map_user_iov(struct request_queue *=
q,=0A=
>   	return bio;=0A=
>=0A=
>    out_unmap:=0A=
> -	bio_for_each_segment_all(bvec, bio, iter_all) {=0A=
> -		put_page(bvec->bv_page);=0A=
> -	}=0A=
> +	bio_release_pages(bio, false);=0A=
>   	bio_put(bio);=0A=
>   	return ERR_PTR(ret);=0A=
>   }=0A=
>=0A=
=0A=
