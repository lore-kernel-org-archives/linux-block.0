Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8995C1C860C;
	Wed, 25 Feb 2026 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772008901; cv=fail; b=PGRscJnlOrhb9RguEIpAiFg7u55q+fIrP31n2nV2V12S5rYFJTq0yqJDP7Gs9RNhYasl8wgUhczVnBx99Ff4wm4ReW+a74YfP3kzS+vAbUVZfaKYoB+mLYLJYjgOWpEdXNswlfGjqjAke5iC/ZNxv568XSXIA58pJkqQi130mvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772008901; c=relaxed/simple;
	bh=ppx7HB5//SzRjZm8ZEMBPbdwWadAcFrD/cDmHPerUqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CjaVmmtTaqd52jP0xjd63ZYm1sJsnaKZnVu6FjC7vaz4gDRE5OYfer7smSMDjcToxdFsvTD6v48ueA9g/SjpV6cPovxQoaBzg/6hL3h/R3B+K5Y481gu8m8KUnRcqB2KgZoXKAAwu+8RsjyCLnv2zaBRNmgLDYrOy/gtQGm1M5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i+SuTLwg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aukEtDKV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i+SuTLwg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aukEtDKV"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OItvfl369223;
	Wed, 25 Feb 2026 08:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=5ZX4MsMGElTrw096uD
	A+hLLYyJ3zddFOi1GUincnDjQ=; b=i+SuTLwgvdznb5N2mFJE8xTw7uk/CT5M3T
	ESaUE6pJJAgwq+2iuP8clP02nOvcOHtriNhY+/1ZQI1JIBja27VmfCIY8gBtXTeM
	5tcvVNCV64X6wsNGv+EorGumbcsK8+YScZvbPkwncyJ9dotPYgDaa4Vnp5vBIPl6
	qVQ+r36HdZxG2+fQY9TepOArhCFR410iVSD6mWp2PQmcv60cNtkOqA0ALS7jyesp
	xpSE0GC3MI5EFPoI/uETrVvuC7PSy5tJy8cAECwqyfDVpkzCyAIGNUfx36oCR3R+
	GkjMiOlYPT0YajnVoZrhWiQ6AVydm5JEKleWE84zL6OUz2EjQI1Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4k5wp7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 08:41:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61P7PwfW028463;
	Wed, 25 Feb 2026 08:41:25 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35at7k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 08:41:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3kaI1YyUENmASJED4WKxcmz79+6MZES2/zsvfspkgeDlQvsZZiggAT1+LbIhZLATb4PYHwY5pdSD9CGM7ZEPyV2wEBN4x+EqaSsb+DVeGNlyiw6CPgv/10he7B9SunSvA8/c1pS4fQoJOElS+rmLzegCpntagYJ7tA0lPYNkj6s7l2SoGQMsWNlcKoBqGP2CBOdP+1F1NHCh69DUTfpK7r/McfcoJOjU4JULoOszow/XeucWEDM5PUhNyx6HA8UOtDw36S4rNLmwRRwkmJeXGbQPtW3z7TD14BhJuHP++qqV8jBCDOFthXAmlRM2cHtMGttZzpHBuyD8tg6AIU8QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZX4MsMGElTrw096uDA+hLLYyJ3zddFOi1GUincnDjQ=;
 b=c8hU+LSIAb07hp7I5Rm/zMm5dBSgALLLu6rPQTkUa6eb0f7PW8zyPECdqDaIPuWExUlsQ0hwYD3zA1elbWU6GZJkvQJZBHGBoE44CFrhuFkLQin5uJ6d2JVrMt9JkyHcrhDdjTzAq/R6jMXNiHyC92SvcHv2DBBOTnYt508xIgFnEvIBT8BP2TbfdFgLxuTCDQEEBz91GjIR0Sx9cAAGy0eyhb60p2Lc9kRvU4eMDF24f2u9H7uRNg0w10m8VVfbBi7IDIZa1mU9si9Idaieg/FKARIgpGzIUcFHqP+7k3WrLdJ8H8LAZWdaXWvEGK/xD5hcAtaSOsjERX//0Hqg6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZX4MsMGElTrw096uDA+hLLYyJ3zddFOi1GUincnDjQ=;
 b=aukEtDKV4WMbCLJxa1Lr7XGrRAubDEe2WWBIM5NfVFIyU6A7xiPGKRifparFl8RM+Rod7g+3PVVzdClxo/YwzpuZf4tY8ojir0yMv7vhx1X26xIWvOaQmfDTpe4LRzELdtcZQuGQteSFCzPkVrdxW9ylxijQ1LhnyQJCJH7gwRk=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA7PR10MB997773.namprd10.prod.outlook.com (2603:10b6:806:4cf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 08:41:23 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 08:41:23 +0000
Date: Wed, 25 Feb 2026 17:41:15 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Hao Li <hao.li@linux.dev>
Cc: Ming Lei <ming.lei@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        surenb@google.com
Subject: Re: [Regression] mm:slab/sheaves: severe performance regression in
 cross-CPU slab allocation
Message-ID: <aZ61qwplTCCapq3L@hyeyoo>
References: <aZ0SbIqaIkwoW2mB@fedora>
 <aZ0wX_QuxNTxXHMj@hyeyoo>
 <aZ1qRhIGDAR7d56r@fedora>
 <qiqptuqsiaufeasf2xukfzoumiyoau3zfpokosn2amgc6zskc6@vl6ie2h2zj4m>
 <aZ6cjpU36_EmXslf@hyeyoo>
 <zn7q75k7u2mspvmspwiao6245kmaahti3kwagablp3advcx5ga@5d36ctyi2a35>
 <aZ6ijXgDKj9D-kDm@hyeyoo>
 <jcgdv46sngpfggq26x2f7oodqxlwqtiilcgjzdcwvbt3ovelpj@mwllshvzoeoz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jcgdv46sngpfggq26x2f7oodqxlwqtiilcgjzdcwvbt3ovelpj@mwllshvzoeoz>
X-ClientProxiedBy: SE2P216CA0183.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ca::8) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA7PR10MB997773:EE_
X-MS-Office365-Filtering-Correlation-Id: 020ab4a2-b1f6-443c-c93b-08de7449a7ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q/q10GnzOviv3nKwH2GnnFbgqEJpT/N+JHRibnvszzHy1o8mcFGqgGkMVq+D?=
 =?us-ascii?Q?P/rEih4+p9LjtmvSM+vBZ4i8avYtix+zmKUwfihhpq/M794Y37iU3K8t5WCi?=
 =?us-ascii?Q?6FUq3aW4CCEPUW0eRo3smnQKRLblhVKQooXFHbVd38M/d/GPh5kQUyU2Bw9B?=
 =?us-ascii?Q?HmGvMI0AegcblKNWrVJty1mAW3qaIM4L0RQbxcCPGbawkemp8VQ+KTAMd40b?=
 =?us-ascii?Q?tHH3foUx4bBRfkNF1b4XiebwQe5NMAv01agYQ/rGFw6K8DZ9URtPaeyd7crS?=
 =?us-ascii?Q?6zb67xREwtLnUrM3++OlGxVDu3WhqHdJYM129OobvZ04XtHMbDq/pjYCnaFJ?=
 =?us-ascii?Q?4Rxs1yPybI17EppnIPD3PW2eoPdP9qTb1oBaI4B0iFQqMuifcEf++x1v3m1W?=
 =?us-ascii?Q?ITHgzrlHAWl8XuQBaqabPmVkMKA4HxrwbL33Pvls1n561z2CqmAkUZ4ypb9/?=
 =?us-ascii?Q?vPbPYQCX947THEnhrdrAxDFWDVRi6HpWtFO03PgjfrNJcjhH8VZXQmPgEkG2?=
 =?us-ascii?Q?YKGCljhdZ+bwb22g2aqDVMU4IR5RhJAoneRDFH1uPimAEuZZ/bAr2fK0JL9D?=
 =?us-ascii?Q?Dbv+BjfDroPbNG1BHTXmNTptFcUzeaFNtUCD2pI0AziUMMX4zSZxyoG7DirD?=
 =?us-ascii?Q?L7TghBuXeuQws2y0/8kD5EGRPDv3rm8moWWsZeXdGgf5lX/IZveJE+kLE0yb?=
 =?us-ascii?Q?XXwpnU2c1BlZk8RxkD6zDneBVWRQIId6MMcqjOwFmXbuNMzEU4+aoonZbVsT?=
 =?us-ascii?Q?Hrfl1YW6L7ykkLI6sfAyk8JzP9bwPZ8OnOJmH9F423XrmHS1yflnUiJwN83m?=
 =?us-ascii?Q?QlRGqe2Nk5rwma5Q35h+ACXdTwcUEVnSqfM9WrlKeI0YMHLeThMctjWKw4BE?=
 =?us-ascii?Q?Qk/RLVkTmKovRCKEsQr9fltP0To7N+28hqCS6YhgYgOuztu5G2h5RXXno/Wm?=
 =?us-ascii?Q?O3CmX2ozykAYHtVOZq42oCacINQC8rOg5o77Is2s+DVGn+2A8HeuH7Ba1H1g?=
 =?us-ascii?Q?/aS8jOcTKdNyYJu5E8+9eqqt7Xl9CLog3FwF/xr8V1hZ0c5Uq/Im2l9N3ly5?=
 =?us-ascii?Q?sLBfko9fxkuzl/s4GLXJDdpJoUf0AEMbK3vI2zzGr20xXCR6pbP3yJZDfVYD?=
 =?us-ascii?Q?rwTa1knmOHIzAEsmsyr9WO0RgVy0obh7vjaxDjZbZZYdSzUhWqv6c/ewJM8J?=
 =?us-ascii?Q?LejmmXo5m2eFaV9N21aWUg/3LLXtkvfM+T3qfRHgicKw11+GfCWO+4/Hfhr3?=
 =?us-ascii?Q?w1cBMzb4zJghzsIHl4I7LRnMH2FjKu43jDWEkLLSG+UKs0Wq8+w2mftq3JbT?=
 =?us-ascii?Q?Piq383eTRTOiU8XzEayK4XpNFqLWeH5SvmTHjygKoMn6yaWDFK6W/3+Z9bP9?=
 =?us-ascii?Q?lQuO5FD3j/Ex0FX441/hlZc5UxNqFXDrWMmn8Bgkt/TRRDXjD66CfPsiEpIi?=
 =?us-ascii?Q?F7F/9OnextybpdLbLWk+2Ky6+fyxpwU/FlHD9QZwEyLRQSsA7xke2e0hGwU8?=
 =?us-ascii?Q?9I0fvvQdvP9CMGq6dRs3Ccpwu+gmodtVkx4oPncs48yswwnFd9wUTlrL7OcK?=
 =?us-ascii?Q?UTJrHE4x9OgJ/wMO5tQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9FHY38WZsyQAnPzNspwgadNhOjnEtEpwQrFARLqgFbeM2Xn1Hcv56ojdZnmg?=
 =?us-ascii?Q?sJ02RakKpX+27w8MCVnKeJrjNafrKpVYZbphzEWufsXgPfGvOKi1vo2JtKwr?=
 =?us-ascii?Q?Bzi5cyHaHde0CyjuEiuPvOPzTXPuK+FLLFU/Ymg30uqidoGEKDf+4GCQjlgj?=
 =?us-ascii?Q?2MJaS5d3nA+G03sSWWRMoYapR/DECYp6vKXSWi90OvxPk94d/WOTyat9MD4g?=
 =?us-ascii?Q?q+vksArO23Gg2qFqOEtKvTOtuyA4roHxKM54i2kIO0OMXnMirp0kLgzcBcg1?=
 =?us-ascii?Q?ZZxzoqr3XuBRJCPdc51FLzVB4bwaqnbQdQlalz7JjZDyFw74PjL9JMbaObh0?=
 =?us-ascii?Q?SLyyb+HFQTFCRDZN4FjUFdoc/dXnuH1OtWs9w/IL7X8EDzCKwAoyk9hQM22/?=
 =?us-ascii?Q?3ImNDj3f300XTG/mSFTUsp+CmL9aaQ6KXOntzj0S2F4rO/7dHLPvMMxG+LQK?=
 =?us-ascii?Q?0v5ILyt8fEo6gSig1zXn2KlmVeEq1fqscHUIkbbTNGUCWOnpeJ7zvu0Mx8Id?=
 =?us-ascii?Q?3jwic6AcPEac1p52Qa4ztk7FZ1yCbSL9j3NQTM5umg4tMA5z3w5cAKdlQuud?=
 =?us-ascii?Q?q4mPQQugGG3ss0YltmiKkCexsCbOFhKk+9yv5csNOsmjMr2w3oOagBUOIk88?=
 =?us-ascii?Q?Ogt5cO7uRI0T+bp1VAvcYhIPsseDxn3ZTR2AnZzh+ZRVWsHSG1GPVqn6ZGYX?=
 =?us-ascii?Q?hjG3v/tUn2oenaPpsOHr+aZ0fmpDs2TS8rmnTXk6aHINGZS/uF/su+v1Df6o?=
 =?us-ascii?Q?cL2xzfa7RvjnTlrcLHsO1H0qEq4HKicTIJDXN1QytWJb72uVi6+TpJJvEE/0?=
 =?us-ascii?Q?LdvqEIxtuaB8hnL9PI9k2ygmR0zRSd6jVIjEdp3uSX/slnSRqx0yvW4jHj11?=
 =?us-ascii?Q?whkXgaoYvErnTOrwODUFznyKpLDLIyFhzBkValKwYPATlJEQdqnCJOEp1beg?=
 =?us-ascii?Q?EgrAVWlxMMIh7B/Qke1v7fBjAVtWsvM2i35PSf+Ml6ocAJQt0Yw5u7QMbxJ8?=
 =?us-ascii?Q?h2tSTWlnmwi6w5Nky6Zh3Vzz7BKp4TLJb6s+6saAuDTN2mYTkv6FrLn+wFw/?=
 =?us-ascii?Q?zX9e2I96pZufVE9B2cA+psSaWcZqIarpWJL7wzRsnkfJ8oxToME8cUl0kuYd?=
 =?us-ascii?Q?bwNQeMWi8zSdzVyYX9xVmouF2SKXQVLJnhT9zptX+MbuEHTOePU3+HMHBUqJ?=
 =?us-ascii?Q?qfFD8kwSnUnYOK0+/7dUXsX6JlqPiesBUQRbqNCPO0X/JKnHyUWK0fQyMnve?=
 =?us-ascii?Q?5qFU2JLDJw8nrF8fvplFr3/r8oGKaYYar3St7XlVCrPUYo4yb3V73w+48ucK?=
 =?us-ascii?Q?E69QgVkyBvsU5nuSRWpDJcmxmvSVP6e9ABr+BruR3q1ianIX/xUpt8Ixcj+G?=
 =?us-ascii?Q?HUNO9o6ScgnavllMPLoTV+/wvJD5EAbuu37DaPOSBnM6vsiOBfZgXBB83fad?=
 =?us-ascii?Q?U46rXRUMb6+KsRkGiIlBt7Y5lIeIoEpx6dezNzSIZaK3Z0f2hrid2IDIKm3h?=
 =?us-ascii?Q?0wbSbwxM0+Sk4ee0Foy6hIDyRfGlI9XJyjvuabb82FcKA6BmEwno3RhkIoyy?=
 =?us-ascii?Q?npPi4QpO/RuWG8WFCsDlYMgHvNo80RRlitGxm9BFx9xLRGGnDehiS1O+xYKb?=
 =?us-ascii?Q?EjMR90tWhpTGHUsE1d/9+jiqaGTkaShE3Of2HXrE0XDG6Z/vLvNGX5jHYKJv?=
 =?us-ascii?Q?O2LEa7PjxrzrN0AwMp3fVDeOb4VxzMaFLrc+MdeHnN91SR6nbIqho4xCzKYC?=
 =?us-ascii?Q?xbSTsYPXhQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g2wJT7WhQXy5SLku6dOjC/bgWpozIywOpO/IRMhZFKMmlnBXrj6ci6zO+SzIzFLo5kCAdraygSF3fdAxYQLgvqeghHX7IAC/S1UWzEOn9pZlJhXf4sXJexMi5Grv/aBG5U/hiYYmquyp07/lnXyL79YbbyTvhGCJ8f94x6SQIWKZOeBy4rCCrJcDiqpyRfCm0fcuaXjpgxwOZC07nAVxz3iO8gSL8ePlgXwtYjol5cjq82nlKARQIlQI56cpXLHyg901J7bu7wY9OE16tN9wwsx4kXlwkwi6u0E2QzDgeehJOv8LYC5hvV/fyg+NpersPZ7Icmm2yQyodNGSkoyGT7fbX4F71fk7TRFJ/yINPOHgf5oVENpz5F9mCqgMNppEV01kfW49+YxgRvAx9+FQkznlR8eVXnAJzpu9OwjxOmuCaGuSiPeiSIkHGzAJ4j9bh+93fvm+h3P6taAI2qxmbcV2DFQmNlYmeeIIXQnonbmX6/rO0hKBYAPjfrHqfJxuzCxTG8VTvkIRbdf9bpcB5eCXKHXsFdK2xqqD4b3xYjxHHZO5H5/cEcEGCrjf/tGcMAj334YXsYEvs7jW0fcWc39n/SQLpSRfx6EqWOGtI1E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020ab4a2-b1f6-443c-c93b-08de7449a7ff
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 08:41:23.4258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZ745vYJWljSdywfnMK8vnqqrSudfyzvD1qUgnPSJ/XOX3D+6qmt33sp01ZoeQUsZVuG8vmGDwf6fK0kxbgS9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR10MB997773
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602250084
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDA4NCBTYWx0ZWRfX/Xx9TiomeFW2
 adx1LtQiAAmnbriVqRv2rgsGwZKeh5GwtevYOTyAVdZ5KD3oszg0+7jy2DNCjYOak8g6Y3dV+g1
 vI3qJmg9xAXsPZpMs/D9aWzzcGMx3RhTFG8UbJ+0j/MMhoRm8aD5ohxCTCOoaHGJPUkTzuyxuz5
 HDfvwyU7fWL7q4vGI1G0LouXCW7GhtEUPdVVav6WLK5x9y1GikMBEEE+M0wuXyThn1W0/pQfzMD
 CDaZd5GD/LJndeNorhPq5UnMGUjoOmZeHb5hEyHlSqcELMvZAJE8F0moSeENTJvRCXpi1qnbJJc
 AJNrOOAqy1YdaCf0uLcbxdcoGBOj8ljgacdVyDdJnWzzc1MKoFKrKKCR3vRA02EgZh4UzksHF2g
 MFL/nJhk6ZXxA00+PV3aDpqdCxVr/TXHFhj0GlKL1xxCEhV3ejSccHqhImeVph0EfrB07C0a9Zb
 spEEIr1S4Rq21EhWMvA==
