Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC76D1E522
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 12:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744633090; cv=fail; b=GVN1782CGfM58XyXI+AjumB34IzPTxo003aToKXPFXWAcwgKBgcPx8xw/U/bL4ZTyDEyCqy1UoEidjO4wDjj3rQI7T0lw3yW1zsLDNmAWS2W5krF2Aq0EYTNxmWSGJ9jt8HdDIumUAHSLLgPs0Lg96EQAgbWj+RnhMxQWrILZFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744633090; c=relaxed/simple;
	bh=wDo8q1W8POgeAmNcdC1EiFnxGDiAEyNSl3ZGc5SQqP0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ci+19QipHWT9HnBWBHDmrZVjZJ3ouqezdPzBdOK7WNTeie1r8sgUM6A8Jm5pWA9I1eYv7rHlHak76dbA57sTtf2fF3LpICYHg2bZkPXhRpK23Mb8+0yqPurZ0gZNhUdlQykUF88g96w718TS5SZyLXypY01yRkJ0XEVNwjVRNDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=T7nUBOKG; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=m2kfjw7y; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="T7nUBOKG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="m2kfjw7y"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744633088; x=1776169088;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wDo8q1W8POgeAmNcdC1EiFnxGDiAEyNSl3ZGc5SQqP0=;
  b=T7nUBOKGWk+SYPFE8zfc5J7Bs05weWmF9cvBneRzUhC5noa+UQskvtHm
   eUWVJ/OyBP9Cl+g/fbSLIyH9wUxjg3qaapVmCFKnaGa9/0BqFSg+cK8O/
   DvqRt0nzItz8kwtdCNesU1DSTPQewC/KdqshUZ2+NuaA9LiEdCEdY4FJ1
   +/Ice+972Ug7PoSV0kaD1F63c0Gd2Hj5BJyAWXhnLqhqDHf2F9H725RN6
   fqkx+5SumzmoJK+blayifKAKjGpujqfJh0ZmIRy08PH5f7vnAWK+jwBFL
   V9fMXJYg/3hs4V/7xGonjoxJAJxYWJ1ABBcZ4jbmLFKoRU9/yq1kOf2cU
   Q==;
X-CSE-ConnectionGUID: PuE+bxsOSGWrWrCMXBzQdQ==
X-CSE-MsgGUID: xlslohOEQhOiScdPPCsfDA==
X-IronPort-AV: E=Sophos;i="6.15,212,1739808000"; 
   d="scan'208";a="82105250"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2025 20:18:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHFKLY/B/i2vPX0hd+PCGTaimCaIISrHtsFZQC/56K0YRUnRq+/dcMzR4cu3jxK/y47uEPDbCOIJA8si3SLXJ9xmQCQI5gizLV2OThWnr9H3jieWl1SRyUrfGe5nLCEU4+l6Qwc6Dxw5szRDmU7b+yukKfWVEu9ESIXPyoGKQz1PyvpSYdgfhxdAvbRDvtNbyEjfoemmMWROF9OiRYBro+nT2YAGWzp6LeuBijBGGjBbT7yWbeS/9qLFZ77Zr2ZjhKmdJj0m9WeYPfmbe/VevknO5Rvg9cKtDyJzDNxCtVtoYoL62jatydhjlQYEMBFJoa+oGDnNoMp8AiR89etdnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yk6uGe8ib3/0PZm46ls76/tG8ekx/A6+7Yp73QzoDbs=;
 b=ca6lUagDlbw9lahE5oVSYm/vex3M0eZM+19vnSEFgEaj6yI5cU8fD3d3u1aurkVChhlLsYdVHhzDFiv5rIAl+GxkI+VwR7oaDZ+0nqCFNOn8lS5QxAB5Wkrfk8dUCCG6egeX968d7kCX8kIynSa2D5mA/pTgXiIuSXJSpZyDjYpZYVsYgKgJdvSvbLMSsdTdqfHZSt1DEtY8TcG+1pbKY7UFQgbWnc965RNXEoprWXLpS4h6JKNUQyVNQiGUVKtugItQkG59T/OuUI1is/oRklzsAKf6yEkH6didPqbmm4vZMz9UMgyCM8Va+4VR6jGs2Cykg02S72wR1SdXlSsuuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yk6uGe8ib3/0PZm46ls76/tG8ekx/A6+7Yp73QzoDbs=;
 b=m2kfjw7yz0Lyb+1IzRaE21LmdzU0RWcIY+gTaXCzDEOVwCwzdCLCHuOJbXmrhxJ3JjtLh0JT0AFui6NotfzrNbK8j5PkpEpSQyaSC3yCHiu/YnZ2bR26gqgJvXG681W+6TBUa6CKksXZfLr3fYCUCzv69WjVE1tLMzid50H86vc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH2PR04MB6872.namprd04.prod.outlook.com (2603:10b6:610:93::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.28; Mon, 14 Apr 2025 12:18:05 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 12:18:05 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <wagi@kernel.org>
CC: Chaitanya Kulkarni <kch@nvidia.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v2 4/4] nvme/061: add test teardown and setup
 fabrics target during I/O
