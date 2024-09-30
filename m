Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A01198A29
	for <linux-block@vger.kernel.org>; Mon, 30 Sep 2024 17:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719088; cv=fail; b=bwt2hoQh50K9vd5gZQC11yGklB1oZC7jm1d+XvEblMvRSXP7vn9yuqqLd00cx9ydEsoXTSuMSTDB7j6dP3n6TblRe0GUwGtijpQzm/VUI6U6uKErB8SFXlyPWaIDPe77Mn6uiSVZdwyO+Ev14TGQkrVyx4cZfUt1+NueeRVsvus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719088; c=relaxed/simple;
	bh=bKZN4SzUsqM9DlL+UFGCZgEzu7mfzYJJir+NCdzxzD4=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=Qpf/ts+AnVE+zxdlVNjzEecqWt7FbwAJ9PznuUaIRD/Y1jQk0Cp06nsJrRMDAUCfLAVFVayTbDBns0Ynof2QIJhZMXGeHHOTuwCiWaZ1ad9VfKnDZbH64ZP7dv2QiuYBlGkIYD9orWtXQMLyOQr/jDZjPMxKVHqYM3FWVqFR7Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jF3ByPDA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uVSf4INJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jF3ByPDA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uVSf4INJ"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UHBXqF020035;
	Mon, 30 Sep 2024 17:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to
	:cc:subject:from:in-reply-to:message-id:references:date
	:content-type:mime-version; s=corp-2023-11-20; bh=cuoYBwZ0QBx7tt
	aG8Xy8d2CLt6ocSbtItRt3AwxHoj8=; b=jF3ByPDAj16n62g0xKEuUj4r31e01P
	vXkboaFlOFhQsdCaawtFDKi3jt7ac6TJ/2xX7Kh8ku0GuGA/rkMDb1b/lP7KpNKX
	IhzvBmPmN1EZ7qLa8UJQM18iS8OAjH57lpE8WqYmwlYVT7Wroni7VfO/jJtKrH96
	bOl+sK+4NCWx1SIHC42r6xa2rLvJYyJ3/ZeFZPJGM9ww3HQC9snuovKCS6VnvaiJ
	FIl0VZb6iAc/E5nwoddh+pKnwje37DajqX7wGknDuHXZKG1y4Y+4YLMeadsy2uoJ
	hfPFNiv+ldzmGKLm5TRR6k1Ew0pzP7WA0mKuSaOaNe/r7VQUBhXTKc4A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8k3419v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 17:57:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48UH2Nxs028403;
	Mon, 30 Sep 2024 17:57:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x886m9pf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 17:57:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TtUovb6YKPLWzeizYli6cvWj5izFT1SCLoSxrTLoHeOuTk02mtcSlxL8aR/WTk2t+rm4QMJ7BeGRf7ZMVe96N+CZTD5nDgbqb0tBEC53VmD+yuh2Bxmlu9yIXPfbx4nOTaA9Veqc3L6NTrSDckbN3Eqofab+JuOi+Ppd1v/ej19xcgoZ5xa+nwIXaZkSiGwAEamaNUTv8+ibB8BSGREBEE32Mq+hF2faOTlCHPbS+HyqB0BLqyaA2Y6vSUQ5YxBV8QNtRc8zHVer2ythFys9pnqOM7fVzrNtODIm8gaHcwo4c14eOyTXJUVpefuGfkaUrWHqig/HYM8jYOpPLaJRpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuoYBwZ0QBx7ttaG8Xy8d2CLt6ocSbtItRt3AwxHoj8=;
 b=itaxCmFKL0TWB9paDTS+byZws8BKq1EEJeXWCP5XbbHs4VwzYPAUQIOXZxecDDXmfd/ohC6xE5/1UxyNiUnrgoJlZJsKFGKF2i3OSVGSSimwlAw1Krdgwo/6qzzsakZhgLi0VrYJzZyPutuSbqUA9Sc2WvMA9tzYzVs/0mCzFAVoGcGq0y1J7TpYZI5ZeAQ5wQwfSFrli4SqDFnUWiJlhywrsj3IKdKL1Vv1LnRzfAVw9wVP9gS1M8NKms/OxfCy7+/49yfa5PHBjYHTqWpziHfecAjgWBapsaVbP6TRJ4Ng8rdANvNfQYTQVMI8A45OQwdM7VJewvyC9Ter17mNmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuoYBwZ0QBx7ttaG8Xy8d2CLt6ocSbtItRt3AwxHoj8=;
 b=uVSf4INJKopgYTeAfSnt1YlcfY+HysrMS66oqsojsbVfF0VzerO3Kl7+5+5QnQxAB9yiiXnrPW4tnVNRexZ6e7SKP8MCR7EqF5DdLCv4PEWB4pemKPzUEPuBYqeMgPqWpVzSgp4WdjkfPMYJTnI7zvSJg99BKDCBQ3XUoMmP6ug=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MW4PR10MB6420.namprd10.prod.outlook.com (2603:10b6:303:20e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Mon, 30 Sep
 2024 17:57:47 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%3]) with mapi id 15.20.8026.009; Mon, 30 Sep 2024
 17:57:47 +0000
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Keith Busch <kbusch@kernel.org>, axboe@kernel.dk, hch@lst.de,
        martin.petersen@oracle.com, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        gost.dev@samsung.com, Chinmay Gameti <c.gameti@samsung.com>
