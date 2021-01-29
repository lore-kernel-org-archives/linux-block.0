Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935CEC433E0
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 01:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F80D64DFB
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 01:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhA2Br1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jan 2021 20:47:27 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:50891 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhA2BrZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 20:47:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611884844; x=1643420844;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Tx3rGRVvP+BDVmTn+bt3WpLVJDHnFkGRVnrDjH/1REM=;
  b=JRrEfaDfrXEfc0Xx3P839Qe3ODBu6pxggZagjoV7MlReeYzkqmsQJJVe
   SNaspaogs8oajc5ZlffNDH/Z7FWv35K8mCDwwCzeAvJL1PZT6Y6Ud6/1W
   RoiM+8mbeRgSsuotJeH7tf+jST5Cf4OBf5P16dY+2u6BgL01GjzgM/xpV
   LAcA48dZrnwVVsHDUssA9jPxkUKWfCVeAKG7J3fX+XSZXWvH0Vrpjt+E2
   xpCFwztzVyguANlzwFusST2Je2ZnVHjfHqq5ZKD1/Zon9am/tqSEhdYYv
   S68K9WL6vZ/2/hhG0DWZJB9gaFsMLmim2y1qocp87LemLU7wWcdpEC88P
   w==;
IronPort-SDR: m8gQ32k+VgyFmAkzh1UOeWXZthpPLCKBijq/uJDdVsLZ8NQq+uQet9tLb5W4pjyd3IvknZgFE0
 uQu6XOp3ohkAY5Z+O9nxRktlG7JnH/brtkczeJA6jqNSDS76FdhcVpQREiEwZatvVYi6uzAqe9
 2D2EZNkR5Ek1/ozGT4jm9ee2ywusI6ttfWyMmjh5Qfsx/jBCQAfGXSbMAFoMS6yVsVN3hjXDcX
 HlI0T0hEAgKBcDPPHJ9qrhVvC9MFB2ZMVFLSCMUF5oeu9ELALTvJkWHdCNKGsAh2pfb6qh91nZ
 rzE=
X-IronPort-AV: E=Sophos;i="5.79,384,1602518400"; 
   d="scan'208";a="159773025"
Received: from mail-sn1nam02lp2054.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.54])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2021 09:46:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhtTDyBT+AdqzScvLAS5kIZT8ZCfZX0mkjupdxzEGkvWadUdzhNPRD5ox+5LL8h/W9vVb3lY1uPtbgFqSt/gIiuwh3dRQsgSA6xBgP6sRwq8HO3VJL+dhiNExlOnElRi79ORe93z2YKsIWWkNT3gAHDjfFrHDXkve29/p9YH/AHnbcXmdIqzyoBUXqT67KpL/LU57hPrnqu6SbWlZ1cK0FJqjiyYcA9Mu2zS8eQAc9IZ9Fn8op4sMZoOf7zrcXYBzFWJfKAqAffjTzQajFNlD89CGKdEtA6Hm0nt+s1Xw4rfD8cOT+evJRzfWXHOa+eIhQBtYXczduq2xz0gvxIr7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9MZnIkIN2kL22lMXQY3gWp569aWLZp7QZiTNQRRFDw=;
 b=cM+cl93oBrwTj8IaCVdCMr7/wEslPlkKUKLsschKzvgNQv1jKZ3KfTGAaGIsmGQYfQWHVkAD3AZ1g/aUMeGItbtsXM1IT+6GJBLDc9rWSvWIbyR/r9EgcVRfBD2rf85oePAyusGF+cL37Fg7JPKwrN5wK2cwyT9C1zbptn9TrnGaSK7gZnrVAjPBlMTzJDVpfpUgVLvccfvhy1JhpGwTk4G3jBGbroF65a6fBX6xlUFmR9h3+x6uADLLAL4fkXJYabSAEazn4D+SSUaq1LDGdHmdyxy55u0a74mf0s5Qrr1c0NQR5NQ6aix+s7/WX22omikIIS9O5pM6kcZ/aJpDNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9MZnIkIN2kL22lMXQY3gWp569aWLZp7QZiTNQRRFDw=;
 b=XRPME8AR3ZOZ9vzLCe+PeXU8MGJsGg/FLjhqcwFIT9RfvHKm/bo9oiE76Pgju1GGuDxB8zUVYIDNAAsm6qR6oSFi4WCfg0vve6vegeWLweDMk4lv8jBQLWjttgxM2uMARJGg5wYlJpDlNeeiNn98xPrG21vZzELPixCb8z2kcMI=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6445.namprd04.prod.outlook.com (2603:10b6:208:1a2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 29 Jan
 2021 01:46:11 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%7]) with mapi id 15.20.3784.017; Fri, 29 Jan 2021
 01:46:11 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>,
        "hare@suse.de" <hare@suse.de>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "pavel.tide@veeam.com" <pavel.tide@veeam.com>
Subject: Re: [dm-devel] [PATCH 2/2] [dm] blk_interposer for dm-linear
Thread-Topic: [dm-devel] [PATCH 2/2] [dm] blk_interposer for dm-linear
Thread-Index: AQHW9ZpW4Iaa29J5rk6ywazmgLTyFQ==
Date:   Fri, 29 Jan 2021 01:46:11 +0000
Message-ID: <BL0PR04MB65142B7F22234EFC710148C8E7B99@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <1611853955-32167-1-git-send-email-sergei.shtepa@veeam.com>
 <1611853955-32167-3-git-send-email-sergei.shtepa@veeam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: veeam.com; dkim=none (message not signed)
 header.d=none;veeam.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:47a:7b5a:7dfa:1b1e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2a2e3377-137a-4885-39aa-08d8c3f7a821
