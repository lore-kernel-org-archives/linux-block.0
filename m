Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841ABC6FD18
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 00:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjC2A6B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 20:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjC2A57 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 20:57:59 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7AA269E
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 17:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680051478; x=1711587478;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XMIjXaRPISHQiGa6+4Rx9+fhQMCXJMuMubDm/0CKehc=;
  b=DeIGZExZQl4YAWSrfJ0cNVkOOpIRRynsPpHN9CwQ5RLPBBoiJnz3kIe5
   U36xSFyORVbb9wwIkyCPSOr7ZqrbkaawZwY6+6SPPnypyAy4qocbZH7xI
   0vv90lUzCNuVWtDuBgaW3E5WLH/n+mb3He+YCQuEsGjnXKMfqCZFjZ7GZ
   GWB37QE/GmlzXnpbywPxF/ol9Eowm9QFlky1awUrANNwCe4nB+CHhh5iU
   RetsG9E2PxDAo3/lTHhGD++z6n7GSRqVapQvSCspkk3oxDmciCA0BvxYL
   LMlGpFswrx4UAtrPWjun0fYmG+YZwnhrUpLCCcBa6DObTv/YHByE9CGkt
   A==;
X-IronPort-AV: E=Sophos;i="5.98,299,1673884800"; 
   d="scan'208";a="231717281"
Received: from mail-dm6nam04lp2041.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.41])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2023 08:57:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1pH1IDVIjRz2R+QLiXF1dL9HlotpYkuA9YEVtVBWYf+laoPj3qMfPiC23XrZhZtiubehK+eJSOqrOLCl82njLqieM4e56aAfrq+V4VJ7w+H9/uz3N1Ciy7hpH7M8Uy1Eww9PoHGFqtzvgpAqMPXuSsKiW/sFqBetzmD/ng/DdHobBCOev6KES6ln+m7F7qDm1r/0pl10HKbhILPUAyPupSjFeJCR/mPrwyierEY4z9BgZ2Iy+vV5ls5fyn6YDO+a7SwmljFNud0o+0/IxPHFUdzOoKYaZ3+sP+OcI6uH0K6ZQmdlGTidHG4vp6s96UQENoAwYNpmsEfvJQDJlvayg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J32h7MiTcsofEkvoLlfzRFwWJrmSW0Ry9szW+EheiQM=;
 b=SblMA8+fgIcFzDjlR6bp84L3XFlOFRL8aBYUdIXn2cgUaKvKsZlWhXJB0ko3o2x2aGbNo7UwIPJah/Ms6cEChiOiwJO+kdlIakAxPfMgNYdz9G9B2odrifSnE0FIlxfAo7AzquwfNH8GBtpJHsXvdTntjavwE6Exe7Uk7KFjqVePI8lm99DsHa7XWI4PQ3jsdoq+wwF5MKEuYvtfI7yU393pGwRe5RM5p4XygE1nfOjJih4Q2U0OEGUbN+IdRCuX+ijdas1g9/tElWn57+LRAwmP1f6hLDwh9M8zkZwfSxVD+qRXgYkKo0vPBfSwQajTGRaOo30rv/RH+j8MYe+B2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J32h7MiTcsofEkvoLlfzRFwWJrmSW0Ry9szW+EheiQM=;
 b=tqO8C/FrJsibQknDjWoudea1DTAO9AASIiqYJc6sDnkXvO/uKLd2WYckP98oN+wr2CM/T8j8vTo7HlhpP1dgiSur7sOx4t3eiy+MZZ6izn/KNHRgmf4Qu4GoMmX6h1OEFBsQNx2jb06/0xT9T4xezoQPbW8C1AoPK6+wlLzxZq0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MW6PR04MB8797.namprd04.prod.outlook.com (2603:10b6:303:23f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 00:57:55 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529%9]) with mapi id 15.20.6222.033; Wed, 29 Mar 2023
 00:57:55 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     Daniel Wagner <dwagner@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests v2 0/3] Test different queue counts
