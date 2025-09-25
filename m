Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F062857E0
	for <linux-block@vger.kernel.org>; Thu, 25 Sep 2025 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809160; cv=fail; b=ZzAlQix5D2BZxoHz7DclCu8WOLlRMQPC3LWn/QrqGjFrAa1yfhnHFBju0quD+beo4fCXZXKL/9kKi9uc6T8oCsnLKylO+//VHmpjXEJhmbLLWJk+Nw4Y+fINLtnYCdf8CXyJcdUaNjsqH6NKr71twzDYC9vYnU4lb79SvQttU7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809160; c=relaxed/simple;
	bh=ndzyFozrLtfs9qLK64NNHAOfaZ8kh93LMQ6OBsREB+E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=biMNMQjVdiQCxeE4bco4OC2ipwQZi2FeI6tDbRSoUjyZTy915Ue5H09LG6PdFkk6/MVJLt9+BuRwXthHLj42ld20zdROYc1sYCTBY0aK8IzLzYc0yb3/BobD5rFUghyxmb5MC4mBo8JQnehr48iCb6G2LPW6J5CkU44WHpnut5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Q+Lffm7M; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=IzGWxZ2i; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Q+Lffm7M";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IzGWxZ2i"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758809158; x=1790345158;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ndzyFozrLtfs9qLK64NNHAOfaZ8kh93LMQ6OBsREB+E=;
  b=Q+Lffm7MfMR/A09uc2k9XoGBtJfHX880R0Jud+xoKD1WaCs9DJwbNIce
   Uc7OYqXXWjXdniCm/Ka218OPcPnWkZdp9mmimnCyPKUnMAsbDu7NLYnsx
   5YbBbFzHx0AvUqSIFoL1lZ+GVyklQ1e1MHeLRtIZWNO2I1+uAYJg88kPD
   s+IIbmR0hDuBCMzppUKQAO9cZhqjield8byJ3MFIMDCGsaxBw82CntckQ
   Ts16ePD/59PY4cLWy0qXh/SrUbKAAXd1zrLjzpcONIBS+kAMJODvXMShp
   X2+2AqFARb7ZmPZtqpP0mhucT0SjooX4Q9y3BDHDrW9fDkS2JzA2kBziw
   w==;
X-CSE-ConnectionGUID: l0qJQtaYTVas+sTXHXbXyg==
X-CSE-MsgGUID: 737IJc0pTJqoDAQuLgUjuA==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="131247964"
Received: from mail-westus3azon11012004.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.4])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 22:05:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkAN2WIe11odgfldJG0HsfDEWK18OlC8wzB9hTb7K513fZRObp8fFYZIKpk3dbYbh8vESp89HJrzhnVERkN6dNA9jpdMKqKXQhlYEL+VIZlPW12tNPuLqwyC9t8piaqK7/ervK+v8Iwaqysi/xeFRyYOfgm4bu4Xy4z5d/ivci+yBJt2wfdJMFNlUDckxKoaAP2ojlHl4ucrq3ZWZHNoEhyl6J0K6Yh3VyEB6vgpYKcnKam8xzeg33cp6Vz0QP+UhSvdE8wpDGuj3jWU9iHNyUJSPcEV6ZBBCL9abs/tLueDp0kT09I4bJTwNd6hNEYwNs3vlIGlTALwQY/ezJNaog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndzyFozrLtfs9qLK64NNHAOfaZ8kh93LMQ6OBsREB+E=;
 b=IcgEOL/4603v9PiJCzQdTlApB1buneuluryQZxRl4DflaoY4mQtSDR6/hUECmW3SIqvtElueHFyicOkWsAg9pP8YDO2OJQ8VLCLIkTUOlPcFVeAEB19oAnGkUPVi+oKfVvhuKDVabyE2SkubDc6nNANGaUmSUyKmXnGHDfy1JOhRr6ZZouUI1Nl4sCxnwYDWcSOu3dzvb+fTJiQnIBmdbZ1cLxIz3R72dWqT0SryWbYDMrLEzVNBLQuYP5Cv5mppJHHtiEDzaF8WsUmvg52oE81Vu5Rv0JV8LQebcpSvMqV6KX5Zh35/Dgf498MDlinDQ0uxzUPQWbifaenSDY0GpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndzyFozrLtfs9qLK64NNHAOfaZ8kh93LMQ6OBsREB+E=;
 b=IzGWxZ2iSWjlXkwNKzpAManZy6tVnEKIyZAnnVDNtrk5xP1mfhl1gvsqbQC1XlzdFkwEaei1kLe1liPK8KbyZy51sELH+J2pkhA82dMCbS1rkQU6jnqJtxeZZwDYrQr6YNfjyI8bAp9LUDABhAQKmoomE0mKA1HJcZ5AKDzIDiI=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by PH0PR04MB8573.namprd04.prod.outlook.com (2603:10b6:510:296::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 14:05:48 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 14:05:48 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Chaitanya Kulkarni <kch@nvidia.com>, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH blktests 0/5] support testing with multiple devices
