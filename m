Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E0712CDAE
	for <linux-block@vger.kernel.org>; Wed, 19 Feb 2025 07:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739949991; cv=fail; b=LqPZzSWi59kYaAdWEVQKaZbxb6+A1dfra4RHH/xinyWtLbbuv8Z04GjLbRtGWrCwncdqkPHOUvclknT7r2oOZ4M7sxjbMHFqF15LrsX+l2C/iHA/xgAiyWWb1yrBwuqFv+iP3oS13siIQ9NFpPL2ouFpXIfKPyerq2evFiYd/JY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739949991; c=relaxed/simple;
	bh=UqeAahx5JUIntROzByyR40Tee3sBj0rn8L7ijwNGWpc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MMnK68CwU/Ms4Mj7jISdLgu8THEofm/f2m3m+CFRBGmbDV9xnkXsPxRuYOoe12XovwJYzrQXWZnu04xPOqG/Qnz/wCGR918/vHLXmLMZv56Ga6E854yyp0Eb1aAxaBPz9H4QfaZ65bQwhzR9EI5PmtvXBGpGNB8xo8Oc2AWj/MQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cmwPvB/5; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=if1wiR5C; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cmwPvB/5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="if1wiR5C"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739949989; x=1771485989;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UqeAahx5JUIntROzByyR40Tee3sBj0rn8L7ijwNGWpc=;
  b=cmwPvB/5GDGUPsHG+UTHXRSA+0TGdUNtNjpG+QKRT85dlIdNu3IuYarl
   kiNNUPqozT1qKDeOjTm290t8bTVwIaFjhHJEuyvo1lIgeM8+rgn+MYwCw
   KXs2XLRXVCXTsXnBwPDZ5i5c0nqjfxcjNRSF9p4iGbujUUuKGpPjgmK8G
   R9zhmFRH679DXeZ3mIs/ObnFsbMZBiH1xT+htlQXG8JU4HZtSWy223X/M
   pN18M8BxbCZ1ljIi2RCmXSOiRAWomvvo8wOX8I+XMdI/hmea37Jpxk3rY
   lo7bjVvUr2RnT4o/fgk2hjDcFlXQqt9nc9tjPiY7Q4+WUAyKfq9V7xpSZ
   Q==;
X-CSE-ConnectionGUID: 58EQyaD3SVq3OEANVYWMFw==
X-CSE-MsgGUID: q5cTpfPuQEm1B+WBD6oWcQ==
X-IronPort-AV: E=Sophos;i="6.13,298,1732550400"; 
   d="scan'208";a="39860612"
