Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A09614A096;
	Fri,  5 Jul 2024 11:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720180395; cv=fail; b=e9OGuUjC0N8HMacrtjycck7hTN6zTopBhPvvlcDOTU/Z4unxltPoQhC7v+pR1AMO/Ux3+zKPcCBA7dnGPpALmd5Ehd11RdKOmchXK1vjHXvZlrMKvJh0m27f2eXg4BRHhO6pk7sc9c9PhVmQvkL8f0Oj4ZYjdxpvfVVnUz1qoHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720180395; c=relaxed/simple;
	bh=Ug8nG4l8dlW4rygc9iwEOO/+v4czMQR1chck2loVKSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=amcmxQQqAkVcWyfnZDijiRtR3x+gYcHt7H7mBhzjb66xASu5N0Sf7ih1n6fr5a1AW6A1q6PX3cG2IKz/Hau8z55s0Lr9n/ONK8LUyUbc4spL4pj8iHYTts6EjEHfXzs/Cv5JFFrvgfgyw13XeG/oiggkKN1XbGwZ6SQ1AJu2Nqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Si+H+j5W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nh1HJh3p; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Si+H+j5W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nh1HJh3p"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465BfVjl023320;
	Fri, 5 Jul 2024 11:51:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=+CS5gOGc0m3PJkZ44+tNF1y2jyDsxVhfLJTXUpxL8Mg=; b=
	Si+H+j5WGqqAJ/xZzWDzI5TzMOriyDpE8cfhm64QLE84TshR9GmZVVictLinYTPs
	OGw8KAZ33GZfbdEu1wG9ewrGJq2tDK0fuojdAIPQYKZ1vIQpZUb32WExhxpV+wdt
	LNGZztCf26TAVNJyw3sTx5+4kLOHWJQ4Y/t5GGkTVVYBztlDjb1yM5oikf2pUCvL
	0nbjGWx5Uvh5mnAV0+2YeGcwF7tpPNVEzi7dRMSA+zrckpwYSLUggZ30ZkOBmt8W
	8iN+k7F+o7VN7eYlF0mb2SQnCfZZBc0GH0quSb8Dno9ntw8Ck+uwp30TjTyx8L5l
	bLoAFv7mNtm3z4EFSz8yTQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40296b3t73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 11:51:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465BUrR5023586;
	Fri, 5 Jul 2024 11:51:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n129232-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 11:51:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9xZk60HYq6JGVI10WPKskp7PwxXq5oXBW04o2PmluT9LyIbOPWInimlM5W4puMR9b1j9k2lTaxvJwNi3cj3rMVctCc0BXfkNQptjZrc2vGixXaW0OAOwcUCFsB0NZ6i/jJ6YadeSe/sfMOlCB0K1tG2j2H6VTCdOUk0vaLuBok7WJFnEvU+BeDpZToF8hslAxgmmdzQZzF0mA4UpyK7W++z/3gi71LJLNafpkGEp94spwQRQdpn2dmLaYycLxnJxDygYx1QU4Vo1YEDl9lYYOGJJ9QPiImZSw0JSM/m0lfaJHh12Iw04wk06X+4+rtqFsPVcY4QqMutj3feBWzKWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CS5gOGc0m3PJkZ44+tNF1y2jyDsxVhfLJTXUpxL8Mg=;
 b=nMvo6rJlSawLeuJMtoo4qYVv+JWrF5qTAUup65kbtlul6hO6bolCmv6EkymkSuJak78tZNK+JVkezzpOQDDS4W7gKSF7u/2TBoYCaA+htl2Qn6bffofWtBf3BQR9W1px1tm1bCNQwzQfd8ZMefBZc7dl8Kfju6QfU/jSXzifYDPkppxQDrUAKoJV91H1OW4JzBNm2uSbLlSMhURmDHByVGCS+YtEaEwMd5FVnSqlnSCyujoIdlcayQcJbPjBNmMO+Tp6p9GI5QOkaZG/yhGMm6MtBn7bYvAMRAWAvytsTsNHfVVSXW5CZE4/1n86Srjhp835csuCcBMSLaRmCo11Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CS5gOGc0m3PJkZ44+tNF1y2jyDsxVhfLJTXUpxL8Mg=;
 b=nh1HJh3ph5p0lrpXzyKDAoNuxZ2e3QgZv/IlczPPbMNAdvE2jprA23ePjwZ6ATGQ68C7iBHbWfUpYr/5F27wUZ+k2mvhUH0iSMP/pn+0yrYmfQMmx3vJDM4W/640zOEM24GgXKgIIB/ebF7/KBEC6f+z6y568HIQGu0y+EPQWZY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB8080.namprd10.prod.outlook.com (2603:10b6:8:1f7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.27; Fri, 5 Jul
 2024 11:51:49 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 11:51:49 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, hare@suse.de, kbusch@kernel.org, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 5/5] loop: Don't bother validating blocksize
