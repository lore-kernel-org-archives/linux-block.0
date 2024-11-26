Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5F88831
	for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 20:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732653579; cv=fail; b=NDJyxB+WE6fK0goIHz3WeQHs4du0ZSxZXPWN4hvOfhhFeYlz1Cb/WdgFibIge5CPiHZ89eB1WINGbGtuSaIOKFnsDK9wGvfLu7n7MAWMtWb+g+x2ooFMZ3PhwusPsBdqETEWwN5wQm1TSLVvuVPFIP4TlegR1vq/8kLtPnaOBZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732653579; c=relaxed/simple;
	bh=gHCcTM/t6ZN2gyS2olcrQN5cOX/MakN3jmv4TIK9KdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H9kmcqoFOryHULzT+/JtpL33PslXH2AwIatciCUWSFJTxkbuNK8G8e4QDXVg0zaxCbJScxanqRuHLR6oKDhCVHv2jXm3B9yWk8qVCF7+kL49oSOQX1e1yLFBPX4vCWEQKS2ketqmNuf1vxPPqAjfHtoIRxWi1IeE6Ezo5IWr5K8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cfCsWTA2; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cfCsWTA2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivk6w13h7Y7XI8Qh058/aX7R71+6UGIJ/DNFvTaq4h+CuuRur7S+Fl3vQ66swnEcpLCWP7beezO3dwgWhWm3FtaxbUix6Ba0yRp6dOGylf+LI5+H+fFsfWt2zohVpOtDQQNuX3lil1uFk/oyHRXtRxbRHUGawiornKKp9i5JH5TvZxoCuPIW7Iy/MgXocvPLFkoE89h1yzD4BjMQTgRDsaA7Iq8hdg/1higxKvbM2xlD7GruVVpjYl6mg5f8CMQomh9QvCaYrxxBT/E5XbXwQjcno/HGZ+l4ZLJe4ZfRxfrSs5jixqjCUbK2O/JDEeoFykOfnQJdqtlHx/xOouNW0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8kKWnfCJ9VW2smK9l8627N9zkaZ49KFZoR8iWBxeZA=;
 b=dR82ZkFzL/J/Z0F6EjcztzaBkSJ9eLKA9+z2TO9Ea2xVKTBbDBe9jqdVFEYyIsWHPONK1mGgGo3M37dhSk0Zebq5ICV7V0vznhuHAgjJE+VMSTkzldyohxaqsnLFZygIppUUmLqakAbzV4OOIIOAvO6jPwx7REMQqTjo4AtAKq4RBhi/KYiTsMgSiba8u7cTHfYvQMKaQ19SBV6fH5Tqd20M3TnZUODypmMxBk9EA+9uwuVhcyDeKUW2H+ybMsIEdZoLD6+hf/4YwwI7es6sfOiWCpVuW8jmhLAvKeWnw87vr9PKaCD3riY6sOpUau9eNUoxD2rVuFxLJkcHMimksA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8kKWnfCJ9VW2smK9l8627N9zkaZ49KFZoR8iWBxeZA=;
 b=cfCsWTA2QVknvisK/4+3zA9iZ5toePdUfiOydYHFtTsE1s+X5uRKMLxEsELXavBa3UkXucaANQoij/4ptr4vN0pzvBgsxIu7uh+2pZ7nadPUxwg0WeqcojDrkoxeZCjDjuET/oOr5bZayI4yBgTwWQvge+g2H97JkTLAZeAdKYuX1NGXKJ6EwVRjlTIUxpgb72wMC/hzIg43eYrL0+YsPY1K78KCVRm/2Q+dcU/4ymHHVpe0163MS8OO/ZEcMk7yMxsBnHkdgM0/d0VNpfkdFwP2eJ8ylAvY1XWt8JzAwLXi+mudpN3hBGpguPFDNszfD/oulKDQGZvpDHSusRGLmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by SA3PR12MB7859.namprd12.prod.outlook.com (2603:10b6:806:305::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Tue, 26 Nov
 2024 20:39:31 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%7]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 20:39:31 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: aaptel@nvidia.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	Shai Malin <smalin@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 2/5] common/nvme: add digest options to __nvme_connect_subsys()
