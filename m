Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BE72236F8
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 22:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744840905; cv=fail; b=JYtkbJWxptP9xOo/KBdBjmMikqR6U3wYzBuo/6Zo1lc3ucuvDqlrBkkRMKOYBP9U4UMcWxNVMWSZfazaz8OlUnVKfGkYJLFPpY9VMVuOGLcGsZWWdZm1ZxqykwJtKYIaUn0Er43HyHl2jlavGK/vOfvrLgNgShE/jlufYAi3N0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744840905; c=relaxed/simple;
	bh=9XoqnMmYaLxFjgzZdqNH5tf+OC/0G6RR0gS95DchhXY=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=V8B9TluyeNoKAzEJHaHsFWX0lFUGUozmKIxi5dOtkI/YV6TPQn3L8kHnclIAStgk/s15ljoH2xyHiIjZNggZFe/XYsTIvAqZ06saycgw2ExbnRmYpdNeAVkHxi+/YpsW8LyMs3IY/R6fZTzmMBVVCOu9vSo2e5H/rfoneJNV6Ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DO0WQ7yr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ADrlut7p; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DO0WQ7yr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ADrlut7p"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GLNDYQ012664;
	Wed, 16 Apr 2025 22:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=GhABUySHLJP8fE2ujP
	HrwN7eN2XNZhzcbLkk6wIgn0E=; b=DO0WQ7yrGkiLzMylBIHXjohK3QaG0cPkPG
	ZFLG6lED1pCbwlqoyxrGFOa2JeHzJrjvQnIl6us4CdSm6kVOsra2SkhBuOghybzG
	f4riIeWx81ztBoZlKjleVOT907p655tLj07I0aeVDx9Wr6uJEcNNK1z11ZB0ShDD
	3h1Tj7dvxey45HwjWdvqR4id4EaLnk+kNVsTU1oJfsNCzy2emHHbFcJE5IheADtV
	lYdg/MDN9T1SS6qjqVDA1wOUEZmqCgOCUcoASu/8C8EhYwN8YSslKdhVkMCRZ1/S
	4dmFiQVA7NYPD8wLjHbJP4OwQz6JMaZHQ0jXknNy/m0qLmPKM8bA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4618rd51ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 22:01:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53GKXxhq031021;
	Wed, 16 Apr 2025 22:01:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460dbcurrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 22:01:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dR+8alBgpbnmLKweajimG/Wvq1m1N2pnnJT49fsHulIw7gxgIPyEi1/4pcS8pW9EJWYIg/n+AE0OMaGynWuNFF7ii6mZ38vJ/q24AUulkM5x15DIJIbm75+sKTh8yMVlI70tFIA5qMz8tw+kAUfiE0hAz7JRXzHvF+5AqvQEmKmBjjN0F1N9jmOaX2XRtyz+nn2FxyQDz4+ZEkiVKkyydLqv4rSJSRZFjfvOx+SEYFiDJ+TPAYbbkkeAlGZ0W7oOiekI1diP3wrHstp7eDim8DKy2b+FDXgGpkuRZeG24FIPzQt7+N80Nfc1QGA6OOyMDHiG54D4Nz4+OCOsuhGQPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhABUySHLJP8fE2ujPHrwN7eN2XNZhzcbLkk6wIgn0E=;
 b=eVY8L6oAtXYJ2D0yBkhQBPcQ1unKyILcaNeji4PSMj81iW5Z5morXvcC983hqPrGx6TJy66pNdHPEYz0VkcmxPZAjcmQyP5mNUzU02W+rxph0IkxMgCQ9+Jt6UI2Tw7TDdN24qP3RUL5lTxETIGEU+K9EKtW3D1dN5O9L6CY7Wb/9fpeRsfDVp7fDF7volazYvAMkCzjP14Haf5iVlL0yiJxPgdDiyw8YN/6zEHwAR2+PwoLCFx8Ft3wWKCm/o1Yd0xF43IZE4ECE/Iy0/PChrcJg0LLl0wgjJYdVXGaET7Z+SPsSCu/A4DSQsjg5Y4jGw06InI8/GW/AA2Z0oPgiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhABUySHLJP8fE2ujPHrwN7eN2XNZhzcbLkk6wIgn0E=;
 b=ADrlut7pmZhPDiSEBqPwTz0iLWOxYnz6beApmhZyVd8qijxvucRUb5PMqmXuReiNGWJViNfXzuigJy6ChN6hQj4dlvzOA5LgKFsf+QxEKvW6Qn5pDGiXtTk7ucYdBsGztfNpoUWX6GOfPdZvZbWH6c3isk378AyXB6dFak3ChYc=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by IA3PR10MB8708.namprd10.prod.outlook.com (2603:10b6:208:572::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Wed, 16 Apr
 2025 22:01:31 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%3]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 22:01:29 +0000
