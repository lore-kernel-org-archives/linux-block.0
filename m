Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AB231A805;
	Wed, 11 Feb 2026 07:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770794986; cv=fail; b=EpbUv0CitlXZ46PXz4i3F0npEBDDk/tohT9CScrTtfQlwJ8dllgaBr0L2exZPp5vLvjGLhrp2qq6F08P+s7mQCK8isIJdAXQ48LbYdN6EF1zHE+DpoLogIEwjZD/MZhEsViFVpZMzfF3q0wlnQ5HhSXFHClWgdeLfLN6MJeFs84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770794986; c=relaxed/simple;
	bh=Xb1eRs25wc84VgqjSsj7QIOxQsjbh3RRAhPS0iuSRJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D3R0gbQ2uONf+gGUTR0yH3Z4djYx/4Ra0cF68mjJw2WviD/g/eR8pyc8PBu7pwvrNSaFNt8s6O0ha27iSf45NtPjx1oeLUWXzv8x4tDzEzRDYEzrqGtovn1HkwqKeJ+ZBLhrc0ncOgWoVHe4NqlrZBHpV83xoq1pSyGLo/rFU3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=dHATRk/2; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="dHATRk/2"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61B57P2t4111902;
	Tue, 10 Feb 2026 23:28:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=Xb1eRs25wc84VgqjSsj7QIOxQsjbh3RRAhPS0iuSRJA=; b=
	dHATRk/2rjQwwDkdv6XlUzkwvbQjPrDPytGN2inxOakUTmYQl+3+li+X1X+BqEW/
	iZ2Y2esfmmN7aT2j6GCJOcuO8x402e9pxF+MrRAJlUYwBKGmnp7Huia5U7Ka8/vx
	6giMvdvr5BgKXi2lDQFXxc27NEoc35E6/6kFTesVgxqtCwJlBECaPxQW2C9PDgkF
	UO5A5H88U/dSi3e9THwgMpVrPwxsJ558SxYCAIMdLGhqGkVOikVVLUlrhyKlTyQk
	mzvY++Gs07CjTNr0wjE4BaJxOVY1o+HcgIhISAmfxs3JYEFXysi+HjeCHqdKKL7k
	MwEsVrNlRXDW3MizfEXhHw==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010042.outbound.protection.outlook.com [40.93.198.42])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4c65sj418y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 23:28:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWY3Jy6Pn/bH11Eyv9CgB6J+Z4helNmM4opohtYhh26gqNtUcfOUctDFuX2MGHEEt8Mb+kqQYS5/Zcb+1S05yQRr2uagYOWg6cFWhowRY+7ZXE+VPy9xvHTo6TkgHfGQjQq8RUmw2heQ5I4c9gBcGZj7v3xiWmdLsicqtkYZL/ufyMV/iXBZcYGebRPcZv5QdnkN/2BPoqxY7n9RWE1AYsY4AL/ersdEWIM2hC2lBPydwVXmsfME8E4TRliMOfH7UDIuJBhw4x1aJ/j+ONkw0BngSBZuUHGSb5kPalSnSpk8oijaJpwwB7Jm3+IrRWNX+ed91rJsy3e0epnliv3dqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xb1eRs25wc84VgqjSsj7QIOxQsjbh3RRAhPS0iuSRJA=;
 b=bK8j6jIR8bdA3FHx7sImNEpP6CFTmxxQ+oEg6GLPrHB1nxp/9HHxHocGWgzt1WLD10taAgHZkxKcTsBDNzMkUIZrNmvbqi1tTdy50y5x/PG3iGXbWSXJTspiitJBkQVoXk07yCGBhtwiwODxWDILIEBi0QRsT/kTpptH0A5vrkjRWJNJZrqmGzMpd2KtNM9aQjX3d9zNQaZevD+79ZQetahiiwF58ODIsWaH7+YEjbzWHoo6ypIbDY9dkmIwgmJYwFd+hvQUHU5u9l3/DosFsDTLJttGFeLj37rz+iRN02PJXh7t9ewWQ6qGKiZJYY6ukJXJttC4DhMeSw6thpctsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by CY8PR11MB7827.namprd11.prod.outlook.com (2603:10b6:930:77::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Wed, 11 Feb
 2026 07:28:53 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845%4]) with mapi id 15.20.9587.016; Wed, 11 Feb 2026
 07:28:53 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, ming.lei@redhat.com,
        muchun.song@linux.dev, mkhalfella@purestorage.com,
        sunlightlinux@gmail.com, chris.friesen@windriver.com,
        stable@vger.kernel.org, ionut_n2001@yahoo.com, bigeasy@linutronix.de
