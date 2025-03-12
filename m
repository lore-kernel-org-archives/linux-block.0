Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BD815539A
	for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 02:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741747083; cv=fail; b=QPGIpEXZL1sbhDbUnmvXkNwcs4r0w82lIGG+Pq2YQm9JwGVfnsBWJs/GHELyvd1e4xarB9N5NwpKvz/i8xIlzMpM2psW9931mhvT24D81wvXgYq25U7j+j0tAb/sG0/TEU6e7uB2ortEH2ZU60PNKoCjkbQbHrx48m7KzBHMa54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741747083; c=relaxed/simple;
	bh=U/ei/h4w9KyD3+OxI8brTRK4gQp8mlzdU0ocGcnWeas=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gqfqGNH/4fhrNhCJ5nUZZrYKD87JIcItxoFrmgFIQj/T/r674bSfD078ZZWmvOaBLh5ZcsMwy4QXuG4+yFMRAABGGiuJuLBKie6v/xF3LhVSVTufsV1Y78XVP60YSSiPQ5RgFxSYHY1vc9I4gO/ENd2ebOqLc8vC0S2+7qG+MDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZtSobA0e; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=fR76kgww; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZtSobA0e";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fR76kgww"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741747081; x=1773283081;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=U/ei/h4w9KyD3+OxI8brTRK4gQp8mlzdU0ocGcnWeas=;
  b=ZtSobA0eOIf4uPCHFFwb5M/uS1IaPtKeQp8e6jouzWp5xlRsPuyGWPz4
   TNV5bol+tBM4yugCCOlzaJeyvBxMYwe2ai4CucOEkDPUV2WmjEvH4A/2i
   ZDnD/q6/HZ17R/ghkOEFUZBxGTnALSlH8NfsT6LFADLCekEshKPgxgDYr
   gbCDj9D3UQQhYl+rzm75xMSrhPKXfKe7vYqpKULXRQHW713aaPEp/D+6Q
   F7vR9H5vunW4NK/J9FoJInXGDBP6KSLtB606ia2pk8NuUvEwPlcbXajhA
   CrSki+nR0MMIY7nFNf4v1UHpf1bSoEZtW7vzTP6h8DckNrWPPqukqdpEb
   Q==;
X-CSE-ConnectionGUID: mO8L3Y5jQ+GQFOgbaNdcOw==
X-CSE-MsgGUID: Duxk28n7Tu20aKcIc/19Pw==
X-IronPort-AV: E=Sophos;i="6.14,240,1736784000"; 
   d="scan'208";a="46718042"
