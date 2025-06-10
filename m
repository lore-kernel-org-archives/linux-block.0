Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3914729A0
	for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 02:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749521153; cv=fail; b=EZbkrvCvtcHa0zAeV0lUhs5Up2iVj9XYFGMI3QvQuFmgcyXdiOYTqrmJdLLHTFUqRWIwRLaAu9eogtRl5lTRJ8qyQIR1qKHQYxGfIbQ7lgcS8ql6CF/G6hS3JltJXfzf04X9XoC2kBzlTLOFHgp37quxrSMlRqkW8WdP0aIAiLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749521153; c=relaxed/simple;
	bh=OmF8LfTJhrXJgmj8jwm4DA2Z0EYnJ5mELG7QDbDIi3Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g+glSFgbj3wJLw2HFxdsDnQh5BMmivp5+zCuAIVkUnfqb6Trv2Wp79tRGgKCAglPXJ+Fk/QbYpPHy7EUzIXmLRJTvn3K+Kr8XHpF8DHEM3qBV8Bn5UTw4wZcpYY2ul38kQFxI5WqQ0Fvh6Y3oIajvqCVg/IwNGM5EnEHlt4rEGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=CJIP6AeP; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=SDnbSpm9; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CJIP6AeP";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SDnbSpm9"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749521151; x=1781057151;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OmF8LfTJhrXJgmj8jwm4DA2Z0EYnJ5mELG7QDbDIi3Q=;
  b=CJIP6AePkPywnkEPJPdkCukgi7lX9REQf4j+D9Ccdo22vBaXymczCNdr
   qwXT6eNnqRgdfbp+p+haRZDhtHVNFaKJzD+0d1qscTemaPiFppC+Xftmq
   uQS2vWfgxfkjHkTADfVKQdGE9odikrVud3m0uRDcMg8C3HCb0NTWJVPvM
   eUzF3FcfgGJ9Uf21mhCfUd8XFsRWMvr4HYexcKJciaLKbHv0k5qi0r6q0
   uwJZhKt9RQuE/WU4e9596kP25JsFrnubqusBLHsVyzqJQzCyOAWyylCVV
   G9hmOkMu3uvn/+BpWxYnAgpHwsO9w5VobtRZEgWSQbxg8ZfpULiOseBV4
   w==;
X-CSE-ConnectionGUID: Ek3cEJfrTO+ap6iE6u+Y/g==
X-CSE-MsgGUID: 4/TWYtjrSoWv5Ndx9EHZGA==
X-IronPort-AV: E=Sophos;i="6.16,223,1744041600"; 
   d="scan'208";a="89210637"
Received: from mail-co1nam11on2073.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([40.107.220.73])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2025 10:05:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwy6Gs/QMfbyz9NB0KprBFDrLAJ9n6FLGUenMXEhB40VOfcegwhGpDdjYfwhKzrkUeQ+vZlU9jbG9fF1l2lWE9ChU3cLBCTKPo1jNieST80NvOt75hCfVImdZfs41BPdQhsVugM/hMhb2b86/jqxnZoCFiXF6Qizn3wU7j7zh5mdRY5tPRS0P/q15M6I8KTE65Pc1aesmmxSPELnUuLobgrKAoIim/TVqvfYuVBjDJAMv0nwNDd/g8qi5g67LhQtcHIzQwYk5VzKfmfNiEVtBJ1xG4rpqX7p2lqslZJMWfJMwvDvtPTYe7YG/A8plUJ8csxHCRrG94eYxe2ssMTqgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkHudVq5Mkrabd4f+kGP9rdMfM6y/Mz1lQjKCUM84qw=;
 b=DncBJHbJBd6lEOZ8lmoq+rHd8S/bAcp6RmAnymZAaqm8y8ISFUDD57uJ0e70r/fRCUk/drFU0BlMczmyrJP4PEZSe2HfP5J5VCfhtHFWJg0UUxH4bpclctr/mYFoVKPGxAk1vZZnB8Y/4UYgB8wN8RjgtMkDcZ0NsqGd1iMkzfyXrN++tMvq/cVXAmr/UJnBdHCfOtX9AJlbBZx09ECELgd0N97F3U6xdBcJxUJHyIbstHhakdDNTMoXF9UDWEXb3Oe35ZrDnSpm2KaAsnqEmIVFqghqx5wVDbwif8y2JyJ8LKxvcBTjOCAg4DqhOZACBv38g0qM1PvLrxYS8iBASQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkHudVq5Mkrabd4f+kGP9rdMfM6y/Mz1lQjKCUM84qw=;
 b=SDnbSpm91hfg+HhhwxTFIm1owScorBKH9oBJntchWdR1tkwsFHjPi/dAUbPt5CjjCLbpfk6His9hpdlg+uT/OeiFtxApeB05tNeAtMYfLiK6pJsCQEFiRQGuUktv5l7zWq4Xv0Gd5Bnr3wyIJKfzY6U2H3OzTpTImn83ETS8OS8=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by PH7PR04MB8609.namprd04.prod.outlook.com (2603:10b6:510:240::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 10 Jun
 2025 02:05:49 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 02:05:48 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 2/2] check: introduce ERR_EXIT flag
