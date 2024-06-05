Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A56025777
	for <linux-block@vger.kernel.org>; Wed,  5 Jun 2024 04:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717560859; cv=fail; b=EAxPi2lP5gerYtVNEuIUI9uEe2MDe2Wpf/yHyCB0r+wOtR3XIqKcVoUN525nuyC6lYZnsKcfULuyT9y8+6tHaDeRCPPy/avJDNP+09QZCPPZjQ+BjbhA0sViXfQctFxdu3lp0F6x2tVKlGrexkYnuahWCIq8Eh/Q+F7K7luTPh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717560859; c=relaxed/simple;
	bh=aey3S7WDcF7s2JcKPJXvAf56zXd8xKQ4Qy76MPM/Hzw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DnEYJN6ePvlWMgowxGiqOpVDhLwojoBq13kiD0XYGR3TZUlmRI3kIwdhATCZE6MweSc1EOphD2/8NmVUqc+cLXgl4cV1QG2lvl/g2E/4unfNc1mJnktGjiefnCPI+C4jOI9mRaFXefFh75rdog4TAIKR7APjOMxfX9Cm1n8WgK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qNV9PqtU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=nNQyBRfz; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qNV9PqtU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nNQyBRfz"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1717560857; x=1749096857;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aey3S7WDcF7s2JcKPJXvAf56zXd8xKQ4Qy76MPM/Hzw=;
  b=qNV9PqtU4uwI9z/hEAJbVN+MXu6tAJEot/3yL9n+H1zYdDZy/0Rrm3ss
   Yv/kuYrkvEPfgIAoD53MrmryvsF6H56OlTXs1W68Vn2ZPnul45HNdqKqT
   nnTr9zu6n7JAhoZB/LJ04ViQROvWMFUJKPF39PUHWZIh1ZSvasC9ugYzE
   oCnKRWpCDvJkXap1J9+DFFK8GSnutz+lA0nMmPvhXEs8lqTfPAGWSC+lQ
   LpQicKkBbDspOod3CGp2vHc/enlSs0FARBNU2wH3qk/zv7p1mhGI9JDZb
   iKLNMiY8U2IS/pZ+/LYkWracRFk5uDE81bi1+A637De4GlDj7wamP2ulx
   w==;
X-CSE-ConnectionGUID: F9X6dzkxRPqPRlCHuQbAZw==
X-CSE-MsgGUID: gt+bZeXgQ96DgQVxv+Qx7g==
X-IronPort-AV: E=Sophos;i="6.08,215,1712592000"; 
   d="scan'208";a="18270089"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2024 12:14:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QknEs+DtcEUUI6WS34sxkxhcoxJ0fGlDBCz5WY0suf7FhYSIJOfXgpo3NTt+WD7nCS/1uVx6MBs61OHTR/jYpViJqfjsUsQfGAZtwob3VVUO1Y72o+psLn+0oJsvGl3rsMwdqwC01jgE9cNuaSWAz0nFYonDT7/t1AeuJp8lAJ91RowKmQMM7UFN1LKVJLG2StvtwyZqmogC46g/5R5dxG2idq2WGguW1s0uA7VaA0H7Sw1k0iwwtvOVoz8U/Xzw0v4BfOyGjudXaAT8b2qPnelyvkvKCDJK2TiDtIw2a5fwod9U95nEvXv47ULCt+RMyPgAEnjQY2IbSl3EtCFblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aey3S7WDcF7s2JcKPJXvAf56zXd8xKQ4Qy76MPM/Hzw=;
 b=mha1w/E0BJmmXCX2/vY6SfE7P+bTRd7rZKnKVytvi8uj57+eE6SP8olc45+62jowdvJNXcRYXtEwh5A2bViLt5JnfXJqveNNhlHQuGz6maIgcbq2wusGnkWqAFZyXMsHMwouP+6sccQHaEFGvmLZ5/Rx6PVQhpmtYuF1XqN1jP8ks/xYVB5HNuhbWNuviEOb7VkQcBSHiwDsP9Ov9qc6HpqNl8wXN8Sdx+dWvqB/S5rU6TccCcuQqW+/0TbeEoWhvLTYK/Y6HJ+PgLINKPRh2+lHDpUjDTwvPLKRsokiXOZaYxOIC3if76Al5qI5uUK/BCOP+lFmhYY6sMEqTkiPPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aey3S7WDcF7s2JcKPJXvAf56zXd8xKQ4Qy76MPM/Hzw=;
 b=nNQyBRfzM+5T+pgqWiuPDo46f6nSYtbt3NXgaR8tTUS6mJpura2KfVZEhs6mUW0NPSsY/0oWijF8/5YIzJRTrAoe1lUC3okYcoo6+k4e6nFtHzgpLC9SKCOwOPa4VVT2/eeuWVcN4XBieamwnOFG1pC5F3j88xcUOjcuWBV3kWc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6746.namprd04.prod.outlook.com (2603:10b6:5:242::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.31; Wed, 5 Jun 2024 04:14:09 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 04:14:09 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] README: add dependent command descriptions
