Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025A2C433DB
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 10:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F9F23110
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 10:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392006AbhAZKai (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 05:30:38 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:18903 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404016AbhAZK33 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 05:29:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611656969; x=1643192969;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6z6Bf4Lj6UtgJ6fVlrSTEnlq0fckSLHPcNOjmc/BR5Q=;
  b=bPZYp0yty0m0NRaxFuo37dLLvIj8P4YX/jbSXQL9AOI00Z7XKLH8L0n7
   vEfY5gSg6awqvDdujHV2T/0BXLzDLTAJUpfDu+Gts+ZwlauOUNs3MQlCX
   HfvLoHouBFeRNHk7L8DOVyQrI55fs/ksuJ6o6zOrMfIpsg2wQsqQRSJKV
   vIyvo5lxTgx1rqGt1T8Fh70y/oJi5NoywWIeCRFCe0TzQQ4CKNFrixjb9
   i+bWsEYX9ftQXD7fH2IfIpDgH3gZukAk9vy26PSeF/iF8JizpS9/vhVhz
   Z9zU8xqJqR5lm2cm62M/0Lh2cqNu4X2oq7rhqjg+QHCi2aY/LoQ1eOPmp
   w==;
IronPort-SDR: k/lLHbsYhK7kroznRvxXg5AH2RD9+WADjmksA0o043MArlvtNZ7f0F1paMI7IK9RcuNf02Kx8w
 TdyoWgVtfqX8Mg5/qnCqUL6AGyU44eEQSqHVrpsPt2Eot5CCIn350FYKfhc2HAcg+E16AwgjtS
 4Mybf+/smhjc8VrVsQr0mGzOTkXa5RIKLXTU0t4buCTsVSHHM+UX71BBiqUJopHtKrQj8nHdan
 2HbiKMCcCootCjeWchcO8882Alar2PFOrBGFPt1KuvD7uYEsSFeJgHu5fxXvTXNbK4NF1C8w6Q
 3LQ=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159514299"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 18:28:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6mzxI/DatSA4KCmv97nTfz8OlKMFb3IWixTZUKZs7a9FsIwCNg7j6nHTi/dIa/4Bc3gRZlepDNPLqjrMjlJNQvVzpaMSqri1J+7cSw41i+0ssppIKtQFVXyZ3F7BXXJ2DBb5KoluVgCRzPJJKs+8zqRf4I40r8CVW24vE/anA+Zo1xLHs25LfUc1qxeT20FFiVKUrz7FnfUIEZppwG+jnIV/+OqmRwBvGitM9fl3TMxO/cWJoRn4zlo1LeBv4AHdmInz1CewNA0bnmhMk4J3juPRfsok7T4mvRfybWeYODa+SEICxipYDQf7xsvIMdXruwW+ok2B5o5jTS2225CXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvaHGIlSNaN5CyNBn3amfJwyZsqiOk/27Q2j9UtSz5M=;
 b=gjW3jZbjDBrS4Fd8raGl9w+CIviytmU64JYRRPbgN1oty7wycW8wwcJzxbZq17BJJQXTXIYq2m6OeEUNi+AROxv7Iv/+UfKEyEP0ftoeEku7tkWo6JRtumKLApdHuADzAJ2bGLBkJJmAjG7ffeVkvU3dCWf94Z2IX1Dduhoy5mjZuoMOTpnqVqfzXxmtOtLsm9BSjTPEQZUQljxOKB3mmsl2exl5o5bM6VN6TUT0aWGz+rRzr067I7lpJi8hOZIHM6iRwgB2FVoIbqGUwqsEbJAZZ3mlkfUqItfk713lo05T1VTreJfh711pePZrH344HBKfWfmw4DmuAtTh+EyVFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvaHGIlSNaN5CyNBn3amfJwyZsqiOk/27Q2j9UtSz5M=;
 b=QrAXmXWfZRQtJkC4aqusM4mMhc5hUGetQZkErZ2UQLy/KXrXqdgaR1DjmDk8xBwnopHLPmM/JSHjmRa84FGNDMl5CsRg3R6YyRzsD1/bRVOgF43t7273+vWXdtjls/4mX6yR6NwvnzDQQeOKQBChJAUSNVfIRA4Smd9CZ1Ut1Hg=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB6595.namprd04.prod.outlook.com (2603:10b6:208:1c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Tue, 26 Jan
 2021 10:28:17 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%7]) with mapi id 15.20.3784.017; Tue, 26 Jan 2021
 10:28:17 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Changheun Lee <nanich.lee@samsung.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "asml.silence@gmail.com" <asml.silence@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "patchwork-bot@kernel.org" <patchwork-bot@kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>
