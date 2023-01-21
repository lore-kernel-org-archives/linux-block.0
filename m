Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8857C004D4
	for <linux-block@archiver.kernel.org>; Sat, 21 Jan 2023 04:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjAUE4c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Jan 2023 23:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUE4b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Jan 2023 23:56:31 -0500
Received: from DM6FTOPR00CU001-vft-obe.outbound.protection.outlook.com (mail-cusazon11020020.outbound.protection.outlook.com [52.101.61.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A272B53FAB
        for <linux-block@vger.kernel.org>; Fri, 20 Jan 2023 20:56:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAIMSR977bdm+A/UpNjv/cEPE+KsMDlRmOvnKIrhvWSA8wCRLTaW1MPpNFYy8fg0ShpNG1Qh7dL05ZbCcoPt0+4jWZR2Re1rs4CzkdvktnjZ6FawQhE3qPfruXwoV65lKAOtL/83M9jc1JthLSOC3MCCJkpNZIsHDVVVu+zoZHBZDf1izUJyOZRzBYD4kmipdqOAn8zIWPTDEiF86pXVc/FzIf7BJvAB9ZqZgURn1l4JNT8h2rl36EF3g8jB/oWL31PI2kvWNqmKRKXxztqhLZ6gBMAOPvhyOY9Sr45OLM8xxMiNC2SdpXY2fW8/48q/F3p3A58kWS+DY0E0CJEljA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuQM1PYjOfvxAM3aebU2R6P2M++K/fo3X+YTsFZ3X24=;
 b=I4t+7Bp0SaqVPZtHSpYdsfB7YIUEECaRbpiWki4etAoSj4RIVSDQwHDfzHffGdNozUhtoyIpQuajSP0vnxJI8N0WMfw6nYSbg6DJ6pOvWo2kY2sGXPpinCHbIcaJFqwXC7Obk9S5s3eXzN7PCvjvePscZ5Kwx6sIE48ynX7T54EDnmX8+a+crm2UsNueoTFvwtVxgiIG3JbjU1Q3XHFyNEZiC71b2vioQ+cX60gtrx5QcDAw8udT+YArKvj8vsb3ar5aMMEXFuMmZAv9C5oSMm/9Bcs1HclPrfDjMKsC53j1Nmj99xmThDwWgeH8O+DJzjaAFFYqDeEZd8n+oivhhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuQM1PYjOfvxAM3aebU2R6P2M++K/fo3X+YTsFZ3X24=;
 b=ToxFZBjQJbk1jREWSiX7feDL2Leo7DHO7PwV1SbanGe0BGdpvNxV6zPc5f6JqMnhW+sE+IuGFNLYvCHCVvAxZKcfSUiDqP7ygvSFPxk2w31TEdjdkZ8/Tpyk6xOw5yB30muGXN6expEya0n91SvhJ+CuKu1wnqN9fks3a4XxEAw=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BY5PR21MB1410.namprd21.prod.outlook.com (2603:10b6:a03:232::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.10; Sat, 21 Jan
 2023 04:56:27 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e%9]) with mapi id 15.20.6043.008; Sat, 21 Jan 2023
 04:56:20 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH v2] block: don't allow multiple bios for IOCB_NOWAIT issue
Thread-Topic: [PATCH v2] block: don't allow multiple bios for IOCB_NOWAIT
 issue
