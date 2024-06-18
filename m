Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0683BB59
	for <linux-block@vger.kernel.org>; Tue, 18 Jun 2024 05:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718688799; cv=fail; b=m628CZnmbFHZfo3DmClyQXZLliciQ77PRU5YiQley48gs9bfu5V5VfdbaeUV21HTKfjX7kb6UTT3Ox20t1j64WoLJt27kRczYQeIULuGtKyVwuZButLmsdGn23M5SyWrqBMLE2q0lwDcIcsi/ADRhQGPa92gRRUbJBQ3Svc2faE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718688799; c=relaxed/simple;
	bh=rgDGrW9OyMertL5hS22pScgRSva5QrpG0esiw+1LNRE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rwNa/cyt3ZzyIFAku4owvxpXb5gWBrBNMaSbqryn2NmloZMjibl3HJv0bbUqc7QqcZ1YpcP4XwxXONgGXWyXUBUt/mlJ8ESrGPvokEfEuFbg7Erpg/25sYJ+QWwe9+DX4QaB61uWbUbkv49tu/qBVA9uuc1eSgp8OAAlvwur+6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XXzdDoEG; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=OAcN4SWI; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XXzdDoEG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OAcN4SWI"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718688798; x=1750224798;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rgDGrW9OyMertL5hS22pScgRSva5QrpG0esiw+1LNRE=;
  b=XXzdDoEGN6P/VpgDOIckJe6cdYvucgEDBga6qNQs91NAujcW68blLgam
   Nu5WsUmzzmxd80NCXEe4ib+OvABEJSjPBfKcjKGUad6kciWINqg3p9jfB
   ADGpeT6VEkg2Npodw0B+as6P7asEc4U3UE8d7PcGBj1wXN3DjfOu0vcu+
   eojIKh8AKJv+DKoRoHbL3nr8okv0zoJGkGmOP7ekiHGfAeVtfq3jfFu6p
   6K9SCM+n+YWf2euDUP94DzLCQd3oBmsCu9EpQYCj+tVFLerrYJxCzTYTv
   fBul0CHUi0B4TehVYYDSHBgI9rxquxu9oChyrRRvcTz0Fy434UUp4Q1M6
   g==;
X-CSE-ConnectionGUID: yv+bpyOvTfGRq0w3qNqUtw==
X-CSE-MsgGUID: hByTKDfaTsmiHHAmwSWX8Q==
X-IronPort-AV: E=Sophos;i="6.08,246,1712592000"; 
   d="scan'208";a="19079826"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2024 13:33:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrO96Xtad3xHzs4BO9mfhnzB7NSqppaR/IzICkFFNUfofJ8nHmu+bFFWSMFvdlwA7bZ3i5W7bN8fOicTGu+YMXSeKHzgpyva2Tdjctaf/tATjEJ0vIjKZn5+lTl7Dx1eTHf8PKj6N++hslfQGkqDLNlHm80Z1pf/LZA9AwKwQkaxyqIpL7FCMD0zAAgRsd2MvwAkTqMvBho9cMqyPmKL2CXqvHAddnc8tUcQlxgi2dswFxgcxFlTegEcv06PH9A3tBg3ghkp8Xz17loW9IzHJx+KvfGOLwaPi6PpdhWxdKeTY8YwOrfnIvzZ+nm1Cl/WKoY7ebLpLKU+H27nWH8iew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weJrIPTxvR+i5suwpk3Sm/EH8gTB/TMuH652FDeqfNs=;
 b=YA7n5djnDcwZcT2T2072AITXDnkDDbHxDqb+qO3nhPVun1E7Ech9R278utp1k+BakBdVhumkMJeMXaMTkxr3yMmqnzF4hWUJC+TjoTAo+Sh+u3v9bYfC1D7uytYACI8CrDQuapsjDalflJA44wBEV9UUJVV4k7256/+W3xSHCYozMNIxY1QKluW2lWagADTaW3CInSP0AzHysCWi9KpWTObTOFdVZQNzTB1DlqQZbAzf5MMxGqq7MW/yE7tnautwX2K7Gi4ENSNXfl70ZwatvBBGnQKhjXNz9RREP2Qn+x2lpZao2Qz6b+yu6mLkX5/pAIOkeAt+DDeRiPvrBQ+Hbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weJrIPTxvR+i5suwpk3Sm/EH8gTB/TMuH652FDeqfNs=;
 b=OAcN4SWIt0nBlq7tm5sEdVrHnseHdvSQ/V1TVxG+kOSHbmFyINYOvGF04VtDF0U+4kB8p21+0fFoBHJEKczb5DWKqpfOtmyj4i5xxElYFX0SMGuXTpgeBE77vZzBD5cJDrqu5YUIEp+pcw2rZVkU0dYpHbj/tQHWYzqsNNRWRQw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH2PR04MB6935.namprd04.prod.outlook.com (2603:10b6:610:a0::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.18; Tue, 18 Jun 2024 05:33:14 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 05:33:14 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>
CC: Sun Ke <sunke32@huawei.com>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH blktests] nbd/004: drop the check for "couldn't allocate
 config" message
