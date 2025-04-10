Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E38284B3C
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744288203; cv=fail; b=jE/gvJfavp92uj4z6+yQBkf7rM04gncImoonnaDxrN0zbHu5TeWPEBHPXT5rh7wD26MsXFu4Y8qasSOtoAAgCb4LDkcpm+NfDX11mh6XAyQFpWqALC2PaGgH7a6f26NlrmdmZWP2hQG48PBIa/CrpCGQShyzC0PgmfnS+4GN/ZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744288203; c=relaxed/simple;
	bh=QHVzHsVS43RselBYVWS0yNf5nDcXojDuz0ZddQYx9pY=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=eEXS8g1NYBit+jU70+5nYDSYfljFPC3OYStEh/pucXKf+OakrHGIzmC8RijRhfeZG/Y49FuxzdSCFhl/vexaEP+iAKxS7Gyapmy0euq0wT7GVEnZT64jqf6zYWXf9pB/OdSe6hBSkjIFUiOoQriAKjynpGmmZjk+ksHXaNXjY0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nTYb6mL3; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nTYb6mL3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqgzK17ehyLVTll9vMCFcpqfHuXiQL4PVWlkxu9h7tjump2EPwFel/HTTrzbfuSWSb/iX2hZGBnR4xKYU9Qywzhr4xqRvaV3Ar+Pq5ltlu7blIF0xX90+Jiv8qN+ECXdxCeM8MTMwJPO0UnmoCE/ppOd5rjR4uOjzubjjwAERqJH9lla5iB7qfgtZnZ2ThvlIDjsm1gpmNg+tQ48BOGEfQHGtP2Rr/l3tsXjGZBY9vDpT5V24SE+liM76dKHWuCOkYL7003VpSay0CV8jj1ge0QqnZiq3tlWur6EjdnBqRENaCxnleOXJSzI1mzs1kDmAZHgjTyGxK2kXuaCH5clxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUAgut61i90A/9FKwS2jpjd5SrkT9qqHR2Z61VDNqG0=;
 b=llMSyT+5YURoBu4IEDbSmmzLquEXhJa1+gniqfM6rQ3RlwR5x8pP0pYdyoqgQwSCEz6OUMjq46bTXqwKyGk0eQfdh19xppG7sfSfS6cdWbOV7HS82IB5Wm7jXpzErGtPkOxsxJ2wagQv6akMFO6c60cdsxvdMuvtPpaOU+VHdr0FswHo1X3AjJ6EMETXHYPvx8XuxGoUgoKI+Pq6DfsFsKg5NSAJSs418BvYoPcJjCMI4e6Az+H30yB6uQXM0ogFmf/DD9Yby2hr/mTG/C6QWVzmprhEVBL96IohahmqRH1LehQ1T/J3kKeYCOCH5WnlFtMXj/R0Ln8yUODE3s+oHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUAgut61i90A/9FKwS2jpjd5SrkT9qqHR2Z61VDNqG0=;
 b=nTYb6mL3axxyMbdUfdrQUd+LbyFrKpgi3B63cjY0FWuOiefRjbMBROArk75z3vP0gSK/FDNq5XzW2pZ+pHHnbXeacyWjZTNm1kPjV5DTjPkiTEikCgROMmJDszzgyjKhRFPxUgS1Dun+9N3UlGA4b5fH1sBqJ+UBIlTsIy8YDHggbzvVDCGuMX42cb4vuhD7SIVD0FFWq1r5O970sTbMLcnOZ/O5vh+UD5XMEdoneaBWATeFJ57x7knujzxFn086G8GFBGlcSVXYklcS/eu7GcaTwAt+MFCLYR9JKrhgJAKZDgNlMdjwpvZJVsqp2pZDoWJprVSh7+PDVSykE+NDDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by SJ1PR12MB6097.namprd12.prod.outlook.com (2603:10b6:a03:488::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 12:29:41 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%3]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 12:29:41 +0000
