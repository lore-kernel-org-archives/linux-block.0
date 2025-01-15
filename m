Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B1941760
	for <linux-block@vger.kernel.org>; Wed, 15 Jan 2025 01:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736904219; cv=fail; b=QKBjQFXUYluq0Ff/mXngn8uhBPuQ2hLo52OyUqLZL4UWfMDtYPpRrdsiWTTaDYxWeTWyGcSSHlCD1XcXPFnvPgYfYttrVXsi8aMWn0LOd2LZc7Pp0NN1g+x9gjjFKu0A6njaUk7xPRgWGdyIjiAytDrrzOaIPy1wn7Jmaor0+g4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736904219; c=relaxed/simple;
	bh=YKtEySxeL1JxAGTW2rX3swq2rmWrCX6VHtWC3wg4MUg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NPTqcub9x9Qy6RuyoSKY6ViNvpKSd5a8EaOeQppd2RvHoFxDIxtJia5MXAmpreSqtsA6Gg3jY4399EYMCDMSAQ5ltknuSjuRlSnzOVIYLA4X3HnJQQ03HeXyNlQHnpZpxYJMme4KKlN1tKqXHOEM8IY3N9pVt1AYrQgNp9cRq8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=baWQLuXq; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=U5a55I6k; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="baWQLuXq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="U5a55I6k"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1736904218; x=1768440218;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YKtEySxeL1JxAGTW2rX3swq2rmWrCX6VHtWC3wg4MUg=;
  b=baWQLuXqXI4F8RWzp09iVtNuC8a9xLpbjoQMT1E/5cJRVRssOf+Aa1t2
   xqDYeTJCnuO9JjL9dt1cDIL79wrwL5XHzkiq32BlStcD9I0nmOWw/Fxlw
   PikU1ylYH7dIUdkrBFck47OYtcB6gBKmMXlwIzGLTThqetYfsDVm0ISyD
   1l13Xz8+pHe4SJ8AE4EQKdI1LeVs1fJ8N+AGAEo5OacLSXUXsp6+aA8Dc
   5qkeSb3ZsM6N0cRu8NKpu5NeTONvK5DO/+B2gXlnNnK6cTZmMFtVC+ww1
   OSxeCGejlFCVeUYNTGi5Kan/FWuYkpPWpNQa8+k14NVjqjwSibJ61iE7U
   w==;
X-CSE-ConnectionGUID: B/Ov3k0eTI6TJt/vcH70wA==
X-CSE-MsgGUID: YxzwaXVERNqDiq/BDS50JQ==
X-IronPort-AV: E=Sophos;i="6.12,315,1728921600"; 
   d="scan'208";a="35322499"
Received: from mail-bl0pr05cu006.outbound1701.protection.outlook.com (HELO BL0PR05CU006.outbound.protection.outlook.com) ([40.93.2.10])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2025 09:23:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMtJSuza1F88bRg6R1xCbnnjMiwFyRMOjn/iUTPKZKUQ3nfQgXzZo+55VPzKhmOYl8g5k0DDrcJ+RkpTCpTpzSO8OylGTf4diXM4PKoDDoBLG3EO5soAfKCEVog3AYm5rOu+W9aH3fXtYYZcl+Bp+y9nQDE9RKmauo25mdS29X+KJ+1yOfPS7DatEtZRDNf/O4imsAZeOTGUrhdquxHrqJKZHg/VI0T5GngG01BjLNIFCI1P34xwSD+UeFdjXyGIF0XGuueaLAJ4MdrwZr57RN8vcWYdoVppNvvzv2CBY+qT9C+qixIOBS4IUkO+m0jgfRmMlrLmENp6nbATohLHJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddWN2FH5Kfz8gb8GSsJ5+3eFVriQpbxdbOicgEYGHFA=;
 b=tLB9UlvjJ9HRfoAxAAcoaD91SFkejygRTvTcqAVwx2mXhly7LDnGhyU/es2Bdtk633Og0qkOZwAAmmo4Pp31RGQLYhsGUUa3g6Tii9kyS6Krp6012W6kmlddVRkMcdvVBgNujC6Ihx8T47ZAy574eycH7cl9u0fUcKp6nDsuhuVZPFCpUviXMvWu4q3jE0rbv/+ys9D3ggEqdgqt2c2ia69YpEqWwXlceexMjvKjUX+EsfrURHbytp/NLFawB6m11hILxGYlymItfXpQCg9d4LW2igl+mjmUAXREvE4Q/W+NivA2IN/V3Mz71Ju9K42qmPSoAGI/noe0K8M1CFZmrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddWN2FH5Kfz8gb8GSsJ5+3eFVriQpbxdbOicgEYGHFA=;
 b=U5a55I6koMHEcr4n4d7uxSYqD8iCZzctZG0RI66CEq2GFJfvjpu5DCgncpQSMdFOuJLDtXks3GHUrn/prjPnj2vTh6Bu2cjZNnlNaOK1cjNP3Cads0eYXkFarzrpmV2/jvqmhRVQi8bGo9TB0S/YboE9NJl/B8F1QvpNj7bTjEw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH3PR04MB8904.namprd04.prod.outlook.com (2603:10b6:610:179::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 01:23:34 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 01:23:34 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe
	<axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH for-next v2 3/4] null_blk: move write pointers for partial
 writes