Thread-Topic: [PATCH blktests 2/2] check: introduce ERR_EXIT flag
Thread-Index: AQHb1pcB8XrHg5kcCUm1uP/dxccmtLP7HeuAgACNQ4A=
Date: Tue, 10 Jun 2025 02:05:48 +0000
Message-ID: <6ov3repiplxgds6jcprle5jhtg33myba2cgf3bt7lsklqlvmy5@igjg7muw2hv4>
References: <20250606035630.423035-1-shinichiro.kawasaki@wdc.com>
 <20250606035630.423035-3-shinichiro.kawasaki@wdc.com>
 <a30853d6-5d7c-4697-9bca-926962649254@acm.org>
In-Reply-To: <a30853d6-5d7c-4697-9bca-926962649254@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|PH7PR04MB8609:EE_
x-ms-office365-filtering-correlation-id: 6502c570-251c-4280-e612-08dda7c3519f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RzdRWUcq2KiImCh0xO7DmL70cQBYJHEJ/u3Aqoxi5bEo12SbjYEkcYuklg2R?=
 =?us-ascii?Q?UhKUJL9jTSsvAgATSmD/98y7ovF994WxhrRDLDqlRIXjwyU9xA44FSmUCeZ9?=
 =?us-ascii?Q?+T5dk2Xq1boUOgSIl9i/LAbfXfZZi7JhbhJzSCSSnfkWivlE5jbtgzj0YUJo?=
 =?us-ascii?Q?k3mKalhtXB5DJUORxi/9JfQVlTxDTBi/9N70RGMUR/MJNNzVaILPzuOUloMv?=
 =?us-ascii?Q?IE1xPVAq0smYk1uu0wAljlVoJ8cuplRUscmsl/kG/67mQp47frhUuU25z1Pa?=
 =?us-ascii?Q?NinshfsC0O4tRtzoxBm2SBlBi3NfQi0C9mxkTXT2bfc7wumdU7d2Gk1d0/aa?=
 =?us-ascii?Q?qBOesgwdhKeTFUTUc6dk6QCBKu0SO4KfUSODPkZ3sXtjz749NPF6kRFocXmW?=
 =?us-ascii?Q?2rlrlCt89dA7ragdEDNZ6GgqduV0CoKH9FIBWSEx9Ov3ozXswXVN99Eb85VO?=
 =?us-ascii?Q?PQA+FCzP3np14eTZoniwkDYUJip+9TRGdbYTduF+Kim4TUCSWCTTGtBZxYOH?=
 =?us-ascii?Q?R7OZenaW6uxGEJMn5HCKYlez1aTyPuD0ELBBIdibmb09vELu8l9jlM7CT6wt?=
 =?us-ascii?Q?fUuw4VksmB6jehg8PqTVtUU5s5w6xCB42eukGapKFSSRS6CTzcUKKGX6iZUv?=
 =?us-ascii?Q?UmxJ963GwJWFKyxDRVpRWfdrgLsnlBOLKClCHe+d80vOghzkjDTqgJD5fzuu?=
 =?us-ascii?Q?Y1T5H+ur10i4fF2T7idncdxmgaBvGTGk79vV8XfJqw0HaMTHSUEj7sb3FDob?=
 =?us-ascii?Q?jRH+ggXd9FnrQlNKxU/6Cuax4F+e7x0JzEaR/QDhxTcmGP7+frBqd+tHRgFk?=
 =?us-ascii?Q?Pj8Gc05ir/KohZx1ccEd27z/K0Y7GcUz+ky/6uM8gE2TZD+fqUxdiIlwSrE5?=
 =?us-ascii?Q?c9l1X951k25tLX/g6P1LUBTIWxay1XyGHJ2RPskHcnhRuUn7rZhgP2FGz9w+?=
 =?us-ascii?Q?ADJOkZpCBZqg8kI1MSi+iat7uJUFqbq/2YW5QW857DKsWgTPe1gktNTpOQAF?=
 =?us-ascii?Q?rALwScUv4/BftkFW5RiFxbCpTH34414FhFmevNUQO3SUt/CbS7ap44wjyzPB?=
 =?us-ascii?Q?UzMRb/zhI8A9CvEdadwGsw+tjdeLQUXgpe+a1BXjWSYW3qA5rv2VkJEEct6v?=
 =?us-ascii?Q?gKpRZVi0X10s0M7pPANoNYqFT4B1PMQEBzG5Lzef+NK4Og75o8ZJgDcoWQyF?=
 =?us-ascii?Q?s/ef6/+KfQbVqHqIehOtZJymSUMyauuHbwpP+00Sf7/JyJ/ThGU7J2SywpHN?=
 =?us-ascii?Q?WC6Pb7xjsSdWgSQHNtDNHbtiX2kn8ZTGvHwZt3B3b47FEQ4326AhHn98Axqq?=
 =?us-ascii?Q?Rz+cqV91gaChvb5bdM2qge/SSLgDl784wEXWY7v5B6KfgpiUt6qut+aszJAH?=
 =?us-ascii?Q?m04YV4POqvPcAvw8/L/xFEe/ZHvKdWGX+ocv8OsheDJkogF0hk3udEJSdQp8?=
 =?us-ascii?Q?Vz8SRfakRypL1TwjstUWRK9f/xAT5XnCDSxPbkIZ7u08jdfZT+gSHuiEVEnC?=
 =?us-ascii?Q?15GrfZBNAlTn5ys=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PBBwmHQ92XulVvO4QiehnmJRKYIhj55Ekjs+gK4YeojU1NqJqWcvk6ROUR3B?=
 =?us-ascii?Q?UObLKtrfDLBRIgQi3E/xiYFB1TF05pGyfJ/C6oYlUSkBGQ2AMgMDb3s9SAW4?=
 =?us-ascii?Q?cQl2wHOZm5tgCPuXOFLoCuHcg9LPVf/PmpLP4hW4LXxV5fQZM48N/IzFDV4A?=
 =?us-ascii?Q?VtROeoareFUnrRWPcxEI0vBP8pg0DRbiCbu2bOnlQ1qEiEwObARv5xGB7u5X?=
 =?us-ascii?Q?rFL/cTxzQ59R6UlIoFpY9/MP8n0d2G+Zn9pxPria4DCUMez7+xnpFEU8OHOj?=
 =?us-ascii?Q?qBATow60kwvkhtcOeJuivml0paJF6iPXXF6RK3g2e/jZUfmcx3tXaB3LfaBn?=
 =?us-ascii?Q?cNTWwjQTv9g6aX7/FhtZq/WVYm6E7x83Y1x/ZMuesM6SbREms1xrpyz5Jday?=
 =?us-ascii?Q?itYTfIhRJ1RQIPSK4mETbb7SIv5/He144Rdw80MSkW2WBr0U4jbNoHP7Lure?=
 =?us-ascii?Q?mPbm/lFIxLqIn9AVorW8qF1ba6bnf70L9O1xdXaATl+L3Sj+X0952R91p8V3?=
 =?us-ascii?Q?5zARuu9SwZpmnoUTeomEqIWIoaXAJIlzbTvHtegvehM+1NJqILT9QO3PZfbQ?=
 =?us-ascii?Q?RxKcmFwiFRa666W5fDQ16p0f2V9aBAuzbpi3Nn3d7pk0NELit/isGlizkilP?=
 =?us-ascii?Q?WquZf4LZFblo5LqqBo+c7hh0vH83BqJFhcCogkBhE5AgeKsZelgimOLezuKj?=
 =?us-ascii?Q?OEAOZo1tSQweyGIp2VthDYlQM5W8fyJO8bqny+rGC0vYtmEv1Hzdt+Lwc3As?=
 =?us-ascii?Q?IpxqKkVB8SKvslY7hmb136UyhflJpZDsplyAizwadR/wSfDpUY4Fm66qTwR7?=
 =?us-ascii?Q?hjd9wmj83Gx3I8zmJPhPOe363nfMbM+ZBIaoZ3XyMn9Jcr9daDx7/9hfYatM?=
 =?us-ascii?Q?AS2LlwCkCjmplSuRbjPlOdtZ2nWxYFS0W6va0k+QYj9N5hdCD71XReBKjBq+?=
 =?us-ascii?Q?1J0kC2EqIz8bGgBGeyJwQr68QeQHSw103GgLr1ZQJFQfSE5Xtw3rCeCNcxDQ?=
 =?us-ascii?Q?bk44366IxHfWf3dD7FW5X6kZXsjOP35UQTtTzrB+OPyV8kLdN2YwqCnVAsf4?=
 =?us-ascii?Q?T6zyR0eouU3D3xzUPCShYd4dxYwIfYhD94S9NP6MHQBzhP4ana80p/p30NS9?=
 =?us-ascii?Q?1epXJ70lG2qvaxF21t6qPKb0ISDVeLRBj5IytcRsUGEvIvGP/dmYBRn+eqMD?=
 =?us-ascii?Q?uz+UhYSFqoApZfP6uLnu91gYs2y9JxUSb5b/+AMuXCj9rsuHcQG3h5xPyxAW?=
 =?us-ascii?Q?wkdseLCGl4pHN9kkTjUXTE0oL5ES6+ERotcXj799WpO/kvwI4bCohTcS/Gfw?=
 =?us-ascii?Q?J2epw8vUOaet+3BL+IlDKl1vMl5FacsfPqmFGMo364B3hOF36G5ScyE2+Z5E?=
 =?us-ascii?Q?NqIvZ/YHJXiC18mC0HaXfYvWxWDKSxl1sj5qLSQmdt/3frTST4uz2F86tHAe?=
 =?us-ascii?Q?SggFWKUmst6yJHsbRvZ6zRJuB4O7YPsPClN2wnD/cf/a/20CCYegN8wik9Cy?=
 =?us-ascii?Q?FNYJ8gWYA9+anAmtkTuMexE+x5wzOg+qKoHwNsfDlGES7MLqsf1b2p89xnzu?=
 =?us-ascii?Q?TpqxfIfo3sLA/pojmESWe0BzkNpnUB0pbM+p6oni8kvbxRZfZxiqpw8kFQi0?=
 =?us-ascii?Q?oA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B847F0D14894864681CC0B919297CAF5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qDIyEX8zlZU/wxvhUJPw7SPenmh0yASrRDNcb1KKufF4VUbeEhcqU/XwBq3599q/isUakS86LLGERzcVBvlK0u3sHt1OsSuNt0wI7OEBJaNNTd+eY/HB1IohpWcQY3nOw04H+iptNttBiHcOmrJoUFuNvdqa8VEzwikmBL/RO8pN5EV/HmwYPd/NWK0WO7scjRLixCDdo7iW2RGroAcS/y90yk6XxsyKNiKEn6OOKfwPDvCktr5+V054A5Cb9VmeJTugpZwZDMQPWOeeXMD6J0CBAiP35jGhq46FJEeJ2I/rmfJJkiVPJcqLDYZpJIPISNUUNbkhdvXLVqGS3Tjgj9vJjaLg56IfeZyYvvHBN3f72/ndA7ONvRqAt0aVcDjnQLh9wCA2L9I64Y8TQrJsY1B7OQ/n/64kc8bTB09+nw11jZ+6GkLn8N746WwAAVTkDAcRkZFrylwCyssivnXJuuI05BUf/NsuxUbQPRUdcV9JkEpHIoG7+6F0OAMRTjs+YFk5JuGJ/to5jiSYyDMX3QOBx2Y7hc0/0nDG0gqcv0zRXf2lbeR5rj3w1slJJEwlJbtPMoAen5crONKyBuejjckoQxh65/aDN23SrW68L6ZatGs2P2cVnAfSHEQKobTl
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6502c570-251c-4280-e612-08dda7c3519f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 02:05:48.6045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BFtTdl2Qa47YLgLz7I+ZXZDQ7luyc1gSIR+kXsCJZFw6bOfAIUwiSTys1z+uIYgvE/M9uW0s7n5N4bOaGTUzVQvYnyGQA3LWJUdUQDI7ZZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8609

