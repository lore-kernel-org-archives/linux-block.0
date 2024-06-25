Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3CE146A69
	for <linux-block@vger.kernel.org>; Tue, 25 Jun 2024 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719301815; cv=fail; b=qq9zUJvu7QcwokAoK5YiWmzA31TmgL2wqjcdT/Q0wl1FI1fFKODQfc0FCK6Qn/KSN9xyq3NbmSbm0LGT/OD/YfbTW6s3LPKY4v3R4LLyI0p4/rikE8dxU3xlPymtG4pZRXaWVF+bDIS64eblymqYyjm6NRVQyM52WmkcS8fvCEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719301815; c=relaxed/simple;
	bh=4u2Li7oz/ofL/nAFuUmJ23DgXOUsGeoP+/AtZvCa8/U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PikZvk7lQkhD7JWGR3vvshmMEZeham46vFOZyMtHARPPCyqz9de0VrFng0Ne9qhgmbpA+8fVaRRYdmX7N6iihRfYwJW8kM+NU1zcDPgjrE4mDZepT5KiG7VgFX47M++AfiLUY0wfk8rPyVXtmz8wjKRMykDIiuZhL8ooSWPEID8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ElsULdu0; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Ajbutwx2; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ElsULdu0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ajbutwx2"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1719301813; x=1750837813;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4u2Li7oz/ofL/nAFuUmJ23DgXOUsGeoP+/AtZvCa8/U=;
  b=ElsULdu0neyBgPeWcElq8/eI56NcG+JmnIPIl8+Q4VnaEaLTo4LyFqTc
   oEW/pdgW9bUm/hUgmVyAPfD+1teI990BZfSKys8tSruKh+weIo0o7r5Mw
   4M00bQFFzBWXhmtMCpBrTuktfQrlDB85mowEvr6MmqJeJF5kdgz734j6N
   ae3gwWVrhwnBLZdNUCIk++jGveVQ8xkw/c7Ignojhh1kuuib/Qkf5juBi
   PS50CYgf1W45AN+gu4FtB4bDsoJWp8B6MpKCSe/geaKpRWutyh5y5OCIM
   UeWK2Gco6rCX6a2N8DqsEVFB7brXbBYnHfLRRBo53gYIP/XcRWUg7wEZQ
   g==;
X-CSE-ConnectionGUID: oiN8wITbSVShlpk5t+38pA==
X-CSE-MsgGUID: t3BVOcgiRW2+YGoDJjSdtA==
X-IronPort-AV: E=Sophos;i="6.08,263,1712592000"; 
   d="scan'208";a="19937764"
