Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5716FCA
	for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 09:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236071; cv=fail; b=pHsY2ZNGkA4+nWNdOGiWRdcrE6d5BBGYqaL1m8n5tPmLYT05B7Z32AbzrKtXYweb5CozaS4RaVQdbXX3i6iggSI9fHkiTDNJ85J2Y0WG+fr8Ofmrq0K9tG67Sgdi35U53ahuCMPbntmm6wMW7V/9Li3NPhhC3et4MHpbjAdrD3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236071; c=relaxed/simple;
	bh=jW3rPUUnmfDiD3kS/71HTNL/yqS9bc1z0mwHgMujEbs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qmrdrw3cv6ggORfC7OUc4CMkbRMsvnkEWft6rCW9nkqQijGcuSiwZ913gSlo1eMruMRAP/0d26GuP0+4M3kU2ehr6pOukCKYL2CE5V0xFaQVFyOISGY8RR66XXWcAJtpCPLmfGRJx2tIuPYmH2JvI2/gIu9lAL8ffPl4X2ZlY8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Ratn4i8Y; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=hw6GnOkg; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ratn4i8Y";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hw6GnOkg"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1710236070; x=1741772070;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jW3rPUUnmfDiD3kS/71HTNL/yqS9bc1z0mwHgMujEbs=;
  b=Ratn4i8Yg7fQBDapQ3iCvLUUmG59ezoVQQr/bw9pALn1f2aYnAmtWdyV
   YZuTvkMPqPi4vRmb8l6X9E0Wx4azs3VBh0UcLExuHQErL6Viogf0xPHIQ
   WKWjvNvO2uktqEm/Seus/1G0+nmYMZMEIiOuhkIWNLEqUqmKBxEWR9Dok
   E0B8AaS7S5ZBpCmaRwnluTuW06jv7GOgpGdx80shuW3g0kHd1O+m1KykI
   5HX4oFilOxl/b9fmVHwu/CHFvag+3YOuyyPAks7sZPJJ4g21OpVK4JwM+
   i1QoViGRPwZHPdboTpIQHxReaslbdyts6uo8sKqawrNNeEpCj1TNvQw8L
   A==;
X-CSE-ConnectionGUID: HRMPU6wvQjKjplzWTiyMtA==
X-CSE-MsgGUID: Adn+TYz4T26GXqztKsHEzA==
X-IronPort-AV: E=Sophos;i="6.07,119,1708358400"; 
   d="scan'208";a="10907242"
Received: from mail-bn8nam04lp2040.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.40])
  by ob1.hgst.iphmx.com with ESMTP; 12 Mar 2024 17:34:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xk2acR6Bq9vjRMaYL+Ux5vTJAXoH4bKTJ9ICbNIwG4/VYfwQpt+3S33z/BNCDZELq2FIPVn17N/G4ZydK302PDrDgOfvZ2hkXy/cbNOJgM7XGL52ED9prlp3YgZao2VSebBV2zaRi3sqJZ/Q+KoIyTP4GPeg4rkvJWuqQYSVTgMSOozuOoqxDXvpO37OACqfkCYFIENrsSDmGXXAf0L4pRSiikXoCB/R99nJSzDqf1HHsyeZ/Ynif2dFfzT56Nk2ZFprIrbqLsDReLXEDgrFDoFR6KmxoqUqFC2qQfRo7Tt6v5dih40aNSVSmDDE5qS15rIFdKpQtZbQ/ExMOqOssg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jW3rPUUnmfDiD3kS/71HTNL/yqS9bc1z0mwHgMujEbs=;
 b=d10itRnHV5CdT6hbNTBYLXRRVQ/JPE6YlvHk+BSTP6oPsR+YnskOyhgDL5gFTDQqSncqtT6c7IvZfQNTvFJ5GO9kSlm5ilgJrWksAXwZs4pTKKPv0welsC+sEEUPNXbLxV5H1NuKgxkZ/sye1iowZV3e/y+F/2l5E4xWPAYQP/rVKzmOCsTZPFFoOWbp5jRUL3l7byq+PSN0D0HmanlhytqB/fzpjXF31DXh/q5I/RBaJ7sng4kyskzcTRiPacfLWw1rkaYVzyLQlY/SutRDUCzmRF+KGDPN2NggNqePuffKeksAdh+SSqebvKqIrtzvvD8jDJqJsaGiZbEEcqr/Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jW3rPUUnmfDiD3kS/71HTNL/yqS9bc1z0mwHgMujEbs=;
 b=hw6GnOkgJmS1rTtbnbhgntDnZ9dXiAv/df+wGUGvIIN0qu4sIo1IfVfGyJF8G/tYbrCkY4lSxIvYjp9DZGLgvxTyWDlm5deGnRf7PhE8SXPSss5WLIubojUSK6Wp3GPMS8jPW7H1KQxdQKejJvtARQjZNDm1Mcpw+JvkCMygyNg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH0PR04MB8178.namprd04.prod.outlook.com (2603:10b6:610:f9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.36; Tue, 12 Mar 2024 09:34:20 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b%4]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 09:34:20 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yi Zhang <yi.zhang@redhat.com>
