Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC1419E7F7
	for <linux-block@vger.kernel.org>; Thu, 22 Jan 2026 04:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769054807; cv=fail; b=AEeFXt350YA3QZ9lPnCKPqqhdCHbtSqOlm0hzAySeRv0slijB2/4W94S7ZNvyNDT3gmGEOpwMH0IrOQX8z+T7SOXaD3pRUg2bMj2UMPGGYMvMgj/4KifvbJoQtTPUBZ52O6sIKVLV9CpjDXr0tLS7BEEqBnMzRs0yspxWovkURM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769054807; c=relaxed/simple;
	bh=d/QxA6i8Tj2HQ7UKPeyQJRofUxgwpV2rMZFjUeMWFDs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pHe7AEHLUTp6o95AQQ9fckIhK79cKYQUVXayjw31+7HfQiuhdnWjxkoT0JibQ3uakaFdz25tGCojBCfTSaSFAJxv6dhQ9yKxU41ouk7z1483lJxSIlmEFhoxpmuMUbgjsuW5bCyVRnP76vJJuUlnjAr4UKJZQmwDFh4TDVmuf8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qZ1GoxyQ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=TyA0aAzB; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qZ1GoxyQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TyA0aAzB"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769054805; x=1800590805;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=d/QxA6i8Tj2HQ7UKPeyQJRofUxgwpV2rMZFjUeMWFDs=;
  b=qZ1GoxyQisT6eHfIjAlzcPs2QryjWYOh1QMhURLYciagSOTmUtLs40Mp
   rRdNrZ2CboZLNk4YkpzT4WCR7RyobNedxRIU5MAcHQs14HM3c/xu5jFLQ
   /S9wXp5ZdUsJWm//3KQnehOXcftto5GQ9YizqiWfiy3aUgMcLgObGan5p
   KQhLO1882qk0R1MzEBBR2V7RouQUbFWrOA0lpD1C91gxi7G+HPMb/yF73
   LMoWB+ISDXk6Y3vmLI1dgImj7BRYTkGdFUWyLxsRnxzsQTXzDSIJICUc9
   qLA2z3q4A8M3+OA79ep4VaKIsareTgnP/040aUg3h95gE1BfHQHUH6rEl
   w==;
X-CSE-ConnectionGUID: J3ZIZX1mT3GWj1OWaN9ChA==
X-CSE-MsgGUID: UuQ35SZnS5iBjNctXSvFAg==
X-IronPort-AV: E=Sophos;i="6.21,245,1763395200"; 
   d="scan'208";a="138996308"
