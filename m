Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C1521B8F8
	for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749540683; cv=fail; b=plxS0mtKkmOhpEq8yEtVIyZ+7gGXJyjtLHEpVQf8JqbjJosMkd1WkHL1AbtB3HJG4i85DA8vKMdy8AsS0pLHF4mKI0LEcd/N7u9ihvKH48L8CGkfra2cKUEO9Vdsui+aLvBGbeTL+/TdOfoEy5VMaEnMAcgwtbXlQgj5jF7ow9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749540683; c=relaxed/simple;
	bh=22f6LgqlAdjTEsz0Fgh+RLliC/YcAxfv5sIkhgWNXhg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=up8+1etryL7ptRpP3fLd2+EjdupFcR+1XbCYg1zd2p06074kKZ0VCxOeZ+b3kDgNrT6PD8qeaRfaOZlL7s35V0lH8ZkUUdhOZvcyhAWnFFaAZtKt2Gt5vk2VyIXgi4GO0l7Z/x+NLTGpfp+9IeTWZi5W8Vy5lyLS7qZL5jAspUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=c1/Qzqki; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Ai2xbszr; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c1/Qzqki";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ai2xbszr"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749540680; x=1781076680;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=22f6LgqlAdjTEsz0Fgh+RLliC/YcAxfv5sIkhgWNXhg=;
  b=c1/Qzqki66iA/GVCusFRgHSHkne6//8O4adczqWcPPIN8hzEWZtk0Oyq
   Xs+HXM7mvdPO8Hj2t6TiqJo60/EtAmfvGZN2wsQHV0hNgCtLRi95h3nmV
   MzujIqeFYQCpZOJrQLgbdV5q2F2+B8WuSv8YWzVk7HS0A7yOm+ZSsd2oo
   yXDY6En6gFwN7/UFTwdcHpAA0aSt9nCNkcq2RKpDF7QTe/Jhr675pe6Rm
   u6APEr7UrAyzuvQySzNSQ1JU1BlDa3FwZWGAKDwf3+nmxTrnSayTJJjHw
   LSu6RpPxZ9b0qPbhasDuVz/oZhFcgxnfYZWBfniwjMm4ADMz0yEPDXKgQ
   g==;
X-CSE-ConnectionGUID: Gyopy4T9SwO5iPSdphXoEw==
X-CSE-MsgGUID: fLkXFh/DTnCUEGRO6kiHQQ==
X-IronPort-AV: E=Sophos;i="6.16,224,1744041600"; 
   d="scan'208";a="86303448"
Received: from mail-dm6nam12on2082.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([40.107.243.82])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2025 15:31:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qip6nbijQiPY024JJaR/v9PVqgpUu5yCjQK9FDzunNaWPJ9eV2TScV1i7Rlly/GyGFfvdW9diubEp/P09KOZfDgnnQTxK9xPXMuSJIr+/B8T9jiROqP2FZP7Am2g17g0gleoSoqUqOvXvxACZsT8coUmeuQ2njXPEbfFvMPLkJ5qynoCnYpWEblnhbSP5ikGzOqwgxe/4NT+Kw5sQdFIFjZKjMQ98s6CElQdrjtjpZRjI1Z4llp4FgwMsSanoFJChtSjIrHYmIrgI7h9w+kJrrnczOR9FhO2L15Kmgm8GLOTyGXB/l6byPm/LooALyVeBiHuVaQmxI0GaU8RuNqnFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wo/Tmm64QLy3cHlNy3emI+MFdsT6jmHqBm2kckQrvwo=;
 b=isFJ6aCPWQq2nBbQ9G+Zvtc9kEBo+S9xsMkDUNDPshEKfbjieu3tr+vD9srPsovh2OFvJxT4RNHoDb5HTorhNe3HSK+v2mWcOuFp1iUiNr/3OC4aIUPelCKyj3g0/YoAhOFNr7L1c2is2E6wiwJZXDQwdLtvc7Ype2wY9+ncIWq/YrcjUnw2H67N9QcWmrpMEdpeOi+c25Bhe342nZMTSSFZPIIIs9O0BK/r1Mj/7cSiySQAIC7MDTyaHoemWP2pzIvMcPH0fTiw53bfAysQfqOB50v9KwHsTC3y6JQ7X7A2GxJ1nMIpiGOWbxe6mFQYLFbV+96N0bjQzjONNEwfpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wo/Tmm64QLy3cHlNy3emI+MFdsT6jmHqBm2kckQrvwo=;
 b=Ai2xbszrBZttIYEBZ2gYFi30ltHOW3AN1n+NoaXD98dojppfg8+f9EID3ksSPJ2bD5TGHSdAavtuU8KDkox7sven1U/xevQKGsOOZpKTkV0nSnwKf/nhgZPA0AYYfdQKhYfA+kxO5c+AxyRNdW4gWmN7n741o1ZAjF4ln72ZQpw=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by BL3PR04MB7962.namprd04.prod.outlook.com (2603:10b6:208:341::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 07:31:10 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 07:31:10 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Keith Busch <kbusch@meta.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] block tests: nvme metadata passthrough
