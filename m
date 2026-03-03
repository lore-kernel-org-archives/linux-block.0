Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9853090C5;
	Tue,  3 Mar 2026 07:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772523532; cv=fail; b=VWODhI8T8lzf5KiYXFHrbZorS6qpCGMEJoSrsr770qRnWa5pFZQQ07ao7WTQULns6I/q3xrlVEiulPS5Cj6ZKQ9G+ILZcdC9ZZtFW/idDONfPDYWh1TTQ5tAyCC9VBkPHAXt/PUduJx9JUW7CyMh4mGvYQGfINdQYbXw5ZuQz40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772523532; c=relaxed/simple;
	bh=/IdmbcRHIMWTrqzBkQKkgBFFT9LKO43gWKHa8OO8MAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DDSSbQZfzy+RTBUCZxbDdymjnW/tXAOmn/3T/V4F/7rN/GCPyPMhPEeOwy0LbDNJY6xI5SR2pc1HeYXT7rKSw4LRuQGyAMsQcBQ1Z+Dz+AQGzZvwaC5NfMgBserrP/CVBF9c61aPcWtVn4gCBszfE5uKsQNop/5cIeDz1SEkd38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=q1hszg1c; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="q1hszg1c"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6235WSGO3928414;
	Mon, 2 Mar 2026 23:38:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=dAPi2Ev3h9FsE/PCMMITvLlm6CY8Xjp1D5Xa1tGOkEU=; b=
	q1hszg1cCjIIvTIOGELchSz79BaUxBlmdsq5IlCDpOEqpAv9MJ2Xo+hi34bgMn2B
	1vPeeW6zDpa/CeGiYqYXgDGe20u+whHajRixJv9sRV+PwYaf9vqHYH74iW/4CwMh
	ZGqIBX8z7hQNwFXjapFHdz6m40saE3tIIQUffHo3WEt+NyXdJ0eetgLW1JMDkqEx
	ZEZf/lW720G/7JAk0K1LerBCyrLdELhHGBX4bV+rUago6AkWgiZq/mpd8aQD8wV+
	/Tnisz74n5l1+UZmxC+184H5C3r+Qm6DDDAHpP7qK3y8uPTk0fbhZc8txBYLYsnD
	0ztj0t/pZL9LIMELJxNy9w==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010068.outbound.protection.outlook.com [40.93.198.68])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ckvh43220-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 23:38:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y74xLOouCk7ZEcKFTuEOMNMru5WLrTTiSBdMBalaMSZpNLHpu7Nwwt5TNZ5rNv7Oqwr3/tPrDp8UGWgK+CpSFXYGXbNZBe+zC7fG7A6sEW/3Xo6Wpt4ONQ+6f3bXVgeryCDWfm6L4ep9pKyXkRhZteaFnjZ4uJVvgGVbXf9jwSvFmNkiAeZDo9LskgkzOQIGgOFTTNwo3VCwDZAfobMxny5n5v6A+wXSug2J9qFinITw+qiOgmLEi7WTBU+OhdC320GzPSRuuhX5Zzv2y4gMB5OHsktA/gXCN8m7Ya8JWoH6AavvYK3WPXoAc+O7RIsCGQvsJ+nSdDcfWDjeBNNy1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAPi2Ev3h9FsE/PCMMITvLlm6CY8Xjp1D5Xa1tGOkEU=;
 b=Yk63MsQyrYdGPFeFcBGS4imrTA4cdEBPyY3Pe6CIP5ZcUf9ftnSsZRQg9yPBzRk5B9bpSeTylxIvutuPtv4/2BRbM++2D804gQLBEZqXJBVZblDEweEU5U9pRlv0tz/2kA4sTzZi+1lgZA8hvbVhLaJglQ+4+xFpQ1ebcIJc8Sjc/gqy562wMbktrj+X8BsSzAGr4h+vP9evSk9dgWIRB5awTAdoEYftq5SUhYTWtZOfHd2CZNFgTagWdsFPqKGR0Cjj09upLlxHKx5vQCO8t7GBQMHxw6UBRqJbjFYQrsFBQwWFFGiKZniogtAvmCIbtns+2amXRCrZPKHU4vwtYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by SJ5PPFF330187AB.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::860) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 07:38:01 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845%4]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 07:38:01 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: linux-block@vger.kernel.org, axboe@kernel.dk