Message-ID: <d90ff20a-b324-49b8-bc63-7d7a35afd1f6@nvidia.com>
Date: Thu, 10 Apr 2025 15:29:38 +0300
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
From: Jared Holzman <jholzman@nvidia.com>
Subject: [PATCH v2] ublk: Add UBLK_U_CMD_UPDATE_SIZE
Organization: NVIDIA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:254::22) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|SJ1PR12MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: 1849bb7b-c95e-438e-5bbc-08dd782b5dee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXVqZlhrZmhmVUVLdkN2dCtoUjQ1WVRLNnRUQ1pFRTdGNzVrQ0ZRWElwaEZ2?=
 =?utf-8?B?cHBDeDVjOUhzdThieGVoZFhtOXZYRExqd0ZZNTQzZ1JPeE0xSHM3MlUzQzBm?=
 =?utf-8?B?cVdwakJCSm13ejFwVEVJb3ZWU2dKWlA2WmZWQlIvaDRNZ2pTaThNUVI1M0RU?=
 =?utf-8?B?ZFJMdWhHNVBETFhHSnRqeXFoeG8xWUsrOUlHSGJoNTlUb0tXaHhYSWFOMzNm?=
 =?utf-8?B?MTFBQndQUlFBelNOQ2tJYmQvV2JzWDBiQ2RRS0ZzTFg1WVpnWjVNTGljTkZk?=
 =?utf-8?B?YWdzY2N0dzJVd21YZjQ0QzlodFRwdWc1Um9lOGxNMWt6eXoyV3l4TTdSSHNB?=
 =?utf-8?B?WkFyeHczbmVZblZSc3cxRTlLdDg2SDVRZFFpR25OdHhWUitzMjU2enJyQmYv?=
 =?utf-8?B?YyszTG5lMUJLSVhJMFhIUjI1eGJlNm44S3V3MTkwS3QwUElyVHJaTExVeVhF?=
 =?utf-8?B?VllyektOSGVRWm1RVzduVVhpT253SFRJUDhGb01TVFNXNTVFMGVWelFJOHJn?=
 =?utf-8?B?d2YvQktmOVB2a1l6eHFERVA2eG1uYVoxZVRVdTVEUndWL1dyaXJBV2dDQUh2?=
 =?utf-8?B?MlNGUnQ4ZDY3T2NLYjdwVHV0TEZ3U0ZiM0JDanlpWVhRRzZ3OFRJSGRTTXNK?=
 =?utf-8?B?UGRuSkE1K2x6UjdWbStIRkR1d0duUG84UlpId3psSWlmQjVENG9LWXRQTVZy?=
 =?utf-8?B?dG9HbW0rekF4UmduNFhWanBaUnpyMGZYUnQreDNvNkRRY2czakVvTG5FS2th?=
 =?utf-8?B?VU5kRDFJdXRKNHpMUWRVeXFZNC95RzRPRFpqT3NNbmE0Vjd3aE5FNGRXQnRr?=
 =?utf-8?B?ZUFvZVFadWRjd25RS3JJenI5NEd6bkVYOUZyaXVSa293TWZpaXBveGp4eW1k?=
 =?utf-8?B?SG9neHUydHRCTjdaUUtoNkVseEFLZG1WWFZwR3FiN1M4Tit4QlRJTDV2VEZm?=
 =?utf-8?B?aysvQ3RBWExUdHBJN2FmV1hZRXZzaFZrMjFSUVJpUXRpTEtaM1ErOTdFWCtJ?=
 =?utf-8?B?WThkRjVxTDB1N2NOLzRSZ2Z6MHBtU1RqdDFrZ2RCb2kxTnE2elRpVUV6V0tR?=
 =?utf-8?B?Ym5sVTU3VDFaU1ZJOFZMNGpwOGxISUlVWWIzcHRJSHhGUERlQ1gwYkorQUFu?=
 =?utf-8?B?Rkt4UEIxdFk4NUtmR2U0Smt2Z1hCQTl2Qm1LMmQxK0VDRlNNK2dYN2Q0SHE3?=
 =?utf-8?B?VzQwMUZrZ2dDKzZSU1ZBUTUwT2FBR2s1cW1uMkprUVMwbk1EVTBUR3VnR2hB?=
 =?utf-8?B?Mms5TkxSOFFjUUFPKzNlRjdUZ3NKMU5CM3BTNzd2ZEo2dW1uTHc5aVZkL08w?=
 =?utf-8?B?bENSeFlhTmVDREx2bmw5MUQySU1zK0VPeVZpMlhYWk1JRVhVcytjMGpDbnNW?=
 =?utf-8?B?blYwU0MzUEJzRXJaa2dTSS92eng5cGc0eThEYUF2QXk1MXBiMU9LNTlsY29w?=
 =?utf-8?B?TXZDcHJFd2ZsTmY1anVpWFlhbTZtS01SVCtXVk5Ta0hrNWVsclBOL085SXRP?=
 =?utf-8?B?YkFNcGd5anBUMENqam1RQVhoSG5lOEFuMGw4ZDVyT1l2SHBsZnNra1pjbWU2?=
 =?utf-8?B?V0lZRVgrOGRsR0puZVE5Tlo0MlFacWpPNzNpakJDU0lWbkRqMFBUWmpRSTU1?=
 =?utf-8?B?UXdRa0pNOENvd1ZybFhBWUhDZ1MzazhhSmQvRGM3YkJnZzFDMHF3cEpQWTRK?=
 =?utf-8?B?VnE5WGJ3dENnVG4xTDlkMk9HOEwyRHVvcG5UaG02bDg1SGt1YmV0dWFMRHM0?=
 =?utf-8?B?SnYraHpNTy9wZXZGVkZ3NmM1cEd3MEgzWk85WlJ6RXdNaTFzaktpaDlCY2xM?=
 =?utf-8?B?SEx5bWw3VEVIVjRQSit6SENyR2lWTE5yNS9tS0lGdGc5ajN0b2VhVlY0TUVP?=
 =?utf-8?Q?Z9Rp+/le7fmYl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVpVY1JhN0twWGRTcW44dWxCZWtPTTBGenZURzdXU2YyR01MTDhYZVE4dDJI?=
 =?utf-8?B?cktUdCtTWnJDQy9sWWYwWWpNd3dqRkxQaXVSTWpCcXorVGpGTjNST24vYkJL?=
 =?utf-8?B?ejFlbnJSN3M5V3JqSmlhb3pyUUNxdlI0L3drZS9NVFUwMFRKdEJZWkh5WG9y?=
 =?utf-8?B?VEhsdUE0Y05OMFRnc2NSaW4wQzFnZE9mTDAvMm1kWVRRY0ZObkhqeU1KVGkx?=
 =?utf-8?B?cWlZR2J1TUZhb2xlS2dycm5rQzJrdzI1VGZmZmlxRnk3OWtSalBvM2QxbHIz?=
 =?utf-8?B?WDB3eGo0MU0xckJoS00vUEpkd09RR09xSXAxb0xOVXRMMFgwZzFFb1dKUnFl?=
 =?utf-8?B?L2QyVWcrbmxRcDd2RXFhd2xRVVBBd1I2blNVRVdpU0RZSXYvTHZwbmtKaHRp?=
 =?utf-8?B?dEpTQlB3L0xoL003L1hXYW5ENzBLT2RxbWh2bDlKaHJtRWQ3WThvaTh3WW5B?=
 =?utf-8?B?SjcxU3hYWGdFci8zTnNWRE8wRzNWcHAwVUhqa3MrdjlkRWRFRFBEUGZmVEp2?=
 =?utf-8?B?YzZYeURDRExCZXpONDY0RG5RTVVBWjVDUDhGaXdBNmF3TDZVdEwwelNCSHJq?=
 =?utf-8?B?aWVjWkc0aWlobHJFQVQwV2psY3dKNDAvOW04U0RaN1FFMWNIMTN6TkdTMmtK?=
 =?utf-8?B?Wkt5R1FsZ0lrY2hFSnFJUWZ0VldCQW1WUUtjb1d3V2ZRN1RpbnJobCtVTlVl?=
 =?utf-8?B?ZXZocEFpdDMxZjFjbFZJUENvWmtOYkVEL0ZLekhxRzYyQ3loVklGdzU3akwv?=
 =?utf-8?B?c1VXK2NEeHlPVWdRRGxQL0cwTGtQcWRBU3FPZW85aXRKUkF5R0pYTlUxV1B0?=
 =?utf-8?B?TmZIbVVYUEhQdmZBYnRzUFYwL1AwWGpvekh5UGpHbW9rTlRaOE1sUFlVeFp5?=
 =?utf-8?B?S291RDdrczJtL2l0R2xtcWNIRXV2Y2MyUHk2OHN1S0F6NkVGSVJpMFhra2ta?=
 =?utf-8?B?VTBubG9IRG1WcnZVbUowT3dtVlRDelFWOC82dWlPSko2ZjFkdy95RDQ4eFVq?=
 =?utf-8?B?RXV2MFJ2S1JjbmZkWHFBYndrc0tDWEVDN0JiN2xscEVDV2c0UTU5a3N2blNO?=
 =?utf-8?B?WU9SdEtHazBPeEJ2OU9ka0VVdzI2MXZIRjlmQVl4eTZOckVuaktOcTZTTmRR?=
 =?utf-8?B?OWVkbFY3c2w0QlZrbnlrUndvUjEyN3lYUXVMMC9SZklCNGw5WGRyczVPQXBz?=
 =?utf-8?B?QlErYzVCNjJkR1RuL2hLSVNnOTlPeWN4LzhFK1VMWTFNUkJTQStDZHhMVVZU?=
 =?utf-8?B?Z3Y0TGk3K3lLeWlvN25HNVdZdndNQUFpOWUrVlZyQXNZUWZCVThHOG9hNStU?=
 =?utf-8?B?cVJzVGQvc3E3T3RlMnNtRUNiZGVYa21IUTh5MStqam9LSEZFL2gyc3hKRnV3?=
 =?utf-8?B?OVpUdWZlM1ZZU2JOUlBOZk40cGlYeHE2WHpXSlRvTFZsWUtxb0MxK1VUdFNt?=
 =?utf-8?B?d2Z6WTVoQzBpbHI1d1hxWDJaVUhhdkZ6V2QyQTNlYjlNdXdCdHRSNGpETDRy?=
 =?utf-8?B?K0U4MFIyRGdiSWNhY0o4L0VLTktkMGF2KzdmdytBbTBUNisxSUc5RVZ2WHNL?=
 =?utf-8?B?c2tqSGJjaGU4NlVhdVBMeXJoWWZCTzNodnlzZC90QlZmN2s4dmUyR01yb1Z2?=
 =?utf-8?B?SjUvL3ZqMEhMVU1CenBJV2d2WTV6bGFDRVNCTkt2a2h6eUk1a285R3VLT2V2?=
 =?utf-8?B?bThVSHlIelJtNXF3Mm5wWXFpNmpxLzY3TXNaK09uRE8xaFR6cmI1SnFaZlJx?=
 =?utf-8?B?QjY1VVdPTUFTSEVIQTlMSUxwOG94UWpxTnRPYWlBcmFNdEhQSnRVVjFGNmd0?=
 =?utf-8?B?aGdobG1XbWVnTlN1LzlJdlJDQ2ZsNDgzaEQwMkxOMFVMVlZEbFZ1dzlScTVW?=
 =?utf-8?B?WVR1Y1VCbDkxOUxxenVVU1RWSFFGaFdxVVNKKzNBQ252dS9QbmxXMG95WGg2?=
 =?utf-8?B?WG16eW1yREhtbVAvUjJIMldIdWN5MmthcXR4YmFDQTUzaW43b1Rqb01CaDlL?=
 =?utf-8?B?SmFKbzJtQTdNU3oyL2k1SzVFZjB0VDRZSHk5TjRkenFJWUh4MTVSUHJBamNF?=
 =?utf-8?B?eHpYYTUwWUVtSUJMNStIMXBTclF5ZjVCL3Zjb0U1SklaN2FVcUx4bkpHSGFT?=
 =?utf-8?Q?L8to6nG1szIljuYd2RlU8ioN/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1849bb7b-c95e-438e-5bbc-08dd782b5dee
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 12:29:41.3667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymDzA/VBmY7Bz+T2NuSiSSHAqurQzKC2zLM25rsID/OA920VP08p4VJwElurhEZmoPohcgysJ/wxO3ftaWZ1Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6097