Thread-Index: AQHZKe5eY4YKqF4/rUGyGUKn5WFEPa6oUYAg
Date:   Sat, 21 Jan 2023 04:56:20 +0000
Message-ID: <BYAPR21MB168890325173FD3A35CB89DDD7CA9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1ce71005-c81b-374d-5bcf-e3b7e7c48d0d@kernel.dk>
In-Reply-To: <1ce71005-c81b-374d-5bcf-e3b7e7c48d0d@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1488fa75-1ace-40fd-8976-3c65e46a510f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-21T04:41:52Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BY5PR21MB1410:EE_
x-ms-office365-filtering-correlation-id: cd35da53-5a8e-447a-f2ce-08dafb6bd665
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M4+JHDHvnJetIJqsR0UCQ+qdArdrNB/OUJ8YiGzFzCd2C2u4Wl+qG0Wn08RcNByt29yYIQ+ee+YVv9jRottGDyP1ZZqQe9V+sdXZkK5SMsz5sJF0gC8ANmyGlmlt3VfugGiiAy/cm8i0tMiTbk3hebBENM1UB4IPJB3qfRLfG30V1e2hm2dy9pjlF2f1ZTwBDyQXpEyqlfsdFXTnOQ17k5OaTbzn/txeoZK448llaQLDsIdKLJmN7uKH8WvV59TnSq3dFt8HWf2uf8/mMPvy3wku61B8aTx9h2R9k5epAlD+ggY/dvBEaDiayjydXcDeO4ePkjoDf1JE1wApylR1elweJrEJVMA1gj9kvNiY3NlsMggfmM6WBncyrdrRcidt3NtgJPJujDMJ1NYCwvrLOgUXSKxuuOZfu5FE1J3locLuIwEJxcSUqNZa5vSAecNC0wCvcrlcQmHD/ZQqgNE+cADYgB1xkXO973NS06BLDrpaTi7bUpdFeNqnMyq05sEEFknXUCtc0aFIfOssVL/GF7RhLBmxsML4Ji9wtgNgrH8v6Mvn/FHkhxzRvsyKlK42M1Vw5kjB9MMiJHeSCPi7uJatgjkr0oYu3M3kEMlXp8CqpPofHhT6WZAyDpEFOH2+6rvPS8oMkShfKsK5N+gwTJZfyqEnBFxJytzPbAD1a+xy71Jr90pIRjs3Dh8BmI9ERGG+9Znu1U517L9T4XrrQ/iWi1Fpk4PprxBvoTj62ZCKO76MInzYIdpgM+HclZFtmFqF5rZDsN688lSHD5IsrMgcUG0B3t79IjrTEp8XIhtfbWAGzbkptR/QYz6HNF/H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199015)(86362001)(122000001)(38070700005)(82950400001)(82960400001)(38100700002)(33656002)(5660300002)(8936002)(52536014)(2906002)(76116006)(8676002)(66946007)(66446008)(4326008)(66556008)(66476007)(64756008)(41300700001)(8990500004)(55016003)(6506007)(83380400001)(9686003)(71200400001)(7696005)(966005)(110136005)(316002)(10290500003)(478600001)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6vUNjKOTB8ouXpmtjvVmjvb0bEXCKGDEZ4jyvO7rHCg4ZzwWAzxW1gZH20Zf?=
 =?us-ascii?Q?h15Ou6wvbVhBNgeH50NhBkKBmR4g66qYLtNF1yL8E5B828w3PpQqwsaykWXU?=
 =?us-ascii?Q?6NCzZt25rBLzvFvgSWgr0YEFn4cyTw7Cxm3rvEblWOQUMMDtgK4Dag3UQRhS?=
 =?us-ascii?Q?JD38Ft+kp+AuHowA/DOZIVqQML3isfVo2uXxVyAw+oawRghGMHMnHATZV/+b?=
 =?us-ascii?Q?/PrecM5JX7WU87kbgbi8s0Xnn/uY2iM5gnTWMmQ2vAfvUIGox1IhJaWkaUrN?=
 =?us-ascii?Q?NB+Envgrw85p2mFhKQQGj+Biomesb8HkGsPGqMYkuuVS99Bq7A401CkvxHNX?=
 =?us-ascii?Q?rZByK7CGzQSlnyZQ7kTOSvCFyZILSUzKvK1+82KL9GErqpmSQRI3ErxgMsK/?=
 =?us-ascii?Q?ARo+03Co5T4HwzZ3fqCy3xDiv0ApQfH6dfu0O/NkvYHc4uyc+q4pGy+V6K0M?=
 =?us-ascii?Q?snTJjZvggbeKMAx7Le+5RWW3g4ESPm0w4Kr3xG9UvvFtfh6BPhEl0mjWCU8m?=
 =?us-ascii?Q?093UXzfQc/ugDn5XMWcTDQ/HK+bCFJhnTR2gVs7++j04QJxK70BYigdcBM9t?=
 =?us-ascii?Q?d6f8Kg9fNTqqAqmuWzA+fIaLQLryDYGQmhI1Bn1TLaElDO3dd7u6cAJ2kKGh?=
 =?us-ascii?Q?WpAarD3TUDacxCahSHsSLdnDzhWsJ8j98vKw07U37bUWI4h3DmpzSOLu4qwq?=
 =?us-ascii?Q?pweF3CwgHhLVJF7geAHt64Ln7iL9cHb4CNb/NxyNtA9YQRQrql6KDrFjQKcZ?=
 =?us-ascii?Q?PLaNkgOP2NBFEaaLKYMImYAkDcIiE9fEYfqTV3Uzw935q6p5/3FyWqdLfv5F?=
 =?us-ascii?Q?aQBC7P3WbuNMjOcEDoxy0IVkFbab/AlTMBF6iRNXuPqPLfyUjuRC7vZcZrv+?=
 =?us-ascii?Q?6/g/MS10P056p7dVQ851yCYc/eN7a8A7GXVimAEHmL4dWry+qnxFKg5JlLNQ?=
 =?us-ascii?Q?8msuFaVwKjx5cLzXkej9APuPCoepatr5Xs5C66/HwOd7DO/N63ikC+gXyQTG?=
 =?us-ascii?Q?zv55nflSRDbMlSIWvl1S9TKGMKO8d73M1+trYpK/Scho7NyqzGD+QqvXikPq?=
 =?us-ascii?Q?1gV49I/xF/ZpQivKSV6sOJd2JB7Ia5M2BOa0KmMLfYSnol+kiaCoW4hBc74n?=
 =?us-ascii?Q?8RhdkihBuMh9LrMtq4EP8KMexORu1hP83OHisFYG5PNf9ql8Ka8WL44GzjmF?=
 =?us-ascii?Q?ApvmgBAQpFuJAThWeHkr9jAfbz9AO37m8UU8ADjhd/QNCVSTp7k5x4BYr4fT?=
 =?us-ascii?Q?vwpDjTAjOv1N3BWtNabgvpmvVsBAylhVU10vOODKHZRyzpWH+6F6XkBsybYk?=
 =?us-ascii?Q?P6E2PntIU7vNOxOf+Fttvq2Rfrhg8wh5ZMKgfwgOf9NMtMDWBHnlJVGkNno2?=
 =?us-ascii?Q?6pD+ZgUv4qnyx9Pluk/8iSjsXKwgFOPtcATevHRjpKh4UR5KHmThQP2yuAKN?=
 =?us-ascii?Q?FJG/0hVDjWd7bfPIx3PtDNyWGEuIOOH12KUVskf9YtCSmLjgwWdDLy2zFRnR?=
 =?us-ascii?Q?Mb6r1kR0iBulksVEYdAe2uJdKnarhG3l2ggQwTa8br4y3SkMcnf2bwlS7qqM?=
 =?us-ascii?Q?BTAMM+b+wehMAYYxBWNck2L8EOlWmYyuvCd37nFBYQKlZF+0itdBut365FQ3?=
 =?us-ascii?Q?eA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd35da53-5a8e-447a-f2ce-08dafb6bd665
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2023 04:56:20.2955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x09x+lvRXswMHnR8r6IkucGSKRozW2H+oCYh+fxCtmx5Rkr33trmdzKK2WPakJPt1LdTWQBTlO5VAhq40D2ruEJ9kyxobC0nmOo24bw91HU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1410
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk> Sent: Monday, January 16, 2023 1:06 PM
>=20
> If we're doing a large IO request which needs to be split into multiple
> bios for issue, then we can run into the same situation as the below
> marked commit fixes - parts will complete just fine, one or more parts
> will fail to allocate a request. This will result in a partially
> completed read or write request, where the caller gets EAGAIN even though
> parts of the IO completed just fine.
>=20
> Do the same for large bios as we do for splits - fail a NOWAIT request
> with EAGAIN. This isn't technically fixing an issue in the below marked
> patch, but for stable purposes, we should have either none of them or
> both.
>=20
> This depends on: 613b14884b85 ("block: handle bio_split_to_limits() NULL =
return")
>=20
> Cc: stable@vger.kernel.org # 5.15+
> Fixes: 9cea62b2cbab ("block: don't allow splitting of a REQ_NOWAIT bio")
> Link: https://github.com/axboe/liburing/issues/766
> Reported-and-tested-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>=20
> ---
>=20
> Since v1: catch this at submit time instead, since we can have various
> valid cases where the number of single page segments will not take a
> bio segment (page merging, huge pages).
>=20
> diff --git a/block/fops.c b/block/fops.c
> index 50d245e8c913..d2e6be4e3d1c 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -221,6 +221,24 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb=
, struct
> iov_iter *iter,
>  			bio_endio(bio);
>  			break;
>  		}
> +		if (iocb->ki_flags & IOCB_NOWAIT) {
> +			/*
> +			 * This is nonblocking IO, and we need to allocate
> +			 * another bio if we have data left to map. As we
> +			 * cannot guarantee that one of the sub bios will not
> +			 * fail getting issued FOR NOWAIT and as error results
> +			 * are coalesced across all of them, be safe and ask for
> +			 * a retry of this from blocking context.
> +			 */
> +			if (unlikely(iov_iter_count(iter))) {
> +				bio_release_pages(bio, false);
> +				bio_clear_flag(bio, BIO_REFFED);
> +				bio_put(bio);
> +				blk_finish_plug(&plug);
> +				return -EAGAIN;
> +			}
> +			bio->bi_opf |=3D REQ_NOWAIT;
> +		}
>=20
>  		if (is_read) {
>  			if (dio->flags & DIO_SHOULD_DIRTY)
> @@ -228,9 +246,6 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb,=
 struct iov_iter *iter,
>  		} else {
>  			task_io_account_write(bio->bi_iter.bi_size);
>  		}
> -		if (iocb->ki_flags & IOCB_NOWAIT)
> -			bio->bi_opf |=3D REQ_NOWAIT;
> -
>  		dio->size +=3D bio->bi_iter.bi_size;
>  		pos +=3D bio->bi_iter.bi_size;
>=20

I've wrapped up my testing on this patch.  All testing was via io_uring -- =
I did
not test other paths.  Testing was against a combination of this patch and =
the
previous patch set for a similar problem. [1]

I tested with a simple test program to issue single I/Os, and verified the
expected paths were taken through the block layer and io_uring code for
various size I/Os, including over 1 Mbyte.  No EAGAIN errors were seen.
This testing was with a 6.1 kernel.

Also tested the original app that surfaced the problem.  It's a larger scal=
e
workload using io_uring, and is where the problem was originally
encountered.  That workload runs on a purpose-built 5.15 kernel, so I
backported both patches to 5.15 for this testing.  All looks good.
No EAGAIN errors were seen.

Michael

[1] https://lore.kernel.org/linux-block/20230104160938.62636-1-axboe@kernel=
.dk/
