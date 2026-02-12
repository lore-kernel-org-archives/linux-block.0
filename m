Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE062BE7D1;
	Thu, 12 Feb 2026 07:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770880492; cv=fail; b=NLgIG4+AFx8+nQD3hHBRb0O818dPEjesyfhDjqadpwLlVl+u23MgZNayNCox22++Joxtk4Sno3rt2x+UGAK4b9mXvDF+hRbnLT8e1EKYikRKYqBjtWLVzwIMiuzevQh6+bnd/LK0x01QBobN6rM85enRVV6PpSURIviNr43Tqo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770880492; c=relaxed/simple;
	bh=niGrH9KN2Awmjx3ADoMXTP6/gi3bPmo0KuEL/croheg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OGxe4LwQ+rWNlVM5sSCTk0Djq0QK6cVtx9wpjGK+lQoVcT3lj0hdvJTjhFxC/79gYHxPjlt/XOhEtK9vbNApLVhB5sze0xXMjioqMv3uejiadpszDhqsS6klw7iWRAuaupi6I0XC6W7Jzqu6js/WupFxwn5GLouPUjEJAIss9MA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=ZK4qD49k; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="ZK4qD49k"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61C6IQkk3163069;
	Wed, 11 Feb 2026 23:14:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=r/EaczgCy9pkSJt2RnmI9F/GD50c938aQa7FEVwmsmM=; b=
	ZK4qD49k/Wau78rvMAqYfcuwz2CZ8UA6iQCAb4wOLja5Ialv23EiBtjvHTxO6N70
	+iEw5yUokJBoAKinYmvwLGHlq/3gzctEN4eMGCR1Mf5NRaLmNEWvCsUs8WQJHDHL
	p64FkOSTK8zuiy5AkqZcFdecqXBa9wXmbWoGyiQnYMXkfQSwXFdnau+t6dwwh9hD
	X24+QjvxTa5qtR6Ru9VPKQ2AzCC1UVosyJl2MIgxzaA/QH0KY4UtiZCFNBYkgYgj
	kvQjL0apeoZTDSznNSfds8NTxbh/Z0pd1OGA7quf2HeAVp4P11WAZRuYObA+tkjR
	Cayrr24yo7Is9CES+wTmsA==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4c65sj5db1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 23:14:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2cEDgmfbewx1ulVi5YucmQmVLqeHm742hgg8uEEOd9HKCEaC2QYA7lQJUlPzTc7iYAaSqEIl6y7N2ksiR8J0CdKQc19FYz8dAVeTLsqvkYYEoRC+oYmdnWjWHQt3JMQxdnaS9ov7KBQoQ26vrYoETCHFge5uu/mELQJVt1ZU4u2Kf1pRzi1cbSSgfOQ8jIovYh6YNiRL/HlTFmwaoPja7FdBLyc/1SzpG7sL54i5DrjH7W2dCk38Efhh8s6H5nFuSEvbHgaL92bLm8CnEBB7yXowbhxDQZzPsf40ei68V+QCEhpL5/ajZ1MdycjzhkH96q84sGUkv/nbMFzbsi7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/EaczgCy9pkSJt2RnmI9F/GD50c938aQa7FEVwmsmM=;
 b=riugM6oITolgzZf1ESXRfvRdGEeAtxJPT4BP8RwOUi//9sKHpAimN+yqmjFDuUIcp7FLVAGEzDx6clptDwKzxCIQ9281j4h9o1lp10mlLgi2f1QD4xWut7j1P5PVqp8JflWLW0e+pJ2sk0rFBXrzotlexVwbq63JFVWvIs8ilALwow+JmFINEyB29Yebay/2S75zrUjrvGLdqzcVF/n+bhstYLi++gjWhnKLmfKBcncvXq5kRoqsW+Q/peltXZAXrrx+f/XcSAW4W+AMvVVp1kXlFwJVP9ueQfs8lGtn0zP/po4e7KtvUw99FIBEhtGvif46a60d4J+ot1jnuoAOKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by SJ0PR11MB5038.namprd11.prod.outlook.com (2603:10b6:a03:2d8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Thu, 12 Feb
 2026 07:14:32 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 07:14:31 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: hdanton@sina.com
