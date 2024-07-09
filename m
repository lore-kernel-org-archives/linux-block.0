Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB3D156F45
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 11:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523176; cv=fail; b=eynHHR0JgpYj5WObWNfQHFmQCkyv4HFP39ISRX2F8eiqMfSGp/fu8xMvcSMqQRkSharESy8qzmVaQ9CA8/tclkBRjG5+0O0uLMSVJ/7nDwNyF6S2YSx8EXyFpLF66KuOmBXop4E9kF59oem2nQOZOPc5x6rhWaUioySbzIuDKdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523176; c=relaxed/simple;
	bh=6gKLEd8/fwkZ00yzok3JKFIFEupEkD8lVld7tVOk/uY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WSPSN/zU9hu6XvuLLKGtN/8kHEHhRzeJWcBc1cVHCPSECl4jpiRBLOzGQY5rEyjA82n1KzTAUPsv9CVVL1Vt/mzLtoFPE6SaYjlvBrsrSyuVK4fvhnbUEw2m/NMbpUcNOokwQLWXK++V+OEpY6K6xPsFHKQN8Xy4ncEUhMRL/LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HUy+C3Yd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0EHHIpQe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HUy+C3Yd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0EHHIpQe"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697tXI9001430;
	Tue, 9 Jul 2024 11:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=e5dYvvV8NCzbSKqecun7hb+way8gPQxAIsqEnt81GWs=; b=
	HUy+C3YdjNIbsuhrkGcsZiF+ZdzUqNtQoNn/zgxMntuNjWc+VZUlQ+iiVqeRtx9m
	scGTp8mXIsyrQU83kUJ55TUBqUdSBK5qS/CTLivBKPQqfYo/mgQCWNFEdwJowava
	W2u4tkUagIAPYl8EQz7BORYKKHW3BLpeYRtUFwsHWLdz8HTBq6R8hpy9ixSIt8bg
	+tLj/36XCc41UcGiF6agWTE8P178Rxc4fIVL6Lz0YTGyhwHLOI+MxYBqSgNRemvR
	8cQP7y9PTBdUcjh+iG8FToMvhzV5EOCBa3IXtOMQ6ric4wXftwrOF/66EDVWgBU5
	8iYuM/Yk5tROxM4uP3xeGg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 407emsv1np-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 11:06:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 469Auh89038189;
	Tue, 9 Jul 2024 11:06:09 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tv14gn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 11:06:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwAngR0+4CserZt7ADC0rC6vBoJSsFa1UCoD9fNDqOuYS6sZnUq4cPfEbtnZrqQNmon6h0u1GbB1RFOZSRQQEWtnbwjqP8dDixB6zlB7S/2Uf4f9g8BAMHacppRPh87H+B//L67ixJ5j3Fq7FqE8Wgqb7vYdnzn+wf7CCl9ledMyKq3hpyouI201fjnZyK8IT8BR5pwNZVKP3H8PpmLAQe45GgX1ixzxJSdSp+tXuIyZuQOkuzt15VQepNTpfemriiCEmaU33BOvKK9uMdWD3kUpwAzJFc4c6bBhM3+xFKpkftnMq80Rc0VTqKsO5Z98maXf+MeI6rhJXi+kYPblBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5dYvvV8NCzbSKqecun7hb+way8gPQxAIsqEnt81GWs=;
 b=ixA2BXvR5q+vZ1lwQfbIDzLdbc5g910IkSJRgLQJLXPbRnHl9VZfF/g+wCOZJUN/gMfJbjJ5iigWTEf0KdXOsaohokVqQvY7vxxKIjRG3K1HrAFWjLNHo0e4qOIISIN6TUDuv7j6WhTWbARRo3CqghMeDSV2e9Ogf9sEm3NWdU/Uo+YEvzYZBUtbwZ+UnxjbowyYTYgpk9WufIccb5w5U8yBvThvnE+QALK07VpkFM8bD4rnHY+X+BN8jw++nRgZ2oRy8CxxEhVrFbH/iqOSb4Dmi64H4tCwXgCaRuFZY/j9+QdYbrlx5Bh2yklmGHfy5DdqqARL8UVWGKeBNuueNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5dYvvV8NCzbSKqecun7hb+way8gPQxAIsqEnt81GWs=;
 b=0EHHIpQeuhLLAv559sN5lENUYZW6lCA0QtHnvlmegk7Jn/2VYu2O1zgyxfwb4xILWLJ2wVLlDHFsuzxEHX9bsepCwz5rHO1PKVAEo8cVtNbjpGFUmfhxpvF0Z92vRor6mC7z7fwwYnlEr71M5MBg0ooy3ghugjBz4IKe3qc5U9E=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by IA3PR10MB8068.namprd10.prod.outlook.com (2603:10b6:208:505::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Tue, 9 Jul
 2024 11:06:07 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 11:06:07 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 11/11] block: Catch possible entries missing from rqf_name[]
