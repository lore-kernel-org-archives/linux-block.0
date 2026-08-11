Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6822B418340
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 08:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786436946; cv=fail; b=Cqnyaoqi5nK72YuOZfQhNuPuS18+vZVOV7tulxvkhWA97Sw9fEZjFwPu4XQ2cJIX10BQME84rCpWRuFjSIFKZMW5hDwNAU938trGCcMQKDSOfnd1Dq5HO6WAneLCY2Fbh0Yfmdx15JENw0GnyhKFjLBt4mLQkg0yPJc56GSD4KM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786436946; c=relaxed/simple;
	bh=tc3iFRAb39c0CG+tPMOBtHqNQflmr2v1Wz+4+mNAL+s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tNgtZhnZIdZGVTaiM9dGRrSl7NWfseLM8IBtBJLG+NWpnmazOBQb7ZgIRpTl+BHk4EmQ17JVOn8YU/R/jqpLYMhxSNkxDUbUmgVSlSc+AI7HTS9h8Zr+rCVJbN47epUsdNux9KPAm36gWD1KA9snsc3k2pPsV6H2ItgHMt+6PFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SeFEPZyl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xZN/zUWi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SeFEPZyl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xZN/zUWi"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67B1Ii3l1123721;
	Tue, 11 Aug 2026 08:28:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=CB8VMEFpZ0UkJnM8rtcfouZWTh/QyGEc+WPoRDATMgE=; b=
	SeFEPZylkJTYvFIZKvM97MpNikom4ZDwQdcxqbczBmFut8vZP/rRomV8I6OW7SkV
	4EsbIWcLVcLALU65o9mgSGvCpSl4MhrZnd+doZzDpQb6xAXmMFDPKCZV7L2EYUgO
	WQpua5lTn/Z/jmfBLHn6nu+eIL+iqQZBNaEMSyKz9jNmW6K81ODazb5BUdeeCeIe
	Na+TCE5pQ6OQ/Z/AJIuInzGX3wd3N/cTonhptnu8h1bCfjas0DQKwiI9b9e7X1Rt
	Cn1+lynnVVunOJZH6xkMLz1T/AHtGGhqxBPhQcLCbtBuDYEHv9RcbbneWRgUjGAU
	RE3GCRsht96XvwjV5+UJOA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fwvk9varj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 08:28:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67B8P7jb020787;
	Tue, 11 Aug 2026 08:28:41 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011031.outbound.protection.outlook.com [52.101.52.31])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fwtwdh2pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Aug 2026 08:28:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ub+YfwZb9ECNwjvSvLyJ0lc2WebtvlgBXX9ZeKBnD/HQUEVT0U+kc5Osot0C2NQN4XhPzfJkB3EAzIlxvznTfT6ar4IzowgpNHamU5tjKN9siaS6lFF1TZizlY461CWeflU1w1EGhhPV86OIDGsMcBeJZAE8sYW9aHu3IhdFLRpkKI5rspurBRPeIGaVe8ADoZdcenxWjykxh7qgd4NkBVNJalgeDLpqYsZM+8LSbMqhcjnfKESnliV8Wbnk6DQnKxpCdCVdLeh1z6jcPYHCa7bTBSy8RvCl15W2fFolnGDq5TqJ+AsUvlPm/Yh2CTcEhyjtr4SJ7MQtr3L40kNYbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CB8VMEFpZ0UkJnM8rtcfouZWTh/QyGEc+WPoRDATMgE=;
 b=mJWKCLwnKSEzwXlWxtlE4N2izj1NWQd4dNMRsU+TENhspRZQUkvl2/nfJjI5tHFGR9Iq6qFdRQLoA5/bCNfZpSEMp91BsRABXqieRy64xbCGIjibgwpQGQh1YfYP4Vc8WLDzNIxnkwavVgXUGoxh71Q1GhHAeaDmA10A7LZ1N9pQIH1ugLcIFvyxKIgN+dBToaeInsTQB3Z9utL8hxaJYBl6KBUM07QcC/hMWMLc0PfAZl/wai113G/6P1wxgKTLaLuArFQ2IahVFAFtX29E4JdQvBL9u6h79m1ejz9hLnmRAxSP993mEpbLj3ZeG2eCV5hgaj6fKig4BADwfaasdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CB8VMEFpZ0UkJnM8rtcfouZWTh/QyGEc+WPoRDATMgE=;
 b=xZN/zUWiTpGpowWee9lOEvmuuMx9K7jglytl+0tVmgwWk42fCO789b1QC86wz+ueobx//nHgHZaffNAND03rdAZkT+DEjOuvl+uWEqlK2JCa4osqsGHGgiNAxumec7xQJvzuQBgtjQkyFrBEx6W7uFKen1G1NGOwR6KpFNm8cl0=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 IA4PR10MB8375.namprd10.prod.outlook.com (2603:10b6:208:560::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 11 Aug
 2026 08:28:38 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 08:28:38 +0000