Cc: bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
        ming.lei@redhat.com, muchun.song@linux.dev, mkhalfella@purestorage.com,
        chris.friesen@windriver.com, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev, linux-rt-users@vger.kernel.org,
        stable@vger.kernel.org, ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Subject: [PATCH v5 1/1] block/blk-mq: use atomic_t for quiesce_depth to avoid lock contention on RT
Date: Tue,  3 Mar 2026 09:37:44 +0200
Message-ID: <20260303073744.20585-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303073744.20585-1-ionut.nechita@windriver.com>
References: <20260303073744.20585-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0240.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8c::9) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3885:EE_|SJ5PPFF330187AB:EE_
X-MS-Office365-Filtering-Correlation-Id: f40b067b-df00-4639-fc4b-08de78f7cc62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	KQao57MmIgic1HZklBWgujFZWr0EWpuJgvQLRIyqGIN0Z+ukdW8U/jQNAFiwLhpa6k2nVvvuBcFj0H6p2xTWPR32C6fwxDoRigBc00pPDnFGwnq2wF+XVnldKpMtpoxU9kGvJJXP31GBQcoFpFKQBvYzxaPlXxCT7v2OtAnHTF59+QRlbJ2AjgC/y++2Ef/nIU7mcb1lf9epbrjdH99odCds1uvJ0bmeDNhiHN8Q0DmU/lpG37/3sG32V7XVyvlUkMccEhYkg00cqcxOANz8+j1OWueJIQRUpCS7GpkZr+sy3287ZJ0hRiUPljj61pVmBeW0J3Hl++6fd1A86RhviBktpWbqvy04KW+pW4GpciTOyYVq4MoWayf9tfnA6KSebrg7KioMY/ZsIzWPCmgyS7KbVngnWNo1s+rAydzAcsRLqyEWujh0jrjzvtbwq8S8CqhO49nc5fGgo4c/K5dASrUcEHMqAb0o4NGTYSqtMeZpmKuuZNz6xNb503rC/zSwzjwCXb1JjrTrT8SjGxuHBUlXgW1T2lFl60Q+3hZF1ArgAo4PCDx//ju2RvqaApv0lI7HE6jq50k5MZwYS8EmYpWKMuJ+ayD+FEuwE8HDyrrkCKSU2RXcwcUVrnU94JIWVzNIvmhhpmuZgoOh5P7MixtZDJNSsfT+tt2T2QjVrbt8a/RdzInByBdhvNm3zaKMMShdniUwZjwYQhrSEeuqs4V+4s05xFYy9TNe//15O4c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?80/n5IkRchxkTRu62MeH9Y0t9kHCFUWoIvW+ZOPd3C4XbUzZWtZitMtrvE5G?=
 =?us-ascii?Q?V5I0F3JIqNROAR55pvETeL8ReuIkYME0cPb99USLK5XR3THaRzMslfSRftRF?=
 =?us-ascii?Q?xIDoBCn17d/eFrDBlWtoJ/79dxeoy5rdGw+mnXtYDpeQ0ZvIN66GKjZGIFvI?=
 =?us-ascii?Q?luA3MTEvPCLezr4Jjfbhn6j+BBZMAbY5do7CBxSI9qaIFYx8NRcluD5334cT?=
 =?us-ascii?Q?v/ZpMkyFzM5eQq9D2CuMK1/MyjGJB3p/HYh1n0CTgBAmu6wgTZxxZ21iMNsD?=
 =?us-ascii?Q?YMpuTWe8AoJMsec7XxNHPeHPB6G+dmTz90JWkUO94RITgCGgjSCLQkKCIuVA?=
 =?us-ascii?Q?2vunNCGHfK++rLJ2SSSNpSh8KCfHN91KRKtBzlm2rXwe4+HfWRuIHhKVOQXH?=
 =?us-ascii?Q?7H1ss0COiMO6FoXJQM4JnipoYh2PfbFr4wOaMUi74tFEdKXjpQYL6a7W+8Y6?=
 =?us-ascii?Q?GR5LcjxHoqlLQ1BF6UgBHRM79EAeWX+u9qmGVApFvDk5hjtOgEsLyvIHkTW3?=
 =?us-ascii?Q?mzbz9p/SaoMg9excXzyXNq8guPCEuX32uyXQ26PB+6fUy9kbHSQaBOPY1gTB?=
 =?us-ascii?Q?YT/ciiSYf7wPpQn6H34vI5Dk4p9olaOlR3t9TYezlHVmNycJ3JMZiKJRbBQA?=
 =?us-ascii?Q?+V7qo5cZdbvRNBiM8HakmdR2bYwzE0u8hJV2zv1q9EriYsGhbZF9/3WWh3fQ?=
 =?us-ascii?Q?GLZSvg0kHCVhkeXZimNpJefajwuu6XWiQr3g8HXyk3L/Gde8ET1eibbyv8/6?=
 =?us-ascii?Q?d1ArYR+BDwTVu92dnWyBTuiQrb1qrSnTp33L1uzm5B0Mg7A7khJeq19Fb1si?=
 =?us-ascii?Q?VlyjJywjym278kGjDJVsdPvoNaKy/a709AVllWIjy9bJipHsS2Ezs8yqydfw?=
 =?us-ascii?Q?0I1Hfco03JZahjC9vE3uZNSoIE0hZVgaU30hVhs6pYu11qW9KmRaQVHpyQmn?=
 =?us-ascii?Q?1NfO6IRq+/u38ewpr9XYVC/ZcKB2DT6xlvCieOL39NbpaDrspVlh/BFoUAxX?=
 =?us-ascii?Q?M3wGJBKa/96fjC5rwVlO5jXwdxvnClSO93f92L3PHXTPrQULU+45XTgUx4Sh?=
 =?us-ascii?Q?+k84QdX9hDbBJkZDSYIIhpTMUQNREfK3dSptVBdj2KQ1kA9Iys2lS+hHxBVz?=
 =?us-ascii?Q?SGop6MrQVp1O+1oaujzETNAIqQ2XZM/WpvjIUqnGHdSU+6vf2qks5u+YUuSD?=
 =?us-ascii?Q?/i7A0daIj5imzQvoEJljO/NNOz5CuOZ48nHoijjtA8+0DMpfisdRT5n6k42A?=
 =?us-ascii?Q?ubYe5u/estJJPl6bAxVMHXAOjURbsyK209+5v4mD37QdsuFvf8M5R9idC+OC?=
 =?us-ascii?Q?h1481X9r48aNVqbzlw+0dek60N4drrvmUVEulDtmmi/OWp3q39QWYszYyBkc?=
 =?us-ascii?Q?vPV8nIojuDz/lHMqNCcscdeYgsO9t5Lc8hI5Rd2667EEljoY1ntbREfVidlx?=
 =?us-ascii?Q?tI3FIVHiIPrzwb0CtBJ9sfBFZRAhvHLJf2A1bVD1ZrQOOo17SaB8BEGeQiM+?=
 =?us-ascii?Q?qDHSuRJKPLZgPEAouuCIyi0C546QC5MqzihIxA0mBYEUgfO6imlVzpyvNZUK?=
 =?us-ascii?Q?twzpjD90I4MpR1r2Y8rqOUK046sv4D1+QVVdMvZEeHtTfM0nPxD4agUxHYX4?=
 =?us-ascii?Q?hOs74w7b9BJGtXEuxEcuRPaatbQD5B3Lwkg/SSvEDEhgTjw1f+i8SKnRFzQY?=
 =?us-ascii?Q?5TvNR1nOKBMgpTaMDHEmsKDh4aTIRTPcTi0AUZmz8d7yT3pRLK0Ur2LL7bgu?=
 =?us-ascii?Q?Evm7Dkz4xMqAnwl8yUP+y2EGCTHpZCS4RahCGYssPO99gR+tCs9YpT4F7B0r?=
