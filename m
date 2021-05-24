Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6B6C47080
	for <linux-block@archiver.kernel.org>; Mon, 24 May 2021 00:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 904F361168
	for <linux-block@archiver.kernel.org>; Mon, 24 May 2021 00:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbhEXAb6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 May 2021 20:31:58 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:5723 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbhEXAb4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 May 2021 20:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621816229; x=1653352229;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=RI9oCbwA5f4pwVJuuZt2gkxvSfnqovtMXPaaOOB8XZA=;
  b=gA8ncCI0luViCYlN0k/nedxFwFdbRlnUJTEarX8XOmTN03RPjQXRWtQL
   MhC2qgc2IG9vugmPkIvag3+J1Q2o01Z5lYFZfwrljPqjJaPVvoLKc3FBR
   Xf/U/Cc+xux7jtPajtoEFtNYF8b944r+EMYNBOb26M8BbCTCrUW2xWNTq
   hNTNXFvA5XY2Jyy0N41+lXBbbNmGLSxLkJL9exVNv1ucSQPlQ1zU6D58k
   0t+k/Vxyii4NGkxzAierjmjwa71aHyW1uUigtOKVWFKg6cfwJ32eIvku2
   xD1Z7q0ViTocyaeytC8ciSBGUkZa4MaFJOxaDdgsNzEXtMsbVyE6zYVX4
   Q==;
IronPort-SDR: j93Pi67IOKkdlXM0AdDfmSgSjycNgZ1N1/rkotQDbMM54HWsou1JhuVZTS1ZFUQeAG3IYhSYLJ
 UqViG8NA8bcOz8+HbV0AXlXMevWfJz6S935gcUZySYMTj/APk718vAKkzqasFmuG+dKwwilJ3B
 GRy//zzQLm5l9/cz5YSXmUJadpa4isAd3p74FZOKDkMX0GwstUEAMEDrEiJYn23hb4Fo5AAiUN
 FBq6/h3eGjh+ZVQzb6c/dqFbqknSiq9f4abqm8sgKvjBw1VoIOJU6swIaACy+oLFH+hRG0by6L
 /3s=
X-IronPort-AV: E=Sophos;i="5.82,319,1613404800"; 
   d="scan'208";a="168496145"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
  by ob1.hgst.iphmx.com with ESMTP; 24 May 2021 08:30:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUbxozzphxNXoaj/IhclWaM+H4KvmtsbGLucFb0x+3u2zgIupAiQEAiRW2eqmQJITXoNr1eKiaCZPPH8Mc+xkfpa2HfO7Ud7+qhD5FxaHlvldlffBmljQqz+87MqRO5BIm0nb2/pHd801cC3GXGwLMNMosM42v7PwwOIcnqnDl3FYEKDEBHCqAWalHdE0bBRnHwB3ZJ1YVEu2m23CUAnJpBRIHjLC0TH1FsxD2Oxw3SmUOmbo69BrZi6rxMnY3VPLt2TQE8KcLs/vN1j0zjYZor1UViHauBP9/l+xIi5JfS3mAHZiIcl8IfzDc/uvl8Em8hqsciZ6t89Ri1syqwBzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxEqu0vq+5HHDpvkhhMsydOVnIdWkKnKiQrfZpdI19g=;
 b=SFUbDg4Br4htKP38mAzOMOSrOCMIxJ/ZCcab3vJN4zPjrk8pCW+zNrPV5xQuj7SLl8lea2e7hXZ42qCsKIrfWL0ZYkLYCbWN68tv1FmpiEEzPX7Nb/BNm5Y+GNUHcvg3sPyhZYZtxtaENfOuyy7/upTru0g0WqRFpH1PaaR+Lvdtetc4AhNh38+679Eb3x18j3lSPuHarkqjS5ODjXlaarBIXMwjLfuvmIhyUTJOKEvvPSn5Cp66Wj3ensty5pjfvBRtQsjetQJTl0JAQEOSc+CDjCqVNo/bj7gVLaNAKSkSFiOITf0AsUQnKjTvaiz+xAb7EdDaRhsQ1evjVNtm9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxEqu0vq+5HHDpvkhhMsydOVnIdWkKnKiQrfZpdI19g=;
 b=OARfpVLl/crFZBUUPBBXFMiTKkPvPGw0jVENMK6H8xoymD+2rPxPZKaUU5ErytWQgFU41IqOds2ZYXGyLnlSJAst1ooiQSXVOv2/XHZQrQnndmsUR+0weQVnlipRNH3qlmuuQbotBEaMWShxZMA/LtV3lPI7OYL/A+VW8nkzSmY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7680.namprd04.prod.outlook.com (2603:10b6:a03:324::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Mon, 24 May
 2021 00:30:26 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 00:30:26 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 01/11] block: improve handling of all zones reset
 operation
