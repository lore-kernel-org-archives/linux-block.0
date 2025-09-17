Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C074A1B394F
	for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 12:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758110556; cv=fail; b=QdZ5X/rbjKVYMFZzCdeWi38C4wRDSdGVTYqJv3P8FMThAHhLOVD1jzSVxKvHD7lpkK7WOero5c37ArD2xqBepxNducVNqUktVck5qZDT0/5kpBKG00oP3V2qhXYknPJCa480eu2yxmmOuKDgyWsDXdptrs4khD2XN7PrpyRniPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758110556; c=relaxed/simple;
	bh=pEkWvzkbeozy+b373RILOIs8JhbzJ1v99YhmX+3NHps=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GCttlJb9G5pRG9HmOWPvls6M9GyPm4LBQ42glqGZUnYw8h0+ocDtf2RHs2akAg9dko4qsMQ49lpGwt3TtIQ1Nm1bffv07U0jUXtMnymyNuiZrwzBcax8eIc0d4BkItLLO43FWF/bVB9WR945S3pQh+MNUpZ20DGvJqGR+Gu/eDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QqGhQPVp; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=CRruJr4a; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QqGhQPVp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CRruJr4a"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758110554; x=1789646554;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pEkWvzkbeozy+b373RILOIs8JhbzJ1v99YhmX+3NHps=;
  b=QqGhQPVpkTg+iW+fPaRcImsaC7O4xMosQH0GwCMLdrsvAp1Dh1XkoOJ2
   kLblHajgd2w6YXl8HOWo7cVbBXlSdBbR7ybt56kaFOC7gweHP97CQiLLS
   oyeLAaDF40hwKtSpuMrUzWasM9WwQGwZSyxKfjvgqPfOvC6l9m5MNuFzq
   b8O1WGoUQ9DC+CtirfLbsLkaW6BCco1LhhfHiyAmrLx2HXDEo5TeW9HV4
   PoHLQd+tmFNZH6EhbSw76vxgkT8Bpmy4PCt+B5vYOa0cu113cZ9MYk6Jb
   xLSFiiQAdAKfvrFqxetMV8iw9psSAAaGYPo1g0msjLxdysNvx9vgLOJDj
   Q==;
X-CSE-ConnectionGUID: sZdt1q0rTY6Q3aAlL3kkBw==
X-CSE-MsgGUID: Y2Yijr3QS0Syndf0G/GG7w==
X-IronPort-AV: E=Sophos;i="6.18,272,1751212800"; 
   d="scan'208";a="122669680"
Received: from mail-westcentralusazon11013004.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.4])
  by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2025 20:02:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbKG34im3KlS+rMIb2ancVDql6rK34IEH6fUsCcRHSKIHFVEmtZPzL4UpJtKoVGHxqTA6LZjFu7AnR/zkN5kcGxSfrtVAMHQxXkv0cWk2IiMXb95N4vZJ6YCTC8WhEn0FSAAn2Kp62dpgjrEzCQo43uqDEM2xK8VikpX+lEcY2mBn6qigELwfAFPaJpRrIMeKJPDih58zEsQvx+4okgQRjeeJk/N0mmt0Zl2znv70rLb2edPS6PrF1eHzJv4NLNU39PVg949jie8WA7Tg+XhCeq4LtRVbmAs9BcHQU+Yh/N4FdeVObY8B8/OVvNiJCdx09bcuD/mbWum4pir0amKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3EXAN2+FDpue05yt5Z0mjbDVHKgjBLI18vx5VSnu8k=;
 b=KEEYbJo/pHus9iYgK/oOb4jr8mZWSVbj8esuLnb9eryJHtNgiex0NmwzRYMKrdkT0Dh4uqfrGDjLY+OEVCTSiF16P44LNCihJYitQdgbAvYyAq42Oso/dKZCgl42wYPwEUuafuxil5OutW55Mk6SmR3Uo2pSFey2KutBoIxmHx8Xq9cdjV/dudmBIUBcVnvB6XvNn1UdnG0cxjRCG8RYrM88cSCSaVVaTC/RFwErOXMdslKx6sgXrJyhtVaSyHe2uLUw3iF9zJ+6PUGl7/PvWqmoLytM0ZSM56/zN2BQILV7Rq9w+gEIZxW1HNVx//FYLPEzvljbSiLAoFeST05b6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3EXAN2+FDpue05yt5Z0mjbDVHKgjBLI18vx5VSnu8k=;
 b=CRruJr4aWza/97CxLddF0bugCAljTzr09UBFFQWG8hCKzbdmwHXL1wPdWEZqx1PqDUN6jK6LMzLyV+fu0EetD5tZU+eK5+fEcRc8LAzm8PjzutDuaH+JA3xp2DoUh/wLPk2CYJFvA58WyQfeYTlduUtErJ90tTiHAqCHP6kS0IE=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CH5PR04MB9521.namprd04.prod.outlook.com (2603:10b6:610:211::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 12:02:17 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 12:02:16 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Garry <john.g.garry@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 0/7] Further stacked device atomic writes testing
