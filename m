Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49E2566A
	for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 02:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741747004; cv=fail; b=dg+CfncgfAR4YVnfcBfrwU9nr9ZakrTez90ZhRriAvfUmJeHDkvEgSvfIG/7CE68mdHEjRGRjna2KAHxWH9eqq0+fe0NMnaR93e19wV3fg87v4svFX55sMywV3JC9Yae/cy2RplLnODHJ9z2EauYgy3p4flAmGUj0KAOZ9s4Xr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741747004; c=relaxed/simple;
	bh=EJyKkaqK0+S+5RGlU5JJqQRut3BMMIKD//1zf53iOeE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eiIMOnRVULsSH/In7aKlbJqPUOtAF6qJ1/O6Sl1QMvx8hpBt6n7Q/WSStdaL+h2H7A5gzdU1FPo5uDSD1ymJY6LqN5DeTQPhgGFvBMzViBV6Hth89cfGHnYB5BlliUv0rmVsFwQN/pcoBkgBFmMlmSxNVLFo+DtoEadtiGjSaqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=evTpklW+; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=QItmisEo; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="evTpklW+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QItmisEo"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741747002; x=1773283002;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EJyKkaqK0+S+5RGlU5JJqQRut3BMMIKD//1zf53iOeE=;
  b=evTpklW+WGgu3t66dJXJ11bdORQ9IQhRVftmtdJ0SdnmXKVN7UGJCU+c
   yVRXmGpY3MLkAu3rpsE/7ogdcWsUsjALEOV2dkpdtBWhyR5n0gzqjbjGm
   ipoEvAa52fO7VOAD+Yk23UvwoNEbDshpxBcQ8SCjGCdiIRVf9EfIqsNZo
   RLyh9xaawa23TW2R2VVNeYD0imOs/Ws+xkqHWFaYBB0r51mT27pWMlcxn
   VnPBNlvIt8OKUfHVfxFrik90qpVKNj1GP/WXAOkEh/aaU/AiISJCZoVyX
   XrYBOEAQkxaxFnMn3F2ZdVuVRr/yXAb/MqCNuQiZW7KIPbGB749aj4ePE
   w==;
X-CSE-ConnectionGUID: 57apZvAIRR+/ClnEZY1lCw==
X-CSE-MsgGUID: w/lN3hbVQ3miQpEZ/6TEyw==
X-IronPort-AV: E=Sophos;i="6.14,240,1736784000"; 
   d="scan'208";a="46717595"
