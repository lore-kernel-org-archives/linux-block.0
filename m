Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684DA770FD;
	Mon,  8 Jul 2024 09:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430251; cv=fail; b=lZ2RFp25lTgx+JgJlDbvA8ERAFoCXmlJL0Pyx1McqsCb9TpRZpTpQ+loJ34qKgqFd2N+nqXk11HZKhFUZqgyiZ8sUJdyeZ6IMTzWJYdHT+qyRgVHrNqrFzdf4fLTQuMShEEBAvwVnD++xpWZoQW9IMysA1+PNNIuQC2OC+U+fdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430251; c=relaxed/simple;
	bh=J9r8Ou/DeHdGHOioz4TUaQs9tc1WB59AHu31HTXLKIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SGw8QqbcfMXSHmBBDD4MbjPhb1ogAm7ihfJkKbX7PNjFBirpYfeDcr4cryQrgt8QdEFnxuHegimOKoK9dLsAvBAD4IiN8mBXMmP96kBfBcR4UsatNdcX0XKdomsZ9CzYJXvzrRUrXP2L9mRrFLmO2PFR0vsGleaVSq2BEqFokGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jhna2FST; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wYQh8o9w; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jhna2FST";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wYQh8o9w"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fSf8011862;
	Mon, 8 Jul 2024 09:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=Vb5qjclebzn+tF5W/Rv96U7VkTNPdXqTIYpfsV5PBpY=; b=
	Jhna2FSTyeE0pk89nC2AS52ErwqXF+rj9uhAXBcw9HWyjYQnN9jQJJ2v6PB6+NBW
	fDJ0hegI9tdIXZDj+UkcTF4tRQIJJPiffsNlT6lqtYJ9XkJkgQXfPD0W+FSeYWs1
	0bzhcl7cS+mN7biKvqapSl1Mr28szBv6lPoqqExbl1IPl2tZCevzLRGQIproB3zh
	tFw9dnBNVLy9CYkuKykCTUaxDY3I+Q4MT8txLusEZrQqCSfseONhfcUCF9NeD5+K
	pHCbGZdu9b+m5crbNKPasa2vlLNZnKCxcTorNstUQ8sXRG43W+d2qG1n3asVYUPv
	WvTjcO+FpHlK+JDLDfsfgA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybj6rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 09:17:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46876pfb013662;
	Mon, 8 Jul 2024 09:17:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407txf4x2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 09:17:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8Eg2Dsx8a0mtx69vl0En2w7BTiukeIwWOgME65yhpkQpGSo8HbSPWaZElxx89rgiW5B77M28RXfxoolwZaEcnQ6YGzva7HjxR/WBl9jsVrP0cW2Py63iXfyXiz9keXWhsWpbLJuEmDmW1ot4my4MRaaSVMlSqFb6jzBPDhgCyQX+NGM8jNPicxysy9CLQB8qQpHB2wisJLqKw/RVBzHitO44EyMWEePjhnzyWQAb189t5Mwx01iNYTYPgJsePicQV1q8P6VjFAS1c5xoK5XPXIhQgB9sGLqHr0si6D+gfMlF69/M5vllBTsBJirSs676hfWEDpbJa9vCS5Ww2KW4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vb5qjclebzn+tF5W/Rv96U7VkTNPdXqTIYpfsV5PBpY=;
 b=K7Laoyv75XIJEkSY/WnAKiNlGCThbow9YSWr0Nl4uTwBRA7mwip2uZPFFZaw6dECl6w3uWgbW8LySfeVS95qBkpldqB/Yf70hEfN6y+3U/cqJJCsd8+iK8KdI0EkZpW3heRak+kCvfSbx7Ug/mJzptQl/YtSTcM4DLy2IzDPOuydH/Iw5P0aFwaI79JPDzXb2CnU8RnF8Demz/Ku5ZJY6QMT+1+bohBu/AaBUTvaK7nYcpR8Awv9HrHOPcV9C8I0zvXby4gG57oNjFt0/VaMOxTPpq2ld+Q4qIYPhSIV8cw/+dZHCyFhgEQRFWlRVo1yT/c8cDEsUv9l4yIS1ZUphQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vb5qjclebzn+tF5W/Rv96U7VkTNPdXqTIYpfsV5PBpY=;
 b=wYQh8o9wqZO/GiBt4IwQ3o6B0BWu5NZ5pTGGhPsOI5Qq9fTZIDTxONdSRMN/G8ezh52ZY7xQaYq6txofstFlh989Z/U2zNgryyUYhBwRUJVEuGuGRy4VfeVeY2bSRcc2mU1u4Yt+ChNIXTBUAzOsliRPRSu8x44ZRm0sGyWWOHE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6799.namprd10.prod.outlook.com (2603:10b6:8:13f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 09:17:03 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 09:17:03 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, hare@suse.de, kbusch@kernel.org, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 3/5] null_blk: Don't bother validating blocksize
