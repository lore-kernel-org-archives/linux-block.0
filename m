Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24B8154C00
	for <linux-block@vger.kernel.org>; Fri, 28 Jun 2024 10:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719569488; cv=fail; b=kyfUYsZ15EB145ce06JhOvfVbMgbuVtKbY1bX9JKFGPs1S3KBcylvj7MfPMejBQD63cbXSUuamIXoo58JGAmHiD/bf+3afFWpjcSnASjrLrmvTwVuTpTS4n4Sr0ujCVwCYJ0bXdCGSTK6Y8+A2XzpC9mMGBMQjGNcP1B/QkPPPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719569488; c=relaxed/simple;
	bh=dL5qQWQ4czgGBoWUxqA20IP1bdVLj9KZxvqe4IMUWHg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bp20fwq2EQxJKvOpyNjKPMY9RwKdLJDpTivvmuS5sNbCf0bMOKp0zLOXMiZdx15oiZIUK+uXJH9IqnnjbWPqJTDz7rlpFew3bguteMSmBJVIiKIW506afsvf/rvs4JPy3GoPWNMahLkUWF9jAgEB1jpQIAto0uSZdPTF4nHAiqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=reAw95+m; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=aTyOa8d5; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="reAw95+m";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aTyOa8d5"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1719569486; x=1751105486;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dL5qQWQ4czgGBoWUxqA20IP1bdVLj9KZxvqe4IMUWHg=;
  b=reAw95+mJPBr+KhCBs4yTig6XYd1FCTvRD9TItghSE6wxrT+dlkV2OD8
   /j7auUwy/5KL4xCWAnMyju9m/v49o6LSIz5SpmUAugQQBWAhTmkkSQebx
   8c1VEq26mKqD5OLl8o7wTy9eQp90YglaudiJISHWvzdf6hVLrvOLTb1+q
   6mZMi2imhbSGeEw9PJGwv0B30Xh1fSuRQWXmJQHsWXvdg5B+Oo+nLd0DK
   NVVro5kPadWmYWqx+PS36WgOwnfSniE+PQNNDj9+77YJui1vwaWP/LVJ3
   RtgYwP4QfHn2jG3PL/+th7CYkbl/ly0fXALwfI8UYl0KXJFgo3D3nRhfD
   A==;
X-CSE-ConnectionGUID: oNG3FkZnRHuxzc3/6S7otA==
X-CSE-MsgGUID: jMrpuKgAQ8CAXCo4azOyeA==
X-IronPort-AV: E=Sophos;i="6.09,168,1716220800"; 
   d="scan'208";a="19998544"
