Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7413115B8;
	Wed, 25 Feb 2026 08:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772007686; cv=fail; b=hSHSc0xWkq+3QE6UnUNFwAn1Z+rrHwfocc1vW1Z/SuTuJorF0zIH+RmlKs+UXZX8NUdSOezozifKZ7GZxERQGUgMtcnpWeYJgIpTjPnj+beWjdikZqrC9b80cCKn4pTIOihEbhexZZJuCLBRJsYImPjZJIXBwhhJx/U2Hzh3KPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772007686; c=relaxed/simple;
	bh=TZ/y0BK/Qn+llaa1Gk/yeuyWQPuR7ZotRrPXmdpxwNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TLepVUFExGdELWDSVINjya9anpLJWu9JjagJoVe9BNAAkf5Q7UB1maxYTNetQ2Hvtq5bc9VekDaG0e7nW+OfRT/J1cj9IGGRLlHCwDfQT871oTETxDjtsd1i3K9dtJgjI2WjJyOhNe0ZQ7d47bLCqGR6bJtJL+l39ORO1aWDCyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pU3/buEV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pRQXUwj3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pU3/buEV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pRQXUwj3"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OIuRla719632;
	Wed, 25 Feb 2026 08:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=QFW4NdM+l/YlC9FLBE
	7B1Om3RlV6t7eH37VGnSGWls4=; b=pU3/buEVw/TNhNEZjQ7UHlziLHtDdKH8Sb
	crfMPqQqH5c2rlY9o0cx14giRyrWyLiWdcyBHOatsu7U+lWdP33+pnRVCyQ0Eaax
	cxl81pBMxbKe8uYHLUqsQ8PV+Tv/t1K+wwqRjN0HyKS86fqLzsc2ix4UzT1mDOFJ
	j2cc5pAjn4I5wvW2qqlKfhS7DH86BYBDu7EguFRyNsX50Q8pPkdEpmOs7nn6hsWh
	dNVEPNjjL1m8WigDuK5LaxCD3eGiyNpDwwKxIafJoqcITId/3g2SNmRe/frrhnbr
	JezCmmJDRWQ7KMCYOTdv4tiV9CcZ0tqmbFnbOflV0UVf5lbQRnJA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf34b5qeq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 08:21:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61P7J5pr028497;
	Wed, 25 Feb 2026 08:21:12 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35asnxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 08:21:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDr9TK1BrhWoP++KVvx33tddAhE56F050kDzkgDQhhQfkaiP5gqeqQ3i9LpGGC4f/vqS0p/kUbJQw1SOPKYC92Mobfp8DxiacM/zFVL5/RPYk0V2RkaHjyHrGh4F3wzVstoOWUcWC+8i/xuWodKvyGg/Hgf4iPU0mmx2s9+6LTSCHoFu3I/zAKHa7lc4ghujTpvDoL68wjwKUkSxRnNo7VHf9g3DjZ2Rqrs2DBEwxLQrw/TZ/RS32vJVEwIN8WiqbfwIhfV595hV4BGbCZjh3C5Joy0ogo6Z69hojSN1eR22/aQpj/qTr+XOy8vZDAVcAdlQKKSIDvwRALWvM7DlEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFW4NdM+l/YlC9FLBE7B1Om3RlV6t7eH37VGnSGWls4=;
 b=ehjjwtlNVfHU+vS0HAx2drPx+tZJ7P02xzmN2WoXm0U9TpfbnddWPq7CUXOVrP99D2b06nU6Ps1YdGrey0NZAyrCS3dCFrXZqTVLWrbhLbfSFm3Ori4dvl3L7Hhig0BVzmH3wRmKChaGUol6CM4NtXcc2fEbKiLDmJxS2XFraVcPre9ngYMTyx7xHQ81ayLw8kxj1+anBiGlvYd29KLPLBrqW6BGQE149//qzJMjuvZRYCmy0oYE9pqGsYfVsJSlemogbtvWMyq9FFj6PhNEGkyu8d7hycFXrjm0LOCN2PQuNjGpOdMtrxinvzsuo5WJNuPizciNDSrkoheLEBBPVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFW4NdM+l/YlC9FLBE7B1Om3RlV6t7eH37VGnSGWls4=;
 b=pRQXUwj3td4NfZ/NV5U8AaWGAiUwD/cZhnZNqNgggVAvNEHHEs6KlAg+0WuTrS2PGwlbMXJl8sx+iAwjolFXrQRq7fTN1EUE0Dk00H65uUYP7e39Y20U/oF3paEwIV3ozSKXMsF9/ViJX3RMuwXQ0L2f56zrhgB6yvbrPBjYBVA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH5PR10MB997735.namprd10.prod.outlook.com (2603:10b6:510:34d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 08:21:09 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 08:21:09 +0000
Date: Wed, 25 Feb 2026 17:21:01 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Hao Li <hao.li@linux.dev>
Cc: Ming Lei <ming.lei@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        surenb@google.com
Subject: Re: [Regression] mm:slab/sheaves: severe performance regression in
 cross-CPU slab allocation
Message-ID: <aZ6w7cf_9uH6wupI@hyeyoo>
References: <aZ0SbIqaIkwoW2mB@fedora>
 <aZ0wX_QuxNTxXHMj@hyeyoo>
 <aZ1qRhIGDAR7d56r@fedora>
 <qiqptuqsiaufeasf2xukfzoumiyoau3zfpokosn2amgc6zskc6@vl6ie2h2zj4m>
 <aZ6cjpU36_EmXslf@hyeyoo>
 <zn7q75k7u2mspvmspwiao6245kmaahti3kwagablp3advcx5ga@5d36ctyi2a35>
 <aZ6ijXgDKj9D-kDm@hyeyoo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ6ijXgDKj9D-kDm@hyeyoo>
X-ClientProxiedBy: SE2P216CA0136.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c8::8) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH5PR10MB997735:EE_
X-MS-Office365-Filtering-Correlation-Id: fb07d6b5-4a0b-43bb-dc93-08de7446d435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3mSrbvGkKhrgLFDPstU/2i1FNEkJHegZXTEL1FRu6UMRpySpoA7AyKcmqckx?=
 =?us-ascii?Q?BkUa2jA4M4lZl0mDyU966NtMnEyLTmwhmtcKQlTiO834N8GyRcWh9xkPSHcJ?=
 =?us-ascii?Q?sxN1E/sqX2PcTQnPt7d6B6EF9we+k69rbAYr9TeGVto7iDJE7JiW3jRkIQMo?=
 =?us-ascii?Q?g6M+7h0HulVQ3HfhCVqfs9Tdf4mnXE7l/swwq+Et1DALCIYWWy5R16eYwpt3?=
 =?us-ascii?Q?hn7USlSoeYzawWzwKAlQqkvAxr912XpjBXSfKH2NerzM+Iji+N0+9km6+Kd0?=
 =?us-ascii?Q?Vf2LeWeIc5thN5pR0VVKImM/owiLpRkDtZKX9/JiGx7aLXVd8eLteqdjN6nf?=
 =?us-ascii?Q?EdhlWnVx7rguvJO1Fe4lzw7/B/EfScw76iinluLd6OCz2QllGogqJDC9RDmC?=
 =?us-ascii?Q?ZhboNHAJxDV7OaNyA/5GFfTk3QQvrhVUzUu2BM803dpz+Zm4V8NFfApgWO60?=
 =?us-ascii?Q?zRzwSeQQtMM6AXytO27He3/W30UrrnMJxvG++C1/wV/t6LCLuL2d3gl3NpcZ?=
 =?us-ascii?Q?ypkb7hQy13FbQIVftqrpCIH72O4ISrB1XVm65N+tDmXaQVeJTfB00MzK40cm?=
 =?us-ascii?Q?xl6allBrYA0JnESYHAftikpW6Vt1HrwTpdHp64ibOA458tH2Y6SJvmleqTxk?=
 =?us-ascii?Q?Eg7g7XfLiDLD/ZDCePNtF78a3FS2vtJjrgFo40TA+iJkv/ODJbN/mdYJ4ZIh?=
 =?us-ascii?Q?CyYGEtGqwk5MZ7Ls599gukscHRP/PoKlX9ssCIllYnonxEZdCCZiCCyQpHKm?=
 =?us-ascii?Q?F+MpxTSEvGQLtiEtGc1ZDOMLcXtcpqRA4PA/BGV/uv17S1OvuGXK7BSR8lxe?=
 =?us-ascii?Q?Am+HIx5CDoFxzIuftujfYCE4isc7ravdNRYGxzkaHT2qU/MOA7fFVUFIn09o?=
 =?us-ascii?Q?qQHbFLT+SAxT9+NNpLHKxz7tITUoNwfcBxTnUlRDTwPgQ9eqf2J51EUPeJKD?=
 =?us-ascii?Q?QMJap8Wm0OEGs8yJzEvwh9/LFJhFbY+3G9/w5zLF+iKFLpqUbOhOm4c7D0hf?=
 =?us-ascii?Q?hHJtLjcbZHwz9VLp9NNsZPPgqwAH8GD3rj2iWyGudlfMTCrMHbzcHNPQG2cV?=
 =?us-ascii?Q?AOfYhBrcGvvheh8ZUruTbs1BwPcLYQgFI5XEFZ8+pwhlG+7PBdueYmFt3vLJ?=
 =?us-ascii?Q?hj2fT64u8SfSkGl57g89JZeweWTcWNhwkElm/O8OJYJduofifD71JMW05HOX?=
 =?us-ascii?Q?qBZ7HL/m3sR5GASUDZA9GfLLNbTnrQHwsxPzhJszGbPSsv/NOrIz3MMxiXme?=
 =?us-ascii?Q?mBAhOfdzlRT/Bq5LCds+19Y2GLeySu+CQY+X1gI0iWFtwarrWaR0ykshcYlQ?=
 =?us-ascii?Q?jdnHzI+poQL52LhDN93T2GDIEuFcnas8674dWxig8MI5CGefVz6mEh4Hvm+a?=
 =?us-ascii?Q?Dt52Oz8DK2pfi9w6wXutBWa6AUPsCK2V5PJ/BtPxb7LY4OaMEDgCFyL4QYj4?=
 =?us-ascii?Q?WZmbpdPEjJedYWU1ZahN4NDCjTWTUJqm3B4wrdxaLAY/v6DwTY622owUxcxO?=
 =?us-ascii?Q?pmzKIK0ptjnd37vJnKr4WFCCvv3ynxPKtDc8VIvlfuvhnf6hQaLsSnnTQffH?=
 =?us-ascii?Q?u4LvZwxNkn8d98I5v5A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m9aXLHEubWMgqPVTstZvNM0YJ8E4+LfDpFSmU3IIIQVzbOUSXX1tendo6nmQ?=
 =?us-ascii?Q?fhHRv4+jiD9b2Pp22KrH0quh27vIGWVUph4lINrB0I23nGMIqJ/6ZQX59cKW?=
 =?us-ascii?Q?I2D8Vb/dBVi58ccVM2i7MFiu9Xa3UWJaGgMcDD9aw0DHN51XgHzIUvAZHsgS?=
 =?us-ascii?Q?DVKXuYYMKjggOiOMgbg0U3eK5kndQ9zezqVZRGo0Vr18d60M+wlE+8mse6lA?=
 =?us-ascii?Q?IT+bkGqZlQvMq2azB1s9pcVbh5fT1a6AupgkeoRRp+SGkfsxLdOQXmsix3Oq?=
 =?us-ascii?Q?4vlkQrfAqfM4hEckvJIk6mcKkJGVv+tfEdrEMo7ME6OTiragI663xTB4dM73?=
 =?us-ascii?Q?WUoD3vRGUAw9/t03c0rw8r9Tr9ld3BuP6bkIUUpyE329Kh96Clf5zbIn5hu2?=
 =?us-ascii?Q?1KFQzgHqdlHk10xsE5YdTMUziZ52eRLxf5NL+XrE0hC/KtA3fcuoTec8uXVk?=
 =?us-ascii?Q?YmWQXT6LCybscyKmpUzQf57m0QTTLmfz1vnbZsTmi8QXvd6zhLE4XkIDMuf2?=
 =?us-ascii?Q?9rVwoyhir81UKS+Rhyy5ivbLSDMifBJaUX01r7wIIbf2O85oV16R8JyyjeYO?=
 =?us-ascii?Q?VW5xIk9K/ZUtcm4fHJVw5cSDEtr4blge9z/XNtuHN/N3Hm99f3Hxdjh1TJPQ?=
 =?us-ascii?Q?aRRLFJoglvUb9LBL0R1nE6/4vqSIQ6VdAOWbLRj6KHE6mz57IGyvLkvI56dm?=
 =?us-ascii?Q?pkExIMoawgveW4HDa3A3UAaBuF+s9dz/rm8QVjMGgiUemdEa9qidbjYyYmnw?=
 =?us-ascii?Q?zGi/2gnXIAa/Ohp2AA+NkErVZjJ5q4PIqwyInbXaWVkZQ7mV9c/EBPHOXVfM?=
 =?us-ascii?Q?hJAxV0zjPtYth8BmgBHZz0JlK80INEi0J17C+y8SNCxSssl1L2rY8QeSgUxG?=
 =?us-ascii?Q?VTLJXVBNs9QhTRxWniVmOBANGe2CpMeh8GRaYzmgNCHY96jBz0JHXaIIdZT3?=
 =?us-ascii?Q?00YADbaYLE6APah1Tg8wEtdyjoBPw/FdGB8NEP2+7caSK827WmlJN31dvKMR?=
 =?us-ascii?Q?IlJS9wSjrulzGqhI7aMkM3+n9UG10kjuRnJWDA4b4eXEq1rFyJXgQJLb4E93?=
 =?us-ascii?Q?ZYdAv86gO1TzO9nMd/d8vhM3UL2hnlZUB9E0PyHcJ3OPlQ+eqLWPVXIU8rwT?=
 =?us-ascii?Q?YIADuN+KQcJymstAhyLzlYAwb0ytlfv/+6yHjf4AZyrKA49ur4NvWOraSZlv?=
 =?us-ascii?Q?qgBU/V6xAowD/w3whZyiswG9NyoNjjDClHpm5ZPh/WDZsnV+tXfzUhrpHch5?=
 =?us-ascii?Q?3gxr4sipgCWQuAKB0TMYtY+cjbjEj0mdgZwIdycQYV6VLz+Q0wBqa0Vy8orX?=
 =?us-ascii?Q?0Ev610xXaRqIBLJCulmjtEFmQk3w/A1DoxssyRbloOEefkEAjIGalgMuqRQO?=
 =?us-ascii?Q?txtCNuI9QCNiEjKW7pvFLiSAgWrzmUgGs1z2zJvIOravFLwGCvVVwmVycW5z?=
 =?us-ascii?Q?SRhbcMMiDPwUt1i3VuEFwrhYpNNrWWmG6WuMRI81ADHjP+8b8lw75eLsAjkr?=
 =?us-ascii?Q?BtkVbCPhUMVR7tVj3YXDln20fJqeEmAT6vhClqRNjq+yUD+C0OAnj8ypA1Pd?=
 =?us-ascii?Q?7L0xukFDM5XCNRtfRq07phJfF5HcIucBPr/M3VYv+owx5VRL5nlNdecs7A38?=
 =?us-ascii?Q?VZ1dM0+tw1OQGFQ1KDrP4GP3cMYwdRm/3kswqYkb9sdL8HZYrnTdgjH8wkrk?=
 =?us-ascii?Q?InyaUpD5STwQTNRJ3CGfZvGmaPP3FpQPSLsJ2VOSE7kWQpU7owcdc8Lcyqy6?=
 =?us-ascii?Q?mAIQKp87IA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y6AK2aEak2uq4CXF3C3lz30uOOx0u/Qhgix/iE2Z+JtmZlOZ1H41m7aNGAYfe1rQfVYl0HnhxQYImzX4xj9QTmlkacmGxqyf+7eHEQP4Pu3Hj/eOcYVGOTs64U5OCdc8epIwDpg4bsVDZ61nKUgPPJKDj+++/UOUvo9xmKFPIoSGcSyLjnJoknC2ItV9ed8vD0/Jv045wyaJIT4rMDFBEUzhGMtdnbIk31DeNPFfskJ6EhrMdm9qqL74wkA2evw/wzXjvo3Xho4zp6kCh6XzvwNEKoK47RqumRqXHBwPOlr8xkhG7wKcPWDPqQ6kzc+xGAbylCYN+XsJ3PTmRYytzjipcIuqJzhA1nONvfuRktEojvZ8KeDL4SMBAHOnMKZ/TntB9Zzhy/G86rs2KUv0vhiunuYnK7gW5khcBz0I3rGa7RIrYa79UuvKujBANYAoDH2+4WPZ1w7Hi+h3SYAPnRVo84PXnZBmg6uZ1almTuRJE0mDBrHy9LBygnmGnNmFuEN7kkBQs4egMtUxawY5NJM7J4rg7pJFBToy9qO7fk56tNmX4cGL9wCWO0q+gs5UcVVWqIjiAaXacxVwneLJRf+Fel7PuRvRNNJ1hPUHVro=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb07d6b5-4a0b-43bb-dc93-08de7446d435
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 08:21:09.1228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: khLCk9L5EiJBXQC56hvOu/PAokAGwGheHJcFoWjTyPmzRHMxb/SmRNiBdG0qsGXQTcJz/ASiqFaXLEjAPlUgAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997735
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602250080
X-Authority-Analysis: v=2.4 cv=GrlPO01C c=1 sm=1 tr=0 ts=699eb0f9 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=lmGR486ZKR69I_DK8vkA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: J1BkQusaN0CMCXQINsJ--MRUjmlEJU2T
X-Proofpoint-GUID: J1BkQusaN0CMCXQINsJ--MRUjmlEJU2T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDA3OSBTYWx0ZWRfX06Rk5sdDf50F
 FTGprcjGOzyASpv5Dr4WxEB4r6+5tkI+UCxWaro2jEosCObTN56ZwT+oI/PmVLwEcHJMHHRC6eL
 apGc/c+wl2M6Ec4LRRnDgIwqTaqA7XK+IobmtWX9ZYPaFd+MYpIOdtTHTv5zTbHQqhezrATbjqE
 aejHiFTNVwcwg0oT5VyQF9ZodRv/4c+9KG2ZZmlWcPmbDnqGdx0QJhRBCNlJnGlxTqgTLL1OLiW
 OVWhaLikG6539brFvEG4CiHrW5erob1v8dniV3rcP2k7P5uZfvJHgZ9q1cDHHMW1RawPq0mz2QH
 V70ser/aCa7Q7FRnvotouYTNQWaJ963JjWQBIIPZsQK2Ihb+byqT6AM7VbH6GjstTA7ZwxIGZpJ
 V2NP9rwXgKWeWRvayeOJxtR0v/WSy+bu9rre32QRnEtlEdJ6EArEp7Zg4Vd0o1HO8ckQpzP1ijQ
 UVRzaK1RsTOOMjJZ2uw==

