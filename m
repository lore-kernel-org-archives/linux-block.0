Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A124A2C1AC
	for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 11:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721389588; cv=fail; b=TFDncJit8gOvaELrq1RFn9X0UhoYGQK3WZ3jWp1jmChJ4JiQUkI7r0wSpgNFnoWEiud9Im5YounFYW11U3F2RkWsmlpjH3PmDIZLjm8dssNMSk5PxlLTx5vwQG9jvUPxNXblBeMOL95fZzs9/eWpO0icUg2I6D/6v+0NRs2swg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721389588; c=relaxed/simple;
	bh=P6TNQMkRBCeJNRRfYZd6taYpcUtOVerBUpTDZfU7oPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mSlbUsi5C2qGq1308Mpm4ZsMLyN5+SkiZD6t+8/pbwTJATSH8tYDPpIAmoo+eTM+KX0eWK3eTidQeQwHr/J3E6es+2HvRakZiIzp5HbLDfK3h8Eu5ZbuoewltSkzGeOqdbTbTLoU9io/F0W+QmH1f1nrYVAfLzAhd7lqpk7Ig7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OPq0ll8V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZgqU9//w; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OPq0ll8V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZgqU9//w"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JBKLHb027867;
	Fri, 19 Jul 2024 11:46:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=QMtnan9Ue1sDIl79BTMr7IhrIAEXMYzC+CAR8XvkJzI=; b=
	OPq0ll8VvX7CUXXfpJl0yXZqOIcB4s0lMJj2OgBxYbxcxuJRRIX1QwS/5mqCpckP
	19rTp4/5gdc9e4XsCbmt8ywzqb7B3yT7aOYaHA+YHvJydAvYivk+JF8PYGy9aVSY
	DkUswr/mZ8WssaVZXzpgl0qdklO3zkBt120r1dYxI6lNA8mo5X2+y/ThqK+y1/Ja
	2w9J1Pdtpc1HrqoQ2ghVc/MUnriE7rqkA6+IIss+QNU9oqIthtOXeKWBtKV32ZbS
	gIXIwOXXaST6kYfryNz2lEsQlNUGWpLAzXEigxmryYKD2WXAhtYkkJcigpAD1uvi
	kdnObX4sRTUFMdwu8Pn9Zw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40fq67g1w3-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:46:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46J9KZ0O021743;
	Fri, 19 Jul 2024 11:30:11 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40dwevt8b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:30:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OkohNKJV1mLq6Q4Ys9eOj5Bbe8raDELMbFD8eRcGEeRWCBH7C7ZNDVYyQm4a+y4/bliGWfOgjGui9Y3A7mrCpnwuFLqVTcqe5ANsxta/ly3WXhZVpkNzHn1Xuw/EZTzpyh1GrGwxUe6bipVIPyaZJqA9izF7GjXhQGQEPL1QIbyOKoHZs3YlDkh+Hjz1AHphJO54RUTvjnmk1u/WI3zTH/9Jfz37Ab5MY2/ipTH5IOBRl+qGJ7ncsHbdNVf0/2b1JYxrAyAA48Uu8xHij+JW69mkJJmop8t18Z6idx3fA8u+VP5FoXL0SbLV0Mr5thgrjLT6ckQK4x0Ueeoz3FbgIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMtnan9Ue1sDIl79BTMr7IhrIAEXMYzC+CAR8XvkJzI=;
 b=jERR/SaRf+xI27Wg5d7tjL3OvO+h2YuLw+VLVhuVtkoOp/RgKMlUBzVjysvfC6hE+pN76usR1rEX85Tts3WWoQvxlb/VxMTs5bVSvp94I4rLLkYfcub5XQPnd0YMDwfy57lmqBlzpc8Jv/ocT0om0vKhHgZj5f0DHMdmVnsUkzkRBbIPvQgKc1fIOs39v/MuQdSOI2z6yjzmuUy5xaFE7yGtJou78vPVqvaGQ+wPezobF/jGr+spTsncEcxB+U1HG2MrM+zmFt3e7lCpSzowF4/z9/S8wciBbK+DP1yQEP8Vs2suVGH1lJRAEH0ku4fXOAqJNsFL3l2hYnWVEIXxCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMtnan9Ue1sDIl79BTMr7IhrIAEXMYzC+CAR8XvkJzI=;
 b=ZgqU9//wTweNFgLkSSoV7E6Ok+VwKQngvvR57Q+AehyZq9tiKNnVchPwPy+k5/XQI+sXXJmsQRbsMWOuxdFdR8IS+AVz+XwRPk4jPEw/P5avGfF2IeJGU4ucAQ9J4HMQrAkHImQFkN6C4RoR7nDVFvU7gJ+uc9VwFfHybiK+sxU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6537.namprd10.prod.outlook.com (2603:10b6:930:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.30; Fri, 19 Jul
 2024 11:30:09 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Fri, 19 Jul 2024
 11:30:07 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, bvanassche@acm.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 15/15] block: Catch possible entries missing from rqf_name[]