To: Keith Busch <kbusch@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch
 <kbusch@meta.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk, Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett"
 <Liam.Howlett@oracle.com>,
        Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH] block: integrity: Do not call set_page_dirty_lock()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <aAAP-Kp5bxWe4ny1@kbusch-mbp.dhcp.thefacebook.com> (Keith Busch's
	message of "Wed, 16 Apr 2025 14:15:52 -0600")
Organization: Oracle Corporation
Message-ID: <yq1plhbdbmq.fsf@ca-mkp.ca.oracle.com>
References: <yq1v7r3ev9g.fsf@ca-mkp.ca.oracle.com>
	<aAAP-Kp5bxWe4ny1@kbusch-mbp.dhcp.thefacebook.com>
Date: Wed, 16 Apr 2025 18:01:28 -0400
Content-Type: text/plain
X-ClientProxiedBy: BN1PR12CA0023.namprd12.prod.outlook.com
 (2603:10b6:408:e1::28) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|IA3PR10MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: 407c79df-8bf0-4f97-ea40-08dd7d323df3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sVIdTWnFXD7bGGwuz11jlAU/ta1H3BqdPRIXz5MuQdK8Bblg313LDgDi1Lzd?=
 =?us-ascii?Q?LYHV1sGCniiLwPvq4KucfSOPGJ5tW7Yim0j7PHo+NtDuRwHxM3uncQjdvoPU?=
 =?us-ascii?Q?SwQsavv9WQiFsO9snBYflEyLjQS99Rbvwdpla5ZgO4OkAg4E6Ph8oja4P7A1?=
 =?us-ascii?Q?Bqy7nt36QKUUvwp8AOh9LMosc1daEb4P5zpqgFNTQAYVlkdNFwtAUR8fafjQ?=
 =?us-ascii?Q?n+/cMiiVo3X6nB1S37L95QBXF0oQZEJSP9UH7UNmpGQu/MkmguV5QnuzmA/U?=
 =?us-ascii?Q?D+epEehdig7+q9jqyWgd4y4MTFpbGoYxAdkc7GBzzYx8WE+gWh3EsOqbX/CS?=
 =?us-ascii?Q?5IuQeO80fQXAtgc12wCotEWUvAGjbqvLcLU6dsaGnvV1yMQb9SApt/KNw+mt?=
 =?us-ascii?Q?wTqEhvW0RK3r0O1GPtb1/VK1PUX0QKJrzIvUyXzHYisW0LJjBviejfhi3eVW?=
 =?us-ascii?Q?pz8M4keA7gg18vaX+rqZEvbcw0VMElybd9ZYlHxUN9GB4RoZisbVPPtGzx7n?=
 =?us-ascii?Q?n9FoFyfIqWS9EPnK6EJoHgrMScLvDfg/MtU4LmlqWWLP/sYioIEFjx7aLnhH?=
 =?us-ascii?Q?B42Y/VUO/t5ltpwcvEXvAVwdRyUOH5PRN4moQ/GnjPIpxYoqlZfLAoOyXu+o?=
 =?us-ascii?Q?FXnDdEv29CN0O7cYp6B0NaPfQlK0eb+F1RxFNq9hMGja+GiltfN6CHmLxGHj?=
 =?us-ascii?Q?ik6+DcCDBG8XzCFfIcNgAp9h6ocBdSrOHd1CZ0u65ROW/zph2MxkCN0n8Yuc?=
 =?us-ascii?Q?vuQhVT+ytB53zamPTMsZTB6EHA1JxhUmkwNOFuKbNxm79VCYvBn2ckGOVOmt?=
 =?us-ascii?Q?gBxZh2/tAIJpqd0/mcLbKDtOwMedgfuuCAoVY2qw0kLMVRG/Lt7L2TK9Q8lg?=
 =?us-ascii?Q?u4ri3g6OwOJB/OgCbYX2AaQBAf0YLcYpTiDBHZ6969va3IG7pwym3cKHUWFE?=
 =?us-ascii?Q?vUb6924iSZ5mPMYjscEanFf3C2+lHe664RWaRBScKwHUwMlX5e2vp3lB/nxO?=
 =?us-ascii?Q?EQ/j8V7qb/E3XFPraJ5AtDWINnyCviRRR9ZPnyx2wN6nwgiBuT86rpM/jpFr?=
 =?us-ascii?Q?mnXKIoy89Z/zGMBPIXfQLZOXDwL3wLBl9phdHj6b/R4fHQYyy//8kTgelDGy?=
 =?us-ascii?Q?yk0TSWvF0YXRMDfLk7N5lqWc35BfDDtZ8S7Hlq0fMULEDloOECzwadRcTXud?=
 =?us-ascii?Q?uU0mrDk3da/7T00V7CbE+CQofnzEBPFc9NiwIDVAFZeh5JbaUlou7PCRuiKd?=
 =?us-ascii?Q?Cf58i61XdWmqbjJ1/kh64dIgGtnoyDLxYE1P6k1RCkeKvjil5LKwK6gwm2n1?=
 =?us-ascii?Q?qieDEnyObnK9kjQOvpI/aSaGwG4fxJYp0sZtNSTE5YAkUvdJlGJOLYy/8do4?=
 =?us-ascii?Q?qgIKCFg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pYkxk6AT8ywVvqVuy8ix8mzJA9PvrHfqgs8YpPd4eGt73KM/MMpFJWqn1Tn6?=
 =?us-ascii?Q?W63bxO+6zZMpFHBGlaAF1ElLD8emmg+pdMrCWbfzUUtmwK32hAspIcSj/3qz?=
 =?us-ascii?Q?apX3lh2x+wAClraQ3zJwZww+AjJYLcFAaLCa+oCmegOOwuLrjweCG/t507Ox?=
 =?us-ascii?Q?Lh9hEUVIrYBqJknZvrZfk7Y+Zew4PL4UmanRIpYBmsEtHkE+y+blYJyfTUxI?=
 =?us-ascii?Q?rG6KiPTChWCLHLu42U3qY4YQHWDWDPRSRG9vSOQrtm13Yd9Xm3xFhvNK6kJ8?=
 =?us-ascii?Q?qzRI9fbxSOy1kvY86G+0qFijZGB5GO/l/c4LIhBxO9Vt4qIyP440hl641kwH?=
 =?us-ascii?Q?im4nr9pj9zyNdkImzVXgtLFp1jBRSZQeR+9TvRs2MsPE/UfvBKVdGQyhbEGG?=
 =?us-ascii?Q?Mm7XHPTwIjT9i4H3SDIokmu2p61ae6Rq60TzD98m1WR4zrZB6k0w/QrKp4Hs?=
 =?us-ascii?Q?wsG4JJemn2pSJWtmF3/G/rlc4OGAWpVFSi52qUvutlVLvJhR2HlsnyeGNHxt?=
 =?us-ascii?Q?gNPL9KNq8foJuGGxFTwttYGuelElNwRi2Z6kZyWgJV7MwbJfIFnIaKOjwsuJ?=
 =?us-ascii?Q?lvk9b3FS8rhbeeoqUXTs+cAd/eFWBfHYnoQv4D3wGwJY7i5BKcOVXPun0fdV?=
 =?us-ascii?Q?a6vCwM2gBE2wJ7TBWbYyuCJn7BIyr+GQnzPLt0T9/7/4tqML8yIjo0uxmwsv?=
 =?us-ascii?Q?gm5tIPMzmZgGZKJp5yYgjtG0jWuiFYZPLUWn7YdOB19r6eJHD+t0K6KIn5Ya?=
 =?us-ascii?Q?Y9Sedid6VORm8cLj1uw7IGQMP4NsnkDJAKRdIqt+p3/lxY2E7Lp0NsVMDp1A?=
 =?us-ascii?Q?kBrTFvkmU9J7gWXg0rPngAL3PCBkIA6KFpmaOVtRT4sgrhsjD+PibpJuTqVN?=
 =?us-ascii?Q?ZU/OGiUfa1tYwVYyg3ZrW9yfnvR3o9h5kdluiB0P/xYCw5RUyrVWSBx69Yf0?=
 =?us-ascii?Q?TYwYQMzaKSD/rwnyP4/1oHPIBzBl+lYUTZb+Un7d0nCO8tqj7r69iqQuqJHS?=
 =?us-ascii?Q?onGL3kEqq0ZneCQrmcoB/D0AnwQ+j2HdgC5XVmA/75PecoXjLd00H6e3O/0c?=
 =?us-ascii?Q?F/FP/rhV/eqVNW8Lo1HhuqVtVmyr7ZeXULTr5m0rRAaqO1lmisvPkMKRvqYv?=
 =?us-ascii?Q?HWtz8sjbayQ6blfc599o6g0tKFHDwqUWEzMCFqvCaSmrkIEpbTuoCcly9yXH?=
 =?us-ascii?Q?tghFCfDBuc5UhoX0tAhMqNne/FX24ELoq7UeW9ot/JRF6mKHpzirKp7qNbIL?=
 =?us-ascii?Q?IEKfeDG1dz9wcaypPZg9bdPZrEqa190kR5/fW+DNyRsmE8rhCKTtANTptniD?=
 =?us-ascii?Q?U3Wmz0/iF29A/08NDDlSnttYF/3PVnvj15GwuOiSDOFUz/ShRu85Fn5taP5q?=
 =?us-ascii?Q?58qd2bhRqu+EezWb9Wl2yHVlHVgBUrGLMWMm+w0Z7Vbu5SllRE0WH5C6h3P6?=
 =?us-ascii?Q?55AZBNSkWScyBmoER47R6+vnzcksSBdtDs/eIK7WgiaEBSGiulpFFTv6UdTo?=
 =?us-ascii?Q?nU1PHEmYoMGbWTcYseRKzZ4hL9rXnS4XwIWs6qU1at+o50CPJGmeGxS7UH9A?=
 =?us-ascii?Q?ESowHEbRV9KgtgpwSVPNBrziTh35OAye6T7UDHG4ceHHXO78iJHegROv6Xin?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vJh+mVq0GrJ9oPSA4HGprrczw760SrIOzza9mJpuEqDfeqwcj3kHpiZ892T0aNW+nCIOHkI+CKeaIpU6oxR34COZT8yA6BhePpPtdUy6+RvVXIDac/qaxVTG77KkxhkXP0XpMCxetCxvaqSYZOBLiXeMk60VLW+8VnMIJwdEwsZNf3xP9b+tx997taAccbS6w3uuNnynWBaRx2uMJvt48gR6+/g4Cze8uiPkDBIGC4rBrSm4eJSp8AEu3NfF0jxAagVD8WMpTpFRYirdh1Tav/Nm3pbf8E4Ra8LxsiuMT5JcEHWDVslRLQsXKn2uaZU3JPEFnyrLo3tY/nS1vQ6APDQt2NjLa76CwuDAC7pEIzE0trjtzi0pnUJBK8vwUaJ/efw5GVxwLhr7YljjUZoJjzNLueTRGUJZ9ssRcEhwfL2+lLLlo4+i1NiMT/0ebK39icNtP/ZN+D9qpk21A6F5SWIrNM0SayZHHwBatRU+LlYxnRC257kNHbPReisBJZTSMYTTrzasK/NH6POt2GgaXXoZZnz3ml0kPz2+BHdj4Uu2iKETT1DmYSOAvt89JDeNHNLvyji7FfNAwrx+dKxCxoIXnZ9QyzWeRUlMpMHiyoU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 407c79df-8bf0-4f97-ea40-08dd7d323df3
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 22:01:29.8922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCSumOHMF+z97JOl1Ph80G7P2flvljNfMqhl+xLPzw+b0SNW7IkSP0iQ3v7QJrb1PcPOK+QtXLvtGoVQXDZE4cQS9gAMFzaQ9UdhTxhTr9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8708
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_08,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504160177
X-Proofpoint-ORIG-GUID: 6MduBUiBfyF6P1HhxnmFx5kbauSg-Fcy
X-Proofpoint-GUID: 6MduBUiBfyF6P1HhxnmFx5kbauSg-Fcy


Hi Keith!

> Thanks! I had just posted a test for this scenario earlier today for
> liburing:
>
>   https://lore.kernel.org/io-uring/20250416162802.3614051-1-kbusch@meta.com/T/#u
>
> I was wondering why it didn't blow up.

It triggered on our end with a heavily threaded workload. Each thread is
reading fixed-size 8KB blocks. The small block size results in needing
small PI allocations. And with thousands of I/Os in flight at any point
in time, we are fairly likely to end up with PI allocations sharing a
page.

-- 
Martin K. Petersen