Thread-Topic: [PATCH for-next v2 3/4] null_blk: move write pointers for
 partial writes
Thread-Index: AQHbX//qR/7ruB+7i0WwgmXaE3yrRrMXGC0A
Date: Wed, 15 Jan 2025 01:23:34 +0000
Message-ID: <53xccohoa52z4x5as44hk2jny4aaodvegmjmhviyfr5jtfd52g@ffkamwa76isx>
References: <20241225100949.930897-1-shinichiro.kawasaki@wdc.com>
 <20241225100949.930897-4-shinichiro.kawasaki@wdc.com>
 <91b6bad9-fe99-4015-8736-d14deddb08a8@kernel.org>
In-Reply-To: <91b6bad9-fe99-4015-8736-d14deddb08a8@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH3PR04MB8904:EE_
x-ms-office365-filtering-correlation-id: 401711fd-7e19-4d07-703a-08dd35033b05
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?N9Hr1VLe7BcnIlQ/psm5ral5DoQmpcMVvz3/V9e0JbmyqbpriOpyg8EfVzP/?=
 =?us-ascii?Q?XtJiat+aOMm/HHC/2xesD0u7YrqVAz6U3iFWzLRl7VkfG1BIR9ZrjxYpJylU?=
 =?us-ascii?Q?4N6lRtlNcMf3bcJ6UkFhnscia5YCUxMEYeKRNA11TSeU9ql9AIUcL9jdwRaf?=
 =?us-ascii?Q?5AdsFoX8846w2RVWhgoJKkRirHzFiUG6LWO0kkrIvEAuU33MDevX0CzAx2Bd?=
 =?us-ascii?Q?SRMMBvmW6NF77xjiqtKY4WmD8ECUaSfYXShsFRIRhx6IMOB8bnbr9YPeMbG/?=
 =?us-ascii?Q?Bqbib43SoeLPhJczpvIylL28qvikqWNuSx4iyiTauztBygKr5jp1C1ZUd4AN?=
 =?us-ascii?Q?XbUAX2j5ZPdHPRRWjscakSzXx0tZlmW9dG1B6htJ+IJKTN42Iwldoonf5b+m?=
 =?us-ascii?Q?fWJLAXvSbNrb2QPEticUS+lYPddTV2sV/nac2wHfTsv/on6uDkCDYbdC/EJx?=
 =?us-ascii?Q?2cCfWH3u+0e56F/Vl6EjAiBQddAP9Wy+wR2MPxra52CSrN6IaqriCqU9wrJP?=
 =?us-ascii?Q?nqREn1gbvWfJTYchyPjBP4OBs6TDL1lGmIpMzvl1B0P7AhGZ+KT4JRHRnVeM?=
 =?us-ascii?Q?OKbcdlwzOLQs+55Lh1goJSVNPHVnWkS3978JBCrPnp+bW2pZYeqqkDLMOjrg?=
 =?us-ascii?Q?/gmeMioEaZ7Ce1ivbG5821puk1L9jvGD6JkM4Jcj6PnQ5pxzvV2QHdGHzTwN?=
 =?us-ascii?Q?fFEwkL70kEX17hhyKUimWhlTP51aMUJCzJv9LI0v8cKMkel4rooBfeKVX2nG?=
 =?us-ascii?Q?7UIBmRSNwiyc4xKn1WY5+j/0IschqK3ZgryZAUg72z8MzUoOFBcSB67K5mgq?=
 =?us-ascii?Q?4e/2zqBc121ZkiMTNUearm3NW6FMsp9+/ZM4fWrRJkd7Q3vGiTudXBncODGC?=
 =?us-ascii?Q?runR4QRzJG5OvjdWQLjrCNEEz5z4MYCo03SpWcrCajWFkV1pG8duw2W8E4J0?=
 =?us-ascii?Q?+BFs+l0gZ1/xKqv4nFQj3h3WrD2ridDXvdURdWp9snmTbOk5k2qwTYKO/pHu?=
 =?us-ascii?Q?J0hjQdv2gan/tUf9LOJaw2HsGJCZC4k1/2yiWD1yuV8jKDlMpSfOVxw7kDFE?=
 =?us-ascii?Q?CjNZi71uHL0Dx1dXzmPEsZZpcTfPp/zfK1uVwFY2K1XbLLt+0fYHLMhPER7p?=
 =?us-ascii?Q?ZPi/i4Lqm3zTtysm6Cfh5gCW6RQFimchPCQxaE2iCmc0Sw5DZkLJ3/Dgi1P1?=
 =?us-ascii?Q?bqz2iMgBrv06LYWw/ovdGqurVwJUjvm0Z1od21+Y3zCLKCDJkOVnrzRiHBj8?=
 =?us-ascii?Q?rUIvBoj3Z/PiAN4FwUgHIFOTl5FQSxmiaGNf64p08MzLwm/+WqKaF2Ha7KZs?=
 =?us-ascii?Q?81gRiWDc5tMDPPlPSw6zsqPJqYgqW6kxblfPrcIMM6rkFr+zDlFFNfgmejSD?=
 =?us-ascii?Q?Ck8z82bpwxvxdV7Qkok5BIWdcqnRimj5/bwNrCDKHkhDJmArFErPlg37TVFo?=
 =?us-ascii?Q?pGYr2BRo1xl5MYSJV/O8U/N+oi5cJBhq?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JZm9f0AWq8xOtFzmFbqzxCVMA84l/oVgE7TyiJPWIvYY9I2bPjMZeuBjXtWV?=
 =?us-ascii?Q?LV32Co1b27aZRl3/G14J5C03YPoo+HAQpOl8V+mssqPaZ9vHj6BuNW31fZ9q?=
 =?us-ascii?Q?q1kVvd766O+He5pcHB5xQxM+gOd1EbAZ4mhhryhoymKIGuRvOMLisKWT+wVS?=
 =?us-ascii?Q?PBWdchOeMu6yxwzet4kMwbjrFEXn55sZbMp+Hat54i0jqMaYEjXiOcoF97hx?=
 =?us-ascii?Q?BrUMPCxdM/rC/685S+g3sj3A1ClnsK/9DMxI5h+m9uxSyJ3dwtvPjAKNdsrr?=
 =?us-ascii?Q?7SU/7gZm+m8i4KUJi5F/X8G53kIY0pDsbsp++Xh1Q4730vmp1aOi8OASwcXY?=
 =?us-ascii?Q?ovS1zUKB9Vg05LlxHP2CVUuRkQtZWEqS9qX6nzCG7xi+n+tdUCMLlenQ2kKs?=
 =?us-ascii?Q?0W1LFTueaRE5coojdiX/kyuAI9kyhu2mNUjpa2efQysD6E0/nzRNjWvIpw37?=
 =?us-ascii?Q?qe5lP5lDCX2+ODipvoI2LEIznPgwGkEskNnAHboW/2z7Qie5rIjTd8fejRai?=
 =?us-ascii?Q?bWJIjT8GO8huD7oPru95VvEARjDm05XcFvFbdx8c2CLpqaMfb8k83v/M857z?=
 =?us-ascii?Q?zkVU1sHaooi7mE+lGSKdML8zBTQDkzYVS9KOLfwCCB+mvg9eDpLo9duwuDlA?=
 =?us-ascii?Q?J/Rqmyh9erKZFKzbediudqTHEClptP3trE6Jl21tIJ5hu5g8VtZ5JERUuGtv?=
 =?us-ascii?Q?zwxUiKWkbGQIKbmEQZi7GTL3eFqWcdo/fIDFGoJ8NxKzGp+sjDfA3vPzENJY?=
 =?us-ascii?Q?zmI1PbM5ugb7TA/QHQUgQuMlXMjrsQ1gDlR4O7ReMGcCWvBRCTu1VNfVOhJy?=
 =?us-ascii?Q?aafLXwqe6Ip/xlB+qtB6zHDsmVHimD4Cae24ZxLmetVNipJ8JZVYdVxW/1yJ?=
 =?us-ascii?Q?q3LgfBvIyzHu8aE/7pQOAXzP+FRws+GsEZwuCviFBSlEZ9DjVJkaiArPjzOX?=
 =?us-ascii?Q?wcrXbWyhczDonCSSa00oawD/ChGvjVoz2lY8EgvO9qimrOslifhF/dPuZF8q?=
 =?us-ascii?Q?3F7rGPadYbvMVxuvEXq6IZ74XUY8ZrYG/ArHJJTJxJJESptpxZ6KaRpzJ230?=
 =?us-ascii?Q?kNmq9YhdrBkecAZYxiu+jFpNC+nEA5SrT5XpMRQ33xoPc6JUkNc7tuQyjA8p?=
 =?us-ascii?Q?ixkX5CWcPsYOyZMkm6aQeK5mYquamoYx+SVqzGZ9RE3m0mCntiQ/A7xp89Gc?=
 =?us-ascii?Q?E5wqd0AKv/ozx7Sj5wFH3rrr7roKbuPRsVd4LSAXv4uMrb7Tx79TvBs08QWR?=
 =?us-ascii?Q?6OKTWIieGwQXWjlivthq78uccH1I+lUv2PXLbpYV5mW2GHWDSTjIyT+k966U?=
 =?us-ascii?Q?ZK9LvXyRvWjv+XDaZg9Qbkeo1csImW8N7s/B9jxl5jE0R3bNm53npBYd+X1Y?=
 =?us-ascii?Q?STVwy3GxO6Fv9p98JST3etf50UjucFgxTFnZTuNCxUN/Vdlp2FgAbAu46v0l?=
 =?us-ascii?Q?Ml2gKEKiqxgiA6ar6iAVyBA7rIg1h1S3MubvYnoIAW3XRscBkKPZad8Lvvw0?=
 =?us-ascii?Q?t49FKDTbDY+BoY3D9fxa45WdY5aT97bMoEZpf5T+hfzV3ZEsvozfX4hsoKW5?=
 =?us-ascii?Q?BONa2ucTLWo0PHmWC2tAckqf1ZRonyxO+eb2rltlmiuj7zjaiF84v6zCrqih?=
 =?us-ascii?Q?apNb9jp/TL/zeLkjfRIyNdc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <73611E9212DAE44DBCE2BE547F3F5AA1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dXQT7obg5nQ1GRUiPIP3BTiv2q3RMFnnQtbAJYFBvZx5xWtzHfWQCEXwsnA6ZSopNEmlRfKLsV+vhnpLllDnZ1ErMSLAjxNZEEeTn/A8CC9cizcy6XYQ4t3lsWCF/qw8tZUH8sbpGM0db74YSFGpQ/x6Pq1aJM8wqj/ll15saze8lAPUY1gbRCAW3ra7aSRCEJM3wGCqZS/F1DKuHUnsbETaaQFXQJp+Wfg0osVA5fAqdWo2+wLStKyhKV/BxXXeXNB1/M11EDifh14DQIxrTDVZ3F+pziIEPZQkvIMjf7a6XpgMOgOfAjw0sjUw53P0/o4FCVZaNoKqVaUq8eEm6ejHEEs5XtouR5TzMStrtkEM8TWapynyXkeDZbL6h4qk5/+vPpg1uFICIovrRLibWYXQREGtY9jB5halfy7KtQFut8cIVCkpFFV3Wi7zuwkJITbXkHco7hL6DGr9u6ou9DBrufV9ro0x33gt7mYqmVMvGqvfg+8FaT1lH0yOv3RHbaPC9YlxwqnWaykmhYTKQUEnx/OIY5sAsBQb3SSDEoivgaYc+vMHhCA8XlRNVNbG8NXq/WJVtvost+DgUurK90fZh1ByI1RBTdN+JHSXsNX+uqW0l3lAAcfjZj3q34Py
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 401711fd-7e19-4d07-703a-08dd35033b05
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 01:23:34.7347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Evq2sH70cepKTPM83BFw9rdDBEeHyOp3JhGUUD9v6xA4eOmYbSf8EUGZlDTmskJOuwCVUTo2NnodVW9rdO+fd74+/2DKsRdWYpIGJDNnlVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8904

