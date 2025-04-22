Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB2429CE8
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 02:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288093; cv=fail; b=lQdiReYrpWPIE/4WjHIQd6uSfl2nv4Ba1U6eNFpfgUdSErrz13H4UXZheX1ekSVqLbdm2YJez1hva0iGsBmR3Yt1dexXr1DXoY37ZGEpRIBHjgKyS0RIu5EEAjaLfbk7XYBUdqebQvB//DO94HJ+e1iIxMY8tH020C3zx8xUERs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288093; c=relaxed/simple;
	bh=G3pG7+Dfj82XTGKUAxcRj/sL12cGPu2kNUgttN2If3Q=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=TuQm/murpyXgR81ELtg1D8+zhah9sRZEP6uS3fi7INd7Jxkunj3YdVZoYGrDjY5ZNhBNv61W3RdzXbKctT9qmFQEpBYeOZObhnvPbIxdD47KKqAcNGXhHTJ25lvdquo2yKr4ypX7yJYJegBss0VEV5efyKcmQunTlEVrmTdHVL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EHFTUxVC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ji+tJydd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EHFTUxVC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ji+tJydd"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M0fw9s018406;
	Tue, 22 Apr 2025 02:14:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=vUMqc9cedJiHvhO0zs
	eLPU3Pl22zOlrVoAxWoy2l1PQ=; b=EHFTUxVCVutvrd/mvDK9X7pGxoRelu5eQH
	x6iM9JdW/XNvSDhJZINLRLciBlOv6nc3xqzTxl3+5znDH/Yibm/+N88Oq8FynaaL
	ABMD7CGqTwGVE3uS9BdLMRcSnvojHL/xqV5HwwWvocBLWbL91pos1Srt+kAeBU8v
	ANvPQU+4wRUHPsmqFoCu1TJslfpFFVICKvHEw2fZNvmo2I9k3f6AO+/77CLFXbdR
	T+QIEdw2pbhZtk6M4b5JeMOy9R+UEIg4R4CkQVh46EAI6ITXwZS5/1dO7r05IXeA
	dQBPu/s8AfB3hHl8eWC1jhH1gWy4bAjzf8CyUMgxEYP5B8xY4ucg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4643vc3mff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 02:14:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53LNHdfj005814;
	Tue, 22 Apr 2025 02:14:36 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010019.outbound.protection.outlook.com [40.93.12.19])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46429901t1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 02:14:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lggf2UosLzcn8mJKxiUAD32/5Qj37lpxt72E4jlEnr+6ZoItk4ZuLozPBfdm3zANzrJEWoMEIu9kO4eL946RgGopO2NjH/JEO6OYU3URaVnpSauM1Ew4bVdkn8flcSJtFNBwFvYief4hgB1WmgBCX5FXJmNwQdkar+tnKMroDDr5psZPohFgSzIEVtiP//QNELFgwd8ZxxWvfFgEg+hjwqW+eQi0GWsQ0GHE0hizKbiDOc5Wh6rQd0aQgSKYGTmxhFi/JeZf8+g0TghfeH/qdbe3ehzDzuep4O779D9zS2865V6tAdOm/gMOUWPmw0aneRq3nMMrnc2boSCmvyn4EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUMqc9cedJiHvhO0zseLPU3Pl22zOlrVoAxWoy2l1PQ=;
 b=loS9lavUchgFCtTWygtPMG4eYSiW0BP9FRymVgwsyDrehzjX0y04MqrqfUUlE5nmRjrBHWxwYIHXO7NV9kOboELbD7rnl52W61RdGAo67Tzt0gSuVYOMViqJcLk9GPEs3NSNI/M1S3L8va7/P6YWfDIpP4xtGngTGU9eEAB+8HF+NtlX6akMHKCctx6tDO8IO2JO0qCi84e7wRS00EOnxBZdO/x9wXUsVYwSD5eQvKrjciufslTcGpGq+LmQf39zRQFrmJl2hiyY8eATCOPPtI+CnInCb48ssdN5TJO5xBpTteDBQ6OHvnYrP1yos8UwoQNaafxDp29AQjb5MBlIOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUMqc9cedJiHvhO0zseLPU3Pl22zOlrVoAxWoy2l1PQ=;
 b=Ji+tJyddiL9gANZJt82KSQ2r2rrZAKt/2Bkigs6ckIwpESIVXL0cgPBWyZvGAiu6spZzc2XyCLJPxfywfYI4iD2/l35LrbeC5ffLVZPDNFsZE1cz55qZQwAIkhRySYcMA3SeSnFbh4omljYeexkv4Heq/lIyHx6cE+aah7vGRPo=
