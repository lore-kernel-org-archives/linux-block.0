Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B99AC433DB
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 01:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 306D764DF1
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 01:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhA2BWT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jan 2021 20:22:19 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:16147 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhA2BWR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 20:22:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611883336; x=1643419336;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=blyiqzMEBOfFzjx0vh3Fs4PnCtZ9+BO4yjsdSJJ4ykc=;
  b=Xpk+SkBlz41Pz6y/jIqgy2XZ5PFxnBWTHVBr3rWTf09gic2kKKT11++I
   IpJevrwYgeLITtx44cLqjK4mnM8Yt5b4LR2yzQ0oIJbIWbRDQWl7nWfc+
   PGoeplznCsSquqcmxpTCkB0trcLPWZ9syU4MwLNjw6o5UjSEJWqWt8nZi
   7ItDBmmUlYx0r31A1nNjriXLBcMMp58TXdG0/TM0rbz02szfvuIRIxZOc
   nzpz3k8jdJfH8xLEybeRVJPeN+TUDweZ2dS8L9o1CTG0yq+zj0PGWDAmn
   6113mvzcEJPWATQZ2KOVV2TianEgpeLpmSCVbgyV5BTHNxLTI75siPXfl
   g==;
IronPort-SDR: 88pnH7Ec60/SslnnLGJo0FhRrzQSc2tyE0fc0OCmLB2jqx8Ub9dQxHyVVYEJ3ToXdG4vFOBE/m
 XW0sqtlA3EeJ9JyI20yV1IG2xBaz6lR3er32ENgBZYlaHi7ZvNAAvSX5fVHq9o2OkzLvdRNBiD
 s7zlziVqSMgNf0pmABEefrFRiyzyECLRs6seQ3VrS2rQSFkrZ5+Cx/fayhHkS7m/fLafOb8lOI
 sPRkKjg40ogInQg5c1MJ/I4MHEa/hIsBQ7Td3ygdHXlyT1jMUN1iarvuKlCeOBVumfLU85pxst
 zRA=
X-IronPort-AV: E=Sophos;i="5.79,384,1602518400"; 
   d="scan'208";a="159771331"
Received: from mail-sn1nam02lp2056.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.56])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2021 09:21:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWFLywkr5HAObYdSPMitml2K9lIAhjH4Qt2nWuhdkPDFJogszRZmfzl5l2EKX++YEgneeexp9tP4vpbD06BXjsnAhD4SppxsAvDRHpQGPpYCAzzFeNV1G+Yu1qWIcvHB2Wk7ViFvVdNuUlXMaxDVWFNZ9JiXpn7Jpg1OBYzRRna/Mu46POB4V21y/tP1s0gsjIW1o9TSlWImVogpiZz2AeiP4487bVvE5YNQW5FrxMtukeg6UYyHATVh+cY+YJ84L7MpT1GiIN8SuATdpoOHIfTVbHKFf6rYc6Q3YXmoqzDWGzyRTxmlRIhQ5jQTEsMD4l4wDI+SoKhHW46kaP6zOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWNkC9jYZT40VN/TjhTcptKZW54cxygdKKUrl1S9AtI=;
 b=S4EUCcWp4sofc0bxqMZESQzs+twNyKElYoVO8s0n7dajpeBJkm31ZxzpLiHq+U8ZgT6re3Ewy9dwuGwi9MhPrScOIL3Z4IaK39CbplVJa5i0CndDq9q0yX6IjjFoatS+HkL/x1XWbcrjx+7mLSkV38DLHOP87VlAgVEX+BVeeyf0WZyJqKBXbNYBGdpKW80EjuyMmc1eaFCdGrDbKrqpAuye7hGtan60IQ9cdMGlk46ENR/bgMpjcVECZLJry3+H3axlbNPlbh4vbSbPfjX7CkJAdYbVoOHKK5TlAteqzk0K4ODRsxXL+peEkiuJIv8AqiaBSK72kb2RJcaeuIuzUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWNkC9jYZT40VN/TjhTcptKZW54cxygdKKUrl1S9AtI=;
 b=ImZOFN9CMqozTEVSDOPFUJ55knx9K0RDhyOvWu258B+/f5xDYYg96ggqbBkCamRVE3OqsoOF4KU9xQSRNlk99Ch3xXBL65rhMlvoQ8M1H/4t2bsLV9DcqA21o4ZyoS0iMFjIclJp/ibwKqRR4TAYSOcq5ssCTpV+SrQgxWN7Lz0=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6733.namprd04.prod.outlook.com (2603:10b6:208:1e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 29 Jan
 2021 01:21:07 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%7]) with mapi id 15.20.3784.017; Fri, 29 Jan 2021
 01:21:07 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>,
        "hare@suse.de" <hare@suse.de>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "pavel.tide@veeam.com" <pavel.tide@veeam.com>
