Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281AFA47
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 00:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713315545; cv=fail; b=fyKDL0y8lGo5oiAbKcQh0bralT60VEGUXpLRY+u7mlpfvvoTmbpCEJE2Gdg9UBQPmw3j9fxtnQRCZL+1Cfp+MiY3SXNhnjXCOF9r5pW9klxaiS36NrJuKDnQXjDFcfloIUdwxKeUX5eQEWaAO2zZnpWk4IaaZuNLIakFFh5t6uI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713315545; c=relaxed/simple;
	bh=PDYC2lsliQRjmBz6/x+j/5rjD7NfoLp/DhcOmvEBOnA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e1wne5SE6iLZjndYeG9IxQoAItmisw7pVb+bZPNTvl2wGKNspzSjCwVRGXE6CAb0bOg/zyJDdeiUaAa25rmb4kxZptu2kvVM8SFHZqAU+MUp9rEH5gM9SmLZiixIu6+1TMEAEizEUcXbVuaDR8c4FFnG2yiWBPtiSZDv9nR/jko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EeVbBaPb; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Oava4B/o; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EeVbBaPb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Oava4B/o"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713315544; x=1744851544;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PDYC2lsliQRjmBz6/x+j/5rjD7NfoLp/DhcOmvEBOnA=;
  b=EeVbBaPbxGIYj+WI3yKm30Whs//6yU7Yrn2WnS0a8vK/evvahUGXrIEh
   uBfktWns+QtqWE75VoUVfVmoeRgGBJr8jIvAFP9c1XaPxFeL9hJn8uA6g
   uI6TrDtW7qRLslgPLdvTK+ITFANICK3KfmAy+jMmEjA/LvBNKgOYtGvWI
   hb0tP//uf/3Cdnk+qZ+Iv+s7sQFHbmsOuWNH/quVxTw5MdnQG4Ck2wTdX
   gi5JLIvPgZndVN1Li3INmTPcwCGzAjn+JEpSfV7UMvahPC+xA6n9NdVtL
   4N29N98Iymbf3CEdlnap3NJt5PxA92c8yUTNUcVYAhIWPVFpl01BLapa+
   Q==;