Currently ublk only allows the size of the ublkb block device to be
set via UBLK_CMD_SET_PARAMS before UBLK_CMD_START_DEV is triggered.

This does not provide support for extendable user-space block devices
without having to stop and restart the underlying ublkb block device
causing IO interruption.

This patch adds a new ublk command UBLK_U_CMD_UPDATE_SIZE to allow the
ublk block device to be resized on-the-fly.

Feature flag UBLK_F_UPDATE_SIZE is also added to indicate support for 
this command.

Signed-off-by: Omri Mann <omri@nvidia.com>
---
  drivers/block/ublk_drv.c      | 23 ++++++++++++++++++++++-
  include/uapi/linux/ublk_cmd.h |  7 +++++++
  2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2fd05c1bd30b..acf8aa6c4452 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -64,7 +64,8 @@
                 | UBLK_F_CMD_IOCTL_ENCODE \
                 | UBLK_F_USER_COPY \
                 | UBLK_F_ZONED \
-               | UBLK_F_USER_RECOVERY_FAIL_IO)
+               | UBLK_F_USER_RECOVERY_FAIL_IO \
+               | UBLK_F_UPDATE_SIZE)

  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
                 | UBLK_F_USER_RECOVERY_REISSUE \
@@ -3052,6 +3053,22 @@ static int ublk_ctrl_get_features(struct 
io_uring_cmd *cmd)
         return 0;
  }

