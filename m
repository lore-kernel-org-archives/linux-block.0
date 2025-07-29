Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D3C78C9C
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 09:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780534; cv=fail; b=MRYaJBNd5yXc1IpwqCXFjrBsQDH0Pq1qpXnwnY0hs8OBuvRTY8VpbNLhHm+JCH2u1GVXSGmuhOjGDIK3cvPl5OOoVBbD1vlPmasPwvNUHLYLG7LoKvOAor6rqecx0vNN1ZdabFMX37KL4llPyS5R2YLu4H040FJVVEkMtPm68dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780534; c=relaxed/simple;
	bh=49MCHJvQygHIFDrf94KPmI6RfF9t1k9zRMUnHACpK9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=stKgkjiVXWqg1R3YzA7WTzRWfcD2khLN1pI+rM8FUayb5/Cagt7H1ymhA+3UfCR0ndPqtXthT0qQS6OgCOtvW8eAntI2q+G90PKA8nPhp+KLQr5T8tniNKJUSpzJBJvXuw+FAMHGI6Bccr3M495tBn25C42ejGlf6VPzddc7jWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VAkyqQxC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ULJu/OxL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VAkyqQxC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ULJu/OxL"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T7gFKs015298;
	Tue, 29 Jul 2025 09:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bvbCOAdwRnfhxQDhZfOaRYAN2lMKak6DHnAg8tKcKcA=; b=
	VAkyqQxCypTuYm/YH2vpGoUsVKqKZuxP2k2rO4vBRG4Do2dOKIyirIUGzFYTz/NP
	+T1B6uPwgxCeIGKlRlTDZ7/92oLAfGHBcPZ1HHezkDy4aMUk11HWhioCp+AEKqfa
	79jdmtvcv9aw5JVv3AzUFg6ahyEXhDJXJH6IKQYtWN+ELRnBoTlZ7ROuMJDYy8Di
	Cp/E2vrMryOPUk9lw9TFdwU0kaW3SKOlJukwK0uLbY7cCO7y1jQr1RRVf7f+47sv
	jE9fK1u02f6WxdZTqQjumvpQyWiR/HtB5hrMFbXIoUJFXZgDB+RN7Wsh4q8er2f4
	ARAng6FrClZNbmhUsaUH3Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484qjwq9ph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 09:15:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56T7OAvp016708;
	Tue, 29 Jul 2025 09:15:10 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nffxtd0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 09:15:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8QdVqiLXuWXQvMKWvgepM8Oz7h7YPo7hLfe53XmtFEL06AWeg/te6kZrcya0cnppERIZ62IQSnw1Z5wnGdX9OVJq/LWpAHm2ad2RNyUzf0Vl0gu9I++V4b7gBQX3V6OMI9ihI+0GBkQn4A6H5y4G6zEbsIbsvxAVyG8cWNuEyhTD1ibd0RUYJAG47cbXWHAf3AMB6Ok/zFdSOEHft6pxyna1Hd5WTnN9dG5pT4e3SPTpn9RRgIVrtYpi2e0DrUYPm0kFOh++CQM8qgTC5bsLXyOPkQFzumt7mddd+vuFaoghkHW3Bj4CBl9BbAN86CgZs1wpiJ65nd8RtqrWMdV6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvbCOAdwRnfhxQDhZfOaRYAN2lMKak6DHnAg8tKcKcA=;
 b=npe0kQ6CIb3Gcs7OyTq6EcF5XANqGClbUNImj8izXyFbe/mra3lTaTxuQJenuw0n+sBeaZcwOJJwM367h+v4tBYnR9cbdqzlKUr372eH6lPUkcgA+mOtcbW5+Zlo9UxvCiRsYtiYzdo865lxmwu4pxFXqMOwWzjnpxTvxj8keG9BmxRh9xd9nOqL4lS1T4Tb6ByS4UmEYOAz2LjQ8YkCR0YbxlHlOiTJ7XM8Pb6WfySh82XeN28kBOcRXBW2w6QUlGI+fpJWqd5imos5I6uOIbUkZLTMHJ0J1AOJcm3JDR59JIpZNpw9R9k5OM4OXagVD0wOHWn3x77RNnIytdD0Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvbCOAdwRnfhxQDhZfOaRYAN2lMKak6DHnAg8tKcKcA=;
 b=ULJu/OxL4JsTlg9xH6UgGeFVUhYgYA73LgN+WgLsorcgBM9RsU8Hc4GsFaKQj/XlTLh8JITtapjIV5iqp2p3P9sWz+s6+OelGAC5VmFvor4Yclo0N1yNn/blYTtDJQjgEUe1pz3yFkiJ6aBrs6s5TXKhqCrTymyiZnxl/55ubNE=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by CH3PR10MB7117.namprd10.prod.outlook.com (2603:10b6:610:126::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Tue, 29 Jul
 2025 09:15:06 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%3]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 09:15:06 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, martin.petersen@oracle.com, hch@lst.de,
        hare@suse.de, bvanassche@acm.org, dlemoal@kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 1/2] block: avoid possible overflow for chunk_sectors check in blk_stack_limits()
