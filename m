Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F3178F36
	for <linux-block@vger.kernel.org>; Wed,  9 Jul 2025 06:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752044376; cv=fail; b=uQc/K8CaBtM2G5IS4RbC9BQLK2MJ70R9oj/az4BtG+WKtSc6cC2iokdaWMuG7xGdLEdvalB2M7YIt95/3zf6C4RIeb6Cs1o8kVdmQC6+SwherUUVyfqz6av6TtKBt4oI3cp+Eif8OzM+0+wwTKgM//91utslVRV+icA52J4QTro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752044376; c=relaxed/simple;
	bh=K/FM3l7ZDjTEzUuRnzm/wZeu1ATS6Amwca4ef/LxScA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=limNxUklTjHi+n1maKbhrDfu+8CjLpMtQ0IuQPk2W6q3GOXc37QgOmSurQjPI8GiBLmdfK66on/sxAwSTj3Jmdrqj73wLfWRDOjiXbyFakDXm5wIAaeGqR3OgWwdPnue2jzeQHHT5TK5QUYqOOjPoEbrirsMuo8AT+66B1d8iB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Q823n1W2; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=M82246NJ; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Q823n1W2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="M82246NJ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752044374; x=1783580374;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K/FM3l7ZDjTEzUuRnzm/wZeu1ATS6Amwca4ef/LxScA=;
  b=Q823n1W271PZkbYbcn0ESH4Chql9VCOdMLL2T6TIqunzA97etJDa8/vk
   QVlEhBzgUXqeseLvMuqwCtR3EJJBPyI/2DEHcEf0PQqUoemD9pLzIkMiC
   Bhfu6WQWq5BO/+YTpkog5EuyHAHRSWMk+i03rLWlJ7DaiUgcxQN/y2AyT
   ekbYSIaaN/xAHVtqcAWiupFPjvMuvzwY/U8l47FxnNNXPlSH9SzyuZn8N
   n7U0xzRkaJqLNBM8Zi1OaW04m3N9wqIqmRfguGom0/ItCz/uf1TjSjm0E
   qjlFhNVcU9GIDE49X3HQc8NotD1qaQmBt46XUl9yaj5DkN/foz+PeSQd/
   w==;
X-CSE-ConnectionGUID: 3aIsdO4gR8+5HRq6lr7sHw==
X-CSE-MsgGUID: YIPqSET5Toa6BDxYQ6LF9w==
X-IronPort-AV: E=Sophos;i="6.16,298,1744041600"; 
   d="scan'208";a="85633766"
Received: from mail-mw2nam12on2084.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([40.107.244.84])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2025 14:59:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmJfpj5hmrre3qsJ2hebWxCld2d05mL348JFDK7NQ7JgTZf43fWYh8CTTp+A1NwnjxbHhuVVCGoH79YQErd0RibG1izpyyBdT3Ii/emolFtWIkAY9UskdkobQKeEvuhXriWMnPnFDZNQEOSEiBVbHA90BfEVQwAYyAkEXmi6whARk8iFH50OIcQUUNj7Vig0GY0LJ9H+PfuY5Fvc6szRr0MgOAVnv8IUHhUhk8hFmffO6NxClL42DEFb1WzCSk+XwszFRbdo2Wwlb/AC+TAp0k4P9BiF5AnL64qnL8zzc1PtRQfSbJDQXatfM3mKxg8ziogMOgL0NKOLxKkiHBA7vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/FM3l7ZDjTEzUuRnzm/wZeu1ATS6Amwca4ef/LxScA=;
 b=QGUyks3sppweC6oudJn9AHRkGtUoDig9BSh4Mbwb4bIifhUnrCBLiwf0Q+QtMM6qLRBkmvvkGPpfDqNrCAX/c2nH5GFNpn5//0NU3Ej6hM0pKvhKJE3zOOeDNpUcZH0kT+yMISPTThT6aPSs7Oyk+xF9IPSWh1jWjY8W7vOmC1bkX0cLeOna6juCB7Boz+BWa8Op/1pjrCL4JiEenWJlH5nScbeI8cROvY4RIevF3Owfxjw7lZYLkXaQZXGRM6xQJZ+0Pg2+Ahl9UX4/c02pz4JoklBB6vFk4YVoHk+kk7+ZKhlS2MWPddAH5Orn0sKpaTEJDqb2+B0/x7nZeDvVQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/FM3l7ZDjTEzUuRnzm/wZeu1ATS6Amwca4ef/LxScA=;
 b=M82246NJ+tIxiLTjJbZ3VzuveLuvQwuplAbvC8m4Ed97TIeCLvUUV79ORsKnMa5BuFfw4f5zaASLFKO8kNOLdFOV1yFzbpz1tWD+ulx0okBkY13pKPwVrIzn1eh4OJ1RnD2fHIsEJOV395IpsAMRh+xmbPrK/hFRo0z085N0IUw=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CY1PR04MB9737.namprd04.prod.outlook.com (2603:10b6:930:107::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 06:59:26 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%6]) with mapi id 15.20.8901.018; Wed, 9 Jul 2025
 06:59:26 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Yi Zhang <yi.zhang@redhat.com>, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests] common/null_blk: check FULL file availability
 before write
