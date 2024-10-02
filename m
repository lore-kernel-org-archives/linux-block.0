Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0757D1D1E7A
	for <linux-block@vger.kernel.org>; Wed,  2 Oct 2024 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885948; cv=fail; b=W0FSFffCqz4t5F2USYkUKxQiRrfZ7wSz7g7t4wHN8evttreDjIgH6dUNMAVJVlW5B99U+/j/86BFCtGHigtxs02csiNms5DhRmzlwoRHy+ogXWrBFnxUubgby0dB0jfb/8lglEx5jOqa8qTj2JeNIIkEo0DETuWC1qNZaaTG2FE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885948; c=relaxed/simple;
	bh=rvkulFKZ9a9jmOme2j2PO2CVUivywH9zeMTh3EtpwTA=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=gXia8HrFZebs5CVVAZzdCf8V18y+4SaduZlt9ar6byNHZ8UIVrIZ23/dgK+9v3lmmfLW+VPXrgYQInJC9NlQQAgcAYNlI3i7FYJaqjMT6WH2FFpT3puAtKw6WMKvKQiBo0GLBNg+wEcWAAhJ1N8DfMJn8MbQTVVksmIbcMvyhG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aSbLdkKG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yu3vpbBQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aSbLdkKG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yu3vpbBQ"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492GFn1X017453;
	Wed, 2 Oct 2024 16:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to
	:cc:subject:from:in-reply-to:message-id:references:date
	:content-type:mime-version; s=corp-2023-11-20; bh=QZjB2it5703iP3
	9JqTr3/yeeukt/+8TecXlmd0R8JuQ=; b=aSbLdkKGuRfHI4GtE6geVP4aF+iqOT
	QTD6/ToqObRygi96TT/nklG2AKnucDS5heYkiI38jH1DqQBBW4T/9Q9tHP4JxtDN
	DGg6pN3VduDQ7m3BoBHf0bftsK0qnsFujwauSrb/pa2FmXhwDMWJusXSy6GId8Yb
	73ntjjZ4APkKGVrcvyMt4I+Bg7/h9UvSWBTeI0klJuWW6i1vzkdwjuYIpsqgJbFe
	heF4JpCPS/lN1kx3uiaE8IbIcGejZelj/cEs7rdjw68brq+daWo30LiDDvJ3po2Z
	f7BbsCKdrxRfstly7zfez+AF1GrueQxw0ZJ7skP/dr2fgWSuRsktzkOg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9p9sqfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 16:18:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492FO0ma040534;
	Wed, 2 Oct 2024 16:18:42 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x88924mr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 16:18:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zd0EDyrUKIbcGF3uCfwVJZS/eFmlqVhg8BU7NtHMVAFfkjclBklX3WL7sFtdSYD1yU17cdUqg0vuGp8YIJCp0GVFmGXcvR5WJCCd0aWnauohYl/glKBgD9BaDxW7bD3lea3SFrsGul8LSTcVL3EyM2j/UslCs9mP32RCGv5tcYULKGWhzHJ6wpaETaE/YW2jZ4AttDm08NXfZyCrFKm8aFG0WUM1/zRO5rz5VkOZ4/WAKic55ssEiRpgZuwRskJgNKgWV7j1SA+Xc4MGgW4/80T8lG9jIpxvkT0or8Z3b9tT1Sa5YEZMl+juXXXcBnFX9Q5LtxqLzHjx8JRVvCFvNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZjB2it5703iP39JqTr3/yeeukt/+8TecXlmd0R8JuQ=;
 b=SogYzY/t/BGQYFHp+wZ31tACn/HGx0sWAumh9nK4jI996uwaCcDeUsPdEvax07yBszOeWIOs8G3z37H77lTE9U9likv22weLeQxGBmX2Z7uLfNnMegw3na/SMGaU8K3w4gV4eVLJU8ZAw5KLaIgVoExpNdDyN9AxeERKwTA+2Xa/5lEMKCpmt81ULE8MZzOHIYGJUWp3bTmwiwsGSPXH4ugZUstTRhn6R+TQ0YnArss65lIIP7f9Q/hBBjrU7h+i/uSmscZDTwPXJ0Ls0FCfkwnvbDbjYr6OTGwYO7bRn5CyHewyeQlrtYHgc8mvXYrRCwiHCvYpV+51yxUUCizm0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZjB2it5703iP39JqTr3/yeeukt/+8TecXlmd0R8JuQ=;
 b=yu3vpbBQhICmURGtELfACSwbGHJKCmBiIhdK2euwy1cP6hJy6TjyU3TQBn/1Ikcu7mPdVr4ftBMdsvRmaCLN0Bgpa4u3f+ZbmSRRpZaSxKGxifQZ6DzWrbbk6M9tirZRTmP6mNUEoiHFllvGD7dzfzpc0tSpYpjUIEqtZgY9S5A=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BN0PR10MB4837.namprd10.prod.outlook.com (2603:10b6:408:116::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 16:18:39 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%3]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 16:18:39 +0000
