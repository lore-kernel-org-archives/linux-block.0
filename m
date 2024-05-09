Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0918712DD9A
	for <linux-block@vger.kernel.org>; Thu,  9 May 2024 10:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715251403; cv=fail; b=Grm1bL9FKpbNgboDoRx7kpUI+O56NOSdTFo5exfVH5heVMgJhmuDpGH8cO1mDprBPm4jvcOCExaSWqanGSNILTSZiNTQ3nzyXhka0qnjxntMkp3gLLl1u7Em540aN+3I6LvxybUSwjm9DNNOIPKebRbNvZthUf5YzPXjXchWgWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715251403; c=relaxed/simple;
	bh=4VxXOHE1gK+rOammEEF1lIRWusEHYxwMTH7Ry3QFRl4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nntpcGjqHrzA9FkprRl4qcYvO/9Y8IazjCAdrLK0/CBqEb5kW11rr02N7cLU/ScXWJIi5Yidg61lCK9DleJHBFzuKjITUnH6bbiXUMmkWMYrQSI1PkXbcs8ruptPq412Lgu2U4QnRiJRExepW0dRdGXFcMSsyK1cwfTXM8zCULw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kqtSDmS5; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=HWgEsOqy; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kqtSDmS5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HWgEsOqy"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715251402; x=1746787402;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4VxXOHE1gK+rOammEEF1lIRWusEHYxwMTH7Ry3QFRl4=;
  b=kqtSDmS5/F/lFJP77ddElT2Rv+TT83pwGZqZ6V1g3tVbxdRQYrJzQcB8
   b0XczyBUxHMUlKNDyKN0S26MPNNZPU7ss6jy4SHumtVdibcajmJ4NwoB5
   G0263stFtSe9OmHpp+E9p4ETZfXi965XfmP37DSz+lxtXxJpz0oWJ0nAJ
   9G9pPNN1jhBkSOCSrpug1IB/Wv5Gs95sI5GDQx3gytusKG0Bk5cx/9yAv
   95TN1fceBQpGt9voZzdwjV07nLE7IPmPQl1joQYIdfCHZKiiVHpDjIUpS
   8DlrhUCEai9F1KDirFb+pXQEaJglWj3ub1uD5DGz1s5SXgi1pT/0xRvsw
   w==;
X-CSE-ConnectionGUID: Q3SpZ8tdQXqKDo8IRt4YPg==
X-CSE-MsgGUID: GcMykwomToqItfqNMFH57Q==
X-IronPort-AV: E=Sophos;i="6.08,147,1712592000"; 
   d="scan'208";a="16187903"