X-MS-Exchange-AntiSpam-MessageData-1: +DbtrK2W74PjPztcmtTgTanJYRl3vwkSrWA=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f40b067b-df00-4639-fc4b-08de78f7cc62
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 07:38:01.5787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /1jeHx4zqQdDyaTFWJ/5E32xSFgl7EdnIUo3rGPf2tV8JS9gMTi8m0XbVIQFIu9Blo7taTGBFHOuQ/XpM8VU/NtBoOHMFzGkMXI4gPO1E40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFF330187AB
X-Proofpoint-ORIG-GUID: pfaK2a47gux6mOQ65BoARqL5gGbCmXNK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA1MyBTYWx0ZWRfXxkZZP5t6HzKv
 qUVWeWgGvvDoOpguV4yChmwdcjwyUK0oq8C2BCeJT8RfzbuQM/MSgvFQ+vrC3Pq6XzDCSd7qd+S
 86e+ua6T/+W2vnnVWL5jMhGbQlF3dSa23ap6sRdlOcQfaSaprBLxa+9QvUuAgwH04KCLWjssCtB
 s1Iic1jF3ShH59r/9HP2DsPHaB6BlI5G9LinA5rRwSUW8A90dLRNqXKmPsuIhI5WCrjlVHsK3tC
 Io0adRD7jQqihTLZhDzXgWbDq6/h18Q5pgesS2VbTtHDMG4UG1W1oTn2ltjPC18eI8HtpqRcdek
 r8gTHwnb6a5KuEXqAGzkH+iQKU0mbwNsHI1bta025iE/pVHELQaJVTeDZU6rKTFw6XEsp5XlLMc
 +4fyE9k8+JkOKOPkGUOVy9EYDFA1dhBXZa1ZDU9gu4r2c9pfjcSRYM/fk4vC3hHfMgNPRi5vxVc
 9IDe/+Z5WZtUx6xikpg==
