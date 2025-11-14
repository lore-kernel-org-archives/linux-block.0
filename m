Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F46C2FCC1E
	for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763110468; cv=fail; b=siZ81dQ8sA0q740AbFpgN78sFbVg1WzopiHKFgPe+RZq9lykzQDr9oQ71wlslmjfLIlZV5chIspasExW6gNcd/xnLUx+mwglUnNHP9+4gqOWGM/Xol0JKeEg+n978+iJ69Ba88siP0zmKzuorVSw6U9d0HHo3f/gCMD0nck6e6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763110468; c=relaxed/simple;
	bh=4xvH7MYfkfTydiAelUJevDUVjNybl47GewnPR/CD2FU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j7VeRE1dy2g1JRGwMXEweMhL9PF7sh9lE/6SRl/CguoGY02hfNg5csAU4aYJSBdsskt5/DdvPaMI6UsmGy5Qx5XU2uNpYkhMdywxf5W2jEoU49vsEY0YyFn67UXw2NOU504TP8EaNvcViqjoN4wpbgKfPWFKvCErLQq7bfPvVvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZZbCWa7U; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=x2XAbvVG; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZZbCWa7U";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="x2XAbvVG"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763110466; x=1794646466;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4xvH7MYfkfTydiAelUJevDUVjNybl47GewnPR/CD2FU=;
  b=ZZbCWa7UOqVKdsRkIcDFaMhsYZSZudkNtfv/nNSLLj5QEuWJLj/aSbUu
   KHheH44PM44FyOHn2W8iED60rSIj7A7yti0T0a+2SiM3sEjeVXOZeOfsG
   J4FH/R5Y5akjIRqCSAbhmdZ9QUTabIdXGqpm9vg1bKRNEdH1JfMCtIGa6
   7wQQbDjOdnMtTTlBxiPWSLiiivBQkZQKV6HElouU6WuZ0OLiXea49Fdna
   ivicVLxXFt0Zy6H1r3wXjFJVjEH2GH+aPMHHvBWPVf5u6hBHT+SgueesH
   nTNuJHlfsDzdS95jzuSCIdpOrgq1G+G/iBCCVxg7NOudIJddiEYu1AnGe
   w==;
X-CSE-ConnectionGUID: /JoJe76uTk+iCSlNIqmfrg==
X-CSE-MsgGUID: TdynRucgTY+/xh1Glf1LBA==
X-IronPort-AV: E=Sophos;i="6.19,304,1754928000"; 
   d="scan'208";a="136422515"
Received: from mail-northcentralusazon11012037.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.37])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2025 16:54:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouIJxz44M3wphiTIAnLTJ8eqtGxFuXOb7BoGUtpHrLpPCl1E4dRIw9sc5/AMLrDQYwrY8FQ7QcGskaE6K3MOwnr7zyYkHeIw8Hahfy3ZTWruoZ6XDOIrKWBzzCvadMCa2ZKAPZGxnw1c0GmGOVEGhrQusZzS1L7x8hXATN8tNCjcaIOIvWjD/iWixAFV4s2n1+ujTlxUl4PCznhqEY6mtPwZm+Nq82oAAfTeMkLuj8l9fzA0FlgSn4lPgRTzwnHsKNZqR6G5WeO9GVKxjEIs7qMzdwIXeIVZzYMmyJhwMgTwrTNxWmka08IP1g2w5Gk8tDB3ioxFpI/ThL05yeZZAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xvH7MYfkfTydiAelUJevDUVjNybl47GewnPR/CD2FU=;
 b=wwDKB2Y3kDk6uJUmbFpNp1Lgehco5F5kYyE1WrWUn6qXVxew5SuWWvzphyzAR+M47GtLJ7Y0un5/P9Fu+pfYRbvR4RFP97UXRdda2irW1ZlucT7M5PN8FLwDKMk7Ftwb1OT0eakLeR48mXfE74YKtN75ghVxK3cF445Xa+83MGzaxO5fhxQhXwXGqbJrMGHewWFFMH2PTBYjq4ZAeAdZE2/86dXpXqWQ6vY3KvIbUE8Dxga0tTsgsGr6IfUeak4I3R2lDlKhLWvtMloZV0z7JbaA3fHzbBvIgxksVheJxGr94a13PLtd0tKlk9im119JOrMemgue4kGWKZApHfDYpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xvH7MYfkfTydiAelUJevDUVjNybl47GewnPR/CD2FU=;
 b=x2XAbvVGyBc09Db4qfEsqqkFRKfd0R37L6OJCHTFgDWS4TltK0Sgvm+sEy5juF107WtFmfXp5ftlfn/BcesQZKwsww/N5fB5zPyyVGLy+JOWgVYghf0SUdYV+3LAmhDrC8/B0UwTJ+JNVQ2AsVOLPgjCYwqmHqFcid9cgafF4Fw=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by PH0PR04MB8575.namprd04.prod.outlook.com (2603:10b6:510:291::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Fri, 14 Nov
 2025 08:54:17 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 08:54:16 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, "wagi@kernel.org"
	<wagi@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests 1/2] common/rc: add _have_kernel_options helper
 function