Thread-Topic: [PATCHv2] block tests: nvme metadata passthrough
Thread-Index: AQHb2VT/c7SNum11mU2jICi0RCaOB7P8AJqA
Date: Tue, 10 Jun 2025 07:31:10 +0000
Message-ID: <pgyqdqi76m7skiyirtjb3d7wtbb5223sk64eoqtafg7r763biw@7f4pdqtoptiv>
References: <20250609154122.2119007-1-kbusch@meta.com>
In-Reply-To: <20250609154122.2119007-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|BL3PR04MB7962:EE_
x-ms-office365-filtering-correlation-id: 53694b73-bfb3-4a55-2540-08dda7f0c59e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+oC10e6DZwbLbvl2w55e7dFAm7eRWMiLhinby6Z0rW+D/e1ujDy8BXoX6Sc7?=
 =?us-ascii?Q?S+aOe580ZZIhKk+NrRexrBsNtABC+k24I933TI7pS+d9psVUbolKy8p6p7aY?=
 =?us-ascii?Q?/RXPoUFCxh0gGeX5IXlr0O7hOS5/axFCQ1JhY+Qs8UrTMzatWby328SD4SYB?=
 =?us-ascii?Q?mWX1hxPgwqbkff7Xknu5eWTTqFQwKlYvpLiG6bO94WqOZzaEdazx+3OBasZK?=
 =?us-ascii?Q?Tbj8FOlYjsMuGpk6qAaCst4ASJ0g/x1+iptgRzSeSN+Qw+yMPippfRuTE0pR?=
 =?us-ascii?Q?677Ua9I5gAFq1Vr+wj5gk9ptFbeze1p2HJr3PXrNWp51c4ZQa9x5e7hmtf1/?=
 =?us-ascii?Q?g6TKNHaPiM4UYLXtHqcaSTOvN2GCiC5Znr1+l87yv83hdJ/PWOzLWAy1mzNz?=
 =?us-ascii?Q?Z9S3Op7ZBu3RtPRPTqBEXLBAWPVOxrf9X8wsObCAziShRnsVQ3IhRPQAUKbx?=
 =?us-ascii?Q?ZaSK2Bw4o9ZrTqCR/mUsY8gMjRmmUzAVGp6fMSfLIF+SUpB3POYIVpztJZHY?=
 =?us-ascii?Q?SDBDIWqhXEZkv5tBcD3UuA+NjaXy41TNbYYULjDNsEkLok76e1lolQLcB/35?=
 =?us-ascii?Q?xsWcHYnRnC9SJOTd5TPJt9DJ8wZpGBjbQbMxBTm6V3mL/GCA/ZAi5nhCjz7U?=
 =?us-ascii?Q?knqgoSzkBHx7Gl9m+iUBTICvrJ8fAtJk28GPwS+wWTPG/FAwai3AvwlRCrN7?=
 =?us-ascii?Q?ISWSaXUjCZlSc+O4tGCjC8qypuPtxzud4HzN8ZYXe+0KuNEHGXVFMucLr4UF?=
 =?us-ascii?Q?LyCaEzBeJVbF+atLvOv30NW9GCEemlC2Fh+BdkcBzLr7SEGKir6BKjXBKud5?=
 =?us-ascii?Q?p0p7MkmSQphNgPcNkuSDOiZ06sYebFWuzsTCaVedsIUXy64+6Khsiw8tv36A?=
 =?us-ascii?Q?5M6J5yT8mSOEc2X3NAZ7yvZNai21c94m/V2V3cvZjaBDj62qNrmfAYoq6yJH?=
 =?us-ascii?Q?v/yzWG4yVM9XJdNsnuO6BY8zr7EjG14EuaA3mzua0+GWRkEri8GX5SH79s0z?=
 =?us-ascii?Q?Kpbi5U7NgiFK1/fgeTEJX/PkudvX/yFtZQsvA3icFyFbZDNUx9UflIMSWAzE?=
 =?us-ascii?Q?OZQWmVk2zCcYKv+kFcDdj4yotu27GmL3akK9mn0IZ619R/6uOlG0OxbuPSv4?=
 =?us-ascii?Q?JwDUmbAyHVjM8ReYfASgRlwi98oBh8oRrdgcnEBCCzeQ6hbwYixYR8WmLB26?=
 =?us-ascii?Q?hTpfr0iQZsU0A0b6+XnzpKgW1QNJLDHs/GY/uDlZM6Z5scVR9mT9IS0f5r2H?=
 =?us-ascii?Q?+p3L9kAYikqOza1xLUveowz5QL0oQWPWClhoV8ozTjPIaWN6z2rE6TpG6G/x?=
 =?us-ascii?Q?+otmHwv+yb1Zw1VCtgNF5xlyRyoD7FNoefpZY6NQLE81UPH/3HG80j1z26bK?=
 =?us-ascii?Q?0ivUrUPOTn2MSn6HbanmUubUP0udQUmwa/Fv5jNCUv2H8bjEytzyx1GUviT2?=
 =?us-ascii?Q?9PfIZBrw2QLenrb9Z1oZjf12cMd6ztQ9pnAKz37QbKkn0xg48TqGuXqi2HEd?=
 =?us-ascii?Q?CdqtWPqM3BH/r6Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Hu7OocGL3R2grIh8OgOHtT6Lse0IXoY30FhtMqQFDc2XctzKrD/YcWZrwz3V?=
 =?us-ascii?Q?IHk4AFjFRkWesAn3Y10tnF05dTN4SbUtOZ1O4MhZ2gF++ZYkHMGd+YZs/qiC?=
 =?us-ascii?Q?NcSUqvth8OJQNyL4UlDFSxyrZknUQI/wxt0EpqGlWN6RO8B5o87UJ1WDZMkE?=
 =?us-ascii?Q?cvAMy1r35+5bvmp1cymujGvO0S5ekOdUe5nnvSRAkTee+1VeOtquAkF+duk5?=
 =?us-ascii?Q?4SIBvuIzygXuJnyQ2dkebub/JAh54QDmLWo2uZFJkXv0y7DmwfuS1WMLOLJA?=
 =?us-ascii?Q?NCqddXpawvda1VFqC/MJTn31YbfoV1W5vpPyB1fuQGuRAZsCgeYb+dKuWUL9?=
 =?us-ascii?Q?N66uAXRL3Fg82X8mDcSgORMG26Th4aCHqo0ElhfSkCemyu93eW6XGOsILNDw?=
 =?us-ascii?Q?RkaqJ/F2s+dzNFkWKLretgf51NZpGmqvdGN7yBcDKBDZV5rh/TwQFo+61Ttz?=
 =?us-ascii?Q?/rhEnhfJaedD2bWxHmlctlZ48kimPpepMGeQJCiJ8GtCsBTDpMBmS1DCdqM3?=
 =?us-ascii?Q?uoZxr7wKZ3e9Yjg5Utne0Ggl3ZmoEnjr5HeSvVbU5xseNahabiyrQ2931zRc?=
 =?us-ascii?Q?ipQKFeI23Y6z2+UX2xke5Pgt+pN/z/OZZCzjMcZx2gZSm3JIFVV+RsKsB0oP?=
 =?us-ascii?Q?u052nejfbWog99r3E012L/GdqirJ4pD57OTE9wYcrHiZtEertCLMeeu1iNzC?=
 =?us-ascii?Q?SSqtXvYfjmf9w02F84UXKGkhCPgJnEQIRBe3PvR3ohTv71jY9Gb6wlvvUgJ2?=
 =?us-ascii?Q?qTEjyPDcHJA3ZdnjfFpQyZJmJSgRa1SvOQi3hc192pRvLbCyQ7ICxvJzX/B+?=
 =?us-ascii?Q?rK6KAPeI/DAoy1Rq0mhLu7l3z9lQZ+tVifRbNFFdiIql7WnWKzCDBVm5XTh6?=
 =?us-ascii?Q?ubp4xGSrDChLgOiUGoNQH1T2sQFme+8Qk18hRPLdKTtPV9U4e+PUdqTk/Im0?=
 =?us-ascii?Q?4xmvPkFm3qqnW8rjc1zinZGMz1hjtHuEtmdexQvIHNk75GiBu05GmzE3q/go?=
 =?us-ascii?Q?OJLngfmeNisHjfG/dHdkjHODzAu3w9GX2zADe3PPSLMJzgHSebCeBXF5R6Uq?=
 =?us-ascii?Q?84PXLnVbdvQ1aS32Gl2s68SHEXi4syogcMis0yD4BD6Mx1YgqmuJWlLMKbg5?=
 =?us-ascii?Q?XIPH3mLdIderyUZl1zpZKyYFnSDgxfEXQxn1p6CCKtfJ1Nq31eswwXr8ELHd?=
 =?us-ascii?Q?ITgl+UOYwuHa3cy0/bNSQh3dwBdIXMN6FTHhLfUG4bB7aLjg+PIfpvuAdFQO?=
 =?us-ascii?Q?V8Z9ZIm9ohTVbkbvAh/ZNQxpsQYOPRn7GFDsOAE5HbrRiv7mhYrBqJCjN6cN?=
 =?us-ascii?Q?crC5MQrCeifF8qjvZ6UHe24xHMlG84MEjwIIprG5dJMbwE0wCX3qMH6K9JMa?=
 =?us-ascii?Q?8Cmg1NkrWQrQlJHXxFvcdLy1nwKVFiLIGh9MH3s6AEoZMR/jgZQ+V1Q3ehi2?=
 =?us-ascii?Q?6jkizapIso6WEQ0WyonJ5mP4AlXgze9n7uBG9iUumCAmM209GZ4gZv++Bbch?=
 =?us-ascii?Q?2z+9e+9bZrQzgCLDJW042QE7c3jkNEiXMjLzj0LDvQf3i+WO4eQVa5qPL0j+?=
 =?us-ascii?Q?e+BoeaCfy/Y4wRXDPK1A1HGZ8rseKzWrbW1DkGfm0WK5X6o+Rt18fsRzwc4I?=
 =?us-ascii?Q?Jw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <600C9E37A1BA76458BFAEF6A51177495@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	flAhHF+MM8zzssi7AkKsqHeJs4iLUmz0hjlGX7W/FGXxrnE4qEQZ9ibYBlM7OlqlsCZva+b1nYdSa8ixFmxjG4N1EEQCukva6rsOCUrObqIFAqAXYX/PJnhnSAAcjRdhM9mr+TYpn53QjUOQngrOpeQZycxWJzVZuD1t2Yz4r17R7t0t4RPspbmweIDGyL7VGR+ACQ8BXAf6L00Fm+O6/vW2RQKq8pXRPRyyAu3rqfAe0DWvxSF2xHo5Gj0tev9481Ve3QhkMZtKWBP+vWa5osqDGTnZUfqd/UFGKZ+qlPULobuTmX7RUOdjG/Tw188j7Z0xnlhABvaqMEdUDwpK7YfPV8fsHx7AHyABdgCQi2sUbcFIYrlWUdcHVJxUlUPlXlyYdqLcqUQZSpsXwsAEyUbtXajIfITvarXN3+rer3gg7vHZA6HuzBF30XBaLIodI0UEkZMOaH6KAUShtu+Z2I8lgDu6sxuIFHPyc8+m1qlO4vfrt5QBL3Ia9SOuBnQanjdtKsn0sAmq8icq7P2VoVYhBfWcrNT2D/8O+Hz2lWu7yObPgfMvSOGFtfPBU6IyJG9glrTmNA/PPhs0eKOWVAKit/lIsprNP+r4MxNPmo7MzNb564PvkUwVkXVRMSwY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53694b73-bfb3-4a55-2540-08dda7f0c59e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 07:31:10.5889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jg7a/SSZq3Ey6I0jQn7EPqNbiT6v2u6kaH0TwH3WJH9yLfIL54iCs69wHDOuy2PwmgTIemVuNPGQe+uD27JXsoBgEGCsbHXdWLinCSfQFCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7962

