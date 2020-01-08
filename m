Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978C7C33C99
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 02:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479EF2087F
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 02:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZD2kYQEs";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="egkRs3Xw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgAHCG1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 21:06:27 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:47909 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgAHCG1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 21:06:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1578449187; x=1609985187;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=495lHs1hXGMuT185w9shnT2uG4Zvd4MfrUYRiMgz664=;
  b=ZD2kYQEsptixRYBWLR0LWtZcInu2Lcd6m9YLOHUMRsBU5kNn7HcHqdG/
   YTyos0m02QtMN62Bl8f5L7/vLcre+MmeD55yni/vyvgZ4v7EYwEED/nra
   JnQ7oKtmSe6J6F1HrbqM5xrTZy6SZ6JK1TGBazyzi51qT1NAXX4PQeH2x
   JBwbLJCsQ+2krE48yOu0GTUDpi9ywfXcD4bc7JbQJM70TnwXm9y02P7MW
   y98+sBFwg8k5U/mH791lQEeAaF8WW5esczpSsLyhZ2NykXVJV2lDCZJ86
   qkP/ib/SCqVgVKF8XsbFhYY7fqlrPLUZUEe+BgXne7lidcCVGczZRj3Tm
   A==;
IronPort-SDR: MytbXpyl8R6XweKKthLOnKGiL1t6VwMOJg+2Xp8skuAos8ZE1q7Lr7c6BVFOFtHXHIMYmVw3vK
 Ry3AWLRe7x/XLS9ITkH/onF4wPBldeQGjjBAN6HneMIiW6e7p1By7t4yj8vIeI/q5Jbeldkac6
 0b1ObUcrnI7TQlAjif82C/V1IXhLSnSKap1EOXKx9+DsOXpSPStPXkYGHI8ntOmaL88quNgB9F
 PgHnXVNi4nExvRo50phfOypVfMBkfGrOu1zXSVsG7Fc3MTKUZb3aBoq63Qw0mGKpj87aD9tlBE
 2Bk=
X-IronPort-AV: E=Sophos;i="5.69,408,1571673600"; 
   d="scan'208";a="127656213"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jan 2020 10:06:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kT4i0RcsMRxC63ABXICbS+37CkYO9oEXBLVlDZLcXPHpNjUfhZ23lET7KM4EOeeNkrOYf1Bxr6PrBldem4HHkKHGxL02Ixeor9fQEoK679S2xFXF1oysRhzNTX2yMidBzcG1kh8gqC07EaxtavwW8/J6mkjyQX9ygMa9j+Mzk2QEiCHsUWOXAGvFnCMNzMUAN1tkiZuWg5TeebsLyqjT8ADj/mD582Yd3N4amzxR60B4Tnrdpzr1bIMUcViz4rVxqEsUq+jz31zZcdng4aEyMf3BZruIFkNhdb3u2Y0tnut6OdbJLzdPCoQKIiAZ2eAhwMbLFJSfyJy1jvf96CETEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsAeuGjEiT2BZka43J1o+XvNBwo+POhF0sG4huy5x68=;
 b=OGJvAuXoIO+Rcm+HGFPFvSs60KIziqV2/LdektnZASMhkgmEv/z+W2/VNPUW3XTGgkAkRt6Gf7zD9AZl+RBv/ZNmxj/jqyD/hEgYcF/v3wB7hdwVjG/rauilp2/MMP4i7cpk6SJUqEjHD3OHGAl3NILz169uQkKwZdTTRqQRR1oq42sXRjqrqKtywoB8pFTUlH6OBGJU9Afc2W6KlfTutgIF3b85pkPik01J3LltJNU+f0BfZMUooee/lvXnlUYm9RGGRRjJZoO4RNefSm0eaR+vWicA4nMvo6j+b3dg60GGCbrv+nshU/pykisc89gOGuo9x9x+o6sRyutn0KV1ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsAeuGjEiT2BZka43J1o+XvNBwo+POhF0sG4huy5x68=;
 b=egkRs3XwN6spnADTJ8awyrIpgHAhMXItDZ+qobATnayEr+6dIIUJANQug0iFu1yTkoGhnH1XswIaTYxiUa1pSQxgf++0pdtIC5UsMm5hDQsQKFWsD/JnXxlJjcTOb6hYBPXsCZONgTWjsZLqluvj65zt5sOA/mSYm9awdnO3T8M=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Wed, 8 Jan 2020 02:06:26 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2602.016; Wed, 8 Jan 2020
 02:06:26 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] block: fix get_max_segment_size() overflow on 32bit arch
