Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B994225A64C
	for <linux-block@vger.kernel.org>; Fri, 17 Jan 2025 00:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737074160; cv=fail; b=m9/bX0wXJXiFFYaDfege9iKHyqRBz5iS1ydbo2FHxU/ORFeU4GIRT1sOgUCw6J9SvWch7dANqyGfwyDzN3XvWToCkdceevYz+776D5+vwb5zmY3utrl3AJzxMcz3o8kI+eikYEwZ5mJQ8d6fNfLNpHGk5u0fY7RUukMc5F8iVoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737074160; c=relaxed/simple;
	bh=LPJQIU5BtqAGUMfNvqBcJYE9sh+0d4jbdjG7N0sONyo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YalVIHmtwMw+oMg+ddwsB6g0B43SCnglv5snJ7qUiFiCEfBeIhb8YH79t4eyow3rIws07niiKoneVDN0Yw3nGo09Tz9BbHsrkW4/QBHUnXmbYIJDzDHei8Q4thztGUyWOwcd2PkbTpKhhzzuUe1RdnTUcwAvRuUCztBBntvP0YA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GrNub9vm; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Z/sbHq8x; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GrNub9vm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Z/sbHq8x"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1737074159; x=1768610159;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LPJQIU5BtqAGUMfNvqBcJYE9sh+0d4jbdjG7N0sONyo=;
  b=GrNub9vm0fXAZ8HuYvlU3b+SLk25B7p1hhcjJWFW6tPdJYMM48LI9xpX
   LmfJQ1PWvNiPBJTaKLSPsy2S8rJDLRV+kKXzT0WIU7OiYo3J93CfX4ptW
   k9Sgg2GV0fJElIpWsjHD/d6By7ipBq92ET9GHUn0nmyGSBAbW+aWfNYL3
   ySNVDmN8ry/pdsr0idaFzV9QPqHPmo7p3601e5/jUX3QCiq7llbpoIrMq
   iU44BFv7itipIW4e1y3A80jtHOMUnr9mtsYGwRqO7dNt9OdMkXzWKJ2rG
   mjmKgvoS3WlOZ9SVGHMAabYnTcSTDspN53xxt3ntdK2ek5vczVs1BIDCt
   Q==;
X-CSE-ConnectionGUID: b/aNNLUaQ2qPwwaw3V8dAQ==
X-CSE-MsgGUID: OMbqbJNHR8qVBKxDCooBvw==
X-IronPort-AV: E=Sophos;i="6.13,210,1732550400"; 
   d="scan'208";a="36127491"
Received: from mail-centralusazlp17010005.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.5])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2025 08:35:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PRX6YR+gWmfblfrtKmNA0kwT14GcWQsxR6juoUd+ZokBdBWURXFWIDvqZNORDWCqAChb14QpWxTxk79ZkvazVqqR+P/AIynprp+A2F/h90z+wN3jdC75wRUzcU0nrz/PLRHcUJnUWFFXhBodPbEGiHv9/IhS9QQWYsgfOoFvIEObglcdCSsVIJDpy+ZEDgAoSHkYKsFf4pRSH7gmJuEZjST/N2uxqL8Roo/Qm4e4R5tjbxd3PYx/jeMYFVlivmXm9bPS+2Vki02L51kyaiygBhIu5Onx13J/Yc7JgBo5K6hU+tTgZuKJ1i5xN4q3zP0P5V2RR3jvl3m8bPrHoeqpmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eK62ncTbRfdrjMRcl7r0jZGACUTLeXYYh8dXubR7qlc=;
 b=TyaOwHNyaP86oEf8Kh8d4lIVRnwU4d19EXpSy8NrmWniBrhRaBNZlJSwyG2Z0Ox06YXeVDXdpCNFOkRsxBYeLl/I++b+qTFMYygTkSPiHPr3igypDouju6LVk/IoW6BtrN3Br/utHZuRjddWkFU3RJOekXGyquibe5Zg8jxkYJjbCWM2CEiVYtL8B4135wb0LMMD5XDTtRlgvhyNIgZL0Es+bJiTREpFclM7KLTuTdf2PF6gY8nvSw/TBimgW2mMM7Z9y4q/n9vAL7PexIsft5nxP5T16snpVtxnpOcft7se11pGRbz1YNaw2a/Y+ThNShge/WZch2KYVu89FToS/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eK62ncTbRfdrjMRcl7r0jZGACUTLeXYYh8dXubR7qlc=;
 b=Z/sbHq8xNT3mMPcCE2HAs1Hw4gzIDVKw/HROuccjbhTR3McofMtVXYmHU+Q0LpUGIpQYNuklunPSkv/eQSysrHwX4IRQeDf3q82/9gItRnDZw6l1fJ4k/zcOnMRR4QwQmqBffG/Uc/Yn3zsKYIVxnZMrHt6GPYdT9dcnKMusks4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB8567.namprd04.prod.outlook.com (2603:10b6:a03:4e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Fri, 17 Jan
 2025 00:35:55 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%5]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 00:35:54 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"yukuai3@huawei.com" <yukuai3@huawei.com>, "yi.zhang@redhat.com"
	<yi.zhang@redhat.com>, "bvanassche@acm.org" <bvanassche@acm.org>,
	"gjoyce@ibm.com" <gjoyce@ibm.com>