Date: Mon,  8 Jul 2024 09:16:49 +0000
Message-Id: <20240708091651.177447-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240708091651.177447-1-john.g.garry@oracle.com>
References: <20240708091651.177447-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0034.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::47) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: b6a09e22-1b6a-40cf-3974-08dc9f2ebae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?brFcPagraufWnIEZMzx7Gi7CZW0cpa9/uSxEVVm3InRMlU3bgPk3OuwWQ0ke?=
 =?us-ascii?Q?mdHfgzm2ap8Z4O07I3pRfm92dnhUVWq2zWidYhe0b3W+R/TfruBUzY9tAUPT?=
 =?us-ascii?Q?wV0yTbPR1r7RlV7U0/IJ52WmQVpXr9xOtNZWYn6LIiC3MZTaZYV/Wjt4p4UD?=
 =?us-ascii?Q?etzKxnip5q3SjG6DCCxkoqHpu99yGpFkue5gkJLQDl6+EgjYbNvHnJTfum/2?=
 =?us-ascii?Q?7W8Fi5hoCGoIbQhnCe0VmUWXIOXRyh8NLVrzdncmHMRKKm2s/vSNjN/o0Hto?=
 =?us-ascii?Q?XuDzFalEHPXFqi3k4yNr+++poW+KH9Fbhuohbn+1mop+VlBmWlYRY2n8+ikb?=
 =?us-ascii?Q?r4bHLsY1R+DE2vzffq4eN2uIFamGJmdlIUtS9zglLoq0mif89k8ZzWfzbx/4?=
 =?us-ascii?Q?E86MkyzPq5U1i88T3JCb6DhUrlGPCp5CTZMy0+8m3cpDIPsNEowWjZN+KwOD?=
 =?us-ascii?Q?T/yeixWOHTb8UJdv3QwrffPDxN5cpvUKWZpTYfTl1UOEzND5L3s91Y11xdWF?=
 =?us-ascii?Q?efoUp56RrWi/GQb2WDYJlpW9C+COm2uX0rMD+VFEegaPRSS52l8vLXuWAL39?=
 =?us-ascii?Q?/GT7p7NtT5g94w81UUNEYX7ByVpU/LQdXqWk1x8ubhX0ALPJhUqTq/HI3MvG?=
 =?us-ascii?Q?XuDBo2mbczFS0M6NKQzJ6/z+6phxyoQAI6hDEpBcjf9qB6y7n8rFP6m1KNpG?=
 =?us-ascii?Q?1EIwCCRf2iyKBx/T+jlelHI9cfkUuLsT4/Rrrgkvo0QoxqOWEk8l19iodNhy?=
 =?us-ascii?Q?QuwdfH4S9Tr9MaUU5eim9xYVNDVJATk3FQySesZj49uMs7oU4jCfYvhNBFop?=
 =?us-ascii?Q?vGE1el1UlK7OBNnc4pnHQTmNTao291gZcBoJC4RBp9+eFc4NewQSjQSxn+PA?=
 =?us-ascii?Q?c0M3/oZfGMytEmk7LPJ6nmFjridqxSjaWlndWI/2iG8mhMU+uceXABnVmHtp?=
 =?us-ascii?Q?hZXy34iEVPaGtJ5+BpOL8zoBtAwpvTN920daUlpB/5hmf4ERoiJtD00ur9WJ?=
 =?us-ascii?Q?t9r0jIkKtx+KHvJo3Exi/NbS07xCITcAblxGpJ3pg3xM94f+SmN1oHS0F/7W?=
 =?us-ascii?Q?2oN6oFH+1y17qTRsvU9r2pYfOzOScwZspxSZ4N2fngxUHJNjHGWB5quY+rz6?=
 =?us-ascii?Q?vRWCMkm5jNgnoqhyhXZHT4iE8xL7E3skWZbIFlyGHW0yG1s1JwkeO1sowL7h?=
 =?us-ascii?Q?I6Xtc7xC8kGXC7MNpP5pLv9IKURsNr4RDHq6H2ytQ4dRoPd1px/cGmHWuoxc?=
 =?us-ascii?Q?xe+qVLNKJejs1VvTbSun3AizxZmCuh1PRuDqpSatjykOnBnFdoWyu/HsT0xr?=
 =?us-ascii?Q?3nTxDdLl1jys1ACLYsEajF6qlGmtkgzE1T0dG5IyVaVPBAMRvSS29U78yPNn?=
 =?us-ascii?Q?1pF51Ays/HoYs7zuVcccYBEIXcCP?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sEkETdJYmkjYAHT3Pxyl/bvhPSVcICCH0gHDmYm5TxOOVC07vDWE7CLtff7c?=
 =?us-ascii?Q?xe+gXUpuU4A3wWSbKDK5+Lwvqotem6nw6D78cgrQ7TvWcCBJeDaU2QJA5tlW?=
 =?us-ascii?Q?WF6GXszxOoQDdz3eb6dWHUtSkotyQ9M+Gztr6rOiKPm0s2dW/wNDUHKeMpKh?=
 =?us-ascii?Q?KdUvdvh65RX7t8ScnBlsaOpserKP/2rOejY2dZTZlI5ob1WR5LOem6DWXlF8?=
 =?us-ascii?Q?CFHG3Baua0nGYlFXO3YcmVKQlIV5TdNuQgIAsdrHUAnS5XfcAXckZSmTqjit?=
 =?us-ascii?Q?SyQOV6Jnm7IIbZmrskA4KmNMbo78hw08yqWepakcK1Fe+e65sXXHnC4ECGcO?=
 =?us-ascii?Q?JTDxX3rYZdbPXt/FZb9OIr/Y72ritvLyo7ysGAxvSqsx/FGh7v95CsadDwIN?=
 =?us-ascii?Q?FvQS7id1q2c1mLyp041VfOi9VRajV+JCnyVRIYZ5QZdogB9VttyGvzj8spaD?=
 =?us-ascii?Q?sLeqP5VhJNzwZtSAr2XHzPY7BzFmpFY0XPaDlULLKiZMbEps9tnmEGS55o5p?=
 =?us-ascii?Q?NIfibceI/MMr5idiizuk28LzvVyKASiQ1fHW6cpEBzqKHSznOLtM061nU79v?=
 =?us-ascii?Q?AUgsjXfG5KL3Nbacou0EgapqIaVeeVtdERw7sPpmevXUFsSZolc9wFU7FApA?=
 =?us-ascii?Q?Um031wAOXmMsHW6SMCPwQX0UvodTvDsu7Xwu20i94eDLDW2O8MCLMxWaCX10?=
 =?us-ascii?Q?W+pWg09hTXYlVV9I12ZCYq6zLJzITJxu2UgiF0Vl8TsG1slf/CAFlsBWbuWF?=
 =?us-ascii?Q?weUZYvPNJ7ZrAPgCXId6ke1+lYJMy8ZRjSl92zF8XL9N+rdeaMoWqU5shpNW?=
 =?us-ascii?Q?RIsoc+X0yoC9dDRy3BMWxhSMYI8GOQ79euGZG9B2PBFb1b0hbv1FnZ1z2X+a?=
 =?us-ascii?Q?FbhFaVUYzL4RmHGNTfijQRNtgOqi6sZxVUEFyAv9zWA9IEQlC2v5/ZFES/IK?=
 =?us-ascii?Q?CNpBWhi7EPay0XVa/cc6r0pwtGVcj6zJ2taa//UjioDzsPyRH3ZTOIyn0Lht?=
 =?us-ascii?Q?Q8B9ghIb0BsDEz0llYAtxhljtq1yy5O9OkGkKCqlu8BnjgYJD39JUNqpyl5d?=
 =?us-ascii?Q?DjqEI1cX5qaiEbpJfCTfBq8OJ59jLxOBmrcAJyQIU/jSNTZtOKNVVDjjvbLc?=
 =?us-ascii?Q?lc1nCGAQuST5c6HWqk2FIT2HKCxQ3QxYE2zhzH2sFXORskO97pYi3294R9No?=
 =?us-ascii?Q?ekdpG5ec20CIgT+zqRy3P5Kt+ECIVbIOjkMYGAgNW7PFXJ+m96JnJ5cufJnr?=
 =?us-ascii?Q?uCD89KhYfgMSZxyXkrronzeP4Lu16VfOBU4bcr0F+j+VnvARNWIXD7/3Epf6?=
 =?us-ascii?Q?JsTckLkZrqwf7zfOh3BKXVoeK8Ycz0gJRBiNQPiGOkDeqEMY724elYVmFf6m?=
 =?us-ascii?Q?N/piqBMSP/DN+V7dwnQFS7YK3u4iqf08KiAmqjzjqnlL246aloaXjMAAP/ga?=
 =?us-ascii?Q?fx59NoP62eVWeQQBFpoEzURopdT1OSHqww6vS5eIeS9N7QiBWBWFk692SJio?=
 =?us-ascii?Q?oNQC2bDpedM/SfTu3vHPfiwCN0y2u6onKwYrw0huijkpLfPjoVrcaXCCNNAK?=
 =?us-ascii?Q?pbUXMWsToBUvN9tTL13tzqaccrfo2/I4tAad01WZrTW4gOzlZpS41VFH7JKa?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	bKyJezdg1F8bxCLO9owbFQ/LczkBlrmKHcoXhxf7huy7AYBu46u7r729SdU4QY76Wq2F0r8K6+TU9i+jyiETsMeOvp+9lEUb6YKPaHl1fRIutb0Ux1fGL5gstMghvrrP+CcpNJWjgEwfHReItTcZopkMBRgLTz5AKh1DCyU8atfzeu+ZUz3TRHo7+BP8CAbDgJfdGnekvkR16yd7+lkfMI144MGsBLSU0dgHzzeQwPddPsXoQme/5VNofpvo+XbSUn7j5OOJiJ2ZN+Pin9uJ0JZ66MZnDGIBAtU17yX8wrY+MjyqoSiZj/teWpAZ5Vq/8Ps8miOrsi4MZ04zo/h5asa1c6K5CD1zwtk96yZNvuAUQUNMj4Se69LRnXML9RyMLVQy0Jc/gXwXopXgfM/UcT0E5FI3ztN9rf8/8A+zqf2iEb9+1aChYwuppeyrUAbyQHKUQ8jOmumrqebpnOb3wb+98ip4sH/K0861p+JMYC6e3k+JTiq06wvPlou5u3z/nIRjXs3pdP/jP0mTAFvJyzEsWRM9Imh2sBkXJvVIjsesX0bIyXUrz/OISBshTEGG/GjuQEos5C7ie1IcNg7d5zvTjRMvZmg3+yksUs5+DCY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a09e22-1b6a-40cf-3974-08dc9f2ebae6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 09:17:03.3991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o20zpAX9TYWt7Y+NxyE0JQ796po4j8WhNbiy7DB1tsFr59KlMozUrrw2erQFp3KO4c8Cbypp7GT/qT8XOy9v0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_04,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080071
X-Proofpoint-GUID: tA4wGEum9791IHhFCJp1JaYc-ZORnC6r
X-Proofpoint-ORIG-GUID: tA4wGEum9791IHhFCJp1JaYc-ZORnC6r

The block queue limits validation does this for us now.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/block/null_blk/main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 9d0f6da77601..2f0431e42c49 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1831,9 +1831,6 @@ static int null_validate_conf(struct nullb_device *dev)
 		dev->queue_mode = NULL_Q_MQ;
 	}
 
-	if (blk_validate_block_size(dev->blocksize))
-		return -EINVAL;
-
 	if (dev->use_per_node_hctx) {
 		if (dev->submit_queues != nr_online_nodes)
 			dev->submit_queues = nr_online_nodes;
-- 
2.31.1