X-CSE-ConnectionGUID: XQv1ql7/Rd+tsM9DR6X19w==
X-CSE-MsgGUID: LOUWct0RR5qu9oZhJiBVxA==
X-IronPort-AV: E=Sophos;i="6.07,207,1708358400"; 
   d="scan'208";a="14414912"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2024 08:58:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJB3YbmUmY0YRerJGvHK27EW7cJnPh5F7Iu+bG8IQclon9VsPlCfX6BBjGrJbm+XVUMMLKGU41cSi3cB+PvqWMRQKt6jm/1faje2WbMjpzzBzJ9iXkIR6uFfoSVIoJxR192pQxuFFUme/T3nJaYn8485zVhrjl4bKmcve6ZiAGWAlf6PCXkuiK5NuI+utCJtSeoP/PCoP4EB7sMrTy1DWtHW9bi4X51DsPJrHlJ8vFlUSRCeUYg4dPC/ct//ZTUvu4yUe+8vSYUMvh1ZjTmTos7St6lGJnIJccQOfdcgjvVqEm95fk9QxPTBohizK68/9DZnxSb7vj6RMfmBhBVRKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eL1e8JFv80VuJeo4RodsOAQZZ878Z2XO5C7tvQRuR0=;
 b=iLu0/V//oDuh4+efO4FsfhaHACyL10gTJecIFmU/FLrY1O6+4lOFGb5m8HFf8PTqjVrBAsPUpdgpyfpEE9lI3xNOceSJWEYKD9NwcZSM19ubxat+ajRG9KSbL2L/UCxjy/LYpTqQ9sGVmRA/2yiG4Bj6ZVkjWfq+iBR/nKarjuF/jL1RMuBVHvs3IKQSHaKutkZUcWbr/L61YbBxagjxaS6aQ9Hm005Ohc9nIs317l1FUdfbaJZCFiVU51wK7EMfSL9MjS880AA2DK5En0MxAp8XLUP3Hgmc328Kj5vX3gf/UL2M4I0yRcjhErZK6L2bX2eJQnO8moxKJCP3b8wCQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eL1e8JFv80VuJeo4RodsOAQZZ878Z2XO5C7tvQRuR0=;
 b=Oava4B/o7FGEJzrlWvNN+Yq+fiWHTOwCOAVX5yfGot89SSCqBcy/0DvkFu1wMezIVYFv784KMZ2WDyBg5tSFZ+y2RONFdeDw1Gv1IMKd4HIpNtwCKxBW9m5XD3zX/wXmHLHy244FI5KTbZKGNzVa0mct21Mx/2hxvuFegefj6Es=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MW4PR04MB7364.namprd04.prod.outlook.com (2603:10b6:303:79::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Wed, 17 Apr 2024 00:58:54 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 00:58:53 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Daniel Wagner <dwagner@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Daniel Wagner <dwagern@suse.de>
Subject: Re: [PATCH blktests 05/11] nvme/rc: introduce NVMET_TR_TYPES
Thread-Topic: [PATCH blktests 05/11] nvme/rc: introduce NVMET_TR_TYPES
Thread-Index: AQHaj73aHKCgSe6kfEa5k1xtmLrU0rFqskAAgABjLoCAACb7AIAAaPCA
Date: Wed, 17 Apr 2024 00:58:53 +0000
Message-ID: <epbj4opovczrfrs3o3mdodjs2dtekl4jsxgbwhtnqhq5bjhjnl@54b5mo6wixsk>
References: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
 <20240411111228.2290407-6-shinichiro.kawasaki@wdc.com>
 <7okerxv2q5k6d2jl4ehdvido37rmycxopqalkt3xcouxeuxxe7@q73je25fv33y>
 <x5xlzl6g3riybq4uuoznt47yp2ieixtltq2sw7w5uodpcosln5@pmx2vne4qgjq>
 <fact36d4ueuna534ktaafuel4uqkexmlkrwasky6ytvpmi33bq@x26qccgbqbnw>
 <b159e306-2b08-4880-96c0-2ff7d5c3023e@nvidia.com>
In-Reply-To: <b159e306-2b08-4880-96c0-2ff7d5c3023e@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MW4PR04MB7364:EE_
x-ms-office365-filtering-correlation-id: 24063aed-21d6-42a6-9fb3-08dc5e798d91
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 AtiGzpDtLfkmmeuyh9W6BP/9TfrOhXBPUBa/yJaF5Ws176trAbnQNW52SV1gzvgwC/JUV1aHz5bHrWhHvlTgMyMIXdDXwZUCnxLmOpRZ5pfGgLC0bg4jMZi+lc/fccUtZFU4AnwuxDoiC4ARYioJD6lWSXQvpB9BpqQVOZadNmZIUIuGK2ncU/2oEXIDzsStHua5mNMniNL7LRFKJj9HKyZ22P/PmSyDxFrEt46W77OfhKNULmo+ru1r1oXyVCgrYfjWQ86P8IQHxQBBF8IonOmY7egFhUk3p5dFEiXWzH2v4+Z7GPOL+JiHOBJDwSO291ONjxfByTzsU+n4vLt/kaFQw9XCWU8njb5d7oXpzU8Onf9R/RNpeEU3xDks5K0Zv6XZkHvI7VAoIICGshjzlpX80/5xIN3cR657TlBTmGdi8AzIiKGJPl87ez+XL6OiRLAGrJtR5i6vAR4jCV4xjA0rZvAhhayi3Okvx7VaBb6CQK3VQetk1b3g4t9zrgMUmOQVfcVu9QPP+IhJy3tst7YmWAS5TbMbAyadUvaquRLrdT5PUUrWl+Dvtxl1PtbmzsFh4nYa5NS5jpmNMhWIQF/qRwEVGlifY+jkSvCVKrj7W+1kP9aWGD4dns0gvB3p9gYzBK7dozP5hPdc0/pSO6kpvposQ+pzEcPgd/Dy58esC71GIwrHleet+dnj5kUB3yVpzXiS+IlgtBQXKfEvz0dz4A/K2atZzAfymqfWkg4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?q5t8T/bA58F/AK+gmsU6a87YGB8J7Bx3DwMPPDXRlCIh8I+DkC7o1h3JQql3?=
 =?us-ascii?Q?KBuxR61J53NEb1lv+3FcxAkd362zUwBB/PF/FRWqs6cjRzJyX16it9o7XF9e?=
 =?us-ascii?Q?VDfihqFmW9IHD7naliEQLP5NuxVBmY7VtSjCMdNYqXDMJWkzEzsyg10jJGZ0?=
 =?us-ascii?Q?hLgFrKIQoEoU6a6VPp1d6Gp0ayH6X0f+pGilZ0KIMeigvVIaqbWTZld9VD8m?=
 =?us-ascii?Q?RpKm0hOZacK1K0FrFlxi2PYEGYPqMZy55zXKh9xAwnr7zHWRm+/WsQGsJvCK?=
 =?us-ascii?Q?LA1dmn9umW2m2XEtofek3vNQvAovjrOEQOi/phwcwrvhN8tatUyiqyL1ErjA?=
 =?us-ascii?Q?srmnJPU4aTvHuZJrC1vguANm201OkM2o+NnuWSY8WnYsJOVFE+CkfYmv0hc2?=
 =?us-ascii?Q?OlLfLF72vE/4hj+RToRtLYohNVydVAGQ1x2b7xs9orzNVxDf0PubGD4o1zyM?=
 =?us-ascii?Q?iwVBaP0KYEFLS0UocmUGArsJbjow54zm6a6qjdSvnJyRwLrh+5YXWdPyxjrc?=
 =?us-ascii?Q?j6yzD5KvZbdbD6HLT24XRmfnSydMWFP9sYi7guq0fd3BQkJ9/ZWECci75OYb?=
 =?us-ascii?Q?Akf3B1iPEXYBRDug0ZyDomU2D6iO3QLWqETYqP7oyt6nH8h5BhybtvIuGN7s?=
 =?us-ascii?Q?Wwk2En3OvQnOCuMmfAZiFu9P1cxR+u3CTVyKxs8OzGSpQqv2sbGuIQBNZQVu?=
 =?us-ascii?Q?0tc+eGNzucFlRKL30GZYWVdRl398ATqqjZif9gxDvr1RMz31uTnknqkTXgIE?=
 =?us-ascii?Q?LFbr/p4vqxDDIhe/sHQMmkksP95UTAWW7LOQZp45ULRU0shklKkueyT3FsVy?=
 =?us-ascii?Q?ES5lGfS+13kTRNuVZpOF5GNGSV4+u+d6MhASZX5Dg/mlVRLnBYs3HJLbzVGH?=
 =?us-ascii?Q?sMQH0/LeFNtQhjiYwLKIs1PX8Y1AekcoOADt1LooW8aaVUrSHxAfWVlp8wto?=
 =?us-ascii?Q?8JI5fCuePxwjtj7Y+4tlwrQ6Us8LQiRnrMroLvU/3qawrGIKB0GGXkI14fBf?=
 =?us-ascii?Q?s3wbUCI8OZmzRojPf1FM9dghKSM9A6IQ0drtTE7zCqiSNKUSV0KzakiKsYwJ?=
 =?us-ascii?Q?h2wF0Ut8D4snGIiRN0vy/pgGLYDhJiIgJ0IKGfGzXhc9SyOsg4KpXjeouSUV?=
 =?us-ascii?Q?fZSwRd3GTJeHgrWu4Lc9Vb7VGKrPRHddKisFgIf142msLq4l9cA5mBj/N52w?=
 =?us-ascii?Q?wLTEnurGHH6Mk9f44YST176MAx9yxnK26RPBrlqgf+eFsVdSbY2tI8FGrgDa?=
 =?us-ascii?Q?jHvWukH/mZ0bPkDymR6/HQpx2x+XtVcOCWk7oEtEl7pU/TcJQjG0wU1vIXuA?=
 =?us-ascii?Q?V0NkhZlzzE+NcAHJ/1b8kK9628eJNbNOeVTsZSJrauQQCkJ2fSfIiCx8p4r6?=
 =?us-ascii?Q?aincdP3Vi2P1EUctEMpbtizvAJ8qo/gq1G6U3R/7OpFZBrGTMoVe1br2+8Tc?=
 =?us-ascii?Q?R8JiB04Kz6PLw5D6tlTNC/4lw5N8XDK/HS0XJtjMEYsvLjEpUfSrm1zBSfLb?=
 =?us-ascii?Q?BMkXVsajMFtRUttoL1iDgL4gHSPSyQigW66yd821K1WfKifL+2zRojoO85X9?=
 =?us-ascii?Q?w4ZFJ5zoHr2tPYwkMGV9uDqFojRORZD/RUo3yTEAsm6ilrTwDZ8zttYSMk9Z?=
 =?us-ascii?Q?AuGG/hrTJr3zyv7RPoT9As0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <870832280AE66A4992BD99AC770911BB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pIBCzZA09SBxaegKf9IIyOG5SBi99M7pJC8l+iHY8szrHATi/bX8CSuFxNw+c+VLjrYSnJGJI6Rh6//Rioyc6oFuY6oj6seUSpIu1OyPUpn9LUImPYN+PT2A+jLpN6aYVnEHcQ1ZO9VaIDe5cK9CSp8+wSX+gAslqama9AftqS8R8JPD4M98uAFk4Apecs961sfvoVgadZHJOkD3RE4xS7xHMiEHjvQ/jjHATlciuqXzbpJqX/eQhM5tyFmKlUMqk77R2emcDoEAMiGX9ntX2Z3TTp0wdX2ppfkVAou/8+mtZUxy5msEPS+p/s8yuHpEKNsE5EsSiecgszt9Yf8H8KDgUz240CjS6CXtXPcQdXJfxWEZZIrs64y1ESJfrls0jYJnSQgK5FRABMfcCEKIf7rUwDq+FhhejhqQpeFLIYfojqXEuYFI2jKt3XG5cKcAq2x+69I/wTV4cTJveqbnmYpZErJ01Y6nwy3bYcn5wT1Q4HcYdEFWiP1eAqwBT7Xham6v6DbazD4vaiMeJ3mhmdDyGYyLCuR8kweh3YCqzZJsGtVjruClKUAnQ9LZAnw7UalgXDTOKmRejdnVwAag2truySItVMdd2Qii4dJRPH+0yjVRu4O+jsfs168vAWCY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24063aed-21d6-42a6-9fb3-08dc5e798d91
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 00:58:53.8802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mu57/1BbD9rrVWHDH1mtYN6ZbT5Ic9I8CDjB+FCjxY+8J+wkbcJZL7RpQqaS8YvpxJvQefboxCZdEw5ojyJDcdyTq4P7wdDYMIQNZGD8ZeU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7364

On Apr 16, 2024 / 18:43, Chaitanya Kulkarni wrote:
> On 4/16/2024 9:23 AM, Daniel Wagner wrote:
> > On Tue, Apr 16, 2024 at 10:28:49AM +0000, Shinichiro Kawasaki wrote:
> >>>    # nvme_trtypes=3Drdma ./check nvme/006     ... works
> >>>    # NVMET_TRTYPES=3D(rdma) ./check nvme/006  ... does not work
> >>>
> >>> I will modify the descriptions above in the v2 series to note that bo=
th
> >>> nvme_trtype and NVMET_TRTYPES are supported and usable.
> >>
> >> I rethought this. Now I think it is bad that NVMET_TRTYPES can not be =
specified
> >> in command lines. To avoid this drawback, I think it's the better to c=
hange
> >> NVME_TRTYPES from an array to a variable with multiple items separated=
 with
> >> spaces. For example, three types can be specified to NVMET_TRTYPES lik=
e this:
> >>
> >>     NVMET_TRTYPES=3D"loop tcp rdma"
> >>
> >> NVMET_BLKDEV_TYPES has the same restriction then I will change it also=
 from an
> >> array to a variable in same manner. I will send out v2 soon with this =
change.
> >>
> >> Daniel,
> >>
> >> I assume this change is fine for your use case. If it is not the case,=
 please
> >> let me know.
> >=20
> > Yes, it's nice that all the configure variables are of the same type.
> >=20
> > On this topic, I am a bit confused about the naming scheme. We have the
> > lower case ones, e.g. 'nvme_trtypes' and now the upper case ones
> > NVMET_TRYPES. I assume you prefer the upper case to mark them they are
> > injected from the environment and the lower case ones are globals
> > variables in the framework. Should we retire the lower case ones and
> > replace them with upper case ones?

Yes, "mark them they are injected from the environment" was the one reason =
to
have the parameters in upper cases. The other reason was the consistency ac=
ross
the all parameters described in Documentation/running-tests.md.

>=20
> can we please keep the small letter similar to nvme_trtype ?

I'm fine to have small letter, lower cases for the new parameter, but I wou=
ld
like to clarify the reason to have lower cases. Do you mean to indicate tha=
t
"the parameters are test group local" using the lower cases?=
