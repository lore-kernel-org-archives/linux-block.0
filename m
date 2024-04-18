Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B422621103
	for <linux-block@vger.kernel.org>; Thu, 18 Apr 2024 06:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713423029; cv=fail; b=mmP4iU0cQLMEYHwYRBz+eel6o9EArg8rq7W2aj0vTd89iZc0Jvimg4D1fj3xSHo332mabsZ//rgY5avovlmQnckXARxNNSK8b8gg8cND9MqT7WzyEas2n5aaCdM70Wbq5zdV3zXQdNFANwRhZ3ntV//NSzw+lVlv7dQj7UL/6uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713423029; c=relaxed/simple;
	bh=2lXJjcIGqoNiaL7dYJETkM24vEXA/x4qy6zzGx/P7G8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i7Txwfn4sN3G3XAyHXXUFZk+OLl95jteZtiKPcoxRvtlqE5gJHs+YMSMQl5KoDgd85/liPAtgKwDyt43gwA+9PUNRivyiIpf+VrtnkOdVz+cOzYPAA/8x4Pb8VvCy0WXHn4wzt5j4I5pvQ9Ou/QzAGORNSAqgKK/a76pg9P2TgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bNdpOzIl; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=FGQJBiKz; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bNdpOzIl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FGQJBiKz"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713423028; x=1744959028;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2lXJjcIGqoNiaL7dYJETkM24vEXA/x4qy6zzGx/P7G8=;
  b=bNdpOzIlv3RjUj/83u787bwRqs3MpbNQW5GbTAuGV0uz/JU8+4ucswpo
   cbN1Zy44OuXT/OXMWkGkG0dVwj6qROHebGOZw1j7z7kOEZvwJiAzSUzCo
   2H1oMz7goPM/EvLmcV+WEXFZ6Qogi34MW6cAKflY9u1398hKFE1Lkrw2A
   f4ffrBKWlB6xJt2houBg2A3ReHxXyW/0AMuehHoCqx9IAN/4LINGlUrrY
   r1xEgBseozkcp7pK24KEJEipELd46BF438oOdYiayb9EFZqickYF7U+4p
   eEEfoc/v0o8BY0LotHThHxWS74Pr5X38fMq9B+eVfJKlhCYJyiBhipMLc
   g==;
