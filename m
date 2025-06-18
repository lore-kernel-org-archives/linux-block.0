Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953EE3A1DB
	for <linux-block@vger.kernel.org>; Wed, 18 Jun 2025 01:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750210710; cv=fail; b=FZPQXLhM4Q8r2ObnMKp3rXoBc8dmsVe+ASiTI/1a+XCOLj9HwIEd/BdzGWwAbjzV3KXXqABHn8Oe9skJ45clOfRKGG9y/QSw8eMAptUZj8XwJUwRbRagepH81F1eI9JnIxEs0UhDJOJF2FEbFXgawJhii9NLJcRFitH6ABmlVJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750210710; c=relaxed/simple;
	bh=ujM2jmSlZ7kKoJdATC62Pb1MgbA9Wmh8t0XxNx0/MTM=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=JPEfa9UumXz0oDLNaokyXTcuDoG2ZTvYfWfCT4RDTDUGjgKQb90QsrEoElQf4zLXIAYk5en6KJKAkFogjYBxgnhrAyXPb1hLGEq2jhPkfqghNJI612OwHxqMZE5XAl1REMmt7W7RSP/cVc5BR/LSR7nNR3Dz44mDik5rYZ6Lmwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HhKjsK7u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qm+bqVQm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HhKjsK7u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qm+bqVQm"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HHtcQb001273;
	Wed, 18 Jun 2025 01:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=aWzINpHLmpCfxLaWil
	NkXKCELX/TWl5Trn6c0uXnmjg=; b=HhKjsK7uyAzlaYLzMsI6NRAlFwpp/yKg9w
	wAybkWnbCKZraLGb7nXvcNGWKwfL3nBIUKEGdteYNuBoWsyFlV/oHQajyzwWKiMT
	TYe0owhxGwYo8thfcTpGmmofq4kgkYkBMXMAIGpYY0nUwKbHzvbO0j0bR6xcdphi
	VGx2tFQAF9r/G+ZbxLQL9QOc5PyKzq/i68nmZwnnwoOOkehVmXeQhtcLFcbsOuNr
	Blw2QxhfoPBctQO8xS2szZ8sAk38t8APTc/VpR4xsSwfdDkZh4uZg1VwPJTN8EZR
	QW2EpcrlXVD4tnzTFcWZRW0kFFzBCHswqLAAFcu1hWrdYysY/Cog==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4790yd6rxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 01:38:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55I1Fdeu032037;
	Wed, 18 Jun 2025 01:38:20 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yha171r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 01:38:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTSnVzkBF64MmlPDJQXk4LTg+XlE/tf6nOE8A2OyVmzYV8nWolIKRdGXxc8A+/jzhwfkvZtAsOdbUnS6CkozupkTym+vJUyLAs008jWugRUkle2K5maZ3U7dNTPwd8WwYOI+NU5FXTJTsoLiKubEiRjOcWK/1M9YCxrPZrkz9c3twvIp+CTvq/unmAH7UtQBfcIniCNvjpQ4fxyI0n5dWh5SwmdbkV/I1AFEqMIb1JlNGF3cD8IdLPVqlEMgfyrqcW5PoyjEuBo7HuYTxbgv0FCIq/nbLQRGRB/XRkFexGoCoRLpthYtGTiIbSEwUU7c1agmHoXKNhgldGUhEBOtAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWzINpHLmpCfxLaWilNkXKCELX/TWl5Trn6c0uXnmjg=;
 b=fkvizKbrikePYQ/w+cI7Ia/KYrP58duUHbfvavJXKbLDZnGSagwR0C9aPaGYTysu6ja6Fg7J5q1TkhtUXUL/eCypA2/Q2xKEujd/0CB+dS5M5Wsy4jJqMNGDnTvWNhCM2rIqSSQNsn7XkeM57ckQXHc93nJ5EOKLhw2YafTdfYN6mfY4Q3banHLR0iHob2zQqHRGuueFbkPVrJ+39O48YIwxN2GssxiP28O8OQ7kYbu0irpySRoHDFyUa5bBGZOgqAVB99KNu0GQnmkPN7dOVyXSfjQqUhoSrfkXof8Cdp9QH0NcYaPVBuRkMvUfD3p+0U+yj6sK1n1jzyei+eu6hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWzINpHLmpCfxLaWilNkXKCELX/TWl5Trn6c0uXnmjg=;
 b=Qm+bqVQmQ/g+olCp5tpSjKalroaZmNbPISGnXs6a3Fv4y8E7MSeryHAiBxStdZSFVMdsFEoKkxzVcXchIM2YrL0y4FBs270i2g5I644QprG4o4J9kZRbckE3NYMSSoA2DqrLVnYj44Sb/N+/kLdI8bqoACHJ6aZZ5N3IFSDv2Hg=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by CH4PR10MB8172.namprd10.prod.outlook.com (2603:10b6:610:239::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 01:37:50 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%7]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 01:37:50 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph
 Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block: Increase BLK_DEF_MAX_SECTORS_CAP
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250617063430.668899-1-dlemoal@kernel.org> (Damien Le Moal's
	message of "Tue, 17 Jun 2025 15:34:30 +0900")
