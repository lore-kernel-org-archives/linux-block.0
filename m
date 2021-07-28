Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB3FC4338F
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 22:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CA966101B
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 22:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhG1W6b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jul 2021 18:58:31 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:44639 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbhG1W6a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jul 2021 18:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1627513108; x=1659049108;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=w9G2fR7qJXygV2pfnkzV/i9oih513A8hoVBD6q623QE=;
  b=GVP7dOmGAOJIf3tO8yc2p48w5oHn/QKFH3xnb8LQWMaNPq5qSaE32yAQ
   2+9Um2EDuI7d2z004huyLvo0wMileJCbs9zz7up67vBjOFX8dGqUokyQH
   jNT3ua2mVga8V78csoI4QhcQ27dS/FPM7YFf8FB5N2k2qpJUqdfxrDVXE
   NKofq+DpX2vRBZ4/WCU9toLp7MsNF+GYVgxV++ShMXndV0IVfwNcICJDI
   qe/OkuMFMWQljx/gm0VF+vY5WH0jrui8+fhaJsP4qb8OEakfNQK1k1a20
   UhtKPL8nyXs/5bV2co4ne0K565V2mRHRK2opya63ZstXEdBMSs5S/tfb1
   g==;
X-IronPort-AV: E=Sophos;i="5.84,276,1620662400"; 
   d="scan'208";a="180549774"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jul 2021 06:58:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=libuE/OhRVkvB9Wnf56XtDBAWHicowF5qujczL8Yv92HL1Q7TslMaGrMfelhZH9WRfO+5FTaupLAx0JvW0BVfB8haxH5QrJHgKef7/DT3Q8T3RB0l5PlNHt8ByDKn5KwUaDMD20v8HDnJpXMaj6Nk9kP/6NgqlcIir2VZw9Ar4FjG/TBYjPVAKuSwOCs7NmXIru/+iijW2r+NtCCuTP2dkN1rPCWIE0t+Fv/4N/biDujKiM5tey46s+9sbkJsVcC4s4EkUldlyPf+gKuBqRsBit5W22NfN+JTmS0Ijt9JPuGOtcM8I74kstPcr0QGD9C1NjbBBkZoJa/ExRFR3vlPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrfkVjXc/6B9HUEcQsYhQ8S6+VWUJ+vkCuwoBzKZFVA=;
 b=fs/LPlyN0luCMJtwcOiZ/StKKvhNFs44ELvTS4/kpRGFP+QqU22Tewn/Q57q0WEWgp9re7yiKKzZ9DhRVjvOYWQnLiaWfpzejoIMg2uwp8BHNqkqFwesZnpE3X6relmjtS/t1K6+6jEm7XxkFFG1KHsMt/Lpq3gdjZsxx6EFCax5TMzWIIyeYpL7cMReIyIV6YoMLEfjkFI71QwBkQvbV15w/CXZwlLbIqQe2tYLktnCdDGN9XsoaPQZiWUBUWmWYVpGBAC1UQxzHtNRTtz6AO7EsXsQdXqqt4IafS1NRQgrk3be2WaNylPpcEyH3rAYktnt1tHzDiXsOJtChImpuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrfkVjXc/6B9HUEcQsYhQ8S6+VWUJ+vkCuwoBzKZFVA=;
 b=fYdQus+UE7V7KL1ggImuWGeAdgUYJvnIPAnAFTnHtMgkL+341L/PJwoIH6FFePgD3pPjtoDyMzE4geJW5Dt5brQTYq+E8JjoFUyBc1w9n2yAYGfiIL4QynAIHjIbpokGqBl7oBFB4u2YBrHjqqIigGhUBXqH9jhABkxKPSmYX8k=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB4473.namprd04.prod.outlook.com (2603:10b6:5:2e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Wed, 28 Jul
 2021 22:58:26 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::44e6:14cc:4aab:3028]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::44e6:14cc:4aab:3028%9]) with mapi id 15.20.4373.018; Wed, 28 Jul 2021
 22:58:26 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: remove blk-mq-sysfs dead code
