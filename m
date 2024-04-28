Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B451F21101
	for <linux-block@vger.kernel.org>; Sun, 28 Apr 2024 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714300333; cv=fail; b=FHPLlVIUPbO/moJs5QAlymNQmHhENYYIj04rJ1k2brF+jB+A1nkfkfCUX0wb39omW1aSAQ+nxRg3dTYoE2nGKFknSQj4kOVtGL+x+yXGTT5Adf7QARXJgaNiEJgUW7TByT2wWXocO1LF/qu9uc3t7209RpJRqygLFWAfmbzW0Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714300333; c=relaxed/simple;
	bh=TYLOYJEKQZQlGisMQhWXmlDpHq4UqlZaQ4V/IBS1XE8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VPFvkCOTy1xbWduiaAVNJ66Vb1qTpt6oJ6rsJ2MnXddNtYQhp0QX/5sYagbVFfHfm5jhiOMF+nIK+P878LrE6s+SXpHXNm3MTyUkShp7yQdytrMaGVJxTWSnVo/Ost+mHGYkdf/gbpJJj9ArKIOG5wydXdR0mWS0puUIiytOsrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fYHFEaqK; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=eww2sq6S; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fYHFEaqK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eww2sq6S"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714300331; x=1745836331;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TYLOYJEKQZQlGisMQhWXmlDpHq4UqlZaQ4V/IBS1XE8=;
  b=fYHFEaqKRnBqTG73Kj/mIF8EcOYRBvcQDDopo0PRK9vn05NYMVyvwTpL
   P+SJmHvOTJgkAICBgi04GQTFgsJQRIGaajXA6mUM/9i2xkYwC2X7tdHF4
   6ZNQDGwDTiy5iOhyU35jfvoT5q+bCQOosWUgcuTf53fnsjU4NHJkOzKbQ
   +YPS0wOj1GIYsWGrocj1QpoFAYwk4nPP0JhtVmCM/Gt4E1Z++IVaL5d72
   LBLOnbQvxOj9qb+DOfQ+nkvik3ZIsgwydezNO1CQLyg1hpxRCqtyEPT2Y
   e5KPI13YSfWAW97GAcvLUfRJgHo9aL/Ba0WG0gHt9LyKBwTKXGgr3j7gt
   A==;
X-CSE-ConnectionGUID: tow+QjrHSQySZj9CbEf7qA==
X-CSE-MsgGUID: hTOXx5QuTfCUVVAWNMfTpg==
X-IronPort-AV: E=Sophos;i="6.07,237,1708358400"; 
   d="scan'208";a="15044491"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2024 18:32:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CpEOmabTbAemz+5ExBipEo9VQwXgyTEq7ZR/leFHW69U1+7pEews+6tmF7oQYLSpjjJ82r2CyOgsOy/EOx4OI6lr090OLTxXYmTs6v4I93an86vqmX5JXoMWXSJFXQs7jf47qZCfc5jlZLE1KdD9DZavr/kWYiwtIo/wm4oka3/dWORPumJyX5iY0pKi39vLUt9I1eCBoVpbLbljwUU6yDtDAczV1tGFbBkID/EMKaXYK4H0ltIh3pQI4XoJhaF2sG1rF1Wy6hgAbJLitVhjk9d6oE3w6UJLyYQksvWx1WEXdzfjJL1X88vprwBw5INfDjY1wEC0xhY3V0IO6ItTLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ON7K7KX2/US6dh8wIrIUMquaafUtVe5tnyXpINSCH54=;
 b=Gc691b/JzSroNgdFDepNtFwZ9gM3iPdzjfW3EBooBiwwDtAMFpEBxjElcjdurz0SuEPOtuB19srPgGcZQriELT2lxH3Y3EBsY6HhRmksKwy6akTA8iob6lCZvJMQaVoI8lilUiYUvDhiKK9A9UFObtOXyvQwJyvQiJE+iKwG0EkrOaBoM7Ho0x+OxgOjJkdXaUYgSGB2417OQoZuPTk6OUBhJjgjmq5Vz8hJ8im7AaIXaYpzW2YqKEw1/up7Ri1RJ3JUocbM+AfsehqfcggvyHyxICumapiWaKhJlBi+3tHpoBAPr1n+oQH6SX7Z/W99XyM0nkIeNkkrEf/3Nh/nEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ON7K7KX2/US6dh8wIrIUMquaafUtVe5tnyXpINSCH54=;
 b=eww2sq6SdTr2A/xDKdDkSC0ClqYCCYi3Rwx2JQFF4GVcyTVrNWXv+X/OcaTgs2DXJmYkgeRaasEwENOC6x2+B/RLiSL5uPOzTYvAoyATQg5YAraD23coDzm5Oethu4gbezqvtz3q7B3oq7g3egPRa+pWeoPCdmEaGi9nSt1ND5U=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BL3PR04MB8107.namprd04.prod.outlook.com (2603:10b6:208:34a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Sun, 28 Apr
 2024 10:32:02 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 10:32:02 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Daniel
 Wagner <dwagern@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests v3 10/15] nvme/{006,008,010,012,014,019,023}:
 support NVMET_BLKDEV_TYPES
