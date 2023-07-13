Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71623C0015E
	for <linux-block@archiver.kernel.org>; Thu, 13 Jul 2023 11:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbjGML4Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jul 2023 07:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbjGML4Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jul 2023 07:56:24 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D18D1FDB
        for <linux-block@vger.kernel.org>; Thu, 13 Jul 2023 04:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1689249382; x=1720785382;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9dKxs0Or1BuRZu1zQeBD1DTbOyRH3Li6ZJPg6D5JVIY=;
  b=LSkWGddGmE1R2f13iHT5mqjBWM91YiTqux7VSQ7CM1QUXusS1sZo9XJk
   Dk71kkqgLTnfTZ29lf+Hq8to6TukUBZTEnf4TSnAaNx5c7eadGw+uzLH2
   u8UV0adjIM++TEoCbyoElKK5WZlY/QUXWa64IF8trlhejIN4uPwoxfxb/
   G/nam9zGnN/D8TjpDwdOKfa8HUm0LIx1ztUrPUN3I6L8Ju2Drk5V1Z2NI
   NrbssXbfYuqyhRqDb2khmtMtUPv23Ah3jidk8YPb8h2QhA3M847MWhy4P
   8s7CfjNo5OlXw6Pdkzcgz5G7390LNGPCpnqD+WDMlL1oU6uKsP2WIG4J8
   A==;
X-IronPort-AV: E=Sophos;i="6.01,202,1684771200"; 
   d="scan'208";a="237706943"
Received: from mail-bn8nam04lp2041.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.41])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2023 19:56:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVv3zekJMWtuXQqdNuhpDQtdHM0KMSDr6cAmbT+pzmjqfP4m7RQcxxDN97J6bo161VqbFEWHkxY5NX7WjmV9AZ38oe0l+nS4nakIWw2ucu9N44uzQcwwUXGgxN9ymk10lpOB16Y5AI88z2uqshncILi//0dmU+lb1rdFoHtpcoAEFHEeEE0ENADHD/dquI+im3MYrTInutu9QUh8IqsqhbIIusEUw1Bwuq4Y9OjWlW3nUhlIitkVk18lPYIqAxYjPptlW/4lbhZ6gjTYItrIeG/Fr8fy6di0QcXDSej/xCynk/snYbSQkZ6RC8sD4kDNOLV+vzlIrEmkWymAdSRZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAIHZiad/sd8xKaoRLZ945DaN/0td+ZIzoB/s489efc=;
 b=DapgIcwoqRbV9SI1BvZieVGRZunEz4vSvaOEafYBVcRDn1Ak+MgMCSLZJ7KaCbMzDzi1Bjf8tkCWmzy9zsB0qNhUM84RvhDfxPbg6kvcns9xIZdZFUk2Xq5VF6mQJNI49DbQrjrPGecZi3hiFiMvZSGa1ejoXcQjnXjE/9nYmL8p5FIpi99wO7OIr0Q5WNa5XfUC7Z1bS/DevcJPNcgujf+zGxWRxOrlzggF1wbhEHegSg+w8acd07F3SxspOUbdlN/vZAdjgriVWXOX0qWyNbS3p2Wrs6rwg7ibI0o+jdmHxZNPogGtIT0N7HMOJQqsHTpUlUOh5RrDlbivntKBkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAIHZiad/sd8xKaoRLZ945DaN/0td+ZIzoB/s489efc=;
 b=fnwPK0EexuSfQ30Okd8TNAFzs5Ah5briICUmj6TQ3X/WLEtm6bkjjusPNv0gU2DfDyx3ZN73fNxIa7T8m1MnXbFpu3kehihiqzDaeTRjticw9KJBFda5fJ+x2JM+l1BxkavoaRPEEP1w1NziHFwit5urV2Ow8oZVInwkvrEZZN0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA3PR04MB8748.namprd04.prod.outlook.com (2603:10b6:806:2f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Thu, 13 Jul
 2023 11:56:17 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%7]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 11:56:17 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [bug report] f2fs mount failure on zoned block devices
Thread-Topic: [bug report] f2fs mount failure on zoned block devices
Thread-Index: AQHZtXqWvEj1MKroG0CyZtEYFKT/da+3jNmAgAAKQAA=
Date:   Thu, 13 Jul 2023 11:56:17 +0000
Message-ID: <h3pgym57jcc4o34bu3svcbppg4osvj3oqczamkpen6bkd3njy3@pbu2nilimghx>
References: <5ncdtsl3nycvxwldjg27yhqbt3pg6sdnjlynucbt536fudq7pg@o4zhoxt224jm>
 <20230713111935.GA22470@lst.de>