Thread-Topic: [PATCH v3 01/11] block: improve handling of all zones reset
 operation
Thread-Index: AQHXTe2XQQmdlggDyka6lOSgElB11g==
Date:   Mon, 24 May 2021 00:30:26 +0000
Message-ID: <BYAPR04MB49655F14C3C880B508D4B90886269@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210521030119.1209035-1-damien.lemoal@wdc.com>
 <20210521030119.1209035-2-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dedb1ccc-cfec-4a91-287e-08d91e4b2049
x-ms-traffictypediagnostic: SJ0PR04MB7680:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB7680547C08303927465B2DF686269@SJ0PR04MB7680.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nvUbKFgik6q50c0nIf4/9yWlS7GcDWr+q3ZDgRu+uJnGKv2tNxU8IWITY8vGB4/Z0V1fpWuPlqZR05WNfclejOKizqEnJTtLmhcQahKp+Zu7o05Y35oXvbSoFN6pgBgIuxSYUb+WF7BgBX6xNTPwUlvv/u8gqWoGUWnyJMJa+hdiwQqbjsfOgkSUl2V4she0J3x6AOEDfquDj3vIpOl+adv+BjkjLXBOj8c8FvnxnBxIBKEVB9jWTozxcdQXCJSBQMLtlZoHiCQvPhpf9mDZ1bF1VcMYX0UvDnc3F22ErJIxLke60c2ClVNrgeZfTqtf2CBG4FhB0E3FDIzhouPQ0ZIvV5caccvpfBJnWvwqxOb65tI1vmLrmUQSr5PcVCGPUrGq9MIwAmWgUlZju2QRJ8qBuFGOHI/BmrSwPuY6whVZhK5r7LEprR6yWCPpwc+eKJJMhjSaWgiacU0xYd7cN9ZRJX5/E8Y4qXilYs+o01Exx1aRbwyv6Fhu/F9Ie5WWx+B7KmjEPQxODumMt1zgh4WT6nQpU+EMmjPOk2Lsg9a6EbJfsunp6H3tZcBX9c635AV2IMq/VrrhzDJywtUu2063s6e8cubXo5ls5wGzIrM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(122000001)(38100700002)(76116006)(55016002)(52536014)(83380400001)(8936002)(26005)(8676002)(66446008)(66476007)(64756008)(9686003)(110136005)(53546011)(478600001)(71200400001)(86362001)(5660300002)(2906002)(66946007)(7696005)(6506007)(33656002)(316002)(66556008)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+W6051WwPk9dHhhDMzenmeIOZ7gvY0wGV1CL5N1t8molyBWsK07s2NmaNb1F?=
 =?us-ascii?Q?cs0kPmcBs32ZJnn3wFIYhgwMIf+LLyDpwNLnHvmxJjmloQ+PvTO9XG0x50r8?=
 =?us-ascii?Q?YDmbZe7JDg76gzSefUuMdyCt7gdje4Uu1d7CyuwaW96KZnQvTDNfX7fUu9LC?=
 =?us-ascii?Q?IwEkTReoEP596SIdM4yalFzkjREKqAoQqKYkaUhTUBBBLpogMMCK4GhYTAtK?=
 =?us-ascii?Q?RJqyd4ErT732//scSTrpXTZWQ47zb10/as40ORDAnWxnw/IFnzksfD6DIJKU?=
 =?us-ascii?Q?Yl/5yvmPmDmYEUrLddp7NtyoEgjBkKtL5RWUMTNXrTSOuMxCEjpQBa3/0Gb1?=
 =?us-ascii?Q?OCoE39BcsYSTOlel4Sr6SZgBkoIvIdYCkAwvE8LwfCrSl//Y61XlpHcuQs1S?=
 =?us-ascii?Q?457mUGiFstIhTEmFklkECWbnmVJq6Dz/+kppniNnd0vPMQybPwa3c8BgnYS5?=
 =?us-ascii?Q?7rADf9Rb691tssFqMB99QYztFDeI/jbB1Go/c4xLwLg4uzD5WS77FJNkMVBl?=
 =?us-ascii?Q?NPh24gIvjmct2CjYI7SkNJilykydyQ+FriSEOZQuYzqN+MKC+yxPZafP29L1?=
 =?us-ascii?Q?5y6cUIC+rhcfRD1/H9Xr1ak1JYUrYxhdeT6BAfFz8obZx90zhzMCrGOm8W41?=
 =?us-ascii?Q?TlYf1YL360C3uPP17viyi5U9V7VR96hUwaYxbNACgR6dmb4GviVRNYc4Vq1w?=
 =?us-ascii?Q?vntWrqPjw0cemQAlQ8r81aius+yPVSitJbG4tfGtd8aQ3V4AH/oZmKPfEI4U?=
 =?us-ascii?Q?MEH+aQqoReIHNW4FCl6NTLmuZG88jP71XLLyWTq8q/RyToODYQCpcavPtyBt?=
 =?us-ascii?Q?W/XUSfnlnrS+XACkn5tXbQR7LD10UQYY6fzoeSqdjj8rG+iv7/vwTNckWuID?=
 =?us-ascii?Q?XJr1sxbNz7g0bJbe2sPUfVWyZOxtHmoYBdSMgIIGYY5YywxubO9kc9kJMjmF?=
 =?us-ascii?Q?SrucKNHhnnfwMAbssJcx/Fszgql4qirqB6qAV7L0SrToFfZC9dXNwNp1vXAJ?=
 =?us-ascii?Q?ZsAt6xNwEFfTTktQyGPfiNSsIJ8JHFM6qLsbUSz9Z1XG9knF57gDwYJ63Hc7?=
 =?us-ascii?Q?kv6gfnhTlRwihyVXZE+relXk942N8JvhVU+S7H2mvq2rISkoTmUMRTwkNeFe?=
 =?us-ascii?Q?8sJaQZNbbTDB9MIxhvfHkb094RCyh5tHsoRIKCtEGrqTOLfID3IjKm92mDFR?=
 =?us-ascii?Q?NmlmLlA5Ms7w44nm9ERJzDJkkIQcYY7h/LmqBE58LjfJBFwCyZFmX2pwv+mU?=
 =?us-ascii?Q?p3BpJeDVerEYWCd7HwmVi/k2tH3bY1k5dSZIN5ikxm90XbLazHeK0tIzPn5i?=
 =?us-ascii?Q?SZ7tHHcWPRZny2ToGUBHX7HI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dedb1ccc-cfec-4a91-287e-08d91e4b2049
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2021 00:30:26.0892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lI2VBMHOHaQCTcIwj3HIWggefu4+KTx7o3WePhQPxQVD1KX0LsuvvwVekYIUADQW6uYD1tLHCaJCzfnHrt4RLd9QT/WoNO3UNxggJGLC9mE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7680
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/20/21 20:01, Damien Le Moal wrote:=0A=
> +static int blkdev_zone_reset_all_emulated(struct block_device *bdev,=0A=
> +					  gfp_t gfp_mask)=0A=
> +{=0A=
> +	struct request_queue *q =3D bdev_get_queue(bdev);=0A=
> +	sector_t capacity =3D get_capacity(bdev->bd_disk);=0A=
> +	sector_t zone_sectors =3D blk_queue_zone_sectors(q);=0A=
> +	unsigned long *need_reset;=0A=
> +	struct bio *bio =3D NULL;=0A=
> +	sector_t sector;=0A=
> +	int ret;=0A=
> +=0A=
> +	need_reset =3D blk_alloc_zone_bitmap(q->node, q->nr_zones);=0A=
> +	if (!need_reset)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	ret =3D bdev->bd_disk->fops->report_zones(bdev->bd_disk, 0,=0A=
> +				q->nr_zones, blk_zone_need_reset_cb,=0A=
> +				need_reset);=0A=
> +	if (ret < 0)=0A=
> +		goto out_free_need_reset;=0A=
> +=0A=
> +	ret =3D 0;=0A=
> +	while (sector < capacity) {=0A=
=0A=
Garbage value of sector variable used in above comparison ?=0A=
If so consider initializing at the time of declaration.=0A=
=0A=
> +		if (!test_bit(blk_queue_zone_no(q, sector), need_reset)) {=0A=
> +			sector +=3D zone_sectors;=0A=
> +			continue;=0A=
> +		}=0A=
> +		bio =3D blk_next_bio(bio, 0, gfp_mask);=0A=
> +		bio_set_dev(bio, bdev);=0A=
> +		bio->bi_opf =3D REQ_OP_ZONE_RESET | REQ_SYNC;=0A=
> +		bio->bi_iter.bi_sector =3D sector;=0A=
> +		sector +=3D zone_sectors;=0A=
> +=0A=
> +		/* This may take a while, so be nice to others */=0A=
> +		cond_resched();=0A=
> +	}=0A=
> +=0A=
> +	if (bio) {=0A=
> +		ret =3D submit_bio_wait(bio);=0A=
> +		bio_put(bio);=0A=
> +	}=0A=
> +=0A=
> +out_free_need_reset:=0A=
> +	kfree(need_reset);=0A=
> +	return ret;=0A=
> +}=0A=
=0A=
