Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771F42BAF7
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 02:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752545140; cv=fail; b=kja66jaXF3d1Y+uVM/rQ4FlbJeo1ap22xcC0GeAqWONjSkVtgDVhkiDzkKX/pdRAyvMPTMi3DlW26zS8Ft5p/yKQ/le7axvz6sNbzfTbg2YpUkMRL05TlgXmRdPoW2wd4D3Ua9jdlbcGFljPvw8B2rznXwTzxvnkF5WDZ+rGSuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752545140; c=relaxed/simple;
	bh=b4md2DBVxW+FvR4MdjoebkTrEC02imgQIDNJGklRO4s=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=ZgYpPekNTZ/DuDpr2af3nqqwnCOebPWZmR17ZTpWIGFDrErg/+60Fp1l5jgJRdaWqvLcsxILvcokttJPRcrCm7sDxg5hcgd8cznGNVBgwlj6xAuaV6iQAAL2lQF98Jilt3/VQEpNkVp6vSUM9UAlDz5Lqpl/nJl9dQdsKKer4S0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CDZmdk3I; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HkMSqCs1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CDZmdk3I";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HkMSqCs1"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F1YrUI027977;
	Tue, 15 Jul 2025 02:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=8p33nZpH2K8aVIFqDv
	SkYN5F0/U0wssHnQoQ8RgTnJA=; b=CDZmdk3I/YAgiJ+vaXuIwudg6cjM1QqHew
	OJwQjYvQQrMA39DXNn7y0HMwJ/Dku05vdLClnulnvoDZvsWD/wVqV9bnwjH/WKj0
	e+Bxp5vu3YMCFrhWQWuhH8rlVCuvUvg8l+AmpYOLWJ2OLM4jkQsZQ31cwPuZ0lBg
	yGqc6Rn0ieSJ10xvKyoc8sj8Nj3ZRRpVKdglVaz3xSranht20nsiwIoJ8JcUIe86
	NpZNL1woTa0gUcKeyKXUg0podegW4/0HQZCS9TL2gkFpEc1x/J797REz6kFxLbAI
	rVYO1o/SAd2Ev6VrmL3DZD2PJIOSXICQOgFHbZReaEk+UKk+J9Tw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhjf6131-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 02:05:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56F1JUne024007;
	Tue, 15 Jul 2025 02:05:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue59am1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 02:05:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJO01cUwPdiCLMaS4R94kxP/A/3p4qJqwZDbklV6boOeghhCr683IaRr+EoYzihNre+KmzsCN+ek8cXrplCMIgvHp1Q0BOtt+z9mKOfeuIZbM1NoF03HbHwASAXJi2Zb3rTJbmHvxPbMyxm6VJa/gXOqHuSHkj3nDOQC7J2OqegPj2brJJ08jP02L5Ir0qAvyaz5DGf7woYPEU50Xe0p4C+syJvPyoc4p/Y7eTdQDZZbOOYVlOxXe0z8lICMuDHQ6onciubEs2pl4t/lkFjSoU+qEcVPIsqAmtyTdaHl5RaIvBm5shRd0MK3Id5JSh7tQutnyp9hnmv9L4/EFawpww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8p33nZpH2K8aVIFqDvSkYN5F0/U0wssHnQoQ8RgTnJA=;
 b=tb2pHA6McXfb6kfyui8MzRM12Tg82m/d+DlYCBd8AU0s3xzdCwceFuwnJiK4DFA774GV0gpNzhN5UoCRlpfsTgslk/cdWaLyO6TPmnz7VOx+vVyD0RlPBZSqDxw+D3enY9oDlnsj2TLpsrMW7cE993IC37Kat0GwW0WIDZv3QEax+CXLYKZ1H2QXb0xyrqpeokI0qbCqruohkaq7oCN0HgAR5FuhLq4Zhn9ijPrEgJHRyFsbqGT3PwnUddzwwjtUbGaKiv55GVubFfclLHP5Bg3+7k+qRi8R5V2xmqntTfds/7hl/q2KagMkExzY5mq0t7/J5AEEFRoKXPAkMh0lhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8p33nZpH2K8aVIFqDvSkYN5F0/U0wssHnQoQ8RgTnJA=;
 b=HkMSqCs18KtLgLx6MxJy8HjyXZEKOg4/Ff/Af9BSntCXiLEKFsqIKKN17klefcpUi4GgaiJ1erMTk4rvX4ZzkXbfkDKcCI7gkwVBmDeZKloPEUDT4ihZ3904eAyTAMFdoqxpLO6lbmcO7lS6T1+zhw9FnwVJAF8EOyKxvISUjz0=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by CY8PR10MB7267.namprd10.prod.outlook.com (2603:10b6:930:6c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Tue, 15 Jul
 2025 02:05:24 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 02:05:24 +0000
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph
 Hellwig <hch@lst.de>, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v2 0/2] Fix bio splitting in the crypto fallback code
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250711171853.68596-1-bvanassche@acm.org> (Bart Van Assche's
	message of "Fri, 11 Jul 2025 10:18:50 -0700")
