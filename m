Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3629398FB8
	for <linux-block@vger.kernel.org>; Thu,  4 Dec 2025 06:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764828128; cv=fail; b=ahbxBZyFnPSM7QyRUiTkh79G8N3cNwTXkoDeHS+ETbLtTGOhtugPJphKiwYRFMmTO9cgFRLYKorKr2RZAtEI7yMKEujEpyntP/dsmnpQ2Anmk4S5lZ6L/8mYc1pun8nU5Y0vKBjHtmderM0bS9oId0sf8Edb+Y+KuLE/Er1GU/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764828128; c=relaxed/simple;
	bh=mq/fUnCOQQkQecymJ1IJbS7uqCM8ZqcLPvuujdzm//8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L1HL/CV47/tS3rTbbOBV9iu+91XWkVxuxL5cQ3DpeM1dfMaq8VoyP1W3CMnFQbpTaEMA4T8hBB4/E9URGEkg6KlMsUAXEU7SFL+b4L18hd4CksC/0OgNlf1+auGcWR+OyRW/W97JSzK2bT2BCRwl/13qCODaEeUpqPAzdvQ7ctw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Yrcan/Yb; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=RahNxPMj; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Yrcan/Yb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RahNxPMj"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764828125; x=1796364125;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mq/fUnCOQQkQecymJ1IJbS7uqCM8ZqcLPvuujdzm//8=;
  b=Yrcan/Ybufyax9VaLKqD2Ag9m4qhnXl6j+ZUqhMPoIMr9+hF+ADkFvhl
   e5vzH6cWFD8hM7y58dVq31quwtVeKrOun4f2gbGo0oA1z32t+aFJepw8u
   a2SLPAt1VV9ZVZwF2apOdTunPj4CcLwm/ARj3Lh4KRw96uTS22cAruBwV
   CiZp5/GsJEml9Fk1RZ0FN/WuU1spAbs1tXIYnE7MF8WFPqfEAKlOJW6vB
   2Q8Nln52zvLbZkBhbEFUpikQlfOd89IyQ5tNzhu5T3EHfhCTwkR4lgoal
   o0LfOMzDwJR6xVe5+hxpSek8ZgyEVOUKL4Ya3/WTi1LObDkHjBZDXeCrO
   A==;
X-CSE-ConnectionGUID: KRHzIDLaR6qoB21n4eMnyA==
X-CSE-MsgGUID: /EXtuXMDRXiKAX+rTBO+7A==
X-IronPort-AV: E=Sophos;i="6.20,248,1758556800"; 
   d="scan'208";a="136308680"
