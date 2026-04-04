Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842232848A8
	for <linux-block@vger.kernel.org>; Sat,  4 Apr 2026 08:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775289987; cv=fail; b=j3B+thTHyRR/pvzuYLz5RmST17Mc25RlyM8IMYk5NXvhobikETW4ywVIHR0eiu0BYUp1mFUQUdMTEDz3f86QzzPU8MR40kwYDT1BJmb+2ZxBsAIkLCa3W7Nu6ZB5GJlFHfWMH+oHVDIlVMFaWUe6Eub5f6sBk5254RBaAecr4wM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775289987; c=relaxed/simple;
	bh=q8COnbylYCfoJ5RohnioD16aYbMl6NhxdQ5WNlYhMNo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gAsd5zZJxSnnP6XmCAuTDcbWpybTBqbMq4aPEW1d/Y5x9DG9oNtUGq/HAtcd3gj17f3qaLpO+EEZznJGztCX+XpaYzeDZp8akV7WhN4NLuv3JpsBE1Gvh+Wn6bu0Vv4wGRdVTnYeEOXweTVYcqCZ3DyGZeGQV2atbgEvbM2UKhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=D+6Soesx; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ugCOMWoN; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="D+6Soesx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ugCOMWoN"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1775289987; x=1806825987;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=q8COnbylYCfoJ5RohnioD16aYbMl6NhxdQ5WNlYhMNo=;
  b=D+6SoesxBJHUOufO2JbAwmn+mVnLL0o0INda65tQyQBEC2fdv72DDF9z
   PohRW8S6qV4l6zIaYkfavwi9bBDK5h7gAA3ILe12DyosRxu7gNxenS2wX
   xqtBvrq6mvCkRWjupXZqmny8KQbVYrnoSuV/Y+T3J50jht8XQtjTOIBlt
   CK4J62JbCuGBai16sIISsY4wjjhxO6OS3omWp0GKoIm4EOmq8jN0+ED6a
   fgV0avw1P9rAlzMgvE50Hwc6k1XGBafp7Axi7kf5/ZdjVw0OF4tPiT8AR
   QBal8cbtL4bdQziKVVSwTptL8eIFHcSoSiiNxTfRclZBDbjLZJEEzlQ9t
   w==;
X-CSE-ConnectionGUID: 7vm7CE8pSi6Bf1SwFBnvcg==
X-CSE-MsgGUID: ZD/FPQoEQTafoNX++kvs8A==
X-IronPort-AV: E=Sophos;i="6.23,159,1770566400"; 
   d="scan'208";a="145006319"
Received: from mail-westusazon11010010.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.10])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Apr 2026 16:06:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0PeI6XEEaEGpIh1KbVQ4UG5xAE9ZKIGREeMXkNG2B256TFmPOu5HElM7osDcqWmjhod2IPe5d7KtpX+L10ipZcgEwoI5ml85J0Cf8q8N9dLRcFG1RBFDuYfuNqJedxj+829Li7kP6WbO+kF88rRc9NnHDwEGIQjVjPcNtik6DkKHiSVoVT5c9pv13Z4ON26a/8o+u3dVagupCNLFQrC8jlIPg0vctt2Ayyw6Sw+lzP15cM48MJwxwMdVX6xGQzUF3pkNsvPUHVgCYs5Dmc64dXXUGfwWm6DMvWRsP9L/qab4r0Mb9j2aIEdaxvYfp8kDbL/GRzet25ikx4vLvRphg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8COnbylYCfoJ5RohnioD16aYbMl6NhxdQ5WNlYhMNo=;
 b=Ci+hkIidQd4AtAH/bWJkFWbFFQKJ/MS/XWNklKnqOtinCgMez4O/BIBj537iMB63KIgrKufkx8BYJ6Ilzvid+EprjgG/CXn4192AQuNi0U28w4QuB0JOmiOFHMosF8CdsB3BBtSbrWhSxoDMDGccw+wFdxdIxhtKki8/8yoSDz7A7ifAJEdIgdIOrQArdwyKYYGJlk56hvOppnmnRzxyTJOYmzkQvoRWmpabTrscDGKXA0dfeEZcP3eHgbzaxEBJmy1qgBYSjzSufpcCu+f+mzVepQ71jpzNuZe1bJ5jXbjyuKN8gFBAfi1NyMg8a1yqIrqKvjP2K2NbarvoKOg3yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8COnbylYCfoJ5RohnioD16aYbMl6NhxdQ5WNlYhMNo=;
 b=ugCOMWoNocOCEA5Y28D0wdEEWgUfJc2B12N+/GY5orAFsiqMn8Iy1Cd7ffy6K/w6eLNDO0aqO4CCLk99+NtwyDNatbVDTyhCpPeS+JqK0n5C/Xafbrppg2o4OcqOJKfkgh/m/zG/tzEu0nKvaAC+F163HAQJoISvyLsv4pzlkYM=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CO1PR04MB8284.namprd04.prod.outlook.com (2603:10b6:303:153::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Sat, 4 Apr
 2026 08:06:17 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729%6]) with mapi id 15.20.9769.016; Sat, 4 Apr 2026
 08:06:16 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: "disgoel@linux.ibm.com" <disgoel@linux.ibm.com>
