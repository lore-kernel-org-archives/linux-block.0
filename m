Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E473157A4F
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 11:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523162; cv=fail; b=MSB9FIaW4kL+p3wIRTZsthaYmyPp1EAvVUFupJPIbPFjgJ0dp/xRRCOG4jPHIs91ArRVU1SeJSeTkimJZ7G2X11uRm/1K+sRbrbo2v6bfRBhJAuKkuMFXnO3tiSh/n1RqjqlkvFOQ6ji6Vk4DIHFaGI5bvo/LrDmwS6xgd/H+Wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523162; c=relaxed/simple;
	bh=7XX7i/IlTiadXSQrf1cafaYl+X5c+Pvm11CsfpZTFAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sAoM6CJ3ne3q45w7glYZ8jNbXVcDn3rc4XBaMI4FWSMiuAdOh1O3NFFK1UYiZtrL9VIbVMZmNC1fg5zQpCflkETzfmjoynM/ZTnWuR7gBpQD7XjJFyJ6b7/rlsK4M1eDQitz2zJKgdqK3yFPLfd7teU06mubLmMCJQagHP94zmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MboEgpsF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ysRNVNxG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MboEgpsF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ysRNVNxG"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697tSEP009537;
	Tue, 9 Jul 2024 11:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=zHD3qcGc0eilHzm9XgRWLUraA98zyIxJrUdh4R8Gn1k=; b=
	MboEgpsFsAKFKyT/CEnHONsKfnA9hjBPpILpCqpXuyfYx+hLdXDqj+kYZlDVHq7s
	VtPYOIWVEbRxQ9Pj9smTSJmAH9anRPnSEpX5DGO95pxdAsPuCM2M/jbbFlueIkIz
	i57SjD2hADwySFmvarg79Mfx2d46lNv1nQxkn3Gx4KG/wAZIwsz7F5HafX+/vQzB
	HA5JNpOYv3ghBSYEnoJA/EQ/2nTAAa111sx0/4vpPpjqUWB6Tr2fWoAzsbuPVmhN
	KFBk6qQmmmcohbBDhq7bUU+qI4CIyRTX4qcTh/4SQBrLnpzKDOK0tKa54atAEuXM
	Hvem/z1BrR1sh/iQ6jzp8A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wknmnu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 11:05:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 469AUcQe013665;
	Tue, 9 Jul 2024 11:05:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407txgs9dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 11:05:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0fbMupfkvmzofT6uDToCbzFC+BE0/vH1AufHnTaFGHmwH9eUxolfHl8An7H2dy3GRNeVDeAxBOQuNm/H9IPv4orjDU+Srmf/Kp6FdGaocIzIMjBKsHDthLF6dQ0bcdYgY5KTOqJgBXZQTJqRldiD0eepQ2TYduC9BpMsfe2RlgvrixCVedFUBylCdSDa/984v8GNwhC5dTpLg/JIcRPTWgzxKNMInoH0ucz8be4u3OgSnTKZZUrg3hNA5NVRM6XIVC5j8hb0VYMWJO/PnhX3wQQ7azJqmho72zx2PW1mfPO8glpzks+FHZQjyfBlU9dnhAozr8GXThQT/9QKMU+vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHD3qcGc0eilHzm9XgRWLUraA98zyIxJrUdh4R8Gn1k=;
 b=BiqKU8u+JsidMY2Zc6xvzJwUh8fr9Y7KJToE+HAdIn1W3lEDTJS5ik/NEtF9HsTIbHke3osmXJ3s/ZWe6g0wxqoHB5fjtxucWtAYiT3M2U0gaLfeiG/UM1vTvEPwun2gTra9/19eSKIDKaEdVsZ5IPjzwXqkudvEW9uF97GSkL8HNRNpWSldjsT7pGsmoGmOVP4r8Kzqmh4UeZv9RRJt5MQrHIZKYIY2KiT5NNidA2a5+b31SG68/bKp6BvHhioiIg98h4AR0suWJjKzA02IqntU/xXeI9+rKKEtWdaxt+Auu+WJ7BXLAOOIuT4KJq5rL+/3wuUxMm4HR6iSPC9qlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHD3qcGc0eilHzm9XgRWLUraA98zyIxJrUdh4R8Gn1k=;
 b=ysRNVNxGZL2d5x2NLPxcPcfCeysd75FreVGlWXnfbr0+XiAbVkKnuocieaM6DEDHrbZoZsbuuTcmAEz0X2HWpiO0Ys3DJgsOdIqXFP9RzP4eAYCKRbZ5NetBVn91gJREFmoQ+UbVShjPqPbLUuoM4TRHTeNZJizdAC2MHhW+ROk=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by IA3PR10MB8068.namprd10.prod.outlook.com (2603:10b6:208:505::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Tue, 9 Jul
 2024 11:05:49 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 11:05:49 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.g.garry@oracke.com>
Subject: [PATCH 01/11] block: remove QUEUE_FLAG_STOPPED
Date: Tue,  9 Jul 2024 11:05:28 +0000
Message-Id: <20240709110538.532896-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240709110538.532896-1-john.g.garry@oracle.com>
References: <20240709110538.532896-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0001.namprd12.prod.outlook.com
 (2603:10b6:208:a8::14) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|IA3PR10MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: 8870741e-6dc8-4e09-c59c-08dca007172f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?jwqgYqJBO3epMdkyGpZLVNZGfqMuaYSKV7wamhIC3e1UGpoI3reBh6NJSrd5?=
 =?us-ascii?Q?emElv85/ZLWEcHcM9wPEhn4sgfgCP61JbHD7vFR/hXLKsJIVbAuV3oAVXuGf?=
 =?us-ascii?Q?j05JaTokbnQBUXxp3dbUXnn3t8InSCZwCKXBBfLINVAk1D9bvl5hcO8Dyu3c?=
 =?us-ascii?Q?j5t12ltKCTPDtgFg5LHASw5R+/YeR597j1+ini+ZyLTm2zkn6L+g2oKMRk7G?=
 =?us-ascii?Q?8ZSvDgxRzyAwiU+gZoJWm0EDn/LCw+4Yc6c7PXG8+X7qjVmHA8IKcYaayNgw?=
 =?us-ascii?Q?61fqpVWJTmz0zvKVuEYlh2FXqSc1dU+T+3/MSOZilYPvY+DR8k+k9HJIKOzG?=
 =?us-ascii?Q?IBtVBsOfFgZ1oU9dp+OVeLmAV6vDvXhLYdiNhmzdubBwf6wLRNylSTnqFwe9?=
 =?us-ascii?Q?Ljcp1+NKQSWqfekJTO5c1bEGbEFunes2Y8gAmlLXDXXCvV6f2AjvJoKMtteM?=
 =?us-ascii?Q?XNKNPZiHfQmvkSSef2/WQ5sCqADqs93MTovJpKI/dF8kA4uH0gzGZ6aeYeqE?=
 =?us-ascii?Q?OOcO5hMTqnFTTQ0PsyfqR/DF72X6VH4JJTNW5rsaRyxmRjsnWBgGYJTgR942?=
 =?us-ascii?Q?XaSfj9VaF1DB+3X0ViDxNQpTMCOeeEMpN2GOobtbTA82+/Wewt9L6gl0uE4z?=
 =?us-ascii?Q?FKMOWCohHUm9tUs3H51xBGuPpoBOBL1rSoSYEJbwaz7YdFIQBKc2IKT3rTiu?=
 =?us-ascii?Q?lJP/H8iYasXy32ucdCJ2sVXpD6lbmXull+3DQtsSXum3NmUNH+P17ue/vrBn?=
 =?us-ascii?Q?kBY2iCYjEGq+2CwT+Uq1TL8mZ9Dm1c34xwzA07T3+hcFqPEOxqPi7fy4PuEW?=
 =?us-ascii?Q?SwlmFN5+IgXUoHFHNxQWunLKkofHOBq1lW9fVFQSgw9t9/eg7uWj1mdjmVD7?=
 =?us-ascii?Q?MFGfnZoKSouGLRNsjS2L7uzrbEghqZR9VRV7J6wqYB3Bt/UMYXAFc7J3puUn?=
 =?us-ascii?Q?SsbeGPUkTHlvUkhRv3SvO+84vNjL8hRz5S0Zl9lapM414+v24kPLgDCXSi1r?=
 =?us-ascii?Q?J4uCecDN+MHqFcr/DsmTRiCyyCGaSEl+9nr8HEfxBfptBj/6IvLkiJNhaAX+?=
 =?us-ascii?Q?BEQNGBnBiamtg+/kpK07VF1xHRaIfIaywY8Y9N+F/aPIqD9FaiW56YW6mu+d?=
 =?us-ascii?Q?FDYz4WttYKiCJSPsETgiKUDifG6GfsQbf0WYvDN9CGCp90/mldPu/1NT6IgF?=
 =?us-ascii?Q?b+6iQGNmtvE0xdRyN6/00qbDKeszuVSpaIPqfxb575JSB3qyLeXaIY3BL08b?=
 =?us-ascii?Q?pL7GXMp5FhKf95oe7kjhbcmI6pTeH+9yIsA7mh+5ygVuKP5z0Ad7hulL1cRX?=
 =?us-ascii?Q?0qdkUMfzvWizKAi3vNSm5Y0laa/dxFfM0f9WCAQAcIDRww=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tJonIkkS6Xf7iQ2fG5bVuVC6IBpAl7hxIcIIIhcVZA5bC6bfpPvh6Ty1zuFy?=
 =?us-ascii?Q?z2JadGEU35sJT7CWKMz8Se7uzmGOIh/BfA3fmt/kk/rxiQDTx0NAO1GIJmwf?=
 =?us-ascii?Q?terpW5/8RdNHW7XbDuubjbHBwTf/7APiaCmcPViZXpB9/9NKk1kx90yLWY2r?=
 =?us-ascii?Q?ZaAn2VZsnW/5mwK8WXAYEcjQRTjw13ICiAq26G1DdH2L9Xf8HBOjwD9GanzD?=
 =?us-ascii?Q?jdj1E/oTzmGRMl7rdvD0xvSnjHpbmtnVjvef6mvNYbBeYIexjv6BHIH92MlQ?=
 =?us-ascii?Q?Ln+iRajJ078PUD6ZJ3HRbIr8oEVPHCxgU67J5udd4jPBZeNcwkNiWxpCBouv?=
 =?us-ascii?Q?Dcvn5wtWNzQpSAVLSNIfx+X7WNNfQRbJDRUFOANQpSLmmQMsz0WNuZ9Jyhhx?=
 =?us-ascii?Q?nyFqI0aSCNRR8PhdXqu+0EFHcjEf532/EpY7XiPEFpp4xJk/QxoLsUO45ayp?=
 =?us-ascii?Q?tNhhvqldLbTA9Q0SNl9Lblw4z3+eGNUSgZF5bp5v+gIq5XvkVSthxJdHQJnc?=
 =?us-ascii?Q?kfm4kDjeMyd3uDb6RPFB/ND7O8BxUPZdxOeIYkVfpv95lUgxNCKLlMXNOzP9?=
 =?us-ascii?Q?FUgBZp/RNhC0g+O+tX86a6sZH0DnjOxLMSFOHx+KQ7acQNsizp791ep2PjPK?=
 =?us-ascii?Q?il0SHy0dkZ89JfazDzr4+Ancn8ZVU80n6xWV7g6yRMEBjNmjV5hIW/vOzuOl?=
 =?us-ascii?Q?AueaEgdszNXCYztLC0UygLb/ruZHGqxp2Y9QQQdiUBWySQhix+taX/gLIjDs?=
 =?us-ascii?Q?x076ahSbn5bxo5o8TaQRDd/2H3wknt0pVPOrYQbe9+CZoCMzT7u0Dme9pzJ/?=
 =?us-ascii?Q?Xlw0GbQPT/+i09xj4i1+L1hPZtAcnyacZNClrd6AOmmysL8q72eAvH9Kut9K?=
 =?us-ascii?Q?wCJ6NL+wVe3KcEm3YPW0EByJKBadDhO1HK67K0X3Xs7o3zbDzGPwuOYJNHhk?=
 =?us-ascii?Q?K0ogjBNpvAutQl0g0y9uEQZcTHvOlrUZJ8z3DBTFL3qHCr7t8kHNbPHt/lMx?=
 =?us-ascii?Q?a1sL3CNUvgE9uXYfXniDhB0zDBxDhDgmv/n8ja6eLF8fJhJO4LrkEpd1Pb64?=
 =?us-ascii?Q?2WOHz3rcwBpbv/9JvhPeb3YivSKNYi081Db+d44ukx6dJJa1tgw3USHoqwos?=
 =?us-ascii?Q?JWGW722eip5gi0ho4e4Qi6a0c1x0311VfdN0IYDuR2e48aZJOOMn1tH7q8UL?=
 =?us-ascii?Q?J+59Qx5B0Ns9ccjbeUmmWwVWg0ceihFDv3403XluGR743Iel2BUnFJqKxO36?=
 =?us-ascii?Q?OyiK3RjGHY9yM8cdy3yNjjVbH9gU0uLcoNRqmFinn5fkTVlMUERncx8MDAbM?=
 =?us-ascii?Q?WSxihWUTclTsI7fx1jz30Mf8VZoVJZXH10sJXifp1I4kIajC2dDDGdsmqtW2?=
 =?us-ascii?Q?8l2HYg+uQGY8Sz1yiopUAdkzIehiQjXd+FzrPngcmz9G3SRgfKStYOXSnLra?=
 =?us-ascii?Q?pV0IIVzeqY0Lxhjs9U+kv17emES1s+wsYmBD+uTD7AVo63yGxBYIKljsYls9?=
 =?us-ascii?Q?pBAoQlXwOmr/AOPzqelq/iREWZxNCD74WSfzBHeW7lwc0lyUGsYHIxdMgiG3?=
 =?us-ascii?Q?luU9+IICoaCZJnql5IKpdWi3uRUcTce4lN7h6E2rGrusFQXJcZo0TWiqwIzx?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	h09HSZ0Fl8kDYemd41X2kzIoTNGZs4iMaMTVogcnnbEtGBiXrUpmrZoPpa5ZXbHP5YlF+UJW8vNFv9N8iNWMs3KyHP4z/fL90fEnp5ewk1fclNKDAitEd9KTjVwcIEiNOkS1/REuQJYZ5AsxoFW5dW94Mg+gnH3MHSbVwyxgj4hAbH3d7XzQ7KazfRwq4+ht2QOt82+tRFfUdLq5pW2naHPNLO821R/8oGOFW1jYR2ENkgo0RBUkAE/Y38W25v4Yq+tMtYQrd5u1QMqPNk+QANrKOTTBC00/Di/32c8CwgFz59gqVaXRacWFKK+rbkRRJ/Vb7TTmxnl/0lpL58XvPfYrMPWUJ0LbW3UGkmNXpt573jiVu+9/8VLCdVIkbl5B1urCs+aaSnrn5QW7HhFzse6ybCQU9CvCEQFydIEsxXLinKtWfyDBeA86/8k/bV31mEdnlUh7ULshtT3irfAZcUfX5kfuuQBBSc3kCTkTidVT3+YEHeODnqhvNk7UycaXXQ2VeJdlS7zYoKLB+D7tvx9VrWZAflwF70XonCBaB+tQG2iRvXFk1slEKl4Dd8tOK8l2ctVQGxvkXS0Yo95hj7lmB5fUNHEdXV66PTYHqKU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8870741e-6dc8-4e09-c59c-08dca007172f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 11:05:49.5748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZPblzZgaPjvC3jtVT1qrzYckGdItI0adR5sEuPvjA31NJXuryb2B+n2xFY79+n0S4fldNP6I+FBg/25bD0KoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8068
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407090076
X-Proofpoint-GUID: nv2Q63OdLVOnggPJljDmtVAkVJLj9cgu
X-Proofpoint-ORIG-GUID: nv2Q63OdLVOnggPJljDmtVAkVJLj9cgu

From: Christoph Hellwig <hch@lst.de>

QUEUE_FLAG_STOPPED is entirely unused.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: John Garry <john.g.garry@oracke.com>
---
 block/blk-mq-debugfs.c | 1 -
 include/linux/blkdev.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 344f9e503bdb..03d0409e5018 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -79,7 +79,6 @@ static int queue_pm_only_show(void *data, struct seq_file *m)
 
 #define QUEUE_FLAG_NAME(name) [QUEUE_FLAG_##name] = #name
 static const char *const blk_queue_flag_name[] = {
-	QUEUE_FLAG_NAME(STOPPED),
 	QUEUE_FLAG_NAME(DYING),
 	QUEUE_FLAG_NAME(NOMERGES),
 	QUEUE_FLAG_NAME(SAME_COMP),
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index dce4a6bf7307..942ad4e0f231 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -588,7 +588,6 @@ struct request_queue {
 };
 
 /* Keep blk_queue_flag_name[] in sync with the definitions below */
-#define QUEUE_FLAG_STOPPED	0	/* queue is stopped */
 #define QUEUE_FLAG_DYING	1	/* queue being torn down */
 #define QUEUE_FLAG_NOMERGES     3	/* disable merge attempts */
 #define QUEUE_FLAG_SAME_COMP	4	/* complete on same CPU-group */
@@ -608,7 +607,6 @@ struct request_queue {
 void blk_queue_flag_set(unsigned int flag, struct request_queue *q);
 void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
 
-#define blk_queue_stopped(q)	test_bit(QUEUE_FLAG_STOPPED, &(q)->queue_flags)
 #define blk_queue_dying(q)	test_bit(QUEUE_FLAG_DYING, &(q)->queue_flags)
 #define blk_queue_init_done(q)	test_bit(QUEUE_FLAG_INIT_DONE, &(q)->queue_flags)
 #define blk_queue_nomerges(q)	test_bit(QUEUE_FLAG_NOMERGES, &(q)->queue_flags)
-- 
2.31.1

