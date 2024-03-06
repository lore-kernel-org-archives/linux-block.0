Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6329952F6B
	for <linux-block@vger.kernel.org>; Wed,  6 Mar 2024 11:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709724533; cv=fail; b=uAWLQjQaYCir6LDTC9+iECHAB3FYzxTod5DBxzFAO6Lzeqh5ukbIMwEibCuLcWC9Dzhj/ZhhN2bFClq0b13Jn6Xmx60u80ELs3xEJN7bJu1FZBYCecBIlkZjBDiPyVXmw27YaJZZk4GPhu5RUUF6tHDSvCNaYQaO4weYwj4+89Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709724533; c=relaxed/simple;
	bh=yiXWAG4gVs7qk7aAiRek15UmOOwD/HnL5Sa7FtKB6N8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f+jv7H+fsqb44QqvgvijJKH5DIKCnAg00AIYMskySOLKJegwJo4eXBUa0i7yEHX9z9ZwldORLml9k4OF49Xi5VGGS8TZdXip7aGIdM5qxhLm2Su7afi1M1/ygmwzQ32pqwGTzTNhgI+rfczVHqt4KKK9Vpxbjzx15/NT5OKBcMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Hxeo+8f9; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=IcWKjqVS; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Hxeo+8f9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IcWKjqVS"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709724531; x=1741260531;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yiXWAG4gVs7qk7aAiRek15UmOOwD/HnL5Sa7FtKB6N8=;
  b=Hxeo+8f9phjOP554VXJm6n9RbcWwaEXuyRROr9lj5sxhDxdL+4St/Acz
   k3CgehfABlAw5nRTbUbHwmLKef1flLII9jogd3jufR2Q8K/CcPZ4Nhh8K
   lLVZRHlMGVdu66n2ZUatGeYLOR49wGyAiIZy292CsvLlV90tFL92svuGG
   MS0qey/RxasC6z8/3cb7Fba8gHs2ZQbRSOwJ/P6AKy+8Q3nrqdjKcxa4S
   2hEdo3GQ1wDWn2ntdQbMO97Wfat76W8+Kv29SDNSzW1OUC3M5yhb+hKfR
   7a3XjErWaOxQpSJhdIcahEZih4j869G6vlA++zb0VYHcWv15VKoiuiiP1
   g==;
X-CSE-ConnectionGUID: wXN6y0uWQr6kfx8Vftifkg==
X-CSE-MsgGUID: AQOkRPtjTFuI9MCd95kOnw==
X-IronPort-AV: E=Sophos;i="6.06,208,1705334400"; 
   d="scan'208";a="10909550"
Received: from mail-sn1nam02lp2041.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.41])
  by ob1.hgst.iphmx.com with ESMTP; 06 Mar 2024 19:28:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqvT6L+jCvHBR3ExjmrfpO01rexCDfRAffDmvYV0VnaUmpRtfzydKszb/PSjRADHzZEFu1t0cW4ZUq2xxa9b5mkiNEK5MszG3Gs7e0QwIKnODfUoBXuwcxhTEELa8L51/orTZ2jpiu7d1nq39TIecYz1ewFYRP0C28wvR9zKhkKufDFqKwoY10m/r+C5IQ03YhVagwq9bPt4XvX0nJMkDbJRc70gBaRrfU/0bSBQ2s7kKfrRkdXbtTCwrIjID7vpTaqqxAjoYFImMj3d8imTuCN9VaZ6O/eA2FGsRcitECf9XAlbjrMQGx5Nct4lxXYzXaRJziupAULLToDU3hG3fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjioEQcOXvIM5w7u4WV/z+fMCcj9uhd8IxTWbgHB9Ag=;
 b=OBIC4Gqbo3Uu77JDrHuKdvgYoYwMfOoeVY8B4m4UNYvA0IRgemibWSo76+2lc1SXfi8dnm/wORwqXm1l0+Wz8EajIWsFbi+NamMWH9xDbbJQp/gYurgYkP1eNkdZzbCkfWPcm9+EJM2uDfQ7iH6bMXH29EYRsiUEYJSjKrDVaJb97m1Lyjr7mDexRjfUaCdMzPJWgxgzlGh4wtXl5pSN1nPLh93FhMSgpdy1hHo7iG03OraofRildrINwpoHVtKxWqrdmbMWRZ5D9UfjvLPh+fe89+iWXURpmesplysLQV4JMOaalq6k3/x6/oAE+3Ap+DVttxC2liLWUnT+DWVb7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjioEQcOXvIM5w7u4WV/z+fMCcj9uhd8IxTWbgHB9Ag=;
 b=IcWKjqVS8qjIUMk//MWNSh2k1YYJW3C2lSAqFx/Ngcvn2icd4Cy7UnVHVR6MBuhae2Snku/N1NSLgeVRLQTlUki2lLqsnmC0ZsLQQzaSeVtO7jDf/Tlu67HznuKpIjJa53lWe3+wio2a8engY3vL5WkkCPy2iuW3+hlqqj2XZSE=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH2PR04MB6602.namprd04.prod.outlook.com (2603:10b6:610:66::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.39; Wed, 6 Mar 2024 11:28:47 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b%4]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 11:28:47 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Keith Busch
	<kbusch@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests v1 0/2] extend nvme/045 to reconnect with invalid
 key