Date: Tue, 26 Nov 2024 22:38:53 +0200
Message-Id: <20241126203857.27210-3-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126203857.27210-1-aaptel@nvidia.com>
References: <20241126203857.27210-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::18) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|SA3PR12MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ff2bff5-ee35-4747-744d-08dd0e5a6e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A6N7UX55zRXuNUkO0NGk4l/A3V0i/KvRdDf4qW6zned0py38ZRQXuZDova91?=
 =?us-ascii?Q?7IwlGppjaY0ocQP2RZktT/GJHR10kSOwxcdyx7DafEhmcUwyhe81SOFhvLR5?=
 =?us-ascii?Q?bEPiYP7IGMr08P23dW04lx1HbZw+Zl1GkwJ6Sq98MHoD13XjUZ4RYEKbYyJ/?=
 =?us-ascii?Q?V1jI3oy8/5sBUcOqPHdy8C6u8VM/QK3QXTuthOGJWJKeR53zjSEzAloI/K1/?=
 =?us-ascii?Q?XMC7M1WOS0O8WuGbZVaV/IDRdE76mSLe/wetGfC0CdDFmIDk3unpA3LfRprz?=
 =?us-ascii?Q?QJflqfz6OEO460W8JY4vBuJ/QfowHqnwkNmJwez4d7UftRdV4kCcnUTLERTT?=
 =?us-ascii?Q?9hXXyLkupFUsa4B26Gn9bX4jzWGfDacEj0wXdElXnzNIGFM3RxmsMQ2L/z3E?=
 =?us-ascii?Q?2RJZosa1A+O7AR9XfZfFlF36HNsjoOr1Lp0m662e1sSNzf2sOke2+WFUSXTE?=
 =?us-ascii?Q?gTKvexreq3IxzRAHWDHzpDGdgf5bzlvdWp069BPmf87sxuBTJkNxlTJEUAcF?=
 =?us-ascii?Q?g+TPMzyB/P1Z2eoUT8HjntJvbba3XYs7C1ms2Qo1JZWM2FpRtZ9Kj4OAEFVc?=
 =?us-ascii?Q?5C0vTDJJqYkRiE1IOC43KlgLiKbHaBv5CzJvGnnxB8xP1RV6uyX5eHPrEpiY?=
 =?us-ascii?Q?mL7bJugsM4XAijshiMRoQFLCIDbTA8fUJPIwrOdN9V/Jc/NLFs0JqTv/QmoW?=
 =?us-ascii?Q?wwrYAnh0QAL0qbyW35CBynxhIo/0F/BigH0OtJwser0SjeXA347/r57FWG5h?=
 =?us-ascii?Q?xsp8eBN3mOqEIuuq5JZ9OZi82yZIvAnQRl7RLvV/ESAr3sYHMcccehIc3xa0?=
 =?us-ascii?Q?IP1Em7B0YU4oevueBG+oCI9gr7giFoEU3smUzGJZnUGLw5d5fhDOv34TlZdN?=
 =?us-ascii?Q?/E/ZNKcDVSMWcml04cP/qlVFw+mv2QKhm5mpMm1N2UpWbhEHlXIwgUO38fdW?=
 =?us-ascii?Q?X87FFXxR892VKDMrFNApgKoClEGwnaGaQPUDweY1DuOd0fESy/6cvFPxdg8M?=
 =?us-ascii?Q?DWeJtGomfum0enoFJwrpNKAjxNesNmFtjDP690/Uno5oxgxHiiXgfNLwglZe?=
 =?us-ascii?Q?kWvoRukq+gPBSzzeQuURs/8iVdNZVeyjpljkv5nTBaZK+STAvSGNmqa55aBe?=
 =?us-ascii?Q?DhHDvVt8MyKLI3SJzwBWZeWC/2Sw7siYWXIf8GH0YXWmGXK1EherrIQrA2LO?=
 =?us-ascii?Q?r2xsvpP/l8jY7nIx0y3MFRnzWObgJcqSytcntA/K2wHA/kWPPncelGPeeypj?=
 =?us-ascii?Q?VaREbsCNNomT+0M965PN7Pg223L2nrO4jyghaVsqmRfVki8CglMEBe12TPr6?=
 =?us-ascii?Q?aNd4HA7sJpvOnF4VdN6lJIBa0+PsJupvpVyqaf/Z0pzprg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7ZNJjIidEbaQZTAc35RCu0j74EbBwhNtJtEhNci+Clelk3kmSDi6MkSYQc5u?=
 =?us-ascii?Q?fWxUJKgbA/XfODJoLyD2RMp6623nZu663m/ECl7QZItxCyMrrh5NK0ebpzyD?=
 =?us-ascii?Q?y02QYUE1qzEZGHuW7JCGjY+KWP4+VfMmlbANKfbFF9GVJ93u2RN8xy8Bz4Yv?=
 =?us-ascii?Q?nZLp902st9wA27wzugsh+gA+71hSCuuqHO6L0J6mxHJ8R9M3//ZE4NPSKzTg?=
 =?us-ascii?Q?k0dUg+QKq/1snOZDJA3nwRdXBlgEURbl3IGCI7yTQ6PYqfTzY+uyMYndHxxn?=
 =?us-ascii?Q?ZXRSeVoywqcPyNjWUj0Ov/FWspgVSuVWERU8OtSgdk/S/6NesKVByj6S8Lbk?=
 =?us-ascii?Q?AMOekgFlncDVSEhj9HL/xK/OAg6xjR6Fijmzs1DGobNnh0d+T+Q8w/V8FWTW?=
 =?us-ascii?Q?D5ulfSsx5lfxOhxyotHpcgdMVOMJChgky13pB8UT0HJhNOAG2ILsV0/xiN8u?=
 =?us-ascii?Q?n/ZrXnLkDDAxDyHLVZ7/bwZM9kfKpbMr02xTbcDlMrOaHOTAl6AAkPxmfH3e?=
 =?us-ascii?Q?SdSNHyaFYR7krhWp8TWQj3cu8f6xgFbm0hpL4C7KsJfFKLJ557Zl6TOiXCqh?=
 =?us-ascii?Q?vgjdD58VXx9Nq6may03D0PF/hyAKS7bAsGgeoDG7QBvcnPyqDQSXE/yJGRsx?=
 =?us-ascii?Q?dXb+cvKQmJFExJLSatNx5jExYh+lXu5AX0clj8BCYfhLsqGc3yorEIz0lzk5?=
 =?us-ascii?Q?W7Fd2UL0Ow3uOKju9ys6oMp5fuGNAXj15ZXPAfsYdkjNOFRjX/REjkSzVTjr?=
 =?us-ascii?Q?eydUg2nzxdgbxu912ncUdUl0pP3sb5XWqx5aVlsqevdn0g5LHEg9UjfBGWE7?=
 =?us-ascii?Q?u5q9E+CQt4YzTWWWtLQWegPQbe6qqLAe0LFqhwcGzMUX5t9vkQMZ9cQzbWnq?=
 =?us-ascii?Q?JVFil940TwfVCJL2e/DuoUNt7QXeE59QZ1e7u8SeL9IztEnxminBq3sWZN4x?=
 =?us-ascii?Q?hmbgDVI1XznmWMJHt1fG5rug7TA1/gz1I/5hrivIYfZ8jTZ6pw7fLhjYkNsN?=
 =?us-ascii?Q?RCuED8mSeYZN9fWEegPV3c/Y36Pw1TOhBQn9zIvZWpTp9asqXV10/m1f6a3g?=
 =?us-ascii?Q?o4nC8clVXN+zSINvtdKg8o+2hzVBiNk/gCMMWa7ozA6mov8tGDTqBnuIB8rz?=
 =?us-ascii?Q?Zb/Rixfgszdon9HnQnE2AVFRBiIsDGOdD8P8Z4e9pBSevDZtLhjgdff1qtMH?=
 =?us-ascii?Q?tePYrwcEIs2BDem/zTiOzbjym+FyOCy7brLMzpdepIpH+AxotNmKLLykjLLW?=
 =?us-ascii?Q?448MyL7W8vS05Vbw3KucFuOccoIo2/dIyHk/FcncW8GUSaTE4k2OFcNvH6aw?=
 =?us-ascii?Q?f/AW5lmR8JNYJItX+cS7s8ffeQ6pQ79WjzEfUKS0mHFkivdfwTwWgVND49dx?=
 =?us-ascii?Q?RZzsvLvLQKPAxwSU6YrBYIGlVVQM11fzrZFCFUOdzii+IaDDfWxhbi2MxsaY?=
 =?us-ascii?Q?4Zl5rhi8KHdY4bb3aybwhSbG6KQC7hV/pgBAEtCMBG98ZCyVzcT+Gh6g3V9Z?=
 =?us-ascii?Q?g4XpwyBI0iVShRVUEbURnWmCxzJQyqmS/aQA8gWmCYT+1ze3s6WTSbCUvUCF?=
 =?us-ascii?Q?OX1OkVRl5TrsDohG8YDZFteexmkbVPiAFoS4tDoJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff2bff5-ee35-4747-744d-08dd0e5a6e4e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 20:39:31.7883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVJ8jIe52NeJD1Ha2wG+jWEzH8Y0EnLrBdjXHZazvMF5uSgc6+PKdvPCADx6zIHZIifHewDjN7bMZ3+NfaN6bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7859