Thread-Topic: [PATCH blktests 0/7] Further stacked device atomic writes
 testing
Thread-Index:
 AQHcI8u2iSuhaaPAf0qUtMrB+Xji4LSVh9YAgAAXnYCAABqIgIAAB+oAgAABAICAAYtUgA==
Date: Wed, 17 Sep 2025 12:02:16 +0000
Message-ID: <gf3x3fisrgfdeqin2dbjhzxyf4ha5ek33jam3orike6tt76b4f@6ixrvnqmktyo>
References: <20250912095729.2281934-1-john.g.garry@oracle.com>
 <5eri4pgxaqhd2mcdruzubylfjshfo5ktye55crqgizhvr34qm7@mhqili4zugg5>
 <39c9f89a-6e6f-422f-88a2-3b2730b659a3@oracle.com>
 <70d8a0c1-5000-4a3d-82c8-2ac7a76056e1@oracle.com>
 <vpds7n4kuilakmqajzmkeipkkbd3wpehuf2ku66wevq2dlfwnf@wxne2chta3ir>
 <78cddd6e-b953-4217-b6f6-deab7afc38e4@oracle.com>
In-Reply-To: <78cddd6e-b953-4217-b6f6-deab7afc38e4@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CH5PR04MB9521:EE_
x-ms-office365-filtering-correlation-id: 0cb8a146-3a9f-40ef-d677-08ddf5e20bf0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|38070700021|13003099007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?W4eB5eI3VYMnlXb21DbDKQFTorQcNsYDCVXhslISN/DGXZ99IJFdkVkuvrD6?=
 =?us-ascii?Q?UWOInIeXp5FeNsZOG9O5PfwXl1xKZLP3rd5Teo1cWj+MpQe10xT59tcsg/2O?=
 =?us-ascii?Q?kLHQtL+J9OsaijQpsKa2SzYvH9L4+Z8/hBJWehYrZXaE/inNqAFvvjtFuJOu?=
 =?us-ascii?Q?GL/bj1oRL6z+yPh+zyyRqAyhE+WDlNMKzDmSEVg/1gCR3gQ02kj3kkK1hYjQ?=
 =?us-ascii?Q?iWUu2t66snirGNPBH8tGGOhEQ2LqnB5V4/oSLFHuj8R6mC1iNzkrgoKLERps?=
 =?us-ascii?Q?iHDEMWsnx+lyVbwV0XKTt0QTYNLncTPOFetfrpi8BhxrytY0Z0ioq+E964Vu?=
 =?us-ascii?Q?1DZYmBAQ298/ml1/1x0EsCqjm+ALd3s3EscY7q3Biwu4OC7ZqyoaxxKNm8S+?=
 =?us-ascii?Q?UWBpDKC9qeprVqyi/RH4Jt6iztU3u5rhLFXEIsdwqQrWC/mUlJ9Py5amF1sB?=
 =?us-ascii?Q?yy2rUbTgk08xWOkLbjxtyglj9gvXQ7DNmche0bDrJhW8liaAQ48/0A7e2Jxt?=
 =?us-ascii?Q?ZFoYOJLDseEsoTYsAxUBYt/iNsyZLvWwaQJBkK8GUr0S15Agib95In2DuuGW?=
 =?us-ascii?Q?hFs9hZCwM+NTO3A4kA/NgLeUuKBTAjlYqehq8C+GNcLHNKgazAU0StxCXP6D?=
 =?us-ascii?Q?bXi1d0Qn3JLlY3L+nKSId2+U9Z6vjHyXl9KXGL0IdJiDUeshgkG0AqMINmhN?=
 =?us-ascii?Q?yNutG7qMj0T50L9CTYir2uUNZ8o8sBe/3CeFnih4xAj3Da28FkB415hwYfMx?=
 =?us-ascii?Q?CGYEdNx+dFdj+e32vdTAQ+qD5yKiWKzJFVf201RZKKjODXNUnAEmyYTbLFOH?=
 =?us-ascii?Q?FFJnrZSlW+Ta6X7u7U/lwVrmbGMz15Bi+HrroUubWgwpK1yjxLhNiBqVXHbJ?=
 =?us-ascii?Q?A2z6SNlR7TeQGsIKJEHhhIQm/jE9EMbaLiy61Ka/VrEJ8UiodJyuLoCfPxu1?=
 =?us-ascii?Q?UJfsC6OTYn/GDFg23kIu2grx2lFOT3p6rDSBv3PyPY5Q1A3QUBCCrsiuFICR?=
 =?us-ascii?Q?VB+zvgXKbNN01teaHGWr0+mfm3Q+luO2kew6tLXksNtTMCEhTdOlI7vUJxgS?=
 =?us-ascii?Q?bNpj3SfJ0uqRmD4ST4bPBqHIyB4ukCg6IHI62sPkP4k5thrvvxskvNTfH0K0?=
 =?us-ascii?Q?XVIoTZjHRKJcNUzWOXcDfgdzAdJPk9RBIIZPj4JhpL4vO2KwPtOcgKpfCAsa?=
 =?us-ascii?Q?VNF45C/IFp1p4pyk7+YkjuXJ4p9g2RT3tw7tvBGGziTa+VzkILf8nH9f95CS?=
 =?us-ascii?Q?i792B9pFQ2NMTzp206blZ6a4NA512Pko6wqhDdbVhjy3sO6PNsgs5/gV4/lD?=
 =?us-ascii?Q?oDvfJ1cyjcQivLedyg+K7jSWnLs9PkB9fVP+auWG6tuY+GNNRiVM01CY1zLv?=
 =?us-ascii?Q?H8t6YvKR79/LThBmK8y9jZ9ITZfJh32GMBU+pE7THruL1n9FO3PujL0zMmzn?=
 =?us-ascii?Q?IzSNp51EQOA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(38070700021)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?y3LGwTynCIGvAnSV7xJc5OKoBhv4Au/sZa31C4bxjw1SgRDxS6CgFNemJP2a?=
 =?us-ascii?Q?2Qcb0oV6YbV7gvwjovQTSz0+HTSIp0CCvcKncP3C4TH7xm9VPbZL0Eo0DwyB?=
 =?us-ascii?Q?8OvkueZPKP9RqCG5JIBxnl5O1553MIZMTg1HfgIaX6crjN3B+GAM9vwXF2K4?=
 =?us-ascii?Q?LjMNSmRtHAoeumfb/VoRKfHLDX6cf4hAzUxkGLcCt4jy2mPbpWpP8q3N3FUr?=
 =?us-ascii?Q?mGMfb4G9FyXQb2twtH7gJyYxoCyjDmADhdzUtrP6NjgRJcxy21LIe8SGGErS?=
 =?us-ascii?Q?rE9uTn/hliNpqkaDpIrfJKJsA4QDOQzi4qjgVaRo0Yd5Xn6YqMZeeNWQA43Y?=
 =?us-ascii?Q?wv3RLLhNquUqCKaJygEFuIoNi5QsDv5PiD9sLs0R34jb2UFkY1zasYpPLyao?=
 =?us-ascii?Q?XSE0Lw+t3J7xWGPK5UkBJieGcRwAs6xixDtFVfqGoPNTyjIMpaN+fGbW1WKn?=
 =?us-ascii?Q?a+WNwQIfBF4dYnrDOmj/BlVo0Et/n/8Vv90rz1yzzuQOGuxSYjbIdGlkkb3Q?=
 =?us-ascii?Q?XPxrFJUlAUuJLmSTlZWd+XekoczqLMerM8xGKyrya2d7PrTSW7tT690iL3lT?=
 =?us-ascii?Q?p7MFZzEpbCD2Kfsvb321SGaC9tjFVfeyfUnFFLsBab7UL6LERg/bzAlFs016?=
 =?us-ascii?Q?eInGTXqyQO7jkXzDr2e1O0ZbdQJBaWWwUGiySK/qLovDZRl7vNFgJpZ9+ecU?=
 =?us-ascii?Q?fNEVnzhuH6NUcnhN+2Lp2OZVUFXNO4g8nwX5Cku81F88y515AKs0qI9dWSyS?=
 =?us-ascii?Q?Vz76wF+4DzlX6x3WnTLrYgJe90ZpTP4Mjf30CJH2sxIVLz0gx5y5RdGzW9i0?=
 =?us-ascii?Q?xQjMqwiXS169hogE78dt+Qz2USWtoC6A5dSTvqNMlJqH0BpTWrIwTP3+afVx?=
 =?us-ascii?Q?FHLUv0c5ZT0SmsZLysUttY6XqEPaUlH9tfgRB1r8VVgWuoc+v4Fa/FMvLgSr?=
 =?us-ascii?Q?YbCGAp4wBIWPx6I40akI89ajL+sYn9zABhJ9+w+pX/LEG2cRcsbLhC0tGlEr?=
 =?us-ascii?Q?P5aKcyQAbc9bTSTrQLTZnpnk1aT+pNr5rt7JUll3xPSOaYoGNjBQrGSOMuFU?=
 =?us-ascii?Q?rzLRUDvvfRPq22xTf/IZNvE3G/AgdlmNmMovCtwvPrHlqfwURxTiFOjvx6gV?=
 =?us-ascii?Q?6BHR9l2WirNtmw44PSXMP8HdZ7QiOu6fBOpGqDZUjlRiLw8wKIbW8hObh2Rv?=
 =?us-ascii?Q?dNWjJnQymQRRR44ZZzVJcGzSHBC/VJX2LjePf1fn4Cs2hViOzacVL9OFrMWG?=
 =?us-ascii?Q?pG9mAUZW2SAIpkvrpOVUuMcppASMhsHHlru6G3z+QvDPuYGg1vW9HOlgEKZk?=
 =?us-ascii?Q?/UeOdbmQ8s+fGskgkY8JLIMCAGWmHU8vFvnWKv1/VAna0oIbMavj8+AaCrqN?=
 =?us-ascii?Q?hvHywD/FoUbWikJ+OZDqVBT1LvvNZwDOjIiUTWeUzkQIbIrnkh/gBqfTmemH?=
 =?us-ascii?Q?fjXmsD3DCSHfKISYVBW3w+tjItegX4gOC9bsGhQfln2zA9899BdkDjEJmqev?=
 =?us-ascii?Q?bdhaOIxa5DvDQEE282rHVbd+w1Ab3wCohp2aMpSN3rlK1VkUzZ+FV96st6Zu?=
 =?us-ascii?Q?7DwN3jeL+4lHcQfDJ6FTcB1q6soBRACgsLkbCUSBNuwNbIXOjwr9XK6UJeuu?=
 =?us-ascii?Q?cA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C60450591C59FA489FED01651028DA84@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6hmhOLpBm2G1gn4wuSpD2mADkXSxoB0Pus4KXHNG/MPe19QvWRmUK5gephc5cv0lSwL4JSVwZknc9kSC98oVupZor1PzJq5Y1U3ipRWwKbLLlsFaFC7op4pzAGgwj0ZxUVRNuEWa3DQc/7hrVB7+D6Qsy809jd9GNAwLJ8SjJQOTpInm9i4+mlcj4JnCXQOWlkoXvWOaTFXUGw/ppnsVudrinBKXgVDdriFoAw7/d1zX2fgHHpM2hKN99IXL4yK0/PWzQnjRtGTygps9DdUdWqViAU6BluLY/xkJ99r9hkC3ENu1ScusxChyX7VBOFX5XWFiGLhFWueypzvIcL7p4SchzwuZJA+kVe6DV9yKqj4AQOVKh3YUwqY5qTCNelqwII6dT2EErWhAsD/hgKisDjjN8Fwv+cMpb6POWoxk4JNJeFqNOrQW1wEdeZjcrRFUutmIrTXbiiU796YCcWJMLU1yTBmXyr8SVNTlMtqEKm6IYlI/BbpvtaKOMHGFww6xrY7RP0IIN1I2PAneXsIcwWJwECsc/cuykF9gtKKeCqof7tvCnov3CH/vnEmMLXXXbJ38kNtUS1BSGiUESeyopDZT2vKd6elAIb9r/QV5YH/PinJMMnjiQopenr3Sm+5I
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb8a146-3a9f-40ef-d677-08ddf5e20bf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 12:02:16.7683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QFRqQFu+klDrWs9cCatHsgIxyikyuu5uEewnMFeAjOfqSQ5dDd/mj21F6pwu355oSh5M1hZ9cmip2HzK8HJB8/U2ZgYNpYoT4gax9sXAMzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR04MB9521

