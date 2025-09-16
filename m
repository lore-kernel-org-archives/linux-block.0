Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14DB30DED0
	for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758025437; cv=fail; b=rPdzFUe5GoA3GAclZ3kFcIQ1Yi9XJXvgSwcQQC43W34LrsxuQMvE4CWKZkU1fsVU6uTOrEA9X+7XcnhWANIrZSTgq/vnei9UZH6Ik4++lygUQsu1jXU/nWBpKz2oglxg+bdyyodEPdq10ySPCeqFMDappvTWZ5wYPTTMvBIDtWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758025437; c=relaxed/simple;
	bh=fjylN9TAX6VpYWpdPuj65Iu65Zl0WIDJchhn10RQD7U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EqZ9NziAuWS4QjBCZVvg+uQPgBvMWGORR4fvsfq6iDULJQw9xf8mDFudkxp+4fbmpgMVDxTaJj1OtscPnp5DtRAtF7KkQrfCdoIm3hECucPAKRNvhnakSgD0YxIjtr7Qg/VnvG/SGh7byHZGSFdHxW5zkIXVnoIQa5FvKskH09Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=DDeBmfCK; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=wWssxOsr; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DDeBmfCK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wWssxOsr"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758025435; x=1789561435;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fjylN9TAX6VpYWpdPuj65Iu65Zl0WIDJchhn10RQD7U=;
  b=DDeBmfCKdp8keVy0zWKfH6CFQL0NZbu2iAsG/x9kf1TZr8fdVsGpRyNv
   0/VDenjER9qA+RPRn63zcEMYUBS2Wb9eu0FOwBtu1k0sSvxNHi/jnvb+i
   lOexG0+E+cqG0JN/lhrc/D0ubA5hKgzOzgbO9AjdsXqjoJ7MLvoEEltsp
   F1epCv2iXmFCrEc0HwSjX0INtLOJUFwgA7l99jgRVEuvq9tZsyJF+KL5C
   LZVcjapL7QE5lVSPQKS9JNKaZg1CaWx9u0+du77SCyrfu8ZBxs+GH6ryT
   H1AxS4CZaXyBTYFJ1IJHFJVJv6LhCxXTYcWoHy6sciIQHZLIgzVk3YjjI
   A==;
X-CSE-ConnectionGUID: 5Gg+qnK/RfeFnOkbyOWo5g==
X-CSE-MsgGUID: hKkoZRhGR02IKKxnK/qyHQ==
X-IronPort-AV: E=Sophos;i="6.18,269,1751212800"; 
   d="scan'208";a="121368610"
Received: from mail-westus2azon11012051.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.51])
  by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2025 20:23:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3y2mExy+gMjjUPX4dUs/6Iy73ch1GJpahCNJsAkhcvTcjaElmyb2bOOsph74jBZIduFX2J9V5A6dk6KcSnDy2sxHAA6toR9CEE3wB/9T8/O04ohea02p7xcBsbLatJAil7c4CFQfDM+RJGFgP0Okj/a9whRwRKJYqzhgZuKuJxQwZLseGpND4mxja2a+HdKqo808SYLA7SvT36ZUTWVlZVE5lte8dGWT2LbbYr5s2V+3BWj96E9L9edl2G2MWfszwia573je4gBmBVeggXbRYun9KQ3w0trUL+b6xlrMA7MvSOMQLJC0mHu6McCdN9P+0oyGBVfqKFMjLlmTvCp7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjUt2KbV0DMLJc/WhBxWtFaJtFSJdGF/BejMHtKELDA=;
 b=T/Z7P0jZ2v1zjb08wglLPCQFtEE7kn6tztZnGbBij+1DA7eGrnYexr+UR4tRN+Oce1arEqtCtEq4ADFAlb87rWz31bsNJPXwkdqqqSSIyRQg6iAmK7WJxoHtMHYgKoYfA2vRmcGgLdHMY/SyHI0MFsRHYgGQiIaH6FMRX34m6LlLGBb1WLKIP/2DnpPHiDr7iNj+ROzPcvBX3WsHT70ikdPIETNja5hzkDEIR9k/TzyCcNtFxV0XiD+IGc4us13FK0JkWJ26kVtHaJlgmRBYpx/wgtxZa9IHFuPKQ94XcjT9Ak+0+hI4hT88T6mSH2t6vOkSfpx8SFmDkMo29TC37w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjUt2KbV0DMLJc/WhBxWtFaJtFSJdGF/BejMHtKELDA=;
 b=wWssxOsrj1rxHcJbMRU0an+PsFx0FW13x4aJlMIGW94HmE+3lS/K+zM5wJsmjIalj41R9OsdgglauCOwO/mvQA1STFgC2WWbcpL8Vqt2HhjGWm1YsYllgdolQ9J2yqX/0L3QgRDOub7V/CJ3NS5EmXqzr2TJ7YB4Ky4xsUCDsvw=
