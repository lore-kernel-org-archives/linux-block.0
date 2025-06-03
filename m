Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2007A1D7E4A
	for <linux-block@vger.kernel.org>; Tue,  3 Jun 2025 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748948066; cv=fail; b=Tsre0vF94lOE5GdWvMjxZ9D4zJo+FGclp3U1/Uj3K/6iBR0vNV5naGMZo9vFSHpfFsy+IO49wT5Tm2JN5rxE+gIQ5C9YnfHfuSznnLTq+sx3cdcmSzsTlR98EfpVTNUpo869Sc9B3B/UVo1kIBFc267J3EAoiG7K1ECwM30FtYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748948066; c=relaxed/simple;
	bh=SQcMh90ajCjcMEI2nOtqfTE8VcXmvySx//YpFMufU6M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rCjUYsMVjn4xEutS+hcOmSduVbHnwS4py6YQ2OXM953FlUUuR8R0MuqbNqCXF/wC9jm4F3OS2MY626+SPn2CdeSfgNdJmmrh/ruIES6y7SBUoqkSxd5+IV/8brk480gvIGTGGbadw4BBprR9Tu7PQU074D4uh7Zst5isPCJ43zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZM9RhTJH; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=aXJMDTFc; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZM9RhTJH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aXJMDTFc"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748948064; x=1780484064;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SQcMh90ajCjcMEI2nOtqfTE8VcXmvySx//YpFMufU6M=;
  b=ZM9RhTJHy7oUyKJhcV04xWFpxUqAEc/+BDWnCzqoQfpdD817ZFf4PoBp
   PoYrrTfJ1hWIXP7Mi4D3KFy+trWe1IO8tAD0uhfPfMKUoNMmeKo3rEnh8
   iw68iVVg05yNKgEfbaGosfUgMfHKbUojThOP68xPJDPMT4SGj7J4+x3fV
   uvQG9v0EB7UsdhjocaRf7colZXK3MoAizXT+Wpo6NdJCJzyHwuA29C0YK
   eNEyLA0bYIQRVdwISB76oUVNYYq+0GpCVyddd37n6gLum3n92YtUcc0fF
   xeSpnX4YcjEaG3VNoUD4/Li0+SY4HhycdHckjU42nCnQPVoB+JlAiXsmU
   w==;
X-CSE-ConnectionGUID: hzDyatuASZyzDktBhvJfoQ==
X-CSE-MsgGUID: YHmNq5PfSjeGlJolkOkkkw==
X-IronPort-AV: E=Sophos;i="6.16,205,1744041600"; 
   d="scan'208";a="83339113"
Received: from mail-bn8nam11on2075.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([40.107.236.75])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2025 18:54:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6A2Cr7Jmm0ZujiebERVbG4J2fV0CL9o0gqIBCAY6LMZajKVVvsPn90xeJ6uP4bulMl9r+9dV6zQmTKq0ALMzFgET4FpkcgOj/12z/Vd4ONpy6gRspBvI1Z5n5sTAoLAEUtzNjsub8PnfgsmYeTajDSwLtuRxQYYuPqg7X8XLVoCkdmyRTQyBJRLOHt9AqfL3DQCpGr2CB7fjQOyCszcm7arnYMzyoqiQocjUGKW/sebIloaYd4yphkHbGbLGDk5x/JRij539Wk0RYWXDWZheH3myLoxzdHwnSM8CNZp5yDPwDZfXHmUGhUIgKAVb7BM1wtO5H5cxgU/zeuQtNXaQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KR9oc/6jDa0Pk+iDEC9OYceh9R99MdPy6s51Rn776/4=;
 b=PutiFviGKn8XEUHY/TXZ3eIcsEwPX2IQyh1K4juJXF2aaIZpiyXNagK9QAsMOXpN0WpFVG/+bfIqTBWXQW8GnCemAngG90WVet/1dHcj7EHcJN1Qz6u4w3XKZNGhITi5LGIOQ9tIuLxwVEtaio9P/VqHdZpInoIH2rTcTd8L9qOg90rXiT1Uc3XwEhqZyW2ima6XX7UGCR89uagpk9oYpvpZQBC8D8ocILGs4/dnDpCQTyPu7FSLaTlQCDA3Elj/pMGeSSbYovq+ZgKuqr4CxjgyBRt2XRNWbxVvUb3/9wPCCE5OlpAft6n44nGD9G763qSROAr41czKwZdmVAIisA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KR9oc/6jDa0Pk+iDEC9OYceh9R99MdPy6s51Rn776/4=;
 b=aXJMDTFcfgwTs9R1BuhyaS/thoJcZ8tegZRS7EOvZL+FZi0XJy12CM+EjLfxKIW+EMf7iLSNSt6pvqMwc4pNdJpAnfCnuGgBcZh5KX/bYzq02z6ZjhP8MydVWEprTxWe4SF8fulbc9HV/OOh2TrDRDv7E3bTo92LJjJM0VPv8uQ=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CO6PR04MB7505.namprd04.prod.outlook.com (2603:10b6:303:a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Tue, 3 Jun
 2025 10:54:16 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 10:54:16 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests RFC 2/2] check: abort test run when a test case
 exits by "set -e" error-checking
