Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DACDC63777
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 02:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B1D620857
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 02:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KygHQ33T";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mDumvB6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgLACOp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 21:14:45 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17510 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgLACOo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 21:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606788883; x=1638324883;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=tfCp1rpDCS2jSblH3oGtjlzh+qoFoeYOI0mLwS2Bog4=;
  b=KygHQ33T/SX5097U3vnnjJoUKCZGLG3xdf7tUOWVT9MH7/IkbjLNr1Mz
   q7McNBjgu3JIwyuJ3IwmKy53+ia+92p+IssatjO033zLZiU87fnb0X+kE
   s4M6wjX9PEer8ixs4uer06oR29lNYwBFleon7d0h5w4BCUpjF6G9LTUHv
   Z66XUzJP3YwoIj3tM0sc5rZHLr0x3WeuDlDQuSbX4KsprY2z/LFXvXgQj
   0g2MB2kOT8oZKzGcx5sZ9WvkNuMHxp+pnBUWjJ9MsVsOV149unslG25lR
   smtIYD0T3TBlG9ueQQvQu8GKFqoodVutxPhw185OTbA3QrnvStwJ1+QzQ
   A==;
IronPort-SDR: kgM5Sz2Xitw4nJKd+QNrjmdJqfGj3maHa0z0R2rBZTdLlbXdJBxnhhFIlqnrDyC7m+o8Heg1OM
 +izo5rJ1mqVqRZwCphEdtO+v5OepfAtRtW1cf2JQN1lm3+iJ7G+9qRxhYAPO/L1ySLmCtVYo+T
 L/Lq0vhi0YDvrtnLpBGPgBrluHXuYJ/H7jRngf3xA6XOuMBNa26/AB3c/sotjvsXYzqbmsn28M
 OWfBUszpU9si+AR5JogdfdBxZzZ+AAUujFfm+j5iuYcLrYHbHwqjQa2Mej7pYsPqK7NHiCmkyg
 KPo=
X-IronPort-AV: E=Sophos;i="5.78,382,1599494400"; 
   d="scan'208";a="153806356"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 10:13:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRry5v/RsaoaP4mLI8p8MKtLDWe5TJefMEaY30i7jSFu6GMe6kMmr/t4JQQEcFtMW2XtWrjO/+qPymLwt7urB6nFWIT4XG9NXXqXBNA/D6Lytq75ku57U4nxHTm9wSqLbyLUbHnyA42zu2+HWtKBovbtrcztjz0cNqqcVfADHY3o6SF4+C3ER/wjY2auQFhwMnle74IKKIyV0AXPvfZJEvbH5/31ikCcSicGpPRkDZKru1dy+QAiENPHIckH4wnziGG313zAPxGgC9+HB2bQED6hifLEq/7dK1jiq9Bsbau3aI8sKOXpxRAbvAOaBtGJXVp33CccPRgOjkRQRS3Ulg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGYWZr65iExI+N8hLTWp0jgaoaXD7h84JKtONRefkjc=;
 b=VFu+ZCSsxOvuIUWFWtzy3LB9oPm5v8n69ttJo3lrPe3t1SQVgsbdBjFb+IWK9QGNUfrRzp7VOXhw8qDREABBQYtkkxqfWU+/bR3Z01zKh3+tsiLEw/83YENR/9EcU3avxE/R9/x8lvFL67NL0aWde3bavkEIUWtR6Dt+N5IM4SUQmW8aqvfeGqn5UV8wGcQT61u1eF4/IrJsDJY+8hrc+zp9X6oFolc9yynYYTWybIifzmfpbLpxJFP7FpPeNbPNjnUB6LCfAJvpMEr1RPyA6rHWUslsD47jHx/dKwFjWAnT3N8rXhwCIRzBBQdEiofxLBNIUfn6euiIMfkvbt/YGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGYWZr65iExI+N8hLTWp0jgaoaXD7h84JKtONRefkjc=;
 b=mDumvB6dK/kj5Xn22rTFsXh4jLhA3VqjsoCve/uwK5x8lT54PswCmMxllzST6ey23KNXCVPbqldQUzRWoAPnCD6jsCDdshYwRiSdg7UL2+fkPInNITa5TxT9hQlL9NJ9Q1q3tQPrwShKgzeid1WQ6u+ysAmpyE8r7QW1zOg7HYE=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB7125.namprd04.prod.outlook.com (2603:10b6:610:a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Tue, 1 Dec
 2020 02:13:37 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Tue, 1 Dec 2020
 02:13:37 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2] block: Improve blk_revalidate_disk_zones() checks
