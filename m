Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49932EB5C0
	for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 07:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761896965; cv=fail; b=u44cWTX8xPfU9dW907PIEq2NVLlEblBnS5rr2xqwJxugsWSU17t1Ii424t72m2uzuzKkg7T83IvBW6uTwcB6oG6A51XWGzkomXG//3MbilRHd/jClBW6NaPEpJ5jXv7RfeMtPT8JOJbPUdQy7zZ0r0SNzL5qDSqSyrbTD8mLYJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761896965; c=relaxed/simple;
	bh=wevsyE63tZgWU/s0CZSBK9lGvw5yLadvELbhDipM6wY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=skFR5NyNbwmQVV6VYeqbw3R1iDRtGkzGvP8JGM4AehAa9IznNPJiGxxiekDuXYg+fqCox1z4/lTEMFcVxRh61aP/XPeVn/ActmFoeLJrgzv05xNZYkXTscmsU3xqBvBPJmPouUxLrs/c0llyVd3yK/1l8COySrxxQIMwQ6b/Y4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Ylfocs8x; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=nFyQQH4Y; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ylfocs8x";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nFyQQH4Y"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761896963; x=1793432963;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wevsyE63tZgWU/s0CZSBK9lGvw5yLadvELbhDipM6wY=;
  b=Ylfocs8xNisWMMjZ42b7vkReknVdIG0Mkn3AqUneh4k8ZVnz1lEjSU7e
   HuO32uP2C4z+dnapjcrC0hH+ZqZcWagL7ROJRZzU6+M9lzsk4RNXu1/Fy
   4wIqJK7727HcZ1HU1TQQiL9fO0XLn8q72rmyMM10N2dNpRyjRO8UVVjWT
   5S+rLhb0o/GJIelCFrvfhMQqNj6GWxXP0dmzHK7kSyAkI5vFN18yGFQJo
   PsPh04HEkeQmukNIDFvLqJRENOfx/8/UL5VHgmCJA81wfs7VDz1pcMLhF
   +3C5aIs46CDV2Vsline1x4WQOJDY71IUTaf3FQlqo6KSuiV9hyB3E7p+j
   Q==;
X-CSE-ConnectionGUID: pV7FwyTtT6O0XAhG3VseEA==
X-CSE-MsgGUID: uIb5oKxBR7uQZRYwIqYOeQ==
X-IronPort-AV: E=Sophos;i="6.19,268,1754928000"; 
   d="scan'208";a="134258363"
Received: from mail-westus3azon11012054.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.54])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2025 15:49:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWyD1fRrHV1Oob/iU0CMHgvGNd+dDVvlHVEiFxLnf6icZQpaRIzIkMVFkbE7eIT8EGpcBjqX+LE/I2+r/CLTge+TcGwibozKFbdqDz6E5hGRcYjoK2nFPA535thVEKSqLb71EdmEMI7ux94iZ40vKX2t4+cTWmwFFkApepHEMjfe8dcbmOZ2beG000TVH26+efKMX2iXk88sIXgawDoL9HmVTMw3fCabL60uSl7Shh3deuqm8ssGUsdjy0MKXiJgc81fESLqANLCvHv0kTaeyaB+9wAlZ4sV00i37ixxnxDmbiTVLFPZHMaX1VU7HqdJLRdJGU2gB4807TEmc0lTvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urHph6WQ7X4UYol9T1uB29pJdOS6cZuP2liUGYCX1dM=;
 b=I4dq/CQkHqlj9pJeHbIiQ7kbWYYJUufW6Lv6H3om8ja7XTrd4w9sLt/WpQA+B/yl1LrntvfOMsWc8HtrBEomvqi2h8lataV+1pTR3f/lJ8GkdNytLRi0MgtbQ0s3hupbebvfoIZIkIGybg2fM1ayb8ftQiKDAU98QL36kr7rT2V4w/sCRPlLPS3YvUlm/A7J1hNEn2svK34witaqnNmdyfAaM5ciCNTE6smm6JA4dcewty9bAa13POT2RMa2QbnwQn4Z0AInwWPs+eBtMAlP58C/vfYolWYzSmxseFVZDWlJCf5mWS9APuD3JeYYGmNHX985Pke1VP3MkxwfxTv6IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urHph6WQ7X4UYol9T1uB29pJdOS6cZuP2liUGYCX1dM=;
 b=nFyQQH4YeVq1M6ZFX8ivHekaqvI1ntD1sM15Zw/ggaQ9t1KAjfkX7jqXFj6XBiXNmtYQ8PfQ7O/Nhps5H9rUucU/lqs/MiPna8o1LcahU+aqRrZUaJTdp4F6NpJAmOxAK5faJcjtWDuTCw6/fbE9jOEvRyFLxSdcOzK3xRnqfSQ=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CH4PR04MB9108.namprd04.prod.outlook.com (2603:10b6:610:232::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 07:49:21 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9275.011; Fri, 31 Oct 2025
 07:49:21 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
CC: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V2 1/2] blktrace: add blktrace zone management regression
 test
