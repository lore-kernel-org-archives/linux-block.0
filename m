Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D2125D540
	for <linux-block@vger.kernel.org>; Tue,  1 Jul 2025 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751355626; cv=fail; b=Mt4fjirJP0QP1BKbI5uB+rgwxdEctcVGhUn15bvpZOqT+VSZqmvAntKzLVvfSEh1R6IH5NYVvNJuDw0URdJbE6eSZizzMryLpjrjy5+OO+yKK5F9Jm7CHiodykuasyGeKkKPAhPkFtzmP4xD6ncrbFVBC3wUCuWxN5Ybu3O3LF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751355626; c=relaxed/simple;
	bh=EJkQgEX3b2/HXCrpHjYR7PZgHAJmMdc8v9q9axY1C0g=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aGrNsDmEp4jrEreKF7Gq+ROdiaw4I3+AAooKVRYmqknTalsDc4TV/YkY+vN8mjq5fdOo9vnMggO2btgcAKEPwu6PrU3BN8rZI+1d1DzBqYi7ECxRnUG0TjAh2ynr9vnhjhyrwj/VGSvk6YbavnSXKIh1a2uVzlTbGa65zswTyOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bt9L8Lyw; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=nFu6s3tt; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bt9L8Lyw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nFu6s3tt"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751355624; x=1782891624;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=EJkQgEX3b2/HXCrpHjYR7PZgHAJmMdc8v9q9axY1C0g=;
  b=bt9L8LywQZEDr+0k2r8SAA0Ph93KgnFC//+h4zQ66rmGwEdvdYJALcxk
   3rNct8TDg/FXh0V2rK3Iy2dPfw0duHxqwdk1t+JKeqe128xMMvhO8CoMg
   ySHZeLGbCHGFsj41iPXrmBZVmfSwqlkFyOiTrOzxXIFEAoujOw38C24Gi
   xNnC3LGBD/uVkG7fmd0iPkcas+hrPJHKz/kZ7kHWS5FLFvZw2QlEx+D2s
   i40N7hOZv4flFkdvZA92sah1lGnVtc6qDRfnPrqCYkXMURirMuug1JT2F
   86MHHCS/sUkMs1pkMORve1GAdYw+0Gne/I4+1lq+eGta3bv4Ue4VOwI39
   A==;
X-CSE-ConnectionGUID: 1iwNpe8ERD26y68Y4XRg8A==
X-CSE-MsgGUID: zijQ572fSAe8nlY6hHcPUg==
X-IronPort-AV: E=Sophos;i="6.16,279,1744041600"; 
   d="scan'208";a="85553351"
Received: from mail-mw2nam10on2061.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([40.107.94.61])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2025 15:40:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pk4qXMJXcLKkaD9onpwOVfbzmg99o8ySGYxhHhwnk2iyNPtv9/0RsGFSbq7Fr74+dvOMkxHCaVcAEOg1BJfuzzaWhne70ZjYw4LgotdA4JMt/b6xqY4dAoCQkV7//qN2CD3oQElbFJAoi8b/10gDUuQB2+FzW498mnQQdK0A+KWEyQ5opTobuuc6mB/+OZO2/UxiQEQ9Fo8RIswrt0nO0rIBKgG3SUU25OHEK/BtuqcBmkABlR0IsPiJ9AEMWfwsoq40xnkfgn/sgfJI4L+XfeBeDnGIwTkg33S8dTTg7FDz/uiNZNdcJNEAFyVHAyD769IysunVXdlJjwxUAaoQ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJkQgEX3b2/HXCrpHjYR7PZgHAJmMdc8v9q9axY1C0g=;
 b=NaiLNilJawW5l4G1xjBkLxmipBBpqLNmQBOoiTgSOSzmDuXEIq7nzzhk+YQmW6onYJ27Fmd2aBhY/Q1FQLm4a/IVTShDDQ42v/Pyg2u0mxzXnrUXLu5VbJLT+uxqOzR+eiMyh+Zxvo4qhfr9BEpnbqdG+mls6ZVG8ehcQ7zCOiPi2jQJM+3r66lSCT2qHtZjrfD8j1V6/+DT0ZNtJEnKdedz44DNfoxjuo63x4Lg9DgOgLLpkGB5KxSiXIc5RbKniWhczaLgHMcZAe3WriEEdlrYklRcw/vavqZ0fxYzVcBACdL/gqhjVgAYyVzYAflYUKF1pfpjm/NxM+87WuTaMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJkQgEX3b2/HXCrpHjYR7PZgHAJmMdc8v9q9axY1C0g=;
 b=nFu6s3ttv1hROwDjBAxpPYNZEy4nN3O1zwFY72MZMRBt26KVTPKfRrUOtrYeBlxxjrlgWICuMoyQMbi0dv9oStD3JFA+jsiGLyzsOojZHyuLT0CIOADtvw6LFH/Vw7bBbNIPHC4GxMH2/xqA0FLkrkMPjweGQSyOd+Y+iKJJRW0=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SA3PR04MB8748.namprd04.prod.outlook.com (2603:10b6:806:2f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Tue, 1 Jul
 2025 07:40:17 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8880.021; Tue, 1 Jul 2025
 07:40:17 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 0/2] nvme: avoid failures of TEST_DEV with
 metadata
