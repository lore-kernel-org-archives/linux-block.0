Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266FCDDB1
	for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721389399; cv=fail; b=iXmZV+Q4EXFI6XXKIBFuMtm0Mbtk7ReikH/9Xzgmo1setwNcSNg1eF1UWdhMMoeTzAErlNzFK5d2C8tXd/6ziBIs64y2SZtEQcQSTciYsyHB9mjmEKGA0CuybduiQuyBJ14/7IhmwimkmfAQzzYBEPrHDmWu0G0tkaD8XHoYZ50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721389399; c=relaxed/simple;
	bh=K4pMw0hIM2rVID72dFCOQHxOmYgK0xyFMMlSa1pFkRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mjAA9TeurLNhA5GGlCa7Hsvsy13dHVrCBRpNFO9E57uJrHPOgOfJc0BQnl6OLKNwmxdptQbXhkuADNw/Y3OEWpJ2VxrzMNrFVnQYm53yMs3gyOLwC/pv5X0eS8dzqdrQQRaGORpCZ6w80ql6xS6PjEoOUjBo5Kuv7YJpokX/g1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RWpk+nZN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tUVg05sn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RWpk+nZN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tUVg05sn"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JBe22b026231;
	Fri, 19 Jul 2024 11:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=IpV8HMIXCYfInCVdjmT269NJDVNsJTPRDym+rHM86mY=; b=
	RWpk+nZNqL2T0Zph+tYFImgAc2zRp3KEs7RcE1gRDL5N5MG++fRgd8YaUgaDObEt
	jcqA5k9vJST65aQSKrMXM8meUXzG7qXQJ/+JBbYCIj4JYnsJQK/7ryHIK1ffZ0Nd
	qnsqtHBS6rFj7yeq8YHhB1zT18hHIr0xR4bkBSAoviie6o65sulQhUNAHUVtzB+x
	cLPqYdADOuFaaB97xxEpfpXtIjc9/kGCNfOgVNTOKSNr3enKmz4KkgvnYqEyxiO/
	m0D7/Ssg9O9GtB18Ud3RyhPZSK2JgcoYoz5lKRUAJeOkQe/cMC9rdYtvcoWX2D9H
	4+EWnT0V+V3HXq+Jkvql4g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40fqfkr04q-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:43:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46J9U3lL039563;
	Fri, 19 Jul 2024 11:29:52 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40dwexj2ju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:29:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVxsddFopXYImN65fcqQX80z9JSHAE4gqPJuMq0VI2MmJaJw+H6okAOhnkpPVuzf6kuq7Q2pfl4vmy+jGArC8N5qbzV0rOaUsLXaCrYkw8Qi3eciuceR1YlgA1XSmrW0wVcJmyCSSLhmV1d1jPsxHx1rHoFw18FZw+EhxFlMd0A+5xLan6K6lwHSTQFHjDjJl3GUDkputQ6TBKhPQfZPk8b5wZd3vUsBXxefFWaPezykBUxuZ00Y9aS/zuUz/Jo/kt63vptr9CloOu7rMx0gu8UJBAFv8B/qBu9ma3MJsNXPplN+NNHh2ep6TwV6QKyp3D+uQyZqooSZ+Qas8FDnRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpV8HMIXCYfInCVdjmT269NJDVNsJTPRDym+rHM86mY=;
 b=MRgMygnPFsmi5RaeeXq49S/5neLiSSSDmVcCL884gAO96QMaUCitpuTK2Adfs6fs0zyct+YQEe0vudGfNISHgmkjblDzOLp/Js2buo4YS9+14/GNA1NUncllPbPho2mrpkwbH/vrMEuu/RA0Ruq2qPWZaZRNrKjRdn0wURQQTEAIozA2WO/iAoyOGj0t5w8gC4HpC/4EMRqpubpHrVquUeMbWZ4P7F2zacyaTpmz/7S7RELPxSkRfHMXtlL5wLfeSqjFarQZqxdPxYov/qi3MItWcV+n0cHNiXVQUVBbsvky3s2Vpcg4gv2tAixQVVjBMN7BxnG7q4XoJMRah1ozXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpV8HMIXCYfInCVdjmT269NJDVNsJTPRDym+rHM86mY=;
 b=tUVg05sn6SubNOM9D80vvvEqnvI0AzSxcCzs2FzX0ntsRPHtLXTra+SaB3quVm3U32VHtpl0LnShnVF35nTYQ+VajSOR9wUqmL8zTBY6rGS9r6BnkJ52jr97JY93jb7s91rUqEDZ2vhOAoSnV/2iVbhiyd//jfBSjlojyEXlKEY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6537.namprd10.prod.outlook.com (2603:10b6:930:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.30; Fri, 19 Jul
 2024 11:29:50 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Fri, 19 Jul 2024
 11:29:50 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, bvanassche@acm.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 06/15] block: Relocate BLK_MQ_MAX_DEPTH
