Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A21C433B4
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 12:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3C9B6191D
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 12:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhEKMYe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 May 2021 08:24:34 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:29439 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbhEKMYd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 May 2021 08:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620735840; x=1652271840;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eS9MYCQ3xpeID6k2tTa5ENqVW3F/0KXp+ngN0HVSsVE=;
  b=qndF0WkNIOFa/1aCI/6JzxV8m3M4wvEJffBegFX+NR/vpyIEwXE7qsDt
   1PfSn6xnIYDdMjeT6i2Bn2VjzYtoSpYQE1xYJl0HqtyQRBGnXgkVYnCxm
   E2EXQzdq4y/4GYVUhLxAGcD7rjxFu/SL18GoEVWPmPATJMqDD6FchcRw/
   byno8hVFxgbtUk9A6z6nkj9DQ1W4gjACBKvrvoJi2I9GARxFL8xjQIcHO
   HZaPsmnEVHxcMYwVHHgS3hXGAG6D6Qsd8BALhYRfM8Rtq67HSVc8SkvCM
   qvFLZcaUTNsRldbiFVPol9R+XJfARcDza1yCdkZb2JHP4XSm9T/mblcBT
   A==;
IronPort-SDR: 8KcVHvMaD1tkdYp2Xrncx5e/ZH8vneGT648GkIY/vYwzMTYAm6GRym526CV7bmnCBmxT9Pn+1v
 bDihtXGB2fHHUDYShqVmT/V2b+1CKRh+l+z4K6J0NXILQdrbm2kGvhxWr18bhNEjVUH7oRkmnC
 uyUM3ZK7bJmsfYuqCihbxLsUdj5ZjnyxU9GzRYF68pyAmwJ7H4J8zOmQ99LYnbuttajQE2ebtE
 Dgyuta85ocm21lhpJ5SYTfYdn55dzvVLMQ3K7lTjMLLIXjzZ/6nZgCrSPWCYkX2QJg2HdmRbCl
 BJM=
X-IronPort-AV: E=Sophos;i="5.82,290,1613404800"; 
   d="scan'208";a="271731641"
Received: from mail-bn1nam07lp2044.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.44])
  by ob1.hgst.iphmx.com with ESMTP; 11 May 2021 20:23:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RizSI5epJCr/98JBuoP1pf7fBvSdHUAkaYskZTSHXuE8YciqEkmazXYVA0MX1xG3ltOXMdFo4emg/iw10Hlp1f1gR4dl9yMlTII/+SStX7WuQz2vGIFZo9w50uyg22+efQJ1KwkOabwOJFaru9THkS00Cyyzy09Uty9AAWx6fTIMWVnd5RNlnr7Ec45bh0riq72qm8cBpM0dp3YMssg1foNnHvShB8fscfFBoJLt9pPISWZYuF3yHV7F2aCj5Mft6GWQI7d2FWv9oDuzwhdhjCVkRLZNSQN0aHlke9DnDIlNN7Z6n9bA8crtwHBSFAkUOYO3uxHqjS1QlLmYRO0mDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jK0ocV1GDHK8OQCm3gSDef42vqSRQI9uAt+6AV2Veac=;
 b=BfAEaWXUvbYi22fkr2FOvq7Bld/DQYFmTKGIwDNxiZCVny5/YAYSHleE/gmSiNUXB8NbjHGfPxntM/TKD/d1ca8/LFQaRq/szDfBgiWoWz48K0qJH1j3p1ImUHOyaMs3IYXpC5tLy1Lw67Ro4ZC+mqCgEQqM+MP8iSeGkyiAIVy45WLAmEc00dWejNVTahCGBItEmy6fFOXv00nyJGA33W1kGijrHzySN6onS/X9fSZVxe9jkbLW7lB6YLWz3z+SyHatM+oxqidn7UXCYeUJ7etx0TPQC3X7fRNA4L0h591euJ0Dq9r/yPpxTTWmLCKbwez/xUUPZ4lNSyjVK9m4bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jK0ocV1GDHK8OQCm3gSDef42vqSRQI9uAt+6AV2Veac=;
 b=VGYTcS56G9+XTZrusRGf5HEvbTRdvb/qsh6mEjV0rCNj137LQBPU66h6ncLLaopzjcE38nFkJfVAfDnE5YEhNLSmEdzXwt+Y1cyS7W5406UXTTINN+82OE4RNR+4PcmLyW0PbV6J5Hf87zWqMdeNFywnP6rrty8fNDE2UNY0Q34=
Received: from BYAPR04MB3800.namprd04.prod.outlook.com (2603:10b6:a02:ad::20)
 by BYAPR04MB5733.namprd04.prod.outlook.com (2603:10b6:a03:109::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Tue, 11 May
 2021 12:23:22 +0000
Received: from BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::6052:9dde:2486:109e]) by BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::6052:9dde:2486:109e%5]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 12:23:21 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        Christoph Hellwig <hch@lst.de>,
        David Jeffery <djeffery@redhat.com>
Subject: Re: [PATCH V6 0/4] blk-mq: fix request UAF related with iterating
 over tagset requests
