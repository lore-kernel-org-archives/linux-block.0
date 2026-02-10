Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1033132E126;
	Tue, 10 Feb 2026 20:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770756703; cv=fail; b=mnpFIE36IU8iT5VnGf9Fs/HRDlsLczAg/IjCH1db6pszDDKv6LnG0GdRDqBPIUUsYjAoH8d76u6vTVjjads8hqBWMId0ZeM/usLE14X49GOB0dtVogkdFGcqhX0FtW4Fi1vT13At95nfnZ5WOrl28yTqBoQ7zmQDMPO44ciAjAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770756703; c=relaxed/simple;
	bh=OfcCmo+rYOzpGGlQXYmR3fKtzz/G8Dm/sKTjubvVhl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OM1s3rh9bvXiFuwsvfHUxZxdC4mA4Ff/VK/yL2VVm+8FyHSwr9rqwulZJJ/gJvBRT5tiOuzK6KBekUFFXh1bMZ+1bydM8oBJOaDXoCSwdejhm5AsZEP/nb6fe9nzSUKZUoc1MCRnt3D1cTtO2O3OdvFiKukU/7LM6/90avP9h2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=mArUsCDl; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="mArUsCDl"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A4j14E1601906;
	Tue, 10 Feb 2026 12:51:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=3v20aIvkjUbDY5FPlMLfx3WBO7VBRfSrjYgyLctjdEg=; b=
	mArUsCDl7GlF7bNycFESAf5ItE/EER2GQgnsRDb9OihrOI4qJ5sRq2oF0TUhIJE8
	bPaymkTsiSCGvLBAQYGT4xfeE/tzs93lIsd3aEXoVcOm89JaihGMIc0yn8DqzmCJ
	oqfdNApckMgmN7bglcVQKARXCBQFADKEL5VxSMzakPOLgbnLEndR0iKb09wgAgJM
	S+Cw7ObyKOGRWGj3aWTSBqg1YV2TOd4sPA2XjO3CZhiaKV6u+cV+C9caCzNzDLzq
	afOQdtD8gaSLHESel2JtKfUriyJIdWSWR1v7FZ7E9mhSeBS/jnLk8kJ7p5fYny4L
	zoC6C0vtTlul5H7r42V1Qw==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012002.outbound.protection.outlook.com [52.101.48.2])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4c65sj3h8q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 12:51:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFLQGGVykgthHTHAOzeO4AKq+2lhCI6Hnn2eT1vCpQDsPqVLUfEV5XjjIG9t8a80d9Z9sgvjXWFl84k4WDOwEcD/XBoNm1mEkjHS66EgVf6R/6rkVaM318MQXZ9KYmQXNYLRLNeB0oCtT8HDDBPZ2mKHA151KBB0nP70k/kLO1d4h579UZ+7qoLbMJrIyi0UKtFvfX/xVUgzSMZa6NI6+DqXe2pZSIRej1sZSXyi/6RjnJk0tGoNmcH5GERKh03fhzUpxrT2/vC1gQ3XgaL8jb/jAc0nlM6b0JjtkPzxEacp5tzkBk9gMPepHHk84X/Fu6k5CNMtWX8fOm0dlJUwYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3v20aIvkjUbDY5FPlMLfx3WBO7VBRfSrjYgyLctjdEg=;
 b=iFsl6187yeP5pGWY0jgipzyOR2jHq3TgLk5BkZYmkJoNQkmKfq5w4h9yTvLxLBujfdR1lOtw+DrytqimgKrQ0/Q0QJ4l0VqJ1rWEjFBtPH+y5oCFJ33dF9k5ZJqmcGLwiLiwOi/kpZC5OM0kFzRkTHWVI85EdvGvqsRSdzrzNgDLsrJ/UlPKnlgH3SQqpdDiyeH82f890jjVLuVEwZn85H/KuLaxH8Kmg+/L0YzDy78C5ZG1Po3Xgh9DPMa8IjHoKBkUT+MbgEUKJv9VV1jViNCUHQeXFrPdYYxU9UuCDz3tnST/hH3OlsUjHzZz+3I0jW2fV9mVknXueSMB1ChBzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by MW6PR11MB8309.namprd11.prod.outlook.com (2603:10b6:303:24c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.20; Tue, 10 Feb
 2026 20:51:19 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845%4]) with mapi id 15.20.9587.016; Tue, 10 Feb 2026
 20:51:19 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, ming.lei@redhat.com,
        muchun.song@linux.dev, mkhalfella@purestorage.com,
        sunlightlinux@gmail.com, chris.friesen@windriver.com,
        stable@vger.kernel.org, ionut_n2001@yahoo.com, bigeasy@linutronix.de,
        ionut.nechita@windriver.com