Thread-Topic: [PATCH blktests] common/null_blk: check FULL file availability
 before write
Thread-Index: AQHb7NIGFneyHVsIKUigcXsAW5S1U7QpZF6A
Date: Wed, 9 Jul 2025 06:59:26 +0000
Message-ID: <54bkuwde7uyewf3uwgtin64iwf4o7bzjsywf5ll3lz3pg4cvgr@kyafaozbphws>
References: <20250704105425.127341-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250704105425.127341-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CY1PR04MB9737:EE_
x-ms-office365-filtering-correlation-id: 0ed06269-7ed3-4d4e-1ebd-08ddbeb624ae
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/kWVzEtf+wo3WpfPU4LwKrKC/59Y+WvDETJGab6elCqVzU+V0H989FD956lP?=
 =?us-ascii?Q?OYRQQ+rpzYQSXoQiy9xZxiS//4iyjo2U4R+hO5wWzAdVaTcEqojpto8OaqXa?=
 =?us-ascii?Q?Kz/Shc10VvPdID5PFzaDBm8ysB6/V/wjCtaaMukrQmrDOvQHRV9xdNIKXzA+?=
 =?us-ascii?Q?arFyFfQL7IL83l8mAS7/rxYkN3tk5rh0s0Z1s0nY3RzJDQ3j5CNZjyBRo64c?=
 =?us-ascii?Q?aaiD41WkD75iyd2eNqXT3/fkP6OCGZpWpPIKPExyVffXz5Z/KKmvJOKYYPfx?=
 =?us-ascii?Q?0iY+xm3kNyjB+YvgNJk3f346xgaBD3enmTlnb1Gjy+2oHTl/XeF1jJaURT4C?=
 =?us-ascii?Q?HzfVV6FY3SDtXOY4qIsi/yVprvqQOBSK3In275EF6guVwOtZdKod69UB2/9v?=
 =?us-ascii?Q?3mb20QKRQC2amJqBycSGj5t0fCzp4b6hYeg2rrRy+y6rECCYVIY74kJO59q0?=
 =?us-ascii?Q?ZElaxcf37mdFFYVGXN0ef+yA2oRi8zTfJOAT9jGZqI6fS8+wa1FrfJnYVnep?=
 =?us-ascii?Q?rlHc/k2l7QAWFdUOIvf5yzRojscDMjFGt7yXR2c7gh1ZcvfypbFOuXq8bwjx?=
 =?us-ascii?Q?sxeXgtaMTROV8p3aB0BS4G72SevAAOQhLmaEHZDj8kCtRAwE4cFlnF+DZrNt?=
 =?us-ascii?Q?QpsrZXu2ffmBxlwD2DAWTZRzRePSVmwBzVF0LdN7rT6HgwEtF7AD7EPtyTZf?=
 =?us-ascii?Q?zdO5K+QVAIYL1LozYFxLBCwI16sT6j6q2LDD+FJmfdzWHEk1W7DLL273HpMH?=
 =?us-ascii?Q?hKOd9yquRrEK2MrfPWrOVmpkb4Iy7jyBTcp3SsCeGIw1kJvwMu2tFuyPO1t+?=
 =?us-ascii?Q?IrvPLKkaEScsLWIifewZGasH8amH4WHUopQ+q855xNAduF0vVK/WrRFDZ4nS?=
 =?us-ascii?Q?g3DWBrK+XJSo9k1Z0FDj1r1rbjm7fqTnBudDbKTtR+IbSiFE5T/NB5EE3QIx?=
 =?us-ascii?Q?k75jJ4ngjoIFopCQrVIlK+cLTJC5nI13nhozYOQjSam0m2lJhgIlpvGCcWbe?=
 =?us-ascii?Q?zrfZ47OPMk6/+HNlMlYSucd6na2L77+1Nrq6rbwlaEoj+88EVILuoiHgyeMF?=
 =?us-ascii?Q?ixJg5i3RoCgrpwkoA/7R3+CU1a5o5YM4aTc0/QOPukd8tNMR5/rukqOVD4ew?=
 =?us-ascii?Q?+MB2Imc9yzRjbjMXWn4cdVe5SUoLoa4VbRoMBo7cMDcqlIWfGQsBV3YkE2jH?=
 =?us-ascii?Q?2Egg5vMqVcDwiY2JD/YTZYZyMEY7+fw9JZRVJRkKs0Z5l1itdmcuWOMWjSX1?=
 =?us-ascii?Q?pCOPzPW8X4nAGvku2URSaLhdkqy/kfcZZW8TFi97HbaYPFa2K+jchuyFE5K/?=
 =?us-ascii?Q?4XrRHyf6vLk8bxTlw3x0QBoCxaPHDlajItWXqq5Sv5ui0I0IULJvOU5LgoKw?=
 =?us-ascii?Q?Gpw8EqS9tG3n4gg66ItczUKvNjI4AdR56RLSAbXqdX4Lkf3H8YffnO1fYdNi?=
 =?us-ascii?Q?/fLqjzdpiGHrO5dfjuSbqtl0UsCAIP25sbS8ssf9Pq7mGDofmT1+nQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5P/P3AruMMmOb7teHCLLjFcXvY9jdi1nIwzpYRYapIYnacKKgnJyXTS2vtSg?=
 =?us-ascii?Q?QmSGNRGO1Xl09fk0ha74gPMbIJ9EJW1/PA1SMgi5VLIpFhJeEa/lqTjCA+d4?=
 =?us-ascii?Q?MS4ovDNz95E2Zirj+XVtRx3/lqgjdAOOBHSc8H26FnjQzcIITzFY9L9wiXsg?=
 =?us-ascii?Q?oQA8fNPAjE19fPDDywJJqCrgDA2lAIH0X4UjqGWnaHJqVI+YQK0WwdBx1Zmp?=
 =?us-ascii?Q?2uTrlCuHKJsjewjmJvJag2geP7z22sbbvWZsfeDp1qqqO6NYnuySQfqaBaIp?=
 =?us-ascii?Q?xhmaXj+ompLr2l9n/DiF9z0IOhgW4e8MEUS4HIyVcnOZ4PC7TxWsbjrLtq4W?=
 =?us-ascii?Q?aevU2AX99kKVXcDoEuwNRcGoVaF2DJLQAWpCfjp7FgwPPFk0X2lsLUnGzMRu?=
 =?us-ascii?Q?19dlrCdO8OQxqv0haZdX5EqlqK37bPVUAO+AYZ52wIM7xnUMOCXmo7g+L9Yd?=
 =?us-ascii?Q?TDWNyrLHEbEeh0hLidds6sRTqocJcu7b3OqQkVQaGafer1s115tyNL79Nwcb?=
 =?us-ascii?Q?9Y6X+dg2q2Q0i5ONvraBffgLFn/L5qeMc25m1bCDFAEFtpzA6ELKXTpTG9mc?=
 =?us-ascii?Q?qSavSLliH/vj+s5qZQu+SnDsZaeCvHGUi4fcAZEkfDZhzAWLh1xRHVmz7kI4?=
 =?us-ascii?Q?AWafPb2XVhoK0dcevw0CHbFVv6aK2wq/ka6c8OT4vWrxGMTHW3m1QQDP7kdg?=
 =?us-ascii?Q?iusuFEH0/cc1JF814XbenyavPa6e6PjdhGPWEgY/Pw48761N4ntBHXUxJqql?=
 =?us-ascii?Q?Ku1xIrqvM71JKdtqTxbsHuPOblaaDMQUkHf3mHOGsRtF3QeoxbbJQ+zamWQP?=
 =?us-ascii?Q?haKjdOC6joEAgGLnFAtzry4yNlgYGfk+FjFr4+jerTft8rHhoOrtco4eKJvZ?=
 =?us-ascii?Q?fm4SDJVRXoB8Uv2SfE343LCT4NVv/itJAZHPZdz0ptKyRKxbK1B7LDmDIP5g?=
 =?us-ascii?Q?WIF7rBse6IQ+JOuUKj8E6R3ecwj+fYv1ox9CsXk5/NL115BqIfG8J5nuXqxt?=
 =?us-ascii?Q?jN/IF8TDTtF2M/3uQr3vUCMl/BjYmqdIgWNppVaDMaWMzd8hW1tDJS+bqj4C?=
 =?us-ascii?Q?bQ8WKjy4ZyEtk8j/rcBxcBScU0Bf+MhT1NV65wvczGujw85Ck34nwUord42S?=
 =?us-ascii?Q?MrK/Qpc/smTF/AKtvGzL5Ixoin6kukYnoKp/TINrulOMJZ94ppz8l7AZoHCg?=
 =?us-ascii?Q?1Xx9w2n9bxXdUXEkcT8DK033ZdvdI9OyqxQi4j3fSLyWKd1elWhyR0j0dYLE?=
 =?us-ascii?Q?e75szFqcFr0dIq0XXMK4ydAf+hOEo9PMkJyxVGVWtt3vwgCXKBBxRpvPyxpK?=
 =?us-ascii?Q?+CKslU/n439G8uA3ZobO5B3Q44g/MX52g1aTzPX0YIe6SHyZswJ4XPH1Zm8t?=
 =?us-ascii?Q?iv7TKtP1zDKXUv8vx2q6NrduiCJKJDZGIChNt3TJzQgtBRIVDUETadDV+pVI?=
 =?us-ascii?Q?9BCwrpqEj8ReIKLJNqyapAKn9PuL2jGmTvcBq/fQQtT8cGYnbsKtByhG24uz?=
 =?us-ascii?Q?/oOIJS3lUR1rcaPQGhngFGQCZC5PPVAsKRGZUiFzeB9zVHpDVeNwDG1cF+xp?=
 =?us-ascii?Q?hbXRgLOS5e0LGFY877YyDPdfZnc2fsE9DH/niGDHK21bYtIXSACtrygz23YB?=
 =?us-ascii?Q?i7dJq4gRmzk4iJ8pPcx0hc4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B82BB8F2DA51304F897B13FFFBFAD049@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x3JNJ3wu2sugilOs1L0JakB40jpgMK2myvuuG5QoC4m4whOCqiGS6WplI6BPnVqNBQnDqSYnOP6IytkYr0W4PXAgGtrWy1M2+xGdEXKQ4grmKU2BvQdnFCv6UevXej0prT2LPljngpn99z21CKRLoxUQvs3eSDv7GwtdPVaYeuw2bA1BRExtQkmVHFTCg7cvgfbfttftyeHy2h46kJMJsbME6PYNNVxmyhEFeJP3c6usp6eI03MjIbFuD9VyksN6XOeT2JERfA+8Owkd/CWV+hd2yMgzqLJ388tBQOqfOKK0zVIskWxJzso0gUCgLOLZUE8IUjE1tyFXWkAulYZjSJEQoDuF4+4YYldeh7sPXIV0u+uxfzJP0wM3EDLLBZl2so+/4SFsHYv8yZgfIorj9QXML6sHyAQnegA9OP/BFJF8rXafaZKysguk4F9LIi/jANlKpP8CrjIvryQ6v0ASHVv1nvMmKoqjzuKHu0pqXTe/c+HJ42O8UaBg0tuiB1dO2nXWHuE7vtgqxTqqGRhTRFShXdJl+yI9faASp4X17F7p6GWVlVPW8jXfyDqRsjbYMJ/PTt2Ha5mEG0VvMAfSCa73HdQ8M8GvF1rIK3c/FjtC8GoBSkFXhhoqDwtN+lxi
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed06269-7ed3-4d4e-1ebd-08ddbeb624ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 06:59:26.5001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2gYNloB27GEJd34ILxeezqrCN58rlfv8X1WO40acKhv5IWpYjnHfqfKEp9yiQCRXV2mJFvd+7khOC2A+x0jK2v2GMmJaroH8zOifli0oQbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB9737

On Jul 04, 2025 / 19:54, Shin'ichiro Kawasaki wrote:
> Commit e2805c7911a4 ("common/null_blk: Log null_blk configuration
> parameters") introduced the write to the $FULL file in
> _configure_null_blk(). However, the $FULL file is not available when
> _configure_null_blk() is called in the fallback_device() context. In
> this case, the write fails with the error "No such file or directory".
> To avoid the error, confirm that $FULL is available before write to it.
>=20
> Fixes: e2805c7911a4 ("common/null_blk: Log null_blk configuration paramet=
ers")
> Link: https://github.com/linux-blktests/blktests/issues/187
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Suggested-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

FYI, I have applied this patch.=
