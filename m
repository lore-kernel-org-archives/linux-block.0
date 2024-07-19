Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D270574079
	for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 11:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721388617; cv=fail; b=fTnkfuVL6+3TwL8/vM60bowdZeAqMQ5X+MBEvwMKj9UGtNnqZc+gGh6eEyYrr98bx8xJIUfDz25xQ1yGhgX1BE9SMApiSb+0LPz5nflxiDejNvLuUkzus5QHVKgfs/FCNq/uKfxVxnZZThI9PHWqgV14qz+d8s6a78svHIme95c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721388617; c=relaxed/simple;
	bh=K3ELZfq1k9VPCUO5PxnAgk86tPIsuOgqu+m1X/51kps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HU95HZF9vfIWAT52KZ/TSbjvIU9M8i4mlAHXFjCmQwENcux5naEl6j0K7hRXAjgUUe9xgp49hG2rkpz3AV7Rzeagilaay3ItLJ8fHVtU/KwrzOHor3wjB+HuoqUdkya95VavNBYjxnwttDjBlZlqO3ckKEZ6rniCQFyaPNlyhiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=keaxAacb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BFGX754m; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="keaxAacb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BFGX754m"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JB0u2A030664;
	Fri, 19 Jul 2024 11:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=go+hd9hdpeBwL/YZqEbgNpPFHfmQzUmco/MYAkcf/GQ=; b=
	keaxAacbTUSUP6jfPLNPgMhATCEm9m5IF2UdS2bkLy4HWWPBYXAkQIu5Y2azdnLw
	c72eQF1hmFlJDSVD/PTbmaoPuMo11Un3tCSJ6Rpp9c37GU/e2bDpnoTtqk4K5+Lj
	Nei4KIqnCEVp2S/Ke+pUEWeMpwgxHW2An3jLDLQUwggLHcc9Y9Vx5HvoyKxSgV5q
	8Xe35//M9IQQcY+ZB2+YwgRG0WKizuiIjS6nCx1p3oR9wUNgRM65jOiJpwL7IQUh
	9aAY9gpy58hC5bLVihh3tN3BfqRAmhF6CGaETHU9ZscaH9KmWon0Hct6gc2SQ8vV
	gwPI+G9VuV/BE3/HRXugNA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40fpvx017j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:30:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46JB6ugp004532;
	Fri, 19 Jul 2024 11:30:05 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40dwf1mk65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:30:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jbc9EQE/qipfe64bSNaL20kn3ygwX/uNRpdGcfoPBM7lMDXFV3Lmxt4Qlwb41SiezYcP865r2PMhbFHlmHSlrcrt9BqUuJT1WlHEe9Kzi20fPBfp12PrWBbjSIbJq9Cho5nv9GbkORRK+KKUn9c4lGRHEGPZ6TOusL5+c2IkUO5E1srQOPMB17YlFAyugm7nbQRGqmmrhNN0OESvHABSkfS2Y6ihS+KfU5/mKZhGJDESG+MU/YGOrLF/5MSIpp1j3DKHx1Xoqasu2d4acw7XUj+gOmyTfcmjd3dBMrztn5840Q5RcrNGFn/t42fiVGvDiQyhLDJF0GJMFxXLsOnKNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=go+hd9hdpeBwL/YZqEbgNpPFHfmQzUmco/MYAkcf/GQ=;
 b=sjDzu5Jx/6TSht8hHV/yi6CDLGEyP2IfIy0Zw03IgQTXEWyTHhZF77l/IlnStM5j8SC14wRSyqelrh5ruGuisSsGqWCcHyIWN9LG8vuVeUTokk4pVlAJi1vUqAffxvQh+RSAunOVjBx2cEpmlSQvft1FPPfEIbu+DRe6Mv+DA6SPigaXsKPJJYyvrTh44LB5EkuxJRBJzDIcDRE0L4geDz6Vn0W0QbHHL8hpAk6RmWdcKA2/bBcSj1t1axWGSKyXVBkG66jx7vD3Jm11BjVE6FItsxj7HkvOFtiLIe5QCWPet7Kx1DZaicufvKRdoH+/setMtXYrrPvVGvopU4hUsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=go+hd9hdpeBwL/YZqEbgNpPFHfmQzUmco/MYAkcf/GQ=;
 b=BFGX754mfyw1dPtyMXmCPnUJ3H+vSo2XArZv+tb/TbQS7OVZKSxk0g+MDAXitM7GKNKzFZLPDqOpVQ68ySG7QkJ+vHXGQbEV62YgfrnMo4NDF/UvGST+r0qfPCK/8JIy2RJ5pFDyzU+eEpa3lXzYe7fAiYmtBDzw5TN9v++sW+s=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6537.namprd10.prod.outlook.com (2603:10b6:930:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.30; Fri, 19 Jul
 2024 11:30:03 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Fri, 19 Jul 2024
 11:30:03 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, bvanassche@acm.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 13/15] block: Use enum to define RQF_x bit indexes
