Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F56C433DB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 09:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AAFD64F5D
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 09:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbhBBJDp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:03:45 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:47160 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbhBBJDk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 04:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612256618; x=1643792618;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=tB3uEfZlF1NGThP0/QHtb4+qd61bWrjxmrDaWJSEoP0=;
  b=Ca/5DEjXOarwH1HBStCXpnUHofAHVLGW+HKQhD3A3luZ5rkVOOzEl8Zu
   Bmuc0FPqB5rm9M0JWRd0j709wmexdURpFjGMk10+RVuLSrFlYeEtGbNUu
   f4RWl8zNyGMh5txHahJgh4wxAgrtJYtl68kXUMaGYoTAQNKaXqRCNhN8f
   EXQdcBdzIYEAMyh+2sKop1lYJeNIP8/m9LtMh8xtPDzpIxmiiXvEv8Azb
   63kAji4UqtzYJ6Zb7gC57sZW7+HG1+OhmXDVRdmBb4oOreLvGJhQOeXFx
   ABmoPam89YrqR5Wre7sMpJQIkvkGdZO3BwFAbqnunn1p43VdWtpgkuM6F
   w==;
IronPort-SDR: 5z3y9hL9z91Wn6WjJs25XyOZezBu9bkq1caG2qRBwRlQv+I+sFcbGOF6rKQ2+q1O+PBwZ8aiox
 4/s0mWQX7Ae1ylO8tPwqcCf5rAUCkFRfXMcmooOypRzxWAEppKhFJrWqzwUnOFDHZLFAuqV3k+
 xeDxVLR0//VdygagyUcXwecWI8CAVMP5eZDiuGeKESquDkw2B6fTXCiY1caHAg+mgX588DlcDe
 jRnlL/feGR2pDfYYUClnBbDqcmcQMNlFuX0mQnkfyGefsEO+XDHV9UgiZdHl0aS6zKkGqd69jw
 Lfs=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="158902391"
Received: from mail-bl2nam02lp2054.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.54])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 17:02:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tuvtf43woP2WR0h3Nne1L56jYmXNihtxRvn5pEnio745Ds9mExDjNPFFpUv5YQLoX6y71ZmVHwmmxnEx3pL77uPPYFMeB0e18esfXEsbG648Z+rhkZrKqN4MX4Vn9pbVseDugO4aj3N/hU2tQf/sZvdMsgqXji1ZXblJIia+vj28ONsNHTYLD/+punlGWRhCFlMoqbn3bGPzV/4aCO6VVeb4+BSieSGbkK+Og48lnP+QyeUIpuiNyzKp1qTWn8l9SfP0+Qd4uWUztrf0sBUnahtOw1Iw0Fs9nvUHxbKV5Nd6CDYyX8t0Molrp8uBG/4g4FdInfgkwAlw/faey2H0Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJY2ty3gKrSKCzcx4Gso2jpYTLm0f4bLa1rZxYJ0e+s=;
 b=YVZBykgKciGvAsqO5R4bD5cgE3p8lASmmtLuOAd/CbYYmReDW20DFnygv4HexfKAtGsMaEnCjRyYoj/dZ9/ZqnHUpjeLU0pGYAsQSeQGRO3KfKISwSe01HNzyj2YOl+x4W4R+YLoMnn2J1FNE2iqv1URFE+YuCSxk/NzpYhs3i1OXBSL+2QbdepFYUgSoL7mFy9nvhfksIzyaM8OAMdioV7tBRr3lQWdygJ4iX8qG317LWFUqOOA5EaBzyaj8utXnwGvKaROJ7Q6q//8sShzWS1OHAjiDVGjRAkpvOsfqzAtmxLQucYLcKYKstZfOV8px4gQGFI/p0PP0zQfbKFIaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJY2ty3gKrSKCzcx4Gso2jpYTLm0f4bLa1rZxYJ0e+s=;
 b=j4QcbHb6ZPwQcj5Q54kcxIQ2BJL7M8w9fcJnP4kK/MSlKWwpY26ryPcuRpaLG0nzM4WtDeQNZH8aXneJE+ztaZkDg0hX0n82AJzjo7QMw0GVDng+I5gFNo8njEc0DW0vpUNfk02haLmlgEgeD2kU3gIfGiuBNcwLv+rkpcMtDBw=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4641.namprd04.prod.outlook.com (2603:10b6:208:26::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 2 Feb
 2021 09:02:29 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%8]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 09:02:29 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "hare@suse.de" <hare@suse.de>, "colyli@suse.de" <colyli@suse.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 1/7] block: remove superfluous param in blk_fill_rwbs()
