Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469372CA9
	for <linux-block@vger.kernel.org>; Wed, 29 Jan 2025 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738167354; cv=fail; b=imKwJfu7zzPHRaNlubgjJWGxk68WxBDgFvmfG/mWYg1DMdON96WbKOQrFfxEEfOY+3+1voaLpCG6ehlUEnE1EV63vzIlMrfMHFrBpE7PlXbo75l78ELWh38XdCtJoOWAoVUbr8sb94VnMReUrw+orq8G0KqTUY6tpP7dTxItDNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738167354; c=relaxed/simple;
	bh=cdF8wEI1k96z9ybgv3n6Ji3K1Jkans6SsLqUX7YBGsw=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=Qb/HLMGOqzGEfkcNVCuHueQn4ORJN5iOHcW0jiwlMH8Zc0bdJQBia4g1jH/B2ufriQEstFjZQwcBV6RBOSdySjRyLhlELAwe1VCJ8+xy0TiyadPfn5FrPLJB5HOrfHKuUQayXB/bbQc3yNTYcbZj7sY1RCm9jyfUVsTwIuah0Qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AYYno6hW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eR0Z+aRX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AYYno6hW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eR0Z+aRX"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TFilCH030358;
	Wed, 29 Jan 2025 16:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=bi7d7nT0dhBsNcds5y
	lX9Zd45/aewUjRTOL8bcgI8Z8=; b=AYYno6hWAmIBufGf1voLMXsPSORu3RLkjt
	3hWr3lCEzHM3agpX/3pN4/I/NYJy/zBi8KHgqmEUvMsoCK6RjWS1sjfPTK3zHgjQ
	H/uEltUeEanGX05lQpHYHPg2mwj8zZMcsPZ1PQb8B8+b78O1Tx6ukszYBG4GBIUI
	MdgPv8P9ujWnXYCf3iKCj0+BEDVDVXugsSDiGBeH9MzggiWj4QPOGVl+Yn/9MSRw
	JweYoyh0CbxiNXBuDIbX4Or4EF8k527dUq4NMVWhnz7LemBKoeRPXcSPKGhfvFsM
	VcwXPQEwEHWHOT68rGv6gQQvsvJEYnmpaoPqVZO5TCe/1xXj8Tqw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fmut8ex3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 16:15:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50TFSOG5011665;
	Wed, 29 Jan 2025 16:15:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd9nmkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 16:15:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpXhMnOT6EjpOdqMvPNEEF/Vjjvev94lqvfTS9tFGOWyX7LjiCfsGXFYw41+Aiqzy2JeQVaxE79mqq+isRNWzS2sqlDFgHpf9kncgtdedVgeT5B5CNcyrrMItfZKrUOVVsnK48aUcJCMOOlv74qih0Ov+zZfeNyt6Yf0S1VRO8EcU31ZhXwMp+Yu7q3aRFPKgDG3/gy9eshf0VXjQt8ziJORGc0c+gsqxM/wz52GLTg3E41BpIPbjtWMWfOaf6ZutRxJ0xdPSaJtLuR66W4ghJEJUY/htNuuCPPcx4MsOp09g2Mw0BMTZqLRqEwFQNWW+YTFo6YPLB+YSwjUXflYAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bi7d7nT0dhBsNcds5ylX9Zd45/aewUjRTOL8bcgI8Z8=;
 b=TFAE0KT6doBVT0bSGJ3yg8iqpHwI+GLg/SLRvAe70sazuwbIfHisXD4kbECWL8YESmCuiGDNwU3WNTicp1pp2tENL1urluEQzMzGL/4/fONlnDBDaA3fsJ0oJQrX+Ynj8BSuH1wNE3bpw0v+Rvlgc4Q21ksr9pFZx1bVmhxQOR9J9BnV0n9xNEBH/mBScT2+4BQY656zWqYXkg4eg/bgfFqMHHFRksbhC1souIDvguGuFmMG/I0zlyTdr5fZlI6w/QoY2O7owZdQmxlCmhgUi5slsdYYE8R+x0xMLAYWYILaIEUv1UDBpw5Fwyt0OEp0UeSniBgNEAovexlIHwrNsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bi7d7nT0dhBsNcds5ylX9Zd45/aewUjRTOL8bcgI8Z8=;
 b=eR0Z+aRXSWp6A4dFPN60h02TLWMPew4wC/huQ83REHaEi5Amp7DOgl2NtEEBE67GeWyrsE9soTWb71IqnlaiqfMpU02HwKHo02zsqIvF8xnTrtcsKr8TvSxq89z5mcfiqo8+eG5NcR6pbPrcTM98qiyHMtoJDZj1J+/7EMOmM8A=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by PH7PR10MB6284.namprd10.prod.outlook.com (2603:10b6:510:1aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Wed, 29 Jan
 2025 16:15:38 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%4]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 16:15:38 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kanchan Joshi
 <joshi.k@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, Keith Busch
 <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: in-kernel verification of user PI?
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250129154315.GB7369@lst.de> (Christoph Hellwig's message of
	"Wed, 29 Jan 2025 16:43:15 +0100")