On Sep 16, 2025 / 13:27, John Garry wrote:
> On 16/09/2025 13:23, Shinichiro Kawasaki wrote:
> > On Sep 16, 2025 / 12:55, John Garry wrote:
> > > On 16/09/2025 11:20, John Garry wrote:
> > > > > also modified md/003 to adapt to the change [2].
> > > > >=20
> > > > > [1]
> > > > > https://urldefense.com/v3/__https://github.com/kawasaki/blktests/
> > > > > commit/7db35a16d7410cae728da8d6b9b2483e33e9c99b__;!!ACWV5N9M2RV99=
hQ! Lm9AlQ3T9qSGDEjCR0nGmjCGC_2wfuAbkP6zN9EfZD7L2Y7mgpKPah_fYZh6L_OPkH9IIxP=
4f9n1Q9dRRRJxbZQeqRtr$
> > > > > [2]
> > > > > https://urldefense.com/v3/__https://github.com/kawasaki/blktests/
> > > > > commit/278e6c74deba68e3044abf0e6c3ec350c0bc4a40__;!!ACWV5N9M2RV99=
hQ! Lm9AlQ3T9qSGDEjCR0nGmjCGC_2wfuAbkP6zN9EfZD7L2Y7mgpKPah_fYZh6L_OPkH9IIxP=
4f9n1Q9dRRRJxbSlcsw0E$
> > > > >=20
> > > > > Please let me know your thoughts on the two approaches.
> > > >=20
> > > > Let me check it, thanks!
> > >=20
> > > I gave it a spin for 003 and it looks to work ok - thanks!
> >=20
> > Sounds good! Then let's seek for this solution approach :)
>=20
> ok, great!
>=20
> >=20
> > Let me have a day or two to improve the patch [1]. I rethough and now I=
 think