Received: from mail-dm6nam04lp2041.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.41])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2024 18:43:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KccZfhdoKGZ6hXz2iIs2ia9QwrGYEIg5zGY8VXQ1zLDMh6a1hNPiwURhi0YnqK6UaOAkfUUYK6LuCRbFzkfnaPQplJPSfHZ7yNuaIX+lG5A1YQu8qWf+iICXeQEDpvQTHKKc8t72Nk+CSWQp4Vg0GMqMMA5LTsjsixF9OJt3XmAp8sxtXOjQ+o/QcoHJ5ESmCcTvJPYYQsCiOo9LApj/3Oqbz4E3tQLuvBH/Q0jdvp/OvrnL448ebvCOrLhvJwTVVUvpVRj+KAGPxSHO5JMXvhlDg59I5RPvcGTTGEzXqU8ANHhjhzDKzddkVe5iYDmTEHqjSYQydeyZbjNuhIQO5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0visKUxUrob3XZ8iA9Jn7vUhrcBhpfjHTjKFyJkL1N4=;
 b=mj5tPxXWLliFm3Tevap15Pe4sqBgbdeb7epOULQ9QGqN2M4/L/bflLscs6D67fXe40Bj161BD045+i7FTdWTj6mvMbnatjnQmdOdBpIg7sNBnZM71R/70JdE6O+QijCPQDaNK4tlCpe1mGcii0jORIlGO6agGHfXJU6BkkbObD0nnOxB8fw1F1Y0AYW5JHsC60kSAZirA/JDwDNhmFjx88guOV5pRG/IhDe5i7zPYReFUmHNuACFj800KTX+Oe3CAXIJzvciEgr1vAfpY5+h048e/hxZHdZr4ozZD4EhCvqO7NtTEwyxNbpjWAYiTyiF13vB+0ShsiPpPpfJUYW9yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0visKUxUrob3XZ8iA9Jn7vUhrcBhpfjHTjKFyJkL1N4=;
 b=HWgEsOqyYQhRe6RMeMcH0Tu5r6zRs72sh9yoNQwqrzE5401l84GY5WzXjgFADLbTG01DcK+mk/ywCB6LH2nVMiih+KjAw5frcfRtKVCh2BnCzdZeEYXhar0uHsT0PN0sOCClLHlFgSQOabAgLUkkc75SmKxA8iJMO4W8/AIN+VQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB7044.namprd04.prod.outlook.com (2603:10b6:a03:227::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 10:43:18 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 10:43:18 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Daniel
 Wagner <dwagner@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg
	<sagi@grimberg.me>
Subject: Re: [PATCH blktests v4 00/17] support test case repeat by different
 conditions
Thread-Topic: [PATCH blktests v4 00/17] support test case repeat by different
 conditions
Thread-Index: AQHanfskESNiAEBXBkigoijujDdN6rGOv3EA
Date: Thu, 9 May 2024 10:43:18 +0000
Message-ID: <vdr37ciqnbjpfxb6yzgpxoqtjlvbgxl7czz2g2mr2do6gprabg@dze7yhsz7nim>
References: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB7044:EE_
x-ms-office365-filtering-correlation-id: e8aae29f-090c-420a-0f94-08dc7014d704
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?j5m+qwrzV8L2QsUGEpu5fYtSvUM7oIwbxztbQBuqZFk24QuiSvO+IB4m6tvZ?=
 =?us-ascii?Q?NwU1c3Wtx5KnYn7w8npUr4tq+O170t70w278ljA2t1svgDpGZbjuoDjbOPxw?=
 =?us-ascii?Q?8kik4sBWgQIS+OitEqHY4BsFvhJ1NLN6cnnG/s5yIa+FsUq9eaSuBx+f+HAu?=
 =?us-ascii?Q?Lfuwh+rmMWZZ/1MIbxE1AmDIj07s+Fzj2Fq9IOe3BhTLaetjKbMZkFEIs+4z?=
 =?us-ascii?Q?rjkhLWCTPpRwZUOH5D9ZD3r9D20GWg8+rydlT+O2trUjI0wUcq9szDYJ+t4D?=
 =?us-ascii?Q?wC7DUna/2Hm/De0ug+cUSyAjuD+ZxFbEHm6qlM7DOpK+xA5BfQ076lCh1hFh?=
 =?us-ascii?Q?bOmb1mStPmBHR0XWICZiZgYiCC7DU/TxhhNmnUttC95W8xrhdFC5VKlRR0zJ?=
 =?us-ascii?Q?FFP6UrKonDd20wb+kKhNZVg27VkrhAqVE2BAFdxbZ40Z2ul5z/DAAb24h65a?=
 =?us-ascii?Q?yqgTJM2Fr05yjL5qxaR4WqEXi9CPTDSMo5cw0GKELE+tqIxlX2xFag2MirNM?=
 =?us-ascii?Q?nEONZ6CpIJjRW7bKT8qsF78fqvn7lDv+aLlSWQ1EQK209NrsCnBXPnpgA4V0?=
 =?us-ascii?Q?j1282Ls60W5FD+y8c3uZF0Ptz4aJsEEOS5Y5iHFAcgspxrdIDMUZvCeVtx5j?=
 =?us-ascii?Q?t5l6FeCJ/ZudsWLYyyUsiLqfkYUXqbSTIMVba3RReQJcw6gKjNutG8tHp9iz?=
 =?us-ascii?Q?XpqFsu7DPDR5wxzyM+ygNhgzh4mBkhoJeyTX7+hzTRoVrkGibdYf+/JqvyZ/?=
 =?us-ascii?Q?ntMmw4TbxCjou7dAzc/hNCJHtVHlh6tCxdkzQWF5r3Vio/mf1lExlPts7+BR?=
 =?us-ascii?Q?zN9Z46ympCImVkExBmyEh/fDgAPDY1UNyESPXGYeDA64ZZik7bG7wcjb5aL5?=
 =?us-ascii?Q?FzZEl8AKkybcezErvShYzYNRqNlY+/ebGnpP/5S4CQgfePOZt2cqA+JQbspO?=
 =?us-ascii?Q?hxU63hSvHC20rV/W4xIgDjauC12KDPOiN8UkR1aCYzYAiMCuf6oiinzsPEC+?=
 =?us-ascii?Q?0vCRrtumtPwpZOFASl+XcxnLjemsvVArSHKdYbAG2vLEBQePpxOSb+cdojZd?=
 =?us-ascii?Q?v2gR+Kl9J1zBumbEP1Ja8z4+kbSrrWU4HPh9lia61YlyahAhXucHbdwXEmP5?=
 =?us-ascii?Q?t9o4iIxubWfIMh/dg+J77iGr9ziRpmQiPDuTs2tsn8FDV/XTCgFQ+7FgtbaE?=
 =?us-ascii?Q?aoohrji1VY5zRP3Nz0re1VfVhZiy06wBMzANnp+gGaE11Ly3lsVGi6DVB/TX?=
 =?us-ascii?Q?eMtVOkx7gglopuXANri5l7UL4tsQ572YCSos91J/iw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KU04Mc0wdwN9L1P1japlZnFeohfg+AzemxVN7w5vkRDacqYl0ExzjYSsnPKi?=
 =?us-ascii?Q?fTDuZ+5J6ooY+S5tvnZ6j8lWU23gVLPUcvFWW7AgnOUIl3ynhXNIekQCzaVu?=
 =?us-ascii?Q?SU1SXj9N3M1LzYYeODif71mFbsC01kL+RQ/mlt+rUWZ4h486aqMNb10PToZy?=
 =?us-ascii?Q?0+jL4RRtdYMWcA3Tv8WXo7phpYh4lltWjHXN+JGmcGZwAj5dk5/6wQutlQGm?=
 =?us-ascii?Q?o14Iix97GJ4DfeDrOQBtKmEyClGKGVDDykIIGLoZBxJENw0vzjT+1U5p0h2M?=
 =?us-ascii?Q?gmDW6CTztNSepMoJu7YjdoFU5z//xDnS8onfW2YoCpxi6tSbIUlIJA888RI0?=
 =?us-ascii?Q?YPF/PNn9Exh3wjSkOfLTwJU8gzmVE3fmveqaDe7IADuFVzctEuygtx3ZEn5E?=
 =?us-ascii?Q?m8kiTZbm0UCgrj5OB5cJahMUIp46EhgOp1DF/5AiqgyS21lk8SGdKKy9+yU/?=
 =?us-ascii?Q?VwQakEC5qJJbh1wgLeRGLPtRVSBeRU0ID6t6MoDr2W6YDKRwl2oIsDkUrvhe?=
 =?us-ascii?Q?svzrVLr6gry3tiCRsCSdSx7h8fLQX4TTRKdSJsXsoAdmOhtk33ozGqh6VzBj?=
 =?us-ascii?Q?mCB+5Pl8jMw+DfPoRi+WzVePYa+ra+v9RcHcrpJKsE9yfXSWL0jnuVZ5tcqo?=
 =?us-ascii?Q?f3XIGFDNBcuGtE4MmQLncMmi0Jkr7v2A4kwCcXUfl4vXEjIBQ5H2EdYpFYs+?=
 =?us-ascii?Q?mar/lCVn64cE7bkpnAf7QwMSOeuAWI8thmbhqRVaLalTal5iux0fJbp5CjNQ?=
 =?us-ascii?Q?wm4xY9bVD+9Qd4lDzMJKxuffmIpMhqJZ6hzkVKTX/b4/tRtNq1IxSXJmaaKJ?=
 =?us-ascii?Q?ar+l5bogdZpnPedkbPdfbqa7/tI0Zn5aV8kkws2/QzKg3zmjZRgURNT7tIgD?=
 =?us-ascii?Q?xZteGHr8iJ7qztEB6Npdzoc7WBpx7muFqckSMKZKIJNBKyPdkxLo2gRxVluU?=
 =?us-ascii?Q?khpI2EzW2GR4Ih0Vtoj+VlGReqMfL7lIg1bFsnkc4eOKrkg3qGLhMWV6KT0X?=
 =?us-ascii?Q?eYq2++81lKMvnAumnLIjf1PEz1FrKg4nWTQ3h25MQ3Uy+w0m6++vsDwWAuCx?=
 =?us-ascii?Q?RxRIBM3KK9/VkbJXgOacVtYDq/ZX6FERHes8jLCjt/C5zHPvmogfQrTBwzSJ?=
 =?us-ascii?Q?3Qy6kZJydzwkiEfENvdEUNIuSRpi0YQIjQ9h3d82G/S0lFTMeZh8msWeISIQ?=
 =?us-ascii?Q?88Xx0kdNJSMmiad/JuO6UQyF9tjxY7DDV6+hqmvjyawbLzMJ/gqv2eTZUM1j?=
 =?us-ascii?Q?SQxRwOeCzPmOASsmeE+oFsmbS7sR5rkizqOnjXyFw5Xzi+rHRNsthRXkQZqS?=
 =?us-ascii?Q?VIBmQdskLPPWX0IU3jVnPc/SerDMriQTtf6vhwWoAK+DM2oiS0M3oWoV06nW?=
 =?us-ascii?Q?DHuQd4hcN+aG3e35ZqlLiIQzghaTAJ9C+sCSr/TvfJg7qF1M0kI3K22c0hfP?=
 =?us-ascii?Q?WGBh4FDKhNy//xbs9wc981/w9Z/4rpuW+2mLSHM0X0Ug2Oy56BQsPMoM5CbS?=
 =?us-ascii?Q?PuuyBG/vyeNMXgWWzRkVo+Mvzv/jwSO25CMp1Gmd/4QJjNWjDy+YSphKfbMg?=
 =?us-ascii?Q?5bFyMJOCe7pT2ymXwcUXOVD63dCPgqimXBX0RaibgThqnRfkqZWGNyKe6yF1?=
 =?us-ascii?Q?+L2xBDgJWvTQgJL7lX+1BPs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <389152A29EF6244F9047A712F2DC1053@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rdIsWj1u9f149MBp/mbXZBUeLSB4+DEyaiw8c/l1YqxhvrJKL8Pv9Se6dJ02mhdQafBZZJnTL0G8KVEG8u/7A/bIJueAg6+BSQyGl8cG5Y641Y5h7u8Szz3de9ODmh5nyzaxDDCRRbBO/i+OY09qhVSBgyjNDDQdkJPp9dZR4jT6kVUNU5xoFO/n3nv/R+a0fAzCgCRb5o4kMXa+X0f58vZjemE6OqoMdtC4L3lOb/oPEco6d+zwQE1s5t7fDKi9dT1nXC2RXnZB9/zOeVL+5A4nWdenKFnQob/3KWhhjbZ89cR4iUODMezJ8N5bk/6qMIcFslc0H0Yx2xijLjoh9AQuyyrUMKeanXgv/oKxxYTRXi6xllYG9AmWCDyTnG+O5ZJRAah7jEJF+717aWB9BU6L0q/he8Bj4euyRz0YUcSO8UOVSkCXNR+shT5kYLaHQo805IfNto+OaD1yHWDtRjVgGZ8bgcDcIL4RWmW+hY74WFr5NLeCB176O50izfxFzCQLFJVsaL87xxDr75Y/LxAVJdKcFEKsNSZ0gPgv1YieZqHnAAocuMkc0YwBbLr4+FnbzVJo5doqG7xFWiUkaYeiZ5wjeEQkZTwxOnrUuJV5blnGlwm9wAdSRpzsOe0E
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8aae29f-090c-420a-0f94-08dc7014d704
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 10:43:18.8393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: htcaUdQwMyAvzW0HacVwzoMznUni/6YzX5cOGfBvQ3wq/0GLQJYXCbMB1TaZkG8vkTA7hkpHw0HuOvmGCzBBrHmHdPnMR8Q3TeIcxOR0CGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7044

On May 04, 2024 / 17:14, Shin'ichiro Kawasaki wrote:
> In the recent discussion for nvme test group [1], two pain points were me=
ntioned
> regarding the test case runs.
>=20
> 1) Several test cases in nvme test group do exactly the same test except =
the
>    NVME transport backend set up condition difference (device vs. file). =
This
>    results in duplicate test script codes. It is desired to unify the tes=
t cases
>    and run them repeatedly with the different conditions.
>=20
> 2) NVME transport types can be specified with nvme_trtype parameter so th=
at the
>    same tests can be run for various transport types. However, some test =
cases
>    do not depend on the transport types. They are repeated in multiple ru=
ns for
>    the various transport types under the exact same conditions. It is des=
ired to
>    repeat the test cases only when such repetition is required.
>=20
> [1] https://lore.kernel.org/linux-block/w2eaegjopbah5qbjsvpnrwln2t5dr7mv3=
v4n2e63m5tjqiochm@uonrjm2i2g72/
>=20
> One idea to address these pain points is to add the test repeat feature t=
o the
> nvme test group. However, Daniel questioned if the feature could be imple=
mented
> in the blktests framework. Actually, a similar feature has already been
> implemented to repeat some test cases for non-zoned block devices and zon=
ed
> block devices. However, this feature is implemented only for the zoned an=
d non-
> zoned device conditions. It can not fulfill the desires for nvme test gro=
up.
>=20
> This series proposes to generalize the feature in the blktests framework =
to
> repeat the test cases with different conditions. Introduce a new function
> set_conditions() that each test case can define and instruct the framewor=
k to
> repeat the test case. This series applies this feature to nvme test group=
 so
> that the test cases can be repeated for NVME transport types and backend =
types
> in the ideal way. For this purpose, this series introduces new config par=
ameters
> NVMET_TRTYPES and NVMET_BLKDEV_TYPES. Taking this chance, it renames othe=
r
> lowercase config parameters nvme_img_size, nvme_num_iter and use_rxe to
> uppercase to follow the guide for environment variables.
[...]

Thank you for the discussions and the comments on the series. This series h=
as
got applied.
