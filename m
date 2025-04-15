Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA2C2797A0
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744704023; cv=fail; b=kGFSZ5wKXc026gOvN/vz4WoVSi5JQIApg5RqBDRbsNbZGoiwO0rmC6pKBuF2lG37jF6V8htIsbJDuTdFG/xkpV/mkqwt5xdRAQ1QjuyIC4APx0uv+u2PTeuNbYkG3fOMHypibqdNcDBaMVUE3kL223Neh3WxBtcioyOqKbkrnF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744704023; c=relaxed/simple;
	bh=X8+lrdOHXSXQteQau607nBvVv1jYxuIsrZLMsfF0uIA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RsoHz2PhyyteL66JPGYwhSQ11zrSIakyQc4s8IcbpW5wWP/p0yHDdL7qK9y/fQFkZdpzQuqBTCmnpW4Ba/0LDCpf39ZnUIpe55oM8jaKEkq5mW2hfVxSenPy7j3oJnyxpJ64SpSf2oeH2QbWamhX9gLKMvMYOW7503qnCx7Ugo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gD7EGI6q; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=VIXWFl5f; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gD7EGI6q";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VIXWFl5f"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744704021; x=1776240021;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=X8+lrdOHXSXQteQau607nBvVv1jYxuIsrZLMsfF0uIA=;
  b=gD7EGI6qfxhiZIxV47x9il+yGHfSnEWbrEwh4DD4w3f/LCWUdeb+2Jt5
   l4Tu1utc/mCORjlME0a9cDpGqAA50VyEjbXYPqGN6r3GxBRTxOmg/qHrY
   4bTgsRboCDS8yuOiSyvtlZLxXc8/ccCCLxn8qRxfrlOeBOa1nRrIisQFw
   m31wNoDAwtRdvZ8b2b9u5KVGUwbWft2Hl5T3gnkN40alTQKm7feRTXoBI
   5ThsI6gfLiJVAnBJwIqJN96PGfUZQehorN3WTNYOY5fTSk7oKr6WkuC5m
   TL7kIWEXXRjp6yHYIqH0u3CAB2DFNImaO9e66ujgVB5xOZhLRjYFcdzCP
   Q==;
X-CSE-ConnectionGUID: uVMdLq1mTRmfDPLa3LQnQg==
X-CSE-MsgGUID: tgtIHh5zRyCmGWcJKVcS7w==
X-IronPort-AV: E=Sophos;i="6.15,213,1739808000"; 
   d="scan'208";a="76181198"
Received: from mail-westcentralusazlp17010006.outbound.protection.outlook.com (HELO CY4PR05CU001.outbound.protection.outlook.com) ([40.93.6.6])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2025 16:00:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7QayhJhfmKKpnnTdu35k185zNcxv7/z3hCCorlTByasd/8oUrIzosqzKiO9cYrckhLVU8L4Kbir1seyUpsUv+UP9/IbQH7g83NmNbIkVBE7lbFe3364e/8WMic6BOxKr+tfcixAPo2Xu69aDDiYSOGmpcaa/rdE8Wr9dEicAtBV61UWzSS6B/0ixb3pRoGtIUJ7PTf3y14J8xd5omnmGlOBW3nGokegKTAFZGD7X2Va1flmbozTpZYdK/2Boj/8LtJii5GATdjtnodenVbqjbzN6sSu3D4NVm+YvDwFlSjkY+uJuh2gQp2WomWqBiy/ru9mZnarSUE54PBvOTo2NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/h7yJV5Gr4ndue3urw0f0kbwUmLTXlWXZ5de1uVlirg=;
 b=L56St8LzbMhJihT9TZlc0DsB0IqICU77Uzl1iIRcSKEj37RVeDClCc/zM8hK+2RIGclJ88YkYH4DgoRcI2xvCNDsipABDSWgPtYkBzEPjQoPaGXPOuEETYiG1Gv8sxNHi0J7n8FTQuEgO6e7UJuzZJsuKJBPiKMBxVv2TlVZOq6Sq9iS+C2rTtZ/X4z86qMcqpM/25VdVOmeTKRSppLwlHziqUCHG4CW9T1TtjAbFj55Gvbanvl5/wxGBmD1ufcO8Yp2KjdcswyGKPCKxvd8j01rOV1AiknDojQvNJZQADY5/UVoubiU4DqTEAND6y6CFpxpLFWHZTJB7eFppBF+ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/h7yJV5Gr4ndue3urw0f0kbwUmLTXlWXZ5de1uVlirg=;
 b=VIXWFl5fP0HLakBRLg61zrY3W15L3oUKoF8ufn0uqgLsfNZIYjTccll1NPcXaqaDRxEeqnd6ogHwBHi1sBjz8j5F4bpOZBvrcQdFrDDgCTIebcvHVRo+syK2ED4JeAU7b/pWpQE6bV8GlO3N/ejYOGFAtx7tMq5w6ej7TRacVkU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BL3PR04MB7996.namprd04.prod.outlook.com (2603:10b6:208:347::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 08:00:13 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 08:00:12 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Hannes Reinecke <hare@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests 00/10] nvme: test cases for TLS support
