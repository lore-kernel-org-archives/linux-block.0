Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED9A277C88;
	Tue, 10 Feb 2026 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770756672; cv=fail; b=hedAA8Cs5+DF6H1iYnc16xculjqsaZBGad4BzHFVrWEdD9cSjAP2qPQped5yNave62ShGVS2aL6LeC7LK4rGKq768KuBSUAqTS+iMRmgQLrItjMx54YbCebijxDSkxwVl5X/PNw7R42ncn21l0c6u97topNmJvcIhYsEHPsKfbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770756672; c=relaxed/simple;
	bh=9yRJa0aD40TOF/IidGU3HiUVX6nLg+82vxBhd1/c+F8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=R9DA5ZS6JcZe59/59nRThs2B7a0diVQhr+UH9ecLVyJKk6ovgsR3oE4/g14CxZuMUGmBVsmzc/ePrPIoC+Kl/56tXAUhiKBSP8BpxsomfCD+2sQPTO/L4QbOu4Sk+a4zELTACzYlksqYNyFW4NwOnJqRRlzasLk4oo3yYqVDvYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=IA9NrL64; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="IA9NrL64"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61ACv0TL2236728;
	Tue, 10 Feb 2026 20:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=yoFFc72MW
	sR22cNrB7RcTYXUkqyoAnOF8w4rqxoGJqE=; b=IA9NrL644UBsz6z9D0LUQeUnQ
	5HOXqGRz3+ZScPJ7HMaMiHMYLk/rCoVJ8gX/J7xpalj7jq2Jxw8tVs+ZuwruO7LS
	HoXGlvoW7m3YoY0GuWrU/gKBSvrEIJJFIe/tmP8bnSxia26gqJvm6A6WJKptVAFy
	v6Dw1Z5D9TQCGD37zBja1POMHy3LD+B8LPhvCYYacMEsbgVJJ7b/IxZdFjvNRFFm
	mOyEedVRdciB+tl7DxkIsOafBJ2CxEKHLkVwpCpnixxGX/3ieVmJtS2FOA88Fpt9
	uI4Cwx2GDFYd/emZmJcLNw7eerM1xvx1FCD7Dm2A/1FvcVuJHorIjChdcYKGw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012008.outbound.protection.outlook.com [40.93.195.8])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4c5tkwkx11-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 20:50:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAoWVmDK8ZxE7jf2fgoWy3qE0lDnA7GXnQS2FAsS1Qv4dHNXTLNDxng0yKBDbAEaS36JJDrpFpoqGCqC8szBwG3W/ppU8sTRqVkSwp41k6ll+nDxyYzTHMMuFpBKdFShYwv+sAYHjj6y6gZY1YL5tzqrqS4sgD/EygGKKaNIxBMU6vHlc98eNTn/a+Fye9qitOBAIEi1tkPxkVK0vjtRB7Ixnn5ohXI1/kpyQAYRJWJLAk6w2fhDRkp6bWnOSoGFimgEZC7250Ke2LaJUZuzP5666T7cklTIvrseZJQ8HlVZVrmXmT/HJup2T4sNLl1lmohgmSYw0TmhkbAB9/ESBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoFFc72MWsR22cNrB7RcTYXUkqyoAnOF8w4rqxoGJqE=;
 b=bPDglLRHUkcYuJDMRCoL5GWegRK3biMnj1Uusb/hFqOMe+8VqwA9STHbHohZFEMT+wwRqOS7GhYhAdOEn83JAz/vmTLNr8n75mn/EVek9tm4lYk8VYbY7sxMRY2VUrNmWM2xNIqMbuRr47vNp+BZImoHjmErBsOG5cea7+cHvAZYi4fWiJ+GiXB1rpT5hhHHpxyM4xKmNrmFg+9QYNZFGF7WoXYnOy7gcHEAibncMqW1p2Oz6ssYs7F2u3ix+NZtJXy25erXf3pjsMAw00fWZLp9j66wG1pVCHmDPEewa20rUgZRWe5Ynk4rmFNktI+Fzf3dWMzBXqvaBlfpYKxEog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by MW6PR11MB8309.namprd11.prod.outlook.com (2603:10b6:303:24c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.20; Tue, 10 Feb
 2026 20:50:47 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845%4]) with mapi id 15.20.9587.016; Tue, 10 Feb 2026
 20:50:47 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, ming.lei@redhat.com,
        muchun.song@linux.dev, mkhalfella@purestorage.com,
        sunlightlinux@gmail.com, chris.friesen@windriver.com,
        stable@vger.kernel.org, ionut_n2001@yahoo.com, bigeasy@linutronix.de,
        ionut.nechita@windriver.com
