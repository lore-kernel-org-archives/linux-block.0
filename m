Return-Path: <SRS0=jyL6=AO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66F8C433DF
	for <linux-block@archiver.kernel.org>; Fri,  3 Jul 2020 05:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0EF4206E2
	for <linux-block@archiver.kernel.org>; Fri,  3 Jul 2020 05:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Gwv8vE+v";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ebrHPaP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgGCF3y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jul 2020 01:29:54 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46781 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgGCF3x (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jul 2020 01:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593754210; x=1625290210;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5JsOPSej7+aFHAOy3nfrb03Rbf49T7CSImDWLuyjDYw=;
  b=Gwv8vE+vmcsS0saJWZqPZbmhhrZjqTETtiOd+dnAbuJOE+TianVCpOtb
   Hggpccso2wWBfRd1rT5PS90SeTpZo9NAUAHnE1JOWpKDhaQIcfWmlFiiP
   1DLSSDzf0iSVdk3KD7QM2IUqu9CP7GlP8/s4NaAxiB/FX8odNm5ZgQG82
   VRrijOhTzToh5zJaVxyqyCqFQ9QqtPME72vg7YmtMlC/aER97HA4lSr/N
   VQfS06sd4hMdhgm6DWfwQQ4uyAAx9Srr01Z9jxuacEU3DzNahEgBr7u6S
   xF9BCke30DFodF7CKIxBhUz2P8cfj1Zwpu3ytz0t3oKEc5pQP8QCwB1Dq
   A==;
IronPort-SDR: Sinpw/FSKkRAGruNjnYc5LcspgTMhy8rpqzlrlxYGAQqcsMBy+6Q0is6gV3Sa7R3ppclbYeNt+
 U3YZUCltgJlFLUsIOUqNnKiRgVoQCa1EAMInm96F6vRpja8mwWqKKT6NAAm0emzEuzDb5OuJyC
 AbncRQEwjmP8NcmenUWtcZ4+Lgz3jXxG5fVAdHxSuiSKmSFZup3cHVdfKUEdTfzKTJEahGf3yW
 Gp5EZVMcK4hLvj/lONk1iRSoss1Txr6mHEo2m0Vp7kmCO5n7NJv2NlRpDpjKTXR7wtPQ6VHCpm
 UWo=
X-IronPort-AV: E=Sophos;i="5.75,307,1589212800"; 
   d="scan'208";a="244567997"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 13:30:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGgymS+5EfL1OxMeVScesrOxFGKFc3Ap76zvH85qULfz9joroXlJ1zNZN4IE50hC9+RWgxjb1ZZN3s8+r/qBQ+wWxZyHoNHEeOIkI5zU08qELTqdQEc/zLMr6lOIZn7S6GMPPEIV8BaY90AmfuGLv0rV1f7EHQVNsKmOkQod2mTpjbXJKjtcxXe/UIZpl+XazeLO6LKjqi0YCAbm3JuqWg/vRJ23UVru9ulbieWShu58VhFL4KhF/W3zJeJIGev6n/ejyD+NhZwLcQuaDAHy7McLUc0Km66K4L1UrPumvqh6sprSmPXCd6ij/Juva+G3gsGJFmYQ9B73aIeclULgbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SxIR3OSup4huqNfKep53XN7RB3z2hMtK8hMabVd7Bw=;
 b=eNypSUsewzZrKpWOJpo8jutRQYxQv157secIcKK5x43b2BAP3DoHRaZ4y8Vu9G7ldpEG79si7Q4ZtF8daVct7l2w+TyRCR53qvpVlVf47paAz5S1KpvLELsjZVUNsc6Ai7q8k/NAzjkXQkh2QCnv11XyEc6xjtYLNQkK6qSViIuOEne3DBmhPx0rffsHmStXWqmENyOB0iUg9CepYJaSTkljP4zGA1aZnwWxTZT9YGKWCpujjCOIfNW9hGbbmhPpRO3I8peN9wBO22YeZjCoe/q9IaX0G1HfqJht/s5Dz5zZJMbVvvWkI93IHFdqO29eApEE/tnPOxYdP3R4sFz1tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SxIR3OSup4huqNfKep53XN7RB3z2hMtK8hMabVd7Bw=;
 b=ebrHPaP8VIJ5XcjvOzNdwKlPQAd2+0SuwbWajMjVmzt4TlewliBjHHK/EtH6ZLm1+uVw9w6bKdxyAFc9VWkMPMG2uEx/Awex1GYfKmY23v6OKazsv5Ph7/tXI//N+7lq3NYdsxAh7AnCo8hi65UDs0fQSNHBlia6Vnyz3kG/wus=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1031.namprd04.prod.outlook.com (2603:10b6:910:51::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Fri, 3 Jul
 2020 05:29:50 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3153.022; Fri, 3 Jul 2020
 05:29:50 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Kanchan Joshi <joshi.k@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, Selvakumar S <selvakuma.s1@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