X-CSE-ConnectionGUID: bzlCU+cuS+u0L/ViP93YKg==
X-CSE-MsgGUID: gBMlq1pbS66k77i1zP/JGA==
X-IronPort-AV: E=Sophos;i="6.07,211,1708358400"; 
   d="scan'208";a="14081894"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2024 14:50:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YW87RsIdLlU/+rKUD4nfJp2UlVSy4Uer69StiSkU0x61rxtuqK/HTuMkCq3EqIybWneItog4jyca0EbTaMHQTkHMIEUfuraze1s0pH0x+BV3QD8AP8s+NUEC7i16R/GQO+9DiZPo9r4+YmKKOcdXOPK7i3aEPIg5ovRNeebLXf9kFLH/8+G6qvtHpojT99gAj7DlDn/tK4Lpk2tjIFvW/3IDoN1YYySGmdkKVFAvRLbkQAUeO/ioDVD9iAa2GNRzHdfpZ/TzMjiPXSR4LBssNLbA/AVAjuJR2JFN+xOS7JojTaPSsF3DJjQxGFj3lK1OuQwPrTshmg/Rh6iN5nh57A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lXJjcIGqoNiaL7dYJETkM24vEXA/x4qy6zzGx/P7G8=;
 b=Q1+Kb5FtMMKt5BOhGglFWMYG0AU530hLfyQ2T3Cq1h2MD1GyQwMVaVeRuwBhBfzgUhrAsICXP+wYJcUmC855Gm0pN1Bxo/VWyDv/aBNThLE5p67+MXxFJS0KMOaIAmzc8Au7CqL0BGC9X3EKSnEwjDkBGqb3r28AQOASIPeL/eGVy/cV4pCw4XMP/Fsft3naCpLV6Dp1jN/kL3r+3/GGN3GC0FNTc3rboPtMaRqHgg67JsSdcjtfMDKsqRaGqhGkqI+y2ozDtO4Qhch271ewqNqc94TZPAINBJyExPF/uFLoY6aUQqymjQmo53wZNW9Kg46NxTdyaq2dh11wlCL9RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lXJjcIGqoNiaL7dYJETkM24vEXA/x4qy6zzGx/P7G8=;
 b=FGQJBiKz/pqNAo2MgU/MCsuQ3sDtRpj3Eh05olmSJFOPu6ZDMI4UTYMyWrTbfr3ShdVfM2Lku5NSSXbFn9ntHImuApr8rIML+hrfuwtsoao6Ro35VMMrw1l5AvmonjzKXv+zAAdpZ8wI2poY5znIxuWGwdG8VNUFIJnIAUCzX/M=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB7123.namprd04.prod.outlook.com (2603:10b6:a03:227::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.40; Thu, 18 Apr
 2024 06:50:23 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 06:50:22 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Ming Lei <ming.lei@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Changhui
 Zhong <czhong@redhat.com>
Subject: Re: [PATCH] block/035: add test to cover blk-cgroup vs. disk rebind
Thread-Topic: [PATCH] block/035: add test to cover blk-cgroup vs. disk rebind
Thread-Index: AQHaiOspDHzPtxRW60ySXdFP/g0zzLFfH6yAgA6H2oA=
Date: Thu, 18 Apr 2024 06:50:22 +0000
Message-ID: <ybhcglijxfwwvd5bnz3zhbgmkgyqoepknvptatxg3l6bqeuaxx@at62eb5lmqmu>
References: <20240407125717.4052964-1-ming.lei@redhat.com>
 <xskkrvbacbubmcbc2tamt5aa7hepvt37y6kl7mz2lqvgswumb5@6hqkngrepouo>
In-Reply-To: <xskkrvbacbubmcbc2tamt5aa7hepvt37y6kl7mz2lqvgswumb5@6hqkngrepouo>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB7123:EE_
x-ms-office365-filtering-correlation-id: f97ae51d-ab86-4c90-2ad1-08dc5f73d206
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 gvmJ7xUg7HHzFH1rY6nRMZQTn4JQP0Nnj9X682Oi+xEdqy9lEeyDfgN79kwtlosou+MzDHvOM3iUDiuf+zCrJHAqmdNrApyQomzhkBBCgHtHPJjHbvhmV5+Ev/SHZUiKhL5bBJ8fOxoIjxK5gVT70/4IQNlpaSXmLo9Wci/pj7riaYGw1onH7Gog1wJZ/ClqHu7vi3uCTg6PwjXrDfkWDqlrxnr76yy+S4dxbqSnNSGZqMeiycPZw3pbYGikn/tixie3mJLYBqJgWRA/+gE5Kpm2FWkkcHnpm7MST9z2pPPQXz4WkfddorG6I9Q1Q+0fYQ5tjy8Jz672dgew2aLOBGthXASOINsz/gk+DVWddbIiHVrDAXVelTK879GurWjrToTozlGFsLcgDMbw5GwcE5jUzVnJpmtsvq5NSpYphMprT+s+CYZmbnByWbSGDdbBWSFQvB5omlCYizbKq281GbzReHqH7L4lgbvsUHF9hjE7gGt8a7JeWNrMBLv5dGOTO6TL1iBR2JwUmEcMQ/gooKL1IRCLrmM0euD0/cIDCfRnS6xoDfsrb5ulxRLgy+dJ7V1cuKEdAy536+nRydKrTrHGj1nOR36gwxCJfHZfcKKIBJ7EfmivZag9azSTDqePUBgWbyQNsp6O7tbx/uIXJ88C5SGhRUX8i2W1zNU8Ss2BnSOzP6G/R6gjIJeUBw9LBMwpe+SCMRMbZK6KeHzFe7PFht+171E5MDFgmUATWn4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rTwub7Lkivk9OK9G0V+63YNfATRGNFos4A2/rzDuBCfhjquVPfp+TsVLuDhf?=
 =?us-ascii?Q?rZqypvAtm6bKUZQldiK63cDyW25n3foTtinu1gzDov+9rXczXCmS5jQS+504?=
 =?us-ascii?Q?pdXtZ+uNRJRjqEV1COLqwTaJMEkAOTgw+FjByP0dgTdExktnV+jiGMPJ28xn?=
 =?us-ascii?Q?4e50P3RyVGpPWu7jEDkOBxRIu7o267k0wMlYUFrUzqWVj3wEjAoKH6ri+Om8?=
 =?us-ascii?Q?jlevghaIFpqnOyTRj5YXGqs2ZzpG8+4NtWJ4FB6pPlabOX+aIct3q/PZlq2Z?=
 =?us-ascii?Q?kIH3WZahE2K5wYOjA5ugj1+T37GNzBl36oHX5iFYkH3u9fQhwqsUjgl4hdzC?=
 =?us-ascii?Q?XdX57vRseifmlWlxxXv7qtuu+YNzoeqq9TZXKAHH+lkM+OBqMSLBN6Caf+Vj?=
 =?us-ascii?Q?1SocAIzfg3xyTsu7SDuY9mk7kSyKTL/ppd/H1tZxnSWwbujZdz6V0HP8UYEH?=
 =?us-ascii?Q?SnpODHCktnqzcjJVAml4Vqg08IRreJPwOVyd3JNhas4xE+F2rv0N71Kh85ws?=
 =?us-ascii?Q?saOI9WqJeTupNAScIlZG2XV0+wBUpls9lDMgaxG57MOMxPUtPN9YeJVQTzBX?=
 =?us-ascii?Q?C27PEWN7NVWjST59UA2gG51UC8R17ZYeMounDjSKuXk++7J7uIIKPudeACGq?=
 =?us-ascii?Q?5PSoB7tKCs3By8/UicMT60MAUFgw9T03aFJJDFR2G+NCMSN2ybB8tZKiPO36?=
 =?us-ascii?Q?hp/BpueZI7kNufE0ex1F2B85BI7q50vrxKVARlId+3sTh3RSMOEyB6q3/pYd?=
 =?us-ascii?Q?lGqaXyMQFJSqIxaMhYbc6z0hKUEAEzVxdNa4g8N+wYvWoD+wB62ErcAWJtht?=
 =?us-ascii?Q?KRvpRIMUgg7UlTWCHeADgZFfnI2TU0tm9l/k82ta1e5oA2coVbS4mje/Hl1f?=
 =?us-ascii?Q?gris2T2uAtn3BBBz7bhKNsFAP+IVKF3Mid63N3ah23hj3mHqPaEwt9asVNXp?=
 =?us-ascii?Q?PASwGgTHmADNM3VeYxqPRM4/HfFXH0dLurPlpB8LyxjYTgiI5Hy3pI7zgiRg?=
 =?us-ascii?Q?WR/RxMt2Q+MMOB6ZfyR2KYZpskcibqm8C7UDzGV6ZRQvhTLsJIbzX4blykuF?=
 =?us-ascii?Q?rDfBbWDsDzS7Uk5uwt8FLX/1dE0HrZ84+nAi3ChTSNF0e0WRxJzwbPZnVG/+?=
 =?us-ascii?Q?PLDQRoJ59PmiGH8XoRE0M6OVHclphPoZs2EGVPmXgIUqA6NvjgkYJc02BNxl?=
 =?us-ascii?Q?GnO3Og9BDeWfPB0SY9OmZcx0w4GgiiazoDUy/pLEblcK0EnL/nZ8kazAiLm5?=
 =?us-ascii?Q?ONdKmult0Pd0Qp5FtJL+RPTTfRpzHNVlmohYkk7/go7sTNdQ3JKscMA4TQ38?=
 =?us-ascii?Q?0/JT0Uxt/QqFPZMjIbFW+u1FZnm0M0mcUxkjHo3zH/xjyfOa4dc15l+FF1uT?=
 =?us-ascii?Q?klkFTurBT6yzQezMaFGAD2VfCj6tXyOoMSNw8lNgOAYXRF9IsYuSMkiKy9QM?=
 =?us-ascii?Q?CRrAcbjXTPcEjRre1vZuBiAWAwGFBP0pjlK7YY6WHJNWtSQIrEe4uDFEMuCd?=
 =?us-ascii?Q?BocLqiE3lGPETZB2iJ4Jq/JPma8qEbvyd7pzfiPpLdtuHSa0spcp+Zb9D33C?=
 =?us-ascii?Q?oXUsrKeNxj1Js6AOJUlmsO1pDIKfYqkgZKVgnWKfsdDd+sZYTNcURkqFdTZO?=
 =?us-ascii?Q?QYDdTcdMGL+3ZhjJ0zEEmJ0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4BC071F23DE88948867AE323FF44CADF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2vKeu4/bjJHkLew9rZUrsNW3i+K2XWyKSiiPuSrvVlgmEVId39f4m9aWDAWstrYhQmE26LKlLVdjkGlFnukAl1hBLEcUbobEPYYrVfz0X71uSk049w7IDY2Eoiju94FFgPI3t57VEPpA/HFmKqQ45SCji+Y/6ckhpSfrn+rtNW/sTwhGjom4U9W0VHiUk8HHyRc3Wj8MIBI3n5IWHrq1WRzXGOvSfR05j1t+IjECFRH/aiV7Ri4CGRV+mLjHTaeW3ZLeb/+yQj6CAbxcZICAco8kE+ZSTW9veHFScYl1tOgeG+Ja6G0bbojn2qOQxOCEr231ANU1kUUKPt1b0HjRWJhnb77fs9wy11vnG4nMVuWBB5SWdGi0GxFOZKXohCdshym5uRxWwD717kK7vyyiMXJpgneyBOA+gbJ847jaO+VQo9sGhHSMxNHJ+mPIVsXtRri9Z0Qb6NoVsBqxVU99zLJyb8/hDdjNdRkEyPjjlDK5FyCZqJuvolM5kWqiiQUYReHQMsAopZjvP5Xlb7NThjIME24Rlshh/4Iw0vlSkb2jCmNLM/GdnM1rnOonOHI6eYEn4isHJ/ne4+5h2u6RKLo1OWwjOq4yznXeyz7x+Xn1y+vs8Rsgv9ZoIsEFrV5Z
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97ae51d-ab86-4c90-2ad1-08dc5f73d206
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 06:50:22.8840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LQRf/ieQAeKY0U4M8Ypvvj23G5CkYeIGMfWmzGv2FdVk0fwTH9Z4ums0pRw6R73xRLvOl7mADdEF5y46zQKOIYvwcBmOkhBh4DuqILzb+w8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7123

On Apr 09, 2024 / 00:56, Shinichiro Kawasaki wrote:
> On Apr 07, 2024 / 20:57, Ming Lei wrote:
> > Recently it is observed that list corruption is triggered when running
> > scsi disk rebind in case of blk-cgroup.
> >=20
> > Add one such test case for covering this unusual operation.
> >=20
> > Cc: Changhui Zhong <czhong@redhat.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
>=20
> Thanks for the patch. Overall it looks good to me. I confirmed that this =
test
> case causes the system hang with v6.9-rc2 kernel and your fix patch [1] a=
voids
> it.
>=20
> [1] https://lore.kernel.org/linux-block/20240407125910.4053377-1-ming.lei=
@redhat.com/
>=20
> As I commented in line, I will do an edit when I apply this patch. No nee=
d to
> respin this patch unless someone makes other comments.
>=20
> Before I apply this patch, I will wait until the kernel side fix gets
> upstreamed and then downstreamed to the stable kernels, so that blktests =
users
> won't be upset with the hang. Until then, I expect other new test cases w=
ill get
> the test case number block/035. In that case, I will modify this test cas=
e
> number to block/036 or 037.

The kernel side fix landed on v6.9-rc4, v6.8.7 and v6.6.28. I have applied =
this
blktests patch along with the edits I mentioned. The test case number was
modified from block/035 to block/037. Thanks!