Subject: [PATCH v2 0/1] block/blk-mq: fix RT kernel regression with dedicated quiesce_sync_lock
Date: Tue, 10 Feb 2026 22:49:44 +0200
Message-ID: <20260210204943.21709-3-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0104.eurprd04.prod.outlook.com
 (2603:10a6:803:64::39) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3885:EE_|MW6PR11MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f54846-ac42-43ad-ff5c-08de68e61117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|52116014|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jmEDDg+reu6388UbqzwxiWtcZ9zs7tV1xgPE3Mt+EE9Y+ewkXkLGt95LzVsn?=
 =?us-ascii?Q?jQ0Ar14QJ52CjhJO0x+I0q+/pmhFfWzKD8twioIlDT31XKeTveZbh2dXrrt9?=
 =?us-ascii?Q?cPGPDGBzT4hhnUo9c8Fz0ai2L3W3C8mFkZHpg9fRAWkgGtMpUgFX4cZ16Oh1?=
 =?us-ascii?Q?Mxhp6pRM+ebRGuRpvj6u/KYs9mAjO5w7i/jklQ1YmjjMsKGo09O82yaQAWlQ?=
 =?us-ascii?Q?tDw7cSCPo5l39cV7vb+9ULf/q7zncKYnbzz/U418QqHGkhUITcuUaUIRuxv8?=
 =?us-ascii?Q?NTMvcF8OzLQMZgMAEvbRnDdvWXnn6QW9+KFskqecgmAW+GHwl8JqD+V5Zean?=
 =?us-ascii?Q?p0wgUqG6kzYpTnDLtpnH5aM0oYnxQYY2qBzkTbt9iNlCy7B3iOd5w2YjY1XE?=
 =?us-ascii?Q?LkM3C5dBxXurURTjGjRkqqhNszPdROefsz8YTDDQ3ONzk+oR6tkQ38yU5s6t?=
 =?us-ascii?Q?ts/ynN/r66Ceahn+771cUU5YbN2R0RbQycKDQIx8O2d5vZ1wWdns2d1Pr4CO?=
 =?us-ascii?Q?+0106GJq0rVyKXv7ggUOLYBNDP4v7/kai4ON0UGdkyMBs2Bl55IRCuBSIdYE?=
 =?us-ascii?Q?R3Qq8XUxtn6d1G1+PAsZmx2lcD/IXItlLxzcD0m0UecV7l8wUWI6DlrN3OcS?=
 =?us-ascii?Q?E0xI2puvxZ/detIjSrr+NXXoG40L6McYjWF94YOE5WsWVRIuCalv10yJNspe?=
 =?us-ascii?Q?VF/ItfbQL8rwlZkMmRaPI2YNt+SDV/lJJc/UjLqNs1ABcALM/RQjKOQ4eP3z?=
 =?us-ascii?Q?ybhk5QLfb6sIMz9ATgj0rnUUTsPw0MxvZAnHlQkGlxWOvDuF8UwCQrQVDJ77?=
 =?us-ascii?Q?gPJ5pN6+54aEbkz7Lbx5/sM+aZ4gLBBQ8RKJYj01MshOnX3fbC7wA4MJ5E48?=
 =?us-ascii?Q?ZUf6KLGi/OtsjVw+tFQ7N8Tl+5c2sNW1f2b91UlHZeHljFeJiokGXH+Kf21P?=
 =?us-ascii?Q?4outdgCvNBf2N6gsQHJ7BYrvQVfbFi/p82ydSGxNl7wBJEfiPxbOP4SOYdmp?=
 =?us-ascii?Q?7TkAq0v22KSgKsRcszywwFow4yRB0SbrRtHutHJ9EurEWA2WUV017shP78TJ?=
 =?us-ascii?Q?RQzTPLJ5rs3RSDBWPb9ncPfXkYqdfCnC5EYDYjXpBxqFq49t+9LMuISwCZrQ?=
 =?us-ascii?Q?kwams4j5Dnxg1lA5L7hf1YLdQqVrrAlXADWeyY47Kwc2het5SSzNpFwMSS9o?=
 =?us-ascii?Q?urbYnfq0877x13975cRqcjHu2GI0YituFMIYuOnFvrmAO45iZJa5PsFqWCYo?=
 =?us-ascii?Q?O0C+mVhJhg/NpFeSFdG8/WaYSGKC37K+3BwPQU9SQ+g0r6UbxXg8h8ZV6yx7?=
 =?us-ascii?Q?hjxR7hwoQ92JY/6hjQcaY/st9wFA82oCGL+2IOB/RJEXY7nDUtX6pedP7a7l?=
 =?us-ascii?Q?HtI2vp2/khjq8Y1CpiD0EFmv81sPGlHlwP3NUaNdpAN/8eUZbh0UpUX+Euz+?=
 =?us-ascii?Q?mw+giqARXRqkIMIpdn/C2ekwQBa2JxqU0ockMKGfKuOFUA+goe/Z6gFn+MJS?=
 =?us-ascii?Q?36yhHig1cAFHUnXJ0B5q8UMayJCwg22cwxis6MqIB/cUuEkLBZpQg2libPn2?=
 =?us-ascii?Q?/ny8Pq/eaVqH7FxFnbU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(52116014)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7sKWjzZzmdEDon+pb444cNEe7/pZsvpGfHWlAdl+P9xOcutJ6AVLPguoVs/q?=
 =?us-ascii?Q?IQ1eWUwbK+CP5/wX15oY8ZNcElLru7ic2ZAAeZASE/UygLvyFRf2sengUm4E?=
 =?us-ascii?Q?ZI+Tt6EcGjQKQ1tX8qkx1yKYAXzbImQzOAgjQgNGQZNGqdTsaTuek6QuukQ4?=
 =?us-ascii?Q?CkqoRadN4MBwKoxMxk+6cOZGpSn0v+zkbI4FqjP5WfU+Wnoqfk1loO0Ku0Xv?=
 =?us-ascii?Q?g34mS6KbjaRhzV1FnbzbyQIhmDLsfR4eOeLGXVYktirTddFR2YcMp3v7apgf?=
 =?us-ascii?Q?BvZsLlscSN9SfV7+Pav5dlXrzjSELTFaQOEuow8jZKxmOraNygTWPPP9H8Cn?=
 =?us-ascii?Q?LrfGtpn4kjcUONzZmTDNuzRbSvfOB7TeNTWqn1v6C8qZWBUVfkYsdrgzUu1Y?=
 =?us-ascii?Q?qfbTfR28qhHARjJqY1mILt/JxIfxiTZxALzPnSPRqmJTHvG85FZm/4r1NSvn?=
 =?us-ascii?Q?JnHMUzl8ym0sUqbFK9Y0NwlI750E4jA7mv2gcViIKPz1pl0BO60EYQomjYux?=
 =?us-ascii?Q?ShBHIgGBwmVgS/WTwl0x7Css3wbAWgnrkN5YyXEMJnygKrhN/6OHO7KHZ34w?=
 =?us-ascii?Q?xDYssMLGXMHxEWk3StZC+AdFxNI1knA7yQLpGgMOkDsecFAoQ5oULzDTPa42?=
 =?us-ascii?Q?vkGU63b5xaC81Kg81znDr3F1Do0MzGsqkiN4ouZRL8HWsnMVtB3rX6Vz6JLg?=
 =?us-ascii?Q?2p0Gvmb2SyO9sF7hXjeDVt1DikV7hzpQFkLWGRMboJo0ByqrUHAHVzqCrSpy?=
 =?us-ascii?Q?nTQk8J46/5aL2uabFGLaFqGgSmMc05JaEu5Zm99zzO5tygJClhWqY7Q7nSg7?=
 =?us-ascii?Q?+mJQ1ZQcPNyJVRPJJZ1HpR+PVxAQ3H1Aiu0cgxyU60kniW0YQ8ahJ1wap8oc?=
 =?us-ascii?Q?8ChJE6nknQucTOA6JAxGKj0nw3fyqTUdoWHoiGGtvrQmihz9oLjJWL3A5Jw2?=
 =?us-ascii?Q?JOTlAEIR7JU4rkaIYBHmGinkqUoWbEar6HLdGKeRwLMVXaqRYXHID7jYl8YI?=
 =?us-ascii?Q?PucE+IGHVq04ykpoUbp46IELKdG5HK4vsjiYSBlJWVC6sDJLdyxCD36vCTIG?=
 =?us-ascii?Q?4ZVy1odo5ygSId0AKMgRtfh/N6U321oTx1fuwE82Bt696VMavSIc52nYoKRJ?=
 =?us-ascii?Q?ypuqB/wV7KngCTCt6iJCdOkQ/jSS2bVk+C5cdyZ8jnXs8ezJEOmt3xo8ZEeQ?=
 =?us-ascii?Q?b7K40o4peoEWWizLkPRwJHw2PcRrkOfVJYAvDiHsUHdXU6n/oFcAWyJyB8RT?=
 =?us-ascii?Q?2NTXIKHTFcCZ9/+EgjvJ77kf6KbTDdlJk+zcRKhXF4OHPCcKPfOzL0N8gUjX?=
 =?us-ascii?Q?+deH4zQ1WV9zxzzNHnjJG2S+aR1tlkpjiq76t3oYBvI4XC/XGcQGMHH1cEuG?=
 =?us-ascii?Q?l2TICSugWzv5LAlP8AUFjWTQkWojJNfalwWXFaslW+79UhlEO3S+JluScs1C?=
 =?us-ascii?Q?zIm9TuGOmsxJBFD3hcZwkJJjuGTyEh9SHCmidFIdH/FNBQzU2mzaoasoia5k?=
 =?us-ascii?Q?BPTx7XPRTOsBVsVh9ZyPB98vHDeUXgiC55+YiQjNmv9C6kn9hm4uvhsnJ6sC?=
 =?us-ascii?Q?MM1aWvMgfpMBv5KHgTXyLohje95L99BYJh4fS2Q85yRZGYn+ehoK6BFzgTgj?=
 =?us-ascii?Q?F97P49yHVJiw+QrFSzmGHDWk8JeMrbYzh+X/nkKIKKuXmdZ3tzH5mwJE1zBP?=
 =?us-ascii?Q?L+G5VE+gpUnajYh+MTyzYd2EFo45sWdY/Kr+nj8po1QMMVJ67MHFm4cVJFS3?=
 =?us-ascii?Q?B0wVZY9ML5ml63LEZseZmaXv2sHee3HBqWsOfDA14YiSAHs/bKWG5vo/mruB?=
