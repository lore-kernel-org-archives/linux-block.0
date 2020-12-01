Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4F0C71156
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 09:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65990204FD
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 09:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="CBKaPdR/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZWArL75g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbgLAJ6h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 04:58:37 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:23381 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgLAJ6f (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Dec 2020 04:58:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606817515; x=1638353515;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=FD/t4QNnIm36fQy5AyIldUnJMbmBAj0+s4ZwtTzhDgY=;
  b=CBKaPdR/jTRV79VO+jztlVkQgvcn2q9vLx+DGxqxRHbzNIRBp1nYcDsz
   ixlqksRLT61o2Om0EJw0ws1hAWXkmV0buKmURcoeVsW+OgDuhpvuqQQqM
   z0sWBs/7VUYWkuAs7FWs5j6TtakGQzwOYYp6r3qEMrLrXuguSzC+fO/gy
   jOgqfEO0QolqqtcfStyY/5BBD4l7yM/SB/yEO6cr8b8nu/PQQvHFS2Ch/
   L0P/dsg2fLnVMDq1xm/zcZOEl/ERmUBpe0RLokomHHcvsIqDIL0I4XAZO
   eDpJOciiq84edrUFO5vReI5B4OjbWP29x6KgCIhe4G4zofIWfCVqmLxAW
   A==;
IronPort-SDR: re/BAI1wD63Z0x3nLQqwKKcj9Wo441tN9Uze14I905U+O4rm+kqx3rvYpwc3Siw4e5cijMZESH
 RVF8y4fRG3X5qIwMXCNiB3IOB75HfP8mVOeU9mE6XqtjNFn4T55gd8yGitC2oSwTWsqmfUjq3A
 Pe7FtXaZIuRjUQshTaG1FG3HSpr5Gme9YwBwT3S3VXRWTjEX74e0JOl0c03QLRXWs0PRx38Jqx
 sSEkLPJhEJMW/zX17+T2JceoO7UyFm99fSRGE7OkSBop/RKVEnmi2FYf20U7Clozg55oOzJQIR
 RuA=
X-IronPort-AV: E=Sophos;i="5.78,384,1599494400"; 
   d="scan'208";a="257587338"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 18:10:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0wOx/Xe9P6wqnLb8XkR33uIwOf2QzlkmCGz2OgZc/0xt9XpqFFi/ouG1rOPXe+1dix8B/dzYjjEEHA+WefmU+NJ1emhslMk+E2OGUR08/QOIu5yJRMxGRfKooz3iTwUnUxkgwXQfDrkihYvljS3q9byFuWfgyWZYurKiTn0/eVOlhFacP3zmDsjkTvbi+FW0LQqzcWzyZqfHtXKSnLf8oCbZXmKMMUsix3EYcj7NNeOY8GKTg2uUrynMIx0jbuqQBwo6BaEzzAF86Kf3eZg7fXZS4df6u2WMC55Og79g2zjj6zKBqVGcL7cF7c1qvD/r3kryGTF6sSuZf4WYAru9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5BkcBPSrQ0538iFXZ2rGlTZ5liWHNF9UU2Wgecaock=;
 b=FqFMRvDhFFBxdvlXV4C3nipn1yoUQWuRkhmpzXraKyN68PG4HdKpBzNvI6Tj8iyQwjNLwoPE5ON3GAPIIY8dS0Eft7rbMkYgG9eSxyx+IorvElE9BW6fS3LKR/1QUhBk20tI/nSPb3Nwv9i85GCn1lJjVe4T5IBKTYUQkMgB4ktXW6u9/Jci+Gc9mJzOA5bPlqoSp8PedyK9fWyvbXQENq0BQvcA+hX/olJe2mcQU0gOChGCFTYJ5Myz7Bp4gn5gPT2+RgimD6qZ5VDNqnMcjSmEaXPwWPi1glxTaDnlKJyRgESPE/cncN5WFUQCZqugc2DDFJDFtQZ1dx5RTvLmCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5BkcBPSrQ0538iFXZ2rGlTZ5liWHNF9UU2Wgecaock=;
 b=ZWArL75gYA0h50XPqj10wv5yuYoirfoKMcjLw634DLE3sAVIR7DoCuo5FjIrT3tOhsV07inQyK3uup7MvfMBH4EAy/AmkK1Y+h+BrUq7/eqoqLUGE1P7MQCH4SS1wXntBtmmjwj0o/l+ySY6KUChoZo2KPVQuwdFa41ELay2mqo=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA0PR04MB7306.namprd04.prod.outlook.com
 (2603:10b6:806:e7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.24; Tue, 1 Dec
 2020 09:57:24 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%7]) with mapi id 15.20.3589.030; Tue, 1 Dec 2020
 09:57:24 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     SelvaKumar S <selvakuma.s1@samsung.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "selvajove@gmail.com" <selvajove@gmail.com>,
        "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "javier.gonz@samsung.com" <javier.gonz@samsung.com>
