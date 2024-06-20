Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38792582
	for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 07:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718868932; cv=fail; b=T9hxECB8MTX77D6lFd3efMP14dqcUaO+6Hh9rhMvmSRZz/W0s37BxByCSX6AafalkrEoMef6P/LvihI5CxH93q3RtwkKbumRlREpN2Rtgw0PC9PvwlAUlgiKbY5kzm1UulAbo+euPyo1IX91T1YdubnZHMj0PDHQsaV2yMPUgjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718868932; c=relaxed/simple;
	bh=sVLxIH28qlOQs/AAJaMGIrmCCVcCuyM1vQqw9Plqem0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UwjG9MHhmSW3GIVB83FHuLU3mP1xdnpkVvSAX1hWCYj1hPo/q70c9RRwHugy4FuypjlO5eFyXDlbUFDO7Xm//AlBFSSEjHtwc48zx9oI3roP6lqS4I0sGHQOXDkqHovTo9r7Nvo9sjZXjxiLoLWGvYOZoI5nAWl7Q4jNguK/u7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=R0hvuLxY; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=GUXIY2Cj; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R0hvuLxY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GUXIY2Cj"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718868930; x=1750404930;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sVLxIH28qlOQs/AAJaMGIrmCCVcCuyM1vQqw9Plqem0=;
  b=R0hvuLxY3B5yUit0T2lEZ+xtAyank61FqhZXiYuGL/SYpv8bWEr9Gyvp
   aUWxkyH1JyqjKYTttz/mVdgp9zp5/ob/Spb6rzkBfOWrWRuOEbHjfxvXf
   61buCln0D5GqwfjCtVg9QPWBzq8ZdbMuXDNFKkiheEgOtFBKaTW7BD87z
   NPy5ztRcCZmpCgqXTa/wWXGA3SaRthhdpspyzoureAuaa+zUX7q84Hye2
   ktYVrzDcqqhd317nHKgcbnN98HeYlkip/g8yIWbNeD2Xg7g1vy9VPtQ0F
   YXQC53PECEUR4mDjPktaPZTWVHicnHPaRnEv8HZOPDN4ddjcNLMymGgXy
   g==;