Thread-Topic: [PATCH v2] block: Improve blk_revalidate_disk_zones() checks
Thread-Index: AQHWt/1VclFb/HqtsE6qBg5aXhh4vA==
Date:   Tue, 1 Dec 2020 02:13:37 +0000
Message-ID: <CH2PR04MB652241B5608023E0DD0A7B13E7F40@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201111073606.767757-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 18e205f8-1580-40da-9df6-08d8959eb6c2
x-ms-traffictypediagnostic: CH2PR04MB7125:
x-microsoft-antispam-prvs: <CH2PR04MB71259053B5680B2303225199E7F40@CH2PR04MB7125.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OG59MUHeYq59Pi+ULIgqEXVNZ0UMoDGWU/jenQ0bjtP7HFrm5W+XUpjEr+uEXfyxuIedovxOF/oiIvcS+rIKhgowX5Ik3pWBfXPRmaJCwXJZTwKQppNTeTdPn7LuonuJGvYiCy4kilju1UZoL2OM3g5jsfXdX6S4fa6ugQ8880cA+PYIuaQsjNEHI5Z42lJBMujfvREqStrU4TnQVHWYtftwPN+h0/bj+oQFhF9ZhTjmW5esH+kKD3jOUplMxWgqNOAxXSTtrZ2Ym5fZPBaUnMijKBySlEpJ5Bs4jnq/88jjOUVaU5/T+39MTIXdGouz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(316002)(6506007)(8676002)(53546011)(8936002)(26005)(186003)(33656002)(7696005)(2906002)(83380400001)(91956017)(66446008)(66476007)(66556008)(9686003)(55016002)(71200400001)(66946007)(478600001)(76116006)(64756008)(86362001)(110136005)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?71ntd8E90vkIXBvktMGSXYVqoMPkVhm9PWWvNcZmIeZi5b0iYnGCRXwXn2Eo?=
 =?us-ascii?Q?GtzkgvtjfkTCIyL/Z4gzUdJtL9m8WkHrc7Yt5Wgucnv8vWFf2RRumL+NyrCS?=
 =?us-ascii?Q?kE6TBSwu436aGkTAP2W6n3JPqCrT6+5xvzx0W3uFCKeTozGA/Djtff/YiMv8?=
 =?us-ascii?Q?er9FVsEjuwK6fbOmSj/fD3dlVcQHQ50HCp0OkpX51Ls/Iktpk/NEOx433LBv?=
 =?us-ascii?Q?q6Fsrax8mdhvQXCUEfzFP+hegpserme+PbB9E8gaOyfwP2V9iNAZRlKPq51e?=
 =?us-ascii?Q?YVRScMFxDzjC6eBO+KCTdnl0RTQ0aZO3pabbDf+1as0oUu68O5AXatD/h36g?=
 =?us-ascii?Q?UMVRYGdBR2dhwec/GVd/SqRlQlnxGImo8FjfFvcITrDp0POB/5Xl/0NagN2W?=
 =?us-ascii?Q?WHPTLKxBm8/xlIuyOu10HiSo/b9Bk1tOynlb0+37o5vnDe5ow7RvtmvtfbC3?=
 =?us-ascii?Q?50kZNLoityeV/Xt50rytxx4/AWZEpMzDlqqflp9vfsT9ac0LlXxFoFMOjyNr?=
 =?us-ascii?Q?7qL8ZqOx7RD1AphEjM4p6RSpecueKC3mbsq8tTZMiHR3DdhkNJ+6Eez192OS?=
 =?us-ascii?Q?BBjT+MHXt58vZ5Fx8B35vlxnDD2mZYfzakOMjfaUnLGFI5LEA30734ZzEWRI?=
 =?us-ascii?Q?y0TsN4GcSC4OGoE3leMCQOjquEMdQIjGJx5k2mLlK9GQh3s6Lmps7l67oy0l?=
 =?us-ascii?Q?HYbby8MT4ThgPaP4KG3liVRefSXzhft2RIIy5m6Fg3kHqV6NP1BE5sw3gCPr?=
 =?us-ascii?Q?kTi0GCp3130wtimJH8zUukQBy7ADtE/vBfnpAh8Z/mEdkiYIIvgl6um/+u4L?=
 =?us-ascii?Q?bC5JobfwsP8yuAX6mebN7h5Z83vYaqcC3MAyVUK3Oy/ZVwm/Rn16kuB0dgEf?=
 =?us-ascii?Q?/pvlQf7FrdXkgHGs5ODUrWFMGR5+Oa4niLPRAmVnvt0xYocgTdxrIO7DF75L?=
 =?us-ascii?Q?0hHdlgsWVbsQKUSzTDe5KXKzLlgS9NeddUn+YT3wyoFwvExLU1xf+fhF8DdT?=
 =?us-ascii?Q?I8N/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e205f8-1580-40da-9df6-08d8959eb6c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 02:13:37.5707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zSA7xm/4TYAwnbIpnFqg9IkIFd0PCEq82YNYtjHVyRc4EkdtSv+Jfu4UCxEKv5P2Z9+kGAM5S4fdLtMHS3fA2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7125
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/11/11 16:36, Damien Le Moal wrote:=0A=
> Improves the checks on the zones of a zoned block device done in=0A=
> blk_revalidate_disk_zones() by making sure that the device report_zones=
=0A=
> method did report at least one zone and that the zones reported exactly=
=0A=
> cover the entire disk capacity, that is, that there are no missing zones=
=0A=
> at the end of the disk sector range.=0A=
> =0A=
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> ---=0A=
> Changes from V1:=0A=
> * Add checks on the number of zones reported=0A=
> * Check the reported zone coverage only if zones are successfully=0A=
>   reported=0A=
> * Reword the commit message=0A=
> =0A=
>  block/blk-zoned.c | 16 +++++++++++++++-=0A=
>  1 file changed, 15 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
> index 6817a673e5ce..7a68b6e4300c 100644=0A=
> --- a/block/blk-zoned.c=0A=
> +++ b/block/blk-zoned.c=0A=
> @@ -508,15 +508,29 @@ int blk_revalidate_disk_zones(struct gendisk *disk,=
=0A=
>  	noio_flag =3D memalloc_noio_save();=0A=
>  	ret =3D disk->fops->report_zones(disk, 0, UINT_MAX,=0A=
>  				       blk_revalidate_zone_cb, &args);=0A=
> +	if (!ret) {=0A=
> +		pr_warn("%s: No zones reported\n", disk->disk_name);=0A=
> +		ret =3D -ENODEV;=0A=
> +	}=0A=
>  	memalloc_noio_restore(noio_flag);=0A=
>  =0A=
> +	/*=0A=
> +	 * If zones where reported, make sure that the entire disk capacity=0A=
> +	 * has been checked.=0A=
> +	 */=0A=
> +	if (ret > 0 && args.sector !=3D get_capacity(disk)) {=0A=
> +		pr_warn("%s: Missing zones from sector %llu\n",=0A=
> +			disk->disk_name, args.sector);=0A=
> +		ret =3D -ENODEV;=0A=
> +	}=0A=
> +=0A=
>  	/*=0A=
>  	 * Install the new bitmaps and update nr_zones only once the queue is=
=0A=
>  	 * stopped and all I/Os are completed (i.e. a scheduler is not=0A=
>  	 * referencing the bitmaps).=0A=
>  	 */=0A=
>  	blk_mq_freeze_queue(q);=0A=
> -	if (ret >=3D 0) {=0A=
> +	if (ret > 0) {=0A=
>  		blk_queue_chunk_sectors(q, args.zone_sectors);=0A=
>  		q->nr_zones =3D args.nr_zones;=0A=
>  		swap(q->seq_zones_wlock, args.seq_zones_wlock);=0A=
> =0A=
=0A=
Jens,=0A=
=0A=
I did not see this patch queued up in your tree.=0A=
Could you consider it please ?=0A=
=0A=
Thanks !=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