To: Keith Busch <kbusch@kernel.org>
Cc: Javier =?utf-8?Q?Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        "Martin K.
 Petersen"
 <martin.petersen@oracle.com>,
        Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, hch@lst.de,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        Chinmay Gameti <c.gameti@samsung.com>
Subject: Re: [PATCH v2 2/3] block: support PI at non-zero offset within
 metadata
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <ZvwXN5n1XyqRoH9H@kbusch-mbp.mynextlight.net> (Keith Busch's
	message of "Tue, 1 Oct 2024 09:37:27 -0600")
Organization: Oracle Corporation
Message-ID: <yq1v7ya4hgc.fsf@ca-mkp.ca.oracle.com>
References: <20240201130126.211402-1-joshi.k@samsung.com>
	<CGME20240201130843epcas5p1b1840bd14ced64a1effb6fd8c93c926d@epcas5p1.samsung.com>
	<20240201130126.211402-3-joshi.k@samsung.com>
	<ZvV4uCUXp9_4x5ct@kbusch-mbp>
	<8ed2637b-559e-3f27-3d1f-84a4718475fb@samsung.com>
	<ZvWSFvI-OJ2NP_m0@kbusch-mbp>
	<165deefb-a8b3-594e-9bfb-b3bcd588d23f@samsung.com>
	<yq1ttdx81ub.fsf@ca-mkp.ca.oracle.com>
	<20241001072708.tgdmbi56vofjkluc@ArmHalley.local>
	<ZvwXN5n1XyqRoH9H@kbusch-mbp.mynextlight.net>