CC: "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, linux-block
	<linux-block@vger.kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
	"chao@kernel.org" <chao@kernel.org>, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [bug report]WARNING: CPU: 22 PID: 44011 at fs/iomap/iter.c:51
 iomap_iter+0x32b observed with blktests zbd/010
Thread-Topic: [bug report]WARNING: CPU: 22 PID: 44011 at fs/iomap/iter.c:51
 iomap_iter+0x32b observed with blktests zbd/010
Thread-Index:
 AQHaYovQw4Cp4i7GhUK8xyPo7C3fjLEfp86AgAAQ4ICAAtxGAIAQ9nqAgAAi6wCAAE15gA==
Date: Tue, 12 Mar 2024 09:34:20 +0000
Message-ID: <d6vi6aq44c4a7ekhck6zxxy4woa5q7v5bnvn5qmad7nqk7egms@ptc72tum4bks>
References:
 <CAHj4cs-kfojYC9i0G73PRkYzcxCTex=-vugRFeP40g_URGvnfQ@mail.gmail.com>
 <esesb6dg5omj7e5sdnltnapuuzgmbdfmezcz6owsx2waqayc5q@36yhz4dmrxh6>
 <CAHj4cs874FivTdmw=VMJwTzzLFZWb4OKqvNGRN0R0O+Oiv4aYA@mail.gmail.com>
 <CAHj4cs_eOSafp0=cbwjNPR6X2342GF_cnUTcXf6RjrMnoOHSmQ@mail.gmail.com>
 <msec3wnqtvlsnfsw34uyrircyco3j3y7yb4gj75ofz5gnn57mg@qzcq5eumjwy5>
 <CAHj4cs-DC7QQH1W3KSzXS8ERMPW-6XQ9-w_Mzr1zEGF7ZZ=K3w@mail.gmail.com>
In-Reply-To:
 <CAHj4cs-DC7QQH1W3KSzXS8ERMPW-6XQ9-w_Mzr1zEGF7ZZ=K3w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH0PR04MB8178:EE_