X-MS-Exchange-AntiSpam-MessageData-1: bURvwi5REr8SjFv3z5drFUZkbC6e0q0FoG8=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f54846-ac42-43ad-ff5c-08de68e61117
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 20:50:47.5106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njzlAIT+oYRI+4Gu+v4I+IO3toN+jUI/nheMFw9fXlokAf68H/QHevhNqT7mVMV1nVOQFfUle5JYct4E64EJTjqux9Ag1zeigQ78y6f53NE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8309
X-Authority-Analysis: v=2.4 cv=bvBBxUai c=1 sm=1 tr=0 ts=698b9a2a cx=c_pps
 a=5ppPJOB7bB2hO4guNQQ//Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=-juEKH9_NjLGvZPlg1sA:9
X-Proofpoint-GUID: SsMwAAuJ4GQyi2JlZFa1rEkRVPabp6Oa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE3MiBTYWx0ZWRfX3AS8u7pLkOwB
 /vjjQ5YMBGm9iXvgatS8pYx7BZOag6eyKro+T84SnC+uy9czwTD0y1VyoJM8lNtHhSxobBLfAGg
 Wh5aZH3hXjvjRUxoNLMRR9Fi6w7yG017KjcNgi5r1i9dg9VsYtzuE8ePSDZMaaGnk43gNEpPQI3
 BSQQc0f7VsJBo41ZIEo778dugCjWgZ5w5LAQDZ6LMAqgF7MBmw78poxV/BcCLFOyuHMy9F/05zY
 tI+7woMz3fDFwPJJXiNrHllOF38KVNIFEYPYgDmt8aJvSW7z82ti06tojk7a7QpsDW46rz9nDJv
 Cb4r5S7LynRlQ32xwNZ0pKwgQbW16aXKl3V+ANvSON0YrdRzywUgYhtwnynKqNJ/GQ1WTeKNeNV
 qcYyIOROyPBSOM4qjY4voIv8IuOnvUDa1V6F9IGWLmk3Dw7q5TQ1fE16mVkupFg2gd4nwTs/IlB
 h9Uo39FzXQIoV39RHzA==