Subject: [PATCH v2 1/1] block/blk-mq: fix RT kernel regression with dedicated quiesce_sync_lock
Date: Tue, 10 Feb 2026 22:49:46 +0200
Message-ID: <20260210204943.21709-5-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260210204943.21709-3-ionut.nechita@windriver.com>
References: <20260210204943.21709-3-ionut.nechita@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 33ff3475-6813-49c1-18b6-08de68e6243c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|52116014|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dMGtKGttln72a4iPJHgX2WasTRpHOtR6idBwTMcvIPkjWkM3BNIlocw5krOT?=
 =?us-ascii?Q?l3q37kM/9Gh//ebk8jSkWCsoKxty8e0g9bnvBV9EdPGzhKIpYv9Kz42Y61/0?=
 =?us-ascii?Q?ooX3sxU5hM2aGTdhRwNJIsJHlQUtzWLZnIGbCO1fWI42K1HfYkDJWz/6X2Pz?=
 =?us-ascii?Q?0rJiPG3HFa0WNxyx5zlacUQbfe4OJUxG6DlvOa7hwc7d0pmyf7olIGyl4kAG?=
 =?us-ascii?Q?FuwKS91dVbRIHvoAoka4g/1SZ2yRD7qB5/tJU+kkspE3GXtaG/uQBFCiD17Z?=
 =?us-ascii?Q?rj54pqfil7NdCQs7fybhI5LIBDL8O4ncEQ1dG3HA7Y1PWqzs87dvKvxvM7ul?=
 =?us-ascii?Q?ZcuIhN1qvjBiMbPva8tF2q2D5Ic1hwvmw4h82v2CMSkIXqqccdjTaSNNE93K?=
 =?us-ascii?Q?vRwVDlS8Y8Gvyld+JO2u1I478pXEfx1xe+fOPNJQ+orOQ43S9tJAysfDiefw?=
 =?us-ascii?Q?pPDxT4nciMTebDQxVn9dn5IPrR6zTciPQR80WTTWMb09WOoU1nXmNUTrIoqp?=
 =?us-ascii?Q?gisV6WRl3kvuPbdL5edrLMngR48LLu0aGEB3jO0Rs9cL2DCjLI8nPvB4Am5X?=
 =?us-ascii?Q?QD2PmVC1VNSHr0Khf05MW0FOJqXvDMgOZaNxopDFf1116m1D02RahSSdbVIT?=
 =?us-ascii?Q?+qiFHQbkd9Vft7JmCUgV2o4VGLWLSrkfcdIorMZB5klg1SauAJAP+iHwlKGC?=
 =?us-ascii?Q?OgfczW7ZpvCQi9i38xvmlVu6acT5zZBOv6v3/k3RecHR0682Rsc5hb5F9IXd?=
 =?us-ascii?Q?b1P3NV3ZzNHxlRumeHcPyLEfXJwTm4oMtwrOa7tQV3NC42NbdzqGFY9XVWp1?=
 =?us-ascii?Q?YNd91HvOBfW4dLA7i8QnSpcqCLTePofrcSmrMuPiBlQzkRtS2UqS1baqCgIL?=
 =?us-ascii?Q?GuqceL25Evc8pkmhwW1hh6Xcp3o5GVPzHIxFaV+glrM/1hCx7+O6cPDtOghj?=
 =?us-ascii?Q?z2LkuhKK1r7H037s+2medXYq/N++U8z/+3+jc/k/6TQO6Qz8oRz++tT/e968?=
 =?us-ascii?Q?TA8C55f8bTjEKY/eYFlzZI+1Ni4R3tcoBFdGUWU1bkzeauKN9ZUQu77gtaV7?=
 =?us-ascii?Q?CkW1oFWLIBICeFPUzyHxwBVy6PC10BSqW6svbOq65Mio5Ae87Q2g2fItjri5?=
 =?us-ascii?Q?FXRhSCYwWyfFp0kFWrcPIgMciOdV9PUQ2i5oIvd8QWAcU30FBiss5bMGEr/B?=
 =?us-ascii?Q?Ksr5I93h2hAtoI6uu49ciXBRsMZ88UWHoAB3Ho3A3XQ+9E25FPQZKgXKvaXx?=
 =?us-ascii?Q?RxgAfI8lvORnI/cOobGthfAwMeGVWydZwySZrR5w88k770rlgtQa1AIN7EES?=
 =?us-ascii?Q?PrXl3eYqDo4GFhpqWL8EuqADuEOi2hzX2hCytlE1eAPBHg6p6TWXpjv41fX+?=
 =?us-ascii?Q?UofUEyw/+WOqp2Tg+G4JaqDKl1yKSift/rYlUSEScTvgOViDkwovoBJFqCTz?=
 =?us-ascii?Q?C114mBYDsrUDfJxh51BzK7TLnfgOQquUl8rzI/ObNOb4qMBbjLupWjN5+T2v?=
 =?us-ascii?Q?jYUDFun1Nf3W50cfXc0HCFnX4ovHVq6Ycw4jqlmieL2J6e8cTjg1XgtI9nNV?=
 =?us-ascii?Q?Wz8PyjU1M/E41AIfEnw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(52116014)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YRt2K0gUzM1fL1ohydgDj/EpV5jsVb7Qo0wvWMSHlTNRDhS+Vj1aTwKz2c5e?=
 =?us-ascii?Q?bRK267i0m4zZ+qwUUjKw7ap1N8l5tkr+67spOvTugMxjp6SzWxnUdn3a/SVz?=
 =?us-ascii?Q?XjnyAAF27egx1w7HI/vKl6Fh6/SHkp8zpPPW0MarRtE8etPmZBN6J8ABwBie?=
 =?us-ascii?Q?a+ERTA5qXJPuRtZwwprl9xg3zLfzW1iN5MFQ3zgpoV41ixyvjh1G05lyAsZm?=
 =?us-ascii?Q?+zGynI1XJM51h3P034U4/g48ghjUatDGmPjpLsG3w1981fg2zZ7NaAd/X2Fn?=
 =?us-ascii?Q?nR2N5Y1d9c37T//w5rE/B6NKfC8Xk/5PzdvzwEQP3BbqlRznkQ7+0XJ8/A3O?=
 =?us-ascii?Q?sW3wFAQmu99vLLzFBnPDGFFoGyoACJ99UnjVWCkSfpGQMdzbAxqcrqdwMyZq?=
 =?us-ascii?Q?71t2txD3edbslPZ4e9aAzZSO5iGat9Qmz2c02MQzOoHtcpjk/3qg/JrY5CVv?=
 =?us-ascii?Q?ZKjie8Ig+2/Yr5OWpTyDeQNSWkWwv0UFEf9mWpIZdxDKF/aTjbD6s+2Dez8o?=
 =?us-ascii?Q?4mDqyfOlyrbfHLE08oD1MYdvAQ0dy3JjZ78tLBWEfj3s9xPcEuVIQSWzSgtz?=
 =?us-ascii?Q?06UZVqDqO34+4gyncJXak2QBl5/ZPAk9uXC+6GhmBTy55Tfv6KiLWdPLtonS?=
 =?us-ascii?Q?mNzzaem8GgaEpWYnhxGBBEiZKekkcEExc6iLIo1CfHRh55/4mtKUSAHla9/T?=
 =?us-ascii?Q?SML/EC06H/116RWVfej+9xj1Ws48VlzKNGkZsp7fDY5oXBTMTQMh3gVKcZ6k?=
 =?us-ascii?Q?3IRCAV9JyLJxgQK87fRqY6cINA3dJKPSEf1NoVJdas+G6bFQlppqWPNt1muW?=
 =?us-ascii?Q?TaVDT+ssafL1wZ3xotButP9DqJbn53Cf9WRCChUCt4XP/vhxX0PyKZiwZB/n?=
 =?us-ascii?Q?sakmzCL9tgfDan0edSW+eE018shy5MdvqbSQbQITk1Gs/DV08EwFiXpQ1rRe?=
 =?us-ascii?Q?3OqGa2ZkxKv8b4PyLaFgI9ccYl2kf9l8sTZLlPUAG0ydef8sLz8yk17sras5?=
 =?us-ascii?Q?/ToH3OuL69H/uGPjeYW0KYeL0qYbSW7OtPoYhaq21ss2bnqT4M2dWx9wfg/1?=
 =?us-ascii?Q?OUOe495BOUZyT4B2LKYOwMj0w0zJumTuIhjuHjhM2djs8ln6mDMeSegxNhFZ?=
 =?us-ascii?Q?Ss20oWB0SxNA+NvtlPtVxhvWK3457mvVWBVVWbb6CEukJ3K3oH/d9vyFMGv6?=
 =?us-ascii?Q?f4JG96tuUdsM0xzbj1DhbOBKsj2oNXUlOTztVuWnN74mM/YrDDOyqZFVlT6I?=
 =?us-ascii?Q?f0BKn0+52PLdwmdFPCdhSRW9bj+U1ZJgkfSV4mPZb4uLksarFFNhBlJ2EVUZ?=
 =?us-ascii?Q?pgsXKWdEHx4t26jAZ13z0vxjBrLV7WkKw89r7uVdq3dAsNAL1WJt8S1Zz6IK?=
 =?us-ascii?Q?Lix0a9lFnJuBPkTPNfPDKmU4axpQfxIrcW0ODwDLvNEQXYFXAHi5CFXd5PCl?=
 =?us-ascii?Q?KqHQu5P62M8VPlFfLGl316MMAdFUk8qOy39m1GQlzCizzEmogFApMdxXW8Nr?=
 =?us-ascii?Q?lYNPQiZ3CXM+ECLMQHw8vP/3qI/IKNlizSPu5RfKrVWhFGW+1pQyWRHh8GH7?=
 =?us-ascii?Q?ceptOxeVkJz+0xmQA9b939M+4zXj0bisZq9aI5YfXvjgw4yGEK/QbuA1oub5?=
 =?us-ascii?Q?ja6etrTW+GGHl0ijQC6Abm7Nv2X6N66Tvdr3alOH3TYA8BCnXty4qRpIm2y3?=
 =?us-ascii?Q?35owMoZDAV1+RPxWzNErDfDS+0a96csNJr2EbJzGmIq2Z/xVwepPldChQN2S?=
 =?us-ascii?Q?vEqKPYu3djnNzLSsu6s93hrukiRO4w6WbHxexSs7P8T4EdTu2aQSHzHkH86x?=