x-ms-office365-filtering-correlation-id: 6216330d-5a34-4453-c612-08dc42779853
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kr7ls3ic7kFzae6vWIQR1pmnjerSH50Z72o8CjAzEL/SZO5vjjBimr6p8g9tzib+4CFleKS3kwL6XozK8pLF/xkXCrbXJiejSkSUWPMobbbeblry+/yuZjlj9GNezEZA5HMq+ZwyzQjnn3s7fwEfw0HxR/Ne1iTNzxJM9e6GvIQ257bQmcWv421SsppPvaLflYSSmqCRZCTej+O9MsQm82qBEJo3h/LuZvTY+sQWJ/Jo72WRcWDQh2a43qZnnjH6ciPvj9q7BSBvXJzRaM1+xhL0BNGQ0WTERSs66qJXHWjJefoc7essyi4bW6nNnnM6A7OA6fIdoIAxOAeZAn6+p3WYGjWcUmc8m6SN9nSRjWHqzLMZhfvQotf+YKb6J7+vX/nwu+sTv6qce+ma7inqpGXSpY0A4NMB3jV4TyTGEMZJfdQQhl5/WLm3NIlKb3IPP5UxSPITl7K18UOCEaFzvSuAF+P+6af22MkXA2A1FYF2exDbTViIHQ/W898NQUilnY+H6HGNAnLAIiITVNk84WNf6x4r7EuVfIs0vJJeM00vCQGwJEUmazBAhDnItnX40aMRyiVrYx53WEYEdYpTajjQ4rOWRX96j9km4HmPtyHvv/I/xW2NalbrSvwxvDzSeiZEZ9SZnB95Cx8H+7yNNN0QsPIftUraw06eNF6kGLqTooFWQ+Rj6QvgN9l2Nnr7zUyJj+4ZXeBaE7bJkaybItCSroC4wEE5BpHqGlenAOc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ALDzmoHcJw6azbUdPQnAs2+5eHWYJGdNz9SBTaeEvfZHShWORyA+oIkdWEL4?=
 =?us-ascii?Q?W1F2FP5XXzX/pJhSTGZdih84nV7eMYmv456b/vPpSMm6R1xA5mRkdABtZagr?=
 =?us-ascii?Q?nB3HP9Sh3aGn3pJfQahSTtV8OJcVn6kVg7hoVxWHJsk2AjrBqRe6vMugfRA1?=
 =?us-ascii?Q?z04Fbdh6KR8lJsG3xfqPEP4pYDYqKUYlXWbPflbscpOKbfG6KnQX1ioX7DL4?=
 =?us-ascii?Q?73t3Rss4BZeLp7/dLaYRJLAPXZRhUWpBTQ1Wyo90jRN4q8cs8aZmiHZv3E57?=
 =?us-ascii?Q?1zm7iwgIa/0AVGGY+n78jMX5sSQqMpVK/s8h1YeoBJ+KkbYt4+pNWgIOFSzh?=
 =?us-ascii?Q?UaBF9kqHpKy1x0ovzCNrSUF+PEJ+HS1q7Vp1xnZW/5bFLx2qn89BZbkSiSX/?=
 =?us-ascii?Q?SonAseqk9zzRFgdn/ZrI1OTyauyM7FwtOyLOmEc/6OaPOyOYe1CUCNCTOr6R?=
 =?us-ascii?Q?G1vL6qkutaveLxiREC+f7kP5kA3EbtAJAV+RzHhkqlzD9JeULiJJKgsyaKeG?=
 =?us-ascii?Q?aohNZK66LRRGJIZLRYtINTXD+Zjekee5TTOEu3n2NqBLnvw7oblSTUaXGWbA?=
 =?us-ascii?Q?pRLFHT4NTNfrYYVsG0flWUFjTfKbg7eSWZrpN5kSqXODrt3NnVOjNthPMPqR?=
 =?us-ascii?Q?srNXdwugLUFHVrvd0x9TlCdEjO547fBn9gggGeCd7dYSJ1bNhtF0FjcDUcUf?=
 =?us-ascii?Q?BE/nPpfEVngTWRH43vFeFCpFz7QB6sxLBh0JmGLGI6FH3MB2h8d+qGeJetQn?=
 =?us-ascii?Q?A15OvTWGy6EPWnfZ5sTP3kPExnJ16OssBa/i9KnHK3suJ9JRqL6nlDpK3/Bs?=
 =?us-ascii?Q?7LeGUtXVYEt1p1LzX/WyczX5VW98DZ1nsFcACU/xfincLaG6U+HmWeIBcU1h?=
 =?us-ascii?Q?kZlrExdZ/tD0l6cQn0JyUYbLrOd+krznsNgMo+zShDSdJBAQFwVriB+9MX8J?=
 =?us-ascii?Q?mPTSrWWjPgbDpXatGpZC3j0rN2jgFHAtrpbw5BNH2yZZ3ZEA9pRdmmitAQ2J?=
 =?us-ascii?Q?k/XqpBXINuHetOF0SU8qJ9O6FY81MzGNxNsNbs2jjX25hMj+1wzd89NLWICz?=
 =?us-ascii?Q?/zOBaQuvVjEMz+RuZGxBqwm6N0YC01MYGJ3UpMO4fmwDIOYCgAh25gLWRi+m?=
 =?us-ascii?Q?pS5//esJVpu49YM28CtSXhNbE25hnwG876IUlig5M9JzG7+BVcFcwUcA0sRG?=
 =?us-ascii?Q?S75YEUT7J3zxyk6w8pS7U0ukVf4Gb+6eCjgUmU8CFsIls9yd9UJ8EcrIfBYP?=
 =?us-ascii?Q?BDXa+1eU3ErzWGxRaxBC33FTYSTixAUp2IMEvwmv6KjsdzXOPxJN4Xt9qJb1?=
 =?us-ascii?Q?Df4cFxnwuftYH9amfOaqwKBvHgtCHgUP0uS6WbwIO1IJOsyeYSMcRSRz2gIg?=
 =?us-ascii?Q?292ys9i33PEPewUHSgnuSmtFcAZlxzI0A4Ss5l3+E1PpyQpaY/7ZP3rsznp7?=
 =?us-ascii?Q?b6xIF1Ba1Y5bu7x4f3BbXFSRui1BPyJs6mFjrEFO5dPHZhD+/PnAVQSHGX7j?=
 =?us-ascii?Q?TiSyNs0epkGUFaSglLYTuts9vXew6cCBLoOEdiLZaBl/4JoVfLTzd7jgmrKD?=
 =?us-ascii?Q?m9tWErsgTJNvr9v//sgbFgDdCAcxkALlfIBmsRA7/HLOK6JExuDTBZzIcS5Q?=
 =?us-ascii?Q?QO1ZBX38Db3+pYiMaeYEL5M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <98CAA742BC76544F9C9D7BD2ECEE0CDF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sWAA+o1kc54+Fm0E3cgt8dWrVc7wK0W+2HVWaa6glOL10fM9p60ogEfgcjM4JYIdbEw5twTVFXkzbdPiL7aos+klSoB7VjmMoAKAxDkSS+OHG0RLxXknbYkAlvhWKbYkGUsvwNv6nHb54kfBUkTSMRPmErc1SAZdrx767FeGvA2gaoLAQkYgFfJ0FXQzDUkmcIX1HpRrBJQsngpbXb3+VxtMfhI0JzMhDT0Oh993Dv7iSBW3MvjqcOdcMJpW04xmYZaQJGJDG3i8spIYpVtR9eyagCCJlT7hIZUY+hsaFZr5lVFHk0FijvkB9iUf9DLkYKSb3C74cLhAEO7pO+mqQMjNRr/LAyM3a8l/RjWr51FF8TeAK9d+FXaD4uigpEfW7IpUl2pH8WMillUGKEXBkpR/xSdVODEUiDfSp5oIUg0fzsc+C84KIidBvMjPITyvhGHOpBFF/rxaj2cafcYxRPGZustfHFfh4/3l8h9jjrbiMIue2umNsTZ55Mkuxk2VM+zQ8LSYh859V6Gr4hKI9+pn1c7J+jVPoHLPvWe4/ENe5FExvMu9kMIhgdzUbH1PRuHUeAZP2hfibG70ElNnmpGRE82t3UUdSHawdEedNQoziX7AicXdS9YTN6MVpfnQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6216330d-5a34-4453-c612-08dc42779853
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 09:34:20.3836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5kcTQeYjsvzvEuVP40RluyM8LKfdVLUL6MUMfOpXItyNQlKCGmBYKFc0BfYfuoamVyFmld89WNgLhwCWDfl64Q6MrCNRPxrynAScVfP/NGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8178

On Mar 12, 2024 / 12:57, Yi Zhang wrote:
...
> Sorry, please use this one.

Thanks. I have succeeded to recreate the issue. Will take a look tomorrow.
