Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E551B6BFDE
	for <linux-block@vger.kernel.org>; Fri,  1 Mar 2024 11:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709293929; cv=fail; b=i+wiCjg2xd8sl2+WkILTYzDYBSVGH+Tayl+TciSoeX2xq7P7VuSXaK/E1u+VpAR8ricxdcqiYHpb62ikcEhJ+sNfA6AfNUhpqIQCs35Ydnc0EdPNHzS/IYu2hMARGsC3VoqRWiEsZvpM3EuJBbgx7xl+Cem9aCxtjeYSN42XGo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709293929; c=relaxed/simple;
	bh=4duKSxYBDm20QLIawsdBHmINtQ11qFjMP8ioKZ/DhEA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vDd2ehwgbtTF+ciYqsgxQF4r30f2FyfnNv6rV/ezFZX7yzPGBHXGEDv1/fJ9pcthPgQ1KCBp3ZLAEx9GbIYOAQKiXsLMOJqxUhY449F0trbq1lHsVvmoQuiy7dGwO3VlUro39/fIJCk/Iav/ba4DqXwAkee1DYAidcEB0YQsit8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZIwGRZPU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Yx1lK3Ha; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZIwGRZPU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Yx1lK3Ha"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709293927; x=1740829927;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4duKSxYBDm20QLIawsdBHmINtQ11qFjMP8ioKZ/DhEA=;
  b=ZIwGRZPUzUoNLYDGOo7ZZk5HbOw8xxBDqIuaSX1RdHZiSkplGKBppPZe
   nQj/dBCCu4CEZLAcBivEArB732YR4WqMciiMwLq4EzZcp9KySmlpwawdN
   vzAW/zbJLf4L01HseQELBluHhc0jEmRmjpTdaw/8d490/oNxesjvoOzK9
   SY9pzeO/+1tbZezpl0xKCUe/mzylkWC5SFKVZd3UZFpj8ZX0bOsouacuU
   LJKPX2XsJgduGezQ8g/BXXHD53dgZjZs1ZRvNlB4SnaCFaQoBeV7fbZpc
   AUAG31R2A/FcShj8Ie0plcrbKsYZKZvkVnaSK6M/mXup+MRozVix0y1Ve
   w==;
X-CSE-ConnectionGUID: A7QWsX2FRxeTtB2FvwZyIQ==
X-CSE-MsgGUID: b1n4PneHTBKoXYEHqXDLAg==
X-IronPort-AV: E=Sophos;i="6.06,196,1705334400"; 
   d="scan'208";a="11170192"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2024 19:52:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5VtlUhIErg3ja85oMcukh3EGVhECE3pc2oo7P3tsqCvnNommXnYm1VUXpixJtNAg6+LNUuR7Ydt6WqThBYFgxLmirEYj0FNpCb1pxWos06dvJHuvsGOj6g86obWM36FDdFhcCnj3yYOKNnLQc1nnegxOgFQ3fhAtbUG5J3ZpVuocgmA1TH+4YwFsGSt0MwByvcaiuKXLWWok3qc1dfQuHl6yRV7+Hgrzx7HoPRXnNHesRZkiNodNf/QZRBzXe7N9bpBka4vptySpIwRGahdvW3Nf52U9q/Ut3p6WajjDp1g2yvmrvQRJ3ZXiCLwc6aDmgxcdUGzMaY9xF2nYkSgKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4duKSxYBDm20QLIawsdBHmINtQ11qFjMP8ioKZ/DhEA=;
 b=GBcT73E/3R1OBcPoiQroO3kzmwaQNMe+4+uobIWdjzf5aqzxmvxuKYB6tH4BJwsMmZmqUD0RqaxQehqGPZSv6RiEvyWQ7Ru4XNk334t7xKaBBy8kP/fOZBooWYGzpZIt5iX5Uc/rNCUP44y16dbhnQsk+Oob1/uGlgSE7N2VHhZ2eTpfxMddvOmnBlvJXtgF6H09tk0piCbOtMO6OXIdztffvn8CSMIC36++wyuB1zWOklSp5I45iOHZaDTdjgr5wIpStcp2j9F/OQma9O9YjXG5zetjHpjBgQXRZAoHwDHDCzv+jSq9qNkb0uGToRNJwh5e9fbLkepxksD704V8yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4duKSxYBDm20QLIawsdBHmINtQ11qFjMP8ioKZ/DhEA=;
 b=Yx1lK3Ha0FhwCMAKWd6Xg7AioYKOyYUhhk1gJDORzoIAW3LxTzrNqjcpzvfeeKpqqF4wySLW9Pc9HylFWQfLJkKRhD3CFGL+MMPhilXmJVG1+jj1OKsElgTsPctVWEkSDgFXo8FFYHu6IFFU4NioxH+MB8LxdNpfF2L/y44JRWc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MW4PR04MB7411.namprd04.prod.outlook.com (2603:10b6:303:64::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.47; Fri, 1 Mar 2024 11:51:59 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b%4]) with mapi id 15.20.7339.033; Fri, 1 Mar 2024
 11:51:58 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] nbd/001: wait for the device node to show up
 before running parted