Subject: Re: [PATCHv2 blktests 0/2] throtl: fix IO block-size and race while
 submitting IO
Thread-Topic: [PATCHv2 blktests 0/2] throtl: fix IO block-size and race while
 submitting IO
Thread-Index: AQHbUVLiLVZTxSc0kEWUkXxQB+gegLL1GGoAgCRWsgCAAN3EAA==
Date: Fri, 17 Jan 2025 00:35:54 +0000
Message-ID: <jz5nux5zo35rvw3h26enxbsnmvzf73clo25p2o3acyerynybma@z7mg6yq2f7g7>
References: <20241218134326.2164105-1-nilay@linux.ibm.com>
 <3bttr4zv2clzes6q4cuyy3l35ls7cm2r6ljzcgzc3cpvut7dmn@grxcm43s2yse>
 <5507bb17-b2aa-4df7-ac3b-73b7a8e4a096@linux.ibm.com>
In-Reply-To: <5507bb17-b2aa-4df7-ac3b-73b7a8e4a096@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB8567:EE_
x-ms-office365-filtering-correlation-id: 04c3f0aa-a0e6-4124-7f11-08dd368ee703
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?MCI1X9uggzKrY7ibuZ3zeEG8mEkarVktX6p37idYRBg+6c1q4ekfaJ82N2LI?=
 =?us-ascii?Q?GSCoK0OR/6cB4Ud4cSFHvVTjlgozJaTgxIAV4o7F/p/fs7IDlEUp6hAssrF1?=
 =?us-ascii?Q?dKr67PmaikG/VJ0R7Rv05hzfgz62O4XDVtOScSuA4wUnu6DzPsrD7T3SK4pW?=
 =?us-ascii?Q?o+awhkgYgjAhV9PGsNAM1FYDtRjUcJoDsKEEDmhRQvc9RPYRZI1G8h+r5qwX?=
 =?us-ascii?Q?3uG3tZzSnhcKnYt0dq0Pv9M2ZTqthE6OIE6hWs+1wtNhVDgyW3XBKinXEenf?=
 =?us-ascii?Q?3Pbhfaaz1eHXHGfGa6NsjvTfEvlBtTLoLrV0IsCZkk1Za3e0Z/Lygofufb84?=
 =?us-ascii?Q?f7jh0YNJpCgkvMhnuvuaBj0ZCxO51PLmI0cWI0PtUfu+hsseu108YO5lBzzX?=
 =?us-ascii?Q?mts7LZjANPb2DMLaMft38+QHq092FBb1MixXv2SiQP92ZQIYLlmxr9SSYHPr?=
 =?us-ascii?Q?dUgie++bXFagOXfpL1NXdRd2lyyEJubs3oGpxKf1BpD+4aeiQX/VhuqCSa/o?=
 =?us-ascii?Q?LkW82/fny+Y9lj2zVZYNLygOdgAxAsBSH7AxnAoZT328A27GRCyXZdMzn+Em?=
 =?us-ascii?Q?yCc3FC81tzTfrnCUF4ZkYmYDrorUWWcelLYMSooTz/FtZ0CM50jhBlfAbdw8?=
 =?us-ascii?Q?/nNKIAXnN38KBWpnmBF4so1dEE/59XxzgYcL9wOSdCJhUkXkPRxbTzXQSWz+?=
 =?us-ascii?Q?1bb66quZx4Nu5W1PuD4rhsyzG82kYenx2TZV37V72rRLLafvPYToVCjjlNKW?=
 =?us-ascii?Q?arCsXAopq//q9kaUTp/3xiHCwQfCcdgPfuXV9MCZWI0lm8LwRRQL1rCdEKh+?=
 =?us-ascii?Q?sUhY5d2tO3lCaCgW4/Fslj07DJnLgOjJ1g+nNOaCzLHyDwuxuVv0o5SVL7l7?=
 =?us-ascii?Q?DRgHH8fp1kYNqb+e0jnSn2s9Pewmg2ktquJXW7OhIUJVz4eyywtq2+E+VljA?=
 =?us-ascii?Q?GCBKLhV8YC4uMt3Hna/ixaR47fmQctjMPOPJozvbyMzp1zcDi4GtMo1+PswF?=
 =?us-ascii?Q?kXCzbdBD+l0c7EFU4V3PcqCdRfLXFKitzbvL5DQ3bsU72/cThKnaNAZFqBb/?=
 =?us-ascii?Q?31zOmgRSfIe5Fckj52lpzKIm4oJgOPqQG9A30wjU2d2VbR8vfv7GSZE0qzfn?=
 =?us-ascii?Q?FBEwXNm0QqQ4BvHnN9lKNIKfPgj/T3JEgxRS0gHYQ9oqKkC/WYvGcQNLSisK?=
 =?us-ascii?Q?q1CT04kJd/IXHj+78kMOFWZB5dr2J+9WRJnMINlRT/uTwcW4zd2NMpXZ6GMv?=
 =?us-ascii?Q?RvSGcWJfDyJYgHvtR54I+XvK2q7arbvvRYIp+7Goe4nay0zWNx8r5LQiHCFv?=
 =?us-ascii?Q?KAlBR2TCX4hrSe8ux9me83kRdfMtvKNjoqVYSptK9zE1WcB+hZzvVpWr2zVv?=
 =?us-ascii?Q?jjIkHoyAsmfU/r4edemSgp4ewW6eDKuFulDP6d4iQD7Pe9HjX5d2a/Q87ivw?=
 =?us-ascii?Q?DUK6W/f9gCzcro56JePc/v5G8Db0nelF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zpfTc/SwEGi1IQaK0enQCnF6Pd/2i76qkCns7EB4rEYWjQOPTEHFK4JEgIwq?=
 =?us-ascii?Q?EnSJcdcJMpj7eQGj2ttl2AViHSQtYm9Ww3Kc5iunbdvX+bd1nA1OfuMvRZTN?=
 =?us-ascii?Q?MH2v4DWkAqA+aH+rhBykrV50YhhIPbhEF+rOVijhc9Pz2gdFVwyHI/cMvHzS?=
 =?us-ascii?Q?QSOFmPl2cLfdtM7mA55JVmIDWvvRer059UD5tOLe66ffroI3ZH5ymdnMwaxB?=
 =?us-ascii?Q?o/AGLCxS2LncRtBJR95Hh1d7APHAhnT2CKxcIvQtuyFzvvdqL9U0fn8Nv40P?=
 =?us-ascii?Q?igeQdWK+MSLPPp0uH92zmR8/qOscjE/O7zyCPhXsCsALu2gdb5Jg8g89Ky47?=
 =?us-ascii?Q?Itxh3giqv0k4DfO/hPshlitcSJR8ctdPm8gFibh6AIhFX5+9MitMR12+OIvb?=
 =?us-ascii?Q?1z4+IhC7Okn3c26U0qM+zKtrbjNhXACQnE4KlCjCeyXbSHbIp5M1WE/Ybr0q?=
 =?us-ascii?Q?oY6MJgKzXRYTPi3sGmrFXpzMU8KV/jZOku0rGW+3SrO7MpCTQCzzFh1fqd9u?=
 =?us-ascii?Q?Ak7VOPxlLol/GpwhRLEpYJRg1nHtRmRMaarj0bNJtX37kE3ANjn++fInOFmk?=
 =?us-ascii?Q?Ck+ajp20qfXEf4w7SWpnFXNKMLKwsMAykxPTsXECJcyqcwmPPWRmCNjInR/L?=
 =?us-ascii?Q?hvh0jUgVGLnVM+iam7ZWiQRMtaoQkWx3ITggh0FmEZRPxwWblFA1w5ZY/IEW?=
 =?us-ascii?Q?5Ikdmrr31sLIj749Iqmoci0BM05fw5YcVRL+TzGa/Slhwt88SB18HRWPS9Kl?=
 =?us-ascii?Q?c0DwmDlJxVDb0rQ29eoyLKkcjiIMkqIKYbkvB/75+doZLErbmwTjbQmzRWPI?=
 =?us-ascii?Q?PfMYDCndPb/FohOGifB1EwvN1oxpBltVl5ygfyogZC96OmP7TO2cPf/FK16f?=
 =?us-ascii?Q?//0817pW9/VVI+nCtLLHQ9BFrEetosHzV+1ZBrXqp+NIiuKJYeRWp2b9w6EQ?=
 =?us-ascii?Q?7jYwSt6kbaVvRHDobg+OPf0iZAd+fCeSolPNW38c3V2LY3jB1oRK8engORLu?=
 =?us-ascii?Q?IJEUxCZlFt8GHNdEOdjHnFEO2yQPaPPSnvwovuzjDl+XOObxX7iKAoPK/sjX?=
 =?us-ascii?Q?UArynEbwckITJgEpoxbMjjI7ygIutPMsXhOXpoC1ELeyBodBeo20MAsspaLz?=
 =?us-ascii?Q?mqo3xbgxAxJmNi3wHiyzz7lEKVQgxDU2gpRchYgdJvhEW1pHozNBMhnzTWuZ?=
 =?us-ascii?Q?RuZRnaU0oC8U8i+5B2gjFHwqMEnOlJgPdF6Hr5bTP/XBbTi75bpZj/nYNjJz?=
 =?us-ascii?Q?QWTgj4NxFChwhff0wI94UNCxP8DsBymch9Br+VBa2rQl4CsEm0SNSeBdTDQ+?=
 =?us-ascii?Q?RQTKgNf7YHv8IhSSBEhzopiMYIdSkhAAxpVMkF9H+kWS18QmaU+//sYEtXKy?=
 =?us-ascii?Q?QEbfCOrKdb9w5aLMgylhs+BmF653MrXCnVDgctrHcTTwYJTdU+XPZFuRwmNl?=
 =?us-ascii?Q?ZpKkeSayPq7hbIAhMmuujayiq1qAFZFx27Nq0NBH31nLNcLBznmVRM3WINEl?=
 =?us-ascii?Q?51a5jLctGnlAGSKrt/3OelD1DLgV27zi1GU5c30rd0WWvDJVA+9wlf3miObC?=
 =?us-ascii?Q?fOhsOdIIbiCVKTykQPK5abNR/BU0YU6WpEPDNfwKw+YojKaRmq5km0Cwa8Yl?=
 =?us-ascii?Q?mDwydBGily7lgfZ08GhW11w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7637E31C3B7181458FC7A150FB8980D3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yFHuJ99rpa21BSKGPzCiOz9x9Eqo7OfiD790KH8J8SvM6hgRHVzpj0uMTLfxLH5piytK90S/NHunSToDrHcOI6yPXK9NUvISuslI+HUq+BGVG0Fii/ggqRxpoIbqIsAyc27uLJG7T+PEE1IFaeh2XfeLDkTLgNyHNRhzqkLjVnyOJVjvvC6+1BmmSvfh6Oq9/xSW3FvFXJRzlE0hEWd/biMqBtcu6dCH9F24DmAnJbzHdghnOmA4dmRM2ZMdkPodsCCiv9ROMTpYPOR+1LXEyvoZA2C92mj/eZLmg2ziO/rSu5gAsnukToeme5rNgFXuwwhRZIAjTkUw+YF+ZGSc8OypzurGBoLbQ2eaYrE3S4YT8ggLjp3ajc08cEB0nGA6HdnvJQgresdukJlscgVtlAksGn8lwmA2hgskKTP3uEX5tY13BP0P2TK4lDbs9cFImwYgeqHN5f6eenUUMX02QZFca4CvleVbe56z17wtJRctFCqIrToMtAzUPtRLDELkvlpCy1YOqOCEFIFpHMp84d/X7MvO6CbB/igJvjEx8yePOBk/fPvN1e8eU6umPevIJnPGhQfHYXH6tZiKYCqzWZlUJduqMXKXIAkt6tFrsImXnlTLRvlwLqPwKVEKgucE
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c3f0aa-a0e6-4124-7f11-08dd368ee703
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 00:35:54.5370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uV5/DLnSaYwSQV9qplJF7VPLK5Ar3PSeOypNQ/Cg74QZpXFUxucNw3nbSVDq4w6dV0Awe98M5bd8y9WEKGVupRsgO76wAyUjRJziWs+zvLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8567

On Jan 16, 2025 / 16:52, Nilay Shroff wrote:
> Hi Shinichiro,
>=20
> On 12/24/24 1:56 PM, Shinichiro Kawasaki wrote:
> > On Dec 18, 2024 / 19:13, Nilay Shroff wrote:
> >> Hi,
> >>
> >> The first patch fixes the IO block-size used for submitting IO dependi=
ng
> >> on the throttle device max-sectors settings.
> >>
> >> The second patch fixes the potential race condition between submitting=
 IO
> >> and setting PID of the background IO process to cgroup.procs.
> >>
> >> Changes from v1:
> >>     - Use $BASHPID to write the child sub-shell PID into cgroup.procs
> >>       (Shinichiro Kawasaki)
> >>     - Link to v1: https://lore.kernel.org/all/20241217131440.1980151-1=
-nilay@linux.ibm.com/
> >=20
> > Thanks for this v2 series. The patches looks good to me. In case anyone=
 has
> > some more comments after this vacation season, I will wait several days=
 before
> > applying them.
>=20
> A gentle ping...
>=20
> Just wanted to check with you whether did you get a chance to merge this =
change?

Sorry, I overlooked it after the vacation. I have applied the series. Thank=
s!=