Organization: Oracle Corporation
Message-ID: <yq1sejxx21u.fsf@ca-mkp.ca.oracle.com>
References: <20250617063430.668899-1-dlemoal@kernel.org>
Date: Tue, 17 Jun 2025 21:37:48 -0400
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0375.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::20) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|CH4PR10MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: 227a30a3-2a9a-473d-3baf-08ddae08bc6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6aROPprU+M7plDwk/E8T4gDW6K+ljqfMJKYM9v3X06xpsL4SEkvEEdI8Kkm5?=
 =?us-ascii?Q?YeM43iYqGzZ2GMVqfeAnHaBy5qx/NBuEbuTv9V5ztgV+vbLhze/sNJYsDrg6?=
 =?us-ascii?Q?UC2UiYJnKsfuRlhimfOm5hyMipfMSLmrj2r1bdR2WHWNvlQCkqE5PNpji3Oa?=
 =?us-ascii?Q?+Ds/66UWpt8MRNbSBYs7dEiPfmPwoCPnFosAexOQkLch4sQKHiTXxzH9kUas?=
 =?us-ascii?Q?3Ro+rv8YDv8p8UJxSNY4D4uuZxiWLwCFg3YzvhOYf7ZVk42jfaxTdoXKdhQr?=
 =?us-ascii?Q?c/xdm3zA3g+nDAKll+DzucXtACd0XXi1E3ZQ5SyFICAKdyO72wBciSjkM4KJ?=
 =?us-ascii?Q?c1Hey4ytnlLTbAJr27Kz/ivdNDEfQR4TWtk9vTomjsztprw+D2bOIR7qvP55?=
 =?us-ascii?Q?s9vZDpdEU3nR2dcdw+j1QZLR6zxiPQWA8Ms1aqgcc8Gm6q0c6fZFnf7+aLH9?=
 =?us-ascii?Q?8/BJjfVSLpQ95Dvjl7F5b1UWVWItjuuiqPsWHQvrXItPKF0g/xFExnz161Xi?=
 =?us-ascii?Q?GGXEkHEXHag1p/NCHBYLAx1fW30OWU2sGAbewZ3CpQzGRLYDmEMsaHe6E3wx?=
 =?us-ascii?Q?ejtCjz3MmlrOq7mH9Osok72hUbw5Qlz6NQqXPBRk8SruMNKncul7aQUJJmOL?=
 =?us-ascii?Q?FpByzyPVqQ34Ov6+0brJqQ7/yVpETd3Y+DrHc/2w9Cn+769qgoiylj5Fr1we?=
 =?us-ascii?Q?8iymByMn4shHFsNnjlrb/1XQfKIf6/H8sampqG/7bHdQgfbe8XzTLTTqe6Ap?=
 =?us-ascii?Q?YTYMoWfa24Ci131VpRfAWODRP4D3s9bJUZcbdRtreKmhi/R7/NA3upHr6lHw?=
 =?us-ascii?Q?pL8b6ZoXA/onpH+cr49QXq/W2cqmBrFq8STgfT3xeu+5rafec4afyNu9Lgfi?=
 =?us-ascii?Q?HDJRsEZtVukfzCXeH/Vje3AMFATknS10osKTF0XTVlZuOVOm32QQjRzKUbbe?=
 =?us-ascii?Q?78lJCl7uz4nkDBr9qxFlQxcIWEGl71CwMvt/KaYNam+BE+KOHrYXgPu6h213?=
 =?us-ascii?Q?wYuDteZiWbXypXadFljWIx4mzUpsrEmO2eew1N4p2TeQi13UBUQ7+YpnD5Pd?=
 =?us-ascii?Q?e+wecvIkslPUX7GxobcdZVaUHtHdKLy5ToxDpRfto2ScuQyqrifwVoxXSBEZ?=
 =?us-ascii?Q?LUho2iM09BvkvGc0VXP9f3vVQYacL6FE02w+bAfOXZBufPSSkaiZg/HfTU3/?=
 =?us-ascii?Q?Io7diWiwSncYL0nebr+nJ0lMp66XrqO0I2d/grY3es14amiD/Hf03X1a2SIx?=
 =?us-ascii?Q?8yzwUUYCrK04DttfwoeCtr3+6odju63w/gKNaelIzClrW+MArKbDprCHlSl0?=
 =?us-ascii?Q?BvnPefueXF26cvpJ/LXw9rzlxufA3D0JGwe/QnJvwH+nfH3Xu4MBUkp5oTGn?=
 =?us-ascii?Q?R2rfcnaVuB5GjQ8O8v/l6FrUEnaFAay/bNTta1qsrZvjrZiR4rdKKFlSxSY3?=
 =?us-ascii?Q?2J4I7vQGTgc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jzISft2rDlGEHA9xIjoVCWhMTPpZnNjWtae+2L5n3Oz7eTw+9VMXw6hx+AUQ?=
 =?us-ascii?Q?/JKk1IQJYAhHSQWJrHzZ0J/AHGN7hAPs9/9BDOfToGW802edFk7IffxzqmLo?=
 =?us-ascii?Q?flvDBMdMq1tvgSZp4kkBEVFGsnb1Hb3HJwW8zYlnM3dncIY9n9koDKdI8A+R?=
 =?us-ascii?Q?CTdzc+P3bvaEs+TinSsmITxAKY9UfLaTp2w2ivXYvsubbAk5ukPQTKGPN6YN?=
 =?us-ascii?Q?mmaAHOP581LkD0Ls/X1znLgffQFgdSWhAR4p7MeK+LpelK0r6VYXzbXL6BuZ?=
 =?us-ascii?Q?933/+iKI0HiQTEeoR3z6rZe/7khRYpNXxMhM4NNSgS2Q8NTcHVUc4OVnA0qT?=
 =?us-ascii?Q?wt6wdr8Pqgm2E14jnhNcKXDsgZ847J07el85OmoPz7jtby99Z08Cg01n56/6?=
 =?us-ascii?Q?boYNXHASusA3ZcTTzZWKZ1DRMFeF+h07l08QImVyHFHJGZkyoH/ihrE6mt2H?=
 =?us-ascii?Q?tWCD2NnFqt7RuvdB4PHw7LxYSrXWoJeoRAg7QOMfzc+QUFCJ29+6FLvVyWk/?=
 =?us-ascii?Q?Z05sUTHZ7LVRL1aOBLGYGS/fDfKDjw5pCUcIiFj4PFfpwgtKSI6Lu/KQe1TE?=
 =?us-ascii?Q?iqiP5xRgJWo2bhn9zmcNFIEaTFpTV5oKS/CkiEz39l8GFmNkfPxOpJJupmSv?=
 =?us-ascii?Q?16yrWsIVacUnj3zHbMEsp1u21GpuN+az5zMP1hxGGjXqLfx9bZ2BLMMuiR8b?=
 =?us-ascii?Q?u61geRvYxecGrhLmem/Zh8Uezss/mF/CpRc4dh399zmvb3w/Si/L0LNbSSoI?=
 =?us-ascii?Q?2Bw+lV84PWypZGJdH0cwRWw4LG7aRBHgVd5XZ4vyznv/0ix3bpIqnyp57HQZ?=
 =?us-ascii?Q?GPDVqQ2FCbHQUhF+VQmAXC+PeG4+nIYY81GnqaWm1K38olH/JPHlYnqiPKJd?=
 =?us-ascii?Q?87GelL3/HYqwzjKDee54yDifnrakI1Je5llZAjrYENFPX3i1Vcn9BZOILmvn?=
 =?us-ascii?Q?L4Ta55zjRqC0vb10q45ZjrNSQ4loJmlK696H4WOs6ACO0/sFl4x6bM7afehn?=
 =?us-ascii?Q?Ul2MTLR3Ocs23ZjJFPotDwT2+vwgngKPL54KJai3fUHdUXYH4wFZ9X1KGWf0?=
 =?us-ascii?Q?bNbc/LfaB+ekLLVDd18x21EBpL5qBtt8zGH8X7a2xy9YvCWBq0PGsfC86TNd?=
 =?us-ascii?Q?7vxHutXiLD2Q/nVYicD/t2ma6bm0ij6SdgLmx+a6A367YiMtVIl4zScr7Qn/?=
 =?us-ascii?Q?6jbel5/PdtavzvCri4X/3Rps7WlUCyf5Ajut2nHLacF3E/92pz/HlCdXkEqb?=
 =?us-ascii?Q?csyeH/8tYukmLqDNfiknfkkel24bzJ6G1Tm1YQ35RtbNVZwBH8hBckd7k0GD?=
 =?us-ascii?Q?tCpb+Ky3LDTFuUilP6nPQFSwSSHkC0a3wnnnhKHeKu1ymnN8UB/BnCy/S7z+?=
 =?us-ascii?Q?t13bE4+9cktKgnP/bHRH6nMlLh48gyLuCf+tOL55UJLMnuM7qLRwFZ2Z69/e?=
 =?us-ascii?Q?+yyWWEtjojpqYQB+2fO/ih1+hqSVdDJqnzmtsUV3xV3G+Q8HHM7ZxkpTpT7A?=
 =?us-ascii?Q?48okFXuYNJS6+EXoRgcvODIyth2H5adsKCbxQOy7aRsEeSjfR5BVX2qaQohZ?=
 =?us-ascii?Q?nlhf664MXQ591+Hr8TJQ3x8me7x3rRlKw09I68hodd4tHCIyVFsbgXsjJ39O?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1cMnGugiO3iccABr3LI86JCAU37GcNCzueHot2sn9sjBfIG8DYiscVFYiTotEoEltC959VrWunWT3QQIxv0vtIvXVtAY226Mx7LCBBVsE8jJ9LT4PbndO0LlPg3mfKu8frIEeNtQmk2j/j6zpDZs/mCSPfNGiaeUgP3kcm/5bKybj1Pi7JEM5PKy5/lmI8eL/feZad3be5w5wVck4jIoslTE5ZIXTzvLqgcX4Lmeptu61ppChUddqTUTYQnQgRpMcpUTzdc1tmNRx8JtjnkI+w8Pg6dhOklmdQlKBEswrTmbk208MTZpUT4eTHdmKOdqD/zA3lXDCZ+QJz0iTPVP66uOKb30LwXecGjPpSC2wG3o+omfFFi/sK5sY1q6kuIZ+rrK+XDjOMUxnNgVNpBHy7pvjPZO6bALRkole8UzNhSRLW26GkV1+VOAX90mnorRvlWoXZujcziUKvNbALkmJQffEs21WUaZp6ygnnisTe22kkfjqHiScZu3huwI5b3SaWA3u6oPrRghNc69ZIHcTsjrTraxU4UMMqvubCfLv4Qhm7/CjeDaGBsSKdjEXSkRfFbfu/h4cmXKeRKoNcYXtuKrZ9RlN6nlvckp5qxNnWQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 227a30a3-2a9a-473d-3baf-08ddae08bc6f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 01:37:50.5074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9cgnuA5yX9LVLy/IEXIu5LYF1LAL+ZBQ1IfpiAdHilgwaWQJQyPCgUzt2qddcIFliHkgjqek/JZM5IgCEOI6G/8XGZi0Hptdf5q/gtPlXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8172
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506180012
X-Proofpoint-GUID: ydVIqQOUXEc0m-OHRsBmSCfI541BfXzZ
X-Proofpoint-ORIG-GUID: ydVIqQOUXEc0m-OHRsBmSCfI541BfXzZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDAxMiBTYWx0ZWRfX6iadtwPhMvpy dTdHsqb+frWIqD/x2SR8mniX33GU57HUYw+ucLuKi0SQaLSYxU5mkFAgq7F957g03Mxp574+bUW KE3btQhNQkX4rb5H+CKyGilMc72HTMQ4DoAYfK0TRh2e6mrrw6k3xponG84SucMZKUSpiPnifbe
 pCV88xBJrenXww/54V/+liBcFXkfvb5UJn9YMx9s9OUL6auRCd2X6wdHAYl3wk7omFivsDRj0aB z9gL0oX1Bgm6J/NVejfMBwyNDwtc1zxdH7i/M0ubkzDzBurz8kfG+jjxDSDQWGgJuWTDU8WurFo mR+MpWa+/XxSxW4Tb7+lw7aCkzX51f1FvB/xYOJQJDRPXwAg2DL0p8/OGhs4jfNZwdBty4dAQcp
 VzsWKHkdNleiVGBybeahwLxbpp0FcEq01qFxahkEtTAQMSbmEC6/U71faNloOPej27mewpBw
X-Authority-Analysis: v=2.4 cv=XZGJzJ55 c=1 sm=1 tr=0 ts=6852188d b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=pEavPsdeSbWd5ouBnYUA:9 a=MTAcVbZMd_8A:10


Damien,

> Since many block devices can benefit from a larger value of
> BLK_DEF_MAX_SECTORS_CAP, and in particular HDDs, increase this value
> to be 4MiB, or 8192 sectors.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