Thread-Topic: [PATCH blktests v1 0/2] extend nvme/045 to reconnect with
 invalid key
Thread-Index: AQHabk7cqNwSTpUn+k6UjReb5QwC+7Eo5uSAgAAaOQCAAWdbgIAADnKAgAAfXwA=
Date: Wed, 6 Mar 2024 11:28:47 +0000
Message-ID: <hl6dhx2572txyachqm3n6awrcksiqoxevq65rw445odsvcbhc2@uykpx5glx5wu>
References: <20240304161303.19681-1-dwagner@suse.de>
 <2ya2o6s6lyiezbjoqbr33oiae2l65e2nrc75g3c47maisbifyv@4kpdmolhkiwx>
 <p5xkwz6i2lfy2a65pbpq3en6wh57y75qcoz3y3eio3ze5b7cm3@zgfn5so4yuig>
 <bax2kpeovgvf63rrtycsgpbi7wmvjhpmcbfcpoznldkowczom4@czjddqccdsba>
 <aaak4yvzeewwhaepcrqk35et6qxkicg3jxvwijavbujisse2h4@36dsv5gl6id4>
In-Reply-To: <aaak4yvzeewwhaepcrqk35et6qxkicg3jxvwijavbujisse2h4@36dsv5gl6id4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH2PR04MB6602:EE_
x-ms-office365-filtering-correlation-id: 1f676f4a-0492-44a6-b49a-08dc3dd096d5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TER+teEWwBTxttBjCh+wAKCmgRzehYbgCk++T3G2VUVlvlEzNPRG+ijpVeR5Zz//z/4x3GKXK0ZnggPAEkriRvY+t0lyjjLw0GsZxHeswYHMw5x4Cx8HJou0SPJlzhrpwtUK2QOOVY3L4cZ4rFD7Q4oYo4jpEzd0RcCg3o3hGcIzdUpQuiQUUwqDQI0ClmxV8rSYDIpVoQFarIe8AAQtZAcOzeNnHzNljsYFIwK7iWeiTHluqVlLyJQy1Pz0D4SpcC+2StsWwcljuAIdIQ0M7EJGF1iVTkatIpg3f7me3jWk0dQGUjnk9VnIXVuJcEdbIykJg2ZL1zjE3TC6OvWvPVR0rM9+CvoGEEoE1zyErjD0yxCGtexkOztLHkl6rFt9PYlsvFzepACV8AU2kmpVw5t4h4MiYvrw80ek8tSZBZNdnKnEyYbPvMd2VZLZNEeFzb1GWGc9GA4QslHPJVKUcnzMEHSsqMzfKwem5Y5WKvHnu22V0iYEoG8o33uGnALu4aj3OFIozQ4NErnxsJMGYXWMeu3N5jaSWExTLyv0Cv8fhlaLJYFrHzqrpvrZRHZNkpN2amlwX+1En2veWRaOvmm0WknwDgbAXqUkoQ+/rPyZlDKR5bojMoIco1rEiH3rv+iUbEU06pELpMz5T9p1Eq5MGAwhxVpvkdBprpykyBY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?S9z+uB1+3XocHQUf5vl7NJzsbW89O44HUzhWlhKKwyIWqEMWZxvcBe0vKgZz?=
 =?us-ascii?Q?F1MRzB44bsIl4O3jKocAvkZ8FHi6+fh3JJsv1AyoFWZW/ZX95/AkRhxUyRDR?=
 =?us-ascii?Q?OTU2zLaDaP9GZNqA6WjsPEhHXAtPNqtYVLzL6K6oKS/j5tdWAuJaxQdgmFiv?=
 =?us-ascii?Q?Gxs3gQA1DNulz8JhFduLilR9G3wnak/TDyfJMyq4rfRM4xez6HDdTIFP25nI?=
 =?us-ascii?Q?yKzEeyGBRgEsT0w4lQPJtImSgjojU9oYn3UFbklF3meyO6JRmXHaXOOLyGN9?=
 =?us-ascii?Q?Ep4Ngn+KhZsC/zqTucTZkHdzpbPzNe9cwUBlAFRAuE2HQpU1SCc4TuZNxnmI?=
 =?us-ascii?Q?91v5ieQkdAHC7rJISKrDhwBA5pwWoOboupoNLq8T9w+YbwhYS+wSYt7qScn/?=
 =?us-ascii?Q?hNXPTRhZY+71swEkHIY3Ybrc7XQKzE1ou634ehJimVMBMAvXofZJTiQb01vq?=
 =?us-ascii?Q?yHhtb+KSsAbwmrDzffGMzKjqSUcuxDP379HXT9WFtHv9Sty0eagvSitfKD2a?=
 =?us-ascii?Q?6uMs03sdoNjgEykRmpqrBF4CdjAoDaSaN5w94250tugbETRLjHzU8DFTNxlk?=
 =?us-ascii?Q?S8xDmE5HvAYb8WQ3HK0mAaDZvRiWBiVMXncf9b7ic+4tKZ8FVIU/pPS6hFvL?=
 =?us-ascii?Q?3xBJzxAvAUPDCVYyDTZvzE0ZpoXcI8PI8nyZIoCfutmX8tSsy6asNIejRugr?=
 =?us-ascii?Q?YEx0lQdbXfeT8A+fIqH08B5jEzUL3+aVCks16yEEfK5IxDQRnEo/s5XnXApM?=
 =?us-ascii?Q?VYKsax4CoQb9XeUO3hAPnvhAAeghRMEf8DTaU17IgnUoHt+DZyR96F0Yfan7?=
 =?us-ascii?Q?KHHddHBy1P7pPfB9RjBhLtZp3KLxdxJ4v+r35w/FeFPN8Cy3KCNDHTGZzwMA?=
 =?us-ascii?Q?AvCnr2+8OqUk4g5xS1bkxrOEL7MwC2pAIxaCx5kO9NhDNVol67yx87eXOFkW?=
 =?us-ascii?Q?lMkxy6p+F431dIMzxTVB19yRvh6p4z/rfn9nuR88Re2JvC8LM9TMvUp29C5N?=
 =?us-ascii?Q?v8ckDyBvLfy7xZWNxW3fRANibOCqy/JIno5xVLeIzOnvWtp9e199pAgGW1Vq?=
 =?us-ascii?Q?N+rYEkA+3fAQamtCfuqy3wKdHWPvN5Re5+kYb60AS4Ro6v779ciRmYWeomfl?=
 =?us-ascii?Q?hFAnJMBLOdvpLLmgIBEG36iO/9rsM3jMjOKSbZMaOWEoY/jxYolNV3V0rgFW?=
 =?us-ascii?Q?h7iYyfjlzLYPUykQ+XLcM275kTWa/P9XQ4UfvSmyWMg2n37pLYvOmxN27rR6?=
 =?us-ascii?Q?XMH5j+QHwzVmcmu7yUm9t8lB1cSxNBQC1GJD52H30GmM8VJFK7NmbSMqqh57?=
 =?us-ascii?Q?LZtsZEF7+Bpmih4fWojfPY0SnHJ6F4zyB+i8jOHQPLvMJDCSp2SFz5lcOBGf?=
 =?us-ascii?Q?wwrfDUOl4MQkh5hxX0Z7v+qyWaLajeXf+Qd5t3mR6Mh8t/blo/ITL45zRPKb?=
 =?us-ascii?Q?wTyFwpu/on/F5r5kDQmFpLAaZyq7buBatSDjkTvK3ahRvMJIG6nPV1NTAOwU?=
 =?us-ascii?Q?xomg0SWqfyW5BrVi483c7ykkkE0mZ587IP2RpQQ2mHDE8K4SCdNalWMTRnGO?=
 =?us-ascii?Q?XS+yAVchsbN5q5C9l47JAU7e0aH+DAwgQfdUK8MHU/615vw0ZJPUcASbxTsp?=
 =?us-ascii?Q?UwKbyZvIS8rjTknk147+Jqk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A652730D958F264FA7448BF7D47BD4F3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uIPkT8docvzizxligk1zeR3+pG8M+RtTntahWXUIUkZwTrbFLocFEeLnQY2L7MFVKncVy+vGCUtip762QIEBD3dlPh6jfIh1gLbkiONkP0hPckR6aTH6uuX+t8AnC+9Gz65pSXiKU7cqIak4G5D5NnP82W4LZXX0RHUIA6g7XMtcuC6fVBWeBwiEUNUieQVVYNTSi9dqzlThUDVti8KvL4g06SX8sTvqoJh2U8kJWYvqVwGCrL+jGtzZdCbXA6PoDwdnC0wjV5wlCCDlw498cE3HqVBc0Yp5jZ24XyNSys/y4MXNN+aI8MSMxnLHMbEQiu1e5akz0dFDwt1uDc82hg/4JtIF7JmlurC4rzVe3sFPjvhRxHqBBUf2s1TXo0u7sonsFQDkAl+PAHBHMp8Oe1OgMIZGyAY1Tx0yUpDVP9rf+8kHQ8ngUSyDIJjdUGjZhuf7s1CB1LM0iE+vzyyhjsHx14GE3M2dZf3xP6FORbmSiKMLl4LKhN7dlToXKgxMGZ41b1h+g9QqUJKsZqxtbisdHiIUPwVt7AdQM/JzMzTh84xGiKKsPqyjk7yWQ866ZDMDWpVNNE86F8MIv08Sms7UVeT1EZ7MGOotR4aBf8ME86DO59RM31KlXxaV630B
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f676f4a-0492-44a6-b49a-08dc3dd096d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 11:28:47.2518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /e3YnJ3SJw+D0ozVfuoq3HsV5IYc0SuBhH6nkVqfJh8jrBljFudT6BlbuYHNcTyWzVto11AbyItCs4ug+3E9GSobNX6svVjr/zK7QOtrrNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6602