X-Proofpoint-ORIG-GUID: SsMwAAuJ4GQyi2JlZFa1rEkRVPabp6Oa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100172

Hi Jens,

This is v2 of the fix for the RT kernel performance regression caused by
commit 679b1874eba7 ("block: fix ordering between checking
QUEUE_FLAG_QUIESCED request adding").

Changes since v1 (RESEND, Jan 9):
- Rebased on top of axboe/for-7.0/block
- No code changes

The problem: on PREEMPT_RT kernels, the spinlock_t queue_lock added in
blk_mq_run_hw_queue() converts to a sleeping rt_mutex, causing all IRQ
threads (one per MSI-X vector) to serialize. On megaraid_sas with 8
MSI-X vectors, throughput drops from 640 MB/s to 153 MB/s.

The fix introduces a dedicated raw_spinlock_t quiesce_sync_lock that
does not convert to rt_mutex on RT kernels. The critical section is
provably short (only flag and counter checks), making raw_spinlock safe.

In past used memory barriers but was rejected due to barrier pairing
complexity across multiple call sites (as noted by Muchun Song).

Ionut Nechita (1):
  block/blk-mq: fix RT kernel regression with dedicated
    quiesce_sync_lock

 block/blk-core.c       |  1 +
 block/blk-mq.c         | 27 ++++++++++++++++-----------
 include/linux/blkdev.h |  6 ++++++
 3 files changed, 23 insertions(+), 11 deletions(-)

-- 
2.52.0