Received: from mail-northcentralusazlp17012052.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.93.20.52])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2025 15:26:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxZs2h+fgMWB9MQk8FhChnSUL12RImfqd5a6VRX/04vQXIP7vtiqQe25rz0GMoL+KLyRczUQ1X8IqoOHJMFbndP1N+FNXjguX19D4L+ijLRHDgMZSsHUyhV/9PbrBJSAgcWJdvlC9gmpqTvUjDY2cEgbkgqkJalSve+2VcOv4G9KmSpsagpa/1aSeth4Pv2K3W7UutOzwufthRFjI8a2gNHxetPqU/dqO8KvVKQNYaHasmpxHwl6/7X0oSrNw9OfGHprQGSBxNI2dUihkPOkXJzhvsJfIsuj2GDyM3UmbaJCcdOwArfRJiUEPRXW9sYU+MbK35lRn8A9wxe8HANoVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsBBlar+1qcDPvzZ7NNXYM9sGIPAd8mo+pjpd4lL9yA=;
 b=xySxpEm4D7WXanAjy+vW6iAlV0qQhXdvYQZa5cTb/j1MNuDdFWHfD40Kq3dn3TBvpziQbApafEFtpgkrgpIRoDuNXq+81eIqBMAT9UwAXq5mMlvDHZ9cw3Fiy0XwT462ZF0H/nWk77o0AuHkjq7AKD2Ds0z8M6ks6dMlZMRjhYmeNjGzW1GHHY/jJuz2vJ8h0j61QObyXT8dgc6MQtI/N3v8unli6VfXstwQ/LDhVrsZvXWeOFAweVCH9pJ7wUy0PZEExLDs2fstf2SJVhlpURpEbbUkhfi8kcr95SayAhRCRuT3HhLyVMTjf/3RYb/rwWwAioj2gHnFoB+S74tqDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsBBlar+1qcDPvzZ7NNXYM9sGIPAd8mo+pjpd4lL9yA=;
 b=if1wiR5CkknnAbtDEgp5heTMKVJEEnpDfTEnaEzykoW/CNoq4nNYVx8thsCrujWTBBPiuMhmIyDPDu/dryh8zL+I27GguOXMJY2RZLZA7VdRo3xUGGCVJSHUpfJ7kT3mEcMwNk06bjI5x8AkB0oN+OHRxwAtToHJwuc86bgARhw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB7041.namprd04.prod.outlook.com (2603:10b6:a03:222::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Wed, 19 Feb
 2025 07:26:21 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8466.015; Wed, 19 Feb 2025
 07:26:20 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"alan.adamson@oracle.com" <alan.adamson@oracle.com>
Subject: Re: [PATCH] block: cleanup and fix batch completion adding conditions
Thread-Topic: [PATCH] block: cleanup and fix batch completion adding
 conditions
Thread-Index: AQHbgp+SxXMtnOmsDUuYlfs8n/vnWg==
Date: Wed, 19 Feb 2025 07:26:20 +0000
Message-ID: <y7m5kyk5r2eboyfsfprdvhmoo27ur46pz3r2kwb4puhxjhbvt6@zgh4dg3ewya3>
References: <20575f0a-656e-4bb3-9d82-dec6c7e3a35c@kernel.dk>
In-Reply-To: <20575f0a-656e-4bb3-9d82-dec6c7e3a35c@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB7041:EE_
x-ms-office365-filtering-correlation-id: 851131de-4ff8-41fb-b90d-08dd50b6b51b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yaVJD0u5oa2ENRSe2RVrivKWRwE5lLyMtBu85PtagLvqpmqRh4OSaq2j4b7D?=
 =?us-ascii?Q?GC9zQ5DPKg+mhvCfypxbpDbcyWVGoJ8WppNY5d10IeCRL+IYIBXuVbSqICuC?=
 =?us-ascii?Q?8wFcV+CRJVCtLbwWbPXQz2/vbwZm0I1Xh8P3ewN9AuDydyRkvJIg7E0U7NMR?=
 =?us-ascii?Q?TgXi94sM3HmPcb2DalsxZZsgw2BDASkqzQFWb6y1LgUtzOkXpPZFFFIKbN0d?=
 =?us-ascii?Q?T7Ly5r6LA7xpA/WQ241ht6M8OI737biKGoWilQHLchlkJPtSgTlyfV4rbv3i?=
 =?us-ascii?Q?5OOJbKxt6Q1heXWSeH8BuuCphDLpSKN6r3YkAjmW97yiy5sxKWXtU3Yoo6yS?=
 =?us-ascii?Q?x5T28qA/CZjZqTyJFs+DjqZoRzHaeTXMbRrSRPXW5yZMySbkf/+EhfwdtbYD?=
 =?us-ascii?Q?9wAmDGFFRkyPe34VLmKGTDsoCMagfl1e48D+drIdzxrzLfE1AyuqzmDRfB0l?=
 =?us-ascii?Q?zkn1gcMjfoS53CX3LFSRNpeb8RdYPTB7K7J2GPBsotm7ASpAIKVDPeALSOib?=
 =?us-ascii?Q?4KYbINXVZp9EmdJzx/BZL7uz90Jq9bPebe5gMUqHzxHm4Zq42Zls1firXZCJ?=
 =?us-ascii?Q?niVVD/NFrNQGVMe27hbrc+z1IBRBmpYHhAnxNbsJPEUkTpT3IqKboxIpH0CS?=
 =?us-ascii?Q?R9q3xBJpieGMkHrF5eomwcShyxJdbOb8GCQJyq5KRkwm1lF2tQu+WoQiJBZI?=
 =?us-ascii?Q?p36spCMs9a8Xpe+0Xe0boOyIQ4293jpH65LBYcGuUMR/QhbZgQ1g4bmO1tsr?=
 =?us-ascii?Q?ysQxIECmilq49tbwS/qWEBBwfTEFve5FB1ernachzPQBWef0Pqz5XBfd4pd1?=
 =?us-ascii?Q?2ocLT4/qH7VzyJ0b4ONxpTNE2OrS4GNitR9WsaRx0LcGRsbBm4cF9AROFwxk?=
 =?us-ascii?Q?csBSb6QatgEAqfPiBc+yW/4ahVCZcub0LS0CQolhz7RxOuywM85I3M/DGIa0?=
 =?us-ascii?Q?ZkslDDDlddidrqbaXp/7Y+jTF+ZmJZPNfgnzSI+qN609yi4Vuh47BnfmaG9p?=
 =?us-ascii?Q?HGtx1hvFXeZwq+vGbPx4NgQZCLczdjU9CV+v+jACIHDw61HeGTOiodvfRSZQ?=
 =?us-ascii?Q?qHdv+V+y3g7Mr+5wsjRhq7+K9+XYyJnoF0ZTH+JcYoonOlEOhM7BjEiqilV0?=
 =?us-ascii?Q?uSmVRMTgvvLv2OCADYCz/iLTx8Ez/0BR19d6WnL5BgyV7IY9hNRGmRmytb61?=
 =?us-ascii?Q?wjQ54+LbD7LlyFKVgcQeizxHm2iABViypOQaRCWLuDaHMg61PQ/Vkr+FNNuI?=
 =?us-ascii?Q?hxpl1ARH9dYX9hpuiLESWSGswXzYrmq8gUr9ymxa3cxCy2v3mHI1BJii5pIb?=
 =?us-ascii?Q?7+BhLmKOZ9oEpeFh3Hs7H3cMX632sQ5xAVhPphnEPiem6SczHcN7Pa6mNv2X?=
 =?us-ascii?Q?3NoCCFY1pLISTkuSfH/4NqGQiXk/VhvYb3+2/kU+/Wgx0esOj8ETCCX/9nx5?=
 =?us-ascii?Q?qsqoGq9t9eUrJUYPIExIngbr8Tv4RvEZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PDWHrduT3EyDzkx/mYwy3hv0oTQQr2hFvf3PBBUks2Fs+MnMv0oBCOeP5r4a?=
 =?us-ascii?Q?6nj3pOBDiWILeXpduN2qNHA4TlDKMgfgELNoUvRc+J/FtzE/V5/TMgD6Covc?=
 =?us-ascii?Q?etQ+A1nYOY1SBHYYIRYMtJzyBLfBPJXD891F7GgpxU/9p7GUNEkef2fTUUsh?=
 =?us-ascii?Q?aRkohmad3ZaexGExnu51sMMlZWvowzEs6r2ZL90KXsAeI7kVrtypvRG0LQPG?=
 =?us-ascii?Q?pTEgJqjsBAl8bJN+0BGtI/AjvWEovVhyQU1MCpVmaGVlx0TBhtYb3TXNY2cA?=
 =?us-ascii?Q?x5W/uc9RKrx+UwmrIuEnPFg9cH5zFNdogHnNFwwQ9rSy+0d6KgpBeqfrCa1p?=
 =?us-ascii?Q?OgrMabzApGCHcfaS2nPg3E787P9az27rEKq5F56afwJyIMhAhylsn2+5Qn0r?=
 =?us-ascii?Q?K+tLKiqqY0likrufYBBC1L7yHHxVof8OvkqjSxnZ5BpLZFUJ3S/C45V5Y1ui?=
 =?us-ascii?Q?e4B/b+Yx6ps9q+oLHv915RWT+gla7ycAgvHY15fcE3aTYofHe3xdqDg6Hijl?=
 =?us-ascii?Q?PS5dtVI3LqhZ4C+A0zk2D/uEJUvs+oxPBzrobl4rbnVgtn/NatAasEnhYyLA?=
 =?us-ascii?Q?zqqb0fkS1KxEhhxDHxDmikAKhkBHazX6n1OKLn8Q9K98aOmbPruRiQdhNnYg?=
 =?us-ascii?Q?JL4djfbqFMC1kT34WWUPTagvXhSn+jtEi5Z4b6x3CTWvlTA9SbToLE8VUJ7i?=
 =?us-ascii?Q?GAsTnigQ+4+ZxR4PRriJrBqepjWce9/2lLLWI7ZJfubWZ1XUOwZei/gZh+GX?=
 =?us-ascii?Q?yZxhsf30JFG0mYj1WbA8ppeb0kp703F6E9mY73BIFztMTg04lbXOKEAIUfAx?=
 =?us-ascii?Q?FR8E9gxcmkRZ8poUoGu8Nghd2ojOnST1GLYXT2vQ6qRgziVRW3LmPJh/v8jd?=
 =?us-ascii?Q?MOIlEAmpx8ESKAZJ2rWlzL9CsvEd0RYkcp4iFkfT/kOWVDM9bTtX2Eb9Zu2s?=
 =?us-ascii?Q?pS3ZW/DNDOb6dOVaBfEQy9Ns69mEEe3wZ9ut6ptffesTL2rzVPobeLpsg9+M?=
 =?us-ascii?Q?L8n0UOrnwBhknQjOCI+SHXHaCIM8hLD+2l7zpbeT7RlcSGvGQnDV9mPa8ZwF?=
 =?us-ascii?Q?SzEW6TAxSArW9sA737RmHbE08wE80rgcds+shP+k8+afXcPbgzMDqpEK2hXO?=
 =?us-ascii?Q?4HThRmoC4WUuxzMK4kLpezOl6+Y17U4no0Ixd6KNlU+jr6CCm4ti+AwEIxQX?=
 =?us-ascii?Q?GmQ+Cbo4T5Kna+76scelEVToymcn7nn9QQPyI8Yadyt09wd7l5Zov2dRd4EM?=
 =?us-ascii?Q?vzEy0cm/h6rwoLJIi6toPiIfZipQfqfesz/J1/O97Oo5/TIU0tJJBQyO+7Ur?=
 =?us-ascii?Q?bfKaGU/9NWQI8PUHCkmEODRUgrIpwxrqm8EDwIGgXGmNvINzBFqVZdf84yOX?=
 =?us-ascii?Q?9r0gzi6OeYuq5ojDtj2QzfdTk4P6NtbAnp7NoAoPx+T590b4jgrKfwe6VSN1?=
 =?us-ascii?Q?UbkQuFLWKN3u7rOD8OemX/mG4kprh6JBa+ZIPq99nLqT0h0yPCYoioue7pgH?=
 =?us-ascii?Q?bzEwBlqZp9BQy6SFOqWd6in0qp6kDGG8yOR/Npca6AcsDhJwaZX+pASMylhq?=
 =?us-ascii?Q?OnwkEOMu/4oJ7pdWamiU7DH2xpZ4Ppkz7BP0dnCc+QdpBfTHh/kcWuiuf4W0?=
 =?us-ascii?Q?c8Lfvo41xyA3xNQNhuW8MhA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <044C6A4C345C624E98BEA433BFE5068B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eAa/cqCJSbC63j2vsa+eb29FkqpJTnxac/ePZ5+SZtvbbwqZetIxOHNTnoObN7HaOlD83B3NGbYaoXTaKQOWXuPZGnp66iDkUGrEJ4Yr4Oo1y70ueFT2JOdMldynJNuuiJRCPjTFlSqqUD+X30x2opBR+OUpEEF+vwG+S8wSbXvUHPChMSEx083V/l96YoU8KYQf+igoMMXNizcqHhmEjKcOxU192JjO4HNMsxfADEbjQ3r/yrrepfxVXCWPHmJa1zj9O6V5xW4+ygl0/R/h3iQppf8V02PO4lkteqEwsXV7oIMJWtPje4VMgw1E8bh0d78zsedfJJaS0fDh3iRe+/nofWtXo5340I7M9jSnNS2Pz9DHZBDUXhSq3Vcqto0u91FKwBEEE4aoZV9Zg4pMGklYdIu1uAlUvXLd8AKsltT0gR1ypHYJ4DEk9ex6S+24OFqXcADJVCFvmGWFG3rcQDZwg/hC3bfyUB+1dGKL8TMgAn09gbVuGHlzLNlNAVHq6eSIchJfR+mFMpZ+bXqRluu721sqh84Ogj2onJd/pQfriDL75k3zuPqImDJEId6L2uuSwR/QjaenSOLzMsCTXGvV9L8QtNRBREWbh5xNOkplw3+upBDx1oiU2oHsaFmk
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851131de-4ff8-41fb-b90d-08dd50b6b51b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 07:26:20.9018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2j6yl2HuogwXJ5STehQQofiY6heaxC8G29X0BARdCXJxPG2MsFfu/erk/Rjr8AZAWPWRl/P9EhZ/Y8avcsbvyAxKGq29bANeBIgXWfOiOyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7041

CC+: Alan,

On Feb 13, 2025 / 08:18, Jens Axboe wrote:
> The conditions for whether or not a request is allowed adding to a
> completion batch are a bit hard to read, and they also have a few
> issues. One is that ioerror may indeed be a random value on passthrough,
> and it's being checked unconditionally of whether or not the given
> request is a passthrough request or not.
>=20
> Rewrite the conditions to be separate for easier reading, and only check
> ioerror for non-passthrough requests. This fixes an issue with bio
> unmapping on passthrough, where it fails getting added to a batch. This
> both leads to suboptimal performance, and may trigger a potential
> schedule-under-atomic condition for polled passthrough IO.
>=20
> Fixes: f794f3351f26 ("block: add support for blk_mq_end_request_batch()")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

I observed the blktests test case nvme/039 failure with v6.14-rc3 kernel. I
bisected and found that this patch in the v6.14-rc3 is the trigger.

The test run output is as follows:

nvme/039 =3D> nvme0n1 (test error logging)                     [failed]
    runtime  5.378s  ...  5.354s
    --- tests/nvme/039.out      2024-09-20 11:20:26.405380875 +0900
    +++ /home/shin/Blktests/blktests/results/nvme0n1/nvme/039.out.bad   202=
5-02-19 16:13:05.061387179 +0900
    @@ -1,7 +1,3 @@
     Running nvme/039
    - Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x8=
1) DNR
    - Read(0x2) @ LBA 0, 1 blocks, Unknown (sct 0x3 / sc 0x75) DNR
    - Write(0x1) @ LBA 0, 1 blocks, Write Fault (sct 0x2 / sc 0x80) DNR
      Identify(0x6), Access Denied (sct 0x2 / sc 0x86) DNR cdw10=3D0x1 cdw1=
1=3D0x0 cdw12=3D0x0 cdw13=3D0x0 cdw14=3D0x0 cdw15=3D0x0
    - Read(0x2), Invalid Command Opcode (sct 0x0 / sc 0x1) DNR cdw10=3D0x0 =
cdw11=3D0x0 cdw12=3D0x1 cdw13=3D0x0 cdw14=3D0x0 cdw15=3D0x0
     Test complete


The test case does error injection. Test method requires reconsideration to
adjust to this kernel change, probably. Help for fix will be appreciated.=
