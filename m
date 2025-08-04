Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B751E9B22
	for <linux-block@vger.kernel.org>; Mon,  4 Aug 2025 08:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754296650; cv=fail; b=o2xuiMCZyRTUz7/RPSY2P6n/mdYRgW2zo1iagepfPkCfhlrTvMLIUXpS+2JrExL6A1i3n7FHs01RPwiJwk+dcWtpwK+rI4GWbFrvKLRMCQOZCXbTYMtdh+Zy1KNmyU/kW8b/qROBqVY/bSXjaA6MmiNeE2ykot+/xRGQBU6Ms90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754296650; c=relaxed/simple;
	bh=8KDaduMc0SBw5U9f+QoUUnJobHqn4gh/dcaQGOKn8TM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GvobZOsNCjRmREpp1pkj2x1bY7gcAbKvHkfsxJvy+8wYHhv0DNv56mDibjbUirJFu0wyFQ215R3i0uv72W3CtZkwvrAT/i1LTyqeiCwaWA3KIY48WIP6zwp/rlN0fWpvupK4Xre38W3xmDlmRrm48f5T9gTxtJvQ3wMPGb9LGms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=DiQdySr+; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Ary4AGQ6; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DiQdySr+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ary4AGQ6"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1754296649; x=1785832649;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8KDaduMc0SBw5U9f+QoUUnJobHqn4gh/dcaQGOKn8TM=;
  b=DiQdySr+2Vj8jGMq2YGYzABym4y6z97G7aIRffloMFLoblBVUFNor/6h
   Xaq+HrpLXZaTHAGgn6dkHz8fUufa7hoxfPEgJtkTBzPpwcfpeelGyfzih
   XH3v0+usCw53T4I8do3S6IPggKyUu9H9TSLIZtjUH1kf9SJPPYJ9/Eg6h
   fnq+gYMELNuj4GyguPtQjCVBQozFcKOwm5GjFclv113SxmPZS26BZ94RP
   LLa75h/JcviBAyTyvOssf+W2MaUkkY9tUe7E20hvVeyrGyMW7BeJOsg17
   Ii8V1NHiwMs14DT3kDc+j8ZmG2sdCE52HXSECbkXerSmdZWJZrRn5obKo
   Q==;
X-CSE-ConnectionGUID: s1JnJR+WRUGZ8KjIstqsjg==
X-CSE-MsgGUID: ny6D13gnRKqo4KC2PrwgvA==
X-IronPort-AV: E=Sophos;i="6.17,258,1747670400"; 
   d="scan'208";a="105197127"
Received: from mail-mw2nam12on2074.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([40.107.244.74])
  by ob1.hgst.iphmx.com with ESMTP; 04 Aug 2025 16:37:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvX5rKv3UEbXJFgrjRvu0Cw1JiXQmELytvvOg+0uDtWe9Xo4qeJcXxM1NsCDcN+rHhWtK4FQi+extC/tKvWLxx1uMynZkhNq5e2eFPKAn61SwdLvKOzLK8LOX8lOLYosLGP5SAcJ2WIGqm9U7e3t2pFn0gKFvx7UWnMfLH+Z+roTT6QvgbNNCH7a6kR9V7Xslnh5ip+QhmMS8w0ur2gZFlZymTE8ApfOt3fojyF5WuH824/DPhIr+kHWNlaUwGAAi1XKNhji52HCsSzLz+XAxT8TzNhe97AT3bQSpuV4Mo/2BD4RdiLaDPy+fTzvZ3Oer9c3nSTPPz8CYWIjVx4/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KDaduMc0SBw5U9f+QoUUnJobHqn4gh/dcaQGOKn8TM=;
 b=sZo/Meu3VcIT0+wqOLfjrE/g/WDaP11RYDFSh+ggS9XLU6Lyh72HJ3n9P1IIVm6/dkNSXa13JMnRZ0upLq+WcSdHkfmfkbvbtVV2Us7mHLoGLmv+mXiO3SycEyOFTU3K65//QLYOGAUFxnylEWL+0uTaE1w5ON1+6F1yW/P8HrOGUMnZv+qIPiSXInyVrBNiQFbFFnNFt9A9fWlrg/j7/7Fgr/4YfBsLxJY8H7tPbEb1EZ9j7pRSGiCHjcPZl4iz8OEVYhAXqe//lcDHDygvASE4djWJ0GZsP61AmbAAmxZjXN48WlKCW4+P5HH9yfj0LbpwGAPQFeVY3deFVHCEFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KDaduMc0SBw5U9f+QoUUnJobHqn4gh/dcaQGOKn8TM=;
 b=Ary4AGQ6U6Aka6kzHirE7aUzKBoh50EvMwa40ujOq0KNVueOBG1nu1RrL3ivG/KocaonJQp7RjN4wrNApKBOFlfMtNiYz+91mvOQIbHpGnf/ItYjnDCy5w7xX8aosVM3T1GWVz+YDNKj+osqvyMEmYpCrp8wnfv0xfNCV4b8uZA=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CO1PR04MB8249.namprd04.prod.outlook.com (2603:10b6:303:160::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 08:37:21 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%6]) with mapi id 15.20.8989.017; Mon, 4 Aug 2025
 08:37:21 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH blktests] zbd/005: remove offset option of blkzone reset
 command