Date: Tue, 29 Jul 2025 09:14:47 +0000
Message-ID: <20250729091448.1691334-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250729091448.1691334-1-john.g.garry@oracle.com>
References: <20250729091448.1691334-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0P220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::10) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|CH3PR10MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: 40537d31-bb8f-4e0d-ff5f-08ddce806867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a4cLFmflPxG6BiKH7qZYRZxEdyOsWidwnIlxOb+elR/ry/AoWkCEhtxkYM5q?=
 =?us-ascii?Q?Blu8bzcIWOZpBhsWKcuXcfCjkeLUEN4V53DB6tJZeky/u+O1z2/ig3E1b9dF?=
 =?us-ascii?Q?KKc5msfdyOcOkjQus+N1FY1MnN4cFoz5ciuYXHGhBGz36U2KB1UsMmsHPdew?=
 =?us-ascii?Q?Y3rK5IQtAuyMhrQieEDqPBFfVMOOYSi/bSqgx57wom2kvA1DPbqo2J4l6Oil?=
 =?us-ascii?Q?9P6DaWuLrleHmOWEmevwEPDDFxjS3MsfiB9z6/pk0Bv960ZaLIupa6Hjz51T?=
 =?us-ascii?Q?eXzgqlvnuREZZObsUS/AgVwlX/Bu17KQCrMBpUlSKsqCefKG8Oh+btmDv4Rp?=
 =?us-ascii?Q?BMMAcgoHhV5IivUMMQMvVn9hYNhbQolUOjV9hYc/0TybfspfL+p0YGj/rdPF?=
 =?us-ascii?Q?dh3oBG//ZH6ecZ/f2ibibhJITO/3TMTLLWmoQEBpb3PCd/BFkjf1QpIXgdbK?=
 =?us-ascii?Q?zGt8JCalZYprbMY8D6kxjzkIW6GRZucpwYOJ/44WJ8DttgJHUZM8VfgirXbm?=
 =?us-ascii?Q?FbQ+aBv9rdXn8DHY2D51AIErx8CjJf64MoG1HvFKQX7ZLxlPz6deaBk/L0XI?=
 =?us-ascii?Q?ox0izt/4d4I+5B0ClcNpiwdLyBak4MH6STziwW5o3GwEpAbVqEVX7TqqdYeS?=
 =?us-ascii?Q?dK8aJHLvRQN5eBtAN/SLsRFkfoBafN1VzBouKFW4DLDFGqFgQFaroKL1BYfI?=
 =?us-ascii?Q?F0yWJwfrxntAd1Kcwc3XC14Lgyw+vePYRAVagjK4hugtkXWrSa9pXpZ7RMRC?=
 =?us-ascii?Q?z01pp9QSWlA2DDpXy394lzqGiRjd0l5w3QVk+97LKlKfyrAwMaiLJt+VrVVO?=
 =?us-ascii?Q?38ayIenVjKUMOsEwPymFbJ4n5pcwuwrF9r/21s6tTwOaPZqaSPnI//IhoJ0/?=
 =?us-ascii?Q?fvHrwMed3hZxLgNvESqvhmTSaj0MA+9j/04Mni3K+Ixl8WfBto2of/6eX28d?=
 =?us-ascii?Q?ZmRZoBUph+lEbFE1Jx7KiRZ9DR481c1G/D+zbat+es77ygoPQ9izkuuo/rY+?=
 =?us-ascii?Q?DgX05ieZY+Hf/OKkJNfEZ2Eb1m+nFgqq7jIMtq9PWtVi7TRg67iQ+MJ1jIet?=
 =?us-ascii?Q?nG5gMJfROfNntvsX8oxIggBEFj4jtAywk9077jU/0kG1hpCvz2c26hkXR3Sb?=
 =?us-ascii?Q?q3m7xL5Bq/JJqDj0CUY3uyZ74HTgWVFBio1tLaYAw6FprwgliuePN6s2UK+z?=
 =?us-ascii?Q?BxcDKD+HvlOJeK6r9rC+vjQGfK03Q1AxGBRLUbf64bs/D7X7VhvKDkBjdTcK?=
 =?us-ascii?Q?wtmd573yVdWpBmFRHhS3Gu4t6bytUHMqRIvgV0PL4LMRliKCcxN6aFx++W3F?=
 =?us-ascii?Q?Cliz8KE8p+SuaxmZ5f1d5raA9aUc8VojBnYpYXZShcngXK+v/xRHwVZdpTLo?=
 =?us-ascii?Q?+p0nttLlWfnJU7TD1nLTGAZSXtgukmVPWKe+ZQWVyLl1eDWwu9xYTOJwKiMf?=
 =?us-ascii?Q?/S/l1xM39Ws=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OkFMpiQ4hm6/sAq9vUKzbO4UDYN3ER3zIkKy9ocgeMsDkxTRC2535vJVgbWt?=
 =?us-ascii?Q?reaU/n5uUsLCywtBUBYQYD3aDWHOZW5RAGd/STybNT+f/tZy0zKl8/RZyL47?=
 =?us-ascii?Q?tXwr9ZSIrjXVquwpQdiSiUi0josCXlVoli46tph/d5lIB4ni+LJLIH5Mp4BW?=
 =?us-ascii?Q?8/JFkU5mrDcZnwh9gpK4iRKQjWHhEFdRW/CnTfsMIhJ4DxHBKSmq8AucZsk5?=
 =?us-ascii?Q?w/OINLW1h8VMumhaa+eYbMlyDSKbvWp9CfT++aRqh14bJJPq5lKhdbYtNh/i?=
 =?us-ascii?Q?B3As9Gnte4os5xgmg2dueW2ICKwVIkbHopMXhTId2W8jo9166ttFFKgVwSgt?=
 =?us-ascii?Q?tW44q4G6QsMfSadMbPKd7ZuB/+d/J8BXNz3F5t/9BdBkL065xL+YT3vitF0n?=
 =?us-ascii?Q?p4fwI33HvRNzeWLvbDkr1JUqj/hSHEPzThHyxBHVp4KmvCDAIQBWL4yHpBIY?=
 =?us-ascii?Q?vKEMz+rE0DXqsNgcueakZT3mqSD3fgCV3alKQBj4RnjD6xtccrAh6dGUmbpb?=
 =?us-ascii?Q?t0Mfjwch+rj27kXOGNR371XlvqqQr4OvEH0WQdUTCuYmex3cnxuX/0b1H2Cp?=
 =?us-ascii?Q?C7W1cbLnpDthIawYRLRwFyPhM+9LIzDZ07pWmHuN/Es48EcCxRHskx9cSuJl?=
 =?us-ascii?Q?/+x1sc8CwgVYVtUtmfDumtor8d265eRzNyo/skB3V96ISXdYilD8jwvkqaEs?=
 =?us-ascii?Q?i884kS2jQr15DznYMDE6m/yTXnYb4Jy8m3QrobKrkd+mgBUxtaIwW4IZvcY3?=
 =?us-ascii?Q?g06hQiGAkiXCqBKmgUf3pH4Px29REmkNikIzUuUG7jkK0a7HJ++QuN0OZ4ZH?=
 =?us-ascii?Q?41yr9do+xm1c0/zo8lRG2Jj19ko9XEqxttT+G1Z6rHyq9KxWYpHbPmcU62b7?=
 =?us-ascii?Q?p/gZ+xdQ1Kjly7sUS8Dyw2cPTGQGEA1nQxttEn2QWAkuerKLnbdUXUd7xf8/?=
 =?us-ascii?Q?XijWzYcd5sdtuZw6kN4a5B+2lrPQ9hesC9PPtWpqL+UZiMq/tZJwNviuBQ6/?=
 =?us-ascii?Q?ZOg19xEMNGmtczoAT7/9hrdIvUBDRL407FDdUslsepseeSh/ENRAiUGZ1Lgo?=
 =?us-ascii?Q?sJG+ACdIwbgSoj4htd1wVjWG1lhGR/nOnnuGSvKMTH5ajhG4WyfceIziMxBo?=
 =?us-ascii?Q?be+8lWFc0PwVqi8By1gcePXP+E88gH5QAT3DdkvS+xueDA0VjJbqzkJdQIql?=
 =?us-ascii?Q?vU9BqxbJ/qakb9kvOMSUAFduUxWU4RPEVZu2s+52U2QWpN/+D/JlOe0/aRs9?=
 =?us-ascii?Q?gcZVA51k6OKfIg6gRfd0zh3du6bKKwcFfrpuJxb3FZBZDIak7KCiKYgJ+J19?=
 =?us-ascii?Q?Nw9wn6FJy9qVjHrmsbCpn3GbyWcpFn2VZZkRq+5s2XyJjfBt0n1eZA8Y2nvp?=
 =?us-ascii?Q?zL8XbSwFM47TN+nhUt3THxvDBfmEYgw47gPXiYkHSHELORE4DBxeQ9MqBmE2?=
 =?us-ascii?Q?/vjjJQyeRbQC48ZrZj3/TGubtmiJgNuzFX+0Wo3XuLAIVDrdyJIOJyUin8Xu?=
 =?us-ascii?Q?/maSHxSPgJ/BMkpbR4+LbLHf73hG1zH2SeTH0ueeOtL3SZVVi9JNwE8Iwp1B?=
 =?us-ascii?Q?FTzClTF7JgE+kqkoNd92Hij/6AalU5nIhHFJFohNVGGOwUmk/Tw9TU6zqJrA?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9oC6maW02rdRXvoEm7pXiYhE23ALpHcTHPV12SYbPvQQCtU5HXeiAGKBN+M2iPAE7RGQQCEkb6SGJtZyrMxmuA635+1yRmfmByKLK0t9lWpJybKlj4CxztZKshFs+6tu2B96J3EXyda3jvwLLg0+VLs2mklJRIGyJdIh/PucslyiiWam6OoftiTbMT1yURb7/puSJfzQD3DCDEkPMmLByQq3Q/qmQc7sE5mNg2w1K+GypzBwRchmuUAXfMeXGgPy18D+FTEOdlvj1w29n3JDbQg44pk54fIx4GNXXiXA3STZWkBfXO6+opr1xynIgti51KYnIJXq1o77ydr3dnJwUyyn9lsI3MEGpDX8p3V15R+ISvN4SYKTye90X+necUk0pXcx+jOjUFKsqJ/8M/2BFyrK+e9d5OlH4MUyBjyNdhfxWpi6Eh6JX1bBlDV5eoT9vuxqExanoS2iXDxXBUb13uNbEQZkBBPmZ/SZMSOA9ZFVABaAw+1gKMwgXlnezPQWgydIoKmYfsZCDdDqrCtELYj/qReN3RxKEoQfr2leXviEukAZEDPuKzHWoP2u6zIshntJkOzeCLGtBb/fQl5vDFRO2aNDa5hHPvxTt0LHCfE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40537d31-bb8f-4e0d-ff5f-08ddce806867
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 09:15:06.3091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lMl7MRRTsdNBd7C4c/DN31O/Yi4cunuFadoLkmMfDrNLYkZ905vTlFuEG3NxYu4pKbpN4Hc0MQBzBGJRo+mnaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7117
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_02,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507290071
X-Authority-Analysis: v=2.4 cv=OvdPyz/t c=1 sm=1 tr=0 ts=6888911f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=_umJvKIyCw8lbYqHW_EA:9 cc=ntf
 awl=host:12070
