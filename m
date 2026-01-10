Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8662727FA
	for <linux-block@vger.kernel.org>; Sat, 10 Jan 2026 06:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768025349; cv=fail; b=s+mmYRJ3W4lJ93LaAoxYF5LpJHigHJ7rVME+L1CfbJEt2zBU+/kPTMfhsVq0XzbCkdvvOhjtYB7oTU8ns/MMMmWNgabrjzLFeCq1NgIuiuChfQ29kl9CxwWh5HW3Wq47y8gCm9wPEtlayAhdXmsg8vHROTuVFQGXLmObGsr2sTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768025349; c=relaxed/simple;
	bh=7oceHzZOmzn1ITdlBRfXus+5wwR0M5kiGbeuSFvxF5I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DcLf1sTmOLQvV7TvaW3puZQ7sfMOw23b68uPW6nTQ7dTdDM3ATMbwkQp45yJNFH2SNDzfW0FO/DUHhhPk7M661nNuv5ISHVdzgduebxdmpG1s4uyhm5qrySb98gDoJEbJyuyFKyZf2WUnGDemhiR+RIyVuDjFFgPD8f5SCmaIt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=h5T9laNI; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=kU9UK0v9; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h5T9laNI";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kU9UK0v9"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768025347; x=1799561347;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7oceHzZOmzn1ITdlBRfXus+5wwR0M5kiGbeuSFvxF5I=;
  b=h5T9laNI19Ok89MhjwbhgAnErY4LjoDVGs7yk/X1dX0UOSxcZqnAEhIH
   4rmgAwr6WWCkbAudj+0r3sj1HJpk6fmYFupXjzT/2jk/no5xZTRKafb7p
   EAnh2yx8VqMJ7tALBt2PrGILf1HCg+WIn+R3nAXGwdKnhQyKNXC8XH3Zo
   UiQcQS7fr3TMWFzdUKBl7H9vmHgf3G1KKoU8t66Q91u7BGEqAdSCRsdGa
   0b5JVUnsYaMBUuE+FeEF89WUF+uaaPkhSj1vDIMDCGgrkV97lJQce6NTN
   N7HvW5ldrjzsT61fc/mM8n0MyMEKbMBb8lR+rN+udon4Mmu5rQNg9gRuN
   A==;
X-CSE-ConnectionGUID: wJ8delxhReSfq8BeeaNlIg==
X-CSE-MsgGUID: WA81dXXMRWak4J3LR975UQ==
X-IronPort-AV: E=Sophos;i="6.21,215,1763395200"; 
   d="scan'208";a="138312275"
Received: from mail-westus2azon11010011.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.11])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2026 14:09:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fO/A4l4PvuueqV+OAaQg7cOSDQ4Pxl6kIvHvX3gcZeUAPshOKZhX6nGvQeqvMldldWbQ/2AnE2KwbUbZLv8ooYXcdzTTRxHq3/iX+LHzBcu9Tqt73XZzivn4cAe0YaqUQKByLMaX45bLOkUCt4ql3bcoEan6DjAm3Vht2cg9OuCpgXPVmRYVKoDsc7ruvDwxBMfWCXAZM9SjGRHzY95Xg26vG6OiLBBn5Dz2og6Od/k9MbhKBkKCOLYJH5Wm9/jSgh0qzMkFwnHQGpT8mbOn25gBE+Aa2YTN67rp5IXZvwapCMyKaH2JDzRJp6PYUPez3If1j+RUBwNcOX5SmI+CVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHEL7RTD1ePrJ5J9JdtjCQBYtsf1+RE0cpAogrEiM3k=;
 b=iQdFavWFCxj+jc7NAliCA0JAnCEDUgznD3+Tf3rNTPEgbYODHKXQpq0/EYudWA4AiX/RWPcXmZXTXjeTdkNAadN2pEsHPB+4B9f8YfpDjBbWy9gpb9W5pC2PvGGkbl67ZQJIQFHysQuTjfsIez2K43qdBrY7x75sG1pEsyvXceSUA4BiLK5jYZPcmkbDVH3BwV5LqZjtxLcEvRDCGU3HAsUTF+LfA8XIm5Vq94qkXXymwlVATPY1IxFYeUh4GZe8Lhi1DnB64jb9zZu6tT9HUvTiq+lWuoA8ZaF4hof2PtlThdRVHqQDtbXFKucpnYvF9ECe469AEc2pgnUO4ov/tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHEL7RTD1ePrJ5J9JdtjCQBYtsf1+RE0cpAogrEiM3k=;
 b=kU9UK0v9fvDKLF16ZmKLeNaq1/JWfqG5YIN7M/g0rTwBikbT18UmYDgUCsRELWMoFnUqj+0zeut6ORSqfQsCQNfDeoNc5MYr/s7D4OZADVdidhDJ9rjlvQ5WvoxOphOngAp6VNHhtxpwHGAHn/d7BINkKXWYfae89wkV5DMaka8=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CO6PR04MB7473.namprd04.prod.outlook.com (2603:10b6:303:ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sat, 10 Jan
 2026 06:08:57 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9499.004; Sat, 10 Jan 2026
 06:08:57 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>, "sw.prabhu6@gmail.com"
	<sw.prabhu6@gmail.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests v5 2/4] srp/rc: replace module removal with
 patient module removal