Received: from mail-dm6nam04lp2041.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.41])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2024 15:50:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myr2vOQyw0NVrQL1+tjJsIBoMRaYL898RGanefH6tubTIt1WOdCsTq89mdVhXuVw5SCCj61zh9mSoFCJyjuScW0miZ9Uc9u4ClJAR8SWmyqsJ6Svq32K5D23/51YTsktjRj49wrWRrBFJ+AsOizdnE7enLcKubR5Ix/pLXTy80A/uRMCML2H/TZ9iQp0MaS+Zo1hsesj/pVbvj4Spvvdp5ekUden4+NTWiD0TFxkMnVl8eGYrj3RJOKCkrvXQ4821EbgLsCsjtQdDZrbhrOGCUqTxluIn4E1ubbOL4kf8TpXAx9urprEUXiZAEPqQa7vqnq9X1/izrq0mGrM+RIK1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7O9Uf0OUYEgXcRyzgrTF6gqYdJutUzB4pa5NlijqWw=;
 b=oEZv8DRIXLixfq+pXS/Q3MWfrW57nx9Sox/Tz74Y7yzhHHM6kcAEMTDSVNXmHPvzb9L7lfIuOUXKs5r4JujvVvSZhxMk7pUlfKbIU40wmW8sNnPDxILWHngFXmLyQ/sMUq8VQVh88vtHdKkFnBptevuhLyAXhuckjDD21i/Iz7a7imuCRYMwnvGSUGQAS5JD4iIcZpeaxHhW3OpCmX9aMdCqHW355vGbIzHfclmOuT+WEz9pfWu7o2G8sJCi+9b94/P/tfur31E3FUpDFPmrF6+M3dcC+2I7GDOUY5SBWdOv3DHA27FzNZ6Qh/4OtLhjeZnGYXIDeqrnAAPJOAOiQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7O9Uf0OUYEgXcRyzgrTF6gqYdJutUzB4pa5NlijqWw=;
 b=Ajbutwx21iv30NR4jXofY+koDjfS9pSWzO8cwJGGBwXo98cwvVurpCDWGs2kWbBG56U8ZWImVG91Htv20XoJWWt5WonmWZwc0nHNqA34VghUzN/JaOS9JIXR38ZszGcn7NmkkL3ceWkoANC1Qjzj5hnr2GEQcg8tt1ve8rai/MQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN6PR04MB9502.namprd04.prod.outlook.com (2603:10b6:208:4f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 07:50:10 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 07:50:09 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Gulam Mohamed <gulam.mohamed@oracle.com>
Subject: Re: [PATCH blktests] loop/010: do not assume /dev/loop0
Thread-Topic: [PATCH blktests] loop/010: do not assume /dev/loop0
Thread-Index: AQHawv5xoaaqr+UJgUa8S/dIdWRS6LHYIp2A
Date: Tue, 25 Jun 2024 07:50:09 +0000
Message-ID: <brmrintay5wf76whpyv3yvde7rtoi3ybndzuwswj5g4ah2dsia@3zexhvd37vkc>
References: <20240620104141.357143-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240620104141.357143-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MN6PR04MB9502:EE_
x-ms-office365-filtering-correlation-id: 8f2c518b-86a7-4015-6a98-08dc94eb7021
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IA/YZw4EuQrn/12xOGsUprWOOtNrzTHaYm6xtKvm25ysM5W5KdtvEbMqS2hL?=
 =?us-ascii?Q?CYpw+7CPG/YbzgbdKiZjUayA7/IR06xxX5mJ9Op/zt0fkswSC4QTt+Ofqebq?=
 =?us-ascii?Q?LvVngydba5I0Ry/T7Nr7i0Ay4OfVkPCgqWHqgpopf9PoWopOM2m4VLs5yQQU?=
 =?us-ascii?Q?6iAlEOsE6WWFvepoB46Uo+hl7z94dcofgvKbyHeMwb0sW2bsRlbwU0o/lSOa?=
 =?us-ascii?Q?X17Vf2Xwrw8jl2+gJIYEMbYqMeU+Vjo4bubAae8ubkKbGKE1lGgK3ex4PxUf?=
 =?us-ascii?Q?I7mVT/7Z5evcks+/18GO2NzthdPmiCWWs6NUP2CAXy+K9/kWRdu8IJGh/yeQ?=
 =?us-ascii?Q?FIUlywV/mpXfICQxz5yClr+6G2mJfQGKnkU6TJQkm4VBC8LDoTDarOTWGdhT?=
 =?us-ascii?Q?1Ky+ez+tBVEqhKBfjquR6DuiHGCQMJrC3rejmhJi/kfg8cwqJtSds01Dg5IU?=
 =?us-ascii?Q?9baxSlegt6IyoThJkJp5wfaIrJLwbqrHq2D5qImsDxYMpf8W0kA7jO+Vpaea?=
 =?us-ascii?Q?z51eIAOWvarOLuYzX4gQfSTaBPt3e5TRDSaZkPRBM8UQsPOPbWQn7+53Pxam?=
 =?us-ascii?Q?ULUEUydswBR9bXXXDwnuFGwT0Nv9nu87ao2jZo2tx4Of2Cf7A0K9L47NgwCu?=
 =?us-ascii?Q?+ScXHkDXoY0zpOOc6eGBcdikJpJQMH5+lDUeiDrC8cbl9QA/Y6GzIdqs1v8s?=
 =?us-ascii?Q?nGcOZpT8xYSJIBJf6R8aC0MSoYAM6wK1byxym5dNfImVHpx3N4nbLhskVMV2?=
 =?us-ascii?Q?9UXvBlET0oZXq3BZd32ZYu0lrWkrkRRUZnAbhuY7KVCXgYmW3JsBA751corn?=
 =?us-ascii?Q?4blUKgq7n6ut+OGMJMGWqCvJzt36H9LaU3dCKrBbV5woiTRTtAgjNx4ftrf3?=
 =?us-ascii?Q?1kPw7tZJjw7Tdsoq4qKAhZzZ+KvjkerF7qRjGYbQR+eGWk0dmh1g18wLsOyt?=
 =?us-ascii?Q?5wWq6bIAwqIAqYJ7MZvHtQFK87yvvnpr5vMleLyKBq2GWORqXQmB/K/aH4L3?=
 =?us-ascii?Q?FZiolK+HE3PtjriDpbBW6KOoHp/t9RynmZz5ouh4qURcp0KR+KSI1MRq0Sf4?=
 =?us-ascii?Q?ZepT6ZEmU61Oveh0+V77ejyZfiSJqCDPR9q1+8T+cMSuiIgoX05zIPvoOoRQ?=
 =?us-ascii?Q?v/6iHhHz4fsq9A/+Y6gVrEUWION9L7auXSb0QwH83COuHkab36oIKBtxKKGZ?=
 =?us-ascii?Q?jolCsvA9+YoPrjNJ1IkKd92TNYIkPIdSxur56g8ySmJF9Bdwl4sNj42aqBhZ?=
 =?us-ascii?Q?W5iz/GVvLBbgbX+xSNiTc90zYGnEjJEk6TtFn2AW758/SA/5c80PLyj0pziX?=
 =?us-ascii?Q?NDn3lI31IJBds0Py+76xkmU59nJ5wwnDsaMNInuiyDGFH/ThD2GXYmXzZMjl?=
 =?us-ascii?Q?DJI03cU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ifDhLV3o3ZnQQgiuq0G39mFgO1wZBMO2fUekFOw9QDS9Qm+KLkCY4PkuOmmL?=
 =?us-ascii?Q?NUkYGctMqdIAYT18YlvuLFVZ+4imMyfWXDuP7fVgrLQ4OF9ZGYYwYQt28y+A?=
 =?us-ascii?Q?8kAOd6TLQLSZf26yVmY8IApZJcV1KFXQBPse7MkjqiapjfBuSki4CLkkRU/W?=
 =?us-ascii?Q?XDWrvkgRxKo+ixtcfH0FwN0f3INZpKxR/zbTdRxTg8uRkB08/SZsMJ22ZuBv?=
 =?us-ascii?Q?vy0VpKDNWcPbkcTRrshgVYKeEpJau7Ov9/eZKc0BtVnf/1Y/GTq9hQCDdOfQ?=
 =?us-ascii?Q?c/BO5IufQsPSPQtP/O99yKTpY6j+SzTAPcPqf0jQR3LjJrPYjmdRWiR2TRAA?=
 =?us-ascii?Q?tuWr28sfcykWiWI/30+Skzmpzs5KCMA/i1GeiqEm5Pfnoku6tdm2j3HHndC1?=
 =?us-ascii?Q?bnRKs30hRjj1EaHSm/T8sp8ZL8glXpnXyKA6gzj4oI656GQ64EH4Kq6G1RMa?=
 =?us-ascii?Q?Y5sj7wTKlKDDfMFgL/FamXSJ3ZO3vvjTL83LP6aWG1asa8U3lKSo8F9A0U+H?=
 =?us-ascii?Q?hXkdEmU3mXj70J2oFx9HRg1sRWpOSiZXYtmoPx+K8wejzOeL0FGw+bHJDcjU?=
 =?us-ascii?Q?5VM5Xg4eBXYeKAgXAOLNERPznWJJdYEXudLnO3jfuoky4fXozpB7d1Dufx3K?=
 =?us-ascii?Q?ebRrOpD3mMJb5cLmGPmtIkkyqpujU/kvcI5+CcX8a226rdFoGnWzyaANCn/P?=
 =?us-ascii?Q?bZYPwPpT5OF0YPpLxzG1Wy22UVbBIz/e2ZQybPHdfln2eCKeaRnHmnStnnVm?=
 =?us-ascii?Q?xbJkPGkTCqjCRQpdWry88uQ4TyLiYwI9PWKWlJG7ncvS2pbiUpxXJxSfh1/o?=
 =?us-ascii?Q?kDnkGv5jQGqIIsX3jOu+ZTHmyrDDRO0gU7eetsS8KAcvrfiYIjQhvQCGS4Eo?=
 =?us-ascii?Q?hcUeBuJVfSJso/AK14prFa0DvCoFEovdfMgbNM9hqfTqiK86Q5/YilxZfVpy?=
 =?us-ascii?Q?VxSb/i9KM7jyz8WKR8BS10/oJ643/A2d+ta7ZFW4Llee00oaT6GA+kXdWUje?=
 =?us-ascii?Q?i0fdoj6zrdGo+vnSpeY2f0RaAamnM79TAE7cfrwkwC+bEuV2dIQFbLmdcmbq?=
 =?us-ascii?Q?iNEmCqiaKTuGbBktjoAZ5l4JUa8fwBpOtzrWwjSteZWPH4exupo6A0Qgm8nk?=
 =?us-ascii?Q?u3KjFswm9WmqaOjyNlZBhKCiTGG8b8gX4Hbj0sOOJonTseSCO8oDH8Kdz0N+?=
 =?us-ascii?Q?Z8a0n7z95uegQYtFqur7YEInHvwenbL/VLdbBZEriSVHkp6BhKOY0BOBLjTX?=
 =?us-ascii?Q?iX3o2zHnfDiY7f1Qkk3aW1Ok3uZ8bBBOV2elHBMCw+ZC24WrHFNLjKBXxQqh?=
 =?us-ascii?Q?zcxNMhFMXGq9vwwm3DsulF+P8K5WviOFLrRCBvY1Ll6V7lqiARIIsrzxmwZH?=
 =?us-ascii?Q?GkxmslrcEeQfQSpOJOjej365GOtT9EhBt7K9AAPR8WzodIHp1YGYLpYL2Fjh?=
 =?us-ascii?Q?tUs37vXUuf+qzHISguWKTFher5LshFD6+JsfoSFO2aBPtGiop9KdW9u5vyW+?=
 =?us-ascii?Q?f97kfalVeS/oNp1bjOYIuh2ih57NDQxj65G7ltv5Wt1HsoVcAjcLwaIFJ/Ac?=
 =?us-ascii?Q?VOMEOfMPCbeLCck1EdInJn+9AXBpyJuTrqyyQDDXRun4cvHIbM0sgNXKo6Ct?=
 =?us-ascii?Q?2P3MCUZpRlQAGq3kdA+V+sk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <54C06514630DA845BDB0C8B5AF853BD2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r9zYJ3ztppaBAWAunbmms0xAz3eSM8NbMYIYZww2WBbg3yeayBRvc/F9VudRABTCHTfpCr0VTZGF7foAot7hmxie7+j9DY0Ls/4df0sVhqNgqvgRieIawaIspy+5Ss0ywwFeRpXdkD9F3hAGtc0P+3KZFmDr+YrwaLFZrGKLambLipmxi2sx+WGLRZnZxzaJYaneLlvd0krxFSsdfrSp0q/Xkr+JMnApMrWNiFQ6wHjYSoVH342ZlJdYW3UoplcNyy9IOVCCAfDfY1VWSIu4+tsISpIQoVBf6qH4GzoNY9Agl2/o5q3i5nWPiLMUVBspHGvRhHsZTCoLjn1lOTowDtikQejIqjK+cC9SVgTzXaS5W3BDZxaEwggAJdV7bLHx/IdkuLcsAkE495elWl1A1UQv2rIBv1vSGo9LuHRL8vstttadllKOkjwl+taAfhIfeHHCtf/itkL6HuOOjpIVm55HKe2D90mujHL50Hp3eeZ/G6l4/Pa7nRFIWTVrERzTOm1uUdS4d6/fAS5xSuwkg3E+d+zR1Z6vrCqXdrIB0obcoV3UWZouLJXqKJr6SROLWYOzeA0iayA7XfOa3/15t0S9eot3isZa83mnTm8p3THN50c1dsKi3f3Eb5UObcCL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2c518b-86a7-4015-6a98-08dc94eb7021
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 07:50:09.8802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3jIGP1G6+0sBU6nj//GIQerIXhZ6uDIneHq8ad7S8NCVSoyDUJ6FefZOSlwXVQWUilNpj8lkU8S5o9LCBcUYEkbGt3xRRy7KMlZfnkf9lJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9502

On Jun 20, 2024 / 19:41, Shin'ichiro Kawasaki wrote:
> The current implementation of the test case loop/010 assumes that the
> prepared loop device is /dev/loop0, which is not always true. When other
> loop devices are set up before the test case run, the assumption is
> wrong and the test case fails.
>=20
> To avoid the failure, use the prepared loop device name stored in
> $loop_device instead of /dev/loop0. Adjust the grep string to meet the
> device name. Also use "losetup --detach" instead of
> "losetup --detach-all" to not detach the loop devices which existed
> before the test case runs.
>=20
> Fixes: 1c4ae4fed9b4 ("loop: Detect a race condition between loop detach a=
nd open")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  tests/loop/010 | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
>=20
> diff --git a/tests/loop/010 b/tests/loop/010
> index ea396ec..f8c6f2c 100755
> --- a/tests/loop/010
> +++ b/tests/loop/010
> @@ -16,18 +16,26 @@ requires() {
>  }
> =20
>  create_loop() {
> +	local dev
> +
>  	while true
>  	do
> -		loop_device=3D"$(losetup --partscan --find --show "${image_file}")"
> -		blkid /dev/loop0p1 >& /dev/null
> +		dev=3D"$(losetup --partscan --find --show "${image_file}")"
> +		if [[ $dev !=3D "$1" ]]; then
> +			echo "Unepxected loop device set up: $dev"
> +			return
> +		fi
> +		blkid "$dev" >& /dev/null

To correspond to "/dev/loop0p1", the "$dev" above should be "$dev"p1.
I forgot to add "p1" and this missing p1 looks slightly lowers the failure
detection ratio. Will fix it in v2.=
