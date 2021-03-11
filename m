Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0DDC433DB
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 02:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A681F64FAA
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 02:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhCKCPu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:15:50 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:41081 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhCKCP0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Mar 2021 21:15:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615428926; x=1646964926;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=y7sV2+KfFCyw6KbFGb8HfSGpq1S49c2vWhnP0GNnZ+A=;
  b=qWryIt9twNWlF9sXY1JCv19pEE0fyMNhmjjm0G9k3hnu3vHhcVtbDtbW
   iVEfU99U+abRFUS8HMdjQlb654VA0mwLlK4VkKSOlAB7Ux6oGAeIU6QYe
   jvjjFcDDKHSc7WkD3QHmrnr8aCX5k0gD/4lwsEU8SVjNlDtY0lC0hspgV
   V9R/bGYOS09sDUC1VeAH2VwntScDvuiry67I8a1djRPlc1V29ZotOj/C4
   L9RuD6OlmbKinFqAUPeP84/wQEv8MfblW48tMi2jNiu+BNW0JvlfatoGQ
   DM2EgKwtzPnR1KIP2p4l/NyqTqbS+a3f+whyY6qZUf9GqyUf782UU8f7D
   Q==;
IronPort-SDR: fNGDtaoI9RZClNtwqcsjuXhUo9BwZo0wq8rFpVXFBCrnfKIgKaCggXwoM7kWqCFqdqCg5mn/+y
 L/yCC7AIBDfrUNVcI6h2j+pdPtZWUww1UnLXk1tqxoyjU/6wgqMKAp+dmQLOWnaEuZxNyu56rL
 pvjtjWG8Bazm3cvSZSlV/k0SdPXLWxlAM6OYNP3sc8OKtesq5py/ne8ND3yHa4VrRaklph/yim
 iwRFrC1dA0nT2GBej3eTG1dN4p4WlNcZ1hrHpT/M+s7+4Yki0jMsx/hK+rmEHIJ1bEz+d0JzTa
 SFg=
X-IronPort-AV: E=Sophos;i="5.81,238,1610380800"; 
   d="scan'208";a="272557970"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2021 10:15:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWCC//8HlahFr9WdeWdiy+OU3yaOuN2QMpzIz9Z+nft8Z6aqo3hv/YXo38CXLzbjT4M/lQZv2RAtyPQBN3Hd9bkbVE4wFHEnAqeUpSIpgXGClfyzbrfqgeVlXaJ38BXOedxHMZRSHLO9gGQfdGjIx28nJABU6JVwZhHKNLGU7zwA7C/GlpUo272nxJS/nHQNiAepsR0UHoPKmWKzSsMvsx+hIRWXCLsAKSlRTD3mJaZvictgyBgKVZyOeRfXbFbblsfiBns0UY3hgMwtP9QcdelzMnrWAAoumujaMCxYL04ruonKQu2xbBTrjX5o4YZKKzoT/v/qGm7N7tuBqdn+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4C2inoo0BAJ8leo6qHQSF2IuEa9uET0hXnK2pmBvFAY=;
 b=RpowYs3hZ0ffGvU6m5fhtF5Ri2b+w5QlV7A93dy7il8/+dUYawFTgTjuKVY2iLOPJauw+YVeLyQgEz24llDHSBv9F6P9UsVVwdYyUhvmtY0CJahonC4Dqztf0w2BFlwsUNLfjSoN4yZGwJG2oGCNIZeROTRR8N54jqASZ8CKol8rnOLd/Pf7QepL41urdCpXv9Kx9rWvCh93b75O10836SpMDehM8I8hi9fK5oA8eVSPxloD9HplyemzbSU9HjJyn7EjevOsKrDCLLqlIDL8YxnjFN+GZFxuaAklow67s8+cLCWU/v2NKuCLYA6GycreM5C1pNEtY6FKugS3+/MuLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4C2inoo0BAJ8leo6qHQSF2IuEa9uET0hXnK2pmBvFAY=;
 b=Li9e9MpdZuDRv01EYuOvSTusvLHEvPdl0pIqdnjzJMb04npFWBJOUahF8IYBZER66ikVZwbMGuzdDIgYWVgR6Mtw3NChnePOq9Xvp0iIXPRFc7QWuUqzySP1wrfEfmtQ5Zyrez+/hcoYJEK1+bMLg+upKH1wM+s3fp3t+Tinp0w=
