Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24ED8831
	for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 20:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732653583; cv=fail; b=PlsopgtN2fNW8hRHdWP37M/vbqtfLF6mnoM8IKQ15g7MrAHA/CGCIbUPumu99xxlApX52uBBuBzROPnT9T6jKG2VWXieiWH5Mt+S4kZJB+m9BAPGsnelnA8Wld0AgdiKQ4MCT7Mp6IYNnSWwJ7wsfMd/28a0bbvLSS9+jkrfRWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732653583; c=relaxed/simple;
	bh=RLCnhaXNJjacmqyj6sJgmUy9o/OtD4y1V6IobTtbty8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nR9LF8vAc665X1WcIfSLX0fdqkEls7ZQoRZZ6gDUMLA5PIPbnH88CNLC8sxwy4b1ZFppQEOdFaL2QJf73yvEsyD2wX626iU+7qUfidMEFI2xgKme30H7/NbuSzv4sCW7APQNY/DJZ73JEL+ry4Tg8HkTSranMLeanuUoe38so3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VZY74kjo; arc=fail smtp.client-ip=40.107.243.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VZY74kjo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j9QLGaFCAkuUavEwDMc8Y2r4VnQtumPvvuJVw8u/c/Y8Mz9D+Q8WBPQSImGPbQkfbtbneIxri0v792+du0jl31WIYMQXIEW5tmsVrLd/2RLio3SM/eNEff0jslaKvj/t2LvAYHyDp8U0UEakuSISGZi594N9AzUMFHoqRqqHaM1DtrHAI4IY5J1VzmbmH3jB7C/LeZZc1DoAGsCjw3bUo1Tf68LwQddwaILBX395ZHxXFQPRAG8WLArByTBtcc3wAa70mrUIW3uRM5petnAChCzxn9qSgA7vgJ5CQYFmSwsGkkvhpvHLLM98oHll+WxP1bNLesE6IEA99TiKX/hGSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEkjaBFN6bFN0SYaBG9boKuGJbuRL2X5cdHeCjirrSc=;
 b=ibw6WqSnzZnU5SQ2UQSzzHIBu+lbc73lTL4o9XyPUBwbF6YZYbTQCrLtcXib2cvIMMkwzXJJQeUWv9uHdC9JmYQn5G6zALnZ/WylIOlKVH21jmxcRWoWyR0pMc01fAEH3vmftI6zts31sVJuQzW9spcf70jqeRNhQBKu3Og1Cp2qsU1oXVh6zmc9nV0Q1KFH7qrQ8DfECtbAYU3XBqOLWDbS1YZH8cVE6gYbJHX97u8rgvqwkwlM8pVcdw3bmrjaDutXn4LDxl4SNYIThIrPfqNIrRQ0FR8mcdLW9DPliYeHc6MDPFzM8z661gnvbrAEbYERxcjzQ2R+baNLMz45eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEkjaBFN6bFN0SYaBG9boKuGJbuRL2X5cdHeCjirrSc=;
 b=VZY74kjokH+3cGoTTE1PvWDIjpU+XQv4uT6NtSClKiCcA1qBAS54DqKRkD+0cRIz0qoImGmOa/Pm5yS71qC62q499BN8vNXVQK7I0NdmjRfN86h2ND7Z6EGBrp9bnmAKS47xVh5DZaBrUwZS2M4xcemOqJPzrJQlUIIOw8TB5JObOxyTr1CY7MWfedFaEUNujnnUHeLFfi/hC6rKIdDVWLdiSSk0qxc4wk23gfEo88nIoq5WbfZOhPDOomyzOC93zuskyUwDj5MvKlgHipoZQF/lU84jPdwb5PtBoSQGx7XAiqa8o0xMw8zTXoRxhFN9/LgjH2Qrjask256E6T4AMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by SA3PR12MB7859.namprd12.prod.outlook.com (2603:10b6:806:305::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Tue, 26 Nov
 2024 20:39:38 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%7]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 20:39:38 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: aaptel@nvidia.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Shai Malin <smalin@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 3/5] nvme/030: only run against kernel soft target