On Mar 06, 2024 / 10:36, Daniel Wagner wrote:
> On Wed, Mar 06, 2024 at 08:44:48AM +0000, Shinichiro Kawasaki wrote:
>  > > sudo ./check nvme/045
> > > > nvme/045 (Test re-authentication)                            [faile=
d]
> > > >     runtime  8.069s  ...  7.639s
> > > >     --- tests/nvme/045.out      2024-03-05 18:09:07.267668493 +0900
> > > >     +++ /home/shin/Blktests/blktests/results/nodev/nvme/045.out.bad=
     2024-03-05 18:10:07.735494384 +0900
> > > >     @@ -9,5 +9,6 @@
> > > >      Change hash to hmac(sha512)
> > > >      Re-authenticate with changed hash
> > > >      Renew host key on the controller and force reconnect
> > > >     -disconnected 0 controller(s)
> > > >     +controller "nvme1" not deleted within 5 seconds
> > > >     +disconnected 1 controller(s)
> > > >      Test complete
> > >=20
> > > That means the host either successfully reconnected or never
> > > disconnected. We have another test case just for the disconnect test
> > > (number of queue changes), so if this test passes, it must be the
> > > former... Shouldn't really happen, this would mean the auth code has =
bug.
> >=20
> > The test case nvme/048 passes, so this looks a bug.
>=20
> I'll try to recreate it.
>=20
> > > If you have these patches applied, the test should pass. But we might
> > > have still some more stuff to unify between the transports. The nvme/=
045
> > > test passes in my setup. Though I have seen runs which were hang for
> > > some reason. Haven't figured out yet what's happening there. But I
> > > haven't seen failures.
> >=20
> > Still with the fix of the double-free, I observe the nvme/045 failure f=
or rdma,
> > tcp and fc transports. I wonder where the difference between your syste=
m and
> > mine comes from.
> >=20
> > FYI, here I share the kernel messages for rdma transport. It shows that
> > nvme_rdma_reconnect_or_remove() was called repeatedly and it tried to r=
econnect.
> > The status argument is -111 or 880, so I think the recon flag is always=
 true