Thread-Topic: [PATCH V2 1/2] blktrace: add blktrace zone management regression
 test
Thread-Index: AQHcSD/9RwSTpOblOkyOH/PIFIftCbTb5TsA
Date: Fri, 31 Oct 2025 07:49:21 +0000
Message-ID: <wa6dahivap3tzmghzabxnldno4vyfnlqtys3ettks3p7e2lh6r@tjxokp5p52sh>
References: <20251028192048.18923-1-ckulkarnilinux@gmail.com>
In-Reply-To: <20251028192048.18923-1-ckulkarnilinux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CH4PR04MB9108:EE_
x-ms-office365-filtering-correlation-id: e75062c4-ab68-45d4-f406-08de185200d8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aBcNUofwmDjO4IqE0mQGgmwBN8oHzNcwtTZrZATvVaGLf2CjkTBSflq4Rwe9?=
 =?us-ascii?Q?nG2lmfyC08OoqeU6Ll6wrxDnpvcr+9l9MurpOXWIRZgllCqpJyTcASmHsJtx?=
 =?us-ascii?Q?jlMBxGysIUN9rA8zAkgGHlPBhQdOg3kJooUN70zGOANQW966zwcQJvs5e2vg?=
 =?us-ascii?Q?KOsKyU+m4lmexiKJWY6wGyZyLgiBdFKEVfiMjK38cbnD3DEoT8CWQ5tWqYL4?=
 =?us-ascii?Q?clGWfOzNYfwp+SP/YHPOyhQdDT7yKfkrfnAp0PosmexHziDRpuPhKi7985P6?=
 =?us-ascii?Q?ZxXiSCy7166XgA4OKHwUpzsllfvlWTBBjdXtU191x5cPzrqyi5Am4FPP5McB?=
 =?us-ascii?Q?/9MoJSzhBxEcjk27VhNwb++HaH9fQTDqeeMN/+H7gToC97l8kw1lSLyLbAPh?=
 =?us-ascii?Q?Xv3Az4lncz/v5ltr6lDnx1qECfiPtS1l+dJm+JaJj7+lb3oOp7xpjkb3VWEq?=
 =?us-ascii?Q?uz4H6WyEevx0NYR14RdH11q7kTCz4jkDiXxelkwJFpU64iVHIZj+fo0AmA6U?=
 =?us-ascii?Q?ejtMK+6m8MnDgCs3+X7a76yKo8IkSxna+wWGFrvjisWzAkR58K953FeWE8w/?=
 =?us-ascii?Q?c5G2jff+cDjNWxGZ05vZ3DcbazBBBwVx8fwUQ26jH+zFIf1QdlNpX4LsFv6r?=
 =?us-ascii?Q?8fB9+mfdyNZ4h6qMiT3wUMlbqUtqbzWq9esJG4psyJk3dLMUNR2SddnRsRHZ?=
 =?us-ascii?Q?zZu1cNPi+RZ7zLJmXvaeRJ22fQHbRwfP5N6LFIuE2WQNRwF9EUzkQkA1daSn?=
 =?us-ascii?Q?QnPsCTc1imbO8hXUMCvTvReUxjjoa0idR/4YqZ2iKk8exij50XXUAl51xiFc?=
 =?us-ascii?Q?6NCCLCtigYu8mo+4rVmpTTbFDs/FQUr81l2eWJnV37nYlgJofHn7W/aYP64Q?=
 =?us-ascii?Q?zS+VleqCMv201m9dX924/pYIg4BnWAVmzsFz4BB6otJGGKB9+meK/46U92tZ?=
 =?us-ascii?Q?b/wZ44nw1bCohiIcJxbtXZMuM9yL1fNkMxhuj2AcdnZ0mUquHcm/y1l8YPf7?=
 =?us-ascii?Q?Uo0L+H2PW5/MAOmphn7OEAoK9LWFdZFwWoa5c98CD7KXu8gPbc/P5vefkz/U?=
 =?us-ascii?Q?NB785uGiis2JRRsUslYxabAxGVCORtaWyUXi7x3X6ozMBgiRRVpjllvZpVKc?=
 =?us-ascii?Q?4saXBV3gqgYintnD+obgCHUMyX9PnREJJAxNKQN+5EgzjzLEj1Ob981FbG3y?=
 =?us-ascii?Q?NZ0XW0xzic8HDl7U0lkuu278K5nkYCZLC2WSMEEKz5zyNLSI9vdo44652u5W?=
 =?us-ascii?Q?PZg+v6l3pj9grejFmZRuIAB56AhnYXcrhAFy1ti+R/IoVe6X2fTX5Qgba4ze?=
 =?us-ascii?Q?nFXPZdSJXqaIUSyGVP9f/f9Zz+Nn+07fW0f18P+PhAEG3UlKSpqC9JeIa3sa?=
 =?us-ascii?Q?ZxTufsFPvCk1HUhdYY/GCrMKObXAC+vQoQfs/c9W5XaX217h4/+HamPIEvVc?=
 =?us-ascii?Q?gS2xoRQFkOSQeAht0XvM0xNz6e869+OMQznf+lVskzJYdylxuwy5yOnRIbkK?=
 =?us-ascii?Q?adl9aZCm3OqfCJXpD/hh+74O+GSuDqZUh+vg?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/q+7rHvn1wy4/7+ynKNMthb8zn75HaZxlVWOnveVh1sC5SqimahV69iPuFIt?=
 =?us-ascii?Q?CcIxLRkUYTEWA5cWa3QG7itk6Py2OCPZdlekgdr5ssxOpM0J8TtDzZo7uM5h?=
 =?us-ascii?Q?JhyvGEWfgW2rhSS16jvvbOnbbhsPflXSK4Tpc4/1FazUsy04kR3KSc91579P?=
 =?us-ascii?Q?oMn2eGhcafJlf+NbAUgbMPvH0ftXJLq77dygOd2XCXKc6LQRlzPlmODv6drN?=
 =?us-ascii?Q?FxIs5+kFYzxBybPohbEUYC+zy+D9hpudSOHElKu2mOmWIxNe5ZtASB6A3A6L?=
 =?us-ascii?Q?S4sLRwWuLRERXluucQsiPVapWHnqb97dRBzsXoNdOeWzT9nM123+id9XfQmX?=
 =?us-ascii?Q?wRucEB/5Et9aVkNmdBeyVRKiJs0W7eTsumeyboCQB3zSrvvWVsirApYNB9z+?=
 =?us-ascii?Q?FjItVTWU8SP1xE8XAJfdiKPx8MAn0HRVmDeijjHDRcv5RBlKJloQMqoQaRBK?=
 =?us-ascii?Q?mEcfuFzddr/JbdHt/y3gffI9J857bbOGF8qGufD1dZsdXgjzzIKOXWG+VJt0?=
 =?us-ascii?Q?va4hAGUYq0c5ZH8WipY5rQziRJH549C5favDyAmC5D6sdFmziW8jhysQmuq+?=
 =?us-ascii?Q?dYi+CZC7og1VxzkICCpcbtPE1jutTQUNAnZe00lzF4d7uk+UpgiBVL1QqU+P?=
 =?us-ascii?Q?nL6MPy1W4lq4jkDiJvoaqNweDGwLIYAHMMldQpPo+g9fM2TECpFFtJV//aGT?=
 =?us-ascii?Q?YKhbjxqbHcfrqSmCnAnCz951EKEk7d4GA2e603BJVnL563V3RibF7mDj7b/E?=
 =?us-ascii?Q?nPgKXUvMl2GutjFz3Kz05i18yD8PQ45pmF8HDU4Odbo4E2VLw3+fDvRFNu5i?=
 =?us-ascii?Q?VM7/bmiJvIo1qPbLSeo20y6d5PJgiJ+7AjZfCPTmGCaUKdC4yvuBXjTwGemn?=
 =?us-ascii?Q?7K4tO+j+YjUhKxjA1UlGs3pRJR4f4mvupyUrNeEYyTDZcO9f2e4chgweq7jG?=
 =?us-ascii?Q?UdaOFZ5H7IgGuI9FyvRKe+V9Xphoad26fPPZipjyoMXBmESnvtLGSEwqF9Mr?=
 =?us-ascii?Q?aRulQKtgQZfkxwvqC5kocXYuBdxOZrx0gz4OniFABawUKlSRsq9DQFU4Y/MZ?=
 =?us-ascii?Q?rujPJecTPQbOaPF1IMrmc+dKfeQ/o0a/MbdZLW83fZX/8MDECvSwzHK3xUh3?=
 =?us-ascii?Q?NNCr2Kc4JBeI2QA1Dibe30srGz18SLK4n5uSfOneAq/dtrgtLjHepzt0Yrtg?=
 =?us-ascii?Q?LBmqtueeVHqFVgc8vGiVmlxuNYQFFQgL6qTy7VEMWfIIvHaB54yocmhex12Z?=
 =?us-ascii?Q?GaoJQdbtR/G0/oUFm2DVIV5W3Tr4rWFYt+XKzBGssAOdcu2HR6zcZd11mFUj?=
 =?us-ascii?Q?Doh4XM/ZDYcRk8feRO6AzQ67lxQR6rz1iZmF+ehOMna+2/83XP1G5hzjVJLg?=
 =?us-ascii?Q?QKU9GArIi/YaNTM2LcxejEbA7LFANepVmQQC+PWJxnOQl652opuWX8jDJUUS?=
 =?us-ascii?Q?/LJwwuhypHXgGQ9oVxBO35do3IEV1RelMkYSIcMAbkq5iM5FRqXRq21LJ5we?=
 =?us-ascii?Q?EMqG6Qi80pm8YHDLDbGg6WHiZMoC2oOPYL9fM+Wm6g+A6AM9jNxXUXWL309S?=
 =?us-ascii?Q?LxiHhbw8f4pNTBRbhbgwKiVChC4cubasebqsxuDIaCKnaq60R+81V+le2BxW?=
 =?us-ascii?Q?u80WsnuI8NuFftS/Os+lsqw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EB5A0C3EA66F3145A6AD7C11025D478B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P6vVtOjut+DoIOYn38d+fiNTvcy/mWlsy1Pb7MiLtK16Nn0SCvsMvG2waavgyOlfdn0UEFi9mnG4Tu7fFrz1djb63ffmMyx76ybgTNaCXGffx3pQuZyiAGts/B6YVGIrtiW3RwuNsEZQ62ylKnDoH+KWJ1S5jwgabnWok9E4VDx6l/KgioB2CVN5u6wHjL7zY7tcG5F0GsSyDy1ifFcuU0uVwLq9nmQv+FVEkjq1fumDue5KoTTvebH4orBarGol77zDuPXZ1xjqFW9DX0gQZf5V+wIqdD7TRHk2SIj3FlVYO5jUgVWpJyczehCbkEe9tTp1/GvujvJNMn7s5jZESwwsmLWMZe34G9aOZkWmXS2UbQyXeLol2qAaYIfMkSDnL6/ZMQ9lpIT+a9F/bIwxspQW5/7QYllrWiu0n/RX3XVZBhcpIEVGDOfmVBx+Qq0qeP62NWcQU92CQ7Ja5U5BfOD/M5Q+nrmTeWW3uC9PaowhkCfLsj/KvS0UlquNlS6mFXjzi7opRQe2rR7+xq7/JCSQY+xdHj3Z5/fpSAAezhkqMXJoQzK01/06kXKeEOxUchLKgSsOVzaQivQh2VJVktpQnFyn5q4+ikqIyeMqNLsz11EyPOrKNPrqzPpB0i7l
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e75062c4-ab68-45d4-f406-08de185200d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 07:49:21.3700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ca8IYo0S2YxWIxZEO8lQiJwb3spmmfB9yCBW728Nw7BQno8gIROJFETjcxH6yKuaZvIZR2/1ZrUJjqTxLxaxR8aeD0pRRaSmwvEKoH7+qs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9108

Chaitanya, thanks again for the series. I think this new test group is usef=
ul.
I also found that the test case block/002 is testing the blktrace feature. =
I
think it might be the better to move block/002 to blktrace/003.

I left some review comments on the patches. Please see if they make sense. =
Also
I ran the new test cases on the kernels as follows, and confirmed the test =
cases
pass and fail as expected. Good.

 - v6.18-rc3
    -> Both test cases passed
 - v6.18-rc3 + Johaness blktrace series
    -> Both test cases failed
 - v6.18-rc3 + Johaness blktrace series + fixes by Chaitanya
    -> Both test cases passd
