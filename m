Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA5DC76195
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 08:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjC1Ipo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 04:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjC1Ipn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 04:45:43 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248CA4EE5
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 01:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679993136; x=1711529136;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QnDDPyYVggg7wds9AA3GxGvfhcCH3BcOSDfvJjqrDdA=;
  b=pQrglB7DRb6NEyX7feODBybfQJbkeXNX44ZsaaX1kd5FRArD/j/Nv8R1
   FPEuw1abY/bxBr+r9ZUw6kLj9hEyXWSIX28kbST7efa+NGFzwUEfyCVEA
   PAro17odWrxxhv18PdlwK1te6JPGfXLm73pmGxIUr01HYUCzllkpdBq7u
   g52XSjaLQsnMRhArNC7+7Rq2idilpc8XDg6VsykvmRLGDaMRGmPlf/h7o
   G5WVZfjVUCdfyP24XkZrSOc6lXrM8ng8CDin8FINjTrwKwDCrSdbdPhpm
   +pW9RzVozXRSk5dRIvtiA6WKZ+5CLT4FWX3UCnwPNkbE6rrcMptHyVeqm
   g==;
X-IronPort-AV: E=Sophos;i="5.98,296,1673884800"; 
   d="scan'208";a="338742709"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2023 16:45:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIpncrtUa/KEj2H87RWCAivmN0vinxTOM6ezg7l5QnJcSqWyVjvV2s6AwiWzZKI4XlV9Lm72VpDd59Zp/XF/SCKohnWMT5hf3myxHk7YjopnvmqfEsG2AxdMD5HlxLC0wOi+lNT3Azp9YLZrjg6crGiSVgoU3gcqa/MMtD72z7aLa3DZ/SbKEszGGwVjco2MzX5CA+yuQ6J2U+bk/O5YxhrBnXS3d2+Hh7mBagKw/LTeeOM0y+OotWjNPxUt0IC2/9Pm4yqUvIXRM4/7TbDhawpVrIiUL3wW2kc11h9TTFFmAc68h2swA8N0hpM3vX67r8Ifd83CHnZydz0e2LOETg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/e/DHjKvXPU5Fq4LwXqRmuCW4lai39WqOzSdNtaiR90=;
 b=MzEomSuIW15/JqDcaee92I8Ttb/hR5tTGdnTHHQMQspETciCxFot6y1J3REjBIszkeKODc9YX8HhXC6K7+7sQp4zBAf09PrqSvPMKGzVSfKOVVjo12Sbk71SqVFKqk8nINHJ0Z99jgXbHDUdYc1lfJVFFfR8oAdyg2NuTZ+HuM0mZO9D9QxpobTnN+IDXkcZzs7g1BoYbfUrZoSSedlFLRngtjgwRe2OGk2LoZYwHhsPR4YMFcldNY7LcQ8QJgyZKZQ9Agdyp9FgmgZ8jVHnzei6hkVGFBMLxNiA2djkdS8mTH8/u2ywW0oduYqtV0w5ttZFcRT/dWqtbZf4lFrxdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/e/DHjKvXPU5Fq4LwXqRmuCW4lai39WqOzSdNtaiR90=;
 b=h2pEx2FzLwkFYm2lZdT83MJ4iXuhgtjqVM16rLzck7RUB1N7o6D54Ej/sKAJ1HPINyEUhxW4WX4unXuJov9pd6pzJUQXTSUz3ZgKj3c+PgY2uIUzkvBVzwZcJnilU5EQGpjRIadbjF4B1ZT6if6DIYF9RFypdJ9U7XoOT0yvSZE=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO6PR04MB7554.namprd04.prod.outlook.com (2603:10b6:303:ab::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.29; Tue, 28 Mar 2023 08:45:34 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529%9]) with mapi id 15.20.6222.033; Tue, 28 Mar 2023
 08:45:34 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests v2 0/3] Test different queue counts
Thread-Topic: [PATCH blktests v2 0/3] Test different queue counts
Thread-Index: AQHZXKdwdyBttNI5FUu+ySjKvJyL+68INdSAgAaWIoCAAR4KAA==
Date:   Tue, 28 Mar 2023 08:45:33 +0000
Message-ID: <20230328084532.lrgcmpqufgwv7nxo@shindev>
References: <20230322101648.31514-1-dwagner@suse.de>
 <20230323110651.fdblmaj4fac2x5qh@shindev>
 <20230327154145.ev5m33q4rl4jf7r5@carbon.lan>
