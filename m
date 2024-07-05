Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4E31465B3
	for <linux-block@vger.kernel.org>; Fri,  5 Jul 2024 11:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178523; cv=fail; b=Pct6Ks7SVhSpqTUXNCDlGy8XUaJKU9yBM44gX4HlrBhq7ps7LdcgAr3lPQCQvffUxxkMqRqhyo4fRvHx+0fZZ+b11pFlbE9KaKFRDtTWubaPamt+o79KaOHPPWWFMiv4S/FE0N6dosS6kOnX5NYyU1+AE0cSDuxOKTLjuzlZYMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178523; c=relaxed/simple;
	bh=pcWwP0BcUwOdj6hbZY7EXGT0TYQrA2CzO3u8+Z5JBuo=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=m49b1O77r4jvQF/uWMLtCUApKBofDBI4gME97mEFNJoKUHOuSucEWG7QMXpI6FiQtNkWfAA8XRymZe/X9q2NDoxRGbHSAKwtm4EJoFUrJo/ZcKiJo8G1byB+NWQKE6W1Vm4NJbMt9IpJHmGwfgtMZ6fhg4FKzJCHRrY5+LyS8Vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kKp40cKR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BiVeL3oq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kKp40cKR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BiVeL3oq"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4655fYOB004201;
	Fri, 5 Jul 2024 11:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to
	:cc:subject:from:in-reply-to:message-id:references:date
	:content-type:mime-version; s=corp-2023-11-20; bh=wzsxTkErFCT4sX
	64yUd64OX+ughAbTXQKUmGf2eutTA=; b=kKp40cKRpd6+8AN8Dz1+DDwQm4NByn
	t/VSzet3RUi/i6AzkSUkusKAl0yq50CYlme7JxjNSuMZa97AsQTXQ2gqFHBV4Bh5
	m/iL/traao7an2g5dh5EZ4RghHTAhwTJ/7JGnI7jDMW2veHKkiACjwyL95rdB+Mg
	DEq3DpyywQwoXXjtAj8e8tkDneU90dgxWbd8dnx30CbNygYR2rz6WqU6ZUR16KMh
	wpUQqG3eFSY35BITvq+bBtemtdV4g/9p/NcMdTtDU/2DsjX1B9IG33lc/1/gcN/j
	/yhN8tg1ZoVZ59dNP0PiPDHcY4OWhVoEtJQrHvc3UoIOokOCiaNqnM3Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402a59bg6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 11:21:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4659owTl024647;
	Fri, 5 Jul 2024 11:21:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qbrkdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 11:21:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZiW6FG1Bi5DvwwLGJfoqh9o5GW9IFtp6WAQvgIFx7wf4zXpu1Y/hTyp1r7XmKlRghm60l2Xc0nvii4mlOtHtdktWReUUtoUpgYe/vWCUzTDIe8b4GwrfKVDiHVt6kigPwQ/pWnskBR6kEekQWmjgDFIL8NaYuwrObWd361jtBjFoZJeBXjNVk+nLu+w6fIcKdASrJsO+grqopetcg5gJxrGu7Ymd4XJ3g2R750OZ81Nmfq5umh02x8nzxy/+QvljS9vao/ajA0IOr5ISg3BX1qQzo5L2GH7pI2fAUAg6Aq29S6aAWnHrBhdBz4E2jVrt+GYmfOV/z3CanZoWm0SVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzsxTkErFCT4sX64yUd64OX+ughAbTXQKUmGf2eutTA=;
 b=hU41XnpemnHiuXeozqwYTeWXZkCGY5jV4C+ByaGeZxH3lOQlyfxXgN8cttyCj9zVNByG01MEBNkxNjrm4cUv7eYIKXSDp/+t709CEJ5KjWTezpi25jNjiuSXceVAY1zCbVMQ3MRmzrLaIO8xKjseMNIlnMnx9xQ+Xba1b6cEHT3nP8KU2WeIEWyuZj+bJh+HC1WzivG2CMiirjvsbJ7RuiTvdrdDIQJbBPCiqXpWOMHl/87HTgLWNSX+ZUqQHE9EkvdX7gcW/45C3IARuXwLbhdovX1V/mouDQ/0Gduj80KFP7uJAelFBM28QxEzv76l7nl4pStD29ay3A3UPQ177w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzsxTkErFCT4sX64yUd64OX+ughAbTXQKUmGf2eutTA=;
 b=BiVeL3oqf9DlwWqZNtBW53VTzSNoOLdfTpwcHZZPGDU+tKdp8Yfmb2mK5gUiCJ7IOYLo4pQ5rYkl9Y+lyLFmn+103oZPc7yv+j9Uzto4/dzm9RPxg1fvGbsFIbcJ0VcBAqWpi2vOjk5GVkiFUt1dx6vHY7m9w52WYfFIcpl8UKA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS0PR10MB6994.namprd10.prod.outlook.com (2603:10b6:8:151::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 11:21:44 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%4]) with mapi id 15.20.7719.029; Fri, 5 Jul 2024
 11:21:44 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kanchan Joshi
 <joshi.k@samsung.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH] block: t10-pi: Return correct ref tag when queue has no
 integrity profile
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240705050550.GA11379@lst.de> (Christoph Hellwig's message of
	"Fri, 5 Jul 2024 07:05:50 +0200")
