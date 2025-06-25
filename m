Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDB42E659
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 01:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750815768; cv=fail; b=cxcG8E57hAf2+fDrbjH2f1buGmKlgMG+XTPoY0raxOf0Ayp3pG2cwkldTdANi/egtSQha+Psk34VN51inGWNupr2sf+nnniDjvuXKPqGj/jseToFhE5KUiiu9ST2IKVqEIfTKBuSlq/oL96jNXYezUrjMlJ994x0qZZfsi58n/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750815768; c=relaxed/simple;
	bh=c4yPeUALkOB3wd3H/m9HcXv/IFxC62EGtGYs+wZh8DI=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=YIVVuVM35S2khTe63wsAMGZTVQj5/qVsiS7P5vhWTcIWhH5Gxka35NLT1fTjsQlUWP+Ca6IgieHsKijtvTf3UhLA+l73E6kvbjD/3a56JOCqLTPvhSho31ZoSjR40k9MTYVNnRDG6rHZYtAWQ687LqSqMaWcn+P5JP+OYP8/fp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QujmvRhP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t+TaCXPT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QujmvRhP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t+TaCXPT"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OMifNN027078;
	Wed, 25 Jun 2025 01:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=/omE/MUWNlUMSi1gOm
	JdJosHRwKpI0el5n0sCkRfRgY=; b=QujmvRhPWp+9SdCg6uiQFWb+/t6u6/hy98
	ynnBOZ5Fwj8FeFOJhcsVm4Z3hT2m8ZVb2r5csIvD9pWFnftcll1UenqanpdKVSc/
	kqQJb8L2wJDYzB4cmmc8Vmj3juIvWwXxgB1aJdvPRko5u00AME/IuK+8Eq+3WBKi
	tINsJ3zubjo3BxQRnfZMsGG/tE4Fj18pOXO46uNXXUfZQTu+KRSBcRb/GxMZf8/m
	rvly7tGPygPfCtBn/3N4ccy1kOzKnC3mzeDDYBwSn7VZE29JrvjJ9Qqp6e4A6m/x
	DB+lv6Z4LXSKjEMDL9EHrgElgh0z4sojVfl306lkhHGucRqRbLnA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt1d7s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 01:42:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55ONl6Dm031889;
	Wed, 25 Jun 2025 01:42:41 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehpqwnv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 01:42:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+NXgA2DXO8RGJdN8CjcLU/7glAicyRr+yLZHFaQX3sxqVyFowaTX4qOl7OPkdYBVisr8UxYEa2r3XQJfITBzx+hWUYL9KZ+q2I4U3/LVWPxAS2Z4C7vOOyiMv0B2pTy+T3QkX32Rpgw4sgm7CHjPz626zJggu7n89kSyb828L4cifqVdeViejpEUfXAkIP6mM2VKDmNLGjkTPzy9a2wBa9/m7uEicQigrdltSuPyDA2ryMpvUzMunGDdU/jLF+3TiGOZ6dHEQ50lWKueRNU8oHpIyjMoxk0bATDjUsw9R5sC4A1hSI+BnL+qyJmEaQtJkKrl/BsWXWQNiS0094iQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/omE/MUWNlUMSi1gOmJdJosHRwKpI0el5n0sCkRfRgY=;
 b=u/pC32KGyWU9dix9S4Sx0WhQoLvOYZo9EnRI5L1qX85rZLvBqxfZJ0Oa+VPhfvYopgH9UeqxwD3HbjoJaNx15nMMVt0V4RA8mJsyzIpnAdmcTQSyiHrTxtRk2muOvp3upd5UYdc6WQ1hajujv2xEC7gjdO4GgH/8QUPXozd+mS2zHYqk9FbyxwfknW8dOA0i9pCD1oz/JpaqmWNC50MrwWOhEu6qacjNcFk72fAn5+3iDHqc/wYzoxm/R/sEAEnbbIdcrqtGVbVZgjfFyWTFZQYUuSk88IWzMT9A9N5mJsFZ2c7x+OndVdsiRLTlpSEG/sAi64mDRhzqeHR9DJY7FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/omE/MUWNlUMSi1gOmJdJosHRwKpI0el5n0sCkRfRgY=;
 b=t+TaCXPTfwbHvnak8uanBMYtWXkMY2AtX2OFCLrC3mouFKU+UTMOlr5ajnSDtz9vIjo+8IsQnUhQXsl/bJrbH/+Td8ovCPYaVGDjkS9CC//vaduhLI9WwLbeidfNzolaA9ymBEnpeJtfxqdiohMaQYtmnheyitk+k63oDsQmp84=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SJ0PR10MB4414.namprd10.prod.outlook.com (2603:10b6:a03:2d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 01:42:38 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%7]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 01:42:37 +0000