Message-ID: <54355220-e8e7-4c6f-aa58-cd63bdf16771@oracle.com>
Date: Tue, 11 Aug 2026 09:28:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] nvme-multipath: fix diskstats for partitions
To: Keith Busch <kbusch@kernel.org>
Cc: John Garry <john.garry@linux.dev>, Christoph Hellwig <hch@lst.de>,
        sagi@grimberg.me, axboe@fb.com, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20260721114553.1657841-1-john.g.garry@oracle.com>
 <20260724050152.GA3680@lst.de>
 <987782a9-e12a-4098-b438-a54a5765c2ae@oracle.com>
 <amNegPEvRX99EvPN@kbusch-mbp>
 <f76e9466-4b66-4a32-a491-728e24d34052@linux.dev>
 <amOGxr3rxvDflHLv@kbusch-mbp>
 <94ed42ce-895d-4197-994b-60fc1d3f040c@linux.dev>
 <d3058b64-e162-4bfc-990d-13ff5f03143a@oracle.com>
 <anpzD5PaOn-_K5hn@kbusch-mbp>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <anpzD5PaOn-_K5hn@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0305.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::9) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|IA4PR10MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: 29c57482-d94b-4e98-7948-08def7828af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|3023799007|5023799004|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	KbK0c0P1aRT/1FTXZNUCQURvt9yDgxtg3qj1JzqR7oDOr0ci592Sqmr5E+HbGshWME1ilXGdN21RjDOoKsriheBPe9UO+HOjeak25EwaCtigUBvRq2LCywtc79juXQIIhokVdBJcwPCSZXkG7gEgKSiJQFNCFi5u2Y1iKG1A771XihB6U18PpSULha5GgtTNOy4b1DkC0TQ59zkJtPYxPwPTKJeWJDMaQ9sXZ0aUTYa2Gnar0xkNhgh978CAEMWE2+pls4UKpfRc+geBQ28fm4HSOYkC3uTtxIcXYcq7/U7UNDO0ssteuA1X5JF72CK2TTwxCG80Byr17nhoOtNy99/MGxRddO1ea74RvbhFasKV5W2jmG7rm3zI0RQYASAdEikle2vz1xUPr+7u9lnANGthPACcqUsHz1aaXlSLTzOQVubHA6WeIlDWu9PLTAejIO8IHnpB/4inrD41XddKy63+kcxeDQOgsKXOCzHQYqRxkyoUElRYWg+18HLRasP9r6oqDBCmzBm0N5XSIChmowZ5HU5fuf1fl19SrZF9AisikmhDgPnEZMXIcJzOeTDtg5uhheQlFqG5w6vO4fKjIOO8RyJqDKZDQV/U36bu+X7+mpq5IVsVuASGstnx63qBv5Fjalxfc7YCa9C+dNxGFtQ9pXbEgqWcMtT4rQusGIc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(3023799007)(5023799004)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2hkY1ZoUmd3YWhtN1lmTnFqMVpQREFIejlIdTladk5qMU1xUjdKMHZocXVF?=
 =?utf-8?B?UzczejVUdnJvalI2Q2l0UGVYY3ZvWXhVY0VYWTZpUzg4ZVc0VkRVNTVJcytn?=
 =?utf-8?B?NjgrSVBoNFJaZ0M4N1d6c1JaMElhWDFwRkJoU1lMeTg1Rkt1UHlOK1R6d0Iv?=
 =?utf-8?B?MHcxK25FSHBXbzZva1lPeUdtc2xUYTNqWlU5VWJwS0NOUTN2Nk9BU0N3QzNC?=
 =?utf-8?B?cVkvMW1VZFN1VmFSTmpDMGVrWjJDekNBUkxCTnBSRUZTMEg4TkZicjcwaHNx?=
 =?utf-8?B?blJGdXNqVGc2TjhEN21yYmlCV09ZM1ZLWFR1L1dZbXNiWnVpam9hbVJPTVEv?=
 =?utf-8?B?bkEzbWllR1pKenBwdnN2TnNMcHhETGRzcG5JVE5XcDZreHExNk80SXRBT1VR?=
 =?utf-8?B?QkZLMUs4Vkx1ZW4zSTRrK1hLekZnUko0SFZuT3loOGR4VklETUNlSXh3TjJU?=
 =?utf-8?B?bU9ROHZ2SzROam1Na0dpb2xHZzkvWGR1OTNuWmw5NXMxY0M4UTB1N3Nudytj?=
 =?utf-8?B?S0dxeUVnMDlSWGs5dlk2NVo3VDJkekxJVjNiZ2RKTUVpMGs5dnRzVXFwMFR2?=
 =?utf-8?B?YkgwWXVwVjF4dHpJS1hWMUt1cXp0S1BCeFNvMlRqRlVtVFRMdEwrbkdZWHE5?=
 =?utf-8?B?a0dxVjM1TWtKMy9LSjc1UG5RbzNEd0c4MUJ6bzQvKytnNEV5TGttNjBlMmFv?=
 =?utf-8?B?S2tOSnVqb1pIYStyaHl6YzRoNlFDNEt6dEorUkFFWjdORmZrYnlkYTNuR1Bj?=
 =?utf-8?B?Z1pqTi9aMGh5dW5lU0hod3VRd29TVlZoL1RWRXJ6Z25vaEh4Ym9yaXQ1cUN3?=
 =?utf-8?B?ZTBUWVh1V2M5dTN6TC9KeG9XdVoySUtWU1Q0K3ZSWDJCdXJwZU9lTlQ0ckdl?=
 =?utf-8?B?dHdEaENBcnhXZXA2R2o0MXdaZzNvL0paU2dyS1E4cnF2NVZkWFRpaDRadG1J?=
 =?utf-8?B?U0M1L3RlSEE0Q3E0UFhaZ0l3ZE9yUTE0VlhMRHNibXAzbjBhSE9QbkdaUjdZ?=
 =?utf-8?B?OTU3d1pnS042M1BBWTZaSitpVXFCcWFXR25GYWhscmU0aVNXM2dmbHdHUzd1?=
 =?utf-8?B?K3d2cUlpdEIrN0VManVNK1h0bTBSUW00WTFCaGtORUZPMFhxc3NFSEQ1REVp?=
 =?utf-8?B?cFpEV3BDcytsRmNZYlBlb1NrNVBUVXBKRDVhT2tpeWIwSVVOVExFUGFYc0dO?=
 =?utf-8?B?OExwSjBReTVNSXJLV0IxbzJpOXZvaVpOVVJjSENYd2F6R2pBeE1ORFErcjAz?=
 =?utf-8?B?NW5kVXczRWpnU2QxYklVMWRya00yYWlGT3ZnQUpkbWdBdk92T2FoUzlIdjNL?=
 =?utf-8?B?WG9ZUVlpY0VmMXJkSWxlOC9kU1BxUnJZakh4T3R1VUhrZU01d3ZVOVVIL0RM?=
 =?utf-8?B?VnBUUHNiWGtwdWZJdFNMc2p4bk16aVU4YzJ4aE5KZ1pDbERnVFVOaGtGNjlu?=
 =?utf-8?B?N0N3M0kxcFlEdVN5ZEsweXRCV1ZDaXdlU1JGL0pCRWJyb0FxTWNJQzV6Nm1V?=
 =?utf-8?B?OVgvSXhXVFQxTGFuQlJ3cDBkdmhyRUlxWEN6Q3k0emxETDc1Ujdqd3Q5WjM3?=
 =?utf-8?B?VW5kMkE5QURZMG9NNHBSVlhoclJBeU54Y3hlcjErdTFNeVpKa05PQjk4TEEx?=
 =?utf-8?B?ZC9NZHJnaDJ2ZHlZeVlOS1BqRElvaktLL1hURjd6R0lPTUtmdXRvTEl6ZDZB?=
 =?utf-8?B?L0pmamU2b3c3a0hvdnJZelFtT0tLNVVYUSthWTlLZkU2SURVc21vcDd0a0pH?=
 =?utf-8?B?bWovKzQ2N2VOOTRmNUlFenpYeENmV0t0aUZLNzNoaDZqa0VWTE80Q1l5eDBy?=
 =?utf-8?B?NHczWmc2SG5Ob3M1VXBJNmhkZjkycCtueGhwWVFSRUw2R1Iwc3J2K3RwMFhn?=
 =?utf-8?B?QWR4VFNHNXNFdnhhdGNFNTl0RjB5T3owbUpFcElhMkdNM1ZWUWxFMkdhVzI2?=
 =?utf-8?B?RTAwcFNwWEdSSnYyL0ttZDkrcjR3SldTT3ZMK1pYTmcydS9LbHJpaHZVb3Ro?=
 =?utf-8?B?WnM5WG5TRXIyRzgzNWtXdzljVEpxa0E0MDJETjdrNThDUjF3Qmc1QTU4NGNl?=
 =?utf-8?B?dGZhYzNsTTV6aWZQVUhFSGFWaU1FdFlHK2pJa1JwS2ZONGNsM1R2TFg0dnlZ?=
 =?utf-8?B?TFk0VUYrdktQQ3cvYitqaW80U1VmNzhkU0VHaytraGdNekZyUUpiZUkyYlVF?=
 =?utf-8?B?Q3c3KzhyQ1BFRSs3cEJKdkVXc2VLbGhOeTRHdnM3NFZMT1BEeGxWdG1NZ0k1?=
 =?utf-8?B?dkwyOFg2UGk1YkQ3bkxPMnRDWEw2RE16U1lJdlBQZDQ0Z2pPWWY5VXlrUy95?=
 =?utf-8?B?ZVplR080TTZMYzM1c2p6M3NnL1NvbmljeXNaTTQ5dHl0YzNPeXJ0Zz09?=