Subject: Re: [PATCH v2 1/1] block/blk-mq: fix RT kernel regression with dedicated quiesce_sync_lock
Date: Wed, 11 Feb 2026 09:28:39 +0200
Message-ID: <20260211072839.61367-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aYulmBtfi3A9TJZu@kbusch-mbp>
References: <aYulmBtfi3A9TJZu@kbusch-mbp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0004.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::17) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3885:EE_|CY8PR11MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: e04739bc-93bb-4173-4248-08de693f3513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pg2dsLoav3oQfNkGmFnOfijhFF8TyjAsgAhYyaZBS1QGV4UGmLnVXjwWz1NX?=
 =?us-ascii?Q?BlYO+N075oHTYKFa76N6e2GXMDhXxt2QQQ0GA3GwYwlPvOYOKN2h3wGzh0bF?=
 =?us-ascii?Q?KT/cACP2wkgatoBdQMPANEsytz705I2ffB4GlNQm+vQxEg9ID7PnqRrmEyX2?=
 =?us-ascii?Q?fNLlEK0ooX7ltneobtoafXORe/lwFdTMqCR4WMD/+jIG+xHaKtgjHG6Hhjv3?=
 =?us-ascii?Q?HJjnkfpoKa8XNfK+CYvBpvYXnfEi5rcsEhOpPdQXgHMJcqyzn4fRN7Gqle2U?=
 =?us-ascii?Q?phabbtEKrch0ObrLYcVrokTxOyUz50tT3QRlA/ml2fZuVZOpHUDRkI2TMiaX?=
 =?us-ascii?Q?dv6EyZZnsJVAO4hOsLfsb1/XHEpEunUaBAdY7itdwAHrJSeduFhelk/Ro4+t?=
 =?us-ascii?Q?U35lwS08hreEE7jDglnAX3jceHXecmgCD+M5SnGLIQWIRNMAox2TJG+YDubu?=
 =?us-ascii?Q?LGBJp5IBCnvOB+7a/rK64wjHHLVv+azlhd/d5+QI+76/8a+8PnHhCMBqRuo1?=
 =?us-ascii?Q?NSW2GvVdonosMpLSbJXLg0pSa09HlxTF3vUfijfHMSLv7UNhyDTKkwBL4Hp/?=
 =?us-ascii?Q?F0ftJmiGboXojnSUgnVA4KzRcFfOCyjsucrgpEn3Y5Rb+ygRlmPLN9QTW5lM?=
 =?us-ascii?Q?S+f2DL0E+nBJpo9+4Mq+IkaR9ma146CkZGWa0oupIo0rnMukEIF7eyaaksw6?=
 =?us-ascii?Q?LlQpASwfnWYfJ+XPrYaPqUDS/be8HYcCdHwNKBnDMcgY2K4hTHVEMfPdhbBx?=
 =?us-ascii?Q?95P51CBhQnUGESb1Ln6VcMIWnP2LXM42HCn5NC4b91wowLTxVf4gZEvNc8PX?=
 =?us-ascii?Q?Ni7Vc6KD3Sh026C8lgRo90tTGEYP0wn8Mm7CrGWHzXCkvxEHupB4vxjrdA4E?=
 =?us-ascii?Q?RRaTMjgf5HV+I/bEDyYz6o091rE5O0HaGFOHuj0ab48oxrSnvL01JeH4lIGK?=
 =?us-ascii?Q?W/fSaeF8gkAKWk+SL6juLMg5AlvjYmdjWoKShbvggMphc8LWHW8tTWsg8V1W?=
 =?us-ascii?Q?GqMELtlScczTIZpWdbE8C+VzIl2WFuP4SaUaGCNlySMJrDtE8q49OGn8ipZB?=
 =?us-ascii?Q?i1r1eOzQjvKdAF8WT3az5TEjcheCMdVc2hsMS+kf2GpSb737Id52HKficSF3?=
 =?us-ascii?Q?UbS0pggrTGtHe79RXIv0HCaqUUNisaAyppDr93tCjiIWa2stHw+EW/rg1EMt?=
 =?us-ascii?Q?KiYzcACNQXkMkWOU9Vl5TknvbRd9RvDd0PYYl5gANqW/5Qg7N5UwesQ34DYv?=
 =?us-ascii?Q?AilWjRaWCUJZZ/U/c9Nk3RBWAXzj+e29F66TZjPsrpiXH9otNdzrvThSCVR3?=
 =?us-ascii?Q?N/LbIoaW077prYvFpcbVV8jVqMo4NFlX+6Cwa0F4nzojbEVdiGXgJ5wpjXrv?=
 =?us-ascii?Q?5GPxVMtQ+pEBPTaB9SNnjhmvwtTqsh10qi6Gd6DEjJ6/7M3AKk3rVZ9Iq8Kj?=
 =?us-ascii?Q?QQkKwbzkXF3j0ByIQ4VmjwUNX6u8OvtxwzBGujkyTx6FuEMBxzkAPyBaO0ZL?=
 =?us-ascii?Q?J8nwQekfPeo3BYiXMafymE+SfCHy3AvVQf5kiLzVR9XSmM5iCU6xOC65/05I?=
 =?us-ascii?Q?kVc1Y5vfCvqfhqEL3qo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AtDA4fcPeMg7xuicRsEm7cmt5p/It8KuNzQD5joQjAnGNhI0Kw13HwmK1D81?=
 =?us-ascii?Q?bh3LKKN6AKFpG2kVaa27HGxjNprd0VG1Nqk9paiiVuSl9GyUxE5gY46+V8aQ?=
 =?us-ascii?Q?8d8uCfD+HsAJD4mvkT+C3iuOO3Zbea08wPRgb/vVtTxdcx1DNZRaeoEeXN2R?=
 =?us-ascii?Q?01VeJsxNS5GD21l2Wmx4NXtNvRjF+GFScF5HfWbEUm3bpdPXvr59xXJ/r6Px?=
 =?us-ascii?Q?yPnDHkWKDub3GYTPf0lo2uqPKXjekKUM2osbcKQ+1trQIBJpc0YJyy1L8dDU?=
 =?us-ascii?Q?OuSzLIP0T9XEHdGaFPOPeGB+AmEIYV/sRMSqBJBIFmkd/aPjlD/jAIpS4lhC?=
 =?us-ascii?Q?USKOuH/wVlvXtDFyIzZlAeJeCo3nLIt7dznBqKWHDQkrplbVPv8jWYKHq4bT?=
 =?us-ascii?Q?li/p3+5ih8vNuio/ipxDuYQBcSpMDHdyUNNcJ/iv2OJfwySQWK+4hPuuVWUp?=
 =?us-ascii?Q?xfvxDFCDxjagpC754MfP8K2mX36VYDXYGil5dS7SsUNxj7Sy1eCVTy5qJjEd?=
 =?us-ascii?Q?CrvpOoZhZ0KwMZc8YuyBOz+9XKQFCQR/kedzF28j2Qz2JOcNAZSsS7dzn3EE?=
 =?us-ascii?Q?sj1H0vvU8Qc10aqG2E/qNpLajFDtrNZk92ahBSH0xoMfvEP89W3V77esyF9O?=
 =?us-ascii?Q?NBl0ZRZ7lO46/oD4e43SuePP0eLoUiN+5/tdpvt0RFcI4ehLwGmPBxcx25Gc?=
 =?us-ascii?Q?IW4xG4hW/xuvm1OLtZD9pskwYgHEEzlKQ2tCS/s6LQDSc1JjkUgLkl7pYrC5?=
 =?us-ascii?Q?FCXvVgHRrK76I7nUu2Hrn00jDxlx25eKQZB+ZaIxE2dO4gVc/fn32ahE5m6D?=
 =?us-ascii?Q?kn3Ac86KQiVA4zewh6mAx3dIc5xBMkDwMZDLiRr5CEPz4CM6VWjIJS0L64u0?=
 =?us-ascii?Q?Ko9TC903cgonR75FPgBwDh8a1G/DIYtnF56UcYRbw5jJzju23gxu0TgwDeoD?=
 =?us-ascii?Q?DBxgsyea+JYSLRd1CaADD6nprpg+h2hBwRVTudhB3izRsEtGWvG0kU0+3Ncw?=
 =?us-ascii?Q?OB6uiLHR4LLwjMpdEcgHqLNStzIv2fTAi5HgDmE8yaPjG+IK+ejxC8V27hXa?=
 =?us-ascii?Q?PSXN6REYcjiCRPuRA/VENavinre4gaG5TZjALZ5jfUkr9j1YCrGL5Eg3DNs4?=
 =?us-ascii?Q?TSLdLZs9zvxlHCV38wDw+ro1m5zG/aKDb3bzqri76KlNJl25gl/vlL/WUfCi?=
 =?us-ascii?Q?PR/7xzhLO6sNBDmP5c3imiC2ZiyINvJOnL1e6/xo0H+hejuplFO1HbfOKnku?=
 =?us-ascii?Q?5cPT+63He4SkGzDFOJbcbJIjvhwBTmsBGoH11WcuC/frubSjUDoPP2mBgMJM?=
 =?us-ascii?Q?FDuLZSofjgjS1vL1d/FoENl+cEXhtsllXKH1d7fvtn+SEba7jMQKye/8sAEO?=
 =?us-ascii?Q?tdAWV5wV4+BavBnod9HSK/KINa+DfOZCTtX/h7ZC86R/BRSIpiOzy4OhxRpb?=
 =?us-ascii?Q?vLugImInrCeeERGUseIBUx5RnXVe96bB6BeCovkYl2TdbSiNO5tx/194GozG?=
 =?us-ascii?Q?rjJ40tcYhNitiBpJkJXgTJ4sH4U/apDov+IFWHfLEe7H/xhKLX0vkHoHxhjJ?=
 =?us-ascii?Q?3lZHNXYpMZSpwfsv+NTl+xHv3v4PN60w8TkFwbk9ZK0swf80iPXUR8frI8vb?=
 =?us-ascii?Q?8MMy/E+BIz42KEUe2ffLuq00yyZr+NxybqNccnSsGpObBgnmEJyTrpnSfl4x?=
 =?us-ascii?Q?6VflqQBA0UKPKSj43P/SPUYt+adUiJv9hbTOXKG6YVkpvKL14u9uuSHc6JOn?=
 =?us-ascii?Q?bW3jDHcvF19PE1qi6rJ+72zl47puwxq6ffm8VI4WewlCHn3Bm4PzvYJZIG6T?=