Organization: Oracle Corporation
Message-ID: <yq1jzadr5a6.fsf@ca-mkp.ca.oracle.com>
References: <20250129124648.GA24891@lst.de>
	<yq15xlxsqkg.fsf@ca-mkp.ca.oracle.com> <20250129152612.GA5356@lst.de>
	<yq1tt9hr62s.fsf@ca-mkp.ca.oracle.com> <20250129154315.GB7369@lst.de>
Date: Wed, 29 Jan 2025 11:15:35 -0500
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0118.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::33) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|PH7PR10MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: fae9f2ff-c08c-4b56-7c91-08dd40802b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mT+4Fd6yKTB5Fk0RgFF8h3yOR9JmzCadhozxB7ZuR567vhxN4AHCGZUcDIKL?=
 =?us-ascii?Q?e/wcKLPfpfKUYOWtYtcFBINQzOsNscJiw2fMGB4e7O5PZOWt3RJ/aDVd7xFc?=
 =?us-ascii?Q?qIrR6KzsPmnVg6FMRVhOeMWEdZlTRsjUcYoolz3mJ4VnmGB9iRizf1WE34HR?=
 =?us-ascii?Q?UOA+DnOo51RRmwq1tApWlFDEWYL8B/lVDGm4MAVh3l5m037qDwgNUKGKN8Tb?=
 =?us-ascii?Q?arKCEyi5R9F65JKa3+aeKC/6zpH6J1p/8vsG/r4ZkumjRq0l0IVKLdh8S3Rj?=
 =?us-ascii?Q?0CNbaK51b0IyQZbqYyZbXjX3lnjgFNqeOIiogjCS1muHe2I3juOkyxAxHx1f?=
 =?us-ascii?Q?MHskWPnhgoX7ob1fN+UFiWUFrjU4WlDMNoTgMwxhrWsMtILz5RoZZPKBrHr3?=
 =?us-ascii?Q?8KWjEfIjY92QehGSKxjagJqlLJax9O3NZ1C/u6Yebq/RnzJCWKCpxD57G9f1?=
 =?us-ascii?Q?Ju05Ldy+bibjqObGZ4B+WGOXMt0+B9PP8GhcVe2nlQCa/jsSO4PH/CWL+Cky?=
 =?us-ascii?Q?p2iAn/DL7jFM+BKsSzUzMt5y1IlO2fYabi9ISDbZAqff7nYoyr6QwnpIrLxf?=
 =?us-ascii?Q?9p1o4aj5Urma0wshysPiPaJSbWtvTsS8q0+R6fVX8uCDePyuIThHdEOvYDuM?=
 =?us-ascii?Q?WVgYako3MY82WKC+ctDHW92ZNG5xZbXvG5Cu/015h+I3kfNhIGhIM4vHlLgY?=
 =?us-ascii?Q?jFyttt8SAl0fsm8nssDl8igd8MpWoBEyY5rnsugk5itr5Xts9xJahjFrciNl?=
 =?us-ascii?Q?7WPrUhAVnMTbq/RKkSB9IpsWigJh3x/QucRwuB5sO3ioomisYFuHvq2oZ703?=
 =?us-ascii?Q?Q8eXbfizjaNTOTfLrs0kyQiZ8wgItYEq+rLgXXuyqUNJ0RLtWpwniSU4yyV6?=
 =?us-ascii?Q?PW7S5rgq+H+qf4m3oWYvPK9UMFSAEf7qzWxRMLCvf8frNpSAFe6J3TEsJr3k?=
 =?us-ascii?Q?5fv3l9m+lzXzm54JyasCv09mgLfCZk4bIVd3m0FOlBLMq4d8Hn+eMxxOFKNY?=
 =?us-ascii?Q?Ri1zwUQxdRMjRcxoUVJXP9HGrKluZ6S7NO64SPcaZVX0vxOFWrnamtKYgyZY?=
 =?us-ascii?Q?7F/T2C1oWFFhJwV1qB5tzikrl+9cSFrljI3O6U7Jx8pch1m0v69S2r339Utq?=
 =?us-ascii?Q?mWd+cY2T1vrBQ2naCngF7YrdCMbAp1hropR+FtDYn1moZIGNutzqxzHm6I7s?=
 =?us-ascii?Q?I9hpnudXsTk8B8LW7LPybXH1VwA/RO25n2o8KyLRODUnPHTrhmQJP8ji3rJR?=
 =?us-ascii?Q?yn6NzGbn996dbatRSr4j+yIbqYOjjs6vgGXXcWvVK+GN1i1taQTAOd74bGpk?=
 =?us-ascii?Q?QKIK0/m2F5qvAOAUWqjIn1hAZ9+ad73wMBBpMug7llr7SbcyZ83es1cG2IfR?=
 =?us-ascii?Q?dcXyipBH0Dy94dYNDENPJNZBTDQw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vsJ3DxNKgADtFWUth7bLeF3ztwgcaKtkbm/Lufje+6DjUK8pGFzLSRzMdC7e?=
 =?us-ascii?Q?EWsRtTvojWLu8S2Y3I37uBfbtnq6S7RRA4KZaySiK4bfd/WaLuxzlLA3DWvl?=
 =?us-ascii?Q?3n5UeXYiv03XAi/vXZGKsEyWxQgh5Q6UrUcWHwNCjI6/WM6/8Cg50WUfwsK9?=
 =?us-ascii?Q?EMoZBz9RUqGE7RFCjC04/oS5yVy/axTc3DUrAOycTL92INHG4MBkQyNu3Sl4?=
 =?us-ascii?Q?8/cfRg3+VQ3A1IvPFWCUIhTGZ5r1RWlJuWDckBm1da0xB3Y1bnHDCRuGzuLn?=
 =?us-ascii?Q?3l1PrP8mNy2/sr1L6fkktJ1l0j7YZ9xJv3KYeSQGKDoCxMQPc1+zukl/VGbB?=
 =?us-ascii?Q?hmq5q6pfhTOlkclN2fiKQTuOdPs2cHt98yhzlXIU6FF62vg9qBPubWXsjaDa?=
 =?us-ascii?Q?733R3l1xAgu/MCYfNY5G3k+iuhEFVtOKNc2pQ9quA9ySgjRyxIYK/Tcstbtw?=
 =?us-ascii?Q?zWvQmmArdh+OhofPVKu6/JGnzd2aONbgbxFjwdBivQxT0GxDohrSU9rGxuNo?=
 =?us-ascii?Q?pks8SObZIFVmyqkt/6WzjvpQzCOyqEOHU2aqVtwpSp/6lbHPCZl6S1RByCr1?=
 =?us-ascii?Q?9PqcgoFOmz7srMI2jhjK1NUM4DzjagEiPka7XNfSRIdeLYZHjJUCgpsuMkKg?=
 =?us-ascii?Q?M5l4e2k68T2pSQ2f2CKfnkmQxE7lDmB5tuKf4AuGd45CxOCMR5LFiSkue246?=
 =?us-ascii?Q?4d/aiEi1WwjqLcBJPUH7p+CGnsHQ+TZbuXC2H4cAyeH5+iAVNcswZY5URs0/?=
 =?us-ascii?Q?HKaNjDHK+DKW1sfftOOAKAgGmbCrFgNLqQLrGserqHylNsVb69cITSAocyFe?=
 =?us-ascii?Q?o7rTBmyTzpYhVU5Xm4t4h3miieFOZCEYVuRGW1imaarlcm1XXr7HV2ZDRuO/?=
 =?us-ascii?Q?AevodG7JxOpaFstgk9PlZqqmg8BgRTaV9Jd4l5xo32L3FDee4J1D+AJCSF+/?=
 =?us-ascii?Q?QK/Szd8H0VqMxswVCjKKWrf3tWLLAN4pfOBSydjgVKuNHasShWDWwkitMqpi?=
 =?us-ascii?Q?Z+eJVpj7KX30lsZ37PpTWo3MP3LDg/+YVR0Ki8NqDDqdY39NqU5WbwbC7xrS?=
 =?us-ascii?Q?/Ov0ohMiIii7oZUJmw++i36P/wutIBUYJ2kSqaRmNHqwVEZGjOaDgwIshAJp?=
 =?us-ascii?Q?ch4C6KmIWWrwzk+RdrCQTTIGNwLBQfZQXrzcsBy2n/v1Bgr6zJKcg2FkaGIF?=
 =?us-ascii?Q?KofDgcvghGB5GHgBks16FV9QZBoEgnrYwxpFmLdxq9udWLGK3X2qgKJayukV?=
 =?us-ascii?Q?S1oBIYUuMf52zoWnUMIWUwplc9JVY/6x+1LMw+e8Fd+sRcg5HyrGlLJmMmLM?=
 =?us-ascii?Q?ucxzoVdhbcVPKkAN4nFujs1kVVV/97+zF56LIcOxg29G+aikXV6H7y8uU3ak?=
 =?us-ascii?Q?CSz8tDd4YfNTLOmeykBkN8xo/Et82yTonbEBPnTGuYCGj+5F1DkAXFMisTtV?=
 =?us-ascii?Q?pX/h354tWXRFd2RCM40CqlwWRUl11R1wDMbw4mmKhF4qpPZNXswe3AdHrrup?=
 =?us-ascii?Q?IuW2Q1rh7edklIKr0xcT548ruqcPExBsdY1x2Y97wIxvEd2RP0hYQSUwEEog?=
 =?us-ascii?Q?gabTNCHAg6yHLQbwRsEWnr8Lx9Gkde+OQP7nhzjaQSt95OnJ7uKi4/aT2Ffc?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MZXcFBjM4aqWCKREMsaqDwyJmkJFa7CAL8rc2R/CFRZBiI6ezPeqhhleqz8Hzi/o25rb319pTPGH+rAAz2XE3U8Yf2+gN1nuvVaN3m6XuhhKhylq8G6ifBvipOV9Ze8kTxjmN2P/sHHRdwzDd3uUnWedNrpgzgsL6uWv6rXqnSOjOt/P+fghaYZRfdeV2pwZf019SRTtG9ZnyLbfFY1axQ/Kt/op9jGHhVsohCjzuFM4csrgbAzMv03xIHOnLlXpLjmPrLhpCoLea9D/qAXgrGuKLtd5ptPbcl30oo5trwui2bVTQ5PWulmKCUrJ1uYoz9LU0dTK0WTIFsED8InWIbnTmj1x8XY8vV860T6LyHT6tk7fUiP0ReyUdBZDnn8DAdryp7Z+XDNcqf8E5g3q9cwZhSX7AZBKeBNzeC4CdL63t2Pd3cHQNE2jkeUo3acGZnNPEjpgDyF1uOCOT4UKBFAyulhBbmyRdVvkNOgIJhCtyZZjZA0KeG/4hc2k+iChFjH0kmdopKCrpI6QOw0pXmRM3g5mFTMv/JfomaMHpFGr7kOhw87ZYCPGUc3yPm5SVjVi5NJPDO7IKeSBjVsP8LvU138tyCJDc3F4F+LwKME=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae9f2ff-c08c-4b56-7c91-08dd40802b1d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 16:15:38.2065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: McX8qtiYZomvYaVttbn06cz7PqUlIEgziXdHCnykWbDDvv7CKP8pPfjt9ifRX2NglvljTdJ57cH42UIa5XuBJYkwi9NcGTjnHyxXTIXct64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6284
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_03,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290130
X-Proofpoint-GUID: QbA4cd3G-JnGQ37uUVKJezpm81u4DP-s
X-Proofpoint-ORIG-GUID: QbA4cd3G-JnGQ37uUVKJezpm81u4DP-s


