Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FF15D8E0
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706008892; cv=fail; b=cuqZMr1LJdSc+C1ISt4UtAVz//KPjSzePHrxRjjq1osMWVIogfd57BMn3juF66RDyBCMEzWoaxB1epxJfAoI5uYj91Gci8iYnNOwYwJwDJIkLPl095b6tGR+3l6yarCrXXEDdXW+pRlu5xUypNru7tanAzP4+p7aY7FRHy5kuhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706008892; c=relaxed/simple;
	bh=bDfDxH+hEhMi+egeUKM0XjX4eyS4BnqUAapjRPqiJLs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d/n+f1DdGYyABpNZRe/sKRU+Q56jbWoepygGNa3av8K0UckkJezHF8qkbXtDFuG+TnChys6Bi4bpmZppr/TChu/Kv8SLL+zhrLqi0MbnsgJzAnxvxE6qZ47byKQKbF5DVRoN8uTJA1sjCsX341hXoagrwZMNiMaxgPx4jmpENiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PW7HmnNp; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ZAT/U73+; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PW7HmnNp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZAT/U73+"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706008889; x=1737544889;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bDfDxH+hEhMi+egeUKM0XjX4eyS4BnqUAapjRPqiJLs=;
  b=PW7HmnNptmWFvtOgIUch1EZktxkKjnNLjHqin7enR6bm5pzsFJgxJg+4
   xky6a7SqrDWoS7wKYJitbEXv5ppW8HJBRSYeeeHsYno5NhRMW2OoLpq3A
   0y4ZvwFhD7kg4FBZmjiJ8WPk74RWrkeCelklIbcCjRJ+mVGR0ib4fUByD
   xiDA8R6QhHt2Ihu4Z9HBJ8rh+iVww6isoxYkF17gWeA0AvkeEjMSiRWtW
   Y1yqDm+CB6TC2QqJwEw44iDDANoJLtW63oU8Q993o7UGlJ63RxWxxCkPm
   Um4FgiIcFUcfU5IjXge7HPO92cn93mMia9yGQ5Hye2kBm4HKyceao/Jzl
   Q==;
X-CSE-ConnectionGUID: ZS5LrpAzSG+aWm6Wim9FyQ==
X-CSE-MsgGUID: WtVkZ3zjT3W2zu93KDQ3zw==
X-IronPort-AV: E=Sophos;i="6.05,214,1701100800"; 
   d="scan'208";a="7519751"
Received: from mail-westcentralusazlp17012025.outbound.protection.outlook.com (HELO CY4PR02CU008.outbound.protection.outlook.com) ([40.93.6.25])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2024 19:21:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeHBY4GLnxzkP0LOXhaMSkdKmtVkaZ6DYWIAlAdl6I8fun7Y6DGS9SUMWwJ15J77KY+junfkMrzasa1XGchodxq3XizSWj1BlPWeSrtu5TikUKyetNOoe7KSO+4nyVPd16IqlCZq7mHhFClmtkt+RnICOad7P0KVcOHIgB1fZ03FO5tg41zwW5kyi7DigdO550HO6tnjyxHXo1gzgJZRUqnzm+GQfPify1YK2kbScJN4jZHVjnqbJr14O+BJ1DMo3WUgWWu0hKl16GitQ3cidsXvgRg87FZ9voC+3hEIh8JehmBGztqUZkQOspD4AV0iTg4OC5EkEk5hUHWLPJldPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gvRFbaEhRDYCCPclhha+GjV9aE/W3dWJfQtg3rUvfc=;
 b=eNx/6aMhUpK4Sqdtyss1onPcm/6IQIOsWZ/nCO1KsIZRXxfQ4GTXmYBH0PyCzcOSdO271AWBSD5+sji6DN4x7DRFEGQnmKucwAMf9rSI78NQSNoOWP1CIPs1/Y7/GOkXKT2ockp2ZnRU0C+MY9IPAo3CsMbwJ2CZAYtlZ/xhknhzYxYR0moXev86HXbUNkZfc5BudLEtr+EzLXqfDtaojYGfNVzBwULMHbDJIit06+ebe7OXhgE8ClYtOsMDKW05Y1mQIbfVGJcjt1reAQWG5tLVhKedbdMqThAUDqLOjKMPk9fYYfv3gpzcfdNzMjFrjm2zj+UYEQSr4gYO3aeUcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gvRFbaEhRDYCCPclhha+GjV9aE/W3dWJfQtg3rUvfc=;
 b=ZAT/U73+YyrFq2g+PNWNOvYk9OrVROALARnnSbvSJ1HU5b+omje17Rf28ARS1Y8/J6/7zCM6SAQrEszMA2wb7OwOpAuTT+UrkvFsURdi16fJc9MTF5xzS7QC9WacSN7pe70j1UVIuWbYlBrttqKZE2QcRorCCIVk9CW5mPEwoDg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MW4PR04MB7171.namprd04.prod.outlook.com (2603:10b6:303:64::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.37; Tue, 23 Jan 2024 11:21:20 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814%6]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 11:21:20 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V2 2/2] test/nvme/050: test the reservation feature