On Jun 09, 2025 / 08:41, Keith Busch wrote:
...
> diff --git a/tests/nvme/064 b/tests/nvme/064
> new file mode 100755
> index 0000000..fd72d4a
> --- /dev/null
> +++ b/tests/nvme/064
...
> +test_device() {
> +	echo "Running ${TEST_NAME}"
> +
> +	if src/nvme-passthrough-meta "${TEST_DEV}"; then

I think the check logic above should be inverted:

	if ! src/nvme-passthrough-meta "${TEST_DEV}"; then


Thanks for this v2. With the fix above, I was able to confirme that the tes=
t
case passes with v6.16-rc1 kernel. When I reverted the kernel commit below,
it failed. It looks working good as the fix confirmation.

 43a67dd812c5 ("block: flip iter directions in blk_rq_integrity_map_user()"=
)

To run the test case, I tried QEMU nvme emulation devices with some differe=
nt
options. I found that the namespace should have format with metadata, and
extended LBA should be disabled. IOW, QEMU -drive option should have value
"pi=3D1,pil=3D1,ms=3D8" for the namespace.

I suggest to describe the device requirements in the test case comment. Als=
o, I
suggest to check the requirements for the test case, and skip if the
requirements are not fulfilled. FYI, I prototyped such change as the patch
below. Please let me know what your think. If you are okay with it, I will
repost your patch together with my patch for common/rc and tests/nvme/rc as=
 the
v3 series.


diff --git a/common/rc b/common/rc
index ff3f0a3..7155233 100644
--- a/common/rc
+++ b/common/rc
@@ -422,6 +422,14 @@ _test_dev_is_partition() {
 	[[ -n ${TEST_DEV_PART_SYSFS} ]]
 }
=20
+_test_dev_has_metadata() {
+	if (( ! $(<"${TEST_DEV_SYSFS}/metadata_bytes") )); then
+		SKIP_REASONS+=3D("$TEST_DEV does not have metadata")
+		return 1
+	fi
+	return 0
+}
+
 _min_io() {
 	local path_or_dev=3D$1
 	local min_io
diff --git a/src/nvme-passthrough-meta.c b/src/nvme-passthrough-meta.c
index d19ee25..29980a2 100644
--- a/src/nvme-passthrough-meta.c
+++ b/src/nvme-passthrough-meta.c
@@ -139,8 +139,10 @@ int main(int argc, char **argv)
 	meta_size =3D lbaf.ms;
=20
 	/* format not appropriate for this test */
-	if (meta_size =3D=3D 0)
-		return 0;
+	if (meta_size =3D=3D 0) {
+		fprintf(stderr, "Device format does not have metadata\n");
+		return -EINVAL;
+	}
=20
 	blocks =3D BUFFER_SIZE / block_size;
 	meta_buffer_size =3D blocks * meta_size;
diff --git a/tests/nvme/064 b/tests/nvme/064
index fd72d4a..eb9ca50 100755
--- a/tests/nvme/064
+++ b/tests/nvme/064
@@ -2,7 +2,12 @@
 # SPDX-License-Identifier: GPL-3.0+
 # Copyright (C) 2025 Keith Busch <kbusch@kernel.org>
 #
-# Test out metadata through the passthrough interfaces
+# Test out metadata through the passthrough interfaces. This test confirms=
 the
+# fix by the kernel commit 43a67dd812c5 ("block: flip iter directions in
+# blk_rq_integrity_map_user()"). This test requires TEST_DEV as a namespac=
e
+# formatted with metadata, and extended LBA disabled. Such namespace can b=
e
+# prepared with QEMU NVME emulation specifying -device option with
+# "pi=3D1,pil=3D1,ms=3D8" values.
=20
 . tests/nvme/rc
=20
@@ -10,13 +15,18 @@ requires() {
 	_nvme_requires
 }
=20
+device_requires() {
+	_test_dev_has_metadata
+	_require_test_dev_extended_lba_off
+}
+
 DESCRIPTION=3D"exercise the nvme metadata usage with passthrough commands"
 QUICK=3D1
=20
 test_device() {
 	echo "Running ${TEST_NAME}"
=20
-	if src/nvme-passthrough-meta "${TEST_DEV}"; then
+	if ! src/nvme-passthrough-meta "${TEST_DEV}"; then
 		echo "src/nvme-passthrough-meta failed"
 	fi
=20
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 9dbd1ce..f69ceb9 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -153,6 +153,21 @@ _require_test_dev_is_not_nvme_multipath() {
 	return 0
 }
=20
+_require_test_dev_extended_lba_off() {
+	local flbas
+
+	if ! flbas=3D$(nvme id-ns "$TEST_DEV" | grep flbas | \
+			     sed --quiet 's/.*: \(.*\)/\1/p'); then
+		SKIP_REASONS+=3D("$TEST_DEV does not have namespace flbas field")
+		return 1
+	fi
+	if (( ${flbas} & 0x10 )); then
+		SKIP_REASONS+=3D("$TEST_DEV has NVME_NS_FLBAS_META_EXT on")
+		return 1
+	fi
+	return 0
+}
+
 _require_nvme_test_img_size() {
 	local require_sz_mb
 	local nvme_img_size_mb=
