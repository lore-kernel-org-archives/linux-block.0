Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F481DB534
	for <linux-block@vger.kernel.org>; Thu, 17 Oct 2024 11:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729166116; cv=fail; b=YtyhNYPf1OjgxCId70lLe45lSaVwa4QnyyHV6CA0K2QqQqj1INx9hup50XY8fwZuxgZ8VgmttjdFIrDkmuw8BoNx2Orx3qG4jdTZeh1KbLgopzd0WZEHGXqLqoCj05BZwbJJ0J3RKT9nWuS+LPMDXQQXyQhMHr0EzJvrzN41HkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729166116; c=relaxed/simple;
	bh=lrPjvCE3fKKBsHntDg9im2JeQyHTx2frUooGFBkwfKs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E+w/glFnFetFpXtHTOlnKKm7WtV4ZqbILTUxCj8hhS8lJQxoP1M6qkRdexORWbErmaULxzBuABWXwY8eDpD2v7y1cXEjD58sVpIzwbWcxYI98jyqrYuqvKy7GzNWIWDVE+G926NHZwuQxf+F8c2I9usCriEKipj6Q0Klxx55iVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NIGgCoeY; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=LigmycVQ; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NIGgCoeY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LigmycVQ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729166114; x=1760702114;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lrPjvCE3fKKBsHntDg9im2JeQyHTx2frUooGFBkwfKs=;
  b=NIGgCoeYN5arLldcfGO+2l96okqtEGJzpI/sBgSVJpzjsaQr3pvfLN2n
   OUaFjrvywBQsp6IU+faBMHMlpo/CSwNQJyBWhb8JLV4MNLGp609GwOKEa
   gqMSJ2m5TlfMlUPOHiTuzUt8Tp7Fg0hrl/73eiwBT11xkVlJCbGb1tHio
   GBYuPoePl4ezqSthm8jd/Cvj3jHkciMgII7Tnc3rGZIiPZvcy64TehJBo
   RCWehhXw4w8MhnemqaXoy6XwysDUYvqSYv2O76NyTQRsPsIqA3N/uDQA+
   DY5E3/PHIr95yfSVj7dbFqYn6K4eZ4/MA09VAgPtfxBbVyo7rp/n0NYt0
   A==;
X-CSE-ConnectionGUID: 7ikz5E2QQuK3ptEPvFZzCA==
X-CSE-MsgGUID: R8ieGcrGTnSqy+iw4fYExA==
X-IronPort-AV: E=Sophos;i="6.11,210,1725292800"; 
   d="scan'208";a="29179050"
Received: from mail-eastusazlp17010005.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([40.93.11.5])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2024 19:55:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDS9L9DKpeM4z3DYrk52zDlWw1spUDHzPd80pR+AjDOOUts+MNHOlxuoAAiOfAxVYGivkZt1IzGsrG4/s4YRa5NFA9uD2MKttwYJGJPjIoylUaLEx/Aj0D3W9qwxgUwL0qJjp1Evqt0BHzo/V3hX7a+ThNSFG0+y+d1lMDiodl4zehER5G7+6oXp4Yx3MxwPc+34IoGKgcfgryi77+qp/dBAVR3ukPowjlJXT1KUL0oCIFmk4fsEKDIgRSTFmwtGquO/zvei1OEcpvwrn9piGjcU4A8Sc/X3brwhm5yPvvlCFMTzeBxbbJSZYGt5CZ5gQWprDTp4Xt3iydaXTlrICQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrPjvCE3fKKBsHntDg9im2JeQyHTx2frUooGFBkwfKs=;
 b=ajlkreDSjW7r9caRQq1Z4QHeWPtQMTh2cHYtOYlKV/jHLGgFWqmffQEoOLHWISKV56Z3vMIfQnkShMo2MzzwW+JDxoPwKG8nw5TsYcu1zU2eZ0SilScrbGrGoyaGmhKmsBOVwXD/5A/V3uTAUTWXyAzFVyZ3fL2X8xBF9C3YRoVBEhq/oIOWM3ofiOO30nyRXcT9vNAQIyxiaNNjnPLLzmwy6wUL6Y54aZ8ifhzUIcerBbWnz7ACw2xUmCHsFAAbpsPKj96XJNpfGSzCtCFqInDe2SmYOtwLuhMQWfof/ApXBxvDsRyNYiDH3Q3I5jxDfIM7y65vWFOEaIYasNAe6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrPjvCE3fKKBsHntDg9im2JeQyHTx2frUooGFBkwfKs=;
 b=LigmycVQAHx+EjigxrnYiVQlt6KPhlkWaED9M7Hm8QSdjx5tLGvKkAQkRt45ErTFKOQM8apegkhaYFsM8zptmP+/vrH5QGMr/tU4AXfCWn5ms1MtDISXlBG6s3FO1x9q+oHzTkZwJZiNIIHgJrmA7ncbwkQ3nake5unGGKpNkkQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 LV3PR04MB9150.namprd04.prod.outlook.com (2603:10b6:408:26b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 11:55:09 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 11:55:09 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "dwagner@suse.de" <dwagner@suse.de>, "chaitanyak@nvidia.com"
	<chaitanyak@nvidia.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests v5 0/2] Test the NVMe reservation feature
