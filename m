Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270DC1CEAB5
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034310; cv=fail; b=VGxUt2/hCTM8p1NG3t5Xl9jzyWFWAQQBCohZq2O44uLsmr5MwVjHnlstdHrn/0NqYqYGj0zyqL+KcrzXA/5TInx1v5iFxVMtGhuhEPma+BN7oX/rCJEWCZTsrnS9ZAQpoLOpZ7T41nrkPq7l2jTo1hx2ECG/kp3lEsQ3IXdZDvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034310; c=relaxed/simple;
	bh=myPAzdhUrXHTqrgQ46eMzrSVYBjFpFcrFpDdxeChAOE=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=my9RZsXGPtI0Dpjko44wpSl5l47XQ2v7xIFGNw+GUpYS06eg8FcGtBUpmJxGIVB7K6cxdjNGWdCCHXfC4Q7Ylk+tCpb8xf/ZX0ZvuWRRqCiem0vSauglVXoWM/KKCZW5KaHNpfHYxZY+nK/cIqtyoqYf3UnV1XxtxW43cqWUUGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mw+XLiup; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZukcJB4B; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mw+XLiup";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZukcJB4B"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJGMYI5031977;
	Tue, 19 Nov 2024 16:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=1OHKmqd9ILGCO9ocB8
	sDF+K7S4Q0apTau2oGk5+xagg=; b=mw+XLiup4oVI2Qy9VJsfb1YENKfRndL3Kx
	zKzVHNO4VbK2MkjdcyjVQYDrJv+mjINXl08T4svwJjhPeLHLP/EawI9umPWhbPqh
	/iqIdx0f8fnHuE9SWrn/fvDb18GXxbUlfnsl9gfpSCogU0xcTeWGFZL/wVivtL/j
	EiUeJQCHQtV7fslhsOZNBSCUtjIzaQT99vTfFeaWcvYw3Z18YZsM5DKEw42izTli
	KY/gZiGe6hKMq+2LPk0GWXvz3UJWceKl/zSAF0KDkL4qntpH5NzvsgDZl71tA/WE
	hnZLhiq7CJXl1JgXY6hNIbOqQwr+9mrwqquyol4D2L6HylpHf5Sg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk0sncwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 16:38:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJFdjOn007693;
	Tue, 19 Nov 2024 16:38:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu8scys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 16:38:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uk0m+jKFAqSzfDr7i/V5ATeuehtjuz1E1JT8kT/CIWNCfcuSRpOCiqKP2icJXYaX+6+UqyEEdsPb1zMq+hOwfSFEIvEbDBgG1tL/kD8fHR3cpTCU5P/BXXcoR+4qr1ycXxRvD8rjYhJ63vE+Ndf/2rckX4wgwikqj/I5/4IVqmRBskvrH4QC/PoB04GXtmQBE9siKlpLJHBcnI5GDSFdmhheqbnXvwLwk/yviuklVSPso3xnCKXMUkoGiolVwRWx6Q0s9DnJTl8kG25m7rtDrYJDG4kOsV/muTyduyOgJYSLBM8UQPMgtokUvtsh2XVyIxo7pAodNvr+gr8r5Z0Bfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OHKmqd9ILGCO9ocB8sDF+K7S4Q0apTau2oGk5+xagg=;
 b=xWEkrURHx+Xwx28ChIe+fpPC0Ilbyn+IYfa/Xa13ufVnb7xEzye50OZe9bWt6x1nDcVRpa6Caf88Oh+cLbXRlKGBjT9FfbSzTc0Te1f/PVVq2Z6nnK1Hr2zyLSie/EuvZzkPTRWgQXeH3Nu0wFq9FkhAzApNXEPDTB3eRgV6Lm1pI+8RyBSnwVt1BnoX3YgUUcXf5squuE1eFyFqO4Q6NvgRMeiV5TDj4/UdMOcpQD5n3ITf4TtLec5IsM/Jt2okgT8Gl4WedYyVC8zNz8wSZlIeFSHU9k385Ab0cn0iVoAhuqiezoERc7EjCLBx5fp6RBPcJkrR5H8QsqiWe2ryIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OHKmqd9ILGCO9ocB8sDF+K7S4Q0apTau2oGk5+xagg=;
 b=ZukcJB4B1lwxePFUSpfGwFeDW1DKukNbI9hdJWw5PpUvSvtFG2m+Q5fZKc4vOl7QMFYXE69XMTfeygUDRD2L9cIPla8P2wkqSA/KjrfjoTOL/P1OHqVpIRAI44pdeCQMjEk7TCEV/YOcHlhSMS2kFUqcBoP4JxiYvpEoVSFt+T8=
