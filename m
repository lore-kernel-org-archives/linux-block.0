Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC03015A8
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898767; cv=fail; b=HMd/Hk0GYAldJec+/fJ79H5y1Hdxtrv/aTphMnWHTXXqA4h7Q8hLzNaSn6PXmVhc1CRUl03vLRGvQFmw8HoISmNQxWR2S1ZqnSxghPkJM+5kHwl+Ul2N5vd0/mEEgDpTUiH3HZ+MGHCY5l3sJkUeXlbwtwWC36YABp6wXJj5XRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898767; c=relaxed/simple;
	bh=LFOvBX7jnva0qt2xvGFe49434ZYS7tTdEPcgTbifV9k=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=Cl4gaXySOf0DPo8ajYo1lh3jH9i5H91e6pxw4T1dmNVW7ertAg2JxQXqmIKbqAkpZlX5bepucHBoj8UFYhCF2W6KFnBbCUucM0aUQWuW5gSqsUOu4lkecBrk6iUqOpEZt0KJMFCsLmbdd2PXuk5aUFJsddPt+bYJOld56LQYdaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mogF+Oq2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Lxlg3Wkk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mogF+Oq2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Lxlg3Wkk"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HBpdTj005104;
	Thu, 17 Apr 2025 14:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=UaPGq9nnVGDZtM3nd/
	Pg92djK57OufqERJ0ZDyteL6o=; b=mogF+Oq28rdFsUyT1kAjwl2AzZLGhwbKtO
	3TqQgubFDAx8L91wTlD4hC41oejyJ9WEEE9UfjE7y7BiU16wmtFSwwGl/iDOc2pf
	rSHHailYJYg3XXP3cRAAATZXLXERtCymSll54lZHtQlm9GmTdwInZ+q2AFVeBFzw
	aZBOO6qqtGtlnHSnlR24LSH/RODBcgPV26YTNGiPAjeKiKqtVDQfDfTmKgnwIT56
	4ExFS2OIhqWUIupSF6wvByrr4lE5VYVbEylRJ8YupghBREwBQrghW/MC8nivgVFQ
	qk5Ac+aIs5r15BYWzcgvvjKJtmjefWvL9Y4D3HNLlzHQjxxeEu/A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4619446afs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 14:05:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53HDcKcQ030983;
	Thu, 17 Apr 2025 14:05:20 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011026.outbound.protection.outlook.com [40.93.12.26])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460dbdtwy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 14:05:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u4HBnuECvr+UgqaYBP7/KFshCwvyIBjUnoNw7OsKmQDHBAkhlKJclb0qSGa/llEPqbyjlLuJwjEZs4QUeM3GOrwpsMy0jZvbby69B9N0T/s1Wq2yuQMeR125taLcio5EC46k1+8SsyUSWqhrXd4XV019BKo6SU5qMQr0q2ES8WAP6rJ4JSAGxXDTJCbpqoBFnSQbrm4VIUz+IFkv8EjRZQB3O3QTmU0tP1c2yu/xUTzTJDI6NmqlBkwebiU4sbeduRbcUrG0JFYUAARlKS2J763izUiIry4Ou3FCfh4lvhtYt4AC5o6du2FjIMpdqaBnBkK8ggO0h8nz1vHdwO6Ezg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaPGq9nnVGDZtM3nd/Pg92djK57OufqERJ0ZDyteL6o=;
 b=ECzc3QqM2l5Z8q6AMNrYFXYYddio49SV5cMvWPsETDMvsHorv5hzwCc4lxQ2ZgL026OKs4Fee2mLNR61LdvLjWEWREtehml+Akdzgyy1MDHd9mirhiz6BvOIYjIuNXAeJxPvIN92J1IkCtHQHGtA1f0jOu/P7HfyJCELkiqREDVesvjICA5KLS9ZagHy342vzLRnFOAf3eonDUdIR3A2eUvImbq6Y81lcOhQNr9k0NknhNiotqK/Uew0pDCXuwIsm6dFxnoe5b1Lx9591qqX43cUapcOvk57xtbuQKRIS/K8ayF5yp5r/3ipod8vbm19/iBD1lfGHk+FrrtcXHAlhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaPGq9nnVGDZtM3nd/Pg92djK57OufqERJ0ZDyteL6o=;
 b=Lxlg3Wkkz8AMPkldlNiJBs1diffkpKeOL0IIDBA2dvB+jJ5nB9ZW2iA2kl1xW0Ew6ErcOteBfPJrqcCLIWANAl1iQfb1ABOTutA0bFSqsvWjZWsKcOcCy/ctSVBvrMCW/2lpWTSEVMveSQxhF4GAgSSyCYtkQbWFfVpMclUqFWs=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by PH0PR10MB4567.namprd10.prod.outlook.com (2603:10b6:510:33::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Thu, 17 Apr
 2025 14:05:13 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%3]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 14:05:13 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch
 <kbusch@meta.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk, Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett"
 <Liam.Howlett@oracle.com>,
        Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH] block: integrity: Do not call set_page_dirty_lock()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <aACcuGpErEsBcxop@infradead.org> (Christoph Hellwig's message of
	"Wed, 16 Apr 2025 23:16:24 -0700")
