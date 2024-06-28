Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8FF1581E1
	for <linux-block@vger.kernel.org>; Fri, 28 Jun 2024 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719569454; cv=fail; b=jHBPpSjZlwahyb7du7Cz5rX0lonQ+enbPbaSOjw+s4M17kgXQIRYSQgbGr03bBEPMeB4C4VSZeHydqsMyomKL4r9Ha+hGf9jZ37WSBu09YrsbSvpIBYtNk6+qkXTT1Ac9NNBp8B2ouF/CnwpeX9mnvKeC3H9xF84oNwUkUvTX04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719569454; c=relaxed/simple;
	bh=s9zIvAvQc4UBwKmCKh6cwsNmur0E5R4/8rJI3AKIm0w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kcfi5SledzLZTegpXt0W6IlsKFjc2Bwpy0tGDOTlS9s5nBw/ZrlBBNt4oqvFEsQ8rKHoTaMvkDLtI6KLoYibudkR0nAsLnDF8DTD48cB3UoIVMShnwe1uY1LJ95phWMkAepymcS7Geyn2erl7CgTEWbQjccGYrltyLeq5lm0KmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mxdpmpNh; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=wSMR1wvK; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mxdpmpNh";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wSMR1wvK"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1719569452; x=1751105452;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=s9zIvAvQc4UBwKmCKh6cwsNmur0E5R4/8rJI3AKIm0w=;
  b=mxdpmpNhXS9DlXdFvr7jT0YD2zNE4VVTQH5ZP/Yg4k0GRTLx6wjakCHb
   jWLd5xXEPiR0mBBXnU43veaqJL0myXX7YAy6qEc4LOzRuhB0dMInxLwFj
   8PaoDMDsaUjukL3iG59+jg6vtW/m6GO+hylNkoiarB8PG9ZppjI/g8f6z
   /hVwNJlw5ipKd0PCkzDEWjondeqj9YDa71FKlhEu8BHSny8ZHNOUbQMGf
   /cvCq7w7pLUhtm5ZvP94X75j99vW77TwZ3nuCgRx2tkRpeQs6/0UFoAn3
   xd+lG9Z8DKCrz+vHi4fD1S+Rif9YRRG8NQXlpjXjdQqH3fjFQUH5VvV5G
   g==;