Thread-Topic: [PATCH blktests v5 0/2] Test the NVMe reservation feature
Thread-Index: AQHbHqw8kdFBgxClOki2PnZ9z5ezYLKK2XoA
Date: Thu, 17 Oct 2024 11:55:08 +0000
Message-ID: <jltf2li27zc7l4cg75sqh626igfrz23izgy5iokarxj7pmzsqi@xworf4nva7ll>
References: <20241015024350.16271-1-kanie@linux.alibaba.com>
In-Reply-To: <20241015024350.16271-1-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|LV3PR04MB9150:EE_
x-ms-office365-filtering-correlation-id: 4551b99b-9208-4776-b2d0-08dceea28c8c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fxFQu4jyyjIn/oX2zZejAZxPzKUNudNWog4VZ4KhyMqnK9PB2XUODM/8Wrk1?=
 =?us-ascii?Q?E8WrzP8thKnbu1lhZHzWRUsj08ojwoT4zpB4iXMUIeRMXYz6DIMKNHJl4389?=
 =?us-ascii?Q?BdCCt7JfVz6qqssxvFRqz6rUGjd5NfmMRiinQMmubojEM8BXdyngXFCwG220?=
 =?us-ascii?Q?jya9BYRbqkRtYpZdVWR792uw7nBFwZ+rsV7dh7Elqgw+Adr2q+6u1DWsqfg5?=
 =?us-ascii?Q?+W+Bjh5dFZzgZlcP8M4ZPB4yPgWNzUC2t8A5Zk6DxoUbBmpD7WuIah8BTGui?=
 =?us-ascii?Q?jkjOIRqIbDhEMf/SNxkejK8cwGIDS5zqxs1rYm1YYVrzSlUB6CmMJMoutu7V?=
 =?us-ascii?Q?L6ePHQWCjCmYutMJWXL+qtmBt8r2Jc3EPcIpR9egfcWoGDi/xdVojyY+KfG5?=
 =?us-ascii?Q?SSNKGaxUidqJlup0Hr5ceMBNEXO0YlPoe1qz+Zi6x5+7VWpoPXSfxl/D3sP/?=
 =?us-ascii?Q?zNIGxvrzqmfvY5tyiulr0XoyTjGZRUzKwT+OuKeWNpP3OhXJaeoC/e28GQyF?=
 =?us-ascii?Q?ikbZ1MXrN1dsqheQ5978IxjCeRh0KNPLiUjGX3Uw7SNQJeDQLmuEmaV4zQkR?=
 =?us-ascii?Q?yVWQ904LFmbp1QpqPi5y5edNGQJYGRQD+BNEMlRmU0PkkDKoxnaEjSVs5bwD?=
 =?us-ascii?Q?oIKvsbgdQorQsB/ir/ajHbmLQ7X7NS4gBrKg3+6lK3/niarqZetIoObm6zcE?=
 =?us-ascii?Q?06kwDmN9VCvyeHukjSt/6Hq+Q3EnSXAAhOuD2FI2ANbVAiOqHFGylitgzhYx?=
 =?us-ascii?Q?3lkMnrJfxHYzsB7YRHqPdtvxOcuMU9pS1gBe4QASH8jtiw05D47yJkffYsNh?=
 =?us-ascii?Q?5k9hjLnjaOQ8xP9xRXalr70QMNF/8HgLX5ikzicu+9MQS2jfUTdov0h2/ojO?=
 =?us-ascii?Q?0zEQxjwGVbxruZFtSnUSudPQCQvO7kq+4OBvuX0hUZJGo7VFt1tnWRPyiBp5?=
 =?us-ascii?Q?GVg2aqni4R8PKo+5Bl3sRaPEkjzwT6evJWGG+R26MtK71WdnncJSr4k6mmqI?=
 =?us-ascii?Q?sSpGoN3IS1tFwbKceUYP5omnnsv60IkeamN6xieTGRsDyTrbOUU3gIDZoftP?=
 =?us-ascii?Q?YBCeOlq5+FfTG7lqk8QTgQEHP8thlBvsQsxP+HCzb+UrcRPWcHCY7wvYY2wJ?=
 =?us-ascii?Q?g+oDpybgB6iHcLXjHfwYRRKonmVMicPB1sgVdN7lnnD7UDJWMcCeQZgTTBVe?=
 =?us-ascii?Q?4ZIGQi8PYBZWneBbRNJ/ew2AiyHEecqYC0tBYWwG815pw4DSEnOvgO/x463U?=
 =?us-ascii?Q?HeWpmJGsxGEA5qBH4wxfo4oVQkqO3e3ZVpZyqigfNafd6k4g0DDLfZXqy2cM?=
 =?us-ascii?Q?gPacg9jx178Pax8ap5cqz/iK0kJo38cGxtP3RH6zsjQtCWhFommqOpXJgr48?=
 =?us-ascii?Q?oauAoBU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WDl+vlAl6eFPQWONWdO3z1Il6CJKLh9pTB1+wi0Hx6zGyBllLc/LIr61Kpqt?=
 =?us-ascii?Q?TnpvGldFeQzkD61+zOZ9C48KAVx6RBOgsMWpTkxVAoreq+ZOH69CtRumqtVI?=
 =?us-ascii?Q?UQDcR5KC7xEhkbtzQCAAFUcdlmUmULkyjbSo6oFWFm9CafA5T/J5qOcqST6i?=
 =?us-ascii?Q?1CBtgDPMhG1RlY4p50Q3ipqgaXXYH282jJeTv2s9nkGaUuM+4Crp+JAs7GlF?=
 =?us-ascii?Q?BOMk4FNFpr3f3iSAYPy31TvugVheO2fqlWcjaWSVXkC7YnZm3yF/Rvu5aKYp?=
 =?us-ascii?Q?he+dalrRYuMaYqaBR0K7MBVm4viCC09Gsqxl+oUBaV5PV2IxCtViL2ahenuC?=
 =?us-ascii?Q?i0J747ZnLU46jrUWJcq+05nMjN7LOEckMe9rKAgd23UkIqHS59/3Tm2N37b1?=
 =?us-ascii?Q?wdbqorlQrL0ZOULZHQxLYgLipLGBk4hGJAA5rctpi/qVPGdpyYtPAw/jZbs3?=
 =?us-ascii?Q?y7lu6B/SQzuS2j5eWtvH/3AybtBzXNwrYkZJOBjkwVND6cd1ThA3g1vEV8if?=
 =?us-ascii?Q?quFFtZknrXzLZsxyu99kmsKWuOT+ozpg2nUvh3MQ2hVyJzW836OT70PlYUSF?=
 =?us-ascii?Q?acMRMJIH8b4t5+i11CD9F+6Ky2DF5KZfqu2AIaLD7/q4/am19wIwYrnvVeVX?=
 =?us-ascii?Q?cHK4hi4fryFcXkYEwRd9Apcl66WIM+PCTcTqWYT3A2HHb4tQupwiPAFN4Oln?=
 =?us-ascii?Q?VHsED4yR6xPGJRWuKIsuYn7aDnQIvbqM2tMAkh9InP8BSzVm9deMIwIKoO1z?=
 =?us-ascii?Q?KpXdDGryxzcc7u+GvTKgZnaL0cbP4fxdZIAs2L78MCWXVCnOJ0zV9+6WGLCn?=
 =?us-ascii?Q?TOHKZ2oQUyiPVRiLNZ3JXqxg9uGIfN46YIBWfIA1atV4A9r3gtTcohtTTs1/?=
 =?us-ascii?Q?yceyR4yc7E+lW8vHtrsEWaWXVioBaWQthFCCfjM6uWC5J5BA+Zn+k7t3mf+/?=
 =?us-ascii?Q?oyEP+JtudkwuzedXaesXqTE6v9orhlwgNy50pHGMJ6PGbWL1vZxnsZAWgrxf?=
 =?us-ascii?Q?ofF9VNDBuq8ksHYt8LzTaoKv8O5KX44Cl8FoCVQisEzF5CqgO/AvmrjUPHur?=
 =?us-ascii?Q?6wtDeCmtJr4/C/g+73oKo1PodTDer4kSbFxuoLwtww0A0gVncAH9hMoS+Y5p?=
 =?us-ascii?Q?YlCbNiyObP44lqtsb8iHFzpefncKjkCkDFhWoRCfC743zqG1Q768OtZrHr1y?=
 =?us-ascii?Q?n1222ZIWuH6ymtHaALdvnzc+gvQKzp90BLUxecrxb3gUv1yo8WCl0mWjrwZe?=
 =?us-ascii?Q?NtVoUuSUMkj2hMLgx31dW1ctuIoQsYrMeVJ7UkSR62CW5xCz9d2ZkdfsxqlR?=
 =?us-ascii?Q?SUrfyEDRhB0JnmBFkmTCp1IeOVQRY6pK1qwJ8+k3G952pA5A/fdcoV6LhzCS?=
 =?us-ascii?Q?xUJ7rD4CvV0gqGUFJEGKep3fGGMLXAMSEpRY/UPWPQWlocI4MKJPVoFjKDMZ?=
 =?us-ascii?Q?yqXQCqpuIKbvY1Yky7fY9HyzkgSM1ToESlvpaxxipa+hRtoaC6w/pE5BFyb/?=
 =?us-ascii?Q?VpCBpTex4JOd2SEIbj6Hgx01tsdk9/WOccqn54qaRsFpSM/S6uCTxqNYzwZ8?=
 =?us-ascii?Q?dTYr4JH02IOHONn0AOOEEtIzIZ2uaKkFwz0+gVkn3UVfqgBQvSroP8DJF6Fs?=
 =?us-ascii?Q?K46KRh3E0L1upoUY7cM0vKY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F508C1EEDB461B479941B4F693A267EC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BUjGYWHDpcBD1I6CscLVsNRAM7cR2fZpB4/QUEB08CfQtkVroqzS1CBVzUtziS8vcJBykLjSDWAB3FX4urQ+cBhmwXIxjKwALKRIpV2u7a/McUjR7kFXzT4+mMj0Xlk2LTdPIz+gIsmQZ2Z6Z1O9JfMw4sz2V3rwxivayTRIJWa3+LSc8KfVoWMInmN0dyhEUV+fCwFVwzbXqAYdY8li5fvXBGWB/kN2vP+WtaS1ARj9RELOHP/rrbDNXgS38xWBOccT6A6FXoOj53WD5SoJMjnk11Q9OPSwwiHHtJYHw8V1qMakBGcwI7UtvXa0Bh3k/qpdV5abAR/D3lfcasuidhBKd+Vj3iCDzaeNcA1cQcBnt9ntUHjSrbKPm6y3HpMsgAn3/6JlGjkpubzjGewOgzUD6bJx8waHFNSrt2EFEifCxbDrTyn4ajxxvEtG6IZiw0AwVjghAP82LQ7UMYaPlidxCcZZBpwDqLWHyAdmOp2+zlx83FBl8QFNkYwIeBAR2aAmvQ6qXPXRiZQIhmD9j4OTVkkA/Bhh07H3nlrfP9QWvRKqgkgyVKJO54u5qLlNk6a4bJrQ6ta8sMdAbanrpdm175mXHR2/XNOROKsdkS7xxeiHzMpHRmmPeFCUeOuX
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4551b99b-9208-4776-b2d0-08dceea28c8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 11:55:08.9619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hROqkx5z+50Kau6GUuFFHTetTg6Mp6hF5ZTQ7yjXTyidH3tj9/6T2NlCfN4QbRMJtDrJFXh4ocnOdIesaSLpvQBAgATl9tIE4KuQHXSQI1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB9150

I applied the patches. Of note is that I folded in a couple of nit changes =
to
the second patch:

- set executable flag to nvme/054
- added 'local' to test_dev

Thanks!=