> > and no effect. I'm interested in the status values in your environment.
>=20
> Do you have these patches applied:
>=20
> https://lore.kernel.org/linux-nvme/20240305080005.3638-1-dwagner@suse.de/
>=20
> ?

Yes. To be precise, I applied v2 patches, but I believe they have same logi=
c as
v3. To be sure, I replaced the v2 patches with v3, then saw the same failur=
e.

>=20
> > [   59.117607] run blktests nvme/045 at 2024-03-06 17:05:55
> > [   59.198629] (null): rxe_set_mtu: Set mtu to 1024
> > [   59.211185] PCLMULQDQ-NI instructions are not detected.
> > [   59.362952] infiniband ens3_rxe: set active
> > [   59.363765] infiniband ens3_rxe: added ens3
> > [   59.540499] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> > [   59.560541] nvmet_rdma: enabling port 0 (10.0.2.15:4420)
> > [   59.688866] nvmet: creating nvm controller 1 for subsystem blktests-=
subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3=
-51e60b8de349 with DH-HMAC-CHAP.
> > [   59.701114] nvme nvme1: qid 0: authenticated with hash hmac(sha256) =
dhgroup ffdhe2048
> > [   59.702195] nvme nvme1: qid 0: controller authenticated
> > [   59.703310] nvme nvme1: qid 0: authenticated
> > [   59.707478] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH for full=
 support of multi-port devices.