Thread-Topic: [PATCH] block: fix get_max_segment_size() overflow on 32bit arch
Thread-Index: AQHVxcKPgLyHDZ/rAEWFpb5xuR+TFg==
Date:   Wed, 8 Jan 2020 02:06:25 +0000
Message-ID: <BYAPR04MB581614236B3088415240723AE73E0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20200108012526.26731-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6711cbbf-e397-43ee-2b28-08d793df5e0b
x-ms-traffictypediagnostic: BYAPR04MB5749:
x-microsoft-antispam-prvs: <BYAPR04MB5749CAB720C10ACC44B03C13E73E0@BYAPR04MB5749.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(189003)(199004)(81166006)(86362001)(6506007)(81156014)(7696005)(71200400001)(8936002)(2906002)(478600001)(33656002)(8676002)(91956017)(66556008)(76116006)(53546011)(66946007)(186003)(66476007)(64756008)(4326008)(9686003)(5660300002)(55016002)(316002)(26005)(52536014)(66446008)(54906003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5749;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7S7AKoN/VOsO+oYMqU2ynvwXz3w4UBsA21yoW5PZerfW7ex3F6Jo/f4uQufG8RE3qrne2T8gb1eu+jVRvpHY8Z5Ubr0F886LPxjnNiG0pF2XCBgCDgY48cNgq13/ZdIKXxgC0F7OCRsEfV0CNVdt/hmMS0ygIGhiOEVsCOFxYybTOkMQ07xwPyt4x9DWOatIK3Hl6CW9fR+1+9xXEDV8F7pMcunHiB2YhUCt2VGKA6DyQxnoHYg6QrJNOLssgguaVHi4Z/A5tGG/NkYE+2K8e8RdERv2Hp/ZZXFeuuzCDWrsS73ceYNFWy/SDtVzerPACSUpqEQB/aYncvK+OdGm5S98pPszpjOWYP0xcWYIJprJmKoh7FbdoO0/8gP3XsWcuA16o1P4gS4PXl24UEYUWtVqB412octUobfXL+ZQPYt81Kvj6LDKM9YUbtIDn8/A
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6711cbbf-e397-43ee-2b28-08d793df5e0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 02:06:25.8606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mtztt0Zhy1COCFvRq/iaCmlwvDonZpbDjfUgLLPZu9b4B6VVq3vdZsPaS/n3SPNFdNIhHIHEca+evX0ybpRoOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5749
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/01/08 10:25, Ming Lei wrote:=0A=
> Commit 429120f3df2d starts to take account of segment's start dma address=
=0A=
> when computing max segment size, and data type of 'unsigned long'=0A=
> is used to do that. However, the segment mask may be 0xffffffff, so=0A=
> the figured out segment size may be overflowed because DMA address can=0A=
> be 64bit on 32bit arch.=0A=
> =0A=
> Fixes the issue by using 'unsigned long long' to compute max segment=0A=
> size.=0A=
> =0A=
> Fixes: 429120f3df2d ("block: fix splitting segments on boundary masks")=
=0A=
> Reported-by: Guenter Roeck <linux@roeck-us.net>=0A=
> Tested-by: Guenter Roeck <linux@roeck-us.net>=0A=
> Signed-off-by: Ming Lei <ming.lei@redhat.com>=0A=
> ---=0A=
>  block/blk-merge.c | 4 ++--=0A=
>  1 file changed, 2 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-merge.c b/block/blk-merge.c=0A=
> index 347782a24a35..b0fcc72594cb 100644=0A=
> --- a/block/blk-merge.c=0A=
> +++ b/block/blk-merge.c=0A=
> @@ -159,12 +159,12 @@ static inline unsigned get_max_io_size(struct reque=
st_queue *q,=0A=
>  =0A=
>  static inline unsigned get_max_segment_size(const struct request_queue *=
q,=0A=
>  					    struct page *start_page,=0A=
> -					    unsigned long offset)=0A=
> +					    unsigned long long offset)=0A=
>  {=0A=
>  	unsigned long mask =3D queue_segment_boundary(q);=0A=
>  =0A=
>  	offset =3D mask & (page_to_phys(start_page) + offset);=0A=
=0A=
Shouldn't mask be an unsigned long long too for this to give the=0A=
expected correct result ?=0A=
=0A=
> -	return min_t(unsigned long, mask - offset + 1,=0A=
> +	return min_t(unsigned long long, mask - offset + 1,=0A=
>  		     queue_max_segment_size(q));=0A=
>  }=0A=
>  =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