Thread-Topic: [PATCH 1/7] block: remove superfluous param in blk_fill_rwbs()
Thread-Index: AQHW+SPmKGXvjr8TckWajpJQn918IA==
Date:   Tue, 2 Feb 2021 09:02:29 +0000
Message-ID: <BL0PR04MB65145A7F5DCD9A8FE16BE0F0E7B59@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
 <20210202052544.4108-2-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:38be:e4f3:6636:91ce]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2f7e8767-6235-4641-ec46-08d8c7594529
x-ms-traffictypediagnostic: BL0PR04MB4641:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB4641DCBC6F0810FAC9111EC2E7B59@BL0PR04MB4641.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:356;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3e8rvJKuUMnsFA2pe0nJ9IGY1bczojjzLFIsMQcBI2NV3A7CgBDudVyVSynnVcmgcN5ld3qScu8rglZwZbptO0SRl84Nh+TbLZOipFuHzHkT3fejbWDrE5roBDApULgyywXHOZ+uX6nyI80Ec0LE8oxSLS3LCzvRn4AHPAZOZ7okyRwBO+IPRMQNO4ee64rdMVdpR9zoZqy+u4k4cfCcWqkUTv/vnaPYLUggfFBoaw51hi5ue0QNklValxidglvpXCJ6Ut6n7mDUBNu1zvgundfOpTBoOIh/BRg7ANxhvwIEeDrYp4OB0g+wbkAl/8EOMBD4Kb8B5TYmtEPgEiSP9fUBK9WkgIf/vi1GlB0bhi/bU6Z6ek9bNtSRZQ5AOASbWbKWsgug4PVPO1RLSqhLn4Bv7YLrXQqfgXtdFIHEuDyRQUw4i5AkBgdCSjBoss0wjdzz7e8uHddc3+TLmJe1fPF7KSGmPqRqf79nQRUrvhHpBhbE4dHdVagHXjOfbXruFdpxQhmgVUxQUlBXROqfjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(2906002)(53546011)(6506007)(4326008)(55016002)(186003)(76116006)(478600001)(64756008)(86362001)(8676002)(66446008)(66556008)(66946007)(52536014)(66476007)(91956017)(54906003)(71200400001)(5660300002)(7696005)(8936002)(316002)(7416002)(110136005)(83380400001)(9686003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5+HxY8Z9pUWMeQn50MjJQsE29stmg2qE7FyCBRoqmqc+JWYbPeHuRyclzyJF?=
 =?us-ascii?Q?KA8S7kjsDbgWDdH6NpoxDg5KZhkx3BzTvuJDu+VvDi1zp3FbqpgR7jjWFfSr?=
 =?us-ascii?Q?RoW7S1HS+0XVJf9lMvTyxTgaICUKx2qkCtWu+KHOrlBzbTWzUJvxCBdYnIFC?=
 =?us-ascii?Q?HC/V8VBYN4NqzCDwTKuDwZz8kNZ+Hcp+p/q3YurQ0FcVeFVNfbq0sjO5yYd8?=
 =?us-ascii?Q?dy1Jetkr+SHWz0Rzb18cSbl+GTxQwYaHcfKxCEUhHNR2bqvjGCzguqZ12mRd?=
 =?us-ascii?Q?59phM1m9aAJhdnLC5ucm8qwWXZfCszPL3eR7XCPUL5rpWL60iIkflVykTsTx?=
 =?us-ascii?Q?a9NgLCfXYIjiTVVOo/xl+860C46t4tD0fEeyyQJDW12dzERQFUwHJ8+OhwIM?=
 =?us-ascii?Q?7qJoza54a3PD2llMXuZDGVsqEObJfDKtR7u559wYv1QuP6gotr0R9GKhsM4c?=
 =?us-ascii?Q?p/ylsZrRZfJHhpmsNnKIPaf5ibbe/0o/Kyb7YC0jDLw2ma/jawwgo4pyzS5F?=
 =?us-ascii?Q?to0HUKRThzCRgIB4KqdtnlwKdLGS+585pOTsAT8j2TMho6HPGSX/3HNN7wO1?=
 =?us-ascii?Q?Ww0YDOLQ7Q2abxRtQ9J1T5s/Mwh+lCEHjC2QByIjAy5I+pTVgPHEJ44sVfp4?=
 =?us-ascii?Q?g9fRvm+cdIDAh/9BOwKFrYnAglh8jzV+iudKYbmsvRatUCsBpUoHKLeDUT9e?=
 =?us-ascii?Q?UOEHFFZRbQYs3qsG3TgofZ1dm86mTAheDUydETbYHy8LfQA8PEhRmoeOSty7?=
 =?us-ascii?Q?VAFPGTl5szmYu0/InbiXqPDQWZgXWWLiyLYXSr6aWRPXotFEAJV8+VWnwKei?=
 =?us-ascii?Q?PkC5f9ryFlFXI74TWIYFFGLPdisxef0zQuPXMoY8nN0JxfDf+pHW/9vvXNkH?=
 =?us-ascii?Q?afpPQrlJHA4bP6iLwKUwJf4/RZ5qVK40qnESbAvRUCOdHGgSQcKJ8F2a1R6c?=
 =?us-ascii?Q?bvuwDBkGnYs1hQHrN4/R+lxHyN631nTrbj1aSFyvIBUeHup+ItkWlS6bNQrv?=
 =?us-ascii?Q?tFEaZMYpP5jAyBC8nwqQ0Xw6aGnpEO07mHGE6DcqQzzOU5I1LqdUGyz0r71n?=
 =?us-ascii?Q?IgReLUg9PyJ2c4uP46pIUzcX2YpQsV+mePXk+VdHPMbFtjWjXp4Wjifr+UeU?=
 =?us-ascii?Q?WC3XFtgQ0ZCOE9wTjZc8Ibt45AI0oHeFgQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7e8767-6235-4641-ec46-08d8c7594529
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 09:02:29.8461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: icVmk6oqikuV9LKU5R18JGyBQpVOC/nI9HUzyXF55aAkYP/0n7CAlwxe1xnuSKUl+gJl1XTPUsbedGld+Lc/iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4641
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/02/02 14:26, Chaitanya Kulkarni wrote:=0A=
> The last parameter for the function blk_fill_rwbs() was added in=0A=
> 5782138e47 ("tracing/events: convert block trace points to=0A=
> TRACE_EVENT()") in order to signal read request and use of that parameter=
=0A=
> was replaced with using switch case REQ_OP_READ with=0A=
> 1b9a9ab78b0 ("blktrace: use op accessors"), but the parameter was never=
=0A=
> removed.=0A=
> =0A=
> Remove the unused parameter and adjust the respective call sites.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  include/linux/blktrace_api.h  |  2 +-=0A=
>  include/trace/events/bcache.h | 10 +++++-----=0A=
>  include/trace/events/block.h  | 16 ++++++++--------=0A=
>  kernel/trace/blktrace.c       |  2 +-=0A=
>  4 files changed, 15 insertions(+), 15 deletions(-)=0A=
> =0A=
> diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h=
=0A=
> index 05556573b896..11484f1d19a1 100644=0A=
> --- a/include/linux/blktrace_api.h=0A=
> +++ b/include/linux/blktrace_api.h=0A=
> @@ -119,7 +119,7 @@ struct compat_blk_user_trace_setup {=0A=
>  =0A=
>  #endif=0A=
>  =0A=
> -extern void blk_fill_rwbs(char *rwbs, unsigned int op, int bytes);=0A=
> +extern void blk_fill_rwbs(char *rwbs, unsigned int op);=0A=
>  =0A=
>  static inline sector_t blk_rq_trace_sector(struct request *rq)=0A=
>  {=0A=
> diff --git a/include/trace/events/bcache.h b/include/trace/events/bcache.=
h=0A=
> index e41c611d6d3b..899fdacf57b9 100644=0A=
> --- a/include/trace/events/bcache.h=0A=
> +++ b/include/trace/events/bcache.h=0A=
> @@ -28,7 +28,7 @@ DECLARE_EVENT_CLASS(bcache_request,=0A=
>  		__entry->sector		=3D bio->bi_iter.bi_sector;=0A=
>  		__entry->orig_sector	=3D bio->bi_iter.bi_sector - 16;=0A=
>  		__entry->nr_sector	=3D bio->bi_iter.bi_size >> 9;=0A=
> -		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);=0A=
> +		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);=0A=
>  	),=0A=
>  =0A=
>  	TP_printk("%d,%d %s %llu + %u (from %d,%d @ %llu)",=0A=
> @@ -102,7 +102,7 @@ DECLARE_EVENT_CLASS(bcache_bio,=0A=
>  		__entry->dev		=3D bio_dev(bio);=0A=
>  		__entry->sector		=3D bio->bi_iter.bi_sector;=0A=
>  		__entry->nr_sector	=3D bio->bi_iter.bi_size >> 9;=0A=
> -		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);=0A=
> +		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);=0A=
>  	),=0A=
>  =0A=
>  	TP_printk("%d,%d  %s %llu + %u",=0A=
> @@ -137,7 +137,7 @@ TRACE_EVENT(bcache_read,=0A=
>  		__entry->dev		=3D bio_dev(bio);=0A=
>  		__entry->sector		=3D bio->bi_iter.bi_sector;=0A=
>  		__entry->nr_sector	=3D bio->bi_iter.bi_size >> 9;=0A=
> -		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);=0A=
> +		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);=0A=
>  		__entry->cache_hit =3D hit;=0A=
>  		__entry->bypass =3D bypass;=0A=
>  	),=0A=
> @@ -168,7 +168,7 @@ TRACE_EVENT(bcache_write,=0A=
>  		__entry->inode		=3D inode;=0A=
>  		__entry->sector		=3D bio->bi_iter.bi_sector;=0A=
>  		__entry->nr_sector	=3D bio->bi_iter.bi_size >> 9;=0A=
> -		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);=0A=
> +		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);=0A=
>  		__entry->writeback =3D writeback;=0A=
>  		__entry->bypass =3D bypass;=0A=
>  	),=0A=
> @@ -238,7 +238,7 @@ TRACE_EVENT(bcache_journal_write,=0A=
>  		__entry->sector		=3D bio->bi_iter.bi_sector;=0A=
>  		__entry->nr_sector	=3D bio->bi_iter.bi_size >> 9;=0A=
>  		__entry->nr_keys	=3D keys;=0A=
> -		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);=0A=
> +		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);=0A=
>  	),=0A=
>  =0A=
>  	TP_printk("%d,%d  %s %llu + %u keys %u",=0A=
> diff --git a/include/trace/events/block.h b/include/trace/events/block.h=
=0A=
> index 0d782663a005..879cba8bdfca 100644=0A=
> --- a/include/trace/events/block.h=0A=
> +++ b/include/trace/events/block.h=0A=
> @@ -89,7 +89,7 @@ TRACE_EVENT(block_rq_requeue,=0A=
>  		__entry->sector    =3D blk_rq_trace_sector(rq);=0A=
>  		__entry->nr_sector =3D blk_rq_trace_nr_sectors(rq);=0A=
>  =0A=
> -		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags, blk_rq_bytes(rq));=0A=
> +		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);=0A=
>  		__get_str(cmd)[0] =3D '\0';=0A=
>  	),=0A=
>  =0A=
> @@ -133,7 +133,7 @@ TRACE_EVENT(block_rq_complete,=0A=
>  		__entry->nr_sector =3D nr_bytes >> 9;=0A=
>  		__entry->error     =3D error;=0A=
>  =0A=
> -		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags, nr_bytes);=0A=
> +		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);=0A=
>  		__get_str(cmd)[0] =3D '\0';=0A=
>  	),=0A=
>  =0A=
> @@ -166,7 +166,7 @@ DECLARE_EVENT_CLASS(block_rq,=0A=
>  		__entry->nr_sector =3D blk_rq_trace_nr_sectors(rq);=0A=
>  		__entry->bytes     =3D blk_rq_bytes(rq);=0A=
>  =0A=
> -		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags, blk_rq_bytes(rq));=0A=
> +		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);=0A=
>  		__get_str(cmd)[0] =3D '\0';=0A=
>  		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);=0A=
>  	),=0A=
> @@ -249,7 +249,7 @@ TRACE_EVENT(block_bio_complete,=0A=
>  		__entry->sector		=3D bio->bi_iter.bi_sector;=0A=
>  		__entry->nr_sector	=3D bio_sectors(bio);=0A=
>  		__entry->error		=3D blk_status_to_errno(bio->bi_status);=0A=
> -		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);=0A=
> +		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);=0A=
>  	),=0A=
>  =0A=
>  	TP_printk("%d,%d %s %llu + %u [%d]",=0A=
> @@ -276,7 +276,7 @@ DECLARE_EVENT_CLASS(block_bio,=0A=
>  		__entry->dev		=3D bio_dev(bio);=0A=
>  		__entry->sector		=3D bio->bi_iter.bi_sector;=0A=
>  		__entry->nr_sector	=3D bio_sectors(bio);=0A=
> -		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);=0A=
> +		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);=0A=
>  		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);=0A=
>  	),=0A=
>  =0A=
> @@ -433,7 +433,7 @@ TRACE_EVENT(block_split,=0A=
>  		__entry->dev		=3D bio_dev(bio);=0A=
>  		__entry->sector		=3D bio->bi_iter.bi_sector;=0A=
>  		__entry->new_sector	=3D new_sector;=0A=
> -		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);=0A=
> +		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);=0A=
>  		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);=0A=
>  	),=0A=
>  =0A=
> @@ -474,7 +474,7 @@ TRACE_EVENT(block_bio_remap,=0A=
>  		__entry->nr_sector	=3D bio_sectors(bio);=0A=
>  		__entry->old_dev	=3D dev;=0A=
>  		__entry->old_sector	=3D from;=0A=
> -		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);=0A=
> +		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);=0A=
>  	),=0A=
>  =0A=
>  	TP_printk("%d,%d %s %llu + %u <- (%d,%d) %llu",=0A=
> @@ -518,7 +518,7 @@ TRACE_EVENT(block_rq_remap,=0A=
>  		__entry->old_dev	=3D dev;=0A=
>  		__entry->old_sector	=3D from;=0A=
>  		__entry->nr_bios	=3D blk_rq_count_bios(rq);=0A=
> -		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags, blk_rq_bytes(rq));=0A=
> +		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);=0A=
>  	),=0A=
>  =0A=
>  	TP_printk("%d,%d %s %llu + %u <- (%d,%d) %llu %u",=0A=
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c=0A=
> index 9e9ee4945043..8a2591c7aa41 100644=0A=
> --- a/kernel/trace/blktrace.c=0A=
> +++ b/kernel/trace/blktrace.c=0A=
> @@ -1867,7 +1867,7 @@ void blk_trace_remove_sysfs(struct device *dev)=0A=
>  =0A=
>  #ifdef CONFIG_EVENT_TRACING=0A=
>  =0A=
> -void blk_fill_rwbs(char *rwbs, unsigned int op, int bytes)=0A=
> +void blk_fill_rwbs(char *rwbs, unsigned int op)=0A=
>  {=0A=
>  	int i =3D 0;=0A=
>  =0A=
> =0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
