Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDBFC67871
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 02:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiJYC3c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Oct 2022 22:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiJYC3a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Oct 2022 22:29:30 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846AB7668
        for <linux-block@vger.kernel.org>; Mon, 24 Oct 2022 19:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666664965; x=1698200965;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nRw2EU7MbUb3e4qCTboMMLsY4vZGCP8hschXIU7KBXk=;
  b=fA7HcRQZwaFBN0cTLRJk4Wew2sP0+SiyHXE2MBSXJi9Fko+Hfwc7TkeG
   8TqKiVcQ5PTpLDONm69F0awWncy088pZufuKoYk1BRQyX6aE1VFWdT0JW
   g0Vnscv/n3oEkuhN60eApRk+qW/J7Dk0ZxwPvmi+tNnpH/DL0J+ZDrA/a
   sJnzYU3gm7RQYO3B/NimKGxWV+sPdC8l3rAMneWMaSJu8fFgYAduBXooW
   S8yQaPp+L2H+/F8v39swO87VcLtX4V41oUyxt7htAnrqdkmsySrs8azZr
   f4/WpJ8/h6nKc7gEo6qwL1AkiQak4BGHRDHJMQ6qP33zHsbLRT0K1Ek11
   w==;
X-IronPort-AV: E=Sophos;i="5.95,210,1661788800"; 
   d="scan'208";a="212951208"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 25 Oct 2022 10:29:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0pxH40YSSKHqJYGp0JAwJmftMfd0szPg3ioVSXx08wpTV5xHnuODMudmqClgml07aFQzA0R65EjovtG2u9fiw6R6CcECdjKLH5AsihYFXojFajP0ujpE45q+Z8IYjqoI+9e3GqiIjN/WzYsJTtVO9PqMWxEI9DN8yBXJxDWsoeQj0N7oj9dOCaeUAz2vky50f8pFmJ5JnsmUxl90rN/IBSXyDZE0S1tk5UYilczaukLwUxzwsgtyivMzdnZLZmx4VIokzraa4cSNEM+XJXbo7A6bz2GDAdpVik755qyynPfvmXuDANJKZnLbJgHD9SHhAyBBNJaIJAb8/s4BStRdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2F4tOZmOJktnN0Muq7oZSoTBehxR6l+f215jLdkMQs=;
 b=PBoA2HbQKfjy41aAffm6luXRHdjEeK2Ld4IgZIkanZkHVq6jI9lAWCs/5g2MpDWHCQuEZgU2kaugl2tphEtDmQME+snItCCkrHLutapMHn071ScNv1BS7mM6Sz6/lsTynSwvcWp1LuP/HB+mCHcydSKnrIhYRv9DLlgZ+qGg0qzjS11xvst3+Iw68fJNfR4AYKHaFniiEcSwu6Fi4oBqaIMf0brCXvP0R7lrNHrdxPlX+4Z7BNrv/klPQ2jRpraRNo87d2bmYmZQnBYrmY4WxQgxeNUaYdpZPlo4T7lQ0sajHPb1Sopb9YSE5Ved7R6erH2hRocXjT0uWzT8lw3Ltw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2F4tOZmOJktnN0Muq7oZSoTBehxR6l+f215jLdkMQs=;
 b=YCUMWI07PuoBVHKLvOl8nOGpuNFcyTPOq7dZkx5GR6tMyi4uT4mEX5w/hO8N/YQ97X3BdKYSTXMqJe9CE1cc6D+cugvLCnDktSDpKWhMxautH02oPUzbWwFFZVCEWt7vyLLAjMQtCkNJKxGm61iH52gqswY0nqKpVloootuda5s=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6315.namprd04.prod.outlook.com (2603:10b6:5:1e4::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.34; Tue, 25 Oct 2022 02:29:06 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0%5]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 02:29:06 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 2/3] common/rc: add one function to get test dev
 size in mb
Thread-Topic: [PATCH blktests 2/3] common/rc: add one function to get test dev
 size in mb
Thread-Index: AQHY52/b0oMyxFwkNU+mbvl7SZ0xh64eZDwA
Date:   Tue, 25 Oct 2022 02:29:06 +0000
Message-ID: <20221025022906.v6lld4proe2dic52@shindev>
References: <20221024061319.1133470-1-yi.zhang@redhat.com>
 <20221024061319.1133470-3-yi.zhang@redhat.com>
