Return-Path: <SRS0=1Rjj=CS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47796C433E2
	for <linux-block@archiver.kernel.org>; Wed,  9 Sep 2020 07:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D902621919
	for <linux-block@archiver.kernel.org>; Wed,  9 Sep 2020 07:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jDteIycs";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FfZjxtxp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgIIHJw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:09:52 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:26303 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgIIHJs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Sep 2020 03:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599635403; x=1631171403;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=dO/7jErUwDdx79D3jC++WEIADfSjog9VHfqdz8/50Eg=;
  b=jDteIycsfVbC6vJ7/hB9pLlroBgQ6IT0hrDivQa9wFK37xx8ya0W9tUs
   Y5QEUNXZwnNpsndfKHz7qSBy4YC0huZuH3PWa9F6ox+5uYtxYsbYNfh+x
   NY2BPkgBT6j3iJlX4657LCC8fV6R3Li5O2XcsK27Kpw9W35OZtUOjg4vy
   IqqK0OjzrPfmJXYAsnNRI8NrPZfHb0lAjMJlleI112bJGGxpno5lzqU+D
   SysS5TyjQlNkyi4CoZiphDSnA0SlBB+CRSJkaxPNmapTQFJ9KAGBTdvQp
   hC73PZbD9AOCjbcDetCuUZM/D+Uv/y/zbzmDDhzKcSuKTxwAScCGOhzLp
   w==;
IronPort-SDR: oPEyws/G8pNkXxt4p3xdeDTVEd68aaE5CLd066Df/LHoHVWcJAODiRtknEjeaYksTnY9VBNmtc
 uzCemk5MkK3JkDerYgcbM9QyCobv9MGPdS+5RaRpw6s/r8ixCSTftHb1Dl8Q0tlSj17NTFLSxp
 V17eafywZIDvxgA1CFUPqJpktwhvhQaX+1JrB/XUzVQA//IodT8K2/rzbQmonxxvFft4nWOWll
 klucVgrrnHMZVuh0exj3gWMzfNOBzPGi/oALrwKlEVqBJsBt1wazZwkHh8t0VbC64cdKZ/V/QK
 iao=
X-IronPort-AV: E=Sophos;i="5.76,408,1592841600"; 
   d="scan'208";a="250201995"