Christoph,

>> It fell by the wayside for various reasons. I would love to revive it,
>> all it did was skip the remapping step if a flag was set in the profile.
>
> How much remapping could the hardware do?  Would this also work for
> remapping a inode-relative ref tag?  Do we need to bring it into NVMe?

One of the reasons it lost momentum was that NVMe didn't do it for
ILBRT/EILBRT. Although of course NVMe doesn't really have an
intermediate HBA entity like SCSI. For SCSI it was natural for the HBA
to convert between what the host sees and what the disk sees, RAID
controllers do it all the time. NVMe didn't pick up that wrinkle.

With DIX1.1, you tell the HBA what to expect the first received ref tag
to be. That could be the application's file offset or whatever you want.
It's just the seed value chosen by the application when the PI was
generated. That's passed down the stack along with the PI buffer itself.

And then the controller ASIC uses that seed value to program the
register for validating the ref tags as it DMAs from host memory. On the
outbound side it uses a different value to seed the ref tag generation
register when sending the PI on to the drive. I.e. LBA for Type 1.

It's really just a matter of the device having separate, programmable
registers for ref tag verification and generation.

So in terms of NVMe, it's like having ILBRT and EILBRT specified at the
same time. The drive should use EILBRT for validating the ref tag in the
PI received from host and then use a separate ILBRT as the initial value
for the ref tag when writing the PI to media.

On reads it works the same way. The controller validates that the ref
tag read from media matches the LBA. And then uses the separate register
to generate a new ref tag initialized with the seed value requested by
the application.

Not sure if we'd have room for both an EILBRT and an ILBRT in the same
command? Sounds like it would be difficult, especially with the larger
ref tags in NVMe. But I'm happy to pursue in NVMe if there is interest.
Because it did make a performance difference not having to touch the PI
buffer in the I/O path.

-- 
Martin K. Petersen	Oracle Linux Engineering
