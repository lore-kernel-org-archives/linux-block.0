Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A0E2147EF
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 12:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750854056; cv=fail; b=IogeypZPMPmVOghY+8A7x0OvdN2ujmy4NuTa0fVlParYmCqW32W/BCUfDShZo66s9XRVyV3Z1NZlun+CODyuBlOLUn4URqYYBKRanKXKkwJl/CYYrifTtnxfOagbxOvgSWJiBmgzZ+/PYoxI0GW0sR4WjTsWEhQJ9do1cey2clE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750854056; c=relaxed/simple;
	bh=zmy6CjBOMSpA/QkMqsmyjMkEgWpvpin2QCkt9izahJo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h0ds9145GrVpahHI4woP26cQsWX7R41CYYwXxoU4pDVkLjRbka/iy/froKU8VCE4tfgakIBttE8ikp6f8iKc9RuEwv6tMayWvX5SKg+S4nIwbd8/7kGbmc8ckl33pJjJUMc+OSLEzkDAFm2UO8IgFS9nK3pOov5P8rKFsw51Pzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nKyNz/rA; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Jp+AfDHV; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nKyNz/rA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Jp+AfDHV"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750854054; x=1782390054;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zmy6CjBOMSpA/QkMqsmyjMkEgWpvpin2QCkt9izahJo=;
  b=nKyNz/rAT+zpwp92/NFj51/w2mhl5gbPt43vSeZwKgAKdtE2ttBBKHs9
   Z3JdWYHV2rQJmnoIf1lY3x3DB0OKyuo3sn9BTyNavCCZdj9BrIFe7aXTK
   7p1G1MgHjlIHTX0YitOmPrzQY2m/Ad3iRc7+MaQve3OA9fjA5yzehaNSd
   LC9Gfr8b1BS2NDUg084GPelbwbhMofJ2Rx7uDUu1uDhAUDMmkSL4OjnYQ
   x8K9pGawTTudbhuJBBT9RwWZHXBG1IADs0YHx7DcDsQV7CcKVTk80AZ+c
   pC6ZoAvrILfhVA7JgiLIGtTLOiEyA8SDKDYNCScdXIREOA3wrPdlimVCp
   A==;
X-CSE-ConnectionGUID: QIv8ClLbSO2iTQASbTxx8w==
X-CSE-MsgGUID: AnQEetV0S762pDlbG4IdrA==
X-IronPort-AV: E=Sophos;i="6.16,264,1744041600"; 
   d="scan'208";a="87200193"
Received: from mail-northcentralusazon11013018.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.18])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2025 20:20:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYacw8GR6YYaENRVpAKsnQRC4WXjZ3NPmT0CgtyUpNXF6U7tpvO3pfNcXxO8yAG0XZNu4u0Mq9970jiRLOkZXn+4dYm3P2ulmQhycobS5eG2U3hpDDawVAhhF6wMZ8vPn7aW3Fy1prWRpb5fUbbAcZJmPPSInhEfBXzXK5tirLurMOU6caQ+DxYd5pBIfT053QWgDXCVD52lxFZXdoG9946DadfmQBCxRKgslSSGDOGbT8E1XysM6P5KX4AO6cFih3f/24MD0pT3PYov3cu9fTt3Ue3hablgeSQOnIraiIW0TNlRTLlWzHutm8jDcXwQzcIyTcKKY4n9cpDiGlF4vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuDU5x7ddnVSVDFGbOf531yLaAx8pirX66fmM8wB334=;
 b=PtGi4k8YGCF2T/5Bh2LumP62DG+EYmfbZzvzuXHTA0N1HZ8C0flxutBF0Aao3KFa3ks5Y/ALUOyKPOAHw9jaFB8Pg5nzUxhDoRnhMY1OCYqPRP8KY6Ij5+g5zdZl13ErE+oVcvf7SykyBQvMc+UOk2DY88My7aJ7PUSubJH5uF1xFq5lVYD8Nc+3NJ72k91j9b4tbQusjMUB3kHHmygoOJqtO9T80VPISeIdyYY1M+WrhjdTONCO5yFkdAOy+Og+lELBek+Fmd8zxyCblZ3a51BMys2E0Z9uv5nW+x1dWxM1YpNQVE5yy6LTUkvEciddfylA2T85E8MfIv2Tak1cew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuDU5x7ddnVSVDFGbOf531yLaAx8pirX66fmM8wB334=;
 b=Jp+AfDHVfoKseCHgRrpOz90J75rBypBazu360FEzUY52QN9Kk4PncLRVIs+jhw4RXoqf3AJ2zOzLoiJUiMJ1pNXxIbheS7PaX6kALDLdLeuoHrpTqnGRO5oQbpzLutBokj6OL7rxZ9wkuwbrBkd1wvG0YUsByqKkkXBckYHMB04=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by DS1PR04MB9276.namprd04.prod.outlook.com (2603:10b6:8:1ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 12:20:51 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 12:20:50 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Li Chen <me@linux.beauty>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Johannes
 Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH blktests] block/005|008: double timeout on machines with
 more than 128 CPUs
