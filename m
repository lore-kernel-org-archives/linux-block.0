Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D6E376BDC;
	Tue, 17 Mar 2026 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765100; cv=fail; b=cN1cJltI2YxRchy8bYiS6MBMIpkfoLfNtIQVrFTNxWhaCyLbPzuKb+G5NluNj2RVtZ6DM30oGlYQ1y+bXBm6M4THhp01JVSm0YTXsvt23nUudSeeupIeoNJ9RAhfoJBQNZPM49Vr+Js75FUYDbkj0lLsKr7fWyLEJcf6zHRD3s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765100; c=relaxed/simple;
	bh=cvoKtpXRMrVA6Jq3dWQBtXlhA/RlZ/P2BSBOsADuG8Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q5Qn8tn3zvXf2Sh/tMdIbwyNjo+9ZiCiOgftZRuSeE8jHTFEJCey3oi9wMn26CFm1kcERPZcdjxm887EzQSdMsoi1oCTlt6E3B/0KzH8jtMkUN+6OcQD0LfXDEEVkzIf7ioCF6BnU4AvzjhSLRiEPH/M30aLyKFKxTDeqspAR3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=crlqgTl8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ewsJx2ih; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="crlqgTl8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ewsJx2ih"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HE42Bt073784;
	Tue, 17 Mar 2026 16:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xIrrzqoBx8ODe36OsEhjxZvWtpIVoSH4ihJEevYubOQ=; b=
	crlqgTl8bXwvSpaL35otKlwZTrKRQfPYH5qJbG17nDU9t8Q1vo2BRHVvMGqjU5hN
	8EAyycs1VzCa8d5hpzf7Sl0Wq7I3tRDXWud7Z9+6fjQjgGpvJXK7j9bnzkl5qpHL
	JFvJMZ9pGLU4Us2CPqN7VbFHK35HRbr7/MtA7EIAWKzuUcsFeTR9KTidv6FpagwQ
	prhFcChWIJrUOMKttJsY/uhzNcqg0zqckoL+dll/AopGasQM7LpL2M4NuJAE8RaL
	ix8dH9Q+uZTlg51g0/lYPwx+Q+hQR6g/OaTjUsRyK7QQIb4W+DjOiOFK3miA6T6M
	R/gaUn/zEVOdLy3ralipFw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvx8x4hat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 16:31:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62HG606g021277;
	Tue, 17 Mar 2026 16:31:33 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012048.outbound.protection.outlook.com [40.93.195.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4nn5jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 16:31:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPo9JwxcQiohb67+4DORuK7wtWXI/ulwAoXKTuPlDQ2jnI6/86X8BL1z6SC/KknH140hI2GB3XPUAtN/iaaBACTPZ5DfVdFlWC4E7Vb8NyGRgEl7QsXvaErZJv83WLGFovmZaWoZJ7Gfy5pq8g2Uyc61hkzffZlkNccqXYX3ZXZCZWqw3FkETV7t6XRVNaqPSRdBUVhqmJT3FBUGtQzY7ASZrID00VndKQDwJhfK+gRiQqsfVmnTzhPNEwhLn8MDCv96LNrwqbSVAaFLgyJxwnXAQuEoK8Gh3DQ8pDiIAjJx7yU8UTvXC6uyouX78lx/ijIBq+O//bdbrEHvzgygtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIrrzqoBx8ODe36OsEhjxZvWtpIVoSH4ihJEevYubOQ=;
 b=fMpZQj8LzlB+nmvQ2XAZsjpStXN9nQoscHHM/VFmoCK2o4eNOy8N4bBtyWL5bt66jR/8Z0gECM0VCnzvxp+BN9mHk4SMhA7q38y15mCSfOyrnWG8L0em6dlibmCMJC8E+IHNgob3XwgI9RYj29GU4N2Onnv/+rDVNkJbhED/EDA526dmGShvCGTOGAf++0ZB8k850/Gi87GRaRGOsqO+WLnrqTTJFU01d+Yed8zWKkuw3uvxNU4GCLJiIHwFaMFyQponshoXRP8pbsyAvyJnJqWnp3QfUHkMTm2bxZVLM/jhqzo7c4b/zhHHlum/1or8DTOdFUoSLk/UNJvXeLCYeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIrrzqoBx8ODe36OsEhjxZvWtpIVoSH4ihJEevYubOQ=;
 b=ewsJx2ihWCNScy+JufU9Fi3QdEKRF9OsZ3vkFmP+Po4UomBNuXU/QdLCr4orgaGkvezch8d+5KmmRHmgoQx1Tmn0ve0+ciHjdXf2rzOLTkq4i9Zu2f0ao8AQrNL3tm8xKFqf33/qDzE21nRP3zHR5WFr/8qwV5KOHxyMc/JxjQo=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by SJ0PR10MB5598.namprd10.prod.outlook.com
 (2603:10b6:a03:3d9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 16:31:29 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a%5]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 16:31:28 +0000
Message-ID: <9390844f-eaa9-4aa8-9f8b-58eb77b14ee1@oracle.com>
Date: Tue, 17 Mar 2026 16:31:25 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] blk-mq: make blk_mq_hw_ctx_sysfs_entry instances
 const
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260316-b4-sysfs-const-attr-block-v1-0-a35d73b986b0@weissschuh.net>
 <20260316-b4-sysfs-const-attr-block-v1-4-a35d73b986b0@weissschuh.net>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260316-b4-sysfs-const-attr-block-v1-4-a35d73b986b0@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::17) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|SJ0PR10MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: c75b8cad-c163-4455-a686-08de8442a370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	PlpssqoQsXXMIjiFwLOkAD0ZkgKPYl2FruJHT5cHjl4nFcs/ldUSo6iVK5XKrKHRGRXSQQKRz4/fZVmXRJgK7q6Qq77CqLy/diZw4hjkJQyd7zw/sLEB72q3Mhg22cR1hVR7X2iXg7T3dV1hISC47bwcEb4zzE92ALwXdysfKTkVdq7pB0s7hZr1q1xEMxcy80+W4kBn+z7cc+zDxn2glScvxzFnWdEHwgR0Yb2hOy+peck6Cf30U/k86kx2xoyLRR5rr68hyBp3UPdA7ZxRVo4JJJP53xvMSPcK+KMYHpKfWAVy51AF9DOS53BKHvO1EGYN+7afjUtz/94kr+cDkc9n86TY5desvM0k+fFV/K2BHOEN15GfURrj4GYY1s9ed1ehxng33Gk8MoT0Gu2VoZtEAnScB6ubwycUazcX1zU+fLXTJaw2qedb+TXKYyEeOHmxW93ZG2CQvU+u2ESZZdxxyjEkMplZ5G3xOBwObBWR60D+bvHE+3ixdxFnmZ4xlKvyGXuCy/Bonsxs9xdkZbTeEbLBUbvWgSlO/f6pU54V1k7Uvg5Dzh0dhq1GJCGgmdFrZHuK5raV0/dScNAl0/nRt3oen70CkGvvKzw4NuIuuNYBYWuLw1REIk9zPTAcrnxoHS5ILHwAVAxnWc6SFeBZLib/B0FBZpaqGwmhXP4q9Cy8dB3G6VDaeqr6jJJhDiGAfUDRf4RTPSIdU2MCeXNUGUpdmF+Zv5FvXmZSXuU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWdsYXkwdnc3b2pHNGpHM0dLVzYwZ3YvMCt4cFY5Y2g0S3R4VG5GVXFuM1VH?=
 =?utf-8?B?ZGttTktCaVV6TktJb3RXeXZYS3ZiaDZ6VG1pakhSYnFlMEpFUmN0bjVId0Ju?=
 =?utf-8?B?TjNqS3B5TlhPb2RRZWRnYm9MaHdMQkJuTmNseXNhbzRvQjAzQjk3OWx4QXBG?=
 =?utf-8?B?aWZ0bjJHQk9PQWltbCtXYlI4ajRrRFBhNU0rWjlHcGs5WEs2MURlU3BZVEZn?=
 =?utf-8?B?Zzk0SVJDTTdWK0pRVWpES3hCZHY4Uk1WMkRMTG5SOUpCNHRtcWgxYS90ZTdk?=
 =?utf-8?B?bUNzSXVob0tNYVNKY2ZXTTZoRjVBTHZCOW1GRU1jR3h5emdSWXBnVXFhdVNK?=
 =?utf-8?B?ZjR6eFVSZGZtTVFCNmZ0YUZyQUtPQlJGb0x0MXpibTcwbnhCN0pHaGhiMzhQ?=
 =?utf-8?B?VExudzBtK2hEQlRZbG9rNFNhK2hWREtuVEZIUEhDNjR6cFNxY2I0aW9IQkxR?=
 =?utf-8?B?YzBUU0I5VTRIMnRwUjlQdEx0T2ZjcnczWDdJQnVlZjFLbWo4SzQ3WjRjVHlF?=
 =?utf-8?B?VExyMWR3SzZKNG8ydmNrMVArZVRCcmdBak9XV1pTcWE2b3QyMmUzUXJHT2xF?=
 =?utf-8?B?QlArS3hGd0NjZEp0cHZnOHRMWGhadytOTXhBazBDMzR4S0FkNTNPRVFpaXZa?=
 =?utf-8?B?bnQzZFRlVkl3cHcycjg2ZkFoOEtUSjRuc082MjVTbENmcFhVc1hUQ2llQlRm?=
 =?utf-8?B?V2RJSGhtakZsV05SMElzUUJSbHg2NEZiNmtmTjh3THZzeS9SMFJ0NkVCclR3?=
 =?utf-8?B?Ukh4ejEyZHYwM3Nid2k2RXVkSFNmRlJSVjUrby9YbWZmUGs0ckwrQ2tvTFJW?=
 =?utf-8?B?ZXZDclZDWmh5cDdVT0VWMm41ZSs2ZmdKd3NZZERKODhCekpsMDlvNmVBbGVy?=
 =?utf-8?B?MGEwdVhYcjNWYmM1eWpCTHhPRFVHZTZ6OTc2aGVVYXd3N0F5U04zSEtRczM0?=
 =?utf-8?B?TmNtYzZqMm90OCt2NVg3cmlkTUo1V1BySDhMT01xS2QrNCtlUnhUMmVaOHly?=
 =?utf-8?B?QXErKzRhSjN5NkdmMDE5K3pBVHl6NHRUU2ZhZnJsc0k3UFBtTStIYkUvaVJo?=
 =?utf-8?B?cWtSNlMrMDRmMUl6alVPWVFWWnJtUXN5MEgwakk2WExDamJhUlk1dGNSa052?=
 =?utf-8?B?RG9ONmlibjFRQ0R2YW03NG5OcHkwOGs2bjA0aHd0MWNTdzl4empsOWdxcWtX?=
 =?utf-8?B?dGJLMFJ5dUtCbGhkeGFYRzRVS1hDUUE5Yy9VbjM1b3hDcVI4bjVNcUhtWU5z?=
 =?utf-8?B?dmRYNVpodThBMDIzYnVMcldVUUZlbXNHUFlIeXpRMWVIak9OZzhoZlZDdGl3?=
 =?utf-8?B?Tm15ekpxOGdBbzhBcGg2Ty9LUG9XZFpNQkJoOWdWcXVvZVh1bm1qZlN5S09V?=
 =?utf-8?B?ZG93RDkydVJlTmkvYk5yRitPY1NzZU42d1JUM3NDOVJOMFYwcDV2SVVjUENk?=
 =?utf-8?B?aTFKcEN3RGhpdUNybWkzMVhpVEczU3BQekpsb292MzB0S3lIdUthT3diNk1k?=
 =?utf-8?B?SlJGa2xyVUJ3MVZGQkJmS0hPS1haUWNvejFHWWhNenhPNGthd0tZSUZXU0Vj?=
 =?utf-8?B?b3ZIRkM4cjhRazZCZzI0UmdZRnNVZUJ0RXZ2WjM4a29qZ3pwclFnb3Z3WDFv?=
 =?utf-8?B?QXFldEZsbWxMZWJ3R1htTCtKd1QvKzhLTVBKdWQxcXdXcVNHeU9Sdm9iaVNu?=
 =?utf-8?B?b0ZqQXNOQSs3TjJUeVZRL2dPMVdtMmFjN3N6Zk5adGo2bitCa3c3N2s3RlMy?=
 =?utf-8?B?NmlsNVByRnNRSGVmRVlBS0Nmem13UTZmUm93TzliM1NrZXNrWElZR3A0Qm5P?=
 =?utf-8?B?eVZQeWEvV1NvNjNoRHNpT0xZTEh2SGFZZjRDT0hHSmdmZTJZSmc4U28rUytW?=
 =?utf-8?B?V2FNTVAyMFlEeXBTRytmeGh5ckFnV1pHUlArSjJ3VEdNdXFHRnk4bFpabmZr?=
 =?utf-8?B?K2lOanRMR1EyTWR1MGtGR3YzK2p5cVlrN0piWUhmRm1sVk85Sml0RGRwcjZ2?=
 =?utf-8?B?TE03eFJsQ2lYNGRtVzZ1WnFaaFdTcy9IdEhUUG9ZQzVRRGxINjlubXRyTmtn?=
 =?utf-8?B?ZWlTR21UbU9PRVZmQjJNcUl5WWVsdi9EUjdGZmJuS2x0TkNmY0xmUVJlajl0?=
 =?utf-8?B?Z1ZCY1ljYmdENU9aR2srKzZxRVIzTGMvUGxtc3g1bTkrck1MRjQrVXorcVBo?=
 =?utf-8?B?U2NzQ2hYeEpKaGVxWDZ1eW9BMGZNRGVWdk9leEVzMnk0VmVoU1lwMEpUeThP?=
 =?utf-8?B?SHB2RTZIeEJYNWQ3REpaYno0eGhnUUQwcGFqMzBVNVdNUU9NcUJCcUtaZGtN?=
 =?utf-8?B?OWVEN0Fxc2hZazhPazRMMnBhUUwyOWRFTjlHTVMwZTR0aXNwQURiN0U2dURh?=
 =?utf-8?Q?OT57n4cZzhWHnKGQ=3D?=