Organization: Oracle Corporation
Message-ID: <yq1jz7idh39.fsf@ca-mkp.ca.oracle.com>
References: <yq1v7r3ev9g.fsf@ca-mkp.ca.oracle.com>
	<aACcuGpErEsBcxop@infradead.org>
Date: Thu, 17 Apr 2025 10:05:11 -0400
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0272.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::7) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|PH0PR10MB4567:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c079b13-d18d-4c52-22b9-08dd7db8df83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vo4H3EUhSndGiTvhjaK6SR8aXhukXXFlxnGkC2kzkxiebyHmAm1ZmoIy9glo?=
 =?us-ascii?Q?WWjX5dQUyK82emtz3mhausFdblZloxAl1O0kPelyD7bw8aHE4XbdFwiHw/OQ?=
 =?us-ascii?Q?8PUBnLYc+G0O27QyivdwKzowAXNL5d8spwDZh/0Pv9aDobnjUXo4JPZ2MTOg?=
 =?us-ascii?Q?AS4jOnSNkBkWqwoYBmluZgbQ94LMJY57+PIJ/zlTn/N+9P6irxJDsS/i1AZ0?=
 =?us-ascii?Q?MKLynheGf5UVNjPkbLJiInyehBPNm0fM/uIP0IGQ8llYJXDCfB46jgyZqDn/?=
 =?us-ascii?Q?u7HKMq5fNGMFrGC9MFWam/gpE0FYsqbV3LCIgZXYAoAwCp41uzb1v2jNIvJK?=
 =?us-ascii?Q?QRJ/8UvHtYyWpRvGn1k+bIZ3/39G2/p5M95CIFyCavWyBCuLKZka55vZdquw?=
 =?us-ascii?Q?C3Ve3xhXLUeEu8oe/OnNEySEIhosZPPJsVoA/GREqHIwamDSPwKgA0IdLAwQ?=
 =?us-ascii?Q?qn/sT+VlNly9BS1ReDtg8WhnQ3sSBAo7cDCwNqnjUxSSX85UYhyrWSca7xOC?=
 =?us-ascii?Q?g3vgkolO8YzORMkAUSQAX9e4wHXEBXg77qIAGIDGXFwPbm2uFjw+CLF4XM3S?=
 =?us-ascii?Q?O+lpCdVpY44XpuO+KInXZb5N5emKraf8aOcEwG5zwr1JrIK1GVD1eXc5wWEE?=
 =?us-ascii?Q?LtmdwG0vXFLkMGfma5C3HNo5xL3ZUPEGyCII6GRaypU/OZJTO9yyyA+/ufOw?=
 =?us-ascii?Q?lIJxhNW/XUZprPd4ERWpaVT6IEt0ZfU20EUry/aswhgWH4IAA6qePC4MYj4a?=
 =?us-ascii?Q?XnUZEzwuQ4chtg/HZpSZC6y2VLsPSrzEcpyVZVNsvV68TynNl+53eQRvpLal?=
 =?us-ascii?Q?6QIeTfLiZrvFqhbI4HWc6tUu9Vefq4JPiq0zTR7V0OoqwSxOt06XS9c8resc?=
 =?us-ascii?Q?A5qmzfRi3r6ZK5bBrTS6r0vVt/gz3a3jl3iKyM2uVMPfGQ8IWfoj+E7mAcce?=
 =?us-ascii?Q?suq2LrR3vzgREeuYg7K8rPSE0GVgT1Wet+TEs2pl8TKyMS5lj7Twf2/EOKS7?=
 =?us-ascii?Q?iqC2ZZ3vvQ7yyuJvFX7/M3TyvWmdWluflWItBG2G1utTYldWOIcJMKj0z2jl?=
 =?us-ascii?Q?B5JSwr9Zo1mnBMUBtaGFmJydA7x48ru8VJJeacd20Goo2YR1niK/tnCS5zBn?=
 =?us-ascii?Q?B/ivF3821Enm2EXnqvkgyPITSiiAERkNxOyC2qDDWWt9Z5/7DrKtL6K6K4Ks?=
 =?us-ascii?Q?lSh9aQkOAcSIjhE1sfFIFYojh9EIcRpHlQwBgadPXUn6odhjNTGVbZxcfdU4?=
 =?us-ascii?Q?JzrdFRBIZmyoARXYxBqnUX/tTCCp8DmdS99USQLCh2LNO7orrEcg8figo0N+?=
 =?us-ascii?Q?wgl4GtNlrTU4FelJTAIlBsuoBsabnyIeJgp1ULSv6DkoXew5v0NZx/mivumi?=
 =?us-ascii?Q?OYY1R5LgPbBWOZ19/2VjeuGEFcuhZ+01NP7Xkr1ziJXN3OS2xQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ayG2rNlx13+NlEilCe19WSz9df0Fj7ttcmTQTXhDbYGg6Y9yAGD3v+cx/mqI?=
 =?us-ascii?Q?1+UwG8BRapzm2NQYXvLBKCcUSwzThOeYxjN4zfMBnE0/NVt5M/6DjwZJcXUV?=
 =?us-ascii?Q?T4Yf7mlKhzytfruSNGWoSncSTYuzxYJK52kOdQ3s/efWpkmIr/KBG9SkQdId?=
 =?us-ascii?Q?85kgzSS7HvZwtlFviYWCgoOCCNgeUcILwrPlwUsxRSX6jGxNTmtC2J9grdZS?=
 =?us-ascii?Q?/sSOaiB/xaMLTjUc6IhURUgFBedLtHmSPNXaCDYnR18wW7ljjyDqpe1s6j85?=
 =?us-ascii?Q?gXsCzTZ/c/cVk23T4CHpvT8hy/xoOJ6Uxr2SvkRE6D6mlPduC+eY+yWMoMNZ?=
 =?us-ascii?Q?Hn8qqZUWY6z6kDBLZ7373kpSGQbu97IT8BoYmRomHOQo426R5UdNBc7jP/7Q?=
 =?us-ascii?Q?0DCweZteD+abPVGRgepoA/PGZZLUOlY7GV4DUf08dEv1T0m5aofhwW3IbSnk?=
 =?us-ascii?Q?f+lfoJ3lnFyyTMq13RjkJeOw8JagWfneaY3VokIPEeH5TG3zBl13vzsxwJC5?=
 =?us-ascii?Q?/Ra5GdFLa/wlgSGqWGTsU25G5WrV/IjOp4bASK9NIPe7pIGuy+WdGoAl1Eyb?=
 =?us-ascii?Q?3/g6n/lVkN1Jjgxi38/a7IBhtbuNHz+fewXnzC1nTezgNBpaHD4VMdJJaMA2?=
 =?us-ascii?Q?WGFA7gEbTrFvVqXrsvjLihuGiVQmndBAsEZu+UUMMgH4P+xlSZqIFo8W/Bq6?=
 =?us-ascii?Q?+Np0VzfvtXEN+GZXOBlKdBN8K6FAPc0SG2pb0TOzAWOP6rx5SvdF8kwBdA8M?=
 =?us-ascii?Q?UhB7j2KwOW7r1hmN3oNgUwVl5sLagTAQb0lG8jC8dQWBcl7+xu0cOb/RF4YR?=
 =?us-ascii?Q?gQzi6BRyU5eaNiFIThfYCyUFxmmgkpOjnAMBkP9l/0k9+xhp+S3hFuabX38y?=
 =?us-ascii?Q?FQuFCDijWPCuRjHqax6oMC/19udE5bsdr31YIhTiwQQV+wKW3FF/E7Lismjp?=
 =?us-ascii?Q?nMEWJB4rDZMExuSAT0EeoHj3oYEgpfiM46iA+CmQuK/vWZ40XE9bq1kiagUC?=
 =?us-ascii?Q?+v3SgpK/FjvVdFbXF0LxI0pFc2BqWQgOD+2n6Mgyr8fwwNsGlpp4YmZnJM1E?=
 =?us-ascii?Q?YVh2slh/epsUnhfXhZ03cZgMwCHv8x9u0Wh07aFy8tasVA4n6RnsX/4nyGrT?=
 =?us-ascii?Q?OEFiMUIHNdhmI8sEjWWqWS03wDXmGprAJbtT8yZy9WSWKMTB9VKSN4Pdj7Qc?=
 =?us-ascii?Q?3xP0J22zknsGCt8oCthHIdKLq3ZQshfIgvP/MiCuAllxzhZHy2jTRlJqT+CR?=
 =?us-ascii?Q?wQZIK39RYlxjBe6R5kdtQfa8Gsxp51Ozrnf4tMSqqYhRzMfY+43hMxdfa1KD?=
 =?us-ascii?Q?KP6GdTVQmtQMCi+cWJ0CeI6zqEVfS5zA4V0dGndswN+jtXrCZn7TR0FpuEFE?=
 =?us-ascii?Q?2nrCRQE4U6VQHPsjhQ68IlrSRpzi0l9S8YcW9THbuuBpRojeXxRlr4gJtKUa?=
 =?us-ascii?Q?xBHOUOfS4yla8XqV5L6n+tFUVzMbhoK/GLlUmKlVZFd7Fq/CrrVFNGyzFsfL?=
 =?us-ascii?Q?A/p/o7XBiuVvHo9dn4iCyQZuvkfwsLRWnmfId/D5U+PJswJe1UhCAJHT8/Yn?=
 =?us-ascii?Q?Ergd2wsGORbIwu8jAOKRT5ZuPrA4r7ePFJbed2kimIgiUmFBEwLreL0A4shv?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S2BOFEzvs2YIKNfMqIlIsEcDtYPOU9GgULty1pt8zZ+iT7eOecyCvsPNiSnguOP/T+Sa23J65tL4lJt12Yfwfp3xwaCJuzFXe/VqO9zFzPakoB52C4a7JmAIN5ixeXQY1VeMMpuI9VEL73YHLVxCZAMnmdsQIK8Quj3e7GXDbqc7x9QSY75D+YBLKYMU/VU8kILxSVysgkyZu6kwhqQLICmIgYKi26nJo/VckOMk/aMVzuiFDfwiTi4LpVBuuHOCyiicjWaYoxQaaCd8QK7QSG0myntVR+9AN2zwGduDhOdMWH4SRc6BJABd4Z1vBj+kXmDBlAmy30r40kYKsLKKa0ETwc+xIm/S5CaearOLiUJyvoqnwElNlN2AQo42ragkMNZnKKspRedoBpMkkH0Xl42m+RXrMh724S1ZiVVkVG2fFhRh7WfVV6Ileg6fbdjaLXQuIzmgWUmgTxMsiwRS9fj2yOzjqFxfy7zLEsKlowvIrvuOJ7X9m9WHASZcQxjFX6wVwpECUwuUsFnyPDEUCqXqMuMrr1SHyfFJenhDGntLeaY9Gtc5MM9n3GDNWEEcqbVnQwfc127DssBxKGPNaf2geS/jbkrV+D7yI/RMj1I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c079b13-d18d-4c52-22b9-08dd7db8df83
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 14:05:13.5373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jupxWXjNq+v4kWf+ibs9CyIMu/QWK5OjTuflLfshOOFjQ/Z9MO6s2yfTNp/XHozm0jUfFi6BX47bzBjHf39f6/n+HsdmKzrBsfAeEnBoLdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4567
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_04,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 mlxlogscore=884 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504170105
X-Proofpoint-GUID: urtnHim5B0fcwmKX3SFlUXX1bShgbsFu
X-Proofpoint-ORIG-GUID: urtnHim5B0fcwmKX3SFlUXX1bShgbsFu


Hi Christoph!

> Who sais it it not backed by a file? Which that would be a very
> unusual use case, there is nothing limiting us from using integity or
> metadata from a file mapping. Instead we'll need to do the same thing
> for the data path and defer the unmapping to a user context when
> needed.

If you have a use case for file-backed then supporting deferred dirtying
is perfectly fine with me.

-- 
Martin K. Petersen