On Wed, Feb 25, 2026 at 04:19:41PM +0900, Harry Yoo wrote:
> On Wed, Feb 25, 2026 at 03:06:46PM +0800, Hao Li wrote:
> > On Wed, Feb 25, 2026 at 03:54:06PM +0900, Harry Yoo wrote:
> > > On Wed, Feb 25, 2026 at 01:32:36PM +0800, Hao Li wrote:
> > > > On Tue, Feb 24, 2026 at 05:07:18PM +0800, Ming Lei wrote:
> > > > > [   16.162422] Oops: general protection fault, probably for non-canonical address 0xdead000000000110: 0000 [#1] SMP NOPTI
> > > > > [   16.162426] CPU: 44 UID: 0 PID: 908 Comm: (udev-worker) Not tainted 6.19.0-rc5_master+ #116 PREEMPT(lazy) 
> > > > > [   16.162429] Hardware name: Giga Computing MZ73-LM2-000/MZ73-LM2-000, BIOS R19_F40 05/12/2025
> > > > > [   16.162430] RIP: 0010:__put_partials+0x2f/0x140
> > > > > [   16.162437] Code: 41 57 41 56 49 89 f6 41 55 49 89 fd 31 ff 41 54 45 31 e4 55 53 48 83 ec 18 48 c7 44 24 10 00 00 00 00 eb 03 48 89 df 4c9
> > > > > [   16.162438] RSP: 0018:ff5117c0ca2dfa60 EFLAGS: 00010086
> > > > > [   16.162441] RAX: 0000000000000001 RBX: ff1b266981200d80 RCX: 0000000000000246
> > > > > [   16.162442] RDX: ff1b266981200d90 RSI: ff1b266981200d90 RDI: ff1b266981200d80
> > > > > [   16.162442] RBP: dead000000000100 R08: 0000000000000000 R09: ffffffffa761bf5e
> > > > > [   16.162443] R10: ffb6d4b7841d5400 R11: ff1b2669800575c0 R12: 0000000000000000
> > > > > [   16.162444] R13: ff1b2669800575c0 R14: dead000000000100 R15: ffb6d4b7846be410
> > > > > [   16.162445] FS:  00007f5fdccc23c0(0000) GS:ff1b267902427000(0000) knlGS:0000000000000000
> > > > > [   16.162446] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > [   16.162446] CR2: 0000559824c6c058 CR3: 000000011fb49001 CR4: 0000000000f71ef0
> > > > > [   16.162447] PKRU: 55555554
> > > > > [   16.162448] Call Trace:
> > > > > [   16.162450]  <TASK>
> > > > > [   16.162452]  kmem_cache_free+0x410/0x490
> > > > > [   16.162454]  do_readlinkat+0x14e/0x180
> > > > > [   16.162459]  __x64_sys_readlinkat+0x1c/0x30
> > > > > [   16.162461]  do_syscall_64+0x7e/0x6b0
> > > > > [   16.162465]  ? post_alloc_hook+0xb9/0x140
> > > > > [   16.162468]  ? get_page_from_freelist+0x478/0x720
> > > > > [   16.162470]  ? path_openat+0xb3/0x2a0
> > > > > [   16.162472]  ? __alloc_frozen_pages_noprof+0x192/0x350
> > > > > [   16.162474]  ? count_memcg_events+0xd6/0x210
> > > > > [   16.162476]  ? memcg1_commit_charge+0x7a/0xa0
> > > > > [   16.162479]  ? mod_memcg_lruvec_state+0xe7/0x2d0
> > > > > [   16.162481]  ? charge_memcg+0x48/0x80
> > > > > [   16.162482]  ? lruvec_stat_mod_folio+0x85/0xd0
> > > > > [   16.162484]  ? __folio_mod_stat+0x2d/0x90
> > > > > [   16.162487]  ? set_ptes.isra.0+0x36/0x80
> > > > > [   16.162490]  ? do_anonymous_page+0x100/0x4a0
> > > > > [   16.162492]  ? __handle_mm_fault+0x45d/0x6f0
> > > > > [   16.162493]  ? count_memcg_events+0xd6/0x210
> > > > > [   16.162494]  ? handle_mm_fault+0x212/0x340
> > > > > [   16.162495]  ? do_user_addr_fault+0x2b4/0x7b0
> > > > > [   16.162500]  ? irqentry_exit+0x6d/0x540
> > > > > [   16.162502]  ? exc_page_fault+0x7e/0x1a0
> > > > > [   16.162503]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > 
> > > > For this problem, I have a hypothesis which is inspired by a comment in the
> > > > patch "slab: remove cpu (partial) slabs usage from allocation paths":
> > > > 
> > > > /*
> > > >  * get a single object from the slab. This might race against __slab_free(),
> > > >  * which however has to take the list_lock if it's about to make the slab fully
> > > >  * free.
> > > >  */
> > > > 
> > > > My understanding is that this comment is pointing out a possible race between
> > > > __slab_free() and get_from_partial_node(). Since __slab_free() takes
> > > > n->list_lock when it is about to make the slab fully free, and
> > > > get_from_partial_node() also takes the same lock, the two paths should be
> > > > mutually excluded by the lock and thus safe.
> > > > 
> > > > However, I'm wondering if there could be another race window. Suppose CPU0's
> > > > get_from_partial_node() has already finished __slab_update_freelist(), but has
> > > > not yet reached remove_partial(). In that gap, another CPU1 could free an object
> > > > to the same slab via __slab_free(). CPU1 would observe was_full == 1 (due to the
> > > > previous get_from_partial_node()->__slab_update_freelist() on CPU0), and then
> > > >
> > > > __slab_free() will call put_cpu_partial(s, slab, 1) without holding
> > > > n->list_lock, trying to add this slab to the CPU partial list.
> > > 
> > > If CPU1 observes was_full == 1, it should spin on n->list_lock and wait
> > > for CPU0 to release the lock. And CPU0 will remove the slab from the
> > > partial list before releasing the lock. Or am I missing something?
> > > 
> > > > In that case,
> > > > both paths would operate on the same union field in struct slab, which might
> > > > lead to list corruption.
> > > 
> > > Not sure how the scenario you describe could happen:
> > > 
> > > CPU 0					CPU1
> > > - get_from_partial_node()		
> > >   -> spin_lock(&n->list_lock)		
> > > 					- __slab_free()
> > >   -> __slab_update_freelist(),
> > >      slab becomes full
> > > 					-> was_full == 1
> > > 					-> spin_lock(&n->list_lock)
> > 
> > In __slab_free, if was_full == 1, then the condition
> > !(IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL) && was_full) becomes false, so it won't
> > enter the "if" block and therefore n->list_lock is not acquired.
> > Does that sound right.
> 
> Nah, you're right. Just slipped my mind. No need to acquire the lock
> if it was full, because that means it's not on the partial list.

