Return-Path: <SRS0=4R18=SX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0ECEC10F14
	for <linux-block@archiver.kernel.org>; Sun, 21 Apr 2019 17:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2AE20833
	for <linux-block@archiver.kernel.org>; Sun, 21 Apr 2019 17:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TcuzmhIq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="g8od/trd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfDURrG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Apr 2019 13:47:06 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:55984 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfDURrG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Apr 2019 13:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555868826; x=1587404826;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=D1yOQfyx4M3VSClUb8YnoFF/jFtlgTKaz4gy1LJUU9A=;
  b=TcuzmhIqmi1XEoq+WX1d43tRQI6EZRsGoYl4EQwVkjg4gLTtLPkwIRcF
   5cifqlO76sOPRT4lbJIMUHo/JjZPNH4dc7p72bWd9MByhni+knWw2soik
   JTMtlyXlAr418Ks79Zcq2tJqUX0gvtFU7A4bLy5CQUHEcFMg3GFdJgQOI
   J7IrCtvlE9TG2rOxHDhdbTsNfxkScbyJJh2r253p+gvf9vlmpUq1HDmno
   WTdIif6QT+Ob1AWosdJB5ArnweUvT3xj44gBqIh5X3a1+JZodaQD2UuOM
   VzCIDRCrFYTLFoopEKSYxFpwFGRk+xLmFz2q4mAazWjNJqX64XOTFJrro
   g==;
X-IronPort-AV: E=Sophos;i="5.60,378,1549900800"; 
   d="scan'208";a="108188114"
Received: from mail-cys01nam02lp2052.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.52])
  by ob1.hgst.iphmx.com with ESMTP; 22 Apr 2019 01:47:05 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxpv4uPZq+yLVjq33GHouLWjgpHW3fXS/JXD3loT0YY=;
 b=g8od/trdU5voDtXm96zSEMNQywHYx0nexwP9M/xO8xJ6mc/C1lN5eHYDmNvJfMknNbIUfjJcVXh8fAHLXkeng2FoRUy9AXfJcYLZ8Wr+oZR67/+o/qWAXJTzgxiC6bkxUIx+A76tVh95BaaEzBid9kJjVwu3W1gFh8vWIt0dL0E=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB3822.namprd04.prod.outlook.com (52.135.81.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Sun, 21 Apr 2019 17:47:03 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%3]) with mapi id 15.20.1813.017; Sun, 21 Apr 2019
 17:47:03 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Coly Li <colyli@suse.de>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [RFC PATCH v2 01/16] bcache: move definition of 'int ret' out of
 macro read_bucket()
Thread-Topic: [RFC PATCH v2 01/16] bcache: move definition of 'int ret' out of
 macro read_bucket()