X-MS-Exchange-AntiSpam-MessageData-1: KSOVaSGwHMdu7wtVVzOFA9zPpU1SMLHuwEo=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e04739bc-93bb-4173-4248-08de693f3513
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 07:28:53.0501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIJwweCzjtPhbykk3hZzx09lRwChiyxpj+54yya/tr28NuXtbmmwuqls872kHG3T9dSDXN15AusOankW7xDMoOzf3Bt9lhpcf6KHt0geDoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7827
X-Proofpoint-ORIG-GUID: JckZd7JSNv49lKgtQ5stnr6i19V48Ig_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA1OSBTYWx0ZWRfXz1/Zyv/vDapr
 6TeHe65EIH2kdpvbFxLr4dxokutJqXCxoTEooY7dArfaYjL7iG20DObZxP1sM9vpcOhIgWpEMwx
 2uR0wgfnxMHAduEuKjxQ8Bkzs4hceQrAEt6jKjhGHEIY/dd9ZqBMz7zSALMt5nvCCVHdfsensq2
 9nvtMDcdqAtzgpZrjyzpKQ/34WEuNDbNhREn8moNZmCdhCQCzBDaE+pfxb4izf+ycOtQ5Aagrtc
 Ljyh8JscPjOk9ZKUKE4gqklF68x4q4H5dC2PW4U9ZSTsaIRLXWTYZAgzKNwisUXx3YiLjehVXQO
 m9LKc78tvLhGw4vjNdePAZux/8+0SnL/jCENpJV1IOzT6wF+maY0h3EcoHfK9v3rrxNhjqjGxIC
 AckFY0zuzsuGShSROlB6ilNGRc/mq2zelwa+0ZuLqcVokXLvzJsqS0y6yVoHdpHxwv5c7s8eVIU
 u2QGccuWuNV5ty3XVuQ==
X-Proofpoint-GUID: JckZd7JSNv49lKgtQ5stnr6i19V48Ig_
X-Authority-Analysis: v=2.4 cv=Cpyys34D c=1 sm=1 tr=0 ts=698c2fb7 cx=c_pps
 a=EKn0uP0Y4sICCJyfUD6Zbg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=J80X-hKIY_fJwJGPSIQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110059

On Tue, Feb 10, 2026 at 02:39:36PM -0700, Keith Busch wrote:
> I didn't see the reasoning for this path to run in async mode. Is this
> change related to this patch?

Yes, this change is related. In __blk_freeze_queue_start(), the caller
will wait for freeze completion via blk_mq_freeze_queue_wait() regardless,
so synchronous dispatch is not required here.

On RT kernels, running the hw queues synchronously means the calling
thread directly enters the dispatch path and hits the lock contention
this patch addresses. Switching to async delegates the work to kblockd
workers that can run in parallel across CPUs, complementing the
quiesce_sync_lock fix by not introducing additional serialization in
the freeze path.

Thanks,
Ionut