Date: Fri,  5 Jul 2024 11:51:27 +0000
Message-Id: <20240705115127.3417539-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240705115127.3417539-1-john.g.garry@oracle.com>
References: <20240705115127.3417539-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB8080:EE_
X-MS-Office365-Filtering-Correlation-Id: 6635d540-e9da-411e-f09d-08dc9ce8da81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ysqX3ohX5BzRtWWqliKMZOfYkNm6tPL0YImlmSU1UpECYSQY+kFE6fWbhCKv?=
 =?us-ascii?Q?3kUMu7yJnqIZ/JTWZLvkMQqtpQ11wyovgSWpv02XLlcGDZNuyiS3HA8Vgd6e?=
 =?us-ascii?Q?POEUUtE0Fk04eZodwUM3kUG+WTqIR767iSwCuU8yrjobKjdRZbDjIF5YlZbJ?=
 =?us-ascii?Q?coLuRBWXXCsLW0z5K9IA/UjAPeudi2iFZMFsV4ymsapptdFh2i2Tue+39cfz?=
 =?us-ascii?Q?wI80SkSkaNUzmfFoNU6kr75r0xJdUMEmqgoSD5hiDMDuzQJkUJMI+z8eIBBA?=
 =?us-ascii?Q?3czobDu7EL7qXKfybrnWHeaz88U53+IV5e+sWDxfzRyPcjKmMPOU5fxBpVEx?=
 =?us-ascii?Q?1zh0IRKPcCOB9OLIgw4L4PMruu5CdH4U3m/3wsbHoZqlPN5f+0ZMIWbiLIkr?=
 =?us-ascii?Q?1+UyDLvQulCc8b+HAArNLhYhuLr4MgOnumb5fobkFaLuPx082NyKFPyHSZ2P?=
 =?us-ascii?Q?Bjre3yQ00bneDe3S1EGZXU+Wd0WWz81/Dwa6G4I7Pz8qeaYq7apOKWds+4gt?=
 =?us-ascii?Q?OdgpOT+Vm47SwGxCZAXmA55ZvIci4CLWOwVApz7vfVeLidAlWqZaXcxYgHk5?=
 =?us-ascii?Q?ByB/3Z8dmi42b1YLQE0lwrPyPsL1QzY33uhhx1IZ2rGHWBKW4b1gNB+Jpq6M?=
 =?us-ascii?Q?Hc2NfXI4MItV5sT63mtcds3htd/Hk4SqLuEKF7uoOgPnhOvULSspLcZUYLed?=
 =?us-ascii?Q?yI+0KTugjUw2LopzlkSv6gQ29eB2tRpK3CA9gf/uHoGX9ipJL9orXdBZ7dh0?=
 =?us-ascii?Q?vDeVZLUxxcNP6f7h3p5M6uK9RV4016uJ2HFWr7cemOTusAPr/+amDbi2EuaX?=
 =?us-ascii?Q?NhvsUPXiv5UurWJh8XEjRbGLEe9LlNMJC8beoWa7zNU1vhN1DkRUgacG6VCu?=
 =?us-ascii?Q?fceRih8WKJcfBXRUy8YvpD/SnWDrCuXIvKBF7ZK6IPUJXv5/9qO/AwGrcSxe?=
 =?us-ascii?Q?GDZRC5FEt80rvzp6RdBskzAYyaBEca1uwQRB+mfku1rHmym27oNaY4ZVeEYw?=
 =?us-ascii?Q?PTDlwoph+/BemW6iSGlUHRpC3f1xy9FIWmjs4kg5JclB1iumKgPIl4h6D2s0?=
 =?us-ascii?Q?NG/dHl6DzKw6MpwTJjQGl8waprqDa+pdEj1uDPX/wV+Pj4JYaz2sX6JuW2Wi?=
 =?us-ascii?Q?wVuc7h1DwxSGLZyd4REEw05BMp6ar1gKTY9QQlitdvPY4D9Ab/HxegLqsgmm?=
 =?us-ascii?Q?q0pLHm+7KnNlCKJLBKgJQoySUzFNuI3oFttnHSJcy/aY8kZRJvuhtfW8xe3E?=
 =?us-ascii?Q?9rzQT9Hp7oMHrqh7E96NBLmwaCsy9VCQFAjO7tB3LIF8jY4wIEz+rexTf3/3?=
 =?us-ascii?Q?k1hImf/UwapCLtunxG3iKaEGqkd0+1p3oaIodymt9ndfDbNJPhJXPWz5zMyW?=
 =?us-ascii?Q?PuufmeFVMvVyK/pwbpO37JL7bcbL?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?m/XDC215E95UWcBSVfs6hnGG7+ms/QQ8ZxgYF75sNJMPI4OLd7bseri3WGoX?=
 =?us-ascii?Q?kQiYqYieDY7Yggoub63hY+BiiQX8bkhM5Se4vUAYGo8+WR4hxD865H9aHf5+?=
 =?us-ascii?Q?83NeKfPKGmcrNCuE2xKrp9xJnXaxGu9MQ0dGjIwniaefsiXmr3CXcXASuEpp?=
 =?us-ascii?Q?q3cDwgrzubYGcmzc6Pvq4b7gn5pB2qUvIGC4h0vIJrVEF9KXulDcjxfkEpfP?=
 =?us-ascii?Q?/22xLJxMj5NkCEH8evBjmnArGgD0ISvTFjQ+yeqdZ+dcP3xbwKQNbSgs7Jvj?=
 =?us-ascii?Q?eAzbx4wnPvnCOdB6g6ALVkEMgOpOJQIuT60I0CsaaZ5rXTGEKFfh5zuTtQV6?=
 =?us-ascii?Q?0wbKRdqF44VdFMsqfhmTXfi7ioQSRMSvurSwMbwiJL5zp2mnMDDK16Hj756F?=
 =?us-ascii?Q?/s4u8+KR+NvTXNCTZi4VDCIPiwv5sKAAFSXNgMXmmKMUbahcHC+YrqN0DwnV?=
 =?us-ascii?Q?8tAlII96mMNVwJchB0y8STJQ8UuElxYvjRfvuBgQ3NPPLKkbOnlqOA7DczEw?=
 =?us-ascii?Q?8sP4jinEjIazeZKJw7vjCRW10s8dcqJatFkan/ts75UWlBCaMMXKrOE0pie3?=
 =?us-ascii?Q?lHgoKZT3CRUEHP8IhALPHqNWQt7XT+Gy+9cxjEqis5984DzXno6LPCci4ygv?=
 =?us-ascii?Q?aWCIFZMukfYXUSDJWbuDrLAqu2lcIU9Qudjsf4VcytFj+p69blQTPRfVG40i?=
 =?us-ascii?Q?DZ4fsLC76Ux8aHCWpA6sMI1BBQoVqblFNUVMBZk8jjlkqUoByqKqR9Q7JyBl?=
 =?us-ascii?Q?r0Rr8ePYKbR0LVMecWJkJSjfydsgarBYfwgqlz/d8bYfw4KyCYcousy8MrsF?=
 =?us-ascii?Q?37cb+ldmRYup0q8EBRYxsaw9Cmb45leGrKPCmYYWxQppIHwys8SSRmZCfuHb?=
 =?us-ascii?Q?Eff5cfOIrpdhxvVItBgC95W3jfLe88XXv+4sMqBn2Kqr22UqioFCrR2Joc6Z?=
 =?us-ascii?Q?Vio4nPYs+6ZaQi/3q9sXVGtW5g8q9X0inq7hrYQ7deacazGsQWzlQwT1pCSJ?=
 =?us-ascii?Q?GBFKh22g8kbINMnUdTh0qBsJpXo8mdGLd0Te2ZTczrN0XGWPmyLCBhlpoJwo?=
 =?us-ascii?Q?DhMg45CKYN5GzwJIFfe4z50AOcNR+KsbBqfoTj6BndPvcRL1uWTMDB5o6iMp?=
 =?us-ascii?Q?IxEf46LQ37Ew/joezFi6q7FlylgL96owsQx3oiyfHq6GonFhEYcIUSq/5zI2?=
 =?us-ascii?Q?N6Y1Qim06BpCxgy8aLkPSPJfVsJ2xKbpz4zfeKI1NSgq2VSR6xJijgxl2FvP?=
 =?us-ascii?Q?SUIVbdINwPUvRkA9A6JDsmmn7FR5/2o+EJeLSAQj28LWCIvE+LRLmVpVKEYN?=
 =?us-ascii?Q?zdGLAAIAL29krzjx+fi1PORpzq8daYRQIR0gMHQOs1RcliPQqmAvcwGnFvzg?=
 =?us-ascii?Q?mHycH4XyZIJ+Bl37aL69bZCOZnsVrlnOGS2kgxcGl8HdfmOP18zakgNh/lO/?=
 =?us-ascii?Q?xkPvENEfB4yzM/K2H9VVOMPFJGPXghyZdknecARkRDV/2Q5sTcmEWoMNlOGu?=
 =?us-ascii?Q?sD4kKQwpebWBFdOQ4g6MY69Hj/FgFEi3pT55N/X9QedKNPBXHr3bXWg/Zzuz?=
 =?us-ascii?Q?Lkn4jZZtHBrzQOY//b5bMLGVN4Kz++Puqwlh1M/0tAyd9YSpyYQtmVlZzBPO?=
 =?us-ascii?Q?0g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	F9U0KuC5rXckfm/PSgZOBLeq5CW+ee3qhk5eWcJJpavTSpQpr3HT9FNQFloMbCdESArmnMMDolOx2QacOC4ysQVcE2KsTNGckqSKXvTqhl6V26xg2yM7eZZ94f7ivVG2jXKhJo2ZzRR+luBFaWJNN050Rrs5jF1ROhFGqCZh+X2YInLHOM92IEEMKAORdpyE/o6E30q5eiE+HGGAQkYTzN1ulmdhLluIIVk4eARjWfJLzVPP+mE/dH4LAUtkRwEYkNp8A+dour7IZH4Zw8qlOIt8OXUur4fPlExKM8OBQoHIYqtnbXmRcUpcFn/PhtjjS2MS4fgf9Wmc6q3JhXaA+kqSqk9DsQuTKOfsgPKIWFv+JvTRWsVta3SA+nY28qXEqWOoNNCw3+TVADVuXIH8JlDNyyk40ZFFgJ3gU84CGUssV1S4YGAVE8e+zr1l/JE+lrL83vp3rYyUywfFoklnag/nCFHf+W4FKx71eLb8AePHNw/U0mH50kN/cTKX4FoDAL7FwR/CmBKvOu5AkubJo2kT0gM963bvim8S1O8q63snsSDVC9jypmWt7oUD7+HwM+8bbgb1yOn4XBO5BfXsnMbvuGGgSDe7cZmat0qk2B0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6635d540-e9da-411e-f09d-08dc9ce8da81
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 11:51:49.3354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dIkPvKewbay5u6sGmdcFgwKMaIexjvDK6j8pfeFHYQoSqgwEZE6uKFHK7J8LnvQUU5sWzo/xLW5h9BefxKBJ4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8080
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_08,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050088
X-Proofpoint-GUID: Li81OcNydv_oArUG7hLNYS9snBLLb-C2
X-Proofpoint-ORIG-GUID: Li81OcNydv_oArUG7hLNYS9snBLLb-C2

The block queue limits validation does this for us now.

The loop_configure() -> WARN_ON_ONCE() call is dropped, as an invalid
block size would trigger this now. We don't want userspace to be able to
directly trigger WARNs.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/block/loop.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1580327dbc1e..736467dc3ca7 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1061,12 +1061,6 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 		goto out_unlock;
 	}
 
-	if (config->block_size) {
-		error = blk_validate_block_size(config->block_size);
-		if (error)
-			goto out_unlock;
-	}
-
 	error = loop_set_status_from_info(lo, &config->info);
 	if (error)
 		goto out_unlock;
@@ -1098,7 +1092,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	mapping_set_gfp_mask(mapping, lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
 
 	error = loop_reconfigure_limits(lo, config->block_size);
-	if (WARN_ON_ONCE(error))
+	if (error)
 		goto out_unlock;
 
 	loop_update_dio(lo);
@@ -1470,10 +1464,6 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 	if (lo->lo_state != Lo_bound)
 		return -ENXIO;
 
-	err = blk_validate_block_size(arg);
-	if (err)
-		return err;
-
 	if (lo->lo_queue->limits.logical_block_size == arg)
 		return 0;
 
-- 
2.31.1