Thread-Topic: [PATCH blktests 1/2] common/rc: add _have_kernel_options helper
 function
Thread-Index: AQHcUJaLfADf3J1+0ESHKtu9lSQvsrTtS8wAgABf6ACABDuggA==
Date: Fri, 14 Nov 2025 08:54:16 +0000
Message-ID: <trkisk2jogj2q6gfdmuhgr6nraofzijvqr5idpuwjvw725xdyo@jielqspuoro7>
References: <20251108100034.82125-1-ckulkarnilinux@gmail.com>
 <357kwngm5y4lj7qxkhnx3xhqb5vtltwwxodvg7slwwmi7ppwiu@uzgyu747o2pj>
 <73fc087d-5a56-4999-8f5a-72e28e2dfb47@nvidia.com>
In-Reply-To: <73fc087d-5a56-4999-8f5a-72e28e2dfb47@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|PH0PR04MB8575:EE_
x-ms-office365-filtering-correlation-id: 5f4dc8cf-da7c-4c3d-dfdc-08de235b6481
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LXNGCVNNashQnvhSvaFeZLAPGIcHutHMkdb2lq7tpAjc9lF6Eg7Qt2x+2Zck?=
 =?us-ascii?Q?bxUwaDxle/KlgOaxLmw+I3pnFkjcuiyZogNqT20tHVfDn25NTPDuhMtjhyec?=
 =?us-ascii?Q?uFdpIXr+hgi5jt7RLyEfRhd+Sr3DbGuFfIBF/q9Kz/JCbpPGem4QbSvVwWb+?=
 =?us-ascii?Q?6DCSo7YkwQMqLOlrnyL0YDGF0PryrT9qz2PDK6kz2yezZhrwlj6vYldVWuCr?=
 =?us-ascii?Q?dMOvZkMtCsCVJHu3HaChalGk5dzJ0OONBGWjAzZ83REs2P05jUh9F+3vDcRx?=
 =?us-ascii?Q?wMi+JdsBk3q+jP6LHhI0jHu+4PjLTWguwIfF3snn2MnrEllCR7lDHCRFBlBr?=
 =?us-ascii?Q?4Ei2CiVtRaG81BevMJlZS5cMuQF8ZJfnCmPhZ9Og6MXq3YWgyfEA3I2INXGD?=
 =?us-ascii?Q?p1zPTAN5Om8OxSw/9CtHUIPenGFJGk3Fh9vSXH071RRdU0yRqXAygNuzjOob?=
 =?us-ascii?Q?ZaJUUkl9qJkyt/6KuNOHJn9/GBVfTddo7Ygm5SY5Y2CAxO5z7rMXRPGv7Ujn?=
 =?us-ascii?Q?hV+eUtNqu1t63keu2cv7mJCZxAO0uHoKVmuSXGUPN/nBeZGXLAo9WMo0MsYu?=
 =?us-ascii?Q?7ogXbKO/WlJB+B+xv18kp5Of43wuY4X3/dfXpTe2hbwEW/ln7F31EZvfWhWE?=
 =?us-ascii?Q?PddAV374AFbCpzVE20tXZBlmB9bt8Q06SuLDl6w2jV2ofNDDaxTmE0Aaby+l?=
 =?us-ascii?Q?ez6OHOtzgRjtjCKfRLpSEIkvVGuePc66WU087iKXAvxi+MQ0XaIWb8FvGkSg?=
 =?us-ascii?Q?muP7Y0N5rRZWqmhbj6uxtnJZxpUIvlBkT/ozZB0lbXSXjjvuN6Sc1uLJRux1?=
 =?us-ascii?Q?dO+k9n/kY4UEL+dIYG5QWQHWSUgXiW55dmtzm1uHI8d1IhGQJNVY5K14n14b?=
 =?us-ascii?Q?HWjGq69ExS1FEx4o+xYEIdwQuIlkgzheIE/RV9l3qxAclEY1ZTYsdB2snZDu?=
 =?us-ascii?Q?y9g8P+fkJRBYESXO/5F4BVzlD3zUvnmR4/T7PMl1v6Pjvr0dWrEyr/ZiHivV?=
 =?us-ascii?Q?vsEIje1Gm8Yir3c7v30rCSJArVtREUxysyuhSwWMRCorcarlsV9Rd4qwwvt0?=
 =?us-ascii?Q?8bLHnrrtivKVgI1A+GUWg0vujAoppbKS6scarjiJWKNxbLXmzwKMSlMv4dSO?=
 =?us-ascii?Q?/04490FGDyDa8xB0swuxVMPEyiuGbIgDdli4b209Fh0Rk23mRjRAuY9J691b?=
 =?us-ascii?Q?WLm6TQg0hlhKHwjwe4a2V2nsjHUYMiq0FPAY3OzdR+hOlzcIXnn78q59NK0m?=
 =?us-ascii?Q?nXgesX8JcflEhayOnoDi+QzuL5Wncd3IrEd2voFmbqPcabU4UVfPVOlMcHWX?=
 =?us-ascii?Q?bnhJv/h4fxqJfEk3+PJfMCBVNv22pK/IzLy9bzJfJmp91ZiCqz4Hdc3/BmYv?=
 =?us-ascii?Q?zpXZ82BFe+VMJz9pc4E1VEOeXvwSQS5g1uI+CfDqkj8K7ASKABPUoDJoe1vX?=
 =?us-ascii?Q?3BzXPcy40vA835Ufe2WQBSi5laXeEGxGoIdKcaRqlFkpysW0reO2msFPOU0m?=
 =?us-ascii?Q?zUgy2GDozJjc3GYtcyZZyTqZKM7zPO9OyEw4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Rv91mNZTIG3mqxyjQNKC8/qcMAzHHRJhyoOaJgomLd0Edq81KpTwj77a8fsg?=
 =?us-ascii?Q?P3Pb1xa4Me9Kj8vwVV7yp4gzVBc+h1zdNJK4pWGSyITwQYdJ+EZiigANyPS4?=
 =?us-ascii?Q?3LhpIaBWCETqvRHmloI+KXiLp97R+gw+44pVMS8Du299tfLiFMwflPH7qXL+?=
 =?us-ascii?Q?fnQoNLOLevsXL7dowSsnmydTJn8af5oQiNhNwotZuhjXqfmxNtO7+2avCkov?=
 =?us-ascii?Q?lAGqSpKq7aikEX+2cQhUoLdUb6gsN97DqbKeQGnzut3ZPphPtckgKAikOWvd?=
 =?us-ascii?Q?WUGsYkKSgN1sM5TFksrmBLR+2yEhmEzqA3v8oA830Red77SETRsSy694J3ef?=
 =?us-ascii?Q?Y3yb64oOZ1lNZVbT4qVPMUlSoK/ifW7nhVyZ3zOJ2f2x/ADEzXr+zCOO7V3w?=
 =?us-ascii?Q?Yy/DMrAUEr0xYLCDIBmIGxh5BeGF+aUCBK3QrdiHWpIvtvx5jA6ZiccoFpqA?=
 =?us-ascii?Q?/BO97pY2ZrOyqrpqMGydhNTGk0BGl8MrUM+dAUOtX8uobyNLzuJmU+JBqQVK?=
 =?us-ascii?Q?BtkdcZcUed6pEuW7SKIMpLcxsq9i7TTIlkjls0k3MMD1OvQ3oE55OPZc9h86?=
 =?us-ascii?Q?3lokwrv27AgGs5PRxxT8QO1KSJ+TQ+ZqNV9479myrcZOtcKkC3PtcLs/SHLi?=
 =?us-ascii?Q?ycr2abCSZAntjLhRJGral3vVn9MxdQ66qu9h8dVn/Nig/LVWW0AF32BGWLpC?=
 =?us-ascii?Q?FgMK0cjqrIB3JDnP9zB9WyYT8pf6tk1vefH3lCvC4jaxVKAJZi3BzOC50crB?=
 =?us-ascii?Q?dbBug1V/CvHj8IbDT7956Ax18wzN2g6GzEV3AVbpmF0Ghoz12Ashd6vtvw83?=
 =?us-ascii?Q?M/sP8Blo8yRUFjx3pUpZPG8UsjQoLTaP3sfDh5ng5XkRVjbnyzVKQzmnkx/E?=
 =?us-ascii?Q?D2v7F3bsEas4j8BwdFzUZrqgJw35jW0qSLnkMYr5dPdjKpvy36Cp0ohZ5JD1?=
 =?us-ascii?Q?1haG/KEYOCISq5aL1pqtuK/2FuptH4Z1vfDr1jqTYp1GifyIK3gPrcFLDw6r?=
 =?us-ascii?Q?XTYP4x6Z0qxTXZ/tpnwwbwvAnmXnXIH+k8nugnCIiBFL5ygGPHIxmEjhTP1i?=
 =?us-ascii?Q?xCz+wT+udMRWhuo7SNXA6gWdz4l2zbs7nHROQCF30KVKqH5Or3THYHIXtqSj?=
 =?us-ascii?Q?onfbVHWsIWIrRVUPMPrYZdwRY/2/yn8/9iuS3AkHzpCeakRD7/2C7/m6AKUG?=
 =?us-ascii?Q?AiIC+QkqxqfPn0L/TfLz4Gp6XD+3dkgjAjE31gsi7snyQmNbyZpa6G8aGeLV?=
 =?us-ascii?Q?w/7ahcJF5ZG/JIUc+Y2LbZYczT6kLVdGVUfddbvi39kJuQuBE5lb+HMSQGVJ?=
 =?us-ascii?Q?jcxT+4+R33hmF0hd3+XUDbJHB0jyS+jHCGffvMmSqJ7dDmBj6nPvRN9L2zo6?=
 =?us-ascii?Q?dymm+jBeUibPX5ezx6cN8QKSSgpki5ZB4VlJEvbz6tKipHP7uhNF9KgI3gB5?=
 =?us-ascii?Q?EiEsm+UP8K8x7Xofn0eIjygI1SomQEU5auxuRdhMgYyQer+ByJ39b5/0F2io?=
 =?us-ascii?Q?NrSPZDPOMQmr17gof1zm3JY+A4+ZeIy/sluaVTPgXodJrbsBbSqNHGgTW9vr?=
 =?us-ascii?Q?PeLla79FODLt5W1wroeCGk7YMHvJzQZS79a6MA/Mf7j6rYxcui7lemhh+lXa?=
 =?us-ascii?Q?5Am2RqaB4LKAUP+n/iG5mOA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1F32E92F048EB6419DB7F1E1C125CDE8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+IwVMpkwutH/Muc3qxt3CvuTdJUUHOS9LhLz2/rE8Yd4sY5a0tij+RlvmpnwXtk3NHwiA+z8uGlUOx8uqx782FTpG/Ru8g5J7eh3X/t+rUx+kozGKkdi716sS6qXfqsegZxW9XtQSQR7EpD77tvUmZbXVeTlKTAuSbuxq+HSUcZmeho5xg6bKYXFuTQJtPVFw6pp3zQrgXmZXDKgQkMZwsWbFPI7Ka69zIvCFWvOQz3d4FLjy01YxWUJ7RokS6L5WSKt6Dmc2phancSXXCKINpJiK7vWW11QMZAQAFuvQjB/BDQA/svJK8l2HY11MDNEOwUgUdOjSw/gA0Zpav5m7xpz2N0xOQ3ZXKtdn9I9ZfWFFRI1M6kCsp2Cjg1X9k56gQGRl2DhGlDwNAXKSqDb6mtcy4JANPNNh+l491gGZXZes5dW7Pmto9+iUyjbdAtnN4FkL75QkUgO16/GGsTo4+Ovx1HBD91LyoyufzT5f1BWwPhgj7V0PBkFIVtANm/VNQ+PH9XUDgSxpqi7qdFDBEL60rdRoYrSdaCWhuJ8h3D2L35YoN06eh1wzQRKBzyOhJJF53/NmJT9vmgyQo6nw7t83ynALsVA3KYOYGLs8YkC6k7Aycyo19pC58r+7VEy
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4dc8cf-da7c-4c3d-dfdc-08de235b6481
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 08:54:16.7895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sj+7fRtHKtTCvaXBeKRYIGf46QOMeCNhqSmHWOLwC+NncBA/PhA4vIINAV0lPEEJbfLB4Li9wJDYMNjzo21pFa1z97ql7oMsAhIR+Oe5Yp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8575

On Nov 11, 2025 / 16:15, Chaitanya Kulkarni wrote:
> On 11/11/25 02:32, Shinichiro Kawasaki wrote:
> > Other than the comments above, the two patches look good to me. If you =
are okay
> > with them, I can fold-in the suggested changes when I apply them (assum=
ing
> > there is no other comment on the list). Please let me know your prefere=
nce.
>=20
>=20
> Thanks a lot for taking a look at this. I'm absolutely fine to fold-in=20
> suggestions. -ck

FYI, I applied the patches with the changes. Thanks!=