Thread-Topic: [PATCH blktests] nbd/001: wait for the device node to show up
 before running parted
Thread-Index: AQHaaxxpoZNSmkFMGkS6polHAjPXMrEix4CA
Date: Fri, 1 Mar 2024 11:51:58 +0000
Message-ID: <xb3omeweyywkdgoeqewdc4clorgrf3tggohanm7w5ytrtmdt4b@ehepjjfoxwsz>
References: <20240229143427.1046807-1-hch@lst.de>
In-Reply-To: <20240229143427.1046807-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MW4PR04MB7411:EE_
x-ms-office365-filtering-correlation-id: ef0f76f3-14ee-4b2c-e256-08dc39e6003b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 p3ebtUUeAYsxhypGsoft36U2W1ahNfubg6kNlLkEUNY3CMbryNlPPR69lapye/fCukl8rFm3bdBw4EqRDwN9p+xxMInEtz4kPYjMxo3OJXuCPmznfan0oKoBiZOmGCc0LRaKeiIlMjZabiFX9c9kuMS8k4OQaQHbS1ZiXRrcGunNxrnJm5Z/HnVwXUdKPDzMLFxrf7D+kTDOHfkN4/t9pBUONAf9vSQcYbT0rnMbSJrWFVxZVR+TlvttKbtwvtXQDKqH2laHUqGjKbV/BWTUR7aPXdN6PsoBFWJJaVznRyJL6fiWUu5z1fP9tnIntjbzQvtq9KsC95PVYqLLyLRXXIHFY3p5G21uxRBRI6yi9eepdmpuPYsjtEdcHIax25MhLv+lz1hs32KF63/WWgnx19kCDdBQMeqQCmC5R1HWxgg1r+Y0Oe7i/H3aDKdz6GtNGrPgZnovEXx9eJ83Wm4f4W/PPRN1QoxKwwGdvv9nV5j/7886isXXngs4aDKJ5VDjCnVMYg1F40GuTmR+Mroj7hqWvtP9Oy0bx7hwE9FVEi1g1+Z8wckvzBkWPkur0aScHRn7wIEC29Siu+rmWnUOt/6R5TT+ZbigBkhK5J1Lg1/z6MtrnnVpIqHm+c/0Yqwp86+1eI49P1Q1mFr543gfkAaxhNz2oELwz27ZWOvBT5Ho/eOjn011KNeGbLUdia3SUcPNC3C+rTuqwoUa9okDR3aPLGZYLoi8f1l6tYLFPUwZWufE6f8DoLPf1Nntcw9C
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009)(27256008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?skO74GVu+fqcOL6ZPERCOvBA4p1c9DnP4/puA9Y/GKIFhhXj7XLDWBnAU33t?=
 =?us-ascii?Q?pBLbM0qdnti2auUlv6tQfUVGJQyS0L3QuaraS9+jAxaTZMDQPuW9tRSnzk2a?=
 =?us-ascii?Q?2h9pHsqegteC5zybjx+6fZMm5x/WJRxskLERV8Prx0pjzt1wxCZkIYmDxICn?=
 =?us-ascii?Q?vHpfpn8oGrD0+UL5w4EmmmpnzGmNDFbPXSi88MQQXnKWsw5NBYvj707FUbsu?=
 =?us-ascii?Q?AYKjNBqn47hcsy7Dd1SrRxMs3L76KDRfwaU8EguAhyeqL5SewGL4b2pGhk5e?=
 =?us-ascii?Q?xkhRjPsYLD1PA34MxdyDrtE+XXxUKQ0Jg1ixH1ca3RNLbDB2fBTdMog5sJIA?=
 =?us-ascii?Q?vx/WvotcqXwt0q9ZiZXd9j5z881tYrRSZsdeH2+Zct91VesRpWDY78kcyaDS?=
 =?us-ascii?Q?atauMx0ElGfuN2nZnj5rcrBQWbHyLXlJRIXSZikDXh8pjVu8oKsT1Dtal40O?=
 =?us-ascii?Q?jKC4oPLRHinRP02GrksA9eoyhAJ3IncwFBSzELIl3KSrDFgFcEaBFuFy0faL?=
 =?us-ascii?Q?yA6o9os8ajcfZiE3KVYo3eYl8gMBt3f/kMEzmH2jb00OSCq5JCJ2/K9/5EUj?=
 =?us-ascii?Q?I8t7oBkewtx6GlG1SNJ5XT15a3Ec+7aBTWWjfU+FhgTCycJNp0KcmSh2QzRh?=
 =?us-ascii?Q?eiEmNmdKhMtFrRIaWHrXBwHEOBqhSD2admXJS4ctFbLwgztB3HFNvSs1YSnd?=
 =?us-ascii?Q?CRz/kIrXkWG/R1j/rSbtac7b1qINB6atPYmWarEOopP5wKlPyvlcrIV1DM0M?=
 =?us-ascii?Q?v+3wEIRguQjlq0q4dG6Tiq9yafK0m3ZECZiMZiDDaLN6kBsAIVjsY7E4GjUj?=
 =?us-ascii?Q?LfWCFa/M6uO9BW6QnoulPmxZ9wdvWQU5/FKig6xf62S/7//a78eFOekIZmXx?=
 =?us-ascii?Q?g3ybtSPTnD5eKELqY74UgwOzPiIjxg2savvc7IVzc3zRAWJseorVNGvTJ8zL?=
 =?us-ascii?Q?qTgGNV9MmW6XRlYGNL8sjon1ANRowSY5xHCqcRYeF4MF9DKdNont6ZtU9yJv?=
 =?us-ascii?Q?Gu9Aukhq0Gm5hG7w+RI9VKT7joPqlCzwsgRIbcAX42KW59ZMNsaMCLCGqQkd?=
 =?us-ascii?Q?oHbxu0MZZUv+OBkkIUUy3Y7kITmbg1uWVSXJzfrCTpWY1IHyXDhjXXxxWIFS?=
 =?us-ascii?Q?0VYgcC6aN8s9BPFXHazjW9UtzU6xc5donR8zh48bOm+PPbyDZL2t2iBSt7je?=
 =?us-ascii?Q?5ZDOE6jsAoxdJErCxkwQhJK9Aer8ot1o3/2h0qQ1Rw/JWyd8nc3wu+KZ6Msk?=
 =?us-ascii?Q?/0DLai74BnLoZdSpkecZySyOxC1WmNeSB+sJMBsmh/MkZ6no7wZTMXk+DmNm?=
 =?us-ascii?Q?FP6mQ/SE2uEsVFoqS/tqX4VnF5ggUw75xh+hFNzOfHldiUTpIWKdNuxrKjkK?=
 =?us-ascii?Q?j8LA0wnjkjyC4ca9TRPfeR/bjsZ4Hq8rKapTsRf/4pH4S9/IlvXGgWqk9DbP?=
 =?us-ascii?Q?QtLPLrx05kpi7jlifP7QEtgQ1/CJLiQEMEXwpKsu8HvpwGqpBXye5mphSWnV?=
 =?us-ascii?Q?JqHrw4AkoLQ9HVedwnnDjLrBkd2TGZN8ICJ9wEwZLiaepU+rG+W1zByl4mik?=
 =?us-ascii?Q?6sPf4CwupK15+7h/lcfch/hoV6L64znVeNvd9T1iJxFltXA7AGsI5lm9JcTX?=
 =?us-ascii?Q?A4kzxj5e+l5SPLBTHZy5zWE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4C93D375CA96B54A960BE1A47BBD0738@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WIcpuSnAYXcl77q9SlJDmbenw7VkCi+WPLy3PGEBb/pVBpTVuuBsdJjCF6sdzqtyB2FHOJpVwdSKfVu6YKuT3Ngo54lA7hLJPyRclf20W3OJ3oAj5BWyxpu+habWeyUUyB7Tj7h5Nh0toE5yLxoMU8MsMFi88fdvqqv3LgIzkhAqnrjLlF3mAtrAXlt6iNv0sSWoDJzrzIpmzSxs7V16W3SIF8p7/9EX9JcNrD/R+lwBQ6bRvsTGP9wSim2mm9GGDosz4xN5WUyQyJW6FEyj8fSdg58h4Ebrbq8OgF/i1vQsFxL5MNO9Vw98Lm7+YJVy+TZnhyPQScsmlK3LfsZspFhJ0BGze4VmoxgxeHSGW+T+OrYEcy/6JItCRmTJZZUiXUaUoVjrAXeb86fJy6HRsqZ/PELw9SmSUDsFVy88uTlq53eYbr1XXPPzhrlGBwgYyP9I4uLtsT1Xh7DShHVorDZ1mFG8AN3VDiu3Tm8tlkIt4NkJoEYjX+Md2JvLBFwByK6azMhDwbC68jSm99jvj2puPAO2k51GyRIFIja2nmOqOBiyWNgTUl+gE/HxZgqhvUq3GQd4XTHLl/Fjf9QPtldFgE4mAUXgGNU58tQZ/TAdKRma+DQLsJxUroaDVG5Z
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0f76f3-14ee-4b2c-e256-08dc39e6003b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 11:51:58.8873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m57tbZj6KpytFCJoS/m/nKAYcB3F2UItMIWjr5eDNMXwXAsZy2Uwmo/v8L6DgXjRD4U9oTFyscLc4cQSiCxRERsC8SJFZJ7NnE7Fq8QWl8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7411

On Feb 29, 2024 / 06:34, Christoph Hellwig wrote:
> The parted call can happen before the device is settled and thus fail.
> Currently this happens very rarely for me (about 1 in 500 runs), but
> a pending change to freeze the queues for updating the limits will make
> it much more likely to hit.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied, thanks!=