Date: Fri, 19 Jul 2024 11:29:10 +0000
Message-Id: <20240719112912.3830443-14-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240719112912.3830443-1-john.g.garry@oracle.com>
References: <20240719112912.3830443-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:208:530::34) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: bdb8bbb4-6510-4bcd-9869-08dca7e621f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?UhNUWcZCCk3g8gzi18rzT6wwI1Z7y+cY0JdnuFfs2io35dQYB6n1KImvwAI7?=
 =?us-ascii?Q?QBu2hpWt7fDkZip9PvbtGZcGE7tRcN1BRYbb0jNhptBBl4fjDQjw7FHP4cku?=
 =?us-ascii?Q?YMgaFfOpxKYf10mVG3Q0dmOJW0wjHuTZg3NSiMOvGsDkVvtYDhlh1dpmh/qf?=
 =?us-ascii?Q?N7wKLOxoDZRYXn3mWh84tjTycPmJJPN3nbx8Qt+vy8C5pKr2YAjBDUJNbZJZ?=
 =?us-ascii?Q?D92G7XizT2dgOrm7fm+xFwAQRCvwmcxG6eqqaocwcUwxIZhGKKArdcEMEya6?=
 =?us-ascii?Q?ySdarJtzFdcFMFGn9gMPZ5GiQ8beYgLn6IjIYkhfZvAJPMpd4JlLeJbQfD7b?=
 =?us-ascii?Q?pO2F28mnmU50FzMMqxe5Fhhud7KCbkhYzXSR2hsLIq4PrbBA6QTB4rbzHpgT?=
 =?us-ascii?Q?h6QkNYYHlmcn9qH4jbbybSFIMFdLMpNGrM36x6G0bYjtBx3nE7YDQmAsc85T?=
 =?us-ascii?Q?/WvK4qpLG0SfDCGu6H5JyU2vXqGZkB42PEF4m03j+qdhzgJ0snp6lytBPLi7?=
 =?us-ascii?Q?/jqrgA3BJ6fT/uRgG/P3qEOWzQI2y11WJ+S9LQ2x1keOol2HEPk7VTnBlwh2?=
 =?us-ascii?Q?F8AdQff7vOqq+6uQgmTuTDiIm7rEyGxPgzaXe/tbDggmACVo1HHRu9czfBfx?=
 =?us-ascii?Q?Q3XW677YgvCicvGMYxjVrUzLUv7XqL64IjuGeCv6WKr14I0p9n2EimRiRpJL?=
 =?us-ascii?Q?bXmuPZN1vO/dqEUoapXgm1UMmHDat5x+KueCAlu0RxET5llBjO7yuETaF1cn?=
 =?us-ascii?Q?I9kitNhEP9vMWtv5gWE8enZ6m56SlA1qi1QYXW7vU8QF4FLR3iwQa3FqxoSY?=
 =?us-ascii?Q?uM8cokJuXPnfjMuE/L/gAOW0m0r/AwWEFk0W6Ro+DPImbReEW6CZnKe2176m?=
 =?us-ascii?Q?08iV4lJid3Xh79UMdaTygpB1IINh3IjsOTZXRa5lmC0In80sQV2FySRuVdz1?=
 =?us-ascii?Q?ibbZtbvioc1sb5ZyWZdOFozYETY8jI8njMlldsYnAgRdFZL7xS/4+SPzbawt?=
 =?us-ascii?Q?5fdesWXBM1Bj+VeOk6CCibYypNzFCxzjZbWgjP+4byc7cY0Sn0Yvga98b+FI?=
 =?us-ascii?Q?jn1LQmjzmMZNfsSBYDW9lGJi5g90fAWVC4e2BhmKN55b2g9uMX+mBy8U9fSb?=
 =?us-ascii?Q?gTeNwa5vAOhGLrxwj3yQ82NS9yZepN3Dm6rty2h1WZ4tDAC1TLi3tfKdviiQ?=
 =?us-ascii?Q?eHG1Z/C7Bq0m9PzerJ/xmm2MnZo6ek6nB5d4mSvVHHCVIbu8084Ml9zBTbTP?=
 =?us-ascii?Q?JfJpD8MwG+b5JClVb3+hbtHLBNLg2ExM8fSS2RL6oOqIU8Rg6gHYqw/GCrJV?=
 =?us-ascii?Q?2uSlvx7czdL4VxPxE2tCLCzm5D4f5CyWvoqTFCyKOn+HXA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/Mz0H9whxEWkvliPuHgXgZ7XDsz2kxofjFQchMFNuRHss5EeL6XeC1daAQVe?=
 =?us-ascii?Q?XgUwY0kDb67Xo9vjQN8RwhXDLO4qaSqvfFmXJXtbCNgpscl2kxZB+w0iyvN9?=
 =?us-ascii?Q?YqHOTqo8jMUAHJGXTwJp1cV2Xk37OPRHlVrVSR2qtxNYn5TuR6R/N7x8B9il?=
 =?us-ascii?Q?w3yf49R7BxX0WdMTeg2aOn3st+tKEmNsHDEQ7CVqNx6MWmMxTRNIfjS5AUpn?=
 =?us-ascii?Q?6cDNgIbpOb3ADQ2mz8pjRbAMF2wa0VPBKAskJ7ehxDQXXT+fijGijo1yX4t9?=
 =?us-ascii?Q?wQF1ZQJ1f7VS9N2bcpB7sDo+IgBtqu1NPLfC5Rtyqvc3tl7u3jzZZYeZzAoq?=
 =?us-ascii?Q?bSgUMRDDCe+NSLNa29wfna9/1bnfP+Itu17Ml3364kKqiLdoNLDA1ZTH/1bJ?=
 =?us-ascii?Q?SmGJTsWq/UTAPypJbbahD0hVBFQqOaYD8q7KV5tQz/LbUnP8wz8V3JrAs1tW?=
 =?us-ascii?Q?TEX4S2uH+Q8GQwdwjrvo1drBuKWMWHioH+KPGmfXGTnIJH40WCwDFNWvmZJX?=
 =?us-ascii?Q?/Qcd0/1OPyEbW4DKbca+4UCxAEYq2ICmc7EYZUPXFfmzNZxbjokgKsNysfKb?=
 =?us-ascii?Q?oj2EL7cNH6aLJj1QNTtKmpgIDtfYWf7z96qnoHMD3Cr6yVgGvM7DNq3ra5/M?=
 =?us-ascii?Q?bpeifSFwcv27L610h+0Ccql7NhNObwjIy7Y3pmi4aziv4ELdkpGYYSa0/RCM?=
 =?us-ascii?Q?X04OsE9+Pph53Il5nIMzz1Oim0wLIQr9J1L8Jxclt5OSar0VHnVQeZ9B42Ce?=
 =?us-ascii?Q?GZ02uOkR652g8zP0CG23HYv/hzX/KfhEWdSSbiQVuSod/d/YVHQfojg+1hTe?=
 =?us-ascii?Q?uyNB2/iYh3O6vG8n/qYnPEXJZuUXvcmwi6jD2dNFSWuq+d55BINqam6Nt3x5?=
 =?us-ascii?Q?/8IEmwSPaLN2Uo7+pmPdIZpbndGkrNI587b0ZVouSJKFD4zL+W3XhKQLMboh?=
 =?us-ascii?Q?nxYL48IR2hM3zqIYzq6L+cO21biAFse+xWAD4vp8rgqisDoHjxnLMzBq25Og?=
 =?us-ascii?Q?KTIUL7HQTXQpEqXvQuuruFsFkNS7pTnnNkWsUSZnlDHqTXUVlbCeAxVFvNr8?=
 =?us-ascii?Q?aWPKYi4c4vqPC+eUuPC7dKgj2TLvW9WO3TlkqrPrmMxrX0oHux5JQ7g4l3Yk?=
 =?us-ascii?Q?BiDckThTi8wKFOu9j0hnTm0Ic7VG3wYHuTquYI0Qsv6NogzjbSICxOlp9B3v?=
 =?us-ascii?Q?8iTO4Y8ZC2VteYJb/BmoM78vUIRiomIuCnzQPTK1tyI0U0ANAzPKK8aNtxvi?=
 =?us-ascii?Q?7YJ0bj/Ruf2Vg57Qtor7zrb6vC8LEe3lq0W0iss7vIU0OyyOpDjEB6BLrax4?=
 =?us-ascii?Q?PyYw2SzoVzKIgs2Rz2fmgqb7cL7uT5EtA8nZrIzLBoUPI36PozpU0LUH082Z?=
 =?us-ascii?Q?vkBfKbhTDSj+CF6M5rkwDGHMbFa/BYz7YcG9w2FTeAhJ0IXQ0n/fOmwjoJVW?=
 =?us-ascii?Q?V8h2wizcGWJn9E+XL179q9CvRI0PPE0qo5liilNBB7D9CiWCVp4ZGWGBNtlQ?=
 =?us-ascii?Q?CMpPENd1VxGV00LeJX2iKIOHQf3Zivm6JpK5YHpGkqvXYIhnvvB+uJzlSYZj?=
 =?us-ascii?Q?Pk1CJ0pBm4pCdfcV9WG87sHMbJXGaPYzh07kHc8uFXIhJ7bAPyjlTgMoBhWh?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	D/fY+lPDsX/0ZGBaG2Vqmu+jqzgu+RQ+2LGPSy2cOhjuImPL67rsOdrhshKpb/2xlo4SmnW+ErJaDjqCld4XXIXh+voq3CYqF7ShZaTmfLuY61iPzq04LYFE44GFaOnLGbtbox2KQBDjxRMxk5IxpamP0ZPwylmqKQmHynkhHVqLfwjEj8YVc3qb/yzsFv8r4TEPxTtYEqYuiflNeD6mN3BOnpk7maaXGGADGj5VEFKA8Voz0NTxZxjhzVb8BW/BY+X1B0SySezwo1wO9UGajBoXRJ8qHlv3ADPUvh1Yj5HE40T8DM7qrTiMvQ/cG+2OKVomdfbS1Nr5204hrraOdUNDYKf2uGMml9Sh0vfJU/tU4yPm3VkozCyFvZ1OfAEaPS3eojiYyuCnL5FxSXCQB2MNI3B0q4csv9cDvhdGDGFdBK4oZjbfq6EdtV72yUGyax5CU1Bk24nzb8zqqD9wgYmQ3POjVv2lhrYPgLbCZZJrLOdgUkVuXoLKuRL9cgKdug+ZJYa6YTtCzyDk3d5mumnUT9Ao9Nv22we2CvYkfAejX9ur+eKmIf6KVa5ORS7iA/IUPdCKmcWgpdjOoCYCaN+KuPze1mbnsCRBR8/a8Vs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb8bbb4-6510-4bcd-9869-08dca7e621f4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 11:30:03.6000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XeMM1kPy4HtYkONHSq1qJUHu5pxAdea3oo/N9Y3lY7SRv6iQcIiV02DM1QgwPNPljYIuzHcB5rerDLg7g5nEBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407190088
