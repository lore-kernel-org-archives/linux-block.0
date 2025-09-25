Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FDD2ED846
	for <linux-block@vger.kernel.org>; Thu, 25 Sep 2025 23:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758844431; cv=fail; b=gLZXmd9kQ8Wk/F5ORK1+8I5pBatnQwEl2vLDZMyeKfVAJXGEj1Aqa/UOhsFqKcAx7mlcvPRbCjOEAyQtUMbWIYho6EaWs8lidN/S2tLulDnvjWoepjyDPiWW+lmx87p4jf5ltAUOgAuBKIJ2JSrke1AEoJ1MP5JQx/1PSYV6V0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758844431; c=relaxed/simple;
	bh=4imtfbIZ44BGn/OIZvRFxuPBIbih7WrJgWSEy2vhx/Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iOVdeUY6IeiHJbLHtFwDHJjdwsjIYr3UWJ9uHqmaHeXrQlOYYRQdN/3sW9AXioKrtNxCeYu0uXSiVw+MHfryIZPlX3XXWZuLqMqUflKVy+2ldzdvPB6CdBtnt2SdAziSdgw+yJMT7UuHhjaG2/oT2o64WVTg//RDfMjpRIg37CU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rR5MHY+Y; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=G57y4DDs; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rR5MHY+Y";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="G57y4DDs"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758844429; x=1790380429;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4imtfbIZ44BGn/OIZvRFxuPBIbih7WrJgWSEy2vhx/Y=;
  b=rR5MHY+YFil2Uo65/87fkK9q+CkMGMtHL+68tZ6kDAxZZ4Ag25GB40BQ
   /snkCU+t9MrM4mqGPa2/iMVhr/CUg9ZLxHYohV/Y864yW8QUTiD7oB4gg
   gF8czEEnSAa/M9Geo5nWWhqz1LEgmdv5g15Dg3rJCKkeBWvG5bvTi+aAW
   yYxE9yTxpz8Bhl6D8omE7XWH5/2odpWfbMS4T0/VIWz7OTlVxTNzjAWwQ
   rI0ISMOLuhwE1GswhFIURTetNQEF2TapoHFqfN8dNXYEFoWiehKNbwGFP
   gHJJTQbjtrimL00aSgw1zMOflo2bOI5XHlwCCLZwfnpTQhELEAWguEf6T
   A==;
X-CSE-ConnectionGUID: 3xoHRq6XTk+5BBMVq0a3mw==
X-CSE-MsgGUID: FoU+D/bhQZaAHrIE2gUnWw==
X-IronPort-AV: E=Sophos;i="6.18,293,1751212800"; 
   d="scan'208";a="130622972"
Received: from mail-eastusazon11011070.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.70])
  by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2025 07:53:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2Uc+AQnAx5avVQlqh6u31DgIwI/DAzmeV3NPGhOhqCXZfOl7kVFC9nhnb2gDRqtQI8iaSQNeKk5h848yWwy8fvEA5aaLxRSkUdvWvYPbgBIo3sxDxBf1QHUXqHQjyK5vI+QKB0vUoPhRjmS5TW4SlbTerUOlgOK/9jhVrMKfRmFxzxKHl4pmr3Mk6c+HBy6ZrQ4pxWdaRUExmuFTiFNc589PwlVL/UPn7q1Yk5F9k69GwpXnrYTvliTsQI8J68HdhzrpCuVhOSBUhBywAd+jjhtCZ/5PKqgzAYUOkxeqBsYlkAsvVD1JRMSAfZtXMOA4FFQ1myXlBQu8gN3xYZ5Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4imtfbIZ44BGn/OIZvRFxuPBIbih7WrJgWSEy2vhx/Y=;
 b=pEl6jhlPff17+X3IMskqp298WegSP4qCQdpKRK9hFwK/80VCOUdJFdjEUo48LPMqOE9gtZDgW0zOLtrwYc/jJiB5KZKQMEkoWb0XyBYNypeH7CNM2VROUUt72cDrfqVWmTYZAY4/yZsEnKYlrp/bYzhi3qRHLhO1+F6LqxLAKi42yjRAM8ldJTz4yuqscPH4PoipSj/B4xS1QAIU/SUdA+B2KZRkdvc1EHYQ3d0ESMfe5fdJyiTDbMBMf31boA67RDW9bBlrSSL/GAPnV6x2rECL4Qi7aVsRc7LH4Qp1E02F/U0VN4NMPEx5GNeYIxhKKEercumtffICziPwwTQ6LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4imtfbIZ44BGn/OIZvRFxuPBIbih7WrJgWSEy2vhx/Y=;
 b=G57y4DDsRBgJOCr/dEClAJCYgtjVqIWKPgBLccuNr5RjVS6jp59EfgmehjUTdsySuLuYfMk6MYprVPbakk6cxmWbqnXXK1OHZIDlD087nYsNH5oGZj/IZg1ir/dnT4rY6O4ajFTMgHsj41qlAOycZfaG1FPaz//Ive2UqDC0mHI=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SA1PR04MB8823.namprd04.prod.outlook.com (2603:10b6:806:38a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 23:53:46 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 23:53:46 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Garry <john.g.garry@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v2 6/9] md/003: add NVMe atomic write tests for
 stacked devices
