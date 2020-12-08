Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B35C4361B
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 00:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E2CA23A04
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 00:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgLHAa1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:30:27 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:51642 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgLHAa1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Dec 2020 19:30:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607387702; x=1638923702;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=y8ngh/eHJDHVwlWfvE0P2XNtjKaDzrhdtj9WdXWzXa0=;
  b=WcwJKPNnKuRQebtEQq80xd27+MveClgktSSS0eWvGblZ2KtIxJ17r6IA
   Ei7aSXBMjhVlv/lMK9Lrd/K0ph+a9RDpEGQeC1S1wcNIxJv5H3nBuEO6M
   NpHOW20ORysrsX3Qmdvhir1ywdS8pWCHr7eGU4ukCWfdigCNcX74n6atj
   n7dcDLrDs9XvoKc5jPulHkYXc3kZjE9QnLEoKtnLW493sJiKClpXXhMkR
   q9rLDijoxgG5Kqo4WwaNLEdKdFgod8m4a9LMDZt9INknLk/auJXd9hqfZ
   qqG/8I6fu0Qrpmv4oyXxfzEx+ga71dXuZ9v1OLdg6vk8Up8P4JHKYpK45
   w==;
IronPort-SDR: P1H7w1zGkqgFZPNyS3Huf3/G7h7mDnAB8/r+CT71lk5BpeHV2DMzz8yOvBKQuOSORlj9/BTPQD
 FMcYjiytOVtz+xkg/AxI5FlLMNQUbdrdbgkAXevCoxSZ1KJ5RFkkBuNNSFxoh2fuESyIYPc3fi
 tM+YkB4jZ3xK9hJ2qBWxVCJt6hl1KKx9vwC7NQOt6cA6KZkfJp12QxB2tDLthIjkQJqVsHCQeY
 iPFyLzsGe+CpjlAJ/miSpQCKSMPpAOaQmRFp+EhFu+Lf4D3BnOrDYEhJYUiGojc6wH00A7GiWb
 SBU=
X-IronPort-AV: E=Sophos;i="5.78,401,1599494400"; 
   d="scan'208";a="258358227"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 08 Dec 2020 08:33:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFAaVFruJb5+6GYC/e6YibPJsO12dxP32M7+gQV6GzE2EJ/RNh6n7yOXoKJ+HDKTpIL4czkuNzdQB49CFoCVPHCs8uWgUQ6+cP0+8zUdFe5M0dS0JDKkHFpk6CQD9wnAG/PFjMYDPuo1evGIBWX2OqjZUc+0KFmSKiaOH1w//5Ayhzh5T3AW22qkdRKmALcEWoaQyU/+zCbLBPeV9hpYD6vvzCkBKjrf67R5hWjl2leDXUK4FBxt8hepeiVxjbOSJePFAPzi1ldvCI14bTE1ap3PKbATdc7radbrhJD1hvX54/cFHvzywib0Ccokwe+0Jnq1pasNuQEVJqPasiO2Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2/tNl+HUZUXN3CZPrX2GwrCEVAQZYHQBHl22gSvYIc=;
 b=MdSECls4rpfJYONheGSUWjrZ/U3UhX/VMMPlv4dE84BLGnClQksLUb5/yI6XMWLL72j5kJw6AYZuGe9qMPdopKrzq/2ZJAhN2MWg0sa8ZTSA4V1U9dHxAQowOiL6wqwzNEMqZ93j4bK1nZw4zsEdgsgKqt5fhfhk8eHbtTetInKcBspsLR/+xP0Rw81m0CrDLb11DtjhZA/8+EJElfF9Iq7CRVFY5fybkUxZTzfn0AKY0l86Nxb9jpcvtBvraLgJcwQGD29tVrnJRK0A4U/Rlyg+7mHRnaP0IC6XeT8wxwVnd8V9FNQKbpFAR+cVzmQx+KVqtzmx9JfBnt/CTAPxcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2/tNl+HUZUXN3CZPrX2GwrCEVAQZYHQBHl22gSvYIc=;
 b=wZ9z/zzsB9+Y6+FLfySGQM67rQp1Lg1jHc8l9/KIc7+UdB3MBO6sRotz5Re2qcMghXOUeW5rvV8SzEWvTZ3bQmQbuiTWJ5LYTOYJRtZ4i9+UfYfIPws74YhUPnLT1M1G1Byizfc8ici/b27T7YrIUxSllkYtaUa5o+MpMya7SsE=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB7111.namprd04.prod.outlook.com (2603:10b6:610:96::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Tue, 8 Dec
 2020 00:29:19 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 00:29:19 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2] block: Improve blk_revalidate_disk_zones() checks
