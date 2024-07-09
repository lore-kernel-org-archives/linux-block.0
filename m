Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD8E155389
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 11:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523177; cv=fail; b=g4kAo3e7WLsOeBH8EYZ985YQ4zzPxoH2ClYcP19SJot5r3KMU1PFMPgPo4r9iQ8NIyWophOU4FPv629xfiy1p+zvmIslHL5mWILZ6ZMvU7sBn29rWQ9KYnLadVpWJO9VKkJ+1rOB62nt3ErKc4nSZjwA91razJxiYPnxDPK2jFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523177; c=relaxed/simple;
	bh=vYlw0ZmowrIC64pfFMZzvhi/WVeXgMOPK3bsT20UJEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dsm+trywCIEvl/CIPUtKXdCLbB0N9sBWxJr4JHXS66yuMn3HrLcqjON/OCCCzaVdBr0aLlx6NPTbCdd3qDkAiOvoH5bSNR0K/FDi0ALnDm31STSNQIMoqkRlylMl65Z4FKcFcNTpOt815lWURWLAO15LuSQyHcHu/r4UKOxIGtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F0vqZee3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sqAMZNGY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F0vqZee3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sqAMZNGY"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697tYAf007528;
	Tue, 9 Jul 2024 11:06:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=TUIyKy6bkikfqyg5a/Su9fqMn5KXoNDkHxPyCP/0eA8=; b=
	F0vqZee34A8bQc1zRWswxOxXwXkPAHvITR7l5jUhGfP6ydUuG44H/hxDb2RPR5nT
	YYpURrKzLe5Jk78CwKMBmsPz0RmwPQeq1a5aj9lfT8Ho0mlJ7z6L8N2gLZlSJAkV
	mgcHVEfAqW5PvuunYqNnmlQodBcixsp3iQt5gGqbQ8HdJm32sEq5dxwBs8Zf/lwt
	dqTDZM5aJTPufrZnpYjgiTK3LybSEm4S8xLbCGWsp2rLstAMrZGRKCk+x+f477b7
	NePap2QA//eCkL8IfjARUHoMlpZNumvCzB504WQVtQ8aEOjsNtFlCaMmkr2XpwSr
	c2qCDD9BnBWG7QnVa6DghQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybmptm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 11:06:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 469B4i82027737;
	Tue, 9 Jul 2024 11:06:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tttg5r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 11:06:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVeepgBe1E6ddjpUL9ppYj8ptfOvdRo0fTDUxhkHx9ODNwl937ei82Kl/lb9HsdNDDn9XRGtxsFhJc3NzRIqCIKeLeoNxJ0sfPw/mvofQBaf4pzM/KWJSPIIBqidk9fBXqr+GGqy3NVy9J2s08tC7xjxkCY3fiOspaeT4FHe4D4qVvex+D288Dxw/fTmg1DXaFBmdcFb6O9p2lN8zKje+DHyDb6W5YHeT0pEIj+m00nEK2uPu0c5Pm1auDMqlBeNdUdTi4juSjIdK0vE/PrNpkqtTKDJA//S9OiLBny48bpoYka4R8/cxNiSQCyW1njJkbZpa8unTQqIqGT1uIfbwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUIyKy6bkikfqyg5a/Su9fqMn5KXoNDkHxPyCP/0eA8=;
 b=RHU38uCIr7FY8GFZ0OK332M20ewG5/F6cL7gTaaI/MuFxcaxfD5TAHWXTh/kddKVYIYjyh4DyDNFbqaeC6zxa+esK1701kbkq1dw/uMk/rAU0p/RFdxNrvHlMoGoQEBoNbEh8VS3LSjZLfkr/92zkw4ZDaWiIdMaE0zc9joyW5TQHzM5kUUcmiMDaeObE4DoHCmqmBP73lZHS5cjAJUii5aYV5Y/g6IK9VBG63m8T1BA3d/pnfkxSMWXJD2P1Hd2TsMTLtINHmMk9fImDNxaTEiclE1x4AkE1ccEtbV/vUAoC4uItxEqAYuV1+Yvhjt9fiHDwEtt8iaK2uPJKzk9dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUIyKy6bkikfqyg5a/Su9fqMn5KXoNDkHxPyCP/0eA8=;
 b=sqAMZNGYNYCQpY2Tn+WEAxmVDC0hbifXvtS8Xp3g2Goh7nWL5cmX4tKRnJb63txLugGmub16611I1VXFtsiJLJgm+wPXd2X5w+tHkAlpKasb4yPGGacEPx7U0IGREMmXSH46KLYbh5yFnQnxmV6QKCVpDEPNAygkxVhwUTCNbac=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by IA3PR10MB8068.namprd10.prod.outlook.com (2603:10b6:208:505::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Tue, 9 Jul
 2024 11:06:05 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 11:06:05 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 10/11] block: Add zone write plugging entry to rqf_name[]