Organization: Oracle Corporation
Message-ID: <yq1ed88854i.fsf@ca-mkp.ca.oracle.com>
References: <CGME20240704062234epcas5p1dd4ae6e7c91555b9573418d618086c1e@epcas5p1.samsung.com>
	<20240704061515.282343-1-joshi.k@samsung.com>
	<20240704062649.GA21024@lst.de> <20240704063242.GA21732@lst.de>
	<yq1y16g8q1s.fsf@ca-mkp.ca.oracle.com> <20240705050550.GA11379@lst.de>
Date: Fri, 05 Jul 2024 07:21:42 -0400
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0063.namprd02.prod.outlook.com
 (2603:10b6:207:3d::40) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS0PR10MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a1bb1c-37dc-408b-a58c-08dc9ce4a6c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?s4+7ww7QsaDzTmEvRw8QoWqp1RoXnYgLW51DAFQvRe/FvI4GB9zrmMRJHFPS?=
 =?us-ascii?Q?AOE/nLGGNnybz5A3RDhsx0N/MjJFIvAnivvOb3nqyO9onx57aCKqqb4MjVnj?=
 =?us-ascii?Q?dTPSLG1Xlk9NWOtc3NIh7Wep2X+ibgOfOqvclM2/apCx2lfw1w3MQnCsBqRx?=
 =?us-ascii?Q?tvKcC17emOl90J298B84w9r5vSiRRopw8A0NxRa57K9yrFWMDeFDa63SCtLx?=
 =?us-ascii?Q?oWOrYQb71TRInP7enzYp7/3wFJcEzSHrb4UI/xpiClXJyOGxEPEl9tyI9jQO?=
 =?us-ascii?Q?8w3UvZUZr6v0oIhOQpsJ1ZxumShuFU7zN841MouWpVQQvtTGI8w3L7cFd6mp?=
 =?us-ascii?Q?waGtP9H/066+pZ5zd7vwoCIR3S7RwizMVSJr+mqx9NsKiO4YyB+qoh8iszwv?=
 =?us-ascii?Q?ArjT8DgdAjt7lCZUO35PQ3LGTB5mNnEvnNqdUxMByN+TqSlmZvr+KP9SzByy?=
 =?us-ascii?Q?eUxTE4PscE/0Lc5rNWIN7ABRCx8LoKku0xj3NaTgjcfXVCYGMBmB87lXr8NN?=
 =?us-ascii?Q?bhcbiJwlLl+a0LVvY/bd7fdKdJ3oyJj6gSksw7qdDfYUwxhguzLQGwgOErYp?=
 =?us-ascii?Q?E3j3RwJl697dybhnDrrVSJt/xNKVPQzN5jtACP47mcOnBrfL9SUqq96sWPOO?=
 =?us-ascii?Q?A4huheXoniExfkAyT5Jg0/yfI5hWa9UKSeRu55JV9SJUFxGBEfMcH4DSsvQ3?=
 =?us-ascii?Q?dwA/pDBuQ8d0SJ8fb8iJ64CySA7UUUxDpyht/ZL7hBuDi/lShmhRl1OlmLEu?=
 =?us-ascii?Q?pXHvL7xiZZdQz4Cq8GQWK9ikTP2LgzsV4o4NUYoaqZ55JlnHkoD0K0HrlROn?=
 =?us-ascii?Q?MiEhyu2gDbLEniNA2fysefLyPxE8yU0VD0sY4WmOni6lfra8ybZoMpB85D7u?=
 =?us-ascii?Q?KL71Oac8lEaMTOoI+jyrto5lfmbxbQyazZMusN4mmsQfi4ucTM3jv8SNKR1k?=
 =?us-ascii?Q?VXM98KFCZy3kQlmtM/ukwQz68NGmKn4pcUZLi5nH5qG05KDifsIJCj2JsFRW?=
 =?us-ascii?Q?O7MFo3CbnSPb46U6INNVf97Z9lEI966fGlW8BJBLOdF3oWtJGWO5WezQNzWM?=
 =?us-ascii?Q?wQJgDay0CtuJvq3LMvLYya1xhjyiJSazr0ke3Qnq08/mq30ko40jJmxsbj7B?=
 =?us-ascii?Q?EGW0Bn9IceojilsRdEcAuVz2HZNNpVjZIMHy5AVkZdPQ/hKiwm3FWeIMOkTX?=
 =?us-ascii?Q?rXZWAysUdQEBeHA56UzVnM5L+bifBzgvTzVTXSFxr3RiaDho4fwmjidyz0q7?=
 =?us-ascii?Q?oEtDp8aG3P8/SIFpGFXq3CxyPSkNZO1rXAqWpOITC8sZENOGpd7mG5wcSpAh?=
 =?us-ascii?Q?5K2PeN7ANbu+pd5/DsL86PYQuhB1hWyHd6UjcC7vqn5Z3Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XU0/uVFH6jE8bORsJYpIIzvNMqbunuanaacQmsxUef/9XH/G9N+VqhInkqa+?=
 =?us-ascii?Q?x4Amm2KDq/dxU4ETBCCT/oGDSc/4iFfwEkToTzUci6PIVTOu9g4l6JOl6hs9?=
 =?us-ascii?Q?t8A7ceZ1k3I8PrwKPbwA1cmVK77456jEVnNlPVjXLnr8dDRNkKKuGtAj2Xg7?=
 =?us-ascii?Q?RcRv13Ha5n3fG9tFoyHINN8lLF1B33YUwp7CNVlPfsN/YRXR/G9MDxTm9WKM?=
 =?us-ascii?Q?fgdJx7+IRy9KKKpH1RRhfXY/3AsBuVkZGeVAsFyLt3voSgyo4oQiP+b+bEul?=
 =?us-ascii?Q?2uO/XHj2UM1fN7jqzX5/iKT+sgwuPCGD9jqyaQKWLBRy0tVaK1zaSjfkzSmq?=
 =?us-ascii?Q?fbT41R6ka3zeAZPjD169Cg/X1x0aQjdtGQ5pvPIVkFDL27nRgYv8jAejhJ5T?=
 =?us-ascii?Q?mqmfI+x5sSR7QIwQiTSyyMYma4QPVY3uTYHqa81LDFeTnaQwlnRfS+MSTHbj?=
 =?us-ascii?Q?Uso2ZHKryK4T1Q3Ie63EThxCIo/l8otFGmz1rvuhbqEYWlZBRFEsyGufpD3j?=
 =?us-ascii?Q?eyR3bpLAmd1hiltCUs188LOvWG/1Z9c6V/O+PAnIo2W8T/T2uSk3JyUDjpaG?=
 =?us-ascii?Q?zoUjE7Kkk0gO+Df+S7rD579uDI1zG9pqkRk3sYlyqGSnNAbnVJ30/MyVxC+U?=
 =?us-ascii?Q?dCa0FSzsjHofyCw0i69TylSWhyXDZDMAEc3eUVUkXU/zI1cEef7gWQTzb85o?=
 =?us-ascii?Q?z5byPnXpxkMyRr+YMKfm7kcqS54Cl0iyO+vhbcSkAygJnrex4G2BTJ6X3lzP?=
 =?us-ascii?Q?dy3+GEWYxat8MWaJng1T2H+KJa8KtL0Hgi6i5r+E9NaNk6LevE4M+ZqUKC6P?=
 =?us-ascii?Q?ejiGjnaMvgDpA2meJ6M9tLdylAWLWIzmkuRLgfwEpQVlx6HijlSX5OgqL9cv?=
 =?us-ascii?Q?ahHuOFh3oObHES+jp6H7J6LsIj8ov8k9gLY9BRYjS0Ajyl2rURQUqRY12E8o?=
 =?us-ascii?Q?kuHGNsBMr6qXbhI3wr8wAmrTwWMCM+/MDUvptaAC6ZcMDOq1SO2P3mBCvEKL?=
 =?us-ascii?Q?rUxBkHClH8Cy9CWOUcHP7kaRBI9n96QlbBYr7/ULmSgH/HZR3dbSnEA6sb9q?=
 =?us-ascii?Q?1NE53NLYH+U5dT4JZ6PJy44N85RLfPbg86bq+TuGNJ1P1c1Gz0MFaAc120Gs?=
 =?us-ascii?Q?y0/LPzhXDMjHdSPpfmtxnlyAs+uXKcvJ8cm2+BZYPfFlI9JR3mf50bOB/l+e?=
 =?us-ascii?Q?eu1Mfkyj4ruGpVjUdP+7rsW5HU41ENa5t50AztJiD8UVSHw5SFfUSl9ueaQ1?=
 =?us-ascii?Q?8r2TH3iYiHbptGbTqs7JxluZxg26UnGlOt9TlJfgM++hGh+QCocDK4cWhUUo?=
 =?us-ascii?Q?jPLxfd4K6dF5F/RxXTvm3RRj+qczkolp/ieSru14OqkK7hwMcrvke+Tn/lWx?=
 =?us-ascii?Q?oY180VzLp9LsU8qEASNGItNzUtl5veLRdKzoZXxeMw6STOM3Rra+355G3BF/?=
 =?us-ascii?Q?4vucyH5q7UoXrjJ2XeaYbBOmnNc1d8lrTEaYqvkY4odkM7tdqQjGmPwAvnZw?=
 =?us-ascii?Q?0E0NmNqFVlmkbEHyVIt0SXeKk22WJDJAKSIXvPnI/Bcy9DZfNlcWO0KWgn+/?=
 =?us-ascii?Q?ksA+bZgR01dPZWN0BtLr3BIGnM5/WI3WIp+Xm7XpwxjiGCwaPnbRHWtWkGAT?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	a1na2hRyfqbpRJSgYeAH6qX9I0o8Bldo1qmV8H6YnoaRCGoOK6RKz6skpljpAfA+0FORBNl06KxclV9FkdhOVjnjrng7fRquMWjxzLHhNvH49zAzEDQN9NiUmIxFoPjDR9jdmVgH2D9iVquz/HzSeYPYql2gvLICbAlmRoTZkbsxMRFG4cxJC1pOYoJ+dYKRQI2L9+FsVkYXvT6dl3YtQEZnvH+0GLcPHNApUW/S+TWStzawt9gR5X3+WMsAYHILRc/E/lG4S3+Nw3JOHS59E66LveCluzmYNUD5/CUdjXogpTT+pe7gwvxkKSjnl5g+d7y7O5hMWPsB4n92hJvo+0PPvJ/qJSh6kZST48GmdqEFcoY2rlGxqxLJwF+x+9ShDGJjanW+LdAL4c50xj6evOOHk7OvOut0nO7Ma37/Q5UdZ/AMNUJCLDgzm3FzWnv0JyYiSkCWnLD+B78DNB/1VRAhvZYPhm8T7Dbc+rogJWEu3RZscI2UyZh7DQKS9LCUER6kGvLPyKbF09B2tCUiR6dcCWuX61qE63qzS3bOMsBeaMl8UNyEM2BJT7ZsjdC6lbNgEIhCVsvd+asr8xW48WYPQqQTQjXORcYp74Cy7nQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a1bb1c-37dc-408b-a58c-08dc9ce4a6c0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 11:21:44.4720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQoF7LtoaiwBI6wFVUUG47MvJtgWWHvwTGeG4v9Jz4REWY6sCguSrybXMXY1xyYYS/QNrdeQWjb3384omipJi2CUg16ssp4+2O4trNZzP4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6994
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_06,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=921
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050084
X-Proofpoint-GUID: RwJoB9E3262V5y9TedebHaDUGiO5nlap
X-Proofpoint-ORIG-GUID: RwJoB9E3262V5y9TedebHaDUGiO5nlap


Christoph,

> So should we just drop the internval_exp member for now? It would
> simplify things a bit, but more importantly we wouldn't have to fix
> the !BLK_DEV_INTEGRITY case for strip/insert.

Yeah, I think that's fine. 512e won.

-- 
Martin K. Petersen	Oracle Linux Engineering