X-MS-Exchange-AntiSpam-MessageData-1: rj3O88WFsPe72IW/jKEn5zwVe6FcSFRXI6I=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ff3475-6813-49c1-18b6-08de68e6243c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 20:51:19.3904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OX//9WDaaFXUIgTcBUGPCiZzdII4xEhKe41g1lEDeAVZbJ6mx80rastT+yBxGBjUZAkHnGkQfQt6VqnrrJWFREusj6qmlaHOChnTlrqLGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8309
X-Proofpoint-ORIG-GUID: mSr9s3nxRvQRTGqEgJJaVZILs01jssY5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE3MiBTYWx0ZWRfXwyK2dGZEMYaB
 E31Jsgj6RJd3rwST3WF11vuouRK/2qt27JPXbv5gFGMFaT5WA+ql9IWp0n16Y1AB5at1WEdiPq9
 yEHEbuQQLNMuwHRBtInlrZZMlRn8iTLwOWeC/+iFLB98rOXpjTBYupsnEhu1kDbU0mIp2LH5reR
 jISz02G/Oju+LvQyvqTVCpgI1lSzKuyoRlGP9PqOjsVQDCotHjeOBc0b+AzkQuIX95Oid+11t4j
 VqoOvBMFALi2RkOzx+khQ7/s5jcBh99Ztaeq2y4SIKrKJwWXFThwUzcg6CRRHXNK9DDdwyBUkzY
 8rnXKHqXyfZfSCxPo2pe4bWgfda/FBQhP1soydP6S3uHTXpkhVn/enydShiHgEoRT33OHWvcXuU
 m48lSrNcVIWMxvOY5Z7xFYs+wqNUMnhhIU3Tmkj/trksCtDRR6N5M87OSo0ezYuMNVj7YHuzHZb
 /rq32r8wuzxhZERPlyg==