Thread-Topic: [PATCH blktests] nbd/004: drop the check for "couldn't allocate
 config" message
Thread-Index: AQHauJuL4LVx3xX+AkKY3pUAWOknM7HNEM0A
Date: Tue, 18 Jun 2024 05:33:13 +0000
Message-ID: <idkqytj4mmphunrmu45nblumva3reemghwl6d2rr4jhdgi4ute@yt55yzlxlfqz>
References: <20240607052826.249014-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240607052826.249014-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH2PR04MB6935:EE_
x-ms-office365-filtering-correlation-id: 064d318a-efb4-4b85-0631-08dc8f58262e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?tqziPoAC6bbv6J3mK0T9mnScoVzbV+EPjcoz6sz1fTqApM6P0P6jF6+SFJC/?=
 =?us-ascii?Q?zqaAfnW9y2NvkUn9KemwEeYQIsH1FgoeQ7nsgteCof8J2ESMCdlwXsk+8xh9?=
 =?us-ascii?Q?T1mFEeP+AiCOtzTNQ6UK08qM6MSJiRmiLzbw5aNFZOqWPNri7W+TJ3ypyNl3?=
 =?us-ascii?Q?mC9M6Irn2V+XSzCDrKv4ymmV3QOtt8fcLHYQglfioYp6szZQTqvCRbsnvjSj?=
 =?us-ascii?Q?ClC6mhS+xRM7nH0yOEARpuKIBi0CgjdiJaLKWbpz2tbkLkgQZ9S4pLyqsnX4?=
 =?us-ascii?Q?JVmhX5wmoh8bkCyAk4taTI6jCeNRfQduTW2qhym5QRM+UDqJzAxVqTTsYipT?=
 =?us-ascii?Q?D6A+TGPx8/wWQnHmfCXeHykW3P+p8x4Kk6MiHH/sp94bUaqBobIsb2xJozl8?=
 =?us-ascii?Q?g9xFBZe2gs5nJwt9lopdDnnpKLe+vPde30Wst6ZHfgw8Yu+8hinv8I3+jaiB?=
 =?us-ascii?Q?nFbPVsoD0pg71PIKs0rBxytNJgNmTCRphSbgYIM42r1dpDYW1X7LoPDi1ilo?=
 =?us-ascii?Q?lDYncARjqKi5JUV4dcEQLkrBs3UbCmNsyTRnyEqgE9/Lv4EhBlQHnRbOBbZx?=
 =?us-ascii?Q?sBJq1C9npoZcAB4Ls8AnPlWKUjwPgaFn/MMEC2jkFPo4Gfd2aZHvKPr3uykm?=
 =?us-ascii?Q?j0ODA4OidrDx5nxrPnEgMwPwZviKbA4yjSTMk0hWcxNExtpEBv5oTZVKd5fq?=
 =?us-ascii?Q?p48gFAOCO6UopBEpJlm71tLamDR9TkQSxbmOjkPadWOLo/bbOhimaU+W+I5E?=
 =?us-ascii?Q?q99dV1kBm1FBzAy48jy0MYegHsX6iv+avaMh34Pfwm9c8EvD3GQgoN+OiPCV?=
 =?us-ascii?Q?UL06SbGC49fKfJI6xRiNfV2VUyVngkbBeMBhtvXnsuc7jpgtxkqXxJf9SuX6?=
 =?us-ascii?Q?A3Hkbdydp0MKeaX1DnDeRj62p5awi8w94DtoGiwXRVdqqext4S9ijHyLxpnP?=
 =?us-ascii?Q?Fe1llJphyzW/34QGjumexF4i5hAN2KQvFc+juPe8A0a3CozgKsCPPY4P1+N1?=
 =?us-ascii?Q?Cf33qqw1DfhzV75NUnbOMrkSU2D4kOToHCfDoyYAxb4/9QZcgp9iGh6GXjX4?=
 =?us-ascii?Q?1fCBXS3jMoeoyLwQ3huC0o5ulrLo2RO7NyLTI/kHBAcOQ0Y8yd59Zvk/IJhi?=
 =?us-ascii?Q?ExF2ogtqSYgpLudJLjVx06F3FzIJcKFINL5rJgLsBZlffEMMbGScVjIOCZe6?=
 =?us-ascii?Q?b5GeK0aT20DZlc3PWesRubTVmeqC4Jiy2VLiNmueVJ5EvgYAzUM/bZGSMl6g?=
 =?us-ascii?Q?eg0gc3RlWOcYFPMJBL4rosf16GYlCKEmf9mn76cdt4IE2SQqsjOreMWSCqh1?=
 =?us-ascii?Q?k0HoCB5p1rpdoa4rdZwZDkE6?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VndGjTjUKBmKM9G+Hhhn7TW37fjrbFEIEw/o/fXzg0gCX6SPXy29y1tunNSF?=
 =?us-ascii?Q?sByJFZgUMW0sm9VueekRmJiETRDqV0DGlUDk7brcjJ5BigtdXq4lclsyKmMn?=
 =?us-ascii?Q?KWm7VX97DttpcIrWf8w4LwLFQX0PLDiO42GZdNr2JW333zIOki0sW7/Ig2dM?=
 =?us-ascii?Q?TN3VZXSL+w/KcE8HQ9VxW0ThSKknsI+Qa+8zhPJqC2HqnW4MAw2oWlp8ywar?=
 =?us-ascii?Q?wFFxmwockW/5pKeuj51aXj0X6bPXvH1QT/rOMHelxHkGjTy9CK5caDs3SYeI?=
 =?us-ascii?Q?lMuQxNe07gjIxtVwqmk284U/Nju37SMH+nLuuGO1Qt8ncX0kuvKUmvPnYx8S?=
 =?us-ascii?Q?X8d6XU0NAIQdO+UpIb53xkntU63K2QXV1v+FL9P61Vn0K1umymv81EQBAKbe?=
 =?us-ascii?Q?b+SLEytFuA6aEz3v72R4l1zyizDKHwgtbCJINQtizhTP4mifIgwS8HtB0MiH?=
 =?us-ascii?Q?BAIqIAJiqtA43DMnVqXEZLHPTAj6kGS4ajzHgndYRXY8uHft9+F/sScm2A5T?=
 =?us-ascii?Q?O4N/hZrg5Q5UkH+vY0sZ3CGVfc/FcEmzXvGajjWHs2sN18UKXjZ+u8kkG6KA?=
 =?us-ascii?Q?RLb09X0h0EHLUS5uDHD/4OHze4++uv3INenkNz/IDNmMxsIwgNAn5p/ZUnCO?=
 =?us-ascii?Q?kAWaJ9QwW32yq9iFwcu9yC7Y7lkDlF4BnpMdzj85nwEVlOVc2e6liHo0XAqr?=
 =?us-ascii?Q?MKgz87bhb5UI1WpDnMSX3LReheQCqmQ0mq3cA505OTE+3parLHhkNLrl0XrE?=
 =?us-ascii?Q?/Kq5no8Bax3VaHBxQb9ipNY2KjG3YErHlXI2NYUXbYQBhuW4Miiymlzz3v+7?=
 =?us-ascii?Q?3XUt/5DKVqUhfkWekSRmcWvVdfA/ECRkm2vHvOLelAog/6MlKK/P3XI79Ivq?=
 =?us-ascii?Q?JVdsYl5R1bBzkJmQj/ijeXaz06BJpkGRZLLpAu3VaMbzOEnt1dlAVOr1uFyG?=
 =?us-ascii?Q?2H2QdbHw5YUs9JKx6oGC165G1YNsMQibbac4OEqbmXRXgMI6sZ7gD9QSVbiT?=
 =?us-ascii?Q?Xkf0ICn2l9I38XL7/tOUECYd/cULN7uMWYoAxFubZdqIbhUKBmflIqrPNwHC?=
 =?us-ascii?Q?PdZbvtyuSyW3DAb1n+SwyACgI7JFjFtkxFLBvaFx1QqDd+Tq6zwn9snn0yO0?=
 =?us-ascii?Q?AyJJl30S7oXdGLPhbM/re0i+HxQI7tFkAlcuFVQ0L/8bQ41ggEDR3cGIe+Wm?=
 =?us-ascii?Q?kQqvrUOfxoPfz9KV2HbGSOieNsXPEd0R40+n1YTi+y51EyXSCOgCwQuK02Xk?=
 =?us-ascii?Q?km5njbUjvuz31FzZGJRls2zaEF7cTbZJ2r0ukBvALDH2CyFxAjZb/A76oCZG?=
 =?us-ascii?Q?acDDrkaZgDA2K5B1RhyPTpNDxu6dHf9zhS5qTtPY8kVIdrIK6AksoqwkqadN?=
 =?us-ascii?Q?1eXKvMsma2u4VmjSlVE+MqUYR5xkGUeoXn89oBbi0ZaUpGv9pAP5kG+ItmPW?=
 =?us-ascii?Q?m+/3Li5P34EI9t4YaB88VZRvSnqCfvRp5dOjcNaohYUG+pS21B57BJANEign?=
 =?us-ascii?Q?LI9jcetO5Y2dhLnlWiJce0581cIF+wUhd0c5BctkSvCT1NcIl++rthdqoJ7H?=
 =?us-ascii?Q?RBDF/atTmYg2p+P9HATfzKlmLEEeQKq3TJb7wRYVaAC549hwXXaC3v05i+uP?=
 =?us-ascii?Q?V3gpAqup8R1cQ/fJQ/PPM+s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0E7F42B30DD7754DBAD3E59C2578C66B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T8MtGWmaCQ/ldyxiDrxbZ5WYRoShoaWJRvI2sdfXI1d3k6Ao2EzDqtiSYTEOSVUBhqs41lNRObfNru1s9AA6JjT5Dwh8EG9lzEz8Gggx7IoFaicrUDrTDjSI0J7ntE2nEoaWSQ1tgqzBCvFAGXlrF6ehxa7SQqXUXsStnlzQxFlJdHZu8LeADEIAZY1GQZuSWFQfZ9umFNS0CZHSicFCPYJgED8FjYqtaGNj5TjQV3AiXF8O+plej9iTYnOQY3al53kKJw3ekdpLBlWVmS5GkCiv7mP/ikflur2qj84ZEaIMl3afamg4+y/WQ+m/aXNgL/PFRqubKPkVpiMsZQwLL1TlBibZxj5EzwQRLmhiCcK318/tRjG67ZmkO+0XMukl6gtdQEoV8qTF0V0RFFtOR4J8J8XhOOO3tyRNOpnJ/T/2BSv9Qqbrmgbcc44f8EWixuREGFbMfmf9V2hHaAnxpJzFJ16l8N6cqpqON8JGjonstvKpzEXeghmokRPmLd7s1A3AHB8LzezV6LwI1h8U1d4to2exCVtffQd0cWPeM7Wnyijl5bVMQ7W/H7+mbUlOJIdEWStX0G9gRZZsJB8PEMBjdFGI53SbSr7y9VLVuE1YxnU/NuPlONHAOp63iA7l
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 064d318a-efb4-4b85-0631-08dc8f58262e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 05:33:13.9805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +qn5p28KuMQY59IhN0axGojEQu2PLZMBb5rjiM4NdhvpaSRhCwQj7BL/lHmC+e8LLcCHKpN5i2D1kZU1Rv2yltAHMBwagv6BJ0tWDo+XGNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6935

