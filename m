Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE1D2C1AC
	for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721389583; cv=fail; b=iuPpxYp6UUIhcpRjNhAPdVhkMGNtVrgDlkHHmrGeoOycFk4hUvTWEO9hGk7CJgEzqvcLDlEka62Enk4mc9nfGYqNUsIDCuvrLseqxV1phAXgUylSEUBsN3Z6Pq/safsXUbU3gk363VQZ7CXOCSRq5FMVDl9UTXxeWqCs38Kab+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721389583; c=relaxed/simple;
	bh=JOA6S4X4SgpfHv+J84ImFfgPtjor4V51s+OzYTb/FCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PB6XCVge40UiFFAyCCW60oYUZwxJ9X4PQyqhsugbqTwXl3qu3xrFWztWiN1tPduB/XzSIGIOrJ7h7CF7/3EPxwWQjEhxdpLTiPEusS26v9WxPYjwRjPaEmmnh2H5Qr/UTus1TR290PRYlWfLPOuuBRWVIN6XT6H8UDlS6JfXniM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nJCqY4bz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ysyEVdBt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nJCqY4bz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ysyEVdBt"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JBe2MP026256;
	Fri, 19 Jul 2024 11:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=Fuy05Bwg2QM8LhveePFdZV1kl/x/ioHY9IPEViISBi0=; b=
	nJCqY4bzE6OEf8/HMa9beQFu8ht3fCebgwyTS8PLvMUvs/KRgrY6cjeN6vNTTi7U
	0DjjM7694TrX8Ute3ggaYzdqYwYYGqSesQprbMYmc999Uvjb6QexGT07MSjNktko
	/UccI+UW2gM+3wqLiJGplEDA488G7w549KN4zhx2lZPTIazIOW7rcNoda2NJOFts
	RF97p1aBcRmKDctxNW4Gtw+ZRdIP7WdXPQHelaI35boGGKdjSPasFPIxCUOsP5V8
	MzbZV8yhKrZLWwovXFGdh6XuAaTZymwlrfynCRF5bc4XFPRcOl2nkPNwq/SD3ZkS
	dbRAvbF008yGF9PduKruwg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40fqfkr093-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:46:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46JBBs9l021917;
	Fri, 19 Jul 2024 11:30:09 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40dwevt866-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:30:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bd91m95TadVoRAZzdWqPkT5UQBXyy+LJA2/zR61W/cuv6o2K4TGUYgh0JsbBgVb80QQZeEEJ1NxGQ3zZLDPifz7Lxw19+SUHtodd7KXvc13de+rjuHKP3xMCD41Ur4tuKIi9v4FSdmRu2qMpxq78q3uhmU6Fa4O5BLauUIIPGOgwSmPWps3gIHjVTw0YhV+AHBI6xfOIeDLug7F5cBsv5UssESLWP2gOZust5XL03DLYnntzgtwysmx0Yq5cpeFHlI2SqFVg4+Vx97yUlInBTRZ1MWLMti4YjE13X2RHuPdqf6tBwUizDn/8q74+/JrnZ0c2ERZI8fcFUk0cC6tQEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fuy05Bwg2QM8LhveePFdZV1kl/x/ioHY9IPEViISBi0=;
 b=Zq8v8u6EOb5yDevQirFVQ9tEA4xY8alNDh6qcCJmQBLQuzY5uizZ6CDdC6dcvc5TGkLkEakxsF5NRxH9QhtyKTi/f8TGQzRmUh5XRkAdW7XoeLUoNlPju1hEzQNBIC2IV8QVXrDHoF90ozm7monQVdvgoDxB5pWZNsVhj5r5s2OVqD36UoD+51vFs8zyTbWXJufSSU6iUhqrk0UcQlAbi5cgMjBP6uUv2qD2SioHOa6LXJjQDjRTwL3U+5TWLZ5j9+eILu49UgYIrRJiIu+m2wqXBku6xnZ/H/tklBNlbRVCj1rNhlLrDssJ3Ofj5kynyQ1yERpIqvVdObbYNCKDhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fuy05Bwg2QM8LhveePFdZV1kl/x/ioHY9IPEViISBi0=;
 b=ysyEVdBtq8gwYHiygoN97oWuuu2KGOSBVvb/Vo1R0HAPFIrPZPzu+oirBo/6ZbEGwvDx2uflWK5IJAVjdAWK9avBwW1CT+3WMVVkKlLWMgXZsCJ78il0mEc4c+SF+CzrxCBFWXivBkeuSYns1svBgZ2imShSRwPhFqtCqcTn2No=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6537.namprd10.prod.outlook.com (2603:10b6:930:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.30; Fri, 19 Jul
 2024 11:30:05 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Fri, 19 Jul 2024
 11:30:05 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, bvanassche@acm.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 14/15] block: Simplify definition of RQF_NAME()