Thread-Topic: [PATCH V2 2/2] test/nvme/050: test the reservation feature
Thread-Index: AQHaSR2yUW5xHTyEk0W/sAtIA45BbbDnSleA
Date: Tue, 23 Jan 2024 11:21:19 +0000
Message-ID: <rfxc3j4jscw4jiivibr5mxdhn65yyh4f5g3gykypvpbcswpud6@gtpyfwidf7af>
References: <20240117081742.93941-1-kanie@linux.alibaba.com>
 <20240117081742.93941-3-kanie@linux.alibaba.com>
In-Reply-To: <20240117081742.93941-3-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MW4PR04MB7171:EE_
x-ms-office365-filtering-correlation-id: 16eae7b1-ce71-4080-9daa-08dc1c056c79
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Jh5fqyh3zhb1g5IZQb1AxWR3W3EbqxAibewDSKbGoYnJ++QH6RUfpB5DbBLrdHCtRiLwDuZvy1dskcJAJW15rUU3O5xfj9dhSwNcQJWVDwrIYK92v/86Pht7g7gxMV775V1CphfkKYzho4tnODAYYOZEjDysvjKwJkvaHqBF5lA0MsxEKrrv3FyotCAZN+IajZPURLUV9fqI7sujpInsx4K3vLz2/AIVyh3MUMfF+8YbV7F9/K1papTTNlb2Vve29jjyXPnDW9qiEv7dJaEUMlXieKS/hwru27alYmpahviBwdvEmqB+sYQLAnZ1kYEsMxhHdncB+SEqSRUlTQreBLkJOfEwIN2U1KK3PI/D9I672DwAFbboffdZgwcNo1FwnoPWG3H372OiwUB7tRBlHuGZB0tIez35vPTOaRoldHcCWOtadN5zLX7xqjOQhqvJ59JyLEDsqkxF4j1jG745jcxL23l+vrk7JfsETPhzZeItMvd51xDR/I5kAquQrj+gbSw0IOyunJ8SwAmGUl0HqXA8ZJ9faAid9wTgW1IM6eudKYKZwmZfJKwlF7CudNYO9pI0v3QnyAO2OAsVpLVg7EQrRPs5qA6ZEQ/xP1Ef5wYTG/038gV63IBLxvNeQrgRq8BsgLrYWaanYKWsoy6tsg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(376002)(136003)(346002)(39860400002)(230922051799003)(230273577357003)(230173577357003)(186009)(64100799003)(451199024)(1800799012)(38100700002)(33716001)(41300700001)(38070700009)(44832011)(64756008)(66446008)(66476007)(66946007)(66556008)(6916009)(316002)(54906003)(6486002)(966005)(91956017)(76116006)(6506007)(5660300002)(71200400001)(82960400001)(83380400001)(2906002)(122000001)(8936002)(478600001)(8676002)(4326008)(9686003)(6512007)(26005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sQ3Unzmk+f+MwuWfP38XZxWtv9gMdJ0aXhxXyn4wAyqgiSq50tJwfoWENDWc?=
 =?us-ascii?Q?JDD5rTo7Xr7COfr6ygGYPeM6qwfabTRk74o/GP6TukdgF6HLqhNHhYUYdKj+?=
 =?us-ascii?Q?GrzAUtiHpO0jWDL30TLLFE/b/ZV7DFuy35B4oSRnB/5gZo+W+YmU8zQ1yAvi?=
 =?us-ascii?Q?f72GRh/Z3V48RexXCZj3D4SvAmfRkqDZXMRnAIW4idVpThs1I38KvB+0NDE/?=
 =?us-ascii?Q?0IBR/6iTooNK+6HB2g38yOrEwLHASIP6Nmbj9dD4g5N8s5y0i80Rj3J/5AHI?=
 =?us-ascii?Q?2pXqN2QBnOJPgRMPAKGP33BR9fAvDC0x2Gpi7QF2sKHw4E8Wktqp2Um1nV+u?=
 =?us-ascii?Q?3W7E/eoSCnkqqxrGGygl06ZyIZ9Q4DkX5RzLb8C+PWH6E9it1GGdeDn5c56h?=
 =?us-ascii?Q?ZTyxC3rb4YGK1Q5pfkO7CbVf8Wat1WHkml5JLcbjRVoyVELp3p3n3Q8GkC/h?=
 =?us-ascii?Q?cPCWtziRIVMnIBq7bLkXoTIXWBZEP28JEjuA9sLs/30NcqXt3/izrQPZJyW3?=
 =?us-ascii?Q?lK2ZrWYRVbTK4IZ4hUdeob1A7U2cQMlHoUgLKGibKeUEKBzUFnG5+oaWubqH?=
 =?us-ascii?Q?Og7v2DpZnyNOatNXaYmAIJtSay8xjPtY1O8nWLSdmmu7IjDV8w5jLaE6+zMo?=
 =?us-ascii?Q?5Dag/9lxw8jdecQmLT2gtUhq8ymwyKmFrScoDFD66MNVTvqmCJUf5bn/0iTR?=
 =?us-ascii?Q?LYrjeSwceag3eOT61r0umD3Mc9djNau2oISKcHLNP0APJvJoWlfl4m+sWewM?=
 =?us-ascii?Q?nUDFxMkR1L+px5E5zW55hULzE87gzbAKeAj9XJwIpfVghKlJTgwRGFrjnk6o?=
 =?us-ascii?Q?G8T/G8BS7HAl36NhZj8fakMZVFqZ58hClFEdMH6NhQXSjVdivbOZiejQvyKM?=
 =?us-ascii?Q?y75duJN2uIbZP3BXk0rDEKgj2sfrkl7lcWupq1Yd0s7ExUpPkESJMi3fqxEL?=
 =?us-ascii?Q?zmCcevK+Q8gyREBKha4q1cSMT5//gxzlBolSJKmlfZJK7bMkmVGsUlhg4ugx?=
 =?us-ascii?Q?Hof63K4KzJBgIFusKyG6mmDtnsaskJvIgd+8hQFinVEj4XdsK9wi3K7/WrxE?=
 =?us-ascii?Q?vSRICKQ6w0YgOxc9AL14pVH7l7H3+YWgzn4avjVQc9RQRTXQTEramVla0NKm?=
 =?us-ascii?Q?y2I0REb0orVU4e3+5W5+nk8emTmggYAilQGG1GVeyXuseJBJtPKj3GfQTQXd?=
 =?us-ascii?Q?GDav7yaU7Xx0piKiCuLFUJoO3JYN6J2PWQHNO39FbWuwZK1vPfpDb69UHVk2?=
 =?us-ascii?Q?pJTAegXVjXyJ7CxdYzoO1+z+gBKa6KBxyrfBzAZ8hvIiVvtJlsCv6yfU2QF6?=
 =?us-ascii?Q?ui4L1hKayCB5MTrRMY5iFEmNs3+sAc7GH9LksOISthRAO/0ZcfmcwQ4ci24S?=
 =?us-ascii?Q?Qw45Hdn4LwsyYg8OPUlwpnPGPJy8W3pqqQI+Vt6IsslWw0NH69ZxWGdm+8vN?=
 =?us-ascii?Q?H2XmRmKcn78gF8hkOh/GOFEpOTsjRDQgcjntjd54kHBz/jpane2QHBnwtZpY?=
 =?us-ascii?Q?2oknXqhYmQKnX7Nwz57TFPc9X/VQ+Lb+NnSoXt4t9LdklnsdlkqsKmgItIVt?=
 =?us-ascii?Q?8LZs8VlRPLmHZuGv4G1Ym5MlKHCZ7e8gBgehH2tYTpgzajNYy2vTs5ZbPLZT?=
 =?us-ascii?Q?RH45TukTNQH04r0y/mhCAII=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F02F3B3CA554EC4EBE2FFA04502514B0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kCsAkRfdVNhxTu/bYB1Kvlaj6lADilsa8+bsDsOsRQQ7MTJr5eohG6QUQCD0lG6Jz0fasrZ8WAU0HHvLdpjQy/7CXRY5cA9tpPhMDhSxQDLATIgt+PwK57IHm/2bjHTY8q7S1QbUJgQ9dpVA2ehgQVhEP5LOrEogwFHabSCLYfv7hRAjBkFk3aazALIjDmsFFCzOphPZ/Q5ARo3AUbN7HpvK6Q8GrfmT2c96yX6dCnYt6MGZQ2zcAdP8BneHcVzuT6MCAoyrFfvml49VzSf0i63yRmAyXK1jaLbJYH/AYnm4oVn+ChbxJ82jnQ4NAyReiIQWpojXSZVaW43mxJ3+q5eUW+BggxpPEwHypPhUGwHtJ2FBC9Xo27vwZdDK1zA4vHCCOL/ruk5p2/Ap7/Il2NcVFXCVHzGez3c6vbbLMsoM+oBaKTQu7qCtV+h41wsUgilhZ5EhSPJD4b978k/lkRI5tnYiM5Sy229zgSUsDmo6/CjsxEOaWjM5ajgJfdw05ujUPC9yuImLw0UFL/eL23nkFdJhSKW9SeT7eVMEEc2Tm27PCQpIQHOFiLdYGd6x9yyIKq4e+0EvJJw5IZXXJ7Tt2jFSSf3uuMRDUT/9rRR4MBneFNUJssBBfjG/lk9O
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16eae7b1-ce71-4080-9daa-08dc1c056c79
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 11:21:19.9871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SdYbImLAXpz0XW1/ai18CLUxemr2Xj+NAmu0nX/yYbuDmpmzkqOp7XxhEeP9Ak3aNh67H4UwbNhAQEB80R2eg0d3LAR0Cp8f4zuww6yQ9jc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7171

On Jan 17, 2024 / 16:17, Guixin Liu wrote:
> Test the reservation feature, includes register, acquire, release
> and report.
>=20
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

Thanks for this v2. I ran it with kernel side v4 patch [1], enabling lockde=
p.
And I observed lockdep WARN [2]. For your reference, I attached the WARN at
the end of this e-mail.

[1] https://lore.kernel.org/linux-nvme/20240118125057.56200-2-kanie@linux.a=
libaba.com/

This blktests patch looks almost good for me. Please find minor nit comment=
s
in line.

> ---
>  tests/nvme/050     |  96 ++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/050.out | 108 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 204 insertions(+)
>  create mode 100644 tests/nvme/050
>  create mode 100644 tests/nvme/050.out
>=20
> diff --git a/tests/nvme/050 b/tests/nvme/050
> new file mode 100644
> index 0000000..7e59de4
> --- /dev/null
> +++ b/tests/nvme/050
> @@ -0,0 +1,96 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024 Guixin Liu
> +# Copyright (C) 2024 Alibaba Group.
> +#
> +# Test the NVMe reservation feature
> +#
> +. tests/nvme/rc
> +
> +DESCRIPTION=3D"test the reservation feature"
> +QUICK=3D1
> +
> +requires() {
> +	_nvme_requires
> +}
> +
> +resv_report() {
> +	local nvmedev=3D$1
> +
> +	if nvme resv-report --help 2>&1 | grep -- '--eds' > /dev/null; then

It feels costly to call "resv-report --help" multiple times. I suggest to c=
all
it only once at the beginning of test_resv(). Based on the check result, a =
local
variable can be set up and passed to resv_report().

> +		nvme resv-report "/dev/${nvmedev}n1" --eds | grep -v "hostid"
> +	else
> +		nvme resv-report "/dev/${nvmedev}n1" --cdw11=3D1 | grep -v "hostid"

The two lines above are almost same. I think they can be unified with the
variable passed from the caller.

> +	fi
> +}
> +

[...]

[2]

run blktests nvme/050 at 2024-01-23 19:05:08
nvmet: adding nsid 1 to subsystem blktests-subsystem-1
nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN=
 nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
nvme nvme1: Please enable CONFIG_NVME_MULTIPATH for full support of multi-p=
ort devices.
nvme nvme1: creating 4 I/O queues.
nvme nvme1: new ctrl: "blktests-subsystem-1"
nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: possible circular locking dependency detected
6.7.0+ #142 Not tainted
------------------------------------------------------
check/1061 is trying to acquire lock:
ffff888139743a78 (&ns->pr.pr_lock){+.+.}-{3:3}, at: nvmet_pr_exit_ns+0x2e/0=
x230 [nvmet]

but task is already holding lock:
ffff888110cf7070 (&subsys->lock#2){+.+.}-{3:3}, at: nvmet_ns_disable+0x2a2/=
0x4a0 [nvmet]

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&subsys->lock#2){+.+.}-{3:3}:
       __mutex_lock+0x185/0x18c0
       nvmet_pr_send_resv_released+0x57/0x220 [nvmet]
       nvmet_pr_preempt+0x651/0xc80 [nvmet]
       nvmet_execute_pr_acquire+0x26f/0x5c0 [nvmet]
       process_one_work+0x74c/0x1260
       worker_thread+0x723/0x1300
       kthread+0x2f1/0x3d0
       ret_from_fork+0x30/0x70
       ret_from_fork_asm+0x1b/0x30

-> #0 (&ns->pr.pr_lock){+.+.}-{3:3}:
       __lock_acquire+0x2e96/0x5f40
       lock_acquire+0x1a9/0x4e0
       __mutex_lock+0x185/0x18c0
       nvmet_pr_exit_ns+0x2e/0x230 [nvmet]
       nvmet_ns_disable+0x313/0x4a0 [nvmet]
       nvmet_ns_enable_store+0x8a/0xe0 [nvmet]
       configfs_write_iter+0x2ae/0x460
       vfs_write+0x540/0xd90
       ksys_write+0xf7/0x1d0
       do_syscall_64+0x60/0xe0
       entry_SYSCALL_64_after_hwframe+0x6e/0x76

other info that might help us debug this:

Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&subsys->lock#2);
                               lock(&ns->pr.pr_lock);
                               lock(&subsys->lock#2);
  lock(&ns->pr.pr_lock);

 *** DEADLOCK ***

4 locks held by check/1061:
 #0: ffff88813a8e8418 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0xf7/0x1d=
0
 #1: ffff88811e893a88 (&buffer->mutex){+.+.}-{3:3}, at: configfs_write_iter=
+0x73/0x460
 #2: ffff88812e673978 (&p->frag_sem){++++}-{3:3}, at: configfs_write_iter+0=
x1db/0x460
 #3: ffff888110cf7070 (&subsys->lock#2){+.+.}-{3:3}, at: nvmet_ns_disable+0=
x2a2/0x4a0 [nvmet]

stack backtrace:
CPU: 0 PID: 1061 Comm: check Not tainted 6.7.0+ #142
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-1.fc39 0=
4/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x57/0x90
 check_noncircular+0x309/0x3f0
 ? __pfx_check_noncircular+0x10/0x10
 ? lockdep_lock+0xca/0x1c0
 ? __pfx_lockdep_lock+0x10/0x10
 ? lock_release+0x378/0x650
 ? __stack_depot_save+0x246/0x470
 __lock_acquire+0x2e96/0x5f40
 ? __pfx___lock_acquire+0x10/0x10
 lock_acquire+0x1a9/0x4e0
 ? nvmet_pr_exit_ns+0x2e/0x230 [nvmet]
 ? __pfx_lock_acquire+0x10/0x10
 ? lock_is_held_type+0xce/0x120
 ? __pfx_lock_acquire+0x10/0x10
 ? __pfx___might_resched+0x10/0x10
 __mutex_lock+0x185/0x18c0
 ? nvmet_pr_exit_ns+0x2e/0x230 [nvmet]
 ? nvmet_pr_exit_ns+0x2e/0x230 [nvmet]
 ? rcu_is_watching+0x11/0xb0
 ? __mutex_lock+0x2a2/0x18c0
 ? __pfx___mutex_lock+0x10/0x10
 ? nvmet_pr_exit_ns+0x2e/0x230 [nvmet]
 nvmet_pr_exit_ns+0x2e/0x230 [nvmet]
 nvmet_ns_disable+0x313/0x4a0 [nvmet]
 ? __pfx_nvmet_ns_disable+0x10/0x10 [nvmet]
 nvmet_ns_enable_store+0x8a/0xe0 [nvmet]
 ? __pfx_nvmet_ns_enable_store+0x10/0x10 [nvmet]
 configfs_write_iter+0x2ae/0x460
 vfs_write+0x540/0xd90
 ? __pfx_vfs_write+0x10/0x10
 ? __pfx___lock_acquire+0x10/0x10
 ? __handle_mm_fault+0x12c5/0x1870
 ? __fget_light+0x51/0x220
 ksys_write+0xf7/0x1d0
 ? __pfx_ksys_write+0x10/0x10
 ? syscall_enter_from_user_mode+0x22/0x90
 do_syscall_64+0x60/0xe0
 ? __pfx_lock_release+0x10/0x10
 ? count_memcg_events.constprop.0+0x4a/0x60
 ? handle_mm_fault+0x1b1/0x9d0
 ? exc_page_fault+0xc0/0x100
 ? rcu_is_watching+0x11/0xb0
 ? asm_exc_page_fault+0x22/0x30
 ? lockdep_hardirqs_on+0x7d/0x100
 entry_SYSCALL_64_after_hwframe+0x6e/0x76
RIP: 0033:0x7f604525ac34
Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 =
0f 1e fa 80 3d 35 77 0d 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff f=
f 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
RSP: 002b:00007ffec7fd6ce8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f604525ac34
RDX: 0000000000000002 RSI: 0000562b0cd805a0 RDI: 0000000000000001
RBP: 00007ffec7fd6d10 R08: 0000000000001428 R09: 0000000100000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
R13: 0000562b0cd805a0 R14: 00007f604532b5c0 R15: 00007f6045328f20
 </TASK>=