Thread-Topic: [PATCH blktests 00/10] nvme: test cases for TLS support
Thread-Index: AQHbo54k38R8mBe2bEOZYmu+Ge9UOLOkbhiAgAAAvQCAAALCAA==
Date: Tue, 15 Apr 2025 08:00:12 +0000
Message-ID: <lcqyialsp72uc2swd5sde7q6f6ua7gwepurysdzbvu7dwoegx2@skznk5s55jlu>
References: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
 <nab6xnd63ose5yqawp5q3nwrgcfi654zveat6iiccci75ob67r@mkfarprb4aeg>
 <4c3eb3f4-6e19-401b-a110-cae405512ed4@suse.de>
In-Reply-To: <4c3eb3f4-6e19-401b-a110-cae405512ed4@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BL3PR04MB7996:EE_
x-ms-office365-filtering-correlation-id: ee458fa5-f378-4ea2-a5bf-08dd7bf38cfe
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qbyf49j3OHBHheij6Dy/7MNrXyDYdKUh7YuMTwOdQ27I/7gOxgPYnmUn1/mW?=
 =?us-ascii?Q?9wQrfcpXLX547fGjzxoICUcZ6QFC8Z6dHm8+ptm9TiE22BepsaI5r5oOT+cY?=
 =?us-ascii?Q?xvFEkVsMz18FVXBXLPWq1gOK9FND+8Bgp3E+X8KPsUfOSMleqdxpSMV+PVrc?=
 =?us-ascii?Q?c62l4QZZ5w0kyjT3yEJyd6z/msl6fFlRtuzYvc6nJcZfPqpA7i6RGEFzrEwr?=
 =?us-ascii?Q?3gL0QQjOQEGq8zoeZHONr+5te34Qw5/WOnyWZEcq7YuTC6Z+kTDATcLvk6wp?=
 =?us-ascii?Q?U2LrbbV3ZPFml1ff8YaEd/7iNdp7R5/T9gIny8boMYUO3enUum7T75nyv4tl?=
 =?us-ascii?Q?QpWWm/OG7HFWPQUg4vPk1j00CrcaWV7rCbWJdOWUky9vsPJhzuDcLi3wtTVz?=
 =?us-ascii?Q?Tw2z6RRa2qqCdoajycsA66aijPAG7uEcAK7qIG5jNo6w4OQAFfEfBfVHdJPH?=
 =?us-ascii?Q?EsZneRrV8RwJ3y6bkQqewFNcpmrrFk0Qpvr7oJRCTxFOxhPwP5vxNEeMCWAC?=
 =?us-ascii?Q?JJR0J1r79AhMRSQd0jRDI0KAuK1XS8421XersCJSNcNbgF9b4O+8/nrUaGz+?=
 =?us-ascii?Q?F+mCn/of8COY2gcf5zWPeOGAx5diygwNT4aDqSrdCjzY/NWjtL5YPDGf95/h?=
 =?us-ascii?Q?oMV8Ayt/LPpJbbsbH7aPDbyA0muTu/ft1rA+8Tn3iq7bt1ltyP9bnE9AIGRo?=
 =?us-ascii?Q?bnpyX4Hcu8Xas4+sN5PTLs+T85BxGey3sHw4pQMJ+SRcAZmkGPyAKDoE+2Dz?=
 =?us-ascii?Q?Ukz1lMUXeFIKyZlJgi2imrl8lzdGdzlhj85HuyXpJ5YskGMDFWCn9ca5JSz5?=
 =?us-ascii?Q?BgEhp+9SxSzAMxg0lR4Xu9zvwrSysS8UqSXUS/hlZubtSeuuxLTuddYVaw3Z?=
 =?us-ascii?Q?HfaAp7rzlvRxFtgNnZTg5PYs4bQqhL7HPMkT/WJe14JPIoGcMwZIfqKU/ctv?=
 =?us-ascii?Q?A9oI1TnEXa5ldVoAv8h8oiIIGsSySeoWtjzKGaIQyRCg6k7nQfSClSo3q7zM?=
 =?us-ascii?Q?QrjBjiZM1MV3/FSoqH2ugTgNAIo1uUNUl1oSNv7T1Xhe3aoYEEzMQe3rGWSu?=
 =?us-ascii?Q?/7NsuxO8Rwr7M8EumWakzY7hEjtbxAmgAflMEjAMYTkIQL7XbV4mOPhxGav9?=
 =?us-ascii?Q?9e14tJDdL77XEm2dKYX+E0jfkH1nxn5ss7gYnnw8of0cAAzPn4anZIRiNGqt?=
 =?us-ascii?Q?jvLTvdIrB9cQh9Yk1Wa41qOkZP8fy0gf1UG7Sm1X5fZ0JUNjrcmkHYvo+pms?=
 =?us-ascii?Q?Doyx8J7eehtHEt7cKJiZqWIralyJF3oSjRgZuSpHwhcSxLqvLc6U/4ttd+8v?=
 =?us-ascii?Q?M5GGZgb/uH9V49KHCAxDC6oCHZCPgz9FhPSpM9n6IOFBXpPRD5NOP8vvvbgx?=
 =?us-ascii?Q?RZgsyiKw6JFEpwwqjrIbxvRmy5FrGq1hx39s08PUkJ86gQ4yY6bv2aQ2gFy3?=
 =?us-ascii?Q?PXNZLpFPO+MUnnrgImibndDjkeccHNHKpScj0LhohSPJKQd6iiLSVQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aEIh3tQ6GFIHfsUGUdYykNZ9mLKlLfFG4I3c2SJ+KaIa1/lrHuFzOHOkck/1?=
 =?us-ascii?Q?TAZZ6M+bWxw5ocGDMe++qCyUBC2jBka5ZHJnUf6VShGP66U4s5nNn8OrgMTa?=
 =?us-ascii?Q?V21BarSQWe5ofQoeH4CTMuifzRTx1yaae8qP1xzESJev4sN0MoOaGL3aLopl?=
 =?us-ascii?Q?hizuNZpbfj6yg8AcEkoUafbPaWa9Yi4yjG69kA3unXrOjyF+91in6KcMUZVI?=
 =?us-ascii?Q?Eq8qOVVbjBCAD3dwZt+FxxFJtLN0aXDvF+hQrVpTyl3TUw/UykRDyToFjY/w?=
 =?us-ascii?Q?sSffJSiUR20nmKiQmfjng0yrZwNCNcigEWGeqKtLu3wkd/NjJznZqEex/hoJ?=
 =?us-ascii?Q?D50X4d8+TzaHmNlIB2ltawZljDYLJccomY+7MbNtRIQOR7EPOk7zqfVXc6YM?=
 =?us-ascii?Q?l27S2B5RK/aqfyKDO+N4E0GRvC91wTjJ3KnxFPsTMDuzIBCJBvNuaBUbEf3z?=
 =?us-ascii?Q?JEzMcFTwPk+HzIEQITk7MNSXH9oaesl4ZCPF+LZExaSn9VaxTJ0EyIwSLKfq?=
 =?us-ascii?Q?jlcWI3ctr/+uuIox1T0knJh4W8/j58uvAUjem/GCD8Aa95hGKusoyAGZynK0?=
 =?us-ascii?Q?J2neHnB9GFJHfMCPGQNm8AspLQFy0TSCBd48VnSGyqkDrWzpw2HxeaOnHHfU?=
 =?us-ascii?Q?KwWUBsD+L/hkZ4hZsPtelOdfZsEU+ZZ8ACA9A9oiv/+HRzU4CTKkqvBN1VgK?=
 =?us-ascii?Q?d4YClKN/2JBlvhtjmdfu/+cp88Kh0XTB7mfTHWTlbSKvsnzdedijSN6odBjX?=
 =?us-ascii?Q?GkPRpoEML3M4iYzpj5yO8zz23CDqfUc/UJDDs2XTDI1bAKmdA/MYgFbXQo0G?=
 =?us-ascii?Q?JgKc2vAolZ8EkpDN/bfobnVd7xz/iZzEHro8YmFhex5lg4GuRK7N8NjcnU2B?=
 =?us-ascii?Q?PyxbXvUrGZENX2hpoRgbmTaPQne4VP3nFtvnOpV3ooBEyehIhA4KGjlpYicA?=
 =?us-ascii?Q?FNZZPghqBTWUOGGtOqA9iE7yLlBnlEPotSVdYsfu+XEif2deLRkSb9aeFiDj?=
 =?us-ascii?Q?+E3Ebfrle/+wEobmHRrnsSmSLnQon2SVRzWOulUZZjNj9R+oS57jmKDGZC45?=
 =?us-ascii?Q?Sxz/TOCXLbndKaPoPVfwtt5HksaeW3Fh3Evqwwrifv4E2TinLY1kPuLaWuei?=
 =?us-ascii?Q?qNrXIuSBmDBbk3lVdRwVjWOdFmOdE+L9JOC+kWZnoWLc1cIogoDrwU05r9YC?=
 =?us-ascii?Q?sJwp6P0uQMG4Q2SUAJBPlNyzRBoWUqR8LbqtDujYwp2+256IaQBq2kY3yEuh?=
 =?us-ascii?Q?cH2zOPiUhIRetCYBesI4iS6EHL5UUoVFF02ELGCqtyMxF4lRLHmrD6W2F2gb?=
 =?us-ascii?Q?wEpj9pJgdg8GWj4CUXseZjtzeb3/FXs/M/CGezH54458TmnHHYzGKBRoDV3S?=
 =?us-ascii?Q?HxunHGFTRqs3PFAXmOTVuxxbwWemeunmU9koKytolxsDOSt8RE9Cy0v4Bsfh?=
 =?us-ascii?Q?1DJ2naNa2pY2eujnxd26kL5qAWWIZzRY6ayBZfRB1XZYG3OA/zVEkdH6J6NH?=
 =?us-ascii?Q?Ov418d38d5fIOJbfrpeaRTi2YHU9/UuKzMiFXU+OhrCoFe1KfBeZ2FwKX+7J?=
 =?us-ascii?Q?lFodXEoF8lZso+FF2g5YGSStfmWX7pyAKiKrCcDgkYabz1l0yNGJZvFntZG+?=
 =?us-ascii?Q?a9g63T+bFZJD9wsFRGZ1fUg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30A051D8396EF24F95AFADFF9E859DD7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GX6pz8Yy/o5VZy88kC6742z68/nBxqPVO4YY6eviIRTglGmCt1RAL4dhpPKRGLNt8S31tye/eakM7gGh31oo+IRH0xG7+kV/+neFZLFCNM2I6V+E16lXFH1R4GwYZxQI+FmBq5m1ePvGzxiG5haIfvjI11bmf4JqGBjOGBDM0Q5VKjaVMkDJQA9WLmiSIVnjYnfBhYI0Ofui7uaAOlB+ue8Lvnk5e5fwmF+KfXKZJfjw+qGIVEyU5kukZk5QbKPCx1JZpX3LFLff9D809JXARXZHrRz2x3GIljksl8TyTCf3iVxtDrSxTTLF5tWUM6z6CohzKa0LChutj73B880SIj5itZeWsYh8gkasJHy73I5dXDYlav5+eLNVVaMiTnJijK4f57xBi89aB51AzMWY7cXes3rIMhozV7Fo467fcKud6u1bUD8jTzffSJq/gTrr/6WwEL03DcLZwBjfXshosuKz0CKxADR30JyvCZfhA4LMIsH1q0KpvMWUiD2lbxXymLtKjG0J/HfTuOFv0FOdDiIb0dLqhI3F81m/f5LBzZUBMqqg8EGDJwsVRd3SoW8CFTWNwIicryO+1eoaRt5pQpPKkNZai211sYw+EVzxns1mIm0RrRkfZ5Zt26CRKFEg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee458fa5-f378-4ea2-a5bf-08dd7bf38cfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 08:00:12.8871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dbvrsBvpfQTGqq4pQQ0Nj8sq4pZJJ9n+veBtlr+5729vXfzom6JJRrUuzxFW/b6tzuGdAVZAinHlWvT7UUm8e5B+S2xDiHoUx8BA7WH+xSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7996