> > [   59.709883] nvme nvme1: creating 4 I/O queues.
> > [   59.745087] nvme nvme1: mapped 4/0/0 default/read/poll queues.
> > [   59.786869] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr 1=
0.0.2.15:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-=
b0b3-51e60b8de349
> > [   59.999761] nvme nvme1: re-authenticating controller
> > [   60.010902] nvme nvme1: qid 0: authenticated with hash hmac(sha256) =
dhgroup ffdhe2048
> > [   60.011640] nvme nvme1: qid 0: controller authenticated
> > [   60.025652] nvme nvme1: re-authenticating controller
> > [   60.035349] nvme nvme1: qid 0: authenticated with hash hmac(sha256) =
dhgroup ffdhe2048
> > [   60.036375] nvme nvme1: qid 0: controller authenticated
> > [   60.050449] nvme nvme1: re-authenticating controller
> > [   60.060757] nvme nvme1: qid 0: authenticated with hash hmac(sha256) =
dhgroup ffdhe2048
> > [   60.061460] nvme nvme1: qid 0: controller authenticated
> > [   62.662430] nvme nvme1: re-authenticating controller
> > [   62.859510] nvme nvme1: qid 0: authenticated with hash hmac(sha512) =
dhgroup ffdhe8192
> > [   62.860502] nvme nvme1: qid 0: controller authenticated
> > [   63.029182] nvme nvme1: re-authenticating controller
> > [   63.192844] nvme nvme1: qid 0: authenticated with hash hmac(sha512) =
dhgroup ffdhe8192
> > [   63.193900] nvme nvme1: qid 0: controller authenticated
> > [   63.608561] nvme nvme1: starting error recovery
> > [   63.653699] nvme nvme1: Reconnecting in 1 seconds...
> > [   64.712627] nvmet: creating nvm controller 1 for subsystem blktests-=
subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3=
-51e60b8de349 with DH-HMAC-CHAP.
> > [   64.868896] nvmet: ctrl 1 qid 0 host response mismatch
> > [   64.870065] nvmet: ctrl 1 qid 0 failure1 (1)
> > [   64.871152] nvmet: ctrl 1 fatal error occurred!
> > [   64.871519] nvme nvme1: qid 0: authentication failed
> > [   64.874330] nvme nvme1: failed to connect queue: 0 ret=3D-111
> > [   64.878612] nvme nvme1: Failed reconnect attempt 1
> > [   64.880472] nvme nvme1: Reconnecting in 1 seconds...
>=20
> This looks like the DNR bit is not considered in the reconnect_or_delete
> function.