Received: from mail-centralusazlp17011030.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([40.93.13.30])
  by ob1.hgst.iphmx.com with ESMTP; 12 Mar 2025 10:38:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1AOmVMRZwsBL53vwc6QVztfnjn57f8YoeAlno2FjddO4Mirhp/QKNW7xYLbJ89u1WHWZf+O81uVXNO6sepc23tHvyaRUZBf1hw6IRKUcyMdRys59Qcuf8NAyiXpvHeYcp65a8nFHOYr/nZNnWzxQGtkkTZOS+MO+EEo9/36WgJXhHlGN6rWV/ZiV9PowlM1l8/x+chAJoh/sdRhdveQt8lB4Dh8SAWEYcl4AV78fjDl6/cmnql/02wDdJJIyuGdvK6eIuZc9Js45lnYUIpcX6CjmQJtadFR9c58A7AI2DP1elFbjDByEZxCVjyPz9NxZbC/qznTNCNVDGr+9igCJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/ei/h4w9KyD3+OxI8brTRK4gQp8mlzdU0ocGcnWeas=;
 b=rlHwYxyxs0K/kBjMZR0Rlg75iEz6bSJP081bJYaSAYEtE5T9IkLpBj/MPUHNFceJ03OEKlcopcVxTppHEXZLu2aXYCneY3+kl1rcT7lEa6xv0eUesBpGwdcdJeOQqQb+zB47LoTK7sPBZJ5nuVraM/1ZbGx+FjvF2KjHs4yJXFBbrCRKZyASlTlgLhBvUaxr3M44KA5Si4olbZGkWFBOO/jCitRZwuY+M937H+SZOqEGt6pV/vgwS6lB3pwZuQ9a/jB0HJdqFs32N0A+58v860UWhNBVtiTRF2q8TMwQspMPQo8FWZgw9Up0zjLWYf1JRqkJ1Udl0QGU0s+WViRRwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/ei/h4w9KyD3+OxI8brTRK4gQp8mlzdU0ocGcnWeas=;
 b=fR76kgwwI54DV+w7LUE8+Fg4kVQqqAtdOtCdOihVXQrbJWccHjeBEscP+IOk4+QYGEvlgDGjojzVIZCbEdsuzjIVmxUW13AbXykdFxhhSB56ClKhA7Isx71TEZf1Fci0aDtAJkv11DtzQlsDSeTgVzSawNymghE1FD7ASokFxVA=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 LV3PR04MB9468.namprd04.prod.outlook.com (2603:10b6:408:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 02:37:58 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 02:37:58 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
CC: "ming.lei@redhat.com" <ming.lei@redhat.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "yukuai3@huawei.com" <yukuai3@huawei.com>,
	"yangerkun@huawei.com" <yangerkun@huawei.com>
Subject: Re: [PATCH RFC 2/2] tests/throtl: add a new test 008
Thread-Topic: [PATCH RFC 2/2] tests/throtl: add a new test 008
Thread-Index: AQHbjzgWW6e06buEmEW8KqL8R49hCLNu0RUA
Date: Wed, 12 Mar 2025 02:37:58 +0000
Message-ID: <4fcdnx4kkyblyvmqtrnzru7fjqn4c4yq7c7giyguzqkif57wuz@ueadqoo6ye4e>
References: <20250307080318.3860858-1-yukuai1@huaweicloud.com>
 <20250307080318.3860858-3-yukuai1@huaweicloud.com>
In-Reply-To: <20250307080318.3860858-3-yukuai1@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|LV3PR04MB9468:EE_
x-ms-office365-filtering-correlation-id: 3f522071-5477-45c3-ebab-08dd610ee6d0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?x+ROwTS8GdLvxfEMY5R4YxkNbDELr5XWc2DKlwrMvMw/6YANyHeRlgdqn8k+?=
 =?us-ascii?Q?hIug5nwft6bstY25dRS6xZbLR8Ii0n3bjKQ9HHrJXXrpfYXXnwDzskwCkxsE?=
 =?us-ascii?Q?WDxG1LgCP0DkeTC8sn9rDLxmzg5czNSIlFkuQXJP8lNczvrzO1QEZJW2X4/U?=
 =?us-ascii?Q?eSFGeh2FtNhRFXAsU4s7bO5K0YQw+PTzYLUjd1PB7Q5s8Q4+LDdKyLY6i5eu?=
 =?us-ascii?Q?wRDYSmU9B6VZTPdLyZW/UqupzyEi+mprQKSMqKhncsTU+3HyLTWEmG0Ba3Y7?=
 =?us-ascii?Q?5yvzUJ0iDhWLWK2XVNirRcD4m/8appMB1yfHv6sjoY/taU2rmN1r0J055JBt?=
 =?us-ascii?Q?QVzYcxyQotBbYIWTAANpymWbJYJwzO1nbzNY835mptkpdveeo0D2J8yzqi17?=
 =?us-ascii?Q?KpBYKBVWj8MEOMjwQLOQaa7xOaIWjrkRA8gCrfFLGvBKwU9k8OUVIrvgeTxf?=
 =?us-ascii?Q?0vu3gIC3MPmMvDzLdGOFouY44BnOwqrhF3vPP/eQPU87t1nxeGKXYKqfwU8u?=
 =?us-ascii?Q?Y4vOtaNC4bJCMeklnD6Wy4lwe0xAuYSL2RBwwtOPK0Ftk410xmL+iWyVeaON?=
 =?us-ascii?Q?GvKXunPDncx2x6vMU5qB3dsWmx3WlQTgrOtk63HrXYyikYQJuIFb+IHZU0f1?=
 =?us-ascii?Q?PejwX61Y6DNmk96Pl6HUx/8tvEkIXnm6cIU2bN1VV2WyfdEfI6+EzcBG/sIM?=
 =?us-ascii?Q?YKBylOT8wPBX5RLC3ijpMGLxVlw7syI2kSZqjrSS2K624Pa9MJp6mlH5yewS?=
 =?us-ascii?Q?THHdJmdXCL4CcaTIFzM8eoekYCtoTpWpwDySmxQUPSJTUPkZLqs3tSB6WYjY?=
 =?us-ascii?Q?Os1T4aCnm4uiI/6h5POtPaWoZg/AN5UtJpLc2a1uacGG/PdoXutLDE4Q7bBp?=
 =?us-ascii?Q?4JjhOV0C+WWdvPZhsiSH5lE3Ufi8zO8eJBRLxChalAC1YltjSqHt1a8+qZDK?=
 =?us-ascii?Q?7qGeRLVgfLhMxivwaxPR/3H4poXUBR+A5HqtPFoA6tX2gGI7kSd7Xfcush1q?=
 =?us-ascii?Q?DEKGjwsvIME7iA2sFLOXRXga/NuE8MrmpbVmG8+/ZauVxtgQBSa9qcMvZs9T?=
 =?us-ascii?Q?qlVJodlU+c0GvoeWsxyojdtUYgl4qenpQJu2SbnuoRmGfYltWfmL5eu+AFSa?=
 =?us-ascii?Q?730ktHP8tH0zw+GLAomBkvG1RZSwlLpR5PydbgEaYYEY3EMvOqc9JzUi4FLy?=
 =?us-ascii?Q?VFrAda6cxb2KFqGXuMzCdlPHpG7gJnZ4Bx5esJDy76TR0s9Qd4W5r7jANZzY?=
 =?us-ascii?Q?at/YX9H0yVue0HKcFr3STEUeFEXf5aPs/DmEvBkzpMp+zlIuxXvJ7gdI7sDE?=
 =?us-ascii?Q?1RsFhNb3S3rSz4MCft2ul8j4p7zJ3ERGgLbtaVsubz6omi6dKKetbFqh+gut?=
 =?us-ascii?Q?k6gIMykVpwIz+3KEla9Q+xmictu1Kl5rTSTRNh0Xwai7Lq6qx5qaxkXhalpq?=
 =?us-ascii?Q?GndMKMbz0mWIy2H/VTsQ9uLwKGqrucWO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MASU9C+1IP60tNuR1mAHdxKaKFe7SlSPkYJ/dYoCfRohEgHH+Z0ln2dYBzbr?=
 =?us-ascii?Q?FkrFQGLZaqKmuVgwZ4Nh/Rol9fsTECz16/n58jvLMHyRiou1SOtxtcu47YRy?=
 =?us-ascii?Q?ikv7mSYAvmUx2mqfcvxXbaj2+2IXU1mDf7qXcxX36OHSbThAaQB53ZA3EmDa?=
 =?us-ascii?Q?xlZwts+JhMsHYtZa+r9mWVXQwzoZcJjWJlLBM6LMXgtjM7+/HbN7ZQDXsS9g?=
 =?us-ascii?Q?dl+sBfBfM35+nDVTIDhwkuNPNDOuTlOa/IGfP+hUBiZbqLug0npUow2DUbi/?=
 =?us-ascii?Q?A1fPuI/BtEHymwb9c7wzaA6fmxC1M7eOGH+hQ+2k13aoge6vrsN7WUqnHikj?=
 =?us-ascii?Q?2ywjPh05Up5c2ClhtY7PbhbTOZWGtSsee5k7BOBXbLUDGR/ivD2wlv5x6QC7?=
 =?us-ascii?Q?tMiANTjzkuIGTPTiVqlwVBfXwdVJbd70XcUbsUSPv880wUTAi/oyi1M3Ddx6?=
 =?us-ascii?Q?App5LxHDKs33LoOWcrKkdod/4+6pIsqI+cZSbi1EqTMjxMMLNYW9ECjJUjON?=
 =?us-ascii?Q?DouRXzRCA4NlL3Ea7nDUkjhuD+WoE0tIALJZgYK+rb+6pLcHG40X0WL4tgjU?=
 =?us-ascii?Q?ui6Z4yTYp1jjtPrfwjnuvBFmNHVRrzc00g+huGolKgwi+gvJiueWhJkG0iVK?=
 =?us-ascii?Q?mljk08xqcHNoYsp/HehAzm4ygxF8eX41t7FPrNZLub7vXih5XDCPxj+/8HyU?=
 =?us-ascii?Q?9gLtM0CikoK9bI+o7jE4rpKCas2wt7w4rhmQIe0x0DCVRgNZQKcH0r+/0tvA?=
 =?us-ascii?Q?LvbZIdJ5zbuCeSc/m9GE4XCP643BFmQ3v+rl0ZQ9HWueXFRoCR0hU04z/jVp?=
 =?us-ascii?Q?fFQxyLUn//QfEU7eqDPcPrVK2Jn3AKfM8UucgdXOOMTNLHYbNmT50WaABUDk?=
 =?us-ascii?Q?a/Zgu5L76/B0Wv68ldQzktVuvfiIiEJ1xbgwOVszUbyw9uU5jINNF4zAgERc?=
 =?us-ascii?Q?NDhhCNaAMsPyg7u8DBZ96criljyRbuVlHu+qVEL43GuvYb1AmygulNeHIO5V?=
 =?us-ascii?Q?DL6axu4m7MwwTAqrjXaZUZ9dAKIMvbh5IIbuHJm3Vvt2iptGHzSPswVyl+NV?=
 =?us-ascii?Q?RlpIEW5ePornqwwiu63RfDn7/dOLTnwfYO9pk6bSAM6oK82Xx0X+Yu//26tZ?=
 =?us-ascii?Q?DfzxKhTz47zljW3QMrSElCSBRBGW1MU1B0kncdhzNj8iB5RlEB2CLM48l55O?=
 =?us-ascii?Q?w2OmLFbu9W4FoUqJnb1dqxVJg+G5nId9KCF25dVeqBQwh0eyQMeypCsBRFgl?=
 =?us-ascii?Q?3b3VbIBjOaJZ3Q8ef3ruo/jgHPoXdh4KvrOO+0H4dfA4xqVLvznDic+fwWlP?=
 =?us-ascii?Q?owendSw6gPhKyCQKQY3Y6tPpP//7VWdHjr7v20jOulADwFDQMqdylqs++YZJ?=
 =?us-ascii?Q?HZMFxim29tnQ/BoknkNXofuJBRmuQYSzoS3XZcRkTL47Y9X6jKiNXiA0Bjb/?=
 =?us-ascii?Q?jT9apxCmflG6aOAZqSWCaq6JmcuzCXRmIWL3RpC8dNSqa7E9Gw0lFtnSmYoe?=
 =?us-ascii?Q?JFXrVSEixwyuPwmiux7xEpl/aUqivaAS2wWHl8CXpuD5T8UtaOpdobnUyL5w?=
 =?us-ascii?Q?y0ISM7cP/VBBSr8+NN1BIHeJu2kEoRtV3ksNx7eSd+Hg23YtU530YBTv5r64?=
 =?us-ascii?Q?3g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F4B67E6EA76C9846A093774CC0A1766E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q5E9Gj7ZQA14eFooOJPIA8lXah1Tos7TnWtjqvGViZeW5BlK1I5/ojEFelHfAhZI7cHfTMrrDOWjtl5bJuaSfbUHfuV9VVYxrvvqhmOzHJMOAaGcAVnYqgnodnIwOvpmPIcOT8Saxm41zjAV5GJZNmiqR92HEuuW7W3jDI9ZuP5GCRhtyUwBUKyIFflfAs7hKNF5un2JT70KUggFDcSNhMj3UWG82bm3MMq1bRjKFbfNkNBFwMpsqb7ltMDQRR42kpzRQRx8fkOAhFpceZMcA3Z4WBLMecTxKAsIwgWvfTO9NEsy9mkUd5LQZmRRLQu5re0fBtf/Kt14RmDEJv6ULGR634+jSFWMg7TIsux+yjPeZdEefm3KHmjDbtfcNxtCb4d8xXZ65wQ8pbnO/djJlzcGTnOaSEtE05UnO6GbFLAr/P744HGQDTWvm8Q2pWmx8/Y8yDCw267Ww/tMv7X+0ZL06EngWNinJH1gh7Cfw7X9pc40dJzlhdiT/5HzpAwWUPBbnGYxdPBfRkEeNaFxdtcw5seEwv7EPFaizXkHzNRnHvVtW5P+GJam+S9MFmqLEpWtHgyhRQax+kBYeEWWciVowzVvmO1eoKa390Udlw9gAUnTfhQLmmDfHQfxwinf
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f522071-5477-45c3-ebab-08dd610ee6d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 02:37:58.6178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wZ6oxlBf0iP56AUUg9G1H1PLdknbazcoYUKVD294sHQ+aE8U4DP9CH4x1/Uh6WJcJup+Df8tq0sOarilqL6Q8CUFtKzGYhWOdeMEwEKgDdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB9468

On Mar 07, 2025 / 16:03, Yu Kuai wrote:
...
> diff --git a/tests/throtl/008 b/tests/throtl/008
> new file mode 100755
> index 0000000..c64f427
> --- /dev/null
> +++ b/tests/throtl/008
> @@ -0,0 +1,39 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024 Yu Kuai

Nit: I guess you may want to update the year to 2025.=