Subject: Re: [PATCH v2 2/3] block: support PI at non-zero offset within
 metadata
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <165deefb-a8b3-594e-9bfb-b3bcd588d23f@samsung.com> (Kanchan
	Joshi's message of "Fri, 27 Sep 2024 21:37:54 +0530")
Organization: Oracle Corporation
Message-ID: <yq1ttdx81ub.fsf@ca-mkp.ca.oracle.com>
References: <20240201130126.211402-1-joshi.k@samsung.com>
	<CGME20240201130843epcas5p1b1840bd14ced64a1effb6fd8c93c926d@epcas5p1.samsung.com>
	<20240201130126.211402-3-joshi.k@samsung.com>
	<ZvV4uCUXp9_4x5ct@kbusch-mbp>
	<8ed2637b-559e-3f27-3d1f-84a4718475fb@samsung.com>
	<ZvWSFvI-OJ2NP_m0@kbusch-mbp>
	<165deefb-a8b3-594e-9bfb-b3bcd588d23f@samsung.com>
Date: Mon, 30 Sep 2024 13:57:45 -0400
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0946.namprd03.prod.outlook.com
 (2603:10b6:408:108::21) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MW4PR10MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 95e682b2-3597-43e5-353d-08dce17964ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7yczGRVOstZKpXdfqJxIay1KntWWkgpEEnTqCFpWckaQnkWCA4blL5q/zKIs?=
 =?us-ascii?Q?J8+5iFluTRJCDVer/iDHY9yiBF3B4qFL782+QABb8uVh52cuPe4t8Aq1v8DD?=
 =?us-ascii?Q?sjDmHnoSSvYTHsBKGFxxXavU9VeAGfvXMK1yL7niMNHZRbmhyKHYJ8uBfBEB?=
 =?us-ascii?Q?2OQWHKkgbqkhmb5oMrXv61Q2tnBBkmw95Tx4zXFhX/GiI053Pes7XYnGjhey?=
 =?us-ascii?Q?7rN/Sr9bcsazaGmUGPz7C0dWLOXYCJ/j2x4NCIRI+GC/sOrsTAQa0C/RBg4n?=
 =?us-ascii?Q?G4i/qigVhDPGxtEryFjzzrwk9ApBUqTgnIR7jUZMoE5F1BY5T8lcp+CHpgsy?=
 =?us-ascii?Q?t39MP1VR4nRiJfFV7GCAu5CVFX4y4d1pA2TGqnW0CbBYeEbcy2HI+8KgUSBC?=
 =?us-ascii?Q?5Hjd9yZt7yhFkIAseQYur96fFF61M7SothTDX+0aKNMAIGV02vhw/A+IO2pT?=
 =?us-ascii?Q?v7iKG7D4gClAa9biRNydt1HMIYkKbVrcgWYbDCPEiuGZUxzoDhCwJjnt7NFe?=
 =?us-ascii?Q?w2D/MUSvV+gd6F3B3PsFViLC5sXtRJvsC8fId1B4aS2w6/IbK4Dx1yJKmAng?=
 =?us-ascii?Q?oxR3QKske4wOpeLuV4leSYYnJAUoecj/P2AsGPG3gY18DuTKpU1UgnxXz/0a?=
 =?us-ascii?Q?yrarmumoz4vQiCS/ytNwHLYlfaOr41ubopTQNVa0RucseemuJqvGLk4P0wMt?=
 =?us-ascii?Q?6ZrhHjqwSxNo3Leo+vM9PucpVWkywIlVCBi09oQ71Z6vS40OF/5ktOabJ9Yc?=
 =?us-ascii?Q?lRomQlb8jvk7eKgVe2j3cOkXVJJFX9ZgAB+UHib0ouEGL0LtpHlupKHThk7c?=
 =?us-ascii?Q?GVoSlcxafw6SBzj2Li++N5WsO5RLhcYnQ6t/yry+lBRaytm3upVIkmglFPPb?=
 =?us-ascii?Q?1A5v9rTtdrdfy28sNG+z0OQb8CbJx+tnCiIsuN9T4JGN1qgtrIQaJ2G/2zd+?=
 =?us-ascii?Q?QJ2tc6M1jQia1XwdO/R90sss/h2qQ3+jkr+Q/0neI9FsySnhG1liKXdcucX/?=
 =?us-ascii?Q?IqBdBAssN0kCCzvarbBC7Q2LJ0LgeSwXjFm0OLJD4YIuYcEK9mscoafzyWuy?=
 =?us-ascii?Q?uSIZh+UFaOg4HKIrFuykxwUpxxR+Fs+upu+oezYpEr91ITJRog6o1clW0VXd?=
 =?us-ascii?Q?qcPblWUXeatF7llZ2DYqQYSVZzNJRTkBhJJOfhMHRy7ijVGJlsfagy6zchZN?=
 =?us-ascii?Q?M7sJniT7Y8ELHtjRAhcY7Ae4SERn+BzQwXFHpMIMqtI0C5XHN9Y1qtB9qK46?=
 =?us-ascii?Q?FxsKA4EJ73SbBRVZM2wE23nbqzlLgrgJRo0czt3pnbA0C34G2Y9pYZ7bqxMH?=
 =?us-ascii?Q?moQ7gzHgME/6tXL/0KxUINLG+z+2CPc65ao6mXeaf6sYlA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PUk9vqrPKCmYwhnlGDQV77BnDC4F0S/Wv173n9n2SAGs4ajQIX84DpVMKVVJ?=
 =?us-ascii?Q?FzR0XA7FdTdTON/C0YvpxZwiBgpGm2uN8BYLUGkqMLOS1oqPABQYkZ9xr2x3?=
 =?us-ascii?Q?+W9y+lOt8tlNOcaVWXloGlGiwomcM0/R/c8yzcJ9/lB65qOb4djWp0VZaCL2?=
 =?us-ascii?Q?844ztZVHBXT//0EcYduebkAACLeME9CLd6KOp69Lr0+ByBDFcYcSYKBt+fYg?=
 =?us-ascii?Q?AiLV5hDH6Sj6o9TVmDk0XZjI8R1aIYO/QCMqu2lYcLD/8/NcLSIzroxmqYh3?=
 =?us-ascii?Q?xEZ3jaSxpOY/K+gl3M3a7j+iCyj6uGkmqFp9cXQ9usWzr8mYKeWjyKIqqgBm?=
 =?us-ascii?Q?5wwTwv+vwXtRXrftdXpiHSnEjpLvpLI5ssuhM+mZnyxTX5vtPQIU0Bldj2pP?=
 =?us-ascii?Q?xBwO8JHS0kdFfqSP9xObidTefFcSMMjmGw1AJrLFhBOsGklVsV7fMhoVvy+T?=
 =?us-ascii?Q?T7fsrVKGT+YmFjCGnd7EsT0E/UYujX/g1led4YG8c258Dpx+dD9csHZqd/hr?=
 =?us-ascii?Q?34/DTZ8Hl4He1V8M8SlqJaf915oLN1o8UXGOvXJLrapsMI5B6AkLhjhGf0eI?=
 =?us-ascii?Q?CbQJdM9S4dMfX11VW6cJ3cXx6f3NO1LcBkOxl7y1JnSLw0A61QIjDaPhRWol?=
 =?us-ascii?Q?PcUYt383d+duJCzn47qvlYQOZJAxpwJ3gTw5B7HYCLG3fUHK6G+Qa2AWwmIa?=
 =?us-ascii?Q?8qLFBNvU3X6aWr4+gO7SyqBnaO3nXIg5TOnVZhnqzQ6ATHiPb6SDhQX/eH3y?=
 =?us-ascii?Q?ZgWm0d14BOL6CN5k31Xg55Sic3JqY3Vu+yjeXwibTRDVXIlvujchel47wM3u?=
 =?us-ascii?Q?j/fnLNBMyHOeCaHRIBIEL3R+KPD+DaHhNPZ+qgz+zSDA/KjCU+GTrisBlDUz?=
 =?us-ascii?Q?MMI6IQHEPvy7RrD73fLln9SMbfKaaW+wACG/+zNHzSQPupO5xKpUpzPlpOHk?=
 =?us-ascii?Q?ju2AUrg+lVhJOKNTvv3qh2EEvBi9Q94MMuzdoZKD9UiZOXYIO80fmSJS8SmC?=
 =?us-ascii?Q?O/qpn6atP7vOJS6QJE4b3QuhRjphoPvoTXCVY6R5/Vw6sMtNDFUt+ld+BRyw?=
 =?us-ascii?Q?m5s5cOcr/YsSH8peqRcrKgztzWZ0I5gBBjLM8w1f4y5mOwSILF0yFuO80P4r?=
 =?us-ascii?Q?NNsb8CG/8nYoldvgAKloBRTl19k4npa9b0qtS5X4o5iv1cRvZt5QNF+vB5FU?=
 =?us-ascii?Q?9ijuOkf1EZ4gMAGZv+PKnQWlbPY7DgVjehAjQ6eC8wGe8QXHEA8OwOsUwwCl?=
 =?us-ascii?Q?lze7QpdCSoBqv/FEX8/hc64N0/kGC6+yb0HoMP9Tzo73BUJ7P+l0y+miURTY?=
 =?us-ascii?Q?TEoGfKRhaZxfdIq5Cfxx22jYXztnPN6qeSi9RgIk6xQCzuAjI25M13KJ9orI?=
 =?us-ascii?Q?LlpSriiFguJeUcovRn5jqY/qzU14ZKCYj7grl/GuNnCtoi36ILvkABElqa39?=
 =?us-ascii?Q?7IasPjIdSPzD7SVmzisWYHIkziLgpAyIQmpd0nm6rAAcLw1nkAz1+p0KcJY8?=
 =?us-ascii?Q?dh2RgQs56WB8DJZZq0EJQdwcn4mCgcwd+B2WON7rwgP8or9TKxJe08eDewIt?=
 =?us-ascii?Q?gs+BHRmvauDp53AwitmJq+4/ziTERybiKotKqfiPWKYGsLq11/qwHpNEZHr0?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qpYNTKK6ZQdMw4dJEBV5at5dsZ2th7dvs9X+Zh3JrGgKApOPuQeUat0NzljACxSYbklJCYqoyIBfagG2AlHntql1Hwf5gYoumtB67+R4yfMQFxaxylDfRuM6By854he4Vs8+/V5nb3v2x38HW4s36433WYQCxFUqdxNL3quB0wL7hBzXn4ak2/0KinW3eQyG0IAveXZDpvEhHRz3mZuVLM+r0x96QM40k9BhzLl2WfYXpOwjjHAce9qwxM9hREvf/igxxV+h5RPKopWAzgBSU09BkAfm7kVUl5n+eWl8ZuAGGkMAS7YsfRVTiKbqPsm/DJhBtomlCFk+k8Ehp/LgiQB8wkVI2gBK0UYQkZRNy55zf7W7dPtbbxLG7lMukib23CKVNr2x2A72GOnpuuA3hUXBSMQ5Z/6MFOzNUq0MKhQCUt3ZtzANCso6KRmzsDz25F8+Wyaa/zXKU6QgbqYSR3d1ixDSL4Pshiey5C5hFvELnEOi2RCX2hOMo6Fh99wyROKv7JSipfBKrtEJYu1lGAvvaXC3/1wjXshC/X092tP+MKMInVqAvC7Sl2R2oTQ3UNvSmv0Def0P08lzmlOEHq1tguusLO5ORrnXi3FGLrU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e682b2-3597-43e5-353d-08dce17964ad
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 17:57:47.7407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6hWjzLp5md6WIbOMYpbt1sIu/xXkkvKI1SvQEJcHQLa3lWVoDB8/cvcnyBKQ1xldxYKEZ0kQoeOmPG/kdyVWTe7Ynn/B8EFTQ2+6FafW9Hg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6420
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_17,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=680 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409300129
X-Proofpoint-GUID: NU3xFKsxLOY7kP5e3osjviwjHqlCj9HV
X-Proofpoint-ORIG-GUID: NU3xFKsxLOY7kP5e3osjviwjHqlCj9HV


Kanchan,

> I spent a good deal of time on this today. I was thinking to connect 
> block read_verify/write_generate knobs to influence things at nvme level 
> (those PRCHK flags). But that will not be enough. Because with those 
> knobs block-layer will not attach meta-buffer, which is still needed.
>
> The data was written under the condition when nvme driver set the
> pi_type to 0 (even though at device level it was non-zero) during
> integrity registration.
>
> Thinking whether it will make sense to have a knob at the block-layer
> level to do something like that i.e., override the set
> integrity-profile with nop.

SCSI went to great lengths to ensure that invalid protection information
would never be written during normal operation, regardless of whether
the host sent PI or not. And thus the only time one would anticipate a
PI error was if the data had actually been corrupted.

-- 
Martin K. Petersen	Oracle Linux Engineering