X-Proofpoint-GUID: ZqJJKLCSKVlOUoHwcckUas6c_DvUsDTt
X-Authority-Analysis: v=2.4 cv=b9C/I9Gx c=1 sm=1 tr=0 ts=699eb5b6 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=07C2qf2vc5oDr3DVq9AA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: ZqJJKLCSKVlOUoHwcckUas6c_DvUsDTt

On Wed, Feb 25, 2026 at 04:19:49PM +0800, Hao Li wrote:
> On Wed, Feb 25, 2026 at 04:19:41PM +0900, Harry Yoo wrote:
> > On Wed, Feb 25, 2026 at 03:06:46PM +0800, Hao Li wrote:
> > > On Wed, Feb 25, 2026 at 03:54:06PM +0900, Harry Yoo wrote:
> > > > On Wed, Feb 25, 2026 at 01:32:36PM +0800, Hao Li wrote:
> > > > > On Tue, Feb 24, 2026 at 05:07:18PM +0800, Ming Lei wrote:
> > > > > > Hi Harry,
> > > > > > 
> > > > > > On Tue, Feb 24, 2026 at 02:00:15PM +0900, Harry Yoo wrote:
> > > > > > > On Tue, Feb 24, 2026 at 10:52:28AM +0800, Ming Lei wrote:
> > > > > > > > Hello Vlastimil and MM guys,
> > > > > > > 
> > > > > > > Hi Ming, thanks for the report!
> > > > > > > 
> > > > > > > > The SLUB "sheaves" series merged via 815c8e35511d ("Merge branch
> > > > > > > > 'slab/for-7.0/sheaves' into slab/for-next") introduces a severe
> > > > > > > > performance regression for workloads with persistent cross-CPU
> > > > > > > > alloc/free patterns. ublk null target benchmark IOPS drops
> > > > > > > > significantly compared to v6.19: from ~36M IOPS to ~13M IOPS (~64%
> > > > > > > > drop).
> > > > > > > > 
> > > > > > > > Bisecting within the sheaves series is blocked by a kernel panic at
> > > > > > > > 17c38c88294d ("slab: remove cpu (partial) slabs usage from allocation
> > > > > > > > paths"), so the exact first bad commit could not be identified.
> > > > > > > 
> > > > > > > Ouch. Why did it crash?
> > > > > > 
> > > > > > [   16.162422] Oops: general protection fault, probably for non-canonical address 0xdead000000000110: 0000 [#1] SMP NOPTI
> > > > > > [   16.162426] CPU: 44 UID: 0 PID: 908 Comm: (udev-worker) Not tainted 6.19.0-rc5_master+ #116 PREEMPT(lazy) 
> > > > > > [   16.162429] Hardware name: Giga Computing MZ73-LM2-000/MZ73-LM2-000, BIOS R19_F40 05/12/2025
> > > > > > [   16.162430] RIP: 0010:__put_partials+0x2f/0x140
> > > > > > [   16.162437] Code: 41 57 41 56 49 89 f6 41 55 49 89 fd 31 ff 41 54 45 31 e4 55 53 48 83 ec 18 48 c7 44 24 10 00 00 00 00 eb 03 48 89 df 4c9
> > > > > > [   16.162438] RSP: 0018:ff5117c0ca2dfa60 EFLAGS: 00010086
> > > > > > [   16.162441] RAX: 0000000000000001 RBX: ff1b266981200d80 RCX: 0000000000000246
> > > > > > [   16.162442] RDX: ff1b266981200d90 RSI: ff1b266981200d90 RDI: ff1b266981200d80
> > > > > > [   16.162442] RBP: dead000000000100 R08: 0000000000000000 R09: ffffffffa761bf5e
> > > > > > [   16.162443] R10: ffb6d4b7841d5400 R11: ff1b2669800575c0 R12: 0000000000000000
> > > > > > [   16.162444] R13: ff1b2669800575c0 R14: dead000000000100 R15: ffb6d4b7846be410
> > > > > > [   16.162445] FS:  00007f5fdccc23c0(0000) GS:ff1b267902427000(0000) knlGS:0000000000000000
> > > > > > [   16.162446] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > [   16.162446] CR2: 0000559824c6c058 CR3: 000000011fb49001 CR4: 0000000000f71ef0
> > > > > > [   16.162447] PKRU: 55555554
> > > > > > [   16.162448] Call Trace:
> > > > > > [   16.162450]  <TASK>
> > > > > > [   16.162452]  kmem_cache_free+0x410/0x490
> > > > > > [   16.162454]  do_readlinkat+0x14e/0x180
> > > > > > [   16.162459]  __x64_sys_readlinkat+0x1c/0x30
> > > > > > [   16.162461]  do_syscall_64+0x7e/0x6b0
> > > > > > [   16.162465]  ? post_alloc_hook+0xb9/0x140
> > > > > > [   16.162468]  ? get_page_from_freelist+0x478/0x720
> > > > > > [   16.162470]  ? path_openat+0xb3/0x2a0
> > > > > > [   16.162472]  ? __alloc_frozen_pages_noprof+0x192/0x350
> > > > > > [   16.162474]  ? count_memcg_events+0xd6/0x210
> > > > > > [   16.162476]  ? memcg1_commit_charge+0x7a/0xa0
> > > > > > [   16.162479]  ? mod_memcg_lruvec_state+0xe7/0x2d0
> > > > > > [   16.162481]  ? charge_memcg+0x48/0x80
> > > > > > [   16.162482]  ? lruvec_stat_mod_folio+0x85/0xd0
> > > > > > [   16.162484]  ? __folio_mod_stat+0x2d/0x90
> > > > > > [   16.162487]  ? set_ptes.isra.0+0x36/0x80
> > > > > > [   16.162490]  ? do_anonymous_page+0x100/0x4a0
> > > > > > [   16.162492]  ? __handle_mm_fault+0x45d/0x6f0
> > > > > > [   16.162493]  ? count_memcg_events+0xd6/0x210
> > > > > > [   16.162494]  ? handle_mm_fault+0x212/0x340
> > > > > > [   16.162495]  ? do_user_addr_fault+0x2b4/0x7b0
> > > > > > [   16.162500]  ? irqentry_exit+0x6d/0x540
> > > > > > [   16.162502]  ? exc_page_fault+0x7e/0x1a0
> > > > > > [   16.162503]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > > 
> > > > > For this problem, I have a hypothesis which is inspired by a comment in the
> > > > > patch "slab: remove cpu (partial) slabs usage from allocation paths":
> > > > > 
> > > > > /*
> > > > >  * get a single object from the slab. This might race against __slab_free(),
> > > > >  * which however has to take the list_lock if it's about to make the slab fully
> > > > >  * free.
> > > > >  */
> > > > > 
> > > > > My understanding is that this comment is pointing out a possible race between
> > > > > __slab_free() and get_from_partial_node(). Since __slab_free() takes
> > > > > n->list_lock when it is about to make the slab fully free, and
> > > > > get_from_partial_node() also takes the same lock, the two paths should be
> > > > > mutually excluded by the lock and thus safe.
> > > > > 
> > > > > However, I'm wondering if there could be another race window. Suppose CPU0's
> > > > > get_from_partial_node() has already finished __slab_update_freelist(), but has
> > > > > not yet reached remove_partial(). In that gap, another CPU1 could free an object
> > > > > to the same slab via __slab_free(). CPU1 would observe was_full == 1 (due to the
> > > > > previous get_from_partial_node()->__slab_update_freelist() on CPU0), and then
> > > > >
> > > > > __slab_free() will call put_cpu_partial(s, slab, 1) without holding
> > > > > n->list_lock, trying to add this slab to the CPU partial list.
> > > > 
> > > > If CPU1 observes was_full == 1, it should spin on n->list_lock and wait
> > > > for CPU0 to release the lock. And CPU0 will remove the slab from the
> > > > partial list before releasing the lock. Or am I missing something?
> > > > 
> > > > > In that case,
> > > > > both paths would operate on the same union field in struct slab, which might
> > > > > lead to list corruption.
> > > > 
> > > > Not sure how the scenario you describe could happen:
> > > > 
> > > > CPU 0					CPU1
> > > > - get_from_partial_node()		
> > > >   -> spin_lock(&n->list_lock)		
> > > > 					- __slab_free()
> > > >   -> __slab_update_freelist(),
> > > >      slab becomes full
> > > > 					-> was_full == 1
> > > > 					-> spin_lock(&n->list_lock)
> > > 
> > > In __slab_free, if was_full == 1, then the condition
> > > !(IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL) && was_full) becomes false, so it won't
> > > enter the "if" block and therefore n->list_lock is not acquired.
> > > Does that sound right.
> > 
> > Nah, you're right. Just slipped my mind. No need to acquire the lock
> > if it was full, because that means it's not on the partial list.
> 
> Exactly.
> 
> > 
> > Hmm... but the logic has been there for very long time.
> 
> Yes.
> 
> > 
> > Looks like we broke a premise for the percpu slab caching layer
> > to work correctly, while transitioning to sheaves.
> > 
> > I think the new behavior introduced during the sheaves transition is that
> > SLUB can now allocate objects from slabs without freezing it. Allocating
> > objects from slab without freezing it seems to confuse the free path...
> 
> I feel it's not a big issue.
> 
> I think the root cause of this issue is as follows:
> 
> Before this commit, get_partial_node would first remove the slab from the node
> list and then return the slab to the upper layer for freezing and object
> allocation. Therefore, when __slab_free encounters a slab marked as was_full,
> that slab would no longer be on the node list, avoiding race conditions with
> list operations.

Right, that's an important point. Just realized that while elaborating
the analysis :), there was a race condition between you and I!

> However, after this commit, get_from_partial_node first allocates an object
> from the slab and then removes the slab from the node list.

Right.

> During the
> interval between these two steps, __slab_free might encounter a slab marked as
> was_full and then it want to add the slab to the CPU partial list,

Right.

> while at the same time, another process is trying to remove the same slab
> from the node list, leading to a race condition.

Exactly.

> > But not sure if we could "fix" that because the percpu partial slab
> > caching layer is gone anyway :)
> 
> Yes, this bug has already disappeared with subsequent patches...
> 
> By the way, to allow Ming Lei to continue the bisect process, maybe we should
> come up with a temporary workaround, such as:
>
> } else if (IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL) && was_full) {
> 	spin_lock_irqsave(&n->list_lock, flags);
> 	/*
> 	 * Let this empty critical section push back put_cpu_partial, ensuring
> 	 * its execution happens after the critical section of
> 	 * get_from_partial_node running in parallel.
> 	 */
> 	spin_unlock_irqrestore(&n->list_lock, flags);
> 	/*
> 	 * If we started with a full slab then put it onto the
> 	 * per cpu partial list.
> 	 */
> 	put_cpu_partial(s, slab, 1);
> 	stat(s, CPU_PARTIAL_FREE);
> }

Hmm but if that affects the performance (by always acquiring
n->list_lock), the result is probably not valid anyway.

I'd rather bet that Vlastimil's analysis is correct :)

-- 
Cheers,
Harry / Hyeonggon