X-Exchange-RoutingPolicyChecked:
	JmdWJfa0TR12YOtO6SpmDTBDkWK3TkneRC/4S0o/aqkvvvrfVrjMdu2MNDkjNV2GBdFmiXFdRgAVJAtD5YoyVJnT9C4iODO2/CdW5jo6Duov8s6Dqqw1vhfgZEmMCui87bLvgV7yv6Ypi+UAJj05aWCjmDHOkEl9xEZa4KYpyMk6Zmvo1wxdi1zAnT0nmLg1CgPLt0BZHP5Xk537YF38kixrJuMULiOKBtjbrR3MBCCj0kp5N/p5qPaYySlmiheTPgzLLRimXtody7ykou95DRESBoqnWDVJH3c2pvc5p1zkbw8Yb6iOQWI6CI+R4IeCNeulzidhMfQfClgXNTVd1g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	82DHWL+pThCproHy5qAwwmIjZGRHWVuFQ8WX422A1PGBhd9bLJfvYU0bDSkkVUhUiE1SsTacjWDMgfKAfoVdUq8g9jodjiUYV+2Cu0np4lC55aSffhI6osiRKpjhh21ztWf0WuvEQK/eYPTL5nc2PdmE7d51L+Bu8S30qYk6IR+8jevzXXtZ9pncJTCHJ19u+Ag9RyB+Ou1KpbNbuh6Aur8uLwZuwd/SXdO6UFKSERDRgaNtjROmnan5agt85PsAvlVopE7AHLvk2Nrbdlwoy4+thiPNy+FXQRdaI2DpWoKR/n9blZyqubqNJeMA32EI5G41QDo27xP2MGy4hRSrp9ykyNUsbhgjHxPhg3l3U+KuedPrUUl49824Lk2FpMeEreKUHc2oP92d11Glx46+YD/x0/n2/3CFwW8vm8Tg+MskMyKi0w4D9V9kq5Z30rCNd1vDMl2+k3GLyif55fM6HypK2lDYCc0cFQ8oOxH+VNdVXAW88Xdm6GUynOS4kwPwf9LTuNFbD8yAG2zaYcEwqJsqUuuk4b765Qo51BeUg8cXhIUiNBCloVpYJAkuA8MVO07XmO82YYYTFp9huSsO5WN5cXxDgDe8bFdTkGDNl0o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c57482-d94b-4e98-7948-08def7828af1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 08:28:38.4671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1atshKn9Gr7bNmRwMo8jIBwk/QgP398EfpqXMFktATl6hHMIFClzs6npl/gYGCjjzon4++ymP3qd5fda3AFwBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8375
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 spamscore=0
 phishscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608110069