+static int ublk_ctrl_set_size(struct ublk_device *ub,
+               struct io_uring_cmd *cmd)
+{
+       const struct ublksrv_ctrl_cmd *header = io_uring_sqe_cmd(cmd->sqe);
+       struct ublk_param_basic *p = &ub->params.basic;
+       size_t new_size = (int)header->data[0];
+       int ret = 0;
+
+       p->dev_sectors = new_size;
+
+       mutex_lock(&ub->mutex);
+       set_capacity_and_notify(ub->ub_disk, p->dev_sectors);
+       mutex_unlock(&ub->mutex);
+
+       return ret;
+}

  /*
   * All control commands are sent via /dev/ublk-control, so we have to 
check
   * the destination device's permission
@@ -3137,6 +3154,7 @@ static int ublk_ctrl_uring_cmd_permission(struct 
ublk_device *ub,
         case UBLK_CMD_SET_PARAMS:
         case UBLK_CMD_START_USER_RECOVERY:
         case UBLK_CMD_END_USER_RECOVERY:
+       case _IOC_NR(UBLK_U_CMD_UPDATE_SIZE):
                 mask = MAY_READ | MAY_WRITE;
                 break;
         default:
@@ -3228,6 +3246,9 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd 
*cmd,
         case UBLK_CMD_END_USER_RECOVERY:
                 ret = ublk_ctrl_end_recovery(ub, cmd);
                 break;
+       case _IOC_NR(UBLK_U_CMD_UPDATE_SIZE):
+               ret = ublk_ctrl_set_size(ub, cmd);
+               break;
         default:
                 ret = -EOPNOTSUPP;
                 break;
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 583b86681c93..0e40e497c28f 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -51,6 +51,8 @@
         _IOR('u', 0x13, struct ublksrv_ctrl_cmd)
  #define UBLK_U_CMD_DEL_DEV_ASYNC       \
         _IOR('u', 0x14, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_UPDATE_SIZE         \
+       _IOWR('u', 0x15, struct ublksrv_ctrl_cmd)

  /*
   * 64bits are enough now, and it should be easy to extend in case of
@@ -211,6 +213,11 @@
   */
  #define UBLK_F_USER_RECOVERY_FAIL_IO (1ULL << 9)

+/*
+ * Resisizing a block device is possible with UBLK_U_CMD_UPDATE_SIZE
+ */
+#define UBLK_F_UPDATE_SIZE              (1ULL << 10)
+
  /* device state */
  #define UBLK_S_DEV_DEAD        0
  #define UBLK_S_DEV_LIVE        1
-- 
2.43.0