Thread-Topic: [PATCH V6 0/4] blk-mq: fix request UAF related with iterating
 over tagset requests
Thread-Index: AQHXQ083BdicgrD1B0CPNWzyxvFGxKrdwAGAgAAZaICAAGDTAA==
Date:   Tue, 11 May 2021 12:23:21 +0000
Message-ID: <20210511122320.2dimco7hb5qm3rjv@shindev.dhcp.fujisawa.hgst.com>
References: <20210507144208.459139-1-ming.lei@redhat.com>
 <20210511050551.3m62ut7nfz2gvqgh@shindev.dhcp.fujisawa.hgst.com>
 <YJol/7YGUxWbBdiK@T590>
In-Reply-To: <YJol/7YGUxWbBdiK@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e401ae4-f43e-41ef-4d8c-08d914779132
x-ms-traffictypediagnostic: BYAPR04MB5733:
x-microsoft-antispam-prvs: <BYAPR04MB5733F244C8F97D4D98D9E5A3ED539@BYAPR04MB5733.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Mi3ujbSYPprWDPeN+icjpIdWxWstzikzToL5e0F0vqkGcuE4SXYHZC5DGYkc9Fnm58RLxzbzAi6vd4wBWDtEvGz8HGcKgqscG+k6JR356MADxwI64YnetW9q46KyvxHBlwx3q6LQ4lDqnJ3B79FZM6g6yn2p2Ba2xRTBkaiprW1oEm+8UpaaexvmMGqlYFOLG9quHlY6USs4HU7JaZykoMbz3YHresEiSJsZZtOKQnBN9iVjs3C+wbZSqXYcz0Rt3SV0LNKwtWMSEBi4Bz7Ekt03Ei9RHHOo/ZrZtyJ74NjPmib067UmtXncXFYPxehFav06Uo64z/PK+fDkC2BZ1qLYVRnagf9vyQudKwseY8G7IxlaenJIfdSxE4JqQSGSYyguM721/pU/9jjoka86vOJCWFHLlkxvjgSR+PRFuuzHbK5DVYCBR+t/LLIjUkXoemPiahxletuAvtla8D84nBlJb80/cu0hQrB+3rW2TVI3u4aCWJ0TsSksLU92fmYO8kpbwDbMvK1RkxhbFE/43AdwRThOIhrfE3K8MUsNzxfa+8wVP7RZ2CqmacGN5gwTkxiI60RIO50OKhOAX8THIUZEcag9f1O4Mj/ecxXnHw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB3800.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(8676002)(54906003)(6916009)(2906002)(44832011)(38100700002)(1076003)(71200400001)(316002)(6506007)(26005)(186003)(478600001)(122000001)(66476007)(6486002)(76116006)(86362001)(4326008)(64756008)(66446008)(8936002)(66556008)(83380400001)(5660300002)(9686003)(66946007)(91956017)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FoSNNDQX4m92ODn9ffwJv4JKHOdJKW3crAeuSrB+iCTA8npwEYkECnGuy7CF?=
 =?us-ascii?Q?eTXjypQsDPHg58g2JyJIoak6HZp3cZUdBPLtjkB5nLLKbJC84iSEjAWOqCWE?=
 =?us-ascii?Q?xL4emNZcublEIs81apOhfseH3y9Vm1sbc7enN0iy4Gaibx9iRwdTBkb7ogUm?=
 =?us-ascii?Q?+wl/j0QqusXJ6mWA4pn0y7lyOS8Qexld8XhYHzocoD81wflMJaYmdJhgDX6+?=
 =?us-ascii?Q?NF/ApV7G/AmR05vYa/rOJyHteocN8J60JVnAe3B9kVHy9mZ9S2cST5Gz+i94?=
 =?us-ascii?Q?Cnyesh6kEALA60Qok8g95C496nNWI9/sJukUTkYmKr7PvBXP2g8YpRIDAJ+E?=
 =?us-ascii?Q?tAIgRhsH3bD9+Hl5PhZD41og3R24Vp/54Lg7LZ08a+FuzYRHJ6ZddQ/C5I8j?=
 =?us-ascii?Q?a+ROQ/OzfzacwihXod4HuxHvgzLyORkFjXT23jeUU2Zu6oXf7ZHIJv6NYO03?=
 =?us-ascii?Q?rXUG+rgnFEMumnXXXTVbxUudD2kqV/YbiLRNzYjpfIOQRqRBSgNJ0gPlZk/D?=
 =?us-ascii?Q?1mxktBAso8P3HgiR5cUGa/n1ZCGKazDpvh/lq1r/ahgBNo1LnqtPqMdPhjdI?=
 =?us-ascii?Q?Kvcv5ffOqJELTwfMxyUYpmNO4Ux8oWUEA8nTxkorEPPZpbM/zulAW+TtKun7?=
 =?us-ascii?Q?Z9tF3QdIgKD5KDNw+bpJU2dJq7kjXr67VrvihOt/fBQXAyY9WCXx4XK2FOOP?=
 =?us-ascii?Q?Z0iGakHNVNCL75g6s/vKwOelpqvzxOyei/iEm0QsEFU3ZJEHWS2v7DwW1i3Q?=
 =?us-ascii?Q?0pw15/vUhxAU7fZw/hl/JOsXx42pD6pTO/R0fqLPwgQMYkLxCZnxNsuFWECS?=
 =?us-ascii?Q?AHoAC604FhGY2OdT6sSbzSP3wqb72Sm5+q/hczkBbFRaILRhPOFt2LYWtDgp?=
 =?us-ascii?Q?NrRyHIFwKl/xQbCpl+y++XQ5J7wjdi9ve9KG/ocfrwVNCLssVxD/Rbd5z+yy?=
 =?us-ascii?Q?OxSpG1wFGQOCSt9BHS9JZ5BOzhbIcohxNbQBN2qF6t1TmhLfUhbaeFgZ3IyF?=
 =?us-ascii?Q?7MsOeIM4hNiJUARbyqCczrfRUX2IzXy6MWECR0HgFMl/uAq9ISIfKO6ZmHUb?=
 =?us-ascii?Q?MxQO0Rq5lau6ImuXkbjtH1JF7QxriZwLE6h6Cj+sz+Iq45jZ1FS8nV3eWT2t?=
 =?us-ascii?Q?F+BGmB3FHGLGl9ur46kU1c1jpAlFDcAG0wUNAsTtggiMdn5T0WwbV5YFOYOP?=
 =?us-ascii?Q?ZM8yc3SaBBjTqUVytjPv+yDO5x+gUXl6wksoFiCRviGnyyBOlDVw5MHTI6Rw?=
 =?us-ascii?Q?CeL/7iGnvMNdPwIGydFfnR511oWfLYWusxDy94jEqXUDa8sExQiPLupLfk95?=
 =?us-ascii?Q?FD6GPOTiEpjWIy+1Osn9pTWZfTWR4bwSfCeqmx6DmpgPgQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1E4BE7BF8E747D4A97C811CCBFDFC8FD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB3800.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e401ae4-f43e-41ef-4d8c-08d914779132
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 12:23:21.8253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e041mWNgxr/GBl/DfNg05G4JUtQJLHw6idFfeqZx8NJLTGFjMno/1HaxU+tmjHnyz1fc44qkV76C3+4O4SDhllhWkXZPRV0kGV7zj7ViXmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5733
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 11, 2021 / 14:36, Ming Lei wrote:
> Hello Shinichiro,
>=20
> Thanks for your test!
>=20
> On Tue, May 11, 2021 at 05:05:52AM +0000, Shinichiro Kawasaki wrote:
> > On May 07, 2021 / 22:42, Ming Lei wrote:
> > > Hi Jens,
> > >=20
> > > This patchset fixes the request UAF issue by one simple approach,
> > > without clearing ->rqs[] in fast path, please consider it for 5.13.
> > >=20
> > > 1) grab request's ref before calling ->fn in blk_mq_tagset_busy_iter,
> > > and release it after calling ->fn, so ->fn won't be called for one
> > > request if its queue is frozen, done in 2st patch
> > >=20
> > > 2) clearing any stale request referred in ->rqs[] before freeing the
> > > request pool, one per-tags spinlock is added for protecting
> > > grabbing request ref vs. clearing ->rqs[tag], so UAF by refcount_inc_=
not_zero
> > > in bt_tags_iter() is avoided, done in 3rd patch.
> >=20
> > Ming, thank you for your effort to fix the UAF issue. I applied the V6 =
series to
> > the kernel v5.13-rc1, and confirmed that the series avoids the UAF I ha=
d been
> > observing with blktests block/005 and HDD behind HBA. This is good. How=
ever, I
> > found that the series triggered block/029 hang. Let me share the kernel=
 message