Date: Fri, 19 Jul 2024 11:29:03 +0000
Message-Id: <20240719112912.3830443-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240719112912.3830443-1-john.g.garry@oracle.com>
References: <20240719112912.3830443-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0058.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 87251a56-b3e1-49fa-f7e9-08dca7e61a51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?e/bJ9l4OubcYzKpuFxC5NQ8GB0LA1Ad2ZFABqDuZpaV2JaWCtAGDxDcLujUX?=
 =?us-ascii?Q?VbGZYDKIE7Jsh2j/6YJMLmx+dLb1swpigZT72+TPQfh9+8ObaHaglZmh79Xk?=
 =?us-ascii?Q?CpWnn1ovdcJknYAlwp7UdOvur6X2CzEWy6gkw2de/0rnS8+8/PbphqBFVfWW?=
 =?us-ascii?Q?PqMQGHEVwESYASgh2OtyzllNhFtAEcCltALmUrKwGHUShzjrTpYYs7FW06GA?=
 =?us-ascii?Q?If1NdqkOurtAkmrg1UjWUQKi0pgAdtphrLhGLzANE9ykKLa1Q48Dvy12dFCK?=
 =?us-ascii?Q?H0RlLxuK3bCDGJSchCi5rEwHnS7b8q3dRzWc0RdshGUqtVPYqbv/f/kLeMA+?=
 =?us-ascii?Q?wLTUnyI/TY5sjqZIjDe61yD+qQsY0QtmMkO+e65KKNsM5xzzy27sr3pOKonX?=
 =?us-ascii?Q?0jucfc579bL6AukV70275FgPPWfhviAWAnoeW/6LKenw+JEGpfZ+LtHTHcbd?=
 =?us-ascii?Q?TeT/RifYgASJiFfn5JwHTK/nrt0q//dv60Dn7mF+wzejCPvdEpdFwweRyKNZ?=
 =?us-ascii?Q?DKefTo+dcGP+8Yja0T3sKEAsZf/XC+NAuseClJyZWyf2qdUBif3NDutGF8WN?=
 =?us-ascii?Q?USf5ONfgrXpDJU3z6BgqehsLE54QHRQafGcjdR/ZFe+3N01yphKxVfb+SJr3?=
 =?us-ascii?Q?KTyjcZlrAFWrUNy6p4lDZWj16rDbvgDOFB7R3DHcSam0mEjV7cvG0VKFwqX3?=
 =?us-ascii?Q?r3RsUQ9oPjoHzEBCzDUaugqsdP1Li4oCI/v5Ufa82WXtiu7RPyQWMm5wx9Tf?=
 =?us-ascii?Q?w8VKFAT5LxbkWMI0MktcXkd6dvrYn/r/fLb/LIgcIUtncK2vN+cKZxWIzsjz?=
 =?us-ascii?Q?rpHZMiBbm6P+NBZly41NOh+LeYgbom9Te9IU8L6EI3HVLWLi8XLcu1ujL0D7?=
 =?us-ascii?Q?ND30JmCxflWR62Gr+ES3mqC258v0rv3k7/WKjq/4y5cTik5YsN3+YVh59F9l?=
 =?us-ascii?Q?fQyKw48G9t8JA6NQMJP0sPgecYrdxft4mXKJ8z5/6jq7Von/BpPUuT4TsGHo?=
 =?us-ascii?Q?877oo5ThecgPAZy4UhRGdCDdEhxQW8ALvqdj6un3gjUlZeuBM3Gp/pPKOerY?=
 =?us-ascii?Q?fE10H5IRfU6DcdwUqfL67IVu08gEMxAOSytwAenWs9vTjAPLEdnnxZhvVe+u?=
 =?us-ascii?Q?xFL5+50RdInxAjEQjvEMA3Sx2BUbNQZtmvEYaVw4yh7Zt/HNbTyS/S73IV6s?=
 =?us-ascii?Q?QGKqK++gYLNPujd/YvTZDRSFh9ACinBqtZnZTQF/AaRE14f7hU1+e1LMSrIq?=
 =?us-ascii?Q?91Rh+wkpswNesxLDPppJM+OoIsTA5CUkJS4e6CGsPez12s8UDBRfJwvAFIrF?=
 =?us-ascii?Q?KXFq92PqA/mntADQVV2I0dZo+2NePrRjJB+defuJmAGfRg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1K6BAwUHmc4R98iIJrwjlasTeDCBRZdqceQC+2dyyAlmW5YSaf4P9gNB5zF4?=
 =?us-ascii?Q?T89MoGwBskI6nDsxDasjGsD9DOz2r8qDKqj8BBlyj3mUjFS5EVL9iUGwzAWO?=
 =?us-ascii?Q?yP4+FLA2gAiY5vzrv4rl9/liggTB4wZBLQLhFW4Yh90O2taF7L3FDv2bu7Wa?=
 =?us-ascii?Q?PfdO/hDlbCxWajKd+ANgmk/NMQ3A9lXZ8FfIi4O5/rx3zXX0+U1Gf+WQYCXw?=
 =?us-ascii?Q?W2tZFUC7zSwIgVmwTdZs8RSy5GvL1sZgzZINP/LdGraBVJZBzKrDKHq6afK5?=
 =?us-ascii?Q?Oe/C7gV40hTJoWdoKVAQzgd8LZ6tu9Aer8N7xpPGhBMC78lgvaEkK3c1o7FX?=
 =?us-ascii?Q?AJSUb8Jq5IPwGTrwn86m75xNHU3jtidThgPPD8SpAwDMfrtWX2nMY0CKpEoK?=
 =?us-ascii?Q?qZX6PBCak9iA09zzmVv6oyAfgp1pEUvDY+jfs/xp9XgmtWtq57/F6z8TSKDi?=
 =?us-ascii?Q?GuCDup3nOS4NEfrvlRfzvGiR/AbXHmN1mgFtNB1D52y+kdgVjyVkxcqdGRHB?=
 =?us-ascii?Q?5LvfWiqMW2vuo9gG8so2yrWYTGQMLaQY585YiTpUI7RG2EaYJqer1FcII1Lr?=
 =?us-ascii?Q?YCBdRTZu8R/oR3rgUkGnOlCQ3QXptpKkku65ZSCgdzCySlO4ecW7Sw7/ZIAT?=
 =?us-ascii?Q?VcQEoCV91bkC3D++NLy02lTGIL6XkcMjN+HPFGZSVzPqMn8Wu7Xu43uB7uI5?=
 =?us-ascii?Q?DHEuF1VH9jxcgGqapUGOmH2TiKyaQLV1MHUHRapDPQ9mkYlqjGTy2ZReIz0E?=
 =?us-ascii?Q?62K8VbTv+uleaMChExQcyjI/eEc+/+fhUg7IrPAUcNofUid3JTPMwF4XXl+i?=
 =?us-ascii?Q?hpqxI1b0Ztrq2xXIsLOfmH8LDSzxS4/CtiQ+AHkK5ROQTKv1agf1LmXx7rRK?=
 =?us-ascii?Q?cAFWZDcWUmW7nks52aP5VW9Fvh4cisryFQvSfnIpQmzbSLHoe452K6uslHR9?=
 =?us-ascii?Q?iichoKjcyW2eFZjl2tzGXA48dQ8DzalaOq4WQP3/HTSMPmxKqUm8+wtA0QRE?=
 =?us-ascii?Q?zMOaXBnghAG/3kIfyyS0KZdRow/wLiLCvT9MezBdr40uRJc9X6lEV4ZKLB4F?=
 =?us-ascii?Q?DUM5J9VmjWncsSxpL/4fgAAiuz4tHfzMoDhBabWtEmL4rvvPFuBMj2ABYNmS?=
 =?us-ascii?Q?k53Rf0wWj0OAuliKfpqI8d1MYfSrAdeQpE9eU9d8mUgbxzQtgY4JUHtR3B/S?=
 =?us-ascii?Q?z4vToMczz2T1AgUGfxjpDkw+1chNLR9PzZoVhtQsTY126/30LyTwJbnPI1Oz?=
 =?us-ascii?Q?TVEiuYnhd8/cWZtGRl8JqlLdKaOMTiBB3YvXQQANic8vK0FBwHPcVDsVluzP?=
 =?us-ascii?Q?Sa7PLg0RTCwn9kACxs7Owd2l3nHrU5fALNVtg9U1NVuLirzY7tsSYbWtDEKs?=
 =?us-ascii?Q?W3ygKdT6+nOvvNzfHiJsSq0IsLx4HEfs2mM4soJ6XeEYcYFTHQk9SB6onzhK?=
 =?us-ascii?Q?LJEHRZ2bCKO1HLCxofJ0+hZ3t1TcqFq2LyfZJR5joELZqFWtUlKYYue8dpUs?=
 =?us-ascii?Q?xa8AH7/WUkr2ZCJ4eYoIC+QJQY1W2dJMn4APRm7KCoFuo8Ip5VLS9GMuRYwz?=
 =?us-ascii?Q?TZ5GDCI5++Luk3Ugrxb83Ktj+qdP1/vJma3icx7wOdeOde0GE+7MmibUR2Nj?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MNPxAFf182cMCPteoHSOMZi5exe9H+hehPOKHOtI9+KW/Prw3VW16G5VytSqaZs0XWZTBuR303XcBzth/1g6THu2ih7unPl6dCe/0q2iWlo29J7yS9PdcyjUdWQeNgbLUOeIuW6Ajy5NRh/yGkoMRhArhMWkw9HYhsb+IstEFQOPJ9ZdqDklQjFiM/rHnRwVj0XYeSpn/chwnfH4HZsBVZCIMuQLe2hUxpt1aoVx5LeksGhaIapHWTqYpcQ5Xb0U/Pfi+1PeNMcpyJhPFM+FVHMMwF7oQdSFlMifpCFBpX734q3gVcNYurQcf4Jz3F9qvq4Z610ExZIOHcNK0rr9wS/T2776I4vjW9AoBm7/OgMF4PIo1CMkve8gGq4EHQBvh/vusF1tTGuJtM5e0baNdIYJRm8+o8Yi/TTDpvzIn6gvkxpjrkGTs1kHBaCt8/OdkO7/REOHU+n9RyZpF8C88RRGnIoOhE6b8QWFSO4pBTP4bAudM7//VGIazUFWAJF3Ca3/q+eo7ooJp1OLBtOHx1TsYrQF/5JnJy3hASKm7GGGQU/tjZ/btlxZZthx3O0I41Z9vFXMw22KUilq0vJRi2p40/x+hin3fkzzeA4MCXg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87251a56-b3e1-49fa-f7e9-08dca7e61a51
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 11:29:50.7386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7nXAF3hiJwSfCRJFlo8G79JONqCX4JM3zeB49WKyGkViEED8yBouM9XKP1CwrL3Hrw2BjFYlbcWbCmtaI24bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407190088
X-Proofpoint-GUID: noOvM0E1rf1ek2qyOCimOCAYxj_3Myb0
X-Proofpoint-ORIG-GUID: noOvM0E1rf1ek2qyOCimOCAYxj_3Myb0

BLK_MQ_MAX_DEPTH is defined as an enumerated value, but has no real
relation to the other members in its enum, so just use #define to provide
the definition.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 include/linux/blk-mq.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index df775a203a4d..8a84f49468d5 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -670,8 +670,6 @@ enum {
 
 	/* hw queue is inactive after all its CPUs become offline */
 	BLK_MQ_S_INACTIVE	= 3,
-
-	BLK_MQ_MAX_DEPTH	= 10240,
 };
 #define BLK_MQ_FLAG_TO_ALLOC_POLICY(flags) \
 	((flags >> BLK_MQ_F_ALLOC_POLICY_START_BIT) & \
@@ -680,6 +678,7 @@ enum {
 	((policy & ((1 << BLK_MQ_F_ALLOC_POLICY_BITS) - 1)) \
 		<< BLK_MQ_F_ALLOC_POLICY_START_BIT)
 
+#define BLK_MQ_MAX_DEPTH	(10240)
 #define BLK_MQ_NO_HCTX_IDX	(-1U)
 
 struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set,
-- 
2.31.1