Thread-Topic: [PATCH blktests 0/5] support testing with multiple devices
Thread-Index: AQHcJ8khBKbKBuZFD0e1Y+25YbzC9bSj+2cA
Date: Thu, 25 Sep 2025 14:05:48 +0000
Message-ID: <fjl2zrgec5nxgm7qf672dduwm7ompzqeoyeg2s6dtfadseioew@me4yjtclntgo>
References: <20250917114920.142996-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250917114920.142996-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|PH0PR04MB8573:EE_
x-ms-office365-filtering-correlation-id: 1e616514-ccee-47aa-ba00-08ddfc3ca0d3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OWUC1OLg3xIa5jKg6ssN8+PSROc26wzDfQ4ku+hwrD2EBqXwXN4WcJjOAnPB?=
 =?us-ascii?Q?TOy1X53TD1EPu4X+zmUOFQi/eFwoRb3KzQUnkpoGHY8MyB9Vvn+BBfrl/fvR?=
 =?us-ascii?Q?cgbCFTzJjmw7XsgIrRZBdQvQ04fen51XIFvwWE4FwGkr87sB0nOqgOyU27Z+?=
 =?us-ascii?Q?0YwCop5fRad1gYf165ZHxV9qazHW/nXkZZk9z2GHInd9qwDJAib/UVyrPraJ?=
 =?us-ascii?Q?9SKS2dgIjDB5kxpxb9Ml2Tryu8sKD3PS2vawFJ5JZf7bqCllt85jY+M3bPkm?=
 =?us-ascii?Q?pCQEIBSHMYeWMH9bLXe7BHXYKngZ2D1DByL3FKd0Ae+MkzQViVZ6OZfmevGz?=
 =?us-ascii?Q?oVluPTeqKA2PyUCYbCByXGDxDmVC8STtwajCvNBVbT4OdJW5JFBzdoN9jVGv?=
 =?us-ascii?Q?dgKPRiZv4XDM5SVm2UUrnIb/fQBsLKiWjVRH4UVUHFc/5CIT14Q58jjP2klm?=
 =?us-ascii?Q?nVdvNJx2prLGM6TAveWaA7ANQEUVTJnwH0u3Pj7WcHvTULnTIeeaYzd73NeB?=
 =?us-ascii?Q?1A0cUboLIeWHSPzPeva6VGGeRzOfxiIplMiPAD391BRmJBeArQKJgJTl3Gll?=
 =?us-ascii?Q?ijkjiE3F+nvJVOdoajv3QqB8M35JAi+RStZxeRDcYOx7FF8hEfk4/v0O7s35?=
 =?us-ascii?Q?F3eMMv8WcwX+mU8wmInq79060UOjvpfVkppQJ4gh0ga/upERvganTYbTzkMy?=
 =?us-ascii?Q?BQae7CYiozrgtNRW76hsF6QD69xC9uggHbvNBkCaBFjRlh0A7By7cSknYISJ?=
 =?us-ascii?Q?5fbqzIl4oSSW76e1epCuTin5jvcwuy60OK2L3n09sGWP+3XDJ1fylZTpc/f0?=
 =?us-ascii?Q?7YQVQ7Y1mZKv36Vp3k/47s6RVrQR681LaoT4AhMpL0d25ZSz8cTlfAHh2pRR?=
 =?us-ascii?Q?ruEbxzO6of+xBL1vsIooSQYeyFPrvb2u9cZ25NvROgn0r8Bp41fcbKdqVbYb?=
 =?us-ascii?Q?L1m1XPJn0PuxDdxfdateyxCDmcWL0Kb3DXzo6RY6plsGH0qXEs5xrxFgjPoa?=
 =?us-ascii?Q?+YMKtjxKy1WpdEzsENty6fYnVvlHcoTY3tTZwna+ZtPxbp1wJwAhvx7vTQzP?=
 =?us-ascii?Q?vC7f8o9aLdsZX4GlJSPH2zELixlcYSu3gBpfY2er8XFESrmaR1QgDSDQGk0b?=
 =?us-ascii?Q?LtrqkBRR0fNOuQLKRwrXkaTmTHkmcfJaXmkEtneIqlaRRofxdJlSBhD8KwA7?=
 =?us-ascii?Q?C1yS1+sn6hTgmDDpRIIHXWnKmmdKJel/sSMQ4q6nSt88aWCMntgFvt+Xq6bi?=
 =?us-ascii?Q?Bpi+WSeehXFQNZ2iUdnvj74zIxU+mJcIzNGhh3mR1ixkdDNL/+1W4cAOCYtC?=
 =?us-ascii?Q?VqvAMYmDKPgG5aplQZ+4kogxbwqkb1snbZkW3dps9jphA/ywYM5b2OHWZ0cM?=
 =?us-ascii?Q?pUwyViqv4Y4hPdCKW+6BUJFV1n93M8Bgc1F4DiST5tKwfWzDkKFhY/YN6if2?=
 =?us-ascii?Q?4Yhwx28C9/Nkd1vVpnPA1rsJjUrBL+jJ9fGmrDb88U8Yx6lcDH3FF0BkXj7i?=
 =?us-ascii?Q?VgeDKIvMPnWTSyE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VlwW7u/aSUCSx/cCwTBO8tWCi62/ghyNXG3egeZqN2JAc1GGWLLRa5PsOMQ2?=
 =?us-ascii?Q?8oXZcmzgZWQtWsQNGVPzz6Rgf60+oje3+UxnUZG9lTR8GQsvd0V+GXY4zOqj?=
 =?us-ascii?Q?3X2X91XHPzyu9zVEDjZpDm7GqLh8Gds7h+BNNHhDK9P/3G8sLr01KeqyEp91?=
 =?us-ascii?Q?JJ5JDBp/eIN73smupZLrlUYPMLEPilPQw56BQg6kQeGU4elK/ewNqad9XiDM?=
 =?us-ascii?Q?sx7JxQspnU6wY+Z4POKjH1Cofgo0937bQQGdmVRxoG2oWv3wrkH9IeheE5La?=
 =?us-ascii?Q?mOExyhfjKjkO5DLunJsDagJbLQeBJpdDbgyx9rHb0AqsfHxH3nj0d66lALLF?=
 =?us-ascii?Q?s0/RSaaEUj9YxVV/6Tc0wET+6MPa3AMZF2hYyh6UqwPbOCdNwL2ZkTvbas7z?=
 =?us-ascii?Q?8aY+j+qjcTdh0J3smMedetxHa5u1n7d0bamVUveJeLEkJl8VXeycKqvKQ4JG?=
 =?us-ascii?Q?H32hKC6WEOB3zsFvL7+HXVRjEJeEeK/68DFkWZIU5/a0ylfdpc460KvHhy4w?=
 =?us-ascii?Q?40POCso1kD3vAphyDYO/VY6cukicGy7JzYQ51hezH83hiFHYANftr3PBkzSX?=
 =?us-ascii?Q?4NoDkxfd7l/m89qmoPWDbwmN8yf+vgkwbTWODzCNFw4WM1CxgT3a0fTs4eti?=
 =?us-ascii?Q?jtKFZYOpOMYNYJ/HW4VzVKze3pj1RnpfSRaPiGZMcZ1ia2+4l90C6y5AmjoR?=
 =?us-ascii?Q?eFoSMSUTYL9AfeSa3TVn44zl/Iwg7OFFPOm3QNCKuPbdcsI+BWJlwc5yAMRB?=
 =?us-ascii?Q?xENCCV5kFceQ+4eGz3CaoctSPOqyNDa7Aeo1kuufHqeV0o6aPbeYc6iTRjFN?=
 =?us-ascii?Q?MmaqDHyqVj9Hs6EZohRio6Yomk/BbrBCEZR0u0Y+zm3Ig0MovX1SPOzgCG8y?=
 =?us-ascii?Q?6cCHujLbdoP1Pu48lsfnlMUaEsmvh8PuW7ujj+UbdiD0vxaeES5qxRv5Pvl3?=
 =?us-ascii?Q?rsJHizdAu2w/J7zp3tJF7ln71qbOq59zmPgSMgq8u39lSBlcvIYxtDCx/Rf2?=
 =?us-ascii?Q?lT1wQe/XHo1394uI42KD4rcf8sStnSYAidN6v8XyRB/wQM+0oAVhFjHmTTBt?=
 =?us-ascii?Q?wYfJgaCHdLRRSLQHOASRf7/vfzUFh90MbCOCI8EnhU9KeUi8oX/frLjRR8lF?=
 =?us-ascii?Q?RBvpDk6YhBEz1QeUGCTFQzlephQ/jvnwHsapnKxwciGVQyeswyEbxR6H1wqu?=
 =?us-ascii?Q?GwXrFTHHeuUNShJ8k1GgmZ4aIsSLL+FSavXKVofZIJCfDFM8EdvaFF0ynQDf?=
 =?us-ascii?Q?OpyfqTmvhLyozMW5lwkNmh477CYATPDloPhhN5+aF6d8B4lIH8ewpmwelrrd?=
 =?us-ascii?Q?GtorbnfbFMma6oDSyXJ4b35GBnAswXjMlKnCO2aIE8wcHa4na3BPsHtyQgYx?=
 =?us-ascii?Q?Uyr1zNTPLu0kRKklf8Hmq1rlERGYTcnLpLU5rSDCaKnur/o8Mfu10v2aAaiX?=
 =?us-ascii?Q?GhpsQc5acX1XErwpcyMk5GSS5yRY1HrTc+zqg0IG93HUJRgV+fUhPP6h+916?=
 =?us-ascii?Q?L0uQ9MMNyKxirOrZmbQF3nDNA8yjdLsduHbxJpUtH6obA4xdyYTTWgZm8S1V?=
 =?us-ascii?Q?mOFWCmAk7V2juXjdZtMz3r1nkA2KticsjvDAOD8BDtcSnUewbJ/0oFE835R2?=
 =?us-ascii?Q?/i6TqEnaBfpXi2k/bXV9FXw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <40546BE6F5D3D84CA146ED1A16A39CEA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NwU1iOr99CWS2SaEk1gvYIEu1ZeJwtOp6vEd7X8L20sD7qSD/Nyz/Wfa7Umo4J4nsG1WVP1gzRgwaqyYkLvZLtufjSEs151TmPe0fwEQKj2xJi5kUExyRBbwrgrUW+Gl9qgOYCA7Ji8pjmAg+lnHr/2oE4VdEZ+WyBESvwpbeu9CkBb7RDNI/UbxWM4Tn7DU8RFqgvy25MBUZ70zA5b0NOD+W7JoEvC6BwKH7cBvJlqhUUZ3WO9/MhC61m9wN2a+/o9Bwb60J2uZ2sBw6Ariyplg0YuDEwhqmpwS2v4z/zsV86LahINYDJHYke+U+wftDuczAQvD3AdCeeprnaqi5AffG35ixgkN+LSmFGEY+DSnqTfujo77s5grcz6g8BraiZzoOyb9+lW0jqlv9Ei+xqT9IRV17fSTr/2Nv7GMxrrKuG60LZhwJzUbrQ/0JlVZ5pXtwQQVUMCdGPNk95XnW0zPz1Mq1jpeI65avhRN86pHzfmDKIwAdoLcwL7u4gskcpXNbFxxlnF5aq5NImwCIB0q9ji5+D9YUL1Nk+N7ENpg/lmcVjshHllfixDmqwAmzUE6+hOU6MnDvvnShpxU1AUWdo83U1mapB/58k+tAYEIxS6dMFBk8Ty1JL8fpUFt
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e616514-ccee-47aa-ba00-08ddfc3ca0d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 14:05:48.2489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pITsGcegMaCM+7FKASiO+LONM9cHJEuV2x8Ty88jpfDoqiHV2knggoN1tBcc2fPPnElR9xrGOUC8zGjpGYcl9JsSfI9qocc/OetWiYHYL/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8573