X-Proofpoint-GUID: HzSvLXeURHvll1ybsErg5F27ADUc8SsL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA2OSBTYWx0ZWRfX52UPJu8V+vYA
 5WxbvzlCR323twyN+OzqHsP1nmf6pqYoduKE0TM8ysEEJKxCGxVXkegJRgS9W1fmsfOQRFBKgR9
 60gSpI7WD1i17b29XOxE8mqp6xxmIlQx1z5vWFQaRChrv0kccKedIGWQB6Y7cYt0X9G6KSAn1rY
 oG77f2hOgxefSRUVTJNb0FcZGsvwJa9DOZ7R7A+nC/33HYMyNxECwSztvEEzSFtuk++zHPymrTz
 6Y/rvEkpRtH5XfrV6KwkXhZpHu1uaSl+goXdwM/Zm09hnMZnG4O4Sizvcv+xoqosrT023jvfTiq
 jRPvm98DNMYJYPTNMDO1uSn80c6ApoZZVg18oI2lq/m0Ii4mllWVIT+r6vjzPmScd7rCyFbG+Jy
 k8plGThvZhoYOzfV8Y6xXQZfU5JDxHJ1Bhd1OZUr5+f4onXjeff4kEm8SGm8Kloj+2Kgycj0Ax9
 mOYIZE1EqCmevP4FSvQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA2OSBTYWx0ZWRfXx9Sg1SDykITC
 3NPLQrya0eeXZbixpOrxWg4C2MfcK5gMyfXshcWP3/XcESEwexfXQ5YUfCt8BNPzdMzNgz6bbz0
 bVLfxykUuRkK1FgPKc+xbE4mtMThPQD8iSc6gCmuvE4FiZPeH101