Thread-Topic: [PATCH blktests v2 0/3] Test different queue counts
Thread-Index: AQHZXKdwdyBttNI5FUu+ySjKvJyL+68INdSAgAaWIoCAAR4KAIAAoMWAgABu6AA=
Date:   Wed, 29 Mar 2023 00:57:55 +0000
Message-ID: <20230329005754.ezfpofsle5uoldgu@shindev>
References: <20230322101648.31514-1-dwagner@suse.de>
 <20230323110651.fdblmaj4fac2x5qh@shindev>
 <20230327154145.ev5m33q4rl4jf7r5@carbon.lan>
 <20230328084532.lrgcmpqufgwv7nxo@shindev>
 <33d3af2b-d8c6-74bd-b2b6-9f9834d3cde9@nvidia.com>
In-Reply-To: <33d3af2b-d8c6-74bd-b2b6-9f9834d3cde9@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MW6PR04MB8797:EE_
x-ms-office365-filtering-correlation-id: 5e0023f1-4c0a-4bcf-2911-08db2ff0a1cc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AGIsvM19WhEvk5d8TZN6axRFj/k6QIVV7K70nmmeomS/LcBEg6KT6wDfklRnarB4Z3xVOOEUxHzjicjybGkDJrkJWy2WyNixCE1W7iOA0SWW3LXpDfiTielBtFmEFtjaWF0+t0CeYgTzjYetFHxN7xsAMF00qhk8PZN4kV3biO1LvztgTzEwZouvINJvL5tC2x4HJ5JwK2tE0HAMXOK+dAht8PZHE8EIMeFS0pOLGZ+ebVE5X7TiPr2AlOAI5BQ5muULpQQSu+Rl+gkfkgFNWZ6hfNgwPknK5djNZ2yvEXlvLSbcuevRh+CADZxPihrYB0S2JyKtsbk6U61bMYPTliNluIlWIgMdLeiZY3/s5BuApHDFPKDhyglGbyyRuUKNRubyfBukDwrRD8+ILzOiZx+M2ok0ZUOiwg1Or2DF/fpi8VvDpm//o0T5vQFVwaWMu9XpIr9YfE/AmSgtUm7hV23xb2IyIKeds1k1WgaAo0h4GSErN+zx3KsWuuvtvtnkMcjfwuSJYMHorG42e/6nBvlmmnBAD0hFPNrfwhMeOOi1FaYq8tnSqrh6GtU7QVDhjvHdCZB1PFb6dqGtVHKC7vwlo4sG52EY+2QNpf/6soI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(346002)(376002)(136003)(39860400002)(366004)(451199021)(2906002)(33716001)(71200400001)(38100700002)(44832011)(966005)(6486002)(64756008)(66446008)(66556008)(66476007)(66946007)(6916009)(8676002)(316002)(76116006)(54906003)(41300700001)(91956017)(5660300002)(122000001)(4326008)(478600001)(38070700005)(8936002)(186003)(6512007)(26005)(1076003)(6506007)(9686003)(86362001)(53546011)(83380400001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?veZpSiTjo/c4VnFWv7LWakPrcy5og7eZu4PYqEd7gnNwGyVKKEktDKkSvFIi?=
 =?us-ascii?Q?c0OV+6Cg12VFAX4qOR8Qjx+E1rw8Bdm+PeU2421PaJiy9YA8Kt/Vm01joQB/?=
 =?us-ascii?Q?oRfUdocg6ZutKOGC1b0KNq3Hf7iH4mWSuQy8CcY0MtCoYbONnfEX2D3uPuUL?=
 =?us-ascii?Q?b9rzmQmzY5uShWFiOMTPNGrfrXrKl65dbkSi9XSvy39ZzISjZlMTXs/DqqHu?=
 =?us-ascii?Q?qNykLysMDWt8WMrfvXjT1e4f6DszERdwY7bGM5BIeqL73LyWGD+9wI0o+lKZ?=
 =?us-ascii?Q?LDeg1EKWsMoIV8wAYE6bpcJB+HiUq5EGfCcmUB361/Yu8SIvKQcb91HBEB2M?=
 =?us-ascii?Q?fLENG/etJ9sLWdbVCNX9dMaxEBBRUALzVpYUH3J7//eUVmL+cYt1hgm83QeU?=
 =?us-ascii?Q?R930mnT5MucCw7Vt8VjfTydohc+hJ+fgkDmeFhl2aQCCbimrxoWMTJqiWFFn?=
 =?us-ascii?Q?oWHc6KQLjRZ4pnTAOvv7IqCmYpKOB97gspaWc/yv7C0ztIZiWLwxCSqCSoCY?=
 =?us-ascii?Q?+p4dmBEVCzF1Heq+9dsVtYF0zGXDSXXe1SDz+RFqto8NWqthOofEerYRsf4S?=
 =?us-ascii?Q?epjfN4jO6cVfjsCzYwcwsOSEjfX8HQ22w+me64g1JFcuWpq7OXjH8cH/VRyQ?=
 =?us-ascii?Q?12Gu8vemuekFIw6zlWGBwsJSNgvd3jQeCT3Wsdo66+ShdOQHGX3d/cyBINji?=
 =?us-ascii?Q?upmPU2Vskd9OWt64tcyN3y/tX/T9vZ/OsW7Lyfui+mr/V07AjiuatzuWF35c?=
 =?us-ascii?Q?l0XhoETA/+pewkN5vGc+h7xsxZg25gA4pRkNSpE8JdTemjBYWzaAi7v/JC7Y?=
 =?us-ascii?Q?aFhh2IR9EHMb269xfUXG04FkEG7q6Gkb/ocVXzqUZjVkefiNqfnu5fVoxOU4?=
 =?us-ascii?Q?dyn5hLJKr5L28YT61QPnHOirSfLj1qbSWIcQqJUZ0L3/K2s9V4dKdwl8xPaa?=
 =?us-ascii?Q?AFgY1wX6OeRFqc4IdbphiEVqU3OLjvXn/jFwiOhgusJioJnu1tKhf2XVxQpl?=
 =?us-ascii?Q?MZb4s595CY8plR7fOropJjjy6bVPC0fRIF7Ys81xPswl5mQhG2yJIG013BN4?=
 =?us-ascii?Q?l1lXy8/sWyQ8Uc5x5E3XvHT3NLUXL8UH8M0XiWo2rjLe9W++IJO/XpbrBjh5?=
 =?us-ascii?Q?71Vr98+iz1dqEvmX1emF1slAo7aohqqw9nCYpqbIoruLgzTQqpkRBmhuTSyP?=
 =?us-ascii?Q?s6Z7bofw6J3dxq+UfXYljaNdQvPZs2YcCVkOIGRN+DOZdUalZ/Dx0OBkHIZS?=
 =?us-ascii?Q?6suxYodrXvKbp1jSXYKul3/samRI4OffC0bl1i02mkM4pGItwEGSUmEKmNM5?=
 =?us-ascii?Q?O7vSmHKBZ7AESSUACt+7rvErrB5YQdTmandjOQT4KCjhDZAlgIyZd0OiuxCy?=
 =?us-ascii?Q?kNekV1xmm8B10wkIDDvCNnxvlfPiPZk+5ocnwh1nz2teZPYomr6DPNV1FNwi?=
 =?us-ascii?Q?9oURVxsxToC1c01jPk0NAvqplnTt6GzAPklsBcJD4IHBDWEQnk0OmmAT0UAH?=
 =?us-ascii?Q?RCwBhVZ+5crQAc/fOOc8lCwWmBznbn1dcpKksX9l2cpLZy2pzZs63J3EmXd/?=
 =?us-ascii?Q?6ZSEf7qF+Gu+ns6tDDQNslJB1b/uTfbQmsXqUmJ7S707TLLAudv1RqeKHMOJ?=
 =?us-ascii?Q?Dpr0xEc63HCZyruTfDMRwps=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24DA0A50D59EA749A371CB1BDEB02E6B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DBFHcsnwQUgUYWNuVM+LLzXYsJg8B1ij5L0Mr4kPCl1eGMPG1KCFLZKbAJfzCkD30DJPn6SZhZuyPxedCil6zhkdzT5u3tCJNoHwxkt6UQ+FYuabs7aD4Kl9Ivp9lVE1wXCI7U9g0bVMKadsBYa/Qmh2n3FZYjKtF+D+jWZJoi8D5QlTt4YtUflmQoq5j6QfOuCGfJ/Nfu2NZJd9kJG9w9tzzL1O1rEVDDg1tmrY/peYKm7cxrjxsRdIuKms0ZP1y++MJhPvLx8uWdqecnBuhTovfRnwrnJ2vxGRoM/4PBBwkh7G8lnzelQ1MFp6dYKGPSTDO111UCOhKuG+stGD3kTG8/I09hyIisBTApoXGYJ2835BiNtlD5p6Ch5ngCQbZIctBrZQOuA+MHHYQ8nrIIE37zwV1hWYgFUFwxHgqtaUPUhTob+23d0VhVOGjCcEuHsx3g6egpvcuErXy+UkfZFg0Jn9AzhTJIoRSo04QCHC/EhWoXRzxmTulkROBMkuDzvBzXwIFchP9lHFwIBC+Empl4NSsv/IC3cwTrXfzpipj6qeLzXJ61iTMx9PhCkJB9Y1Rm9LoLOtkF9vuwDGzuSizjMm8A0zmv0pFb+6oFugwggs9+G5mi2NgpFv45ELyh6xH/aoz81jo5ZORSpOfpUWVNX7O0vYHEo5P6pXBl2ERg9LV5wxHNTsHf6h6TtNYn9q4IJf8ZqFH2BJp4pIBaPoaEz7wl/YgnZz708IgmbRpxOBqJNMglFsVYwfWiWJybPVbS2G2oAp88AGoI3KVmw2bfulDPlwa2bPfmmfyHka8IVz3UpyedFENK9vygUeuFkkx0ow313EXnjPTGiOGZyKWymgmVQmMa8gUifKWkBuZhX7IkrHnMvSYjrsw4NT
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0023f1-4c0a-4bcf-2911-08db2ff0a1cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 00:57:55.6089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aDll/2piCgJs18IekX579JxGzxxOWzAU6tfLqsc8v3z+TvaRvKTviLzFE4pAv6rj3k0A5ucYbFkcQFRLcdCMPmkLnr92c3EqXYq1ugG11LM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR04MB8797
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 28, 2023 / 18:20, Chaitanya Kulkarni wrote:
> On 3/28/23 01:45, Shinichiro Kawasaki wrote:
> > On Mar 27, 2023 / 17:41, Daniel Wagner wrote:
> >> On Thu, Mar 23, 2023 at 11:06:53AM +0000, Shinichiro Kawasaki wrote:
> >>> On Mar 22, 2023 / 11:16, Daniel Wagner wrote:
> >>>> Setup different queues, e.g. read and poll queues.
> >>>>
> >>>> There is still the problem that _require_nvme_trtype_is_fabrics also=
 includes