Thread-Topic: [PATCH blktests v3 10/15] nvme/{006,008,010,012,014,019,023}:
 support NVMET_BLKDEV_TYPES
Thread-Index: AQHamUo6D+gVl3vVR02YXq3wno0qJ7F9fAYA
Date: Sun, 28 Apr 2024 10:32:02 +0000
Message-ID: <36jinbbjhzr6erpfpnfqmk2jebf5tlnl26skuak73krwyyu6zi@i5qtgb4bqqgy>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
 <20240424075955.3604997-11-shinichiro.kawasaki@wdc.com>
 <6b55293c-0764-4922-b329-be393c9afc81@grimberg.me>
In-Reply-To: <6b55293c-0764-4922-b329-be393c9afc81@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BL3PR04MB8107:EE_
x-ms-office365-filtering-correlation-id: 4685e489-54a6-482d-b3ca-08dc676e712c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+7e7BT95wjtfkdnn5NiIRihMNrxYML7wyLymicQC/cxMzejQ7C7hpy8Wii53?=
 =?us-ascii?Q?pX7zusHy0eDro8taZ3587Bo0Q9JapSbd9E5WqD9WkOnrGTdv82+xLevqY12o?=
 =?us-ascii?Q?VubVGuZCNqrd+4c0cy0Kz//+7P535Fkq/e/ZPZh34lE9i2ovXMjS/cXyzJWO?=
 =?us-ascii?Q?thSX7XGFkrFldhyPXrRGB6WsMdQ1iL0AzF8iglICUokfAtPjXnzO1YkGUPWo?=
 =?us-ascii?Q?s3LJSK8zPazUb8g4Pkyjj1IthppOwZ6tpWf6474ZqT/olWXyXxuIxGv6bpxh?=
 =?us-ascii?Q?wRVKg0YmMX7g1IIrxlqAI/3nCF6O2Sz9kfukmwvLprSdkT0IJt1CPkY2BO3K?=
 =?us-ascii?Q?cCUQMri0RlwsI2Kgnw+fH5535kJZw8LEqaH7e7y4PJPBg0/nCgxmV/g56i0I?=
 =?us-ascii?Q?9q2DBqSTZkPfmeTTo5+HgZJThDzL57xXdT0V5QEvkaHUE78nghtEH/42lyF/?=
 =?us-ascii?Q?gjrzK46n907x55HAK+pdyzwVEzxK6JxZnefYpythw5/K1KbsMis0i3a7JxPg?=
 =?us-ascii?Q?ft0rIBKwoMJnTo1zPjgmUi2qjwrk+wYLu/jAYM7i6mLGTqr8qWajbWKQNfmX?=
 =?us-ascii?Q?RpjJA+sDRxNVdmGQpZTLyTRC20E4IYprooBEeogACpX1R+cHu+SRUUMJChAP?=
 =?us-ascii?Q?4Ku58rvrS8OIiuricx0/7m09eH1YpRKJzvvWVFHSdfzo0q0P/6qD+lPGfH92?=
 =?us-ascii?Q?/+c9d4eQiNlLDg7rDZodwuLwqnu5Y/oDni5luxPexb3UnoX2JmUCjjtdQgBe?=
 =?us-ascii?Q?vtpS6dx77FRv7kabsZ78Qw3xcFCiYJUTWu30vMmpaCo4CwferMh3fQHi0vb5?=
 =?us-ascii?Q?yeg4dPLkH9ZDbWxO3if+2F2f8ZHUKJGvpZ4VrCaE76tLQEwxwHjFr0jOsJ76?=
 =?us-ascii?Q?WBrSccfN4x8X9ZFhDRT6wFAOVfyfSEqDwVCM3AevRBow/P/+/FPXkCDCmtF1?=
 =?us-ascii?Q?Fwu3wI/gbC1lrY1OTymrEHJct9og9xkb/tDs08eCEFIrGTYVVeNs1buog1Uj?=
 =?us-ascii?Q?yTOD9rei5vH7FN1hPh7K+Pcw3pePRAXQXYiSU2EOScdt8LQb2+LJsdlK8IZ/?=
 =?us-ascii?Q?OKv+QKBCu/0+VrRhZKIedyUct0JjZtannx9bXUszjvbZLb+lWtQ6a8BVMH/U?=
 =?us-ascii?Q?ai5laIFDEshOnbnAx0ByfCQFZo8TnOMWoWkkMQljWBeTelm9Sk7vmEvOhHRD?=
 =?us-ascii?Q?q4N1uOcJOYCA4HnHWGn9FSd7VMX6IWC5XsowGESu7DfqHryoh/MkCVMUlICs?=
 =?us-ascii?Q?b9nPonRR3U6ZtcOPAj0atCVXAWs7r/RtbMlJDZaGMNNbnWTV6jbwVNzcBSa1?=
 =?us-ascii?Q?MsAwpr7OBMKW7e0ywGEIc6QoUIOfzq3QJATYNtxviyHfXQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bCP2LPb1tkrggY7mk2X4TLqwXnN41medLvcUxlF8h9XtBsvAWnf4mU9EQfxX?=
 =?us-ascii?Q?C9LZol/oTixn4sdifCLSXY0KP213lcokFKtHuBKyTpN0Mb5KPyYCdFeYhINe?=
 =?us-ascii?Q?bQO83NllEExz0zyGtjP5ByZhJsADOxOdtz4XFpXN7cQ6l2cF37aZa1m6Lw0r?=
 =?us-ascii?Q?T0AY403KHWRh1y2wW0B0S5v0U2J8Nn6VpkMQHQ6Lp6v05VrQlgRXRV2FDIRi?=
 =?us-ascii?Q?C5mZixnEJXvl6bYBz2af9K4oZdbiRF/zDCx4CuQGLpcZ6R2+7GvClwo0+7kf?=
 =?us-ascii?Q?fL9OXfF3YUahZ/MCztRHRqtzNKWS4JUi/1GLxq2Eutnz0vAjFt+mpCQufgYU?=
 =?us-ascii?Q?NfzZLrClxCZ+a4kk71F9LazDupxVJrUbwmboIXkOqCscek0uGpOmk/E5TMM4?=
 =?us-ascii?Q?Zl+ATRveJEjhGyn4jVIRItCnvOMR2fOsx1esAZ5x/wROOfSDjq+rOu9O3a1/?=
 =?us-ascii?Q?W/UXiDiboqAXJ81k+34z2jZHg4gfYSKsiHzqBJMMC0qWx09sxO0NfBjeo98G?=
 =?us-ascii?Q?ORMYHcf7w+ydf8FlYqBimhdBtNsJr0mu9zVAsB/a32uLZO+Fas45s363aGPZ?=
 =?us-ascii?Q?x39WFmEILHtd7XQib8UnepKubdOvZ2VU4nO4omK6Ab8CB/KVP7wZn0oV/L+7?=
 =?us-ascii?Q?tgfMLbwtOj/uyyl5dZ1idy2GKh7YqpQ2plxSPAuQqvDTCXSuAr2/cl0BGb51?=
 =?us-ascii?Q?Xfh2iaPTN3hFPf3UxdljGg28bAb/QQlZsW8KYH3/eRYMq7VEzPTTBLv5SPvc?=
 =?us-ascii?Q?4zFJnsC2ybiYY8zbltkYdmWs+oqCXpVxBs0xgVtjU4cHWnoetnYbMIkGmXtY?=
 =?us-ascii?Q?wrXDcK6ipLn+huE/HCwdMrOA9HGuwdTGGaje/jk1RxP2lpdveM6OgdLR9vOi?=
 =?us-ascii?Q?jEpQV3aDRXshA8xI+BjQnmvfdAbQzQfsDGzLfk4t7E6SYg39L308lhWb8no4?=
 =?us-ascii?Q?X+GdV172yceNr1QlUEQEvmCK2ghLRkxpDqChkCSFhxy3pQSIzn+6SwNIyQNs?=
 =?us-ascii?Q?MOZG6zXCMoJMuUcwQQrEfy3Tu1SU/8WA9V2wEfoCEYPB4Zzvl0DDcHsz699j?=
 =?us-ascii?Q?HyssWqumlXe8W5SJQrtGZwasJgIeiBETi3DFywSYWAPTGJ8bFHY2h9aNwkkY?=
 =?us-ascii?Q?rkWyrJ7BnWc24TL/iQSoaQFRPrtj18NYEaHHe6A+0QnE4ucGpt1Ha2r/OlFg?=
 =?us-ascii?Q?OXOU94VOg7Z1Z+LYdQExbVbIcRoICoz5D9bNxglqpknz59/eFtKp/5O5uz5H?=
 =?us-ascii?Q?ePBnXEXkZ7IdbJWYo+uNPDpYlxD/Z/YMeKNVP1EFgulQlkoXfdJqWKETCFom?=
 =?us-ascii?Q?YJuEt+16lsuTZVm+VfGEhc4ceUaF9/mcOj8Y7JVc+k3vH7I1Wcg0lFgId8Q2?=
 =?us-ascii?Q?tmyP6N07nszOM2q9+BDPG9NbGwBDwB4Y9OmqkJRwweCEHRVOIRlbaPtH4IgS?=
 =?us-ascii?Q?Ea18mBw2WMClO6opItb9UbIYFpFUuGbI9QBxkW0bzpojSDPuVLoI/uds6ipq?=
 =?us-ascii?Q?e3WKQYfbT+EwYWrYsLha6zvu6Q+Ex9PZGdiRsn/cInHBraSVmimGhf5sl+Je?=
 =?us-ascii?Q?cYHqWUa8GSuygY4mBmcPMo2qrt2HRaUt5F/0ODjJeHadEd1L7QHoN/Jrt66D?=
 =?us-ascii?Q?DrKIoafFrjK5J2ZKdhl11MU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4FD01A13A1C6A84DB3F08C2D07607DC4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RdgNIU0bBWEZ7rzWPynJu5KUwklzuLofWvgcVbl7VdsqFeOKafnB2FvoahuEkT+8GEX+noBA6jruANRmWevVs58IYCXvkaqoNMiMgfvFDydZ+Yr1I9ngjM1XqwuKoQ1+Mzx0hPekd2Fm571FwDT4mjMulSNvYNo93EwP/leN30d/kUJQm8Dc7jm12xIx82LvbYcUl9qHVNP6PibJj/eHch+99tgC8UPwDYm14p5xy7793GZC+owct5Ic1OqSTitKWUm9VTGrLi6SwU8iXmUemkf6SYNo9YiHOZsX3WhpZ9A7IUrVGBJ+0HkCDq4zKEVvg6dKGUwpmO6lQy9GLjGFmy8sjf03uaAYyjSHDEahQQu6qPtxtLhDClZ5iLJTR5fjjoy6A3bzuH6SfMU2Z1YknPeZizxA7fzafngKwglox7DicLYUH/iIuG1c1ZtwrlI9e71qBmDTwcIj/rmwJ5yyZZP0QwdUrF+3HuK51RqC2blxgJhGpbMt7KQe7iGeO+eAMtLxbySdNK0QKmIWP1pJF8gjIQeKbUyJsm2uBOZzTPetNCV4tt7ljLQ2cgyEQB9t7Ee9bSBFJzFnucgHJ/Xwm91kGN5Z3EB0XCSRFjslj0GjONs4rvW3txpz7w8NOkRg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4685e489-54a6-482d-b3ca-08dc676e712c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2024 10:32:02.2564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4oI1qvFIGNeJ9BuAU6jrXj48ohDqPwHRbjJF7OGjk3fZ5ZJx/5afold0NPXJyURy1dXmpziXzRaL9HSuVrLz6NQ66xEkTK8dlTebcjgxrV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8107