X-CSE-ConnectionGUID: 5mnZAOyZRZS5q73HL9u+pg==
X-CSE-MsgGUID: g2YYXVOTTRm81135y6zFpQ==
X-IronPort-AV: E=Sophos;i="6.09,168,1716220800"; 
   d="scan'208";a="20246936"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2024 18:10:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKFylcoJRJSBWmsTcfZs25jWAo9ZuwpN3OeAAKJbuNiCNDLF40vUUZlVyrkDJ+j22GT5fvOycJvC+65Xnl8V4i55MahEMGr175P/xKGGqhvVm6N1tkjS36ycnAuYzdrOAlIa5AZKTeV306HYifS9wOlFGU1aBes5fKqfPijKYjD0zdAMzpmI7MwaqmM7ds6HPa7yKz6Cswppwxq9ZW5YJW+iRdzJqnFOkgJSjEWoQ4glHN6SNSpaeEo8M/f7dkKxrwhmlamlk208MvNh2pb0jLXdjw6y3Kxze85NkNiQlhlogboQFS+ziWiKTiDzbelR2dNDXdU2Y8/4E8GYXerBnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9zIvAvQc4UBwKmCKh6cwsNmur0E5R4/8rJI3AKIm0w=;
 b=ZD62x6F+1jvAihJe97QRT121coIY5haBGTIC4rwpONbvtCU7HEi464JVrHMS/UnQMtb7Q6fGr/rJal0KATeiv/PUJtPuwyRtolAjAOTW1ZzXJbMwjcNRCoSGmybpG1SWsLyzKB7F9bzl34wVOVMv/LCKe/fBQwjTif3/CoAIrG+cjBpqo59PfL5Tvewm5jdJcY8PqtSE79eq9S17TT0lOxsJKmWTz9eUNqNGhCPeLL9uNAP5nG06VKlbcZOf7KD7q0wuOeEUeXmNvJ1lFifmixpxoFNJUZuKoGdM7GBoeyUdi8pCkrVToBP95MefVYRYBegYRGwkdJsysZ7HFXxVTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9zIvAvQc4UBwKmCKh6cwsNmur0E5R4/8rJI3AKIm0w=;
 b=wSMR1wvK5lTp+K/rnEdK3yeclC7yks6Ubzcpw8o/5qsdwJWGeEbnDwVs3UrZ/dyGgCqSFaoPb3NYCKkzAcpp/G52GHPj77tlox1u6GBprc1JZCjlTlIuEwstoVECFBl94UIKP24j1eUmFJGJJDyX17fxgX1soeKo4gIxshrv8OE=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7565.namprd04.prod.outlook.com (2603:10b6:a03:326::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Fri, 28 Jun
 2024 10:10:45 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 10:10:45 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Bryan Gurney <bgurney@redhat.com>, hch <hch@lst.de>
Subject: Re: [PATCH blktests] dm/002: do not assume 512 byte block size
Thread-Topic: [PATCH blktests] dm/002: do not assume 512 byte block size
Thread-Index: AQHaxqqgaE/eGVoAw0qyRPlw8gooObHc+YgA
Date: Fri, 28 Jun 2024 10:10:45 +0000
Message-ID: <cpxabybm766epviclvx4wezrzupyi3mwdcjhhsv6rq3xk2mnkr@cm276kkyhvfo>
References: <20240625025143.405254-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240625025143.405254-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7565:EE_
x-ms-office365-filtering-correlation-id: ae0da071-5f92-4862-cf3b-08dc975a9341
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CTu0g7fJ4WTdvNGzXYIRy8ZZAy3Kgylm1OXrIVtUq8agZCsjhyM2UvquojMl?=
 =?us-ascii?Q?GkcFJtJluLRCaG916h2WK8eUwF9kND8IRUGb7LZxGTWwJvbL2lAUps6PVUp9?=
 =?us-ascii?Q?vRqMfaVegu1f43wRqCmPY1eisxwF0D06vR8+TYS3FXzDWzZtbKEwDMyysC7a?=
 =?us-ascii?Q?SgysNyWKN5IHeOtKAfsj0SAGgbruPLzGmtGN/0yAx7oaiE3Igm3id8z3kYyo?=
 =?us-ascii?Q?tocZtGgBfnDPNR0PImdImARTnOyYGzwWkYyKXKEpYr43pmyAzFUqsAoC5KYm?=
 =?us-ascii?Q?/QFVpSsgR3/SY/5sUQLmG1INftEGHDQGQhFkMlIcHmmygVmEjUn0AFv4k2NL?=
 =?us-ascii?Q?Dh7qwTX9Vz8aikmF6IyhIWb8bclW/dASrflNq0goBCYVoJ3WQs44brykPrN/?=
 =?us-ascii?Q?YVAzASiCPPVug8AIgR0bOKdmtk0H11Qnx1i7vk1EcKnW547hW/MCXEwtnxr8?=
 =?us-ascii?Q?TGJx4eSIVrAtxUL9725Ikv3ca94GZzuKXqOe3LAlU0IhsUUmej5fyCDfDJPV?=
 =?us-ascii?Q?6APuV0CLuxnVHAiN2m1NJaVMUF/bs/CCOxFog+IRaS/LpRZw9mwC1N+9Db3z?=
 =?us-ascii?Q?leaCJmzdchL3pw8lSjg70IYuNkVLiwoL2wtLORzQnHYeUxXKZwMuZy2t5SDH?=
 =?us-ascii?Q?/vBeDgUuWwQm8sJv2ttYrOVupvJ8/rMKA1f7M5BoLCur0ojObiKqBum7QZI4?=
 =?us-ascii?Q?w+hA8cE7IKnye2AWQ37WotJwxgJ3vDDhxbU1gzGVTPbdvQw2GexQ2lt6t9zK?=
 =?us-ascii?Q?KJoKB0vYPidba7LnuR/hIHCXsY9kc1NWYsGGVBK+BIzhvUXpKNiePf6rcepn?=
 =?us-ascii?Q?ug4hzRR/4mV41qlIJgExYbjPUteeUQ3F+CUKSIqEUkn6FM4PrntTnchrrv3Y?=
 =?us-ascii?Q?Tt1vvhqH5EhaRqhP1imz9NGpHN8TVm3ELC4FuOcSRRIBBWkpWl7178ahjA8l?=
 =?us-ascii?Q?rKYl7E/nn0Wid1KT3Ffl63k3ShLJ7gIS5QKwKga5cn+oLlEMefuBxpHFDy/b?=
 =?us-ascii?Q?dzWgrPib3B6mIn6viAzjJ39z61pbzZxbWxPa6KbGGbwZvu+QozQipb4OUbT0?=
 =?us-ascii?Q?1PvGubhFp50qFeqQvPn6fgnR0eXBkHVkOsR+TN9UOmZG/PNs+GwdH5Flxcc5?=
 =?us-ascii?Q?WomUFFytX0CbCmJibOtlOypzgwDy/DDChwPrSKxeUNCOZ8MnfrUZjH9hXHS+?=
 =?us-ascii?Q?fmi2wMkz4lo8i2t8BO0pI/UIAWfJqFbdAudrE/ICKdmNGtgm0bqtXvZimTBK?=
 =?us-ascii?Q?JpLJOCraOYKCQXZ8A2DvFPo5WCHHb+6UYhY7MzaLMdaxM6imALJMoXf9J1Kd?=
 =?us-ascii?Q?ntArnPziJ6u/2c7bMSIeJponJg7zvESJOSlSAMDXAmWY6jlFkx1VS3NDaHT7?=
 =?us-ascii?Q?wzugqrM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cA9XDPQguVPA+/VKFQJQt63iB4tSTqDIWENVgrl2MKGtZfa3vyLi1U4v77XI?=
 =?us-ascii?Q?iwIQHeer6xDRNB4BbWWC8oBLNY7kKj1vd6VtRmWxzEhJ/eSeQKBMVXXQXz9n?=
 =?us-ascii?Q?/FB5gXvUxupEzVcrsmJJIAayeAeo+hz70LRIxjxDr3bGkgJDN1ayTlTZCRrI?=
 =?us-ascii?Q?Ol2Oc+l7nSXbOIQ8K6MbxedfSwfbttkoCSUzhvB9BhTHtGqy1hkQMhZnlv4P?=
 =?us-ascii?Q?ko426bCNXc4n7kSYiRRtepuGpgBrcvik6qCFpJzm251MpbfNN0wmRDjURc/H?=
 =?us-ascii?Q?LTcazq5NVtOmly4fUwa+znVD0546UTJl0bRdoi2HWu8ERjnA/5cBdDpb/Pff?=
 =?us-ascii?Q?nRp2ritXcreLU3h5rb/rcoPWtvBO2+N6VnqoZo5VN/FlKmLIifDs6PFqb0b5?=
 =?us-ascii?Q?e+3E6+i52X1f4DrR6uD2OH88IBuSf73pQwrmcAF0nzs1qFNfonIGhpW7u6H6?=
 =?us-ascii?Q?olSvR/gR2v8CbHoOXWwlB9ZSDLrJGtOl6qPLhxqCrQ+1lcgq77fZ4DPPErK/?=
 =?us-ascii?Q?sA69EZGlNz8hPIfkSTys+W0b6Ei4aW4/yQFXKTPfK3WxcnrxeibuMjddR1rw?=
 =?us-ascii?Q?oea+S6zxe6UGyOQpKYwjmdjg/XLw6pI3JNx2bKpWDUPjb1NImVOkC2irgKtL?=
 =?us-ascii?Q?K0Nx6PQPlfbguLxSFjzxEbaMdhxeEmMpCr89JxTmqBlOttfEt8TGGNkQk5BH?=
 =?us-ascii?Q?wzE/DZ3wSZlN2PpoABL4xdKDHGYie11YJ5qJIvZLJMmePIR6U1yA41NGh6KF?=
 =?us-ascii?Q?DMMcCR+x2rg0/KcEQmjJ2NntIz1FEa5Wgtse1aoU+YHtYWCcjZ22ATFS00wb?=
 =?us-ascii?Q?G8wjW+bwUyqycFS5jF9eXf+el4KFbeXuwu/c8vbx4NBToWsjZtELupEyIcOc?=
 =?us-ascii?Q?O3x9hkeQz1L0rxBCJAl8s1/qkej/7yFxFtRrvRXy5aW7LYYXDdz6Ytmhrn+y?=
 =?us-ascii?Q?/R9GQgIevoCjyjKsvAseyaaAF/PN3vmne9pBh3RdQDMM3VB29jkbV5ayZufc?=
 =?us-ascii?Q?oEM7HYGM01O6MpJdIIfGMbhNrZUb62Ffh9dDl4oP1mW5SQuL/mwPsVB90liK?=
 =?us-ascii?Q?pnr7ht/5nSNea0WI2RIesrdIE2Y/qspekjVW50BXZsCIuv7sjprdKdZy9o7/?=
 =?us-ascii?Q?IDopt0FlVD19I+mQwW1g22T9Miw4bWm9rswkWcQ6bDSIxUOZ2qZWUYo+7iBM?=
 =?us-ascii?Q?2nG/lRH0G9mgXogUUUblJ6vloO3hsByKq1H62xmkcEpLRSwRyWtykqVCNJmb?=
 =?us-ascii?Q?9PNKT8ieIEd8N5m3Bh9hkuIIQclDQKYUNtyJk7t+ZVNSGUSwXi7LhT3VJG96?=
 =?us-ascii?Q?rAwhmuE4tXXp6bb0ISEJPYp+92qurg1jU3hgSkVOgxhkReYyTuOArhYl3me3?=
 =?us-ascii?Q?9FCasvt5u6iwTpRVHQUbDVGzhr/93w1MLKwukRDzVZWbREY2Q0ZXUQHmkFok?=
 =?us-ascii?Q?M0tNHLeDJNDD5FYgvKvlmrGHiXqpiD5V9871pkFBft0TYIsgZoNvGwA/wAZE?=
 =?us-ascii?Q?zrXugkkWERNBuHIDlTy7ySW9LUs6Z96b5CSUuIn2QSJPmRP4pbyn3+N9EnrJ?=
 =?us-ascii?Q?oGpF4zQzDOtKJP8sxY7FvNSQMDwLbVC8GmvYKrqABMWD80Iui8VK1lhs6GOm?=
 =?us-ascii?Q?bqPwNqdDnPYN3M291oIZ6As=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <240BDC9DF33BE1448F090510079C4C23@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/0ttNenyqMsN9ZbEnc7j+RyBben6lbIUw9k6geaMqydCBE4RrXD6ZpW4+zzHOvLcnv6jtzRm7XHiQFJuY/P07JkoB6eEJBj4/tKy39C95UfR9IlRl3JUbU+PiNHfXeBHZUM8NrttTwOVdnXrCWWmTnldxGhfLmyoTEVhNuFLsKOkxuAT5PFAI+PGrunplw/8lEn0fWeWa/dS+wGN+j5S/ivqFeQJ5nMfM4izH+KiQfPanBeQY1FKrNbAluwk18p3TEu+08Wdbc4lN7I9jMppDUs3C0MEFyJr6SS0VTXXnBHOIibfYETOHexlp9+0JqOpRVk05k0mSuzU49ZlgXvxKeZl6U99eOsIwdgmI2+5+bfw8zx4PqmIItAtxv0zJHb6+OXbH0Z4La6nexbeWUHPd1YCb2sc5Zw0qbPuXsBMqQQEWqyEq/EAq0WN2iAAE5cbYKOSqYD+9S20dw66hVpfbzmguuws58VXUNzGoOMivw+AVzOhltbLIYUxCDMm95s8GcHYD04O+bPhu3+IjvP4gOEz4rLfzZLEiPX6SAsbDH88avdQHQL7Qxmu/bd3Ga8UWV6Ht3tv2t/E4Wr9i9lDPPivJlsMDU8jtzFtaTg7pPWvQj0vCVtPfTNgkoEBcJ70
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0da071-5f92-4862-cf3b-08dc975a9341
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 10:10:45.2672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: niS6UOFY/UZsi4imKXJux2Vq7D8n7SCZKsNTs1jm/kMW0fndyA0QwCc2CCQ4YHl3SnWgIDUPBL+hR1AEn8QaIz0kvf/H3GFg/tJNJ6si89c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7565

On Jun 25, 2024 / 11:51, Shin'ichiro Kawasaki wrote:
> The test case assumes that TEST_DEV would have 512 byte block size
> always. However, TEST_DEV may have non 512 byte, 4k block size. In that
> case, the test case fails with I/O errors.
>=20
> To avoid the errors, refer to the block size of TEST_DEV. Also record
> dd command output to the FULL file to help debug work in the future.
>=20
> Reported-by: Christoph Hellwig <hch@lst.de>
> Fixes: 7308e11c595a ("tests/dm: add dm-dust general functionality test")
> Link: https://lore.kernel.org/linux-block/ZmqrzUyLcUORPdOe@infradead.org/
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

FYI, this fix has got applied.=
