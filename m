Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80C21CD15
	for <linux-block@vger.kernel.org>; Mon, 10 Jun 2024 07:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718005658; cv=fail; b=P3UxI9ihNRHS54/sme2UrmV5+TdqhkHBukQXABAwIvqhsr5aK6jj9bvjsGcJr3koT3aqZgWl1wk/GnANrx6oz8Jpj2FRiJyVR6JTNSyoUitPUmi7Yv6KDBCk8o0sTOAh6zl0nyOsGUIvsm+c5H/AqrCgLYcDrLWIGfRrKy0zq3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718005658; c=relaxed/simple;
	bh=XevA11tIZZmB1BN34iJ3n+zH1Y5j47SaCorme3qmEHI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SIepXb6i1fKGLQLFkjpDkkR0exVJcq/8WDmzBHmYlxtCySxFavw/7NoMC+QPZL8rTJm58JSsFagQrq9hDhg93ztF8dC+WQGUgUq+DWgEYyOIIbOQfnM1U/y4frJm6pXA9iV3AMcV/ztNIhYUFhZwThQU5LXJTbJLzc3zTiNCbO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rd4cQx9S; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=SoLtl7RY; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rd4cQx9S";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SoLtl7RY"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718005656; x=1749541656;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XevA11tIZZmB1BN34iJ3n+zH1Y5j47SaCorme3qmEHI=;
  b=rd4cQx9Sa3RIjVw0UdeWkONETiuT12iReZgFzh4C28xq6vDmXavF3k8G
   H9RjOW3qibACgsdtdjsD4WHaQfJjoCH0ulfAcGavP3judKIKFhlhKdg2h
   Z4CDEz40yXOd3sG9+q6S/joVCtSNE4zKjQvpVyFOZZZqYx+V23AgIo1+F
   VB/Izj7d+QcMjjsxp+f05oRP5QT1+wIIYBCANF8uK2yFvrGwpkWVXvyJe
   WP8z151V0musk37sBBm7tqVunmBYoll9XkVhnZuh/ppeqzhVI7MqQHyag
   S+PQc79KNWs3PB7fXhGDVFlEu7G3oxmKtU3Wxd/FKOKaS6yVjPFejWWuO
   w==;
