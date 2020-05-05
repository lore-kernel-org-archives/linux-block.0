Return-Path: <SRS0=vpK8=6T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD3CC47256
	for <linux-block@archiver.kernel.org>; Tue,  5 May 2020 06:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D67A0206CC
	for <linux-block@archiver.kernel.org>; Tue,  5 May 2020 06:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JaWEu4Eg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Tn/udvAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbgEEGoJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 May 2020 02:44:09 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:23149 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgEEGoI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 May 2020 02:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588661061; x=1620197061;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=QH5PEeUagO467pxOfFYJQbnfHHkIe71pStFGUybtrVg=;
  b=JaWEu4EgvEVNbTOD2+H/ZFy67UAzQQAJ6HLPinu9Zu66vrXNJnuEGM/m
   G5KRkRAjPBuxmHA2L1Abhc1iXcXElCtTBrZ4k71+Ubvaz3cwE/Axp7koO
   2A0OVyH3V4GM/JRyifXBxbwiAuMBUP5Qz9+bMJ2+W1bqMZ6JTY+rmKGan
   0en+KMvbW1DPX5XOIh4Azm7Qt6QyFip1kwpOe795Dx2NEMT9n2WMSYzFT
   D3or1EpO5pEO5lCeXcadksR4VkdtBsHaeY9lDb1Gt3OEnfnxQC1kKjYsX
   trm1hnx2sxltFhxQPwvO4vci9Bsh3jt0hcHqqqDk94UMBPi5UepB29tZV
   Q==;
IronPort-SDR: 9oDtL51/oBlYAB3KypKaUegw0mGUvRJSd4JsZ7EgwDI16qQRbyA5CYR3lMxt5YiZuGoJQQ9hS2
 O+lOhg26T8eZ8WJzchLyP+XSxVqvIFeop/ZZGE50XSMgV9VZ8HJOyj8Yxb3wfofdJdWljwDFP2
 QvYd6wiUthbkBEWRV2+1y/2bRD+FHBSS75MhojHWgqddCeE0TeOfaUdru8SDb58XgbHodEVIkd
 mIrBFLFDojP2ylAsdbWHNmSUSr9GiNhY6ggQhRnYauvFJxutSy0dx1RgY6MQrl0OhtF0MaEHiG
 d4A=
X-IronPort-AV: E=Sophos;i="5.73,354,1583164800"; 
   d="scan'208";a="239551569"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 05 May 2020 14:44:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6poXWwM81MRfM7UpQDJ+vMvbQDejmncs6k4pg76akBy/9EjcCdL8ocEdIDl5X15bD1HJ2rffkFUFGUca/QXRCPcFvex31lHZlpy/k4XJ6JCn25MddZtzjViO7N5akqbeNac3jEkLWxffCM19kdYtDwl8ebVAn4M19XBD3838ANn26L58gtYsEGKL9vTU64YBKAglJwF/QKWUg6hmp//AFVLz1dQU9EOCSjzT7QZ+wlzEnpoFsURh007e0cy5Clj2QQ+uMHM8/j7hX/hB503PphYNrapE+nrJh6mCS5G2WrkJ4UERQse5gZurleDP0/s82kysw8aUHgzF7b/mxVRSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Cq9p+dRCZsOkvSMScfjrzBG/sCyUSPZrMXcSsZy7LE=;
 b=kUU5i6lnv9YDkZN1AjnRgittv5A+pK6r8s6YGGtxoNCDYeoeqXkc5hl8oa/6VVLszCTdELSnNqt/lZSAipNf8A5JKp4IsNTXAMYKzsLC+xfhsWMXAjRyE3GAOySs3Az7ZB0v7yHBM1dCIBgohiUgesYq35xzANFudn8nVlGLyC+kpsem9WdwbZjzKD3URvOicKLZRSXo3W9yYyFplo3D7oiZuN0W6BR8NM6zuEFr2E2Nzl7SlVoWkh7gkBEq0og0jrUZ3pnswteu76VvEXykrenhkC501g7rnqegcwEBuewG2UzEjIZu+0gy3M9sP7xyAIxUS+sd0MIE5NbPBJymzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Cq9p+dRCZsOkvSMScfjrzBG/sCyUSPZrMXcSsZy7LE=;
 b=Tn/udvAKmINWBb6sCEDyTsnmmBlPYGqaR/xxN8PJKal6H2XA3uFmFwYy6sswxPV60jhiSQfXUdo3U6U4NS1BL9ETquxpyZ8puO+joYw1u2UqihfT4kCXOO/x480alBdTUXJeQxp9LvMbGXof+sC+PHj9irEoVUtHtyVQlU4JG/A=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4904.namprd04.prod.outlook.com (2603:10b6:a03:4c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Tue, 5 May
 2020 06:44:05 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::28be:e964:37e5:44b6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::28be:e964:37e5:44b6%6]) with mapi id 15.20.2958.030; Tue, 5 May 2020
 06:44:05 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: remove the REQ_NOWAIT_INLINE flag
