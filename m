Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DE74772B6;
	Fri,  4 Sep 2026 11:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788522252; cv=fail; b=o+IXo0umWFyMnItfkppZ9SHhbVL6LbwfcnYPo1TqKdy/nkhMNkRADL1p5hcHMmfI6Fyj3M8H5OUwmOLdI5+Hk7Rs5h6l7+GrHuLuOL0h9YRPmyiiAJnQlN2MKqr1ChP0qpuMXCoLUfHMmfGLcludkbeG/bht1WzAKJ0rNjC71YU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788522252; c=relaxed/simple;
	bh=CtmVrSEJg6Y4pG/gNM1gwJi+zB3o1x7kbPTDkqWstbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hf+4H0mX3RPO5+tamcgR+eJpS92y0bJONcnbtTYd0QLkxdxzfHrYjyTYY48WBTlfbZG+xIRmEAE8G1kyjgefg7IzT0WnngtK+u49hgcL6z2lgBNX1tJHn4yDVcieyshmk7aB0pbuWVocoAEGQ7oUxahuv6Jgy+P5FJaVfEGdYHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=XAtACBpc; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="XAtACBpc"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684AJVOs1020437;
	Fri, 4 Sep 2026 04:43:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=CtmVrSEJg6Y4pG/gNM1gwJi+zB3o1x7kbPTDkqWstbY=; b=
	XAtACBpcRelYUgs/v7AcYQmJ/vYNJjRokqmIG11zafndwuXugMXBRNzM+NqQEmKf
	BIoRgvG1ZWTw1/rCrb5C2+ETQjmTgDMkZoDQicy+T3Vx2YCoL5UYvqbt5h/15peC
	wV8zLAtbRkDnta1RumtrljHrQ6E7cfpJrTI93k1csW7MiBoxG8sG5bVcGbxeQfps
	eRLalt27phdQN4fbYxOt/ZYf/KotknoatdvJfTL/pcfQJHHEmKtUxlmYK1oeaWSN
	itu3cGy9aw+O5A87h7Tng/0xYAgPQE/lane8p520qi0MDykM70S4taPXv2drtq9N
	xXbWjqlQZy/4nx3s6W2Yeg==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11020106.outbound.protection.outlook.com [52.101.193.106])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4gf5qsjar9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 04:43:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xaC4YkDOWulWm8nYvVs5fc+1qzavCkkFTao/ctESOl0EcLKkEsEbwU5wYtDmPGX2lZe39/lW7UMg0n2lxErq1xK0v6cq1zJPoV2T7ORZnMoF+HLlfvq1WfPnM4d1k9HXx5yNkHmGvw7IX1kt1sldQ6no0Fy23mhfVGbqRxWe8c6Lit0bhpLOEgWaFjY/tzN87LwabbLyDq/lgJi7XPUd0tRTSjJ3wzN3/h2zHeowVOV1BspcJCPxAF7AQxQNSnTuMyivVfm5YOKuzk/7neBcpKBFcVHu8KtgN78Ddds3Ie0j2xzDmIVfTICtPUw0YWFt2bD+LWbQTRIGEdBn6JIT3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtmVrSEJg6Y4pG/gNM1gwJi+zB3o1x7kbPTDkqWstbY=;
 b=W3BvUH8jEOMxkNFQWC8pV+jM1lXs0BJ9IlfjbJP8C7EOZCnNKt3yWq9IT0lAwFxHaYbg07SnR5mjVh663qbTnd7hO8UADtOKaDLbQj4LGPiPer6qiuhDjKeeC+SovWt8FPsjWIHGd80LI08g3uGQhnmvQGXXJWO/e6nQlXYGm5jGyXn3VdwtRIPSA1OymiPV3+gzaA6aBX7JhLMZdQCqb4+Voru+h9gpkA6Il1ovvsj68bDlmgHH/08a5jSfD/LBoKaw+s8Qmifbkqvtdrrn6nYgofqK5PH0Zxcc/rCJyuJPcChFP8oz1fXkRuxx9MC6sZfWzev40GCXz5K/PFK5eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by DS4PPF7CFF9C87C.namprd11.prod.outlook.com (2603:10b6:f:fc02::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 11:43:12 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%3]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 11:43:11 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: atomlin@atomlin.com
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        bigeasy@linutronix.de, wagi@kernel.org, marco.crivellari@suse.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 0/8] blk: honor isolcpus configuration
Date: Fri,  4 Sep 2026 14:42:42 +0300
Message-ID: <20260904114249.217677-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <k2lz7cbhtzlx23qk2nhii46znecytdfrcyoctvpqgu2ibttdbz@v2y6jttq2h6l>
References: <k2lz7cbhtzlx23qk2nhii46znecytdfrcyoctvpqgu2ibttdbz@v2y6jttq2h6l>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::10) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|DS4PPF7CFF9C87C:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd3a61e-0dce-4b70-7497-08df0a79b264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|23010399003|366016|38350700014|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sca+6hEpM6tNpj9Fu9bv2ptZ5lVatiEg7JgzOo4e+rGDuIn2mOBa9unzHilTsHA/h4ZUBstymMKKxc1AlwDLTE7VASK5siYeaV6ZtJkaoEkIF008d2xNQyvZiI1sSw/3XBo98zNDFrriOQEM/dbIRGzft1Ra4j6WLm6Wd7ymh41tiZ8NxxdylgBAqy419rwGeD0iwpbQNh/5NRTMPdtKFk93W9rR0WKiziJUys+wmnLJm25bPZQdgQ3bvuqc/rTVkJplArloiG4MipCKSicjrnv1wrw591DU/g+Tlor/WXTdunaZxbTJoFkuu0mLHumJAdSVOmMjwmFFHCfA4cMfrKxc4nefIbSN7RvcDwkXZSLRHgI+OQj9KaK9Pf4mBXTwnKamTYT5pG6wEwk1d4G0UcVAwca1BG2WKG4j6YpMv+Fs4YIMtlsC+eAACJ4dbhbxVCBfpGuKNMMS45BLcUZs0lgq+FECPx8Nem9QwbXJei6e0SAc/5r7wBoYdCI+txFhqRGRUnV1yAxEkwX42dhRtY6iLbdb2ogDAX8uJaRbLqhkzpUfNO+mNkloC3c83F4xDnBwpOrI+d/NezwFebU6hdtqjjV6ls98+77Z5GcK3QwPQ8rdREz8QhlYhbN2Kvzj7QiTEk2knC9GMs9gLP8kMHtOYko8bNGXZ1Oz/8/2QWHrY5wHpcOpx/CYUHauBlY03Ix44j2VqHaMbNdhjZGYtA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(23010399003)(366016)(38350700014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/8oItYs3cNwHcEyPf6/tFgP2McSAVMXlemz0JjryIl1h0SW6VJF6dGjnlJ0U?=
 =?us-ascii?Q?YQEc64NTE7kooti1lWq1aEoHWGZQTKRq7oLL6IHNTsu9izIEOmBOB7oJ65oT?=
 =?us-ascii?Q?JdIZ9LNJVAGjiw38jv5WbZP7g5QIwIqcEkmrgFhWT8lkZVxfHARsUj3wA78B?=
 =?us-ascii?Q?hIOeYIOwLl2zd4vPkLRBMnBnKpHpOix82YCP+h+d1yjrJfUspkZrhFPh7h79?=
 =?us-ascii?Q?/VN9BnYPRG425/wAYTKcbSd8NSjXaa1BxsBVioikM4U2CxXhPozHzR6/XvJ4?=
 =?us-ascii?Q?hIwe/hYz+KF5m3fFL7vGJ5/tnhSv9224bJa9NEOFyAujV+STlHkPb19iAK2B?=
 =?us-ascii?Q?1ZnXMipCUjHrOiEShHFek+ZzVdR8FMfTdapmoD/R3OQpQ9QVj0g53v30wFlV?=
 =?us-ascii?Q?Mg+QnYrnDBrvyFit60VM6Coz87wfraDb0wYilciPJzdQtwU+DvclI90k8b02?=
 =?us-ascii?Q?k8ZoihA2/kLWE5xlI8HsICgVBYTWanf2EwxUC9iaR7UWF1iokH7gIiqx6mlC?=
 =?us-ascii?Q?daX/bd97/w7cXlglb5yk8thpjTYwKJnd/SzokPZyCk844WfNGyJWa/9gxgw4?=
 =?us-ascii?Q?2a2YJw3dRJTGXaiCwH0+Cym2+9G/P6ZPvS1eODDqObMYGKxz3chl7GEVpzpO?=
 =?us-ascii?Q?0n7FrUwMBjdlfqo5fwd8h+IHg/OhMCjR0N9w6niEtu1NAtd85r0UbnLDC+dP?=
 =?us-ascii?Q?WJPAiFJYAu6EAoA2obYsxtThO5pudsmtfsau0sLRVOeO0uwVcMpwtU+LDZPQ?=
 =?us-ascii?Q?rKLhVSavtfNEt0SlyW4/PEOtA9xncMeI8Yw032hbj+pn715BGyAvnk86+b1i?=
 =?us-ascii?Q?ZKM1/njKYzYYuhFP//QxG0c6aKZ+Um9/2RpqUlgqR5HWh91nogbbD3+2P4Jj?=
 =?us-ascii?Q?cPzrhMndh9UrMxkS6cB11P4zWmDSW0pnfjP8PhOrDBSJfIvFcm9Cp9ttkFSl?=
 =?us-ascii?Q?c7+M4EtDpgaLRD8OJMSow/9OfdJpt2ZJ6qoCEDnmLoCohzz9IKTGxFsdtLSw?=
 =?us-ascii?Q?7etZBTaWGg+RLVkCNeWY8uas+ajWAuUT8oSn65zO9CRaPU7siFnyu+/3QPOK?=
 =?us-ascii?Q?naJrZCyAFIg+twtcDGzG9Xiejk0GT4y3Yx9nr772dIVEO3p3ZAWIuVGOh88P?=
 =?us-ascii?Q?qWNMPrP8W0jU90W6Yf+YxJd6xz5xQrgYYXRyOl7mNTHRBYXHYzW2vRPrl+M9?=
 =?us-ascii?Q?SGG+fapJMXjDH6BCJlacNG4kUYUinIISzEx/e5cJjPW/W3+FnZk9VvqV7ho8?=
 =?us-ascii?Q?DnhXZYMy4xeIZPkJZkDQd+3lj1J3UY0M7jPqHUkMumr18rmGsNaOmtqaWB9p?=
 =?us-ascii?Q?rT3+9dNXr/aHIS++KtNi/NP9tf+psuI+ahRV8311h7+rWd8e7g8yH+1R4kGd?=
 =?us-ascii?Q?TPzSEUexqejozAw/ZNI4zpFtBo1kUcoSaqsQfdw/N4QQ9e3ieK36NtZGdWJy?=
 =?us-ascii?Q?cKXQWu0vLr2yizOkCPCgpy6uNvekkCYlpShb3xBQM4b3wB9WiyonZNWxCdgS?=
 =?us-ascii?Q?zeEPHTprhS8+hKD9w4GiRAh9jdxP3LYcpeitv0G0wmMUHWYWavgpxElXWO3+?=
 =?us-ascii?Q?iYgf9KdgX1HeVmv8O67W1d29g7cYI1oCdksYuwazHe+seCD+f4lIqj1+lykL?=
 =?us-ascii?Q?Q1eO9cjiZl1vHG/0T9LVRo5AhDQniITwwimwRuJ/hN7fCrRFEyIpF+aaSS3b?=
 =?us-ascii?Q?AwgWv2qUqoaDAmO97wezdoqQ+UiLeYYT9KXPAd6EM8268stVNU7C5g4pJJdk?=
 =?us-ascii?Q?kb8zUYi1LgaKUOqX1l34GysLgrMELTY=3D?=
X-Exchange-RoutingPolicyChecked:
	mYvljSzECIZsVr5B8xl/Aw51VmYCm07BuQ6N+OoyArLCTtVHJU0chwe4chxiZLWr09PDQssai6OPuflyHegAkR1W/0a7tNz6KhP+80xMP1SApWkMOXFDohq+eRSLHvzP2iIFyaKehNqDe4udAwOFd8peJ6te+oLGaa2jKRO2rWXB72gBwNuo823DdZC9RFP08/T+dndEzMUTLZOeqkV6C5SBBpn/fcimLS9LGWLYKL5P0y69Iy9P84qGqsC8xI8vdOlAbnvUK0F1VRJ9w+eUKguMHu5HBqFlquiA4G8Qctu1wn8jUBRAnA3z1eBpXpww83cFze/vTkG1afl3o9Q9gA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd3a61e-0dce-4b70-7497-08df0a79b264
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 11:43:11.4631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPm8lQE/NuoFyqdsxb/HZvuaFlkoQ1Qq+T3SCQOB0tr4nOCVi+oZB8tLlOLICaVNRaeApy8l/6jcImv3LW7lCHH+lUP817NQAmWW5UZ5fgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF7CFF9C87C
X-Proofpoint-ORIG-GUID: IXpSkbTij0YBh8I5k-wNX3AAJSidRKCc
X-Authority-Analysis: v=2.4 cv=AMY1HWas c=1 sm=1 tr=0 ts=6a9aaed4 cx=c_pps
 a=4ZUDiidoD8pqgsosA5oMHg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=s0HdHe-e17aw2oGrVpkA:9
X-Proofpoint-GUID: IXpSkbTij0YBh8I5k-wNX3AAJSidRKCc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDEwNSBTYWx0ZWRfX2RN6rpqNmfYV
 SNPb569XoLH6fB2nQmGksHFGowtte07F7ADsOqBuS0ZVAwwXob/ITjYT7BxdCe13htMnN0OTvgs
 fPZEbnNDzQMRvM4icN887UvDnVCQTwsqgXbiKLENQyXHGt/Ic7geHiEd7vyjsbGvC2JfoIVgMqo
 E2ll7P4fEte2TpFdyCws1p8QwPdpuULslPDiY/LCIFXdM8oBflCFu1N2DfPw7P/fNlhu0J1qdSr
 o2oLtydmB+yjy5TGOCjk1tFibYDKdgDCnNNavVUsPad51/lta+C1bM0QcSKr5b2dTudww7NW3wc
 ZCFPywM9RFytZYunG/+CB+PbWPAbeN+dcicLdKCk0+rjKUy0sf95Xo/KybiACM9WsBpJmdqjddo
 o5PmYkWJWuV5rwMvccm43StLvGKOXvvKtb+oqRwZ3NyocmbOoOmyJzV/TzBRvqw4FOsPpT1BIee
 T6xdkwvdGIO1yUNtRpQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDEwNSBTYWx0ZWRfX5meLSDA5Ywid
 dPhQ8Bl/hkxjGMI6LVOAbIhHQQyn+ND4TfMt9mI+tLGiEg/sPbgn7pWoS1W4sNjUX83OaiMXDCV
 EUI5Ogj1EnT37x5QvaIngWcm9JDPTDRtqStWypFhGmWvBW2nphbd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040105

Hi Aaron,

Just a quick follow-up -- is there a newer revision of this series in
the works, or posted somewhere I might have missed? I'm mainly trying
to gauge where things stand so I can line up the GNR-D testing against
the right base.

No rush at all -- happy to wait for whatever the next spin looks like.

Thanks,
Ionut
