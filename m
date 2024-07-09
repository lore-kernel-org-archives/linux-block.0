Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CCC155303
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 11:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523160; cv=fail; b=bf6wlZKBChKFFY6G3okcf8vZ0hrfA4MIn1zuZyDcjbK0U1Y4u1NhRWcr5hfbYGl+rDMfAKUfAJHlXHkcDB3GkyOWD4VOkT8jBGCvZ23E+iOr0SBvGc+btxxuHO1eWskx+cOgrwDfpL4f0O7QWa30Q3F9MLsmOf94bg51nYHd558=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523160; c=relaxed/simple;
	bh=FCks2QIeI7ehOU5U+9epxJRNgf+ixSh5x/lhP/CrnDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HzUWlZJCF32OeHy0488tiT2e6tPCwpi1/XPQOw2nP+SyEpxsRbn+68umqLpR1ibf8+tZDZrRrCnQNTTKNMcQQPBsjmProzaICuxfDScckLQbTfo7XBvblKl17Ep6jwEasiGmTZRtmi9v3+MHMOko4uXBUjdsmrlsOQD3qfz7meM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EKmJ+bCX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Sv/43xNE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EKmJ+bCX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Sv/43xNE"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697tUB1016137;
	Tue, 9 Jul 2024 11:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=gVPI01woOgMo/dEMxIkqqaxN6hu7sWhV/i/at1u7cgc=; b=
	EKmJ+bCX0JfO7Oxbr2g60kpWKuPTCpCh+bBuS50Q4s6xhNLFq7ONbA4tBuQ8Fkf8
	eMlBtRQ+DaC4efcLIN8Ir+j+RUo8W2iBVdJA81h68vGJE4bLxd2WYpVcuUEfoLJF
	rHU02mkmP0M3YNyenM2F+w6rwX6tMLhLxuvkIcLNhzYI8AXXpMa/PVkCIGgzqefM
	5Q5yCS2HdtRyAZ9AeZKYlE6bI/iS9m6r+3KKvvC2+4DA8ffWFvBVqU8IYTW5c41I
	Wt8qLPAmiotm+n7BpFOSfXdKe4VmmrmEu/LYA6zBMULhyVEIRfLPvb8TM58zjGOY
	4p0Eff/q5UeKQl/Hi8Z3JQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkccmgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 11:05:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 469A8VA4005730;
	Tue, 9 Jul 2024 11:05:55 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407tx2hh2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 11:05:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cS1tA7IcGgys6rFsTYWxAmgADbTT4nHyCNPny63LpwXs88xtx44V2NaR0XLVBgqls+sRSwr4G3DdPgdMbkOTrB9foVjuZzEvv4j0Ip+FkJbPS+yKcAzO4UZAuh2p532K2aAmcFdkEEUdeDJHWATg+Ey3hmQl9Qhrzbn8UWal3D4AKC9cknFCndkAX5W711I9IpKOHg91P04Vt6IKO7rzyMy/hbMufZlgAVF0v82+uwo+zGow4Iaw17ZUpp+B/XYKOJ7TDBkXBAhwfM2mw6pura8RsmaM+d3mbdh/q5UBkH8UbZoOhdQM9gqlRvZHpVCbBLfkMuPjkDrtq6CjkZovHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVPI01woOgMo/dEMxIkqqaxN6hu7sWhV/i/at1u7cgc=;
 b=mQF4inU0YLvgq6uVAGylXZijUo1w/gBWWTOdT2P7B/L1KiDRHZcwduBgcJt4Lbn7b0aE7Xch/71BU0DDW8bKDCWKWI0IkAV1qMFwxj6gVYvqL2KQNGTHY/Wjeeye6wYHAjGMqZEcMB8D2Yx+QbOyw+30sqHBbyUVtWxCDK0kqs767IZ4qWDz2E1hi6x2GR+WDIvQCoXjDmH+kU9sOhw9aJW2exR+rXBRzY2bcTrYN19lPX/4Lpp+/qI126ZB8z9wyHPROvlXbdncIdNtGuDkXWcifxo2yKLHTp42AQ0d1RbFv8Yf0W6vH3rYxKcn0rsA7RHRIY+wf3v7XsIWVKTshw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVPI01woOgMo/dEMxIkqqaxN6hu7sWhV/i/at1u7cgc=;
 b=Sv/43xNEC+T6xjmQSYUzPeaUyd+Yt8d1kPD8T67Y8jJHFtTTTd9CGSMdOKC7U3P1AvZJorDp4hTiQ+RxJmK+8FNAMnvBmjThcTcNXRrvMg+n/BtbqCHNqqNFUqQTsDWTA487eV01XboQMjW4A+0KiEJRyXxCHHXLkG3WMkNw7Mw=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by IA3PR10MB8068.namprd10.prod.outlook.com (2603:10b6:208:505::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Tue, 9 Jul
 2024 11:05:53 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 11:05:53 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 03/11] block: Add build-time assert for size of blk_queue_flag_name[]