Thread-Topic: [PATCH blktests v2 4/4] nvme/061: add test teardown and setup
 fabrics target during I/O
Thread-Index: AQHbqKL20QFND67ly06BTRZqVqQRirOjHUUA
Date: Mon, 14 Apr 2025 12:18:05 +0000
Message-ID: <x3nhda5qyj4o5qf5uiohzuulyimlef4x7ov3itx77ghni5s3fz@4hpttpchyj2v>
References: <20250408-test-target-v2-0-e9e2512586f8@kernel.org>
 <20250408-test-target-v2-4-e9e2512586f8@kernel.org>
In-Reply-To: <20250408-test-target-v2-4-e9e2512586f8@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH2PR04MB6872:EE_
x-ms-office365-filtering-correlation-id: 57167b4b-6dc7-45a9-e59e-08dd7b4e691b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nxJFpti03rV0pWEh2DBldgza6ieXtASaaXwIkuISI+nHlDu6xqbgSAxMPQWT?=
 =?us-ascii?Q?8kaWrwAMJhWlwS+Htn6q3ZzvjvClOkfBRbTZ5b5jd7cQPniU29UcCUNs/EZz?=
 =?us-ascii?Q?aUS74vqYgM2D7dp1xtZWRMK/i/D2QN2Pa1ppdxgWz+BuCy4Ndv3DUwO52kTf?=
 =?us-ascii?Q?SbXgxJX5b/OHOU2pIsALeD+4g+IG/zdkLM8hq4imK0LOAyezlv8njZGnQCiE?=
 =?us-ascii?Q?y8hIs6CPZ11aYB5rpGKp3XnXR8+zR0vVh5x0Jri5NmKuTTiHxXEPCoyxmmi0?=
 =?us-ascii?Q?rTJ628XSEWqHr6YOcJFP891+Yzb7QOFa6hxNHpolrzgFpOV39fyiIsE5n4ez?=
 =?us-ascii?Q?KMTLM/hPLkqNHjJwjIoFSezGyVdqTgT454Ps0Kfk0CavlJjRUQhZ+zo9XjBl?=
 =?us-ascii?Q?W8Jxp3Mn8BVv5b/rc47TsyWKSxwgGa1UWyYgoMTyNe0Gapm85B8r0Jgs5Duq?=
 =?us-ascii?Q?A7FGNqEojhfM6yvl+ssFOBR+g80/o/64/W1RiPYMKp8St8u1P4n5muGoZWNm?=
 =?us-ascii?Q?ICo1PgcN6/A7wC/nVYeEakQmQ7cWEUekwTNx4P8O/GBPqgLP4nMMNYOOuHhe?=
 =?us-ascii?Q?vC6+COXwkWe9/9+Vq5WpRJYEuiY2W7Ls8LrCH7nCG7S1jRCv3thqPsaM2HqG?=
 =?us-ascii?Q?hIqgeiMoEOf2hio7bJH8teHRD8ZwPnZkrZ0hVia1s5mHZ8BDDKIjOzi6GomI?=
 =?us-ascii?Q?DFV9jbX7XoxdgOz2jfts4G7HhZPfbhou2j5WZ7DhHKiy/mIab74iQ3vd9m7I?=
 =?us-ascii?Q?TPLiJorBG0rwF4JQi0hg7jtIf2GtWt4+3ScoVZS6q+PtdBaCEz0bzoeezYxt?=
 =?us-ascii?Q?yXKst3yULVvgbn1EljfSHS0QDpWb59V4KvG9ylEvu9s2VYd6DBtHw73cJXuF?=
 =?us-ascii?Q?bd+W6b+IGjyVflAc8FlSAoU8KHbdbhNzABqOiZTEl81AkKdliGZtXIF3YH0u?=
 =?us-ascii?Q?Oo+c9RkxfRcoRSHCwn0Oa40JqnXRUg0vRNmZB2yS+uVMDYFUplgzpsdeSSxr?=
 =?us-ascii?Q?e+9ExipeAvJVCkt9aFNVk7Es4e7doNntrJ3xx9ypXE0iFaY8f5NXmAPqsQzF?=
 =?us-ascii?Q?5DPQXXdAZChbhnHnxIwglLEWsdQgSuuvvwSgh6J+NhXiXbwWBu0DiWbBzyHy?=
 =?us-ascii?Q?StV3g9U/y0lT3bsmMQhoyVoFVhqtN9EqTsY1Vl/ieyZQxlZXaJcvKWeL9qZ6?=
 =?us-ascii?Q?ICVrGSEfYzYK1VXj8iFeiArMej4amrsu4ngDTnGKcKh3w2nQvu9tuagcLocg?=
 =?us-ascii?Q?ZdzX0+tbFt2Sh5sM7VC/F2RCmRazwZOoqxia85HFz1B675ckFaFkvjuu3tKj?=
 =?us-ascii?Q?gmztD21WWrB6tw3tBaEwmr5xl2nx9YFMY7WO7748sNMbwew0XpmGGo9zg0H5?=
 =?us-ascii?Q?SMdNZ321MwAUVn8kMRyW1mRaAyu6+Z24b6WkbUTX2+ehz0XllgqG8XQ+xWto?=
 =?us-ascii?Q?4aDoyx6rYv8B7kKrA4lBsApmafoe4rqHQ1tVBcagiPcmum/jCzNTrQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NRXNG92UFp49UN5WWwzTU/Hswb8RA9W6kyhvQDYPkDa4i/qqx6ZYCUGllsQs?=
 =?us-ascii?Q?knasYNzHM6RayOXmrWoxBhNxIFM78BsDyHlNXsEI4iF7F7vO9wEYij/jVaqs?=
 =?us-ascii?Q?Hd7lW44BLjWNPJsFBXspiFaAc07pW8f3dnzd3SUCUw+vSnfP9SIbZ3+sHfMe?=
 =?us-ascii?Q?A/rduC5uZ5WkVZfqiRBwARB+aNPxPgGx0tD7QrmQjP/WZdwQbLYgpvD2miba?=
 =?us-ascii?Q?DSLOAiXmXB3wlgziYEDS1x+OmvV1ye2WSEFAxfMJRAiBwi2x6NPULMyzYgTs?=
 =?us-ascii?Q?LMGR9PC82FmsddIVpnGHEFRdYfbQdIYzqUyj10RXWRnK7IhINg/6TdoPLhHz?=
 =?us-ascii?Q?ppqJQemCKDENcOTnAaHyjpMgtZUAMSxYTAQgjBeCPlHUGian0JYPxLC0KsGg?=
 =?us-ascii?Q?U384gWHriU5KDU+7HcDW4xObOgO3Zi3BIsxKLkHSWMDgYKASe4mwTOc4kSv0?=
 =?us-ascii?Q?uOGNcW9EnpfqKlnMXKYh8QEx8gb0zB5QdIsmcRzErYub50Oil4fPbNXzTxm6?=
 =?us-ascii?Q?3iuIJ9ud6yhh9m0ZkLCSoStSXqcmMp3x1WrtAC8hAaQ0gCFendThUoonXgas?=
 =?us-ascii?Q?7jvHG53r+AeRZh0cc/k3NBYkk/g699nenNCiA5/GJIXAQtvRAB1ztzYJ8EcN?=
 =?us-ascii?Q?ftZcHzzpngw8SzWvubNL2TWz3W1b8UaRDbjra3SbjsgmDXEFRMZEvS2dfABS?=
 =?us-ascii?Q?AP+jpisoXUSESSaKrDr9sXUx0g9vIAHzMcqlpd8+dWyPSOXc0nSUsaD3WAVN?=
 =?us-ascii?Q?Ptcg7Jbbf6rFGFKIbFIKrOHbGl0widlbOHT1/ocyZ3i80WmmJkvclrsgUGJK?=
 =?us-ascii?Q?x72oaTgIFc3wKJkDS+Uwh4VhLt2Kx7JPuhlFbhVdkNyQXZMgts74qg3TYnEc?=
 =?us-ascii?Q?KwuM+c7eE7+yI8ukJ7CjWDxTAO0KG4ISEiTauEmtHdPZKzLfvHT3k20SRBh2?=
 =?us-ascii?Q?7mDoDoLQ0939X03hYyjqGRnLv0wmXMQwah4wO6b+lK+HBukzVK9wDo8pFbnY?=
 =?us-ascii?Q?aC8nP6dTTNcuy/+MHb9yLRe3N6u4Pn6RAU7KL3VFe2s0V8FWyCS4qFR9peCn?=
 =?us-ascii?Q?/Pc3sAQuFTzQXxv1shAFhjbo7OEFetjdGp85hCpz9b2mNn1nIGrDpAQ+Pec6?=
 =?us-ascii?Q?3eArI8zDgR4HDKuCuNu+dF85POnpScREUMIyavR9GinWbBuuk0j8CwSpeglt?=
 =?us-ascii?Q?t47rkfYZHL/KShnRberEtymNoYRaCsD9m/7JWD0lARxundg5rGdYKR+It07u?=
 =?us-ascii?Q?GHOXgPdzPBgLWBTousVkjGQn7tWFeYtrW3Rp2GAU8oxpb3VuEzSMpGTteYpA?=
 =?us-ascii?Q?1ZRdAkVBwo8RocAaETxMtUuIe0VuS4/kLt2TouihlYhx4VkxNBjCHWw1rlI2?=
 =?us-ascii?Q?8+gveJnMnw2Z7ughmDwJggxnsJz8IcVS7DHl8Le561tfKoJ627vbieAKAcNN?=
 =?us-ascii?Q?EJuaaCmXYwPxpIDMQmMmE+1R/fq3Z+cPfWQKYMh/zhCTvBm/v1keJgYGfZpN?=
 =?us-ascii?Q?7ZDiH6cInV3If52Yfv33sDq5h0zhq9CjxclpOSb/uVmGSJB8UhBgJUesssbu?=
 =?us-ascii?Q?86BGB5e/qFukc1pTBZVuNr+ukhPVlcRCTBL6oMmih7ThgXH32OaNZknFLEEc?=
 =?us-ascii?Q?AQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <02D8D9CE50C8F543A550F9183D2AA5C7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FL2YZxQzRuJYXjJmwjeEmvT9EaRlC4GRrGZ16BslfccFZaH4Z+LAnhVxYKc9oILy9lqmSBwYICFsGdsCqtphp2ijPM9pAYw1ER6ZKL8/Qo6n6ygk2rRFs60jgPXjEX6FZPrVeMVE6TuQV5sBzK9xsTjNv+IIcWmDBAS/OkZLdJO8mmwu9+fZsSLU/35PFFQIWhGNCjvlk6aVF2kvybJH/Fxa/xyn4LGYBy5PqnU5wacwGB2OLZ7eoZlBPwAgsBjIgZyf3FNQ86MH+KDnIQxfRP7WncI9oHYN0Hh3jrPGJ5gppazUcSu6RF1GswqEXSEPm1UbvjKfxSn2goBT0wn5IHr4B+1vMO0EVmR1lqz+jLwJGfAEjYrIca9WbnxjTflht8eucUN07dhyt79miQT7IvBCBT9uwArr2P00pFrRXkiEflEIcslfmXwJ0A306zrptkoj3d+RCJgThNi4A7clXmG6FH4bk6nKsbgaIgfk2hzyNp//QXPCndaTFCLgSqvt0swWTq+Qv3Br7Ilalb1wAu548m1PnrLaws7T88rXucmKLW8mxjSc+k7NMzseR0wPxE6o56vO01kfd9cXuGOwxd8r1Q3ZD2zE95Al0ewtvS1X5p2a6H7QDMWYDIqXUvWh
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57167b4b-6dc7-45a9-e59e-08dd7b4e691b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 12:18:05.7224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jg9jWtMXWZ6xWz3AsZuJRMNrw/18U4ZUL8w7fYPR9GlxjOJccVkqc/oeSMVYnd9Ariz/mEQuRCACMu+bpgEUWFxfsBupcZgx9VZwaYBlifU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6872