Received: from mail-westus3azon11011064.outbound.protection.outlook.com (HELO PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.64])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jan 2026 12:06:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WdhUVjp0vPY7+PGoR9s8EORTzD5sIucTX++PoA+YOfikQiK58LaGkvX+UjHGV29Ty4N6ZZXyRPoyUddMtLyPjpUK8k19zjGqdWdBJELZE6rKaekRERge+1Czw7pNiUyy2qkPxGbt3jH+/VkpQ0vFyuA57NsnfYIP5j27bIOxkOgNUlGxI5iEiAUlBoRyauSedVbxU+UF8k0nLrFJ/hmOEs7OIgcCnn2U5hrGLb/KrPI2ryE4Z4WdavNBbhNJCbjz54N+3NgswyQLJUVDx7n3D3KDaGVhEAmNmg6osfdaI/i1l7BKK0XISUnT3k1Mr4dzH5FzrJfbmMn5groTmMkz6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7E81sUg1RhDXeo6QJysgk+We0D/6+ZjQq15CeRN1nc=;
 b=DnRMoKIsyIalCGsCl3GaP/k84/14X96zoGCGYNPtQJ6gtsc493saMzt5zXuhafU+X+04SGSRxGni5mO/v9BG64KOENjnwFeo+8/q+DaiIeOvi+0ygDKsVtwGcMvGtU3yvzqR/d/5VGMDvBRMNUOEu6tsc036wxzEvtJalTipo551rEl+52xLJg7uNNISwUp+4GhVgSSmTNg4hlF+k7GNVXSbuLoJrL0RJKDOqa5VPzuayZS42knetyHRRY5cnsR66GAi5HD7xyEDORoL1rr8nNa1tvDFgANIjUVA8UObB329i4xVNpA/i7ffwnMUsnBVNlkhAmuFeSD0n3PlFApbzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7E81sUg1RhDXeo6QJysgk+We0D/6+ZjQq15CeRN1nc=;
 b=TyA0aAzB7N36PaHI5PTYFMPZnEVEhWHwm6M7s98MPTS92/5PKRzJPL9sHl8rXUFo2gLg3rzFnqJ+Npvh16HAett4pCsGP42gFW5wChTcUesaDPiizUZAyrR0HN+eio0XwcLmvAu6A64DnCV5lC0Ck4cTlTGgsPhrbhFmC3jKgYU=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by BY5PR04MB6277.namprd04.prod.outlook.com (2603:10b6:a03:1f0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.3; Thu, 22 Jan
 2026 04:06:39 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9564.001; Thu, 22 Jan 2026
 04:06:39 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"yi.zhang@redhat.com" <yi.zhang@redhat.com>, "gjoyce@ibm.com"
	<gjoyce@ibm.com>
Subject: Re: [PATCH blktests] check: add kmemleak support to blktests
Thread-Topic: [PATCH blktests] check: add kmemleak support to blktests
Thread-Index: AQHchHJGjk8hYXq38kWsXekLN35ixbVdoBqA
Date: Thu, 22 Jan 2026 04:06:38 +0000
Message-ID: <aXGgRFW68AnU0qlE@shinmob>
References: <20260113095134.1818646-1-nilay@linux.ibm.com>
In-Reply-To: <20260113095134.1818646-1-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|BY5PR04MB6277:EE_
x-ms-office365-filtering-correlation-id: 5c7fd584-fd08-4d4c-020b-08de596ba477
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RBY9UihEga6KtPf46r+AnrQDtdNk3w3ayVOm4URKnQeF1IqPjtV6Sy+tcXaL?=
 =?us-ascii?Q?bzp6Xj/XTTxA8b3AQf3t0mF4sqv5LNDN5N+EzNVWw5U63nS5uaA929re5wJY?=
 =?us-ascii?Q?QIa6CtgHKBhj3CSqykhjVoZOvBAK+iZRPGIlP0i2egmkz6pX0xalYNZD4eMa?=
 =?us-ascii?Q?uE+igaJs0eBwSzFyO6dC31WjwboJ0G0Ieu/6j/iMj0HNpBS3cbvwsbN8wBR0?=
 =?us-ascii?Q?nPqNCNxBmcHj2T6zQj32AmNWa5RWCq4u6YFuTJENOnG8NltJVQWCgEnHbFLf?=
 =?us-ascii?Q?cVdth5Bv0t3XtvM2WjMnuPcpGZavypCbJaK11cMFR5JhGHt4jSIG1t034pbt?=
 =?us-ascii?Q?xrwLgnuGqFZ2wfOOJNtsCvxqij3vLH952N/Brk7Uc11/7TDF0g5/gcYnzzBF?=
 =?us-ascii?Q?puzbItd8cCSauQ2J++lfN0HrTMP3Oza4KYvpMCUkzx3NJknMWr9+9t8ZfSVG?=
 =?us-ascii?Q?TJlaE3ISCZ2hZFFuxfFgsUaKY3KSsatDX/Rb/QZNYtXJupKpITv8piyf7OFy?=
 =?us-ascii?Q?b+1xViWEZy6ETmdgMzOq9xBWPl3AsYCu/8BhcAbbqTe1T0NE1W5pNorAwOmO?=
 =?us-ascii?Q?eT72RC0/McBZCL/hnECZHsbOu+UGvDfCh/qFJDLFJRorNNGvTmwdU14rWC8D?=
 =?us-ascii?Q?gi+lte4pRaY9krZgrQeWAekPe172h882nERqNSB27cSvd+oLF/NNMVz67Qc+?=
 =?us-ascii?Q?EWFeCRoTjeglEi3PXZcbfgCgkPIEbMLlBVhZT9oF3/UZo2IT+cTWQnkLwKsh?=
 =?us-ascii?Q?kLzyRswqf7tzT9IH6jczBKpcfEv+Iod2Iai7vTzz4DQDAbzxxrdWyCwfpSXr?=
 =?us-ascii?Q?LRHL/J+1JKUPOPpoH2KTntWiUBFe85q80jnrTqWMttjgyBj5QZ8BLN13jteC?=
 =?us-ascii?Q?v0x+kF+bkn6GZp7Ye6PQY1rfnIDqEqVxZQtBB6+4N3o50dPv5N98E70umab6?=
 =?us-ascii?Q?xfiP2Ho+KkTX/0rwWuSg49FTLBpksRVTbnI7ivvssxtyMYWkxO89kuIm5T/k?=
 =?us-ascii?Q?ei7Js8Jyp34NAzGUpOKZQPpfdaG5VRy9peHNmUooZ/qH8IGeRn4+WKuW4NTX?=
 =?us-ascii?Q?s9shTw4GsLQ6HQdcVLul6rY78qHEdBymIbsZ0zXhtiBqiAJ7CFI2mPE+zCZt?=
 =?us-ascii?Q?J+DsaM32YOJaT8DHf0olz7KDFfU5LeQ/4hFcAaAb5GLVZo5C6gqU30agqpO3?=
 =?us-ascii?Q?LxmRSxY5TKLEEN5sDmWIeTX/uAgJWz5cHrpJgX7PtBJdhfyP1Bo3McoMd8po?=
 =?us-ascii?Q?lUaLEA8gFaIjQIwfNOskSKxP+T7i2oh4OSiKAiT+ANFS8k+PBEPh9+bG0SQ2?=
 =?us-ascii?Q?svO6hgvIBbRh92Rnx+ens1u+fSlkwL4Ky59FESRYm/eBu0POjOr13XVy4K6e?=
 =?us-ascii?Q?dxUp7hbZhh385Zcx9lsTqgDPp1Vd1O9lGPpmXZvnM/YMIBP7fthjzGHmX8UX?=
 =?us-ascii?Q?69OWoHhkyHT75Y1CpEXAeLK1DDgsmPijmnWgSDFmgj5BppLxfawlMQnhtLBC?=
 =?us-ascii?Q?8YJ6MdwT1R+LxPT7rQeOEwlJpga06LcLaWHVaklyf/w5zLnaYtIeCTMoaoj/?=
 =?us-ascii?Q?55puqVNwQ2rmjSU2Jg8giiILFDxaLFU3k39Q5i6HR8gSfSEgc5qgPAPxhFbh?=
 =?us-ascii?Q?MTqRKKiNpVNr51vaHJbBezw85EViD8LkycgIDbjGfP72?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gUtS+Hy+ll2+/yXZ01QxToMeS1xPEE7+hhRGGpogge6HPqnRqd6gZomFsxqp?=
 =?us-ascii?Q?34EAKGBf/DT3wnIrd4edDb/ha4CwO1P0NiT7t4zhk6dJ8lO5CznvHeLCEe+V?=
 =?us-ascii?Q?zUU2Kw8It4mubwGh4V7h7CGfBkeemtgXGM8YMouWul9+rha3yV7FzJ75bH30?=
 =?us-ascii?Q?v1yZuuX9S9Eq1TpJ5QVnR1y/LCnrYSjQ2eBEMSu/cknOnKK9Y9VCubRpqGFd?=
 =?us-ascii?Q?Q7k8Gltwrn0XLyst7+TkKQppvtZ2zsBkcHCXXCHiwcyTcRQlHDdGAcUEpv4P?=
 =?us-ascii?Q?81cquAFB/SFCPGfoRkxgKzxDu5n4iobyeVD+4r8BLpNg6V5tuLJeHppl75G0?=
 =?us-ascii?Q?wij/paKn154OasL3fQvU1XraOr1jThp/9g7n0tLCzQKk4o86D888yWFpGSzv?=
 =?us-ascii?Q?8zB4fsaXmAirfFYfkfwEpem1nUJwcLd9d+YOtWdzvJH4GLEPfm40Ukt1l185?=
 =?us-ascii?Q?XvriWwDVwaDnCTVUYJ2PDdtL8wz0Ci8Zf91jiiZ6IffCMicI5O+vK1L2ixid?=
 =?us-ascii?Q?C+D2RY0t2YgpzXBrGrBmAzi2b4S495LFtO9q1gvnYWq5/7HmzCA911EWacwl?=
 =?us-ascii?Q?uiKX/W6jlClTNGoysnCufLHPIdzHLChl91htjmUCO7OEPI5hTAb2f2ZJEzXo?=
 =?us-ascii?Q?0evAWfpX+dyY/LmShGsjawSUXYrUZPdThj05CDwSILHP/2YNitKDp9OUw2jG?=
 =?us-ascii?Q?HvpOS8h4L60cq8oohpQeOMjG3rAbs8isMDqBug2F9SOK3m+9dWMqgNq8MCZV?=
 =?us-ascii?Q?xwwyhQYkNCOWcu3AsH4GEK+6zYL89nbq7joblzUO6p5wmRYuqyDTmhWKAmVn?=
 =?us-ascii?Q?KQjwaaqbG5uOtlMuQt2NeXzblSAvDdrgUmG8vqSLdLvnjQdOqeX8A3RDUyqD?=
 =?us-ascii?Q?058VU8qNXXx/e0N+pHaeas1Phs56IX5eM4oUP3alzyi1r39DkFZFx/PGhG2J?=
 =?us-ascii?Q?sAIbMoHBQ8TCObZYQF5prmtFKN83k/Gn96OeeVdZUVaLmg2S8wLtoFCdxY6Q?=
 =?us-ascii?Q?5XcxcXW30uK6tssrtFbcEBWO20CDIV8dox63JgrOr3Km29lHnieKkqoFDWJx?=
 =?us-ascii?Q?UmYwuUcLLJw7ESAwr4Y4+0N9OoMFbJGjFbW6etgOapq58WziJJ2RlkyRwXQF?=
 =?us-ascii?Q?MgXzlgS2W3OCQAzmKUqZG6j2VYSLmxOz+2bbAlk0neYaECMcVFjy4O0qTzry?=
 =?us-ascii?Q?tacLAhr1jD/SGYWzOlazIvy2ea4BEqXJVODHmFdEhayvs4bfDAuzkzc8q2mz?=
 =?us-ascii?Q?Npw4NnSu9wSmCkJpSeisVSe+6atxo2neA3CmV+6EZS1fT4PFZf6nN4DVtqTH?=
 =?us-ascii?Q?q3q12nCF3gTpeaavNwdjpyvFviDTQa4dJnQgLx9bcAZemF9itLkP/tSkFB6E?=
 =?us-ascii?Q?mBzL4VJl3RbCeV9ZufLQXRg4Uu6Ghef4BWOj83t0YwwQ+fLRLbmTT0szu3z7?=
 =?us-ascii?Q?BqRfFL5H/5ZGKCaJAFJ7Ew7HFYKdf7v7odlIrdrK6+kMjuMqPZ7ZkyM79AIr?=
 =?us-ascii?Q?Bz9wVKC+2izGxe6BqkChbd1D/wHnFd+LrOPdPJxkmm+5v/WJA9oVQwsyqjQi?=
 =?us-ascii?Q?TBMnLq8Ozf9v4aa+ZuwKrKwgBWRHVckTqWVShSeFI2s1hXR68Lmu8uJlEGaj?=
 =?us-ascii?Q?QAk1nHi/recD+LXsDAo+L8G5x5pO2YHB67ob3dCn7vzcL0E1chl2YCiOlgky?=
 =?us-ascii?Q?gfaxMvBMTEFbb+FiP1LtQ+9i17IZzuOlelZ0470kC4ZJMGWUbSVAVng7Uuqa?=
 =?us-ascii?Q?4cPTixL/dUrbJOR3AACRqNGp0KBy2a4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5587F458943308419200E10CA7C7813D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/MqI/mZOQnSu8KpV0lyi0MFd5m3DVb8W4R6tq3k9t0IaPYTa8BFAmjPG+AV0VH/HorNOBsy8PHaeWEzAbTr4FdiL2fOZC09ybIvH+Htcb75vbYTOQcL3wsNAYvTpWv1dvceigkEZ6Xw87B8m+PgXyABvjXKsc9a2Z9jV0k5pfnx4hCBLZeCn2xwrWFx+br+77o57FM94fbSEYCGSXShu+wF5mVBCuFXtYLutRjpS+TLhiHwRlo9xu7SH7jECHQa0PbiA3flkYFVj+xawffufFzbltuPULRXj38P5tISprRJQtN9iHv0YumYeyv1uX+t9O6PWQab0Zgic3qrBFesY6Td3m+EBuGycQJPSrrh6JX0yWip70lphNYld969pvjzWH/9l+LwGvLivVH7e1BC5R5vl1wpuipG1Fgkr29eyoy52joTk4UUOO0Et+h+ibwF5c9YEMOvoagaV6rd5vZmv/YQF5t4aqTloP8YyOG1ZgxrRmytz0XJEu5xadx1dg6jmClnwLtxVbK6Y3ozNHU+k97Glb0GpcsIUZ2P7oIYxETQtDwGWgusB61xkpVxKQYvdlNhX78wOdU1nhfgm9l74J9IwwkTLGfNMt3upqYuqHZu5JcgXsoXICJUnC4wIAwWA
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c7fd584-fd08-4d4c-020b-08de596ba477
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 04:06:38.8373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QIb6IihiWhLW7de22yFeDkmgbVam9wvK1NkeMwmHXYlxBxsRkrwX3lc3Fnc+81CRHivNGBgPZXH1F3+La1SBi/JX+08zNdXgws0EzORRsyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6277

On Jan 13, 2026 / 15:21, Nilay Shroff wrote:
> Running blktests can also help uncover kernel memory leaks when the
> kernel is built with CONFIG_DEBUG_KMEMLEAK. However, until now the
> blktests framework had no way to automatically detect or report such
> leaks. Users typically had to manually setup kmemleak and trigger
> scans after running tests[1][2].
>=20
> This change integrates kmemleak support directly into the blktests
> framework. Before running each test, the framework checks for the
> presence of /sys/kernel/debug/kmemleak to determine whether kmemleak
> is enabled for the running kernel. If available, before running a test,
> any existing kmemleak reports are cleared to avoid false positives
> from previous tests. After the test completes, the framework explicitly
> triggers a kmemleak scan. If memory leaks are detected, they are written
> to a per-test file at, "results/.../.../<test>.kmemleak" and the
> corresponding test is marked as FAIL. Users can then inspect the
> <test>.kmemleak file to analyze the reported leaks.
>=20
> With this enhancement, blktests can automatically detect kernel memory
> leaks (if kerel is configured with CONFIG_DEBUG_KMEMLEAK support)  on
> a per-test basis, removing the need for manual kmemleak setup and scans.
> This should make it easier and faster to identify memory leaks
> introduced by individual tests.
>=20
> [1] https://lore.kernel.org/all/CAHj4cs8oJFvz=3DdaCvjHM5dYCNQH4UXwSySPPU4=
v-WHce_kZXZA@mail.gmail.com/
> [2] https://lore.kernel.org/all/CAHj4cs9wv3SdPo+N01Fw2SHBYDs9tj2M_e1-GdQO=
kRy=3DDsBB1w@mail.gmail.com/
>=20
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

I applied this patch replacing the spaces with tabs. Nilay, thank you for t=
he
contribution :)