On Jan 06, 2025 / 14:56, Damien Le Moal wrote:
> On 12/25/24 7:09 PM, Shin'ichiro Kawasaki wrote:
> > The previous commit modified bad blocks handling to do the partial IOs.
> > When such partial IOs happen for zoned null_blk devices, it is expected
> > that the write pointers also move partially. To test and debug partial
> > write by userland tools for zoned block devices, move write pointers
> > partially.
> >=20
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > ---
> >  drivers/block/null_blk/main.c     |  5 ++++-
> >  drivers/block/null_blk/null_blk.h |  6 ++++++
> >  drivers/block/null_blk/zoned.c    | 10 ++++++++++
> >  3 files changed, 20 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/mai=
n.c
> > index d155eb040077..1675dec0b0e6 100644
> > --- a/drivers/block/null_blk/main.c
> > +++ b/drivers/block/null_blk/main.c
> > @@ -1330,6 +1330,7 @@ static inline blk_status_t null_handle_throttled(=
struct nullb_cmd *cmd)
> >  }
> > =20
> >  static inline blk_status_t null_handle_badblocks(struct nullb_cmd *cmd=
,
> > +						 enum req_op op,
> >  						 sector_t sector,
> >  						 sector_t nr_sectors)
> >  {
> > @@ -1347,6 +1348,8 @@ static inline blk_status_t null_handle_badblocks(=
struct nullb_cmd *cmd,
> >  			transfer_bytes =3D (first_bad - sector) << SECTOR_SHIFT;
> >  			__null_handle_rq(cmd, transfer_bytes);
> >  		}
> > +		if (dev->zoned && op =3D=3D REQ_OP_WRITE)
>=20
> Forgot REQ_OP_ZONE_APPEND ?

Actually, null_process_zoned_cmd() handles both REQ_OP_WRITE and
REQ_OP_ZONE_APPEND in the same way, and both case results in op =3D=3D REQ_=
OP_WRITE
here. Anyway, this if branch will not be required in the v3 series since th=
is
patch is totally rewritten to follow your the other suggestion.

>=20
> > +			null_move_zone_wp(dev, sector, first_bad - sector);
> >  		return BLK_STS_IOERR;
> >  	}
> > =20
> > @@ -1413,7 +1416,7 @@ blk_status_t null_process_cmd(struct nullb_cmd *c=
md, enum req_op op,
> >  	blk_status_t ret;
> > =20
> >  	if (dev->badblocks.shift !=3D -1) {
> > -		ret =3D null_handle_badblocks(cmd, sector, nr_sectors);
> > +		ret =3D null_handle_badblocks(cmd, op, sector, nr_sectors);
> >  		if (ret !=3D BLK_STS_OK)
> >  			return ret;
> >  	}
> > diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk=
/null_blk.h
> > index 6f9fe6171087..c6ceede691ba 100644
> > --- a/drivers/block/null_blk/null_blk.h
> > +++ b/drivers/block/null_blk/null_blk.h
> > @@ -144,6 +144,8 @@ size_t null_zone_valid_read_len(struct nullb *nullb=
,
> >  				sector_t sector, unsigned int len);
> >  ssize_t zone_cond_store(struct nullb_device *dev, const char *page,
> >  			size_t count, enum blk_zone_cond cond);
> > +void null_move_zone_wp(struct nullb_device *dev, sector_t zone_sector,
> > +		       sector_t nr_sectors);
> >  #else
> >  static inline int null_init_zoned_dev(struct nullb_device *dev,
> >  		struct queue_limits *lim)
> > @@ -173,6 +175,10 @@ static inline ssize_t zone_cond_store(struct nullb=
_device *dev,
> >  {
> >  	return -EOPNOTSUPP;
> >  }
> > +static inline void null_move_zone_wp(struct nullb_device *dev,
> > +				     sector_t zone_sector, sector_t nr_sectors)
> > +{
> > +}
> >  #define null_report_zones	NULL
> >  #endif /* CONFIG_BLK_DEV_ZONED */
> >  #endif /* __NULL_BLK_H */
> > diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zo=
ned.c
> > index 0d5f9bf95229..e2b8396aa318 100644
> > --- a/drivers/block/null_blk/zoned.c
> > +++ b/drivers/block/null_blk/zoned.c
> > @@ -347,6 +347,16 @@ static blk_status_t null_check_zone_resources(stru=
ct nullb_device *dev,
> >  	}
> >  }
> > =20
> > +void null_move_zone_wp(struct nullb_device *dev, sector_t zone_sector,
> > +		       sector_t nr_sectors)
> > +{
> > +	unsigned int zno =3D null_zone_no(dev, zone_sector);
> > +	struct nullb_zone *zone =3D &dev->zones[zno];
> > +
> > +	if (zone->type !=3D BLK_ZONE_TYPE_CONVENTIONAL)
> > +		zone->wp +=3D nr_sectors;
> > +}
>=20
> I do not think this is correct. We need to deal with the zone implicit op=
en and
> zone resources as well, exactly like for a regular write. So it is not th=
at simple.
>=20
> I think that overall, a simpler approach would be to reuse
> null_handle_badblocks() inside null_process_zoned_cmd(), similar to
> null_process_cmd(). If reusing null_handle_badblocks() inside
> null_process_zoned_cmd() is not possible, then let's write a
> null_handle_zone_badblocks() helper.

Right, I overlooked the zone resource management. I think we can reuse
null_handle_badblolcks() from null_zone_write(). Please review v3 that I wi=
ll
post soon.=