Received: from SJ2PR04MB8536.namprd04.prod.outlook.com (2603:10b6:a03:4f9::11)
 by PH0PR04MB7653.namprd04.prod.outlook.com (2603:10b6:510:5a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 12:23:45 +0000
Received: from SJ2PR04MB8536.namprd04.prod.outlook.com
 ([fe80::8820:e830:536b:b29a]) by SJ2PR04MB8536.namprd04.prod.outlook.com
 ([fe80::8820:e830:536b:b29a%4]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 12:23:45 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Garry <john.g.garry@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 0/7] Further stacked device atomic writes testing
Thread-Topic: [PATCH blktests 0/7] Further stacked device atomic writes
 testing
Thread-Index: AQHcI8u2iSuhaaPAf0qUtMrB+Xji4LSVh9YAgAAXnYCAABqIgIAAB+oA
Date: Tue, 16 Sep 2025 12:23:45 +0000
Message-ID: <vpds7n4kuilakmqajzmkeipkkbd3wpehuf2ku66wevq2dlfwnf@wxne2chta3ir>
References: <20250912095729.2281934-1-john.g.garry@oracle.com>
 <5eri4pgxaqhd2mcdruzubylfjshfo5ktye55crqgizhvr34qm7@mhqili4zugg5>
 <39c9f89a-6e6f-422f-88a2-3b2730b659a3@oracle.com>
 <70d8a0c1-5000-4a3d-82c8-2ac7a76056e1@oracle.com>
In-Reply-To: <70d8a0c1-5000-4a3d-82c8-2ac7a76056e1@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR04MB8536:EE_|PH0PR04MB7653:EE_
x-ms-office365-filtering-correlation-id: 2a9b8340-1ffb-4ae7-5f0a-08ddf51be195
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|13003099007|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?P10S78I8ex4WPihsU1zRTGpZhG/vZAfJ08q75efQJrelJ1rphNFooGSJ/5Sl?=
 =?us-ascii?Q?TbZaLFe+xAZ0xSja5x/q3itahlHsOr/ojDLMW5JGCa3bjrTdIbpOi6EmtVKL?=
 =?us-ascii?Q?WJ0UkY8JhK8/WYSI5pTVH8luRfcNRz8cxeHsWyt1G6XHigD4VDjfU4dOOsOc?=
 =?us-ascii?Q?DplgIaajeZ67U/+FW04xBI9QKrD3E8TTy+9p99Y0L3uhUvobwdfXthcHneaA?=
 =?us-ascii?Q?yXfjdwFUvsIDpoWFD/Xy+19qSqUdGHOgw0yyFuyG5MsHJN8OJ+R4voVar8Hp?=
 =?us-ascii?Q?tuxxhvuTTwY9zUE5lZJf7/oz1lxEQUUMVjRS7wPWyt7M/NzjPQpMgJHdgk47?=
 =?us-ascii?Q?FQuLfJKVliSCM9S0OMt238Mwj5JNmN/tX0JgOpMuh0Ybf8GNvWkCOIUaK3bc?=
 =?us-ascii?Q?y12dDzxZh+qA4MHXQIiiuJGJqsgAvGXhfUnd+IN7ScvMav1Y+jfFcWUjvEXt?=
 =?us-ascii?Q?scZfiA9b7HzBZeNUJPMoEaUMfohTbaHo98ncmVsEO8lTLuKhOACbDqvvjtJp?=
 =?us-ascii?Q?asnCr0Hl44DMxwsmZtL9lblf3pXmwJM5MryJEZ+ZTVHcWqh6tis2gMVrZvD0?=
 =?us-ascii?Q?33r64zal+6FnH1Vxb0lLTvCD5pMwSPdU9+1Dnl0GVaqce0XAexlbMAk+ccPR?=
 =?us-ascii?Q?WnU9kiTHJueM8NP+YOfI8Om1hVt2WeIClK9Jsylq33nqIfVrHKlKvG4z9yet?=
 =?us-ascii?Q?YbZOJiBquHcPKTBubmCu8/2cGUr9H+xQbHQERa/9iFxELjrvztiNvvQcDo+9?=
 =?us-ascii?Q?aEOi7U9xnvLqiaINcBKLxNW/YRfFowRPXHj3+Wtjfo8aSbXnMwo9CH75R8s9?=
 =?us-ascii?Q?6Wy39uVfnN/7yfG5G+3EP22P9K+tYYFEAuUIuHLenBZ9XvTC/6m0XOF1lrIh?=
 =?us-ascii?Q?LeEJ2OX996mIQq30rHbkMAHttgEtpEFHXNJdTJWOPA6NqdUkqaeI38HRHbVU?=
 =?us-ascii?Q?Cfc+d+BY7bjcg0KYw9O1SILruVScjsIWwSbbRuQ8qO6qrdHnXWIHc5DPq7HP?=
 =?us-ascii?Q?AR/y3EoVE16T0Ndj2LJPvzN4aFFx65tvqv1rK+IvvEle56O+2XC8IawGWPZE?=
 =?us-ascii?Q?GBq9AphQr5dNapd9+65EWBxybnN0oq5edRjV+qns4aFjIP5qfKMQct5fbX/C?=
 =?us-ascii?Q?j4mdRp1a0BORffM4XT+v/FpbcH70Tu92I0/2igK4tfXMZhBd9gfUAPPSIPZ+?=
 =?us-ascii?Q?TYQ8b0DbOCzxwWj60yy5bhVhskYgztcD7jI+cLmsy8QVZENX2z9ta5nf8LxI?=
 =?us-ascii?Q?DibVaIrLt8YMriUad9xRI4OfQfNDv0H6LZfCY5FQHZ7sDMXXXy2/PVKZtVId?=
 =?us-ascii?Q?gbjJQHMyHVXVTuTuFTefGJve2q2L05XzhDo9mGETawEKENsVftkc4c8UiHoa?=
 =?us-ascii?Q?vi6J+5dcyMk6sxyQR4nsjaHBk/4XFpuVmXhQjpa5fh5FUZWGQGrJ4y08syCQ?=
 =?us-ascii?Q?9IGF8pwQZUI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR04MB8536.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(13003099007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SKuag2sflGKyLTtsW1A36+j4effyYlW6wBJ9bJ/NqtEJTWcwv6uRDUP3bH1Z?=
 =?us-ascii?Q?CxyGecyYjG7ZtMQ/NK9atXAVvPSBKwSt4Z7wiixAI8kTWmuQr91nOkqd/b2m?=
 =?us-ascii?Q?mE16+d0GDC/2xID+BCUo4wqX42/MrhqPG6YzhYDl4xw3e/lgwsHOV7wIkQ/n?=
 =?us-ascii?Q?vKgorkBPbaxERYdqkTi2zG639OEux82El3xx5cJM96q8ZAFWJw4NRWKoLkgL?=
 =?us-ascii?Q?+kBuGWg3poBunEumSIrIHk9qOhoXJk22AaQtt2n5/cU+jt5LSO7GM2qChRzi?=
 =?us-ascii?Q?w/PKXfaXa9SWOqQN0iDqv8ohXZxJjm/3/VKyG6FjKNDzjSdnP/xXGfykk3bv?=
 =?us-ascii?Q?ap75moCwtXyoeD9RUTR+NcMwnDtJ2xtQGkG4z8dWEKpa/VxxRhdYzAF81IJe?=
 =?us-ascii?Q?lpjnuzAC6z3VrYMbQ4jUejdcFbnDwONxfrhSwN0EGoTkEIHCQ0UCjCm4Fnh6?=
 =?us-ascii?Q?akTx1C96yRGxe3lN8m76mipHYEwBzoVDztFRSDDQb/Q//oWDp5i2eyW/6X5c?=
 =?us-ascii?Q?5CrRNswFGdHqqIfHWhk2nJqur7zS6Rue9JfizWtvVYCoHfv4te/Y9eItREyg?=
 =?us-ascii?Q?mWoLq3uUKH7FOxiKMOXaNkzcAycrlrCeEdKVKLzvL6e55/AkNMW1cO+U8+BD?=
 =?us-ascii?Q?3uvmdKR4qc/AHbx9ljdT8MdOUDAf1OWIIMBVfkb5MQtdZcIEHe3yvaNxdR4y?=
 =?us-ascii?Q?iS9N5PjoB101Y6tQGu+21GoZt+W616FhhukzlsTvY3FAzZjzhpNC2pDfvyTR?=
 =?us-ascii?Q?/oen5SJbo7lNA6LEpPXW2FA+6EbhjqWEz5fWEnM0rgx63jUpH3I7ojoFeXGL?=
 =?us-ascii?Q?5EMsHYSeV7/ZV8LeqQ9AoXypNEUN2nUYztnEkzDw83SiBx/5U3rjMUl1QBWt?=
 =?us-ascii?Q?1erfXEVaNeWZUW7xmiGjofDXUNjK7K9iSmQDVGrXvn0I4NTiojenOZU3T2eD?=
 =?us-ascii?Q?iPDjB2eKZnHXvFY90bRtOFEAOJqTrMjEqRW1aN+tlVh6ohVh5k+lBPskbS+9?=
 =?us-ascii?Q?dzMHk+Q4ThIFon9KWDvBm/jqKe8lF9jQf2MrxjOhwh88ULcrgL0GR6sgMqsm?=
 =?us-ascii?Q?SeOtkxpoEQXeQUYTsOhhGrwdbOsYZda9joNcSbWxv9hzdJI8OV8lgr2XmMNJ?=
 =?us-ascii?Q?jnaGfIGjw6+bKfqBDDWMxV8z2cmor3K/pEKO02zYOlVSh1NzG8ysvp6A0ma9?=
 =?us-ascii?Q?xFE42tpLiedKHgR8RJPRLcEvUdERVqTTrmYRr3tliY+/4wExuHlvoOPoCZHb?=
 =?us-ascii?Q?qupcpCTJz1se5+eZs+eLjraeJZgYfbCrDkSqKh3VPSMNcyF8WsBmE0Zhtepm?=
 =?us-ascii?Q?tg6neBpeBr06ln5ePi8QWSzndhRAF/qsR68C6dDVsNOAE88LbpQgZtt9o5PQ?=
 =?us-ascii?Q?rIoTj/oXmJbEHmQS40ZKwKmu1OLd9oiB9fvlXZl4zOM3XOzFs/QyXW+p822G?=
 =?us-ascii?Q?RMrRTTJyYqB/SqFUWuTs6+n8CYbbEdw6QwLx3N5ThWPplO/vc7vE7YxcjUl7?=
 =?us-ascii?Q?g25rUsdOzdd3hb7qdQ9ZZSm2WEKEvlJrmFlOECRWdHZaUOPaIIzWQqkfTVw/?=
 =?us-ascii?Q?P4q6OzrF7FkHA47HCHuPYZ0GWlwLRw71tMCjWz4JBAzTbR/ctA5ycWylO3i6?=
 =?us-ascii?Q?6Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7E06D3F3FA8BE24B877B110E3E93E522@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ccJ9XFMPIkK60Ki3iw6x80F97R9QpVL876TLqAG/OHbfuyAyrrGRdNK6LpkZwiu0CfBKswARHhTS2sf7N/JmT2e4Ph7/kPhDXa9ofTlyBaFUlaK9YUAGMcz8PtaAwNVV+458VI3evvYgNgDDjyFQt0/mVAUdE4AtEb4hNO1kr/W6/EF0WV66ce6wBRW67rh/7td0P098oBX3OxZQEDc2AIoI4BIgA/hzrN57hA9eMMzFgU+hAp+jfWf6A7+NqpsD/YVOTAQd3YRzq0vuLWcySsYYJ9Vnj83nPEXc+q7uJr+pWYVP8Z+P6NNbCIfnhBWQRdUktopjIubhebkGos+YyRByuR7Pz26bo6sfyHTBG1cX1STG+8XuYjKzI90XGGa+yTCngbg6/HnDrADWvqiubCwT6imuwooeIEWmwI8X3lgBPn/FhUzoT2HHtCi2Gj4PubWm45xBiEl//f4TvcF2w33In/msTJYLG+ROsGdKV70IqcoqgzQrC27fbz7k2/7GNygJ+RZ0Ko1+/fkxOA3a92bX+WT26joF9jwdYq+ar6/F0VEkz5rMmn6CsO/0pj6kjifm3XXdzYhEtPkqTgjDl7GHMFJuAEOYEcP4d35cGVi56dnaU0Q9Kug7CVlBx8aK
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR04MB8536.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9b8340-1ffb-4ae7-5f0a-08ddf51be195
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 12:23:45.3922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rSfeesVE+joQyF9p5fyDmdy4UmKpHY/TvhIvU2+3cl8/jpa5VKyqBmrGyQlah80vsfTh9ElPF5KDoina0tZx9boYDGY9E0AQdbAWzcYCv/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7653

On Sep 16, 2025 / 12:55, John Garry wrote:
> On 16/09/2025 11:20, John Garry wrote:
> > > also modified md/003 to adapt to the change [2].
> > >=20
> > > [1]
> > > https://urldefense.com/v3/__https://github.com/kawasaki/blktests/
> > > commit/7db35a16d7410cae728da8d6b9b2483e33e9c99b__;!!ACWV5N9M2RV99hQ! =
Lm9AlQ3T9qSGDEjCR0nGmjCGC_2wfuAbkP6zN9EfZD7L2Y7mgpKPah_fYZh6L_OPkH9IIxP4f9n=
1Q9dRRRJxbZQeqRtr$
> > > [2]
> > > https://urldefense.com/v3/__https://github.com/kawasaki/blktests/
> > > commit/278e6c74deba68e3044abf0e6c3ec350c0bc4a40__;!!ACWV5N9M2RV99hQ! =
Lm9AlQ3T9qSGDEjCR0nGmjCGC_2wfuAbkP6zN9EfZD7L2Y7mgpKPah_fYZh6L_OPkH9IIxP4f9n=
1Q9dRRRJxbSlcsw0E$
> > >=20
> > > Please let me know your thoughts on the two approaches.
> >=20
> > Let me check it, thanks!
>=20
> I gave it a spin for 003 and it looks to work ok - thanks!

Sounds good! Then let's seek for this solution approach :)

Let me have a day or two to improve the patch [1]. I rethough and now I thi=
nk
TEST_DEV_ARRAY values will be test case dependent. When we have another tes=
t
case to have multiple devices, the new test will require different set of
devices from md/002, probably. So TEST_DEV_ARRAY can be an associative arra=
y:

  TEST_DEV_ARRAY[md/002]=3D"/dev/nvme0n1 /dev/nvme1n1 /dev/nvme2n1 /dev/nvv=
me3n1"

I need to do some trials to see if this idea is feasible.

>=20
> I further comment I have on my own code is about this snippet from 003:
>=20
> 	for ((i =3D 0; i < ${#NVME_TEST_DEVS[@]}; ++i)); do
> 		TEST_DEV_SYSFS=3D"${NVME_TEST_DEVS_SYSFS[$i]}"
> 		TEST_DEV=3D"${NVME_TEST_DEVS[$i]}"
> 		_require_device_support_atomic_writes
> 		_require_test_dev_size 16m
> 	done
>=20
> Notice that I set TEST_DEV_SYSFS and TEST_DEV, as these are required for =
the
> _require_device_support_atomic_writes and _require_test_dev_size calls. I=
'm
> just trying to reuse helpers normally used for test_device(). Is this ok =
to
> do so? I'm not sure if it is a bit of a bodge...

Not really, TEST_DEV_SYSFS and TEST_DEV are part of the interface between t=
he
blktests framework and test cases. They should be set only by the blktests
framework, and test cases should not modify them. My prototype patch [1]
ensures that device_requires() is called for each element of the
TEST_DEV_ARRAY. Then, the code snippet you quoted can be replaced as follow=
s:

diff --git a/tests/md/003 b/tests/md/003
index 94c1132..765c4cc 100755
--- a/tests/md/003
+++ b/tests/md/003
@@ -14,6 +14,11 @@ requires() {
 	_nvme_requires
 }
=20
+device_requires() {
+	_require_device_support_atomic_writes
+	_require_test_dev_size 16m
+}
+
 test_device_array() {
 	local ns
 	local testdev_count=3D0
@@ -33,13 +38,6 @@ test_device_array() {
 		fi
 	done
=20
-	for ((i =3D 0; i < ${#NVME_TEST_DEVS[@]}; ++i)); do
-		TEST_DEV_SYSFS=3D"${NVME_TEST_DEVS_SYSFS[$i]}"
-		TEST_DEV=3D"${NVME_TEST_DEVS[$i]}"
-		_require_device_support_atomic_writes
-		_require_test_dev_size 16m
-	done
-
 	if [[ $testdev_count -lt 4 ]]; then
 		SKIP_REASONS+=3D("requires at least 4 NVMe devices")
 		return 1=