Thread-Topic: [PATCH blktests v2 6/9] md/003: add NVMe atomic write tests for
 stacked devices
Thread-Index:
 AQHcK6sug4CvHkcG+kqFWi7gggf3erSjmJmAgAAB0gCAAFs1gIAAAF2AgAANo4CAAJRKAA==
Date: Thu, 25 Sep 2025 23:53:45 +0000
Message-ID: <6bvdbgojbyrd7cu2jiq7odhb5o7l6nljuqdpjouc7fhcggmspf@ddjteaaow364>
References: <20250922102433.1586402-1-john.g.garry@oracle.com>
 <20250922102433.1586402-7-john.g.garry@oracle.com>
 <zz4lnyno7yejb33tqqi3vpjbvlvj6nceqciclicrkbqaqwt6oq@nyu7dz7xpwaq>
 <5d9a2005-93cb-47b3-a708-e0db50328142@oracle.com>
 <mlkg5dr4ipq5722ye5owxppp7t7drkvcnijcinsryc2fe4t3y6@n7e4l5hc5zo7>
 <1a108930-59b8-4055-a065-25ce8ede25be@oracle.com>
 <49036bee-c254-46d9-8219-a94ef485ad90@oracle.com>
In-Reply-To: <49036bee-c254-46d9-8219-a94ef485ad90@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SA1PR04MB8823:EE_
x-ms-office365-filtering-correlation-id: e821ff98-5942-4755-3fe4-08ddfc8ec3f9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UrqFJppJwAevkvJOQk6vosQjDW09qUIeX//iZ/x0NgionYHpWfFyCzjSJmEJ?=
 =?us-ascii?Q?RWqODmyDl7ISGEYMuw/9pUcaz/gtLDEF+SRpDKdDGyigDjoe3x73yhryafG9?=
 =?us-ascii?Q?TL7C+Irrvuzfnv0aVFlqA8NgS/OMTpXIKUQb44m57lrAjjRTE5APEbWLbIsu?=
 =?us-ascii?Q?wkr3p5xv7g5IIeasl6er7m4X7xCkRfOC5gc1YbKDOJofr1E69pazfdvGVVwo?=
 =?us-ascii?Q?YHgyR2js1jOry8BKq5bnHW+v3wHJQrhwuv31z5cVntXBY2ZRNvp+95p83Gsi?=
 =?us-ascii?Q?oBVb9WZOm2JOfEUbxpvUmcpNJ7+NQtaIGTW9gBH/Xiat/6888HCdy1Olcekp?=
 =?us-ascii?Q?L0FSS+j1Ml7ctVs8O3+b6/RJy5+X/ilbPOuEVZwYz85jt8TgtShsxZ1lsbxY?=
 =?us-ascii?Q?BYjapXKOm1pup5/OLsfLvSMpZY2lGMWvGWOgxjx0RzQBU+VuihqwWKnJ5So4?=
 =?us-ascii?Q?TEb/m0gQxPdeKq0g0jfc6RlNOIP8ri7MLu9UJAiHeKycNEV1hlAwyKBotR+5?=
 =?us-ascii?Q?USsKZ9XO2wIz/lWTlvsfRkUKTA7jpsap7fVSYh4rqgGfHF5/+7g0KHPK0AnT?=
 =?us-ascii?Q?NpIOxjEGc36CZqtW6yOvrxUu5OZgz8uHqr7qiZGxDUdZNysEBNKgxkvVno3q?=
 =?us-ascii?Q?SjfIdoFu1EejC0/beOmbKb2MEuqLUScsWIwBQHoH55x6S9WIMbRCeYdHEJLb?=
 =?us-ascii?Q?xa9/EsJaYD2qOYKzSMKSHNF8fY9NYYxTfnZcMWx0bz4wlVtJJpXoIa9s+ygr?=
 =?us-ascii?Q?YSMgIhxVVUSA4y6VLYjo9IyiO7e//5hq6MbO+C/7MzgvZT/gu2LT61wkRi/Q?=
 =?us-ascii?Q?wyi7pHrw1sscVKstLaNh2HRctsfniHdUh/hXwuAlHLrg0IRk6myB7BWLzxXt?=
 =?us-ascii?Q?dywvs0EH9G9UpvLDnno25TXQeHNhIOQrD+MUpLQkOYvdM1DQMCP3SlpHkzqO?=
 =?us-ascii?Q?oA6s/9z9kGxRPaJOejcsiTGrLuKwMTXQ/AMdm0X3h9FWhL01WQrP9EDfo7aY?=
 =?us-ascii?Q?Pm5zvjqfqPKmlBMCUNX/QAeGUMB/n1tFp8Fn3t2gexPVrs2ZXBrF80z7ld/j?=
 =?us-ascii?Q?6diczMsqjo0WviMsv791nz9C2789tgRocw9p2WzW4+mm01yKPjdBQqsWSSWH?=
 =?us-ascii?Q?LIYHCW/qf9gbN629iCcFAg/6f53MHnKrUP4ul7EfDnf3a+UWO3unxDhmmSat?=
 =?us-ascii?Q?23BcwTNOKr+XFTU5ht30SBqkQ1BVipNZFKGdIDC15YMTQqLX32Q5rytBUcaE?=
 =?us-ascii?Q?rcFk8EJwhcSO4O7gJiUvpyVA2LNP7Io+wYqPOl0Aj8xhOIyf/8mYxDLw4Ehr?=
 =?us-ascii?Q?24KpJ7cuHDIB5H5KA53G+Bxkrz3eYaUJUafpvbjJlLgIowYCgDLQpYHbSNen?=
 =?us-ascii?Q?Fr0Lsx7Sr6Gydqyb9rsVs/AG+izd1nPFil//PgLU5dsLrmzSjUhKgBiveL/a?=
 =?us-ascii?Q?tGsYw3Lng4BJdCzQhlPb+fou1RvF7HrI+kz5WQ5XqCpEA6mJttXVzye5n8c7?=
 =?us-ascii?Q?PQmr6Sz7j9vF3yQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Sq/FltFUehc1jOnMYpkkP9OSLbyD3dUime4t5+RCagIv/EGy7TAdGes6n/Ya?=
 =?us-ascii?Q?ppwpU4WAh58un2QeRT5rimNSZOqUvo+Z4i9Z0TsFoKxqxpJdwFLx4QOUwoNn?=
 =?us-ascii?Q?J9QAvE8q4+VJ8APVmXuo4dl0jeuBqSzdXJ9Oul3CzzV/lwcVrqiRXPCunhjx?=
 =?us-ascii?Q?pLuiffs9bmJrfwA5ifka9m2tKHnPH3pKoMd5/uMkTTZyhRWfVrcynK9/vsnH?=
 =?us-ascii?Q?ry7Y9vn0TxvUl+4D8ixqW/P/a71THPrnHAeh1rFnRNBsIj9116OebY2QiVm0?=
 =?us-ascii?Q?0tq9YG0uClMOzFXAPvYAGBAjMEbEMnmH3NhsuI7daSCGjiufQ5TV8jfgbXAu?=
 =?us-ascii?Q?kz+YPXO1pwAbkCwEthzxYbfba5fdbHGmqS0YrPBqZISAtEbth6tOb8DmDg/x?=
 =?us-ascii?Q?aIo4KtSvUglw+fX+l+WftSTeoeDWhRTvqRXPJtrYLDqJHxZLn0VaNoX/taPP?=
 =?us-ascii?Q?J5Fnh7DZmkiFK+MflZk4olblYFFN7Ku0sUU4JK3XkKR0HVTN3u21i4aGjQ/I?=
 =?us-ascii?Q?6plGLWEq1iZjQ0uADJOpPJK4QlQguGhnixFIXhbmS0d8Ih2fjICCo+7iDSyP?=
 =?us-ascii?Q?MEAEGpJt4x6sPx8eSSXWucDKimwUPUs9lwj0Oy7ruW8u5JDAUqRkLYPDoEBk?=
 =?us-ascii?Q?bj1ynDonhxEVVhKmhLY7zQnqCHSZG7nUwSbCfIAdbiMAdwDXnlWCe27f0SVR?=
 =?us-ascii?Q?ULp/2/z58uoxJEltyD/HlCzmuUeUDYYunZD9hq6tTL6zb9A4+hvzm0qIDC9M?=
 =?us-ascii?Q?lFWcgOpNqydTZman/7dU7fVopNmg5ctWi2s0DJKCAftMoUvu5rJ4NdS11LsV?=
 =?us-ascii?Q?Q8CE0THGOscHwmUN1Xz4XM5rlfuNJ0mHKfWNzal/7SgAFkS9pnfS/jlz0thv?=
 =?us-ascii?Q?VKEZjSZLYo6FCF03tZdCA+iBB1/lsA2YK0MGt30o23llurAoaGpAsPIz9eL4?=
 =?us-ascii?Q?hGM7FyskFFv4cJBjZDSMmuXnAYeqMMLGa5nwFg9EP8VbB2RafvEg5jOhehdU?=
 =?us-ascii?Q?HCysE0iyiQKo92FcbOZRppi8JhFrIGRqqKlIL3kQ669MHdVnngFk0DJ18sMy?=
 =?us-ascii?Q?kytcCMjH/O/HvHtN+SenngwM+0ZdzJGQam6wAthCLRZkC8eKYnkAYcfleAob?=
 =?us-ascii?Q?KII/ar95zh7BZK+77u0DXZeBIyiz0ecS6NAZP1ESDBCcdLkRY0WhCdEcIPH3?=
 =?us-ascii?Q?iw26xM939DxLiVbXjfjQqNo2xdYWuJdSheg9eOT/5aWMA3O+yd994BVaZwnm?=
 =?us-ascii?Q?JMfGPSIfUsk5s7y+IQXrVuOzbAPxUGZp8pQMWIjJCl1R0BHyC4DYaCXDOSIU?=
 =?us-ascii?Q?XE6GBeRYAvfbyQeBUEVfwCr6IL9k5TlyfayVJEqDEqDzrHN0GnnImBISA3Vm?=
 =?us-ascii?Q?FbmORQeREbOemkCFh5KrKfzFi9Tjyo0PO3IrMrJvXfCiDQTiYr0uVSk9aLm5?=
 =?us-ascii?Q?1N0CrVeoz3XMKq4qrq49lmVUksBgMKwf5eXlW0F2KlkJ4jHcfY1nlLnssyag?=
 =?us-ascii?Q?61Wc1WnW+WSuZct35O64I3TdTGY/CeYVmczdjfWNQv2kpVkplW9rJRx2JntB?=
 =?us-ascii?Q?kVLReCg3dmKok2g16FbUim+ietbpRhk+FPCvXksQ9UebKLAVblfcExBDm6zL?=
 =?us-ascii?Q?crRlc+7q9USGVp7wJ8mevcM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6F355DEDCBBF074EA13D364213350691@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hRRD7WI1tpi9S0PfHurveGHx1iyhfa7Mlazdj+bq1e3hJynIfQhrzGMmoPRtIgnebwDqGiZExQ/NlTkJ6EX93s0YpvCURcKMnk2i1C9xOeYslUM8i0lnPpNWtxaGz0oRW6RgxgSajfdu41ML7codctMoqfHTexRhxZIHeUaL2eYkBSleR/yup26GJQKVIWI4DW9Ymnojfu9fSWoWQjCbZU04zOvBag81ReT62XMqvj6KhjaMPNhBqe6IRhL2UHfF6RVqgdzCfu2YAvODAggHfF60TkWhkuP1+usNmowUYBYCjveFYzIjeXaKEPEYOFHaI16rg1AfkXzHEzQRLunevz+L+hceBVy3xWJqLr4eGp7sNAv4x+U/6hP9ndmHZmyY5YFIZxDA/gW5GrsT+pGZAWyRQtOYRVS6gxtOZ2hZFmIZN8Xgh2l5N4U9XvwAE1I8sLm9MoCKRW77dFRx5w8zFdDN0PHs4slZJY/7O7dvMcgrAUjt8gin5I/hUZzURro9/ZEkxf/Ai+FIHsAbFXrjfJvWMEKDD6cGYD/bOtHnUXkErNwILYbmb8tHzTI6yANukBwNt6lejf5mB455OCRd1cpp7tgv8S1fyISgIAAwnbi1yThVMoOnOnkuCqxsY72i
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e821ff98-5942-4755-3fe4-08ddfc8ec3f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 23:53:45.9827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I0YCWkUCHIx6LOLhdiDVPZ255CZaG7cdHelLByYtrzs7JtBMWfGqSbmTdrCabUEsasT0ogUKK1Vix/wnA9JxeMBrztLdCD7JmVzv+zSAucU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8823

On Sep 25, 2025 / 16:02, John Garry wrote:
> On 25/09/2025 15:14, John Garry wrote:
> > On 25/09/2025 15:12, Shinichiro Kawasaki wrote:
> > > > Let me know if you have a branch you want to test with all your cha=
nges.
> > > I did test runs using regular QEMU NVME devices, so I have some
> > > confidence that
> > > my changes are good. Your confirmation test on the current blktests
> > > master
> > > branch tip will be appreciated.
> >=20
> > Will do today/tomorrow
>=20
> it works ok for md/002 and md/003, thanks!

It's good to know, thanks!=