X-Proofpoint-GUID: pfaK2a47gux6mOQ65BoARqL5gGbCmXNK
X-Authority-Analysis: v=2.4 cv=Z/3h3XRA c=1 sm=1 tr=0 ts=69a68fdb cx=c_pps
 a=48c6PaPq82/B1OY+thwv9A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=8F8sayd3OLXzmNd1YCMA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030053

In RT kernel (PREEMPT_RT), commit 6bda857bcbb86 ("block: fix ordering
between checking QUEUE_FLAG_QUIESCED request adding") causes severe
performance regression on systems with multiple MSI-X interrupt
vectors.

The above change introduced spinlock_t queue_lock usage in
blk_mq_run_hw_queue() to synchronize QUEUE_FLAG_QUIESCED checks
with blk_mq_unquiesce_queue(). While this works correctly in
standard kernel, it causes catastrophic serialization in RT kernel
where spinlock_t converts to sleeping rt_mutex.

Problem in RT kernel:
- blk_mq_run_hw_queue() is called from IRQ thread context
- With multiple MSI-X vectors, all IRQ threads contend on
  the same queue_lock
- queue_lock becomes rt_mutex (sleeping) in RT kernel
- IRQ threads serialize and enter D-state waiting for lock
- Throughput drops from 640 MB/s to 153 MB/s

Solution:
Convert quiesce_depth to atomic_t and use it directly for quiesce
state checking, eliminating QUEUE_FLAG_QUIESCED entirely. This
removes the need for any locking in the hot path.

The atomic counter serves as both the depth tracker and the quiesce
indicator (depth > 0 means quiesced). This eliminates the race
window that existed between updating the depth and the flag.

Memory ordering is ensured by:
- smp_mb__after_atomic() after modifying quiesce_depth
- smp_rmb() before re-checking quiesce state in
  blk_mq_run_hw_queue()

Performance impact:
- RT kernel: eliminates lock contention, restores full throughput
- Non-RT kernel: atomic ops are similar cost to the previous
  spinlock acquire/release, no regression expected

Test results on RT kernel:
Hardware: Broadcom/LSI MegaRAID 12GSAS/PCIe Secure SAS39xx
  (megaraid_sas driver, 128 MSI-X vectors, 120 hw queues)
- Before: 153 MB/s, IRQ threads in D-state
- After:  640 MB/s, no IRQ threads blocked

Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Fixes: 6bda857bcbb86 ("block: fix ordering between checking QUEUE_FLAG_QUIESCED request adding")
Cc: stable@vger.kernel.org
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 block/blk-core.c       |  1 +
 block/blk-mq-debugfs.c |  1 -
 block/blk-mq.c         | 45 ++++++++++++++++--------------------------
 include/linux/blkdev.h |  9 ++++++---
 4 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 474700ffaa1c..b6104c672547 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -434,6 +434,7 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
 	mutex_init(&q->limits_lock);
 	mutex_init(&q->rq_qos_mutex);
 	spin_lock_init(&q->queue_lock);
+	atomic_set(&q->quiesce_depth, 0);
 
 	init_waitqueue_head(&q->mq_freeze_wq);
 	mutex_init(&q->mq_freeze_lock);
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 047ec887456b..1b0aec3036e6 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -89,7 +89,6 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(INIT_DONE),
 	QUEUE_FLAG_NAME(STATS),
 	QUEUE_FLAG_NAME(REGISTERED),
-	QUEUE_FLAG_NAME(QUIESCED),
 	QUEUE_FLAG_NAME(RQ_ALLOC_TIME),
 	QUEUE_FLAG_NAME(HCTX_ACTIVE),
 	QUEUE_FLAG_NAME(SQ_SCHED),
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9af8c3dec3f6..8bfad5272d6b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -260,12 +260,12 @@ EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue_non_owner);
  */
 void blk_mq_quiesce_queue_nowait(struct request_queue *q)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&q->queue_lock, flags);