Thread-Topic: [PATCH blktests 0/2] nvme: avoid failures of TEST_DEV with
 metadata
Thread-Index: AQHb5cac4NAnmqFLcESIh1Wubf+4GLQc6zgA
Date: Tue, 1 Jul 2025 07:40:16 +0000
Message-ID: <352ep4nwdg4bhkidlh3vvvgata7vclo5sptowk5r6nr5onhjls@qmyonut7ukro>
References: <20250625114505.532610-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250625114505.532610-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SA3PR04MB8748:EE_
x-ms-office365-filtering-correlation-id: ff7eac9f-90d2-4a53-328b-08ddb87285fc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Lb8G2HrBaLvN7adK9EcZ1JRNM+EzfjQpxmQm25nmcE2L3VNdV16Cop08Tb4o?=
 =?us-ascii?Q?ZjV/g3/vLRtBQXuhHMSW9SnwfDB8xJa/UbSnONtUqs9nB3W0Ozosn3i0R8zd?=
 =?us-ascii?Q?byh7uw3SrYdeUow6ZzRbFdiIrp1vruULeg2WhXLVX8dlOWHi+x2kHpOjrDvw?=
 =?us-ascii?Q?QEZQJtwSLeXn49Bk71MGZPAvZm51nb/3OljQ4Y7jv6kCascfSD8A1irSStPK?=
 =?us-ascii?Q?whr+OPg1AwTzCSXZYrL+IxXn2V0gZDgidCiDPa0yLRit5ODHpmLGxOPYCiLD?=
 =?us-ascii?Q?H2sqK7xtwL0lZtTT/yRuSIWYLB8xY5Fa8zXmcWRuCVRytW+B4mVdkFcpaZb/?=
 =?us-ascii?Q?p0+M7HbzKvycSQ1lesD8pJ5RehOcFVCiPYcdSsQ9dbsPJB25HaO8Y8SaOzzQ?=
 =?us-ascii?Q?3pKK+GmR8mfXJKc7Rj864Js6Hs6S4JTVHDMnS12e8W572SBERo2FygDc9LY2?=
 =?us-ascii?Q?gL3/khgWA9Qyr4d9KRFpdA1fIjkb8HNFuumByrXfc5JRPdyKexEc4DH8vma7?=
 =?us-ascii?Q?KrVE2o3eHhy2V9sn1//lde8cdI5NEhbt6yK0Pt2DYM+oL50/+pc93jpWPH3i?=
 =?us-ascii?Q?ruh4vTvADETtgyjL6C8mKHdYGl/NvmnWSXe7MJ/oxUGLlg3mwCVKscYghtdE?=
 =?us-ascii?Q?7IQKg8q2XliFzr0Fs0DrK8dvmT/qG5F6cuufm1fpJVr1Sg+T2QLZJElNs5NX?=
 =?us-ascii?Q?3puW2e9Xmu29JNw4FnyhrhS8r15bYnqE4qu/24kRi0N8FH2G62LfzJ8uUG/t?=
 =?us-ascii?Q?ofhWG+OUgQbNpmnI5JP52rITwdUhnsNGCUYY3tuY1MPnid7DzMRsgCWqFrNc?=
 =?us-ascii?Q?bPAqb2XjK0G4eAQqExBNwnL2OVTS8IiZ/qprcbxzgyjDc2fa/hwrj+sGP2bd?=
 =?us-ascii?Q?n4C9K8wjWBrnmYmk8RkuRxdruHP4XWVBhhnuJiz53Fn1W1sJ4YPJkG0G13VU?=
 =?us-ascii?Q?ZSAsk+fsgz/E8XAfeaNdqJxkF0cntNFof0OQNeEh1ntXlGgYTgBl6kXN3Lsv?=
 =?us-ascii?Q?BztdcpDqPIapAN7xg59vr4o98NoVtfIDsR1Yzz/alqZ6yMYGNUPX7XBGgZFD?=
 =?us-ascii?Q?8DfRpG3zVREFNFU/dZgMOBiwQcq4POrvHvPO3HiXwOoxcQIP5i1d+lUBxHaN?=
 =?us-ascii?Q?bel+yalwyRnjcevqzhyFuE1Kvh3T5d98FklSGiCJFbotA1ap45cbouLobhhn?=
 =?us-ascii?Q?cRLRqTRQaQU2kTt74mCgeCRBMpevjQ1TrQjUUGv26UHmViWNAo2B/mUKUrb2?=
 =?us-ascii?Q?it1NJn0sfU0VX5C2ehxs+aw6vjmqoipIsR5rMc1c/KzyrxOjPDXCZW77DINM?=
 =?us-ascii?Q?iXF2SrnG9oJpK3Xy/Tw8dlWY06OxAkzrLqdoeF+HxDs/o9gr/84HMJWsoOrW?=
 =?us-ascii?Q?f7twH1yOf3Xu4bCqAEeTvydLNdmdzsbdVHeYWn1QDhyvakdjX5VvRDXOhcdV?=
 =?us-ascii?Q?lf8MUJ21pKHxcj5TVGaNWcM6pyxX6QHyKEN2j22gW9xUUZhCHFzOO/qHq/O6?=
 =?us-ascii?Q?JzZrPomtTqTbdF4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?f8nZDHLgGcaorPqyxea78OB8L8hU++Yawl0X6OC876b9rJ7E45FAufZHbciM?=
 =?us-ascii?Q?o3cwAApWSFhzJw8Fh03pmL6shGwvjKqNtS2SCpUW7vAYXjtsNKaPc7X2XAnw?=
 =?us-ascii?Q?m2FHCmCuTpaUWqyN3KOjMuR7Oo9n5potka5vqa5nALXMk2rBHXWohLmZkpha?=
 =?us-ascii?Q?niTVq2ALVJouB+03GzY2/ggslULc9SX44B8NuV4aCblB1EJ2uTCx6UcdT/1W?=
 =?us-ascii?Q?ZEbmR1EEjME7RqeJlQBgEq3tJntjA7KAgC4RkerMn+AShnQawqZUvVtQeo3d?=
 =?us-ascii?Q?7vxXW/HKlHVeAVV33f+dVdrmcuQWRcMlWvmhldHgtCE6KuU6WrVO1CgyL23x?=
 =?us-ascii?Q?5MoKTG29WqquFB4VVwGobiENDssnZlhWxAWEJsxRCLKznV4W1Pkcw3TOBNzp?=
 =?us-ascii?Q?ecUqutRV9/qsBE7WiZMLH9k+lS+02YBMZ+5VKqQsLevwsM7/iO40VKuuv0Ok?=
 =?us-ascii?Q?VQVDeCdxltZApnhrdxbIdyMwMKiBNh3EIvoR+/yudnW6hiVDuc+tspGbjpcr?=
 =?us-ascii?Q?5O1gTvKTeouq4bRCncruEkyZ/Kh5mwzmJxQinKiQOzLmNyOANYJ8oS/LQ/dQ?=
 =?us-ascii?Q?Ns+h60VXnguqTDyLPMpZ08J96SQmU0EO3WXUV6vv5rieyM/WkPjoWlVr4z5V?=
 =?us-ascii?Q?GtLv6j+PFvrrBU2vQO68PEjUEZDLX1WOWkEge5dtznTteqNAWFSvlcvTGRq3?=
 =?us-ascii?Q?TAHsKcoHVnvmQcBfQWUIRt+i+zjW5yUm8qWDsDeE40jKzpLOH903fdJvb2MV?=
 =?us-ascii?Q?x2jGJN8Cjl9gZ0TslLaxS7MpELl2b3kspIcR7GxxLApLw/ss9Ttll1hmm6hq?=
 =?us-ascii?Q?IKk+7JCum68iUqXG1naH1naY90AE3txSuQ+gtiJP2mxJde/rZgrlegVP6S7x?=
 =?us-ascii?Q?lLwIBmwhJe+cZXNlkk8EQ7JbUvqM3hsK2QoaQy4Pei0cpI9qVz5APgMQEafq?=
 =?us-ascii?Q?Ant+1pWbUo08MfUKDDOADlP1jKqfMyIFgyPCGoOnSltyC0PuS+EA/RahWXMI?=
 =?us-ascii?Q?Xw+CLPZNGhgZm4TSPTxNnXTi0lyFXZm6MiPeDWON72FVwC7/ePBk+eLH+C2q?=
 =?us-ascii?Q?Vn7soLPwLMO78jDXJNh61cHhJXsmQ0c4s2Q/LBZbtfuwNw53HYzxGbNp34Sm?=
 =?us-ascii?Q?VeiFEOAkybOQBF+XNCGyntRkzjmnrRRSFySyxRwNm2YjbjS7lYzXeRUZfDJY?=
 =?us-ascii?Q?z73djZelli1nlRrcIcIBbtiKhTnZmDRtSJfKiaVDcFExoPBEWQoX+W57Ulno?=
 =?us-ascii?Q?3bs3W0tgfpNKtM7eyqSuC4i+It6HMJY4OXos84aQIkNekyOAk1PXK6g6kJTg?=
 =?us-ascii?Q?w5iWN0vEIXMSwOAVVv+7MhHSYF5M7SO58vVi3jkJzBMTn0C6MBkeEkUq/tVg?=
 =?us-ascii?Q?RdqiVaBzXOu9QUU5VMla4WRnHVEjYwB5qejfh5mitWDg4UnKhEpVskymllGI?=
 =?us-ascii?Q?qqeGsmi/6fIz67aStdWkmp7lpy+nhL5XUzApg4GD5xDnQGKbg0iM6dTbnmhE?=
 =?us-ascii?Q?ENmLB3rnlEiQLBowFknkbCw7W78bdyno9nVHfn4/eU0Yl3du5Dmm22PmX6rW?=
 =?us-ascii?Q?agUAsE3rTeXoZF4FOLsZFDZ6hdjy1Xn6IglRu4IpoUaZH7fPO8FWhgAgqCqH?=
 =?us-ascii?Q?Gg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8668FECF0026D24499FAB032373BFF44@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eJeeW3lCPYUeWcUrEMJpFqvnCORj3Un848EHeFfbbJIxV+8Xfg9WS09f8R2JwDM5pJ8O18uKAywb8QjP76brb/wGcEW7ucF2mxTM6hggU37fdFde8mx1ppmbH0NJFJ4o5Vpa9zgitL5rRnMSON4ePPmE578vObhJcKAaXl2ZLbM903DrfVGckLHjgvojct0ozWi8IFPC96Q8D2eyrC1A3LD/5diMT/ziP8QCa7DDlnj3yOycE70wKs6dXBB2t+dGwOXMy9frRgBhfhOkxMEXox9deQpVFbnA5bwWIKC0ll2OEmPz5XOb3hkj88DGR2ZXGk6GfOq3G880MG2tZxpKbH25sG89Sku+Kxo34MVATcWFER5uWqPxVnfxAKPObF+kUababw3FqEGIufEsAAXMU0uODLIn9y9HBau89NShCT0u0P5vkPEJLaqlV+R5ZKVxQfabnSbOmGra7VoQzMTEoJh4eQr4JxfXQ1XIqSjAZGrC6xGFNImuceEMma9DQXys/I8lIEoyN8UKETQQ8J+3UJ3HZf9qaEogSPsjSSfhQ0CnJo4wEWbzkxeTcLYfpdyQX7978jrKtoe8jbH+lDeRutz8N3v7TJM+wqlYJL3cr1Ymk1n5gxwaK0zwl3MTXwni
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7eac9f-90d2-4a53-328b-08ddb87285fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2025 07:40:16.9602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZDlaHLigWInKjV6IOnI4JwWno3Q3HzpA/r6Z9CpOzYShYGpvMAVY/Z+nJ0eMJR+NTHPojiHIh6xJemRmogNMz4k7I5bxWr5DOIcCBEJhgU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8748

On Jun 25, 2025 / 20:45, Shin'ichiro Kawasaki wrote:
> Recently, the new test case nvme/064 was introduced to cover namespaces
> formatted with metadata [1]. To run the test case, it is required to
> specify namespaces with metadata as TEST_DEV. When this TEST_DEV is used
> for other test cases, a few other test cases fail. This series addresses
> the failures. The first patch allows skipping nvme/034 and nvme/035 when
> TEST_DEV has metadata. The second patch adds an option to the fio
> command in nvme/049 that is required for TEST_DEV with metadata.
>=20
> [1] https://lore.kernel.org/linux-nvme/20250616020716.2789576-1-shinichir=
o.kawasaki@wdc.com/

FYI, I have applied the patches with a minor fix in the first patch to chec=
k
the existence of the metadata_size sysfs attribute.=