In-Reply-To: <20230327154145.ev5m33q4rl4jf7r5@carbon.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CO6PR04MB7554:EE_
x-ms-office365-filtering-correlation-id: 2a69002f-5c1e-49e6-2207-08db2f68cb82
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X8bSBKslcK2BiJauHxuC3AxOEmlttwlsX1ZGmIjFOY0MW46HWom8xlYmW/WW9W8BvBXy+06w0LUGWCWNklgHYQCtcHZ0uZzZ9w4oDNqK2JKyYpkIWWJ+bzqLKaYT7YY1DitGnt377oA5D0Dhq0YjYs+K+ui4sCrLKNwCx/lt7+8Vi8rwbd/oLC1jvKHLPSQ0hNvBRT6ZPRqBiXiVXeIvxTTZ1gnTk9NQSqJER2u0jAGTS4W/wLCr4QlZ8v1anTP5qTl2mhp8JrEbxmTrBqxhnxIKn+KE3LoV5Ojd17Uv10uHgVvQGBfFwsgA63Yf5DeNWFCcRA2rTBLQKJx/pB4+zaYPxyvDFZEpdVTcAwn27oD0iTvPWrUu/isPsdtCpQ+ImJ5I2KWyDj15hlhOCHIScx9Mtu4ypkv7A9zVzSClGBIr/UY28MyRYDmd/XA7ecigJ8D2VGlKuxtOXFhsHfOeuOVcfGwJFeCXQkwkRCy2Vn25M40+Z4cTeBnXJ7oR0jCWWUFO0IODxvoOR4lPy6/BL1+ecoVrYGYVHEQBLHRSKrm8y5ty6JLOhZkMascXSbyR0Udwyc1+jZp3udT4RI+gCRgVhiVC+eAi2OJTeZeySHM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199021)(91956017)(83380400001)(66946007)(66556008)(64756008)(2906002)(8676002)(4326008)(54906003)(6512007)(6916009)(66476007)(478600001)(966005)(76116006)(71200400001)(1076003)(38070700005)(316002)(9686003)(26005)(186003)(6506007)(44832011)(33716001)(86362001)(41300700001)(122000001)(66446008)(8936002)(6486002)(82960400001)(38100700002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?77A3SbMak72vexyloeaBc5KnQYWheGwc1LsjNy3YdyTboeAHrbLj8QSVxwNc?=
 =?us-ascii?Q?y4QZpH2lC77k1hvnjGw78meeL0aApX2482V5UVixdslQ3xdg7jECVyfEqz7n?=
 =?us-ascii?Q?kvaABLtUe89YejY2DRVOKZ52/rBA4L73iLzMqsi4PcFMqoHB0XL/tHDopJ49?=
 =?us-ascii?Q?xr82PdTtxVbXlMSbRDfMtXkm2u6udxiiCM5dDyEhdAJdhdYVwhkn/gzeZmPD?=
 =?us-ascii?Q?YLZimG4X4nprvHOuPCFekbXglEUjH4Vzg2ZMFOGPcEDOMumNAIIyR15E/H2I?=
 =?us-ascii?Q?EL627PyZ/QwGcozXoMOVrQuGaxxMNGl2bswNkXws34cVNOy1f8YZ6B2pJoh6?=
 =?us-ascii?Q?GVHuXY5YiDURMg08lBv0gJbdgR97GK1JZQHLjw4Xd+laSvQG0rWGxDGkCKT0?=
 =?us-ascii?Q?dr6jwkZXd7k2QQvYPT9NEUeljsxVGdSNM96lNmfplcpyZXbd6f8HyI1AejQd?=
 =?us-ascii?Q?/o59+4I5K9Tgz9aw1pql2MSeKVTujIaNwzI5ZOeOtAW5Lb8ejwjVpPB4RB9L?=
 =?us-ascii?Q?KuJdOcr+GEdwWUyvlSc76aOtLs8BqJPsx+s9tSvQWI5azbhx0igtE7DgCqJZ?=
 =?us-ascii?Q?9sSVrM4rdaW93y+ZEckbYOHfwWRuiTiL6kbTU6uO1Q9H/UDqPTWoJok4i0+r?=
 =?us-ascii?Q?+938EVai3waj1pH24Dgl0XnAcKZ/g3n0MDa6HVwr3PGKSWUfNOXp9x6852Y+?=
 =?us-ascii?Q?8HSeqKkq347cUUognCfl3sVB8n8q8TF4p0GTMQplUhqEIMgM3IhbqKbHS7Gf?=
 =?us-ascii?Q?D9bMfsq3m9XwNWS46nKHCHECy+MRNc1IM/C3K+V5hrhhGbK0ssEgkQNubgKs?=
 =?us-ascii?Q?TJk2rJRNqHrzcPirkzgrMSwFA/Ai+NC8np7qCG3ePWd+uiXaGXKNF5v1OHir?=
 =?us-ascii?Q?+eOY72tG10snjm1uXuVnhbyw2qV5nNM4xTWTcWtfUrs1OLUBR7Yq5iAWIRRN?=
 =?us-ascii?Q?NVCD2R/RZs6bpXkmFayG8YvZoOlRZyyPF56KlndfEBCZLsH0kN/wyQ7veQil?=
 =?us-ascii?Q?pFhRdSq1kksN9xImFxBfnGBG3xfT+wWeCa/FKIzPnUqegil1K4oQcQDKbWUd?=
 =?us-ascii?Q?5p2aSj2SGB5U8L2EpHyg0+ozes11E70amN1aa0szbKxagaMq5fTZDilCqnA+?=
 =?us-ascii?Q?ZyqRmWr0p4kmxe4edz/njuCMk55bRTiY/SNGCaX9ejeLshznF4n6WFCwh75G?=
 =?us-ascii?Q?Tc2OyH7hN0FhmcvCMx0wHIK0OpdJoqaWvW91GZKhhjcSkvSC6ao13d5fzZxS?=
 =?us-ascii?Q?nyXrHET/wNT7nZ2xr+HsgbqtMqIB/Q6qD5n3nHrina/v9hJEfdfeeN+AY+WT?=
 =?us-ascii?Q?g6skttShlTON1GaXeihSGxwfsRxvQXrcXrPSnsF/6KTyI7qfZScJUK4DlJ6Y?=
 =?us-ascii?Q?LVtPwZOfyf6b7xcuENuC7nbZVsXURG0OYZ6Pl/D7R9O54xga3YiYyWnUgN52?=
 =?us-ascii?Q?etBL2O/+QaN2V33TpR2L1hZAITzwg1njj3qdIIu4N7eDXQ+JvbZT3qYGtGkV?=
 =?us-ascii?Q?HtJZBpEgUEkYqVSwfy0PMdRBwOBgTPxCf5PhYJ2XxgV0wrPcEm1QAOT/GxmA?=
 =?us-ascii?Q?BXKEr4M95irz/xTQXACHIsbyU6NuWtk/oyG49f6aCK7EZcYNqk+GH5n2qqW7?=
 =?us-ascii?Q?nzdlm0YfMFl0xtB3vS0lh+4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F803DFDD2BF81741A5BFDF8B7CF9241E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DN3vUDT6N2d1gAIQNQroeS2NP9LmMfWpH7LBawON0F2SYu7UQqHPZfALsi9t7K/V4rqN8vohWAWtkSUeqelEYi1lZm1vhsSqgf9SBSknQI+zfAa0bYKr/JhxIpd8Ca7oQ3Oe2rcS+msn4hjagatEGj59Yjs4UMpFiEpkVJvDrUfx2nxfFoDl2ugzq2fSZm29d8NmpNicfy587JLQjJh6TEwvkNmpkXbgM9NQ+Fy02I84At3mELyr6Kmv9UR9P4qHN163CIsGtOfytgLD/VpisUgh9Z6DzA0HXeLezUCDjr78ZNrKQmea6wks/WoJy6LjKOnLxscR16pdAe9VoF+UelNmfVffpQzhgc/x/JzMuGOmQWKsICmgwGTM1ObOwM6dqAz4eQzBTjlAZxG7Mq9xCHkpyBoOB6No31p4uSyAHk6LNIIk+iwJFn8Ew3rCbEddZ0uG5aW7z3obOQGtACEcXeKQk4lEPtzPFPSfyym8BirWdQ0RWAOIMGAU6nDna8XxnltPSrc7rb2wVumA5gfpFes60VwUVkeNndFIAZmFaChfm8qGlkUQ7LV9EqjHqhZlcJSW3wZZg8oWhfDqw97QsqXQhf/BOG7qNoByTQX5+bbJi/ODcvZSocwhUc9Wso0MjGZ+LvxhCsTI70qq8o19thn5o1kEFvmku0TnYzm2huoPnfEscHAW2J4Y5pVeO+l8fis1KHLC1UenjNslLSrsqrc0Or64ga4FWhesd6HYpV0p4BED5xkk3dX/SXI2OFnMPF+FFuFbb1vT5u+H7qlNCKbmPOg+Iqvf0ndTaL1R/A56smSLu1kCeYOVCGWV2/nguxvwCVlxLkCC28KzMrxnmjg0EhxtjRmZ3gkwf465ianDF+EKEUpdx+8Ma551H9WK
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a69002f-5c1e-49e6-2207-08db2f68cb82
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 08:45:33.9841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TpDhKKZbozsWre/BeIkGsVbm6vRX1e2Xees5hh4b9H0QCuQmjXWvlwXxPozMqAJuNVmgltaaUIvzNyZrDD+0+PSShhBuO1BmUehniuGFQ1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7554
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 27, 2023 / 17:41, Daniel Wagner wrote:
> On Thu, Mar 23, 2023 at 11:06:53AM +0000, Shinichiro Kawasaki wrote:
> > On Mar 22, 2023 / 11:16, Daniel Wagner wrote:
> > > Setup different queues, e.g. read and poll queues.
> > >=20
> > > There is still the problem that _require_nvme_trtype_is_fabrics also =
includes
> > > the loop transport which has no support for different queue types.
> > >=20
> > > See also https://lore.kernel.org/linux-nvme/20230322002350.4038048-1-=
kbusch@meta.com/
> >=20
> > Hi Daniel, thanks for the patches. The new test case catches some bugs.=
 Looks
> > valuable.
> >=20
> > I ran the test case using various nvme_trtype on kernel v6.2 and v6.3-r=
c3, and
> > observed hangs. I applied the 3rd patch in the link above on top of v6.=
3-rc3 and
> > confirmed the hang disappears. I would like to wait for the kernel fix =
patch
> > delivered to upstream, before adding this test case to blktests master.
>=20
> Okay makes sense.
>=20
> > When I ran the test case without setting nvme_trtype, kernel reported m=
essages
> > below:
> >=20
> > [  199.621431][ T1001] nvme_fabrics: invalid parameter 'nr_write_queues=
=3D%d'
> > [  201.271200][ T1030] nvme_fabrics: invalid parameter 'nr_write_queues=
=3D%d'
> > [  201.272155][ T1030] nvme_fabrics: invalid parameter 'nr_poll_queues=
=3D%d'
>=20
> BTW, I've added a '|| echo FAIL' to catch those.
>=20
> > Is it useful to run the test case with default nvme_trtype=3Dloop?
>=20
> No, we should run this test only for those transport which actually suppo=
rt the
> different queue types. Christoph suggest to figure out before running the=
 test
> if it is actually supported. So my first idea was to check what options a=
re
> supported by reading /dev/nvme-fabrics. But this will return all options =
we are
> parsed by fabrics.c but not the subset which each transport might only su=
pport.
>=20
> So to figure this out we would need to do a full setup just to figure out=
 if it
> is supported. I think the currently best approach would just to limit thi=
s test
> to tcp and rdma. Maybe we could add something like
>=20
> rc:
> _require_nvme_trtype() {
> 	local trtype
> 	for trtype in "$@"; do
> 		if [[ "${nvme_trtype}" =3D=3D "$trtype" ]]; then
> 			return 0
> 		fi
> 	done
> 	SKIP_REASONS+=3D("nvme_trtype=3D${nvme_trtype} is not supported in this =
test")
> 	return 1
> }
>=20
> 047:
> requires() {
> 	_nvme_requires
> 	_have_xfs
> 	_have_fio
> 	_require_nvme_trtype tcp rdma
> 	_have_kver 4 21
> }
>=20
> What do you think?

Thanks for the clarifications about the requirements. I think your approach=
 will
work. Having said that, we may have another potentially simpler solution:

- Do not check _require_nvme_trtype and _have_kver in requires().
- After setting nr_write_queues in test(), check if dmesg contains the erro=
r
  "invalid parameter 'nr_write_queues" using the helper function
  _dmesg_since_test_start().
- If the error is reported, set SKIP_REASONS and return from test().
  Blktests will report the test case as "not run".

This approach assumes that the "invalid parameter" is printed when the test=
 case
should be skipped (loop transport, older kernel version).

As a generic guide, SKIP_REASONS should be set in requires() before test().
However, if the SKIP_REASONS can not be checked before test(), blktests all=
ows
to set it in test(). The test case block/030 is such an exception. I think =
your
new test case can be another exception. With this, we do not need to repeat=
 the
full setup. And it might be more robust against future changes such as new
transport types.

Thoughts?

--=20
Shin'ichiro Kawasaki=