-	if (!q->quiesce_depth++)
-		blk_queue_flag_set(QUEUE_FLAG_QUIESCED, q);
-	spin_unlock_irqrestore(&q->queue_lock, flags);
+	atomic_inc(&q->quiesce_depth);
+	/*
+	 * Ensure the store to quiesce_depth is visible before any
+	 * subsequent loads in blk_mq_run_hw_queue().
+	 */
+	smp_mb__after_atomic();
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
 
@@ -314,21 +314,18 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
  */
 void blk_mq_unquiesce_queue(struct request_queue *q)
 {
-	unsigned long flags;
-	bool run_queue = false;
+	int depth;
 
-	spin_lock_irqsave(&q->queue_lock, flags);
-	if (WARN_ON_ONCE(q->quiesce_depth <= 0)) {
-		;
-	} else if (!--q->quiesce_depth) {
-		blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
-		run_queue = true;
-	}
-	spin_unlock_irqrestore(&q->queue_lock, flags);
+	depth = atomic_dec_if_positive(&q->quiesce_depth);
+	if (WARN_ON_ONCE(depth < 0))
+		return;
 
-	/* dispatch requests which are inserted during quiescing */
-	if (run_queue)
+	if (depth == 0) {
+		/* Ensure the decrement is visible before running queues */
+		smp_mb__after_atomic();
+		/* dispatch requests which are inserted during quiescing */
 		blk_mq_run_hw_queues(q, true);
+	}
 }
 EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
 
@@ -2362,17 +2359,9 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 
 	need_run = blk_mq_hw_queue_need_run(hctx);
 	if (!need_run) {
-		unsigned long flags;
-
-		/*
-		 * Synchronize with blk_mq_unquiesce_queue(), because we check
-		 * if hw queue is quiesced locklessly above, we need the use
-		 * ->queue_lock to make sure we see the up-to-date status to
-		 * not miss rerunning the hw queue.
-		 */
-		spin_lock_irqsave(&hctx->queue->queue_lock, flags);
+		/* Pairs with smp_mb__after_atomic() in blk_mq_unquiesce_queue() */
+		smp_rmb();
 		need_run = blk_mq_hw_queue_need_run(hctx);
-		spin_unlock_irqrestore(&hctx->queue->queue_lock, flags);
 
 		if (!need_run)
 			return;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ef6457487d23..e27a437f2a77 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -520,7 +520,8 @@ struct request_queue {
 
 	spinlock_t		queue_lock;
 
-	int			quiesce_depth;
+	/* Atomic quiesce depth - also serves as quiesced indicator (depth > 0) */
+	atomic_t		quiesce_depth;
 
 	struct gendisk		*disk;
 
@@ -665,7 +666,6 @@ enum {
 	QUEUE_FLAG_INIT_DONE,		/* queue is initialized */
 	QUEUE_FLAG_STATS,		/* track IO start and completion times */
 	QUEUE_FLAG_REGISTERED,		/* queue has been registered to a disk */
-	QUEUE_FLAG_QUIESCED,		/* queue has been quiesced */
 	QUEUE_FLAG_RQ_ALLOC_TIME,	/* record rq->alloc_time_ns */
 	QUEUE_FLAG_HCTX_ACTIVE,		/* at least one blk-mq hctx is active */
 	QUEUE_FLAG_SQ_SCHED,		/* single queue style io dispatch */
@@ -703,7 +703,10 @@ void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
 #define blk_noretry_request(rq) \
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
 			     REQ_FAILFAST_DRIVER))
-#define blk_queue_quiesced(q)	test_bit(QUEUE_FLAG_QUIESCED, &(q)->queue_flags)
+static inline bool blk_queue_quiesced(struct request_queue *q)
+{
+	return atomic_read(&q->quiesce_depth) > 0;
+}
 #define blk_queue_pm_only(q)	atomic_read(&(q)->pm_only)
 #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
 #define blk_queue_sq_sched(q)	test_bit(QUEUE_FLAG_SQ_SCHED, &(q)->queue_flags)
-- 
2.53.0