CC:     "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>,
        "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
        "mj0123.lee@samsung.com" <mj0123.lee@samsung.com>,
        "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
        "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
        "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>,
        "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>
Subject: Re: [PATCH v3 1/2] bio: limit bio max size
Thread-Topic: [PATCH v3 1/2] bio: limit bio max size
Thread-Index: AQHW88bVafk/AI14qEmQ667BUb4FrQ==
Date:   Tue, 26 Jan 2021 10:28:17 +0000
Message-ID: <BL0PR04MB65147D829369D0E6B45507E0E7BC9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <CGME20210126093706epcas1p150e9b57a678f8724fa8ab9eddcec8a42@epcas1p1.samsung.com>
 <20210126092129.6676-1-nanich.lee@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:59be:e05f:a0a7:a46c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 08b152fc-96d5-478d-579d-08d8c1e518af
x-ms-traffictypediagnostic: BL0PR04MB6595:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB6595BA45C9DDBD6DAE810A7EE7BC9@BL0PR04MB6595.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zfRvCwuQg+sYzrmIyWetqsPsslggM5kDeumJgqZ2ArSpVDj5y/i9r+jm0nNToCCm0ki6OA/GUtCffah4Uv0HMRtXCWV2Yfqj9Y1gmZ81Uje9kd40Zig0l3QfSua3PoZ1BFCykLMP03XjzvHOMzvlH8qNjQf2dOQ0+Lh/3NdnKs525YSmdXAcYt2NL0eR3AgO5xz7yU079P+jX+UyIwg3gwujpE3J87WU7bekeJcfjxOP7JpoWAr/BKkoMkxX3AK1PtDH52QaDGgb1GIvkl6oeMfue/bsIT9vjS9kDW7upO47Xd4JZi6DLLkUvSGRDISXoEluNBH+n2sj4lMw19O73vWKVimplPzz7rrYL3HWwYykR9gg1eCq08Ihi2RgEhHsDQSBsKlGcSsNps0UvLjBKJV17OT1wBuy/ZGkeXMVpVJGpac5BlpjOgVB7prJjhrV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(91956017)(53546011)(6506007)(5660300002)(66946007)(4326008)(8936002)(54906003)(110136005)(921005)(9686003)(33656002)(55016002)(76116006)(478600001)(316002)(83380400001)(71200400001)(86362001)(2906002)(186003)(52536014)(7696005)(66446008)(64756008)(66556008)(66476007)(7416002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?moq5vBAbJjZWPcARyov2mu1btDiOD5O9t2Gnwsk0pOda/EV6TZf1hNpzLmrK?=
 =?us-ascii?Q?1xxAHhtG4PQ//bCccqUa0DdECP9OGvJjcX83wxsQ/uKrhBQx2tEJDad0UPXu?=
 =?us-ascii?Q?/Ly+EnN6PDFPojR7tnfd3alTJjaKyenoVNmSsrW6FlzvmYaImQKwDqBqqY76?=
 =?us-ascii?Q?NnWlYT7x3JkElgEMnzl3Oygw/suA1AtfxwNsL895P533gpvLoyVbdLApKwVA?=
 =?us-ascii?Q?JpjBqCEckdIr54axn15SaVL/UL2G0m5ebKYqmFvx6LK++BcuqFkemL4ngYzj?=
 =?us-ascii?Q?R4S7QRCyWYIuYI0qupF7jcDK4F6szfbinEZtefbmHoOeNL7z5sNuxbp8C4O/?=
 =?us-ascii?Q?a/lCc5aD1HkxKlF03yMb28j+E+KS9VNCbfPIe9JcGBcTTwhvRj3MNNN5btlm?=
 =?us-ascii?Q?c1uarzT9tMqpt3azPSk9zKksHQu5qoAtPLSEkLUhvDTcJQh5Qzw0bu882ryM?=
 =?us-ascii?Q?ggp8Hk2e8eCw3QW+VQjGsR+hty2skLlAFtofG3oQF8d/Lu+9i8p2B6u5JLsG?=
 =?us-ascii?Q?WOU7jazJ7hGFb/gBSKNwYaqlPwvKbOTbmlNeSB48r429bewmG+QeJLM088v5?=
 =?us-ascii?Q?BMyp9da3q9NpX9YM3s+3rHU4zOY9c24HbRd0tDzeFGvSHJebl44JCAqj0QXg?=
 =?us-ascii?Q?VWhpswNdpnQoAHki5xwJHQg1Uzf5s25ybixutcpMCrR9EuNROLDtPsYiUghh?=
 =?us-ascii?Q?D/EEKVggLvRNYbxVG/DqbeTclPMuNSbsNvomJxIGTaZHLc8kjyRG6oiv1o1+?=
 =?us-ascii?Q?3FO3hWvOpZRor5aW3lQVSZOntYigserdaMzXbuP7doYVn90L9EokeP/Qquke?=
 =?us-ascii?Q?pwS/EGfiVh9y12WRQYO7SMTjUd41w6KV1MUuhS75Q/psJSuq9JI3wUu/on5O?=
 =?us-ascii?Q?uDr0Sx2mHaudIFvlRkY3pJa9PLpG1qgiQ7a5d3PzoAFOHsAYZgsgaju2HB20?=
 =?us-ascii?Q?lUXtxmeWqSPLOIo03T+DwRAn/3l5AM+ZQQu1S1N54ApboApI6XiZFb3Xfrzs?=
 =?us-ascii?Q?mlLc1rCenFsvXQ0sqgL4YyCF/qZeWV29+XsqH9dWModWwpxr6N7JZJcBqM3q?=
 =?us-ascii?Q?NF4DhNMOfj0ELRF9z3A+juJP7y2fYhiDVrpbPztvDuo6vFrCti9hcOyt/VN/?=
 =?us-ascii?Q?kAozAp+pEBh+rFTk8i5ZPwT+i/XWCLY+0w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b152fc-96d5-478d-579d-08d8c1e518af
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 10:28:17.8074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UV2CdFRmIvQ3dqXQR+IyWV7ZnH1AxWpBFgiqYLS+HtiokLmau+gfQG3IdUwvqNZ2OUJQ68487OC/4eXuiEUirA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6595
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/01/26 18:37, Changheun Lee wrote:=0A=
> bio size can grow up to 4GB when muli-page bvec is enabled.=0A=
> but sometimes it would lead to inefficient behaviors.=0A=
> in case of large chunk direct I/O, - 32MB chunk read in user space -=0A=
> all pages for 32MB would be merged to a bio structure if the pages=0A=
> physical addresses are contiguous. it makes some delay to submit=0A=
> until merge complete. bio max size should be limited to a proper size.=0A=
> =0A=
> When 32MB chunk read with direct I/O option is coming from userspace,=0A=
> kernel behavior is below now. it's timeline.=0A=
> =0A=
>  | bio merge for 32MB. total 8,192 pages are merged.=0A=
>  | total elapsed time is over 2ms.=0A=
>  |------------------ ... ----------------------->|=0A=
>                                                  | 8,192 pages merged a b=
io.=0A=
>                                                  | at this time, first bi=
o submit is done.=0A=
>                                                  | 1 bio is split to 32 r=
ead request and issue.=0A=
>                                                  |--------------->=0A=
>                                                   |--------------->=0A=
>                                                    |--------------->=0A=
>                                                               ......=0A=
>                                                                    |-----=
---------->=0A=
>                                                                     |----=
----------->|=0A=
>                           total 19ms elapsed to complete 32MB read done f=
rom device. |=0A=
> =0A=
> If bio max size is limited with 1MB, behavior is changed below.=0A=
> =0A=
>  | bio merge for 1MB. 256 pages are merged for each bio.=0A=
>  | total 32 bio will be made.=0A=
>  | total elapsed time is over 2ms. it's same.=0A=
>  | but, first bio submit timing is fast. about 100us.=0A=
>  |--->|--->|--->|---> ... -->|--->|--->|--->|--->|=0A=
>       | 256 pages merged a bio.=0A=
>       | at this time, first bio submit is done.=0A=
>       | and 1 read request is issued for 1 bio.=0A=
>       |--------------->=0A=
>            |--------------->=0A=
>                 |--------------->=0A=
>                                       ......=0A=
>                                                  |--------------->=0A=
>                                                   |--------------->|=0A=
>         total 17ms elapsed to complete 32MB read done from device. |=0A=
> =0A=
> As a result, read request issue timing is faster if bio max size is limit=
ed.=0A=
> Current kernel behavior with multipage bvec, super large bio can be creat=
ed.=0A=
> And it lead to delay first I/O request issue.=0A=
> =0A=
> Signed-off-by: Changheun Lee <nanich.lee@samsung.com>=0A=
> ---=0A=
>  block/bio.c            | 17 ++++++++++++++++-=0A=
>  include/linux/bio.h    |  4 +++-=0A=
>  include/linux/blkdev.h |  3 +++=0A=
>  3 files changed, 22 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/block/bio.c b/block/bio.c=0A=
> index 1f2cc1fbe283..ec0281889045 100644=0A=
> --- a/block/bio.c=0A=
> +++ b/block/bio.c=0A=
> @@ -287,6 +287,21 @@ void bio_init(struct bio *bio, struct bio_vec *table=
,=0A=
>  }=0A=
>  EXPORT_SYMBOL(bio_init);=0A=
>  =0A=
> +unsigned int bio_max_size(struct bio *bio)=0A=
> +{=0A=
> +	struct request_queue *q;=0A=
> +=0A=
> +	if (!bio->bi_disk)=0A=
> +		return UINT_MAX;=0A=
> +=0A=
> +	q =3D bio->bi_disk->queue;=0A=
> +	if (!blk_queue_limit_bio_size(q))=0A=
> +		return UINT_MAX;=0A=
> +=0A=
> +	return blk_queue_get_max_sectors(q, bio_op(bio)) << SECTOR_SHIFT;=0A=
> +}=0A=
> +EXPORT_SYMBOL(bio_max_size);=0A=
=0A=
Why export this ? This is only used in this file and in bio.h in bio_full()=
.=0A=
=0A=
> +=0A=
>  /**=0A=
>   * bio_reset - reinitialize a bio=0A=
>   * @bio:	bio to reset=0A=
> @@ -877,7 +892,7 @@ bool __bio_try_merge_page(struct bio *bio, struct pag=
e *page,=0A=
>  		struct bio_vec *bv =3D &bio->bi_io_vec[bio->bi_vcnt - 1];=0A=
>  =0A=
>  		if (page_is_mergeable(bv, page, len, off, same_page)) {=0A=
> -			if (bio->bi_iter.bi_size > UINT_MAX - len) {=0A=
> +			if (bio->bi_iter.bi_size > bio_max_size(bio) - len) {=0A=
>  				*same_page =3D false;=0A=
>  				return false;=0A=
>  			}=0A=
> diff --git a/include/linux/bio.h b/include/linux/bio.h=0A=
> index 1edda614f7ce..cdb134ca7bf5 100644=0A=
> --- a/include/linux/bio.h=0A=
> +++ b/include/linux/bio.h=0A=
> @@ -100,6 +100,8 @@ static inline void *bio_data(struct bio *bio)=0A=
>  	return NULL;=0A=
>  }=0A=
>  =0A=
> +extern unsigned int bio_max_size(struct bio *);=0A=
=0A=
No need for extern.=0A=
=0A=
> +=0A=
>  /**=0A=
>   * bio_full - check if the bio is full=0A=
>   * @bio:	bio to check=0A=
> @@ -113,7 +115,7 @@ static inline bool bio_full(struct bio *bio, unsigned=
 len)=0A=
>  	if (bio->bi_vcnt >=3D bio->bi_max_vecs)=0A=
>  		return true;=0A=
>  =0A=
> -	if (bio->bi_iter.bi_size > UINT_MAX - len)=0A=
> +	if (bio->bi_iter.bi_size > bio_max_size(bio) - len)=0A=
>  		return true;=0A=
>  =0A=
>  	return false;=0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index f94ee3089e01..3aeab9e7e97b 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -621,6 +621,7 @@ struct request_queue {=0A=
>  #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */=0A=
>  #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active =
*/=0A=
>  #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */=0A=
> +#define QUEUE_FLAG_LIMIT_BIO_SIZE 30	/* limit bio size */=0A=
>  =0A=
>  #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\=0A=
>  				 (1 << QUEUE_FLAG_SAME_COMP) |		\=0A=
> @@ -667,6 +668,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, s=
truct request_queue *q);=0A=
>  #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)=0A=
>  #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->qu=
eue_flags)=0A=
>  #define blk_queue_nowait(q)	test_bit(QUEUE_FLAG_NOWAIT, &(q)->queue_flag=
s)=0A=
> +#define blk_queue_limit_bio_size(q)	\=0A=
> +	test_bit(QUEUE_FLAG_LIMIT_BIO_SIZE, &(q)->queue_flags)=0A=
>  =0A=
>  extern void blk_set_pm_only(struct request_queue *q);=0A=
>  extern void blk_clear_pm_only(struct request_queue *q);=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