Thread-Topic: [PATCH v2] block: Improve blk_revalidate_disk_zones() checks
Thread-Index: AQHWt/1VclFb/HqtsE6qBg5aXhh4vA==
Date:   Tue, 8 Dec 2020 00:29:19 +0000
Message-ID: <CH2PR04MB65223742BEE5687703584A55E7CD0@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201111073606.767757-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:1cf3:4043:c21d:e871]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 95af3446-5208-4119-a364-08d89b104dc1
x-ms-traffictypediagnostic: CH2PR04MB7111:
x-microsoft-antispam-prvs: <CH2PR04MB7111262BF5A67C8220D59EF6E7CD0@CH2PR04MB7111.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:159;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fQPEwpu2B+4TwHvA2eEE/2TvnRa7wp49YxL/NkrwPy1RGANiJOiszfgt1YgihNXdwgA/zpj6ch9GimwpDty1i26Wgqq0nII8N3Ge6DXvl1HKpKpxv71e9v9gZkZTYfG8fjY4jNHBZPIZU5o79aRDUDgvA2xrLemuEJhGDuEAKzLF2pHOQ/AOA7HspbzjlYPBZ9Z9H+8auJv+gaHdI+xKAJ+QSAe/bWla2zW5q79DEqSvs+FVucVgNa7vHnjQZ9Fs8N3qCu5lFKMMnmNSQynp4pAfCtnFJ6j7mGZCxeJ7G7JmSPqA++KYWRCB2Bz3zLb6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(55016002)(66476007)(66446008)(33656002)(53546011)(52536014)(5660300002)(110136005)(66556008)(83380400001)(2906002)(66946007)(316002)(8676002)(7696005)(64756008)(8936002)(186003)(91956017)(6506007)(86362001)(71200400001)(478600001)(76116006)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rN5xZswqA2I4MSeUk96xts0bZ32if6P1ISOFexOdyOHSvQ01q6AIZ6fq2H7R?=
 =?us-ascii?Q?/pY84NkXsTa54oMZOf5Sw90qTN6Kee/LH4wozT8x9OyAs4nI0ZXSTtmhdCqH?=
 =?us-ascii?Q?WHea7L+EZHLn4G+YTWFRQWiXsunV8MFVlVgUAfnGJSVSnVBPjVzH6HvPfAuB?=
 =?us-ascii?Q?wz/yvf3LV2BQL/wzLbtG1JQ6xLWb/xCb9FYMpDnRZu4oH3g94rx3lY4K9ND9?=
 =?us-ascii?Q?nSA//5bkOkoXa87CM6PKSs6KlBjXroNNlch4C2Gqn4um3/zbx65v08aIK/L/?=
 =?us-ascii?Q?3QOIrnCOSajQN+/5G1FxaUS9TmQs79uV2hksmEY0b6RnGHq8p1uS3iHAtH5U?=
 =?us-ascii?Q?BIWovpuquSdWZrwiH+C199FVK3lN89yy1ppHZFsvTf+gmwz4q34fcV5Hu67A?=
 =?us-ascii?Q?HqI6J77aOS94MhoVp79mBWtpbyE7GHL27/NlMDIpyf3KEvuViaN2lFqq6moc?=
 =?us-ascii?Q?gWcQt0+gfnUTGnpBQb5UlCRNjzo704pax3JrC4y3OikYmWdBG/f5KBSdRh0K?=
 =?us-ascii?Q?hu0oFomx3Axkv8dVlkDWSz9HanzXZR1oO34klvLJpVpQx5GF8Veo3mokaLUL?=
 =?us-ascii?Q?9gPEGqU50n7rgQPxKuFaWcXUVzmvQzO5ss93ViCrP/sFY/gaS8brtTCgxMYQ?=
 =?us-ascii?Q?Vc/itannEy3KRd8EoJk+RwA9kaVKHF1QvgI8JvzkDktzEO+lg+Ub+oFe3gnM?=
 =?us-ascii?Q?+Tv+xDGdwxnuqel9ih6AdztC5yc06NOs+IvRBWMCphUiV8mJOOoJ2Vcj10lH?=
 =?us-ascii?Q?taA48a/cMxdnuDVVIKyKl/tM5krpXx8LK9oGUo/0veQrWpMsEER8JY2sAH+L?=
 =?us-ascii?Q?/Vbt5T1fhzMMgWucI/CZQwRSJXrNEjOQo0hKTlzTCeK1RqXuTDQs9QEndWdg?=
 =?us-ascii?Q?Qrnh21u0uG09nvBA1ln7xwvMFw86pBrqtE/Hsz2sbw0lw+KgptJF7lDv9JAJ?=
 =?us-ascii?Q?/1fNhz79gSrF1Z2GtpftqfzpiuPJFnQALPWXTM/sf4iqZBITblKQYNEbEzdB?=
 =?us-ascii?Q?U6kEZTLGCof6Y1des6/DbdWLDl1QrEpX1jD1CkgvUTR+/aAK4NQ/f5aEdtLs?=
 =?us-ascii?Q?7pmrKM/l?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95af3446-5208-4119-a364-08d89b104dc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 00:29:19.7968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H3P71xqhl9PTvcEe2PeN9DuQcV24VMNtU9xs5mg3dJ4IC8tcHd4DFTAfQ1zWKXYBv+nb8JrRIlA5/q2TMBn40w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7111
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
=0A=
Jens,=0A=
=0A=
Ping ?=0A=
=0A=
=0A=
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
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