On Apr 28, 2024 / 11:58, Sagi Grimberg wrote:
>=20
>=20
> On 24/04/2024 10:59, Shin'ichiro Kawasaki wrote:
> > Enable repeated test runs for the listed test cases for
> > NVMET_BLKDEV_TYPES. Modify the set_conditions() hooks to call
> > _set_nvme_trtype_and_nvmet_blkdev_type() instead of _set_nvmet_trtype()
> > so that the test cases are repeated for listed conditions in
> > NVMET_BLKDEV_TYPES and NVMET_TRTYPES.
> >=20
> > The default values of NVMET_BLKDEV_TYPES is (device file). With this
> > default set up, each of the listed test cases are run twice. The second
> > runs of the test cases for 'file' blkdev type do exact same test as
> > other test cases nvme/007, 009, 011, 013, 015, 020 and 024.
> >=20
> > Reviewed-by: Daniel Wagner <dwagner@suse.de>
> > Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> > Acked-by: Nitesh Shetty <nj.shetty@samsung.com>
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > ---
> >   tests/nvme/006 | 2 +-
> >   tests/nvme/008 | 2 +-
> >   tests/nvme/010 | 2 +-
> >   tests/nvme/012 | 2 +-
> >   tests/nvme/014 | 2 +-
> >   tests/nvme/019 | 2 +-
> >   tests/nvme/023 | 2 +-
> >   7 files changed, 7 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/tests/nvme/006 b/tests/nvme/006
> > index ff0a9eb..c543b40 100755
> > --- a/tests/nvme/006
> > +++ b/tests/nvme/006
> > @@ -16,7 +16,7 @@ requires() {
> >   }
> >   set_conditions() {
> > -	_set_nvme_trtype "$@"
> > +	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
>=20
> Why not calling separate functions? having func do_a_and_b interface is n=
ot
> great.

In this case, we want to repeat the test cases to cover combination of two
conditions: M trtypes and N blkdev_types. The test case should be repeated =
to
cover all of M x N matrix elements, then the hook set_conditions() should
iterate the elements. I can not think of the way to handle this iteration w=
ith
separated two functions.=