Date: Tue,  9 Jul 2024 11:05:37 +0000
Message-Id: <20240709110538.532896-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240709110538.532896-1-john.g.garry@oracle.com>
References: <20240709110538.532896-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0175.namprd03.prod.outlook.com
 (2603:10b6:208:32f::14) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|IA3PR10MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b73cb7-da1f-4ef5-b0e1-08dca00720a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ikimhP5KM12ax51rso/At7ruCjFfgcJFGqGEkRF0XP2Lhh3TEWzAMPsLD+QO?=
 =?us-ascii?Q?XTc9cdBPaKgQ7GqOmGMmK5d0OjdM5zGJjn12aTlvYks/Vh6dHqMdO8nzdZsG?=
 =?us-ascii?Q?XgedGmso4N4npRsqjoA980Mqk4WMublfxrvn4HjehJGgJekxhxPpdZCtIfIj?=
 =?us-ascii?Q?T3gDa7SDpeSWT80QPrks4L4V0WTRKnnJyxyBwg+FaHW91XEjXg6LvmAGJrXH?=
 =?us-ascii?Q?aj+/ATOg2JPbxY5NHutAbmYSkG3pLJInm52ASBCOK9oxFmGeb4Uhqa5uAU/r?=
 =?us-ascii?Q?w0SNjhqHVHrID08BihwAhX6GaE8gT2GNVublGThjMQsZHvd+CXdtng1DZiu6?=
 =?us-ascii?Q?MHHsxH/RuFK2lfdLiiT4kPbqtEedE0oR4XfPZ5ZMOproVutu8ixvHTR4NPiA?=
 =?us-ascii?Q?P0Cs04uliRTTGy7csNrJkwvdrrylR1dvLSsWGh7FIRnDIt2Ws6x1yuIPtG5V?=
 =?us-ascii?Q?KBYWpeU1WvLJ9bIuGHTmbqJ1rHM2Jmfp3zqXdfswcg2iG+R8CzvMZ8jZaWfs?=
 =?us-ascii?Q?iAU+32wTtRTBSbMZqan73OXSyGBwk/zi5Fo20XxX5o7DxsS4GWAZu3RaP3ga?=
 =?us-ascii?Q?1iq1TkEdLr1S4fldPbSa10sVBaX4EYzLJt7rt94hDO0XIbvevTCCBlyO9xx7?=
 =?us-ascii?Q?FPjRvuDJsE/yInEJ34Y1C/s0JOq5d2DP4Rx1dDvP5PwIJ6mOodcY1+ZmKXKs?=
 =?us-ascii?Q?lyswo/8vlburFj6X6Qhl9d5Y2j7XCi5eGHy8uoLjHiCvMFsgGw75Y2GNgJc5?=
 =?us-ascii?Q?HZ/5q+p7uTDUIdoKA4iqNb9TXUUts/+Ac0Oqt9mTSNMMYcVFBohsBXjWNLqN?=
 =?us-ascii?Q?awkgF/SRHvw7U1FfJ+gEyXlG4h3zTtwEbMnXDXRlMF2/GjbhMW9QamYjnDod?=
 =?us-ascii?Q?llEZKw2KxbtNfXEHJEEKNAhOybmlhrj0IDMzX2iA8LvE3+t4Y4SQF3RxIK34?=
 =?us-ascii?Q?oTmf8THe2YJPGbWxrzsQdx539zSWTEcJg5GhX6rakCqsZ/ve79f4QaRRwMDq?=
 =?us-ascii?Q?IMGM0Q5xNU1015Fe98T1ZW37HX5TwnVEQPM6G+xFldgnf9vS5VrnktWhHip0?=
 =?us-ascii?Q?tAk/WeWTdnbn9Em1TI6rXp/62NOfD9yXyK5zw85J/PKUz4AyRGZu4oGg1ApT?=
 =?us-ascii?Q?kaXC2YA6EGTsz9ZrAXYLPvNxpMfNPVt2YrL5jwd/iyOuCP2QSVclBgdcOc5E?=
 =?us-ascii?Q?KNxSQ6L8l09XWDMaov4OaaHOv3NdJaWpHG1gC9Odi/QWdi6VZ/b5yMk68Pcc?=
 =?us-ascii?Q?ELhnNzX6ayL3tmeiLJd4/CQkERUcZ2gCV/XabUI/7PEg5lKB8PLi+y2fvKg7?=
 =?us-ascii?Q?Dy4TBF30i/8Xc+WxSYssZy+waL02Jqkz1KhIGijAdbbjcg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XogbS+A29mHFvC5MlWC0vu69Qxi46b4OBA/zK30UnE0XDslybSDlCGK/cRcC?=
 =?us-ascii?Q?2WmkZOHVKk3KvpAwbl9up98kFEuV09oCcFwnigDHo1ZlnO0NJmeSmFWSX9TY?=
 =?us-ascii?Q?5JNIQMVxiDfNwT+3MvL6YAjf5EwlsQp/7i3HnoyVvrlfKBscJAHXV5ri/1Zh?=
 =?us-ascii?Q?sdYbyvSFW61qYsezWhmtAoOs9Oc/KBj9Lzl86Q+03ZVjfVfBDF/4+TEQdjsU?=
 =?us-ascii?Q?AlkcDU3b1SZ5sSwH4vF3VYpoDrFBxyxamBI1dwVE7q9foNGZws4jNfsbRk7t?=
 =?us-ascii?Q?k4kaDqF484EEpkvacj/NR+F+sIaSuWPqSy/+M1XLAqJxBGOQE4SfhdN13E9C?=
 =?us-ascii?Q?JfG4tl+LNP/2QyHElzU2y28ET81T34gEVDIWjyL4Vr7WReqKO0qrhi89FDTl?=
 =?us-ascii?Q?+PMIviQgul2WXkXL5DbUd2SCBVG8hE0xyS61PNfiWfmQYnXoQC6G70tPq7qU?=
 =?us-ascii?Q?9WTY5+N3jEr+RsE/3UNDJuzqyYLur4ywBFaGrnlZbqlJDBJBRf0foWxHpCJa?=
 =?us-ascii?Q?wvUItadKUozPV8VNRdAW5kBmW7h0QELKKUFxC5LAsHVn+IO6FoJ4HDyiH7ru?=
 =?us-ascii?Q?0kRrLL3DVv0hxHZuRweyJTOuQimtFraayijAdwQMDQirA52eujGy+24slhc7?=
 =?us-ascii?Q?zsSJpULNXP4xtlxql93Lve4CAFaxz2iqR0LxhaHDLZrU8Da+clkZ7BNCa+za?=
 =?us-ascii?Q?vyhylzgP1umH2akfjz3XkOGWmVghwZC+cf2iTIbQoHh/8WVlAOZnZjuqs/Eo?=
 =?us-ascii?Q?ExtB3inU2IlfGT5K99tpWS9KANi337zMYqCOh3D5hYwIEUy2zPHGhFUsrCJ6?=
 =?us-ascii?Q?QF9mXI1wIH5WXTMzInVWcgYHGzBF+uN+Cye0GpiLLR3T/EmMC0AIPrxmApo8?=
 =?us-ascii?Q?6x0ZMRplNl7V5cCnzjayVn7X0vpTpq2/pRWRzYOJasnQmtbZTMhlTGDNXa97?=
 =?us-ascii?Q?9n8V9Rm+C7WMzV6k6Vgh0ivtssIIMlHClUTg6SNoE0JPA84xVV+nWku020mP?=
 =?us-ascii?Q?woUi8JwQDfrMyGt7n/4Ffe2fSDcVQ572+hwTny5wEMX05eEEIjYuPW50Up6O?=
 =?us-ascii?Q?Zm2xq0xVVz6rGPZ8g4hHBjWtcqPwRfgjibeGxxUqK9Hpr3vHzeKlhxJ5wZgb?=
 =?us-ascii?Q?Qn47/Hv01wza5f1U8YmBKdEhm+p7zsQsD6G2+Ckopjng3i+0Qa+lBeZUo43Y?=
 =?us-ascii?Q?KZXCll0gsWGVj6iywarlB82eufTLyLn0QNAaPXVYnhlOdk+5aSrHpUWYMzI/?=
 =?us-ascii?Q?fMI1fixvwEecKqo4J0B2n9Yzm6vDBvqACat+SYkqhvvb97yZzXDYFwCzl+DL?=
 =?us-ascii?Q?CdHClgdvh1mFXc+KxK11bIwfz3qpBSVz59rSDOQuf2ccdxq7CmYRLRFRtYE0?=
 =?us-ascii?Q?3H7LEfCfEGqjSZWkrFMF3AJEo8QGGdqrzbyDC6dfE1W4+Fg/SiOZixcZTooy?=
 =?us-ascii?Q?KzorNlHh55SJgOvIcSJMQcE0/5I44HlG3VEozMUE5x6AkYg1eFJo2nEYZVWw?=
 =?us-ascii?Q?nh6FqW4LnK4KsJiC31s6WkgBHeuGhoTfhrYh2oDWpwbiZzjCk64Wdynry8Cc?=
 =?us-ascii?Q?ne/x8wnhhyS96yINIJowomeTp6Z3kGhkaMOn+yhtmMTpF/qlmiD8FiVZtpRu?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gfV91OBK9WVjDPiI8bp20ecTfX5PzmydrwfVOmX4mKz5tk2BYz1fuXye6owiiAhiAijSaR6+6G/pxY+AfB3Tt+luSOlzvUbPVg/YMDRa38lpnP1nca0awT7dQPGVCBK+GqOL0iM+Ycp8SuLJ23eR3Oi0+jwf8rIZTt/mjYRSLxcRnIDET3JY/f1gtkvEfhaVQhvkcV8zLbPz0Ed/reaBwqEdWFzBgI1JEJv+3GMkoh3pRCLd9ZWdClJu03jOEwr79k/jWvWKIYti75YY9MtNoL38a2k6W7wjyZiC66aMY/NYS75zj6o/i+RZsyoiuK+hGg1VDt5PVrPt0RcOQmJZp0G+3BdSN5IEw6+BHmZKHCnd+FOWLcYacF1ss9GUBxWmaf6GuHshxyCQhOn8NNaTEOaajjXYQl+fE+aXEKGYSuFtDtc+IuDh4AczmoeF9Ckdg8LZFGBz4BiBmQCIjNOODNwhw/mIJbHc71eos3SvDHMBTG5wF1Wss6hN3m5265hQrh9J9vZavqa6xtdAfykLVPEVhmHJfesZfPq8MIvunwpSeIwLT3vqLCOzXLQkmo9NPjaSQoLLzNtpf3pWD2bEWN9t2Nw/RujNU5EqGbgrvUg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b73cb7-da1f-4ef5-b0e1-08dca00720a7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 11:06:05.4176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMXzdGVu9kqZgdEQlfnytSr4aMq04rqSqM3yYUrWUsPqNjMLQ3uOFCEjiitYDtO62Fod5oZussFlZvo+Vq/7mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8068
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407090076
X-Proofpoint-GUID: jV6qDp24hJOzAo7wE6QSvVrJPpHFUvHl
X-Proofpoint-ORIG-GUID: jV6qDp24hJOzAo7wE6QSvVrJPpHFUvHl

Add missing entry.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-mq-debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index f764b86941c3..97741996b5f2 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -253,6 +253,7 @@ static const char *const rqf_name[] = {
 	RQF_NAME(HASHED),
 	RQF_NAME(STATS),
 	RQF_NAME(SPECIAL_PAYLOAD),
+	RQF_NAME(ZONE_WRITE_PLUGGING),
 	RQF_NAME(TIMED_OUT),
 	RQF_NAME(RESV),
 };
-- 
2.31.1