Cc: axboe@kernel.dk, torvalds@linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de
Subject: Re: [PATCH v3 1/1] block/blk-mq: use atomic_t for quiesce_depth to avoid lock contention on RT
Date: Thu, 12 Feb 2026 09:14:18 +0200
Message-ID: <20260212071418.7622-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260211235919.2955-1-hdanton@sina.com>
References: <20260211235919.2955-1-hdanton@sina.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0078.eurprd04.prod.outlook.com
 (2603:10a6:802:2::49) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3885:EE_|SJ0PR11MB5038:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b89487b-3d3f-480e-f276-08de6a065e20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fnvU2cY2bx3DAwRrdspSp80K2UyvuRkcVyNLrdnSdVs9V3SkWRt8J9FYEVtz?=
 =?us-ascii?Q?XjU6qbL7+td/XpLXXf3c8V84/hWRm/S3MEJt7rqDXmtVXwsjvmpd2s4BdRXK?=
 =?us-ascii?Q?rkTv1XbY2BqIx52/ijifVVOuMEQf2N+/gXTeL86w60l3UDo6vNoV0zcFumzh?=
 =?us-ascii?Q?blFfM6uYujZxerymoy/14lJNfcei7frfrK5pg9j417qlAYv3FwHZFAWOXCjE?=
 =?us-ascii?Q?y9kGGa1RoQ2L0jt05Cozmu5FRvsOmPnonMa04rZdzk/wHmg7OR9dw9Z/HHeh?=
 =?us-ascii?Q?7uDLMsLnD+dl+2r/cSzkya8Y+yZ8Ilz/8UrKHMFuCheHWHxTC9VmBfXhgPJH?=
 =?us-ascii?Q?Ka/ZitMXIBgrTfBaXuTdLfCw9+Rvl8g6OA8himCtlM+a5OebKqlFFa6Ht+QX?=
 =?us-ascii?Q?sZy87x0/X0aOPjUTMLXAOTDa4Ozh8ewLUtBZDZ5DWUSuj/G2GOJZZPPCYuad?=
 =?us-ascii?Q?2/1P2eL6KzI8MyUQESVTN2p0TgNbfKtvDheYRqAveXD2HEk4N3wIgdgzouRL?=
 =?us-ascii?Q?DgMZgeNuW8Ntb7SvJZsJJgYl+syldF94sNJQ+1T09Wg3d7pxTex3/eiKuQiv?=
 =?us-ascii?Q?bCg86uW0EaQ4nGHKzo5/tc6DWg16KF9bRazOK6gfClGG+MZGMZOHZI5DFCNa?=
 =?us-ascii?Q?Hda/hdTQyhyAbKGeVdbBstQI7c8bDRIwNRS7DkUT+sVBfZEMXip51Lb1tCt8?=
 =?us-ascii?Q?+U76n7X0QQ19lpzol6I3EohCuFvYcbZxfiPlEng92J+k0bSawt/1lBC+9asX?=
 =?us-ascii?Q?BFJtYEwcetyRU5SnwmlbL5UgjgfIoWeUNPZeUP1W2SAeysgxXbOBClTZgSY6?=
 =?us-ascii?Q?++YxoN9YcOWk0PG+OhBHqK5ktjWRsXJeSgSiiz9Ym70do5zxGTH4LMt4fGgz?=
 =?us-ascii?Q?ZjRmr59VTmDeUbvJs11elyZUU2tiZJdtHyNVDKh8tnwl40oJxs6/9h3HkAvI?=
 =?us-ascii?Q?Q5b/WQgM5hPV1VSiV6qSegt17DJVZlRpCwekurOKWqIZarfKgoRm/hKnd3gQ?=
 =?us-ascii?Q?rxSOmsJmRy2cqA4oSoGeOS28Xm2fACZHMaNmmHaOKBdSH3NKOx4mdc5teGP7?=
 =?us-ascii?Q?xF8h6llGY2KSulfnryhVdaLg6G9YF0K46HoTKk8J9l/AMxugRJQfJO2f6NzR?=
 =?us-ascii?Q?Eo5is7z/MZUE1ZPSWR0uuqd6vmkM9u4zwB6CQ6JgrSmpoGuIrVQOl716fHcE?=
 =?us-ascii?Q?DpFOKtqW2F43HAyiq5k+pFmwkaicHbadUwKNTWsGXEDKFhcI9cvoILCoxXXJ?=
 =?us-ascii?Q?eyeKtvDxVAdDvZ5saKelVf7qDcHWTCQqM90XpNH+N++xvLjCRe+quht1NybF?=
 =?us-ascii?Q?Ybw+ZUFfxgoCTs2q6Af2r5pMyMGTR9JLBHoSWNOtBp47erU+Op0p0OT9EAjD?=
 =?us-ascii?Q?2ZIFJaQFyd2ZXL+3nGzyNoaAVOLF/sa6NrI/evZAhD6YVQpbgqkWX8TYRysD?=
 =?us-ascii?Q?Pw8MMtv7uEHnGFwrmhSqwAyKF2ozQ+O0H9DZKKK4kXmlfkn+6ReAvpUo7MvP?=
 =?us-ascii?Q?Nul+Q3FDLPCrO+G5OV9ZWsAyBeoYSRD9kQUnoSYUnhhB5ljgTyLZbThx+s5p?=
 =?us-ascii?Q?BwYFe767zBGsqCoHbFs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(52116014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZUjsiU0LuDOhktptr3hJ6pNVixMxetMaoj9LXGPeUBdQr4wJJIgrvFHEjcNL?=
 =?us-ascii?Q?1qJu5fqeDurwT+srNJm1eUHFgdbvYIc2cp+cKr6kntWZHurbOLcQEeQave3y?=
 =?us-ascii?Q?WzDGEmOyhA04ZPOuLEG3LLPc5FiwaNH7ycrTxNqa+Anug/ezTM6eCvsBdZJ3?=
 =?us-ascii?Q?hL3xIvFMJJPvICF9M/tHC90DCSqkou2TB4JNUNWuZS1tVT42ik+eq+oNHNLm?=
 =?us-ascii?Q?VFaFUZ1XvPx/IFatbUwc6f5YB/Tm43AOjduFgY9PZ0c3Qco5BS3tygXND0Nj?=
 =?us-ascii?Q?m19iPdrUzZtfZIGODcflUPgdnwr8/DTHvoPzr79k09twb/BhPfm/yWWj/Q0J?=
 =?us-ascii?Q?9opdjJh+oD8am+v6qCv3IgQWSAd0Z11tluePu3/VDNkZBogZzl2bhFLUCFt/?=
 =?us-ascii?Q?srjl+0aN2gZ7qIwwwWoN4/lwN8C0XgYEYneClDqyrIZSpimsDId0xt5sstpr?=
 =?us-ascii?Q?Bolpovp2nXWmZLBGTYm8z0klvFwzumuXFjrEjGUS9LvjD++UaD9pr2/NkRSt?=
 =?us-ascii?Q?G9Wq/e3styj+m9fqdWFmFb4CL07LA5QiEuAgX38X+FEiN8VtXDClMbGqXsZJ?=
 =?us-ascii?Q?bjti/pXYJjX+aDc07YpZlKUHdPKxT7AeoQ7pOnOQuo75cKpe4GtMp8xlEqA1?=
 =?us-ascii?Q?DyVb3xEUGdbQLTGF1wx91Co1bVZlwlgoIrqHiH1vMrOpxfwCmVbC2Fs7q4Yo?=
 =?us-ascii?Q?CnF7xTFBz1yM+uq/62/He+d4MyUqDSUmDi2FCIDXL0MToyUPb5EGZb6kIUCD?=
 =?us-ascii?Q?NBWmH+DE7h3Gh2hpx6wgLcjaN3P0YK2uNVbDTvAN1U8O0R0c5ewKC1uoefhz?=
 =?us-ascii?Q?K6Kbu7hltDuUevNLusP9h7MLirHL8ztyO7cwLQ2BRGBYyVBwA/VnmnMWd4RQ?=
 =?us-ascii?Q?ZGlF3b+N8ni8+hplZaTX1j1P8K73RJI30h2T1adJlJMbyD7lxBS8gXTZzdKK?=
 =?us-ascii?Q?1YAgWDjJXnaMAB0CYGYE4EC8bfAj6kDSTgVvLRS7B+9nnZ2W24XS8v5q02TL?=
 =?us-ascii?Q?s6b16i7x2AZNeOUn7s+IswG9lvEQIzWHpVND7q1o7yW0dIsDZVlKy5qhkoVq?=
 =?us-ascii?Q?/znMKwrZaWsjkGeeNmhP8CgN+6F8Wlkqnu64IlMw0+ZyGEahdDNSlXtj6RlB?=
 =?us-ascii?Q?7aEdKcGotKfheChVRpDRQg7GfWtIKyXJp5HquaYi3ky4YLIFHfglIG0tjRMx?=
 =?us-ascii?Q?M1uDZfnacIMPVeuKTcj0o10GXwK3j8NpGS/8ExkyrmkjIwK0AlpeuGmUql7I?=
 =?us-ascii?Q?17zmfMncghfK3oWToI2EotslrKdqK1bULk8dXK8Y8RHd9O8XTDDh5IG5eCEl?=
 =?us-ascii?Q?pREo4ioSpn8LiA3cEPvnp/blN/6QB9hGVpnPsLFr5UMbxIOViq9JvInW0R2b?=
 =?us-ascii?Q?Gxx7BLroYh43D6zJEPnPoBhV5gkaTUlOtiImxPgPUE2dwSwhlVeo/U/W3Wz0?=
 =?us-ascii?Q?epH4MLFGDSKEYJ0j6OyWgyjt3Kkt7ii+BlxfpKKyB5dj0gdjz1ETJHzM/EtS?=
 =?us-ascii?Q?J0LtEbvzjV9CHqJdH0RA2e29P5y0VJARbbvDFmYsNp0yVzoruUpjDKgykXpi?=
 =?us-ascii?Q?3QkaYQNoieQzY+XpW1IYZdZJDu3DfpX/UCKpQr/cz/GbRwm37fFqZ/RQwUnV?=
 =?us-ascii?Q?WXMhytAxMGRmPC04jYq8GpxeKpN7xPVy6Yqf7nMU1FrtEzScFW3fb0SAJ4/j?=
 =?us-ascii?Q?EhUAd/OvPSCZLTl75MJB2HsDuObyxZyZ1y3BZ9XAcmy47F0t41AchB3/aJCO?=
 =?us-ascii?Q?SbloZZav7tO6qGIPGR3Zg7By3e9iRukKSsqI6vDCp/A+kWbgESh1YLD9/9vG?=
X-MS-Exchange-AntiSpam-MessageData-1: 46r7DYrJ9ZQuv1vq4l3+XeAC3//bR7q+NfM=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b89487b-3d3f-480e-f276-08de6a065e20
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 07:14:31.6976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3awhYFo2vKV+8nUHmjm2y7iJxSJBHdLFXVwHJdlHA30qZENJEs0O9yJEo+mNduu/PP3eyof2qHIDksGtp730/t2TG/KEHy/srzKFb7ttttg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5038
X-Proofpoint-ORIG-GUID: CVFQC4BIJHwq2ci_IXfzd5QmaTweGrpj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDA1MSBTYWx0ZWRfXyCZdCXaSw9Rg
 IMNaoxLo+6ez3DWIu4HjQGOc3wdjJnjb9Zc7d+685om9ptAswXK2N4077ANEfL6yRRkNRKloOxt
 6WIDpUXDO7XC1iLG954T59BH2o3Sz3ApjAxQ9JYifDuaO+Lzowzt+5RCO1nAFigovbe0ERwp8xV
 r3ud3bZF3dfCLe5jIotC8uPB3xbmgHJRr4JLfniSIdHtqqaF6q0sq8wSCWXAKCoU+CXWu4HcTJR
 OR0zjOl5N+rWy71aZxKwrgZAzKCXY6CI7Dd/HJlFmcBFm02dObN16ZSUkrNk5/uJ3H7byuJnZIq
 q5m4+JmjwMjq76CAUdZQz4v6vvo9D6zBCaAu92n13TFSh/nPhMmy+3mwJqCQKMhV/6FxoHi3Z0v
 OuObTQHPBOlCIRu0FGwcyabXKgjpQ0YoIrLPtA4zEmBDrj9Y74OZ9d+/TVi5ED0XnnFmQ5v6+qs
 /T3lgVByd0JJUbnrkyw==
X-Proofpoint-GUID: CVFQC4BIJHwq2ci_IXfzd5QmaTweGrpj
X-Authority-Analysis: v=2.4 cv=Cpyys34D c=1 sm=1 tr=0 ts=698d7dda cx=c_pps
 a=U89Fr+s++Oy0xugnv2TZpA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=jv6A66iDG_iutW-MDn4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_02,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120051

Hi Hillf,

Thank you for the review.

On Thu, 12 Feb 2026 07:59:17 +0800, Hillf Danton wrote:
> Nope mb is not enough.
>
>     int qd = atomic_read(&q->quiesce_depth);
>     for (;;) {
>         int v = qd + 1;
>         if (atomic_try_cmpxchg(&q->quiesce_depth, &qd, v))
>             break;
>     }

atomic_inc() is already unconditionally atomic and does exactly the same
as the cmpxchg loop above - it atomically increments the value by one.
The smp_mb__after_atomic() following it provides the necessary memory
ordering to ensure the store is visible before subsequent loads in
blk_mq_run_hw_queue(). Could you clarify what specific scenario you
see where this would be insufficient?

> More important however, why not send this patch to the RT tree instead,
> given the spin lock is good and correct in mainline. By good I mean
> fixing RT stuff in the mainline is not encouraged.

PREEMPT_RT has been merged into mainline since v6.12. There is no
separate RT tree for this kind of fix anymore. The spinlock in question
converts to rt_mutex under PREEMPT_RT, which is now a mainline
configuration option, so the contention issue is a mainline problem.

Beyond the RT aspect, replacing the spinlock with atomic_t in the hot
path is arguably a simplification that benefits all configurations -
it removes locking overhead and eliminates the two-variable
synchronization (quiesce_depth + QUEUE_FLAG_QUIESCED) in favor of a
single atomic counter.

Best regards,
Ionut