Date: Fri, 19 Jul 2024 11:29:12 +0000
Message-Id: <20240719112912.3830443-16-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240719112912.3830443-1-john.g.garry@oracle.com>
References: <20240719112912.3830443-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0066.namprd05.prod.outlook.com
 (2603:10b6:208:236::35) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dc13bfe-59bf-4016-7f87-08dca7e62434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?5HuYwwJBxhK1dC3/yEb7WfJLUsG1kooMxkn3XUoGMc/bbbphf6XFzC/1qFmh?=
 =?us-ascii?Q?c3Cgbejo8KpJbxnhhWh8nNzRm4ImH0U0EVGu1UzVWjDrv4uWwGKBiRvtisVc?=
 =?us-ascii?Q?I6jDpyGf9zEeb+p49DavWwunmEgxzcRkVuJQuzwsXnsHovJhg1nHlyJL6JH6?=
 =?us-ascii?Q?TudrUr5OguA/T3QfYbPwpJudU23S0gHop/qFu4aP2pXJDcOQjZ58oEN69ZJg?=
 =?us-ascii?Q?9dUg6osaOoTM6kdhbwR86q/rafLGJSFk7ry6LvxATnhk0YAL8IB93QWFBg5r?=
 =?us-ascii?Q?DYm1HAU8fRtdqTcK9s//w9WOSv9X0Lgtz6116zamFWA6BxcvnJDGb2+HOjW+?=
 =?us-ascii?Q?7CnnLsNiiq6vXxhmUWdZ35VAh+7ZSaA4TeybPrmuNaglM1RxnJXs2katgtfs?=
 =?us-ascii?Q?vMQC7CJNgmPL5pGFhoe+yc5PQRSRWHWnKQJh9dfBOEf9qKLgv6CIgiHDt84m?=
 =?us-ascii?Q?WF6X6KKdqamYZ4bpvHFOAJLZvyC0FkxzoRZTwJIx4tEDO6ZDnN+cG/upoWlo?=
 =?us-ascii?Q?aWZ88K0qAOUp6/NE5gCzyySovZUHBUeKgyCKfTR4VWU61+AS2p0EugQ7kXnL?=
 =?us-ascii?Q?A1zMLt/ZwiIWBl4qPFHYAo+0BfBUwSwvfHs2cEQJ5KVFA2TkdrO6svO2qwFs?=
 =?us-ascii?Q?OW0hskz4hUKXZzuWSQGAC3Khm7F8Dpxrh/kXEkmY21E9kvSZyc/fgL5uvfIB?=
 =?us-ascii?Q?VUsULJZrqSbNPgTSlir1EpCx8vXDUFwml31arIg+W88fCvrm90pP/oVuUGtt?=
 =?us-ascii?Q?FCTy3f1ypSj2wX2jxVwRKvT+SZI1mcuylCQ+fcxuAcUHma1kD7ilbF1HKwSA?=
 =?us-ascii?Q?Gk/+w1g8daHIMRwGTcIhs5mJighuD0p8OlTQodiH9DbACF+LtsNsgPMotfDX?=
 =?us-ascii?Q?1OoE9FGC2sSo4mZd6ol6xLgh3/Szir9zAlk5NnjSL4cF0O/auAhOlURpFYOS?=
 =?us-ascii?Q?e49hL7aSjNrkU1CCjIiOXwxEi9r2RDD/auOc8dlivOcb8A79M8NJLm00tZI0?=
 =?us-ascii?Q?3d2mzLm0Rx7Ksx6orTnyVuUIHbN2fVRboNGeTNF4ZJ5E49dt5xywRgrYmwOQ?=
 =?us-ascii?Q?uAzX19A5etnvGJY5BhsG8+snU5EzDKEZhfFZCsjypK7xueGsvR6ymliLr6pU?=
 =?us-ascii?Q?Wa2v2LfPJWkCh/erNUdHUktBXryzy2r/1H4L0XwojY2aGQMrOTqotY0HMfAi?=
 =?us-ascii?Q?qRTzoxk7P2zpH2LdVdZhspf5K1+p8T2MysZbinFV6JrA+G4klMzv0W+hUdAM?=
 =?us-ascii?Q?uIJ8hsM3m0ziO1gQTBVi66FjQIAIRFbCB8xmoeaZ2IF1Lw94fd+kmVjPFqZB?=
 =?us-ascii?Q?Fm6t+M/2j+GiwH+XCtJHxDugcJuaBL9f5eHDbRcSyTkB4A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0ONC1nquiK3z+sO9D70w7KEMwVlbvhGjACelSXwJEi7GJR3xmT+n4dETl7bB?=
 =?us-ascii?Q?utTWBIIXH7EBwqIEqZUOqo/tMIfKRAcwxv7PmSTbQtEg9Nh9UQCG1IOXuQku?=
 =?us-ascii?Q?yu8wRETNKAnYMlmZ+XSa5/P32susvGmTB68ZQ+dR5BD3VvD+e7lVl3ndXTzd?=
 =?us-ascii?Q?LTypGIfssr66oO2p4CKYCI/aDXOBIiDUdH2ca+6jXkDu+6Dymlnaluq/D+D4?=
 =?us-ascii?Q?UuA583F9lVN7ySDbUWwnbDICaFrEAUIOFzdnmRD377NqteXFNtXhgzeLIVhB?=
 =?us-ascii?Q?iASgEkfAL7QPdGABRNvTgO/HOsibNTeh7yMjVb0ivabFoHQYPEfmaV7fwzQ3?=
 =?us-ascii?Q?1QFol0AWgErA3FIdu/95GFlMET7kZE4IE7AHahLd8bn4kWgmXTJUBFEiOG+W?=
 =?us-ascii?Q?QzTa+3DyYGeEIysuRtMrgorIrps2Z87u5IzkZMTwJdfGvPwpTfgmIAWug8Gf?=
 =?us-ascii?Q?B4G8UqJ7+icSgrUEHOA+Da3bH0F7fQl/hxdXBbgR/pEO2bEVwSBgBmzTmwDM?=
 =?us-ascii?Q?JTyoxHui74IVpfvhvY2o74SK+T+oOyERUR6tGviohXKGGerKDs9BM0mzHU4Q?=
 =?us-ascii?Q?ABj5+gt0qVtmdW9a04Ykd1cKsQAsDq9CrWPaO74VWgrhpys0WC800EsCW1NI?=
 =?us-ascii?Q?g9yvvs359CSrCpVtMS+XqG3hub8M8mlgJP9oZdHwcND84moOg8jLweQb3Ysf?=
 =?us-ascii?Q?oGrqg/sWEjQYFRmQjTgUBhgHYL3dpvgaL16SNTu/GxJJtYUd0V6yJVAeokU7?=
 =?us-ascii?Q?Dy8DTfkeohlHknVINcOG4NdiRUH8ggwA47qT5MsP4oqEK1DFGrWd0uGBJSit?=
 =?us-ascii?Q?sg9rGrJys7R9l/Xl1gd4vb6Fj/FWYhfYCzxAex+TCjOVC2zRYQDsB5q3Ux1T?=
 =?us-ascii?Q?jPwRvT/9PWk17sZHKGR/Rf3aHxPCtM+vb3r8ZXi5i3whmL7zTYC3THWdNgpv?=
 =?us-ascii?Q?d1etNqxElJwVSfu4N7vxZgWyYj7z310NpPOMncF6Zcfo26RN99jhKnj4Pr9I?=
 =?us-ascii?Q?dZOOT1DG3ze7xy0JHmR7b2qEay6aMcuCmcmmm6L10wWc+KOqwK27IDQRFWq3?=
 =?us-ascii?Q?Q/BVxZNlZBIOJrot+YKco64cHz1+fRthgzSR0yIRtaPPMYI6hqSDFlvJGESx?=
 =?us-ascii?Q?G7hcz8sMg0IsMKzifxP+9GK07T8gSROOjaPaLj56SwLJjSO7f3HAlz/5VCkq?=
 =?us-ascii?Q?0ns09zZueAKRQ7XZCmJrbMQkTjlJ2ToM3MzvRhUQnJ2EKp6DSwejkFU1Z28i?=
 =?us-ascii?Q?UOswYPzrAqn7M8HksaHY/v8AF8NFvsgfN4svOPc6gdV43drkVPjnJah3IsKh?=
 =?us-ascii?Q?StKAYaFQ+xlyycdq4t/88mqHZ/Re7kHC/NgW9yhQ/Ws3twaiZGKowp7nOzWi?=
 =?us-ascii?Q?LXrGHk7A6QVah6HMfnhLlUenhW7lC8ox0q9qvZ/OK6xBu6woegYbHGdcYJeZ?=
 =?us-ascii?Q?bBDYUntIqIuBjpad6i/wQC8ETU4xbMHioqZFr/dxmJQBZlRbooi0LVtSq7O+?=
 =?us-ascii?Q?jNRzf3KfGtoepQdmHeQUUqgw+6E5XhsLZBsovGGdSE0QJHY9A4vpV1x6E1KS?=
 =?us-ascii?Q?vn2bny52AJFsXpgB5ztaRPpf94++/2Cs4AEI32CvMwp79/6VfmdGX4SCwWf7?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5b/9xMCvV0FbItsGRSWGAhLWmT4VX8tAY5ti8XFd3LZEiVTLVliSMONNBb3JgWOMcCNt8cNKwL/9kF8XV5DVbZK9QSkWhdhWSkpO5sCsLpqIixdRBSZYXIkqs8z8OLGjO+d8DBzwG6hpxosAgsf1Wjon3EoF7IDyvSvSv5mvbQBIZzwS5p0h/YEGbx9SEKF65204x8srrDh5feqTWf+rJt2zgPq6Wvpv3fQjV5nQLkYdTN337DFZwh5WxJ72MYkVGwwqowc+JBTHr+B9vnJHdqGkEX2GNIloDvcR9lGqXSo6twZ/+a0iK6wDS6nAM/cgIwFO3mprgBiave8dd/Gi9wA0WmsbFiUph22aO3b2BiLK0XPVcVS6yivotLXftALaKlKLxg02jlPuSOwn2ZMKy9o5JjE5ebIXa7faMVCoBJqGQx4hHGYTmSYgBSf+QCGNRfKQ4TXQ94YqkgGIGaN8k0mK9JcKDTBWB8hz7unlXThiHo1Oy4Lp5H7isVlgg6zB5mr6JuFYfAul1fRVREVdrFmdss0t+jv/97ibRbKejecZaiXsJr6p20ZFAjbso4uLHr7Kf8qJCy5C6b9VqKjm9OR42PyuTgsplNPsRPvfzUY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc13bfe-59bf-4016-7f87-08dca7e62434
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 11:30:07.2541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SiPbkpr6AvZCUjFzOaaL1L3y6zI0B21xj1Tq0KbRU8dCIGLlccmzqqB2BHkwp89Yjg5Op51tiLZM5ttsZafAaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407190088
X-Proofpoint-GUID: dITGrQ3wrk_NADvr7OyUlU1QjLE5Z43s
X-Proofpoint-ORIG-GUID: dITGrQ3wrk_NADvr7OyUlU1QjLE5Z43s

Add a BUILD_BUG_ON() call to ensure that we are not missing entries in
rqf_name[].

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-mq-debugfs.c | 1 +
 include/linux/blk-mq.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 34ed099c3429..5463697a8442 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -282,6 +282,7 @@ int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq)
 	const char *op_str = blk_op_str(op);
 
 	BUILD_BUG_ON(ARRAY_SIZE(cmd_flag_name) != __REQ_NR_BITS);
+	BUILD_BUG_ON(ARRAY_SIZE(rqf_name) != __RQF_BITS);
 
 	seq_printf(m, "%p {.op=", rq);
 	if (strcmp(op_str, "UNKNOWN") == 0)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index af52ec6a1ed5..8d304b1d16b1 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -27,6 +27,7 @@ typedef enum rq_end_io_ret (rq_end_io_fn)(struct request *, blk_status_t);
  * request flags */
 typedef __u32 __bitwise req_flags_t;
 
+/* Keep rqf_name[] in sync with the definitions below */
 enum {
 	/* drive already may have started this one */
 	__RQF_STARTED,
-- 
2.31.1

