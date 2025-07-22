Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17FE19E826
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 03:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753155033; cv=fail; b=h0mFvIqXT9mgYYCdBQy2qeQGR/DDZMGqpB29j7EBvRCnfweW+xEoReYiSm27SEbOLXRPjuVDMtW5LY/S8DvFABpzjD0l6rWesCp0x3rhr/DiaN51e22ttzVArWg3GNwOd86LXpSBlF52/DneXiicWZzIP/XiOd7UVKq9X32+n8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753155033; c=relaxed/simple;
	bh=f8yILv7dZ5oSG+fugXOyG+XLFp57fqti92oZidTJOhY=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=XXjTKwp0FDOcHTw3A4zpA1m5hCUfCmlTnkqoeRZ6uDz5NGo9iDYL/lUz1jRS2EHgPGzus3dDC+Oa6BXwFEXmrO/hQ/yUExIWf2UgiKlHhDdQS/ZA8vhi6YuImE5URPb4RYd6lJZcP3rDk31bjdgjTYjI9cR/jO9Degp1b/zX90Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YcFqgrKa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yupo+Dw7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YcFqgrKa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yupo+Dw7"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M1BvQu018902;
	Tue, 22 Jul 2025 03:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=PriYHxE16wnnlQhIQ1
	3yiUjV0tHYZjZMAbUWjrCJWLM=; b=YcFqgrKaaIL7PbqCx2Khdpws2+1l3j+DiA
	lkgIV5VJGaln4Xo5wKB+rKmpo/YoO7IN2/Z5qS7m1NBrWZRQ3RUTVpumuKlrfK1a
	1tprvaN4lZAse7CKoUcSBCq5f6PepexI5dJ0/r+T+Xh33aezRkNumGkqOsVqViTF
	nSNIQ8Yixv63mURLIeVHjba5GboZJ9VhlbzSbeAT2Wy+wwokw/GrqTLC2R5sq0Pm
	rqQSEwLYSSSNcymjZ2WFmVh3KvaFFzkEXk2ILv0bI6CP0PEvJPo0c5UnEirUODWd
	ztpyx3UVNDZivWd/NoNi7mYDh52dIXJDLMfiuz7lpC915f0YXqlg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 480576m5bs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 03:30:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56M0EiO8011321;
	Tue, 22 Jul 2025 03:30:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801t8s6kt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 03:30:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFpOWodtpH/Y2mM+TRgouwHBzZodDWYjIYAVyc3h65rRmBM7CkeQuht18wpXjSIPc8on7GyLq36xGsoYe7wsBTjHmch/Rwgjx2ba+j+gMATfyPRsaFSWF4qSnUqQgeOJ4Ko1Z/GeQeWGXgwfJD1obxw7EAxV3hdOHjMILjfPWK/d0ux9tLYJwGU9uNOoLfsrd3VVoI806yW+5vFnxEZWtapd0VP70Gzbehs2Iv5307MLvJ2EobYZcUpN/ebrjfdMqUaXCZ0VOTn9vgVd1nDL2zTuFEm88g6VhN2ncGlDvPJfJZ01+9U6jhmnio1ifL/ZVf87WripKgKmMmcuWQJ83g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PriYHxE16wnnlQhIQ13yiUjV0tHYZjZMAbUWjrCJWLM=;
 b=InJZPFntjT/6wBXiXHD3bbj/haqlOrt2ht8BTxaEANJe3FibS8McO6N9Ni08jPNhVAm1MX+Hecwog9SUbapPDwGCMn2xMsuVWEqsdpXCzbBayYiqFcS9Ugq9X9O10PzC9b4UbPnpEdCiX4dL9lGAQZVMJfGYHLZuqpJlBF11rbe7rs59N0QEHLvEtNmEIdScMX1Q47A4fAaL+Gtq6gSMMuOqcNzbY8pCWYH9BgT+imc5PgZpmU06hyTCVpmi/wpWxpHRGMhqZab0xYkDTVdST0HB3BK3S7K7lMAN4rtYduUlHusJDnNdfy08YLLLmx538yZHetKhWPzaHMNdvLBtCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PriYHxE16wnnlQhIQ13yiUjV0tHYZjZMAbUWjrCJWLM=;
 b=yupo+Dw73wOKo7QaJSsqkTq4XCEI32ldiP+UVWrO5HaqsP7wg2rEBnm52wykXTvcvO6J52HbUvw7l8RGVxLeQhz9B3MQl4fb10ka1udELP+1qdr4wAPFsnGUnjNK3DsI2o1+PWCGK94GYhaqiD88xZk0Q68C7/TK6RLd+UmyGPQ=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by PH0PR10MB4757.namprd10.prod.outlook.com (2603:10b6:510:3f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 03:30:21 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 03:30:21 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph
 Hellwig <hch@infradead.org>
Subject: Re: [RFC][PATCHES] convert ->getgeo() from block_device of
 partition to gendisk
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250718192642.GE2580412@ZenIV> (Al Viro's message of "Fri, 18
	Jul 2025 20:26:42 +0100")
Organization: Oracle Corporation
Message-ID: <yq1y0sgx5rb.fsf@ca-mkp.ca.oracle.com>
References: <20250718192642.GE2580412@ZenIV>
Date: Mon, 21 Jul 2025 23:30:18 -0400
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0188.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::13) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|PH0PR10MB4757:EE_
X-MS-Office365-Filtering-Correlation-Id: 654e1cfe-2be5-4bb0-54a9-08ddc8d0168f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2ou7W0IBqxY1wMEv0JfGMLU6R3mh/DVClV0Ge/ecJcfvfpYyA70oRowe2JMh?=
 =?us-ascii?Q?WemXzXMyWy8o7ljMCsbJgp42avi2FOr5J74XbdnUP04l/Iw8JiujfREyn1pP?=
 =?us-ascii?Q?oOl9Yhn/7mb9T5ip8jJ8sES5/h1X66TE67RtXY7LR5Bcd62JQx8HTZHdW+iM?=
 =?us-ascii?Q?7DYIEJDPPj+nRFyzBJiVytj+KH+iOPUxLZjPRkgSiwz9M/HG1K17QDyQMaHm?=
 =?us-ascii?Q?EZUzBvDC7gevJVfOsuOzxJ0gBInnVYcjYXeh+mIfyhBsgPDaT/orXqOn8mXt?=
 =?us-ascii?Q?E8h4rLFXA1Z0YMJKXx47udF2B72jVdIdi5DYH8xQAgbVvqWQevE9vKWSWRnF?=
 =?us-ascii?Q?/EAfOY498xPhRQd6BgIMDhIUVqtWBRI3xkKADgTkJqHRcs4uuRLqqXzmAjq9?=
 =?us-ascii?Q?tX/XMIHbMtdWJrZok0l5NrRBDR0JBRHe29bfM6eRnkWsJqzlzBSTPkTYAxSI?=
 =?us-ascii?Q?a49Oxyswqd1qBPRd4oRl2kaVkXCNPMlh5evEnXSOFF2e3wejrbEYvcAUTTTk?=
 =?us-ascii?Q?+rxvBqEExNfic0MrCvxlGPKx7uJSN3zBAblcKbLCcWhfvDWm6gz5yULFbE1G?=
 =?us-ascii?Q?gu8QawfNXYHfpAH5t6CQ0uEb2q85m6PYO631MEe4SLJKI64ybkqdQuAulB/A?=
 =?us-ascii?Q?cm30RvNUTJmBrpqlPwpUmjH9mHLNqrlNZCDcweASsiKNYNqBb3pudOgiz9g+?=
 =?us-ascii?Q?62ibSRyzqlAevC4Yz8AKx7aQoRS7TULmALIldz6G4QSh7Zrl2B6WKC+8/VvW?=
 =?us-ascii?Q?wIiyhySydHt0kehIGgH0UUMPwx87HYoShrh9fzE0i+16mARuM3uuftvvUdd+?=
 =?us-ascii?Q?4HJGTTL7TSqfkE0lJz5DrbU0DipkfulVLpf5q0OY0JG+c/XGmwFwgCYctDxX?=
 =?us-ascii?Q?y2X5T/SIfoUNtn58upyIbBHJLTJeRpPRHh/hAKHA+UiZ4302F3hXaiX+gC2l?=
 =?us-ascii?Q?yfEXI+SAnHkrfsFi/T6gnzoqqW2UPO3OQTQ/w26cPrgXu9iYcyOG1iJ4duFN?=
 =?us-ascii?Q?tsAlNIa4RJQku8iqffdlOhXMV6QBcKUmWtS2GqOGl9yNdw35ENXDyFlCnviV?=
 =?us-ascii?Q?MjCT+WzveuhmbpmxHhEEc3fszMJ6z2BkFdeuJz1QXGtcLxpWuhGfik6nj3Gj?=
 =?us-ascii?Q?7MyhaguBQ21wrMFkWfEeluVGhgUH+IF+ZhDZ3gq1+GLQ4j/igIQdaV/PkHDX?=
 =?us-ascii?Q?7y1q69/nB6M5xtnL4m0YwLym4iBpx4tHcpfak/Kh7UTj2xhssUYiplYchyrp?=
 =?us-ascii?Q?B73PY3y50iAE6DOnzH4qsxeIwReTjCJ449yLSPcUFdoVVJgof+b7jeBNSPi5?=
 =?us-ascii?Q?wf4D31LeiTHTqQHdDEO/spD/4HpmAis9ymbru0eOM/HJ1+NcIGPKyFIe45oP?=
 =?us-ascii?Q?jbV3WrmwTH7xSGgbbVg8lrHwbqYwkFDAMHJ6UP8e0rBDLeacjnO3i69L5poa?=
 =?us-ascii?Q?w2ujmC5QS+8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y/9X6gTv9ppaprFo+/N9pYBT+U15sjzuourAmKT0sZPRNrB5GF8ensSOHhGn?=
 =?us-ascii?Q?0DjDqCCo8Y++JhtvY44swVBpd85Wl7Tp3eocBoda6/1f1IqcINmF7RbTXVhl?=
 =?us-ascii?Q?VMgxue9FK4/Jf492GF7roxfngxwVfF8fs+5B9CQyGm/5viI7km1yveBovV9t?=
 =?us-ascii?Q?3E3x7m0zYeZVR9Fcf4vZrJ53U7jDFFcSfYD07HByp4mczVe32xfwW9o3bR93?=
 =?us-ascii?Q?GJih0RBAITLZ6geZKTlSZDKtIHFCePTpKBG94lVIszCn9MUdn9y9Y1lmocVa?=
 =?us-ascii?Q?Ua1Vjqd7hPkKEpZNHmg1KBZh/ChOEyRsgfVjOq4dXxhYWCIiI1hFERQ6hqUt?=
 =?us-ascii?Q?EA6/Kdk9u5/lyL+X3vh4qj2W6XMG7KULFMD1JwV3fR+c6OGqDeavyBa5Jmgx?=
 =?us-ascii?Q?Q/91LtI4XWLDnYH6HJoz3qdKAMT/3wuFqN/Ih0GB9hqeOYPDrwBlDBdjjoxE?=
 =?us-ascii?Q?M12aNllUXnw9YTsUKvnfrXZTTdEC+5ojp7Kdx/1vFjHb8K+U8KItlli0gLHV?=
 =?us-ascii?Q?dX/mBH/KE8IgOehylZJ7HqYE7cP9mVBsTxi7YeBQyIHa3t+IaHD2O8N1vasz?=
 =?us-ascii?Q?8Sd/stq79cGRmtcboWr+6eul3Hgrfb8lfPHeJHiZi8VW7pMVthHMcvDcut/4?=
 =?us-ascii?Q?hCiWMdllhbQGjrPJz2izm0XSdVr7oJIX8ePE283vUA3rPg+5XXU8T0FJa6EC?=
 =?us-ascii?Q?m8KTDMVzdfgKPiCtmxkZIp1l1KVy8zf69Et9aRPKhFux3TU1YHevh8dBslJa?=
 =?us-ascii?Q?Whbipdj9hZ+NoXSqqkcKRfI9ogAIB/smheRt9w18TA3/OyaSG/GofmESD/UC?=
 =?us-ascii?Q?dhI24A96M7kdCpmTFnwT9EXyjil/IdS/kPuyb9DCjpoamYLHoTZSc7D8oseb?=
 =?us-ascii?Q?N8mhCSnoMZsWNpC/38Y+RvWWe17jx47Ihb5XTMbxFxUXkU7NctJaAsUtEzGg?=
 =?us-ascii?Q?ryvibnMl+dnVykZi6lE6folEkvg7End+dAQKwsjbGouO8Lrj9OR03YPWs3VB?=
 =?us-ascii?Q?cf17CnI0ZsFklzJVJQ/DgQdeawvA0LA7EmYqYj/EgA4ZHpFQ38HeW3O1p17k?=
 =?us-ascii?Q?FPS9529SfolZLl3rpg7cXDdk5qZkPyN1DYEqhrNjYDnmxIju7ueUnMkg/Obk?=
 =?us-ascii?Q?12hfF5cZq912+YRZYxhDSlWqde2zJBml7rDVVoAHkSRA2fCJYIzXgVH0iLy+?=
 =?us-ascii?Q?9JfqIUsRxRi13ybESMBCgJnlD9gXnBsJ1cphWXKCnpBuigwWq5w7K/C1/KSl?=
 =?us-ascii?Q?khQvddSeVjlLMKYGZbsvPOEx2tF10MHD8kxqfvpubYYRumYtnRcwDlpcVjz5?=
 =?us-ascii?Q?PwkquiuKIzQCOkO6ZjRjOCNfqRCl0dPurarqOY08zQOmWYvx9U8/Jkba7Zb8?=
 =?us-ascii?Q?Nkv79tREX2xJeyfLcFZhaGnvLLRTJjaNO/pQReoGcf0iwrinxcZeOvSEnysJ?=
 =?us-ascii?Q?nMhH9dCxz0cUnsiQKl/mULTaqOgHSRcNRhC4nRw2EmiuSGxKZ6epJJRV603v?=
 =?us-ascii?Q?teFKe4KkYcZUqFZviYwFskZpDrq7vNJFQNgn2DKu3qennKFXzz6BKL35dw5O?=
 =?us-ascii?Q?9t1VK7MwOsMEIuNaU4h6BzbGPyjlPE19CJcMM7Bs2FgdErfN5P2Nk2yvWZqm?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k8WORqWRBmEirw6m8ugCvCztYaz4jbtEh6V48LW1fZORlRc7m4SnlcOsET4iXmdVTUOs7f42QRZMpqCE9CVjaGOeRo5+cYgk9PO5HnmPfZQ+/HdtXU3+/1Bz7lJdxFxvflOCRdIOEka3w6qwTWvF1bgveApaLHcu97V0mnhUnm+O0PGRllZJRuTsRecf3W4ODugB7orLsxW7RpttRJ3CPwWNjPG6Y9+6MyYkM5fbrY4K14cXGphaeDugrfvY55jqtjzFLFduD4l1E6uN2R/+DMB5K365g1j4AxkKP0XNogQ+mDUY9FhRe2ShyGRxt4cryHj/nl4Rr4C0L//rs4zmeTR/tGvyJd+57Jtm0cWhLeUdt+Sy03Q/vZypI3bhUzZtpKmsGX2xTtsObwZpK7RmidC8kLYX8+p0vETD/10oCDfF4RDxrOtr2exKveCt81RDJi+ywunOivpKUfe/iMUmdExRV0Lc394iBJXvy1T6YYInKPmP1Uauw5FHgMTJSYPXM1VclTtvptOEU8FJaKgfgU3rtNCa9Cbipx4C1JSGSx0VVcxaYuXolIpLIfkJeMt4N5NPVYxXWkFINpOzZTaMXrVAuIIp++swbaT+4wwPvEo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 654e1cfe-2be5-4bb0-54a9-08ddc8d0168f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 03:30:21.4867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tb1/BQJXY+wNGSUSfslMsGdlXxnJQ3x/Mqf+ldL6RLAVbYwNVl0VeKXEUCbShtQoqrYLopHfcJ8I+RmQbry/oTn7ADTIvq54oJYHOdm5icA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507220026
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDAyNiBTYWx0ZWRfX+/9skNNjJN0G
 zsj/AADTnyzyLjUlDmzp1N2XQ6c0iX1yt1GuNP3AeBtm2alwzJpaokS08n5w/BfVeY4ACdkgoAI
 ED4aZEApEKv2wtGhuL58vHjeE6npkLmGzUy0NGI51PunuGs0oAcnvycrDkZhWyzYgL4Aeuz53a8
 JdWkdsHLlSWPE9AKmq+jeq+/rKQBvwmi+eWr8rannA2PvwgTrZag9BV9uaAldKRmNkyIGzK/QHi
 u0BAjGZ64CzKrEWkIcKfqo4XiGYJrzapunOC3up7T5s7HiBAf4id8PYeuF8tmZpi+mY5M3deXv8
 qUUl/9S2pxzvieQXjCt6IHWcBK+M9LQpOpMbsywGpvkEzNpzS8PzT8bokm4gAAuAva700+P0CMR
 jPFtx1zNxNYGxKKAvYotd1bkxtNhHKiMOjbPreUMAqL6UQmNyfj8eBO7pnZvFJfbYTSBoQd5
X-Authority-Analysis: v=2.4 cv=doDbC0g4 c=1 sm=1 tr=0 ts=687f05d1 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=kKNMEWOT1K8_i5yIBM4A:9
X-Proofpoint-GUID: dei_ZkPHLA50h5-OKhfkwZUyAhlVC7B4
X-Proofpoint-ORIG-GUID: dei_ZkPHLA50h5-OKhfkwZUyAhlVC7B4


Hi Al!

> 	Instances of ->getgeo() get a block_device of partition and
> fill the (mostly fake) geometry information of the disk into caller's
> struct hd_geometry.  It *does* contain one member related to specific
> partition (the starting sector), but... that member is actually filled
> by the callers of ->getgeo() (blkdev_getgeo() and compat_hdio_getgeo()),
> leaving the instances partition-agnostic.
>
> 	All actual work is done using bdev->bd_disk, be it the disk
> capacity, IO, or cached geometry information.  AFAICS, it would make
> more sense to pass it gendisk to start with.
>
> 	The series is pretty straightforward - conversion of scsi_bios_ptable()
> and scsi_partsize() to gendisk, then the same for ->bios_param(), then
> ->getgeo() itself.   It sits in viro/vfs.git#rebase.getgeo, individual patches
> in followups.

Looks OK to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