Date: Tue,  9 Jul 2024 11:05:30 +0000
Message-Id: <20240709110538.532896-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240709110538.532896-1-john.g.garry@oracle.com>
References: <20240709110538.532896-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0031.namprd19.prod.outlook.com
 (2603:10b6:208:178::44) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|IA3PR10MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a11bba-9085-4a2b-26e1-08dca007196f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?afOcrk4H2Xk9ja/UKnxExQawrrDBbqRkoZ5cZtn9eNf8pBvXRzfAJfYwgJsx?=
 =?us-ascii?Q?Lh0brVGjIplPghPcsKNmHaZ/iL5FYCKB5BLEcrd3sOTlVW2ZRgjWKKKXSN8T?=
 =?us-ascii?Q?V1OJ+UXRTuYt2HfaM7PTBWi9XIZ/fxlW1YUyboJmFZXI3jLe2nS72JWMHf9y?=
 =?us-ascii?Q?BcDBmFCKnnfssIIAQHKUYA97C8ihM26hISNLjImsjUVfm5TVsOTsQtAeolcs?=
 =?us-ascii?Q?djaxp4QHZPMgL/ZYy7Ee7hNoJcPVMck+lmV330GDe3t1wCvQHvJPtUjdy0Rc?=
 =?us-ascii?Q?6pHywQFs4JFpPyDu7JN+YyPetdYJiFqVudil1/8p0DJxCTXOiX/iAbkyQMOa?=
 =?us-ascii?Q?s2u2F9YlJ72Vhx7si4194XGrDv0nhr2RJulo1gBZIJ/goTOKGia5TDMqY65B?=
 =?us-ascii?Q?HXal2ZFMOm0OB8+ebUZPzUxVFOPO4Jr18mhYGkUNKKsgjeC427CTYVASbUZ4?=
 =?us-ascii?Q?l0y49XWiWLHm9p3NVUnaipeVQ1s3+SzlhVLAFI6uS34mQVEWZGa0krMa90bR?=
 =?us-ascii?Q?NaxzHczbW5qnW/yolq6Uyz3l+mtjhmCvJK4VVPJqHUzVEjwCJ/eivAnW/TXi?=
 =?us-ascii?Q?ZdVNlv8aaOP4iwgg9JXb8gzGxW6SbeueYwK5pUVE8Qhwfkf44ynFUXwP12Wo?=
 =?us-ascii?Q?5QZAa0LDth55oJRsIj0DdWTrVPZSbCtPejFpcR/0ru5lre+qz9wmRgs3OEEx?=
 =?us-ascii?Q?FyDP5IXQL54Rmkr3KsoIkzoioXB388KBPiV71Kt+zeQ1eriatD4Kd53nrD7j?=
 =?us-ascii?Q?1fDHL8AJDNpShJIPwEAZ3hWazmHAgJapg7WNX8U3d7HAUWb003E2HeCZUPbp?=
 =?us-ascii?Q?0DfSdmmgXNmQYBST1TV43iKHRWvu1VWlaLCY/AWli8EPG1BBuQ6ATQdbOmcs?=
 =?us-ascii?Q?d2EiaxFDtsY7CAbEnephKr0TzBq5AFT0Ohwd3M8bZVuPPVrbhWYs/IT6MtrY?=
 =?us-ascii?Q?VJh8VByYNrK1aLedRPRA2xKhymT8QDjz3Q+7jOwsqwLzLfj0Ma1wRgubSuhi?=
 =?us-ascii?Q?OBjFjvY562rJcFMcHQGzcxSpVlWcqbI3rg8yq/LXx/QCLz9KqCRaulNVYi9W?=
 =?us-ascii?Q?iEi4VRhgcSd4HUcBW694IBE8QIFXOgxRReEFNLyE9LiEXe+KNoSK4ZXBK7e1?=
 =?us-ascii?Q?n25YOrVNwnZ8Qk/P7S59/TeqVN79R8UU4k00yoimwa9V37O0NqqKbEcKGFNS?=
 =?us-ascii?Q?rRRtV8wIXGOnkuoqXwYfIrbOF32LczMEkrBmrtPjmivSzRN8BgQn3UFhnDTo?=
 =?us-ascii?Q?8ayqGyEj+FtKEsSyGmn+MAWEMPvtIEhs04XlCAj8SP2cJOpRrbJGI+lvPbZi?=
 =?us-ascii?Q?dyAT9IozqYf1Z2F5tXdo61PPlW/u++5beLJaM+4fYCm18w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xrEK/Q6cKxthP2fMBFMwDusZimSwQv+cGkAO/xTjMnxZSnitH+XZ6HeOK2Dx?=
 =?us-ascii?Q?pQ2/y1kvdeLgrxpMmOGsg+pVhqf6/Ix26oJXTOY/A9wiOEhVd/dKNzHNzWAD?=
 =?us-ascii?Q?DCOXJr9K56beR8Yss2Q4AuOzeTmAVeUji90uzwIuZ0gKehYby9ZLwQp2cVMp?=
 =?us-ascii?Q?vtal6cLm9fZYkwWwhPWvU2ezIJKrdf0PtzqskbEW5DYMZ7g2uMcmkzJ1kibj?=
 =?us-ascii?Q?Wr2UNppcs62K6hqBxVAfNyn6GhaLSBNqGhOMr7OD8xEde31lnKJRqbY9iGA3?=
 =?us-ascii?Q?WaTlzKCdQV0wAV9Y5ZsbmjsKDzrrAXJ2vwvNS4S7R+j6577DPoWe0FIhnbQ8?=
 =?us-ascii?Q?qo9ZZIcLSw+iDDFN7M6dYZemSnELOYeX9CUBgl3qcVSOQENKxQ7EQKFiubG7?=
 =?us-ascii?Q?9eo01ZYgGrV0dOeAB1MPFKGRLQtoovcfUTBXohkDVIiY0mw1jhWMJUL+BbO2?=
 =?us-ascii?Q?6EC7AIEXQM5ThWHOqeictR4TZh8XfAexfzxXWM5Q7IKwTSBt7e4qHeZs/3JQ?=
 =?us-ascii?Q?RN6sGrFilnYajQXwN34uPjARhttxIXujOL6VFhTd5djdc9zp6X5XHP5gexYy?=
 =?us-ascii?Q?8drvBvk2LA9r+9D1iYR2m9Tk0Oh47CiLuZGfaYcCcVWUsMHP2z/a/x+4rpEc?=
 =?us-ascii?Q?u84J6zxyYFh2Kcdvj+fouNYHibKUO9N1iVJj15XH7Fg4P42C8fVVoYo2KqIq?=
 =?us-ascii?Q?vIVVNCMsiNR8Gpqgg0hv8xkuEglzkJ8iqoVBtgUSyZRsvXzc9UKSa8N+qV5e?=
 =?us-ascii?Q?3bLPwbe4T1l65wjFkfp5ru+VfUTPBnJ9trAx0drIqmDLtzfyNSm8qhropgqj?=
 =?us-ascii?Q?TeUWVi1FZt0XMomWR9RrxqyE+77AzLmxfrqvDui2SgpdyeoRqdWpe/X3wlIH?=
 =?us-ascii?Q?F5fKH2CcNuYVTroWN0ZclXRf3I4JsGea0hfJOWcMe5LCMWOluHfnfLVdQEre?=
 =?us-ascii?Q?AOraTUt9s9Z02VMRXOTMKg7jI4Gyoe/oi0xDZw4N0OxfbjteifsojVCisGMT?=
 =?us-ascii?Q?Q7zQFVdOKBxcYG3pysbDoLXK4qI1wx9k8qa2DambcToCwtWzUiJdcHMmafhL?=
 =?us-ascii?Q?sIfMuSdAaqluozeqDL0sBgcVefMWIGKRZOn+qkJPwFWtzTrTOsSo/VQjPIOX?=
 =?us-ascii?Q?ZP2cb1St/tNW6Acn08Pauu4wUHlYWYsrxkVx27slfc0Fgme+HLgzc1ExArU9?=
 =?us-ascii?Q?TG9D929YjVNffud7v3V1SH45ItnCwRx0IbUIUEicSkXtQI/kkYyZkmRf+dCj?=
 =?us-ascii?Q?flYJs8Pp28iIqLlIuBccmNbfH9xrLQdX9TU5gSaZaBVu4ZXWCfuAJRobs9t8?=
 =?us-ascii?Q?PcSvDoDftQ5dwnpw8JzRz/uIR9mXteMg/1mx5lukkPxBL7WmGlKn8GF20IPN?=
 =?us-ascii?Q?J53x1MRAG01oIkMmvLuEz05ImfFS04lELkjssI9Eme9M/KKSbyiAuGwEcfal?=
 =?us-ascii?Q?XBaNNo9YVyoO75SBZxoF9+jwU1awp0rsmTjeArNZW7tob0im8HNnFyGJgDCN?=
 =?us-ascii?Q?7jQhIu+1zL5rPb/AixBkHoQ9XmKjaGKQ93TjZd4L3jcjl/v/uEQ83sH2Q4Nh?=
 =?us-ascii?Q?yHQVtJIfq05GMh5gGTVE5t1oUIh56nGPMBi9qnVr7O2Y80kbJpxHBi5DndIB?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fhXSTDmo6S/RwCYXaImoIkzXUsj0s7Ufc3X7EiYmzRaq3N9OEcUUD2yPGy/OZ65f5efFHgBtMqTRggPgd+9yym5aPICGd6D373BYaQLR+ThvT5ERigANsFs/9pBz5CVmQh7uWtYM/ykI1XbEdG77hZmFBbCzWdMRauj5ws3dDh7lbuW1Gbe56y08wBQNa1oYWvdiZVIC1lWcVrejhfmjS7dCD+yJe18PwzgEQd3znduHdYs+oX58Sv0Z3ZJE3bsc49jQI+D7x7BS53EePXkzlwkIyzY0JiTjyylpLzTeeefx17aj//05A4+8ti/Bx1YcQJzwvekjQkMR2YhlIINxol/BGMN2ZHbbPufxQb2eDyqGslDe1zIHbkJNiXDrtUecmskcjZIBQhWt3fQa6UmF5djUh8+TII5AM5vSYl0VLL9JDu0XDdim6icVaxVE6aFfO9Mb9mlFjK/23XJ0kN6rdIU551IrtGPg4E7owfCZQUqYmz4rJ7fZxdcYGZ/txxBeY6ceUGfAleeID6BVoaiDroKXAZXjIC3oQxk1fq7mwvSf7hims4jsJxah6w6ckb5bsRjbfP9XezsOhaTgMnzN4J3qk5Lpi3vLDwT+IZh9O08=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a11bba-9085-4a2b-26e1-08dca007196f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 11:05:53.2834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V16pZInwkglhVAFe3Ku1tniZjKZP9LwtZBk8yx2Jg++KZPM+HcSJG/vuqBO7olP07YsiOmWhVR5Pk47ATljOZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8068
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407090076
X-Proofpoint-ORIG-GUID: E6bOgepp9focTjeABK2tAuydKsH9wJlM
X-Proofpoint-GUID: E6bOgepp9focTjeABK2tAuydKsH9wJlM

Assert that we are not missing flag entries in blk_queue_flag_name[].

However, we are not catching mis-ordered flags. This should not be
necessary.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-mq-debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 03d0409e5018..9e18ba6b1c4d 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -5,6 +5,7 @@
 
 #include <linux/kernel.h>
 #include <linux/blkdev.h>
+#include <linux/build_bug.h>
 #include <linux/debugfs.h>
 
 #include "blk.h"
@@ -99,6 +100,7 @@ static int queue_state_show(void *data, struct seq_file *m)
 {
 	struct request_queue *q = data;
 
+	BUILD_BUG_ON(ARRAY_SIZE(blk_queue_flag_name) != QUEUE_FLAG_MAX);
 	blk_flags_show(m, q->queue_flags, blk_queue_flag_name,
 		       ARRAY_SIZE(blk_queue_flag_name));
 	seq_puts(m, "\n");
-- 
2.31.1

