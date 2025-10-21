Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFEF1CFBA
	for <linux-block@vger.kernel.org>; Tue, 21 Oct 2025 02:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761013404; cv=fail; b=NaOUew2HxJshHDzvKT+REhG9YWMeqXSYjs/bSuBLa45MktYJpgxq8IsI1zQ86hFxaeL1cLOUFyUKOyncXY9KhVZ9w9WY4WpqAKa+7gOJ1Cqz2HgI1zDL5JdNkNxnDz3uLPip+cQfrM2SJQrm51o/Fwah0lHGi6KIAV/9FxONaN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761013404; c=relaxed/simple;
	bh=fLdSxorXuafud/j3aWpjtpaL/MW2T1nruIo3k5e/mzQ=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=bnj1Cswrwhw8wGAkBPLYz/GYE8H2dLcwXBfvYtAXh9WOtiow2JFGjCZ5O3VB3922yAL9o4MyiLXWJXlswpwTJzdiPlTBLV4edwm+TkDT266ypWAEQL7lllDJFU9cOryuThisarJfERzjBIi/sqfBVUZ1fBXAbcU9Ie+dQGqmHa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g8PGKldn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S+gpgD0a; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g8PGKldn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S+gpgD0a"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KJuk5N025922;
	Tue, 21 Oct 2025 02:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Vguc4kXs2UMKgGOn5J
	NntldqL50IuvsMKKHgZtK3/xs=; b=g8PGKldnhZYOHn6GSz5+L48rLlCRR3N4fW
	PZqVeh8RD9Al/dOL4Go5kgLKybVgracacTs2qMqGhvgjS3axAVel0DElhSMI/4RJ
	BBsDurHIRhXMDbrbUQ2mH399EB6iK5ptDrJEJSgO/EGr0SKfVeSKgMavSjl8Z6+n
	AHFUC7CMLjVgE9u65Q4wz/ThhEgGHg4/SOWIEp44fmfCr6/sOAVxx/a4pHgN9acK
	Y9+j7AgvGK8igIzoaPGvQg9C32O4NhDw7Ny3d6ZwJmDLEBOGQRffei1DUTy6I+Vq
	BiGt9wQ2JyQvtKBuKru6RoBsgN7AdVpUR5z3Meiu+KvITcqU6kZw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49w1vdjg4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 02:23:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59L1UaLR032285;
	Tue, 21 Oct 2025 02:23:04 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010015.outbound.protection.outlook.com [52.101.85.15])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bccfqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 02:23:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gW571RgGL2fodju0R61/jRPUZN3ycA+7bXU/5m3uwhwJagBlL6/YaI4W2r/V/sSnM9BJTz5vkKfQwXy90a9tzyyMzhdTrorzWdE4AZmanvpw9UZvoEkGqYtVW/+LblTF4uFpwNHwO5tyb0SdhvfQNWJ1ujb8yCehcNLIORCgVgmrrnMngVvLWstMe8hw8mjJIcXI6yQdVlNBz7XFXlYuLIRp1QJRay70I2QOBeog6DCg8e4a7oJgnYVFqM0B5CcK1alyX/0HZQwYS2UROcxDGWr1DmwpFdW32AgP+tX+xVQnt63ma2DzJuPHkoR37Nqs0WGpgCga1GAJrpnzxGps1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vguc4kXs2UMKgGOn5JNntldqL50IuvsMKKHgZtK3/xs=;
 b=O1rxTiMf06L8YoLJAdGqVetmtbPpI9Cc13u4kYNJgnyrYbuc5+sdZn40eW5smnOJnpehe/EZkhc5kE/80Ky12D2BB5+4EBwMCUJf+KB89zHAAaUnlkNh46LggHQ9bmGXYOhyBSDDCaPN493tRfsXL2wsXchpr4cJT3RIK4njzgLh/zyv/Skydl5O8ZQ9y125z1k4ByOzc8uy4nbYoIKhHBzzvt2mPmvifpklu9sX/H9lzRfqvrxgA2nA5dxMddZjBymsq3Gn7KjY6av3//4ydl+lazPYTef/7tapyMUOWXmif3ZiDGCwI6IzieqG1T0TI8qKx9FfGSlLBIiQWTKzsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vguc4kXs2UMKgGOn5JNntldqL50IuvsMKKHgZtK3/xs=;
 b=S+gpgD0aHqSU5EM3lYfMl+uCLXP3mpNbRy/cloaVS00Y4RR4Bn9v2fgkMj6EOeZyJ6S66bkA8ErjiJfz/JFwY1LSoKl+eVmDfZ4QCOCvya3ZkejpiLV6GYjpSaxKOM6F9/10ajozsU9jVTvjAWcAx1hh7XRNjaHwfuEV1dKv+yM=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by PH0PR10MB4616.namprd10.prod.outlook.com (2603:10b6:510:34::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 02:23:01 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 02:23:01 +0000
To: Keith Busch <kbusch@meta.com>
Cc: <linux-block@vger.kernel.org>, <axboe@kernel.dk>, <hch@lst.de>,
        <ming.lei@redhat.com>, <martin.petersen@oracle.com>,
        Keith Busch
 <kbusch@kernel.org>
Subject: Re: [PATCHv2] block: rename min_segment_size
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20251020204715.3664483-1-kbusch@meta.com> (Keith Busch's message
	of "Mon, 20 Oct 2025 13:47:15 -0700")
Organization: Oracle Corporation
Message-ID: <yq1a51l6mep.fsf@ca-mkp.ca.oracle.com>
References: <20251020204715.3664483-1-kbusch@meta.com>
Date: Mon, 20 Oct 2025 22:22:59 -0400
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::27) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|PH0PR10MB4616:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b14025a-9742-45b9-1a9c-08de1048c226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jd423Hg/YrL1jKKJyQjz/sY3pdO+E3dWol91o2WoHu2DQy6Pji/uaNi/OHYT?=
 =?us-ascii?Q?IeStt6hd+qTxB4GQ9PjdGYWmUDbIBz2GOXxosnpjvNyDYMpTj1iOXvNZ7Ttu?=
 =?us-ascii?Q?K/SaoQcAy/p91zm+OzUyJXvYiuhUbvP704AanfKLJzHJfX7VeGDhZup8lZSR?=
 =?us-ascii?Q?rpFRSgN7X96bORpWfLO0q48GftpJFUYSaMnvNN57MaU01gpSik9G/zXZkrpa?=
 =?us-ascii?Q?LqIB9pG2YfENI4zpT9DfC4WnKPV8XaZNBRkdG4BAYiQCxw06sWI9uiQyiW7Q?=
 =?us-ascii?Q?/zcv8tQmKa6WI7uRfNjnKXV9WfBxm0tSwKt0RlkXG+UXJ2CfmyHjXbpUS3v2?=
 =?us-ascii?Q?5cxBkbCrMIaCZ/DjOoli6BFHCCrLZ/IJSvzPTvdv9P2VYrAIbBLhaRWEQ7Um?=
 =?us-ascii?Q?rll7C0y1lZe6kNEv5Ig+yaEGoaqYFrZNDpUiXhpq1ruETY5ECOZ0L6Kc3zWj?=
 =?us-ascii?Q?3gFdCPdcY463uTJ/TY3cG4jEyHM/AQTdWCO4XNk+qQkVWRbNk2v8Mq8aDss2?=
 =?us-ascii?Q?0nutInZBElY+8gOGcFSR+jhQWGfcf2kcIPbhA123wsUd80VsPGfLX4SDLmvF?=
 =?us-ascii?Q?7WDaGgAVOpch88blBL86lObURUDpc5ZySYoHd+WtJoG1C+IDRONNhknBE+NV?=
 =?us-ascii?Q?C+SPI7s67ozdw/RzVOPRKPEh8VpvuaPvd3LwT0j7tQvAQrFvvz3KMyjqQ7rB?=
 =?us-ascii?Q?s3pptusy/giirQAcIvuYlzgm46lCIpM7tgQO2wGdr3fm/3wLa5QOjy997wRA?=
 =?us-ascii?Q?FWSW04ytsRtlLy9rmSOImpNLQBfe2CIu7QaUQwMAImw1Vqot2wCo+ziKPCwj?=
 =?us-ascii?Q?fs2wqS9gb9UUwGMpU5pNRq6A8LUieWBLgz+Xb6NjR/ArC2HG6/f0rsWJDcY4?=
 =?us-ascii?Q?QIkLxuLWx+8wt5/fSPSs8sLGJt5Wy2UCTIZrFg6Ba8M+RWpcoXURkLuzGND7?=
 =?us-ascii?Q?oHvQ5j6K0fpCQQ6muMcPRPat0aihQWAueiUAAJjBtFCbflZ84fnxSWA4EyC2?=
 =?us-ascii?Q?ilneRBwcOPdG6z9R8x6njdboMhYligXbHzIAyej2qQEj7A5U4YkDCzmDLE7Q?=
 =?us-ascii?Q?U847buh897G/mLTnZyO0IXJRGn9a3ifMnaf2aQdwouknkYkIwC1KN5pq7oxB?=
 =?us-ascii?Q?BbrCEZINLT1mQMIPzXJgewUldR6D3NlcOMndZbXxVyqDoMGb0cF1XDLaqelP?=
 =?us-ascii?Q?e3FS0R7wHXzIHZBDF3TH+evqtyb/TtVKotz6IifOieHRBFEC5cFgCr84gRZ/?=
 =?us-ascii?Q?ZCQg6dpxpGj+BUvNzAv6sRV+2DHouxzvEpzXRh4XG3N5sCdJHGKkYBqbNH+o?=
 =?us-ascii?Q?HmOA9oC4evORsiTZi1rCBXyGD9OY9HcfaP0UOQ99ssbGJHZDYkgyX2w9gS8P?=
 =?us-ascii?Q?vRK7BJxZCVEf63zVx/Wd0hKak4wzCLPARIn9L7eV1H5UQyj0s3LygqwZ+Avw?=
 =?us-ascii?Q?4uXr+LucqH1BMnuxDps0noc3uiYwXBfM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VJRP0I61ZFtU8mP6zDpAKtzuvjHEs1OvEAnS985FBV11P6msFpio7PUNHbzl?=
 =?us-ascii?Q?ZlxWUXlUz83MPNX+JOiWENMcKROT6m9W2BOapgRCh8sJO5V0lWqz3Un3DDBQ?=
 =?us-ascii?Q?JLbp03NklRDhS3flCwzHXktcBDAfp4iza3bdr5Kg0r2vo69h7bcfJroRB+81?=
 =?us-ascii?Q?Ih77eIe/MvQp2M7zEB3IlY2qCgC4n4AUhie+s35/hYkZNS6dz5UG4JZj9Kna?=
 =?us-ascii?Q?/XVB4H+dWvIjPilqxIc1vFNcFi/JUgoEz0uMOJwrlRAefX7nbHFEKjKKNWSY?=
 =?us-ascii?Q?USfHHsM/5LmyKKK1ntgN4dkJivaREU6lvGEETsxFkQ7AFIfsfXVcCvlMEKVc?=
 =?us-ascii?Q?zXewaBdrY03OLD1KsFKCet/QIx+3WabTHT/Hsh+mnloxfKzLacnx6WBq4KNP?=
 =?us-ascii?Q?RyQoLdFfRGcyrFyuhqnC02+kGA+Ch9j6NrjsuQtg/hnOuttC8CUX/kwYmetl?=
 =?us-ascii?Q?0GueEUvlLOl+6eOSi1OiGW0R120ZQvthW9X7Jyv766qkMfc91XhXL/W+9vXG?=
 =?us-ascii?Q?Hdm4k+hz2nzTX87DBenG3f024yeIiPjNoBOikXXZ/5pbvxsMWHnK0AMiW0Uy?=
 =?us-ascii?Q?rEg/1yXMyj9A7y6/hrVTQpLdfF8hiDR+5PlAH1ve8l6AxVQYzcEwz/nL69GU?=
 =?us-ascii?Q?+le5OFbV0ZJlcy3TgVT1AYG7uZqfDe1gDb/qbDSV6hLme4xu7qS/wBmWrkbp?=
 =?us-ascii?Q?fV9pxy33emYU9x4QIAWo09daihCVvcuRnw1MBeg8NxOe2jsZ4wcfFErc3at5?=
 =?us-ascii?Q?zTqal5EA15fBuAfdN68/qR93gpHtXZHg14eBQ6xxL2VjgUHPtYbLe60Untmy?=
 =?us-ascii?Q?c1IbBZINBUwWbtCwLlavF6aN7NQndSGy70aX2Ty6AzqmxDO/ubX7j4EwYUds?=
 =?us-ascii?Q?6z37aNycBw8b//hF0g97p0XHIw1WN4/i3Y/0pYzXP246FUjkEIT/hkoMVyBi?=
 =?us-ascii?Q?VSNpEg3d+6XW9WcNPk4UoGdDA9j8BV73PJ2EgT0ggcUwEKQ2dBUvsKB2HzOH?=
 =?us-ascii?Q?GQUuY7UQ0rgnTJhPJtUS8XdgBITXYpd9OChNsfjnaeGegZ23BviudU+bTVAt?=
 =?us-ascii?Q?rs/qS5KxvVVhO5lgVfHc9PJ7oVVMLingK4UQdmyDmwuNu9OVt5PsVJnrSF8L?=
 =?us-ascii?Q?MI8jWz1TSLkxGVkhkcbqPSqhN9HpHMCfGjT5/HWZ2BdxO5+RKbCpfCEXShX8?=
 =?us-ascii?Q?UpQc9SWJRklnuZAO1muis3fYUQ/OoQtN8q1cTmplCIxFSyGE1YIut5IExNhB?=
 =?us-ascii?Q?AkBrcKUwMJk434XO8YVfqTGUjiaB1hmNF/XswXYHUQmJeRFS/jRpodzYvapo?=
 =?us-ascii?Q?6QJQqf4ZztnlR1XglA5daQn53gh5tPfJG1ykcEQMLjNQ+UwoDZ/OrBwZzy25?=
 =?us-ascii?Q?0nuEMyR9LdjkZs2+eOnP0BgU34fcgELoz0bCy14/spcVWcVhuZpDysAk663a?=
 =?us-ascii?Q?kd5BhcLhpx0hd9Lt9+Kv8IGJzdfNTSHXcy6rzlsTPRMyJ5GYG0Z7Ko9yMwpT?=
 =?us-ascii?Q?/1BMjMP8MnMwGBTb8xAdeBLvl1qTPoahKbjGWZQL4UNpfFMKagRyHyCxuHQV?=
 =?us-ascii?Q?stubfG3kNjOh4lkoMB+Xgcv5ZsfS7PXdmcp7X4ls3AbVc0KpVdrxGswQuN3E?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e29x99Ejo85zjojrOLm+C07ATtZRHwfdwwX7wuK6NVEsUtYVrqjZmPs947F/xFq0mggqZDItjf/SqJfbDs+AnpSQk1pTOo4gl9PxkmhiV8i/gfxm35PhUYGFGWdfs7OOQaJ2tmlueydUgkFIY2kaPAFsfZMf6X7WPgzT7SyP8b2/002SMkOxN98ui33iVeaGTnZb0RhHQEcuMmuinRcbNl1P18BC1xJVXP3ozru9NEjFjBmAz8jVjoEM5bw5ifX5Gxta6ie/FLQMAvG7OmVAfTcYuDLhlZ2ZWPyDnVFIfSkOfD5GwoKHDLqD/1YxxtUmvdFa3VBMCLx5VdN4ebUi5bYy4jk3WnZEZIG2+2DF0CmaOIdv0YqG4G9FUpg265TEXJ2TN7+Yj70EFCcCa/6m8KANN8Alk7dQIM6c5In5SaRaqSmOBWOjibhrzf5ji+0PRwyKTGqKeLWdsTnNRgLdjdk2hOkDxlDqIMRZb9GH2nw2fTT53fEiEuEtOFo8n4soWagad0NMmOscrt7N/WGgVL/eiIkoVcsGD5Ft+Abt2LR672+vIZ7DjM3wxQnam0L5Vymim+2DQpVJlsCmN1HSZB7jsZey+nAq1rivC7OgqTU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b14025a-9742-45b9-1a9c-08de1048c226
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 02:23:01.5774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txAvHdOmFZYHg2hnfFpC+8vvo2QNw9caouPVGOacfDqKnmGpyyL2K3sXB89bzYpG14bO8B/Dd9pF4Jccik7VeebxHhMSH6QvldoRvCxQvO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4616
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=576
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510210017
X-Proofpoint-GUID: r1HnsNtYUUIkOxLt9nabdIL4-cfbXG4v
X-Proofpoint-ORIG-GUID: r1HnsNtYUUIkOxLt9nabdIL4-cfbXG4v
X-Authority-Analysis: v=2.4 cv=WaEBqkhX c=1 sm=1 tr=0 ts=68f6ee8a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=8aZEKQ9luFVNbBfSi-YA:9 cc=ntf
 awl=host:13624
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDEwNSBTYWx0ZWRfX5XH7A4e/csCu
 j+y1eKpuzrBVsAGP26oT5yZIhTGRlyZA/VMQXjCei+HV6kRlWBWHiOUtCgqT/XA6LUOBZo6wueH
 K3itONIoaw1AjZJBT85uV6B/GgmLfmxLxTDAJSYcnGe7w3/V5I/FdYerk2WzlEGVQkMunUgB6S0
 MqVNBT8dZnM8/jXMKwoU0sBVrcrE7Q7RGG/Fjg1+rdm0etCgD9L8sYLkG4H4fi7bNI745s2sQB5
 382+FXm3bWEg6QFhOqeu9Fh23zpUdzwIHM7oDEuKoe/ppd385HX0SLO1FkSqXqT4wOyHEqFihUx
 MHuAOJ1ZT4Vyi2ZeTKF90wNkYLnEb18HHcXnFxOOSajOrCiW+nkXKhB8imkP1Z2cGnzA15HOE1b
 1gdjHhDZ2Gx+720vc6DQO5tYS4IrcmfuplMlrGNDljutZeaHYkQ=


Hi Keith!

> Despite its name, the block layer is fine with segments smaller that
> the "min_segment_size" limit. The value is an optimization limit
> indicating the largest segment that can be used without considering
> boundary limits. Smaller segments can take a fast path, so give it a
> name that reflects that: max_fast_segment_size.

How about calling it max_fast_path_segment_size, then? That seems very
descriptive, yet not impossibly long to type. And less confusing than a
"fast segment"...

-- 
Martin K. Petersen
