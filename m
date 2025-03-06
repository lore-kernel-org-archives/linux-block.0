Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A999614F98
	for <linux-block@vger.kernel.org>; Thu,  6 Mar 2025 03:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741232019; cv=fail; b=fcp2ZwOC0qd6Tuc9+fLbSUZsXiwjOv/N7/6tYrAdtsU0kL+TyuCrlVNaGZVULUY5zZ73VgiVitMTwjXpRO39C/R9fWZPAZNi06L5LOE85PoCH/EEY2PXiLi1u3+AVQOPkW5NO7RAAiWmmK7WAe7OQxgSizQMBbr/NnnWyxpmjWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741232019; c=relaxed/simple;
	bh=GijLpaVUv3wrrj9YX3PVWFahMZTRVoaMyC/nntDHBIM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hIy/8J4EBNl2n45Qb46b8T5ZFAiAnVGBOz4rIpL2BJd2fiA6uDNEzdqzdO91E3JTkAy7wc60m3K2cKtigLuhOBeONYPjlYzmve5KPw+Gd0CJqV9UrCbCyg1TVKzxGZ+Yo/nkXj49B9v5Y35UkIWY8sfxILhTpR95O4fqV49WAHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=auyw22Gv; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=hM/x8WAB; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="auyw22Gv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hM/x8WAB"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741232017; x=1772768017;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GijLpaVUv3wrrj9YX3PVWFahMZTRVoaMyC/nntDHBIM=;
  b=auyw22GvYbKABiCw62Y61wt5auIWxWzfAOA84ffaaYzud9T4pt/p3H3Z
   rUW2u3+wv0ABK8/OJnyx+xQ0XGKdAljga6UJr1Y4OOWy7JAK3VxnhYS3Q
   hqEScOpoB8NvISjEyPzhKPn3kvP1J0fjLoyuUnilmArT9MbAIikX00bsD
   XLiENK2gFqnbInndeyn/4DigYC6/H327bsej96UqZC/HTcZIWGFWhVaDN
   PRF/VYS1lYGyF0xNI3n8HW0bo2whaphz8bqPxQNrFEIxpKV6xFs0T5PY+
   RNVWhcbkG6QNM/iNeQadk8WOWKs1Ib1NJUQnHIl0FHU1ziRz9py2sIYRs
   w==;
X-CSE-ConnectionGUID: h+BXD5rOT4qhZIzF9GjYFA==
X-CSE-MsgGUID: AG0NEAYgRHyOU1xop6DPCw==
X-IronPort-AV: E=Sophos;i="6.14,224,1736784000"; 
   d="scan'208";a="43067121"
Received: from mail-westcentralusazlp17013077.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.6.77])
  by ob1.hgst.iphmx.com with ESMTP; 06 Mar 2025 11:32:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhlDa/3QtWzIyQXqoevFdDV9DAe8hzKMbkINxE8IFyU3+jtLF1RKPTCxjUI8psAnzGlr+HhlbYHIENGpDoCLee2xP+eAbhDNfak7zqDh/dpR5zQ24gZCld+HO4JfvMVb4Lm2aCaENIHHPA6txuDUP1jF3O9ZpZqDvxLr1pHe/tYJ4z+UcY99X1mkuw2XTFyrN8hh4SEzD59Tbm0h7wxzxc6KR8dcQe/RkXh3CMZqyCgwP0rsG6CtjzH02NDKDduWBPb7XxZnsoVOcU5lypQZUoNG0b8QGuNnQQzJ3+DSX2WGUFFGmlxxu43dndKpjzBBQIixt9ICIcWNQPtuRgJ3Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDOIm+RttUAi+5QFeESm/R6Uuw6X5Od8O1cWf+sr+H0=;
 b=BJx9Xo20wlk/U2kYZOKR0GOIiVLFmLXmRe8/hjpe5W3Dj4EuKJIqxMF8d+VrjuGQkL0QQ5b5+KkA02r8QFIwsYsBXBG8YEZqKEA3uXnqDMm6+OQM1bIbfgdLLBvgPBEPG/wCe7U67y28jaX6F2a1y9nU/f/L1gnQG4cCbXYkfH4JrVJ/henARW1Wj3vbkvAntdWBiAHslHtGflnBzY1Rdg9IISRbNw61ZHZ81tpWYrek6kRX5rghXpd3hCxmbErWmrJf+9HJsU/0WgLX6fUPY20MLC6Xfv1mplhmQbU1oaDUWRjgYIGm2oEXisS9f7HflM75bUzKs1au1JPMhBHYuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDOIm+RttUAi+5QFeESm/R6Uuw6X5Od8O1cWf+sr+H0=;
 b=hM/x8WABnLbin+r+EfXyt0KSCUe9dyF5UFcReeEo4AgWkTcVPDVURCzYyW59NXU6gboz5+QXR7AUrQmaapADMmQBkH7Hve+Kl1skrJdgnFhsHGeo+ORKwnCZW4ZMV3ZXQ2mv0W2lu5TzLCGkMSFj/EWZC+kFIonYt1h9XFLLKHc=