> >>>> the loop transport which has no support for different queue types.
> >>>>
> >>>> See also https://lore.kernel.org/linux-nvme/20230322002350.4038048-1=
-kbusch@meta.com/
> >>> Hi Daniel, thanks for the patches. The new test case catches some bug=
s. Looks
> >>> valuable.
> >>>
> >>> I ran the test case using various nvme_trtype on kernel v6.2 and v6.3=
-rc3, and
> >>> observed hangs. I applied the 3rd patch in the link above on top of v=
6.3-rc3 and
> >>> confirmed the hang disappears. I would like to wait for the kernel fi=
x patch
> >>> delivered to upstream, before adding this test case to blktests maste=
r.
> >> Okay makes sense.
> >>
> >>> When I ran the test case without setting nvme_trtype, kernel reported=
 messages
> >>> below:
> >>>
> >>> [  199.621431][ T1001] nvme_fabrics: invalid parameter 'nr_write_queu=
es=3D%d'
> >>> [  201.271200][ T1030] nvme_fabrics: invalid parameter 'nr_write_queu=
es=3D%d'
> >>> [  201.272155][ T1030] nvme_fabrics: invalid parameter 'nr_poll_queue=
s=3D%d'
> >> BTW, I've added a '|| echo FAIL' to catch those.
> >>
> >>> Is it useful to run the test case with default nvme_trtype=3Dloop?
> >> No, we should run this test only for those transport which actually su=
pport the
> >> different queue types. Christoph suggest to figure out before running =
the test
> >> if it is actually supported. So my first idea was to check what option=
s are
> >> supported by reading /dev/nvme-fabrics. But this will return all optio=
ns we are
> >> parsed by fabrics.c but not the subset which each transport might only=
 support.