Organization: Oracle Corporation
Message-ID: <yq1ms965hvf.fsf@ca-mkp.ca.oracle.com>
References: <20250711171853.68596-1-bvanassche@acm.org>
Date: Mon, 14 Jul 2025 22:05:20 -0400
Content-Type: text/plain
X-ClientProxiedBy: PH5P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::12) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|CY8PR10MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: 804fc5ae-41f7-4197-046d-08ddc3440f34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4JKcwxOuLW6OGUnkSv5MpDWr8eKlJlJHMXQJk1WDVCyRbJZ8ovL0rs5He1ui?=
 =?us-ascii?Q?fEWIsn91AYLO5Dh62lVmUB4lijrPXAs6Vjva10XlIfXpYZ4I6wSmFVCvZk/d?=
 =?us-ascii?Q?MUmkr0xcEwHmuC24d0gqBrbtdQaYheo6TsTz/Hs3YFqZho2BEt5BLfHzGGE+?=
 =?us-ascii?Q?DSGKwoOQ72PTEQBWwcBKzaOLApL7lIgOfdRte7dJEYMH52paTlnADyWGbZbG?=
 =?us-ascii?Q?5uTtuOW0Bpl0em6i5RWoG//HXd4yZswzEc/1Qz/vK0mi1xgqcNJ8Ul2PWnZm?=
 =?us-ascii?Q?faLV5OFkKZSb+ZjY9Gq2ixZKNkbDfmHTY2VFQIiTXa1+8ANqklXzj4NMnswZ?=
 =?us-ascii?Q?M75zCkplsGKeWLC/g4JrzsAbkSsNcjAPfVPjX92Ftur/goMIDGQladUOLoSb?=
 =?us-ascii?Q?5LS7WlfLKfdPnOSymyYviKcByBOm16i1SdpiqwdTbnV8YNx429ETgYhlpEOq?=
 =?us-ascii?Q?nRA8sC2WPDBroJwYOpGaIPzZCAJ3iZRuDEsyjZeh5pdDqi/w92jdfBiA7YN4?=
 =?us-ascii?Q?aejuL1ouuH37nJyuvl2HLjtl+JCqDSNfjVlxukNX4SzUwl+1j8QI25UHpfMM?=
 =?us-ascii?Q?gZU7KJkRX2u/Vxn2JArOwt4tLUaVR7CVOzoaBjr/veeAYt4L1F74AsfAGWCE?=
 =?us-ascii?Q?aY5w1dphUxQ9X+UENWRzSbsAP56kovBLaiN1i7Tf8Opf6+g53NcuSF8B8uFt?=
 =?us-ascii?Q?2VFMhFxuKh+805JpEYxXnt12NSinApXFaOv1uvLEVZdXuffC3pz/7d1bHLKo?=
 =?us-ascii?Q?f5Cg7mXe4ctSgUetnKrwte+g0Ryyld4QZpzX1j+3pObW/Js7bUcxx80PrCWW?=
 =?us-ascii?Q?NbKI8M2ruD50V3q3CVq8EJNkWEfowVZUOLUO0y4u79q2Dzm9Gr+dMqCs8zya?=
 =?us-ascii?Q?eZwXB7741bACjyeoRDRYywwUPnVhlyyWpT3cDVFlOYnD8uO56w4xfWZE7b3L?=
 =?us-ascii?Q?ujFTx0w/bBUJBRu/hxhVGrWNTPJfohfd+DoZrWhtwDcE6hiG+eonOhsl5ytV?=
 =?us-ascii?Q?te6GsIDjHusPOtivg/8FVFzXemAH+wRRYhukFHFkgspQK1OJJA5nozrKXGje?=
 =?us-ascii?Q?Aoo6uaOxeANJGmn8AYi2c3Osbj3Z15uJzuzWvVLH6hmOjOxCymoWfPSZ82x2?=
 =?us-ascii?Q?m61Z0uJMyezHAG4sh5l06NQ//2aMNKW1xpUfk2C8etVMs/WkaWVi9NWqoJmz?=
 =?us-ascii?Q?5PKRGag2WuneHwN2DmeUcvCWTnNMvIT2EWphUyMudDMK6LhfTorXe4o7j+o9?=
 =?us-ascii?Q?b5GCbn4/H/laOfv4gkIDt5EUNLU4miIt0EQbHBro+wwXMDZeluBgLPQXPg4T?=
 =?us-ascii?Q?LhZb9m6J93f057YBcu7XkxJCWG9afgXPVkxcRbwWmVDGVQSdPcPm+dSFHIu/?=
 =?us-ascii?Q?u+LByFQ8pGi0KtBgbyirEvdBDr5DFd8pRuQL/MB1B3Pn0g8T0NVoQCHOZjCu?=
 =?us-ascii?Q?J3py+Ukbl5k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kXFSH+H/TBjsJSkPqNyYtg0/e8PE0ejRR12TnBQBAWQpNej9PjRut7sG+6jq?=
 =?us-ascii?Q?Q0W7syUqRol2aB1XFxBDzcNbYXfCE83FuihBLAwOXEB+Vtsn2WuBL9F2UaMP?=
 =?us-ascii?Q?rqih3kR+gcpo7a6gug7Qc0DBojpcWpyDoS4PeT4i89axfs3IUw6gObksTq/b?=
 =?us-ascii?Q?6stqGkQ8tlfR8nm8ZRA6Z1dU7OYk3AcNA/c8zAhzcTTtQ2gere0VpYJ6FrPM?=
 =?us-ascii?Q?A/A2486qcqrQJ82zIVLNV2BT+aIdUQWAZeekEutJCSJNffXEWtUv4wZ2CppI?=
 =?us-ascii?Q?JKYqmzjLL23TqUSq7Nn0y0Ot0/jZVEqe2RDoom+ab84uj1EUkNp5Wa+sy/ul?=
 =?us-ascii?Q?HCfXb6DhklFGLgk3GJbCPCkob7rA+XVWp4XsPoOgJ9GDET9yrrxepGoq24AE?=
 =?us-ascii?Q?rNhswRjbOmjNMnvY1DhwkGfOahu2BTWFai41EJVl4rskWIRr1RFzlLDIoJFC?=
 =?us-ascii?Q?BqUm4b52fzYBcYXegBzRoWeM9lE5iZ8iPPCnUGmFC0inqXUW0sYbp+RE8vAd?=
 =?us-ascii?Q?rLR11DrbpKOpFI9daiV4IyO5dfvYENEATZyQDYOLagYGYSbtOAwq0LeWYE4Z?=
 =?us-ascii?Q?v8VduH1tcyMLNOq3c3fulkIBa61qQvZuQmv/YHdbBu21S7unOvR1Un9W5Rh4?=
 =?us-ascii?Q?u7ekE1NvoZ/acQO3sZjOGJKW58pXFRJddNfOKiqPD4C8HV0euhADrg205Ok2?=
 =?us-ascii?Q?1ZSqS1rFnFqWdIGjk4irhEEy5IvyPdCqC5eUse+8kVG+7KJAF7vVHenNBxdq?=
 =?us-ascii?Q?tzoMwgMxLDYlYjV2pxVcF2Ud29H41loJwkRM6FMepJDssxM48IH/hPPHtaGQ?=
 =?us-ascii?Q?JXYWA1/+xGNealfqOWWL7NayjRZsu678KGdVEzjD01qXXF1czcS86yxJLdYy?=
 =?us-ascii?Q?SZRFTj6Q4weu5Z/MRKMXGICbf1whyh7Dq6gwNQEl5gVE7kLIhNLfd8a1v90s?=
 =?us-ascii?Q?VPMk9kfT834ZJ2mc2+ufF4GrITU5F1/PQpYo5fa4deyrRtI+8AV8n7y1UA/n?=
 =?us-ascii?Q?eSvXtZDcB4H04bX8zgXIutA5qylsVJMlTdE3XNeCYApRKHP49BxCW6Kyo/pH?=
 =?us-ascii?Q?ELNOt1VWI2r6Y7OM0NY0tXtArkH2pf0dKNP5/C5iGjhomUQDZb2IUdV1nibO?=
 =?us-ascii?Q?QrMpftgZCTJlXWc0PXvHFjtIjBHgxbc42RjFe4wULsqqs1a6Xs4InNRXWTEQ?=
 =?us-ascii?Q?Luklx5ngDWTzn7F6IXYm87Qw1DvOu13HekBtHg85NfENcWBGo1mFBP2jiwZN?=
 =?us-ascii?Q?7/Hm9RedhLiMxfrwVpHI3oRdjUuDvWYUFNjc6CRyCDyIT7+0TwiWu/brhVEZ?=
 =?us-ascii?Q?qG6J1s+JRqomTdd57AMHRjAimtubj4GjwVZFw3WIq5wbM5+ra/fruG3mJuZa?=
 =?us-ascii?Q?aj05YRVMGb2kW9xPzEjl1ZpwAg08Mt8epo+eU9Ow5O1PQ6KNWglpTYTa7LiM?=
 =?us-ascii?Q?qj4+CGq3rz92mWt9sUugIr/0B3vtLNuVghRxRR15/J/hR3i3inBat90Op/z2?=
 =?us-ascii?Q?A/qEGNd3g1orfrsCiC3i4KKqQoVA/875qs8hGw4Q4vPAV52PDu0ejoKadZND?=
 =?us-ascii?Q?2fvkh3csRQRvOMs/83ft/y1kTtcS9YTHfrkP8TtVlNgue1aKYmJT6XOEZZy1?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J2zKtog0ETXEvdWf/HNU47xTYhKkRcQeLnGYHnjomdofWjjME61cgj5DyDKR6aSWHi6IGibKGdeqqVt2Ft8KL8fMjbD/WJti85jJCw8VzF824LhsF45mUJzx8lhjrbPnROrJR951zPVwJI7dHSQfa/9RK5TXYjz4X7wfhj0JBCxkW/Hy04K3zoiNeZ+117ywHXxb1UwjsTYCsyOTr8AcKNzq2HJDiUyklJmfMraVLNvlGX87OswzqmhUlEfoPqph5hPDoCgSg0QAvS7rYOnouvhCqkUKxTYCZy0AKK/pRgbHboJ0dxvn3QFh0xq/GBQJsJSNO5QcaBZfSVLBIf4oKxwJdr8WmmUR5Y2d399SjID9bRF4zB5almY8iN4wvnenTO3AP3ENEVksoguJEAyndkPTa1/ZrK0HbAcQLGWPY33zYw7WOJl8ejrpNoTu13dmHjDakGQrH+lCVl5eix815on5cNuMp14XRsA2IRgIEiklMrVWpw4RdjIcRZ+8Ok4sFaXRaW/VHSqVXIlzhvhgtTbDE1JSyN3NntG6kKW5dPPWiIzvwy0wzKNkSGIf3EC47HQnneGo6nI4kW5EufQX/hA65IpOmBQLmVhbnSsI6VY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 804fc5ae-41f7-4197-046d-08ddc3440f34
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 02:05:23.9014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgIaEeh9fYHW0wB12nR25FVoqID0uImXgZtcU/w4qk/tmCtkYPYdDtE6vK1lUMwWnYxUDfAn+DJ9Hie0XMO0COtKJ0xHoyIwyOgaqMxI6/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7267
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150017
X-Proofpoint-GUID: 5uBZlD_izMAAM0WjMt7muWY4hK8uvV8O
X-Authority-Analysis: v=2.4 cv=O6g5vA9W c=1 sm=1 tr=0 ts=6875b767 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=xwCwS6vpahj6bnBTv2MA:9
X-Proofpoint-ORIG-GUID: 5uBZlD_izMAAM0WjMt7muWY4hK8uvV8O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDAxNyBTYWx0ZWRfX4oIvDjlsWQFw zd3Xx58nkJc9hcYYDi8mO1UoVGcXQWDHQerYl8q+bi/I3SbPHKh4Dmdm7eewKoFy8efj9jgjNak 3+XGOtQ1apM0Xh4iGHXaWmem8nOzM3y5DN736TmQegSGKKjcqT4sdGC2HAu79i7EXdcaygSSsxj
 +3sek1ANH1GaLHVHd4OsHVIzpWfkIppa34uG2Y/qmDindrAqYFuhb+qENAEOvX6Agvz6aWxI0qI wMBu03dy4jW+auWwP9cAqh7ptdSwtU5ysa0sSQfkvf7g96jiFUfiVD81azD8rVUqFXI57OEbuur io7GlzN0tsL14AwEEz5gwAu6hzRWel9H2FZ6g7YX2D8yiaAJ72SVFzC4mvCMHzmF9NQwJsvAfhf
 xCnqPRCRdlzgY6NvzNXHKYZjgjFvKY24SAf45uiM97kSkQtPgNdtW5yDuKVtU/tT1iZRQDqB


Bart,

> When using the crypto fallback code, large bios are split twice. A
> first time by bio_split_to_limits() and a second time by the crypto
> fallback code. This causes bios not to be submitted in LBA error and
> hence triggers write errors for zoned block devices. This patch series
> fixes this by splitting bios once. Please consider this patch series
> for the next merge window.

Looks OK to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
