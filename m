Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4238EC43334
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 23:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiFXX2Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 19:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbiFXX2X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 19:28:23 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D97B6F79A
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 16:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656113303; x=1687649303;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cmfwuYHh/wrC+3CwczpONu051c6qUw4+hPjgT7QLGYc=;
  b=RJgmodphE2oJ8X3h2HJSbJEo/HcUAA1zJ2gVShOyC0NDus5MaMUvBRGl
   zo3AyNLz7Diy6VV7zbLjkzR9ononItsrkHdpPBXGK+tEmP5VRqhoPKss1
   UwXe0XF+G+N4+dhqHzEpfpFRNZsvBH1kuY1XYB9woCgqyCheFfz+7sxC3
   aXApAywqyZHV68eXXT1XTGALbz/Xj80+VgYE15UJkL2u8jTTzAmDa1688
   1lEmzfTmofzkxCJq0HN7ny4kUkxajFz/Zj4x3Yuw3U+/JjbfAJNcRWX91
   no7bqRzC+KSKvmb1sU9Vd9mgwrs2TGJy8b/KAOIzG/N019F/lqootZNwU
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,220,1650902400"; 
   d="scan'208";a="204802310"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2022 07:28:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMikWVcMvFS9dBfQ7jX/1y18YtmAzPd0YHtIZltABkOsJymUrIfcKhLxu5A2gZQtg7UAH4Xda2E6jrR6/uzC+6biW3mF5kCAuI+gDtAW3T3ejVTdSsv0CDv7gQQWtZ6Z5AKmgNfILmVmKu9gMbewDno8oIl8RowjQ3UizHvkDJhlCq9rV3ViL7A8nmbwEdTLa6DqlFbdlnK3dE0wV+FObgsKy6quvh3Oh8Q4Leumf+JtV+D2oyaoUm3IHHx41+GdAVZGTY56wwMzpQyJnxlLflfWikJZS8F45YOQeSzP7hvAjYA4UgVYQkS+WwSm6CWeGlyyL1Ws798zWFnIemEy3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjuDFDqGqptJcGCwbUmHwzKCeDqMmR3W2N4KVojAPkk=;
 b=gPCSadrvQzvsb6G20lCLeJGrouxkt/h+qb4GRbRx+uZ/auG40E8Jen1TRjv/X8U2wxew35RwFI5RUXntKkTZ6PClcDxMvRwNcEKwlvsYaBEIia9xyPi2SEIcrEtx6bGnQHuChQOmQT0d+9vE6lpOOpxDVrAw415W3wWtWUQv40t+rv8uCPElYNv2n6082RDc+qjN1MrsbYh3ZdkfK554L5c1P604Tf3fG+Y/oFQSQ5hpzWo4ZW5DZgZQA2cz4CaG0hkEXgLLJnwcRAjqw2gooTKToV8K+3rajX4gvN+vpngQGXalOT5HMwacjBHxklAVuHOTVunm8VOY+u595ZRslw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjuDFDqGqptJcGCwbUmHwzKCeDqMmR3W2N4KVojAPkk=;
 b=TCYgVBjgZpqNMwKnro6Hrtc3ZaBhVCe4D+S6ppGkv8M+LmQsnoA3AbLgiKt0k1R5M/gN2VM3SFG+nl1z9PEZhtv05HXIHX4IfOQ9AhV93KGyooQoFvsmXZVxUWvRVQcWxvhCZXDTclSQYTaHGt71ctIuIpWoXTflhqr76L/oZ+g=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BL3PR04MB7916.namprd04.prod.outlook.com (2603:10b6:208:33b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 24 Jun
 2022 23:28:19 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 23:28:19 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] nvmeof-mp/rc: Avoid skipping tests due to the
 expected SKIP_REASON
Thread-Topic: [PATCH blktests] nvmeof-mp/rc: Avoid skipping tests due to the
 expected SKIP_REASON
Thread-Index: AQHYh58XRETCr2SsZE2RADrDB0f1D61eN1SAgAD9mQA=
Date:   Fri, 24 Jun 2022 23:28:19 +0000
Message-ID: <20220624232818.dd7v2zaheqzbzw2w@shindev>
References: <20220624075023.23104-1-yangx.jy@fujitsu.com>
 <20220624082039.5x2cl26q7v6rnm5n@shindev>