Subject: Re: [RFC PATCH 1/2] block: add simple copy support
Thread-Topic: [RFC PATCH 1/2] block: add simple copy support
Thread-Index: AQHWx7Gmd3TRGW/jckGt+BDcIzWOoQ==
Date:   Tue, 1 Dec 2020 09:57:24 +0000
Message-ID: <SN4PR0401MB3598163C941976D90F745D8B9BF40@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201201053949.143175-1-selvakuma.s1@samsung.com>
 <CGME20201201054057epcas5p1d5bd2813146d2cb57eb66b7cedce1f63@epcas5p1.samsung.com>
 <20201201053949.143175-2-selvakuma.s1@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:155d:1001:548d:b207:1d7c:917b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0355fd70-e1fc-4fe9-0715-08d895df8109
x-ms-traffictypediagnostic: SA0PR04MB7306:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR04MB7306EF76FA8F230E032654F29BF40@SA0PR04MB7306.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PpHLY/kbZBVdTrutryhrHde+hsykckrkyLu13hVCyJSV5CN/EInwMWjDlzT3hYfk+uZ0xGHRNsy9cgKyG6YEwdq6uQJ0cLMLGPCvKxZsmz6F8SkQMrtqz5j8IvbGyA6Y3HtC+EIO0f0qKUBfuiFsxgV/k4fqo1Uf2k+MMiMQ/VZ3PkSW9OclVQ3bD2k5B2U1+KK9J0jjuSz4euh8vS1rPJbJcl6x6CcQBrXnum5hjliGMupagSSn3dwhNQN401Rnx+BcXF8IJHDdCEXstv2B/CfXklIt62EgQTOI6uMom0VRYIeFf+HMXn3ckJoL0dub
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(8676002)(186003)(76116006)(8936002)(7416002)(86362001)(66556008)(91956017)(2906002)(66446008)(66946007)(5660300002)(66476007)(52536014)(64756008)(9686003)(55016002)(110136005)(83380400001)(33656002)(54906003)(53546011)(6506007)(7696005)(4326008)(478600001)(316002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?LQE860IkeP857nxBhOFfp9IPLOiHDRGqjY1ctsZAGh249oIPMrfWskzIIMUv?=
 =?us-ascii?Q?VH7Rw06L6nQvKipy8WHLdQsD0SUaSUoUXQzgmSdv/mDHfus+5ryBPlDXBW6P?=
 =?us-ascii?Q?FhQ0AH7E3/HjtF3KPeTLb3ThpPscbqXP2MaDio7+g7eSwxrLWVbIpCn+XoQF?=
 =?us-ascii?Q?pS3n0aPkAy9X/mwDlVRfFZ31ABv/DRuwS8rJgeXkLHGqDnt8HrbQt1cY0s87?=
 =?us-ascii?Q?3bAhtiEL7kMZ4427za7gSe8O91YR+Dit5z5vzgm/851WpoXSzGGiJu/3Q52C?=
 =?us-ascii?Q?W6qmstEClRoT1mwyhf9CpR740Jdlk/6spzAZLXUE0US0ZSiuCP3fh5/0kRw3?=
 =?us-ascii?Q?7m2omB1dMiwLxdCZ0j6hv6eUjmD+6H+7e4ojhJnfV8CisDlQ8XN9Lrdoh1Xr?=
 =?us-ascii?Q?LiEoHcnMea7OktLBCqBFJnd0Lxs3cOGqUZRYzYYBYMuqrrbYQa3s4QUjgDyb?=
 =?us-ascii?Q?g7sFFR6cL4JBp3KG0twV8uK0nWEjOkrjZHyuCfw1+fkZ5SbXcMACzBj9ieG6?=
 =?us-ascii?Q?ojzitwaYl/xQO8Ke2C19b1aO0kyVd8lWXCFPMNgZ94Gm9YSDFpq9Vo+/6IHz?=
 =?us-ascii?Q?ev2Ie3p9kGM/q7qSAfXhMiDKGf9YiwCBlSI+z8djcilHUV6qvOqxSNtaWddS?=
 =?us-ascii?Q?iz1P4gbcqeLH9sLv8rF1fDDwUe8PwDvo9SyPDWHJdmzPJmmeVgwVVAIBDjlC?=
 =?us-ascii?Q?eN747KclrbIBAMHcwqRTr3e9DSbxhCdk3z8JbwTkCVW8C3jaGClpIfFEJD8y?=
 =?us-ascii?Q?8fksCc+pNNJgJ4KH50uESAWwUMvrXeHEQOg29Va94MGIzslOkZ9NGLC76/Ya?=
 =?us-ascii?Q?kMiRSS+lY726HQToCH/Rdjkvg6EwaddIXmaRZHa8ZCA7y/0D4VXU+cMvXvHO?=
 =?us-ascii?Q?9it2/B85MTQxmdjlKSudeTT9wszcbzkfNj5xuSxEJOWayk2NKTfUCbhoWX/h?=
 =?us-ascii?Q?LigeeoTF1dgtVBJhfu24uAkuvN5iZkEOMH0PWgqcLWvos1Crc3QTuG4DlZ5b?=
 =?us-ascii?Q?d+pqMtRmu3ResebsJhsLq29XL0fuVSz5WaETrNJsJgXwtLyKuQ5hJ9O6eO8+?=
 =?us-ascii?Q?4Xek1CsC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0355fd70-e1fc-4fe9-0715-08d895df8109
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 09:57:24.6883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h0TOKtYgUjPD3wnvmNz2+JxWlThsypwBikWl2pjrR48FQiDgDLDJI098HroJRPbssC/GCWHwnUmiF9zkb+HPp/B7eRror0gLxJ36S0JbpYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7306
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 01/12/2020 08:14, SelvaKumar S wrote:=0A=
> +static inline int bio_check_copy_eod(struct bio *bio, sector_t start,=0A=
> +		sector_t nr_sectors, sector_t maxsector)=0A=
> +{=0A=
> +	if (nr_sectors && maxsector && (nr_sectors > maxsector ||=0A=
> +				start > maxsector - nr_sectors)) {=0A=
=0A=
Nit: I don't like the line break here, maybe:=0A=
=0A=
	if (nr_sectors && maxsector &&=0A=
	    (nr_sectors > maxsector || start > maxsector - nr_sectors)) {=0A=
=0A=
> +		handle_bad_sector(bio, maxsector);=0A=
> +		return -EIO;=0A=
> +	}=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
>  /*=0A=
>   * Check whether this bio extends beyond the end of the device or partit=
ion.=0A=
>   * This may well happen - the kernel calls bread() without checking the =
size of=0A=
> @@ -737,6 +748,75 @@ static inline int bio_check_eod(struct bio *bio, sec=
tor_t maxsector)=0A=
>  	return 0;=0A=
>  }=0A=
>  =0A=
> +/*=0A=
> + * Check for copy limits and remap source ranges if needed.=0A=
> + */=0A=
> +static inline int blk_check_copy(struct bio *bio)=0A=
=0A=
That function is a bit big to be marked as inline, isn't it?=0A=
=0A=
=0A=
> +{=0A=
> +	struct hd_struct *p =3D NULL;=0A=
> +	struct request_queue *q =3D bio->bi_disk->queue;=0A=
> +	struct blk_copy_payload *payload;=0A=
> +	unsigned short nr_range;=0A=
> +	int ret =3D -EIO;=0A=
> +	int i, copy_len =3D 0;=0A=
> +=0A=
> +	rcu_read_lock();=0A=
> +=0A=
> +	if (bio->bi_partno) {=0A=
> +		p =3D __disk_get_part(bio->bi_disk, bio->bi_partno);=0A=
> +		if (unlikely(!p))=0A=
> +			goto out;=0A=
> +		if (unlikely(bio_check_ro(bio, p)))=0A=
> +			goto out;=0A=
> +	} else {=0A=
> +		if (unlikely(bio_check_ro(bio, &bio->bi_disk->part0)))=0A=
> +			goto out;=0A=
> +	}=0A=
> +=0A=
> +	payload =3D bio_data(bio);=0A=
> +	nr_range =3D payload->copy_range;=0A=
> +=0A=
> +	/* cannot handle copy crossing nr_ranges limit */=0A=
> +	if (payload->copy_range > q->limits.max_copy_nr_ranges)=0A=
> +		goto out;=0A=
> +=0A=
> +	for (i =3D 0; i < nr_range; i++) {=0A=
> +		copy_len +=3D payload->range[i].len;=0A=
> +		if (p) {=0A=
> +			if (bio_check_copy_eod(bio, payload->range[i].src,=0A=
> +					payload->range[i].len, part_nr_sects_read(p)))=0A=
> +				goto out;=0A=
> +			payload->range[i].src +=3D p->start_sect;=0A=
> +		} else {=0A=
> +			if (unlikely(bio_check_copy_eod(bio, payload->range[i].src,=0A=
> +					payload->range[i].len,=0A=
> +					get_capacity(bio->bi_disk))))=0A=
> +				goto out;=0A=
> +		}=0A=
> +	}=0A=
> +=0A=
> +	/* cannot handle copy more than copy limits */=0A=
> +	if (copy_len > q->limits.max_copy_sectors)=0A=
> +		goto out;=0A=
> +=0A=
> +	if (p) {=0A=
> +		if (unlikely(bio_check_copy_eod(bio, bio->bi_iter.bi_sector, copy_len,=
=0A=
> +					part_nr_sects_read(p))))=0A=
> +			goto out;=0A=
> +	} else {=0A=
> +		if (unlikely(bio_check_copy_eod(bio, bio->bi_iter.bi_sector, copy_len,=
=0A=
> +					get_capacity(bio->bi_disk))))=0A=
> +			goto out;=0A=
> +=0A=
> +	}=0A=
> +=0A=
=0A=
=0A=
All these if (p) {} else {} branches make this function a bit hard to follo=
w.=0A=
=0A=
> +	if (p)=0A=
> +		bio->bi_partno =3D 0;=0A=
> +	ret =3D 0;=0A=
> +out:=0A=
> +	rcu_read_unlock();=0A=
> +	return ret;=0A=
> +}=0A=
>  /*=0A=
>   * Remap block n of partition p to block n+start(p) of the disk.=0A=
>   */=0A=
=0A=
=0A=
> diff --git a/block/blk-lib.c b/block/blk-lib.c=0A=
> index e90614fd8d6a..db4947f7014d 100644=0A=
> --- a/block/blk-lib.c=0A=
> +++ b/block/blk-lib.c=0A=
> @@ -150,6 +150,122 @@ int blkdev_issue_discard(struct block_device *bdev,=
 sector_t sector,=0A=
>  }=0A=
>  EXPORT_SYMBOL(blkdev_issue_discard);=0A=
>  =0A=
> +int __blkdev_issue_copy(struct block_device *bdev, sector_t dest,=0A=
> +		sector_t nr_srcs, struct range_entry *rlist, gfp_t gfp_mask,=0A=
> +		int flags, struct bio **biop)=0A=
> +{=0A=
> +	struct request_queue *q =3D bdev_get_queue(bdev);=0A=
> +	struct bio *bio;=0A=
> +	struct blk_copy_payload *payload;=0A=
> +	unsigned int op;=0A=
=0A=
I don't think op is needed.=0A=
=0A=
> +	sector_t bs_mask;=0A=
> +	sector_t src_sects, len =3D 0, total_len =3D 0;=0A=
> +	int i, ret, total_size;=0A=
> +=0A=
> +	if (!q)=0A=
> +		return -ENXIO;=0A=
> +=0A=
> +	if (!nr_srcs)=0A=
> +		return -EINVAL;=0A=
> +=0A=
> +	if (bdev_read_only(bdev))=0A=
> +		return -EPERM;=0A=
> +=0A=
> +	if (!blk_queue_copy(q))=0A=
> +		return -EOPNOTSUPP;=0A=
> +	op =3D REQ_OP_COPY;=0A=
> +=0A=
> +	bs_mask =3D (bdev_logical_block_size(bdev) >> 9) - 1;=0A=
> +	if (dest & bs_mask)=0A=
> +		return -EINVAL;=0A=
> +=0A=
> +	payload =3D kmalloc(sizeof(struct blk_copy_payload) +=0A=
> +			nr_srcs * sizeof(struct range_entry),=0A=
> +				GFP_ATOMIC | __GFP_NOWARN);=0A=
=0A=
Please check if the use of struct_size() is possible. Probably even assign=
=0A=
total_size here so you don't need to do the size calculation twice.=0A=
=0A=
> +	if (!payload)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	bio =3D bio_alloc(gfp_mask, 1);=0A=
> +	bio->bi_iter.bi_sector =3D dest;=0A=
> +	bio_set_dev(bio, bdev);=0A=
> +	bio_set_op_attrs(bio, op, REQ_NOMERGE);=0A=
=0A=
bio_set_op_attrs() is deprecated, please don't use it.=0A=
	bio->bi_opf =3D REQ_OP_COPY | REQ_NOMERGE;=0A=
=0A=
> +=0A=
> +	payload->dest =3D dest;=0A=
> +=0A=
> +	for (i =3D 0; i < nr_srcs; i++) {=0A=
> +		/*  copy payload provided are in bytes */=0A=
> +		src_sects =3D rlist[i].src;=0A=
> +		if (src_sects & bs_mask)=0A=
> +			return -EINVAL;=0A=
> +		src_sects =3D src_sects >> SECTOR_SHIFT;=0A=
> +=0A=
> +		if (len & bs_mask)=0A=
> +			return -EINVAL;=0A=
> +		len =3D rlist[i].len >> SECTOR_SHIFT;=0A=
> +		if (len > q->limits.max_copy_range_sectors)=0A=
> +			return -EINVAL;=0A=
> +=0A=
> +		total_len +=3D len;=0A=
> +=0A=
> +		WARN_ON_ONCE((src_sects << 9) > UINT_MAX);=0A=
> +=0A=
> +		payload->range[i].src =3D src_sects;=0A=
> +		payload->range[i].len =3D len;=0A=
> +	}=0A=
> +=0A=
> +	/* storing # of source ranges */=0A=
> +	payload->copy_range =3D i;=0A=
> +	/* storing copy len so far */=0A=
> +	payload->copy_size =3D total_len;=0A=
> +=0A=
> +	total_size =3D sizeof(struct blk_copy_payload) + nr_srcs * sizeof(struc=
t range_entry);=0A=
=0A=
See above.=0A=
=0A=
> +	ret =3D bio_add_page(bio, virt_to_page(payload), total_size,=0A=
> +					   offset_in_page(payload));=0A=
> +	if (ret !=3D total_size) {=0A=
> +		kfree(payload);=0A=
> +		return -ENOMEM;=0A=
> +	}=0A=
> +=0A=
> +	*biop =3D bio;=0A=
> +	return 0;=0A=
> +}=0A=
> +EXPORT_SYMBOL(__blkdev_issue_copy);=0A=
> +=0A=
> +/**=0A=
> + * blkdev_issue_copy - queue a copy=0A=
> + * @bdev:       blockdev to issue copy for=0A=
> + * @dest:	dest sector=0A=
> + * @nr_srcs:	number of source ranges to copy=0A=
> + * @rlist:	list of range entries=0A=
> + * @gfp_mask:   memory allocation flags (for bio_alloc)=0A=
> + * @flags:      BLKDEV_COPY_* flags to control behaviour	//TODO=0A=
> + *=0A=
> + * Description:=0A=
> + *    Issue a copy request for dest sector with source in rlist=0A=
> + */=0A=
> +int blkdev_issue_copy(struct block_device *bdev, sector_t dest,=0A=
> +		int nr_srcs, struct range_entry *rlist,=0A=
> +		gfp_t gfp_mask, unsigned long flags)=0A=
> +{=0A=
> +	struct bio *bio =3D NULL;=0A=
> +	int ret;=0A=
> +=0A=
> +	ret =3D __blkdev_issue_copy(bdev, dest, nr_srcs, rlist, gfp_mask, flags=
,=0A=
> +			&bio);=0A=
> +	if (!ret && bio) {=0A=
> +		ret =3D submit_bio_wait(bio);=0A=
> +		if (ret =3D=3D -EOPNOTSUPP)=0A=
> +			ret =3D 0;=0A=
> +=0A=
> +		kfree(page_address(bio_first_bvec_all(bio)->bv_page) +=0A=
> +				bio_first_bvec_all(bio)->bv_offset);=0A=
> +		bio_put(bio);=0A=
> +	}=0A=
> +=0A=
> +	return ret;=0A=
=0A=
What happens with bio here if __blkdev_issue_copy() returns say -ENOMEM bec=
ause=0A=
bio_add_page() fails?=0A=
=0A=
Also please handle failure not success. Sth along the lines of=0A=
=0A=
	ret =3D __blkdev_issue_copy(bdev, dest, nr_srcs, rlist, gfp_mask, flags,=
=0A=
				  &bio);=0A=
	if (ret)=0A=
		...=0A=
=0A=
	ret =3D submit_bio_wait();=0A=
	if (ret)=0A=
		...=0A=
=0A=
	...=0A=
=0A=
	return ret;=0A=
}=0A=
=0A=
> +}=0A=
> +EXPORT_SYMBOL(blkdev_issue_copy);=0A=
=0A=
=0A=
=0A=