Thread-Topic: [PATCH blktests] block/005|008: double timeout on machines with
 more than 128 CPUs
Thread-Index: AQHb5QEVVTb8VtSh9EyVHES/Mu+gGLQTzSmA
Date: Wed, 25 Jun 2025 12:20:50 +0000
Message-ID: <qgon5pxnxccucafhgz76v5aqliypnbtki3kvvhu6o5l7f3l3vv@oqobbtx4gkma>
References: <20250624121057.85689-1-me@linux.beauty>
In-Reply-To: <20250624121057.85689-1-me@linux.beauty>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|DS1PR04MB9276:EE_
x-ms-office365-filtering-correlation-id: db141999-b0cf-4be7-4477-08ddb3e2b91f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Djm/Fzt8YgEwD4IIjMD5lsW4elCPXnYoWh4ompdmzUgEgkhrKI+eELIYq7KE?=
 =?us-ascii?Q?ANMDN2NLS9SvHWEAuwQgFklUteDa73maKaHedm+tdExTXh/P7oBYPh5ZbZfD?=
 =?us-ascii?Q?yAc7aRDxpf9mDiBdzBEOs8RMyf3DXqmRe3A1c+YIBCrnM/2+veDR6eF+EpoR?=
 =?us-ascii?Q?lMbi0SxBi/ls8LQElnppOU5Lza7Oiq7q4COMEMQeIAHA9Q/+Nf35XPlTqlVU?=
 =?us-ascii?Q?bAS04P5bw6K4rlO3EUiXxQ/GQGf4TWED4hMV93qq1fbmV7MSG3nPZwUw+Xae?=
 =?us-ascii?Q?rVZAGJ47j+LI6rI2pI9lWnCX2cUZTeduGeDCDJv1bShQEDif/GjcFhw5tG09?=
 =?us-ascii?Q?LzCGzonWg6SQQPnVsZhAIAdan1CGjWr5q494gCEaZswB/11Mrw007tbwP/Tm?=
 =?us-ascii?Q?bFgvuRR09N0+GpmPN+R+QcMffBZ9uDUXrfOssZFNnEogAaGB3z3fHsNERVg6?=
 =?us-ascii?Q?lq9kw6nmkTe52JlaE+aNBFMCCSek1ROaPePkSDHTdnBN5frcSWEBgntJy9vT?=
 =?us-ascii?Q?dxOOlW0ulGobhxrD6kTmPwK1rsHcungsPykDs/q0KGBSXJbjRccTMIis+ifc?=
 =?us-ascii?Q?JHptOpj/qIx07t2QDuWrb7b3dHHEjimTPU+v52cRI0NLmMCF/ink/L/eYKH7?=
 =?us-ascii?Q?59EQwJuw3p7pMmC4Z5sD1VEZOnuqv0x2+lwFC5mkR2uCg6tAYkXZFnW3AVtJ?=
 =?us-ascii?Q?Fs63+Ds/NBKTYBpnRd99Fio9G1VPh2JNtac+enRctZnxehkHW8V35ZKLnX5J?=
 =?us-ascii?Q?RvN3gTyHYbcawdzPM0UhPPYAR2bjoE63UZwHswuTYc2/8zyZ0sPDyI/i13Kj?=
 =?us-ascii?Q?kvarcnGn26kI1IyXyYFX+0ndn98KPR7qg65nuxL+VlxwAIm85W5dmSRO5CeM?=
 =?us-ascii?Q?ckAV5k7S4s62TY8+wqeXRLTx1PHc7iBGq00cOLRx4l7Zi4aX8JZ5+ewnYqVh?=
 =?us-ascii?Q?Rp3/j7RGtY916svqDI7jQ2/iwnSpxrnX0xho/0+Z+AQ8E+Rn/oe3dRsyTBNY?=
 =?us-ascii?Q?4k897kJw4S1o0TuqxWRmzvAs09ak98M30l5YlecPnIRoOvoYSc7F3O8CMsw1?=
 =?us-ascii?Q?4YMzDpwYpcPldHqyr05SFQe9KXW8dyEt2k0yQP8jZ7XFhooFJQsMWEbSCwtD?=
 =?us-ascii?Q?4JZWZCHe+ugdxqNhxqPUOriy39qF9kKFiZHmWT8dhRavGYjAljZQmetEYWBm?=
 =?us-ascii?Q?IrsZ4P3XLTcwdoc7Y2APuk2Oyu0Z3dacfCksM8kjmdtk3PWF4ZUaJBoC+IQj?=
 =?us-ascii?Q?GFvgHduzOWC+hxbiwu5SUngHWhVERhUk/MZIwDJIoalmWTzJakf6T0bSEwZ9?=
 =?us-ascii?Q?n9+lzydEshYp4r3Nel3tFPsfWg7kcs1WyKmitmsxwNbvZ4x38SlFnsSxyieF?=
 =?us-ascii?Q?576qAN2pDgrVPKVkeK4zQ+KmxcSbgp63+SlgkP0Hm815iiGfNfgwzVOHvMLm?=
 =?us-ascii?Q?MwS8aIO+d/47pZqLH20l3ZdwgAJtWJX9gqzqnc1O53sD6scYgPVxHNCAyYhm?=
 =?us-ascii?Q?bsFixZbgdWdTF94=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TsDJ81itcPEAyX0X+/LAyyGnPnt/OaUdhqdg0yqy6liQ+dh/Kg0pku0Z3Wz7?=
 =?us-ascii?Q?1rvPSEHlHkjLgb2qdWQFrc/cuqAYv7aya2KTdN9rL+F3/bHb8tfuHlPQGr2r?=
 =?us-ascii?Q?NUGm1u5a7CWztqbh+4jWTpkWXLQxcEnCWJ5wU6fAlrAoanbn4LzH5FJZ0yb2?=
 =?us-ascii?Q?MEyT0fCZq4Pkc6N+qFbOU2aMHeOyP0iaInng4LLjgJzhpQGk31LWdhhpyQK7?=
 =?us-ascii?Q?QnAP+WNpeBeE8y3aNxraLAvTKChA3a8P2FQlAaw2cW98dDkWjYAZ8rU56SAj?=
 =?us-ascii?Q?I3LzOL1qaaRpJdDBwm1E4UtHGNkkvSyAnD5q4aBY8J/iIk0gsRQLXkAk6+Rz?=
 =?us-ascii?Q?1Mqztu0P9UcwmwL20QUAZBWFs1Fbg7f8l8xkHoRvaaq4O4kp3ZKnX/g6y/9K?=
 =?us-ascii?Q?Hb23FpVNX0vQKaEza89o9ScR9DGlnqGNUkk0VeiW4Hkm837wxbgX6vlb7N4W?=
 =?us-ascii?Q?Pxpc5CuS5/sAmf+BDEaTcffT7zuizRs8DpyBe61ymEgwWqL14MSN4sGZZ1P0?=
 =?us-ascii?Q?6ZWnzcKbAY1zEGd9o3ZRLW4Xq/dPu9lQ7eVlnoGKJ3f+cG7k+EA4yh3mxJsi?=
 =?us-ascii?Q?Q0+BknOGL3IgB5d3L3XFhz+8aI7CHwXBwnckd9XrraRTaAWga1Wanu9ENqwV?=
 =?us-ascii?Q?8aMa/ulBHpU/0wpGS4F0cvQUsLq4F6gPhvuurJazzVX7juabb9Uo+Ddr5KmI?=
 =?us-ascii?Q?p6C1XBJFrLR+u/F2QJvjEa6oUKx8t/IJqB/3f49IcLhsLyfnEIvbjgUVK14A?=
 =?us-ascii?Q?A70LC+cBRwRg/sVJbMslcEGI2Ihg63pPbdIJZigQ4BZper5NYGSjietOBHgP?=
 =?us-ascii?Q?qrtZH5vNoPCbSuv2knULJkLSAv+zLqUtxhyxUD29IdA9CxG2f5A3jMu/FAtJ?=
 =?us-ascii?Q?jM267aXD0Ll1FD3gpXmTPUfb1mGWaA3KwpgWyukkhxdPqq3yPOb93nyCPRiK?=
 =?us-ascii?Q?dX2MPSuG3c5k9aEIJ+i2AAoeGsj1VH8lDJuRxkrxwPsWdH+UPwol9VLqPXeI?=
 =?us-ascii?Q?+QZt0jS4kq2t/jNy5mNL/4aD3lRlj31noTlUFmv7/mjFLRi9imvRW9adPuua?=
 =?us-ascii?Q?saBm+OLC5yMN48NRzNgJZ+R6dzszfst7EF2sSxWGJVnYIm9hhjTYWSOraH8e?=
 =?us-ascii?Q?toBIyBpNNColf2XpMqTSk/TXS9xBLmDqk3H6E1imajlTfVIqlviv1D5bxqSo?=
 =?us-ascii?Q?VRlbWJM7pnT38QOU2B954jRkCMxwcgIhu/Id1jx4CzgNkg7CLG8YsUHwr7Ll?=
 =?us-ascii?Q?D6gQ/BfD5QlPN0rzu4GFf+qvjZzWThZeYlJNIB76Pu7D7IMO/dfCsYyaJog4?=
 =?us-ascii?Q?Y6nBhPGRpdgRKS8djRJFRK77M70Cdt1umpWOv9yYECIRnWrguIPTdKkCFRRK?=
 =?us-ascii?Q?SQ/frRkjItB6RuaTE3ZJWfIjOyJb6lhfoVNHkHNbCDUQ/Gck9U2vQ4HccD5I?=
 =?us-ascii?Q?9eHZNM7UhLdYC/ZdOgwWn8rDHSP1lP2zq+6pDliyk1Eguw5Pmu32aCGKvUJM?=
 =?us-ascii?Q?H6BnTnJIb9aCaK5t8HB9ZiZ+96FxioLvHr0Ds+eEzOhsuljmooj4YkPbwzvd?=
 =?us-ascii?Q?BttFXfo/1yyqGf/Rhd/a/ZogTRv9c6o9d414q3DaWEU2O++X89Z1MB3hmATu?=
 =?us-ascii?Q?RPXZly8x94+SLDmyIAu6Wn8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E48CCF22165E0E4CA4E6EBD7EDAA14B1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vMvNVvZklkOkNVhpNEpmn31aBuLuzP1+8IfV1CjthAdyM3soeykG98dmhGwzys9NoePPdB3vKsim3jral70KfDkaE2vMyPBfY9UuUdeKMCXFbZZ/o93ej/zlxQ+AwD9QjeDDnMCTsZ1Lpi2SbRWe2VG2opqNj4kq5c7uk7BBPw8ZaAc253oAXeBddDUrb+u0MndWf0344GV+6A7s4wsnAE0XZ4+PSo1Y8Mr1SoRj9teO4z8av6mwlNWEVQtfhzk61INCFGyob5Huo2JMJxNHZbZZxAfNqI4k7MFPVhzuVc4eYTFcdvdj7sW4SO99RrpR9yzEDrzQ2ZLdkt+h1JFHuhBIMSF5MIAztXrLADtPry41bXkCJH2kEtD5Nbo6SIaCrrlpGQFloCQ+8bw6897VZ1zsXQUBYZpCpyRV23g13RU1Ah7jOFp+j2rD8LUPxGfAJGTON9vX+xJmjR19sqrJiO7UjKhkhIdPgFOhCMhWUjWOZn0LdlxEnvgTbrz7wV3JtXIbcwH/LdVesipfcGRsM1EJPb1UtdvntblhT0Hlsx9iMPWI8hkJJC6sMjUU9Ij/ceJBIPmQn5gZ36tTtcTZOE+5IAN/wXDSWEWEggngJ2LEY4JP23Qtnm5K0ZM6aYL9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db141999-b0cf-4be7-4477-08ddb3e2b91f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 12:20:50.6045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O9wviNuOPyb3562yNASehVctQ112fEfuLEbTB+hhV8/xpldeVhXs131JqjpVMMq2D5e1v4/nhFJOlzzpmTPCfaW3MOzlahr+eT38dEsYKeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9276