Thread-Topic: [PATCH] block: remove the REQ_NOWAIT_INLINE flag
Thread-Index: AQHWIi5/bK6PpKjP9Uuhd+Hw3s02Ng==
Date:   Tue, 5 May 2020 06:44:05 +0000
Message-ID: <BYAPR04MB4965EEE9C5F85B78A2CC7D2286A70@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200504161005.2841033-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b298bc36-f49d-48fc-ea0f-08d7f0bfb4cd
x-ms-traffictypediagnostic: BYAPR04MB4904:
x-microsoft-antispam-prvs: <BYAPR04MB4904B5DA2CDB750A49412ACE86A70@BYAPR04MB4904.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:800;
x-forefront-prvs: 0394259C80
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kijd/t8ue8ulAjs2ahyOZq8xLLcxG4Hk1KJHTPZ8V6GRjBcb9F0x69xJDvYLGriHgpUo+mFrP5XmNko88m1/OnBml5FMCLiMvAjVlYDrS9tikootki8oS/UX2Fgw+vUp67Eylq5qqRGOuQc1GQDNbn6AGYc3I5stTm2SQl+uiu37Mo20dplrJgaVci0aHRZlP2u37Ta0C9myUde5KTdZZepJIfGtfE/afm21GPnNUsRYw4cVFSUqt0h0Pwb14yIat2fUEHksbwjjY53EAKUR2422CDgWwdbBUniYir7mUrap+FSWPQws9+PSAC96MXAyY/SMUs0RRp9T9Xe9UrCmzWLRtP31es2lyfgVlNKn97XWLn5Pz7mZaFb9IzoRThI62ub81E6LV7LhVgmKjmkexULmqHYz4YckWizCFGEQQp9+D0c1JC+P26/aylq8gkMin6stWIeuomIDb/s2roZUppCWAyJoqay5YJHyRPvIfKGJNL7OhK40XvRuEjtN8fp6jCEfwP89H5WphqSHAZj24g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(33430700001)(76116006)(4326008)(55016002)(8676002)(71200400001)(110136005)(316002)(8936002)(2906002)(7696005)(86362001)(52536014)(66446008)(66556008)(33656002)(64756008)(26005)(5660300002)(186003)(478600001)(66476007)(33440700001)(66946007)(9686003)(6506007)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: iAHZJmHDJz7HWsTLjj2sCGZLZPRMzxxBnUoq0mFfOFSX6BCnKZBovFKR16k7N0K75eOlu1zlGWRvnmte2OmH/dd/1wqodcd0WPg7mE6U8Jso6cj5YAt3leFtavNx84gkdc1cwPshWawA2YCRhnd1QLNX8K/Y76F5+TXy/gb7Zhj7UOPkWfDrNR742bdDzVoUlP4YJ2AeO9Iz6m+dbct158/+AYSJGgCzmLoM3hCf9ISKJ//RCYwBqtLa73Sp3e0h+14m5/HIFtehIvdjoBRBHQR+UuQONrOhRC3kxXvlLIP6ePVH6zpVvddyvriC+fPZCTazs2pYHb3mBrdQYDO9S1lgTpu8IsV+K6bfRTwKd9tBcyJJm0sflsJrR2J18bFd+oxlI/iFHw82ZP9HXlgbHaU6t4ymq8L/61ZyHMaQSoD7JRq8qmm2GRO0RD+X85k/cooLK8uSKovIm3NwwTO3MtHDVBRWSgbZ8jbPPKy7yFMdCGMs7BtT4/I0TJAMrqWcf0VnJYxfraPt9bNzEC5xF/8zD2NzvwTbC1cjczwn1gPSwuMoCR9My6UhKPxFTji2H112myUAZPgcTtg/9UNk+Ei0v1Ha3nkLWY0u4PShjA1YgK6dwLRRwPp3djgHxq2W/gaVGl49HYc72yA95EQJgwFwlpCnzxn1MlFdzzVce8tW24i/ODuSOrN5kwM+P1C1VKXOp6DDpVoIZfjdChqI1vGRY2+epiU/ypFPctfQkrDXDfYOwj61v9k6XqlTd8L8QPqcxZOPXcqZmFhA9IRXneMi5O6/2l+pMrTWjpk+hDg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b298bc36-f49d-48fc-ea0f-08d7f0bfb4cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2020 06:44:05.7498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: URmFnB5Nd91omfQosuHTANH5xzxiVW6Wpf8ksoJ9XDIs7Pj5fmCW9IKqy4r+LqhJMyjaJZ0QaRVtZCn1rzW2HwmblnStjvZW/7BBEWYx2Io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4904
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/4/20 9:10 AM, Christoph Hellwig wrote:=0A=
> Signed-off-by: Christoph Hellwig<hch@lst.de>=0A=
> ---=0A=
>   include/linux/blk_types.h | 2 --=0A=
>   1 file changed, 2 deletions(-)=0A=
> =0A=
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h=0A=
> index 90895d594e647..7443e474cdad5 100644=0A=
> --- a/include/linux/blk_types.h=0A=
> +++ b/include/linux/blk_types.h=0A=
> @@ -323,7 +323,6 @@ enum req_flag_bits {=0A=
>   	__REQ_RAHEAD,		/* read ahead, can fail anytime */=0A=
>   	__REQ_BACKGROUND,	/* background IO */=0A=
>   	__REQ_NOWAIT,           /* Don't wait if request will block */=0A=
> -	__REQ_NOWAIT_INLINE,	/* Return would-block error inline */=0A=
>   	/*=0A=
>   	 * When a shared kthread needs to issue a bio for a cgroup, doing=0A=
>   	 * so synchronously can lead to priority inversions as the kthread=0A=
> @@ -358,7 +357,6 @@ enum req_flag_bits {=0A=
>   #define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)=0A=
>   #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)=0A=
>   #define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)=0A=
> -#define REQ_NOWAIT_INLINE	(1ULL << __REQ_NOWAIT_INLINE)=0A=
>   #define REQ_CGROUP_PUNT		(1ULL << __REQ_CGROUP_PUNT)=0A=
>   =0A=
>   #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)=0A=
> -- 2.26.2=0A=
=0A=
Looks good to me.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