X-Proofpoint-ORIG-GUID: HzSvLXeURHvll1ybsErg5F27ADUc8SsL
X-Authority-Analysis: v=2.4 cv=UdJhjqSN c=1 sm=1 tr=0 ts=6a7add3a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=EWUz03wY9PWCy_RikeIA:9
 a=QEXdDO2ut3YA:10

On 11/08/2026 01:55, Keith Busch wrote:
> On Thu, Jul 30, 2026 at 01:52:00PM +0100, John Garry wrote:
>>
>> With that, /sys/class/block/ looks a bit different (with the per-path
>> partitions):
>>
>> #ls -l /sys/class/block/ | grep nvme0
>> lrwxrwxrwx    1 root     root             0 Jul 30 12:39 nvme0c0n1 ->
>> ../../devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n1
>> lrwxrwxrwx    1 root     root             0 Jul 30 12:39 nvme0c0n1p1
>> -> ../../devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n1/nvme0c0n1p1
>> lrwxrwxrwx    1 root     root             0 Jul 30 12:39 nvme0c1n1 ->
>> ../../devices/virtual/nvme-fabrics/ctl/nvme1/nvme0c1n1
>> lrwxrwxrwx    1 root     root             0 Jul 30 12:39 nvme0c1n1p1
>> -> ../../devices/virtual/nvme-fabrics/ctl/nvme1/nvme0c1n1/nvme0c1n1p1
>> lrwxrwxrwx    1 root     root             0 Jul 30 12:39 nvme0n1 ->
>> ../../devices/virtual/nvme-subsystem/nvme-subsys0/nvme0n1
>> lrwxrwxrwx    1 root     root             0 Jul 30 12:39 nvme0n1p1 ->
>> ../../devices/virtual/nvme-subsystem/nvme-subsys0/nvme0n1/nvme0n1p1
>>
>> Thoughts?
> 
> Yes, looks good to me, though I don't really know why partition scanning
> was skipped in the first place. I always thought the important part was
> the HIDDEN devices don't automatically enumerate in /dev/.

Yeah, there's more than just hiding the /dev/ entry.

 From 8ddcd653257c, GENHD_FL_SUPPRESS_PARTITION_INFO was set (from 
GENHD_FL_HIDDEN) so that those per-path partitions don't show up in 
/proc/partitions. From that, it was decided to just not scan the 
partitions. We don't want userspace needlessly notified of per-path 
partition scan events.

Another commit of interest is 3b5149ac5097, where 
GENHD_FL_SUPPRESS_PARTITION_INFO is replaced by GENHD_FL_HIDDEN.
