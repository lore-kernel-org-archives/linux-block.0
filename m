Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B813712E4A
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 04:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713243427; cv=fail; b=mzIozhJdFIIX4IyFkN7rmpVpFgPsUzT+8xx4s1WIL956gDb/4TXdoQ7Rn9khOXR8bWhFzezIlpR/YyHtVAQMoByfixqoT8GaoNnB4hBbGfetqHdEoEQGbgupcnZNN5/4SWW6In8j94xE2vLB6pDp6VU2uQYDV+G+qwKfAWer+7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713243427; c=relaxed/simple;
	bh=R25r+Bv8T3oU0pJMlUGk8i4g6x6Il+5ZLxOVeeWNCc8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VsGeEgpN/FMYMOOcBendV1pyIL5dhEvW60rmdXle5qoK7XR4BXlp52DtxqbH6SacdPOT1wYtwCQNrGNhxeoaZiQ6KMsyPrpYMOC3wgeG9QtSCgRu+i3UJ83iQkMJ2fcs9sGT007I5gbUuABYc28Sw/aACQW1oMoKcr+0Qt1qyzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=q5FN70JF; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=YfGIkbTc; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="q5FN70JF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YfGIkbTc"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713243425; x=1744779425;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=R25r+Bv8T3oU0pJMlUGk8i4g6x6Il+5ZLxOVeeWNCc8=;
  b=q5FN70JFKc8SW7zq/feGTPQhU+h1NHp/1QFIalmTOh6jdPdY+qmnLd9B
   IY9UhgUBrHftVjf4PC+FfOKrJvvhOudgpf/WkubkGfpPeFNU5g0buN7Wk
   Pds9REdJgyfWIuAAGN+nDN6OFg6KLdff6l02TU/zz8pR1iEX3UY6WkkIh
   i2pt1b2mpEbXh+ZU2Lgx4pw7qW1acmOxQZ0BDAfILUpitF7U3nuGtSvFA
   hTvDO9vs/Ahpk6qhc4fwZp61d1lXIfx2LlBAsgm0wqyQ5B23lEJvXN6Gv
   vxYcnhXF+Q7be0TtPqjjd31Q38QbpOP8RWf7K5hpmnycm+/XQeW134444
   w==;
X-CSE-ConnectionGUID: lLp4OMA/SeiNpw+SfM8P0Q==
X-CSE-MsgGUID: 30O6dJWaRR6pOPsnogQ5Xg==
X-IronPort-AV: E=Sophos;i="6.07,204,1708358400"; 
   d="scan'208";a="14301900"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2024 12:56:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/WBH9dleh3vf4IbL7Bsz5EMzZKJ9QVUBm65JQhYvqD0L2/jfS6gA3Tv7irYRiz8vDvl42gQLZhYGwAehyOKABQx+CwF80z4eezZ2l/WQjFrB/dzQdhu0IybNERl18KorbNu8NlucU+oFucAsLS66KBcPh52Y0TD626taNDdODWDjzpllhc4EAk1Nyvg1URGFmBL0l5eP6arpBsdoWQtq0R8gs0DMfixXKDXgD0lfpmjsX1tMsQ5gCKdoPspihi7o5I3NEPpAF/W5su29zpTnN9Ho0chFaI7+v7IJBdT/YDdCJN7xGM4AoRRnNQILgd/4rP3wtOY7hjR6mlG099Uug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpvmXwnCZc/AklqUX070YGcAhn7+ZEsJLOkfapf784Y=;
 b=HD3W+y7qhACJNM5wptMzvVjQetKwPr3VPzaw5VMeOC4ez1Rr6kqAbA/TmLnrvZ22EmmJ/JuEtjiScbFjKUk5KLBPAbajnz2LzcRK+0guLGPIqdOCoRaX8y+j7L0IxAkHAPswTHHxC0296k3l07VzpWxH+EIh50AQXrMK/1RQfSjF04LOzz1kJp5pn/luhgWeEZxdFDHEDLE1GGXV32UBrtwQ779mk7xnmx2wZdWnEAyiOsBe5GTmkE/js4TVRbUh1SJ691gJXqB40KhAG+Zsex34g43jJOwptpvfQ8QGLBV2DlwlDgsPmrgYuFlOpMlTveb2WM/fnIIXCLFxiKqA3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpvmXwnCZc/AklqUX070YGcAhn7+ZEsJLOkfapf784Y=;
 b=YfGIkbTc+egzq0gDohcH43NaX5hpcP/K7aMjLhXI1bagZnN/fV2KQa4DdBtE4TDtJDtvOTwrDRSow6++axCw9k11pe3WFewmbK1U7uKhg9PA3rbr78T4bgMm77FOOkbAf3AlqrHiqjRrPKf66a49AhDnU9V1bWPUuUCdVi3Uvik=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6608.namprd04.prod.outlook.com (2603:10b6:5:1b7::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Tue, 16 Apr 2024 04:56:01 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 04:56:01 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Daniel Wagner <dwagner@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v2 00/18] refactoring and various cleanups/fixes