Subject: Re: [PATCH 1/2] block: fix error code for zone-append
Thread-Topic: [PATCH 1/2] block: fix error code for zone-append
Thread-Index: AQHWUIdcNaHZ5okuAE6oiVJHNmJMWw==
Date:   Fri, 3 Jul 2020 05:29:50 +0000
Message-ID: <CY4PR04MB3751B8037BE65D573667A6D5E76A0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <1593704330-11540-1-git-send-email-joshi.k@samsung.com>
 <CGME20200702154208epcas5p39fe202f642a9d5c8dde9b911645c594c@epcas5p3.samsung.com>
 <1593704330-11540-2-git-send-email-joshi.k@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ef4f625b-90cf-4ba2-2d8b-08d81f121b92
x-ms-traffictypediagnostic: CY4PR04MB1031:
x-microsoft-antispam-prvs: <CY4PR04MB10315FEE5EA741C3FF0AEC59E76A0@CY4PR04MB1031.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AeCmm5hAc+nBIG76ZKes+0C3acaMhlE15qWG+1qNpwuO0P0GZeeKwNBdIg74MmC5dveZyUbFPaCYkGDNA9pfJfa7g0ma9FqpcxMf6fIlkgvsMsIFe3b34niv3n3c2D3wVhPEI7lLKSVmxUl+LtJldU47ybgTcMq2Vo5i6/I9g2BNw6FKxcsZ7cJnLt7z5TkmqOXefU5jwduYaqLYss1aBFYn7f/BByuIPFd5gzhhKtsZVjAbSWtOalG5I0P/r+8jZU+C8/O7lXzE5hyjUfzMjfOQ42dAJ59gI2Tcyf8SI6tk96h3tDt6gNsUWkzqpNE+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(8676002)(53546011)(5660300002)(6506007)(26005)(52536014)(2906002)(186003)(8936002)(33656002)(66556008)(64756008)(66446008)(66476007)(86362001)(66946007)(76116006)(91956017)(478600001)(316002)(71200400001)(55016002)(83380400001)(9686003)(4326008)(110136005)(54906003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: JXmDoRBZaw9VbI065zh1BGcV4csd/8+EOVQIboepkewaCApQ/fxJDEBbZ0n5VL0wucZ2fVDv15GZqYQ4vU88w4AkQlsG6rgu0LkS/imYE9baqMZ84ZGELEYt2b8VHkaVnHaUqSJC7G3F4lzAyXRK4nhBBBk+MCDUvgErm+i2+tViEV/bi8jcmmoHoXAMSusmCR64ggou5qVN7BuUPOrnIGbaUG7IYuoTMK3tCjLVP5JCxAOroCGOfsaMVt04Ec9i2BdiPqX7U/jxkHeOteMQ0ns0T0xkUU3+yPTHtMzs9DAXmuuqk2fMAZ8JNQdED4Ekayiw6ORWdNFbjJfPusVwAk4KO1rWC/swjkHZVKj2YlieaJUq3RhMFdQFCdME2Qww1qcdFknVYdop1+9nJn270r0QNU+quGxPeFZVoCfdSZzBDxoVDY13WSx3+VOvmqKmreuNXvUoCv6mq73pWnVL3+m5drHjiWFOmLXtNyZn0eQDzlWGrryEsYEhzX4aeqF3
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4f625b-90cf-4ba2-2d8b-08d81f121b92
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 05:29:50.3853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jl1tZqvNAmy0k39hTYjXWFOvEi91XCYrnGGTZgCh8NjX7cjMxhqIRsDviFR+/nrj6bonAc6gOPjGrhb1kyK9hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1031
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/07/03 0:42, Kanchan Joshi wrote:=0A=
> avoid returning success when it should report failure, preventing=0A=
> odd behavior in caller.=0A=
=0A=
You can be more precise here: the odd behavior is an infinite loop in=0A=
bio_iov_iter_get_pages() whcih is is the only user of __bio_iov_append_get_=
pages().=0A=
=0A=
> =0A=
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>=0A=
> Signed-off-by: Selvakumar S <selvakuma.s1@samsung.com>=0A=
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>=0A=
> Signed-off-by: Javier Gonzalez <javier.gonz@samsung.com>=0A=
> ---=0A=
>  block/bio.c | 2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/block/bio.c b/block/bio.c=0A=
> index a7366c0..0cecdbc 100644=0A=
> --- a/block/bio.c=0A=
> +++ b/block/bio.c=0A=
> @@ -1044,7 +1044,7 @@ static int __bio_iov_append_get_pages(struct bio *b=
io, struct iov_iter *iter)=0A=
>  	size_t offset;=0A=
>  =0A=
>  	if (WARN_ON_ONCE(!max_append_sectors))=0A=
> -		return 0;=0A=
> +		return -EINVAL;=0A=
>  =0A=
>  	/*=0A=
>  	 * Move page array up in the allocated memory for the bio vecs as far a=
s=0A=
> =0A=
=0A=
Note: the odd behavior mentioned in the commit message cannot currently be=
=0A=
triggered since only zonefs issues REQ_OP_ZONE_APPEND BIOs so we are guaran=
teed=0A=
that max_append_sectors is not 0 in that case. But this fix certainly makes=
=0A=
things more solid. So:=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