"because it's not on the partial list, and SLUB is going to add it
 to the percpu partial slab list (to avoid acquiring the lock)"

> Hmm... but the logic has been there for very long time.
> 
> Looks like we broke a premise for the percpu slab caching layer
> to work correctly, while transitioning to sheaves.
> 
> I think the new behavior introduced during the sheaves transition is that
> SLUB can now allocate objects from slabs without freezing it. Allocating
> objects from slab without freezing it seems to confuse the free path...

Just elaborating the analysis a bit:

Hao Li (thankfully!) analyzed that there's a race condition between
1) alloc path removes a slab from partial list when it transitions from
partial to full and 2) free path adds the slab to percpu partial slab list
when it transitions from full to partial.

The following race could occur:

CPU 0					CPU1
- get_from_partial_node()		
  -> spin_lock(&n->list_lock)		
					- __slab_free()
  -> __slab_update_freelist()
     // slab becomes full
					-> was_full == 1,
					   no lock acquired
					-> slab_update_freelist()
					-> if (was_frozen) // not frozen!
					->  else if (was_full)
					->    put_cpu_partial(slab)
					      // add the slab to percpu
					      // partial slabs
  -> if (!new.freelist)
  ->   remove_partial(slab)
       // CPU1's percpu partial slab list
          is now corrupted

And later when CPU1 calls __put_partials(), it crashes while
iterating over the percpu partial slab list.

The race condition did not exist before sheaves, because
1) slabs were not on the partial list when the alloc path allocates
objects and 2) the alloc path froze them before allocating objects.
When slabs are frozen, free path doesn't call put_cpu_partial().

Commit 17c38c88294d ("slab: remove cpu (partial) slabs usage from
allocation paths") changed both 1) and 2) and introduced the race
described above. Now, 1) slabs are on partial list when the alloc path
allocates objects, and 2) it does not freeze slabs.

Because the alloc path does not freeze slabs, the free path thinks
that it can always safely add slabs to the percpu partial slab list,
but it's now racy because there's a window between it becomes full
and it's removed from the partial list.

This should be have been fixed after removing cpu partial slabs layer
from the free path, though.

-- 
Cheers,
Harry / Hyeonggon
