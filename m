Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E74219AD70
	for <linux-block@vger.kernel.org>; Wed,  8 Oct 2025 00:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759882146; cv=fail; b=jOW7EAViLn02uG8aTlu1o7xpmMP227hfrntILS9vQPTOckojYKS/E5thYVqtvGvivMJveHxX8bMRPUnFtQfqa+0SNNZX/a8I1QU+DWf3OTVQvuZGSuLssgz7RmM0E2WQTsrdSyBXdO+55b5z64U4myg/+H/BmKizoTitTchMl0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759882146; c=relaxed/simple;
	bh=wG3nty5fH4XN82Cd3IMLO0ZohR/AeSfMMXIeEFL0ps0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lzPkMeVBCrJVfXGid2jTJgk/BlOEWUb9jPdbcedF3LD3mFVGTphcgzlfe0lXYH8B5mAZhrG95BNqkPSPdiVRkCFTpmEy4q5f9AhX1x3YxnZUNi7cQRHt34U6//5ZAFNKv9OAf9XCs24t/dYnoMloV0WtmYG1xEziVr0E4RTeQgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=R907XWiK; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=fX4ql6gA; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R907XWiK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fX4ql6gA"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759882144; x=1791418144;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wG3nty5fH4XN82Cd3IMLO0ZohR/AeSfMMXIeEFL0ps0=;
  b=R907XWiKLbhB7yywbhz+BcdwY1PFRgfMJRmVRJrj3OORmJs2kTZRR8zD
   tVjTa1BcAsoPFjDDN+19/QZWOgGsoaqfMxYK02HhaTC5W2rIidWEpKV89
   7GtXoWC52QRYD+D+QSiuuweMcrNuwMD6yPYZkiK0RP+tLEyEXoxHhHqBh
   Lo1V1zfrCEGu2uEHD9fajBxQD/yxVl3DcLTq7B4GLWzSsRzpPB11fLVM2
   CQLLLlxEl1CwFfh0QDmaJ5UZ8SVNPNv5NCgUvM+D97q5+9NH3PmGmwJei
   FOdt+eRdKglWRHcIwpl4Pz7fO7gwG/HwdvPt7ugvLfv5s9Mvi2eYt8eYf
   Q==;
X-CSE-ConnectionGUID: 042Z6uTsRQCKtzHxQDwAmw==
X-CSE-MsgGUID: Y26UcqfiQf6dS8oH7uGEcg==
X-IronPort-AV: E=Sophos;i="6.18,322,1751212800"; 
   d="scan'208";a="129809234"