On Jun 09, 2025 / 10:40, Bart Van Assche wrote:
> On 6/5/25 8:56 PM, Shin'ichiro Kawasaki wrote:
> > The second problem is impact on following test cases. When the error-
> > checking is enabled for a test case, the test case script exits
> > immediately encountering an error. This skips the cleanup steps in the
> > test case, potentially leaving the test system in a dirty state, which
> > may affect subsequent test cases.
> >=20
> > To address the two problems, introduce the new flag ERR_EXIT. When a
> > test case sets ERR_EXIT=3D1 at the beginning of its file, the blktests
> > check script calls "set -e" for the test case. The test case does not
> > need to call "set -e". This allows the strict error-checking to be
> > applied to test cases selectively.
> >=20
> > If a test case with ERR_EXIT=3D1 exits due to a non-zero status, catch =
the
> > exit in _cleanup(). Then print an error message to the user and stop th=
e
> > test script. This ensures the following test cases are not run.
>=20
> Has the following alternative been considered? Let test script authors ad=
d
> "set -e" and "set +e" where appropriate but only in a subshell. If a fail=
ure
> occurs, only the subshell will be exited and cleanup code will still be
> executed if it occurs past the subshell. A disadvantage of this
> approach is that global variables can't be set from inside the subshell
> and that another mechanism is needed than local variables to pass output
> from the subshell to the context outside it, e.g. a pipe.

This idea sounds something to consider, but I'm not sure if I fully underst=
and
it. The word "subshell" is not clear for me. Do you mean subshells those te=
st
case authors create in each test script? If so I'm not sure how to ensure t=
hat
"set -e" and "set +e" only happen in the subshells. Or do you mean to modif=
y the
check script to create subshells dedicated for each test case run? If so, I=
 will
need some work to understand its impact.

>=20
> > @@ -372,6 +380,7 @@ _call_test() {
> >   		fi
> >   		TIMEFORMAT=3D"%Rs"
> > +		((ERR_EXIT)) && set -e
> >   		pushd . >/dev/null || return
> >   		{ time "$test_func" >"${seqres}.out" 2>&1; } 2>"${seqres}.runtime"
> >   		TEST_RUN["exit_status"]=3D$?
>=20
> This change makes it harder to write test code because it forces authors
> to surround cleanup code with something like if cleanup_code; then :; fi.

I see, this point makes sense. I'm okay to not call "set -e" in the
_call_test(). If we take this approach, test cases can do "set -e" and "set=
 +e"
wherever in the test scripts, but they must declare ERR_EXIT=3D1.=