On Apr 08, 2025 / 18:26, Daniel Wagner wrote:
> Add a new test case which forcefully removes the target and setup it
> again.
>=20
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>

When I ran this test case for tr=3Dloop, it fails.

The out file is as follows:

  $ cat ./results/nodev_tr_loop/nvme/061.out.bad
  Running nvme/061
  iteration 0
  grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
  grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
  grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
  grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
  grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
  grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
  expected state "connecting" not  reached within 5 seconds

And kernel reported the "invalid parameter" message:

  [  888.896492][ T3112] run blktests nvme/061 at 2025-04-14 21:11:18
  [  888.937128][ T3158] loop0: detected capacity change from 0 to 2097152
  [  888.949671][ T3161] nvmet: adding nsid 1 to subsystem blktests-subsyst=
em-1
  [  888.997790][ T3170] nvme_fabrics: invalid parameter 'reconnect_delay=
=3D%d'

In the v1 series, you noted that your fc-loop fixes will avoid the failure.
But the failure was observed with tr=3Dloop, so I'm not sure fc-loop fixes
will avoids the failure. I'm wondering if this test case is for rdma/tcp/fc
transports only and suspecting it may not be intended for the loop transpor=
t.

Also, please find nit comments in line:

> ---
>  tests/nvme/061     | 66 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  tests/nvme/061.out | 21 +++++++++++++++++
>  2 files changed, 87 insertions(+)
>=20
> diff --git a/tests/nvme/061 b/tests/nvme/061
> new file mode 100755
> index 0000000000000000000000000000000000000000..3b59d7137932258d06c3d6416=
6db493df176ba4e
> --- /dev/null
> +++ b/tests/nvme/061
> @@ -0,0 +1,66 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2025 Daniel Wagner, SUSE Labs
> +#
> +# Test if the host keeps running IO when the target is forcefully remove=
d and
> +# added back.
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION=3D"test fabric target teardown and setup during I/O"
> +TIMED=3D1
> +
> +requires() {
> +	_nvme_requires
> +	_have_loop
> +	_have_fio
> +	_require_nvme_trtype_is_fabrics
> +}
> +
> +set_conditions() {
> +	_set_nvme_trtype "$@"
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	_setup_nvmet
> +
> +	local ns
> +
> +	_nvmet_target_setup
> +
> +	_nvme_connect_subsys --keep-alive-tmo 1 --reconnect-delay 1
> +
> +	ns=3D$(_find_nvme_ns "${def_subsys_uuid}")
> +
> +	_run_fio_rand_io --filename=3D"/dev/${ns}" \
> +		--group_reporting \
> +		--time_based --runtime=3D1d &> /dev/null &
> +	fio_pid=3D$!
> +	sleep 1
> +
> +	nvmedev=3D$(_find_nvme_dev "${def_subsysnqn}")
> +	state_file=3D"/sys/class/nvme-fabrics/ctl/${nvmedev}/state"
> +	for ((i =3D 0; i <=3D 5; i++)); do
> +		echo "iteration $i"
> +
> +		_nvmet_target_cleanup
> +
> +		_nvmf_wait_for_state "${def_subsysnqn}" "connecting" || return 1
> +		echo "state: $(cat ${state_file})"

The line above needs one more pair of double quotations to avoid the
shellcheck warn:

		echo "state: $(cat "${state_file}")"

> +
> +		_nvmet_target_setup
> +
> +		_nvmf_wait_for_state "${def_subsysnqn}" "live" || return 1
> +		echo "state: $(cat ${state_file})"

Same here:

		echo "state: $(cat "${state_file}")"