Thread-Topic: [PATCH] block: remove blk-mq-sysfs dead code
Thread-Index: AQHXd7+znomefotxT0eKY9Ecr8+sCg==
Date:   Wed, 28 Jul 2021 22:58:26 +0000
Message-ID: <DM6PR04MB7081160FC9DC368206B1EB88E7EA9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210713081837.524422-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e13da09-ae49-4b73-7c73-08d9521b35b1
x-ms-traffictypediagnostic: DM6PR04MB4473:
x-microsoft-antispam-prvs: <DM6PR04MB447368A4D1F4D8530239C89EE7EA9@DM6PR04MB4473.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5h11XtwScHZRdIkZ0Zjlnz1IeSbfaF+LNWvIsbOOqOuyXMA60zFnje2Gkb0fOF8BeYsZYEpwRVZDMzRGNrgaxFVnsnaJNxhOFiIgFqI/1CBi1e8hC9FKC5nCNVrn8Kfi1PfMKiutbZW8OlwYWPpBTuE4y9QScDg5eYpUjzdOPFVMuUm7O81ntuD1T8D9dY9I1MejpXqz7KNgkxrpjoC7U0ABomfPC0xbQc82TPjnw4JD/kR5C77RN07xOWYi9antqEyLnN75kVoOUf6PLniOpvG/Rne1fMfU6/UeAW+Ept5JQryf2jpAFWpf45Olv9wnkV6Xf4XHfynbM+3nhx+XXxF+NbBUxgAra0+xklJ2UwraZEBMOY2APTbwaDJFpLahMgVfQpGpR6xDzuECYWHwR0hp1yqKlwIPDhFPOw5zsKg02GbYDhf/mx+MEKNobRPqGIGjBZZCVS2PjxhcoZZec8l5oLzfFMNfsQuZC834Ws4R14NZAMINPbxGWR+b5JN31jRJwt/R/Jz42C9xCqAOd7PkFb2y/bBgWdU1dbfVFOLa/+pgbgW+ssEgelbCU4ykFXBQqfZbgVv6zcYFgkxl7CXnJYUpolbkK1D6qjMidO4aJlbg92B+IxrNjiYItHpDSZs5ENgoA8U5S7qyjJZiuYmw5z1Rvw6FtRiHFzZBgpJPl7N17ZNfcVrYmJdQXGdQoj39dLD3q4pYKTtnQnuPww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(122000001)(55016002)(38070700005)(9686003)(66946007)(64756008)(66556008)(66476007)(5660300002)(86362001)(52536014)(76116006)(66446008)(71200400001)(91956017)(508600001)(110136005)(186003)(83380400001)(33656002)(53546011)(6506007)(8676002)(8936002)(2906002)(7696005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XytoFPGfhDZ/yYpfQJep0Rdw4q4EiNPbf2ozZ6pJMf+QevPoBGg7wQWLZkFe?=
 =?us-ascii?Q?2StGgMsj7tnOzJi6U5WoZ7x0YMQ/4lcFyu3hoKDIiO7hilbjerxGzAeq8EPv?=
 =?us-ascii?Q?xkp7uB5RxHpd4bWeuR4K+gDEb4Ys9uQzHgVH2lUPO/lSY08InS3RKudhoCFI?=
 =?us-ascii?Q?KYWg6WUdRHO0PCzmoNG4YbXhQWNexoX649g5/yVE5MbLVil+8KUWCWaL6vO8?=
 =?us-ascii?Q?8udD2bya5mjbzjUF2iT/rZ7kNDNBtBaWiEOkmTBpBmuXazLQ04PpnjV2yv8h?=
 =?us-ascii?Q?vckusuJTbMtp5BJ8FWcEywkHqvQDokUAxLmNOQDkuy1fbSBDoiPaeDHmcNxQ?=
 =?us-ascii?Q?LukYBN5ZPfvtxRyoQo2FxCySri6gsM34UJBu8h1Gz8nNYEGXaA0w2KndmHk6?=
 =?us-ascii?Q?MoCEKVCiIveca19Wcin75miU5/YmNg+ev180jQIyW7k7GsojMQ4PDZhB+vOf?=
 =?us-ascii?Q?Oj/coi71Q4nAnbvqGg60/hD6pPiD993iRfeeBsldyZAP8kIvn5934Y+GTlW+?=
 =?us-ascii?Q?P8KJYmqqL0kYYqu1I+Jp0WjRaK0KzD/kQFKkcDUkaJBSPVic+ZGSakf79ELr?=
 =?us-ascii?Q?ci65aLBiAcjN6O1fLqjc10v5+/b8WU5tNDuwnEussBq62HDSm4rQCE/WvzTl?=
 =?us-ascii?Q?r/JMpsra87zyCIse2yhnilnMUa6EqxRWi0nOK0IjgXNjNJ9EPBQNe30b86Lz?=
 =?us-ascii?Q?wrUTe4vGUiD2KMQxvvVtVLXNe2TgZDYokaxKa3hWnMoIsunRJuy42Aj/Ijci?=
 =?us-ascii?Q?dIZMoq2lWQdS3guPDcQQFuMzsL6xFlf/+lqCeG97Po9tlssWsc78++0MstA6?=
 =?us-ascii?Q?jAY32LJd/EfWQE2JmAvRCn57zMuNuim0xdm+ZwqnbeMVDKZp9b+SCKZoyU7n?=
 =?us-ascii?Q?a3xf9bs1UQuxVISmXPq7hOnw8znrF+HGbWQWMQuBN9Wf9DE3gz8MdP0ZuGaQ?=
 =?us-ascii?Q?7zNwQeL4iaEV9OfpjN0ZJHincgDMOyiSEi5jbuICivl/PE5oE83V2R2S9nHG?=
 =?us-ascii?Q?Mdi3l34ApVnVt4dsdf1HBIoDs3oKutYh/e4kjA9R+RzidAO1eBP2EX5WEc0F?=
 =?us-ascii?Q?Dn6P+7b8kbG4Oh3vOgjqDtX4Hkpw2WRbjeyfikL0RdXmOuUp5nIANY7YGf9E?=
 =?us-ascii?Q?hO8P2mOd7jZ6TZRIGmY+D8z2QQalL0riPs8C4nUEREZrsFljK6cSvGwLJ0jR?=
 =?us-ascii?Q?EQtC6BxeL70T0sSlMgdySz4G7b1zxNoYvyULcIlIseQqeTxl9fXWDGV4uX4c?=
 =?us-ascii?Q?oFe8eQBmSKvoyL5R4QyH30tx0axZVaYofSzRSFJ6OvRUhRrkyywzCtgDQlNL?=
 =?us-ascii?Q?VwhTGZfcZng9iVX3tLMtmU0RJxPu48FupHKJWkzASHqAwjKD6wPtiQaoiWgh?=
 =?us-ascii?Q?JgToXQRn+O037lTKU1Ec20YWro92MejREHG+FLUg9MOJFxbhKA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e13da09-ae49-4b73-7c73-08d9521b35b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2021 22:58:26.6780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gWPovSX7Wqjd5wfK6umMRrrT8h8c7xu9a/5NUFXcA58OUyfpXKahSD/v5sxsCA6whGCYgUBUFI/uu7kLF2JacA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4473
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/07/13 17:18, Damien Le Moal wrote:=0A=
> In block/blk-mq-sysfs.c, struct blk_mq_ctx_sysfs_entry is not used to=0A=
> define any attribute since the "mq" sysfs directory contains only=0A=
> sub-directories (no attribute files). As a result, blk_mq_sysfs_show(),=
=0A=
> blk_mq_sysfs_store(), and struct sysfs_ops blk_mq_sysfs_ops are all=0A=
> unused and unnecessary. Remove all this unused code.=0A=
=0A=
Jens,=0A=
=0A=
any comment on this one ?=0A=
=0A=
> =0A=
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> ---=0A=
>  block/blk-mq-sysfs.c | 55 --------------------------------------------=
=0A=
>  1 file changed, 55 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c=0A=
> index 7b52e7657b2d..253c857cba47 100644=0A=
> --- a/block/blk-mq-sysfs.c=0A=
> +++ b/block/blk-mq-sysfs.c=0A=
> @@ -45,60 +45,12 @@ static void blk_mq_hw_sysfs_release(struct kobject *k=
obj)=0A=
>  	kfree(hctx);=0A=
>  }=0A=
>  =0A=
> -struct blk_mq_ctx_sysfs_entry {=0A=
> -	struct attribute attr;=0A=
> -	ssize_t (*show)(struct blk_mq_ctx *, char *);=0A=
> -	ssize_t (*store)(struct blk_mq_ctx *, const char *, size_t);=0A=
> -};=0A=
> -=0A=
>  struct blk_mq_hw_ctx_sysfs_entry {=0A=
>  	struct attribute attr;=0A=
>  	ssize_t (*show)(struct blk_mq_hw_ctx *, char *);=0A=
>  	ssize_t (*store)(struct blk_mq_hw_ctx *, const char *, size_t);=0A=
>  };=0A=
>  =0A=
> -static ssize_t blk_mq_sysfs_show(struct kobject *kobj, struct attribute =
*attr,=0A=
> -				 char *page)=0A=
> -{=0A=
> -	struct blk_mq_ctx_sysfs_entry *entry;=0A=
> -	struct blk_mq_ctx *ctx;=0A=
> -	struct request_queue *q;=0A=
> -	ssize_t res;=0A=
> -=0A=
> -	entry =3D container_of(attr, struct blk_mq_ctx_sysfs_entry, attr);=0A=
> -	ctx =3D container_of(kobj, struct blk_mq_ctx, kobj);=0A=
> -	q =3D ctx->queue;=0A=
> -=0A=
> -	if (!entry->show)=0A=
> -		return -EIO;=0A=
> -=0A=
> -	mutex_lock(&q->sysfs_lock);=0A=
> -	res =3D entry->show(ctx, page);=0A=
> -	mutex_unlock(&q->sysfs_lock);=0A=
> -	return res;=0A=
> -}=0A=
> -=0A=
> -static ssize_t blk_mq_sysfs_store(struct kobject *kobj, struct attribute=
 *attr,=0A=
> -				  const char *page, size_t length)=0A=
> -{=0A=
> -	struct blk_mq_ctx_sysfs_entry *entry;=0A=
> -	struct blk_mq_ctx *ctx;=0A=
> -	struct request_queue *q;=0A=
> -	ssize_t res;=0A=
> -=0A=
> -	entry =3D container_of(attr, struct blk_mq_ctx_sysfs_entry, attr);=0A=
> -	ctx =3D container_of(kobj, struct blk_mq_ctx, kobj);=0A=
> -	q =3D ctx->queue;=0A=
> -=0A=
> -	if (!entry->store)=0A=
> -		return -EIO;=0A=
> -=0A=
> -	mutex_lock(&q->sysfs_lock);=0A=
> -	res =3D entry->store(ctx, page, length);=0A=
> -	mutex_unlock(&q->sysfs_lock);=0A=
> -	return res;=0A=
> -}=0A=
> -=0A=
>  static ssize_t blk_mq_hw_sysfs_show(struct kobject *kobj,=0A=
>  				    struct attribute *attr, char *page)=0A=
>  {=0A=
> @@ -198,23 +150,16 @@ static struct attribute *default_hw_ctx_attrs[] =3D=
 {=0A=
>  };=0A=
>  ATTRIBUTE_GROUPS(default_hw_ctx);=0A=
>  =0A=
> -static const struct sysfs_ops blk_mq_sysfs_ops =3D {=0A=
> -	.show	=3D blk_mq_sysfs_show,=0A=
> -	.store	=3D blk_mq_sysfs_store,=0A=
> -};=0A=
> -=0A=
>  static const struct sysfs_ops blk_mq_hw_sysfs_ops =3D {=0A=
>  	.show	=3D blk_mq_hw_sysfs_show,=0A=
>  	.store	=3D blk_mq_hw_sysfs_store,=0A=
>  };=0A=
>  =0A=
>  static struct kobj_type blk_mq_ktype =3D {=0A=
> -	.sysfs_ops	=3D &blk_mq_sysfs_ops,=0A=
>  	.release	=3D blk_mq_sysfs_release,=0A=
>  };=0A=
>  =0A=
>  static struct kobj_type blk_mq_ctx_ktype =3D {=0A=
> -	.sysfs_ops	=3D &blk_mq_sysfs_ops,=0A=
>  	.release	=3D blk_mq_ctx_sysfs_release,=0A=
>  };=0A=
>  =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