On Sep 17, 2025 / 20:49, Shin'ichiro Kawasaki wrote:
> As of today, each of blktests test cases implement test() or
> test_device(). When test() is implemented, the test case prepares test
> target device by itself. When test_device() is implemented, the test
> case is run for one of the device in TEST_DEVS that users prepare and
> define in the config file. In other words, blktests test cases can be
> run for single test device prepare by users.
>=20
> However, it is being requested to support testing with multiple devices
> prepared by users [1]. This request was made for atomic write tests for
> md raid with four nvme devices. To run the test, users need to prepare
> four suitable nvme devices and specify them in the blktests config file.
> But blktests does not support such test with multiple devices.
>=20
> [1] https://lore.kernel.org/linux-block/39c9f89a-6e6f-422f-88a2-3b2730b65=
9a3@oracle.com/
>=20
> To support testing with multiple devices, I propose to extend blktests
> framework. Currently, each test case is expected to implement test()
> if the test case prepares devices, or test_device() to run the test for
> the given single device. This series introduces another function
> test_device_array(). It also introduces an associative array
> TEST_CASE_DEV_ARRAY that users define in the config file. With this
> ,users can specify the multiple block devices that the test case with
> test_device_array() uses.
>=20
> The first patch is a preparation patch. The second patch introduces the
> test_device_array() and the TEST_CASE_DEV_ARRAY. The third and the
> fourth patches update the documents accordingly. The fifth patch adds
> meta tests to confirm the functionality of the new feature.

FYI, I applied this series with the fix I commented.=