Received: from mail-dm6nam04lp2040.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.40])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2024 18:11:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRCAwwwxUuLkYnurie+eqLMxWZ9yNc+0kRvAIjrFdxkNpSlt/L60+o0SCKGIjlZYAiouGHaUWIOdsQFNl7UJ40oXbZz++izda2DimIDB8HWmLyavBRT6kjLjSRTTh1oGb/9IeduwTQmwmQrZ1dPGWkT74OIg7SVZX3ZDX4MQQLnfsRtopyOlPbSRRjcNvXOBC17s+UKPNAmWE0bxvJ4JlVJICwR7lmHDwkqJeitT6X9wfOzUtbvhsTTwDbYiXp/PdE2hGkBpcgTPG37TxHoTo0KY+eTy12OdfL2009CMVUVfNiTGn1in8IgOONfPgt9lBZdehA6/ADKMAZ0JHGleDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dL5qQWQ4czgGBoWUxqA20IP1bdVLj9KZxvqe4IMUWHg=;
 b=U8oFSd1W/ESXcbogfZVAEdfUmoRB6RMdjks954ovRXhGBy6tiNFajPUi0E+CUTpvnZ8Gce49NWOFo/dPBsGUvShN1TKDYVOS6Db4RVUhK5BkHvCf34ZNSPuD7wAOTsvUkl7WrnUuIEGENIHjT+Hq5OlyTeIl6BxmLb3L1vKrcZZkueu3jOvajzOUJcZbGu+De9S8AKTH1FioX3lfQ8ppqtn8UkN54OF90s+F6Lfd71SW10UYq1Hn6xwGOMVL+QV1U5BdY/fjahJl2ZJX8CCa1FDV6u0/nzt2HBz2mIm5ZrrbZkNmbNGEkDO2sX1CDV77qrsaZit1OVB2PbTSsbhuqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dL5qQWQ4czgGBoWUxqA20IP1bdVLj9KZxvqe4IMUWHg=;
 b=aTyOa8d5EfYNGohuLaK9F2O9xIw9A0MQ2GHI7BgMzgSn63TXt00Exy1FmO5Yw8tdFazr/VkSdzJj7LVns8ZNOm+gztmCNT98vjD10MRcHPs2y5+XUDtfBKKx49NjSC7peC2m8czPkWQpqoX3FfesG4z63zfh5QLuqQotljYxhgM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7565.namprd04.prod.outlook.com (2603:10b6:a03:326::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Fri, 28 Jun
 2024 10:11:22 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 10:11:22 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Gulam Mohamed <gulam.mohamed@oracle.com>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: Re: [PATCH blktests v2] loop/010: do not assume /dev/loop0
Thread-Topic: [PATCH blktests v2] loop/010: do not assume /dev/loop0
Thread-Index: AQHaxvGomRv4xIlE/UWpUccZkyX3PrHc+SoA
Date: Fri, 28 Jun 2024 10:11:22 +0000
Message-ID: <svy6jcrepk5rdsao7y3ocie4tfyfgkpm6vq75er2youfmsrb3e@ta7q4ocua2vd>
References: <20240625112011.409282-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240625112011.409282-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7565:EE_
x-ms-office365-filtering-correlation-id: 77acb481-ded4-4999-0263-08dc975aa97d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PKpE9WqyxvoGVfzCISVpLoaHLr4xADG5S1T3frI0LG2DjdC1noLfF3EAOK1i?=
 =?us-ascii?Q?OonHPmdRle3qYGcBCj97PiapMDhHkyHUSLB69ekkilGha44S+DDhnRSxbg4p?=
 =?us-ascii?Q?RP+GTI9h+cRewiBoOBXB6asFMDdzka3dH//xgd7XagBfvw9+jrkO7rYBcDev?=
 =?us-ascii?Q?n8HuhRmiHUqBJBTFytHR+LF0PRkxmWuU/oCJDonYZ0juM2RokwI1niRde1kP?=
 =?us-ascii?Q?cvdGYIJqpDHT7imAkKugPWIsTESS509trqSFfKeoGR5hEg3CaZq2pdLDHJZh?=
 =?us-ascii?Q?1vgUf+cDev5swuvQm9HCtpPW1X6XLprEAvwWhw2Xd4Ul9VYg+c5vMEpHMWc6?=
 =?us-ascii?Q?O2/iGyjDWeoii5DZDyxGQhCsGaDkSMJsOmdQmNRZ0qM9u2joOWk4hr19d1d+?=
 =?us-ascii?Q?bYU3k8UtzSWZHa1HKqi776txN5SfMyUBRH5crcgeDwYwh+vzZaKYFvkHxI5R?=
 =?us-ascii?Q?iokcIwPWNsiWH9uxXx9DnXEg4jlvXW5um0ZWa76Vi02w8A1+KC6PA/8DtIE/?=
 =?us-ascii?Q?Yd5yATNGj44PtkD68heKwIrWK/XNyww+yHEtDTy5DC92OIs1RYJkgANEnR11?=
 =?us-ascii?Q?zedJ1N8PUmnp8t/NOt1B2xDTYvLdqhSw/0SoHa3Y9+1B/4CzcFnCPr5A8qXp?=
 =?us-ascii?Q?EwgdvytbIymO5DkAa1AHSa29iwAglXLlEUOhTJI4aKW8Rzuef9cuXm0maL4J?=
 =?us-ascii?Q?l4zpNFkhuLRgP3k8j6bT3bKMm37y2Dl2JRs9uOdonriDXjJmJxsxSn39fTtD?=
 =?us-ascii?Q?iv6rV1rtkAxvTk2afIOh9YKXxvDjBy4TYJIQrju/ddDn3Cvn2NAuM2gNYzG2?=
 =?us-ascii?Q?buVu02emYO9LOa3K0swhAReI9qBfPQD5l6l48Sq4p30CZ0XaIZJBPdV6AvFh?=
 =?us-ascii?Q?HacLUKW2u4qeKCMzT4tN+Utd42D+THOWMvp+EW2v6+lENU8c2AROCOH31bb7?=
 =?us-ascii?Q?jYRTEe5Sb18K3V+ugPExzKUJMYc6EWeZBvXkO6ytjvaupaH9gixRiNYD+3ac?=
 =?us-ascii?Q?Xve4kbRkzNlJSuK1HQ+MUBZxnRpwkiCNPKr3RKj3e3P5PfrEOqdZHD5YYTlW?=
 =?us-ascii?Q?BH66FyF/vRjUVdAtY4M5R+gbmDPJgdrGjpRb4KsNMybLF/s0HYFRVxQ62GeP?=
 =?us-ascii?Q?8w7oxGAhL4xjuozeNagN2bX2B4sZOeqh2iYuHyj0XrN1f+pzS83c78xI84+5?=
 =?us-ascii?Q?8Rz0XpCJiyBBKat851X/PohVTy90nQZM5GprwPnT0RJcynugvh4fYAhS1qyp?=
 =?us-ascii?Q?d7ws2+j1bUGepJvrqn48PipgKzVfYBQyo0MNBcqteYWXhLRFS0gwOBQBCVvq?=
 =?us-ascii?Q?ddNC4D0XzvPL/edQXxrX+tuL8wdryizPUPnypY59VfDXwWLT0btE55PwBYj8?=
 =?us-ascii?Q?bR5NJ4auSZFAInrMbrhNwZyqE/dCBimoq2k3dSb+g60bPScWjQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ShvA4iwWrniYsdzAIStlCV1/C8MtASwvIRFG/JLnPUIsGyP+3zbQFq/M5QaD?=
 =?us-ascii?Q?teSgFRGKQ+Bhly9ChuoMMncq0jwzgul7h995FFnYcCc9DPMu2J03BT+v6Q4I?=
 =?us-ascii?Q?Xg52j83elcp60mi95F3m4mgfce8SkMtIGjxUz4rO/GjKQM0Z2ZJIMJTFYM6K?=
 =?us-ascii?Q?1/i4ltswnjmxX/QRcml4PABooXeomfoc+caIf+AI8IIYagmgM/jWOV5eCvcv?=
 =?us-ascii?Q?l+d5uXmHY9v5jfKcHC7kxkX9fxJ+WL0eVau88ueIAydI0mivXoZBbPUuRqwt?=
 =?us-ascii?Q?E9Cbm3VJA4QPmKCMZbADEIGds1+W96zCpH1cvTMq83fbvAmXmtCzXuCRbjGt?=
 =?us-ascii?Q?LH0x7gVtgLr1o8b7oIqmqFUzqmO63J0ZggV4s1/3Hp27ByFqifHQeGWqXJG8?=
 =?us-ascii?Q?BY1j8uQFH9YRsk+cHEmI4StmsI4fRw34coEb+aJ3/aI+oxWZ5OlOhMXuVFxS?=
 =?us-ascii?Q?mvxosA/v/fANjfwYUOJ9RY9aI0BSShi2cC/BrgXCtlTUcNQFJxHuH157yQZm?=
 =?us-ascii?Q?Bno7n9gUy3wgcMyA3Ro8o1g7H/cGkYFs1pSpcLH7Nd7R3wSGCxjgX10VohlK?=
 =?us-ascii?Q?7rXdxW6+KSbx7XAYGnLqsuJZB+yYz1y7T9QTWLJsOu5JtKEqFan1OpxbQmpG?=
 =?us-ascii?Q?I6fb+WzfFV283nQeGQzI4dOWibFoerJu2Q/r0R63lohuh7XLiac694/0ChJR?=
 =?us-ascii?Q?p/uHaOhRdxul+QzFHtnvnxWnGNkDJwPvGu5LAngWJG/6sUm1aTXdgNdZ18A9?=
 =?us-ascii?Q?jMo6Uz3//M2ditkpa52WZqXomd10RucdOjkjxehcSNP2t1ogjOdq3JtzKB0a?=
 =?us-ascii?Q?ZSLb2cHa0vKlkQj5V/oY/GVXDwxWr2w/x7dUwUrUNd/GjAOoXJGdwuvvip9c?=
 =?us-ascii?Q?mZiCWeREsvCGZAwSJj0br1VoASrKumsNH8dZ30ESq3nnicbUnaZRl1ZsfSvw?=
 =?us-ascii?Q?j+NAfGFHoXBAHSpWHXb7arTofBgCG+7lvnFE5CmBtCG6nPBrkajmWjrgSF+w?=
 =?us-ascii?Q?PWDJQaTMHDwQbsIUZgJM3KAvYZMRfirccM6DfG3dah20DjAi/xrdVwswSSLe?=
 =?us-ascii?Q?GZEHvqfOud0pEilBlByy2hQK73iCn4eK764MSVM0RuAGbjiLlEdlzkf0cFRS?=
 =?us-ascii?Q?pGLS5bYKjStv9Ob/axfmBKndltV4zS7/APBzH7yAosO2EvS2YGQBzB2/TDXm?=
 =?us-ascii?Q?r+qZAW2kS6i535ckjUQ8PdvZ2uzoK0wEycl2tC3o0MhNgBw8mU0cPDpqnnfZ?=
 =?us-ascii?Q?I+wXGc/JylJ5dWYyGuiVQMOsMZxZmm28NUYA+DOQOKobM+JuhN257687Vptc?=
 =?us-ascii?Q?CTVSrbLrmx1ucHY996uPVybWwsXMN1z7Y8q5Z7+oLvVA+ha0yajtQGtUCYaa?=
 =?us-ascii?Q?ZwZJTHWVFpS1Uv3SJsc8IZEJexvZVQxcoN78zbOe27Px6noN+jfvOFC1iPPi?=
 =?us-ascii?Q?f7y2Zy6DAPy6ILmbcnrw7YEoZxjQg6kkf7990qHdJ6gguO+gfU0u7SQkOA4d?=
 =?us-ascii?Q?UHZ+jDD5y7Or72UJL9WArs2A0x6lIb+0jxI6drp1s1Wkm49rSx4Q/MVwJKAI?=
 =?us-ascii?Q?n58EgQ6fXSBZDMtTQB4jBv2p8Mm0lTSTrosjsHoY0OSJIukTEa4qW/NaWyyM?=
 =?us-ascii?Q?fmrOzviCVck2+YLVRBRBa+g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6FF46DC07B019945AED4758A1CF8A98E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YMmq3Wv8+sn1UBINtt7618LsKloswDRlmDCfhJxEflE+DOGWxU30CANwv3MW4t6ePVnldmfRcLjLrqtkgFHwmZY7h6mwD03XX/GIJVTTyGYw6iDJlQ8GqvVVvE6L6bWarUw+iyixjW8Hy9S3g4MO/z7O0c5UGml08cj3ieHQkN+ydRxpXrA3tk8KMY8j9+ofSv2m8aj/EMioQfLbqr3EWNItH+HIooWziLrHPApJfa4Gyp90adcmlol3+LgjckJpXmKHGG3dt8iSE8RLtY+/7juxN73e+VWfT9RtBwZkW+646q7h8Li8Hve3/+ErgVSGVbmDGVl81fp6W7tb2WdpwY4RrklTSmIUR6hwR6zNEJVHch2PvBStLqPACkEvbuRYQKH2bzoqxbXAt3I3ln4hLWUH+8hdwJgZ4a6ACAgv7k8hc/9/vssuGZm4vG8ZwHoKa//h1/UcpYKdPrKMUTQDGkWo/gh0OSpYxkG3rjSWdX4cnbAk0ksSpWJEgiaAF8UcDryd+lvk6AohuP5uaR0bCXDhli+7c52/C5MdwEfK6PZbLw3XGoHiIy+7h2HRyfKmZ24LJSVWfvBn+cSEsKhndLNb9ejPUf0dY3Nf17bCqPzbahB8XcdjX0yVmd1YX3er
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77acb481-ded4-4999-0263-08dc975aa97d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 10:11:22.6122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ceWyUXfgbv0YRc+kbpl9BZi4hWiV9GBYFsRnTio2kQXwKmffEpUcYuX5o/NGprsVzISDJ7ifeDnpzJ663TzSKYc1gpdKGIuVahVMrCK5x3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7565

On Jun 25, 2024 / 20:20, Shin'ichiro Kawasaki wrote:
> The current implementation of the test case loop/010 assumes that the
> prepared loop device is /dev/loop0, which is not always true. When other
> loop devices are set up before the test case run, the assumption is
> wrong and the test case fails.
>=20
> To avoid the failure, use the prepared loop device name stored in
> $loop_device instead of /dev/loop0. Adjust the grep string to meet the
> device name. Also use "losetup --detach" instead of
> "losetup --detach-all" to not detach the loop devices which existed
> before the test case runs.
>=20
> Fixes: 1c4ae4fed9b4 ("loop: Detect a race condition between loop detach a=
nd open")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

FYI, this fix has got applied.=