On Apr 15, 2025 / 09:50, Hannes Reinecke wrote:
> On 4/15/25 09:47, Shinichiro Kawasaki wrote:
> > On Apr 02, 2025 / 16:08, Shin'ichiro Kawasaki wrote:
> > > Hannes created two testcases and shared them as the GitHub PR 158 [1]=
. Quote:
> > >=20
> > >   "This pull request adds two new testcases for nvme TLS support, one=
 for 'plain'
> > >    TLS with TLS PSKs, and the other one for testing 'secure concatena=
tion' where
> > >    TLS is started after DH-HMAC-CHAP authentication."
> > >=20
> > > The testcases were missing a few requirement checks. They also modifi=
ed
> > > systemctl service status after test case runs. To address these probl=
ems, I took
> > > the liberty to add some more patches and modified the testcases. Here=
 I post the
> > > modified patch series for wider review.
> > >=20
> > > The first five patches are preparation patches to add several helper =
functions
> > > for requirement checks and systemctl support. The last five patches a=
re
> > > originally created by Hannes to add the new testcases nvme/060 and nv=
me/061.
> > >=20
> > > I ran the two test cases using the kernel v6.14 with the patch series=
 titled
> > > "[PATCHv15 00/10] nvme: implement secure concatenation" [2]. I observ=
ed nvme/060
> > > passed, but nvme/061 failed. FYI, I share the failure logs [3]. Actio=
ns to fix
> > > the failure will be appreciated.
> >=20
> > FYI, I applied this series. Of note is that the two new test cases were
> > renumbered from nvme/060 & 061 to nvme/062 & 063 to avoid the number co=
nflict.
> >=20
> > > P.S. Hannes, please check the Copyright year of the second test case =
nvme/061.
> > >       It is 2022, but I guess you meant 2024 or 2025.
> >=20
> > I still suspect that Hannes intended the copyright year 2024 or 2025, b=
ut keep
> > it 2022 unless Hannes requests change for it.
>=20
> Weelll ... 2022 is actually correct, for that's when I wrote the
> original test for TLS. It really took its time getting upstream ...

Ah, got it. Thanks for the clarification.=