> > below, which was printed at the hang. KASAN reported null-ptr-deref.
> >=20
> > [ 2124.489023] run blktests block/029 at 2021-05-11 13:42:22
> > [ 2124.561386] null_blk: module loaded
> > [ 2125.201166] general protection fault, probably for non-canonical add=
ress 0xdffffc0000000012: 0000 [#1] SMP KASAN PTI
> > [ 2125.212387] KASAN: null-ptr-deref in range [0x0000000000000090-0x000=
0000000000097]
>=20
> It is because this hw queue isn't mapped yet and new added hw queue is
> mapped in blk_mq_map_swqueue(), and the following change can fix it, and
> I will post V7 after careful test.
>=20
>=20
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index fcd5ed79011f..691b555c26fa 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2652,6 +2652,10 @@ static void blk_mq_clear_flush_rq_mapping(struct b=
lk_mq_tags *tags,
>  	int i;
>  	unsigned long flags;
> =20
> +	/* return if hw queue isn't mapped */
> +	if (!tags)
> +		return;
> +
>  	WARN_ON_ONCE(refcount_read(&flush_rq->ref) !=3D 0);
> =20
>  	for (i =3D 0; i < queue_depth; i++)

Thank you Ming. I confirmed that this change avoids the hang at block/029.

--=20
Best Regards,
Shin'ichiro Kawasaki=