Date: Wed, 02 Oct 2024 12:18:37 -0400
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::46) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BN0PR10MB4837:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d0a751-8e7b-4fcd-8e71-08dce2fddff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bcVcX6/w2Fw0mAPQrTSm11SdurX3AODfcJQP7OQncUd/fw1xFUtZFsBopzzF?=
 =?us-ascii?Q?AV2vnghgBQzzwfMvR/peBaJK/bexX5FUUXF1uVLtGjlMeBL7aKuL1cGM48EC?=
 =?us-ascii?Q?jcK1DS3BWE2VG4pL+q9eWtI1rdwWq2GOQDiOnGQzQdpmg1/GAnorlIDpG8mz?=
 =?us-ascii?Q?DlCsvQt67DUXjYe9NsmD9YPIrF/bEhKiv7A30DJaeeRTiyfyndR1iZgr4EfE?=
 =?us-ascii?Q?5z/WW4k5DC7x81YRReEeEdR2C5ftGO9Ai+rHSJEk1s07cK24sQ7KUm7m6NY1?=
 =?us-ascii?Q?nAvzOkavnMcNzbITSCkhY2lOHsqzOM3VfNQglpOFy2lkB0it2eHMrq2WpHui?=
 =?us-ascii?Q?2Lqqds3XSCVcgL8m79TZBX47upFB7JpFJP22OSo5cisYhEE/mu6wnyD6lR7P?=
 =?us-ascii?Q?IXPAN3tdm67hzOcPGxtgBSR/N8tZhKyC9Y/HH3sbxn1QDisOByNHw5hR3iXW?=
 =?us-ascii?Q?yDSu9L7JMiIQiyaEdGg/WbyqncudkfVCBZj5H9ntRk7bitBAMhnEF1X8dcuL?=
 =?us-ascii?Q?Fo81kH2mSmjnItbqShyoiAPWye6/3uu1uzJWU9bHE8H87oYcbW4ZFGnrYUyw?=
 =?us-ascii?Q?DQ/gQXu0Mk0TLgxDD+LvKNItwtT9X7693T0E+GWkFezX1NRSiRMcq/VjZSu/?=
 =?us-ascii?Q?QuSIv/7Var5o8sAAwrwRCYYQMBwLRVn2i9cREa4JH0cPAg+2DgWCClj2dgc2?=
 =?us-ascii?Q?uOMEnKFXfECMr+um0cKnHrCZlNdMgVR8DHzNNI7wbqw1C1I5k/vDY6O0q16i?=
 =?us-ascii?Q?JAWJZboaWrj7/YEZN6ux5gnxDeItKo5CnFCQ50x7p7KlsSxm9aHKdE5cxH6M?=
 =?us-ascii?Q?Y0LgHlKCI5QgJ2iVgkoNqUzlsN3MvEGLik1j48zurgK4dG9uglK3a9LZkqws?=
 =?us-ascii?Q?a3FOVnajlgZQmV5XoOlJhINY6bqJu7HK6NRyU5MIKiuGIT0AAfzAETTRgCPP?=
 =?us-ascii?Q?Y2LvybeFgNkuoLtb7691T7dvJCO84dLEbEL0+ILg/6+l37XWT1bjsWT0Hl3C?=
 =?us-ascii?Q?TowLyPco6mcVbSdp+PH3VtCn+w9EfLLQ/2HIVKx05LsmNn3O6y1+//L0siPD?=
 =?us-ascii?Q?NQLEhZCABZXdAHdkLZsJ0Eumakz4i8Qp2krkdM80qq5ZRJeMZixvGiDpCC/4?=
 =?us-ascii?Q?gQnPkpIZ+wvO+wcGDY1EgYPDEdVhrJplShF4yRoMbvfDXokb++mUmpXIo22w?=
 =?us-ascii?Q?P9GGKW+/6JkvumbMiX3Bo+CXS+fa7EJPCsjsHbEvxbojn5XIlHCUz2e9l83N?=
 =?us-ascii?Q?iFRE7Q1d7X9LThvjaKiEoI4VM7Fh5l9wScjCHOMzGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8+Qt/iZbXyAsFYCKJI3GaOqE2+2oqykFgJYtvsyquNwiJcVAihoyA0+CVxyH?=
 =?us-ascii?Q?uCtRLnRyd7QhJT/YvWeprbF/78zukPLYOO6THr7o7Eey1SYcg00yqkvFt0yC?=
 =?us-ascii?Q?rZIrABwV9l8d6rjQA7DTsOrkf1x7LUEkaKsBkInqI5nXN72mh6JBqEIIYdZj?=
 =?us-ascii?Q?iyvW6eM3osSdE+UstAxSkAd+Q2nbT9vPJgz+Cc/4jIfMTxBdXgqWZPD5bMzH?=
 =?us-ascii?Q?EIuWj3If/A3sAR5RqkWSGI9WtvEOIlbvg2Y3ZLL8VsK6enoepr6OspxfPgKi?=
 =?us-ascii?Q?9wjUx2DKxWpnCNaPm2GlQPPJNeZasKLLhTCJfPlPrPHXbTNStA0SoIQGUaxP?=
 =?us-ascii?Q?FJABaLrOgZc+Zs7u74t8JZeJ7QgA7yK5NF4BMqyC/hnpEgxk/eO8yCtg+UcN?=
 =?us-ascii?Q?EYEnvYc91lBFXFBkfY0DJZBni4Q8TuqRsMpwufjZYrhWzs4uDYAMmAscvJ06?=
 =?us-ascii?Q?mMMHfNBqYhvIxCjaxmjI44QprLy6KgsjJ5xyRdCETLJohJ7QNu9EtKI2sUYI?=
 =?us-ascii?Q?Io9rJ0WG8AkQJJh5p4JY2HawmCjvplYT4uWxbYGEquyI6nmYOk2TJbq1LCCZ?=
 =?us-ascii?Q?nK8xrLq8bt/U2KiRThGZnMtQVGn0V7zTuY01PBR/M3V6JMJav21erzvE5ByR?=
 =?us-ascii?Q?iYCfNbhi4SSnNXZPhQE9Wwh102ialXwl8tiVwxOsJk+Pi6zGkp7Rio9dsH4B?=
 =?us-ascii?Q?de9kssr5zk0E8YuZXtWxGAtX8JdMfSfnfPSM3kafYWq3PU9+IVOnBJC5Kepr?=
 =?us-ascii?Q?VNmBhhqGLWjGziav2F70Tgj0xSX58+Hfto+G/vN5eyj5tjDEPG7ZCYBgiLXO?=
 =?us-ascii?Q?XZ3MBlPdX/Hsnpu5vnuMrjoVV9645eS5C5lq2gnKiGOao8TAacPgOlDl+iZb?=
 =?us-ascii?Q?XBCm/WHYSkhc0NXUW62l3LGPzgfSAmOAjjPC3HNLZf/x59t9EP67QONcxZfY?=
 =?us-ascii?Q?XFhgl2FrmwukLoQdNwGWVsryOzPSYoIzVLqtPt/HNuYicIZG91/c3owT7KRT?=
 =?us-ascii?Q?HH5vQSAjwVouXLWGkMRPPEnbCAnzLj+ZvOm4+s8U1p9YA7AMDTTdtkWEhQGa?=
 =?us-ascii?Q?fDfJx1qp5wOIU9Zaoge1C7Rqk60HV0kEf818DHmG9ire8MsbBsU/56sZN5IN?=
 =?us-ascii?Q?GYCRCXvJzqCgll2wmdMZ/sSe1ee5XM486F8KznCARepCkW/+6aJfaIoDEDh8?=
 =?us-ascii?Q?fJ0iy/0dkaJw5Zh0XyyqaXJy9/0wlT1hn/FwPyDz3xjay1XzOHepq1r+j4nM?=
 =?us-ascii?Q?9jO0R9j2xk1nyuk+AeTHOI61aS8aabzqLtkM5yF4j2h+4JOAZ4nuT4Haf68E?=
 =?us-ascii?Q?0u20bfEG3Th5Mb0P8add9IP7TxHykvtW0MBEBhkjQ+/O3qIYcjEOquHVoSBS?=
 =?us-ascii?Q?/5cCG3cnzSmkBbSl1lWHFeyH+bCycComnjVnORwfegEosIsp+IA08RPHTrf0?=
 =?us-ascii?Q?KOc7F1j4cYT0xHKRt5VdQClEjSOExup/M6PnFiXy1eQ1wHiEmGct2DtloOsr?=
 =?us-ascii?Q?DLtEANOENFuJBuyuGIsOLyFZXQ6CWkU5ZhbXmrs6TIPg9j7BIUp9G3vw2qSG?=
 =?us-ascii?Q?9lRfaEB9qu2cRY/7dFZbzj10ZijUK9VTIhcWJRyFKjcT946VdSta8YMuhylK?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FSSc0b23twFmRTmBfv1Rr2njvvA91VcQ6RcjUeDFptwa7Cov5faMxjbStGRWM1S/YQ8rVIIOPO9m0fSHUmTKTJCXWGxPTor3mtsN6Xu5E+MXx7PUtExmeYwyBGkQPPN21Y/AdnYJwjN4BoSSYPAi5N0l2XW58mawQNqQllFoAPFucMScxMQHlIq8xhyqI11pM3JuKKjLIyA4B6eJfpcSiVFv4tQb3dbdB2kjfUEaDQNbZ6ZldwS2bUflJ9MARYUYEDPIeE2ExoFz+Xg24B5WSs+wTypZSxMT+MW67xLWsHWzdeQQ/+y6LRIWTnRvHKnoDwzDw3IKmEfEncYIwX11/SX1JQReHL9xjeMBL46GI01piBcG1DK8FMbNnNt4q+wTIyqh/s5zivWmFRKXbq9JLN+Cc9kIDH9BDrJHJMKwlMpnbrn/K7oAjDlf9p9oAP8jkkn6X9UT+8FzUyD7GSvyAsuGMFUCQloDk3/MWvwAp7lGP0VChBN1TeilG5JgD7VdQHJa5abBg9YTfY3Uw84XxjdDIULYH7WT34fTgTYbhB0a74HnKvu2MSRPX/r/uIMqs9kdmuEwrJ+w+uKwf33wP7MZGRSXqeaewadsKuIWRZg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d0a751-8e7b-4fcd-8e71-08dce2fddff4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 16:18:39.3813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0AvaxtfpU0jZyjpAysmhDgcrpq9cj27sbiUpTujVkNkuWSA3jc4oCAtmAklnlKrm7vTTv2d8l8ltY6jMdlHNVkgnwt7k/Vwm7tLuNr5xkVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4837
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_16,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=701
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2410020117
X-Proofpoint-ORIG-GUID: zOE9B0QqpIta5T28LwmOnAfWOQ3moQoa
X-Proofpoint-GUID: zOE9B0QqpIta5T28LwmOnAfWOQ3moQoa


Keith,

> Besides the passthrough interface, though, the setup uses kernel block
> layer to write the partition tables. Upgrading from 6.8 -> 6.9 won't
> be able to read the partition table on these devices. I'm still not
> sure the best way to handle this, though.

That's why, despite Type 2 supporting offset ref tags, the kernel always
uses the LBA. This is to ensure that any application which doesn't have
prior knowledge of the contents of each block's PI can perform a read
without failing. Including the kernel itself when reading the partition
table. But it's not just a kernel problem, the BIOS also needs to be
able to read arbitrary blocks, at least at the beginning and end of the
device.

Many of the features of the original DIF spec were squarely aimed at use
inside storage arrays where there was a single entity, the array
firmware, performing all reads and writes.

With DIX, since the interface needed to be used by array firmware and
general purpose operating systems alike, we needed to add the all
required features to the interface to accommodate every use case. And
NVMe inherited this. But NVMe did not really capture which things are
suitable only in the "single application" scenario.

I'm not sure there's a good fix. Other than as a passthrough user, the
burden is on you to ensure that things can be read by somebody else.
Could be backup applications, virus scanners, system firmware, etc.

-- 
Martin K. Petersen	Oracle Linux Engineering