Subject: Re: [PATCH blktests 0/7] Skip tests if scsi_debug module is already
 loaded and in use
Thread-Topic: [PATCH blktests 0/7] Skip tests if scsi_debug module is already
 loaded and in use
Thread-Index: AQHcu1IJoQiJ7sltZ0ShmyJGlttMa7XOnS2A
Date: Sat, 4 Apr 2026 08:06:16 +0000
Message-ID: <adDGLCMM3oc4Pkm_@shinmob>
References: <20260324054949.3821569-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20260324054949.3821569-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CO1PR04MB8284:EE_
x-ms-office365-filtering-correlation-id: 6f49aed4-8bf8-45ac-3bd5-08de92210c22
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 am/LHREw9Gk55VQwTP9FzbbEloaLj368+YWh+d+YbU5VeO6cEDU5kqgRjBk0ApWnYOIkBeIdcN6ngBO12QzaFBzkpaF1PceUndEbWxOYfSib9A0lyXu1J6NQmpUu/SDGvfNRtRh3mDoa3rxWcCMg/C34x6Eka7GdypYyLRGuXDd78nz11iUMyKyvLGm3tWIEkU/Di91PoVaNbO+q37WTkYeL87/1lhJpdHdZ6g27z5cBk8VUlwYSdkaT+/j6C5y2NAkmNBqLUm1i7yg0u6QrILnXRCciWcRbXquaRtJrJKYxLyidFuTbMtf6suVFi5NGHr8DdEPj2ySHQV/meNr+Fhs3ShSjf9zXBwQg+OlX2YwM0djx2ZznxiTlPMzXLKChOWpGLc5xn+dljx8xpKiBzfFt5dcHmVoglrc1VMpnS2EvCaAlqGH84WJ0lJGMQOBaLdSZRQrXlJuPZgwtVDfw8zFqokqb6CrnhLnXZY1aCV9+ZvdNP4VvMLo/E7GlDAwF+P5he9MOu+Pn4HB+SHhjkapAxM3BMpmVtE4SvK6h0E4a8u0p8w4+U8IvR34vzZ1pnfaO/tXu1a7QNBoPzzqf6QN5SYoGuYrRPBSt1KFA51COdA2iZnwcAm+uh3Xg9cp1/0R1pK0F34SyLrh3aoIWHtYo2c0upa7tj+g5zniRG+WOMc7uJkTgDPfk65vGNzqJzTrIdpKm6iUym8JkxC99i7HRbH198KQHgwaPuMupIfAM3XwBaSJzJpuTU9lcSsv3jMF1KJ9MgRlFl33RBLd/D0IzWx5rAo72M3mZC1lduc8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2y2npH+3ZeU3iG7ouLHi1I8SFRj3Bc0H8zU1z7UkhXjEjCUwpCcs7iHCJHu+?=
 =?us-ascii?Q?D5dRTW3vI2yPwBSOR+AAbV+db7pEJQGuyVH4RsdSvXggn0AFw3h5MfMM0d4C?=
 =?us-ascii?Q?gTuVBT7IjyqbG9KRmW/SLEgpwvwgKqL7Y/mNYqyelOY/fuVIHEHB1oRsSCKI?=
 =?us-ascii?Q?WVr0RaycIxQdepgO6utEPtmmf34b+3U7gzQCOsyq5rCGGr2nUksLIu202qfs?=
 =?us-ascii?Q?pZC37j0imAhNNxY4fEkjGNfc5I7Ftreju5xHey78aJSEBUlJe90xEY3pP9Y0?=
 =?us-ascii?Q?kcMfVtrGGCHXF53Ea/BEZJH5pBxoBJ1imUB+gCPOiUVgq3/yY4HjLKwYHhVf?=
 =?us-ascii?Q?1Dc9ZpyGTIG0YECS8wZ94ReP9LLXRIBCTxiM3KAK5oGIOlorlG7UTJKfDUVL?=
 =?us-ascii?Q?qG+QQJ7Jrv9Jlylrv5pDlAd6cuRBXIAbgxh3CzTRbtX0cJzal9P8tPyRmZQs?=
 =?us-ascii?Q?6+rpDvdj0M2i5LwF7ms9xXd3rMxkhdD/t/8Omeg6zt4RIVutL2RrKjSZy9UM?=
 =?us-ascii?Q?UUReMSIFhVhgCMZyBClCEKvD8ai4/WivZcxNighfcjimC8NDRkiY9WtJnGuL?=
 =?us-ascii?Q?b/lZqEl+RK0/MvskiNBo1SjBp6pldaYHDku3HllJY9GpFHCQ4Gx61Gm/OB6L?=
 =?us-ascii?Q?dlk6G59wkwS9OT9WJieXQaT9Ti8ckNlUbQ+Ty7bZfJDP3D1r7HCytzUNONdb?=
 =?us-ascii?Q?NvYRkkpvRZiX/Nxck6pbl7GAnOH0keY6W+X/gtdhxmFAFB5jfTy6wdk7iHj+?=
 =?us-ascii?Q?C6WfwCkr67SJIellcDSi1GjaMfqL1sookHDlawWaGIc4ZjX59UZLNeh0Espt?=
 =?us-ascii?Q?I+kaqXZ/til+DGUgQFsvILwAAwJ/5ePGh6j4JTE3d+r1gYM6T7Q2a5/x8O4U?=
 =?us-ascii?Q?JhaWAvK2M1FzDE3pZwUIF7A+5WTWUmPM+vEN7Od4KKHjA6wg3aqPa/+r3KE5?=
 =?us-ascii?Q?A7UGK+mZQIxrOBN79HASz5kQwP5yzvNQ1Zd5d9Su5mHe2s5thWnpicrnDRvB?=
 =?us-ascii?Q?uPcaj7flAVijK1XjqC+KrFbJrwoRlzoDkUzuU1FTG00jWwgoD44SkDrMznak?=
 =?us-ascii?Q?feXiYTKYC0c8n/36SE0tFwDMQP8TGNyH/y8K9gYi4ExdAdrPDnoKp1ph3Hgb?=
 =?us-ascii?Q?uMq3UQEEGDHK1tlFA+YV+ME/Ixg0lqggKKDnDwPMgLztgTzP2iMmBHiEhieD?=
 =?us-ascii?Q?YGwd5tVudaIIy/EezO3mtWg1EhtZgWB8ixkKsDGv4qJw7+U3y0kVjlb7fX+W?=
 =?us-ascii?Q?K267KEcPremW6szhCTQ1VfK5H5c6XvRsbmsEhz/g5SS30DJNB3jIW1TMbjGz?=
 =?us-ascii?Q?dr888O4KtwcxbyNhFMxChH5y8R2fIQXfsF8XfFV2dzEtJODysc9sdCcHnHpP?=
 =?us-ascii?Q?SJ7drN3V2Y4g27cTgTVCHtLfGiRbO2Qt7W5XzMkgP+UcNGwDD3dBmDtGXjqT?=
 =?us-ascii?Q?8oJ02JfnBanKjnn1k8GMYnqeohATcoR98qpAuZt/lgcRCQB/pUwO2cUQxvEz?=
 =?us-ascii?Q?BoD6JIrbYB/vfCvNqzhldBPJuhDQsVpwDjjIjB1qFyKbyi1vry1Grw8HcRm2?=
 =?us-ascii?Q?CPtjr6M47bcHDEpkemRSCh1BBldPYgE66NYNlTh6tMq+6Ni/diON1XB1cvIz?=
 =?us-ascii?Q?yH1G0EV89OAgaXPhZfMmk4h+nyJHlkinWapu0Sx+Fa688GOLUT/8WNb6PN6I?=
 =?us-ascii?Q?FmGsvYk+sBQoMfa+iL2IvCLIEJMhpxob9Khc+t8D4XkfgI7eLuujZcnEjjPa?=
 =?us-ascii?Q?PpBdIrPhK9VcG+bZ95sj49VVNqQMRLA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5C620016EB235043A5819619278BFD70@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	gvh17uE8kwuMcWJJSQ6iWQK/6klwYNcY29eGiRrBPruy0GVypj4XJOGLsJNR1XEpK1Y7wZAoC8km3PkcLIonsyXOSsnw78EPW+fGWOJAb7dqRwwSJc6K1mAu5xW5+nk52wKRTQsDBViRAAhbl0/aWY6whDQOxTk0C8e+yCJ4WBM0JblHzl7PgFyubiiNMe4fCUJfH4/Vb9aLZLNTjKloaSui9n1DtpMVfMxHZNZ0IhK5Qfk+wA53ZXKD4rrK31dOUkVvjROoCJnVvzPHhRSZffgraGezEO8ID/pzAMw6jHrG27kiQ8CeDUVw/oGRE6Cw3IfxANjf5g9ldn/iVMzSLw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c1OjXNjncQzR3+WwL4vLE+d5vnf7FH+VMEqUvoD68pLsOHxm83+UkVT7TACwgL6SJ71g7oajKYKm6p0jccuEsg7ORdXX1GFZb9ItsrwmvYzt4WyvDacJiDaFRJq7vdIJoArOrtBg2dv6ik0HHNUJMfB25q9mNT1k4jXa3XTOYZLoVBSgTYgDJhRfG3gU0WiYpPcz7rYL2KMtpSNK+rvr1sNgZLdYPFOFGVcjfzCW1dqix+A6dWMrddt8z8ldNeYjAo8qVWygn52SJ6QeRTGEBSqX/dpW5zBXM0TNWVmDk0b54H1gtbuGA/IK/5tLKw+USM9Xc83AqGAL0UthuoEPwlcKiAWiUlqf+AvdUvwA51gCEOKd4x2DUZK1adpZwC8MN/d49Z/joAJJfvZCMDhEHsijtA6IO9I81T9DlRF0VicgCa+va9YmSgN0Zw3S+qk7fYymLIdKOoKTpU0DE4o5FLGokBvuK5UsRiVSGpqEjh/isL2uGPoofmooFpgXDn/T2z3ydXsYoJCXyjgO2HNit7Rd/e4pndUFfSMXsfXkeeZpukp7gNeuGqZl6eEWCbq0QtwR0dA/rPRPO1csZZcaYu2KgL5sKunyWQlliVYPSxBokE69EqfAhxkMp0lhRs3e
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f49aed4-8bf8-45ac-3bd5-08de92210c22
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2026 08:06:16.7982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e3TZKfRrIXJorjMmVtjRodlKmo/xUql7lnTeXNu1xhKaSOQ5MarzV9R1wiAUcNR47ZC1TYI4VrxegO2SPAmrgVeiJcsFBfahhGffxZxJMb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB8284

On Mar 24, 2026 / 14:49, Shin'ichiro Kawasaki wrote:
> When blktests users have scsi_debug devices configured for purposes other=
 than
> blktests, running blktests currently unloads scsi_debug unconditionally a=
nd
> breaks the existing setup. To avoid disrupting such configurations, this =
patch
> series improves blktests to check whether the scsi_debug module is alread=
y
> loaded and in use, and to skip test cases that require scsi_debug in that
> situation.
>=20
> This series was originally proposed as a GitHub Pull Request [1]. Disha G=
oel and
> I worked on the patches. The first four patches fix pre-existing problems=
 found
> while working on this series. The fifth patch implements the improvement
> described above. The last two patches fix two additional problems that we=
re
> found during this work.

FYI, I applied this series.=