Thread-Topic: [PATCH blktests v2 00/18] refactoring and various cleanups/fixes
Thread-Index: AQHafF/kgEERWitJoUePk3ENLQIk7LFqWPiAgAAjCAA=
Date: Tue, 16 Apr 2024 04:56:00 +0000
Message-ID: <tot7ywuqv2iwfu4wdkjoux55et4j7imu2yruq3qf54rb6fndyj@kfuqvhn2v3ab>
References: <20240322135015.14712-1-dwagner@suse.de>
 <c189008d-b07f-4930-86df-4059ef4750d6@nvidia.com>
In-Reply-To: <c189008d-b07f-4930-86df-4059ef4750d6@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6608:EE_
x-ms-office365-filtering-correlation-id: 3573f1b1-2086-4032-3cbb-08dc5dd18324
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yBeZnwFUSnj0GBe0+9ZlsrnhYxmIzYS+af5qmUBvLp9yjhlHxJntwePjfcUtVi1FJ1djPeWbmrUv4UB9OPrFAjOoOkhaKRkBFxCRkHhm9uP4hDf749u4Tv0vNLbwLEscAnhnRF1uwfXnVY7pTL1YHaEJobOhrifJlVbx9jegDQSnXnfTYG1dTzL3P1/NGjERgnMRuRoWKCgqw5lX0O+rMmOAkyoynLmYqhLh03v3mUT+bbFrIQMdOBWJ6dkY5vVUsN9fNoYaxcNM4zGRM9oR7PFzXEx2B3h4YeFE/XR6AtPw016crhQHGPAqn3FVKaHJLSaybZEvgJ3MrLBgGkEYPb4BdCwVOWCWBu0qeJIbz7i8RAW5NlIcW52fxQVEYJ4RLdUV6gjlsAGbbgMmjz5JbhWocnec9ELnve+CBHpzqG6YGKzrG6BIw9XBEPBeJXsfdKPNDX2JacsiTR8Un4ziw3Hcr6dCRg2uYzhjy1p0GyfvPCHYGVj90uLqPTBPstGjJ0BoBrh5FFcKeX1tYJCZQkQtefnI6YZyiPlKgjpXUSctRPn9NS/zo6OqPiJdO2FQ0KwMewnE9cXFAWj+lUUilMrunsrGku/+6dCj5FkFE7evjyZw5Cc3QhW38k8y1HPDW2jGWGvV6/mBWXBU7beQBofkpug36c0Zxls3ZnQIma/OjZZ7BuTfNCTdtwlNaBkwhUu0fcy23g38ecpWHZw655fbX5ZIhp/s7cc5R2WnBh4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?WAplXIrVwitVG/4M8/qq2eSbHZHZCqDwFb/uSN/jx57hdYI2C5vh4k1i18?=
 =?iso-8859-1?Q?sSgBjPGPssNA9/5KNA1G8KhfJLYOftrv7VhmgMxRd6j6j6C0KMQDB5/AVd?=
 =?iso-8859-1?Q?ekHjz1ww73NJteAIbBb32d5zyU0cIP6aZQOAiE4yRqUQOBLN4i/dCNo5CV?=
 =?iso-8859-1?Q?1FpXPY3gwr1rp9fqdr4fSaiGJq/PtlHbPBtZYp77I7KPZAcnDoJKFsprR+?=
 =?iso-8859-1?Q?p16aqmYrgByxM5g8IoAiCorlJBspc4hhyMsFjYfwSW3P5CBUVizq5kwd/c?=
 =?iso-8859-1?Q?5eoojLK+5A0roDirGzhp28pa95yKITHWVYEJ/aOl1awM/1/3GHbKLSTjZw?=
 =?iso-8859-1?Q?tpszqLjQXi7XKHEHGswuOSFWPGbmX5pMSADTijTgVe+zoesyU7kv73Fbv/?=
 =?iso-8859-1?Q?eF/3rUlR6aA9jmxKKHPOwE+pwf1yX6V3FDE+RWpI+MXT7Dk6ivCCeTsJjd?=
 =?iso-8859-1?Q?2obaw7e6N01RTlvKW4b2YX5YZSPVhqEffKqeZ5UkyhvucTUMPG0NwdJUxi?=
 =?iso-8859-1?Q?kWM3HA+ak8srtNcVQuWcFr5I77C0S4DnlxuraOK1CKBieud/HQFTl9t0Vq?=
 =?iso-8859-1?Q?GLz4Ud2tI7rJv7ODAdkQIqdJazZ+5W0hjzgOay3TNVgC6cxpcwdKPExUIQ?=
 =?iso-8859-1?Q?k4H8LFpnbZZgLdyhtGRBqccgBP7TVPpBYmoiLH+i7JUhfcenncgwtR8r0B?=
 =?iso-8859-1?Q?n0puno/tNd2P5lpq1rOb0OleTWCO8dbBtHDuLMQdRTHWoukzKrGfWnpJGj?=
 =?iso-8859-1?Q?WAOgcpd1pNO70XrRV5lKqepDouS02MUNpE6Ah7Lr9bzRJtW7v3wuPDfAzQ?=
 =?iso-8859-1?Q?Tnii4xDjyA/ORidbO5miGDH84dXUQejze/qPNeoaJocSTiCfR5xxJAWLho?=
 =?iso-8859-1?Q?Gg7/aYhIa/wkV6j/HmwiYaBxRIDdbWSpo8Bzdtj1lPIB8IJow0NDKckFjG?=
 =?iso-8859-1?Q?ANk8wMKAtRIpYoy8rVBeja6jhF1vbLGHWWazCaiR3zy8PEuIdpcH+Rg9Zw?=
 =?iso-8859-1?Q?pEqzQ5LuBRwfBP8ss8lzcK/aHRDkKELTrerzFOSo6u2bPvOKeoHGE1aODx?=
 =?iso-8859-1?Q?jbs6Gbhok1M6JgcnX8zECvHEWD/gxjZ3xmg+/G/vur/Eu6bs4yGuge7ILr?=
 =?iso-8859-1?Q?zh2uk0SLAKvaViSw+d5Wz4/rC4csZYm+EA+xylzcjN3UUXQIKktQfXiZOY?=
 =?iso-8859-1?Q?8Ho56hHGsiXHC57f9GoelKeZegmnrrtj6kO+CcqPD+b8av4jpFEGOzVaGy?=
 =?iso-8859-1?Q?dIrBc0q3qEAGwi0AvztvHiBNXRE79ZKT5drrzvYfNVfW0JnrsgwH8LXTWw?=
 =?iso-8859-1?Q?H6LmQkGr21NOVNj82W/tbvxC0muIg8KF5nxcgbZOijCrglS0IYQc4OgQrq?=
 =?iso-8859-1?Q?ok7110+DFA6w0X5yE7XP+Lx3b/m4mm2c7zPHQQN8pSzS87LeaVOGtkvFUf?=
 =?iso-8859-1?Q?jnBeQGd2g0oErZJocysRQuKV8YImfyepAa5piIVjm0PUvoIKQpK7TRjn+U?=
 =?iso-8859-1?Q?/VOSmvdSk1KX5tfXNu+l/e2jNkIgQKAsdFzLpBxwb73iAE8nhP/OLUKswS?=
 =?iso-8859-1?Q?vnl+fm67FpHtF090Nvo94swWtrpqzowCB2j+vBsGQ8VpeM6IWJgblHo5jb?=
 =?iso-8859-1?Q?TCY73pJrM0GU/lxEg+/EzYNs3QdCnxILd0vLHDcY9ivHTadyz7Dd9r9tFh?=
 =?iso-8859-1?Q?BJFdgiGrILvrNdrZKpg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <B5827B7F479D0D4B8DDE5BE78A50B5F4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ihUs+t1Q3Yt7eXbgkNYkmzHe7A/bqjW658mlpi1FA35oUj/ZJFrUgqRug8HS+ClP9JJQPhhhdhrskWDlK7dhIx2LYPIGp+1Jn662Rl+uYGk0cVyTRiYQohTWY6s/ewKdCCMHRVVObJI5MmppbrXK4bK2ce3kbBf4dWcLZybhkCqPCoax/XBcCoURI6ezgztAO6wvINjRTE74g7/2LDtQHKRuPWa4FZvamBPTwFVc2KZSvZiYDodnp3/sE2nXFiboYLOteS52yY4pQzl/rDftxjoaeK3qZZtIqeEKfDbxzYPw+4UMLcfyYJ36Wqs4Fgpt8sCp1QJJyq0cKGX+ZGm4R2tqvvADyijrCm6tQXjT/fvF0Z50+QQbI19iJMsW816L/l3LNU/qceLSuxmX0NLHOOx9DO/FNOH3hkPCEEEd3I0vqHcQeKjJsqcXnY9F4KEGANUNO3TLjR1fvQnXtXXXyHXybwoMZcz/uU6t/Nr6NKsLqu72ES/pU5RcuqnQumDCsWZApoz5owPu6AdmKB8+nNBIA0IQBCHKgXC7qwQASobfnb7wteRkLdR58tNXzTVQFRVYxuZMHcZ+tF0GuiO1YVifDXg5HBzu6h/Umr9quSg6l6wsC2KcEH6+MbSMVGjO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3573f1b1-2086-4032-3cbb-08dc5dd18324
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 04:56:00.9419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MEqE5QdwlI/98ztmVdWQYSOURHUzy7E5v/K288kkVoIqMd2Vv1XQi5LENWE7zcfEO/ubYiwfto7EjQqZ2FEySfnjoru1poYOglVGU536mqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6608

On Apr 16, 2024 / 02:50, Chaitanya Kulkarni wrote:
> On 3/22/24 06:49, Daniel Wagner wrote:
> > Updated the series to include all the feedback from Shinichiro.
> >
> > changes:
> >   v2:
> >    - addressed 'make check' errors
> >    - squashed 'nvme/rc: remove correct port from target'
> >      into 'nvme/rc: add nqn/uuid args to target setup/cleanup helper'
> >    - reordered patches
> >    - added 'nvme: drop default trtype argument for _nvmet_passthru_targ=
et_connect'
> >
> >   v1:
> >     -https://lore.kernel.org/linux-nvme/20240321094727.6503-1-dwagner@s=
use.de/
>=20
> overall it looks good to me, I'll wait for V3 to provide review
> since Shinichiro has some comments on this one=A0 ...

It's good to know that this series is okay for you. Actually, the v3 was po=
sted
on Mar/26, and I applied the series on Mar/29 [1]. So, it's done.

[1] https://lore.kernel.org/linux-block/6foqfrw4amrpqoaiov6tyr7dhlnlm5tpeb6=
unfxpbrvsc6zals@lcbxl7pljbso/=
