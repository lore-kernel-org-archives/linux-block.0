Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFF526157E
	for <linux-block@vger.kernel.org>; Mon, 12 May 2025 12:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053123; cv=fail; b=JGHaadb+58jliIcjzuUdEL05kfVVgtXjFa/DyR+lnpRq8R8iBw5F0qzS3R+jBElOd2pR1zWX/E9dRkJVXUNg5HKqYo1qzESMU++17odBsfYbA2U0KlHNHD9ZjXPYU738nYzzO+NC4hT5LZCZFZONOtDFgUNgSw1vXBzLTLUVzJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053123; c=relaxed/simple;
	bh=+MQW6bSS8YqHulEFExTvNYsxxtrhNKGxMvGPadQs7nA=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=t75j8UN6jt25qdv88AHoroAWTRWmetKGJigZu4rg1I2U4ZWU89TsdtigKYXHKG8ciLWLLpXxma8SeEVvRRiMJQaN83JWY5NPN9EoGVrS89KnsUbhlRWqi3bnfcc38KXlLdpzPB3SD8OXwWFElrhuI5O60zmvpMAXwn4dck7CjD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DSUwE6Y1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B6agqzeu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DSUwE6Y1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B6agqzeu"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CCA10P004180;
	Mon, 12 May 2025 12:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=JommWohb4e0oXfe+t+
	sUMHuqrLcsFdd0ScmgR1jU7mA=; b=DSUwE6Y19xIgOu4x94h3e1ujGd1P5Ge8jt
	k5au4O33JU2kFm2T2sVvbVaAL7AMo2wIB5au0V1klvUl1OI7rjFZlWfe/aPuEMB8
	lOOOnOAntoKq9wiLnbpRxgDnFP6vPbtpkzuJLVQSOMeAwPrHZ2dakoce9YF1/5ag
	YBk4XhTDczufTX5BxXdu3wj9bNybczYfhYqiXFFoh2TWZbK23x4/x9Xu+mcvkCu/
	apSNsoUex/aet6SEQodXnsNomDwYrXw13xfeaD+xE5PosegAGj4VrLauOR9SR+xd
	4P9Ura6GbZoF5vGlCAwsEW9lgwT6UsnO8cZGKj4PqzcYUVp8zHSQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j0epjbw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 12:31:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CAtljO015485;
	Mon, 12 May 2025 12:31:48 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013078.outbound.protection.outlook.com [40.93.6.78])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46hw87ar4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 12:31:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwzjFFyKibOVwUzVx2YgwMYmSIO60fjcu6oDr9xI7inwzh0iOUJiqnXI55mL0TqLCTqRwh1dqUpgB+5HTBznOoActmYe09wAWGejByfkm5e+hK3Y4OtueDlKX3It4HgFVdOCrTIChh4F9d8nk6yRMpcouW3uVhwpi+pQNIjIWqG44YRQQP9jXBBs/4LOrfo+5UsIEJD+7N4cBRbDCBbWSEtf1RN9shEc7LWxrp/p9S0aSCaWFhMLav2V+BjaLW0Cz3c+UvL93ZeaX7ABHtopxwgvhKmMHBl52MAJyzxAvotYMyo0iBEEkAik2gUxjn7AstmdQkcfsMi8K1SJz2clCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JommWohb4e0oXfe+t+sUMHuqrLcsFdd0ScmgR1jU7mA=;
 b=aAzBm6+GAd3A0m12HR/jC6+gROTJgGX5NpmYFJURBlueLxinjNuV3Dk7jiUtGLxcowWqbv9sS99+VEUcJUBeLlZLfjk86ekKZrjESXRj+XWt+0PhJ0XerVvt2kCV/mmSDTuAKw2bNl8qDUOCvyKgSYW14q6UaAdRRkPdSJVex28e2VONH0bYNCmDjUb+L3MNlcVKsWjs8shYpQZXu0Yzt/7wQyWV1Lf0dBTyJjVp0t4eYouiUSQPLJpUL8HbSTwmZ4dkV80HC29sFvWnJxBJeYvrF944T2GgOU/fOxty2rsuSkL0RiU/O3XeCuJsfZTfy07qvuvBRdUEh0wBXt1LSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JommWohb4e0oXfe+t+sUMHuqrLcsFdd0ScmgR1jU7mA=;
 b=B6agqzeuNZyT8tZubblANK7ll5IUpYIAsOHqieEMuYr+tK8RXb3up/XaqI77ehUNA0yXwpTAMBQlXsxxDxonbDDy6HxjYeTSk8x1G3c5bE7B0uU+Rr7K2yYY/Fw7d68t2F3ylAnNlo3EcnjdErbxhshAS3AeY0u3xkN/j0Qf2pY=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by CH3PR10MB7209.namprd10.prod.outlook.com (2603:10b6:610:123::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 12:31:45 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 12:31:45 +0000
To: Keith Busch <kbusch@meta.com>
Cc: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <martin.petersen@oracle.com>, <hch@lst.de>,
        <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4] block: always allocate integrity buffer when required
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250509153802.3482493-1-kbusch@meta.com> (Keith Busch's message
	of "Fri, 9 May 2025 08:38:02 -0700")