In-Reply-To: <20221024061319.1133470-3-yi.zhang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6315:EE_
x-ms-office365-filtering-correlation-id: e014e677-0288-40e9-6417-08dab630b0cc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VdPNdUjbcVetVT53NWwj1+Gt/2ZfH7/agb9q+V7b+iZ9Wqk1Mfee2XI1VPVq5AXntHsBnApuY0bWMIP5MLBVkFuFXzCm5BQa4RhjX4AS7gUQCCYu/sStYdOncilF9pmHS4tTPn/ccOaoWg8Kwlfg3xEKVvEhpvN9h2jgd9mmsEXY0eX0sTj6nZD+eQPmAHP7CmIgllrgvmV5DDOoCYatBGYcTS1MiuvolxApK/ZaMF1WzmM/4Da3lKLr5HAjvnbHFE4VuVAKJTn8hNCk13Mdzv2yyhytl/xLJYEucBp6WUYRrcNtkr8l6xonyt4csM3Hd12REJHz/pS2Uz9sRcZOgVCPXGjsbE0Hs+jSOp/cBR5tcedRPOmFhAU+uTAEvsVuafnxzFE3cIVW079z2OLxWaPjHaUYRR7qvhv1POMpo5LOWcp+PN9Q7xEa6Y+i13th4n5ruOn6szbboU3sUb+MTmNeDuJk6JDuwvL5sp3bNJodRBraCnsSg7q6Nh51hEKNUPP163aGW3KahFpPMnyWpe9BQOBYvptT5VWLYz2H3YtINTLyrW7DQsHIpn8Ny13qL+nXIVJejFseTBjeejisgZl41rw1O9HcE2vI2bycoWmTBRZU+VeqUmhdg/O6MG4hioHTvBGeQ+jJZBhdd8T33eZxNJzZdEYd+AQrw0BNRPpHpO4b4gJxgvntKwx7j7Rfbi8KEAnffW1vS8IBdUp5klrtw2vZO9Uqc7HdU0ARekTASlUjX41pWjXBCc0uOsj4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199015)(6916009)(76116006)(33716001)(54906003)(6512007)(66946007)(6506007)(9686003)(8936002)(4326008)(64756008)(66446008)(2906002)(1076003)(41300700001)(91956017)(186003)(82960400001)(38070700005)(66556008)(66476007)(122000001)(38100700002)(5660300002)(44832011)(26005)(8676002)(316002)(478600001)(71200400001)(6486002)(83380400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nb4JE/OsfgW5KXPJp726eiPOz/qiataospCExa0q8sidAX5WqakCFvlIR6TH?=
 =?us-ascii?Q?trGMPd82bRG1uPnIZAiZ5ds0rORsJFJBuI0MAcbK38wZf1JzhJZYXN3iy08/?=
 =?us-ascii?Q?oonebgAUSqMi9OEfh8a8D3WOXowY7V9YZia0ObbOLzMOz8y+bley59KInKZ7?=
 =?us-ascii?Q?Bhm/O0UXz+YSPwQ2aOHIzcJwDyuViqf+QvhZeGX8UwmQXe6zdI8Wt390vZjM?=
 =?us-ascii?Q?RwVYuQJ85J15Vtm/NZEbtQjMl+CMqw9J/qPt9UOnuYSUOt+bJNVSHJm+PlaU?=
 =?us-ascii?Q?7v9NVSMAiAmPJiChavDeyZmNmZ2hhqpI2mLVnjCP68Q27aMdV1AXtyQoKIfA?=
 =?us-ascii?Q?xDq7kT9pU13kWNxsadGEci6xdlV01taw938fA5Zk1gnywsKnIqTEunxcZT/g?=
 =?us-ascii?Q?X8wZeRdgAeVZ56DI6nvKY7CpElFyGVyPM0N9fatdRiuUrJVVlLcyUBpTqFXc?=
 =?us-ascii?Q?b2m/nQx+BAtWFoAd8MtQ0g1vHeXVGh6GmoJMIp8KGTV7jImdJC2m0OInDIs0?=
 =?us-ascii?Q?rTQE5IpunerUmNx2ob+lToOi+M7VRNjHEaA2zh9pD6COVfkoADcoL+vV1cnB?=
 =?us-ascii?Q?4Wlh5Zug6kMwcPNMu1hy4ZuSyRYI0QPlONBHjEm1Ze/iW5q5CPLlgnS0YtoR?=
 =?us-ascii?Q?qABf8CJN8fxdJw9I0ALxA+/xT8P3ebn1EM/twd1LMyyl/diKIP+HGiIa4Jeo?=
 =?us-ascii?Q?hlnJYskjAS05Q3HsdEM9YO7iP3TsSmpk8YwAowmMU1z8WMkspSByJFpmOlmo?=
 =?us-ascii?Q?3qpVp06L+YAQQuy+blZJsaa+9Ve2BdAhmZTJtfh4oOW7DZJVZik+G8ETAOda?=
 =?us-ascii?Q?48eQVfsSxSTlp9+9zrTvPaEzSK6Q1AJHxGwtbpdrzN3hrggaXh0IVP8ZR0nY?=
 =?us-ascii?Q?GweFt20S6Xa+M//GtNXTFECMy3IFn6OOmtDdKLhWY1EYwkF4v+l0HQikqVIF?=
 =?us-ascii?Q?6DDuHbg3yaai4GyS+13AS65xeV3HfSXuDVM0gBkyZy2hncwmlzgHTJUXafkM?=
 =?us-ascii?Q?2bUb+fdLcCFWnWNG7NyZwlATZiVVz5ngl5nnp+SwWn+esdRQs8mcMvOQDE7U?=
 =?us-ascii?Q?m5Gx9QJRX4jMbCfFd4IljWaqkurdpeBC88gXMwrq4lbgqwdKNOyzBMWIkZ6X?=
 =?us-ascii?Q?LWpWmmeDOB/rI15Q3tZ6j1OO8qjVO629hIz61XKoAG3B+r6dNnFELoiwVd3P?=
 =?us-ascii?Q?kHpHd/WaVs+5S3E7uc+84GLdzsUfE8Emn0ntu3Qd4N7OdVp1cD8ZVTVCJ5ww?=
 =?us-ascii?Q?ikmITACOZMI5Z+kRMv98AYVsKXbsQTu6XYyFc6jUXRFD0b2aC/EYQDg/smav?=
 =?us-ascii?Q?jZe5Z7zp3FckHygzuA/OMA4oVjWv901nMFVHaOKy4p7yrQcmITY+cqOgoNTO?=
 =?us-ascii?Q?qXl6KkL1Z/M8H9RdQWgn99K8gQXg/fC5qRMKD47KU2f4lbalMFAaqT4HFnpX?=
 =?us-ascii?Q?spX49FkLJSi3Mxyyavvkas/sNk1UYMyhM2jLwtHvkWdEX+aLo7x3RlfwI0BT?=
 =?us-ascii?Q?S8Dt17He0AJWHb3IEXrrnhcVMz+fGxbCKzjc/iIMYY+WsemB/JJ6du8KKObb?=
 =?us-ascii?Q?lVzgqfRqMZIPyCL2etexZuWWD9gwS9t0Kux+U/bRGyCIYzvkPViNaV3T+F2Z?=
 =?us-ascii?Q?PSVbrfEOB/gBUbe/+NZNS2U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BCCA9BBBBCA3D9478074D459BBAFC7F5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e014e677-0288-40e9-6417-08dab630b0cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 02:29:06.6591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JMzUOvQKHTYiglhLKAAsUKo1QPmaXBGWPzQfBwU6VXuhgjdk903E6BXw1Mt2H6Sxu4RVeERwzCKd2XjMleIDsU21IIXOxjoBdiZ3DAEhFRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6315
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Oct 24, 2022 / 14:13, Yi Zhang wrote:

Short explanation will help to understand why we do this: something like,

  nvme/035 has minimum TEST_DEV size requirement. Add a helper
  function to check it.

> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>  common/rc | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/common/rc b/common/rc
> index e490041..847be1b 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -324,6 +324,14 @@ _get_pci_parent_from_blkdev() {
>  		tail -2 | head -1
>  }
> =20
> +_get_test_dev_size_mb() {
> +	local test_dev_sz

Nit: one empty line will make it easier to read.

> +	test_dev_sz=3D$(blockdev --getsize64 "$TEST_DEV")
> +
> +	echo $((test_dev_sz / 1024 / 1024))
> +

Nit: an empty line not needed.

> +}
> +

I suggest to improve this new function to _require_test_dev_size_mb(). It t=
akes
1st argument as the minimum size size in MB, and if TEST_DEV size is smalle=
r
than that, it set SKIP_REASON and return 1. We can add device_requires() to
nvme/035 to call _require_test_dev_size_mb(). This will skip the test case =
when
the TEST_DEV is small, and do not report it as a failure.

I also suggest to include nvme/035 change for the size check in this patch.=
 I
think one shot change for function addition and function call will be simpl=
er
for this charge.

>  _require_test_dev_in_hotplug_slot() {
>  	local parent
>  	parent=3D"$(_get_pci_parent_from_blkdev)"
> --=20
> 2.34.1
>=20

--=20
Shin'ichiro Kawasaki=