X-Proofpoint-GUID: rMFgptwiKCCMkDOKu09BRONNuO0YshXO
X-Proofpoint-ORIG-GUID: rMFgptwiKCCMkDOKu09BRONNuO0YshXO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA3MSBTYWx0ZWRfX15RnZvdJi2so
 0KNI8fFEvXx4ce5lkUumICcjeAWOa0aibL/FZp3eiAeN3Id19kIOZAhJmotUZRUz/3fcPmimASA
 qWb1arLQh+DIHlAnlPdiguODHFMTsbZdkE3O+iCSAp+DdSTGRWrQTzTCw8Pa5HJgTjogq9hvoXi
 Uh4EbiiQWOEzJypaL7Kt/spruIMC+cBUx0n3AwhK+v3O62UaZrtRupxUwBJpTiTxLladCRh3374
 7ZEpTn9gLRFxy718gtqo7AD/mWJYzmZXvRVGuopud1CMa/bHs1PyecR13mtaXz5JEqlnLUWyUBO
 SwmFidkkC7jYWvIICO+fjliTXaNSiy71EOj3Q6ltObBEhhEuUBmJwpsEUwY8jVRIxfdDQZxsfyA
 JPKOe1trzgcZMB+htUn2LAn0w6jIXKW86Xk3VIWhT8K9jKidZZLgn1tz2JuiEFk8ea2gtW2e

In blk_stack_limits(), we check that the t->chunk_sectors value is a
multiple of the t->physical_block_size value.

However, by finding the chunk_sectors value in bytes, we may overflow
the unsigned int which holds chunk_sectors, so change the check to be
based on sectors.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-settings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index a6ac293f47e34..fa53a330f9b99 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -795,7 +795,7 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	}
 
 	/* chunk_sectors a multiple of the physical block size? */
-	if ((t->chunk_sectors << 9) & (t->physical_block_size - 1)) {
+	if (t->chunk_sectors % (t->physical_block_size >> SECTOR_SHIFT)) {
 		t->chunk_sectors = 0;
 		t->flags |= BLK_FLAG_MISALIGNED;
 		ret = -1;
-- 
2.43.5