To: Wang Yugui <wangyugui@e16-tech.com>
Cc: linux-block@vger.kernel.org
Subject: Re: scsi optimal_io_size changed from 0 on kernel 6.6, to
 16773120(32760*512, 4095*4096) on kernel 6.12/6.16
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250624091020.071E.409509F4@e16-tech.com> (Wang Yugui's message
	of "Tue, 24 Jun 2025 09:10:21 +0800")
Organization: Oracle Corporation
Message-ID: <yq15xgkoayn.fsf@ca-mkp.ca.oracle.com>
References: <20250624091020.071E.409509F4@e16-tech.com>
Date: Tue, 24 Jun 2025 21:42:34 -0400
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0277.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::12) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SJ0PR10MB4414:EE_
X-MS-Office365-Filtering-Correlation-Id: 72aa67b0-1f1b-47a2-74c6-08ddb3899077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V2JnxXYWZQ2hohbO9YxRfR3AsbvVaenizGaKWWnE5de26rczEQE7nVXo5bLV?=
 =?us-ascii?Q?jI5zjzI8tZ/hkV6ZJVtHu6huofzvvgbdZanFJXKq+Jt/FXXm9PTa7tWHnHqG?=
 =?us-ascii?Q?HsQw8jk9RzNK9qmsSpzPF3bWs4LxNhqp8Yl43xkUSSClZO/wIbZfsMMkNeGa?=
 =?us-ascii?Q?lNDJ39w6TH4Pp9PTwhD2I3TxNI26+4mXCIiq4CktiS6eNKORHtCwsCQ4ofAJ?=
 =?us-ascii?Q?8aZH7NqD/Ch+/ebeJbeXhQqWDURX18hKB914zxG6R9Nd3xUzo7EFFFtydEYq?=
 =?us-ascii?Q?22cib+FWZQqyM7JEQ7gEvnsIapMhYSby+kTYzk+AhnlRQThq5oFI/axnvfzu?=
 =?us-ascii?Q?Nl7xGm7X3wNzDkK+NCpB4H8XneiCwPpiTDa8IVBJa9tXCYs81/6QgcbCTOTz?=
 =?us-ascii?Q?Y0ZiTtUoUQm0WxrdRqwOFDQ1oob17spETMa3AIjsq4A2T9y6NDi1NK9e5I9c?=
 =?us-ascii?Q?bpJ4ifUnNlnM6pw15Bw+cc9usCL57tyWmhXtrvutvxMeKMOFjzUMHt5g0KZc?=
 =?us-ascii?Q?TwkXbd4yGYvUvZo/Jmg1OGdG2al86QUTXb9L3cYH6CHT+/pygXKpBGKZUmNs?=
 =?us-ascii?Q?zw84IwqaTEGL9AATNW5FbAdCujUZ+eaHQ46HmFnPV/LphZuiIjPri3gin2BF?=
 =?us-ascii?Q?YUAyua+eZPkmlVu8KvJ6et5ONLMszUsp51HyFG2KEcSnYUn306Ytip/YamTx?=
 =?us-ascii?Q?TEfzndCuP5Brq5wgGnasOKSjeM4VsqbVZHtFsLiUr55XB9vJnXgSLCxnozde?=
 =?us-ascii?Q?WpUztb0q3N4kTwe/Hd+of1ee33uMBWJC5ikFW5SJ3hhxwWUomW9cuMLn6fpY?=
 =?us-ascii?Q?OG4zyeAVagOARKVwq9XcSBUAwa5lVpcaEFmtS6HQ4XlBHW6EfJKy0rlr7njS?=
 =?us-ascii?Q?N9WpRa0mduSaqgVrkdGIO11CTlEeGiBUnp9DS2ZxmphhHO/Co5wn1qhvustm?=
 =?us-ascii?Q?bg72792W3o2qt/NltgdiffLOMBBJ3lTBbjCHE/umDX1QY8oaGToYxn6V19EB?=
 =?us-ascii?Q?fYAmog5e6FOfKibv4ih+ezC2fm0vfcYGAOHYW6kKUEI0ioT8LjeyFZQfz5nF?=
 =?us-ascii?Q?CZbvw2pW677qppSTk/3nlXyNH0jXkZEs2hUSSDjfmycfgbv1ZMc7VUBUPGcp?=
 =?us-ascii?Q?b50vVv1HMUUuhVL2nzh36gqv1jTHhxevQqjTLav8mPjXT9gtaCZbSYwSCLmf?=
 =?us-ascii?Q?K1dXsEJhMvceCGRLVIxYBRoOY4F9cm0LI7OKMQ1ELF0Z0SJbc4eODhataXsF?=
 =?us-ascii?Q?CQqFEIpbwcU5IC+CRIHXgv/g/NEcjHLhhoWfE74r5NpnSW+MrOSZC7MBOhzf?=
 =?us-ascii?Q?9pjiEMMEYkObQ7tE9EPgff31mrJyVvP3Hkn+B1Bez0Oz5kkbvNXvaeHF++on?=
 =?us-ascii?Q?NRSfAMEwKkcwfrbi32x36NQna9e7CKkqwSFTsd8loEQ/sViIsvpgtKz2UL9d?=
 =?us-ascii?Q?4Lj5gKGmFIs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?maNUgRTeCis88Ax+WXPf1nKB5i+P1y/fAnVd3ZFGGIvAg+8L7057AAbhf+lJ?=
 =?us-ascii?Q?5AG2IhIMbmIyvbsarhHGHcOhoVJu+Cid9zGYzT4IPhe5XuO0+I+II9OZtJbQ?=
 =?us-ascii?Q?1slGmbH35KxJ6tCOrbl8/HFQN0u9nrDAmOcITa5EpZX/Bhw73i54rgrimpL+?=
 =?us-ascii?Q?5malNE63EQUTb1tRbPgOOBtM3VwP46QHC0ol7usjWdcSUpGAi5wDfWB3uRg3?=
 =?us-ascii?Q?kq3QdUDd1bZG9v8z6H2eWB4jeqAW/ZJMi8orIMXX+7vk7oMSCc56KCRcPNe7?=
 =?us-ascii?Q?Xu48j5niZDaQ2zIBwioVHqqKCYgkY+mFjS7UWFDYmx2hgrgj/LuCLOK82EJm?=
 =?us-ascii?Q?Rjj0T4IHsKWjzoYV9SpPtBi2+qO1d0krlSBll7kMpgUWYAayX++yPNMmdgsc?=
 =?us-ascii?Q?mI0nsW88vZohOB5tVRTt7kMeR7vKrh5rCeLJ/0DTo/MnELelgsmiLGR+Ju49?=
 =?us-ascii?Q?wyrunv3GL4zMrBvJwB2s8hGpjxQS8PUv61xPdjSf6WcrwPvzld4P5CMJOVtw?=
 =?us-ascii?Q?US/GadWdwZ9hifNP0qy0KG9yDtUXk9dF/bU22AAqWZN4Tm73M0KeBn8hhmZX?=
 =?us-ascii?Q?wAW9gPqZVVhCUgiAUUlKqX7aods2xfMqzOqIczapt7lOWt2NiUEB57hTq/p/?=
 =?us-ascii?Q?Vy4F10+4EAITUkUK/H87zsr2Ad/phs54yoMte0FnZNuUzfCyDC+IJTJTT/1b?=
 =?us-ascii?Q?+yOvEoFFpb8uX1b3YQNs6dvUFlc9bhX5vMUrwHXjGP7wCxaIU8p7ZHwjWKYI?=
 =?us-ascii?Q?y0Sw1NhcXap6sODGSnWol4rs1k0Z6X0JZzoNlD9dl7VwFKzTS+12DTBeEMem?=
 =?us-ascii?Q?BhDCiLG7Txlzb+Jx654NQunI466A4CIC20KwczmvvlSqk4jgA9YXekEV7y/L?=
 =?us-ascii?Q?sn3OR+aPZxyvX0nR5TcRHYAkDCCgsSyHOv0fEpxEeYoXwWjgSbqKeZBP0j0L?=
 =?us-ascii?Q?kkevZUkhwfvcp+daMSI5+ma/FDJjgfnf61jzIJ4LvKCAPBcH0cjn/NCxwNLk?=
 =?us-ascii?Q?LADa20sFR1jd1uspUR5uEjVSf7ql+MbvlTCOFoRkF47CYpOsMcekD+6FUNZF?=
 =?us-ascii?Q?uPF+DXKG9/6VGdGle6W2uthkLcYlMycth3tWnCFvoOE2M0GpK68l4N9EYb/1?=
 =?us-ascii?Q?6fYXJlLU2atK0V8BPIMznCSk+oVp8T4/DQ8GaFBtZHNI6tpXHOE1eKgvYcs2?=
 =?us-ascii?Q?rKnfYgNQSx6Um0f2/zOYqirZBXS/L3+0u9GHkrFUi5qWQU+vxEESOjNwJuPy?=
 =?us-ascii?Q?VK1eXK7VO9FlSm2k2ZKLN1m5uBqBr3B/yPQfpmdxFn4KUTeV3PEXtG2Gtixd?=
 =?us-ascii?Q?5N77FzZoYl3jKKenrNjbJNOs5Zkblmb+pKmq/6CFR4kL3gXeWl7ut1otikls?=
 =?us-ascii?Q?ZuHROkdouvGMLZkRLoPnbzm1MgsBqHjA03ojZQ8mw8lWlLw0fyW1BC4XJo/M?=
 =?us-ascii?Q?hkkE0bmQdYqXQev+2CIEBHYjB9XAMyawg+uPtcwA3/d33eGpYfPIsI9I8yIm?=
 =?us-ascii?Q?Aa3ctICEUNs/lgdR3Fuq/hoJzE/8a8QoEjNq3Vu6Exl7PdW0c20R3QCyB1/n?=
 =?us-ascii?Q?FrPGLIkKn6Z308OTMxnw/iqL2AarhRI1xPfN8tvoHgeqOTadXPwSi960uGA1?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	75KDz87qaGHAM4aRwx2Jw246ioB7Pst23mu78XPGjDQ36LQka4zYKZOIwcLKvYcc3kijaEQ+xEe3F+MDmGea3ClRzo/j7bwwI6Tlwksxt42lPa4RnuPE2julJF00+iADkgIXv6RzUdUVX65IDmEKdVL0fgYr9D/CuDiySRvUcVf8fwMW2XKSCA8f5HPQv4R6FiY05WCi5sexq3HTHIcH9h+LuhZrBIXdjRWFVnTIeLd0YRUfJbBS6vNK+ptx5qYMe40uZ77W9p78C28JOCkJMvF66aGpteFqslbe6K5y6Db8Qxfmarry5xyMuAeRLKNzatAdbOAWH/dmlAXy+C7yb2yei3GENZU6mDr+CPZ4QkmdpkGm6B5YPSeMjxpSyKFtphPUA4/uUV5N2N0cb6YEr2pSG3wYF5YYIVgRWK9L1GCpM/kqoO61sH4Zh7swi4+Bv6wbvAkXTrJzbi3he8mj/sCtsXMCfbOe+KNsMoZ20LYfEK414bdGJ19eqYA6XVfvJFqSu/LQ9GSFuDEFZcBWKMsi7IY57eY610+/kc6YoOpTisbA7sw/6q9pJM+rWV4UGlApvP+7Hoz1C0JkQcUh8IE2AKvqxLpeMHOl+843n6Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72aa67b0-1f1b-47a2-74c6-08ddb3899077
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 01:42:37.6396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MV12tqBIgn09xfyfSErrHOPHwxJV/bEXiVPDEOZSVHJKB1XdJlX7mbEJzm7J9bA3Dsfpcj4ncK47MPyDJbeiVPZZFwyD9lppOxDPRX29od8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4414
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=796
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506250012
X-Proofpoint-GUID: 25-pPhH-9WSAET9XXA2RpJZYoJKw1jvN
X-Proofpoint-ORIG-GUID: 25-pPhH-9WSAET9XXA2RpJZYoJKw1jvN
X-Authority-Analysis: v=2.4 cv=cpebk04i c=1 sm=1 tr=0 ts=685b5412 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=XsThDU9uBpSvB1x01mYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDAxMiBTYWx0ZWRfX0WQQ80BK4sac dPrwUFfK7Li9caIw8nvX5tfyV4FU0jvk5BCIQaP3omlRcJImk3ki8/kSTUQTrl3GlidDUwe1OOc ioZcyxqZETFHM3CSpOvaGfxFsaNqdHJc7vVvzipMiUb8tLRWEJK48xnnkjpd+Jh6dBi5MV1/G/p
 Y9CyzQFehtOaArYilS5iHeBizYbwbTcHdDd2Jr1RnckUQYFkmmuQqsJfUkIfnpOYeF9CCMe4CzN CvbS24ZUwsVFB0sbL0fZ06zilXdJjEYv/DYz6IQhHFNhl6HW9prmXFrvOzknsk2Vi2Rw99KOzxD ugRKyg/XBlIw7Dndp8++W4WReRZL9a7WmMKtOHKevlx0PqRvP+11IvfKCRD7cksEzltX3DriRuA
 9w84TZ2sTQG9OXwGvCxAW9JtsbFPqrRyhJtob6wjsdWTgywUYrJtU5L8VV44aaG69yHq7KKi


Wang,

> scsi optimal_io_size changed from 0 on kernel 6.6, to
> 16773120(32760*512, 4095*4096) on kernel 6.12/6.16

Peculiar value. Please share the output of:

# sg_readcap -l /dev/sdN

and

# sg_vpd -p bl /dev/sdN

Thanks!

-- 
Martin K. Petersen