x-ms-traffictypediagnostic: MN2PR04MB6445:
x-microsoft-antispam-prvs: <MN2PR04MB64452D63B9E966B86D26E6E4E7B99@MN2PR04MB6445.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sW9hN7Bbuy/spxTOjC52j34HjKzLz4ZVnxv6myIRsPgQzsm2WF6KHzDMZi6xvTv2Py17lFgwXSzkIc6urKighitXRk5dfcgZkjNfxXdn51roXupZTe028Te/faXb9Y0N4SW/E2okqnZ4UHjzmvmJ64cgrUTJjTZvPAPyBT4i7p5cxEKpXdqm5g68NW2VAG+qmodJD9+sQ+MrXDbZtni60JU5AOOwlQSE2OVVBcSCGtYCai8dUxy9cMcF1ztZhIUltvJ+23Dh8sWpUjyJnkD9qLB5XLN1dExhDUU+ac0dcuL4W7RtnrkQeRmN6bLiaOyCzHoH626WKgfRUG1qRAGHodojpISpXOnI1tzSpv4nbRrGY113Nemv5WVkGSmjcOHLWwbuLaevBcIN7hOFmTtqZElaeaLxpJ0fEFG16Tv40K6dYQHnQK3J9sjAUQJi/qFD6LaRQn7FBKvsNwGQs3+Rv2JKflTaQV+WsTDFRs0L6z1195rLtFCi8RU8tHnL39V9rPmT7f3913PdgyE6H7rcfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(4326008)(71200400001)(2906002)(7696005)(110136005)(9686003)(83380400001)(55016002)(478600001)(66446008)(8676002)(64756008)(66476007)(66946007)(66556008)(76116006)(8936002)(5660300002)(53546011)(52536014)(4001150100001)(30864003)(91956017)(33656002)(6506007)(186003)(86362001)(316002)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?aGV/JDoIM3MY6bIjAxMAL1CqzfqNyTwAq5hS39uVjNGvL2lczYHILy/PiV3u?=
 =?us-ascii?Q?DrSndyfEMeQeqLd+06BVAlaiaTQy5lgqFkmFXZ290dgP+tCKjgkn1BKFyCkN?=
 =?us-ascii?Q?8mMkXuu9/tdasDgVSwSivjvgStK2FO8NXm13S9obc6sIvcZdbqfkAUcLj//Z?=
 =?us-ascii?Q?MM1LD7B40ZdsZUMXODmBy+mahgMQBiOH977EdZXPvqYdZwZ4Dm15SUCkZjtx?=
 =?us-ascii?Q?df84sOK1rFJD/GxSiOWTrQWR4NyaWlWgzPDZVrDXJGRJfLCHYz97D1RkMzAo?=
 =?us-ascii?Q?ao6CRxlwmEYVVg3xLntCGyZ7zPwGb7r1PLdD4KvoTZJLz4fJ7J3+aepYpaKR?=
 =?us-ascii?Q?z5cTzxj2OfmzNUAtnI2Zb6EOdxSm05DeK+6jBZFTVdqtwt0AqrQRce2IPcgi?=
 =?us-ascii?Q?eCrLyua/FwzEsw+RjCuZjDXmw2H9jI8CC9KSvwooPotNLzRZXjMQlAcCggyr?=
 =?us-ascii?Q?T9c31zKPjhZ3MFCXo6zs2vhgbp6M/gMfIc2AG6fweCNl8YCPvU+lcqQZ82sD?=
 =?us-ascii?Q?Ad3swAtbOe4/V0OdLpoX+jNJswdaB/8GNqwVRNubE5F2z/IMNrckYsiHMGLt?=
 =?us-ascii?Q?n8TJvgKlFDjpQsR59F8YAAGr4DxGpjn9FyWWLM9Fuybg6kmweqhrNGeDNdRy?=
 =?us-ascii?Q?a/xcDRMyFXXg9PMiwGwTZTtbUTF7bQ0VAADEcWYZb8H10Wfk6XBGct1BC4Bo?=
 =?us-ascii?Q?YT2FmWGX0G/JKQZyoUbP9PZ85NIek6idvk76/p5No/+/H7PH4ZHWFcPUcZxP?=
 =?us-ascii?Q?gFbnAjKLjE3O7qW2PCESep44EMe9H/mVohtuG2iydTBB1z6rGuiA0R8shcnW?=
 =?us-ascii?Q?sg3rTcAssEmeCNe2Cdq2ixH+4dB23AWUsnH3HyxiI8mP+7a8HFCJ7rLjDqqF?=
 =?us-ascii?Q?RS0qrBmC258WiGLWkfwGETIwuS5+soYEIWs/KSeU0+xdQsbofCJRhBIlte87?=
 =?us-ascii?Q?aiig+T5sQIwvIHm18uw177cyl8PSm48hKyW4qmxXaNoeb2z1jDyumqHrZplM?=
 =?us-ascii?Q?nvxy0UVDEgLCKHnHcVztZhm7bTlWlMHjiCMQrS3fve2QAt2D3IxuMCz28aHW?=
 =?us-ascii?Q?cwHAA2mT0OQNm8g2rRfg05TIPc+jTlzRn9I62XP7DPsngqprVqNqdio/nZid?=
 =?us-ascii?Q?fo6f6urpy5Fg49U7jvLCJKTNy0rT9HO26Q=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2e3377-137a-4885-39aa-08d8c3f7a821
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2021 01:46:11.6624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m9bH1Xi4QlVEz/lDB0vDSvrVVsTB7vfLB8VPkObCpdPMIgqvrvlMJiDgfscKsyHw5M8/FmV126f28ClY1m7A4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6445
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/01/29 2:23, Sergei Shtepa wrote:=0A=
> Implement a block interposer for device-mapper to attach=0A=
> to an existing block layer stack. Using the interposer,=0A=
> we can connect the dm-linear to a device with a mounted=0A=
> file system.=0A=
> =0A=
> changes:=0A=
>   * the new dm_interposer structure contains blk_interposer=0A=
>     to intercept bio from the interposed disk and interval tree=0A=
>     of block devices on this disk.=0A=
>   * the new interval tree for device mapper.=0A=
>   * the dm_submit_bio_interposer_fn() function implements=0A=
>     the bio interception logic.=0A=
>   * the functions dm_interposer_attach_dev() &=0A=
>     dm_interposer_detach_dev() allow to attach and detach devices=0A=
>     to dm_interposer.=0A=
>   * the new parameter 'noexcl' allows to create dm-linear to device=0A=
>     with an already mounted file system.=0A=
>   * the non_exclusive parameter in dm_target structure - it`s a sign=0A=
>     that target device should be opened without FMODE_EXCL mode.=0A=
>   * the new ioctl IOCTL_DEV_REMAP allow to attach dm device to=0A=
>     a regular block device.=0A=
=0A=
Same comment about changelog as in the previous patch.=0A=
=0A=
> Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>=0A=
> ---=0A=
>  drivers/md/dm-core.h          |  46 +++-=0A=
>  drivers/md/dm-ioctl.c         |  39 ++++=0A=
>  drivers/md/dm-linear.c        |  17 +-=0A=
>  drivers/md/dm-table.c         |  12 +-=0A=
>  drivers/md/dm.c               | 383 ++++++++++++++++++++++++++++++++--=
=0A=
>  drivers/md/dm.h               |   2 +-=0A=
>  include/linux/device-mapper.h |   7 +=0A=
>  include/uapi/linux/dm-ioctl.h |  15 +-=0A=
>  8 files changed, 493 insertions(+), 28 deletions(-)=0A=
> =0A=
> diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h=0A=
> index 086d293c2b03..0f870b1d4be4 100644=0A=
> --- a/drivers/md/dm-core.h=0A=
> +++ b/drivers/md/dm-core.h=0A=
> @@ -13,7 +13,7 @@=0A=
>  #include <linux/ktime.h>=0A=
>  #include <linux/genhd.h>=0A=
>  #include <linux/blk-mq.h>=0A=
> -=0A=
=0A=
whiteline change.=0A=
=0A=
> +#include <linux/rbtree.h>=0A=
>  #include <trace/events/block.h>=0A=
>  =0A=
>  #include "dm.h"=0A=
> @@ -109,6 +109,9 @@ struct mapped_device {=0A=
>  	bool init_tio_pdu:1;=0A=
>  =0A=
>  	struct srcu_struct io_barrier;=0A=
> +=0A=
> +	/* interposer device for remap */=0A=
> +	struct dm_interposed_dev *ip_dev;=0A=
>  };=0A=
>  =0A=
>  void disable_discard(struct mapped_device *md);=0A=
> @@ -164,6 +167,47 @@ struct dm_table {=0A=
>  	struct dm_md_mempools *mempools;=0A=
>  };=0A=
>  =0A=
> +/*=0A=
> + * Interval tree for device mapper=0A=
> + */=0A=
> +struct dm_rb_range {=0A=
> +	struct rb_node node;=0A=
> +	sector_t start;		/* start sector of rb node */=0A=
> +	sector_t last;		/* end sector of rb node */=0A=
> +	sector_t _subtree_last; /* highest sector in subtree of rb node */=0A=
> +};=0A=
> +=0A=
> +void dm_rb_insert(struct dm_rb_range *node, struct rb_root_cached *root)=
;=0A=
> +void dm_rb_remove(struct dm_rb_range *node, struct rb_root_cached *root)=
;=0A=
> +=0A=
> +struct dm_rb_range *dm_rb_iter_first(struct rb_root_cached *root, sector=
_t start, sector_t last);=0A=
> +struct dm_rb_range *dm_rb_iter_next(struct dm_rb_range *node, sector_t s=
tart, sector_t last);=0A=
> +=0A=
> +/*=0A=
> + * For connecting blk_interposer and dm-targets devices.=0A=
=0A=
Is this comment about the callback or the structure ? I think the latter, s=
o it=0A=
is in the worng place. Please also add a comment for the callback definitio=
n=0A=
explaining what it should be doing.=0A=
=0A=
> + */=0A=
> +typedef void (*dm_interpose_bio_t) (void *context, struct dm_rb_range *n=
ode,  struct bio *bio);=0A=
> +=0A=
> +struct dm_interposed_dev {=0A=
> +	struct gendisk *disk;=0A=
> +	struct dm_rb_range node;=0A=
> +	void *context;=0A=
> +	dm_interpose_bio_t dm_interpose_bio;=0A=
> +=0A=
> +	atomic64_t ip_cnt; /*for debug purpose*/=0A=
> +};=0A=
> +=0A=
> +struct dm_interposed_dev *dm_interposer_new_dev(struct gendisk *disk,=0A=
> +						sector_t ofs, sector_t len,=0A=
> +						void *context,=0A=
> +						dm_interpose_bio_t dm_interpose_bio_t);=0A=
> +void dm_interposer_free_dev(struct dm_interposed_dev *ip_dev);=0A=
> +int dm_interposer_attach_dev(struct dm_interposed_dev *ip_dev);=0A=
> +int dm_interposer_detach_dev(struct dm_interposed_dev *ip_dev);=0A=
> +=0A=
> +int dm_remap_install(struct mapped_device *md, const char *donor_device_=
name);=0A=
> +int dm_remap_uninstall(struct mapped_device *md);=0A=
> +=0A=
>  static inline struct completion *dm_get_completion_from_kobject(struct k=
object *kobj)=0A=
>  {=0A=
>  	return &container_of(kobj, struct dm_kobject_holder, kobj)->completion;=
=0A=
> diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c=0A=
> index 5e306bba4375..2944d442c256 100644=0A=
> --- a/drivers/md/dm-ioctl.c=0A=
> +++ b/drivers/md/dm-ioctl.c=0A=
> @@ -1649,6 +1649,44 @@ static int target_message(struct file *filp, struc=
t dm_ioctl *param, size_t para=0A=
>  	return r;=0A=
>  }=0A=
>  =0A=
> +static inline int dev_remap_start(struct mapped_device *md, uint8_t *par=
ams)=0A=
> +{=0A=
> +	char *donor_device_name =3D (char *)params;=0A=
> +=0A=
> +	return dm_remap_install(md, donor_device_name);=0A=
> +}=0A=
> +static int dev_remap_finish(struct mapped_device *md)=0A=
> +{=0A=
> +	return dm_remap_uninstall(md);=0A=
> +}=0A=
> +=0A=
> +static int dev_remap(struct file *filp, struct dm_ioctl *param, size_t p=
aram_size)=0A=
> +{=0A=
> +	int ret =3D 0;=0A=
> +	struct mapped_device *md;=0A=
> +	void *bin_data;=0A=
> +	struct dm_remap_param *remap_param;=0A=
> +=0A=
> +	md =3D find_device(param);=0A=
> +	if (!md)=0A=
> +		return -ENXIO;=0A=
> +=0A=
> +	bin_data =3D (void *)(param) + param->data_start;=0A=
> +	remap_param =3D bin_data;=0A=
> +=0A=
> +	if (remap_param->cmd =3D=3D REMAP_START_CMD)=0A=
> +		ret =3D dev_remap_start(md, remap_param->params);=0A=
> +	else if (remap_param->cmd =3D=3D REMAP_FINISH_CMD)=0A=
> +		ret =3D dev_remap_finish(md);=0A=
> +	else {=0A=
> +		DMWARN("Invalid remap command, %d", remap_param->cmd);=0A=
> +		ret =3D -EINVAL;=0A=
> +	}=0A=
> +=0A=
> +	dm_put(md);=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
>  /*=0A=
>   * The ioctl parameter block consists of two parts, a dm_ioctl struct=0A=
>   * followed by a data buffer.  This flag is set if the second part,=0A=
> @@ -1691,6 +1729,7 @@ static ioctl_fn lookup_ioctl(unsigned int cmd, int =
*ioctl_flags)=0A=
>  		{DM_DEV_SET_GEOMETRY_CMD, 0, dev_set_geometry},=0A=
>  		{DM_DEV_ARM_POLL, IOCTL_FLAGS_NO_PARAMS, dev_arm_poll},=0A=
>  		{DM_GET_TARGET_VERSION, 0, get_target_version},=0A=
> +		{DM_DEV_REMAP_CMD, 0, dev_remap},=0A=
>  	};=0A=
>  =0A=
>  	if (unlikely(cmd >=3D ARRAY_SIZE(_ioctls)))=0A=
> diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c=0A=
> index 00774b5d7668..ffb8b5ca4d10 100644=0A=
> --- a/drivers/md/dm-linear.c=0A=
> +++ b/drivers/md/dm-linear.c=0A=
> @@ -28,12 +28,13 @@ struct linear_c {=0A=
>   */=0A=
>  static int linear_ctr(struct dm_target *ti, unsigned int argc, char **ar=
gv)=0A=
>  {=0A=
> +	fmode_t mode;=0A=
>  	struct linear_c *lc;=0A=
>  	unsigned long long tmp;=0A=
>  	char dummy;=0A=
>  	int ret;=0A=
>  =0A=
> -	if (argc !=3D 2) {=0A=
> +	if ((argc < 2) || (argc > 3)) {=0A=
>  		ti->error =3D "Invalid argument count";=0A=
>  		return -EINVAL;=0A=
>  	}=0A=
> @@ -51,7 +52,19 @@ static int linear_ctr(struct dm_target *ti, unsigned i=
nt argc, char **argv)=0A=
>  	}=0A=
>  	lc->start =3D tmp;=0A=
>  =0A=
> -	ret =3D dm_get_device(ti, argv[0], dm_table_get_mode(ti->table), &lc->d=
ev);=0A=
> +	ti->non_exclusive =3D false;=0A=
> +	if (argc > 2) {=0A=
> +		if (strcmp("noexcl", argv[2]) =3D=3D 0)=0A=
> +			ti->non_exclusive =3D true;=0A=
> +		else if (strcmp("excl", argv[2]) =3D=3D 0)=0A=
> +			ti->non_exclusive =3D false;=0A=
=0A=
It already is false.=0A=
=0A=
> +		else {=0A=
> +			ti->error =3D "Invalid exclusive option";=0A=
> +			return -EINVAL;=0A=
> +		}=0A=
> +	}=0A=
> +=0A=
> +	ret =3D dm_get_device(ti, argv[0], mode, &lc->dev);=0A=
=0A=
Where is mode initialized ? Why remove dm_table_get_mode(ti->table) ?=0A=
=0A=
>  	if (ret) {=0A=
>  		ti->error =3D "Device lookup failed";=0A=
>  		goto bad;=0A=
=0A=
I would prefer to see this change to dm-linear in its own patch, following =
this=0A=
one, with a clear explanation in the commit message how this change relates=
 to=0A=
interposer since the explanation for this "exclusive" change is nowhere to =
be=0A=
seen. Also please check if there is a file describing dm-linear options und=
er=0A=
Documentation/ (I can't remember if there is one). If there is one, it will=
 need=0A=
to be updated too.=0A=
=0A=
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c=0A=
> index 4acf2342f7ad..f15bc2171f25 100644=0A=
> --- a/drivers/md/dm-table.c=0A=
> +++ b/drivers/md/dm-table.c=0A=
> @@ -322,7 +322,7 @@ static int device_area_is_invalid(struct dm_target *t=
i, struct dm_dev *dev,=0A=
>   * device and not to touch the existing bdev field in case=0A=
>   * it is accessed concurrently.=0A=
>   */=0A=
> -static int upgrade_mode(struct dm_dev_internal *dd, fmode_t new_mode,=0A=
> +static int upgrade_mode(struct dm_dev_internal *dd, fmode_t new_mode, bo=
ol non_exclusive,=0A=
>  			struct mapped_device *md)=0A=
>  {=0A=
>  	int r;=0A=
> @@ -330,7 +330,7 @@ static int upgrade_mode(struct dm_dev_internal *dd, f=
mode_t new_mode,=0A=
>  =0A=
>  	old_dev =3D dd->dm_dev;=0A=
>  =0A=
> -	r =3D dm_get_table_device(md, dd->dm_dev->bdev->bd_dev,=0A=
> +	r =3D dm_get_table_device(md, dd->dm_dev->bdev->bd_dev, non_exclusive,=
=0A=
>  				dd->dm_dev->mode | new_mode, &new_dev);=0A=
>  	if (r)=0A=
>  		return r;=0A=
> @@ -387,7 +387,8 @@ int dm_get_device(struct dm_target *ti, const char *p=
ath, fmode_t mode,=0A=
>  		if (!dd)=0A=
>  			return -ENOMEM;=0A=
>  =0A=
> -		if ((r =3D dm_get_table_device(t->md, dev, mode, &dd->dm_dev))) {=0A=
> +		r =3D dm_get_table_device(t->md, dev, mode, ti->non_exclusive, &dd->dm=
_dev);=0A=
> +		if (r) {=0A=
>  			kfree(dd);=0A=
>  			return r;=0A=
>  		}=0A=
> @@ -396,8 +397,9 @@ int dm_get_device(struct dm_target *ti, const char *p=
ath, fmode_t mode,=0A=
>  		list_add(&dd->list, &t->devices);=0A=
>  		goto out;=0A=
>  =0A=
> -	} else if (dd->dm_dev->mode !=3D (mode | dd->dm_dev->mode)) {=0A=
> -		r =3D upgrade_mode(dd, mode, t->md);=0A=
> +	} else if ((dd->dm_dev->mode !=3D (mode | dd->dm_dev->mode)) &&=0A=
> +		   (dd->dm_dev->non_exclusive !=3D ti->non_exclusive)) {=0A=
> +		r =3D upgrade_mode(dd, mode, ti->non_exclusive, t->md);=0A=
>  		if (r)=0A=
>  			return r;=0A=
>  	}=0A=
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c=0A=
> index 7bac564f3faa..3b871d98b7b6 100644=0A=
> --- a/drivers/md/dm.c=0A=
> +++ b/drivers/md/dm.c=0A=
> @@ -28,6 +28,7 @@=0A=
>  #include <linux/refcount.h>=0A=
>  #include <linux/part_stat.h>=0A=
>  #include <linux/blk-crypto.h>=0A=
> +#include <linux/interval_tree_generic.h>=0A=
>  =0A=
>  #define DM_MSG_PREFIX "core"=0A=
>  =0A=
> @@ -56,6 +57,8 @@ static struct workqueue_struct *deferred_remove_workque=
ue;=0A=
>  atomic_t dm_global_event_nr =3D ATOMIC_INIT(0);=0A=
>  DECLARE_WAIT_QUEUE_HEAD(dm_global_eventq);=0A=
>  =0A=
> +static DEFINE_MUTEX(interposer_mutex); /* synchronizing access to blk_in=
terposer */=0A=
=0A=
Why not dm_interposer_mutex as the name ? And the comment is not very usefu=
l: a=0A=
mutex is always for synchronizing :)=0A=
=0A=
> +=0A=
>  void dm_issue_global_event(void)=0A=
>  {=0A=
>  	atomic_inc(&dm_global_event_nr);=0A=
> @@ -162,6 +165,26 @@ struct table_device {=0A=
>  	struct dm_dev dm_dev;=0A=
>  };=0A=
>  =0A=
> +/*=0A=
> + * Device mapper`s interposer.=0A=
> + */=0A=
> +struct dm_interposer {=0A=
> +	struct blk_interposer blk_ip;=0A=
> +	struct mapped_device *md;=0A=
> +=0A=
> +	struct kref kref;=0A=
> +	struct rw_semaphore ip_devs_lock;=0A=
> +	struct rb_root_cached ip_devs_root; /* dm_interposed_dev tree */=0A=
> +};=0A=
> +=0A=
> +/*=0A=
> + * Interval tree for device mapper=0A=
> + */=0A=
> +#define START(node) ((node)->start)=0A=
> +#define LAST(node) ((node)->last)=0A=
> +INTERVAL_TREE_DEFINE(struct dm_rb_range, node, sector_t, _subtree_last,=
=0A=
> +		     START, LAST,, dm_rb);=0A=
> +=0A=
>  /*=0A=
>   * Bio-based DM's mempools' reserved IOs set by the user.=0A=
>   */=0A=
> @@ -733,28 +756,340 @@ static void dm_put_live_table_fast(struct mapped_d=
evice *md) __releases(RCU)=0A=
>  	rcu_read_unlock();=0A=
>  }=0A=
>  =0A=
> +static void dm_submit_bio_interposer_fn(struct bio *bio)=0A=
> +{=0A=
> +	struct dm_interposer *ip;=0A=
> +	unsigned int noio_flag =3D 0;=0A=
> +	sector_t start;=0A=
> +	sector_t last;=0A=
> +	struct dm_rb_range *node;=0A=
> +=0A=
> +	ip =3D container_of(bio->bi_disk->interposer, struct dm_interposer, blk=
_ip);=0A=
> +	start =3D bio->bi_iter.bi_sector;=0A=
> +	last =3D start + dm_sector_div_up(bio->bi_iter.bi_size, SECTOR_SIZE);=
=0A=
> +=0A=
> +	noio_flag =3D memalloc_noio_save();=0A=
> +	down_read(&ip->ip_devs_lock);=0A=
> +	node =3D dm_rb_iter_first(&ip->ip_devs_root, start, last);=0A=
> +	while (node) {=0A=
> +		struct dm_interposed_dev *ip_dev =3D=0A=
> +			container_of(node, struct dm_interposed_dev, node);=0A=
> +=0A=
> +		atomic64_inc(&ip_dev->ip_cnt);=0A=
> +		ip_dev->dm_interpose_bio(ip_dev->context, node, bio);=0A=
> +=0A=
> +		node =3D dm_rb_iter_next(node, start, last);=0A=
> +	}=0A=
> +	up_read(&ip->ip_devs_lock);=0A=
> +	memalloc_noio_restore(noio_flag);=0A=
> +}=0A=
> +=0A=
> +static void free_interposer(struct kref *kref)=0A=
> +{=0A=
> +	struct dm_interposer *ip =3D container_of(kref, struct dm_interposer, k=
ref);=0A=
> +=0A=
> +	blk_interposer_detach(&ip->blk_ip, dm_submit_bio_interposer_fn);=0A=
=0A=
No queue freeze ?=0A=
=0A=
> +=0A=
> +	kfree(ip);=0A=
> +}=0A=
> +=0A=
> +static struct dm_interposer *new_interposer(struct gendisk *disk)=0A=
> +{=0A=
> +	int ret =3D 0;=0A=
> +	struct dm_interposer *ip;=0A=
> +=0A=
> +	ip =3D kzalloc(sizeof(struct dm_interposer), GFP_NOIO);=0A=
> +	if (!ip)=0A=
> +		return ERR_PTR(-ENOMEM);=0A=
> +=0A=
> +	kref_init(&ip->kref);=0A=
> +	init_rwsem(&ip->ip_devs_lock);=0A=
> +	ip->ip_devs_root =3D RB_ROOT_CACHED;=0A=
> +=0A=
> +	ret =3D blk_interposer_attach(disk, &ip->blk_ip, dm_submit_bio_interpos=
er_fn);=0A=
=0A=
No queue freeze ?=0A=
=0A=
> +	if (ret) {=0A=
> +		DMERR("Failed to attack blk_interposer");=0A=
> +		kref_put(&ip->kref, free_interposer);=0A=
> +		return ERR_PTR(ret);=0A=
> +	}=0A=
> +=0A=
> +	return ip;=0A=
> +}=0A=
> +=0A=
> +static struct dm_interposer *get_interposer(struct gendisk *disk)=0A=
> +{=0A=
> +	struct dm_interposer *ip;=0A=
> +=0A=
> +	if (!blk_has_interposer(disk))=0A=
> +		return NULL;=0A=
> +=0A=
> +	if (disk->interposer->ip_submit_bio !=3D dm_submit_bio_interposer_fn) {=
=0A=
> +		DMERR("Disks interposer slot already occupied.");=0A=
> +		return ERR_PTR(-EBUSY);=0A=
=0A=
This is weird... If there is an interposer, why not get a ref on that one. =
That=0A=
is what the function name suggests at least.=0A=
=0A=
> +	}=0A=
> +=0A=
> +	ip =3D container_of(disk->interposer, struct dm_interposer, blk_ip);=0A=
> +=0A=
> +	kref_get(&ip->kref);=0A=
> +	return ip;=0A=
> +}=0A=
> +=0A=
> +struct dm_interposed_dev *dm_interposer_new_dev(struct gendisk *disk, se=
ctor_t ofs, sector_t len,=0A=
> +						void *context, dm_interpose_bio_t dm_interpose_bio)=0A=
> +{=0A=
> +	sector_t start =3D ofs;=0A=
> +	sector_t last =3D  ofs + len - 1;=0A=
> +	struct dm_interposed_dev *ip_dev =3D NULL;=0A=
> +=0A=
> +	/* Allocate new ip_dev */=0A=
> +	ip_dev =3D kzalloc(sizeof(struct dm_interposed_dev), GFP_KERNEL);=0A=
> +	if (!ip_dev)=0A=
> +		return NULL;=0A=
> +=0A=
> +	ip_dev->disk =3D disk;=0A=
> +	ip_dev->node.start =3D start;=0A=
> +	ip_dev->node.last =3D last;=0A=
> +=0A=
> +	ip_dev->context =3D context;=0A=
> +	ip_dev->dm_interpose_bio =3D dm_interpose_bio;=0A=
> +=0A=
> +	atomic64_set(&ip_dev->ip_cnt, 0);=0A=
> +=0A=
> +	return ip_dev;=0A=
> +}=0A=
> +=0A=
> +void dm_interposer_free_dev(struct dm_interposed_dev *ip_dev)=0A=
> +{=0A=
> +	kfree(ip_dev);=0A=
> +}=0A=
=0A=
Make this inline may be ?=0A=
=0A=
> +=0A=
> +static inline void dm_disk_freeze(struct gendisk *disk)=0A=
> +{=0A=
> +	blk_mq_freeze_queue(disk->queue);=0A=
> +	blk_mq_quiesce_queue(disk->queue);=0A=
=0A=
I think you can replace this with blk_mq_freeze_queue_wait().=0A=
=0A=
> +}=0A=
> +=0A=
> +static inline void dm_disk_unfreeze(struct gendisk *disk)=0A=
> +{=0A=
> +	blk_mq_unquiesce_queue(disk->queue);=0A=
> +	blk_mq_unfreeze_queue(disk->queue);=0A=
> +}=0A=
> +=0A=
> +int dm_interposer_attach_dev(struct dm_interposed_dev *ip_dev)=0A=
> +{=0A=
> +	int ret =3D 0;=0A=
> +	struct dm_interposer *ip =3D NULL;=0A=
> +	unsigned int noio_flag =3D 0;=0A=
> +=0A=
> +	if (!ip_dev)=0A=
> +		return -EINVAL;=0A=
> +=0A=
> +	dm_disk_freeze(ip_dev->disk);=0A=
> +	mutex_lock(&interposer_mutex);=0A=
> +	noio_flag =3D memalloc_noio_save();=0A=
> +=0A=
> +	ip =3D get_interposer(ip_dev->disk);=0A=
> +	if (ip =3D=3D NULL)=0A=
> +		ip =3D new_interposer(ip_dev->disk);=0A=
> +	if (IS_ERR(ip)) {=0A=
> +		ret =3D PTR_ERR(ip);=0A=
> +		goto out;=0A=
> +	}=0A=
> +=0A=
> +	/* Attach dm_interposed_dev to dm_interposer */=0A=
> +	down_write(&ip->ip_devs_lock);=0A=
> +	do {=0A=
> +		struct dm_rb_range *node;=0A=
> +=0A=
> +		/* checking that ip_dev already exists for this region */=0A=
> +		node =3D dm_rb_iter_first(&ip->ip_devs_root, ip_dev->node.start, ip_de=
v->node.last);=0A=
> +		if (node) {=0A=
> +			DMERR("Disk part form [%llu] to [%llu] already have interposer",=0A=
> +			      node->start, node->last);=0A=
> +=0A=
> +			ret =3D -EBUSY;=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +		/* insert ip_dev to ip tree */=0A=
> +		dm_rb_insert(&ip_dev->node, &ip->ip_devs_root);=0A=
> +		/* increment ip reference counter */=0A=
> +		kref_get(&ip->kref);=0A=
> +	} while (false);=0A=
> +	up_write(&ip->ip_devs_lock);=0A=
> +=0A=
> +	kref_put(&ip->kref, free_interposer);=0A=
> +=0A=
> +out:=0A=
> +	memalloc_noio_restore(noio_flag);=0A=
> +	mutex_unlock(&interposer_mutex);=0A=
> +	dm_disk_unfreeze(ip_dev->disk);=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
> +int dm_interposer_detach_dev(struct dm_interposed_dev *ip_dev)=0A=
> +{=0A=
> +	int ret =3D 0;=0A=
> +	struct dm_interposer *ip =3D NULL;=0A=
> +	unsigned int noio_flag =3D 0;=0A=
> +=0A=
> +	if (!ip_dev)=0A=
> +		return -EINVAL;=0A=
> +=0A=
> +	dm_disk_freeze(ip_dev->disk);=0A=
> +	mutex_lock(&interposer_mutex);=0A=
> +	noio_flag =3D memalloc_noio_save();=0A=
> +=0A=
> +	ip =3D get_interposer(ip_dev->disk);=0A=
> +	if (IS_ERR(ip)) {=0A=
> +		ret =3D PTR_ERR(ip);=0A=
> +		DMERR("Interposer not found");=0A=
> +		goto out;=0A=
> +	}=0A=
> +	if (unlikely(ip =3D=3D NULL)) {=0A=
> +		ret =3D -ENXIO;=0A=
> +		DMERR("Interposer not found");=0A=
> +		goto out;=0A=
> +	}=0A=
> +=0A=
> +	down_write(&ip->ip_devs_lock);=0A=
> +	do {=0A=
> +		dm_rb_remove(&ip_dev->node, &ip->ip_devs_root);=0A=
> +		/* the reference counter here cannot be zero */=0A=
> +		kref_put(&ip->kref, free_interposer);=0A=
> +=0A=
> +	} while (false);=0A=
> +	up_write(&ip->ip_devs_lock);=0A=
> +=0A=
> +	/* detach and free interposer if it`s not needed */=0A=
=0A=
s/`/'/=0A=
=0A=
> +	kref_put(&ip->kref, free_interposer);=0A=
> +out:=0A=
> +	memalloc_noio_restore(noio_flag);=0A=
> +	mutex_unlock(&interposer_mutex);=0A=
> +	dm_disk_unfreeze(ip_dev->disk);=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
> +static void dm_remap_fn(void *context, struct dm_rb_range *node, struct =
bio *bio)=0A=
> +{=0A=
> +	struct mapped_device *md =3D context;=0A=
> +=0A=
> +	/* Set acceptor device. */=0A=
> +	bio->bi_disk =3D md->disk;=0A=
> +=0A=
> +	/* Remap disks offset */=0A=
> +	bio->bi_iter.bi_sector -=3D node->start;=0A=
> +=0A=
> +	/*=0A=
> +	 * bio should be resubmitted.=0A=
> +	 * We can just add bio to bio_list of the current process.=0A=
> +	 * current->bio_list must be initialized when this function is called.=
=0A=
> +	 * If call submit_bio_noacct(), the bio will be checked twice.=0A=
> +	 */=0A=
> +	BUG_ON(!current->bio_list);=0A=
> +	bio_list_add(&current->bio_list[0], bio);=0A=
> +}=0A=
> +=0A=
> +int dm_remap_install(struct mapped_device *md, const char *donor_device_=
name)=0A=
> +{=0A=
> +	int ret =3D 0;=0A=
> +	struct block_device *donor_bdev;=0A=
> +	fmode_t mode =3D FMODE_READ | FMODE_WRITE;=0A=
> +=0A=
> +	DMDEBUG("Dm remap install for mapped device %s and donor device %s",=0A=
> +		md->name, donor_device_name);=0A=
> +=0A=
> +	donor_bdev =3D blkdev_get_by_path(donor_device_name, mode, "device-mapp=
er remap");=0A=
> +	if (IS_ERR(donor_bdev)) {=0A=
> +		DMERR("Cannot open device [%s]", donor_device_name);=0A=
> +		return PTR_ERR(donor_bdev);=0A=
> +	}=0A=
> +=0A=
> +	do {=0A=
> +		sector_t ofs =3D get_start_sect(donor_bdev);=0A=
> +		sector_t len =3D bdev_nr_sectors(donor_bdev);=0A=
> +=0A=
> +		md->ip_dev =3D dm_interposer_new_dev(donor_bdev->bd_disk, ofs, len, md=
, dm_remap_fn);=0A=
> +		if (!md->ip_dev) {=0A=
> +			ret =3D -ENOMEM;=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +		DMDEBUG("New interposed device 0x%p", md->ip_dev);=0A=
> +		ret =3D dm_interposer_attach_dev(md->ip_dev);=0A=
> +		if (ret) {=0A=
> +			dm_interposer_free_dev(md->ip_dev);=0A=
> +=0A=
> +			md->ip_dev =3D NULL;=0A=
> +			DMERR("Failed to attach dm interposer");=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +		DMDEBUG("Attached successfully.");=0A=
> +	} while (false);=0A=
> +=0A=
> +	blkdev_put(donor_bdev, mode);=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
> +int dm_remap_uninstall(struct mapped_device *md)=0A=
> +{=0A=
> +	int ret =3D 0;=0A=
> +=0A=
> +	DMDEBUG("Dm remap uninstall for mapped device %s ip_dev=3D0x%p", md->na=
me, md->ip_dev);=0A=
> +=0A=
> +	if (!md->ip_dev) {=0A=
> +		DMERR("Cannot detach dm interposer");=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +=0A=
> +	ret =3D dm_interposer_detach_dev(md->ip_dev);=0A=
> +	if (ret) {=0A=
> +		DMERR("Failed to detach dm interposer");=0A=
> +		return ret;=0A=
> +	}=0A=
> +=0A=
> +	DMDEBUG("Detached successfully. %llu bios was interposed",=0A=
> +		atomic64_read(&md->ip_dev->ip_cnt));=0A=
> +	dm_interposer_free_dev(md->ip_dev);=0A=
> +	md->ip_dev =3D NULL;=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
>  static char *_dm_claim_ptr =3D "I belong to device-mapper";=0A=
>  =0A=
>  /*=0A=
>   * Open a table device so we can use it as a map destination.=0A=
>   */=0A=
>  static int open_table_device(struct table_device *td, dev_t dev,=0A=
> -			     struct mapped_device *md)=0A=
> +			     struct mapped_device *md, bool non_exclusive)=0A=
>  {=0A=
>  	struct block_device *bdev;=0A=
> -=0A=
> -	int r;=0A=
> +	int ret;=0A=
>  =0A=
>  	BUG_ON(td->dm_dev.bdev);=0A=
>  =0A=
> -	bdev =3D blkdev_get_by_dev(dev, td->dm_dev.mode | FMODE_EXCL, _dm_claim=
_ptr);=0A=
> -	if (IS_ERR(bdev))=0A=
> -		return PTR_ERR(bdev);=0A=
> +	if (non_exclusive)=0A=
> +		bdev =3D blkdev_get_by_dev(dev, td->dm_dev.mode, NULL);=0A=
> +	else=0A=
> +		bdev =3D blkdev_get_by_dev(dev, td->dm_dev.mode | FMODE_EXCL, _dm_clai=
m_ptr);=0A=
>  =0A=
> -	r =3D bd_link_disk_holder(bdev, dm_disk(md));=0A=
> -	if (r) {=0A=
> -		blkdev_put(bdev, td->dm_dev.mode | FMODE_EXCL);=0A=
> -		return r;=0A=
> +	if (IS_ERR(bdev)) {=0A=
> +		ret =3D PTR_ERR(bdev);=0A=
> +		if (ret !=3D -EBUSY)=0A=
> +			return ret;=0A=
> +	}=0A=
> +=0A=
> +	if (!non_exclusive) {=0A=
> +		ret =3D bd_link_disk_holder(bdev, dm_disk(md));=0A=
> +		if (ret) {=0A=
> +			blkdev_put(bdev, td->dm_dev.mode);=0A=
> +			return ret;=0A=
> +		}=0A=
>  	}=0A=
>  =0A=
>  	td->dm_dev.bdev =3D bdev;=0A=
> @@ -770,33 +1105,38 @@ static void close_table_device(struct table_device=
 *td, struct mapped_device *md=0A=
>  	if (!td->dm_dev.bdev)=0A=
>  		return;=0A=
>  =0A=
> -	bd_unlink_disk_holder(td->dm_dev.bdev, dm_disk(md));=0A=
> -	blkdev_put(td->dm_dev.bdev, td->dm_dev.mode | FMODE_EXCL);=0A=
> +	if (td->dm_dev.mode & FMODE_EXCL)=0A=
> +		bd_unlink_disk_holder(td->dm_dev.bdev, dm_disk(md));=0A=
> +=0A=
> +	blkdev_put(td->dm_dev.bdev, td->dm_dev.mode);=0A=
> +=0A=
>  	put_dax(td->dm_dev.dax_dev);=0A=
>  	td->dm_dev.bdev =3D NULL;=0A=
>  	td->dm_dev.dax_dev =3D NULL;=0A=
>  }=0A=
>  =0A=
>  static struct table_device *find_table_device(struct list_head *l, dev_t=
 dev,=0A=
> -					      fmode_t mode)=0A=
> +					      fmode_t mode, bool non_exclusive)=0A=
>  {=0A=
>  	struct table_device *td;=0A=
>  =0A=
>  	list_for_each_entry(td, l, list)=0A=
> -		if (td->dm_dev.bdev->bd_dev =3D=3D dev && td->dm_dev.mode =3D=3D mode)=
=0A=
> +		if (td->dm_dev.bdev->bd_dev =3D=3D dev &&=0A=
> +		    td->dm_dev.mode =3D=3D mode &&=0A=
> +		    td->dm_dev.non_exclusive =3D=3D non_exclusive)=0A=
>  			return td;=0A=
>  =0A=
>  	return NULL;=0A=
>  }=0A=
>  =0A=
> -int dm_get_table_device(struct mapped_device *md, dev_t dev, fmode_t mod=
e,=0A=
> +int dm_get_table_device(struct mapped_device *md, dev_t dev, fmode_t mod=
e, bool non_exclusive,=0A=
>  			struct dm_dev **result)=0A=
>  {=0A=
>  	int r;=0A=
>  	struct table_device *td;=0A=
>  =0A=
>  	mutex_lock(&md->table_devices_lock);=0A=
> -	td =3D find_table_device(&md->table_devices, dev, mode);=0A=
> +	td =3D find_table_device(&md->table_devices, dev, mode, non_exclusive);=
=0A=
>  	if (!td) {=0A=
>  		td =3D kmalloc_node(sizeof(*td), GFP_KERNEL, md->numa_node_id);=0A=
>  		if (!td) {=0A=
> @@ -807,7 +1147,8 @@ int dm_get_table_device(struct mapped_device *md, de=
v_t dev, fmode_t mode,=0A=
>  		td->dm_dev.mode =3D mode;=0A=
>  		td->dm_dev.bdev =3D NULL;=0A=
>  =0A=
> -		if ((r =3D open_table_device(td, dev, md))) {=0A=
> +		r =3D open_table_device(td, dev, md, non_exclusive);=0A=
> +		if (r) {=0A=
>  			mutex_unlock(&md->table_devices_lock);=0A=
>  			kfree(td);=0A=
>  			return r;=0A=
> @@ -2182,6 +2523,14 @@ static void __dm_destroy(struct mapped_device *md,=
 bool wait)=0A=
>  =0A=
>  	might_sleep();=0A=
>  =0A=
> +	if (md->ip_dev) {=0A=
> +		if (dm_interposer_detach_dev(md->ip_dev))=0A=
> +			DMERR("Failed to detach dm interposer");=0A=
> +=0A=
> +		dm_interposer_free_dev(md->ip_dev);=0A=
> +		md->ip_dev =3D NULL;=0A=
> +	}=0A=
> +=0A=
>  	spin_lock(&_minor_lock);=0A=
>  	idr_replace(&_minor_idr, MINOR_ALLOCED, MINOR(disk_devt(dm_disk(md))));=
=0A=
>  	set_bit(DMF_FREEING, &md->flags);=0A=
> diff --git a/drivers/md/dm.h b/drivers/md/dm.h=0A=
> index fffe1e289c53..7bf20fb2de74 100644=0A=
> --- a/drivers/md/dm.h=0A=
> +++ b/drivers/md/dm.h=0A=
> @@ -179,7 +179,7 @@ int dm_open_count(struct mapped_device *md);=0A=
>  int dm_lock_for_deletion(struct mapped_device *md, bool mark_deferred, b=
ool only_deferred);=0A=
>  int dm_cancel_deferred_remove(struct mapped_device *md);=0A=
>  int dm_request_based(struct mapped_device *md);=0A=
> -int dm_get_table_device(struct mapped_device *md, dev_t dev, fmode_t mod=
e,=0A=
> +int dm_get_table_device(struct mapped_device *md, dev_t dev, fmode_t mod=
e, bool non_exclusive,=0A=
>  			struct dm_dev **result);=0A=
>  void dm_put_table_device(struct mapped_device *md, struct dm_dev *d);=0A=
>  =0A=
> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.=
h=0A=
> index 61a66fb8ebb3..70002363bfc0 100644=0A=
> --- a/include/linux/device-mapper.h=0A=
> +++ b/include/linux/device-mapper.h=0A=
> @@ -150,6 +150,7 @@ struct dm_dev {=0A=
>  	struct block_device *bdev;=0A=
>  	struct dax_device *dax_dev;=0A=
>  	fmode_t mode;=0A=
> +	bool non_exclusive;=0A=
>  	char name[16];=0A=
>  };=0A=
>  =0A=
> @@ -325,6 +326,12 @@ struct dm_target {=0A=
>  	 * whether or not its underlying devices have support.=0A=
>  	 */=0A=
>  	bool discards_supported:1;=0A=
> +=0A=
> +	/*=0A=
> +	 * Set if this target needs to open device without FMODE_EXCL=0A=
> +	 * mode.=0A=
> +	 */=0A=
> +	bool non_exclusive:1;=0A=
>  };=0A=
>  =0A=
>  void *dm_per_bio_data(struct bio *bio, size_t data_size);=0A=
> diff --git a/include/uapi/linux/dm-ioctl.h b/include/uapi/linux/dm-ioctl.=
h=0A=
> index 4933b6b67b85..08d7dbff80f4 100644=0A=
> --- a/include/uapi/linux/dm-ioctl.h=0A=
> +++ b/include/uapi/linux/dm-ioctl.h=0A=
> @@ -214,6 +214,15 @@ struct dm_target_msg {=0A=
>  	char message[0];=0A=
>  };=0A=
>  =0A=
> +enum {=0A=
> +	REMAP_START_CMD =3D 1,=0A=
> +	REMAP_FINISH_CMD,=0A=
> +};=0A=
> +=0A=
> +struct dm_remap_param {=0A=
> +	uint8_t cmd;=0A=
> +	uint8_t params[0];=0A=
> +};=0A=
>  /*=0A=
>   * If you change this make sure you make the corresponding change=0A=
>   * to dm-ioctl.c:lookup_ioctl()=0A=
> @@ -244,6 +253,7 @@ enum {=0A=
>  	DM_DEV_SET_GEOMETRY_CMD,=0A=
>  	DM_DEV_ARM_POLL_CMD,=0A=
>  	DM_GET_TARGET_VERSION_CMD,=0A=
> +	DM_DEV_REMAP_CMD=0A=
>  };=0A=
>  =0A=
>  #define DM_IOCTL 0xfd=0A=
> @@ -259,6 +269,7 @@ enum {=0A=
>  #define DM_DEV_STATUS    _IOWR(DM_IOCTL, DM_DEV_STATUS_CMD, struct dm_io=
ctl)=0A=
>  #define DM_DEV_WAIT      _IOWR(DM_IOCTL, DM_DEV_WAIT_CMD, struct dm_ioct=
l)=0A=
>  #define DM_DEV_ARM_POLL  _IOWR(DM_IOCTL, DM_DEV_ARM_POLL_CMD, struct dm_=
ioctl)=0A=
> +#define DM_DEV_REMAP     _IOWR(DM_IOCTL, DM_DEV_REMAP_CMD, struct dm_ioc=
tl)=0A=
>  =0A=
>  #define DM_TABLE_LOAD    _IOWR(DM_IOCTL, DM_TABLE_LOAD_CMD, struct dm_io=
ctl)=0A=
>  #define DM_TABLE_CLEAR   _IOWR(DM_IOCTL, DM_TABLE_CLEAR_CMD, struct dm_i=
octl)=0A=
> @@ -272,9 +283,9 @@ enum {=0A=
>  #define DM_DEV_SET_GEOMETRY	_IOWR(DM_IOCTL, DM_DEV_SET_GEOMETRY_CMD, str=
uct dm_ioctl)=0A=
>  =0A=
>  #define DM_VERSION_MAJOR	4=0A=
> -#define DM_VERSION_MINOR	43=0A=
> +#define DM_VERSION_MINOR	44=0A=
>  #define DM_VERSION_PATCHLEVEL	0=0A=
> -#define DM_VERSION_EXTRA	"-ioctl (2020-10-01)"=0A=
> +#define DM_VERSION_EXTRA	"-ioctl (2020-12-25)"=0A=
>  =0A=
>  /* Status bits */=0A=
>  #define DM_READONLY_FLAG	(1 << 0) /* In/Out */=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
