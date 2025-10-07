Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0FB2DFA5B
	for <linux-block@vger.kernel.org>; Tue,  7 Oct 2025 11:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759835937; cv=fail; b=YOFIxW0n0Ip96PpKcLzaGit6TAd5Dd0FUHziu7eEcRcFbAk8tYvmYS06C3moten/vs01xb7+4vUjCMJfUv/GruFSKC78b5GjMawta2fgpIoosajY4EoXNr4gNzkPnz55p1y0PZaAiTz/tsxcBli/rBEHDs+s861LfTsGzi2m0vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759835937; c=relaxed/simple;
	bh=V+XCnLFA8vBcEI10SqHCmXLGQQlQap1XlESESfk688c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wq46/t11GenNCpKBuMp6f6kkwXWfvfxg5RzLF3RhrKxVNDO3Yr6IM5T4RZwq1lvku/pc+4q4PQuceKilT0qQxgzb/FIzIA5gllL9Kalji8C8ykma4KQan/klkQ658NyfMFhPBYS+TzKrov3ywHu9UJrKO97iODX5mksxZUVN/mQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=L+2+vBOq; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=eC4AN021; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L+2+vBOq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eC4AN021"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759835935; x=1791371935;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=V+XCnLFA8vBcEI10SqHCmXLGQQlQap1XlESESfk688c=;
  b=L+2+vBOqF2W6IMC3hyBavV9xW6C0/yMGWSyMsYHzMebXGCnxHIfRHA9j
   kn9bnLbO1xpRLncLB94mRGAyW1a1eeXsvlv5tUAKl2iJmeHsL8JklP8zK
   Qsbzlwst0peGws+gdwB3dhnXY4OZEn7Ur26NJmkjwj3y5co6OO6+nBRRs
   zEkLYr4irEVhJ90Ozw61Dq9BWlVd6EpLRaBbX3+tD0vu+ecj4JvljXAkF
   SGXvGDttjlTvzSxSvjtEetjAt/IvDODkYlSHyAW2FmWoi8kg0NHmCD6xJ
   sMTyWA2Er/Yt7omcxbOrIQVSYd1S9DpXXjRKiGnawhnM0levBrEGD4Tuc
   w==;
X-CSE-ConnectionGUID: hKdzsIXYTgaFsotpmNYbPg==
X-CSE-MsgGUID: rajcBJjfSbC44bba6rTzBQ==
X-IronPort-AV: E=Sophos;i="6.18,321,1751212800"; 
   d="scan'208";a="133670671"
Received: from mail-southcentralusazon11011001.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.1])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2025 19:18:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7pAo7FmFqQMFmv6seoPSQnf3yT1mdUddKILf0JP0lFsdBfn9TuXEaP40EU/rlH4be7o8WbE+G3TeJ745s1zKr49jLo+vnK4SRgzCqCXyUQvufGSaOGh2RJelzttyXbO+4WrjymMEy/K41sBPeaA/x9aW4zyL5Skm8T/CiasIwFkUvdh2oBxgy0AP6LQRRAj98bDAmrXRmcZGqWWFrA7wxVrBuDBfhNpxy/j1XXpAvqTgrD2XW3rd7uwDVpTKv0i/zDzbDBfdj9j3bIgFGGcS7Pe/LsF19etuBJhOJJz7G0B/RJ/b7pKRxqIDZJ8L+MD++QVXyP+nDqQne/chZjLVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJRyiEVSw7KznK6+MPGcTY5tPBtrb+mJOxG2STzKgGo=;
 b=HIwu7ht3SXV5UxWZeuSs6/O+B24ZPsiuPzoLyq5vg2DUIBjPszaSrfKtBmZNwhcy3NAAJHRQZaRj7zHJlbXTkdne8tcFgYQVt/AAhX3r3UEPtICMcEBmXNG35DgG6snwzbLPvrvEiPly33RN9kywJLaSFpEj9OWh1pHtkG9dX07MNVJQ1fqlQU/BLV1oJa06TAmOmVUfSWmEynvogcKpNvNMNwCLK1rDBmNJnTQj/0rAFBvivXSX6knC+KJkLb8kkYaMSJV6m5BXrszlRxKVVzf7hCE7sqVPJG5d8lz+BWVCrEzGv3aWSv1rY5t8DVVqYCn0Chb/BwbA9UQjHPdX9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJRyiEVSw7KznK6+MPGcTY5tPBtrb+mJOxG2STzKgGo=;
 b=eC4AN0214fuxfVLbVE2lbivsUkmDtYtyCrsCAYNIovDgUmUXj/U1IAHwlNMbZNSu7CQ2kFcYefYU/s1mpJ6LrS14nvXOYIAEoXn3Nce90vXO85VGNCT3a0wIMCJavIgqlXulA8FdaJirCpP+nqHT16OZIbXVvhcOC8RRmMYwviA=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by BY1PR04MB8608.namprd04.prod.outlook.com (2603:10b6:a03:534::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Tue, 7 Oct
 2025 11:18:44 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 11:18:43 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Garry <john.g.garry@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] check: print device names provided to
 test_device_array()