Date: Tue,  9 Jul 2024 11:05:38 +0000
Message-Id: <20240709110538.532896-12-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240709110538.532896-1-john.g.garry@oracle.com>
References: <20240709110538.532896-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:208:fc::18) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|IA3PR10MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: d5ef21b0-3f9d-4fb5-6332-08dca00721b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?J92ZgASMV74CXgUQo++K9B7grgMIIRS38eoq31szVjDYECs3I5B4z/G0auR3?=
 =?us-ascii?Q?ZJiBEzP8NkXWFvwCyrZrptWfKJOX7tCLK4djujCmwyoZP0iCdV1/sXbaFftV?=
 =?us-ascii?Q?S4KPs18hcjcBKAD0gls3b07bSz+6/F0nUtqkCnFFx9ND32+gpFfE6xsFo13B?=
 =?us-ascii?Q?hu899pXKQwGyKrB2QMu8VO2yeATwKDtcW+Lo3fYSOcRMMy2hGG99PquDLXAK?=
 =?us-ascii?Q?PZiajrjUVPorwcndd6qQ9ksGR24LrXuy6vxgsOgEv2Bjz9sJ9Pj8Q2dHrzTa?=
 =?us-ascii?Q?Ig/1W4ilWKDuYNHJcpkmEUcC971q74wxyPEEVbeeJ7OmA75ID8QSWO3j2HQ2?=
 =?us-ascii?Q?gMa4JudsAF7YwvH3sr6WArMeI8vpbZuqx/WABaHuNGOA0cdbxOBiSBIRmIfX?=
 =?us-ascii?Q?7xifSKx/YChGOq3HoBZBY2auN/hGKPhqq2SxnD+xnv61VLPSfeQDAA6tgCur?=
 =?us-ascii?Q?TJ9qY8p8XFQ8GZnQqDJwhiBBve27jsg6vFAr4aaNPVGwRz+drnZ7eVJrK0p8?=
 =?us-ascii?Q?T5nGYxsdRwwDvFJ1Fs5qEuv71O9YUYldSmQSAvecvF82tk/HBhwhPVtOO2ry?=
 =?us-ascii?Q?D9RRIDbJQH+Auw5mhfygOClFSBKaS/t7pS3nuOEwu1DfFXwYL9jfUK1SVpwe?=
 =?us-ascii?Q?NhOaXriuP1EBDpd7oHxTNgvAbh+pHgjdF7ubjXjfRTyQSoHZ0x7C1TSFHsiZ?=
 =?us-ascii?Q?xL0jPFO8cM9kzxbOiSspNIgojw/aY65CwmKa7SzsRQmQ6bwJVar2EhzWHf1D?=
 =?us-ascii?Q?Sa7o+eN9nccRnksWOaMXrTlWE4R4mtZz8iBKDbTo7Nv3LM17nNqEOUpG9LnT?=
 =?us-ascii?Q?HqviVQZnqlEDD42BJniuVmhZDgRDJ2kEBHLJFkjfxMDcJ8ISckpAzV42f4gQ?=
 =?us-ascii?Q?Ebq/EqNl0r/UL9z8S+/XC/BIUvGaQeRw8v/gMvmGnlW/+Z/V3c1E43R0HySg?=
 =?us-ascii?Q?iJj+tPqJz0aL6R7wT5OXna7PBw5I23k0VM5+EIfutupF2QlfKzYZJnHNEndS?=
 =?us-ascii?Q?dHngAqvjrM2PjavCVK7bxXfaQ2PRe9oDbfg0O5b7iq01xOZh78E/vLb//NrA?=
 =?us-ascii?Q?olwtDu2T+VKvheY1Ffkh8apX7NPd9/rNZXEMtTovr+3wTB+sC0ExF45XY+Z8?=
 =?us-ascii?Q?8MC8Fo/n85zw82RLkAW+fl3s8V2LSBTwx4jim9h0iKo/UuYrhTxP+hlW8ma0?=
 =?us-ascii?Q?rKaqIjXIEhNh17BYaJD2ZZPf+JclYY/M7ea+c8dfCpYTBTIPmh6B4Yzcw3GW?=
 =?us-ascii?Q?zaGbbsbtuOuq75Cte6jQt6dY3XIyV/eKqG9m1bHQF8dryDsIkUyrp2mTKdYT?=
 =?us-ascii?Q?YPpAkb00Yfm8+eTg7Nz1Lai/f8J8SetDRTuKV7G69hXDPA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?E2ip33nFZW8c4kgGxQ/78jrIySrbMNXzT+DhoiFs8kAEpHGtgjxE3WMSdgEP?=
 =?us-ascii?Q?nGyU8yRcpnlOpHiO9ZSH/ygBxKYtKQy6XDTGDMSSksjASn15+UgUERrB43r/?=
 =?us-ascii?Q?PrKuZS1vkaC9YrJGk9bozhsMPdLWot5Rucbs3WsPfi3ffvSGpb4umB5kh/5T?=
 =?us-ascii?Q?6aI8ZGSxBBXqRITM6OFFGc+mTkiX73BpsEbmPO8Kecv00lbvPAtSUCXNsd+E?=
 =?us-ascii?Q?RFyEHnfi73DUd9VZ8+9K8emCNo0k+KCrvByuc2Y0/AuwrF2CpsxlBbTAzl1l?=
 =?us-ascii?Q?tNYDH+dvNs3v9tXA+c3auDWY6kd4CvmLH+BNJauGrET+abCEbkf5yOkXLFag?=
 =?us-ascii?Q?el6yVnR7mX8F6ZkD+vVZU5Ze+IpnNKeFw99RaBJ4ORC61ZFKvQp/A8WrJtQP?=
 =?us-ascii?Q?oc8yVyF1C/LYg9I+jKuALjArbnPuCXSJtGkr31MQwFxdA0vgqX97hjvUn7Fm?=
 =?us-ascii?Q?Q6AWby0dhYKBOd40fsB1eAY8gR/9qqJzpA6TX6n8VsuQ+6ReyHIswuDyXpCK?=
 =?us-ascii?Q?9E1adr6zy0FEIHm56/K/oKLhkbG+kLmokekvViizDdwAvlo3WcsfENDwcGUm?=
 =?us-ascii?Q?BfJKDtGK7T2MUOMvjiPI2d/yK2J2i5gHYa2kQGbyUL80WpKiVD+FJ5QFmpzG?=
 =?us-ascii?Q?nge4+zyJeuUTrSO9DD2eQOUfDQznMgmrusEMW2fl4O+mcfAk8AKO9ViSTeY8?=
 =?us-ascii?Q?PvNLe3w6NDmKy7QxVIWMT5+kyhJ0SXxjXxgkBqxq8dd6/8A1yvM09J1lIv/E?=
 =?us-ascii?Q?yjpzqIM9wnFyW+BxQDUDCbMPSYv3qw4uLGFPkt4lKbkEX9PZpky+TFlMCkEA?=
 =?us-ascii?Q?W7X+3RmbTZ0hYsxXHMIsHEi5Awj88RBKF1vaHGqhd3IR35Zg4kKNNgowabyu?=
 =?us-ascii?Q?p1lRVSapbFip2eDmRvuFSwf2nQYYSCrQAAvNmFDW7nSX+1srsFgI2a6FQSzZ?=
 =?us-ascii?Q?EwkaKYEC8dUTbq56xtCxNta3mg3qU/4Fb97oHU0Dx7pRUkH1/tRA+aH58PFI?=
 =?us-ascii?Q?DeZgKjEW1mRmdjrSbysIz8B3b7y35+fCY3c4WT6rhLlKNwQhonRPMokZ8t0p?=
 =?us-ascii?Q?ebD9/zOstm6DUlZ6Q80i6vPlqjf13KQEoKyonF10BJPTGsB1SlHRrDaXNfj4?=
 =?us-ascii?Q?WMhTtYbWd9V231G61POGP15btOhyWTtcdhQVSH3sTTX9x9A4IE0EzPbALRjS?=
 =?us-ascii?Q?TZ49ZZVDJ4xcAOKj8Ai8g/nMdiRwpDSM+7pH7u1erfDGxFT4VC3f69zISHwG?=
 =?us-ascii?Q?WFyqT0/xi6w1jVX27yeKkuI+DZsmnPjmtnyALQbfhCJ8WfEL0MfLnntwJPVw?=
 =?us-ascii?Q?yPJbr1Yk5+WBSY4rXagiWxDLEZXQWY8RVc4XB4XIm82YS0O0Y0HV4D0UdddG?=
 =?us-ascii?Q?GW0HOceLCgdImzR4psqHfPijFY8Hf3W5REpHSfSj/Tfo+oiymVF92WAx4X78?=
 =?us-ascii?Q?t9MZuIN1z913tEE3HRfK0IpeHYQyEUKNAUFymY7RKc1HFn1upVqyvR8PBYzC?=
 =?us-ascii?Q?VX7kPWqWNAfBWwlzhkQdDyX9ZZDJ+SNa5UTqE/HaSoJ6fsOPa6DlO0IIXu77?=
 =?us-ascii?Q?ZLYC1Ynw+dePXDR+N5zuJYd9bZqOWEv5XzafQ+02FD2g5NXyrG52f4+rk8j1?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	haKUDId1TQjZhPqpOiN3bK3zIYpyrDaGA5k83TABcPQdXbK/PPBoCFTqMu6zfsp0C4E4LIYPH2fO2VScZSbfxQzsmW56IU5jsKbFNU15OOmlJ7XTB6SWAj79p+YiwbQ1tYuURep3feR9eN9VTsdLFICrYp21OfoOMjepkh+AySQYod6aySE3hobGARes1NA48vteY8vabiXQUUQmkfFQZdNNjw18Eose0NpS9jdkK/OV28uI9HAUW2UWuzNJKscWk8NCg9Btea3RRFtdLG2YRZFsmqV9fIiG3s1pDrLyPVHol2zxGeJb+v2t9Cti4d33hNg2ByABi3oGkwR2IBJ2gLg+GspvkgUuj3X6ICmnR5V1CyD408fAdyZCsK02xSkD73nGGMWPtfekQ+gE5XvIkh7jKH54+la8klLRtKTLlb4OVt7XjIyXAeS0pMUMjqdsksvoJT0O4BEoDVO9LwddBW0196BZcXfNXTPuHS+4hb2Z51aV1D/9FwfxZXTA9NFNK++h9yYsous56gVsiHKjU8JvV9INoQAjhulDed5d+y4NVUjZi3QasFB8ACFKYbPeiJXLZikvOxj8PoCu0IjK+yCh5Rz4uRSqDEdC9RLFULM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ef21b0-3f9d-4fb5-6332-08dca00721b4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 11:06:07.1809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AXEY1MGVZ+ehCYhYbpNaBNb/KSCfciZSgZ2dlUEhQzQpD+ULGDHSb2ZSm6BMia+bJTdaGVlbCQQ9szXtrY3mww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8068
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407090076
X-Proofpoint-GUID: 7iCnP9cgjlszhFK5en2MN9uo7hggAHtW
X-Proofpoint-ORIG-GUID: 7iCnP9cgjlszhFK5en2MN9uo7hggAHtW