On Jun 07, 2024 / 14:28, Shin'ichiro Kawasaki wrote:
> The test case nbd/004 was created to confirm the fix by the kernel
> commit 06c4da89c24e ("nbd: call genl_unregister_family() first in
> nbd_cleanup()"). Originally, the test case was created to check that the
> kernel commit avoided a BUG. But the BUG was not recreated on my system
> even without the kernel commit, so I was not able to confirm that the
> test case was working as expected. On the other hand, I found that the
> kernel commit avoided the two other kernel messages "couldn't allocate
> config" and "cannot create duplicate filename" on my test system. Then I
> suggested adding the checks for those messages to the test case, and the
> checks were added [1].
>=20
> However, it turned out that the kernel commit did not totally avoid the
> message "couldn't allocate config". The test case still makes the kernel
> report the message with a low ratio. The failure is recreated when the
> test case is repeated around 30 times. The CKI project reported that
> nbd/004 fails due to the message [2].
>=20
> When the failure happens, try_module_get() fails in nbd_genl_context():
>=20
> nbd_genl_connect()
>  nbd_alloc_and_init_config()
>   try_module_get()            ... fails
>=20
> This try_module_get() call checks that the module is not unloaded during
> the connect operation. The test case does "module load/unload
> concurrently with connect/disconnect" then the try_module_get() failure
> is expected. It means the failure is false-positive.
>=20
> Drop the wrong check for "couldn't allocate config" message. Still keep
> the check for "cannot create duplicate filename".
>=20
> [1] https://lore.kernel.org/linux-block/20220707124945.c2rd677hjwkd7mim@s=
hindev/
> [2] https://github.com/osandov/blktests/issues/140
>=20
> Fixes: 349eb683fd06 ("nbd: add a module load and device connect test")
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

FYI, this patch has got applied.=