Date: Fri, 19 Jul 2024 11:29:11 +0000
Message-Id: <20240719112912.3830443-15-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240719112912.3830443-1-john.g.garry@oracle.com>
References: <20240719112912.3830443-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:208:236::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 71832722-1d69-480c-9dce-08dca7e6231f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qESJHPod7sfhBmsyUIsl7+4c4kc/0sCxCw3yb6rHHAwZ7fOcqgo/ycJPqUbH?=
 =?us-ascii?Q?hAX4x+ihjjX/0i4EVzpu8uctuzIObqHdiWvP8RoTIfr/IyXQNM6cRUrr1riT?=
 =?us-ascii?Q?gguqsteFgUq3PYW+KzL/7AJq9PddGjj34lGjoejQ7FhFmfYchSrTYNc1DTQ4?=
 =?us-ascii?Q?9RkQcckel0JMUhysV0/gw4cDFbpA+E6ptk52PLeIM6JUZepSAClu4iDjUwQQ?=
 =?us-ascii?Q?Pib+quTK1hmau62G2g3/FS/TCx32kR6HvalRj/sjfnkETimvtrHu/e8kggup?=
 =?us-ascii?Q?H3EIwPiUdx05mglKZxU4Jl1erlz6g0o2930RYlxZDawM0GvmdXLnK1hSognJ?=
 =?us-ascii?Q?0zuwZjK1//eAbHsh7Ago7beZLq40WZQq/SPY6SMiC2okqoEKv7+JGrdI6VWV?=
 =?us-ascii?Q?fA9wGK9fHHeFo9lzwHpDBWZATDDOcMmld9BOOu1/hPWSvae/Hfa2CSBbYzqb?=
 =?us-ascii?Q?2Znh2vsr61PwWWwB5/VJz/UtMz/63PrCVHjE3acRZ944xUQZO6ogtCu9SsjS?=
 =?us-ascii?Q?UASPgKDyfSQD3VCpMkxFasMw13q1UowmDFG4+12rNTco8cFDpOLYWa4NwQg8?=
 =?us-ascii?Q?DfGHDj3SJ3DHJMhkLebWZnmFPgDK3zsOMU8O2/IFr3ODhy1tULCLZBXFzxgk?=
 =?us-ascii?Q?XI3moVzCDhqRHf9xixZNgTGXvGG/w7E5XoMZ4GddkxtqV/+t/itCOde4nhVD?=
 =?us-ascii?Q?0tXpXALpReoM4unBvEwUtNzGhoBlDGvV+q834b6G460NKPihPFZprBsK50gF?=
 =?us-ascii?Q?Sq7noiEO8j/nncsKJvO2c0jZvlxHkLwBKoEIBB6sd4pUSLtw8+OpmspO50mD?=
 =?us-ascii?Q?wvwW3TlwxffpC2sIhKfzm8/RjJiKvSklcoPYDB9BZ0o5Yrd4pz4E3imkgk1j?=
 =?us-ascii?Q?d372Yy6kBNn4SeoosgcXTvlKwWOaqGANH2sVvjSTCshqgOXCQpEXRsdmgmn8?=
 =?us-ascii?Q?BwYxXn8Zp8Ho60hWVyFPlUv5Bo4xz663k0T/agYLP5fQuWBWdqkETcwtEZLq?=
 =?us-ascii?Q?Ddn3T1hCV4Uf8vXnAy1RXq4odl+FCenEWYBF9XGkBZFjxOhzaRbnayYiV45p?=
 =?us-ascii?Q?UinXZqMuHuscKZN0L4O4zByNV9ndvBOo6K/bAEt58XDYVcPCcl0r7QsUbQbv?=
 =?us-ascii?Q?DlA0UKShXdZbN8BSIBUSMMT0JRXNJCgURlhpC+cLyj89fF8JfJvyZuL5OdYX?=
 =?us-ascii?Q?ZGHxfELhRONgz6OcPzf5rW2Zf5SIHf8ltMw1zNTzWflqVrBReL2UO9bI7YA9?=
 =?us-ascii?Q?ICxUENPvqukl6j8amlxGUadXCNz+cfcVBuwJ0WdTqWvDgqC1nPRGNabL2xc8?=
 =?us-ascii?Q?h+zhSiCeybFho10qEdOeJfsYkugVY8uTLNy2DayO4aefOQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8zzLw4nND6NIzWw4cHgS7MnnqczlGrVaqh97Lm7D8sMPmsSu8TpjUCAhwlcC?=
 =?us-ascii?Q?JBCdMbSve6ujvW5a1bEdsj6uGDUJCy8rDYSn8jjIVOl14PulwXaSwNkS1uUM?=
 =?us-ascii?Q?MouWUG2g7OQ2akaRWf9qVtJ/6RyVvR3w0QgsPZYh8i0T+4JUbh5+gNwopfmm?=
 =?us-ascii?Q?XkdAtM68urs8KxZ3WU9qEgptCuOpegVPdAEYh2W5CeD4QbzVVVqpVh+cOsSz?=
 =?us-ascii?Q?cKxBu0L9boO8qHFF9RS2vnFWMdaauBMjAyaIqgBNORhvTc1MqrsGYrXKEj7v?=
 =?us-ascii?Q?qFJEAGSVJmB6Z5RupVMbc2ev20gNxKJWSGFe4A6DCrecZ9C52lj2tH/DSjto?=
 =?us-ascii?Q?QWN7zzcMUO1JjTFc0ubk9RdW1tCRmGDPfNTG1wHD1RHG2oNAlSG5EtC7JqzY?=
 =?us-ascii?Q?xd+cVd3EpL+EQlM2zefG9ON+vtEJGHn3v3595j1HLgzWpOv8eXdXujDCa5k0?=
 =?us-ascii?Q?DB+jlIKU4oQqQ/GSLnbMZ44l/UZclymEH4t78dagnlljpYkH9riovylN37Qu?=
 =?us-ascii?Q?QiMfSa4H9PlLu/cy6UODadaN8n5F88ERoi1SpOxSHNgfnMRSfhivLKS/7vZv?=
 =?us-ascii?Q?Bx2x8/OLYYIQ2yHI90+flnoo3QIHDRr3te6wFeWpHy5qnlzY9Rrb8ZQtFDMb?=
 =?us-ascii?Q?H/pZdVVSSarFqKmowtC3pzabRCijCZtq4GKDF7WMNKItXEuUEqB6FK7PmZpi?=
 =?us-ascii?Q?2b1AV5i+9QSV+cXwD1Wek6iQmLvHwq1OQLDYSUr3Yqrf/eX2eLijZbTOSbN8?=
 =?us-ascii?Q?wbIBvCyK8eZ3srIWWJE8yMlHxKQZyJj7hd2Z0djDNSJxm6IM+YwrDBnWi2du?=
 =?us-ascii?Q?VHHcL4cWHmF/Hat+ggNd8/O8nrlinqp7d3a/87Z7+T0TGQjsVfeOaTQWsBiT?=
 =?us-ascii?Q?YJxu7tusMOc7LliCegWkz7FMEjPIY/TaYOJynY1CfwRNfA5m1Y8oSTOIOpy6?=
 =?us-ascii?Q?YK6A31Yi00MWCuF99Yf6/l1lwSg77BIDcn/XqzX1rq5rcJRaHakvc7q0gNke?=
 =?us-ascii?Q?oENrwhdwkTbAQIOL9pvlHrU0PIwvSVCaPtypNC1hgvBmvapWdw1Y72OBzdrH?=
 =?us-ascii?Q?ztUxaElPtZvz2vndq/46xtaK1d/Nm4bvu6rSQogl/NcFYup7gS4RqOd2tEYR?=
 =?us-ascii?Q?sqzqq915KinhzMnsPxUbh8vTYtDRtUXTjEfUojpNsR/Qh0/Y+tCr2l2Z3zPi?=
 =?us-ascii?Q?Hb2PMwwcpMyWEZXPEfoU2Qy4caW0WCazzYOdHTdxUkDZi6gtCdaPbvUPl9qV?=
 =?us-ascii?Q?4tRJrUyFk0rOGAzfGpfGqJlT7boEXA9dMbqjUgtfjQxkaFDCrrHuDrSaheWT?=
 =?us-ascii?Q?jdRblF6DAsbdOXiWmCgQgzaBqwSORWfh0RCrTo9JcRfLmmZ1xY/xrw7VaC/U?=
 =?us-ascii?Q?ialGSNf2HcUVDXJ3CodQTEvgO/lx16d/Na8aPi/COpwkb613KGggLKEnNgKx?=
 =?us-ascii?Q?Ba03Ki8WRNkIMajHYy6KtPYPvuL5Mnz4RE4PWWKhj/M5aJxSHomQkqZUFT+i?=
 =?us-ascii?Q?8EIQh0KFDvLe7EfAUUxKdC/3Wb8KA5kn4pAkDG9LKr4M7euyYD8//5zpE0Lh?=
 =?us-ascii?Q?nYq41Lv5pjOdFO9nghgm/VJMeX6se6HMXgFLFKtc30Eo/v+S1gEVH//nYz6A?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	AfiwhAR1zKZUUGmQTo7JN+Be+aiZwHX65YFEevQ1/w7ruoNGE1E55IqxceJ43qLpNGdwXUZytdzgMYLxzWjcpXTPQny1nv+3TIhJKZRty26zFh5ZVRfr+0uJei+wO8W6a/DeYNcUaUllkbqhvxgfIY89bZvQkzDXsTckRqDMDFp9ZrwlywFssAXrMIK6n+69IcihmxRHCyptRHuxagsT1AAxWgbKcjwcBvYo9QB1Pe4eDdj9+DoC3f3KJLmZMnbeiFeUgAhnXGNRByNhESht6RZZUHlWciG4bh43ho2JySEWNFTFEYPQd8M17VBAWwSnVDH40r6tTqVdUo6r7xHIwnjSTvESPN1YgMT0V62mlFxZi57z9HNN++lBn0GM+Y2+8jbzFbM1+9PWK9hIAblPAzY9DC8CIT4klLx4xSWlhoE7Qrc4fPP+MQPNqSyINNH1g55eGANs5xvxALNpMv/QU3oG4wLIuqShM94jm522YGT7l3T24p3jW4TA/PXkzELN+PDfagBwJIV6gHeYUgDdY9kcCcRXV9fJwfQRTvogqknY3h3wz/gwe3pHyeWpxes9erWYGydzd2gKL2ouK52tXfTJdniLFEHcY+XCXRRb5cg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71832722-1d69-480c-9dce-08dca7e6231f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 11:30:05.4445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YRuEjQTjJdAxj5R7N+WRmkwQ22mYO5SHvv+p6oc3O7bB+bgWfh4zDbijkq5JegT//812rpWyz4RcldbpZQS9hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407190088
X-Proofpoint-GUID: PvmhfIWo3NKrXNsAeae2-zgnOaApAqWz
X-Proofpoint-ORIG-GUID: PvmhfIWo3NKrXNsAeae2-zgnOaApAqWz

Now that we have a bit index for RQF_x in __RQF_x, use __RQF_x to simplify
the definition of RQF_NAME() by not using ilog2((__force u32()).

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-mq-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index a4accd79c225..34ed099c3429 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -240,7 +240,7 @@ static const char *const cmd_flag_name[] = {
 };
 #undef CMD_FLAG_NAME
 
-#define RQF_NAME(name) [ilog2((__force u32)RQF_##name)] = #name
+#define RQF_NAME(name) [__RQF_##name] = #name
 static const char *const rqf_name[] = {
 	RQF_NAME(STARTED),
 	RQF_NAME(FLUSH_SEQ),
-- 
2.31.1