Thread-Topic: [PATCH blktests v5 2/4] srp/rc: replace module removal with
 patient module removal
Thread-Index: AQHcdZdS66W4GJv3n0S6Vr23DGoEY7Uzo1EAgBdgtAA=
Date: Sat, 10 Jan 2026 06:08:57 +0000
Message-ID: <aWHrykwwVlyGRSfC@shinmob>
References: <20251225120919.1575005-1-shinichiro.kawasaki@wdc.com>
 <20251225120919.1575005-3-shinichiro.kawasaki@wdc.com>
 <435451b8-4d54-4306-b29c-819a55b6b5f1@acm.org>
In-Reply-To: <435451b8-4d54-4306-b29c-819a55b6b5f1@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CO6PR04MB7473:EE_
x-ms-office365-filtering-correlation-id: 9cdb8752-5354-42dc-4910-08de500ebdc6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?joaRsW2O2RmsLo6Tium/8mp/9nh6YP7a8//aA0pl3X4Sgo+dSyLFpds9pnel?=
 =?us-ascii?Q?XQZqyBRi8agF/SoaQroD8ROtfR4iim7+jlKFZ5beQmfZVnUVjdKV+V5bZeaa?=
 =?us-ascii?Q?cQwQe+uN1lWjNWVO8L2OA0UdG5qpEQSXVNl4KlnC6+GiaDzD3Oo5ffKoWcoj?=
 =?us-ascii?Q?uscpGYbH7olLXMzPpcO0GkmY8BsccruuZzOa6RQbfFqiSjV/1SkYqpNlk5Ax?=
 =?us-ascii?Q?fvUncogmg3O3pcPyIkcLca7U63U7yuUar443hqO5yjbtk484RcN3gUOiMl7X?=
 =?us-ascii?Q?KyvFhMw2BXhfZ+IFj0ivmBYWyNU1NKnqmRemrA23kLshtvUOa1PyQWDixex7?=
 =?us-ascii?Q?tD+8rYv/fztoYK4VJ6L8kz7R37aHPlTr87kHzORsiOyi4dB6pHVw8gOUGJYd?=
 =?us-ascii?Q?eKDmQwOfCLqBiJsL+yk/IR3Wy30zadToHr5GEwgS3SG+ix2rFsvqpR8rL4Lq?=
 =?us-ascii?Q?lpD1tM1K8t2/gt3LhrUTrav4zjINKqvXCL/jAdTQEQouSn7PbupkQWHAEV0U?=
 =?us-ascii?Q?fWO0QOIespRxZfdWxO22rRWOf6NRJm3M4h/tTmXc1sib5679lbs7/rsWTb75?=
 =?us-ascii?Q?0N7mv8OCyxC9dc2njwbvdKzkRK/Ni4KwhIibum/d9McU1ATQypqF+FtXuF+u?=
 =?us-ascii?Q?yvzDr8mdac0Lggl/tOprRhGQjEQehAOQq45zI9ZJEiENLuQOmlJHWKGLfczQ?=
 =?us-ascii?Q?Ywsd+crzpPl7RMM4JeVXSuK71IZEzYPAYzEbXHWEuArOmieZRdbyal7HVRgx?=
 =?us-ascii?Q?iM1x6u8Og1imr9Yy68KaeH7QbrunxQDpf/g3igbaeSvYhDnrz27ux8r+SIZS?=
 =?us-ascii?Q?1yWKeYz1ZuEg+9OeF+NmuNy+VVnMz6G67YmxRk6v+8HYGhuHyTn2QsbJofgJ?=
 =?us-ascii?Q?YkSlgaUYoAlB68nSljHDigVAWPVq5nFK/7wQW8OiVCwxO2myHqnWZOKQ8o0D?=
 =?us-ascii?Q?ltLDkHdEYDmxF18/HqE5vs5xYfbNU6Tomuexo85o3Tr2thLoTD9luLXt1Qhb?=
 =?us-ascii?Q?mG+NmuwKkIVdkGIMcxh9PaesYStRRMznShlPhCh/m38TTaxKRSuPOuE1SC1U?=
 =?us-ascii?Q?MH2NionAXGfOd1jfcxb78uJxW/GUiMURobCaJZsyKnt6REKzmDTz/4Vz1cbP?=
 =?us-ascii?Q?qdelSaxhYcyRzMNR0zCPZcv1x0BaFopZ4y6HT0dcbpMnnsNmz1+SZkE1+tor?=
 =?us-ascii?Q?CFPeizSdm/U+DNDmpN2Y6VK/kM/Qi0OStyWGRiqB/VRmUbyuvNpmb3kEbRqM?=
 =?us-ascii?Q?+zs9gLKF9e/yGorFIGB4hz85rY0L1FRXtacCn4Fr0LL/Rh7t/wcoFH6BHsbu?=
 =?us-ascii?Q?q/3RBUv+Rt2QYxCTEdweXSUM/eUcYlo6Z48HxG9xH4EOFo8CrD2l+HCwNFhi?=
 =?us-ascii?Q?UTYBTv6zDwVWPuKXS5U+Iyj/+C7yMgei47faK35jKAbdL/yWxIJdLo/JcHbO?=
 =?us-ascii?Q?Rs6a0872RVGzMTnaQL/T+Cc3DQ3361Ion3PxaevUk8dkYxqh/vVMPwj9bBRX?=
 =?us-ascii?Q?a9pJd73/EVcQz6+KZzrAgg2ajOwPbGiIe8W0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xdgPg6rc2vOT1fcITG3R8p0Q1MuF6mxXjPy4GDIwMYOHVD3qg1pXG5Qgp4Tl?=
 =?us-ascii?Q?UR2otxaLYfuyCBilEvrVbI7jC0oX4v44th7rcRlVRfT+wsDetq6DKIhNQ7ev?=
 =?us-ascii?Q?hE3yQD26JyW588lSvv7ay67jbgyxwsxyfcFUUQh5qtvvml2gopTyvUzmCywY?=
 =?us-ascii?Q?nd3TFmWHzXL6sDGiuUYJKxxcckHxzPGzPeWYR8mClztYb+VfR9PqQDLuxaxZ?=
 =?us-ascii?Q?JMRvI/UKCaGU31T4SZ6PBpjexKmt03x4YakEtJTc+lyrtFj/B1jSl2xEZ6Bt?=
 =?us-ascii?Q?qAGnIy5XEVlytMU7bx1a/OJw6JIWc1djV3L98p3efCAW8tbYWeFFg6DbG1sP?=
 =?us-ascii?Q?SZaasq/+gaQLu4APGTSYSMnwo4f+k6MFEyBgQk/RSUAoaA5wcanWka07XBFQ?=
 =?us-ascii?Q?IOJnP5oS6wRopEpYoSk1dD19yAMQA2rbpdm5tfIGDvFeIgwWsyaAf/5pnnnq?=
 =?us-ascii?Q?SWMvBOJcmgUklt1BSYKoFJZ51cJ5OVB2Y5A4V4qK9fVueTt5EB+0p5Pipq/5?=
 =?us-ascii?Q?XpyjICE3a2DF4NgQNL0HXcAjGdSoKWBsSqdJT5xnujiE4zPkeOVcTVAy8NXb?=
 =?us-ascii?Q?YWe0aH+uaTvXw1a9cqCVHBIF/MU1+ctzZwt18dNsFR5vutpYWD+gpzhXw3QQ?=
 =?us-ascii?Q?RGlYgen4WcE27AD4f2y4UH4F97K14yXFsx/A8BhD65pKY4YcsAl8pPEQ37DM?=
 =?us-ascii?Q?qmhsmNRaoqinnUK+Exuo6DAbBvuTA6SrQ0jDVQTWwXQQ8FAuZj7Jl28uZxDT?=
 =?us-ascii?Q?z7IskIRIz3Fjzwd+Lel4h/ZOdb/63lljoD3+Ut2fstz7YkfgwW8BSQLToFCM?=
 =?us-ascii?Q?LrLzq+5Qf3muAlLRwU2CI4n9XzsDf58ctTZB7YTxd25acJ6IWPNVbl7tXTQv?=
 =?us-ascii?Q?Xqui5nk8ZbbphEshv5Z1tR977GEDTcrBSXE4X3I6/dICrDdYzM2NaJfL4Xnu?=
 =?us-ascii?Q?p2jwMeGWuzxaW/D6Kj+ZKRYwCUidGiFpPbiCwuLCLfX6wYkx3sziGd6ok1j1?=
 =?us-ascii?Q?blq0SifCZ2UEYWLgoW/36Oo6EfsUuvu64F69YAm8hBTeMFro42vwd0kTLjkE?=
 =?us-ascii?Q?42wrm5mKUhWcB14MtMqjho7HYINfIOikYLY3fleLg911YzFrSg9JccoHZpKo?=
 =?us-ascii?Q?4tORodvZaPrK+pNIStlLEjN6063d5B2G+cv05XZpnNMgOJRyEhFHiG3Ci2yY?=
 =?us-ascii?Q?uSCuqg2p9Z0EIWvt5RQrdHlOAhTOV3qQ9LC7SksLwY/JvGpVBcXaTqbkXKBU?=
 =?us-ascii?Q?55CnDtc5DyK6rr6hW334zNGCJHFaLJlMDciratB1c+WQQeKRAWhhL2BxnGI2?=
 =?us-ascii?Q?D0xmn0hqnb1Qj0AfGqwinDM8JZbQ77CYfI3cm6QzCke24Gm4avew/cRKP+Y4?=
 =?us-ascii?Q?ipNc7pKLFgvqPu5t+B+cQVpdJjhUeZR9I7rZvhCjDMWLDIqAkmAxKjfXNLiv?=
 =?us-ascii?Q?HkYDR/zyCAmX05e5xHJf380g0IQGH1gVsBnD3Ny1XgojoFcOmgVx+rZoVMG0?=
 =?us-ascii?Q?znmBSAQQPsaCv3o4OZkbKDkup/Y8qBE/2faFpsNT4Ls8Pcv9IPPwQw95guu6?=
 =?us-ascii?Q?6J1drg4xhQhn/7B5HS7Iq1/NrvlGiSSLsKHG7wt6I1mNtOWGpZdiNYop4kVV?=
 =?us-ascii?Q?X48AtylEZNkzC6eXk5bZa1sQUNsStMQV2DzSpkwxANtN8bOte0aG5WW5lju7?=
 =?us-ascii?Q?wr14jf4fP3tzbLjUfRYWqDK9dk/QoQHM/jPDesDSLS/wNZ9VJCo9NTsZFra1?=
 =?us-ascii?Q?S3mwZLXkZSD7R87iBeyeuWj0jgCet4s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9D0C00986E236D4EA61F234685D552DC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IfQZgkq8sTMmIKLyPVMYInxvouXp3pXcgiqwPCklChYXBcY+fudDnizWdqoppD/SKMIcv4BbH+ZufuPNEKtU7GpplVsA4rxSpMKDy48ySrLNYcZ4Nvw2yyRX0006vZW16N3pR3oV7Oeyr7d29CRF6jMYxIIQ6etvTnA3oweEgHhoFfTsw1UqAwfTgACzSqfugAlc/o6w/9NKT7kh2hgET3Kn4lofUSizpfHwYo3xMJZaLovwwUQ8NbpiL5ysZpNuRxQd04ZWRzCR04lStkMTiSU0bg3lo1ftPg9LlNb/lY7e3EGHfpt4yzVDFCUxoryAA+n8eyHcSkvwnf0juBWuXZtNW29XieCPZdlG5iRdan7IFf/9IFqkCDoSGGivPfI0Y785MKXxqT/ofnWun8r2IPMRs7AGlQfb9wW7hCCUyRCaXt2dagdLekhFwisyzIEWSGnAYu5hK22NMOBHznynHIZPzhMBxuEaMNu+Vn1UquJ6RJ5A2B4UxQ0IwoyZv3TExsEbU+e7g3RddiGYimiE7Y8PTSBdLW3aQr3HGtHpLGD14Xt/iGFy2mNFPHu9rXxqINJebyz4GRdx0eGmdy6Hy+8P7+vpwsYgheEx4WRJqtqyf9WiGVzDPTbGnQ/8f3Sm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cdb8752-5354-42dc-4910-08de500ebdc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2026 06:08:57.6445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3I3sYFSDlnDVh6xgbLPDeCIyXFdEy22diA34wISrUgMA4CyiOLsOjA90FNo9VjTJbh4Qd/qSlnW3r127O42t4D2rsv+5suaZIC1Iy52Xy+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7473