Received: from mail-northcentralusazon11010005.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.5])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2025 14:00:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8EHi8Ef0xbZE3jww1K8AaNpidKDn17PO0/bjzoxcKxLrzTP+ocUd7wHjgWpg6WkM4kLe0AIAnOlJYHjqDfSzx/nEXNk5Q/Frzpa2P3NazlFNxLcwUvVS42COOOaE3vRdgKwWQwUo5xfYtVz4Sfo5dIwz8n/vP9jPBmYtMJZlF0m/xA72yDZOS0k1pdDvCY+AWz9QdoJ2tiQVv+Kwt1i5iYwUqXlO/Bh7lPS9CwiVhaMQtahyEKs5AsPqc3hNPxytZ/1JxBdGx8yhzsmfTgOfwUzMjSzXadoDRwIUbHlr7CV+WfbmCdwYWNp0Z7YHL8TMY/hzNUUJ/kGgfxz1TKFLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OH8cBQnNRyCj8smhlejLBQIDHVrHscE6ZJfLJXt6t8A=;
 b=pbyLIPxmjiEvQwPrO4lVWPRd58fTB/0orqPX92Svr3MKe7dcG33jbLCnZdkA/8eB537bvuF/rWcCQqg2UfQV6qT1DTAzpe5Vy+2tZmN6oePVPhbJ5Fta0tq3yfVW3a3wptdf9HfgJ5rGzbaiWRWdAivoTUyS5gQGyQeDA9HggCCoamDZKsQi0amg/netACpU11o01Gj+K9OmXEep/XE6pFVrW/YTl/RGZeZh8OHHEx0OKSxa9K3o0J9bBnSwmd7WpRp2j+FHw7zAF7cu19PgFQSmKjj3NutE5HaQwk1duekcokknAjMJil82XyoZahEdfkiq9prkia0t1eZ8Vi0H+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OH8cBQnNRyCj8smhlejLBQIDHVrHscE6ZJfLJXt6t8A=;
 b=RahNxPMjFhLX43QA+WrtMEIbOzYAl07ATeRL1oJMTV/yV+lafupBR9Arz3AiqeetDmMa8TCvNi+WCT35AyuH84mo8EoOoGDQyEM03OzC4rNZoXsT8JjKxh/on7nuCIqwoyhnQmuE1a+s9zMcreFYFDw+DenUn2616TBbstJSv2g=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by PH8PR04MB8710.namprd04.prod.outlook.com (2603:10b6:510:252::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 06:00:50 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 06:00:48 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
CC: Hannes Reinecke <hare@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Steffen Maier <maier@linux.ibm.com>
Subject: Re: [PATCH blktests] scsi/004: add SCSI_PROC_FS requirement
Thread-Topic: [PATCH blktests] scsi/004: add SCSI_PROC_FS requirement
Thread-Index: AQHcWbydTCAS9iO+n0Cwz+vVzrq4SbT7KHkAgAAQ2ICAFdnggA==
Date: Thu, 4 Dec 2025 06:00:48 +0000
Message-ID: <2pvduxbjeccwqgfn2rlofm4aacrnublbwcav4bpcsz7eg5mimd@5tm3576mikyy>
References: <20251120012731.3850987-1-lizhijian@fujitsu.com>
 <43b4daba-3bc3-4b37-8464-324792c8b4de@suse.de>
 <17b6a4ab-1709-45e8-93da-a068192b0137@fujitsu.com>
In-Reply-To: <17b6a4ab-1709-45e8-93da-a068192b0137@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|PH8PR04MB8710:EE_
x-ms-office365-filtering-correlation-id: 2184e73c-d9da-4963-2dde-08de32fa7909
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|19092799006|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?FHx8GyJlg0+ZUMAT8uEeTJjVpkDDxfipb9Owq1omQkb743e6tjjuB39gqe?=
 =?iso-8859-1?Q?OUVLSnIQxeFePafuwhflfHXltq07QILmylYnXeoEOnpMMQHbptB2bGCJa9?=
 =?iso-8859-1?Q?bTy/t3coIyKf6Pr6qKCcOksax0zCx1Wem0tl/tB1bW3wvIkkbVEkBLYkGb?=
 =?iso-8859-1?Q?xAw9rAPm5x1Y1rPVhB1MdL/4bAeXWNjNJ7si/FpTJed65bjetyZwN0j3Dx?=
 =?iso-8859-1?Q?j1Z6VJWzCiMgmE4MtVntPgNolXa0YzFchckoz9b1rUU4WczUTu9xWJFx9k?=
 =?iso-8859-1?Q?58Su3/Fph1NR7qWy7PYswH8fuqANC0GBYzs3cB6p0A42pLx30GmNE7cuXk?=
 =?iso-8859-1?Q?J4n7/3K2jAqC271OV+eBA3Q7BelFD7JSxRgownM0Y1VSxqn29xImMbR5Te?=
 =?iso-8859-1?Q?P1c9mouCX8LKuvyu5uCrkAUUbfIywyzmnr+9PWZuT+l/X2D4a5TtRj17ck?=
 =?iso-8859-1?Q?itBdcKDZHMJgDSx8lw+BRICELZpVljav+i+/NiaRoXz0WqPPbOxC3UW04a?=
 =?iso-8859-1?Q?9On3QWKuOTDTvWoFG5lgEzhTVg6qVl5+UKasJUPqhs6LF0JqeVOFgu5/TO?=
 =?iso-8859-1?Q?08uqvy27g/duxC68pIbjUYp9LKv7vZ5OYSoCipouQllTzOBMsGHeHAoKCn?=
 =?iso-8859-1?Q?wVb9Kgh7GHpttscENm/khfdlRFUPPv6z99Pru+LrgXsiobgxmjgtl80DRq?=
 =?iso-8859-1?Q?Azm/fCJOdhEARNNGHSiFmeRkwfb144rGPAtMSCCmoYD+M7UoTv69UkX44x?=
 =?iso-8859-1?Q?Y3QMb7eRhxOlmHrzmbuyU46cTgQ4e8M9wmg4PKkOqq/DhlvRp8LFx/NVPf?=
 =?iso-8859-1?Q?1PbBZKv39el3jJq87n47/X9heV+4ynYJh6htcBGpvZK4sU/a+G6W5eA1fW?=
 =?iso-8859-1?Q?NLfIzlQjtA/0I7FPEZSAIXh61r7+z0kpXp1ilsMMivRaZ+g2O076PKL3bc?=
 =?iso-8859-1?Q?ZU3riZkNtRCsUcI6+i0paqAJHWN+0yIk6dM9VXnn3JDA6IYabb8vrkGEI5?=
 =?iso-8859-1?Q?SxmspM0IKxfzUQAAzXtsguOSv1AWVmIK2htnDBtU1YrmUpkV9SeGCUWGVF?=
 =?iso-8859-1?Q?OpoPQ4spXNfUSogzZcrLzpQlDTuj+8XkOm2VCvk3E610eST/VTCXs9ET1B?=
 =?iso-8859-1?Q?0WSgKQEcbQaVl4t7p2W58Ii+vAVBRdOfyHGK8AN/7bNsKSzlNEitlxMY1R?=
 =?iso-8859-1?Q?zIb4Om4c47mH0xIJouByHn6f1ApEgPeu/Th2K3g92k3vaZH0gtRiTs3dAn?=
 =?iso-8859-1?Q?HRcWhCHseFXIbvnz6QHzQitiL07eI7QVVaLx2kDADBSkwjHc8rYMp+7QXU?=
 =?iso-8859-1?Q?J7PnlHgIYVnYn/spwIJjdjG+4R/ytpby0GmfpS0aON1dKkwbvqEoOgODYW?=
 =?iso-8859-1?Q?SsXTa1HM6JbP2xjrEoeUfyxAqRinR96nvMtYUTkQ/hG87AHepgyoxjxsyH?=
 =?iso-8859-1?Q?9BMLD7GGjjptzHS0Z5X3aPaEY5iVD+ZYs7ZdzLdYNlxir+oYnR+A+mcwbo?=
 =?iso-8859-1?Q?4d0ipVXSPLIYcHDidGIKNh5WDNfcDXOtsti7jthf3ccurVGwk7/dz8a9dl?=
 =?iso-8859-1?Q?MYv9WJx7T0p7EsDT3QbuSTHg4i0M?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?YZXWnal5Z8E3RC8T30hP8XaKIzsGpQ6KpOwftfrobNZduuq44+pLmoF/FF?=
 =?iso-8859-1?Q?dqVFcMWPpnhSgNOzRhtbTX4T5D7di/eMEQN2Q+kysmKCfxoLShLOIv4Yv3?=
 =?iso-8859-1?Q?OFMIScXDgWE2DPMZqHQyVUa3fLrqRgB3CKev6js0ZAUx5agg2K9MCEcxy7?=
 =?iso-8859-1?Q?Z6fT2dFCG8EvNtkj/YomSeAEVE7lus/hXwN8emk3TaF4m9cbFPTUy6FYea?=
 =?iso-8859-1?Q?BrmK+5JV/iX28yZqSV7Rtp6itNDYJLFaNqsKt+mJ3FCbTXXRMWbkFIwQS8?=
 =?iso-8859-1?Q?Awgi2UqpZT9oeFjoikykmUCA2gqUyTfKyWXB1pO4Hr58AEOcjNVmB1hUXO?=
 =?iso-8859-1?Q?1lGaIduBOJBTb23SF0bFptVvHBUvLgQJkwFc7CdkIDVYkUgE6fhP8ddsBp?=
 =?iso-8859-1?Q?3HgROSv7MybDz/03hdF4FzidE3tDvE2fdlOjkGLI1pW/a+T0O4UV5bmqu6?=
 =?iso-8859-1?Q?92IBY57zoJ5T4xEWrvc5WQlfHitlur5hxC+CMslg5RL7JIkcqpOFrjbDeq?=
 =?iso-8859-1?Q?KN1weUA4uZUGCngJ/4wc0ZW11NExlSjZw3tVENeWW7qzFfX9EOph8c5TfU?=
 =?iso-8859-1?Q?PhOT/KeTmmALGF3z6K56FAG9r4MRoq+jVbWYQcV8SSuHZDQCBVz1YnpLx+?=
 =?iso-8859-1?Q?rGurae+GsdjkAeGjoHPbmWyFgSg4IYOfgpkF4Hmt1Il4cl/LuOMqaCkz6B?=
 =?iso-8859-1?Q?0RvmNeJVSwIl9yWzTiHgisxzIVkPabApu89Eu5z6fhH1i8xDgwPtrS83Yw?=
 =?iso-8859-1?Q?I31yAItpn6mPD6rnkVwFqZ4brwVRjkU152o3qYnnrjZuP6ErO2tnXkcgYD?=
 =?iso-8859-1?Q?OGBORvkqx66DZsDXHUXG/TpAM2Yvoa/GMzcgTktBos9E/587+GLCurII+Z?=
 =?iso-8859-1?Q?16HfNe1WC8/zcYjMgXQomianXuAtB3r5gpGB9kq+NWJX5RGUG9GBz2AGi2?=
 =?iso-8859-1?Q?MulQoHmE/Bc3gOzlOiVyj9VcVmS7W/4uhX4o56RP80Ar8VMCVZ8ZhR0BqB?=
 =?iso-8859-1?Q?0psEWMOXxBXjVoSe96Ytbq+bKbiROi6MFcJokRcPjn2aFuTI6Rl0KkZKlC?=
 =?iso-8859-1?Q?MdZeqjsZhQMhP5+WPP4QCKe1rHgyO9/sR8NXpajNH6q+UL/A9zHlbnHQjB?=
 =?iso-8859-1?Q?0CK14rXX8TnE2cGOz3r1JJMjornnBk0HYvzBF9K83kEWct9Auy2xyXwiKl?=
 =?iso-8859-1?Q?gUAHftYa1C/JJXrwNiemMTRC+8VtW2UkAKVO4FC7Y6/6MhUlwW+6AmP1E5?=
 =?iso-8859-1?Q?JF8m3WqxVAuIlaiw1kaJKFuADFpEAYvGn6dwk9+QsfB0Vzc9u42IYZDVyV?=
 =?iso-8859-1?Q?+Od8aNEINFIFk1wj5FeNYVuQ01QTrk1YMCu9d3uduYclGUWvYV1+e6QlBP?=
 =?iso-8859-1?Q?WtSrgUI4rmXIb+IDBJrfdpSauC4VSnmi2wcGHrIvwNoIk4aI0arBPPUrxF?=
 =?iso-8859-1?Q?mC6VXr96GstGPs+8daFASp4sjLOZAhubyO5kfn3iCgBRdRT5iIasIz2R+s?=
 =?iso-8859-1?Q?uA9UbJS4NYPVnGY3dfLSakM2IRjhgAhiylMtTx3aFDrA1cFyepIsnm9gap?=
 =?iso-8859-1?Q?rWIFtq9yiMmYcoop3LvhzHbyg5PhIgxElqlzx7XJPgNYJ2gv0nxE8aM7iO?=
 =?iso-8859-1?Q?GUDqTdtw1I05rGVfnA8n4lI2tK9wf5rZe5wC1TQTcRgVqK3RIJ05Y00Pf3?=
 =?iso-8859-1?Q?AB2dG9gPMIeU2pKTuw0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <2E79F20BDE590247A0E107BF83C03E57@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yj2NIzONzqdV/vAyHZTGk35LLG2XewC813G3RrOLPv4yFydLlzBTfL3riVb72ainYiUjrOuX0uHF5RQjVoq0SwGzN614Zuq2W6/H4HStsNYzQXP9ASnx0sTOiwBhbvbvVvjdL1TrzRrjQxbolIz2xgXYADilDuxsFNtycRcIIpw2l05EGlMUg4APHnNrFvg9RFcwNJxhXK2iag083hcIWvqZW0uEbTvogCx7ab5b40qm7cZjP9QLna8NTXjBS6+xBlqCnEm4Y+XHV84UU4NEmFUvbgPBApNc6dfp2RKsSZPiLHDiZupcQ2ibm51vcuAw19k/3y24GPVODZkDBaTX9aX0Pc731qMOJ9S9QaL2saHaz6FFTU9cmq95Tw6EmuWxnWhX9lAeNDrhSrOJOTPsOKllwuToBdXDOfYyGjAVtaMkZfuQ4i7wlZFxeop00n9nfft14nrNwXkBdop/AvCL6otyzqHhkZyF57J/IGv6TFbyr5+IGHct+zCWIV3k056RV17GjPi8sypL9yIiDRMmursvVGrThakIiEhHAWkVvr7ytkDCl2qqL6PSzaP3pUSzGAmvBtgCCRHUcjtCbgN4SYIDb4idlhfUUteLS5p8ImQvPxCiIeUAygis3AhELliE
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2184e73c-d9da-4963-2dde-08de32fa7909
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2025 06:00:48.6687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JYfNw9R4axTUhCy0GJaALjcs1Sqip+O0x/LyMpU2iiFrFuxYWu4q5pFEg8QMbTFn0Jt79azvqbBv+vZhuPq/6uDQIKFVJSCVgOaxE4MoCw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB8710

On Nov 20, 2025 / 08:19, Zhijian Li (Fujitsu) wrote:
> Hi Hannes,
>=20
> On 20/11/2025 15:19, Hannes Reinecke wrote:
> > On 11/20/25 02:27, Li Zhijian wrote:
> >> This test will queries message from /proc/scsi/scsi_debug/<num> which
> >> relies on the kernel option SCSI_PROC_FS
> >>
> >> Prevent the following error report:
> >> scsi/004 (ensure repeated TASK SET FULL results in EIO on timing out c=
ommand) [failed]
> >> =A0=A0=A0=A0 runtime=A0 1.743s=A0 ...=A0 1.935s
> >> =A0=A0=A0=A0 --- tests/scsi/004.out=A0=A0=A0=A0=A0 2025-04-04 04:36:43=
.171999880 +0800
> >> =A0=A0=A0=A0 +++ /root/blktests/results/nodev/scsi/004.out.bad=A0=A0 2=
025-11-13 12:46:33.807994845 +0800
> >> =A0=A0=A0=A0 @@ -1,3 +1,4 @@
> >> =A0=A0=A0=A0=A0 Running scsi/004
> >> =A0=A0=A0=A0=A0 Input/output error
> >> =A0=A0=A0=A0 +grep: /proc/scsi/scsi_debug/0: No such file or directory
> >> =A0=A0=A0=A0=A0 Test complete
> >>
> >> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> >> ---
> >> =A0 tests/scsi/004 | 1 +
> >> =A0 1 file changed, 1 insertion(+)
> >>
> >> diff --git a/tests/scsi/004 b/tests/scsi/004
> >> index 7d0af54..fd4cfb0 100755
> >> --- a/tests/scsi/004
> >> +++ b/tests/scsi/004
> >> @@ -19,6 +19,7 @@ CAN_BE_ZONED=3D1
> >> =A0 requires() {
> >> =A0=A0=A0=A0=A0 _have_scsi_debug
> >> +=A0=A0=A0 _have_kernel_option SCSI_PROC_FS
> >> =A0 }
> >> =A0 test() {
> >=20
> > Please, don't.
> >=20
> > SCSI_PROC_FS has been deprecated for ages;
>=20
> I get your point. A better approach would be to refactor scsi/004 to chec=
k the corresponding content in /sys.
> At first glance, I haven't figured out the exact implementation details y=
et, so I'm CC'ing the original author, Steffen, for some guidance.
>=20
> Also, it seems the key words that scsi/004 tries to query was actually re=
moved from the upstream kernel in commit 7f92ca91c8ef ("scsi: scsi_debug: R=
emove a reference to in_use_bm").

Zhijian, thank you for finding this and the patch. I took a look in it.

The test case scsi/004 checks /proc/scsi/scsi_debug/* to find out
"in_use_bm BUSY:". If it finds out the keyword in the proc file, the device=
 is
still doing something with using a sdebug_queue.

However, the sdebug_queue was removed with the commit f1437cd1e535 ("scsi:
scsi_debug: Drop sdebug_queue"). This removed the in_use_bm that was used t=
o
manage sdebug_queue. Then, as you noted, the commit 7f92ca91c8ef ("scsi:
scsi_debug: Remove a reference to in_use_bm") changed the message from
"in_use_bm BUSY:" to "BUSY:".

IIUC, the test case refers to /proc/scsi/scsi_debug/* to confirm that any I=
/O is
not on-going. So, I think it can be done using the sysfs "inflight" attribu=
te as
below (not yet fully tested):

diff --git a/tests/scsi/004 b/tests/scsi/004
index 7d0af54..f62546d 100755
--- a/tests/scsi/004
+++ b/tests/scsi/004
@@ -39,7 +39,12 @@ test() {
 	# stop injection
 	echo 0 > /sys/bus/pseudo/drivers/scsi_debug/opts
 	# dd closing SCSI disk causes implicit TUR also being delayed once
-	while grep -q -F "in_use_bm BUSY:" "/proc/scsi/scsi_debug/${SCSI_DEBUG_HO=
STS[0]}"; do
+	while true; do
+		read -a inflights < \
+		     <(cat /sys/block/"${SCSI_DEBUG_DEVICES[0]}"/inflight)
+		if ((inflights[0] + inflights[1] =3D=3D 0)); then
+			break;
+		fi
 		sleep 1
 	done
 	echo 1 > /sys/bus/pseudo/drivers/scsi_debug/ndelay

>=20
> On the other hand, since blktests is also run on older kernels, explicitl=
y adding the SCSI_PROC_FS requirement isn't a bad choice IMHO.

That is an option, but I think the check with sysfs will be more stable.=