Thread-Topic: [PATCH blktests] check: print device names provided to
 test_device_array()
Thread-Index: AQHcMFAXod32pG6NpUyixm0uJe6+b7S2XaUAgAA6AQA=
Date: Tue, 7 Oct 2025 11:18:42 +0000
Message-ID: <6xsuj673nuxphyd73ckz3rff23t6bmuaofpvkmnx25fifx4c5r@lz6zrg2mqpy7>
References: <20250928081537.337008-1-shinichiro.kawasaki@wdc.com>
 <1f86a692-bb0c-4fbb-92a2-11fb28b463b0@oracle.com>
In-Reply-To: <1f86a692-bb0c-4fbb-92a2-11fb28b463b0@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|BY1PR04MB8608:EE_
x-ms-office365-filtering-correlation-id: b03e7a61-cca5-436a-bc5a-08de0593468b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sT1RgRvFSw09SWd/Vq+CRCRg551z5a273byzmgDUuZmGJOSFKAlQlnpWmPM8?=
 =?us-ascii?Q?zfIOO0ZjW1GKxjhwJkiCk0NB+RoRf4XjWksFbgq6YKmgnh42VIg1WN2VFB1T?=
 =?us-ascii?Q?yCcF1pvktX19RgfCcPWaUaOyJ4Te+c6UEbZeZLtsfVEZwMJ25mHl/KrHu9KD?=
 =?us-ascii?Q?OfQYRANfUPh8Y7srBhjJ7L+csRYtWMbne4yTK8d9I2OkKx5hsEXzJ9Kg+WhP?=
 =?us-ascii?Q?0RKAuzDLjSho8VIDtXZoHdISpVw56bTrPHT4+iHmDJ+c02i2spUFfZ6Ldui7?=
 =?us-ascii?Q?0yPisXoyemAib2RhS5Zn7fEuqkHFxDTKOAatJeIrjTfTPhXuA8WwtLOuc9NV?=
 =?us-ascii?Q?eRdRVnQTASVffTM8mbdQgSRXbPvJKRlM0Fit3IXjODWNDRbDPuTMWFUTwRIP?=
 =?us-ascii?Q?DsYKZZgmbmOBRyELWp5krLSiR5RcQdBD5rmtRIF6/Yv/LnxOWVtG8+nX/aGW?=
 =?us-ascii?Q?ryrreHTt6pl3NJosp59US5l4JUZ/zUpPH92IeOqZf1PnJYC9pDOy5SGDXCn0?=
 =?us-ascii?Q?dAJBIWPXi+8FNNrzIwiNSw9NthXaL88kPPLdezCVnLwt1VsuiOaSAXdEK8Fk?=
 =?us-ascii?Q?zgGi9itTxL89RvLhHKtLggex84WPx3ipbGFLb1VrH2v+O/V1s+6k9+dW66Ts?=
 =?us-ascii?Q?bxRMIPDgZTiiiLkVU+aiBTEhSclh15KBAiPWigx1bv68vuks3+fPHCQWDPxz?=
 =?us-ascii?Q?YrCpsH6Ua8aPJbVzsGLUxA00u5sWbIE4DUrRgSyuUNEoaAVB/Bo406BU1mCn?=
 =?us-ascii?Q?aIvkP3P05aTVLdIoAOjWuTOUK6TRy+aBobeQvBmXCkExjdT+cZFhhJiRFAnq?=
 =?us-ascii?Q?2TPThsU8jogveROgjAsE7AEDyd36Mq0qQ86mon/G1724RZCaz8eynMzsy0td?=
 =?us-ascii?Q?zB66qnhJtSP6rRUXl7ovyhFgvnbpKbG8F8Q3koTDediMKONU1IcRfPTvqY4P?=
 =?us-ascii?Q?DQ2SSOSmwK9K8kjV631jirGzYDdbjHmvgiOBSNBNxwUTyBPGKPsmqEOe9oS3?=
 =?us-ascii?Q?2A+rgcvaEBU0MYF1BEdtFi+4dbbEVlhgiUyoQI4LOUJJDyf4nkKZlMm6UJDk?=
 =?us-ascii?Q?1vXWXm8bYOK2KPXTSvydfZijipBCKr3Y6WRcZC1RNZ55g+CpyTNZ1yc1ChFq?=
 =?us-ascii?Q?kHflSBodquwuJpIF+TvTaAkVN584f2TCRcKmuAODgbAKIgupPo0GSZ9sr+F2?=
 =?us-ascii?Q?t2QRxLPppnk2sjASElcpCfCNYjX++Gqe2BRkxL7zu4B3V166ggab1EJJ4727?=
 =?us-ascii?Q?PBT3n4EJ+aGQBzgrcixUvl1t/+yfAE4ZzTH7tI/q7lrDCUDf0+lL7vslxzmU?=
 =?us-ascii?Q?LsIaqDJlrvq3/e8nZmIX7VfKW5AKqhJaf00m+N7aPiW+iTx5saAVg6icvjtc?=
 =?us-ascii?Q?gcFDTWiKcXs4pRksWBXwUVAhZ7TuNJtssPragBnHDTRyVV+8p6mr/OBvf1Im?=
 =?us-ascii?Q?mrEYp1UaCmpO1YjrzYzY3hKs+rYX/MM0JTdAHwLnnrPxzf6+68SjHw7wqL3e?=
 =?us-ascii?Q?myb//3LXIzlkyzmKdzOgMaV99QjtiQR8M7Bn?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gKpg6Dv3Hi1A84XE6jRinFT4KiVIevY5gELS8XCcinzPy3tJ161LQdZCqMqj?=
 =?us-ascii?Q?8yhCV1HIFkJoJTR2CKDT/rkBNPCM38I3YGmr5LXqSRWkNq4VQt3k2Pg0ffB6?=
 =?us-ascii?Q?44OAfu0GMW4K+vmJwZpT7knax2U65qYbwIuuuYRF9n29u2oucpJdGtFQKSSf?=
 =?us-ascii?Q?P2nTy9wVfaGvN6BmT2eGC/9Fw9zan86Y5JoO2yc1YuDLItJ0GgGEM+dqMCzd?=
 =?us-ascii?Q?DkAEPxY46TQO3wWVU7I7MK9j8WGG5Kjm4pE/FhfiHDu6mpI7zRTMJyXSstFX?=
 =?us-ascii?Q?acM4qQB4BJOsRGpsK89d3Mww9TxFN2+nKARiVqR3gCp17rRcwSauLH1rVCQ+?=
 =?us-ascii?Q?pJ6DcnyVtSfEZps2+nxi2Rv0DpGNe/FkJV4FlVItrCOzJ/VCGs+2qLhjbYiV?=
 =?us-ascii?Q?zMmcNbrgVM95vHyMtt0wBA2cER6TB+o5j1S8FpFInNw4yhJiF2Xk6A58R7wa?=
 =?us-ascii?Q?JRYnhspxEf0Kb5700LHxxErkuvFxn10FNurvJavfwYM3NNA2HKa1sBmBWD3M?=
 =?us-ascii?Q?TYEdQqWtrZmELt1lxeJn+lDRhbCO52rxN+2v7V/qGo7BxmSRbHa6PD+jpMzl?=
 =?us-ascii?Q?vwQyQGSHq6zQ04hzeMAzu2V5i29I7zT1pNlKpAZQWGktzLJBU8b+yI5Zzvyf?=
 =?us-ascii?Q?VQEg/iA9S2c7d/UJZX2KgSRT/CzvlTTQbqNA51dB2Zy6PfgI1kng+/2zJubi?=
 =?us-ascii?Q?TAxJ0VSxX2gW4B++/jtNp/VwdleS6+502LvSkXyaOm6bttadMIpBU2nCBDnB?=
 =?us-ascii?Q?cs6vAVpiggrpFR8wAomSRGHON3oMCrkbQ4b3Rl7mqmU4MuSBJGOrjo8WoIuk?=
 =?us-ascii?Q?cdiApz2pxgF6CapE5Pv08NyzeGjbYj/IsIaakl1JFLUPwmdLQA2GNe5+fD87?=
 =?us-ascii?Q?A8yIhOvBTfTIfRno6FoKZsVxk9AH+t4b2r1WAMmcfrzhugovH87+6mykprS7?=
 =?us-ascii?Q?zD9YG/tVwOW7bJuSGKx6gL0cFh+TUEKKcAshtUzDGVWTH/UGP8cLkybNESj0?=
 =?us-ascii?Q?OsVAGHxLTnDFWMypbQ1mjX6X0sEuaWNL++BTDoGf3PArkFS/mlvWEaBATETu?=
 =?us-ascii?Q?kn52Gy7aT8m3rvz45Go1v+A1vBFnFU7/SAeNvrElbEiNOiRnCHlItgz/Ohcb?=
 =?us-ascii?Q?VojJxYOZKv2KbEsxljp4WRmShJkdYdyIIxq6ahT87OHr9jnMy55mDlkmyDxL?=
 =?us-ascii?Q?FX9i6PTco/zSfumfmf9xSDAR04OmQ39D8KQPiecLoLJ1x2/E2vttq9MtZHEm?=
 =?us-ascii?Q?jHJRcRsZ5BiYDvvABRcZz0mVz6wyXJgQST0BeAngRdw6W8XHvtaE8WOUVf4w?=
 =?us-ascii?Q?aME/vHlIilGGZ4hp4ZGpc6Oc+/7R8WKkj1J74Taevu0bzJwOPNZRl9nBv60n?=
 =?us-ascii?Q?34gxKbUo/YlpVXAsozn24tqFsJDxOwI8KMs0ekKqma7B0bPx5Bb0N95LqZ7x?=
 =?us-ascii?Q?BvXBAjMfwrY4gvLWXTYBJNSOwsyIECOjXiaW0NxoK90c0mdOK32tn01lx0kD?=
 =?us-ascii?Q?Yn0qf1XwcNne/s1VveNrEXPIhu1diU6GVeNJAmC9H48NUnV+hZ72+/CWHKrd?=
 =?us-ascii?Q?uL9DTxsJZHALa55An+fhKlYiDM6qCuIw34w2QllEVSsaPn560FBajnAZSXV9?=
 =?us-ascii?Q?iA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <413DDF0F6634B547A914EB1D1C465470@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2KNLwXXd3cWAEgLNoQtszJYGWoI3mv1/hyNgv2yg+zD/DyMN33e1V5o5Rj6p/93T2Os2aRPM+YIKlBdL1+LGSl0Kl5oBedbayMxOZPLM0n6IWUx+jr20loA+/6LSXkli0pf7OSj/fsMkcW9FoxZC3GzJRQ7WZ4bezdPJbQfRTDZpDqk529zCDhG3/qvpjGHHcVHFTwT6MR44fKkD3QCuJyCW3sGJSAJiTc1lK5fCGvf9v4J0+91p1q9FyTYnN6VZr4T91Daf773WiqvEtL4cScEkEVIN1NYOxjU0Tx/T5iLlu0eDawjn/J/df3NcDojo1yoVeovPNaHJx9zIH8vq5QL7Uf+XAL/YwYIq17z98CqF/r0ofVI+LO1JxsEq4UuPUtfgfUVB/G45ONVEHtBc/q66/QulYpttsoz3QsdCRj2LpRZ2PVLE7f+EylGJdNfB0pXhFeSbPb6bLGe1sevjYOHwO8F4SS4qUBCETlX9oDucoGNReFCGEm6ozFibb6vh6NKOi4u8Q0+Cmq54Y6+M7XJ4sWJuGYHel5Q7ia/HLsMXT0DntB1rjVBSMUNVXczQeeOt8T2v5OcCZE1Bfwnu+AmidclG5XqhY2rOfoMxtiAT+QbowdqshsZE1p4z26Q+
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03e7a61-cca5-436a-bc5a-08de0593468b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 11:18:43.4462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c+vJqfCWkQ2yDBQMLr88l4f8CLM86Rv63i72dPg5befZHRGzMIpBRcQSUuH0ht3YTOwWKFSSnPY3tvZsOfYlc80zwVuPfenUe+liE47vWPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8608

On Oct 07, 2025 / 08:51, John Garry wrote:
> On 28/09/2025 09:15, Shin'ichiro Kawasaki wrote:
> > When a test case has test_device(), blktests prints the name of the tes=
t
> > target device provided to test_device(). The commit 653ace845911
> > ("check, new: introduce test_device_array()") introduced the support fo=
r
> > test_device_array() which runs the test for multiple devices. However,
> > when the test case has test_device_array(), blktests does not print the
> > names of the test target devices.
> >=20
> > Modify the check script to print the test target device names. For that
> > purpose, factor out two _output_status() calls into a new helper
> > function _output_test_name(). In that function, print TEST_DEV_ARRAY
> > elements which are provided to test_dev_array() as the test target.
> >=20
> > After this commit, md/003 run will look like as follows:
> >=20
> >   md/003 =3D> nvme1n1 nvme2n1 nvme3n1 nvme4n1 (test md atomic writes fo=
r NVMe drives) [passed]
> >     runtime  18.678s  ...  18.446s
> >=20
> > Signed-off-by: Shin'ichiro Kawasaki<shinichiro.kawasaki@wdc.com>
>=20
> Tested-by: John Garry <john.g.garry@oracle.com>

John, thank you for testing. I applied the patch.=