X-Proofpoint-GUID: mSr9s3nxRvQRTGqEgJJaVZILs01jssY5
X-Authority-Analysis: v=2.4 cv=Cpyys34D c=1 sm=1 tr=0 ts=698b9a49 cx=c_pps
 a=wMiyO8M9v1WpSot1jLKY+A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=t7CeM3EgAAAA:8
 a=VwQbUJbxAAAA:8 a=Cw8VXQZKCj28N06HuCYA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100172

From: Ionut Nechita <ionut.nechita@windriver.com>

In RT kernel (PREEMPT_RT), commit 679b1874eba7 ("block: fix ordering
between checking QUEUE_FLAG_QUIESCED request adding") causes severe
performance regression on systems with multiple MSI-X interrupt vectors.

The above change added spinlock_t queue_lock to blk_mq_run_hw_queue()
to synchronize QUEUE_FLAG_QUIESCED checks with blk_mq_unquiesce_queue().
While this works correctly in standard kernel, it causes catastrophic
serialization in RT kernel where spinlock_t converts to sleeping
rt_mutex.

Problem in RT kernel:
- blk_mq_run_hw_queue() is called from IRQ thread context (I/O completion)
- With 8 MSI-X vectors, all 8 IRQ threads contend on the same queue_lock
- queue_lock becomes rt_mutex (sleeping) in RT kernel
- IRQ threads serialize and enter D-state waiting for lock
- Throughput drops from 640 MB/s to 153 MB/s

The original commit message noted that memory barriers were considered
but rejected because "memory barrier is not easy to be maintained" -
barriers would need to be added at multiple call sites throughout the
block layer where work is added before calling blk_mq_run_hw_queue().

Solution:
Instead of using the general-purpose queue_lock or attempting complex
memory barrier pairing across many call sites, introduce a dedicated
raw_spinlock_t quiesce_sync_lock specifically for synchronizing the
quiesce state between:
- blk_mq_quiesce_queue_nowait()
- blk_mq_unquiesce_queue()
- blk_mq_run_hw_queue()

Why raw_spinlock is safe:
- Critical section is provably short (only flag and counter checks)
- No sleeping operations under lock
- raw_spinlock does not convert to rt_mutex in RT kernel
- Provides same ordering guarantees as original queue_lock approach

This approach:
- Maintains correctness of original synchronization
- Avoids sleeping in RT kernel's IRQ thread context
- Limits scope to only quiesce-related synchronization
- Simpler than auditing all call sites for memory barrier pairing

Additionally, change blk_freeze_queue_start to use async=true for better
performance in RT kernel by avoiding synchronous queue runs during freeze.

Test results on RT kernel (megaraid_sas with 8 MSI-X vectors):
- Before: 153 MB/s, 6-8 IRQ threads in D-state
- After:  640 MB/s, 0 IRQ threads blocked

Fixes: 679b1874eba7 ("block: fix ordering between checking QUEUE_FLAG_QUIESCED request adding")
Cc: stable@vger.kernel.org
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 block/blk-core.c       |  1 +
 block/blk-mq.c         | 27 ++++++++++++++++-----------
 include/linux/blkdev.h |  6 ++++++
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 474700ffaa1c8..fd615aeb5c463 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -434,6 +434,7 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
 	mutex_init(&q->limits_lock);
 	mutex_init(&q->rq_qos_mutex);
 	spin_lock_init(&q->queue_lock);
+	raw_spin_lock_init(&q->quiesce_sync_lock);
 
 	init_waitqueue_head(&q->mq_freeze_wq);
 	mutex_init(&q->mq_freeze_lock);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0ad3dd3329db7..888718a782f88 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -171,7 +171,7 @@ bool __blk_freeze_queue_start(struct request_queue *q,
 		percpu_ref_kill(&q->q_usage_counter);
 		mutex_unlock(&q->mq_freeze_lock);
 		if (queue_is_mq(q))
-			blk_mq_run_hw_queues(q, false);
+			blk_mq_run_hw_queues(q, true);
 	} else {
 		mutex_unlock(&q->mq_freeze_lock);
 	}
@@ -262,10 +262,10 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&q->queue_lock, flags);
+	raw_spin_lock_irqsave(&q->quiesce_sync_lock, flags);
 	if (!q->quiesce_depth++)
 		blk_queue_flag_set(QUEUE_FLAG_QUIESCED, q);