Received: from mail-bn3nam04lp2058.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.58])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2020 15:09:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntiLihPuvN0cRoWPOvED02Y2P0hIwFUcLvYnYKDTLAswpiQrr00joiLaT+99yfmVqYnugR4BI2eoeGYsKZPHnFwKSswpT9yzUWXPzjEV8JDDD5zgHUh3qlpGUiNgVsg7LjsKYorp4AM/yQYPXLzWQA1pak4Pkq1uMnOQ5NYnWyiPIw6B72Frhyszt7/UQE/urnoP4iKnk6BvZ3YmKhQf9gVB/x+f9+NnYB+hb1NW7Mx6SUpyP8dImF5bs4YtY0lTQlKZa9wZj12CD3dMcMktSibrEtBPGoZQ6cnpxM46s4Zc+W/EN84g+VpZ0AVh49f/gA4uGXA+Pmeb8+1VpRxM5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dO/7jErUwDdx79D3jC++WEIADfSjog9VHfqdz8/50Eg=;
 b=j9bcsueRtQEkyQFZ6vKvcoZPOYui6Ou9TIhRoRLVLOABq9nvK5MpB7i9fZCNFtHzS5obMFn3+gyS0YoVMUhxneFHjjCWLxN+jeptC1xTdAOHnjITZPGYMO7yjub92xuCzganWnC68PHd6Z2ajQTCxiMXwvfwWje2edV+GA2Mtv6aWKip5Mf4G0kgTvZhu5IX8D7Qnx+Fu+2QiAiufW+7frdFH0qjQqTc09xS+aCKNpyI9Cg1M7kzbKtYcWcSdKeljEqVHDoeGDF2i14BLs+NRuFM2TNBcn7i7cYkTn0U/K2RR5Mh1j51uqj22OO02tSt8o3gYEe2doGamjgsnAvSjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dO/7jErUwDdx79D3jC++WEIADfSjog9VHfqdz8/50Eg=;
 b=FfZjxtxpEYVbahStzi/GVVW975caPrTT2rvYXY0b7QbXLMjO3HeRi7ql6WZVVImebG3QuloRifeGumUZWh/vnS5w61fsnfZugJ+XTwsO/rnjRPjWyYnsEBZTt8fbtRqVqh4QA2a229BAdBjAPWwhvKt/weN1x8/psMSVjt6z8jI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4157.namprd04.prod.outlook.com
 (2603:10b6:805:37::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.17; Wed, 9 Sep
 2020 07:09:43 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 07:09:43 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Miaohe Lin <linmiaohe@huawei.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "hare@suse.de" <hare@suse.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: Fix potential page reference leak in
 __bio_iov_append_get_pages()
Thread-Topic: [PATCH] block: Fix potential page reference leak in
 __bio_iov_append_get_pages()
Thread-Index: AQHWg2i/1CaIpgFNnUmvex8bQJvNOQ==
Date:   Wed, 9 Sep 2020 07:09:43 +0000
Message-ID: <SN4PR0401MB359839DF2BDDBA6BC08ECA369B260@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200905094006.1925-1-linmiaohe@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c247e210-9cfb-43b9-c597-08d8548f53d4
x-ms-traffictypediagnostic: SN6PR04MB4157:
x-microsoft-antispam-prvs: <SN6PR04MB4157C61A32CF3F30618533E59B260@SN6PR04MB4157.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: amCYkkIoKvdGe81MBHpxprdkdN5+2IWlWEdq9bxNXmZ5eyU2uw0k6iYSF48eU8Cy5v54wX//YpW4ovO12nDfW0Y/zIiZp3RPpfBFu2KJVbvxZ8EenZbAYmwQRLlzRKjj+6OcJ6i6p7Vc0AcU2hh8d/4/kxQ3cgyvFnbw5Q1kK+m0nEcIE8nLBEFvFYZZXeve2aIeEZrVjbehvaWMwMr+ge3NqcA4UqEutcvox6mtMJFMaklzEG4QouAWRxu87U9njgoAaJ6NeBY5kGHn/zdj8HwG4iYQ+0QSu60AJBGZnzO4ydMaWSuEaXlbO2Jr2sBbEazr0l3nubsoF42rWxzY4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(9686003)(316002)(7696005)(8676002)(5660300002)(66946007)(71200400001)(66556008)(66446008)(91956017)(2906002)(76116006)(66476007)(64756008)(4326008)(52536014)(33656002)(110136005)(54906003)(53546011)(558084003)(6506007)(26005)(186003)(55016002)(8936002)(86362001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 4zQC5pphrpijZv8m/GbcYhvcMFFB/ST+kuUA0mbE6oY+ndDaam/XUo9XjJKvHRgAuevLraCOyS1430oq9Qkooa9SwRjcVwcyG3lDB8QPMAYdZVZ/g9177WG7T7sdE6wv3ukHeFvyHep3ZiULnyPGHuTSM/N+KR2QejvUmASJgMT5ck4FdK+yoImDaGN8X5RS37yuA5KvXT+6RGRaBJ5RLEiZe8v/7Zakr+/whcwpSMVhaHdcGFYxiHE14dpw6GQCIYdN0b+LJxupLxdRnaQlqUg4K9rWv4YnUe6aTc6Y9ZVfU0MNFDdvc5zowL/CXlebYCkj3Dqaf+CD99ZLOdp6jujOD9+a/UCjOVYgyJIAOHfbjns2S4ZQDx478TuXckgBgJ044+ylu1IEsTFXT9HevyA2aTCB5/r780wnCMrHlI/Z4Ka9oN/PMhEakLrcbbtmJYqouGvKdimCINZcMoY4c63ELMslT0GDGl+j7h55wcLUcRxoM69T7S5aEYKtxCsCxiC+KZ5hi6uymeItattnEgek7YzQMZoW/Z/bUrC0xSF0TaUl1ygNZIgTOW2XEf01lx0x32Zjw2JBiu3nDrquF0VW86szjPhyY/81ZMSA4dbIDhFg6GBZT/S2SkbiEsWCeY0a9RyBYXjXFvWL9TyqFw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c247e210-9cfb-43b9-c597-08d8548f53d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 07:09:43.4995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4pSAijLWni1YfWNoJM/o0qFZEMNEVz3mD2gxnt16ujIC2jprBpi59fIKJYgoVPJ0Yd66tUt72Rh6ATos7rXgu2YItiW3T/7K1OUZPiY7bxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4157
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 05/09/2020 11:41, Miaohe Lin wrote:=0A=
> When bio_add_hw_page() failed, we left page reference still held in pages=
.=0A=
=0A=
I'd add "from iov_iter_get_pages()" to the above sentence.=0A=
=0A=
Otherwise=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