Also add a BUILD_BUG_ON() call to ensure that we are not missing entries
in rqf_name[].

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-mq-debugfs.c | 1 +
 include/linux/blk-mq.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 97741996b5f2..c829406579ee 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -280,6 +280,7 @@ int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq)
 	const char *op_str = blk_op_str(op);
 
 	BUILD_BUG_ON(ARRAY_SIZE(cmd_flag_name) != __REQ_NR_BITS);
+	BUILD_BUG_ON(ARRAY_SIZE(rqf_name) != RQF_MAX);
 
 	seq_printf(m, "%p {.op=", rq);
 	if (strcmp(op_str, "UNKNOWN") == 0)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index f3de4a0b5293..928674c026b3 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -27,6 +27,7 @@ typedef enum rq_end_io_ret (rq_end_io_fn)(struct request *, blk_status_t);
  * request flags */
 typedef __u32 __bitwise req_flags_t;
 
+/* Keep rqf_name[] in sync with the definitions below */
 enum {
 	/* drive already may have started this one */
 	RQF_STARTED		=	((__force req_flags_t)(1 << 0)),
@@ -60,6 +61,7 @@ enum {
 	/* ->timeout has been called, don't expire again */
 	RQF_TIMED_OUT		=	((__force req_flags_t)(1 << 14)),
 	RQF_RESV		=	((__force req_flags_t)(1 << 15)),
+	RQF_MAX			=	16
 };
 
 /* flags that prevent us from merging requests: */
-- 
2.31.1

