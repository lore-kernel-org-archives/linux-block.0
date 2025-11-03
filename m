Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59707FC0A
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 03:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762140311; cv=fail; b=dJP7VCQhylJORBK8GPoNp7vUjkeifGo73R8lkEYIi98imv3njlUo/3zhzaAWf6B2LYGNaWiRW+YkiZ2BjmMhMAHbT1TtY/oy5uD3JqqYyTRyV2CShy8i1YYhyVzSP/3u69WY/Qxp1LF9r2exCDwP32Lm3UOUEZy487Vkjg3m4v0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762140311; c=relaxed/simple;
	bh=7MDQaPS+dxBAoPS7dwehaMmzn7rpfFIvtgS2AYUyuDM=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=C3+ccJfI0UF6eQj7miOjZqnj8acmoPot/txUgG4C5rvZZxuEjXQGlrodmB7U5JQXRy56UFqzoSOXIYg3ueSQwVh0pBBHsNLssO561cLYvMDh6xp4OtZtyL97IolKDk64O3zrgxAwaOlWwlru+LJ7JXikTidilSGWd3ns7SPlp2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X33v7Ezi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Bndh9m9m; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X33v7Ezi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Bndh9m9m"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A33P3pq016820;
	Mon, 3 Nov 2025 03:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=5mFiMXMgQrUuK8dsfI
	s8xUlfiEaSSP/4DHZoHn59+Mw=; b=X33v7EziDAMmnciTEnUryjRHzCooVWtjlN
	VVijt6RY/7sPSDP7kV9MhaKswxjgr9De8KCqqFsx654fzg9S3STZnpfDeTUXwx7G
	GYKkEEDbq/F7+LLGr4kiMgH8XPQe1f/OhrZqx9WxLxDReJv5TNJIUvoZJL1LHvGV
	STesW8qclBrxrobCcyvJLLAC8q+9C/2zncpLeDATdpHkkxB3QkBkmSWgIhv7nBIQ
	6O/Scb8WFs/cc84whfkSjEh/+qleW63WdOAqcoQ0e6BDeqBGhktSYaTY4UJJkaio
	J021OOJ4AyO0lzAKdOofeNMpyGwmbwF4Eohnm1VZ7ibEZwsRqL2w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a6mf78007-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 03:25:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A2M51in009646;
	Mon, 3 Nov 2025 03:25:01 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010021.outbound.protection.outlook.com [40.93.198.21])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nb3abp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 03:25:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZdJugf1cx4iGktw5pGasvt0brztVJA9MIQsZpbFz6RqZgBkCjvaqqKvNyrmHFt1Z4tQ73ENh+LbOrtVxGKkTD5NbixH8m7wAOakh4w/5Dwgeq1IUmFtY5FWzQguFizcyyp6kZNrjrT5X4XlwgjKMw+3G0yGupS1nQFs8iV/9redB6C1nAMCJvGnmiNFyBjBwICyDkfPhpQUFaHkI5ahDTH6/+1fDnmzKhGBKg1Ylx0K1HJ2MZyeY6KVJmjqIJp784/Y2W5xMPdiOqAez/eTUx9RFrcFqmgIxjptsjLYBO5lk65gsuHk48nIT/psYMmAnR8EXUp4FRU0U24RCSBiDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mFiMXMgQrUuK8dsfIs8xUlfiEaSSP/4DHZoHn59+Mw=;
 b=fk4HwSESAwXl3ct8kOJ1l4SjFs3VML5sY1JqSsxIoz3qFHkIRkPyhhfFUucB1cw8mugHJmnvL4Vr+121GGvouRERFgIpno5lh6Z0ndMdPhBUFPowfBtQgct+e2Y/ySKi1uwDok4pIsWPtGwvm+YVljw10cvNN0VoZ3yrGUTtu67a/94h9LadbUdyfoCcmILbqcTzLRrEfkhUR0ltWXD5hsEKNQZSnG3Ui5xFFJH71c5h7Xl5Nl6oVumu8y9+9cMErs4SDWQYLRC7rKrtVyuZ9CadFQTIy4L5oBG9VJfukXR2wL7t11W6K4z3YZwNml/FckymO4g+HkTWhKLKeDme/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mFiMXMgQrUuK8dsfIs8xUlfiEaSSP/4DHZoHn59+Mw=;
 b=Bndh9m9mJe960tjlyxUW+WQxg4eId/LLlRsDAmvdYIWeKlFerRQWaHPal/DtQzoO7JiTQ3kftZBEs5IFfTqfUUMi2RqHQ3uaD/h1Vtm9mebQke/hDUDerM8r/enFpSmSni2QH4rgMijriKDnkUOpfwHluyQARoZnoWGuBBjQN7E=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by PH0PR10MB4790.namprd10.prod.outlook.com (2603:10b6:510:3f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 03:24:59 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 03:24:58 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: make bio auto-integrity deadlock safe
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20251030144530.1372226-3-hch@lst.de> (Christoph Hellwig's
	message of "Thu, 30 Oct 2025 15:44:54 +0100")
Organization: Oracle Corporation
Message-ID: <yq1seevreai.fsf@ca-mkp.ca.oracle.com>
References: <20251030144530.1372226-1-hch@lst.de>
	<20251030144530.1372226-3-hch@lst.de>
Date: Sun, 02 Nov 2025 22:24:56 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0154.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::12) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|PH0PR10MB4790:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a94c81f-41f3-4f40-5ea2-08de1a889132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t3Ay73AyFSgs+IXzkMiditJ6WCVLWLncAiLy+zk91M6UlZayq9jKiCRCQJP6?=
 =?us-ascii?Q?NKNJicV4gTm9mza60ZTMRYb1ypaNVK/oNPwVrOcxeO0AhW+1f4D2+GbBxUeX?=
 =?us-ascii?Q?56TmeWqmx4EnX9USLudCY0ZPFD/fEV+WW4vaEF/GJLf8RfTzJLucyMh93bBh?=
 =?us-ascii?Q?rfANaoTkBk5JCTbFul/Jfq1CL3441efW1WiyVMVT2FBOeAGYBaEnRvgBi56E?=
 =?us-ascii?Q?Am97reGU5BOkENVB2bDeUQYb4yW3pHa7qE2/SQj32iw1Ee5SZjc5CGq5sXO6?=
 =?us-ascii?Q?xyp58W5a8ADlKkuL3PwVxPkUHlp3aYEQRVB1Kj9IhUAiChdLmSOqES3j/QqJ?=
 =?us-ascii?Q?zV6arcPMJGhedSC8b2LdEoTUPW58kWb7f5BJkpsH11eKSv04RDq9yUxbR7Q0?=
 =?us-ascii?Q?0/swqdkBq4XBZCREwSRQDtnTFDaInEmg09E29amClj3c7bJRY98ZTXobVAh+?=
 =?us-ascii?Q?bOqYh4Dl0M6QCQKRoVYpz9F+9+MKzZeWaq0Za8zx0KyFWYAlRv9Nb/kSFpCD?=
 =?us-ascii?Q?BZgnojy+IZtIB2xCr/Efz8DplaI2ziAKigLqy+E0tthY2dfNcY0lBbPeqV24?=
 =?us-ascii?Q?gve0pk1BJQznynhy8aVn8z0vtfmSn41e/Vp97Avw/W5rQ5x+M4gz6ZzoOkO1?=
 =?us-ascii?Q?vjUuwYcOcMAMYCvni7BDaU9Sl7m2UvpdUAttdiGGYN+Jas8r3zSMsSPK3ZwU?=
 =?us-ascii?Q?Q+pp99dlvSg0pZqoOD7ejDXn/2MYVVdtICQynqzUhj631pWOZ7vrI57rHSfd?=
 =?us-ascii?Q?cH13PFbbag4vhQew85cWRH28Tr2uxIOn8ptYO3hyPNLLVpFXrG8qob86DTg+?=
 =?us-ascii?Q?Gco5kp3XOZfcSOBRZoDJHHRnim5GwoO7UkU9S4SjsTEP5QQSeXODii6fg40z?=
 =?us-ascii?Q?0NnmbfqospxAp7/xhL0DMM8GwNxPtxoG9RskGqo+LQkdJ4rENmIIf8dwYAEv?=
 =?us-ascii?Q?n/qiqKztM7gYMG0ZFUbGHh71R3OIr6eQ/WxUPfDfBkFOsZ+gRUo+gRFYYCZI?=
 =?us-ascii?Q?LQirNY3mz4xQLRRnP/4/87d4J063CtTLuxnUvT85eZ9gH1e94KIC7xE7rWWS?=
 =?us-ascii?Q?bTBQTcXLcB/0PvONWd0TUb6gJ8VIhzLU2u7ZhwrsN2BdYKRjcK6QtpO8g/np?=
 =?us-ascii?Q?wPPD0sgZy6YqpVJt6O0rmN9eXCrhvMH4pe/49V44XpWL+FqCBfD43vv5vaAt?=
 =?us-ascii?Q?/mHW06UWoeSTgAXOPb/7C6Z6qgYw8cVPOjVDVPVLPtAtZRIgwcVVxTdZ2rTe?=
 =?us-ascii?Q?VqRsQg6H6TYErSXeuMcV8ZA/LlDj8JTT27rGYP/GrTaBjSl9w/bHdGy1l8SQ?=
 =?us-ascii?Q?FTR5RrwlCAzYQ+UDxUqY2eT8aqD6pnsUZpBXW+aNAUuQLPk9vT8McKBY1kwy?=
 =?us-ascii?Q?rA9JaYvqcTMjKiC3uE2V0R1i6myuuCzJVSv2dqxIf56khdLb5ZQA3Czh3gvh?=
 =?us-ascii?Q?3Z07KRFe62d88a6ZzJQt7WPimkH0GCWa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sFULR0iXjT6vPXYAdEfEUEW3b71sxahmqHORqG4MXd/KOrQMxNPIL+U/4Ue+?=
 =?us-ascii?Q?ppqeC4uGhq3xftYQYifpGrG8SqLtpsQltLV6avln6Lbkad/FOXzweSY7wWjz?=
 =?us-ascii?Q?XOK0G3KRAwz/S1DIWRL/ELO/Hw9a0FBa+ndgo5fOR8RVZEgVqqxAGGipNNpV?=
 =?us-ascii?Q?EV3/0bFBdK0lLPAbiTrsH+Y34mBrBCSYFO1NchN5an3JOyUGWm3aSi2DRFWv?=
 =?us-ascii?Q?c1KwEKMnIUWoHJUvDWbbWoyrhOA9T0hjUmRNMUC0h/WKCJo34BlBqLqqlesz?=
 =?us-ascii?Q?/TNeB9vWnLgHIhvez1MQP9zW6EgKBReRBHbNf89gFZPkpX+tKH3aYdT1VoVB?=
 =?us-ascii?Q?Z+XBXbPlqS39ZdMgAKSYsLpxT/zM0cCnEKEWbbBRh6pSjdzLaRBMMeokREk/?=
 =?us-ascii?Q?mO+fkgqaiVIovyceG/lDzNBqzyKz9ciKrqEKAhF/KL4x4Bg7caiwRvqaZuBq?=
 =?us-ascii?Q?ybIiZdtpTnUF6fWNibYz+rEY7iFQxIgblX/kGNSDvCGhAquVURm8A+ayeCPk?=
 =?us-ascii?Q?VnIoSynioJR8/NRI+qg1l/rKjZQtdkvHd1Fz5qMMchThPEsZm10y0q5jTc9Z?=
 =?us-ascii?Q?SfOViI5vPqxWSe8vX+HnJcUOa+VHHy6zWrBwVfWaCfl/lcfeyZ3cVZOTls9R?=
 =?us-ascii?Q?uPwkC8sDoUy9iGquyrvOcAMyPZ/L2pEJWY/XsvdYpuenie6+nYEGGHpvZl4j?=
 =?us-ascii?Q?7N48cP0eKNV8T+O/1kYAXHeX9pwOQstswWAthgfAySsLLuZP3PIwq5TLnxmO?=
 =?us-ascii?Q?sJYPUz2QMK9cM69YyTVv5TGwiSOUGtgyV9cfKjxdIoj69UIUkZlxeR3hcmQK?=
 =?us-ascii?Q?AM/xf99f/tPakvOUpOk/pIU4j3P1cZwh6iPxg+vSGMEts11K8C8NbHr/sN0y?=
 =?us-ascii?Q?LJIZ4yeC+FhfIV/k5ngrLY9sLVJrmQ1WLdjlzjEnWmeB8IUJkZhSEzh4VPm9?=
 =?us-ascii?Q?sVYbIQkkSzD06CsPiACWL+eVUU4xSwnHaBmcRbcEHBSzZ+uNOGuXmWpwHsR5?=
 =?us-ascii?Q?/PhiCrKKXmWr/sdZGvTZQuKgTXPceyKlFpEZAl/7aBpKYmZYkjAbZCkPZhed?=
 =?us-ascii?Q?OFtCIxwQRY6R3LOOW331DNqQR3mEbWr753PqvTFBz/kS2xD316ItPKUMeoRN?=
 =?us-ascii?Q?if6Pt5ZNYOqgSetY86ld7f6KpSe0gae2LiyZVT/TpkIB/xZlMt4oZN7rIuoF?=
 =?us-ascii?Q?p1OF8VFmrcuz3z45p5dpeTF6LUgpREUhc6LRY15Z7Yr4aP6Qh9uJsXQvaq8X?=
 =?us-ascii?Q?bByFY+4+Io3ryGCk7jw1BsoacSViqxMqKyY7OJn1uFb1M3p20ksF7ccQiroS?=
 =?us-ascii?Q?03+6GwATfSJcdEh08j/B1bYIJxQV51DTrvhvKfTQP4fP44VjhNpJPPGH6qf8?=
 =?us-ascii?Q?ts9/XVi8M2PHa3cxJaU3o+UwvIKw7w7egng0HjnD9aFxxnPBFfhqdd1VEOBV?=
 =?us-ascii?Q?vwm4Q1iQGh0ytxSJ9nj900UjkGqKH2bdS1kZtjY9EHcTXPgn3jyAumCfdUqP?=
 =?us-ascii?Q?dy6rCmBj70VI0rZqqDvs5KWAVTb7yasA8kuUr3hWrBg5nW2RXYZ+OX2FlkpD?=
 =?us-ascii?Q?RS1mMjZoAMY80xZAheiK8SD3R1PndwnlRHzKIMTqjGegbf6+A7vjkVC9oOTk?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ag5cn043ankAPwugpEkDSJm9ZQJXMNR+c4CmL8KLCUcy0899eLDJLSBIWnYvczo0piGMsUj+uBq69wGCdz7A+ijOWwUbsoe2vhZbMC0djeRzYTnX6GCtbxHtqQYzVjXCtJAYXodg5uTTsxAMfgE1u9jxe+BkQvj+jlHN9fnPb1FvhrqV7xYPXybyY5aI6DjkB4LkaYrrp8J+zcUSNVeeZKpW0Wg/vyaRCv7OZlhKBICinZd4eWZUprZoQIRPgUnXftTezCMhlY2p41O3iGEW1fg9OykFrehhlFtn930yTj0xbMdpDs8m2KvUsiRUIU16Jsn8/RYLZdCSpA2X0FQYPtykoe9Mc9Kd9yUZ3QAaGeeV+CbpVY5NFaI3aBMBWvEQha07FAXxdCbFoGCkZQHlvsnwe78WCqcgB4+/hCFnlUSeGQnM1XGK7MF+Q2U3rofBvehoujocLFirYKsOUZ40BqkbVstEHyNsVcoeE7cmJxRn+gqxBZT3i187pkTre6Zb+Wg9Rt6VVSQjYOVdmxnGF7ZNAf6GW6KurXQceDQN1J8Q2GJWPTTNjoVDwJ6/jz6TtXNHhGIqoi/gCOxuS8K+d6SpvqP+5Iia6YaM3hSU7OE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a94c81f-41f3-4f40-5ea2-08de1a889132
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 03:24:58.8779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUleHaIo6Jc3/yugz3TIy8fjhMwqxREFwjNFnVymFibGlTCZsoFkcKkTksBY2o171MKTrd2xPBaVp5zockzNgyxET/UgFSQSjjsLgG05sqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4790
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030029
X-Proofpoint-GUID: 32MxBrF-TpJYXrNE9_gUNkpQv9XKRubK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDAyOSBTYWx0ZWRfX1EtglvUtBKEt
 w+pu82AsgK4S9IbTskNjPHuzQbnu3BiLk8wfvwckb1pZ02FRZNsekJgA5H77NTl7mA58DSFFHu9
 +LRLMN0R0TIDjMKNXGC7RqLzZm7zspd9DV6jsA0eTfSRf8oSKYkdnGR1SM2dx0tMs1Lb0AC9hzc
 WL3V6NzgkKq4D3uEZyvITuFy/PIuMF5p2SLvYoXfw/y1h/afv7ahQrIJ5nuWxff3Q+bkBg+6pOv
 +10NYCpn8LYnhXZuAzZwOI1hIlW/NXzpbEUXP5dQomybHPy/6mP+mx+G9Cn+9ZVOjwskf0bBdyc
 DdtEzYU7bcjOM5fFwWVX+V1AvpeRzcZqK2cU4k8Ol8kJmfYwRtIkv4eO/OxqX9cTNMeIKzL5+Zv
 JAGDYa9yMzZLC2ocicLgz6uQqo9t5cP+WVFm9/qOYC228hlW+jM=
X-Authority-Analysis: v=2.4 cv=PvyergM3 c=1 sm=1 tr=0 ts=6908208f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=gn3kYZaTo9YkCkAxE0sA:9 cc=ntf awl=host:13657
X-Proofpoint-ORIG-GUID: 32MxBrF-TpJYXrNE9_gUNkpQv9XKRubK


Christoph,

> + * Maximum size of I/O that needs a block layer integrity buffer.  Limited
> + * by the number of intervals for whuich we can fit the integrity buffer into

which

> + * the buffer size.  Because the the buffer is a single segment it is also
> + * limited by the maximum segments size.

segment

> + */
> +static inline unsigned int max_integrity_io_size(struct queue_limits *lim)
> +{
> +	return min_t(unsigned int, lim->max_segment_size,
> +		(BLK_INTEGRITY_MAX_SIZE / lim->integrity.metadata_size) <<
> +			lim->integrity.interval_exp);
> +}

Otherwise OK.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