Date: Tue, 26 Nov 2024 22:38:54 +0200
Message-Id: <20241126203857.27210-4-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126203857.27210-1-aaptel@nvidia.com>
References: <20241126203857.27210-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::16) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|SA3PR12MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d2130c-646e-45f3-22aa-08dd0e5a727b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HyF7JAszEy9U1CAO9AcE0evPg4fpCyAvPM6uVkGRbn5BQs52emq3NioNvVOT?=
 =?us-ascii?Q?Bcia3jSrMO9DWKH+7sRi4kdDbga3lnkCQe8zRntcuMpONL20jiAe7t+yaEPF?=
 =?us-ascii?Q?lmKe6D/Rqe0D8JPBeWOBPJL6xpUWt2a6j6f0BL0xP8ypKCEUEQHjRhtwaN7X?=
 =?us-ascii?Q?fs+VxfXiNvKEu8pq+lrGAgc8fAKEYR9ckPeZvmYtkYu6njud+TFeiZTeHBcv?=
 =?us-ascii?Q?tfAYBZPp2Q++RW4mWMOEW3dWWH3LOEHu15PzIIgPu+aEa+M2eLlvulVmpYL1?=
 =?us-ascii?Q?bsotgfmSJ4cdusasxi6LKI846+rxyBWmeCz4otwKQqU5pkKA8a4/gtptgTMB?=
 =?us-ascii?Q?XiMzamX6n70te7st5ZgLhjesNLj4BibXqHF8FXLw9iNPFxCxSsyiqSRbVKXL?=
 =?us-ascii?Q?+D7xvcra8fwUyikfvVIYEdJ34e8dzXA7c4q1sUz4pGFhJmy7tvOGyfhLgQl1?=
 =?us-ascii?Q?hmRnxsn5lhomBBTXdaEknsfmM9jZHP7mrGhWrun4Eq3S9y63nM5pF3Yf5Z7c?=
 =?us-ascii?Q?EcFWvAB9mgxMcgK+KSIdDv8Tu82WfOLgKjusOJoqF87KueMuhC+FVY+n31se?=
 =?us-ascii?Q?g+oHOldYVR12Xh+w1NIFpUpKCbXlQeJPTlWaHV4Nw4j5Xavh8zakf/UyR3RP?=
 =?us-ascii?Q?OK+X/2pk6Kkg5YnROxQ5yB06SGVT5xQCA3hUlkozSpqKteVJAPPOwRwvhA7v?=
 =?us-ascii?Q?laV71acdbUfGan3uLP/k6JK8NDbvrILsM/KchOGq/YBB/fQvWtIqrvZ9Qyr/?=
 =?us-ascii?Q?gJ7OWUbtQcpdZNY6Li0LsDv3z0ivnX+wFDAljTZpBnzup8X2UKTzbiHsj8ax?=
 =?us-ascii?Q?GXyvryWuXN/zyFSPAYlfGDeKuI4zyGBGqtev/6Zs6zMmA3QQKl269dav2fYC?=
 =?us-ascii?Q?ApEE5e/ua7kumphk3m6UFGmkSbsyTeId22FwhL+E5Qo0NZqkxVowayBM3onl?=
 =?us-ascii?Q?9Zu//Zdbg8txcgiBbL7mVVPUegzwTAuh7W7eNCPsFc4fXgq0VnafwWNcRZMz?=
 =?us-ascii?Q?6svIfCLh2NKuepsZJNDvICswRexbqXLp5XmSIa+0E437BV6cpWD+vdXHmGR1?=
 =?us-ascii?Q?UADQXEyt2MRMh4jhCYKaCXAiIyjZ4VcZnHGAcO5yMgF6C5f1BagIwRFGjOwF?=
 =?us-ascii?Q?lr1JOhVZkhn9X1XpJRn9YUuUgsWA9HpVlE+UyoFc0+Ag9z6sUvlbtEKdMmn5?=
 =?us-ascii?Q?kexaz+fDPJftbnRTbTFrsd2qsNajzEt6sGE+hGS8WS9l8BpSpti+SAlkiHZK?=
 =?us-ascii?Q?x85qgS9T7XGDLHTHTeRFNI+tvHGV+FrAY2wnJpMFWELAmOcAW9QOHqlyvJLo?=
 =?us-ascii?Q?32q8i2ougJXs7qnLp/5H1pW9Ch7MQt8a1fX1+fNRHGyzRg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZsAWD7dNdK2Ie2wWaLzXdyI3iw00PB2Wt1Mz/YjiBLuZguu5loakdAB2XyLo?=
 =?us-ascii?Q?2KyAE3S3zFsfSJcfUxjF1D+euUvQeWo30MVUhwl7REZhIT/mhA1Jd4BR4wvs?=
 =?us-ascii?Q?EVfj7Q5QZKd7dUdy07I8uOyu79/lyPIOLVO1kn39Jgll3tj3K648dXzOMsre?=
 =?us-ascii?Q?/yjiHCRn6yIHxOWnywlcEbGnjUXIEHMEUC5em8k804UBcVI0TreIE5aOQlN1?=
 =?us-ascii?Q?hi/UnXCSc5fAh6jhJkMDQXxXrRkgxfJjbjhke3T6Qdswo+3u9YdkRji6AMV3?=
 =?us-ascii?Q?6I4tbZMWB6Je4lghTZuiJGSFI3kfSgY2H/giS1hJmh6LDP9XisZgYrwqjQzP?=
 =?us-ascii?Q?sQp5WHzjHwjz12alj6RaaQB8KMAiWhh/tx7ef5btVXvWqWVcD+tuKyP2FDp3?=
 =?us-ascii?Q?0K7MOdzS28mhZPz0nnurXhFJwmi0562vyWVDYRl4/yyFi9/NZUPSo2gRRrds?=
 =?us-ascii?Q?sX2K8QmnlXAXajRWoT1dfoCtMrt12aGiNXHAxhCjgFz5LirLlwqU3nPXbJ9c?=
 =?us-ascii?Q?kdHKwMib1UObiRjc0JatVKeY9TJWBznEDdgxTAGNqMq5BYsFJzJ/RvcLH2WP?=
 =?us-ascii?Q?zkVgmEVABG8/P/uJsicQwczFrA6cd7VjXcuuFuS3Ky6NNQdTMRcdEhDMeiXH?=
 =?us-ascii?Q?ZIsjMf/+7oWdzsAsWzmrgf9FKShVD1lQLz01tP4/CVr7JJptIThpbpSNac8f?=
 =?us-ascii?Q?3qWzBnckKqDRjXNbw9jp7qTrIWVvm7bnuk4zDG3a6epy+izoRZlxlRay3TvF?=
 =?us-ascii?Q?ojd/2kfOg/T9yYUktEhrYLJ1YwfNmAT2tQqILd5KZoyO4WTACkBLQoUM0aHV?=
 =?us-ascii?Q?OMynfpJwZgff3LasdRFeGvtaThP2PFI7wCw6TWwhpU0YgdbsJxQ5xB9Duv8r?=
 =?us-ascii?Q?iEN78i0SkI/pfd2tHigO+qg3JLvItyN/vzBBB++27ChpyaUFWFCucycTNBPN?=
 =?us-ascii?Q?t6TKsgDEOV1zE5+kYcHYRGIFTxhzDodQ6CcIRJjIfIGy1fU4jBCmEi92OAc3?=
 =?us-ascii?Q?ai6W2UKFdpHyGY+NR5ZJft7MXUpHwDW+FerR5R6lU7LKk5VRMhip1L2NItTy?=
 =?us-ascii?Q?yOFs3tQy/NRXyg8NVaLFAFiugMBb9SzqtLEw+Ge/32jZJbBGpHYJnMKEml3I?=
 =?us-ascii?Q?PckQ1hCyAUNd6n6Trl5HcWCU1/taY1KVrXjXvsIaz0A4K0BJEIrAIXl18W4/?=
 =?us-ascii?Q?Ay58nSn+I/Df9CFosk1gA9/ASWjAnhupObh5TXNEy6rZPM+8gS3GRBC6aQR2?=
 =?us-ascii?Q?PM7l/Ecc/VWcbklGLUsI8kOk1xwnV6T3EhiM4UgE6tXKBNy9KrcQU4+bXD2L?=
 =?us-ascii?Q?XPLHOLgsnJVjtZHWW63Vkf9MnoTD5dAEYV+aQWLi7H7p9uu70KqC8y0t7ABw?=
 =?us-ascii?Q?sqa1zKvWU0YeJznjo5CL9c0mfwnIC0jkH2agrRhru9URO6ZFkUqIv1ZVqMCl?=
 =?us-ascii?Q?1Nu3vKelQT/X8mpRH2HJJSu+C03s36kIHgH7AQGqS3Vo4N5xB7aR5SX12d0v?=
 =?us-ascii?Q?sLIm9rvYArR1j2H5L1UjaEA3h4b+pRXZE3APVRYyFNU40VgjRVC67WE4376y?=
 =?us-ascii?Q?J+CP9apWIuvMlvpF2njHBdoSeiI6RsdTubCaKFhd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d2130c-646e-45f3-22aa-08dd0e5a727b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 20:39:38.8199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhPJ8XzLuQIXnfgiLxgxbhmVO2pSb4XXcXIu+PpGnfurftPFKdgI3wOhVMZ7O5Bfz0V0yc7F93hqwmy9mes5TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7859

From: Daniel Wagner <dwagner@suse.de>

This tests is exercising the target code and not so much the host side.
The problem with nvme/030 is that it depends on interface to interact
with the target which is not covered by the standard. Thus we can't
run it against an arbitrary target. Just skip it when we run against a
arbitrary target.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/030 | 1 +
 tests/nvme/rc  | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/tests/nvme/030 b/tests/nvme/030
index 596e411..fe74849 100755
--- a/tests/nvme/030
+++ b/tests/nvme/030
@@ -13,6 +13,7 @@ requires() {
 	_nvme_requires
 	_have_loop
 	_require_nvme_trtype_is_fabrics
+	_require_kernel_nvme_target
 }
 
 set_conditions() {
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 9ad9a52..d1a4c01 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -191,6 +191,14 @@ _require_kernel_nvme_fabrics_feature() {
 	return 0
 }
 
+_require_kernel_nvme_target() {
+	if [[ -n "${nvme_target_control}" ]]; then
+		SKIP_REASONS+=("Linux kernel soft target not available")
+		return 1;
+	fi
+	return 0
+}
+
 _test_dev_nvme_ctrl() {
 	echo "/dev/char/$(cat "${TEST_DEV_SYSFS}/device/dev")"
 }
-- 
2.34.1