Thread-Topic: [PATCH blktests RFC 2/2] check: abort test run when a test case
 exits by "set -e" error-checking
Thread-Index: AQHb0TgVxfjKxPpDw0qPjIwsVIc9Y7PrVV0AgAXz5IA=
Date: Tue, 3 Jun 2025 10:54:15 +0000
Message-ID: <wtf4xxatqafbrz233j4f4veasgghcfz3ocl3lupwglkgtcz5me@ds4f5v23gp33>
References: <20250530075425.2045768-1-shinichiro.kawasaki@wdc.com>
 <20250530075425.2045768-3-shinichiro.kawasaki@wdc.com>
 <8f14de0a-951a-4724-9ec9-92f73e65f3da@acm.org>
In-Reply-To: <8f14de0a-951a-4724-9ec9-92f73e65f3da@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CO6PR04MB7505:EE_
x-ms-office365-filtering-correlation-id: ef2e3c90-dc4d-45b6-20a0-08dda28cfbcc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Jo7QvP+3NZvaNFfPd/F7xXReyxAqeyzcvgM6uR/diiRAladRTYlXjIrubnbc?=
 =?us-ascii?Q?nL0CN1W1+p/q6lmx/vqOFBd7S7qMMXGMuFj/++o0GVrcWprrUBtTOtpjjev8?=
 =?us-ascii?Q?yF+flFB6h2TurK8n7zSyx2oS4zElNw9KlOLq+Q0LHeULjn98byYWUtCiUnoW?=
 =?us-ascii?Q?NewAcTjYhSBhZtySDiyipxxViwHJZ12PeatvQ3dKjKTujVXmIMry7vdqU3H7?=
 =?us-ascii?Q?RiScG0EBq9XdbrKO/+dUmIWfgUp6GvMaVnsUT5y3MLWd9ofOi3xM412PwQSv?=
 =?us-ascii?Q?WeQJz5NbOmPHBZMSMHeTyUYuOu36GRITCrnw0GHm37C4PFXvAo2C1WkUjR0m?=
 =?us-ascii?Q?mDMEeYniRl0OYWkMZsFY5JPR/n9WmXNahrkK82EkWH65uL/tA+oicvNNeEdq?=
 =?us-ascii?Q?soz9a6gnO61zJ01EU0V7am8a3TxDSehHL5qzqkK8cjl0lShjADxJ9mWUoN/X?=
 =?us-ascii?Q?7ZzzBdGabdccyujgbDZA1QMXebS0oXRPnCd5gKc1S6G3UNoE0ldvpCNtZvO+?=
 =?us-ascii?Q?v6O4R5cC61OZxwLP4rRq8wZzM3w1nsdhhUbr9T2AQq+D6rjddzT31zU+jKQ/?=
 =?us-ascii?Q?D2pvMx82NLY83utmDNg5RmCUPqeGXjSwd+uvWX8ox19HTO/eHEIu5awD6M42?=
 =?us-ascii?Q?1iqGBMbaXRTKucexhHPOGQd9W0V6hRrN6kLR4EBqjTjzwUvzGu7m9zHfJWPj?=
 =?us-ascii?Q?zdbnwq6niFyNTo39cfl9U9P2BjOLbsFdT8rTGNQEwrg8i1B+p0S7tjLgKLo2?=
 =?us-ascii?Q?+wVXssV73CFAUfILRJfVgiCf6QeJmjVsd+Wr4OE9Sxnz9hL0v0IZEy7L/beP?=
 =?us-ascii?Q?aUeTTwgyLn7hKcTal7hrtILObieIgDx/e9czB3237Hc5D2Ydnst65HJEDz6a?=
 =?us-ascii?Q?84BiLkUFk1ZVks6Tv5KerCroguLboum2QQlu9gUnJD17zj/SmYDSespp6YIS?=
 =?us-ascii?Q?OJ4hPynZ0SXqYZsrD8Eqr7kVa20z2jOv/8QriMRwc8FKd42SmW6Jk6qICjEF?=
 =?us-ascii?Q?vC93S6J4Bo4k2tQ1aAinWuOvi95vvFgEfjHqlgYRFblPels65dnwpY/bxR7w?=
 =?us-ascii?Q?mHlsbfHzFjQUjU5dmJhhxzS0m7UdlEKiXalduexNxWY0lP5ebaFl5emPtARh?=
 =?us-ascii?Q?hlNUKFb9ZBmZX6hYB3VCknGyz84O509Cgvt4s09soniXhSivPxTx83I4lQ0B?=
 =?us-ascii?Q?R+I2+/Zdxla/wjLgkovQsTj2XMMfrNYrCLSc0Q7TwRuGZE+7QVEoAYelKL76?=
 =?us-ascii?Q?L12yMhbKDBJyzulmF6PdS9zuv3cVzZ1Brg8sLxZtWFRCb4NQN0vTiLJkkNuy?=
 =?us-ascii?Q?rPZT7H+yDomWnLf3G/80/jtdn3smJPR1IObjiGNBjLWta4SD9oJ8aasYTEym?=
 =?us-ascii?Q?n4Vsw9Trl40xG1X4IN8wxBALIwAFpDLiyAMVBKf0B/1aQTOre4Cas6KaOJ52?=
 =?us-ascii?Q?yL/VqudJXSUJUNu+zpYnLjOGweA64mJBNMDH8NDkp1BQGdTf840ZF4C7KyOd?=
 =?us-ascii?Q?WlEsmCRNuh/CGvQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HnWlwY2llr/dDJb80w+bSZRIdeZ/93uyp50i3S9kbL5OAPgK9OrfFOcp57Ud?=
 =?us-ascii?Q?pSfFaF0fWV+yH6lf+1yypGqbDZDKS5f1sWCSBISguoUEvyq0atgbowfafPXZ?=
 =?us-ascii?Q?JBS8YX1V6/N8DT8fbBX8VErDijeyK9gEaazC0gxzf3lRwJFgQ1cSO+uLE4XF?=
 =?us-ascii?Q?6bMk9wCDrPlvlFI8V4XPqwwoVODhm3bIlqzv6MqhBS1Sjjoel0G+L53zJb2i?=
 =?us-ascii?Q?XWGBZE5avRaSPGfenLDYNd4LvG3e9bZBf6X6T5Nvh1sC24Ko1zPMeozCDc3Q?=
 =?us-ascii?Q?Ixk1y95aW7MgGGAtVe5Si+NDYbMlEVnjuq9EtLbJSccBnIJrNC+A6MsqOvk/?=
 =?us-ascii?Q?y2kIBNMDgHQf+Vo4FKUUmMA0R8GJoSgphrriOvUsqj0TGcrp3CnRpX3DCpXs?=
 =?us-ascii?Q?SQinO1mgJv74wLjZwQaYnoCmrTC/vK92LN4BlNfpKVLg3lzH/vkBBh2ctjYf?=
 =?us-ascii?Q?IVF9UDxDiwg4KyU5B5kKConysRExO8bDPWYD7xOpRddBNxPk09hbj42r1nHD?=
 =?us-ascii?Q?kEYZ8wRWd3hbjX5V1Zql3BEY1N8my0LDMRoc5p3zaYUesMo2jRVKwZDMr1xt?=
 =?us-ascii?Q?7thlX9I0dA2SJ5AbAV14jjIuZNnKEH5vVrPPd98YsqcCOZ7pLZQ058f6Blyg?=
 =?us-ascii?Q?UUzy1vyP5TfrKtyulUIg4qBgrgxPcVJddtM2YYcT/8w54qXhHdG0bnPsZlzA?=
 =?us-ascii?Q?M0WoQqzxTs2y9RFobh+h6XT82yAagcaPzZ7QhFnPuaP1/x89suOqG044QSa9?=
 =?us-ascii?Q?bn85WqixgDonr6Pnbd1sE40I3SgSaLyW6N/kW+8q9fumAm/xiF3MNxYYeVw3?=
 =?us-ascii?Q?2MZoaogjh8UHLxZyjUZaQUp53nLN5QIzq4tDp3pOa4zxbU4U+FWIxbpqUazI?=
 =?us-ascii?Q?W4cbF6d+bciiPfxqU/felgOI8+xhVzguSUG4EUwhlMTPRpEluRFiY8nwgKYy?=
 =?us-ascii?Q?At/aNbXCn4UfsH2pSlM0IuPr0zlPPYSEXEMuvgTx0wpKlcmUfr66h5TNKsnj?=
 =?us-ascii?Q?EMjGJqdD4kmShAk5/2RTxRRQLgxb5itiAKasJEyVkSeAIYj1bwGWESOaEuKZ?=
 =?us-ascii?Q?M6s7lydoqtDTuFYTlSv55IQyZX97WQ1vIQTG8fvnp4VgnotQO9fMix68hjo3?=
 =?us-ascii?Q?toiwLbrFJiiGreThbYjRK9psDNK42JobIEe/gdGgrciSpzFGs5Ohi0ebOSNw?=
 =?us-ascii?Q?HnG+1nGsuMmnJN5cgWgzN1ySzj5kj5C8JAY0Lr/n235Cxw1lhqOz38vx0OoQ?=
 =?us-ascii?Q?KYTRhOp3QdSmD15RJ8MplLLPpwCyQZJCUWjDWa9r7GDU7/gKvYWbbSCVeDq0?=
 =?us-ascii?Q?eaNORq5PWWNudvgGluPJpycqaX/lu+eSPms73UdnZX3tQGUySRm+IG6T6fw4?=
 =?us-ascii?Q?pdmZrB4TqXjUHzJjtGsfyxiVr/FplPsKrFuzE40w7r0njMgysQUCRITQYMef?=
 =?us-ascii?Q?8lejKME36sp2Mhh8fVT0Hd2VNZ35eM1uyTLOUZZnxmwtiWJEzBDqO/Fa91od?=
 =?us-ascii?Q?hVt59YlEJ7o19SyPaF6tJUaSMD2aqdgfL+qWepZ+ytwPMKKNlRkTpj7HwUpO?=
 =?us-ascii?Q?RM2iqLPFcu9ZUXNDBWujr7HWLudCV+G92qJxxGoLpkpuuE5RuOhFZuUPfXk6?=
 =?us-ascii?Q?Gw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2872C94BD5C0CC408F3A3544B376FBCF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YIArD3SbQ4neowoS3+w+1Cposm37b8jt2Wxk02m+T5HK7q4CahsHiCaFH1y2Fxix00r4JB2IZIPN96PM0bU0HOASczYg2Ee0Au4ohpHMgJ/0l1yDC1AJBMxVINibfzpmWBZSB9Boge0cw/roOqzyLGU4v9bYp90kXT+ywha2KTHoaxRdghm0814VjiqdR5JuHNl2mQlDpj7iTjLmBK6u1/1rcu7LIcUunkYAavPFPZFafLJOw1M4ZtZ5C6H2l0rQFXp3hs1M6yMSZd23VjdpgOOXPJlwwAknYxO0m1fMKp3RjOzobLhy1yeyzZuRfSfKoIUW1RFJ7VkVdEmuZqNQKwCalrOJgH1yqSVVoVm1bXnoa2dE3k+saZwiemjHiWOtJB0Vbko+H4Ng7MYOpLEDBXd6F6DE8ut6vc0khVxVurg5KJf3nXEkDygWOONEKFRsH2w8/2eHreBBmDshj9Cw8lE93xeKixyY8r2UJdo0OEdd38BGBo0MJkzUSX/pM8UlmO71WwIVB9Y4yDmTnphQGN/TjClVX8g0axtaYp2ibTKHGA4I9OGXVEZ2JX5gOVaVHk40pzpzl8/GYtdjvniaRvn9rEMjI/6+ep2fO2fkZG8SrwI1hya3q1qoGiUXYHRY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2e3c90-dc4d-45b6-20a0-08dda28cfbcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 10:54:15.9934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EREIFfKC1QQ8G2ip3JoMQN40Kjxs2neopa7wB6P72T+S8SC54QwrdGJxqFql8pSulvkX5WaZ8StWXNGdw5gtVGoSFXZ7+4VnE0Pd53MqeBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7505

On May 30, 2025 / 09:00, Bart Van Assche wrote:
> On 5/30/25 12:54 AM, Shin'ichiro Kawasaki wrote:
> > +	if grep --quiet "set -e" "tests/${TEST_NAME}"; then
> > +		ERR_EXIT=3D1
> > +	fi
>=20
> This is fragile. Please don't do this. My opinion is that test scripts
> should declare it explicitly if they exit if something unexpected has
> been encountered rather than trying to derive this with grep.

I see. I will introduce the global flag, like ERREXIT=3D1 or something.=