X-Exchange-RoutingPolicyChecked:
	mQuL58aIKtzagRguVjghLAzHd2y3/rhGnYDg4yUUzRccH/eeDu9QGXk8XsHyR+tnnU41LSFxU54tfuoM0Ey+53AEY6xCp3HAP26hZl28eoBeLtz74wTIy8WBlZWUvPMUd2bEu9NuMkSeVVRj2Crcr6CoH47sjicOZq6DgzJ5EZrMWdmfDhAxs2IcJzfY3TGW/efG34tOK6XiK8wJ9LSA+mJUHe0MbB+FONOVU2i2tLZuy1ElJ6cV61IIZkE/ZZOQq0mFLqkM0OQdgvHM0+UQwg8zGMh/cTGIhi0yBJBhk3Dhmgo4ZqC4XgklDR2jGjQheazQlF9+ZYYZxlfD14tlhw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+naKWuKdQySQYlZd3TZFUOxT8RS/zdSNl4jlIae8/x+C2K9eeRdsRv3/wNrmYGXk2uIVuCY1p3ChTGz5M9dYSzBBVicRnUPZedz2N2R8IbiOxRmq9SoHY1CIWAg1Rrq6bDrWWXpruuLSTB10nscJBOvYGEcVdXMV4OFUfvRWfC0wQUX4y9efv7OJG85KsINKbiD/CDg/qxhh5rMk9rGfsCnk4CXveXCR54hxZ9b5SsafOucx8sb+yixSYprr/9APb9dLFeshAin70J8iDEATfERL3AcrQIrlBVswe/AQh/AXX1JG3tB8JvC5jBrHghzS1KB/not3BmpV5bnorqDWFYQU5qo7w+RRYIFncfQa8LhLndhBLga7c2RMzVi37jPhHtb1jvn8TlYpO8/W/ViP/lSSGiiQDfG3gTcgwrSK+Wk9CZb2MekWHHb9c6R3oKx51Plks2ymFWekco8k9lbDxo2N/fyNaUmAhTr/454a1Nn2X14aHEstYL5OZmgEdwaSRWqromMWmoDsl76OsIaHe5kNw7RdE0xamBiDrgwRqwMnVGh+dLYp9qxrbT9vPwf2AGL4MODL9thdGC+iVfCg4zRKRtcNKGxoyGoeGE3qgu4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c75b8cad-c163-4455-a686-08de8442a370
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:31:28.0968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSy6MfaoxS4q8NK8YVM0IdELmdW7pJ+X8D+ZQQ3iZUOPEsR6Hs9FamcCvu9r9knlsXNRoLSSrU9rIhx3PMVVIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_03,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603170145
X-Proofpoint-GUID: wYdSepXGVZmqctDkjWXSQa37J_3xEKyB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE0NiBTYWx0ZWRfX78t6gEK3NOfN
 NvJC+sfqAUzx5aLQoUw8XtYJ292/xDTB2PSNEcUWbGWgE0igZnkAIJPFdXNCXsZAhKncMvpuz2H
 WUNcqApAjha5MhL2QcHtNf5z3/Ao6lzXXD7x4B1KuYqGnUZLSZH2GlB5JZnO3gfnKNoI6QRAIuJ
 wxtPd01iSDPRAf5VrjUpjrRu1Gq8fxNBUpHwuVU96SHtaygdJMez+g0SAsqhP5FMlep5cJdeX4q
 /bOLk/0vyxN868aFERQOhZe21GpLzvh8RAnV65Ag2AZKJcQevdt1dbFZZL9OJr1bf5QPkVET7CR
 IdbAKov1evX9rJ35Yp7Egd6Ayy5U8/jcvgCWgbZPTyz6Bh8npsLM2mI46sFyDflo/woLYJQjixI
 oZXOkdxoUM0pIFtpscGyge2Dsgdm71IE4vB7S5kxJnA6HIKDapAua3lriP7HhNXy7rb4gv5bRaj
 eBCkdEhY+QehfcYlb9Qac1Y2Z2m/0arEp53xS61k=
X-Authority-Analysis: v=2.4 cv=dJmrWeZb c=1 sm=1 tr=0 ts=69b981e6 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=VTue-mJiAAAA:8
 a=yPCof4ZbAAAA:8 a=PcwunJldpSWZqpLde34A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=R6trLQSf4H0A:10 a=S9YjYK_EKPFYWS37g-LV:22 cc=ntf awl=host:13824
X-Proofpoint-ORIG-GUID: wYdSepXGVZmqctDkjWXSQa37J_3xEKyB

On 16/03/2026 22:43, Thomas Weißschuh wrote:
> The blk_mq_hw_ctx_sysfs_entry structures are never modified,
> mark them as const.
> 
> Signed-off-by: Thomas Weißschuh<linux@weissschuh.net>

FWIW,
Reviewed-by: John Garry <john.g.garry@oracle.com>