In-Reply-To: <20220624082039.5x2cl26q7v6rnm5n@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55df7aa1-aca7-4939-debd-08da563938ed
x-ms-traffictypediagnostic: BL3PR04MB7916:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CgaYOST5aFinf8M80YYrLu7w3cacihOz+tOpgxyyHq0gJnsXQcEd2KLuh0C8qRfImo8bkEKJ9WFMl/vAMTbIMUeaopAX9Jpz6/IQqfVLqaA6IhfqhY0kQ+G6Sv9g6LB5NwyDSvBAnMz1khmD6/y6yRXtX7L2rEBRGQ2KwjVukLiMYFVnOIBKDLo+xmxwMNWps5ZYJy0cFxA/8fs6zGF6sKqa04wf1WdEbZ0lOVXhIj46xwtJz1R0fo0ETY64SZGIezyOJfugCAzqoltL0ZdES+LOVFEtOaJfLwXQhtysHoou8Bmb08uytU5PRvHCwQTpHcdn5WrRJHr2VFTkVDAiAMtsXV5WUOkjHh4CEZ3OgvYRdpepftIg+GxJ76iN/MJJcf4aGiq5amIDrgi5CB9Nqk7wRKQYKppwecf53nPU+Jl3vrv/Givn2musXQQbC7zlEQW5E34EH7obc4mBRAgHpzAn9VdpQqTAudK+jm+uN5Vnpz1k7XM5yvsF9oDx7fx6KzJ5HemnDPuxSM96E677XZi8dMrSUTdoPWhjpVTRvaUnFIoh5vr8VitSpFzgsHVSNa83lsLA5wtUyo2vyE0gH5zAW59HAN9DmzTU9UsqmLt5pvL/lrXAtrCkVnbsqYrgFr05SdDgwJSqSFhWxiW1NdhAkLKpWauZR+6UoWBIw+5EO6wqbNRbotuhWANJ4bCpsrbdfZBFFOxeEw/m68kOqasNDYPkfItuLcNPZbeR0fSlqTpdOy+98rQKqXq33qRuCSVL4k5aJKOd+NMhWLdPr5BdTkElmu4b1aLMjvF+ZL8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(71200400001)(478600001)(6512007)(66556008)(26005)(82960400001)(66946007)(64756008)(186003)(8936002)(5660300002)(41300700001)(66476007)(86362001)(83380400001)(8676002)(33716001)(76116006)(9686003)(91956017)(38070700005)(4326008)(6506007)(316002)(38100700002)(1076003)(122000001)(66446008)(2906002)(44832011)(6486002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IFSJ0FxxjV6FQjD3Q/CwDA9PTZgVeJXhv2rKv8dL1wsFQVzaKUK3hp0tIdG6?=
 =?us-ascii?Q?Nv/EJmfCqQdnlZtf1VxW1xchiUgP2XdHhDLYxjN69fdUtr5piwXqg3Q642Cy?=
 =?us-ascii?Q?tZVnItKInSOVVLf9waRm5OlTxge3Q0zyNpGt/T+KA7Vlv12VaLegK9JpMcfL?=
 =?us-ascii?Q?ltp/HSELnEXlfQGXFo4zBbDfLgNvWYBj0wUkVtE/N6vaGcwR63JeVEVcnWU4?=
 =?us-ascii?Q?iX29CMoba3GyIL0Y6lp28TsdjIHgh0NvMjh0Y65A8G+0B0gQipnT3ylqPnu5?=
 =?us-ascii?Q?mQb/FQBWpjGbvoVCfHXNrIS4z7fyELgXr0TUkrdW+QdpS+liU1C+Bc/cEZRG?=
 =?us-ascii?Q?jn+7P9OK67V0fQmROSYbZZocKTYLHkBhsrMpcs7iHTbkAXJhU+zpJXbX6StQ?=
 =?us-ascii?Q?XUCWzO4QrgFdSoVS7aOdtQxgL1poBC7UVZknWBqGEZKttliQ1pheW8M2Xbvz?=
 =?us-ascii?Q?pnlhmu5ox6mX9QO4oHl8hjkUySoa1jdDzkzX+/f3jBchhLnCyVHkKeJAOa+e?=
 =?us-ascii?Q?szivk9Z5KhYsRpieMYzCT7xoWj9u9XT8WpCzkXExvljejrgPKH93mEXYkqJ8?=
 =?us-ascii?Q?YfV6Irqofm1BiGmvkTFiUrC9Y7/OAysqECpouXzTw9lQwY6SKypqg84fLd03?=
 =?us-ascii?Q?EFYgUs97qAx1+wddZifbF9fDmU22QqRNxDBOmqoWntdkqx17w59AbXE2VftU?=
 =?us-ascii?Q?/a975Sh2CFR1+Z+r7mOKWUKp0KXXIXP8W68Mr1KhyWVV/Z6qGnqU6KheM0ti?=
 =?us-ascii?Q?y0Pdx5F6jH9A38vFRc3Ow7mKZQxwqgQd0h7DT9WmlEmkZl4POJl2BBYYn/lj?=
 =?us-ascii?Q?tj8IlY4jEQJXLRhQXgEIXDhdwBw2LkvQAs64j4kkYWqd8Bl0jOImIs8BZc8W?=
 =?us-ascii?Q?1OwEe3CeCKM1sUFd+KVtQ5SAaVoLMaf2vV3gT0mlxMe3vbmwABeTUaihH+Sz?=
 =?us-ascii?Q?G5W0cS62eZJYOEPCGzhWcC9iF+pbKOEQPWkicUeg2mNFEIRf/1OES1d7DxTy?=
 =?us-ascii?Q?i3h9AyFbDOA3eZZL8BtrSm0nE/RP1cn2CO+iXiUrgkQqUlgejvZzklAZZSv7?=
 =?us-ascii?Q?cMsI3AUBHYWHw4RbYjKgRSyFdKR58lOCe57N73wfny8FhZghfIBq4SEpS5lH?=
 =?us-ascii?Q?PPiBuClyc/+GBIUd8m1fTVRqhB60mLtmigzpv6dgdv9qLMJL11ZM8cIZUKg+?=
 =?us-ascii?Q?MQR3gEZQPd3+hCNbXSYb8YXN33W4BJajSEdXmE2q0gX7pnjiFWUVCh4cq8WX?=
 =?us-ascii?Q?UOrk7ggWU1WnDqp55hEWYnwH/Bk3XQbeYamQ3sdfRE7RwFTJ6uL+VycvTDRG?=
 =?us-ascii?Q?pHtFUM9oc20yFVjiXDhsGfi3CL+8R7u4MXiDrtJOmSY9l4lXR3YtKuFIbsvR?=
 =?us-ascii?Q?P0jFvnFkRyz9a8UlqbPqytXyn4hj82jva9OGav0OLarsiLLeGVmS3gHC5biD?=
 =?us-ascii?Q?A7yHweFh6VFlNRyVPiuqG/kePUuskhMI0xylxRgM77tDu7G/6ttfM5SMyNyp?=
 =?us-ascii?Q?zBYFBdfzXCPHoYL/Z+kTg97eTWKTNdGo2/Z+dRRE6ZYJIw9T41q1RdvGDJki?=
 =?us-ascii?Q?2pIBooh1IZ6p3nYEgrAZLjgQ/h+78pESjroe/bsj0TtsGZ8sIzcsCg7t2lkt?=
 =?us-ascii?Q?34i2oB6s2zA71TZ3F5eefDA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B9BF581A83300A4DB49EBC8083CB844F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55df7aa1-aca7-4939-debd-08da563938ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 23:28:19.4428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nm0YCphh5fdclwOpBVm50pmd73BRJk6DY4iKdPtiU0VOTfd8u+bTSmdXK+JfHeEMHlQJYfpwXHUn6nGgytl/6621r9rnaw9pXBCQsndvgBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7916
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 24, 2022 / 08:20, Shinichiro Kawasaki wrote:
> On Jun 24, 2022 / 15:50, Xiao Yang wrote:
> > In _have_kernel_option(), SKIP_REASON =3D "kernel option NVME_MULTIPATH
> > has not been enabled" is expected but all nvmeof-mp tests are skipped
> > due to the SKIP_REASON. For example:
> > -----------------------------------------------------
> > ./check nvmeof-mp/001
> > nvmeof-mp/***                                                [not run]
> >     kernel option NVME_MULTIPATH has not been enabled
> > -----------------------------------------------------
> >=20
> > Avoid the issue by unsetting the SKIP_REASON.
> >=20
> > Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
>=20
> Good catch. Thanks!
>=20
> This issue was triggered by the commit 7ae143852f6c ("common/rc: don't un=
set
> previous SKIP_REASON in _have_kernel_option()"). So let's add a "Fixes" t=
ag to
> note it.
>=20
> > ---
> >  tests/nvmeof-mp/rc | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
> > index dcb2e3c..9c91f8c 100755
> > --- a/tests/nvmeof-mp/rc
> > +++ b/tests/nvmeof-mp/rc
> > @@ -24,6 +24,11 @@ and multipathing has been enabled in the nvme_core k=
ernel module"
> >  		return
> >  	fi
> > =20
> > +	# In _have_kernel_option(), SKIP_REASON =3D "kernel option
> > +	# NVME_MULTIPATH has not been enabled" is expected so
> > +	# avoid skipping tests by unsetting the SKIP_REASON
>=20
> Can we have shorter comment? Like:
>=20
>         # Avoid test skip due to SKIP_REASON set by _have_kernel_option()=
.
>=20
> > +	unset SKIP_REASON
> > +
>=20
> The change above looks good to me, and I confirmed it fixies the issue.

I've applied this patch with the edits above. Thanks!

--=20
Shin'ichiro Kawasaki=