On Dec 26, 2025 / 10:08, Bart Van Assche wrote:
> On 12/25/25 1:09 PM, Shin'ichiro Kawasaki wrote:
> > Suggested-by: Bart Van Assche <bvanassche@acm.org>
>=20
> I can't remember that I suggested to use _patient_rmmod. Luis, can you
> provide a link that shows that I suggested to use _patient_rmmod for the
> SRP tests? If not, please leave out the Suggested-by tag.

Based on your another comment below, I think this patch can be dropped. If =
this
is the case, no need to worry about the Suggested-by tag.

>=20
> > diff --git a/tests/srp/rc b/tests/srp/rc
> > index 47b9546..2d3d615 100755
> > --- a/tests/srp/rc
> > +++ b/tests/srp/rc
> > @@ -331,19 +331,10 @@ start_srp_ini() {
> >   # Unload the SRP initiator driver.
> >   stop_srp_ini() {
> > -	local i
> > -
> >   	log_out
> > -	for ((i=3D40;i>=3D0;i--)); do
> > -		remove_mpath_devs || return $?
> > -		_unload_module ib_srp >/dev/null 2>&1 && break
> > -		sleep 1
> > -	done
> > -	if [ -e /sys/module/ib_srp ]; then
> > -		echo "Error: unloading kernel module ib_srp failed"
> > -		return 1
> > -	fi
> > -	_unload_module scsi_transport_srp || return $?
> > +	remove_mpath_devs || return $?
> > +	_patient_rmmod ib_srp || return 1
> > +	_patient_rmmod scsi_transport_srp || return $?
> >   }
>=20
> The loop should be around both remove_mpath_devs and _unload_module
> because multipathd may add new paths concurrently with the for-loop.
> Please back out the above changes from this patch.

I see. If we back out the changes above, this patch does not have much
meaning. Just replacing the _unload_module calls with _patient_rmmod calls.=
 I
will drop this patch in the next spin. In stead, I will modify the first pa=
tch
to replace all of _unload_module calls in srp/rc with _patient_rmmod calls.=