Subject: Re: [dm-devel] [PATCH 1/2] block: blk_interposer
Thread-Topic: [dm-devel] [PATCH 1/2] block: blk_interposer
Thread-Index: AQHW9ZpcJE05P/jO2k2LywRNymQ1Yw==
Date:   Fri, 29 Jan 2021 01:21:07 +0000
Message-ID: <BL0PR04MB6514943D2E257F88778C389CE7B99@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <1611853955-32167-1-git-send-email-sergei.shtepa@veeam.com>
 <1611853955-32167-2-git-send-email-sergei.shtepa@veeam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: veeam.com; dkim=none (message not signed)
 header.d=none;veeam.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:47a:7b5a:7dfa:1b1e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e0dcf58d-daf5-4a2e-0cbf-08d8c3f42745
x-ms-traffictypediagnostic: MN2PR04MB6733:
x-microsoft-antispam-prvs: <MN2PR04MB6733E95CF4F44CED2B64875DE7B99@MN2PR04MB6733.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9OAXTCxIJ+RGMnJJvg3S7GtAhXq4weLfoqDMg+kWaA4Dr/P2WjUGexIDmvSc5Pcwlsekf161Cq0pOzR7nKjyMBm+qtgxmLUs2j1/UJ2QkuEsTZECdUHQcanaE0jXrDD4jBM642VjcljEwPcW76i3NVC6YyhX3VgEYkjq+eZPmTJj2RS+l/0RZEhRNPYP2yGSamiQCpBXOL46ngaS+BJweQMDA3hzctEEfsW0V2hXYXvogCPd/hE3yucf+ltaU5z9dtp/Qo5F9R6lXuHxevCKeEUdncPJBRsodmjYP912FgJZdt3gZ6FCx7wOT4gd26pb+f7AlAoS3W1IJcmSwCW2s26lyVdVF0SY2tytAthv9ARxJTEieCB57dIwTny1BK420jPFvSEHlPjWoFQ6cz84bOy1n+dBPrEdy82j9CoaM2C5lAtLIwwOxDxAUOG24nH4UWNubU9s8xaLyV6KVBnqSQ0DXizjOtI+BVB5FHWZnuU3zRgXc2jkxOgdKsc73NiZuXYv83ult+BLQwElZCKI4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(53546011)(6506007)(71200400001)(2906002)(86362001)(4326008)(83380400001)(9686003)(55016002)(8676002)(316002)(110136005)(7696005)(5660300002)(52536014)(91956017)(76116006)(66946007)(478600001)(66446008)(66476007)(66556008)(64756008)(33656002)(186003)(30864003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Jno2RAw+BHJkwIncEIXHLZxFY1GbOeMFx3sYAfEhrwRAo8/Amf8jW3kqcXx8?=
 =?us-ascii?Q?eUen1WlUiwyULcPoI6bVqn8QSbMAGIMxhxvafqVSvQ+i/XKyGMz6wLQjWHBA?=
 =?us-ascii?Q?lZ5ryfLfEAnSCMW4zEEGdbGovAGWyjxVsTic62uEGoYwa4upDbDYVxUlzdsI?=
 =?us-ascii?Q?krWbnQs1iW42VVgNNtI7ZxcI84s3UQH+bz7aW2VvYIuyIE0uFKIFfNP/EhgL?=
 =?us-ascii?Q?YpGoBhLknXy16HK6JEnjBM67f+hIuTT8nlKyIqQBWBv31JiV9wD8TJmCipDg?=
 =?us-ascii?Q?lNoARSIhYd6WZ7Kf6hlZdgmzBlabtr63d3e0a/g5CwGknMo5UosdVRzPVRo9?=
 =?us-ascii?Q?nEAZQ3f0ModiS0F7hBNWAr+ePPOCHKgJCOIHDIZEiZIfhzMmw62htMXicgCQ?=
 =?us-ascii?Q?gpyTJdVIWuF+3fBBxsMlkqJR7/yT+Y7LiJQD0tTutCL62tD1/tvzUsF4Msfc?=
 =?us-ascii?Q?CFQ0g4eVRsl+m4Ok0IHO7K9sqAe5LjmNJj7GXNNltZbeq92lhskk5T+CNMUP?=
 =?us-ascii?Q?1bgHS2E/a/tCHclL8fS65bSqB/JCgcs6aLrsIm3jYh/q1HofIs9uhlnWXFOl?=
 =?us-ascii?Q?NrLUihNxSEh0ZdvUgSxk7hbKmtxtMBJeVDjFbARYoye1HRyaVNLOQygFc0Fa?=
 =?us-ascii?Q?hAr0Av6Kcyiof2qrmYmhcgjEV0O+Ja0oaXXWIk3SnbB/hJ5Z2bmRk4aA0Xa0?=
 =?us-ascii?Q?UCFZfqegM3T6novkfT8akd4AvCABazY+Go6x8xeOkNAeyJDQ9RdFFVMITCct?=
 =?us-ascii?Q?Pjng6oBXW50UHveYT6oN51sYpvLXoBKeySzrv3CaTYF3vgjJfPzMPeLEN5G+?=
 =?us-ascii?Q?P8OWxhDeWOPLMP7PzUfNMppYjQtwcWkhx1Kw2beeR7qIVTMnfyCkmlYy3dbL?=
 =?us-ascii?Q?bBRgFYG5YJvZ1DWCd91gp4x0lnRJondrMicOms3p4IQjX3qkpLcoB0c97enk?=
 =?us-ascii?Q?+vSkBPGzxqHnyFznWjLgysrV0OPMBsjS/B4EScFk9Zf21PgTPgmBaXm9+Pn4?=
 =?us-ascii?Q?2VmpghMT32V0O++j/94OIg+KRuuw8dyui/lVD7DOtm11kohHgwugNe5uYxk5?=
 =?us-ascii?Q?m1aabxmBG49PxZrRBVB3GGPW4uXYxz69ORON/9hskChn+GqhMnmZ1naHnjmv?=
 =?us-ascii?Q?owC+sCF/uyYO03MrRWd6uFTGhOqPBVb0Iw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0dcf58d-daf5-4a2e-0cbf-08d8c3f42745
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2021 01:21:07.0601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +WIrbQ2NFWJ34JVY448Pu2lo5FYMd6x/siGjlwid5FxIcTG+cfl4vfZF0E8LYeCXuJ7aNf95biT1GttUMCXkkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6733
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/01/29 2:23, Sergei Shtepa wrote:=0A=
> The block layer interposer allows to intercept bio requests.=0A=
> This allows to connect device mapper and other kernel modules=0A=
> to the block device stack on the fly.=0A=
> =0A=
> changes:=0A=
>   * new BIO_INTERPOSED bio flag.=0A=
>   * new function __submit_bio_interposed() implements the interposers=0A=
>     logic.=0A=
>   * new function blk_mq_is_queue_frozen() allow to assert that=0A=
>     the queue is frozen.=0A=
>   * functions blk_interposer_attach() and blk_interposer_detach()=0A=
>     allow to attach and detach interposers.=0A=
=0A=
The changelog should not be part of the commit message. If you need a chang=
elog=0A=
for a single patch, add it between the commit message end "---" and the pat=
ch=0A=
stats. git will ignore that part.=0A=
=0A=
> Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>=0A=
> ---=0A=
>  block/bio.c               |  2 +=0A=
>  block/blk-core.c          | 29 ++++++++++++++=0A=
>  block/blk-mq.c            | 13 +++++++=0A=
>  block/genhd.c             | 82 +++++++++++++++++++++++++++++++++++++++=
=0A=
>  include/linux/blk-mq.h    |  1 +=0A=
>  include/linux/blk_types.h |  6 ++-=0A=
>  include/linux/genhd.h     | 19 +++++++++=0A=
>  7 files changed, 150 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/block/bio.c b/block/bio.c=0A=
> index 1f2cc1fbe283..f6f135eb84b5 100644=0A=
> --- a/block/bio.c=0A=
> +++ b/block/bio.c=0A=
> @@ -684,6 +684,8 @@ void __bio_clone_fast(struct bio *bio, struct bio *bi=
o_src)=0A=
>  	bio_set_flag(bio, BIO_CLONED);=0A=
>  	if (bio_flagged(bio_src, BIO_THROTTLED))=0A=
>  		bio_set_flag(bio, BIO_THROTTLED);=0A=
> +	if (bio_flagged(bio_src, BIO_INTERPOSED))=0A=
> +		bio_set_flag(bio, BIO_INTERPOSED);=0A=
>  	bio->bi_opf =3D bio_src->bi_opf;=0A=
>  	bio->bi_ioprio =3D bio_src->bi_ioprio;=0A=
>  	bio->bi_write_hint =3D bio_src->bi_write_hint;=0A=
> diff --git a/block/blk-core.c b/block/blk-core.c=0A=
> index 7663a9b94b80..07ec82d8fe57 100644=0A=
> --- a/block/blk-core.c=0A=
> +++ b/block/blk-core.c=0A=
> @@ -1032,6 +1032,32 @@ static blk_qc_t __submit_bio_noacct_mq(struct bio =
*bio)=0A=
>  	return ret;=0A=
>  }=0A=
>  =0A=
> +static blk_qc_t __submit_bio_interposed(struct bio *bio)=0A=
> +{=0A=
> +	struct bio_list bio_list[2] =3D { };=0A=
> +	blk_qc_t ret =3D BLK_QC_T_NONE;=0A=
> +=0A=
> +	current->bio_list =3D bio_list;=0A=
> +	if (likely(bio_queue_enter(bio) =3D=3D 0)) {=0A=
> +		struct gendisk *disk =3D bio->bi_disk;=0A=
> +=0A=
> +		bio_set_flag(bio, BIO_INTERPOSED);=0A=
> +		if (likely(blk_has_interposer(disk)))=0A=
> +			disk->interposer->ip_submit_bio(bio);=0A=
=0A=
Why do you check again blk_has_interposer() here ? That is checked already =
in=0A=
submit_bio_noacct() and the interposer attach/detach cannot run without the=
=0A=
queue frozen. So I do not think you need to check again. If you do, then yo=
u=0A=
definitely have a race condition here.=0A=
=0A=
> +		else /* interposer was removed */=0A=
> +			bio_list_add(&current->bio_list[0], bio);=0A=
> +=0A=
> +		blk_queue_exit(disk->queue);=0A=
> +	}=0A=
> +	current->bio_list =3D NULL;=0A=
> +=0A=
> +	/* Resubmit remaining bios */=0A=
> +	while ((bio =3D bio_list_pop(&bio_list[0])))=0A=
> +		ret =3D submit_bio_noacct(bio);=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
>  /**=0A=
>   * submit_bio_noacct - re-submit a bio to the block device layer for I/O=
=0A=
>   * @bio:  The bio describing the location in memory and on the device.=
=0A=
> @@ -1057,6 +1083,9 @@ blk_qc_t submit_bio_noacct(struct bio *bio)=0A=
>  		return BLK_QC_T_NONE;=0A=
>  	}=0A=
>  =0A=
> +	if (blk_has_interposer(bio->bi_disk) &&=0A=
> +	    !bio_flagged(bio, BIO_INTERPOSED))=0A=
> +		return __submit_bio_interposed(bio);=0A=
=0A=
OK. I *think* that this is to handle stacked devices, right ? Otherwise, th=
is=0A=
condition does not make much sense. Why not just:=0A=
=0A=
	if (blk_has_interposer(bio->bi_disk))=0A=
		return __submit_bio_interposed(bio);=0A=
=0A=
So at least adding some comments here may be good.=0A=
=0A=
>  	if (!bio->bi_disk->fops->submit_bio)=0A=
>  		return __submit_bio_noacct_mq(bio);=0A=
>  	return __submit_bio_noacct(bio);=0A=
> diff --git a/block/blk-mq.c b/block/blk-mq.c=0A=
> index f285a9123a8b..924ec26fae5f 100644=0A=
> --- a/block/blk-mq.c=0A=
> +++ b/block/blk-mq.c=0A=
> @@ -161,6 +161,19 @@ int blk_mq_freeze_queue_wait_timeout(struct request_=
queue *q,=0A=
>  }=0A=
>  EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait_timeout);=0A=
>  =0A=
> +=0A=
> +bool blk_mq_is_queue_frozen(struct request_queue *q)=0A=
> +{=0A=
> +	bool ret;=0A=
> +=0A=
> +	mutex_lock(&q->mq_freeze_lock);=0A=
> +	ret =3D percpu_ref_is_dying(&q->q_usage_counter) && percpu_ref_is_zero(=
&q->q_usage_counter);=0A=
> +	mutex_unlock(&q->mq_freeze_lock);=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +EXPORT_SYMBOL_GPL(blk_mq_is_queue_frozen);=0A=
=0A=
Maybe move this change to its own patch preceding this one ?=0A=
=0A=
> +=0A=
>  /*=0A=
>   * Guarantee no request is in use, so we can change any data structure o=
f=0A=
>   * the queue afterward.=0A=
> diff --git a/block/genhd.c b/block/genhd.c=0A=
> index 419548e92d82..d3459582f56c 100644=0A=
> --- a/block/genhd.c=0A=
> +++ b/block/genhd.c=0A=
> @@ -30,6 +30,7 @@=0A=
>  static struct kobject *block_depr;=0A=
>  =0A=
>  DECLARE_RWSEM(bdev_lookup_sem);=0A=
> +DEFINE_MUTEX(bdev_interposer_mutex);=0A=
>  =0A=
>  /* for extended dynamic devt allocation, currently only one major is use=
d */=0A=
>  #define NR_EXT_DEVT		(1 << MINORBITS)=0A=
> @@ -2148,3 +2149,84 @@ static void disk_release_events(struct gendisk *di=
sk)=0A=
>  	WARN_ON_ONCE(disk->ev && disk->ev->block !=3D 1);=0A=
>  	kfree(disk->ev);=0A=
>  }=0A=
> +=0A=
> +/**=0A=
> + * blk_interposer_attach - Attach interposer to disk=0A=
> + * @disk: target disk=0A=
> + * @interposer: block device interposer=0A=
> + * @ip_submit_bio: hook for submit_bio()=0A=
> + *=0A=
> + * Returns:=0A=
> + *     -EINVAL if @interposer is NULL.=0A=
> + *     -EPERM if queue is not frozen.=0A=
> + *     -EBUSY if the block device already has @interposer.=0A=
> + *     -EALREADY if the block device already has @interposer with same c=
allback.=0A=
> + *=0A=
> + * Disk must be frozen by blk_mq_freeze_queue().=0A=
> + */=0A=
> +int blk_interposer_attach(struct gendisk *disk, struct blk_interposer *i=
nterposer,=0A=
> +			  const ip_submit_bio_t ip_submit_bio)=0A=
> +{=0A=
> +	int ret =3D 0;=0A=
> +=0A=
> +	if (!interposer)=0A=
> +		return -EINVAL;=0A=
=0A=
Is this really necessary ? If some user of this function has interposer =3D=
=3D NULL,=0A=
that caller needs debugging...=0A=
=0A=
> +=0A=
> +	if (!blk_mq_is_queue_frozen(disk->queue))=0A=
> +		return -EPERM;=0A=
=0A=
Why not do the queue freeze here ?=0A=
=0A=
> +=0A=
> +	mutex_lock(&bdev_interposer_mutex);=0A=
> +	if (blk_has_interposer(disk)) {=0A=
> +		if (disk->interposer->ip_submit_bio =3D=3D ip_submit_bio)=0A=
> +			ret =3D -EALREADY;=0A=
> +		else=0A=
> +			ret =3D -EBUSY;=0A=
> +		goto out;=0A=
> +	}=0A=
> +=0A=
> +	interposer->ip_submit_bio =3D ip_submit_bio;=0A=
> +	interposer->disk =3D disk;=0A=
> +=0A=
> +	disk->interposer =3D interposer;=0A=
> +out:=0A=
> +	mutex_unlock(&bdev_interposer_mutex);=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +EXPORT_SYMBOL_GPL(blk_interposer_attach);=0A=
> +=0A=
> +/**=0A=
> + * blk_interposer_detach - Detach interposer from disk=0A=
> + * @interposer: block device interposer=0A=
> + * @ip_submit_bio: hook for submit_bio()=0A=
> + *=0A=
> + * Disk must be frozen by blk_mq_freeze_queue().=0A=
> + */=0A=
> +void blk_interposer_detach(struct blk_interposer *interposer,=0A=
> +			  const ip_submit_bio_t ip_submit_bio)=0A=
> +{=0A=
=0A=
The interface is weird. Why not passing the gendisk ?=0A=
=0A=
> +	struct gendisk *disk;=0A=
> +=0A=
> +	if (WARN_ON(!interposer))=0A=
> +		return;=0A=
=0A=
Same comment as above. This should not be necessary.=0A=
=0A=
> +=0A=
> +	mutex_lock(&bdev_interposer_mutex);=0A=
> +=0A=
> +	/* Check if the interposer is still active. */=0A=
> +	disk =3D interposer->disk;=0A=
> +	if (WARN_ON(!disk))=0A=
> +		goto out;=0A=
> +=0A=
> +	if (WARN_ON(!blk_mq_is_queue_frozen(disk->queue)))=0A=
> +		goto out;=0A=
> +=0A=
> +	/* Check if it is really our interposer. */=0A=
> +	if (WARN_ON(disk->interposer->ip_submit_bio !=3D ip_submit_bio))=0A=
> +		goto out;=0A=
> +=0A=
> +	disk->interposer =3D NULL;=0A=
> +	interposer->disk =3D NULL;=0A=
> +out:=0A=
> +	mutex_unlock(&bdev_interposer_mutex);=0A=
> +}=0A=
> +EXPORT_SYMBOL_GPL(blk_interposer_detach);=0A=
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h=0A=
> index d705b174d346..9d1e8c4e922e 100644=0A=
> --- a/include/linux/blk-mq.h=0A=
> +++ b/include/linux/blk-mq.h=0A=
> @@ -525,6 +525,7 @@ void blk_freeze_queue_start(struct request_queue *q);=
=0A=
>  void blk_mq_freeze_queue_wait(struct request_queue *q);=0A=
>  int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,=0A=
>  				     unsigned long timeout);=0A=
> +bool blk_mq_is_queue_frozen(struct request_queue *q);=0A=
>  =0A=
>  int blk_mq_map_queues(struct blk_mq_queue_map *qmap);=0A=
>  void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_qu=
eues);=0A=
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h=0A=
> index 866f74261b3b..6c1351d7b73f 100644=0A=
> --- a/include/linux/blk_types.h=0A=
> +++ b/include/linux/blk_types.h=0A=
> @@ -227,7 +227,7 @@ struct bio {=0A=
>  						 * top bits REQ_OP. Use=0A=
>  						 * accessors.=0A=
>  						 */=0A=
> -	unsigned short		bi_flags;	/* status, etc and bvec pool number */=0A=
> +	unsigned int		bi_flags;	/* status, etc and bvec pool number */=0A=
>  	unsigned short		bi_ioprio;=0A=
>  	unsigned short		bi_write_hint;=0A=
>  	blk_status_t		bi_status;=0A=
> @@ -304,6 +304,8 @@ enum {=0A=
>  				 * of this bio. */=0A=
>  	BIO_CGROUP_ACCT,	/* has been accounted to a cgroup */=0A=
>  	BIO_TRACKED,		/* set if bio goes through the rq_qos path */=0A=
> +	BIO_INTERPOSED,		/* bio has been interposed and can be moved to=0A=
> +				 * a different disk */=0A=
>  	BIO_FLAG_LAST=0A=
>  };=0A=
>  =0A=
> @@ -322,7 +324,7 @@ enum {=0A=
>   * freed.=0A=
>   */=0A=
>  #define BVEC_POOL_BITS		(3)=0A=
> -#define BVEC_POOL_OFFSET	(16 - BVEC_POOL_BITS)=0A=
> +#define BVEC_POOL_OFFSET	(32 - BVEC_POOL_BITS)=0A=
>  #define BVEC_POOL_IDX(bio)	((bio)->bi_flags >> BVEC_POOL_OFFSET)=0A=
>  #if (1<< BVEC_POOL_BITS) < (BVEC_POOL_NR+1)=0A=
>  # error "BVEC_POOL_BITS is too small"=0A=
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h=0A=
> index 809aaa32d53c..8094af3a3db9 100644=0A=
> --- a/include/linux/genhd.h=0A=
> +++ b/include/linux/genhd.h=0A=
> @@ -134,6 +134,14 @@ struct blk_integrity {=0A=
>  	unsigned char				tag_size;=0A=
>  };=0A=
>  =0A=
> +struct blk_interposer;=0A=
=0A=
This is not needed.=0A=
=0A=
> +typedef void (*ip_submit_bio_t) (struct bio *bio);=0A=
=0A=
This hides the definition of the submit callback for no good reasons that I=
 can=0A=
see. Since the callback has a simple interface, I would prefer this to be d=
ropped.=0A=
=0A=
> +=0A=
> +struct blk_interposer {=0A=
> +	ip_submit_bio_t ip_submit_bio;=0A=
> +	struct gendisk *disk;=0A=
=0A=
If you fix the interface of the detach function, you should not need this f=
ield.=0A=
=0A=
> +};=0A=
> +=0A=
>  struct gendisk {=0A=
>  	/* major, first_minor and minors are input parameters only,=0A=
>  	 * don't use directly.  Use disk_devt() and disk_max_parts().=0A=
> @@ -158,6 +166,7 @@ struct gendisk {=0A=
>  =0A=
>  	const struct block_device_operations *fops;=0A=
>  	struct request_queue *queue;=0A=
> +	struct blk_interposer *interposer;=0A=
>  	void *private_data;=0A=
>  =0A=
>  	int flags;=0A=
> @@ -346,4 +355,14 @@ static inline void printk_all_partitions(void)=0A=
>  }=0A=
>  #endif /* CONFIG_BLOCK */=0A=
>  =0A=
> +/*=0A=
> + * block layer interposer=0A=
> + */=0A=
> +#define blk_has_interposer(d) ((d)->interposer !=3D NULL)=0A=
=0A=
Please make this an inline function.=0A=
=0A=
> +=0A=
> +int blk_interposer_attach(struct gendisk *disk, struct blk_interposer *i=
nterposer,=0A=
> +			  const ip_submit_bio_t ip_submit_bio);=0A=
> +void blk_interposer_detach(struct blk_interposer *interposer,=0A=
> +			   const ip_submit_bio_t ip_submit_bio);=0A=
> +=0A=
>  #endif /* _LINUX_GENHD_H */=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