Received: from BN0PR04MB8048.namprd04.prod.outlook.com (2603:10b6:408:15f::17)
 by CH3PR04MB8813.namprd04.prod.outlook.com (2603:10b6:610:180::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Thu, 6 Mar
 2025 03:32:26 +0000
Received: from BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::2482:b157:963:ed48]) by BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::2482:b157:963:ed48%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 03:32:26 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests] zbd/012: avoid fio stop by I/O scheduler set
 failure
Thread-Topic: [PATCH blktests] zbd/012: avoid fio stop by I/O scheduler set
 failure
Thread-Index: AQHbiBaDUSaWHF716U+2E/EEGEZRobNlgJSA
Date: Thu, 6 Mar 2025 03:32:26 +0000
Message-ID: <nmssv5yey4ktkuwzrzo5s3u36ty4c4rb6blkjkm2tv6gikgavd@ajhmtxpaxstp>
References: <20250226062015.1620612-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250226062015.1620612-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR04MB8048:EE_|CH3PR04MB8813:EE_
x-ms-office365-filtering-correlation-id: 71a0120d-8c82-40a7-2aff-08dd5c5f841b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|27256017;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ATFZufjhyrt0o27rM5suIbzYXy8gB0Y58EJmOFE64lzXGLZy9aDO/duKp2bW?=
 =?us-ascii?Q?OqP4YJJ5UpXhT0GnN4OP6/d3kKhDUURFJ1V6HRlGz+5N30uveyWY6KenR5VV?=
 =?us-ascii?Q?cu5goxeFI/pAe3FJOfXA+Hd+36ELE5yQHk1rM8iS2S9TwwpLHtI7FGqY9uMm?=
 =?us-ascii?Q?4KZHat7U+BN0uw4MrjiZpOo+aW5y4TtPVPDEHq6TXzsKG5ZnO+TUT+wFqjvS?=
 =?us-ascii?Q?giTxE3V9J8C7k3tdNgtS3dZx7STRskT9BZUmMw2qLiksP0bUz7mFsC/D4Owz?=
 =?us-ascii?Q?nmM4MnLQVZkE3v+Ncfz19Cgz7SegyfjMHFcxs1fuAR0J+9QRd+wxB1gdu5HR?=
 =?us-ascii?Q?odgrKREkVoWvfQquz/hhYzdYmSKRo2gn7pSNNc7B+k4M6B19YVmQDdX50RMj?=
 =?us-ascii?Q?VX/H8W9heJTML1F3/zIT2QmbFEpcSdzwmrP2e9OqyEM3u4dOL5z+s90/MpP/?=
 =?us-ascii?Q?5bXGqJt2mBMtQP6q1rVymw1naumXfsoqaThZai8u4qKLfcbFE+fWcqZmeEh5?=
 =?us-ascii?Q?Lj5WRTpjRM4TU8VHOYlFQYAZf0MSD2Akbv5CfC8O19gcLxP4xVbug9UyTLpz?=
 =?us-ascii?Q?XN/eDaI7ucKCAUT9h6gxXwf2gkv7eoUYEPuk1E1olm9GbPaVuhCWq78DZtaC?=
 =?us-ascii?Q?PQ2YwP3pzWd/N3Bu/tjOAEQuZO3ZTe+qoA18JWSWJfgTHhbfqlwAQH0a6iaO?=
 =?us-ascii?Q?SFpD9CJNhw5TqNgCu49OmErzg5bEsTAjZw0jBkHoZQNLRQrJ1E+eQ6rUEezI?=
 =?us-ascii?Q?wBeGHd/BZA/SjutMAFWTmhwJCm27XlqrxogkR8UQ5r+g6nyMFe9qFSewgBVI?=
 =?us-ascii?Q?kQHr6TvGzJlnPmbEK51GbxImc0U/l41Jq/MtdmZW2bty5yX38jMB5qpsB4JA?=
 =?us-ascii?Q?QqrRhRw79EFEsU5ib9UHs+v8dZxOcyz7NUxoMjFNSzyljsCBwVUtRG8jVpW/?=
 =?us-ascii?Q?7eSMxnU04XBRAwwTc56m3C2L4x47u8Gslq8yh/N33zv/7YHlMe5iHdLfym8t?=
 =?us-ascii?Q?dQeVdiyX7lVWWVTpbqupT2pQ5S1/R3aa5lvX7dtIbshFGsHXpMqFr8Dmh/df?=
 =?us-ascii?Q?b3aM8K19Y4PNxa0DJIxpo4CLM0AoQBZd3Tvm0prM5AvRPunQvVXSqHsC3GyD?=
 =?us-ascii?Q?V5zNx9vangWehR2B0YaSXqAeHiTyKuG9N1PBabjRnwuhOgsWV1d+POdfxGJh?=
 =?us-ascii?Q?ARrQcrxLYs5H++uZfX+lWBP+FTCzP5UX5iXTdSo+e09BGmjxnlbAnX+DktGd?=
 =?us-ascii?Q?7CWnjSlK+l9andP56kC9pXNb0+IU97hZ60/+GelsvRaDRKyeRhpGIqQBaFRM?=
 =?us-ascii?Q?aB8I3iPcmfxCudjpymLBz7zFwPgJm0KGs9ASN41voK1NZHn++BDGlmTJNDLJ?=
 =?us-ascii?Q?8ZOqpOuFz3WNU15Vr9cMmE9FHue/9xOOiC0pYGeKApSY/FhwZ3O61e+xIzbv?=
 =?us-ascii?Q?J6P9QfZbAymDpLwZdSFcztqbvOlJJCRLwuSKmCu6AWzkxasK32HPkA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR04MB8048.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(27256017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tD1siqVcqt+HZ0Cah78wA5uXT4gaGxck808wmFBtOrFi6hp3FZa+YYDLFAH+?=
 =?us-ascii?Q?etg02JLfmP7pZ84386WCWUS4U+FJcBjEuQgcbb3z+/2d/WGGSTOKksVhPFAo?=
 =?us-ascii?Q?lZDGhpRQDay5SPdDnCTeOSc26oHSbQV/ZwyXOHJNlK3X2uNQPmpLSs+bfSig?=
 =?us-ascii?Q?up2JWPu7jQ6DHSYdP9he8+6K74hqiWYdx5aqH5PXlNdRcVii6DkyWfpakuXU?=
 =?us-ascii?Q?5AZQJGVIUu15pXphU6r3lY8HHO/yn/XqwjkZTjipNdEEE5E3uyCGLRiXN+Ar?=
 =?us-ascii?Q?9lJY4yu6MrWGblbcHzuiZ6lOys2fKUKmOdQN7rk3bblhMI5JpR3DRaLLG78C?=
 =?us-ascii?Q?X5hiWJV9D5bEm8X28DuFrik8ChgUX0rGY1HEIlT4VH2lUiRX2h3FRqYCv4/N?=
 =?us-ascii?Q?mr9yYnescu+V0yoVXLfEsRL3mdGyCLLdVzAMe/1EGfNcrtsvAeFk3imez2gS?=
 =?us-ascii?Q?1aEq9LP0wbfbj2og9vft/tEhhjOWCOm97VdAblI0WudrkFG6obt1JOOkjxTT?=
 =?us-ascii?Q?juLx+epZLOhiHTJsq3MgBlzw61YTEYku6PS4hQMid/5TsCg4J39fvKk6wfeA?=
 =?us-ascii?Q?hfnWA15q4z5OPZJViSjbU9cOMVKXj/yE4Fb7N6Gzo8is3KvWgrPp++IydoBr?=
 =?us-ascii?Q?7G0oGVA9GRFk66r8ZyUJTxCWYeL4wV6K3GZO++RNu7MohCWl0OKosZyV5V4R?=
 =?us-ascii?Q?M8DaMBmWsPGKgg9ALqtWbMTjyo4N176vOx5GoILYpf1RmILrk+MvK8dOAQYG?=
 =?us-ascii?Q?frERTVYIXXjQ0GnyUzrJMYqDksOJ52tkvk6B258RskpXoNwxjVvfmhNWdIfw?=
 =?us-ascii?Q?U6pUXLPZqQlyXC++pZPVYVBq4DcGaMOPLtC7ucHUYtbhqaoD5jOSWaHRR3R+?=
 =?us-ascii?Q?JLRC9s2R8pixP0ZsJ+7UPG87KtkJ7jqgtwqBGJEgO18s8uEmakT0w0EvS+2k?=
 =?us-ascii?Q?veKqWz/hoLKKdV+qIzWFACwV8fm9vcMCShdAAW/Gshbx2bB+GQS2LedTmcUC?=
 =?us-ascii?Q?BDACgVYLwG0OJCma2/dKyhSSlXKyYlcH508lxiAJpW7LxcZ1V5l3qTAuTufo?=
 =?us-ascii?Q?X7ApW23476+ujfO0/L82fPjAJkfr4udKO8aGCy57a57wgvOvUfB+datx7jBD?=
 =?us-ascii?Q?wqSW8G3UczxlaTHOjXSzdMaq3IQZ7LFJM40JTJ2Z2fvLwJkLy6DxIw8diyRw?=
 =?us-ascii?Q?ihJurip7RkJWwF+fQOYYDGRIh3k7f+819vcQlvb+SChTHQLrtNVk4H/k6CL1?=
 =?us-ascii?Q?OjMKWVIjuucRMQ+8SeOJvQjQ42QKWUhaA3s5t55IcYsOdOvVt5hLrz/0ZHgH?=
 =?us-ascii?Q?rOK0LWvdIKvzzexvE7Ls279eGZIJnrJ3h1oTn39exL0pIDMjI4aZs+QXB7it?=
 =?us-ascii?Q?YJBTJ4fgMgmAYW86lKlTo+N1ComeQgjMqUpcUZpwNQRuoHq8NQHYFuozYG8E?=
 =?us-ascii?Q?66LRLdMFtH1ke3y9NPJJZivLGVRz/BFBp8Q7MDFBxlXf4R/mNcFSZJKuYgET?=
 =?us-ascii?Q?U9r+E9NhxAR4dqOIDDVyFq6z/Qi3mrgemleWkIIhXkxfkYG1GDZ6TC23z/GV?=
 =?us-ascii?Q?kJ/CQ6Kb2UzDlIxCJU6jeBAMGIK85CJe197kdWzIS28dcSMqcWjj/oYS6USY?=
 =?us-ascii?Q?rckCrtFjQl/8ndRUZIuIyMg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DFE5D3A3280C13498597F918C0997774@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	M+8G+CAaZXEJmSo/t3GvFuzMgdfsGpr9O2yGakBFv6RQxjPTA7f2dHs3kADB0ceQNaTpfn4O35E8E1z0GTQ7kHP2vXzKRfXUUa3jF/F7iDfOsJXl1Go6lDukG1HjAP1e6nPjODJXBCA2ndlul+7BZ5rqoPe5eimMQ0TQ+zgwHOncBeE//1RuGdPDq8Bp9S0yu+6f1t2iJSWrrFyB6+RRPZWMVYmWXgXdYX0EaLU2rBY1DIF+bXK6U0Mr6Bh+8FswRWrBS82MX5MzZlnOrfsev8rn6L5PbgprXxYArFtdC0St7gJLJ0V0RQ0eEsGX4y/OA0Wa3f21FHCyqUNdMe+dPop8Z03t+guN+H9o4GM2q+H0F7p+HXexzDPweCRd0P0j8z2wU9MnLnHAF9FAegRt9C25kIBY/Y3C3honzeIqhaS31eq0Q+H+6Aeqii8wBWBQ/hNUMvO+s4sLqslQI01OddZQlbEos5Hl110iM8QSFgJQiYOWOvTet+hj1yHA/0eBTbsSA/rCVGJwmpvgktvsKIKsGeqALkUSwTsEFVH6cHESFJ+2b2R2fZjOiJsOBdKWcx5JY/u6xE2kZ9olOgv7FUPCinpbqN1ZsDIFPW4LISEOHI+CKr8Z6lGbIGewYvUr
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR04MB8048.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a0120d-8c82-40a7-2aff-08dd5c5f841b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 03:32:26.4431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ngi9RhAZsTJ9J4BXNakMzI1q6l27jMZ8TzhECU8e9roLctmmLOjt9f1I+X18d+8BQBqKFVFIr8zVn92tpdli2npe+WIH05QIvDstG1Uno/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8813

On Feb 26, 2025 / 15:20, Shin'ichiro Kawasaki wrote:
> The test case zbd/012 fails occasionally due to a sudden fio stop. At
> the fio stop, fio outputs the following error message:
>=20
>  fio: unable to set io scheduler to none
>  fio: pid=3D119786, err=3D22/file:backend.c:1485, func=3Diosched_switch, =
error=3DInvalid argument
>
[...]
>=20
> To avoid the failure, drop the --scheduler=3Dnone option from the fio
> command in the test case zbd/012. I confirmed that the test case still
> can recreate the hang with this fix, using the kernel v6.12.

FYI, I applied this patch.=