Thread-Topic: [PATCH blktests] README: add dependent command descriptions
Thread-Index: AQHathgeVRGyAjFh/U6gELy4xk1uRrG3CD8AgAGJLwA=
Date: Wed, 5 Jun 2024 04:14:08 +0000
Message-ID: <u5wczqhnd6n7xk4svaqya6dlikchfwusoclydoysksnwy6wn4c@2io2dd3nxgxp>
References: <20240604004241.218163-1-shinichiro.kawasaki@wdc.com>
 <Zl6cPMysMCyHHAkL@infradead.org>
In-Reply-To: <Zl6cPMysMCyHHAkL@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6746:EE_
x-ms-office365-filtering-correlation-id: 96a3de35-3786-4d48-4560-08dc8515f293
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4sTNMRrRvpKm95YYZ7kf9nYCK+WHj2BHaQWzDTjtJjZ3pfeRKigI7p9clnZt?=
 =?us-ascii?Q?d1/+54MrbTHmRdwLOEvc6/2ZidKamTO2YnNXGlSWuzyt5S9UxAX4zFNJ3+h0?=
 =?us-ascii?Q?AumVPALkzCvehFDmcEX34rYVs/T9SEqsvJ0JGoA93pRD2IoFPuUwC4qE/YDu?=
 =?us-ascii?Q?DMHO5fiYE/wc8T+cWKhCV99J0O3If2F3iAYSMeZgL2Kc/gAAyUwEdkicb9de?=
 =?us-ascii?Q?ssS4paLcTliD0IkwRamxIXY8vnSB1zX7KFIBeJwL373fNbIirSyR9zM6hnZr?=
 =?us-ascii?Q?7IW76plurVqtQWMg70z1YFlQXlShHZk5jBHJY4+9nnZfbkuL+LpU8UvHg60Q?=
 =?us-ascii?Q?kHqD3adSyz3JUxoJMNec46iPSBud0NYisbL7MDSe5RxLphvUy7jJCkPds9RE?=
 =?us-ascii?Q?gEEiYzfI8+Jing5IQYDWSzHsPKXzDbE1M6icUt6LIE7nxr0FQjZ1Y1eaAWFY?=
 =?us-ascii?Q?Wl1x9IXdTdUID+sAvG+3GO+xFww+pdXXD4qcE57NsM7hJxH1ZySRhDUQWcwF?=
 =?us-ascii?Q?S1ZjLggqCmGLpDm6u9xQSUnCnUwrZ1le2slmrVUMpgFFGPbYCyZ9lMb1cANB?=
 =?us-ascii?Q?iSMDN77zm0nIdDS2vyyiWwBh2xsbgPaSzhvKl53lOluu5rED1lV9JD0YE2q9?=
 =?us-ascii?Q?N30NRJCAksJrvtPYjW5Soytl1WnrEDlzxKfFI4Ao5PyHxGmmRqtecpdAUSIM?=
 =?us-ascii?Q?4ke2ia9V+WHf/Dh0iweC2NoYb9xMrRqujmjs5Q2iwjfGtwk1Qq4qmPINYXlC?=
 =?us-ascii?Q?7bM51Bq1olraVJhRmZYHT34ZBMscj8x0DJKzL3XukJcEQwnxWKb26E+8/SPS?=
 =?us-ascii?Q?OyzTLN0bfK3XMDn8Oxh7DUiWu8PgaqAvGrRARqLL6f5cjqBn9tLTmDyaCLJp?=
 =?us-ascii?Q?BrjQe6PcQZg2cIGCRCBURAOI01hPIhlyI0iSUVg21/9/6Pnqqys1b/MbAGYy?=
 =?us-ascii?Q?juv1VeChQNOqKyhjdqTIr62x7D2JdCyX4gx39oRvMGZ+wyLVAAS99xBVXeiH?=
 =?us-ascii?Q?L3rNSClKmryzFasDB/KlZbS4870uj8OsT1S+WU+d/GNb394kVnDInoP2VE83?=
 =?us-ascii?Q?aCdeiiXFEVbNmUPzj7YxvuzYfwm+Scnkuow9Fyq9MzNe6hfuWuLuekepUf8h?=
 =?us-ascii?Q?FNmK5gbE/7uOW6bkHod2OEM7f2H7FfVsefQ0uRyr2gs6LxrDqLxtoaqxYiri?=
 =?us-ascii?Q?EieqlEVYgyDEDrNk9TVJZa6HspQ2Wd2/dEtVbP+tWhoQOk1+j+ddWL9rJD3c?=
 =?us-ascii?Q?Dv2LTwJy7+La0Ht1WgvRVEPbVnehcrrJrXaU6/pRWWPgEXeXTlgbs/Th7Um3?=
 =?us-ascii?Q?ieQLjZAKYFXK5AhdfESFEQDpsXsqN7PXJCTrX0xRZtouyHagDsc/74sfuzVH?=
 =?us-ascii?Q?eipUyJA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?g6xvF9/KFWcw/86bkh1Amv8Z+zIah8qQfufAIZxCQGyKEnjPXr6CA1/XkHjv?=
 =?us-ascii?Q?rByNaCWQh6iqegZu2A2SAJl70m1pS7Q7InBkf7eKaruezY/SNq/rnDq70q95?=
 =?us-ascii?Q?7pLhtPiiDm9xjbAe8BBbG8veor0CpcaS8qAgr+8AOfuUlc/CEeScjToF9xbu?=
 =?us-ascii?Q?odLNSq8xl9gmKZ2rNZPCThpLxmfpfEFq4SazKxISMFtYzP3fy6QysQ1IvKmb?=
 =?us-ascii?Q?cRSOzlbaPxXqUApTbgUgXjhdxr+mhaKfp5HxG1pvvfuuHC0dvdWYuB+NNdaV?=
 =?us-ascii?Q?V5koWwUyUjHWzor42NP9rIwsDLdRRYTjlP5DL2szp6XDAeQ0LbQg8+QCs1AJ?=
 =?us-ascii?Q?ROJ5F2Y72apKsrfSqZodpOQYmlttz7jgABiiRWWNhQBrwtg5RoK6T6y9+VW8?=
 =?us-ascii?Q?glY67BdNIqvAtA4m+lCbEBXRlCkWT2epRk655xac5tgEOIWgLqX/A5/uFhsD?=
 =?us-ascii?Q?xerQQR+aSHwZ3yHSMv1+2Zj/8DpxaXbzpg5A0uks1/N+UJ/Jb3hjDH+NGjwG?=
 =?us-ascii?Q?sG7s5fka4XNpE6xN/iHTjGHPwwlBtp4sDkIqvfw+e1H8LT9369xmrH3B16ad?=
 =?us-ascii?Q?4czgB91o+cNHUfp4ztrhDS1i1k6Ovm49azOIDbhD8v3lrewiqWwUt3ZQpiW/?=
 =?us-ascii?Q?vsPfF+mnxa31bc83eC+M4Ld8h5B2hEo7ZtUJvG2dCrVfCET5864V4KKh4o4v?=
 =?us-ascii?Q?G64DZ9jX0SZzL2LXQeND9NIirtWh+P5RtbwXrHUVfYnhHJ2YbOzp65S4pRYH?=
 =?us-ascii?Q?sbqOfVau/72RF9Tn2FAugw1D3zagZhv3GKuwSCUutFfKwK7rhcS77TVUEKuN?=
 =?us-ascii?Q?P8G1eq/eGyq+p5JMUyPRry+lHZbCMrThys0CkG6JWdrXA6yTy5EJTnj9uFma?=
 =?us-ascii?Q?tJmzBbl4w2ezSAoruZCK2Nbaq23bnKHj4BsvuT9bypV1V5dP1qS9Kqx/cp5X?=
 =?us-ascii?Q?WkD6iiIRtJ20pu/yeK5cQGTP6uRdm7fgOydfM/UR0Ax1vKDCxma1psjAMSO1?=
 =?us-ascii?Q?H5KGMV2snUYsS/ljW6ITnxOXveqeWKl9Kz4oifMIbk9eVVFlFCEf9sjNaK80?=
 =?us-ascii?Q?P1MTR412vBa+eYL+YtdNaYqed9aCqj9agyrl2YR9k61N/aTV1zySXxpPeBsb?=
 =?us-ascii?Q?4/DkIa32SSyZ46Qx8KpD73NTaWtMG3GZVNDLJi6oFZRR464a8FBA14b3PFO5?=
 =?us-ascii?Q?uMBgYID7OCx3XGDM5VX3UvI1wmKdOjDezdATzHGDeWpLlI6hx4289AgMmxsF?=
 =?us-ascii?Q?e6swnXgufdRKdYOTBP+QPNVTa194QQBTNZalPBCq2Mo+WOd4qwMZJqozkG3U?=
 =?us-ascii?Q?C04gggGIyL02EpYeVaCNDV18n5+9Iui2gbEhdLxs2tUW8AMFVZ9/RHBTRCNf?=
 =?us-ascii?Q?Dauc9Is2FqbF25yCk/eZtlvmjbqQ0ZNIJkkAu1VRh86qPviiKZErzVPhSuSl?=
 =?us-ascii?Q?G3R2Y37v1h4IQ4yByDdmrtEFT3DvViAJ9bfwlBrqJ8Jod8BU23zyLejpUMfz?=
 =?us-ascii?Q?DApqjD9KRVxi/kkQeUiw/EcHBKrlis+7TR+YWM/gX/MNVEWblAvbyqFH6eOQ?=
 =?us-ascii?Q?r0C3ik85Rpr5SgDC8gD6gzGHrAMMgzwZAuC7Y7tN48Cc5ueD9cN9K/LtCw/3?=
 =?us-ascii?Q?Vc768cDOZfdslNrn/DpPYMQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E966649437F8AF4994668EFE82198430@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uLoLxVAGQNMS1Xz7My+bBxomTRrA93a6+nKtuNkYA6TLB800wYMmgSb9cePkL5TQ1TVcGr8OPjoQuMFN8uqZ8z6AHW1rF0uQAF7moo6uFD0uu5ff4UmgLSCKTL+1wuvjNzG6YcBCdk2ENL2W7B3uuNmF8B/kkq2LU+80TIgota6F6fVVKiMmG5gm+xinRArgpAH7T8rediZb9cfVZdFkzA/JwAp7hJqtZoc2aDGyrC2NSPrU+dSdhxRrbEO2TNCz3fCf2sBKwf1ggwgsaYOPcsh9QHCK4JrKiB8LeYzJDyewfrg/o1q1TdOzV+xFDAjbhWVVIGd0rAHIO6A9xSjmxB1wvljRW3zkn6RnYFAaxftZ2okbTBXS7NQLDwjL+9xx16vbjzbTxc0hGuvQaURmmpYRBY2YorPNn8Wetz5mnmL4lr6BA7RDVFpVLTQCViPNjBhxVXFnOzHcu/l+WblAg5lOo4CoQdFcjadXQu2cv4xJiz9lydW/HNP8vsf5yOurv6pNdYjWq/afCmY7FigkTEfRnNtQMufzMHem4wPe5YT0SAinABp48zVr6u4sxf1UouTIqqo/qSB+Ex1LvlMGkvGgVAMePuLtBt6XkMOJ7w160kFYQ4NoFb+T4qVmlnSh
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a3de35-3786-4d48-4560-08dc8515f293
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 04:14:08.9703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JRgpYFIk2t3zxXBfpXV7ZIEo1C37MKO6JY8dYHSS4R5OjXyOFee39hayuieJmDaQQkEAGYEHj39UbOWvJK1ppys0z7Kermlz96qdahr8kMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6746

On Jun 03, 2024 / 21:46, Christoph Hellwig wrote:
> On Tue, Jun 04, 2024 at 09:42:41AM +0900, Shin'ichiro Kawasaki wrote:
> > Even though many test cases assume the availability of the systemd-udev
> > service and the udevadm command, this dependency is not described. Add
> > it to the dependency list. Also add optional dependencies to other
> > commands: mkfs.f2fs, mkfs.btrfs, nvme, nbd-client and nbd-server.
>=20
> Should something check that they are present and warn if not?

Yes, that will be helpful. Will create another patch for it.