-	spin_unlock_irqrestore(&q->queue_lock, flags);
+	raw_spin_unlock_irqrestore(&q->quiesce_sync_lock, flags);
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
 
@@ -317,14 +317,14 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
 	unsigned long flags;
 	bool run_queue = false;
 
-	spin_lock_irqsave(&q->queue_lock, flags);
+	raw_spin_lock_irqsave(&q->quiesce_sync_lock, flags);
 	if (WARN_ON_ONCE(q->quiesce_depth <= 0)) {
 		;
 	} else if (!--q->quiesce_depth) {
 		blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
 		run_queue = true;
 	}
-	spin_unlock_irqrestore(&q->queue_lock, flags);
+	raw_spin_unlock_irqrestore(&q->quiesce_sync_lock, flags);
 
 	/* dispatch requests which are inserted during quiescing */
 	if (run_queue)
@@ -2368,14 +2368,19 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 		unsigned long flags;
 
 		/*
-		 * Synchronize with blk_mq_unquiesce_queue(), because we check
-		 * if hw queue is quiesced locklessly above, we need the use
-		 * ->queue_lock to make sure we see the up-to-date status to
-		 * not miss rerunning the hw queue.
+		 * Synchronize with blk_mq_unquiesce_queue(). We check if hw
+		 * queue is quiesced locklessly above, so we need to use
+		 * quiesce_sync_lock to ensure we see the up-to-date status
+		 * and don't miss rerunning the hw queue.
+		 *
+		 * Uses raw_spinlock to avoid sleeping in RT kernel's IRQ
+		 * thread context during I/O completion. Critical section is
+		 * short (only flag and counter checks), making raw_spinlock
+		 * safe.
 		 */
-		spin_lock_irqsave(&hctx->queue->queue_lock, flags);
+		raw_spin_lock_irqsave(&hctx->queue->quiesce_sync_lock, flags);
 		need_run = blk_mq_hw_queue_need_run(hctx);
-		spin_unlock_irqrestore(&hctx->queue->queue_lock, flags);
+		raw_spin_unlock_irqrestore(&hctx->queue->quiesce_sync_lock, flags);
 
 		if (!need_run)
 			return;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 99ef8cd7673c2..ab9e62aa3ae42 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -514,6 +514,12 @@ struct request_queue {
 	struct request		*last_merge;
 
 	spinlock_t		queue_lock;
+	/*
+	 * Synchronizes quiesce state checks between blk_mq_run_hw_queue()
+	 * and blk_mq_unquiesce_queue(). Uses raw_spinlock to avoid sleeping
+	 * in RT kernel's IRQ thread context during I/O completion.
+	 */
+	raw_spinlock_t		quiesce_sync_lock;
 
 	int			quiesce_depth;
 
-- 
2.52.0