Agreed. Let me share the kernel messages with the added printk() below.
We can see recon is true at every nvme_rdma_reconnect_or_remove() call.

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 507cbd6a3312..bfb23b9d5d82 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -988,6 +988,7 @@ static void nvme_rdma_reconnect_or_remove(struct nvme_r=
dma_ctrl *ctrl,
 	enum nvme_ctrl_state state =3D nvme_ctrl_state(&ctrl->ctrl);
 	bool recon =3D status > 0 && (status & NVME_SC_DNR) ? false : true;
=20
+	printk("%s: status=3D%d recon=3D%d\n", __func__, status, recon);
 	/* If we are resetting/deleting then do nothing */
 	if (state !=3D NVME_CTRL_CONNECTING) {
 		WARN_ON_ONCE(state =3D=3D NVME_CTRL_NEW || state =3D=3D NVME_CTRL_LIVE);

[  139.201909] run blktests nvme/045 at 2024-03-06 20:22:44
[  139.277895] (null): rxe_set_mtu: Set mtu to 1024
[  139.291307] PCLMULQDQ-NI instructions are not detected.
[  139.451087] infiniband ens3_rxe: set active
[  139.451856] infiniband ens3_rxe: added ens3
[  139.627815] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  139.647899] nvmet_rdma: enabling port 0 (10.0.2.15:4420)
[  139.777796] nvmet: creating nvm controller 1 for subsystem blktests-subs=
ystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e=
60b8de349 with DH-HMAC-CHAP.
[  139.789952] nvme nvme1: qid 0: authenticated with hash hmac(sha256) dhgr=
oup ffdhe2048
[  139.791053] nvme nvme1: qid 0: controller authenticated
[  139.792039] nvme nvme1: qid 0: authenticated
[  139.796131] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH for full sup=
port of multi-port devices.
[  139.798258] nvme nvme1: creating 4 I/O queues.
[  139.832707] nvme nvme1: mapped 4/0/0 default/read/poll queues.
[  139.874555] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr 10.0.=
2.15:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3=
-51e60b8de349
[  140.084928] nvme nvme1: re-authenticating controller
[  140.095934] nvme nvme1: qid 0: authenticated with hash hmac(sha256) dhgr=
oup ffdhe2048
[  140.096705] nvme nvme1: qid 0: controller authenticated
[  140.111696] nvme nvme1: re-authenticating controller
[  140.121209] nvme nvme1: qid 0: authenticated with hash hmac(sha256) dhgr=
oup ffdhe2048
[  140.121885] nvme nvme1: qid 0: controller authenticated
[  140.138435] nvme nvme1: re-authenticating controller
[  140.148513] nvme nvme1: qid 0: authenticated with hash hmac(sha256) dhgr=
oup ffdhe2048
[  140.149344] nvme nvme1: qid 0: controller authenticated
[  142.748523] nvme nvme1: re-authenticating controller
[  142.944154] nvme nvme1: qid 0: authenticated with hash hmac(sha512) dhgr=
oup ffdhe8192
[  142.945023] nvme nvme1: qid 0: controller authenticated
[  143.127665] nvme nvme1: re-authenticating controller
[  143.293304] nvme nvme1: qid 0: authenticated with hash hmac(sha512) dhgr=
oup ffdhe8192
[  143.294204] nvme nvme1: qid 0: controller authenticated
[  143.732511] nvme nvme1: starting error recovery
[  143.785440] nvme_rdma_reconnect_or_remove: status=3D-107 recon=3D1
[  143.786448] nvme nvme1: Reconnecting in 1 seconds...
[  144.834299] nvmet: creating nvm controller 1 for subsystem blktests-subs=
ystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e=
60b8de349 with DH-HMAC-CHAP.
[  144.990883] nvmet: ctrl 1 qid 0 host response mismatch
[  144.991937] nvmet: ctrl 1 qid 0 failure1 (1)
[  144.992655] nvmet: ctrl 1 fatal error occurred!
[  144.992953] nvme nvme1: qid 0: authentication failed
[  144.996695] nvme nvme1: failed to connect queue: 0 ret=3D-111
[  145.000090] nvme nvme1: Failed reconnect attempt 1
[  145.001717] nvme_rdma_reconnect_or_remove: status=3D-111 recon=3D1
[  145.003218] nvme nvme1: Reconnecting in 1 seconds...
[  146.116430] nvmet: creating nvm controller 1 for subsystem blktests-subs=
ystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e=
60b8de349 with DH-HMAC-CHAP.
[  146.272948] nvmet: ctrl 1 qid 0 host response mismatch
[  146.274869] nvmet: ctrl 1 qid 0 failure1 (1)
[  146.276687] nvmet: ctrl 1 fatal error occurred!
[  146.276891] nvme nvme1: qid 0: authentication failed
[  146.280591] nvme nvme1: failed to connect queue: 0 ret=3D-111
[  146.283783] nvme nvme1: Failed reconnect attempt 2
[  146.285339] nvme_rdma_reconnect_or_remove: status=3D-111 recon=3D1
[  146.287206] nvme nvme1: Reconnecting in 1 seconds...
[  147.395546] nvmet: creating nvm controller 1 for subsystem blktests-subs=
ystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e=
60b8de349 with DH-HMAC-CHAP.
[  147.563730] nvmet: ctrl 1 qid 0 host response mismatch
[  147.565628] nvmet: ctrl 1 qid 0 failure1 (1)
[  147.567256] nvmet: ctrl 1 fatal error occurred!
[  147.567411] nvme nvme1: qid 0: authentication failed
[  147.571022] nvme nvme1: failed to connect queue: 0 ret=3D-111
[  147.574003] nvme nvme1: Failed reconnect attempt 3
[  147.575463] nvme_rdma_reconnect_or_remove: status=3D-111 recon=3D1
[  147.576976] nvme nvme1: Reconnecting in 1 seconds...
[  148.676722] nvmet: creating nvm controller 1 for subsystem blktests-subs=
ystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e=
60b8de349 with DH-HMAC-CHAP.
[  148.842117] nvmet: ctrl 1 qid 0 host response mismatch
[  148.844543] nvmet: ctrl 1 qid 0 failure1 (1)
[  148.846369] nvmet: ctrl 1 fatal error occurred!
[  148.846478] nvme nvme1: qid 0: authentication failed
[  148.850217] nvme nvme1: failed to connect queue: 0 ret=3D-111
[  148.853850] nvme nvme1: Failed reconnect attempt 4
[  148.855425] nvme_rdma_reconnect_or_remove: status=3D-111 recon=3D1
[  148.857496] nvme nvme1: Reconnecting in 1 seconds...
[  149.873720] nvme nvme1: Identify namespace failed (880)
[  149.877168] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  149.927672] nvme nvme1: Property Set error: 880, offset 0x14
[  150.754847] rdma_rxe: unloaded=
