Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F268C30507B;
	Tue,  2 Sep 2025 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756829474; cv=fail; b=fTB10tlPAZfYAIFLkVOqMOIgQyW8BDVIHTJ035fGKkFA1E4D6PxfeCiTv78R8TCayXcq1aX36WNwrNSMj6vwejpGV+3S954smnhsZ+n8RNcFjnTizg+UiFsxZyMN8atRxdRibmsHubKXd4s+SFbSkkl0JuSJWcMhirHYU/suf0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756829474; c=relaxed/simple;
	bh=HNKhNMLn8LWWrWwVZ9Wp9vskRkotpgvG90AW7BKzy3w=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pm2BgrpEPkDOW7e0R1slIyGkhau4wODgLLISPko5WdS9RidqYdlBB/CB7c7IGFr2b4JOIZ6QMaf71w8onMTI1ZF/qspunug/jOExKX+UTV3GtLpPi9Wo5Lc+V1MiEAGGeEBuKe4yZ4phJlQeZskKfHLYNJ6GkObEtd+JJJYotRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jahBwZoE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UjVEt2ed; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jahBwZoE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UjVEt2ed"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582DgBeN017624;
	Tue, 2 Sep 2025 16:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=U5zd3lkdphuDCMcfUSPat0tuhtQK32xYSKJSPVDS1Tg=; b=
	jahBwZoE35kKfIsu3w674G2THufR1usgSLnlJ1Tat422yfOOtlhCn84P4/kZo+oG
	kqNzY/uPayrMc2KMaF2fDA9s/c11GZt6pzi+cb3lfgM5JQSnUaozv/5/VOStV5mw
	zGEUjszUNNJmRt95lrUgBI5aoQRK92y1j3pmm8qVXcvpSmnnHpHahBUkJVUWuStg
	YmXi/WCmQ07beiiOwhi4NuUq9JqXxsPj6hEqrs3mcGKyIcSvP9lglNGRxHk0n4Cz
	tei70Z2x6bBQWlyJKxGKxPwL4rGND9/x9E/vg5kjYXCRiCn5pFRCPhWOdB2JAQgl
	iEtFEPknfvMi3u2M7EfIJw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ushgve9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 16:11:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 582F98bH032709;
	Tue, 2 Sep 2025 16:11:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrfkvfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 16:11:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=im3XPg2y2ssDLUXtDV5bDoEWrnZ2hYrBSLYRijVrIrHV1kxmX+tUc/YDiOglCxwQefo61bC8Q8hrVW3xKj8KzTF0A2znsJTvQqDegebCTouLN/fYmsPwJ7xQFzdTtfuYeLxLusECoyQe5HeKT3NhMXe9tM8aK7gvDfKpI71pbYYp1YILgLFe9667xgEQ90N+izm0TfEFR1Ra9BPltioBlrXk+kYdz0E5q6HPidwZd00WE/EDFvggsgzZ8Ln7pDX2hmc0ztyWh9f36Oo3pdXRZF/UK7DPpEy7Mj4HqwC8PERe2Fpmr4pDdZIjadA4hfi7LI55qrwswfS6oaLsoqbaig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5zd3lkdphuDCMcfUSPat0tuhtQK32xYSKJSPVDS1Tg=;
 b=SnZAhSRL2SXiCN1hbPHEHwb5OjaUeWINaJ5anhGUWQeTPbyBNrbQ3lmANQ8s9t2m0TX9OKePdwb3YXTiSBKgE7rhVJT5xzfBmzu4hlIYBjWt4q2I3MMtPxj2k2s+7qDDky75TEBihJ1DX8hvbQOhsbis75H+0erihFjOPGMTp0gRiMtmvsDx6A6PzugxcofbjuoNlYbDHsvlQ2AXDrRsWZM8YwnRkRWDjBfD9tx0/R40dg8/u0DWaSfx7J326uf4NktbrM5+bnR78GUpbaqacecty15IEcL7LXyaexCTx4uTs8rdOfcHbHRZ2S5vZxx0XEFnhfoXYtlQEg//J3mNvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5zd3lkdphuDCMcfUSPat0tuhtQK32xYSKJSPVDS1Tg=;
 b=UjVEt2edhjwN5yTf5raHmk4LXymVPKSGtak29hRoQBeNB7m7qAfb7f3whP78J7k+ndIQT1tT7YwbvVzwAmo3tMb9GGRlnHG09eSrXZnkrU3fVg0/2bK0C9lyPDUSbc8HbyH+IP3Bp01Y/u0j7mEFeseePQk5w1xPjBCzHAc+6rQ=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by BL3PR10MB6089.namprd10.prod.outlook.com (2603:10b6:208:3b5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 2 Sep
 2025 16:11:06 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 16:11:05 +0000
Message-ID: <b6c44c7c-282f-4f1c-aeb4-af0b39bfae78@oracle.com>
Date: Tue, 2 Sep 2025 17:11:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: use int type to store negative value
To: Qianfeng Rong <rongqianfeng@vivo.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250902130930.68317-1-rongqianfeng@vivo.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250902130930.68317-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::7) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|BL3PR10MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fe6e847-f334-4844-8a7f-08ddea3b5206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djBEa1NmRkNWYTFKc2szNnBDNHBHZnY1dUtoMDFyTE1iaHVTdVo4S3lXUmhG?=
 =?utf-8?B?U0ZWVXFOYzlFT1kxenF2bzN2NXRGM1p3SmpBR2ZYeWxlQ2NWUk9YWEY2QjRl?=
 =?utf-8?B?cFpXQmlQOTd2eHhLK1JoMHVRM2NoR3N4VnZobHVxZE9WMVBOTlBpSldXSmZB?=
 =?utf-8?B?SlBNSVFkcHhmL28veU9VVnZ4Yi9CMTlJTXVQanUya0p2Kzk4dUNOM2xvN1FL?=
 =?utf-8?B?bC96MS9CQ21DTGJKaCtlZ0pmd3luS3RpV285NE5PWnVOSUFBNDEycDdCdnUw?=
 =?utf-8?B?azBqREFCRWRobWtMRThIVisvanFPYzBIWGRQZE1zeW12WEg5WUZUMllPNjlP?=
 =?utf-8?B?a1hCZTdMTHBhMDFHVldReUhLM2s0blpJbWs1bDRjNEFkdGV6RGVpRkhKalVO?=
 =?utf-8?B?U3F4RUwvZlVnTWFFMHNEY2dpaDNKMVdFdWZaMU1xMnhUa1RONlM1d0FuWWgz?=
 =?utf-8?B?U25CUnJJbzZ2UnNlSDBJWWFFWVV3Q1hpRktjS25uTnh2UFpqdHFUSSsxUUJk?=
 =?utf-8?B?Z09La3NPV2RndDBpOG1KTEZld2FmM1l3MkFrV2s4RFNtN25ZT1N3R2NYSkZE?=
 =?utf-8?B?ZUF4ZEZYa1haWFB2RnlpNHVXajBMNWJ4WS9scTR6ckVXanR0YU8yQ25PbnZU?=
 =?utf-8?B?V05KejFXRmRtem9TSzZRQm1EVklsMHBRb2ZCOFRWSE1XZW9LR3R0dldpaExn?=
 =?utf-8?B?dSthMTdSdDdPT2xGRkorbldQYWdUejJnR2RjcVhEVHNKR1NibGtqaXQwbzZJ?=
 =?utf-8?B?RHFLWHlvNHp6T0RSZFdrM3VubEVYNy92Lyt0Z09OWkJ4bnl0TC9PT08zWmVV?=
 =?utf-8?B?Z0hIemRNUEQvUUhFeDV6dWwrVlpuOE5GNXBDTnF4RGtEeXFCdEdlNE5scXF1?=
 =?utf-8?B?djZuZEx2bzlmekdmYTkvZGZQKzlWNk93bEVaMGxJNkRLLzN6L1lBMGVJd2xz?=
 =?utf-8?B?am0vTGdFblcveWUyeGVzRk5Na0s4Mld2UUlxaG52ck5lczJqVzRCZm5iUkFG?=
 =?utf-8?B?Zi9Eb0pQUklxbmxGWHgzazVRdlduM2grZFBxeWtmYXkzN013K0oyWmFwN05Z?=
 =?utf-8?B?TU9KTlU1MHgyQXgySVYwMElmaS9XL0VQR3QySysrV2IzT3k5S0dNTExOK0tV?=
 =?utf-8?B?V1dCb1ZxbXRnbVk2SFExUDQ2K0ZzYk1GVWYzajRrQzYxN3ZyQWhJUk1XRjFQ?=
 =?utf-8?B?MWFZc29zem9HWjRCait3YWc3VzdKMGR2SWFzTHppdlNTSjZZUk8yUDl0K0RL?=
 =?utf-8?B?Yk1ka3FVMVFSdWdQR1dOekkyWXIyV0lCYlcyS2UvbUxqRjN4MWFYZjU2OVU4?=
 =?utf-8?B?WjIwK2FPR0Z6YngyMDVuUnovNWpaN3Vud3BmSzloNmJ5Y0s2N2h0Y3N3aFZs?=
 =?utf-8?B?c1JmRGlVTURpZDBVZG9RS0toS0haajJFMTY5QkNZMGszKzNHUFROeThSaUNN?=
 =?utf-8?B?dVZSVjA1bmFPWGwvV0RCRGNzUVp4b01oKzZyNkIyK2M2NnBMemQ4bDFINHpo?=
 =?utf-8?B?WTkzSkx2S1l4ZURwTnp3K2lLWmttNWZGNDJYc2M5dkg2WHlxUk5YaWNVWEZG?=
 =?utf-8?B?SzlYN3BnNHpSU0pLbUo5LzF4WWpNdEdDYVZDeHdNK1Y2Z29qdDlDZmVRWHRK?=
 =?utf-8?B?ZG5qcUN5dmdFRFhEYy9lVldwcERHeHVpUTY4Zm5Dd2RrOHk0L003L2wycGNa?=
 =?utf-8?B?RFJqWmRvd3JvVSt1YUZaWlZTa0E2WitzeW9xNzMrQkRuTjNhRXlNZmNScHZh?=
 =?utf-8?B?Y3J0MUplcUN6M2c5elZyc1g0S25uNlhKbnBqNG1FeGsydGhoU0YzN1ZvVkZp?=
 =?utf-8?Q?tsYAsxKKcSs/7WEWsMWkiQVO3ubm2f/GreDm0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlNUb29zc3JxTHRFem5NTjVYbDhUZUd6MUVaRTZnRlhiZm9GZ0lSRXdZUy94?=
 =?utf-8?B?dEtndkFtb0J3QnhsRUhETThRU2NpeWVvYzg3T3RSYUVvYnl1TUZJL2xmUjhW?=
 =?utf-8?B?TDVlQnBKeU40Vk1FRmx5WnV1VStuS2hFZjk1dEJ5Yy9wd21kYnp5R3J0NzY1?=
 =?utf-8?B?OUxZQTlUbytFTUpkdnFsNFNESmVHcE9KenNDSnh5d1p1MjhlMTBDY2lVM1Fo?=
 =?utf-8?B?ZUh2ZGpOcStoVHppcVRVUElmeWliT2hCWnJHQWlPR3lSOE90ZUU2Smk5d0d2?=
 =?utf-8?B?YzRhTHJWcDRXaVRDVFFXZDQrT1RLTkp5TlMwN0pJanhFNjZlSFNSdVJ1aG9C?=
 =?utf-8?B?Rnd5SmkveUFMR1Q1Q2lyUm9DdmdDaEpSTzNCdlVQZ0lVcUhGYzREb3BGK1RK?=
 =?utf-8?B?aUlzVElCVzE2bWxkVVJDK2laVXkrOUp4c010Z056WTJka0NxQ1ZSQXQvbWxC?=
 =?utf-8?B?cFVyblpSNnQrNjhzNEd4dWorQWFzOW0wREZEc0hWVU1vZ2d4bjhpTldBRExm?=
 =?utf-8?B?Z2xRYktGRTVRUmM1WmRENkVpR2h1TFdOeFpWTlZaNm1uRXNlQXZhZStYNThL?=
 =?utf-8?B?Zm16N01MU0ZVR2VwY0QwNW15eXNTTVhKd1BkRHkrQUVHWlVSaUEydjBLanlj?=
 =?utf-8?B?c1dMMWxWVktJQzhUVDJ4YmE0SzFTeVRxcUNkRVIyWXlaQm9BdnFZTTVNTWZa?=
 =?utf-8?B?dkhLRGJFWlQvOURlZkdrakVSWXhVcWY2S0JTbE9GbGdtNzl6L0d1eS9FMFNH?=
 =?utf-8?B?MVluYlFncCtibWd0YWJnZkY1TGx6N292K093ckZYd0pDT1VLcTROaXFRNFRR?=
 =?utf-8?B?OGNkSXQ3UFhHMU0veENTU2ZxMG83UWhqaDB3akpOKzNLeFFRN1hpNldDT1Ix?=
 =?utf-8?B?RnJyNFhjODNlUDJrNVNNODdBblp0dXNJd3NQN0o4YytkTVEvMUkrSVVRb052?=
 =?utf-8?B?VXI2UzRITDZGTnhmZjdTQmN0SU9aTHFXeG9IMW5HSTFmYitRM0hMdnZEQkpu?=
 =?utf-8?B?azR2dm1VRVdyNVRRSEtrWEJQemZlZlQ1eEdSYStxZjJPZ0cwd1ZwVWp6NE8r?=
 =?utf-8?B?cXZ4VFh5a2xpTlN2WUcxTWxJdUYyUGNUN2lnblJ5L3MxNi9pQmZvR3g3SXJR?=
 =?utf-8?B?Y2FCUFdLV1RiV3lteUxMbUZrN21lT2JBSUV0TjJ0RGZGYWZZZGsrT25xS0Rv?=
 =?utf-8?B?U2d6VjZIUkordGluOFVJcVNxcnl2N2w0dTU5bmZRL3ZrVmh3a0tLWE5sV1ly?=
 =?utf-8?B?LzJCUkdML2lybXZ4VUl1YkE4cGVPVGpkcTdlTktGSkdkazRoL0NtMkoxc2tt?=
 =?utf-8?B?WTIyd0p1cSsxOHVjL2Nmcmg1S1p3dUozd01Ia294cUhRTHM1TUQyZ2J0QTdv?=
 =?utf-8?B?WDQwZk1UanhsQ3NVU2xWRzhZMDBZaWozUDl1MzRRdy9aNWphalJZbk9JS2xP?=
 =?utf-8?B?cmZGcEhTWnRtaHNYYmpVZVZ3R1NRdWVMTWQ4WVJ1dGtMNGZaYUNIYkIvc1Rv?=
 =?utf-8?B?UkpiM2QrUDZsNm40VG9EdmtVSW1qWGgxcVpoL0tiV0JFWVF6aWlhTUJ5U0Zy?=
 =?utf-8?B?UzFsMkFrR1p2WHp2WVNWLzdva1lrTTk5bXFKSi9icktHLyt1V01EaWxweHJ0?=
 =?utf-8?B?cE5PWHlsOUVKeW9XeEdUZ0pObWFKVnBHSjVLSnAzeUY2d2E1QU4xdW5ZZkJ4?=
 =?utf-8?B?QUlYODdQSkxSZjhDK1VMcUM1Y0xpdXFCL0lvK1hlbmRyUHRkcEZvSHBZNUZO?=
 =?utf-8?B?RnRETWhGUnFZVTBQYTVIVGsvdzBpWHliMk0xd0hJcVBrM05CUjVpeENWZ0JE?=
 =?utf-8?B?ZDdJbE1ucjNZaXI3cW9PZ2tSMUhtbWk4Y0VodFlVRERNZDQxUHBjd2kzTmRM?=
 =?utf-8?B?cEpmUGtvbUlYRnBsa1ZmT0hFK1NWR0gwK0ZuOG5nYkNmNHFybGdiazlTbWNG?=
 =?utf-8?B?bDdySkx1K0h1OWVYQ2hkb0QrenI5ZnRKUTQyK1ZNcW5ZT3N6Nk0ydGtxUmc0?=
 =?utf-8?B?TlJVaXlVODR2OGlMeENqWUhUSEgvSE0vWDJ1MnBQM3ZLMEFIemVjVHVKa1lK?=
 =?utf-8?B?TndleGxHZnkySnJxQXZUb01vTnV6cUlFSnp5bGR3Zk5TckRRalVnMGZMZWxv?=
 =?utf-8?B?OVh4S2EyZWVpekRjT0wwYzJMb01uSks3bWY1VStjY1ljZjdvQUFsdkk2eitq?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	du2NGymXin14I4wUFxpKeVM6goz/wX5i5jaFGaxkuBns2n4HBNH5fUJwHnoysx7OtKYvnXN63+j9VRn/zpUM8Jp/U+cffxP6D0+jugAw01YBHVflP+POTO5erLFanrgMOXWv1f5RIOJVIwr0/EAThqwXCZdOLNBRns1uQiMsXLWoWoG5nhpY3w/FSQn6A1mifPVQm+OoOxN4a1Vx58X7j/HhUIw45WCJOUskd4RTbzaEJgpcLdoROEtmK3vV0QHLHpKoL552sC65O2+1TpTPq1tl7xp96AFqD3tQY4GVFw0buIkC/2NkoxUgU6JYh6JZTjFluaaOWTtKVwGK+WAX5SojrVHILCEMQeuyy7Q7SFJYBV54ExuhmRH0crdn0FKr7+gzF+eDwwZVMmN6t846zHP2vHf3B287JrpV3DHn816aaGp3xP/iARmRZ1RG9Hmn5G4WH/FHlg9reb2i7joHxhZdwrYEuE86BRYCP3GPZWXA3dJejNlrM1NjK7cCeeCL9OAoC7X2wNSTf8emao4NEbV2PNc1VRkecmwBY58FshkQ6eEbiW/7fpiLulQZtPhc+KJPOnU/17C4r8UxSLgHqfu3Lagd5g6eqVhdcEw83uc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe6e847-f334-4844-8a7f-08ddea3b5206
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 16:11:05.9034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pfmu3/A7265i09kvXUxmFDfXBRRpiXOFqEgJ4tHVOjYQ4QR0bVBO0350DMMnvBi+5ucqpJTQMi5AHioFbtSB9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509020160
X-Proofpoint-ORIG-GUID: lm8hzxwoFJGLNfWPH5puBZDvud3J_kAn
X-Authority-Analysis: v=2.4 cv=YKifyQGx c=1 sm=1 tr=0 ts=68b7171f b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=1WtWmnkvAAAA:8
 a=yPCof4ZbAAAA:8 a=0xR-IGaWXB2ZAy-uM5AA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX7UuSd/tsK6pn
 6T+MFYHkHQHJKr3vbEUdQ0eNyWrSJgvrFqw9CxSWYeVwSMo/VnX1wVbOpBQZ70DzVxDEEGEaAHy
 PM5OiFVe7yENsfcvTPsDpfOoi1Uh/92nZWMox7zoK6Rw8yKDX49w4/U2VsztQJnCqYlGDZ8tcjI
 5a8zjjtTZkgHmtJMHzi5AyjvczYLM5dzMdezDV5L7IEfYv6/XuXRl+GC63DjTwWivUGCzV9rRZg
 QXdbhmB5uOPRCUxqVj0OeEGvIl7JdmRwKKAxgR00WVcMiFIP34wzSXybluV5Ktt0E83+nHd0o0H
 qAPRsQN7Rd4N+hldH9UGVvJF4Tv2SAvFonsYnItsYT4eCBK3/HWCGDbpy+J8ysihlwbP57N1cXs
 fCy6cwdB58DU5Jhzko+aI3xUAMjxGQ==