Received: from SN6PR10MB2957.namprd10.prod.outlook.com (2603:10b6:805:cb::19)
 by CH0PR10MB7438.namprd10.prod.outlook.com (2603:10b6:610:18a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 16:38:17 +0000
Received: from SN6PR10MB2957.namprd10.prod.outlook.com
 ([fe80::72ff:b8f4:e34b:18c]) by SN6PR10MB2957.namprd10.prod.outlook.com
 ([fe80::72ff:b8f4:e34b:18c%5]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 16:38:17 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: more int return value cleanup for blkdev.h helpers
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20241119160932.1327864-1-hch@lst.de> (Christoph Hellwig's
	message of "Tue, 19 Nov 2024 17:09:17 +0100")
Organization: Oracle Corporation
Message-ID: <yq1wmgzqivx.fsf@ca-mkp.ca.oracle.com>
References: <20241119160932.1327864-1-hch@lst.de>
Date: Tue, 19 Nov 2024 11:38:15 -0500
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:208:32d::7) To SN6PR10MB2957.namprd10.prod.outlook.com
 (2603:10b6:805:cb::19)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB2957:EE_|CH0PR10MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: e558e9ce-e7ca-4bf6-100f-08dd08b89195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7WbZ6TyQ3Xq8k6yovMvhjes9s7aJUnhIKcZ+A6jOu4oJaF7i8rYPVHjrF4sR?=
 =?us-ascii?Q?pam/ZvlOH5ANxX1SUqSRiGvxn2AamkkUPWKQK6+kSg2HLAKd3CV5F5htoPsl?=
 =?us-ascii?Q?Nwa3YbvlHxu9flYjInsmyKf/1Celx/4oCuU4rhzV7Q76/nyF4eNDWePCzw6Z?=
 =?us-ascii?Q?8YrBKGTyIB3KLiD4w0vNOiD6fUM7TIVFtrCvTk8Bcmh2LpvPqy1jY7QwXEeK?=
 =?us-ascii?Q?K6YjHEK2FXObQahc+bwMuBYdMbCyNb1eNvNgXNbs0BvZNRfqv7Z8LnSLq1Wn?=
 =?us-ascii?Q?qhKAs/FFshYLEUuaY1JLr7XTwXnNuzoty25UqFpqbtO87LluHDUA2e0whP+r?=
 =?us-ascii?Q?kbfB2UO1T5EvyFWY1JmEMkr4atti9bvVfRUSFRe+cSMTYwQmNht4o590yZij?=
 =?us-ascii?Q?nZVDLrhReG7VZhVvs0iAz9uhmcRo9qF8yPtryQYwfKymVR0LhPkCj7xVebjF?=
 =?us-ascii?Q?oBDdat4v6FqCOCuuK8RlG5o66/k+JXYVOm9Bq3EvIqM09gDiSUq3q+Zmid9G?=
 =?us-ascii?Q?jM0s1bhisc+0+dhENagiL8r1AqoQXFhpApPJl2rRDUOuCvvdEcLmFG5HTMtf?=
 =?us-ascii?Q?H96OfNm2TMj7k8swqrjqpcShs8zkSJwZO4ZZ9y1AsVGG91c6JTo6/Nc6bZXs?=
 =?us-ascii?Q?zW1k26LXrWy17slfMczP/Et4Alkllofthg76eCdvVrYJqty/lNfNR77squVg?=
 =?us-ascii?Q?+95qQSbHpWNktDWW/UhWHYPq8l5hg/XRk6q4b6kx4DB//yO1kvEMsH6+CqQJ?=
 =?us-ascii?Q?UFPnzhIN7lhXnOKcw6qX0I/jvsUChHMX+4bvJkW9rsVCtX2oGJheotko530m?=
 =?us-ascii?Q?b8ZKQGoBYLAWhfwp6X0sEJQ0Ke3I9gvOomON+jAF2b9j4VV5FS2sqIBAgZzh?=
 =?us-ascii?Q?6VbDlMu8WB3RyUGkwx31PVYxCv/+33EqYKVXSw6YyPl0wREWaC18ITDwISDO?=
 =?us-ascii?Q?VTkRPA6ekH/9i0x3HrcPODIQnPzeiX3LG+VjOpVXskSo8sjYQ5brHmc069R5?=
 =?us-ascii?Q?hYtBpKUUu6W8mI5Ekot6rfko2FirX17w7n3duD0It5uxyr4GR2u7Wu4z1moB?=
 =?us-ascii?Q?8qgENUK/j0kT8aG2o6e1Kz1baFh4ELph5mX9oEqruUKE3PiVpEWByRsoZPZ5?=
 =?us-ascii?Q?PJeitGI7I4cuQf45jhAzUQ5IgXN/WAaiZH3mqqtpe9XbTx69qhG1c0vhz5DB?=
 =?us-ascii?Q?bwd6dEDRVYkHubqZfVFuIEYpDKBVil61US2l66XCAxMCPVk8JB4iOkF85BRU?=
 =?us-ascii?Q?++Xj8kbrA2pmzoekm91i8yx18ep8Hte9MQFj8qbtLaxFNZhvTbHW1Gc741N3?=
 =?us-ascii?Q?+JQHmTD3EecqAC6hmhlabsUo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2957.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ac8thifAKJ/rwzzjaedX8P1IIpRwgrfuDvSjTONRzkYq5sYblC/c/4+sg77Y?=
 =?us-ascii?Q?Z0/c28A9GgvKTpK4mtPGm0PrzQ0fp2jUcBr5RQOyKYbVBmgohcARUQgT7/hz?=
 =?us-ascii?Q?33VOaXMYJtW8soh8LVftf3xQZ6xISaKI9nWrTfyjFMNw+IsQlwitZDuWvWiz?=
 =?us-ascii?Q?zamRlIM1SineGK0POnvxhd4VXZ7cvxKp/3tgw9U70bBmCG3tu1d62w2qV90y?=
 =?us-ascii?Q?Ic33Z/wMw6z7cNIErDFN6HKqtP7OrvE8q8LYjW8rcBWeknskM1rzUUOBs+Kp?=
 =?us-ascii?Q?XZ2AATZdxFs6Kevc4XRJaPMt0+MB3WXItPTtYd0QGi530NKRRMhZBK/5PX0E?=
 =?us-ascii?Q?mEuUqG7ZpZwGo4RImJ7pQx1v+G7+VB3E7L6/PXLQgx4fxJ6e3iUbrqV0IefL?=
 =?us-ascii?Q?sPf6rXEQhm3zCI1SecjD5i4RoFKH+hjNLwHlxiA4+cQSvlju/ZCJaUZ8YFaG?=
 =?us-ascii?Q?h1QbZwfk7iazY1QFqph3QhwFZ+v43g3Dl5HE/4kZPtZFpd/X0RxL0YXlsDWD?=
 =?us-ascii?Q?lXT1faMVMHWIjMrw3fZI+68BhNJJA/T1lnLrkEop/IsNPoqTeNplrVBeuUyG?=
 =?us-ascii?Q?NOds3t1oh2fVpU8Muv8JAm+ZHBNL0ShdulchJc9cIVQKvkcw51aBm4XdAY/P?=
 =?us-ascii?Q?0HCxCHqpTpbDk7BFs0Rm2s88ossdisB1RIFD7ID1clp5kk6SSQn9I08nHxtv?=
 =?us-ascii?Q?66pYZjM19r0Reytwmfl72IJ44K8CK7Qnks0xStSpTBUeLZqoe2SS+atQXVyF?=
 =?us-ascii?Q?T9CIJz++PSr7bej+MotRDRV5zyvFsMZRZk1oiFRd4COchTvdPXz7DSHqWWEY?=
 =?us-ascii?Q?cfnzrxuoARnKDer9PQ/QBKXud0y448ADN3I3kYodKx6kzZ40f+Sc9Lk523e/?=
 =?us-ascii?Q?+0vaomQ8F0rBH2Xs+nj2eMfSkmMTwbw+3NVG5Tiv9Tf/mWbOawSVhzt6J28c?=
 =?us-ascii?Q?dXXr74MnKxCHfE10HyTfVFcDDDyqWLgMuoyuaz5DAFl6E7rZdALatqVsnbh9?=
 =?us-ascii?Q?fuNCZrYhekmu99tKgkCHqvKouU7VVV9ToO404hAUj0gnUjx6flPADab9XWFP?=
 =?us-ascii?Q?EpU32kiVR4tf0pPn7R9HfrqgKSl7GdfMaBmNMmtYEUqN6k/huBS7CtVFeyIy?=
 =?us-ascii?Q?E1VXWUur2+YTQodn0IbfXsPsek0CSR6V4fKdq4etjnb4xK3kqvIBZa61MLZ3?=
 =?us-ascii?Q?OPk5+npnqiCwse8HjveEz7NnBJ6oWpuya89JxPBPlwrZ9L3waM6Y5HacHLd/?=
 =?us-ascii?Q?0anMnLlg7WCqELTiF4VavMlBAOksPk0ViLmuIMC7E3lPnP0GhvkrjzdF8hkk?=
 =?us-ascii?Q?D3SD5rZluERP6YebcqGiyIR4e/MxNR+h/frSbpq1v48bPQvaliaajYs2MgkS?=
 =?us-ascii?Q?habsuowDTe2tzgivQP8Z6F4PVq2VXwgcKL5MLIprKj4xOUH28l6qPZHC0mxP?=
 =?us-ascii?Q?d9HeNhkY9XbyY/VOysvc+oEfpe3P++Uc7tP0z252w850RgqXnvJ1+QCRISyq?=
 =?us-ascii?Q?Xx3BsCt8z9q6VS7moNc7ATW/vCCveXjyriqy/HI8oRM0oTkXCsfXDWptr7UO?=
 =?us-ascii?Q?YGW+D7vODZIGwD5diUN5nZIGBBNPzBAf0VFnfnld4ViyXDyFvIz0SFUfZEqf?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CkgHYpWi/RhkOHyK5wJz1RflG3iCiayZXvArRDol+EE6oaQ92tGCLqMLp4GuihoEswgVoXCIC0PlzMumBGQsHBq78aVZgtZOWA//P8yP6/AjnP2iGsMvvI77cjKBSGquNqv3ZXJgRnQEUIAY1WoWYiCpj/QZER4z+PZbogoCDVKsy9SL+QShLWKnWozU868VOSNGysKAbi1f8cNOnVnTJXDCAQpZAMI+/Qh60hsbbiQTbPWYqk63ovbROzQvqJARQYgD0M3ALqAWXEwPOImFBhgkaqgIpEJFMBN6EUARFyf0elV5ZKTnc2/VCQZaA5JGEShsbFsp/qPODMsJ/WVibI2BArDWH1nioNPyPbYCaGUThvNvUlCTXuBTp1VTsetHUsO2fr/7ghyCmn9CjSilcSvyDCeWxpiFtQWbjf/sg45zSJNLfzll9ahOINhnAl2z+KEVFPP42jtCFuOUX8+I6A1nlkQNzi+O7ZKKoYgSpgXvnT6m3HQahiJ8Mll+xYssF1XRpv7EMVmmRWiLynEC92iWX4LVvECug1gc/18yPjqkl8Yp2XsWX4txR+tKRLo+uSM+yZobDV8CaBosVNvYBArxfeKsZil+oJDoY2FFeQE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e558e9ce-e7ca-4bf6-100f-08dd08b89195
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2957.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 16:38:16.9673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DAHdhavWcHKvKyJ/Tk92S5u7CblWZEP7pnnQCu+SZ0SXRRNmaW8DNCYKLWfGhrrBX+AgcMWwjx9Zn8XJNjwQ5CnFUBDzDe6OrDRbwRnFUiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7438
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_08,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411190123
X-Proofpoint-ORIG-GUID: zyu0mCG7ZvrSAjxavWcWC4PYbU8sijp_
X-Proofpoint-GUID: zyu0mCG7ZvrSAjxavWcWC4PYbU8sijp_


Christoph,

> as John pointed out there are a bunch more helpers in blkdev.h that
> return int when the underlying value should be unsigned int. Thid
> series fixes those, and also switches those that return boolean values
> to bool and drop a duplicate prototype.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