> >>
> >> So to figure this out we would need to do a full setup just to figure =
out if it
> >> is supported. I think the currently best approach would just to limit =
this test
> >> to tcp and rdma. Maybe we could add something like
> >>
> >> rc:
> >> _require_nvme_trtype() {
> >> 	local trtype
> >> 	for trtype in "$@"; do
> >> 		if [[ "${nvme_trtype}" =3D=3D "$trtype" ]]; then
> >> 			return 0
> >> 		fi
> >> 	done
> >> 	SKIP_REASONS+=3D("nvme_trtype=3D${nvme_trtype} is not supported in th=
is test")
> >> 	return 1
> >> }
> >>
> >> 047:
> >> requires() {
> >> 	_nvme_requires
> >> 	_have_xfs
> >> 	_have_fio
> >> 	_require_nvme_trtype tcp rdma
> >> 	_have_kver 4 21
> >> }
> >>
> >> What do you think?
> > Thanks for the clarifications about the requirements. I think your appr=
oach will
> > work. Having said that, we may have another potentially simpler solutio=
n:
> >
> > - Do not check _require_nvme_trtype and _have_kver in requires().
> > - After setting nr_write_queues in test(), check if dmesg contains the =
error
> >    "invalid parameter 'nr_write_queues" using the helper function
> >    _dmesg_since_test_start().
> > - If the error is reported, set SKIP_REASONS and return from test().
> >    Blktests will report the test case as "not run".
> >
> > This approach assumes that the "invalid parameter" is printed when the =
test case
> > should be skipped (loop transport, older kernel version).
>=20
>=20
> Is it possible to not rely on dmesg unless it is absolutely required ?
>=20
> > As a generic guide, SKIP_REASONS should be set in requires() before tes=
t().
> > However, if the SKIP_REASONS can not be checked before test(), blktests=
 allows
> > to set it in test(). The test case block/030 is such an exception. I th=
ink your
> > new test case can be another exception. With this, we do not need to re=
peat the
> > full setup. And it might be more robust against future changes such as =
new
> > transport types.
>=20
> Ummm should we avoid creating exceptions ? unless it is absolutely=20
> necessary ?
> The problem with exception is it becomes problematic for long term=20
> maintenance.
>=20
> I believe currently focusing on tcp/rdma only is sufficient ...

I see, then let's go with Daniel's approach. My idea could be tricky too mu=
ch.

--=20
Shin'ichiro Kawasaki=