X-CSE-ConnectionGUID: 5zq8d8LhQ+m9gpu3TVha0w==
X-CSE-MsgGUID: M40s6JSFRPWMjgHtlpwfGQ==
X-IronPort-AV: E=Sophos;i="6.08,251,1712592000"; 
   d="scan'208";a="19919948"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2024 15:35:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXhFhwd2HDcbBgsHVVX559ydZKCI9Kzn8YAspd248i34VHqRia98FQyrimbKY3LugKnG8bNFqVCwALxmtAiU7h840T9GwWr8R5u60fJF5hUBvwtESmRZtViWOVWG6oBUJrXQ9Vwmsw5Di+Bz8BqHAUiHfY4Mmi7esJknRmsywa0ZAxoIZYAYF8Phfsi2reijVqZhklBaBQCA/Z+i/phqfJ+RvHukgHUeIO9vGzsbMljfSUQA871BnVz+vpNPgtFuHl8srC+J/KlmIosWseBCH7fGEoAEFz1SpUR7ebeYqkemPmt+1d5D9z15hHXie+ZGTRxm+hbPimYDUTCW2yrecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgQewMZmnB6fmw3ywwtCNrFmZsexBTj1g5KpywjCRmw=;
 b=frfU0n15B+iDNr2OFFZK22wHoMh98dreROMaGIdvr0laFYoQcjDD+3rQ+rJdZLYPTyOgcugbTKc3dAuiVyHkMqh3KWXgYwYCBBu+5a84lieu1wbABYE64WO6mpkoCfU7bGwhFeUzPlFTJAa6EbJVVk0oVyW8NozypIznnTyzC+MR3evx/OrLJi6oHJYgo4KjBoKvTz8zVgoZPpwn9uaW7LnIwXQtQ0ElSgZ58DrpIi/WERQlSr6eCiN9G3YdYb3aSwdR3JIs2DzwwOJZrM62fbUCnIJxrSYH4P1EY7MwmL7T3I1ygQAqwLWIgHR8P6PNxlNSU3b6lsnwS74qU+q8Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgQewMZmnB6fmw3ywwtCNrFmZsexBTj1g5KpywjCRmw=;
 b=GUXIY2CjX/eCTmX7nLSqc7iX/Hk6cgfmiCipZplay2lev1VEnI8o9MvDfZnB92afLlZzCfnfvWLGECc+OiymALxAlMoB2SBPVwhiYXTal5DiwjVv317k+ue8lXOwJVzVw6MRXGCaDH68wPNoQXR7wxF5TOmDrStr3bTl5d1GiKo=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB7009.namprd04.prod.outlook.com (2603:10b6:a03:226::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.19; Thu, 20 Jun 2024 07:35:22 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7677.030; Thu, 20 Jun 2024
 07:35:22 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Cyril Hrubis <chrubis@suse.cz>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"hch@infradead.org" <hch@infradead.org>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
Subject: Re: [PATCH v2] loop: Add regression test for unsupported backing file
 fallocate
Thread-Topic: [PATCH v2] loop: Add regression test for unsupported backing
 file fallocate
Thread-Index: AQHawK4ILpTaV5hHhkmxks1szQ4EULHQR3OA
Date: Thu, 20 Jun 2024 07:35:22 +0000
Message-ID: <rpr4g5wgntrp2fcux4dpyfoqdvzi7mcvgwl6rrkxpvdkeanmg7@bu2vdyj4imvf>
References: <20240617120018.13832-1-chrubis@suse.cz>
In-Reply-To: <20240617120018.13832-1-chrubis@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB7009:EE_
x-ms-office365-filtering-correlation-id: 34986413-bbcf-42cc-7032-08dc90fb8b05
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ggXtAlgysfSLH4stKK2+HTydZ0h64R+Un6lyCIAhWdeqUgFG3bvV2db/R9rt?=
 =?us-ascii?Q?tp9UcthqliYs1oly3aC0Jwv85IIL4w48D/UgcV7F/5BmZva3NcrhPE5xh+B7?=
 =?us-ascii?Q?VdUAGICVbrGBaE7PyZdQ35DS2mhAvVYzpNSoIPBp7v9WC20wytzsYecetlbm?=
 =?us-ascii?Q?unrOc7gn91pPGfiktPTFXDz3HVi1BXGNoEL3FkY0ZZh26z/6RRljIFjN00e4?=
 =?us-ascii?Q?vwPeBeDy8OXbLhAUXCQXBw+ljqZZ5JsNBU0kJ94Kq4cTPJwuKDdfksIN/jz2?=
 =?us-ascii?Q?iYgt03I36aDLWnd63Fdp/I57UqAlcT/Ay9dFY9qsCio75rk/gbA7X9N2fQKX?=
 =?us-ascii?Q?UL5NKKRerXNRT7/9jp9KnE5XQt+Lfqrlqq0juk+Euz0QZtEMscgLUJm23C1L?=
 =?us-ascii?Q?WLxHWUKOJ4Dg3FTOcO7cMksC8ZuJZt0s9pWV9kXgCAwbuxkEl4yYM8RduNpx?=
 =?us-ascii?Q?PvKtfwgZl8qx9dNvLuby6sN5JJL3oz7oiRr2qgaVj7g4cjxe1s3ODpbuA4cB?=
 =?us-ascii?Q?UY1RR7mnR2sb1BR84YGtXXXZb/6gQtUiL3yqZi4y7yRe5c0ISiTcsaY12PrS?=
 =?us-ascii?Q?vfz0X1QabKIiVCBY1piyJmJKutSCa/Iw6hntlN+ZL/6I3F7KmTm0JdUOcjaM?=
 =?us-ascii?Q?d80QwwJcfSmDzgz+R5BnzczvKgn+lQTfJb4DpBlSnyyprglHsTPcZsTrvjAC?=
 =?us-ascii?Q?Gf3YhsNLSB1a0PnOvyeIOo3oKWyHE+n3B1TOIP9/LSYLOwPrU2VjQCIxtVeY?=
 =?us-ascii?Q?/YctANzfucvlgJ3yqfQwYNmuIYlHwKMaGVPH2vVoUIU/AEmUnE8rphgHkxOR?=
 =?us-ascii?Q?a53c3f6QT6Ej1bXUCH0uxC8tdoKlensWkgn7a+DaLYqhB/lLC1Zu/I5OQAIT?=
 =?us-ascii?Q?odvcmV5BsrDC3EUtmlUKXtoeXbYTT/x/w8QIIp6zEoeLgYV6mfjpzCWkRMWL?=
 =?us-ascii?Q?c/s8HbHm6L7yHA3O0N6QlgeW0Og/+gDHMH7kAiulWNieAZAxKFST9iE+uCvH?=
 =?us-ascii?Q?Iq2iHIq7PHwjNAvpZ1AOGg3TYX77ppa+ZPm8+Zc1XEFygm98PUC07/s2c9YW?=
 =?us-ascii?Q?FlIvEuGstuLFelWpcYqZL/eE9gd9ZUvTFiN9ty1hqw4tt6oCDQCLfPoiPigT?=
 =?us-ascii?Q?zX6R6a8KLKpi9opPiOfyB+o0YO6+RvTwg9ETlyAkvQeGlmqw6Z/wm3Egsy3d?=
 =?us-ascii?Q?4HNzV5c1Vr7HWT+KkMK17QGY4sdtvTVtsRdjWGBCz6qSrMtH+CGzazMl/MyR?=
 =?us-ascii?Q?Q8EpXj+205Yk1iDvtNsROreaWEWrjAEZy2rPNBvViRu5NDf6nv2gnNO0fqH7?=
 =?us-ascii?Q?b/p676CgxrubE9P5ymUy+dFz2o8syDOdaztCafNiqIyz+gwVyZpTWLzuwlSs?=
 =?us-ascii?Q?bGqxM7g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UdIB1p0ZWynGdjAy2Kstmg+Rhu39Dds0cv3M8o4GOLFe51J2FqLkJQLZ6x53?=
 =?us-ascii?Q?kuv9qCQJV5TgvT9aFyTBYxQRnDQQXExY74XFX2GA7vU9xLtvR+/DdX9RFd7a?=
 =?us-ascii?Q?fR+tZ5/8UQjIPyYMLmwuE2p0vy07CWAtPd8MJM5RdWhrH2712gVXkdi6jydF?=
 =?us-ascii?Q?fP5eCBo/mDtFuQQTbEXFK8f30eNTEwweLXLB9reZIVjLtdXRrwvCrIv2ocri?=
 =?us-ascii?Q?3VBm1ocCyGXGA2ssXcdkV6I1J8Q0vfMu9GONnVDYL04veQCa1l89Tt6JQfuW?=
 =?us-ascii?Q?5b13v5px4zgIxcH1AkslJ9Pe/9rNaSolW94oQEms8Chd4boAvTI6vsLaxGun?=
 =?us-ascii?Q?/930SoeTO9SvIcgjy0OYfMFxLnsntFSg5Em6HEPHaq1eUTcvhpF8Zf6a2E91?=
 =?us-ascii?Q?Mvhp7CPRJbohICyT1n8GHAXkFUE07v+5oCpYfhhwADtTYPWQh5J692cZDf9w?=
 =?us-ascii?Q?h3CUBwrnTiTAlZKK8S6RKYIpTsXRmJlg1yqvojb5wsrGRvWcV/bmDlZ7r+om?=
 =?us-ascii?Q?FwOnlgYcixbytPEYgKzMticmrv4Z6YynU6fq2d4YIJ9+lyvdUMLdKsphxaUZ?=
 =?us-ascii?Q?6m6DGlyBqmcypTVAy+5c6G0TvwNzl7I/5CbXRKjtIOG0Zco7Xxrj9au/bZnc?=
 =?us-ascii?Q?wWGliJOCv/lN3wvsomJRwIdf4UElujawve2QCUiSJGs+DITvW+YoRWFKiyB8?=
 =?us-ascii?Q?qmeLBa27NGgSsn8Ha+kuThN/RHBuTinjEyuzN+lNI74kVMJvInWSrbjJwgvw?=
 =?us-ascii?Q?PyMtHYZvB2kXAWJLFcxgbHga9j3s616SN8hxnvpE/NadBrlamMrs/pfAMdPj?=
 =?us-ascii?Q?LM7vN6dyYy1lbXw3DmaJMkLc7MlcBK4kt9rut1Dkz/Wy1qlxg7gZ6/B8fyvU?=
 =?us-ascii?Q?Nim1lUw/mU+GSqknf3orkqKlV40ATffbw9cag1WygWX+J6HqegAKJ0DMeGrU?=
 =?us-ascii?Q?vq8ul6Y6vxJ9wPonB3jrbM5P0zxvy/EJIgh35VkjEXqAqzOmdK3EU1bcNWzn?=
 =?us-ascii?Q?Fm1FlqX507cGpGrsxEReCiEBKuhQ+pdhevzuKpgpUl4OhQv4vEOjcpNzyRLw?=
 =?us-ascii?Q?QJFtIWzNaMPgQpyvLC6ja00moad4XRSCsU/lWfgJOT0XlRJNh0BNrWbtbWDX?=
 =?us-ascii?Q?WVECfq6RaTYvFR52IHvN4n/U1WZk4H7EGaYmr4lLDhS9o9gasCYVQd3CXQyD?=
 =?us-ascii?Q?JOxZKA9wGH3jgT7sC9iUqVz8cLLCL39+wrB6FbN0ji2vx7tASvyh5ZqftvpF?=
 =?us-ascii?Q?XFS61HzaYW7LITD1MOOORzJrbmLtz78aa8ukRIrFQ/it5cb02lHl50v5qx/U?=
 =?us-ascii?Q?qu9wiA2BNtRaJUd2hHbxpDIHhw6Kt125es7rS0UU152dXChXUbMsOXr6j1/i?=
 =?us-ascii?Q?SwnvbaAvehpfQPdJMUwMazqLb4jfbYMF6rAnC92YC6PIqVcog5r736szR21C?=
 =?us-ascii?Q?TQf52vFpMJo1g/BZimZgHGhHKm7Dzk56vdF4eYBWD+bZv6OlA6qI/h00QPpR?=
 =?us-ascii?Q?gLk6c+X7WLMV28+y8yu0lobErWENPNtdMqy+hPPZjhh9Rw9WVeJ6KquB/3fI?=
 =?us-ascii?Q?AvVuzZpyn3Y20fcCW8zALM6ZWmXHexitCDZ6F0z6Qbr2FQ9HdQ1xCna97LJz?=
 =?us-ascii?Q?vhFNWLBKJ7HfNVdl03bw/xw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A8B3429B51E1F54BBF5942A40392E222@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	73jya6u3GIXu7oEphGsEP/hMPDNHC8PhOG3kLIz8cY7+x5sSzbuLwRS1lSMzvC29TEq74zheQhI38RMfwvb7iSjd5g0eUe0T7EBsbO8PI56NrVqfthfUEq1TJSl9XYBS/5D0SFtqJfBSvmGZGz8ZmmY8KymAt1dxDuZQ79vtLYeMSNDTlYSs9kWQc/8MkUGGW/RYk6VIDMtZCOUSHBK1k4pRmiIa/h4vS/ks+Q6NZ28IaX1UvvDaIqdpXyLsTQUB0ja4QWyvp7/kVqeKyYVlk9XkQibqcEJjvk0F+Q5iu8DfylTG2m39F2Slpx6PHw0kXVtklITschZzSVtRH5c+bNs3K+MLIheGNJJOckes5g0EwYOG5uSImyA4MRQ8fVyIeicGN/UQ77++9c0dl6ZWwadaeu7OPYfFQLa0TqHoolfIkVTx1K3xS0DWSg8KcmE8RyBviI9EG4A1ow4YGWI6wyzYFRPVR5RL7MiyupHnX7OZipRwgx7lYHtmTrkVPt2EJgdBrL4jbQR8GtKxMN/pgcDvpWDk741qEWEBct65wQKfZRbH049+Av2hbsHIGDFvbeoO8w/RY4aqyK+XZIYwKJj2kHOWQL0uccZtcT2FWfKFApS3so2HsHbk53jXLovj
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34986413-bbcf-42cc-7032-08dc90fb8b05
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 07:35:22.2809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NcDxn+PZn8j227EBA2ayFPrYjXbtoPzV1pzuJOd6WN+vqIDC+437QrMr479rQIq49yW5huf9FGfQPz/ueVxxlZr1tNsg4AYLQh0ruJTqwV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7009

On Jun 17, 2024 / 14:00, Cyril Hrubis wrote:
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>=20
> v2:
>   - make use of grep -c instead of wc -l
>   - Add WRITE_ZEROES string to the grep regexp

Thanks for the contribution. I've applied v2 patch.

Of note is that I folded in the changes below:

- Added some descriptions to the commit message and the test file header.
- The created loop device file path was hard coded as "/dev/loop0", which d=
oes
  not work when the test environment has the device before the test case ru=
n.
  I replaced it with "$loop_dev".
- Replaced short command line options with long options for robustness and
  readability.=
