Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA755257852
	for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 20:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764017385; cv=fail; b=qGdzJzzS7bf99IPM0rcL0ZhtmQCxTWxix4hCLEJ37DeNe2W3qdPQF0iLA7xxoskLDEC4yr43+lVSil7VQrFtQBOVwMZ0cUu5rI/Iq38KgA8DTWiY41eAqQUo09WHLABT9dEwBuQ4WswV8rZn2noStMfEdoBrpvSA6CGTcKBuLp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764017385; c=relaxed/simple;
	bh=NJXheTIdQLKyVQftT0xpmOtVf/C88ZNwwhVjLdMO8as=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=NZwMQvJ0YfwvTLYxiSWLLBFrlqqIZvsaGOst4iDkeC6939aOdU6RgQIiDZeEh2Ql+e4wxE8c36Sz0GHjdNTvi+BmS+7hbwwUWrBIMN8+fPSP+ITeaazho5WxVUyFe/+31XVNwoj2vkKxuDMjoy0Y7TR6VVE7CFELFgyimClQ+VQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aEtIhqC8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SzV5SFVs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aEtIhqC8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SzV5SFVs"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AOKOUjr1078607;
	Mon, 24 Nov 2025 20:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=fV8kUHlLWwWnHo95g1
	y3ONgUXiJDs2bhz9/ljPzSqM4=; b=aEtIhqC8//Og9muGB+MJ2TbQyOGudQNrHq
	/ENT80bwuS3PXqZo6Rv46ET5Zw+7NJMai3hcRXloyOQfYfAP48Ctq3ctIlrcamTH
	ZnYUNWFc2Mpgars9OqOKEJP70bxY5CHbtPCXqg7tN/rIY9R8PIPRIFZmgH2K9qyL
	KE0A0L4phSlQ4hqSLHu9QEJHqP+hyLCXY1fkRqe1rgsM6Q+Z/DQwy7stVLIt80zK
	CirtfxdSYSpnqEkkcFDPUYCLWDmoXo8xgObpHZOJXpapC2Zo+ILPsBVwS5AWUSUx
	YVBhwJtU2QrYyDZlLQaVspkXA0CdsRzVhHr8JUgkFNEDp8/IxJXA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak8ddawqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 20:49:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AOJXQmd018890;
	Mon, 24 Nov 2025 20:49:36 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3m8kndc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 20:49:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tY/kOzLDkJ0xORbt5vQVVJewphwTNLigtVuNpWzPCfsuzZrVslCaGg1852hF9CjL6oUI1qX1Sk8D9CEPV4tcu2mX1+YIVi3K76SLxrE7VlaYgLOUGuAAC2dhwEtDsGOhW7YOsOHG8RwTprjmMiTdojuHl+0DFxE1WQdBARQPG8Dqy3UMZoQOFNIL3RWAGgJjOxoLHYrGw5x6yIuN0jgziBs7VF5n19r7nZM5UKPzGG5NLgfKKGE73nOqzwVpH9a//ehotIIaQl0OFWXO7QsobgErPA2Y50Ly5nzRvaT5DVaZCWiZf6UV0t/iiYDdTqgzV4V9Foml3gZXULr33jtiJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fV8kUHlLWwWnHo95g1y3ONgUXiJDs2bhz9/ljPzSqM4=;
 b=wYLLPzVeRf+pU15sR989amv1DGZfFFCNhlRzqpR2kNIHIfGc84ecNNgGdazLlORl2cfJ5MvucCFqgmsHgr0lruWyEdFRCjRTJmOeNrKPFtFhp8WuqY9q1u7JJuQE3Df0ueNV7RQnLiWZeN+1RpKm+PMFUnSPx5gtzMo8pqB4G63sgoBEPdVRc4G9OlBqVV5FNXGKKLOiT59qBtciMZkQ95kt73J7N15xxpOhmpk4n8+/tDbze2SAIVlKHBvovWFZ30XQuSpUxwbQEUmVXhO8ra7LUXk9HPHrfZgbntLPgzFr8aw4FVx5lFT14ZZPov+h/jH2tUKRqfrQCHn3B/I53w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fV8kUHlLWwWnHo95g1y3ONgUXiJDs2bhz9/ljPzSqM4=;
 b=SzV5SFVsST+7t2j9mGwyMhY9fm6/y+Gkyw54jDJk0mPk/fINaLZGLNtxUwmop5xFdOpRqXnsJCHu4J8+0ZcHNzsbKP6j7xT802d7et9yTvHBnFlwRFnOzDYgXdHFizEC1FqJQSQcskVeLMShwxhGghImQ69JBr4xoWDDOgzICjk=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by DS0PR10MB6031.namprd10.prod.outlook.com (2603:10b6:8:cd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 20:49:33 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 20:49:32 +0000
To: Keith Busch <kbusch@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch
 <kbusch@meta.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk, hch@lst.de, ebiggers@kernel.org
Subject: Re: [PATCHv6] blk-integrity: support arbitrary buffer alignment
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <aSScjjoOZswC35nR@kbusch-mbp> (Keith Busch's message of "Mon, 24
	Nov 2025 10:57:34 -0700")
Organization: Oracle Corporation
Message-ID: <yq1ecpn2m4h.fsf@ca-mkp.ca.oracle.com>
References: <20251124161707.3491456-1-kbusch@meta.com>
	<yq1o6or2y11.fsf@ca-mkp.ca.oracle.com> <aSScjjoOZswC35nR@kbusch-mbp>
Date: Mon, 24 Nov 2025 15:49:30 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::28) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|DS0PR10MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d709ea4-1cc9-4152-fe17-08de2b9af856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e1WRJjj6P+Knt3Tql2ES1xSmqVOojIU/8szgUhUJzhInilKIzdPXdLf9RKFK?=
 =?us-ascii?Q?6GPwcvNZxYyPH+L5C8TFk5IcYyJk+LHrOLxukoiZoO/FmxXWtVQ33mTKIKhU?=
 =?us-ascii?Q?QUw3JS4vsz0vNVh8bwo4gn4ar7/FWSIx62Ywr6arL9926rGpFx5lU6hFf/qX?=
 =?us-ascii?Q?1+RW6j0M9a+E+8wlZaznrCjkqonbjiFgn+dI/J/U0ss89Ftoiv4nMNS6m004?=
 =?us-ascii?Q?Rf8HJSOPVHSCfNKsiL9OpQDYi/KuEp45xa1XqQD0F5mcyllAVp+eIV9nowdS?=
 =?us-ascii?Q?s6kvaULK80wrlHYKW1qKNOW0FwMBdbkLIXxSQZZQRqcH7wHOg90qwv8t3RR4?=
 =?us-ascii?Q?123BrwM5YeoFgh8WQDCyXIQEehtKBg4fdVjfW1pc0d3HpCuCxx/Hyp+sxtMp?=
 =?us-ascii?Q?S4Lf/jcTHR04JStdV5iBAF+9m9cNyNQOT8nltQWUFGlDH1CoksGMY6ALMQBF?=
 =?us-ascii?Q?ojVB4nwLsTIBd749vZcVjIcNvl4f5ZHm5BUL7hWjUZ/94RgIeDbxUqF5sT4i?=
 =?us-ascii?Q?jPsdiQDKEuhOrTJkuBrHXZnlX/jo+duNENBnA/GvNOdUkY3rJ3eTrDgSXDCw?=
 =?us-ascii?Q?Bvm6LDaMi/dBOn3vdgvRIz03pWYaz4hV5Y4z8txLRk+12GYQWD75JXBVR3ib?=
 =?us-ascii?Q?ixMsW83AAhr0Eye9FITph9ahzqk120K3j7dkF0DlMNhZOmOzTpaD5xErr0kX?=
 =?us-ascii?Q?3NXEUYF2AGlOQjjDltVEiaK/nfrskqBTBWIvYnKbJeGLfFlL75BhNjBLV3pY?=
 =?us-ascii?Q?gXAuB7/6ldoePh8ktnGyCmhHivAIRLvIbA79hHH72FWMMVy1nXID/B5EIv5A?=
 =?us-ascii?Q?Q18/V2LL4YFc5cq40EY5mTCB2CDsHCGLnGp307+DCf20du9uiaRpUy1Mmo3p?=
 =?us-ascii?Q?YkloYpr0RDQD2nSj+5Nsx5TyJLamIe1qoh27/etOjQ5QCmKpYdQSSp0Tc2Yy?=
 =?us-ascii?Q?6vI4G+3KiZxARzp56Mz7yFC+vipaMzELiXyqbhoIZxkZ1ta1SEmpsgvLPzri?=
 =?us-ascii?Q?hRpG++A2Zkal3yZBJ4jluH9qzdBlUH1Sn+bkcYPem51yZzr/Pl0+obrKJcAK?=
 =?us-ascii?Q?VVNbtTsnrZ2wBG1/F6Qo/470DpCJ2LUXhyFG0+awtmvf0GVw1QWLzXmyHqa6?=
 =?us-ascii?Q?mnGtYxMDp72bXkDc+FMoKjxjK/X56KkanCmeSsLsC2mtzYPda8QtbHcjsycU?=
 =?us-ascii?Q?IfHSeE7cHuelPS6br6G1WMLZyLIgdrM+oIH5nZbtpDmTbJZ0lqQ29LA2p6Db?=
 =?us-ascii?Q?qCMNltBrXdMR+7QKQctg+RGI16LDArJAmVgxwPBQpKJxL/WlrumOW6Svrgsr?=
 =?us-ascii?Q?q+J65qieM34gDo8BVh9U6/wS2M1ckJEBQEVf791IOYn1EeGzsRsh36q4Z01y?=
 =?us-ascii?Q?XC0IU/ekkBFTVUzfO3bHrE9hnouiFyDRw2TWi3bTFy9TxGbpFgHBXnHfyWmX?=
 =?us-ascii?Q?wWanibqhCxOhguf58M28uak+iltgWe6k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ceNtbuDK869hE0uj83DRgyzdmlC7q/UaJngnqB+CxhsychKBRR/ZKDwzLijm?=
 =?us-ascii?Q?LKd7Py/SciOwb2zWZg6BIc9JVSo86BZ3LGE5uPtZKcJnMkdZOZhzMRKvoExw?=
 =?us-ascii?Q?A43RMU7m9LG8WPUyMShmCZDGdQ8pgcmN9BMmFt3mRNdRTGcmKNwbzPtyiBDI?=
 =?us-ascii?Q?O2kM1/b0uzXozSUrwNC+ruULU/5wY+2X3THblfC+mrbMmcGF5thoZ8MRen3h?=
 =?us-ascii?Q?87eJea0KNhEh2kn8yNpIkayUKi+YqxcjQGig3rkcFcGvLnRYwgwsYnWCj6mj?=
 =?us-ascii?Q?anFQ/R2t06ijwvZANWMOJOqNCwua94+zmXDm8g6u3YQOerQRVp19zQQKN1vM?=
 =?us-ascii?Q?229gICvSzVUS+Xym826Snrc08+FEFhG14kFZi/93ZHUXfCYKdQAuW7gJmjjm?=
 =?us-ascii?Q?ZhC70VzL+EvbVyHGdshJu8Cl5sRLTHSMcPS0rpog85+guWg77WgOrfT6QG37?=
 =?us-ascii?Q?EghLN/Svb6NP51WKtsHoiGA5LIIok7UfxyX9Vfan+06sryLf86QQAI5xyg7U?=
 =?us-ascii?Q?7k2CX5rZgUe9nAtexvzzJxCQERrETnHqgQPBRPLZgw08fwUZpM2u04F2GYrs?=
 =?us-ascii?Q?5qrocT9yeKv80n1WGsVRAMAnPGQ2m+0xD2r6v62e/eUADN1x4G4gqTBFqq01?=
 =?us-ascii?Q?TbFBTiYNjCxgSYVsgqg1WrUIjz7o0JmnvYXDonDLmthflupkO1ZJKGnONC4q?=
 =?us-ascii?Q?7rlc0yLkk8GYBZj9mel5M4sJJi+uMZtbk9WC6h2IEaWZY9O1AVKol+GTH0Y1?=
 =?us-ascii?Q?GMTHXlUpiJcEhi8p32MIpjrg9BKcEyYgkZfK5/0foA93vkLQZifFtZDDr9az?=
 =?us-ascii?Q?NGIn5yZVxqIzC8zvsCpEkhXjWSGWWvCjfwJf4KjRp/ozEKk1Lz14Y2yHQWhV?=
 =?us-ascii?Q?xswXwIzBMl0FG5SuLsv2QHRoHsjHTz18ZqSxYn8eaCE0BwsWtjDljsz92NLG?=
 =?us-ascii?Q?StiEeBYgKpncng+kDn6qJQggsnn9eK9fu+aHWy0UszaWsARuFYGvx7HQDzrR?=
 =?us-ascii?Q?9GmpN5nD14fveIp2WeJScR45D8X3o/SjN6dSh3yhaCfVD7r5ZjVuE1hwNMH4?=
 =?us-ascii?Q?56Torm5Y+otkczhXuClTiKz2nbYy+462PvUuozoFzwcYk5wH7rNlKGkrPET+?=
 =?us-ascii?Q?dZ2yi1LnsLRzz3Fi4NgQtjS9oOoEPX6bbiw6xg5LcGgV3Kh2LueFIBfR5aG8?=
 =?us-ascii?Q?nT8ADxx9mVdDZBBQSbUa+LlWFnFFNYMGLjL/QFPAyrG4kMrCnsngPoE+9JIY?=
 =?us-ascii?Q?r/sOY47DsRudp9mZLQ6IK3DrPzSKT+RTdEq7E1DtAw8oL+Vg1JL7L1CTxHtF?=
 =?us-ascii?Q?AdJopDt4eT3S3ZuFv+fgCZo17SbnOGgNAqNxm25IRKof43f6GBD/Nj/jSD3I?=
 =?us-ascii?Q?0q7x1Sb+2U1q9slfoVoYv96RSWe7QiamWHbWoNgY1V0m1rHaqr3NLTh+720R?=
 =?us-ascii?Q?x79kPafoO1d/c6KIRhajnihM5rxeJ4UqRyyt82Otlp3ZKvKswCO/9n0JIkcU?=
 =?us-ascii?Q?gpyo7iUMmJGAeKuXx+KF/uTfeMql+Zw4n5hmFV51YAyeOuwTNLDZfhf8aeNi?=
 =?us-ascii?Q?w14/k39H0Y8bKDtOyOTFOqY0SlhARXBVM9HJ8ECmO8s4L7RD4hm+VcrZ664U?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RVsCMZaW8z8kmRaKXICRwJRX8TrpvjubcHtQ1mILxJvzeImkkDhCXVHBjjl1FgpZab/OVJLOIWVgpiJIP24CF5Djb2ExU43Dw2uLvgxYBP9GVLs7NJRaKHUKJM+MYnQg7QsvOisl5fqjClxR8HvVjsoh9jztwammf04vQP+v1Q8frstQ25Bzh39gzcnFiwuI+2YGQ6CJTznb8S49ZiZ1dWtc0ZS6IfNWn4XAHdemuudvFDNOvEWpILZV5CBmn9P5pqSjv9rChebUNmeYHpyyUynhDCi5dsv2Gh5Le9bxjWlzKoFTr0yRS6M/eYZJzPXk5YzRn9rmrXXKa+808xUQQqzkXCP/OzUu5cMo6T1R6MQvdjSl18xNHnF6yGvQdkNiXywtYKd2HvRDtvyTacBgcooyZojO0Pt06NoLh98oLC6klAKQEKzhXjA0f5uhSKig/yhOjRrrKLX934Ct5FPQC8OrgnOJwNaKa9EXFEM6uWxVz+MZ/OciAA+v/q5K5N29ZsEA42S0CCFtZynQZQAwHrOFS3nOq88qtVDGbFiKWj8O0ZC/zNe6i0qQoe0+cxgmRNbm69fSRXJMl6P+Jx+aWKkvTmCx8a0oGG5fREkEA/E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d709ea4-1cc9-4152-fe17-08de2b9af856
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 20:49:32.5723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XeVu0q9t240WnCDTlH9ari7zjBnVD80Fgk1gPQ87zQne0S0NQkvk/OOIt07fMHDCKuDIt6YqNFz34H/yLQYeP7sY493gDnFzkR46DTrUiUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_08,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=529 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511240182
X-Proofpoint-GUID: IYZCv9QqHjcwf89iht4ycIMVrbI6Udp3
X-Authority-Analysis: v=2.4 cv=ObqVzxTY c=1 sm=1 tr=0 ts=6924c4e0 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=TCqOSzizJ9_xYrtHMiUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDE4MSBTYWx0ZWRfX220HiyaWZvFm
 LDnbB9sFo4yu0QiPY0W3pJsOfJOwkJds1vjnb9HiWq7U2XgUHRzyjd8j9TkUOHFX9fRUoqfSpeO
 kczD6rEfhuijRkTaL2Yq9Wl3PpatzCzqzhGXd7iTLOeCaJGTMU0F6pOSQKTBKUFeXGGtO2+d5Fi
 J+1yVUtpV3TXg29j9HNcBFe1vgx3dwHe5W/yRASQOlkeNkGoU+3MfJSoCK+mrX2G/xs8tGhOUZN
 2ywYmJT36pSAQJzklpibMkCmUiDSwPJ0dtGUYjNYzRz266MDxg2ILaQ79BVNAWvFtu7cYywSQ4y
 Za5vVamTo50t6UffJY2WatGqGvDp4sOgNj+culJ8RJXT7O+FxUKll5oYYx7f1URw5+Tevn93/cV
 90D8aIlu//WLcwBGl8/EE1K0dEeOLA==
X-Proofpoint-ORIG-GUID: IYZCv9QqHjcwf89iht4ycIMVrbI6Udp3


Keith,

> Truthfully, the users I'm enabling rely on the NVMe io_uring passthrough
> interface, so much of this path isn't in the path. I just want to remove
> the dma_alignment limit when a csum is used because the incoming data is
> naturally unaligned in memory to the lba size.

Yep, I understand completely.

-- 
Martin K. Petersen