I ran whole blktests with this change and observed two kmemleak failures at
nvme/061 and rnbd/002. FYI, here share the failure symptoms. Debug support =
the
nvme/061 failure will be appreciated. I plan to post a fix patch for the
rnbd/002 failure.

1) nvme/061 (tr=3Drdma, tr=3Dtcp)

   When nvme/061 is ran for rdma transport and tcp transport in sequence,
   kemeleak error below was observed at the run for tcp transport. The
   backtrace indicates the leak happened for rdma transport.

unreferenced object 0xffff88812b7d8cc0 (size 32):
  comm "kworker/2:0H", pid 66707, jiffies 4298507259
  hex dump (first 32 bytes):
    82 69 85 06 00 ea ff ff 00 00 00 00 00 10 00 00  .i..............
    00 60 5a a1 81 88 ff ff 00 10 00 00 00 00 00 00  .`Z.............
  backtrace (crc e0e63884):
    __kmalloc_noprof+0x62f/0x8b0
    sgl_alloc_order+0x74/0x330
    nvmet_req_alloc_sgls+0x283/0x4e0 [nvmet]
    0xffffffffc1d60f0d
    0xffffffffc1d67064
    __ib_process_cq+0x14f/0x3e0 [ib_core]
    ib_cq_poll_work+0x49/0x160 [ib_core]
    process_one_work+0x868/0x1490
    worker_thread+0x5ee/0xfd0
    kthread+0x3af/0x770
    ret_from_fork+0x55c/0x810
    ret_from_fork_asm+0x1a/0x30
unreferenced object 0xffff88812b7d8a00 (size 32):
  comm "kworker/2:0H", pid 66707, jiffies 4298507259
  hex dump (first 32 bytes):
    c2 65 85 06 00 ea ff ff 00 00 00 00 00 10 00 00  .e..............
    00 70 59 a1 81 88 ff ff 00 10 00 00 00 00 00 00  .pY.............
  backtrace (crc e120dc78):
    __kmalloc_noprof+0x62f/0x8b0
    sgl_alloc_order+0x74/0x330
    nvmet_req_alloc_sgls+0x283/0x4e0 [nvmet]
    0xffffffffc1d60f0d
    0xffffffffc1d67064
    __ib_process_cq+0x14f/0x3e0 [ib_core]
    ib_cq_poll_work+0x49/0x160 [ib_core]
    process_one_work+0x868/0x1490
    worker_thread+0x5ee/0xfd0
    kthread+0x3af/0x770
    ret_from_fork+0x55c/0x810
    ret_from_fork_asm+0x1a/0x30
...

2) rnbd/002

   The kememleak message was as follows.

unreferenced object 0xffff88826c5f8720 (size 8):
  comm "check", pid 145048, jiffies 4301507712
  hex dump (first 8 bytes):
    72 6e 62 64 00 15 b3 a6                          rnbd....
  backtrace (crc f6c244b4):
    __kmalloc_node_track_caller_noprof+0x69d/0x900
    kstrdup+0x42/0xc0
    kobject_set_name_vargs+0x44/0x110
    kobject_init_and_add+0xcf/0x150
    rnbd_clt_map_device_store.cold+0x164/0x792 [rnbd_client]
    kernfs_fop_write_iter+0x3d6/0x5e0
    vfs_write+0x52c/0xf80
    ksys_write+0xfb/0x200
    do_syscall_64+0x95/0x540
    entry_SYSCALL_64_after_hwframe+0x76/0x7e

   I tried out a fix patch below, and it avoided the kmemleak
   message.

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 8194a970f002..db6890121012 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -60,6 +60,7 @@ static void rnbd_clt_put_dev(struct rnbd_clt_dev *dev)
        kfree(dev->pathname);
        rnbd_clt_put_sess(dev->sess);
        mutex_destroy(&dev->lock);
+       kobject_put(&dev->kobj);
        kfree(dev);
 }=