X-Proofpoint-ORIG-GUID: TeLtFFciuTzkLbslOFOzG3x0xhguyxw8
X-Proofpoint-GUID: TeLtFFciuTzkLbslOFOzG3x0xhguyxw8

Similar to what we do for enum req_flag_bits, divide the definition of
RQF_x flags into an enum to declare the bits and an actual flag.

Tweak some comments to not spill onto new lines.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 include/linux/blk-mq.h | 86 ++++++++++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 32 deletions(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index a64a50a0edf7..af52ec6a1ed5 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -27,38 +27,60 @@ typedef enum rq_end_io_ret (rq_end_io_fn)(struct request *, blk_status_t);
  * request flags */
 typedef __u32 __bitwise req_flags_t;
 
-/* drive already may have started this one */
-#define RQF_STARTED		((__force req_flags_t)(1 << 1))
-/* request for flush sequence */
-#define RQF_FLUSH_SEQ		((__force req_flags_t)(1 << 4))
-/* merge of different types, fail separately */
-#define RQF_MIXED_MERGE		((__force req_flags_t)(1 << 5))
-/* don't call prep for this one */
-#define RQF_DONTPREP		((__force req_flags_t)(1 << 7))
-/* use hctx->sched_tags */
-#define RQF_SCHED_TAGS		((__force req_flags_t)(1 << 8))
-/* use an I/O scheduler for this request */
-#define RQF_USE_SCHED		((__force req_flags_t)(1 << 9))
-/* vaguely specified driver internal error.  Ignored by the block layer */
-#define RQF_FAILED		((__force req_flags_t)(1 << 10))
-/* don't warn about errors */
-#define RQF_QUIET		((__force req_flags_t)(1 << 11))
-/* account into disk and partition IO statistics */
-#define RQF_IO_STAT		((__force req_flags_t)(1 << 13))
-/* runtime pm request */
-#define RQF_PM			((__force req_flags_t)(1 << 15))
-/* on IO scheduler merge hash */
-#define RQF_HASHED		((__force req_flags_t)(1 << 16))
-/* track IO completion time */
-#define RQF_STATS		((__force req_flags_t)(1 << 17))
-/* Look at ->special_vec for the actual data payload instead of the
-   bio chain. */
-#define RQF_SPECIAL_PAYLOAD	((__force req_flags_t)(1 << 18))
-/* The request completion needs to be signaled to zone write pluging. */
-#define RQF_ZONE_WRITE_PLUGGING	((__force req_flags_t)(1 << 20))
-/* ->timeout has been called, don't expire again */
-#define RQF_TIMED_OUT		((__force req_flags_t)(1 << 21))
-#define RQF_RESV		((__force req_flags_t)(1 << 23))
+enum {
+	/* drive already may have started this one */
+	__RQF_STARTED,
+	/* request for flush sequence */
+	__RQF_FLUSH_SEQ,
+	/* merge of different types, fail separately */
+	__RQF_MIXED_MERGE,
+	/* don't call prep for this one */
+	__RQF_DONTPREP,
+	/* use hctx->sched_tags */
+	__RQF_SCHED_TAGS,
+	/* use an I/O scheduler for this request */
+	__RQF_USE_SCHED,
+	/* vaguely specified driver internal error.  Ignored by block layer */
+	__RQF_FAILED,
+	/* don't warn about errors */
+	__RQF_QUIET,
+	/* account into disk and partition IO statistics */
+	__RQF_IO_STAT,
+	/* runtime pm request */
+	__RQF_PM,
+	/* on IO scheduler merge hash */
+	__RQF_HASHED,
+	/* track IO completion time */
+	__RQF_STATS,
+	/* Look at ->special_vec for the actual data payload instead of the
+	   bio chain. */
+	__RQF_SPECIAL_PAYLOAD,
+	/* request completion needs to be signaled to zone write plugging. */
+	__RQF_ZONE_WRITE_PLUGGING,
+	/* ->timeout has been called, don't expire again */
+	__RQF_TIMED_OUT,
+	__RQF_RESV,
+	__RQF_BITS
+};
+
+#define RQF_STARTED		((__force req_flags_t)(1 << __RQF_STARTED))
+#define RQF_FLUSH_SEQ		((__force req_flags_t)(1 << __RQF_FLUSH_SEQ))
+#define RQF_MIXED_MERGE		((__force req_flags_t)(1 << __RQF_MIXED_MERGE))
+#define RQF_DONTPREP		((__force req_flags_t)(1 << __RQF_DONTPREP))
+#define RQF_SCHED_TAGS		((__force req_flags_t)(1 << __RQF_SCHED_TAGS))
+#define RQF_USE_SCHED		((__force req_flags_t)(1 << __RQF_USE_SCHED))
+#define RQF_FAILED		((__force req_flags_t)(1 << __RQF_FAILED))
+#define RQF_QUIET		((__force req_flags_t)(1 << __RQF_QUIET))
+#define RQF_IO_STAT		((__force req_flags_t)(1 << __RQF_IO_STAT))
+#define RQF_PM			((__force req_flags_t)(1 << __RQF_PM))
+#define RQF_HASHED		((__force req_flags_t)(1 << __RQF_HASHED))
+#define RQF_STATS		((__force req_flags_t)(1 << __RQF_STATS))
+#define RQF_SPECIAL_PAYLOAD	\
+			((__force req_flags_t)(1 << __RQF_SPECIAL_PAYLOAD))
+#define RQF_ZONE_WRITE_PLUGGING	\
+			((__force req_flags_t)(1 << __RQF_ZONE_WRITE_PLUGGING))
+#define RQF_TIMED_OUT		((__force req_flags_t)(1 << __RQF_TIMED_OUT))
+#define RQF_RESV		((__force req_flags_t)(1 << __RQF_RESV))
 
 /* flags that prevent us from merging requests: */
 #define RQF_NOMERGE_FLAGS \
-- 
2.31.1

