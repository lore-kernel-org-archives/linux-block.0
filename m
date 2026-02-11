Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DD21632E7;
	Wed, 11 Feb 2026 20:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770842395; cv=fail; b=pxya5ZiSLcKEdVX+fsYFKQxwYAISik8M/SjTgYtBi9goqTVVep4cjpOSD0r8EdXRXrI9Cx+gSwmcw8a0IBxrpcei+HSldE9ZcV5xATzdr7M/sJB7EnuAApLPbQCtyhZ0rAKlA1wT67NaOotuEdQYF2QFoTy43odkN4WFXP+YaUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770842395; c=relaxed/simple;
	bh=9i1XLjDbdJzss9G50Vp3CvFS+q4q5W8w1jJbyGnsMKk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Bmz2rS73Ax7zA9BxxFX3QfoaBunqnpj8uDargcR4ZbfQALRZkb0jZNIAylTrxK6gwqg4WhJ9Y9Ru4LzRc9K+PCnLtE3kxq1qhQfzJqvHVERBlY5m4z0H3ikOubA/O8dg9kb8dgnCzjSsvW8k7KKyyD7K9uvIDVitaC/GoLktERI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=l/Qp5kgv; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="l/Qp5kgv"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61BJZMBl1198805;
	Wed, 11 Feb 2026 20:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=f+iFPBXIR
	ajTrA4fKTSe2v0a+AO1zQkNvR7Z9pSgEf4=; b=l/Qp5kgvyWP1RKH0LftE3LbVd
	iKuFz520BolijAYZo07OrjZv6i2rDHpmOl9XKKec1yFHVusHZz1Z9qvV3GUY5tRG
	QYjvUpY/Kr3MfZSF+Edhy86tyAA5fANlTW70nfPESAoVgi1bgsO4adWvlku8h+uw
	ACO6rfbtjWc0EdG9AhaGtl7tj7scuhUnZDh/ZUGVx2GeM1BthtlzNkHk3vPIqVxB
	m/kutFJlK2R02/eSFdBsyYCGCBU3ieNCszESpOCMCuYeIQ+8QaO8r6hXb/M7jtam
	FlClCzIj30EkUZ2sJ5GbfG+eR6obm4t2pGcZOdjNFCM+8/WGHTC7gqOBp7vmg==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013054.outbound.protection.outlook.com [40.93.196.54])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4c5tkwnab5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 20:39:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sctuh7ZNr1o6UTbT6N1XgvW9F7PoKJj6Hw7gWAkjyE5HLZ8yYamVdc2Hbyka9d/quNiKzzAq/3ngDyW8pgPCSe5mlUkSvvm4GsVIYXcZQ7YDexCd8XnPflDnSFlT4MZ8y/9yDIHFEhIUgy3vaMQNwWYkVSqfQUdbHwdLUqhO8s5kuyGWSM1IOBsRJCpCQrxtzf0Su0LG5qWqFJ+VU1Nng7ui7x7K9kx+wXkxVzt/H4Px8xBfbr1bdQ+wqEyETtUtKoQpn+h7fNq99qaahyy620Zj1dFnDoJ8ue1WqK4+9xN+3h7tNx8xIdTH/0xjVYN50CXfEN4SnYdxufcSSTlutA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+iFPBXIRajTrA4fKTSe2v0a+AO1zQkNvR7Z9pSgEf4=;
 b=YDYMPENM6txmrBmxgvQ3WMnMan6NvJgLcMXDsL4BZY3Voz/UOJtidftdBo5/KnVfz6lXplNiiZz/X1XydPC5Y7+1sbZeWu3Q2wFXVLWPPhnvSSk6/5By81X6SDcJQDPZcFBpePCI9f/V8x9iLaeHjglDntPq+y9WQW21OLJ08dQmrfVDWAOoT2EucsTWzPOOGXMnVzQfWk3CtuMO+tiPE+5Yoo/4ytBB67BG81k/okkquUsYl4ZYqQijHmNtjUOl/XZMb6837b4vtgco5UR6oBKQW2p5+4q2PQkI07jsuLavK0jRToVbkFybcEe8T7sv2KEleub/g82RIMKPzHJyjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BY5PR11MB3878.namprd11.prod.outlook.com (2603:10b6:a03:182::31)
 by DS0PR11MB8182.namprd11.prod.outlook.com (2603:10b6:8:163::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 20:39:16 +0000
Received: from BY5PR11MB3878.namprd11.prod.outlook.com
 ([fe80::5836:a4f7:7e05:d23]) by BY5PR11MB3878.namprd11.prod.outlook.com
 ([fe80::5836:a4f7:7e05:d23%6]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 20:39:16 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, ming.lei@redhat.com,
        muchun.song@linux.dev, mkhalfella@purestorage.com,
        bigeasy@linutronix.de, chris.friesen@windriver.com,
        stable@vger.kernel.org, sunlightlinux@gmail.com, ionut_n2001@yahoo.com,
        "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Subject: [PATCH v3 0/1] block/blk-mq: use atomic_t for quiesce_depth to avoid lock contention on RT
Date: Wed, 11 Feb 2026 22:38:51 +0200
Message-ID: <20260211203850.315635-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0275.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::42) To BY5PR11MB3878.namprd11.prod.outlook.com
 (2603:10b6:a03:182::31)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3878:EE_|DS0PR11MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: a6da94e7-5377-49e6-53df-08de69ad9f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CFYShQWqVR00n1y+RaG0F+jkZlSMra4SA2KVzUHz9Er1dcio1e/R1Thr/wGe?=
 =?us-ascii?Q?g93XcJNs97uKF35dxBcmAcfd4uqMe9XU6JQ/qtfFQqPRp1pNptOE7RqYMc9x?=
 =?us-ascii?Q?plRX3TCymLhHEGeXu7S+jEfRyKas1d6meVEvbzh6951SAtc3fHtHRRwIRqBS?=
 =?us-ascii?Q?67+YhywwlLUezqz4/d/j4huZxD46g2rnCMnXYePA5bJlPpw3AXmaiTNZaMwS?=
 =?us-ascii?Q?EsURoGosJmnwyfxnMrAcFC7x8nK3hBKKBfi0KSvJ9aXwl73FaSNCtlyfzsRR?=
 =?us-ascii?Q?a9PzJExliwLZlesFH3dXvTzp3rI3Uu0akB8db9NGcqKtvnYlEJtXEgg3lAKp?=
 =?us-ascii?Q?UhRNqcXwoBTqlTEmiKOPAhK3wxFNOnvWbRa+nthzwCK9XyB+i1It+hq25vsv?=
 =?us-ascii?Q?0f81RwSE8ovJTo9X87GsXz7JFTgfRdRWm3/Lyi3ZcahQyOQ40TdTap1LNUWq?=
 =?us-ascii?Q?qtsXhAWDA1vTeMBYtihWmJLQFt8r1LlnfiIqJTdlCRcFREu06FILZt0bgYV8?=
 =?us-ascii?Q?WjsuzMwmmHLxu002r+1a/ZbL0HHj4Twf7dVMX70G4GRF3JPLxGrYIML+n9vD?=
 =?us-ascii?Q?M/0FG5wnsRDaiOG2/kKUicC2tSG4Ge4iid0ToE3t3zdfeMFPuwG5PcsNCqDi?=
 =?us-ascii?Q?OMFqOhWhfqQNsbtKt4g8AffYXNR+XtfE2UZnPdQuoVvBIdGliqoKHjWh8WgB?=
 =?us-ascii?Q?ONhtzWfkvoOunQByH/rhn16eQmcfd3PhaszQ1zFchS3uE4w0b8hQfsStLY3m?=
 =?us-ascii?Q?fsx/Db0qVLVpqme2PxqrNu/fK09uUk6suydPHDVCGDah6jwh7FBdbHbgJYo2?=
 =?us-ascii?Q?5uQ1G4dvIZtHNE4u4uBi12MqLOZnb/tpTUk3M7OzwDKYLOl2gysJ3uxttXHG?=
 =?us-ascii?Q?dEatqVUox5YFy53x6dsZhxICeMPeZQuUi58O9Dsr8BW3Qp8wcTI3wSfbwouu?=
 =?us-ascii?Q?lt9tZH2hyC2cIKR76oeGn0bFjjxxoOBugEJ+5FP7CONzSXEcCcHSM4ZO9qI6?=
 =?us-ascii?Q?TkPhPsUVcQi7fa/fLeEu+mh2i1AJGcsdz2e2UKxc2ZzdzWwyzSP/GUOhn4l9?=
 =?us-ascii?Q?bygcBY3vTZwVyWummTZNJYigrtIqDo3yLhjq2kp0/lNp0TtmF8+QMOMM3Z1G?=
 =?us-ascii?Q?FpB3chvsfZxwFak1udwVW6nfgYXxWMDzBsk7EDUmp+vwEKppCHq6u6j+7OEC?=
 =?us-ascii?Q?3N+cVZOLsnGc1vfu+3C3lcxIxX3ZWVOlgiQCFwcjpd8gxi7Q1sKzgC6HwLsI?=
 =?us-ascii?Q?MNDUPB6Bfyp/Om7gJdVn7XHBzHwdu1xvfwOsVBiN81hp9nnewRq70GjzvVPx?=
 =?us-ascii?Q?P/RXU0i8f6sG7xPS1VqV0RtqBuKYxnQsnCIXyp5J6bpCyhdYZFcxuF8N+eKX?=
 =?us-ascii?Q?1YeHweWnF+U3rMjiEQXZ7qL6Rm+bFYYDaA74E76oUGUFVG8HVvhOUNKIHC95?=
 =?us-ascii?Q?nWQdqNPpQ/MbVle2AdpKrv16/lVU3H55iThE0mW0VQe94bRGmA1ccAdIZid3?=
 =?us-ascii?Q?tvQx5KJgQWv/Izsv5whQIi4Nne0W8UI9FJvcKLTchZjYpdbScvnA2i2lqcsB?=
 =?us-ascii?Q?ef64p6CwmXeSUJO7K5k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB3878.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S7MtCOcw8zD4uC4JQVjP4tKNrX48iHGEgJnwy2jqsz+35Iwmv+LAXix+zk77?=
 =?us-ascii?Q?BMwnzs12W/svO9gh3+EVh6aRwLXho05nrCwr10OjgcWHwgGXAl7iMTsWDkGC?=
 =?us-ascii?Q?hNOz3qBQTDOzDgJnxOjSI6XZqsHzkZEYCNKw/4S/3EO4cGPYbECE7U+VcsDH?=
 =?us-ascii?Q?VUnOT/ak71SXGLQJ0Wm4lirZFUh3vDkYupaFvtWFoVPi1qD9GdofS2U27j6V?=
 =?us-ascii?Q?9NfGDg71bqFoLh47FPD8B7giruObNCvF/6p8VSZaY8uNevrhyST/gXDSawMP?=
 =?us-ascii?Q?e3chLq+vbOv6fVIL/EA8TXoMFq72/9yRbFJ2lrny02LgX9maLiZ2WCFlW1sO?=
 =?us-ascii?Q?Np16+wH2LItCCfa8QoLDctAnYTZEeCk//QdYDe1IHygdiWAIqZcIhIOkRRah?=
 =?us-ascii?Q?agPy+NvIqXZAxpGbIPo43aZK12ZTsrE3XdjPwYkxzRrgLW3Q1Rb0jBHb10P0?=
 =?us-ascii?Q?t9hz6APMIocRqMJsuqjpffxdSofRfePz14Egi+0jUFk4Y70/kWMGZwgXOt43?=
 =?us-ascii?Q?+VHWkRCeADVWyVrKuUhzf0V5D0E0mCl4ze28xR9iaTM0yy0zfPLDoK3S5+iN?=
 =?us-ascii?Q?57SyxQXRyi5MMoRYUkdOapyf6t8BXhBZsSbM4Lw0fOspGs8Bmjot9aGkKL+q?=
 =?us-ascii?Q?ojA/FgbODG135VRUEUmL7r8b8K6R8VaM6/PJVSJoYnueojJw2LShmpMAAf24?=
 =?us-ascii?Q?jdzoXlKDxA+o+AQCjIeQ+5PlCHLzJw+HEhskyCMR6SlNA0S54IFCmvUXqYjL?=
 =?us-ascii?Q?rJ8R/RQ5rahwNBsLAENxzrBsTxfVrV286LNvp0s/LDgTSVPY/GHJL6j5iiYI?=
 =?us-ascii?Q?YPjdc6Mj5IaiE6lN4MuARypGuZ3PxWd6k3qWmoKomBkMlJKIMipG9MFCSwWN?=
 =?us-ascii?Q?cJdWL47V5KF1Gaw7L88wCxLLbyh2uKWUfS3iYE9xMAo0RyHF4C6ao8hMvyCC?=
 =?us-ascii?Q?va2/yM3E/WM/Pgo/XnYJFJ7/ehMCV7FZnA6v/1OcnLzMPMClwQhEEW2r+hOT?=
 =?us-ascii?Q?BIARLeQi+ZHXiITFd+eGujiKw8ip9ZaGPdnknKV3uwb/Bv4Vyqc3zJx6Ck5E?=
 =?us-ascii?Q?RUqF3epO+/6pIFi6ZiglZ7ZgFXW4SScPeTf1B409Omsd11xpLgHNzXihJDjz?=
 =?us-ascii?Q?yF5ocK+25t1YowfoQYD3NwsDTacNhwTp4mWXceD6llT6ImVdS5fvakuHRyR8?=
 =?us-ascii?Q?R3o6rWD9CQgDkJZ8rG+iBkoZsYv8ti1O8L5Fzb29Z5M7yxGpav3oTJwvzMaw?=
 =?us-ascii?Q?pXZPK+l/OOvLGL4uVGNoAIGYh16ao1ein8/61v8gjkuemJQF98Vgru+tlhjY?=
 =?us-ascii?Q?yUCC3fjeY1xGrl6a7UgajyWM0WuYSksjcp6CHI9svgZ/q1Ijh4z8sJGzEjx4?=
 =?us-ascii?Q?yLgcZjPvUgJiZHcd8JtqHPBgEuyVuHlNmbVd9cg09PB6LKbEJmb5dFE5USDe?=
 =?us-ascii?Q?aOMxhOsL6r0z1u2HEXsJ31hvAk8XBtP6cPRdNNdM7tLzDkbfldVri9J3X8St?=
 =?us-ascii?Q?nABXUIiEsnF4EPfuoQi/DeRnPCJuMxA/FavAQrx31jep7lCX0zcoTx8+ahL+?=
 =?us-ascii?Q?xB+2EvHYdfD7Zp/RliC/0sGXBEzD0aUAyfL4z1oQTMsM2Hd8At8tKvLIsVUG?=
 =?us-ascii?Q?uJmLsFyXK3iumzUMypR3Pb5DoozlK5iq2TxCZj+laba9TdOMKhxD+qoW5R0F?=
 =?us-ascii?Q?jBo+Cc5Dx3RynO5VyTMAfD0M0cmV/h6SQ6PEN8I2WhatMMCDwKtTPkraOE3L?=
 =?us-ascii?Q?XPn1Xyt5oBdDEmnMZpOo4Wpjj34SqvdrjJzAcgZ1IDhk9VfvfxjIYbjA1e3E?=
X-MS-Exchange-AntiSpam-MessageData-1: 787iaiOfpYF3A4Cr8ZNjBs/LjLdVVoG32v4=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6da94e7-5377-49e6-53df-08de69ad9f80
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3878.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 20:39:16.1599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFw2u+zCK1/wlVXJdrRWmB2J97e7HW78HouCsB/Z80WkwqaNvrVOkL5sftmPqdeF7MwhpOJKvT8Fvg28J4huGaNuHjdFb6wGX+z5ySeoE0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8182
X-Authority-Analysis: v=2.4 cv=bvBBxUai c=1 sm=1 tr=0 ts=698ce8f6 cx=c_pps
 a=S/uo/C2bPHUhgLefKkPNaQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=86sMj-UcmV66aN3zjccA:9
X-Proofpoint-GUID: daVOu3nxMaev3Ntt_GFcOEuwABsmhVrb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDE1OSBTYWx0ZWRfX3jDuGYApzc5g
 NVoeruJ3Mdvkg/AP3vn+GA5lfNMVRMNVw9paOMShdgml7cwoOdC+l7aOS12V2Jrc2Nt7DTKd9H2
 WxI32aMkoKI32haGTT6DN0wAd1hsRzi+TrThCyYlBPmcEEB2AVOx9gPCn1ZsS+TrL4PYzZCF9RK
 pwT9TM9GAjEwiujozEOo24w3mUbh/BDZxF/IaRfbu9mE4hI/nzyK2VL7R+ioPEJc7negDqaQqyF
 91uD6HA6qb336lTyXl76DEzlubDjpw9K2zN7bA+/mPBAmI9kynTYxIpvnjCCIwJ9Z9tIm/OZHCO
 rFP+RYGYMtX5frEXISRKKnRSJTu04G4Vgi7BexZeVNE9EQovy6vNwkik3rAGt0QkpftQxnnbbxG
 T7lL5cxbbuB+nSAN0/8QXMkXIJl/qj6kAATEZVt52M6KljVBjOJYj9BPyF0pqtuQdE7hos2PQU+
 z065sC7MVUwvBQ9Hz5g==
X-Proofpoint-ORIG-GUID: daVOu3nxMaev3Ntt_GFcOEuwABsmhVrb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_02,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110159

Hi Jens,

This is v3 of the fix for the RT kernel performance regression caused by
commit 679b1874eba7 ("block: fix ordering between checking
QUEUE_FLAG_QUIESCED request adding").

Changes since v2 (Feb 10):
- Replaced raw_spinlock_t quiesce_sync_lock with atomic_t for
  quiesce_depth, as suggested by Sebastian Andrzej Siewior
- Eliminated QUEUE_FLAG_QUIESCED entirely; blk_queue_quiesced() now
  checks atomic_read(&q->quiesce_depth) > 0
- Use atomic_dec_if_positive() in blk_mq_unquiesce_queue() to avoid
  race between WARN check and decrement
- Removed the unrelated blk_mq_run_hw_queues() async=true change
- Removed blk-mq-debugfs.c QUIESCED flag entry
- Uses smp_mb__after_atomic() / smp_rmb() for memory ordering instead
  of any spinlock in the hot path

Changes since v1 (RESEND, Jan 9):
- Rebased on top of axboe/for-7.0/block
- No code changes

The problem: on PREEMPT_RT kernels, the spinlock_t queue_lock added in
blk_mq_run_hw_queue() converts to a sleeping rt_mutex, causing all IRQ
threads (one per MSI-X vector) to serialize. On megaraid_sas with 128
MSI-X vectors and 120 hw queues, throughput drops from 640 MB/s to
153 MB/s.

The fix converts quiesce_depth to atomic_t, which serves as both the
depth tracker and the quiesce indicator (depth > 0 means quiesced).
This eliminates QUEUE_FLAG_QUIESCED and removes the need for any lock
in the hot path. Memory ordering is ensured by smp_mb__after_atomic()
after modifying quiesce_depth and smp_rmb() before re-checking quiesce
state in blk_mq_run_hw_queue().

Ionut Nechita (1):
  block/blk-mq: use atomic_t for quiesce_depth to avoid lock contention
    on RT

 block/blk-core.c       |  1 +
 block/blk-mq-debugfs.c |  1 -
 block/blk-mq.c         | 45 ++++++++++++++++--------------------------
 include/linux/blkdev.h |  9 ++++++---
 4 files changed, 24 insertions(+), 32 deletions(-)

--
2.53.0