In-Reply-To: <20230713111935.GA22470@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA3PR04MB8748:EE_
x-ms-office365-filtering-correlation-id: 10f7e578-0347-49fd-a189-08db83982a7f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 80HxZMgfVoa19CgOv6JhTGejuhMeVYXf28EqSEk2m1FAp2S5cXdC0G6iRzuvpkUui7FUvmJWjLcdiUTni3kXjCURJ3MEWHA8C+xhJD+TOS+8Zt6mMyZqI++9WRKDkIQULUoTT7NdgraSwv8CvdenFa/8kIa+nTuNGfovSgcDu7sOG6/3PgvJ293yJ4ug9XooM3iKJ4YFSoMJdmbfiaiCoIQoZ2no6vX6AORkq209v6FJ6hiEbOvn5fD4zyDEv7xO1wdxZXYvL8mhVP+sDxB0c2YuRdyxlun5+KX2QATt9zMrusX3MDxMjAttqLxQ3IaClrDcfCN5wjbYN9FIY8mTvItPSyBFw3vOnQLZBs4myPAV3QXa83tGHhpS0bMd5J88a6hTK1EinLjtqsa3hP0ErPbmdjh8rEHOpXXrwh3pJMhwvf2RhTCe314A09R2Ek5/bi71FviYox6KiA8zlS+OaC5pvfEACyVe7MPaa8G0i0spwPVF5nfvDuB1YAewC0K+C3rqHj6Rjs8nS3H2rR+qDqUOUfA77HFH2X3+ZsCP/FDFgaBhC+8+Kf7Iibfin5Ug8ZILEHxBuilwcRttp7V/hbdnVbWie+tDY/6lkGkdiX4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199021)(64756008)(83380400001)(4744005)(2906002)(66446008)(38070700005)(54906003)(38100700002)(6486002)(91956017)(82960400001)(71200400001)(122000001)(33716001)(66946007)(4326008)(6916009)(66556008)(66476007)(76116006)(316002)(966005)(6512007)(186003)(6506007)(86362001)(478600001)(44832011)(9686003)(41300700001)(8676002)(8936002)(26005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aoPDvSzoUMl4WryP3EMEfg5dE011CPHKsN5xjVhip0tUAMzV0XPf+x9JwEBq?=
 =?us-ascii?Q?tAreBVpq7FYasQsluSZpK4qFwK4TzABG98Tul7PHIz5osQwRN94JF1ygkAp7?=
 =?us-ascii?Q?LFmPJvhAQh+ZojuTySHkXkEJvzk8zY7to3YYhSMyqor1bz26DwZcpG0U42vk?=
 =?us-ascii?Q?6UuP4XOQUDsu91zPIkkjBxyi8o46X/Oax3GgpdglIMCuxTW8nlbt+0cfYcR9?=
 =?us-ascii?Q?vpFs6NnTDPLhSdmuBqUmWM2E80GuqFqlLhwdZb8mBJt/RwHdVbcdlL1M1svV?=
 =?us-ascii?Q?pobNN7Dxifv8SdmiRY/7Mxo6UjqtEW8ajcR5cBQM4eyqONdcX684ymc94O2t?=
 =?us-ascii?Q?OHDsVnAtgveWiahVdivzguBTVFB49w2xYh3woAfUSmNb2EYc6TVHw8/FGw4w?=
 =?us-ascii?Q?DyfNtmYNiv0FdKYuY6gMOwdDOMcbCTeXIDMkoqy/bTi046iiqP3f2HVy9Fbc?=
 =?us-ascii?Q?62DJlG1+qSvW3PgV8NSvfhWVhSpSpKyhDfQnoVKliaEXAfto9tIxPX6HMBaq?=
 =?us-ascii?Q?MmZ8C9SUA2boQxrF2ZLrvTvnlOgryE8IdbnM6+gs3CBSRCnu6SmIbmAGKc+i?=
 =?us-ascii?Q?tQBtfsyc5x7T1j02Y3eqBB9UBQWU+dORaHq11XQWA4Os8Ofl7AipxE1B6mX+?=
 =?us-ascii?Q?HTUsCO31eKOZU5oS016/b62tUhN4FFj/JuY9qd1wJ5F8NGA+CFCLEHaVCu9T?=
 =?us-ascii?Q?PhdJfVNnQ3zWwMzsDvhzbmw7dtSbqG0BYq88TDvJFkAFF5QFGPrxMM81ZDcg?=
 =?us-ascii?Q?4qDbyI/0h8EvzUIXPNBWlAdE+b9U1ZnOQ11TNUWmYOcinXnQffgWK8mkdm7V?=
 =?us-ascii?Q?y1HJBv+HU52yBxbvZYyhAb+lwvrSrfBqrtkfn07nZhSxa8pxv9MpjSGB10Yz?=
 =?us-ascii?Q?fQW3nvOgi6atn/1Mb6SdtWi2SebtOFYm7To4blmJgCk0JTefPk1mSBl5aMSW?=
 =?us-ascii?Q?FPqvgyjNUt5e9zOfkhMmIhWJg+yOzNuOjzoI6vm3aZe27Ea7KNMgn3m1CqG/?=
 =?us-ascii?Q?9fWZjip1u60xjiIM7cFAUmujmvfygMj2Ftn7NjS3ftg8xI4GtBO60x4psWV8?=
 =?us-ascii?Q?PEL69z0ALhoavX5yC9/S4rH1ZSz/EdEJx3K1cZz/gGoHSijwLEgoIt4zf/qv?=
 =?us-ascii?Q?RTFtMwS0wUa/quQ1coOfHSB79sdXg7LE1t0435k9aPxMeVpIEYiUS0eazsUM?=
 =?us-ascii?Q?qu+FMIBswwvNquDyvffb6zfQgGRu8gKU176S6NvdkddI04sIU/5QHcp2cbsL?=
 =?us-ascii?Q?vSDRV2uYRKh+pFh0B9z4jOUvIiyI/2EyIekIMY/VLAMKcg4wNiWwJlXOHobX?=
 =?us-ascii?Q?WplIpz32U8rUcEOVhnfiNwpDS9mDVGQyiEmQEbDEdyJyFPnA6NTsY09XI5gT?=
 =?us-ascii?Q?/vvZFd2H+GKnXFIsPZ3URCvVEDpv77/Jv7vmck+KaoTz64uEpkyNLxcZxV67?=
 =?us-ascii?Q?3WAlYjAnQ1gRENUkS4R0sXhYHpYcx0U3Edt3Avfp1Q1t8yTrrRQmJ2WUl4pj?=
 =?us-ascii?Q?S0fuPyepX+n2dN59FPyCUJ6/0QKD7kciY4SaIbE52dsgtVZ3MIfeeEiuJnvw?=
 =?us-ascii?Q?NjS4VHG+6rGkPkPCHb4KKHTQk+kzSR6ydtUWoZ30xd6ompeXFvptW2rzz1vr?=
 =?us-ascii?Q?K/SBPu18z1AgCmnmsLAweD4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <830B62E8C2599A4FBF51FD4827F47552@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: a0f478k9sKCsL5F2BJfakdV/pvwD4iX+jDdPYGE4/8c3zvA3xouaNWAR69r946k54OByohwvRV2LF7kA9vvyZA6FQdzrzvei519px6bz2UPUXV7hMilf8j4rJjePbkkceySOBtYkFWlKAzCkPtWAleBceffd2o18F/GQ5r8/qk2ZCcV4AJwrG0nC4voVXN6cXdMISrO0oRn4p7zaIIwS1IG1SlejIg5WnElw4+lnVc44XssOenT7PNGWhWQ1X1HJzrB3eVrrC4xNeG9UIF4nONX6cMgwXrzQPJY4KUrP0GlrLwrzs0wEg02K8rJX1tWMhfmhxaIvnDOrEBa7xBGcdJHVM2a7yx7iaNLxGRixklQApn6RDVo5bnOJsK/j5bcZzKFftWf0KCh/igkgce/OLg/LdEsBwFzq8fz42vvv3MDyQyK1ISncpsSEZk7DOPQarBZOG/Pk/yhP/78eJGDByxjb2pzN7NDuCXJR/ia8gzoPlMGWOnPEsVyucVWn/c7+IVBeWzHLQ7mdje9JYHSNnabQ2MbgacBp/v3BsfKa4CQ+n4/FgRzMNPXklWt0cZyv3+3NuPIAdG8ry0UIOrIKdIA4pHVQtwiZ5od1q3eNRHp0uXtlpF/BtmS8/Pi8Edz1xS58wcbbdaXPBzAQkIbCicWCKwHJdPAOJdDq61462tlnSW8jFqBSfWEXQd34J4vpWg0Eq409VSPi5b3gyHWxDTVf85lRb5CjXMBLbN73ezNJ61+qJ6FfQAoFezBaH3zdaFnk7sXkDgimTlhnD3THX0sW9jBg7gXwctRFaGsCilySlEC9husnpBhXp1/V+J92pXrCdOS922n8b8jzUcGSjAGdA0Za4F6OQM0Wd2KOwRs=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f7e578-0347-49fd-a189-08db83982a7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 11:56:17.3787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XkVt7oAbPVoNopw/OZEpKugM3m9Gh9TERSVYTtSx5gOf1m6zBYP87lqz8yaadM+lub42Z93bzHOKEGztOX2cdT+GQZAmWgESCzjSgeNCcyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8748
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jul 13, 2023 / 13:19, Christoph Hellwig wrote:
> Take a look at the "f2fs: don't reopen the main block device in
> f2fs_scan_devices" thread on the block list.  The first version of patch
> still had issues, but there is an updated on deeper in the thread.

Thanks! I found the second patch in the thread [*] and confirmed it avoids =
the
mount failure. It also allows the test case zbd/010 pass. Looks good.

[*] https://lkml.kernel.org/linux-f2fs-devel/20230711050101.GA19128@lst.de/