Thread-Index: AQHU9t0dGdZeK3qXwkO6qv+fCpTfCA==
Date:   Sun, 21 Apr 2019 17:47:03 +0000
Message-ID: <SN6PR04MB45273AEF543F22F2443B83B486210@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190419160509.66298-1-colyli@suse.de>
 <20190419160509.66298-2-colyli@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd40a0bc-1df2-4804-22e5-08d6c6815d08
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB3822;
x-ms-traffictypediagnostic: SN6PR04MB3822:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB38228B82EC321A853E98659D86210@SN6PR04MB3822.namprd04.prod.outlook.com>
x-forefront-prvs: 0014E2CF50
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(366004)(136003)(199004)(189003)(305945005)(446003)(53936002)(476003)(486006)(7736002)(74316002)(316002)(9686003)(6246003)(33656002)(72206003)(478600001)(52536014)(6436002)(86362001)(5660300002)(229853002)(55016002)(110136005)(68736007)(7696005)(14454004)(2501003)(25786009)(2906002)(102836004)(71200400001)(99286004)(26005)(71190400001)(81156014)(81166006)(8676002)(4326008)(66066001)(6506007)(53546011)(186003)(76176011)(3846002)(76116006)(91956017)(256004)(66556008)(66446008)(97736004)(64756008)(6116002)(8936002)(66476007)(66946007)(73956011);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB3822;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2fA9oO2XXRGfIZuc1N3Y23NccHTUzn17sZTmI/TEzxes1UQ3INneJmQvqN6KschOJpWBykjlVewNToSCu3BVVdvfWsn1Um0Fx3i5nr1O0j0T6TcATL/+sCLsIbSXWBmTmB2TEUsdryf6kUV4QMKsy1JuKfiJ07qgmo3bztkwBpi+KO5mSpXZ7CoNLruw8IvbG8VDz5UA2S+MMp6wCIeauf8RsdcMePp6u+zUyWWuIV1a+k0CwEIY7LPPPPn068UhQv+vQt8ez9fyTBjCEUlVs+sGC1PDKzVtT0jtCHKNGrnrxDmsRf9peZpXvEZtAxhCxZMjxtgW3kOOtkz/X9ViZHqMHMTZmkh57c3g7/rv7rzOKPY5CVF1utt/TAX/LvPFQWlrhBANTMNzvsn2f1qZgbYItf06iWPrAYlO2Kjo1Ww=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd40a0bc-1df2-4804-22e5-08d6c6815d08
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2019 17:47:03.2348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3822
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

May be we should make this as an inline function instead of macro ?=0A=
Reason being:-=0A=
1. It is not a simple substitution.=0A=
2. It has multiple function calls.=0A=
3. With this patch it is now dependent on local variable declared=0A=
    outside of macro.=0A=
=0A=
Any thoughts ?=0A=
=0A=
=0A=
On 04/19/2019 11:24 AM, Coly Li wrote:=0A=
> 'int ret' is defined as a local variable inside macro read_bucket().=0A=
> Since this macro is called multiple times, and following patches will=0A=
> use a 'int ret' variable in bch_journal_read(), this patch moves=0A=
> definition of 'int ret' from macro read_bucket() to range of function=0A=
> bch_journal_read().=0A=
>=0A=
> Signed-off-by: Coly Li <colyli@suse.de>=0A=
> ---=0A=
>   drivers/md/bcache/journal.c | 5 +++--=0A=
>   1 file changed, 3 insertions(+), 2 deletions(-)=0A=
>=0A=
> diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c=0A=
> index b2fd412715b1..6e18057d1d82 100644=0A=
> --- a/drivers/md/bcache/journal.c=0A=
> +++ b/drivers/md/bcache/journal.c=0A=
> @@ -147,7 +147,7 @@ int bch_journal_read(struct cache_set *c, struct list=
_head *list)=0A=
>   {=0A=
>   #define read_bucket(b)							\=0A=
>   	({								\=0A=
> -		int ret =3D journal_read_bucket(ca, list, b);		\=0A=
> +		ret =3D journal_read_bucket(ca, list, b);			\=0A=
>   		__set_bit(b, bitmap);					\=0A=
>   		if (ret < 0)						\=0A=
>   			return ret;					\=0A=
> @@ -156,6 +156,7 @@ int bch_journal_read(struct cache_set *c, struct list=
_head *list)=0A=
>=0A=
>   	struct cache *ca;=0A=
>   	unsigned int iter;=0A=
> +	int ret =3D 0;=0A=
>=0A=
>   	for_each_cache(ca, c, iter) {=0A=
>   		struct journal_device *ja =3D &ca->journal;=0A=
> @@ -267,7 +268,7 @@ int bch_journal_read(struct cache_set *c, struct list=
_head *list)=0A=
>   					    struct journal_replay,=0A=
>   					    list)->j.seq;=0A=
>=0A=
> -	return 0;=0A=
> +	return ret;=0A=
>   #undef read_bucket=0A=
>   }=0A=
>=0A=
>=0A=
=0A=