X-Proofpoint-GUID: lm8hzxwoFJGLNfWPH5puBZDvud3J_kAn

On 02/09/2025 14:09, Qianfeng Rong wrote:

maybe be more exact in the subject, like "block: use int to store 
blk_stack_limits() return value"

> Change the 'ret' variable in blk_stack_limits() from unsigned int to int,
> as it needs to store negative value -1.
> 
> Storing the negative error codes in unsigned type, or performing equality
> comparisons (e.g., ret == -1), doesn't cause an issue at runtime [1] but
> can be confusing.  Additionally, assigning negative error codes to unsigned
> type may trigger a GCC warning when the -Wsign-conversion flag is enabled.
> 
> No effect on runtime.
> 
> Link: https://urldefense.com/v3/__https://lore.kernel.org/all/x3wogjf6vgpkisdhg3abzrx7v7zktmdnfmqeih5kosszmagqfs@oh3qxrgzkikf/__;!!ACWV5N9M2RV99hQ!JfWLPo_X7bYZL3xujNcmSob_sFzfvnOmFwzTQ-buSgEyxB4Rx04CZsZmcwf8CSAME6ySlTkSsgsc2EWpNVX-LC_C$  #1
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   block/blk-settings.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index d6438e6c276d..693bc8d20acf 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -763,7 +763,8 @@ static void blk_stack_atomic_writes_limits(struct queue_limits *t,
>   int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>   		     sector_t start)
>   {
> -	unsigned int top, bottom, alignment, ret = 0;
> +	unsigned int top, bottom, alignment;
> +	int ret = 0;
>   
>   	t->features |= (b->features & BLK_FEAT_INHERIT_MASK);
>   