Thread-Topic: [PATCH blktests] zbd/005: remove offset option of blkzone reset
 command
Thread-Index: AQHb/TtjzwmtX5FygkqszxtkOoGoZLRSO4GA
Date: Mon, 4 Aug 2025 08:37:19 +0000
Message-ID: <hd2otiuwobiaseeui4jytwm4mlc3f7nzb6vtdogcjpyyfbz7i5@kxljskxaqffz>
References: <20250725080856.232478-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250725080856.232478-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CO1PR04MB8249:EE_
x-ms-office365-filtering-correlation-id: 22b4f222-63f6-4b4d-cedb-08ddd33220ed
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|38070700018|27256017;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hkuKZxlJzcp0CoyFYMtrXNW/WRo8GqfbZCpq1Zh6rdMuDWvfinTi0NX6deiS?=
 =?us-ascii?Q?VaqwZAjg5cT/i1SZ46IgEcdvlO3DZcnyukBYt1hASBVC6aQ31hTs/ZiyinHu?=
 =?us-ascii?Q?SogVN5RgWEghQCPMk/zhTFhixkqzfHMxzMdE8rcvcN2PCa6aMmW9q/XxdKAD?=
 =?us-ascii?Q?w5jIDHlAhNXsg6VRccPjyeStpACcwCNv+UwctZ1yNxeJjzsrKJOy1fe6wF4b?=
 =?us-ascii?Q?vFAoOr1eZ0xFQoVE/nVAEW9LZpjNMgo2Zf/N9kcNgeKQQfc81xei+cMn+Tde?=
 =?us-ascii?Q?qJl5ZvUczW8eMkvYKjG7CURI0G8qjfocEee/v5Hne8QxJrYjPBzYvMZSCFQX?=
 =?us-ascii?Q?A2HKiRSt+z3EfX1gEI66+UQNlA8iVPZ6Cb4ssNXDT6jvKN8aLTTNW8fo0Gdx?=
 =?us-ascii?Q?TPBdSJHcozaf+nThs/lYzc63ZEmbn7BhqxCFH0eTNFQvtQ0wXe7oIjBbydMz?=
 =?us-ascii?Q?8ocR2saIOiSt1LB6KVp+dskmmxOUaGHHo/6CFjHUrtHm7onk4B4sUuxW1akY?=
 =?us-ascii?Q?MAlA2y/0whV9zELChc2+obq2s9rBiSUKh4wvJ4UE1kUjt0CB9iADc2kr35Tg?=
 =?us-ascii?Q?YQMv+4LdgO/QeUo9OAPyEH/GCCZVxCFx7UJnvqKWcYkyHCHnYLfOZj6y6SjH?=
 =?us-ascii?Q?Uj6SL8BmQoyAM/zquoi2wzuBvwN2SryGIsLaX+jLIW9nhqoPRqZzdeJRx9oj?=
 =?us-ascii?Q?9RlIgmpnRrJ0Ngym7fNaoROi5RtbXp6/YvYQaZTp/Htypj2b69nd+3sVleTJ?=
 =?us-ascii?Q?L2yvMuytsiqfs7QhKKGyhmezjxLs5rr8QPUPHYwlTblaDPhOOulDoB74axkH?=
 =?us-ascii?Q?SigDaNwYryB8uG4qWux9l051WzmVxMFIbwgVEWrsLL4ZDrvReZf0G2zEVcdK?=
 =?us-ascii?Q?TsPcOe0EPvFx2FRGQlIolJ7NPun5FPTVmuF3LogK1DhWEnmuJEMW495PucH6?=
 =?us-ascii?Q?m9/fIY6E4QoZugnsvhKFDdeVkAbrLJlp/koyaDLItm1MIKrpYBJEoKysygr0?=
 =?us-ascii?Q?AcFIqQnfd4lkhQm/nv3JUcshRU2edNgxBX0zYgPPjs4qqWNrkqAF1WgL6TT9?=
 =?us-ascii?Q?n3/te7q3R6FKqmmYRW1JHigU7Bbvrp1C3sjgDro5FAMn2V878+ykCX3rmVTw?=
 =?us-ascii?Q?U4DGPGhlxjccPbEZA+f0z9YKiV3/ZDXaRZ6RG+slMMvHo1FDb05yuQxeAd85?=
 =?us-ascii?Q?YdZgGOX7+LJ3HoLM2lPmQEV9pw7ICrcFYZ06r6CUqOuzWKrnshkiJIKKMdp/?=
 =?us-ascii?Q?NGHmAOD3zSapxbctN3/hw6Qrl6ecF3bC9QVPmiMdbGYZNuArq54HVnl7mAHh?=
 =?us-ascii?Q?f8DvQuomcft+pa25awMhFaO1g30KNl17jJj5u5K2ATBGuZQ4zFqHIiRSyxLB?=
 =?us-ascii?Q?VEiuRReERv54tjtCL4EZhd2twypjBfD3//gKRFRZok+Uog793iQJ+2jbMFwZ?=
 =?us-ascii?Q?z/ljV1hrvAkpV72eZyJZ721TXtTsyFUCxHIDJr4RDSNoo4N4Vfc9lQGPKt2G?=
 =?us-ascii?Q?pBbNi0xf/mUulpvMupfzPLdEgrBLrGbtCmjh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700018)(27256017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mySxBxmpD+P4zZlXgUgAsuFooh3x+l64p7L1bLGPt5/xgZkiPYhs68Q2ut+o?=
 =?us-ascii?Q?6xCptYYP1wHnSEaDsK3G1LN8konU781AFXkAwp8MEpej3q/02CmAcv07JCb7?=
 =?us-ascii?Q?qiS5/uhWZ5nDXxasZ2USpeRO6LIPhY67xLiWRgT/NW8fVD9znW/Z8H7CFbhL?=
 =?us-ascii?Q?maY0eMRSmQLLJFFBGb0OCaNMVg2LHS8nLsWjqucI1m4cYXI5ED1QBsa6uv/1?=
 =?us-ascii?Q?z0MUcFKL++gOWbhhSfaDBYGaSpd+tvia9+b+x7qmJ8tCW/WkmPazVT9fbch9?=
 =?us-ascii?Q?7nYZIkLm+62u4YbQxIh5ALuRVi/GW03pVCKHU2H2vIAQSkmQs5BGGGLDm2cS?=
 =?us-ascii?Q?cYBhnh6GiXuTuM/GsxVhyzMd1N8AvSr4iDp1AzhPOijJPrhfbg/KrYT8nvx4?=
 =?us-ascii?Q?UPVIHT6ONZ0UXHCwGypcvW0XeH1Z0DqFXVOnVHF0rzpNqLESoaL9QuWlMXmI?=
 =?us-ascii?Q?2VA2KpRXs6oxF4mqPP33PELD/RnLtPwAszYxHy3ySa41eKm2/TmHnAu/N0Hv?=
 =?us-ascii?Q?xRwFkgPg1dZN7HfWrhHHiiLUO7HzGL2kOOVDOPZhzMkLvwdbnA9l4IgCpf0B?=
 =?us-ascii?Q?WKUYn2I4T4/3L3lECOLTKoXv0EkyG40ZpolMNm0MrppLyP77sdiAvTYYWsZY?=
 =?us-ascii?Q?4P2GTLeDpAfsi3cgDos96Kc1iBmgoUdfDyx0SDDR7lp0aGIZOyJnAkjr04CI?=
 =?us-ascii?Q?hN8EJFnkCNSlfBpIumsfSTiVibRYHUK8zqClLyuxA1+QKHa3CJw7+5VyUj/k?=
 =?us-ascii?Q?p1gwjSOl90Tbx7BmtGIqL1GRGCl0Gj4v3kM6exQHoqtGeCxWbw3RuqSxr2rl?=
 =?us-ascii?Q?khH1R8QTQbeaeWLfhHL44Lz8m8+aFylWw81xeWrV4ljM8sJma6KFcv3fqJgw?=
 =?us-ascii?Q?sUHc5xyh7nQ6b78DICf0Me9FhK7RnkVFydox+G7janjBekV0lUYLQvD28xTY?=
 =?us-ascii?Q?Ke2oHvCKkJPlWoi1wMffBiDIqNz9tiHumUDXAfWn4BB/YJoKTVH1xUhvBw7L?=
 =?us-ascii?Q?2tOMiE/R+HNe/DaAu5Wh4H+dzb+6u/Z52oJEkBLY8cH4IhiuYGn26dksCwv1?=
 =?us-ascii?Q?Hg4L1daqbavhMfcviqZZFaa4a61Ft49x0Q2xWbVz9SYAFtIUsy0j7/3QwN+Y?=
 =?us-ascii?Q?TlqG/RMjYFMtdQDw/5kVx0zoyO6Gfk/mmOSZDTECW6n5PsSy+m4ui1HK+r1j?=
 =?us-ascii?Q?ESEHxae07iuPm1EPckmS08bKzMNRJZD9zZn4YrWM6z8gy7JX8IBcT6ckoOFa?=
 =?us-ascii?Q?I15cnjUMnCN36ggbAd1B+QX/rrOfiOiFqz/d9PM9Wj6XJN88dauiUFp75OJo?=
 =?us-ascii?Q?9T7gFJvQoL24bk8kNlphaAdDmYNmMMGNM+dxFwxexjLiZ2+t+Bsq5o4oZog7?=
 =?us-ascii?Q?Rn2f/D0LsrIDbFAFXZRfD9R9KJ30QTEjfFfbZKys0caYIxRIzzruF0GzY1N5?=
 =?us-ascii?Q?VMSrzUvLalBSvf4o5ho1c+C+E5Ctpd0StaQHtCZ6SM9pL11ZiW4nAKd3E1Lb?=
 =?us-ascii?Q?J2c282vAySNTtJuHIpLt99dhBUA/vRIPq8sNZ0EWUenXsPTmHAOvoWK1YJ04?=
 =?us-ascii?Q?Uy5OOaqu7kXIwcaYWQseesJAzJIi6uWp7v+bBLFWM6oU7rAI4+R7GgzUjdKJ?=
 =?us-ascii?Q?aw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CBE6C0FDFA55EF4182D7489531D1E5BA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Xktt5NyH8/F3q7kglD6fpBDiwmvHRVKr/6izKCMUf5gYIsOPrn3NT/Jlmvm+kEgImlxHj1Po4Cdldl1odHhr+sxHHShKHPdVYJ35qF0+Cw0zmCLgc7E8w67nMM2W866qFjubp+ai88RuKQpNxc+P1YdsR47defR0Io7PMixv7L0uwRapu/+AI6fFEM4rNgMjwfTTpq4t2g786WnUJx3J5lGVP0Sd2aiIWnMbLfeoCmeHubFPs6xeGlmfUU/w+jY0nqe8DY1orEMKVd7PnJGLaX6ZPJBruCBAdXWlg8wEv5KZ1LNSrKBwmY39JNSNfly+J0ARtyFDY5z2aDf8QPN0oRBp9DYogE5+EZ4IeDEUt1Y1LUhOUFu7dFw89lK1QkWp4UMuFzub63/p7YATRJfCj5bEG/lwg30yc8d2buUQ6UnHOnkqqgmBmq5WA0IAXP07K09DcYhgY1Juy0+Th3sf4JeIJ18+FypeKApciB922PRKHIZk+2EipEBfQjpOdr4XXUZyjcrVjgVPFA4QwQunwe3vfyucbJUQHTqbnXIF6QHEZXLGF9XNh6I5ykkJKxrcDSJcH0BT1+gxAr90v3eIR+z93wYN+1arr3R4gVBQUC7mObYFk7Wi0kZV9sSJudaa
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b4f222-63f6-4b4d-cedb-08ddd33220ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 08:37:21.0662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R+VLljgpHGFreZrsTkgebkBf7O70irZ9Z9GpuH7sMR0z3NYf2/pKxARtF1Z9iIUae7j214ZCEPo9j1sr5oiLg8BnNF7pUrO3EyY0nMJ5Iwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB8249

On Jul 25, 2025 / 17:08, Shin'ichiro Kawasaki wrote:
> The test case zbd/005 performs sequential writes to all sequential
> write required zone on the test target zoned block device. To prepare
> the device for this operation, the test invokes the blkzone reset
> command. However, it takes very long time to complete.
>=20
> The root cause of the long reset time is the offset option of the
> blkzone reset command. This option specifies the first sequential write
> required zone. When the offset options is provided, the kernel processes
> the reset operation zone by zone. As a result, a separated zone reset
> command is issued to each sequential write required zone, significantly
> increasing the overall time.
>=20
> To reduce the execution time of the blkzone reset command, remove the
> offset option. Without this option, the kernel can perform a single zone
> reset operation that resets all sequential write required zones.
>=20
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

FYI, I applied this patch.=