This commit lets tests connect nvme subsystems with data and header
digest.

Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 common/nvme | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/common/nvme b/common/nvme
index f99af5a..e5e5344 100644
--- a/common/nvme
+++ b/common/nvme
@@ -272,6 +272,8 @@ _nvme_connect_subsys() {
 	local reconnect_delay=""
 	local ctrl_loss_tmo=""
 	local no_wait=false
+	local hdr_digest=false
+	local data_digest=false
 	local port
 	local i
 	local -a ARGS
@@ -330,6 +332,14 @@ _nvme_connect_subsys() {
 				no_wait=true
 				shift 1
 				;;
+			--hdr-digest)
+				hdr_digest=true
+				shift 1
+				;;
+			--data-digest)
+				data_digest=true
+				shift 1
+				;;
 			*)
 				echo "WARNING: unknown argument: $1"
 				shift
@@ -381,6 +391,12 @@ _nvme_connect_subsys() {
 	if [[ -n "${ctrl_loss_tmo}" ]]; then
 		ARGS+=(--ctrl-loss-tmo="${ctrl_loss_tmo}")
 	fi
+	if [[ ${hdr_digest} = true ]]; then
+		ARGS+=(--hdr-digest)
+	fi
+	if [[ ${data_digest} = true ]]; then
+		ARGS+=(--data-digest)
+	fi
 	ARGS+=(-o json)
 	connect=$(nvme connect "${ARGS[@]}" 2> /dev/null)
 
-- 
2.34.1