Cc+: Johaness,

On Jun 24, 2025 / 20:10, Li Chen wrote:
> From: Li Chen <chenl311@chinatelecom.cn>
>=20
> The current hard-coded timeout for block/005 and 008 is 900 s.  On large =
systems
> (e.g. 256 C) the test spawns one fio job per CPU and therefore
> issues 1 GiB of random I/O per job.  Total workload scales linearly with
> the CPU-count, so the original 900 s window is often insufficient for
> high-core machines and causes false failures:
>=20
>     fio did not finish after 900 seconds!
>=20
> To keep the logic simple while avoiding unnecessary test flakiness, bump
> the timeout to 1800 s whenever the system has more than 128 online CPUs.
> Smaller systems continue to use the original 900 s limit.

Hello Li, thank you for the patch, and pointing out the problem. Your idea =
to
extend the timeout can be a solution. But I wonder we may need to extend th=
e
timeout value again when we have more CPUs in the future.

On the other hand, I can think of another idea. How about to cap the number=
 of
jobs with a specific number? According to the blktests commit 8fc7ca8300cd
("tests: use nproc to get number of CPUs for fio jobs"), the fio option
--numjobs=3D"${nproc}" in _run_fio_rand_io() was introduced for the workloa=
ds
which "just want some IO". So, I think it is allowed to cap the numjobs wit=
h
some number, such as 128. Based on this idea, I created the patch below. Co=
uld
you try out if this approach avoids the problem on your system?


diff --git a/common/fio b/common/fio
index 91f4b23..f4965db 100644
--- a/common/fio
+++ b/common/fio
@@ -204,10 +204,12 @@ _fio_opts_to_min_io() {
 # Wrapper around _run_fio used if you need some I/O but don't really care =
much
 # about the details
 _run_fio_rand_io() {
-	local bs
+	local bs nr_jobs
=20
 	bs=3D$(_fio_opts_to_min_io "$@") || return 1
-	_run_fio --bs=3D"$bs" --rw=3Drandread --norandommap --numjobs=3D"$(nproc)=
" \
+	nr_jobs=3D$(nproc)
+	((nr_jobs > 128)) && nr_jobs=3D128
+	_run_fio --bs=3D"$bs" --rw=3Drandread --norandommap --numjobs=3D"$nr_jobs=
" \
 		--name=3Dreads --direct=3D1 "$@"
 }
=20