Received: from BYAPR04MB3800.namprd04.prod.outlook.com (2603:10b6:a02:ad::20)
 by BYAPR04MB5157.namprd04.prod.outlook.com (2603:10b6:a03:48::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.28; Thu, 11 Mar
 2021 02:15:23 +0000
Received: from BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::61ad:9cbe:7867:6972]) by BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::61ad:9cbe:7867:6972%7]) with mapi id 15.20.3890.041; Thu, 11 Mar 2021
 02:15:22 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Jan Kara <jack@suse.cz>,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v2] block: Discard page cache of zone reset target range
Thread-Topic: [PATCH v2] block: Discard page cache of zone reset target range
Thread-Index: AQHXFXmfhLIk75QAv0ub8EV3oNPybKp86HKAgAElYYA=
Date:   Thu, 11 Mar 2021 02:15:22 +0000
Message-ID: <20210311021521.tgnifnhpd2d5z2c7@shindev.dhcp.fujisawa.hgst.com>
References: <20210310065003.573474-1-shinichiro.kawasaki@wdc.com>
 <20210310084519.GB682482@infradead.org>
In-Reply-To: <20210310084519.GB682482@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 57031557-1dbf-44b1-16a9-08d8e43386d0
x-ms-traffictypediagnostic: BYAPR04MB5157:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5157D24AE2C0757DF5247DFBED909@BYAPR04MB5157.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XztJ5TpEUoBzJYymwEjSu+BOZz41KLoLEVDRD0m/0L/8/KWoLQE+e/hgDwe/rSGmfK70ykEmBWhzKgM0/i1rvT2xd7VE5JB/zgpD3qpa/ySRhk9NQbxpiiDDrdKtzA9Bk4vY/+/Of3rvZgOni/lql7cPaFS2hqiIDKR3TapDdqs0K9XLRHYkL6bFRhT/qbuqpdwO23O452CnPCtgOE2MCdTe2n5ooBUqme29nKF3lt7TTYAD+vUl3/jakX7DLBbJUj54zB7ISGKY44fvmvG4pHh3pyDodEEImCgWfOt71lBQ4+BKPYN2u0s1l+ffgYs7RyjZ/xCxHVVJmu3c2F6uNkdgRg8OKyAsxuceyGnKg1CrJCv8fAh+aXKr5uE4J2saD5+CERjoa9P9vgJ7H33i3PUTSZgw2j3pcIH5VAdPMj75tyv2usj667734sAskKIkEzrYysShhg+XlxALFMM9lT0OL6AUB0KzHzUN8zURs4V8UHBOslQmxfkKg6yWzSFc2fZw3cUuIEvT0Fb4Z5k2Bw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB3800.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(44832011)(71200400001)(26005)(316002)(66446008)(6916009)(91956017)(4326008)(5660300002)(1076003)(6486002)(66476007)(8676002)(76116006)(83380400001)(186003)(2906002)(54906003)(66946007)(8936002)(9686003)(6512007)(86362001)(64756008)(478600001)(66556008)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/48d5jNO+CKZ63ueIQ0/p7UME084JSd89LYo3Pl1+tf4O9Oz1EuEg2TexJ23?=
 =?us-ascii?Q?UdqADmQzn83GwlDp4moSUVisdWVRQ2EXUFjorv+Za76j676wufQzLPd1MWYv?=
 =?us-ascii?Q?t63VR6HOocef7RldQ463YTcEoIhLrfx0VSxYgEM7buRiOnVQCwGHFKvjcvcw?=
 =?us-ascii?Q?bOMJKP8nDantX6yxPhAU/wa/iEHUbLAWs4eKlremKdE0oA3RiVe2S4BFE5Go?=
 =?us-ascii?Q?2UIvE7Ryki0sF1NaB8FTab7LX8uGV+xSqk9LTVM8kU6OhTX3WmFLlG3WvbsE?=
 =?us-ascii?Q?C6kINp3qdihnJcHHNema/725npf3b/SEGrdkfhYrzbP5A82N7fImUxRJBEsE?=
 =?us-ascii?Q?BK3A59K1SJ8j36tj0+fPB+wufDXwDwrfTBJnk7ChSNoPlSbpAuFhPh90KvvW?=
 =?us-ascii?Q?SOd7c5FxToGF+X6Kn6eqLxUhSzDbL2JLDYLSuwQT8i35yy8yC74j4Gyuv5Bn?=
 =?us-ascii?Q?iwtDSihMtdxGXgdx+Dmdk3P23Xj26oeXVfvzNXLXgWM0PwHUlYY9b2JuHy/g?=
 =?us-ascii?Q?T4zE4HCeP0gijqSuS4380tGtfMLHXw916V8pVrpLLAqgIt1ftuP7HKP3dNsk?=
 =?us-ascii?Q?qNRJ6GbzhNgr8zX04Li8jyDCZeOxoTRz+lJx2QzRSO4GGMvsRktQfsOl2Ne0?=
 =?us-ascii?Q?qAIwqb6IjdmyIqT1tMdXingPqTzHl06MrNAE16I/pmv2jQAlR/QTXNUd7Qju?=
 =?us-ascii?Q?qRnqyd9RF3GPGBlXz3NsSB9rubv6dq4ey8f713Oo0Bsxptd7Df4s9J8wmLQH?=
 =?us-ascii?Q?MzFCXA5iGLfHTYZGQnGaOIHbI8wREfC1JaL6aouLBKjNdEhFryAFjFyxjslA?=
 =?us-ascii?Q?6LK95X2waFa9JqV86Bui5QCCYkG+AfibQWJs4i/ltP6LEA+XwXeTklURXkhU?=
 =?us-ascii?Q?FpLGc5zmNnz6gF97/YH0VX9sgrdcq12Rgv1agKfOLINzef1z4QQ5ZebSP2ay?=
 =?us-ascii?Q?ivej0Trom324ptiYOSAgHwvy3lRigzuMZADHITOZbDAnIth0N5zd6ukSN6dv?=
 =?us-ascii?Q?WlQOcgg3UtyO76AeWYgncc92++nZPXvRf7GH947Oi/Sop4fej3jZIg5AIDmh?=
 =?us-ascii?Q?b5+BNYpxTOiU8tDu+UnhUVUYwYUXAFyabxhkkSyE0HakAxJBQbWJ+kcSu684?=
 =?us-ascii?Q?ycsapWHvhEKPcPq+Q4x4kPhVP/+HflAYf0VwBGR6IIrzEUYJ2pizjNe8Emq/?=
 =?us-ascii?Q?nrJQ7wULq683YXEAFLZq7Dujxb2zmxrEPK+bWG4wWxjssgtX2xC0L34DbI4J?=
 =?us-ascii?Q?JFL10WDeZ5VFtYPzd7DQOvMbG8Xl5hVQF/q9prxnX/b8OmY33sHoxoAa92n9?=
 =?us-ascii?Q?POUSZ/nCkADTxoIyWNxt/Vsv0ZzJ2qBUBa3w3IEeXBoroQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C3F7666648B5444FB1FB3AF825FF86F8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB3800.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57031557-1dbf-44b1-16a9-08d8e43386d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 02:15:22.7695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uqZ/oCNy4+PXQG1DjfsU8Jial4xP7VcUnqTYJuhdynSMx2JvWU2XUa0i/FKYRYfCjEtnFQIcKKGBW0vQtQTo17IFcbj6bMeaFV/+3XllVIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5157
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 10, 2021 / 08:45, Christoph Hellwig wrote:
> >  	switch (cmd) {
> >  	case BLKRESETZONE:
> >  		op =3D REQ_OP_ZONE_RESET;
> > +
> > +		capacity =3D get_capacity(bdev->bd_disk);
> > +		if (zrange.sector + zrange.nr_sectors <=3D zrange.sector ||
> > +		    zrange.sector + zrange.nr_sectors > capacity)
> > +			/* Out of range */
> > +			return -EINVAL;
> > +
> > +		start =3D zrange.sector << SECTOR_SHIFT;
> > +		end =3D ((zrange.sector + zrange.nr_sectors) << SECTOR_SHIFT) - 1;
> > +
> > +		/* Invalidate the page cache, including dirty pages. */
> > +		ret =3D truncate_bdev_range(bdev, mode, start, end);
> > +		if (ret)
> > +			return ret;
>=20
> Can we factor this out into a truncate_zone_range() helper?

Yes, we can. The helper will be as follows. I will rework the patch and sen=
d v3.

static int blkdev_truncate_zone_range(struct block_device *bdev, fmode_t mo=
de,
				      const struct blk_zone_range *zrange)
{
	loff_t start, end;

	if (zrange->sector + zrange->nr_sectors <=3D zrange->sector ||
	    zrange->sector + zrange->nr_sectors > get_capacity(bdev->bd_disk))
		/* Out of range */
		return -EINVAL;

	start =3D zrange->sector << SECTOR_SHIFT;
	end =3D ((zrange->sector + zrange->nr_sectors) << SECTOR_SHIFT) - 1;

	return truncate_bdev_range(bdev, mode, start, end);
}

--=20
Best Regards,
Shin'ichiro Kawasaki=
