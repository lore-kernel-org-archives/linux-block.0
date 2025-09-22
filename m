Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7BB285045
	for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758536701; cv=fail; b=Q+fM2W3ufwwVGoG2scwHknDxfHA0vhtLP92nXgOfgd6YlVvNLRHfA9P8xdQzl5wf6x9AG0ziYV+jw4rNm6qUtMOt/ajr7qx/nd1zYF9p+1P0jDAZ9nsz3l25TxJRQ3sNlwuOeY+y+0qniUJ8kucd8LW2B3f+uPqaSM8o0qcyFa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758536701; c=relaxed/simple;
	bh=83F2FUOvQvaIKveOSEEXiMMMJ2scKgqpX2evTK0lc08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O3VpEiHbeZCbFx37CHWH7bYMTYriMDugF4Y/oBMvsXHbPBKgeFnVWeKxl5NcqCyZqpXzlCps3kXx9oIo6rxRlEpjFXVN9YVVFS6r0L3ZfnNQP6ipJRZl6DIgyH4W9TjIKzCIdjDwl3PCcDGYZR1jA+4dckWuoRRR5yUmwx/+ouM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iL6O4vJx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yrgcTYWg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iL6O4vJx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yrgcTYWg"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7NO0H024209;
	Mon, 22 Sep 2025 10:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OODsdYfIwNcWPF6k/QYVMYDOrbe89tuNK7l/3N0w09g=; b=
	iL6O4vJxA+qxJUi1Uzm7tsq1F62LRKNJr9GXu66QC2UwhqlGBXTrttkpDl82ckQY
	qs3sSFAsSZNjqEXHC1Xd9Qsfdg27rmEApHsJPkryU/IQGqW/wIL8uBMl9FaihIPD
	LpUBTS49SfgZ+V9yd0QarsMsQXtYIPAyz633naeq/CTJ5UTs8NvdxHrRDKSKctnu
	VvGFiSpJzqrdMA+XnpIqCKIdo10WEGRPX/xySrnRb5+ybhraojb84L3YgN54JeAv
	sIx8EmQfQFQsyi59GBhvXCIvl+2NDH1tzEefq1S9eLK3HBb9UJn/HcqWEzGaIYLi
	eiud7UjY90ZWdveq6JxSQA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499jpdj4ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 10:24:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58M8HAVi026008;
	Mon, 22 Sep 2025 10:24:57 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010040.outbound.protection.outlook.com [40.93.198.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jq6upnk-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 10:24:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/N+ePF6m+Rr7C6BnDg/l6tPMaHZ2hB2+K0Qu9bokfGKDXxaPoKwgUf9vPoP0RcLzf/O+M3/j353a4C7Ul4Yc6wyx5nlFzTki0GhKRFizzYRjotHqSbqKWrJhTE4c83VWVDgooKyhLhevKfpy7i8SmCZmf9s5q0PeDf9eh3JztJ3PSap7rM/SnFJ+iv+BLPuytIJ1kUyd6nWsvIQIBXkNtJnLyt2NFY5zaBVVX0x3UkTSoLnM63/5T1iZxE0X0Cud5mJIos6XI0qgTxlmgrN49uO74zfSqIx74PgL2iFquvimPTrN8LFTg2BiYDHdxr2tdH3Y/qUch4vdpgrWOYftA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OODsdYfIwNcWPF6k/QYVMYDOrbe89tuNK7l/3N0w09g=;
 b=cmxEidOdNkWvBNKIv0CwEj4i7wbfCj2GAXsIYumNbPVnX0loDpRYr2p2InSKe3Z0rRyA+8hnOQ1daZQAdiQ5kxFHqtBAlnAQKZ/D5kF4XXuBcBqN+T3GSuhySxGZAUtsvF0AGlTqgbcxF9CYaJU1OAL/VARRcBF9/ImAnb4KG6RTnyfxRfaQT5zmpMdj/axaV5PTSqPhsaPZvGZFlYPGuPehLXhEXAXea4R9htSJ09amWp37NvI5P8fQ2c60+WvHDNUyzB5/DZtE3A0A7d39tzR9fay3+r0HMC4MseoIGj2xuj10KzJIFm3QJIn5yIgT5LgpTyQjlsy/DfYYZr+K8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OODsdYfIwNcWPF6k/QYVMYDOrbe89tuNK7l/3N0w09g=;
 b=yrgcTYWgHVfAHSPXavNTpdoCLdHdELPB0qd8VzrcZ9N4HI2qr1QOJ2U/ap6bDloYrEuLocyln5V8BR13TML1mUnoeNSM4bmJtM9/eXpYfLqYOWaJfpixZd3oiI1Q1R+aZCAQXbRINQQ1REcz7kPLEil4+9U2N4+9e8Jv726G9Lg=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CH2PR10MB4293.namprd10.prod.outlook.com (2603:10b6:610:7f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 10:24:54 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9137.012; Mon, 22 Sep 2025
 10:24:54 +0000
From: John Garry <john.g.garry@oracle.com>
To: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Cc: John Garry <john.g.garry@oracle.com>
Subject: [PATCH blktests v2 6/9] md/003: add NVMe atomic write tests for stacked devices
Date: Mon, 22 Sep 2025 10:24:30 +0000
Message-ID: <20250922102433.1586402-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250922102433.1586402-1-john.g.garry@oracle.com>
References: <20250922102433.1586402-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:510:5::21) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CH2PR10MB4293:EE_
X-MS-Office365-Filtering-Correlation-Id: c934a0b3-42e4-4297-c7da-08ddf9c24565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fvScrceEV3Icj0nm3b8KmiWnKX0hzc3O48Oar+abaH71IAFqbAC+Yhlk0Y1W?=
 =?us-ascii?Q?05oPW7QJ02patUn88ABEJH5MbuX4UlkCigMXlCSePyJMfUMcB7m6fuXh6lax?=
 =?us-ascii?Q?+CR1hjYljCOnDmC8jxI9uu0LZgaKXK77jwDMXghwWEsDrT2JgfMNnVAcDBLP?=
 =?us-ascii?Q?RqIbzU0WRTYYgUxiOkN/XqM9K1d5jrR7zZBEpgtByKARWhna/wDC/HGcK26E?=
 =?us-ascii?Q?5jZcskZMwwFhnqwJUTx6mkhHWOYOb30diNWA8wAu/c1ca0wV/NOtzbzuYBSH?=
 =?us-ascii?Q?2RDs2Z0B+cIAr753RhwZqQ8dc4lP6pheC/WO/I+daFjYUa5iQBtwugJ2o4H/?=
 =?us-ascii?Q?O4viFG0kQON/HYauHhFo4p9fq7KoX6MZRy5R68mXCV0OjSH9YFETMHLhLipe?=
 =?us-ascii?Q?4jPsIltB49ROSontXjjBoC/TW5fszTbLkUi3oQa1OCqNOcZHFAEsa3LS5Qg4?=
 =?us-ascii?Q?RESHFZ+4NVIxlpFlOkFFyD9AOY8FuUSWrVXylSW4zAnm+LhQ2oG4iQvV24De?=
 =?us-ascii?Q?Gm+tsPEsrN6SHH7/jaDU4p2Bid++dbsXMvuPncYTiTcMkFYu+t7ztjlw3HkJ?=
 =?us-ascii?Q?2eGeCcuFayxqM+oOP1/9tUeyXZONO6a68NFFpD7q5UwOZ2J6pmy1czOvDK7I?=
 =?us-ascii?Q?nvs7DZSI7LzSXkB1l5u50RLeBlOVP8HTikRbHLp5fO/YwMWFC2A8riHbGsC0?=
 =?us-ascii?Q?xY+O+4hSYo0pxd+TkS8Uja3qXHwV9a8FMHsAyuemI+PZ8PIsFX9Nk/OYKd8k?=
 =?us-ascii?Q?1iqNav4MxGIUaLS7QQKefr3hLkMDhf7YT7X6Aah0YIH9ksWCVJoeCPnpv0Q9?=
 =?us-ascii?Q?1AkHX4kIherMU7PJ05sS1EsVkK96Pj5oRe4R3+Rr1ZpLz287mTe9UzLUSr8E?=
 =?us-ascii?Q?cNcfeHhBea5HEEGnLQMq/ANWQMrCOAPZgdGZyxciU6Q5AxbExO/2CZ44S+1J?=
 =?us-ascii?Q?IOvkEH9kZg/IAYLc4HTPaZNVCJXMQOa26HdlSUj72GFhTrpHKqFgBmc/yFa5?=
 =?us-ascii?Q?GxDiKLWPuHyRyWdj+jCM0MUSwMSDOfiJKedbOW1R8ftXU85dGYRYOBEhLIqj?=
 =?us-ascii?Q?attVwN7f08T2U2HxHFqzh4Cy5eAZNq4FxSl7tLipknlqrqZ0BY1fZ77XZJms?=
 =?us-ascii?Q?/myje3RqzTj8KBu/ifnYxNCfqH0Oo6dn6QQdkjj52Ymo13X54ss4VFCPLz2O?=
 =?us-ascii?Q?T/UAHZd1sqKni3DtS44oJIWq3mZcSXJ8Mq1p6yEK671sm9/0WNFoNzLx/s2c?=
 =?us-ascii?Q?nwkZqDRt/IsNVPEhQK8JESbhgXMNgF3gqgU4Y6yawiAoIvPEaP1G5WLIZYG2?=
 =?us-ascii?Q?D9VSPLkthR5oGx0iaoBYNAuMF1mueYa+Als8PGHaGHqgPmVe/3t/3RSQDCGE?=
 =?us-ascii?Q?OXYWs0VPqFhKc4JuzJgNiCFwg2hMxBSqwrKyQWQ9H80+Ik+iNDtHZP+2/8Wd?=
 =?us-ascii?Q?WUeMWKLv/Wk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?74fw36QHn492i3tjFaC7N+v+ydPGMqZcuFCm+F3ELAbR3EzfDuHWb61fEhKt?=
 =?us-ascii?Q?eX8T6YyhFW/Yll8TE76+9gGd5sBpEkI0Zj2VlXzAAuCrXrFAd+uAkZQ9AOsk?=
 =?us-ascii?Q?IusRG8vOmrd26oOhMWDqqocEGqvFjq54Hl3Txqn+818jimiemVQ84bVpt5ym?=
 =?us-ascii?Q?csjkjLStp2wbCJwTbIx6z2Ip+86GEoSSpLVyZQXwM7Y7pjF0ABMnDyDUYWzY?=
 =?us-ascii?Q?6QSl74xUipNvv0d6HF0mg3hGnMNde2UvgHBzc7zXtRZcn72kmFgUDNIFUnCo?=
 =?us-ascii?Q?K1zLNjWQNWK28zOT1nmWXfLWQhdjX0MnZ0SMTa4cNf/JJHOxXWLgHgHG/Sdc?=
 =?us-ascii?Q?6H7DC7fVJzCDWVvBsY64WhhD2lIxMx/aid/sZNd+aYezsupIOttVfBeHp7id?=
 =?us-ascii?Q?4WwF7oNv3DduhdQRNF4NWAq4Pm0en+q4zTlrHjMQSYuHxLGAfMrAuyLhexlN?=
 =?us-ascii?Q?sOeCOpWApwccunVykpQvw4q53b+nuYUq6hL8n1uTLD3sFUMEae7t5W4RDMbC?=
 =?us-ascii?Q?SBd0juz/QwlYxhIKsHfURl2oKpJVo88Z0cUwL+oTLdFuCrPv+q6XqCvLlvjb?=
 =?us-ascii?Q?H9y9U894fKVXA18wPBhAgFKGuC7SRWxgh9Fw44yWXsFe+peYbWCBW/YFfZFQ?=
 =?us-ascii?Q?o7XiRQcTKa0rlyPX2dk8wvit7kQlaEAx+eDNzcVYVkTSH9JpKC8EjwKVDii7?=
 =?us-ascii?Q?e65+KjOKhnjzor4vpHAItciN/IPIJljroODj5OGrqg50ObjRK409Tf8b5GCq?=
 =?us-ascii?Q?8IlAD1m/2ynHiUQIxv0vf6X4DxtEKRTCoclSUQ5lFmb41msc8Xu6Td4tVSUV?=
 =?us-ascii?Q?02qxdwcgFlJAVulQq9paQ3eLRYz20nsFofrCNFLZCS+Yve1uGVz5pTyPb8KA?=
 =?us-ascii?Q?nXav5q7kzjxdu+e65x2wybT0PTTNEalUDXdRgKLd9nTZKXx7WjNWxBQ0MC4X?=
 =?us-ascii?Q?u3SNVFu24FFyqikRxbKejqZmILheJ9nvh1/s5e/Vjb3EVtfMidbvQZiiUPtv?=
 =?us-ascii?Q?eB0SY9+zEJiIIXkSaYzGpw43/G8i72+IB6QGpOZEWt0dgQ5yfxqI8akxuERp?=
 =?us-ascii?Q?xBW58Jr/iIgudUJ80FZenHMUosiCehjnxkIIrLTNIK/3Rb4PMy1MXd6OanfK?=
 =?us-ascii?Q?KOCW7piFE7SdjzEgt82iIzumCwEy9D11SKmlcsVJZo+wvCMWv5JTxNnBq6jd?=
 =?us-ascii?Q?XWA3OB8b6wQzTNxG/1Y9Lbt+HwgTjpDvhOzDV4sscQDc6nXYSK78MRzHvoR/?=
 =?us-ascii?Q?gK1kYp0sX5cONfMa9Qc+kuPoEGsRVvlPCWTlmPL9noViQaD0JX5dieNkMder?=
 =?us-ascii?Q?tIMqrnG1NqJCiyd8BT0rCEZ8GjsW2tpZ/wSvxlgxuGyW6QMCE3N6SEhLH7Kg?=
 =?us-ascii?Q?RQj+yL1154d3+uk1aCJ92lAjm+iHF9vhyYiOxGrDQZ36wRK6TmVxYBCFJheD?=
 =?us-ascii?Q?1NlyI1Q5oOnbYlSCrHUseFSH6sec1Pm32CVbpUyLNYLZ3Z4azmsj9O0P8WeN?=
 =?us-ascii?Q?zAkU897jVFBE36eRdUembd2cVsBBKsETxCA1drqyPTMFGf4CTGYfvW2/4gr+?=
 =?us-ascii?Q?zxtirpXc5/tZHYo0FJRus/JXsYO32JOGuMpsEVmbWK2kPLh+R0kLRt/VDVTi?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8csocZjKaaMb6pJRiJHFUcjPkMyGoyOBiPO3K6V7D9aWihW9ScP42MHa0Zh91dp7qzFKqigSuB3qAIZQDYC/nb+5OWgxmThHVrBnnCw5FRjCnapc2Z1UtybATWdWsAONE75kjGz8ezUOy9ETkdRiV8R4tq3gXb7zw3feJT7wiB+VPn+FlK3dOiyoFmC8K+nVygfIPD2Zj62eAmyPz3HmVGm81XPZ/64gFobX19WiEaagUichW9/xS/KkN12iSN5mLv1QfWRBS88M0pkmBbwMjDBi8ocB19PDZ6W7UQSiO+K9ZyPqIh3R99HGUYdKhuE8oBBbJFGF/lYEdlCnEGMzPVKtfPWh5Gh/MBrp9nBYFtEqdqn1Y9YQcLpzPL/8egvgcs5c9EsIF8MNnyR4EaPob+jcUb2cwAGVjDEmJmM+FWMU1laYuFmePt08CYjYTWibCTNOKAeNHzIHjtfRgzbOembh+Xf+VPLwUVx8vs+euw1D48sfK8twIHLlqnZIRtRVCiO4SCGEe/9WPLfqqG+bhyhNH5eS9+6scrvztG3xJ4uBJedSBwKGG248FTvjpcrqifmj7ZQWPdtfKNDl3BVFc4bGPWR/OytA+EH6JAhNDUM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c934a0b3-42e4-4297-c7da-08ddf9c24565
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 10:24:54.0648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Us0nxq4PFFn/GmU2OQAAO8fGaPrm2plOdf98Jx02SiFEh2VAARv40+2MXd/99Gzu4NUKa9VZ0bXyFEicppQ5gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4293
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509220101
X-Proofpoint-GUID: Zn3N-U4_RBejCdAVFe5nMNRvjiuMC48z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMiBTYWx0ZWRfX+gjp24ircMjY
 vHpB/OSUpS3JJweJ1dklm/Pfa+Pt7lGDcs7wydSCcA2JJWyuBI9jWdSEzJwvQfoPdh1TMojSaq5
 70huFjQwLAQ6qSo12TEvN70oHK8CYQW1xtuuitnIQaTsTlRuVi8RMW+EUclFNOhlF2J2v7xq0ON
 mCeGC5Pj3GI+Iy1RhOS36RGjdNQbTPthmI4bloZSmcJKtxs+JkmxMKn7v4JY9wihLs/9cHsz8kh
 vrhUJ7Fc8MdoR934EwXjtl3jb16VGKqJsw5mT3+zigz3MXwN+dKmpTH/xhx4zIqltQ/IKxwBIhT
 o8qL5lRF6Jm5wG1VN9Zk3tKkFGcCMRF2p1xFkg0+TGRM0JWsu4rgoZhvOagSG/1+O8rXG6h8ISr
 hSL6EgDO
X-Authority-Analysis: v=2.4 cv=aJPwqa9m c=1 sm=1 tr=0 ts=68d123fa cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=KTJngkhJxTRbHzM5J5gA:9
X-Proofpoint-ORIG-GUID: Zn3N-U4_RBejCdAVFe5nMNRvjiuMC48z

md/002 only tests SCSI via scsi_debug.

It is also useful to test NVMe, so add a specific test for that.

The results for 002 and 003 should be the same, so link them.

_md_atomics_test requires 4x devices with atomics support, so check for
that.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 tests/md/002     |  2 +-
 tests/md/002.out |  2 +-
 tests/md/003     | 44 ++++++++++++++++++++++++++++++++++++++++++++
 tests/md/003.out |  1 +
 4 files changed, 47 insertions(+), 2 deletions(-)
 create mode 100755 tests/md/003
 create mode 120000 tests/md/003.out

diff --git a/tests/md/002 b/tests/md/002
index 3e9c1fa..65a5fa5 100755
--- a/tests/md/002
+++ b/tests/md/002
@@ -25,7 +25,7 @@ test() {
 		per_host_store=true
 	)
 
-	echo "Running ${TEST_NAME}"
+	echo "Running md_atomics_test"
 
 	if ! _configure_scsi_debug "${scsi_debug_params[@]}"; then
 		return 1
diff --git a/tests/md/002.out b/tests/md/002.out
index cd34e38..b311a50 100644
--- a/tests/md/002.out
+++ b/tests/md/002.out
@@ -1,4 +1,4 @@
-Running md/002
+Running md_atomics_test
 TEST 1 raid0 step 1 - Verify md sysfs atomic attributes matches - pass
 TEST 2 raid0 step 1 - Verify sysfs atomic attributes - pass
 TEST 3 raid0 step 1 - Verify md sysfs_atomic_write_max is equal to expected_atomic_write_max - pass
diff --git a/tests/md/003 b/tests/md/003
new file mode 100755
index 0000000..5a68480
--- /dev/null
+++ b/tests/md/003
@@ -0,0 +1,44 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Oracle and/or its affiliates
+#
+# Test NMVe Atomic Writes with MD devices
+
+. tests/md/rc
+. common/nvme
+. common/xfs
+
+DESCRIPTION="test md atomic writes for NVMe drives"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_stacked_atomic_test_requires
+}
+
+device_requires() {
+	_require_test_dev_is_nvme
+}
+
+test_device_array() {
+	local test_dev
+	local testdev_count=0
+	declare -A NVME_TEST_DEVS_NAME
+
+	echo "Running md_atomics_test"
+
+	for test_dev in "${!TEST_DEV_ARRAY_SYSFS_DIRS[@]}"; do
+		NVME_TEST_DEVS_NAME["$testdev_count"]="${test_dev##*/}"
+		let testdev_count=testdev_count+1;
+	done
+
+	if [[ $testdev_count -lt 4 ]]; then
+		SKIP_REASONS+=("requires at least 4 NVMe devices")
+		return 1
+	fi
+
+	_md_atomics_test "${NVME_TEST_DEVS_NAME[0]}" "${NVME_TEST_DEVS_NAME[1]}" \
+			"${NVME_TEST_DEVS_NAME[2]}" "${NVME_TEST_DEVS_NAME[3]}"
+
+	echo "Test complete"
+}
diff --git a/tests/md/003.out b/tests/md/003.out
new file mode 120000
index 0000000..0412a1f
--- /dev/null
+++ b/tests/md/003.out
@@ -0,0 +1 @@
+002.out
\ No newline at end of file
-- 
2.43.5