Received: from mail-westus2azon11010046.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.46])
  by ob1.hgst.iphmx.com with ESMTP; 08 Oct 2025 08:07:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hup2E/xOyvzEio2o16d4J5uvxgFiRQL+32TsNbQAVaKRknfBbPTnK1kbgSyuqXoPHrF+gN/eEy7FC4YEbwk+A4VmQ4Nn94+/IVlzOQBUIag67IT0rqi7LnqhlSTboCxwJO5TVR5Qb1Yx0t9r6XQlVfqzltcbs5gpLDr0BVDL4m7H7IWKooAt1FrQL2MiKS79HOP1pkF2hxmK4O1VWhk5Vso/ghgSQFY8duu827OQaWHdGrxLMfsQyStzbOAg4AziW23hzCVv2RQef/w3z0OZQpcrooRMRx8zDNWnuQvGofXZ5bNKfMppqb2uK0ScA72x8LqISIT3CXWR9ePC38majA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0AWAx1z6Yegjal3m0cl4JRYHn8uSabttZ94F3KH+J0=;
 b=vA4Og+uR9oYDfrFmGlXk1l06sIvWMRDmYdaOuOwd3V2rNML4dkC3ICrIjM7Bmf8sDKBZEq9mc+c0WikM5LnkthG/+TJLArQFtgs+5YbAPPl4wfopj/CV7Oh1Tq3grMd9ZZuE0aMZzmSkBvwvqWa81vF26XqiR9aY1Lha4jruc84Kkik5VI2U3mV8AJkFCgxuFvsqQNevcEGtBLhLabaYhjVYm2c1gL8ByHcNm0OaoFHKOAMry5ccIXCMh0r2vt1kCajjL8Kl7y3tKTshjJncePmqv0M1q0R2+hAVaxQ0ZHDfQealW4bBcJdLGYRCkXkNiywh11nb60EXRbP1X42ZuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0AWAx1z6Yegjal3m0cl4JRYHn8uSabttZ94F3KH+J0=;
 b=fX4ql6gA4Wq6z8HGjs7/1zog3AQJvV+c8eeXH/mAJexwb9lJndPGTjaOXCv4IR45Ti9hhSqNYkEdIEQ2Vzsi7t0zU7Ty396wPHpQaS4UetCOqnRL6Jt4o/jdgkIkz6G3+i7pimjy7JJCDMqAIG3tWwFANw8ColTixWdzTwhzs04=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SJ0PR04MB7486.namprd04.prod.outlook.com (2603:10b6:a03:31a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 00:07:53 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 00:07:53 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Keith Busch <kbusch@kernel.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Dennis
 Maisenbacher <dennis.maisenbacher@wdc.com>
Subject: Re: [PATCH 4/4] block: move bio_iov_iter_get_bdev_pages to
 block/fops.c
Thread-Topic: [PATCH 4/4] block: move bio_iov_iter_get_bdev_pages to
 block/fops.c
Thread-Index: AQHcN4Gby9L9W7RIWkaZ1NOUytIHT7S2pNeAgAC7UoA=
Date: Wed, 8 Oct 2025 00:07:52 +0000
Message-ID: <5yow2x2dorflr677zmwwt6q3ubtago6apc244lnhlno4wxk62m@ghdimhszbmdb>
References: <20251007090642.3251548-5-hch@lst.de>
 <2daafdb7aa00cc3b007e68ba146ba7ded2a2f7ca77422111d0f81eca6c751436@mailrelay.wdc.com>
 <aOUONb8jolseFiiT@kbusch-mbp>
In-Reply-To: <aOUONb8jolseFiiT@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SJ0PR04MB7486:EE_
x-ms-office365-filtering-correlation-id: aae38198-8e27-4da4-5088-08de05feb9d2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?R17NYbV4KSj2cJCfxz/wrd3yQCnZrWL0O10b45MQ06sWGaLi94iJpHRwVsna?=
 =?us-ascii?Q?Rhl4Oef2sfVbCeN+tcH0CmYVKpImZFJhvgBYJqcoL3bP69MWvBjYCfd6KGuI?=
 =?us-ascii?Q?Wnqs7o5EdnB/KAe6AHVHjKithZibmOy+2S+ocIsQgkisMC3xvdGxUP/i8AvH?=
 =?us-ascii?Q?un8BuFLgGE59SbZj24kx2JS4BNvbbjjrrAPtZE1qAhhnI0+WfdTyFxZmBHN3?=
 =?us-ascii?Q?CEb1tdIrhbdZgYElu5+x2zNdyWKVwTUJJL8QGsPELPwo7R07WUYHOTY5xIZl?=
 =?us-ascii?Q?ChR2mmN956A9FY2geEXdKkXF1VhGmpfWQ9ow6uY6EGBOUzKMODkD52cRX0WN?=
 =?us-ascii?Q?iuRlPUBDkq2jOddIH6Sf3mEb7ptYJJhabwf24/B7p/aS4A1yk+IkXYWElJpZ?=
 =?us-ascii?Q?gZot1ug1NR9XpaxPkhRVCg5fA/ff+AQQZdyxiLMB1Ab2/rdN5X872I3W5Pil?=
 =?us-ascii?Q?g4zjThvjsBRzmkAZuAsMges47RGeS/9ZQR+OFQIOh408XdJ/0tqBvzCmEViF?=
 =?us-ascii?Q?w8q4tbsUxTQ+jiSjiyMTPtLqc1NO7It/ysilLYtmMFu7MrLJR1SbElcyTrRj?=
 =?us-ascii?Q?OkqgxNb/Myse5IwQ+ozz/vMrkoygsXBzMFiegY5sGBTE0xa0Xm6uoUX3Eq5/?=
 =?us-ascii?Q?IYuWYicRKaE0WLkz66bwAJu6r98PPo7wwIKaLHDObnVcFJHhnzANDHpoEc/n?=
 =?us-ascii?Q?4tSGB9AzKUX2djpHWRTscXkTMaDQw4Tcvr3Er6yM2TeHua8X8uKGvtrGLSRW?=
 =?us-ascii?Q?qzpIbqJ8F+SddPmgJowfJalDQLS13S4ykEOtTLRy1x9lCfQfLlZxnaLscBMk?=
 =?us-ascii?Q?PdOKGdo3HOwuvXpgpwufhGw9LgN5Ah0VI+t4SVVibGA2mbi4Aa33kPP5hncn?=
 =?us-ascii?Q?ndl1JHNxo4WlMzPPQ0RW61WAVMF0x8IC2/uFvQxmfClmrN/cxNMlIeLuIxD7?=
 =?us-ascii?Q?zuPZISdQ6y85kNiQ9CIj3Kqk4dgrzyv+YFUbpsK6rT7cHP2B9KVfoPXYl6zm?=
 =?us-ascii?Q?0MXXWtyGkWVLkqiAhP+LJy7HgdkxFOAvBtlHesgpjb3GR8nPP9Hw3T254aIT?=
 =?us-ascii?Q?QSehzsQco9GEGf6Hrx1JIiieY61BQ1LAQvje1Zu0us9mPjDiOoBXxpqY9huW?=
 =?us-ascii?Q?rHPV3Qge9yMo8BjnIdz72p5pN8Hzu5sxBBPC/0NF80nx4KDMZcMiluWZndvX?=
 =?us-ascii?Q?q1aICoC5MY9xOTepiS509Tr3ViR7d0sTDDyxuZonzd3GnaccxrKnpwInH1Gb?=
 =?us-ascii?Q?Mw4s0cx13r3AtJ5ug6KbivKtDnXlZhPpF4+YR3b458+1suZLa3q7DYOw7WC2?=
 =?us-ascii?Q?6A48n0VhA32hmDfLsVHfv6rFWlASwgVf3FTOoZw8aHV0g74AOQyPae+NjIyL?=
 =?us-ascii?Q?nW9Id3nCTkCbRGFE4VszW+xXCvMV1mVURK67GBFH7xpMLw0TAECQKmOEms7f?=
 =?us-ascii?Q?g5bCZOqcjdXvMdTf3+vzVpSLbpg2hK34rVFOewFeWIxd7M61RMHMTjfMSYh8?=
 =?us-ascii?Q?xw7v5S/gpsnQaCQFfZ3bXh4zUqEbRlhnsikm?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?45Ic2Euv/idESehWSfj5BLlAYk/M0Kb6n42bT62cTevwsTtdnpb06Fwk3T35?=
 =?us-ascii?Q?5fm8H+4Kuw7W04XKAg/LyIpB0AQF0FHWLAUid/IJfC924osD6uoY6U5j/kbb?=
 =?us-ascii?Q?d0WVzfBWx7moTBxg9t9r+Zj4cGlM4WRFwqJXaGIhXs5iMe37CTUeFcoQ/sKb?=
 =?us-ascii?Q?fxPkVDN4eOh4FuqjLk5M/j2szmj05ryv24Ul/M9eXAaBnUFLFhlIhx1u4hTN?=
 =?us-ascii?Q?g4mBQX1SqR44dxGgepkBCypWvIni7H435nqQIcrW5l5V2HkVJMrZw45kXI5x?=
 =?us-ascii?Q?0iO6a7OwWJYk18LkwGkvJnS75ONW7Pkal+Hc/GkzDZp4vyxaSZpzD1N/ucRN?=
 =?us-ascii?Q?bolfQu2mDVSZb33U0wkQZougba9pm/BC7EtXBe92CFducotUd/y/8ldprh1h?=
 =?us-ascii?Q?fKy4HsUPIP7eRF7Zis49fJUARoOkh5WFL8pZVEcD/b7VHwH97NaQIyfRPfo3?=
 =?us-ascii?Q?NP5rXv+cyJcCikDLN0Oj6nIruJam4u4VpWLYEwMvspH87oEbjnqBd82uXIOM?=
 =?us-ascii?Q?ZuVLRH7X9Bx4GghmiYZ1hTzxfG0294r9dO7YEVMAHbMriMTPIE48Ur1X7XL3?=
 =?us-ascii?Q?1Okj2YFX/7z9UYW1jUltYl8L3o2AeAVaIt/Yoyuq/hk0TmlFXcwH2KKmeepl?=
 =?us-ascii?Q?59ILQN/xRiTkWRKjWykfnQEpOYud30pkzdt8nTVhlkWIRIMEX1q5NvTKoVAW?=
 =?us-ascii?Q?7BLynzx+9CVjwa9R9useYMYULPTZD8CyJ0gUUaqQ9X3zLCPQWEji5D1JTDu2?=
 =?us-ascii?Q?cXRixiiFS77d6KgEalERoWp1SF5iO3htIh3cHLirqd5IWg0Kbxp06btEJx+0?=
 =?us-ascii?Q?fqLEYy7S34Ag9zyV0G6j8hAloEI/qCQIhPV83YjgCzE+Wr/w9siGWPhWjp3N?=
 =?us-ascii?Q?V5GzuVl9UdA7qXvtl1ufBe3wxgw0+2mjfUk42kUL/H4HERAH1AERaK+pUGUT?=
 =?us-ascii?Q?4ebFcX7a3+ElOTy7Tx/kauwuVSVWiN2SHqkNGeWsbLd3XqMB0FCU0JnEBTGI?=
 =?us-ascii?Q?oB41gzCvnqMXQfo6BhKzPfapIFVzNQj1wDmN/+CZe+8fcN8KSvdkjy9GvGHL?=
 =?us-ascii?Q?GKnxqEJKASLus1y2xkvV6yGMPK31iB8JQA9Tti3BKQtmJ+5xT2fW5Q3pKXpX?=
 =?us-ascii?Q?OP/Du5QbiuKxXeY2v9ziRspHvdEdKyhC44hbiCmztH63KucrKlBohnwYMx7a?=
 =?us-ascii?Q?88S8xAMI0+y9QHy8XdKeFVXrOBxsnMkBztL4kJnaT2AwF/xVJ3uEdD5WB1iR?=
 =?us-ascii?Q?1K9e/OfWJhQoMHmZDCYpp3OWg7kbSVJLhdZzLojXm7UZdlMZ3mvDAXzeyWqB?=
 =?us-ascii?Q?J3WkADYgefPLbjKroxFzo/F6spc8+EClivSqF/D8+s79rk+g+S8YsDH5/UV8?=
 =?us-ascii?Q?qMwz/9lwE3M5KMvetTY9f0gv+1kBt9e7twqSwWgMlV34YZhkdDjI1A0rkFis?=
 =?us-ascii?Q?n2IyVEXTNj3Oljilhjr7aemu6SulKnZDD9sb5DG/2wjdik6xxjbRkHtOhfsX?=
 =?us-ascii?Q?1uYTZDQOyCfAgbfTgRMvGbOC2yKiQYt/ua/s/UnuULNnZYSbNpViIbADTKRY?=
 =?us-ascii?Q?ma8Bvsw17IAHUCaVSWdExdEf8karITS44ED2VGlyOYMsXTCS4crxxP011acr?=
 =?us-ascii?Q?bZZ0Yd4T6CsSIm8b17Bzh8I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F165F156D59506439FE7F05E8879FC64@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k3978zdKbnG0jtnWK+AvLUEL/Sy4l+0hmlolbjNYUtU+R9uIIoknlNVIaRq1DUQ3sxNspDGgRk7XyT2QJMLFOe5pKIv8sxp+jwx3QTt6f7y+lQBJnIfVNklGp340Tjp4cZftdmJwc1wY+4McZvNqFT2o2ddfbhaft9N8Qm5LskKBKZRHqzXzD/MUGbeqtxs/o6URRIpez+/IxTsVQI2ZlhQ5UdlrmGmUOkYgye1x3KFGX4qfWRWKyxIZOJowjdV265NCrra1an6+H7LsrdeDVbMZgrb96dExk184E3sNWkzpqgfkjkfUqtG7vw6Bg2OnQ9O1bC21uvbWAzpcOuy11+1fJnrj84P51D44hZ+/820CtjRMRPlsHi3+EHVeXhSHe1Dl+SPumgm2uggTmK/Zn8xv7h8rPEepK6ZEG8IXUROjRiydWc2Ooc2QbBwjn2KHU7VjTwx8Sy06gtZ1txhn3BZ1HMlWqN5Fc31qOFNxuBsjoNlo+CdU77EF88RH98EcDdywQy/BuY3z9M+A8eYj6kOs2bnlBSjnqgEYJG/KcQZb51Anpmf1PgRYCBTCvKHQfRPAhjqDKNwDe20C+y96MxYvf6pXCnlnQTpQ/YHqwjS+dNBsEHJy5pHaD1em+E2C
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae38198-8e27-4da4-5088-08de05feb9d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 00:07:52.6718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4zjAO42WQabnvHXyMA6Vkbg8xovyYEwr+OB7ErdERzWWy6DIfLPPEBRX+YFdNw8jxGXXtSegUP099TLZax2MSlcmNANceIpo3QrVJM/QA+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7486

On Oct 07, 2025 / 06:57, Keith Busch wrote:
> On Tue, Oct 07, 2025 at 04:57:40AM -0700, shinichiro.kawasaki@wdc.com wro=
te:
> > Blktests CI has tested the following submission:
> > Status:     FAILURE
>=20
> ...
>=20
> > No failure
>=20
> o_O

Sorry about the noise and the confusing report. I enabled the blktests CI
automated testing system, but it didn't go well. I have stopped the system,
and will work on the fix.