Received: from mail-westcentralusazlp17011029.outbound.protection.outlook.com (HELO CY4PR02CU008.outbound.protection.outlook.com) ([40.93.6.29])
  by ob1.hgst.iphmx.com with ESMTP; 12 Mar 2025 10:36:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSnPUlrq3fzp9r+fK0lTwUbLE5QoVhlATyaMbLXbnzzC7exHhgq/4/O16LEj01qcBhTz/X0AhrowQEdsRQsn1AZKAfUfD1OTIWMwr40xwIUeQ6pUbVRHa8RUedUbvvBpEfdOxMK0I5ltfF+IzUTeZS9ybr0E8uHloyKz2s2gXwZfg6aeQ1fZCtqW3TagHnIAUw9VYo5USmcFyKQ2/mJQgziOojquwlQCWx9Vww1LCvq9l+RpWoHBkfaSfTe2ANbTdJeft8kcv0S8+IJ19syuDkIOigvjC0YUwdiK7CRxNUcTK82FYNl2TFs5Jle4SsnYnQW7+PvWlwZAMgrbG+FY6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5eMIdvwCsbp3mTqCbXc/MfqmVMXmlj52rMsXrzwXBI=;
 b=A+pmKZXq3hUwfoAP/Sc1lNXpEPfCnDSUad35QU83axI4NOBjXUxvE6gmeGrqeO0L6Lrc1eh3uDZvmd1wony/R+/jTdfrXcRAORd0IPTOu39x0Iz1B8UUPq09/hjMXm4//bWmQCk3kipGOiy+tFSimxxrnurJ29KuSyqZet8IeHzdDl23L0AXGfBNKVVYTUOFLP32x0fpIpaSjYa/C4dwGgH2kkss/O2Us5Z5IuBTrZ9LoDBRB6edLAKBhgeRilwH0+6poNEJBd9pHftjebDX3699cEvgwjhb957c53n+bfHQMi/L/SU8hsLhz2GUq3y7Rhbah7FlV3yQm8MZBXLPlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5eMIdvwCsbp3mTqCbXc/MfqmVMXmlj52rMsXrzwXBI=;
 b=QItmisEoJ/MR9NsgdK32Jp8hS1gWJP/A3oLdnKfExremxTyJTBKIWq1ndnmAs/3q5uU7t0JABQRD7CUeRIivj2hIJbpIagKFji2UoZqx/OwoZLVxsg+K66iw9FiaSJECZsKJoW3eUl9fs3jr7NWnUYphHwd3vp2kEHeWOgxhQr0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 LV3PR04MB9468.namprd04.prod.outlook.com (2603:10b6:408:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 02:36:32 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 02:36:30 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
CC: "ming.lei@redhat.com" <ming.lei@redhat.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "yukuai3@huawei.com" <yukuai3@huawei.com>,
	"yangerkun@huawei.com" <yangerkun@huawei.com>
Subject: Re: [PATCH RFC 1/2] tests/throtl: add a new test 007
Thread-Topic: [PATCH RFC 1/2] tests/throtl: add a new test 007
Thread-Index: AQHbjzgWst/0zddoHUagIOuSiMTwMbNu0KUA
Date: Wed, 12 Mar 2025 02:36:30 +0000
Message-ID: <qmajylrcxxcnp5b7o3lthx7mpwqzdhuqehpa3rb3p5q26ceorm@gjp3yrqu42ee>
References: <20250307080318.3860858-1-yukuai1@huaweicloud.com>
 <20250307080318.3860858-2-yukuai1@huaweicloud.com>
In-Reply-To: <20250307080318.3860858-2-yukuai1@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|LV3PR04MB9468:EE_
x-ms-office365-filtering-correlation-id: 81caada9-2f25-449b-1435-08dd610eb239
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?R4MAvDOLPdzP10dIDQ/oOwxXYf/r29uHQxAiJhE2hSO5KK7o++LKpxpEhN6x?=
 =?us-ascii?Q?Y6lQyrOxvg9gi8CsaAEjEffWHUo1XM+0DyflGVN6MT++a3fePOQTNqlbvHQX?=
 =?us-ascii?Q?B8RlVw//w16oUy16/mtI+xa6p5SrI1Z5FxqeaOF51ogs+5n3TmMiklYWup8q?=
 =?us-ascii?Q?e7E1rqCUCejQcCC22eQq9KJ+pyd7Zur6IHDtdgKqG34xJNuvpS+MMNkJbQSL?=
 =?us-ascii?Q?Y+zscn8MP10uCE5WSKP2FTM9MiKsIkyr4mFis/e5yIOaZhcnDjG/eRE9qo1+?=
 =?us-ascii?Q?8yxNOlxBldOOowvQmH3TGjPgQiCMyPthkEER4x+s1px/w+wdWRrsxW7K80X2?=
 =?us-ascii?Q?PsNaR9pgfIUEfmoThB0meQh+1J2sD3Ix8acj8Um7uo+Z1qeMf+f+7sY8GqUh?=
 =?us-ascii?Q?N2i6NE+NS9HAoyHn9PRZx3Qk89EKrarVZiIKyGJ5HecYFC8qKBddC9S3tL89?=
 =?us-ascii?Q?PlzmomZ2YfEDq2Ee5WNWsnV2rnKSqkxgGOiBNeDAvGcqvqo6TaxTTumFwONH?=
 =?us-ascii?Q?t+RJb71aQ5oCVGb0mqxO4HT85MTPZCbPiqIoj5C+HMsSoagDS87/4Yhc5Psk?=
 =?us-ascii?Q?qogNLSsL+pBjDPPWUO2lYO7ouJ3dwh0LgurHf0szAM09xkU5nVt5cVJnqphq?=
 =?us-ascii?Q?wyurcOivg7muqSFCYxbBfP2kkog4tz1vJmA+pPXB3YQdYGZ/s8W0isznJzvE?=
 =?us-ascii?Q?Sb81eEh3lHrZ9eUpb1c18J3DzdwczCjNtSs48HHAsolKbzrtTTjfURkWZuWi?=
 =?us-ascii?Q?UYjCBEsQsExrROm8hiACm03C1feNAdnhrUwiz19FpvkddpkG2uKKK5WfQEb+?=
 =?us-ascii?Q?G8JY9bErygMjCGTqdvhFSjFYGbBHPpNxvqlOLgLkuAH6Rg9AVErURNsx2JBm?=
 =?us-ascii?Q?NKBpEdY/kXXbaybuOvqE98xNr4UnDjvM0Phmbb3fxRxEc+rQStpLlCKptWbA?=
 =?us-ascii?Q?emtWVld5V0ds+fn8DNh1keY5TkzrqeKdoepwA8eYq8v9RWrmRSOL8jsL670c?=
 =?us-ascii?Q?Rtr4b2S9RG19KkNQ+y0bMl1gIrLNe9yRmo8Hdzm+7LkN5ujwlnjxU8LqKybj?=
 =?us-ascii?Q?IFlrdOrqPzhhcFbo7D+sOKRd1+cVE8Uy0o96ZbF0NJHWQq2cb/DO3A2KiUfG?=
 =?us-ascii?Q?GEop5urM0e7+N6gOr8JOED0PVn7ArwzK++iTmst7ynrGOUyBxjUYUuSL7vmh?=
 =?us-ascii?Q?yr7JzvAz8Hsjd6TPjViUggJdrmABHGyJfO/+YW4dH635q3JSWkCXN3gZeyU3?=
 =?us-ascii?Q?kDjjmkgky1iz6eGawKjqdHkGttAJFYeHpJ9DG1hAV/6OAdRdjagZwPLAOeyF?=
 =?us-ascii?Q?4mp9bArHLtt306zno24qgRylgmKIB1J+oKCS9ButgEHCPX54wHIv6pRarwIr?=
 =?us-ascii?Q?Guw9qpt9ZEQYS5zc5RRajOERVpwVF2z26F/Mb2jAXgwvxFcku9lvL0sgwO3l?=
 =?us-ascii?Q?OEy/U1PGiTswSy4qjPo9YrFjPWozCW9n?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rGfjYKDymSYbcm3A32UhpvD0mNMWwYwfZ/B1YytbiraHq0nzWGTUf/oHWf97?=
 =?us-ascii?Q?7xIwXFRU8pkcslj7qhviZRQv33LCSau/JstRQPRHWSCcu5Mia35HrCr2IAP0?=
 =?us-ascii?Q?b9OVIaIgHrBjP2+H0gvGFxhBNLC05s3bxak+MzHKmVyFqkw58rd+aMBX1kXN?=
 =?us-ascii?Q?qu3MmGFj7PH4Qy8EoL+MeWMDvvIT7pElCXg+SeUvlNZqs+7/zxhKkrmWTdqI?=
 =?us-ascii?Q?J1Ibuk2O4pph8zB8hRgYMVE3JX8C5wBthTB7bdYGWxwei29TcRGTOcT3sqp7?=
 =?us-ascii?Q?mNA7M2Jo336BGcpF6x36jfyu9fN3eUGkZCK2n5Va2yHr+wBW9R7FsHVO4ddS?=
 =?us-ascii?Q?xIXPx/Kvg1QJc4kwBq0nyckxmPq7GJk1wdQbZm2kFbkYK8mU8SXTLbMS7Faw?=
 =?us-ascii?Q?nyuVJKMTbh8hS7Uy+fvg09DkswibOf6lK4t8NVRGvamwQCBcUZks10taNzIV?=
 =?us-ascii?Q?SSf0eZ9LUtCXIcnFf7/d+sWgf+iQQiTlbh2qqqHkvp5xZ366F69UDcrca3V7?=
 =?us-ascii?Q?1Y09smaTPnFsh3cenkogV0xxjyWNIa3m8GTv8yKCO0CRvTdkNxCe36pXTcmq?=
 =?us-ascii?Q?EbmuxTcwDBERnmFl1FUAEi6sJI+7l4PDgwkL0NBVm+8QlrH/LtGBr4CqRfA0?=
 =?us-ascii?Q?jHsT+2tjapS+bLvrEXtmoNdFrdH9yiVYo39QTdNWZ/FeKfuPqe/O0j9LCC/e?=
 =?us-ascii?Q?qQGFvJQieYVpLQc/+2LMXTJbFVk2MBvEZyed6DjyBSzvwBxNURqswBZYWvo6?=
 =?us-ascii?Q?gup2/oTkWdO9dHa6H80fhpG9BOGmwtuCs3g25GWOWXahkpMpBY5yUGAaN8k4?=
 =?us-ascii?Q?fVlzawKGn/NyWt3gr+SGFTN+IIcd+N/SIXmwxFSKP9yhp+lwKso+PvatwlmK?=
 =?us-ascii?Q?8SeB6pLeZBTdvv/EvkQdVfM/py21fPw/OhaUfLwdus8qu1+ZPU/x1mkfhIRE?=
 =?us-ascii?Q?6/2uKUUIe7F6jOGILCPZwZcrom0EXqIXIgwRnt99Pxjav7HrnSWuGqV9DaA6?=
 =?us-ascii?Q?NX8aT1Ty/VN9xnFj2LMo/6+dDNZsEU3JVLaBDKaB1FMEWIYdE0X7b2O4as9r?=
 =?us-ascii?Q?VNmA9jMaUiAIMdWu3ZHAG6oJ5Zd2b/VbTsSEkJRq8pqS9rKtN+RDfqXreEfK?=
 =?us-ascii?Q?cxdMAXvPrh9Ush3G4nydU8zAv1NjKRSf/tO4EMrshX8/P1D1Q8K9s+nmp0WA?=
 =?us-ascii?Q?M6tz5gjC8qbgSyqHEEgTY58i3FWUAOKhU4byyNnrOvcZrN61rM/LJD2W83vk?=
 =?us-ascii?Q?kziySKViU2+xUJfbHid0li537tWgsIOwNTqclnrwPzyKVB2KJPIdu/kAwZl+?=
 =?us-ascii?Q?KhtJaNyqkYP15P9oXIV+3hN6wSI7Ou9fFL2LshJa/ui52gN4Z76PUw8tNAsa?=
 =?us-ascii?Q?dvwrOP9d9gwCdfvh2nHAreM8mWtG/ovG8gqrbUgZsQE+0XBFwmeVH20jmurd?=
 =?us-ascii?Q?vlIB5rKBdt1YnDGOjMmR+ry4aeDTvtiOBgumRad8KA/0sRmteg7hDR+Sq1p1?=
 =?us-ascii?Q?zCRnAKYvItcSqU1zLqDp/crd1eXn0E+yo4ne0XmYCBdfmzq8YSDiOuDWSnDd?=
 =?us-ascii?Q?GrZ7EUuYzAWtNG5OY3vIVJ+XVpMB7SXkIEdDCf7RDkphP/qe8vu01F6OYyrE?=
 =?us-ascii?Q?Fg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D7723B2F968D534FA5D5FCEAE9F52D06@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+g1qPcnr4X2g+fRRWUPxYDpiUSuIRbc/5g7rDyGkbKO6SSizOtOTm6NF14fUQnAF8rw9Y1LA+Iz8Y3T947pflzF0OmIC+AwoPoKm+oVuqN/7/FdiIdLzuEJ+fh8R2aTggc/iot+UcqNKYkvFk7T8CP9kxwggC1wrxriY4H8VDxnpB8bZLpwCA9JpKJSiLVp83xY1kZF1ZVhlkBS8GUlK8WQNIhJwIgn9LBOBRxYJKml0qaXs7o4aK2Iyb+MsDvqzdrPAKiYgEVh5UBEySjiyyYW2FNDulmyZ1hsWHIuVqT9A1P4BOuOZ49vqzLjeENOfG0e283A6mRsiFNh+/TsKQuycjwxPDo2qyGDVPopOoCiq5CWxcuZSP1AQXa9zdc0jZf2gC+XMveSmaQPHF8wkgY6YbsiFpcwLtMqoL5fmkT98mDZsB35RRDx818iCTs9JZolZhUX5ZH++3luIan4TC/oODRem/TuZosi8279LxrfgqHuzIdDUMd4pYMGMj4PLDy4+6wrchjoqsnxQfwkkhnplrPEb0ZIC8wIDgKG86k4kM9eKIKdMFaCXPbEHw+mexW1B9Je/zGL0JDBKUVBt3HMn+qp7B4fUzYe9qKnxu3JzDHMRf9gaQQxE8t5zojrj
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81caada9-2f25-449b-1435-08dd610eb239
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 02:36:30.3378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Byx3tmNlWsnG3gGIZtZyAcpdWIy2TuvIxkUUkDbTCcXuIjnLcxL8GxtPX26Sxx8OYBZjmefAL4DhYX90myk6sugB4RX2tIp69Ggv8Q6ZnqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB9468

On Mar 07, 2025 / 16:03, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
>=20
> Add test for IO merge over iops limit.
>=20
> Noted this test will fail for now, kernel solution is in development.

Thanks Yu. I will add nit comments below. I will do review again and trial =
runs
when the kernel solution gets available.

>=20
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  tests/throtl/007     | 65 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/throtl/007.out |  4 +++
>  2 files changed, 69 insertions(+)
>  create mode 100755 tests/throtl/007
>  create mode 100644 tests/throtl/007.out
>=20
> diff --git a/tests/throtl/007 b/tests/throtl/007
> new file mode 100755
> index 0000000..597f879
> --- /dev/null
> +++ b/tests/throtl/007
> @@ -0,0 +1,65 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2025 Yu Kuai
> +#
> +# Test iops limit over io merge
> +
> +. tests/throtl/rc
> +
> +DESCRIPTION=3D"basic functionality"

I expect this will be updated

> +QUICK=3D1
> +
> +requires() {
> +	_have_program taskset

This line is not necessary. taskset is included in util-linux, which the "c=
heck"
script confirms avialability.

> +	_have_program fio

I recommend _have_fio instead.

> +}
> +
> +# every 16 0.5k IO will merge into one 8k IO, ideally runtime is 1s,
> +# however it's about 1.3s in practice
> +__fio() {

I guess you will think about better name of this function here. "run_fio" o=
r
something?  It's the better to not have underscore prefix.=