X-CSE-ConnectionGUID: B6wXlgDcQvSnSbB9+E77Gw==
X-CSE-MsgGUID: PsN/7V9ZRe2fAfdJo9NtjQ==
X-IronPort-AV: E=Sophos;i="6.08,227,1712592000"; 
   d="scan'208";a="18723548"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2024 15:47:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIbqMH2tmCGp2LZvv5puFOD2bVu7nGkh4ZHJvMPoM+z+NLPP2gRTHKjY2C52ZgqEFPUpTTmQI9g/dwDVYWx60OMwymEjytQPQVhcVCiIdaXwErIIBZYIUKauz8vyN/HyomPgPo0eJZ1coQSSEDto042behnq7qtDh9PzoGVrvm10pvDu/aAx7cmJWuxidmEGKjM7GsGECCqTMJvW/v7CNkPL5QOQ4d65a/vzqgVDoM6XNTQAhkCYSxh9rqm2YYb/r4bVLNTDrM8t2czBjquTeW0x3BtyqdKzaA0mmM8+00rkYtOUsny9aGslqg7DZ+M/wcDYYNB14c8CoJOp5/t2Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XevA11tIZZmB1BN34iJ3n+zH1Y5j47SaCorme3qmEHI=;
 b=E9+XWbGhAzxpUUtL0oS/GzokmvaQg0FtRGWMT+igGWwKr2z0T2XijnptgCK3kh5xkj10Z3JzDcuPq6EoVAYVr8wHTWq5Fziq5GujhXrKwXCuZ295cHulSCAhNHEy+qIeuu1FdcWMiiVEUJZ4H9FzgqLtIp5L8Pf2xVvJ4Wci+dZOL2WF6nywzw1qO0f20bV4pREhpax4w4XaTlIsEboX/uhS8xtTpJBOv0eA0qC2rKIo9Rrj0kNVFztXlvAnFp9CIMqpxin+QWaDnW7UQH9qM+OeQO9Nk/IEMlHFIh1cFh1V5VAsj7VAi9pPDcIqkLCm/kmKVknQnofZBkAbDq5EOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XevA11tIZZmB1BN34iJ3n+zH1Y5j47SaCorme3qmEHI=;
 b=SoLtl7RYj80SEIBGG2K8RVYc9j9ohZPtlcixBzB03/liF67Q1kr3cMG0Dcxs5sSRBYyhmOK0OklZ6hzsD3PkzQWf31WOEg4CCA4uuLtl7HV5+0PDYP8Fne5zILU/N9kjbLYet7Em22ZN/pcdDJJdZERO5cpJSescQ8/mAfqXSd4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH4PR04MB9411.namprd04.prod.outlook.com (2603:10b6:610:248::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 07:47:28 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 07:47:28 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"chaitanyak@nvidia.com" <chaitanyak@nvidia.com>
Subject: Re: [PATCH V4 blktests] loop: Detect a race condition between loop
 detach and open
Thread-Topic: [PATCH V4 blktests] loop: Detect a race condition between loop
 detach and open
Thread-Index: AQHat2P+Ro1b1U/u0kSTKICB4pZR2rG6P4MAgAA0qwCABjHqgA==
Date: Mon, 10 Jun 2024 07:47:28 +0000
Message-ID: <6ndmnkcecst2bgjidbioby67w622brllbe4ko54sg2rnj4yskv@bb7xzj45izh2>
References: <20240605161815.34923-1-gulam.mohamed@oracle.com>
 <ymanwmgtn76jg56vmjbg5vxcegfng2ewccgntmtzskwl6qx42d@g3iyvqldgais>
 <IA1PR10MB7240BC80176D4F5729CE27CB98FA2@IA1PR10MB7240.namprd10.prod.outlook.com>
In-Reply-To:
 <IA1PR10MB7240BC80176D4F5729CE27CB98FA2@IA1PR10MB7240.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH4PR04MB9411:EE_
x-ms-office365-filtering-correlation-id: f0ec0cc8-a6b1-447a-3fd2-08dc89219387
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?N9Ufdeal+hiaMY33bick7AtxlyMkpzg551lN+y/EJN+4ae/jcNJklYifPm+m?=
 =?us-ascii?Q?FmkLy/LBl6hlh+7cTvQITbNokPWCoe3e/4bGQn8P33j64CsDf1PLoQwF6SxB?=
 =?us-ascii?Q?SRiAsX5GsIwvnOBuaGXx0vtWgTAsg1ZII+x4YeC+rYxbs+KxmzEiCwz++MPO?=
 =?us-ascii?Q?rkGH1GY3htK4+q96x2XwjWA9f38KyGCYBMhDdJiLeTarIHb5NyFyjtMvDphg?=
 =?us-ascii?Q?mpi7N97BUfIJXruKHa+FcDJWvVVzVeE1J84gKBJgK5+LRrJkUOMfjr8AXz/f?=
 =?us-ascii?Q?Dg7luuB4EC24NO2UJLypN3jrIqD8tDbnkinG1DwWwAr5A2EBFGL90mfTA8o9?=
 =?us-ascii?Q?cOfhnms76prWYaYQh1ttEUiis6qSAy1NY8rKzSxL7ThtnkRKhvHUmfnKJxLa?=
 =?us-ascii?Q?KLNgyoRcu2G+f1o9kSoj8ePanMfTKxllSmFZm3eCJc6nevz+Y3fBHuzB3j/p?=
 =?us-ascii?Q?Uxs093Ax3pH7w7qyc0mVTuxshAjdwXfCEjBi+A96v86YaVM/rNUEL+BzVMa5?=
 =?us-ascii?Q?V2Ia96oxo160fX+hG9CExWQoi0tLG8dEhpzqQ9yNi6Si+UAInIA5WnykxoDp?=
 =?us-ascii?Q?/adXHph0P55+M0LQUNfFNvNBd5TIk6JmpvhGVupzl5lgxJ1Rsck5GdTu2OxX?=
 =?us-ascii?Q?PvxXXar+tXq8KkKSRHEMAqrTFPtQOrFrtutIhHffUNAcTGUOuRTIKJz9/j6b?=
 =?us-ascii?Q?ki2CyMkHJ5rqncYslC5YJ8OZwu0NvoF78ew7W2KQK9wUF0E/ofKNTpzrcJwJ?=
 =?us-ascii?Q?w2OIRc31R43GJPU0UBpEX44PzL1gcJkUz+1Vd/CLOnkMWctvkIPI9qzMYKVU?=
 =?us-ascii?Q?+NZA+mhkbkte31Nhf8b4u0SktSq4KmJHMBPQgOJRk6PYcnTMo+cv61uFUb25?=
 =?us-ascii?Q?PlRZ39kSzRsR0SM9SvG5jSuiEYFFR8IDJU8Vc0umjfLwxq2Do4PUadiWYsVq?=
 =?us-ascii?Q?ykRjjNAvd4IkYI7y88rl1+JNAht2jKj8IIB+syicsnWJsBWuSZgpCSkWstuW?=
 =?us-ascii?Q?dEvMdLZIJnAQEuwHGqfch0YlFd7BfYtyxGbhZdIUSEv4lndyI14K7uD/tBJ9?=
 =?us-ascii?Q?H8mrsI2f5d4yzSegmC4Gv25hPZefKhGcZgf6Uzim/Iwgdz7BPfN7zBJhipG6?=
 =?us-ascii?Q?7mafvAlAhKYNh4Su1oBrFhCA6Hk+Y+4R4I40Jax2VQPKFUJR46/6TbbgwgOU?=
 =?us-ascii?Q?vbxmTrjzF8QC9+J/Jwzj0+8olBoTNEGWRtltDBzQwK5XlT7p15lUsSYZO13o?=
 =?us-ascii?Q?1Q8mVUFRzat7/cJ5JIDoksVT4J/Wg4zmVhp+I7uWY24Kw9hRuyHPwIltsXV9?=
 =?us-ascii?Q?q/sXlFapmWBSFWWdg96QziQZa95QSQ2z0ovJCCXJWIjixwqvhHy/D6MOn/N3?=
 =?us-ascii?Q?tRQu2qY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oJjkJqO+r+BFqp6yOw1rqhLPBhbgR4qg9074oL8uXcGweQVsLXh1JjjGSkZb?=
 =?us-ascii?Q?QqvubiBLN8XKU/6wVb4RIq1vDxI1sNk9Y9HZtWN8lhySXgjvzZ3rERKU+4t3?=
 =?us-ascii?Q?Q/cbErIQmVxfkTWDxTf1IYHNKI74ZQH+3Axf4TccIxErWR0IcqHdukcxGNqE?=
 =?us-ascii?Q?R4VyA1amL3K3vohLAiZ/r3x82TnSjRacihzQ9fHA5jkkRPKGdHC+57tfwedj?=
 =?us-ascii?Q?YJLQpO6CVBYB8ZsnxLBZ6RnuE978NvlvQPOxWh436d4iERy9F6TA8IY6+ylz?=
 =?us-ascii?Q?cljogR8n3BHcFyrK2FPmkoL+CknEOnn8dJ7AlNa60XTznlUvRNw3Wck1qx7g?=
 =?us-ascii?Q?4V5lSIkAiHQavRRS0SJDMMqNWY3czNsxqW7dV5AmV/JclGmvG6VNJeMjG4Qv?=
 =?us-ascii?Q?cAF/aaTBRU3HbLsel6AmfL7w0WYQpXC2N1W3DpFXDwSN2EMYL2RkIL2OR1HY?=
 =?us-ascii?Q?Citanm/3bVNXHFLOJsYdJa4dU38vZntNJ9vBeFLu4gwrRZm0ckHIxaNfS1zt?=
 =?us-ascii?Q?o0C/f83LDe+Ofhn01rIbebIIwDfHgV0F003mjXuf15uMC0UzcwATL5sH87W0?=
 =?us-ascii?Q?n/ew+bWEvGvhBKoXWk1v1cXf5Dd8PxL7S1Mde/BloK6BP4kX4vxe7JuBPq2B?=
 =?us-ascii?Q?tHZaQEjiFvyJbp51z5QeZBUDU2yRxybftqjQKzRna6N39B2q4/5GvidtVyoP?=
 =?us-ascii?Q?MbJWPjKalkS/nIJy/PZSCMXnIioqaufY1od0wHQQ+6mFOvtVgnkblNc21Ev5?=
 =?us-ascii?Q?spFOiNXIuE1bXLBBwuRpf+lYCdSBOeSf8P6Jsac/Ob2DVJ45N7IsMsF1G3ie?=
 =?us-ascii?Q?mJxYRyXX7tsM64/63eqoz9PkyKDka/rghHzVQxq3NmNsdMI3rMinELzkrpIx?=
 =?us-ascii?Q?RRufMtlk5BeVGEnMNQ+aG+N8rlUI9WCzVkZkMiY/fvN/U/ByV2cZMWvr4Xyj?=
 =?us-ascii?Q?Tl0mdtfSVPzMumXBLlF8VxWUEQufCvKEh/t6+1CHDxiZ8BrE4STOatjNaYmE?=
 =?us-ascii?Q?6JwsE2zUiaTgKVGm6cmFAi998XLG765BxvoZPbAMuLQphcTzEa/kZg3l3/5S?=
 =?us-ascii?Q?MbXdhYKDaXUvBuAdBPsLDFJ7xTNUUQnplGQ+azrD3VBdvWRs4NTOAcnRD3KP?=
 =?us-ascii?Q?vG+oq5N7JhVUIiEIqnu1tZH+jDrQAfgTgX1ojsmalLzXmFUWQQg8wjxAKtKw?=
 =?us-ascii?Q?NVF8ABF/qBxDseYBD//hTOMNvGAGxlcVySYVDxL9fvuXwfpalj2rONPvqzMW?=
 =?us-ascii?Q?UwTByT9+zTHQsse6f1dEb+yaqdMekPpIYL3kP2pwqQ7PF0ETP7TndIHj0oJA?=
 =?us-ascii?Q?x4rPiwN9RprDwaspHMNwlwAHhdooSJiMgbuGH173Mh3OOVJvzapUyA5DhQD7?=
 =?us-ascii?Q?1H7gSmcsUcXpRI7dCBMMQqo4VvpDVphMEVipBkqabinf1ODnC80w8PC5lGbt?=
 =?us-ascii?Q?ZHEDYSE5GV2a/9/iJBYxnGd3OPCHwYZJGlsemfEHCa66VSPFhp0KruHE/1Gu?=
 =?us-ascii?Q?q7Eq5f1fRhniM9Wav0aMI4NlfWKL8LpNqF75moiEpaI0iQEpTAt7Cxbze51R?=
 =?us-ascii?Q?wlL8F3Ar6AMx1Z+xDLj7Y2e35jksO8HT3KyDRU5OMWHx778G9jvwhZDmpvWd?=
 =?us-ascii?Q?KOvR/9MZIroPf3xKvcv9Xvw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9CE8237508D35A4795602C5DB2080C61@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Urloes8EBs74eyd70KrixhCEGKKQf2m6sVMKrg3XhB+ygyI4k5/e+8i+aBQdYMuJMGTLs0QnOc385ClKxx5fTdeLXaFtqqRyJszPNg5kFJZvzWvh1qnlgDmwveu6CIPWmeKnwlOYzo0upom/caI/UZ8Ks8N9SI7XrHJkVE+OhBVVgTN56Lu+Zw/x+Nm3XaWXTRwiXMY6I6k4D9q2jMm/ff6p9sdmYLYJ8cxYa/ojBR1vAIv4dO/4Z6mmLRciC43QQgwh0tJMiFSDEJ6Thk31clMyy850Zt3FJzCiTgSTjhsVpLBH8XB4ZnJmS4jQ3RLF/481JBEgQAnLvWi5rcHB9fKL8Czh5xrZVCqf+H4A16WpzGpPtTeK7Rma+dVcdqo5hmoMDgIyl90SwFUhnuxO8WiMTkfiSFt50iwSjgDgXcqVAaqYTfeb0IbUr9mfgCzdIVNxeBJlAALMrtuRqsJDtb4M+gQWKlAqMSGcjvVnhoDstI2nya1Jysmh8bYCDfbfItKf7Uo6GgNZkY8pSUQ9Yf7Sbpd7X6fMoQNf4CtikRuZrsinq56LSOMbIpnSyu7CChY3D+j2lTbKejrOo5oqX2Gw9ydNTRLeWAXRVUk+J6xwY+1ZRHCtyxZZmioE8lKU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ec0cc8-a6b1-447a-3fd2-08dc89219387
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2024 07:47:28.1491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EJs6mojrHCtxZBFcvXtnhZZDgdHdFGRs0RhWjpeY23aMRq2baaxexhrIVArkdSGubU4y+P6j1FcAVlDFEx0Qri6q6I3TkZ67jWOZtcsKCQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9411

On Jun 06, 2024 / 09:11, Gulam Mohamed wrote:
> Hi Shinichiro,
>=20
> > -----Original Message-----
> > From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Sent: Thursday, June 6, 2024 11:33 AM
> > To: Gulam Mohamed <gulam.mohamed@oracle.com>
> > Cc: linux-block@vger.kernel.org; chaitanyak@nvidia.com
> > Subject: Re: [PATCH V4 blktests] loop: Detect a race condition between =
loop
> > detach and open
> >=20
> > On Jun 05, 2024 / 16:18, Gulam Mohamed wrote:
> > > When one process opens a loop device partition and another process
> > > detaches it, there will be a race condition due to which stale loop
> > > partitions are created causing IO errors. This test will detect the r=
ace.
> > >
> > > Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
> > > ---
> > > v4<-v3:
> > > 1. Resolved formatting issues
> > > 2. Using long options for commands instead of short options
> >=20
> > Thank you for the v4 patch. Looks good to me. Before applying it, I wil=
l wait
> > for some more days in case anyone has other comments.
>=20
> Thank you very much for reviewing all these versions.

FYI, I've applied this patch. Please note that I folded in a minor change.
When I took another look in the patch, I noticed that $TMPDIR was referred =
out
of the test() function. Actually, $TMPDIR works only within test(), so I mo=
ved
it into test(). Anyway, thank you for this work.