Organization: Oracle Corporation
Message-ID: <yq1a57it3ht.fsf@ca-mkp.ca.oracle.com>
References: <20250509153802.3482493-1-kbusch@meta.com>
Date: Mon, 12 May 2025 08:31:43 -0400
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0014.namprd22.prod.outlook.com
 (2603:10b6:208:238::19) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|CH3PR10MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ae1f3e1-d689-4ad2-2634-08dd9150f502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MmmfKplIWOgjmt7RjbL+/bnG+nrotMCklKcRp/nWqDJ1iDNbMaiRuS9qWAxm?=
 =?us-ascii?Q?XZWmBRb2/dLsNfnD/T1BuXtUDlKZ6u0+32rAfWge7KOokTofLdJGOimGGMM7?=
 =?us-ascii?Q?yjJ2YaiZuTnJvxL5SJiZl7PRt382kgcAwoMOJcnS6MytSTfWl29lNl7FQ8TL?=
 =?us-ascii?Q?R7RTwDtKMyzTnAFkmRr5rCikssO+lHlTTbruoxW0kBS9iIU2xfc71//j5xhJ?=
 =?us-ascii?Q?+ahgBT7ksjBAJ6gHfF5hnfJy9MmvwbAax2D78kM7wyxAnlz7H/UiVRFkBUWT?=
 =?us-ascii?Q?yhQzasMI6k3SP2UyeG7KP6K9oNOVWgeK3i/zpk9oFS+9YoxxvYtsaDrNHcJW?=
 =?us-ascii?Q?j+ybtgNXwhpqGe/rVhw4y86HBbxbnzE7kvGiWXHuUDu5F2n6AjQ9ge3br6pA?=
 =?us-ascii?Q?wHT4RXpkhElfSpfzmUHlM3JJYiApjBG3Jxhd+X8cUWdGa2JL3WLHVxyt+/tA?=
 =?us-ascii?Q?ZEAiChqJwqQj2DEwzrAG76ANYMQwzA9Og7wWNZjfxd0uzjAONH9wG40NqXcb?=
 =?us-ascii?Q?kIQD522z7JOB0/6vzLkjh9mO1PGPJrnebzsA8UNXBafyxobwXKr6aEOZs6Zg?=
 =?us-ascii?Q?Wzk/g2X+xWanBcIaxgL/hFOQt8AHmS4Nldre1NCsSXp5H8V+4M8yS29p+XCb?=
 =?us-ascii?Q?YZHtvAGOF9U6W2q9ocrPlcLJX90OKIhA7KmsYUhMwkkzkx2e8g5qDafkZ403?=
 =?us-ascii?Q?ojx09SsufurVfSK+v6VsfPDEjMokUbDcxX2KretuQBBjZVBLDuni3PaovEEv?=
 =?us-ascii?Q?LNLuPThvC/cSAjRlpLCid6m+AO9zyFEH5LX2VrSJwh5iYuzMCMle8fN3PG2Y?=
 =?us-ascii?Q?KmbvOz8raQ0eCypLZK9e0U8iLv9J6lxyi1sDNmhaMJ0GrOwLymw1kBe4XhaH?=
 =?us-ascii?Q?EQztnY+jkttUV8Hl8DxC+WOhYlh3l9FLl0a6WOEiNh9NcsFRvA1J6mLvXakr?=
 =?us-ascii?Q?EEzTxxRL8FxZmhE/x8OiCGebvayXEKiJE2ys6qaYlxzwwz3v/uxJY7PWbF9F?=
 =?us-ascii?Q?tTpuyh3mbIx3frObJU2zf2mMa6514Pox/qMX1BpYDZ9oxH5sQ3VW9RQAP1kl?=
 =?us-ascii?Q?n67Hid49E3dRzxPtcMl0mXn6zpcE1D4xAKXIwyMb/zJAzCeUUXk029mUTd3V?=
 =?us-ascii?Q?oNGPU/PPiUNGvWgMvT+0zeD4OOo3FP6I5uzskspsBm5lhenHQbmLZYYxNSBB?=
 =?us-ascii?Q?aGNrVHoyJSzoZnYCRRzT2Mj5zXP1G3iue7PKQBOlXh4v/AHvPuGU+OdJXjXE?=
 =?us-ascii?Q?UUrAuJ7RoyKBrATlSm7scanVv/W1eexzlQMhTdJXWG0YobBWaho6meAkBu/2?=
 =?us-ascii?Q?WFveEXVJX2WGZS/HVS6zG6w+RVs4i8DZtNobYnOw/KGdTN0N59lUrmn0mLfG?=
 =?us-ascii?Q?r84A6FGpOwIj5kUnST95q27t4YS9F8ZFq/A5cWTcLOcFtIn/9nlHjjNp0+yu?=
 =?us-ascii?Q?aKzY7iebhsA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y8p3N7axDPLfCBwCkY376hbubyfd2btsktiMGk0ZCDEFv2MR1n118clcvda/?=
 =?us-ascii?Q?Y++wqaQHk843aMC/FVkF1QS+wcWSyTMfRDI0Sn3BvHcm2GtMtIuW1dWcxI5s?=
 =?us-ascii?Q?4qVqD48WA82+HV4eMrg4eZLkoV4VPEAXYDfUw3wOiXok5yG5CPQ0JUx71jxz?=
 =?us-ascii?Q?OTywo+S6P9uX2EETXMa6E29r4/0BmuSo5eJzLfUEd/cmCiuGJIiXBxXN2e6V?=
 =?us-ascii?Q?L1KAEUSUO+sjdF7C2PatmbfulRIeBDCCEBE6quvncGpfEt4t5G+4UUKZIrJ0?=
 =?us-ascii?Q?bStxzFbN2S7jmUky1D10TqhF1aX/b+2bORxGhnV11JOExhfx7sFhHIAln/+W?=
 =?us-ascii?Q?FJPn1NK4i+7TwjbRSOVA0bEVV2S/VDfLXaXsQaFuqTzVFUGNqsgqzFvLNi2Z?=
 =?us-ascii?Q?MCf2E3i3bOWEMpUivmeLShLp8Ud6UUDtw9d9aGrMg5Ug+nAngllO4CiYxj6g?=
 =?us-ascii?Q?8sp+JbIF2zXUjEXLFaeloeeZlxISN6G3l7XzUIKi+muujBOptdUM8H/aabl9?=
 =?us-ascii?Q?DOqAa8Zf0UtIY/vlb44/RcZE4IQdSB0KD4bS5cf7Vbt8E+9GnPIgNcL8BxwT?=
 =?us-ascii?Q?NGxdpIhgrLv31YI88s695nv/3bQtuaugEZfd7qZxzK7iDC6pNIPSlvlBduuU?=
 =?us-ascii?Q?Hz8TU2JCSkyY461a/ISV4CqXA3tPrNqsHUGowRoDaUIIvJdbntTX3mmOkRb9?=
 =?us-ascii?Q?6zCIgOyDXtslVe69dPg1z5jfHUugbjwFzyk89McBmQZ1gN0hmC97YOkgCISK?=
 =?us-ascii?Q?p2kDUvdIWI02lvR1yKbht6ai/5cJibmcQrqmCyKr8HNp+ls1XiKuN8YZc6+N?=
 =?us-ascii?Q?daV7Uxf0LdGiu10/WfA3ND2dziZV0Uoe8IGCLxBX1bdT4U4BMEpECqrM+TE0?=
 =?us-ascii?Q?MRVbnuQZEIAgbe9clqbSLvncsNLtjugtM6RwqJzl5pNKzSom9UhQUEKAsbJa?=
 =?us-ascii?Q?V0XW7zKnKTYQby+6X1Dbt62qRTD9IgWG04ohpem3QfddgKK3gp1SlEnBUAQf?=
 =?us-ascii?Q?C5hcwoLnwXU3o5ZnhjpqqAnklLfMrZ/1KofcBfHnD2eHlwZHmyaYYXavB1oc?=
 =?us-ascii?Q?WcAl/bI4ovDb0Gw2g6y1GV7/IVVnxtDjouonr/Rvr4+eOfXoYgq5q7Y+t0A+?=
 =?us-ascii?Q?h9GFzg4XAtbYxIMRu9pFtTtzK0nQQRM0EuR8OseiymM3WR1K0XRQCui3YIl+?=
 =?us-ascii?Q?xZ11my+ZnY2z5lTeRpap7fI5XbGub4shlwwlLEmphbyOZgxL+htr810jDbFd?=
 =?us-ascii?Q?IgBx6F37gPlqGWBZJH/JcIgJPxkP8+P4QIz91TvlL+KqVuQEcIBbXkr06pB9?=
 =?us-ascii?Q?JgilseJ9ioAqKIEs1t8SCoULDOIOttxCY6qV8ev3hoOvu+hkcJWjgc62oeol?=
 =?us-ascii?Q?CfqELKGbhHXQAHBfYGO9+Qx8a65jkze/l8DQJ0k20VV1QaQJy076CMyHDETa?=
 =?us-ascii?Q?qRjUJsdVCfpt8KppKZDFMqr8gfx+flMKVAjDN4yNL0/0u4ezn4VDyL4BqRRa?=
 =?us-ascii?Q?x7iurxEliSQ6geQ0ZyWGWXzO2QnmTEQv69jA4CSnNAsGO+UohF6A8umtajYk?=
 =?us-ascii?Q?0JToh65ty9fKBP2LgJLMgTy85IgduXMRYjpmuw/IIjgWolu1ZoIs+lsXbrLD?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i/rVnfB/yQh96mE/rTqRzLRTDk8PKpWHFiMXwvaFMx/hm86CCklSGiSH934sj2tHVwZd91A1+3hVIWbFJ5yDWONRf/L4tIPdLM11BZWD0ROACORx6W7mZHydXaG60wz3AxTRMIGybvBfei51F1YphN2ZbPAf+W/6Lrj0qj7eMk+k2mPDkOlAnsUAP00DWXIX5BOr6a3qJ/iaTzoCq3yzM6Tdcmpp0TZ7nNNMHV+YzJ49tgj7ektPPreJk/cS6Q3+1cGpnNsRBkvcinsdOinWU6LE/+Nn2j6UNDUBjyinUzxheBPgxxxPjiS9vs3q+CdpdSJdJFoxKp7CYMHLP0aZ4/98i0vpXgyoh8QgeOP/s7c3yJeUOiiqGBwI4hrHi2JR3qXNONP3CHtSQVLtD0J47uFfyMazKQ26KZARt8NRMcm1x2dddpgE0Kggj6gnUWA7tMC1rlwZVAm8tqLB9DFcbo0Xo9h9JZnSluHtmIfijcOuD1oNTFwzmyPOrJWltitvtuXVKCRbt1NfXeTUEfvhCZia9GXf8CNXMUI2eK0p5E0ml/Quo5fWM1pUSzPlocoIi2ZRfDAoxPIHDk7m2hvE29QvWo6qvvolwvBZfbWOWJo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae1f3e1-d689-4ad2-2634-08dd9150f502
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 12:31:45.1987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IUyiaFDIykmZsvroBjsxh9OZYxyndEci5+VCGfMlheOk1q5PRmyzgB9g4B/IIgElJBjx4MM4bDofaQ78RI0BeRiNEO0t0XE8yOdV6Hfnopw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7209
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_04,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505120130
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDEzMSBTYWx0ZWRfX841wu1yEKd1g CO4o3/C7XKFfvzksg3b4rM81JZsj4W0gQ/4UbWCC76AX+Fol9hkpXBDpenKxGezSfOcOLh3zjb9 mIgd6JKFJmZ4DOf8Ow20I2Q82mhwUIV6QlXA4obMbVfLxzLHF3nrye8gKycM9/aRK1U5NhEp4K8
 G2qmpkkMZFR4zuTWDLPknRA0146RrkvRf/8V9PkhgyolBIEZ/p6HwYYBo2wO+Y+aTVrncr3ZbSU maYyk6z7/xoVuhF16jIgNOo624h+rum3vGVOEysJa2XaEUzeRipLo5+fV/rtd00XgMvYzD31bde la4LslTz6wCiQs08Ik6Bnxecg2FCuzAki2jPKiZ79xxlosOOu/RqF7BEdYQ10Rlf10w5dhcCBcm
 XqKjHNVGZJJ18X9XBOnqYiqoeFw6e92rR8capqE9pA8CzBns0D2pX4lhcbau7KwQAjwDVFiG
X-Authority-Analysis: v=2.4 cv=DO6P4zNb c=1 sm=1 tr=0 ts=6821ea35 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=ZVdNkXU-Lf_5JqRXUaoA:9 a=MTAcVbZMd_8A:10
X-Proofpoint-ORIG-GUID: n_i7QuyIrZCSQJTp703NJRyl2Bl8pnSf
X-Proofpoint-GUID: n_i7QuyIrZCSQJTp703NJRyl2Bl8pnSf


Keith,

> Many nvme metadata formats can not strip or generate the metadata on the
> controller side. For these formats, a host provided integrity buffer is
> mandatory even if it isn't checked.

Looks good.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