Received: from DS7PR10MB5344.namprd10.prod.outlook.com (2603:10b6:5:3ab::6) by
 DS0PR10MB6947.namprd10.prod.outlook.com (2603:10b6:8:145::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.34; Tue, 22 Apr 2025 02:14:29 +0000
Received: from DS7PR10MB5344.namprd10.prod.outlook.com
 ([fe80::b527:ca1f:1129:a680]) by DS7PR10MB5344.namprd10.prod.outlook.com
 ([fe80::b527:ca1f:1129:a680%5]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 02:14:29 +0000
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
In-Reply-To: <aAXTz3e8-X1SlGvX@infradead.org> (Christoph Hellwig's message of
	"Sun, 20 Apr 2025 22:12:47 -0700")
Organization: Oracle Corporation
Message-ID: <yq1a5899caj.fsf@ca-mkp.ca.oracle.com>
References: <yq1v7r3ev9g.fsf@ca-mkp.ca.oracle.com>
	<aACcuGpErEsBcxop@infradead.org>
	<yq1jz7idh39.fsf@ca-mkp.ca.oracle.com>
	<aAXTz3e8-X1SlGvX@infradead.org>
Date: Mon, 21 Apr 2025 22:14:27 -0400
Content-Type: text/plain
X-ClientProxiedBy: BN0PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:408:e6::12) To DS7PR10MB5344.namprd10.prod.outlook.com
 (2603:10b6:5:3ab::6)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5344:EE_|DS0PR10MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: 744f1469-d934-445a-ab42-08dd81436980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zAhmbDo35a2SpIpRZUh51Fpv2uwSaFkrOoM3nQKKiP0mjLwHzxEsruxbiqir?=
 =?us-ascii?Q?BkIOoZcLGf8jMdqvrSKtu4WGuo0l3RSa7uZ8ZB3MQI1ZiY8PQVzSw34YUa+I?=
 =?us-ascii?Q?mW0hBY4iJNlP3hCVo5+8oKSGO6q0QoJcT4esNsMDeW2GdqCfW8Q3aTRtVt7G?=
 =?us-ascii?Q?WgixAqkpwIgtxuxl7DRrFt5DfwW1w9X3/pYskIWxDAy4Hp7HEonBnegxqnd9?=
 =?us-ascii?Q?mVB+77uTk/vGP8qX/JefYQ/eWJLkgVo9o9TubRHJTAlbt3pcJ+YjWR/3pZrJ?=
 =?us-ascii?Q?9mezO1LFvZ0tg3asRNlehq0/pBgiLTJJSPRmhxWK6ToFVIT874H1ffUzWVJT?=
 =?us-ascii?Q?31f8iCR8pt355Xd1lAu9ona4kgTJMyjIqI/U6/VCXJQezcjfc4PugTV7df5i?=
 =?us-ascii?Q?7CfiCHNjC4kL297Uf5mSjFeqvM/PpTWFEzIknQPBcKhYz0mW4IZLLax2mTaU?=
 =?us-ascii?Q?I5i3joirDl5IzrkIk0u2FzWipeP8SkO0yrsjNPHQTr5mm3q4j8WrLK6aggt2?=
 =?us-ascii?Q?iTMJX1s/p9Oo0DPT7GygK7PzLX0eUAIue2H/cSvsU9uaQvPiBzUbi5A4J/Ug?=
 =?us-ascii?Q?lXoLpyjjcm/vV+xuV4uXws/AhQvhFxUB4yKqqIOG9Ltekx2RyKKKHdaQAO+d?=
 =?us-ascii?Q?3nR8R+e3HJHh2ejff636UxZFBc9VQQop3HTz1CKlehcdotlNzRylbFV3Mf7C?=
 =?us-ascii?Q?YGdn0FHYT2ivOhQNX5yKG4A85SBSqq2jiaTiSD3GTodPEIhnCENyKN0+YZ9t?=
 =?us-ascii?Q?ce37Xm7bhi/EE59K3DKVTTRQLD56L5TDvWsmEbq6eWtFxDmuViPNv53UHCUR?=
 =?us-ascii?Q?Uj1R3RHNWCfoXVUIlpwQ3KwpNS1tpZwlVxOUolHG4jCSMF3+nSuGLAyViDUw?=
 =?us-ascii?Q?7qi5CJOjTFQ/vFNdCzNDsB6TJR/1CiIhpIJBEX7IhltOfWVEMJgokHkN0zrw?=
 =?us-ascii?Q?EbOLn7XMGkg+aNvqHOAPaDOrvLE7DwXqse+EIV0tBA0cqIZ5PPNgufshr6d9?=
 =?us-ascii?Q?SPDVRc4oMGui1jmGR+OPZ02/rZHIbkg8tTsdjnQg7fadCUWXBC7vIcdUXOqJ?=
 =?us-ascii?Q?6zo1SEy6Z3ev8lXrnsO0cFL7PyUbOJ832H+8nVBy3RrSvl0G0MKe8BKBBqfA?=
 =?us-ascii?Q?IFcd5GCWJZO5M3ZTP6ffVLTPuNKEN0kuMsbj35RTJ/WASL6YOGf85PmyxTNw?=
 =?us-ascii?Q?tgw/ruOhvzHFZw4MxJ8LjTxY1D8PzO6pGpFtSIYj9KYg4TFvWXs0nUZn/DJ0?=
 =?us-ascii?Q?RofZwOajAAPh9XDKsj7YJqR9/OiKhl3NSOFECEgTvrymy08ITkYyERRezaeo?=
 =?us-ascii?Q?0WrTiiZhr4LeUs+G7NjhcSNrMSy+5jfXxhLL8yq2h/DaSrAnM/OHLYV6twl5?=
 =?us-ascii?Q?nIuxOcONMj18ikDVGjF5KXPkp5tYfMLeo7cqvkXqq8J89Pd3PH9p+sppxr8l?=
 =?us-ascii?Q?cD0MqRe/PZ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5344.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AAPpSyLADYYQ3nvbll3Q6JGqX+AsZ0KDXajmB5QBwB7fUGnagwUX0BRCSU7m?=
 =?us-ascii?Q?hKAL8x3f+cFFv1uUHofansg/rbmd6UyX0gYVyt11WcS3QA/aUWshdGXyJX/H?=
 =?us-ascii?Q?fLdPi/oKNkgRl+pMJVjFnwZBOmYbjRokfzfqYvBxASgr2h/M++24vNHXa7hX?=
 =?us-ascii?Q?GjqZSbkJfQj4zvZTaCMm6yVej5CyrRFodiZjkEgR5PwaI/51QMD9rUdHWa6j?=
 =?us-ascii?Q?c9o602gC2PKJ3oOZlJc6zdVGraYj1eOisgdBnO+QvRrxyAEPzPoWBEvukWUw?=
 =?us-ascii?Q?P85woVJg+WAIhdfDJ/KCZKQms6uSWi4kDEgS/UXwWSYFp72SZAmQg7tsGE98?=
 =?us-ascii?Q?hqhE56cgM/9tTDXx4FW7OZZ79qkscARgzU7hyhdRLDz8F5phPu2w8omnbEB/?=
 =?us-ascii?Q?2ydqdCHodojL8oUMHj9hxGnjMyN7IAS8CcUZFaVIYWzElx67dYXCS33UXiWD?=
 =?us-ascii?Q?yNMkECVYUT5Iy7ALmATrycx4y1eU98GCXAmNMSaVegUd9USD3Rr42uFlexBe?=
 =?us-ascii?Q?+0KXQaORx7i1+vGka/LEGTg38ZELwNugDFE9LFwcRWXpLewAGy4vseIiHokJ?=
 =?us-ascii?Q?I8kZOVv0JDIXyns+Bb/0IBG0mZTB4BF9ILZixC74kjW8rtAOXvIrCf6+p4EQ?=
 =?us-ascii?Q?FxQ+jfEB+pCRxdTdhmLVZ/hxlS3N9Om2hf+2QcUY0SCD2AtV5EMk7p1PoeAb?=
 =?us-ascii?Q?ahbyrrM+YNlldOpm+fh0tq1fn0AKJ9d19Tnu+AQmcDkrLW6ysSaGzO5ZB7U/?=
 =?us-ascii?Q?uHGeE998TdmP/1XqMdjXpEABRPV1Kt6/hbU40+FV9FvAdoK+qnSthig87Yzh?=
 =?us-ascii?Q?Q0lC6WgTxnFI8ykeyUsZu6Ow8MLmDo9/LwQbqH3AZkp1QxJwQkxmTDPj1hao?=
 =?us-ascii?Q?Qlcp/hlZgNnrPlKhmBZnZ1P/KO3ExLyu8PbkHPuirva5JqWZCuIDl9aVPvr0?=
 =?us-ascii?Q?5GPEk8kMPbD22nUjnHDsbXl0aim83cZf8R91f1lrwSnVUQk+YyivIzqhIZP5?=
 =?us-ascii?Q?yTMmNJBnHYMSXhCRkJlmrcRKFQIAFqV3lBGqyvgrIYIwXESIWO9kauDDgoLg?=
 =?us-ascii?Q?XIaojylfbozN0JHIiKZ/UOSsqe3hJ8V6u6FtNN5POAMN0d/ah6As96+zUgBH?=
 =?us-ascii?Q?7/8zxfHlZm/gwiR3f2Z4rZxjqKuPuWzMSNcdeFvfY30SRjNpDzPFs/yMuMI2?=
 =?us-ascii?Q?1l1XFjCFNUEU013jgdLc1wAlGm1vqA1vhDeHIRG+pRgxToxV3mqTRexdLngW?=
 =?us-ascii?Q?PBJ7vlZoVYb9s584+MvATXzyOc2nA2Up6MjfEQuI/ueTNA+TXby5srFgcwyo?=
 =?us-ascii?Q?GTWJkKsWmLokunFocayRZcHF4poqh8xB7Siz4sPuTo8q2VQy1k7kpO62phe3?=
 =?us-ascii?Q?da1duyFuLFRdjfvNVo0xlUCD1rVvrCoe154nopMcqa7ApC6yxqhA2vPA+miD?=
 =?us-ascii?Q?yYZGx22T7aYcgaQKp0iRdIzYW3vEGEnthSGdaKIClMWfpDLaQ3jEEszzR0zL?=
 =?us-ascii?Q?Ed8q3Vv6+ydqAksSeP3JyCLUS8qsXmY9Sk6dwD/6lrT20JdOlE4JbSVcHf2p?=
 =?us-ascii?Q?Wr1gVtN4nO3kJXoUedsVVpQADVWWjjmuibo3FIHKAV1DOpNM6/gzxNdKyyUR?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8xgTmYQ51Ij+KPklg1KriaUr+O1hRuV1GdHjAV/e9LavGXpPA1GsicBB2JqfXnhp1DZ67WaWsTj7RKH2cMoAwGBef4R6ETzaIiWicgID+w4SLqlvtGL0Wk3FwnVy1OgMjtpJ/pTxu0oUTlcucjVNgBP1NCLEoPGI0L00ClimbbcxpIqffqZ8XhAMEwYB636z3x2rIg4aeSd5ZrrLYrASuT58mKpVrxCJoj11fP784Pcvo6TsVjdq9YnzIcfrJxTYS5xLehbcId25I8caNZcHQ0Tb3GZap6WivaL4jgCKomZ2tjL0N3wvftqLNdk/cX+pFHNs3CpZR0FJxBdVbmBsKBBEu6MOy3L62D35MyDmh6Z2wcFNayCier207afm5G/m/AxYxA0efMGP9cfTCKwlYmKJrCdkJR+YUHt0JflhHgxR82cNIkgAN5k35fVwTHt+/Wq9FWWAG+0z7OC8tfsfOtaWZ1YnIK1way5/a2n9IK65XfkWOJPVz5arfXixZIuVivVCpoLbOmBLiBm5ZbM20i5jeU93bUktMsmfb53zAh7+Bl83ZlKNMIXL21naj8ir7U68KlMezOTDKbYDOpFF4KfVqhtvbWoXL7AO+gq0iqw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744f1469-d934-445a-ab42-08dd81436980
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5344.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 02:14:29.0377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ePWp6SnxD/I/7f++fl7mtWfKWba6Roe5H+x3BWffEbGdt3HhJ080DFcpFGUASSCEx9JH6OhnlOGHZEyQKZ8mV1XZOsbRhNum7NPEMal194w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6947
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_01,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=918 mlxscore=0 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504220015
X-Proofpoint-GUID: qTG1yoSwafb4h-9_1vCqvODozxoY0EKk
X-Proofpoint-ORIG-GUID: qTG1yoSwafb4h-9_1vCqvODozxoY0EKk


Christoph,

> I do not personally have a use case. But we support using file backed
> memory right now and have since adding these user interfaces. Suddenly
> removing the dirtying will cause silent data corruptions for these use
> cases if they exist, which is not a good change.

Oopsing in the common use case isn't desirable either, though :(

In any case I'll work some more on this tomorrow unless you beat me to
it.

-- 
Martin K. Petersen