> > TEST_DEV_ARRAY values will be test case dependent. When we have another=
 test
> > case to have multiple devices, the new test will require different set =
of
> > devices from md/002, probably. So TEST_DEV_ARRAY can be an associative =
array:
> >=20
> >    TEST_DEV_ARRAY[md/002]=3D"/dev/nvme0n1 /dev/nvme1n1 /dev/nvme2n1 /de=
v/nvvme3n1"
> >=20
> > I need to do some trials to see if this idea is feasible.
>=20
> ok

FYI, I implemented the idea above, and it looks working good. I created a
blktests patch series and posited [3]. Let's see how the review process wil=
l go.

[3] https://lore.kernel.org/linux-block/20250917114920.142996-1-shinichiro.=
kawasaki@wdc.com/

The series introduced a bit different config file variable TEST_CASE_DEV_AR=
RAY.
If you give it a try, please define it like,

  TEST_CASE_DEV_ARRAY[md/003]=3D"/dev/nvme1n1 /dev/nvme2n1 /dev/nvme3n1 /de=
v/nvme4n1"

It also has slightly different variables for use in the test_device_array()
function: TEST_DEV_ARRAY and TEST_DEV_ARRAY_SYSFS_DIRS. As an example, I ma=
de a
quick commit on top of your patches [4].

[4] https://github.com/kawasaki/blktests/commit/fae0b3b617a19dab60610f50361=
bb0da6e0543ea

I will review details of your patches tomorrow.=
