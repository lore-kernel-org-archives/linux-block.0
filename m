Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C385D137760;
	Wed,  3 Jul 2024 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720009246; cv=fail; b=T12UOiH1dh8xXqMa7aqGmZEccE5AMCXFEOuXhCjt3DKPL6iWUfo05O8bkDHm9hYvQziW+cpsH7N7uJ0I9eCt20PjSkQmNz14rlUnZpw/gj7Ytog8n8rUJ6Q3Dvx8097xON3dIUzAL28aD6IHm96idSWON4TQ6wVNIwGNNek8O/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720009246; c=relaxed/simple;
	bh=RGJALawKqerXwcutC179FZsnlZ91kXlwwAn5TVZEzNg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dlThyr86PH/qCe8IPRtLYtRaNjNm3+SUgxGLuNaxLF9QTbZVA2y5qY+Hj/Oa65unICfH/JFqiyCc7bSbyAEJZGM/6v47ZaZaL8np3G2WHTITP1PGe/W8pnf8kyCxrYVxZAtvY/dNhpMMVJmCu3RDZcG2EpKLMUAcv3oGwkZ59mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WIXaj696; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qTmgrc9V; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WIXaj696";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qTmgrc9V"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4638O7C7017795;
	Wed, 3 Jul 2024 12:20:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=HYJKydiUg4ti0RdOp9NF/KKdo1KxFNkMTnU4U21/MYg=; b=
	WIXaj696TPPwBDLba1kFakdLqMZ38czDwLZK28PB/e0iBm9DrrGtKL9pGXzv8Nl+
	53VcTGAYQXRQGPpdtVe8TFAf695LQ1TMFARe0p7fZ9P4PefNhhXBRj+Kshb6avrA
	SWRVyOVAe+u247Vrx0OvElirznafQGybZ07MdHxXM6hYYMpLsfpr35C6mAr707ok
	pFF2QP0SGuuNWqI1/nZBZ8hyI/y3bzTJ5tOorsj01flMEVTS8fJRca9SL34MwmAq
	NFwkEoSIVdT4Z6zckrg+BWy66g1nJBGeVJ/e/96V8wYi7YuvCbxc4tBah+iNS60h
	6aBM5Cei1266efxNNJ5qog==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 404nxghjnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 12:20:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 463BD08I035751;
	Wed, 3 Jul 2024 12:20:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q8vhx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 12:20:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3rd5TiBmxF+M2saof+X0/iJfoGwUUDBm/X4ojS0Y97a+JltkSDs7/U0VA3yBqLCSRVgTwFaE1jF67m2M+dRUwWusY7dlCeJ1PzpFLKol3amLZQzlX1JpJX3l5k8eugC5LabBQbDPZ9BXnRpFIfpuWeilYJ9TbnOhRv5Bw4lUH3gpNU8RIEA33qoTl0D5jEHt83bVWqPd7581cTw0fDgTJcHHwcXB0ThHK8UYlkzCY4qVSpsoOcmL32fJnr3S6apqBPRGk/QMhXTjZPQveZsEmZpPiqD+DSQnxBJo4nx9SDQrDAnt4Hbrpo0C12bo99fKCSfrYouME/46qPInAMSEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYJKydiUg4ti0RdOp9NF/KKdo1KxFNkMTnU4U21/MYg=;
 b=T2aVmFoPT5WEBE3L2wvOkKCWyTbDz9IlzeQgehKLY1eMH9crpo8/htcWwMSU8mcv0k5gKtikS21ov9zWxP+qN5+V9KvmRKUmHlHLgMP8IvvL81efA0iMeSeYkC/Mb1O0Fm7VNyf2gANSMgidsbEIC2tcOmghW3vQtXSBbd8JIhBYQEq9cAY1/qC3LNpkeIa3cNBAO9Qq8fr9Ljdo3MV8+oNz/k886pmlt/YM4sTThrMAt2Re3gPSTbLV3pUu7Z8TIzRWMooQoodsiQbuwIpyiT8xFYWQBUvIItSwL4s2A4VdiMGqsQjrfAtpZp/Ji/CU5wxILsyKH0BCQhTbR8ti7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYJKydiUg4ti0RdOp9NF/KKdo1KxFNkMTnU4U21/MYg=;
 b=qTmgrc9VFRDhZXENZiqt+p56j+pWKQqrbcZ2hJkIdrtaWWkyDaeuo9ML9r6ryjHl8dTFYU49T6H2T9xgDYuySdfcNeospU5xQhYL8t+ZuzY0+aXL+SjGEZatDsm7DtNk445eGS39QCe7yBmnB+yN6fN4D9+TP2roX+hct6fkmIM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 12:20:31 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.025; Wed, 3 Jul 2024
 12:20:31 +0000
Message-ID: <43aab70c-8521-4dfa-847a-1175d31a55d1@oracle.com>
Date: Wed, 3 Jul 2024 13:20:26 +0100
User-Agent: Mozilla Thunderbird
Subject: blk_validate_limits validation of block size (was Re: [PATCH v2]
 null_blk: fix validation of block size)
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240603192645.977968-1-nmi@metaspace.dk>
 <Zl4dxaQgPbw19Irk@kbusch-mbp.dhcp.thefacebook.com>
 <Zl6cHI48ye7Tp1-C@infradead.org>
 <8f8f8f78-fcd4-4e71-8dd5-bae03a627a34@oracle.com>
 <Zn-Wpq2AzBo6rcgd@infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zn-Wpq2AzBo6rcgd@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0117.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7329:EE_
X-MS-Office365-Filtering-Correlation-Id: 059ba7c6-ee2a-4ed4-ce8c-08dc9b5a87e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QTJWd0ZmbUZPKzg0OXBqQXVqbVZCNkR4NEE5T3Awa0lwd1FJZVV5UjU2czZJ?=
 =?utf-8?B?ZlRXdHhiS0ptU1dIdjFhRzVDVzU4cG5NVXB3bFVvYmhsSmxWYUlyQlUrY3hv?=
 =?utf-8?B?MUJqSXZYcFhpQmYzcjNBMkNPSmZkeStOUnZ1T0lVRlZoOUhSSWdyczNTZGJH?=
 =?utf-8?B?bVZsVFhjN1hXOFZMTmRpZG42YllxcUk1R3I3b1E3MTVETExHZ2tlTWs4c2VI?=
 =?utf-8?B?UW9JWmpxQXIxWnN6QnNFaklhZTdLLytWZUZKNTBZV0svektnK2djYS94K3Fv?=
 =?utf-8?B?UUFQOHRJZERpcXpUSVpGd2dGeGhnQnRSd1FwbkxBTUxBNit4ajAzVVhvaVFX?=
 =?utf-8?B?eUNVaTJ0T1YwN1dRYTY2OE8xaHBJYWhxd3FrNEhMdjlrdGtqalNwcktLcFFO?=
 =?utf-8?B?WWIvRFFsM253c29xRmRFVmVCcGpIKyt4REdYcWZLaXhRZkFJNUNMZ2hOS1By?=
 =?utf-8?B?NENLNi9aT2RpQUIzTnRoNmNCenp2UkQ2bFdoVHdOWVBROWVwb2Q2K1ROZEI5?=
 =?utf-8?B?RzRwSnJpaG9DSmx6ZUdiMDFWdG1VZkNnc3JwUTFWTEpQdVBpYlYzTHo5VWN5?=
 =?utf-8?B?QkpoeUs1bFhxdU5ncy9kejVITG9LRGxrNWZWcmNyVGtkR3hoM1NDTmJFMHBX?=
 =?utf-8?B?SHo2d3NYcm5zR2xkWG1jcHBvRGErUEVpV2gyWnAxdFQ0T21uRU4yUUhsTGFv?=
 =?utf-8?B?RXNxcE8zeG9JdEppcXdRbHJOeDZFR1pzMUdvUVRtWGxmRVlWeURKNVJJMHo5?=
 =?utf-8?B?QnkrR043T0kzQWhGSVlzZzQwcW1Sd3dxRENreHVTbzNMZ1IrRlVudlMyR1V0?=
 =?utf-8?B?RHhNY2tjbURSWC83dURjbitWK0xpRnYxKzBsSUlSb2g4azRBelBvbjBMK2JW?=
 =?utf-8?B?YkhqZy80cHhnV09mUWZKZU5wbExNM1BNMlE4MEtEQ0JiNU5Ddnc5OFdyOEIr?=
 =?utf-8?B?NEc3NHJmNHVpcHpXbFdjR1p4dFV1UnEwc2NWZzFWbjhnVXFnTXNVSkgxRGk4?=
 =?utf-8?B?Zjc1SFlUN2VlRU01RGNkekxqazVLcHg3bHB2RXJBTTN3L1FrWEpZUnhIUWxD?=
 =?utf-8?B?Q3Z5Y2diR0tYVjYvWDEwUzJwc1UwbWlMTExLNW5KWmswdk5UcDB1NWJKS3Rs?=
 =?utf-8?B?SVdBTlNTUXNzYXNmZWI2dFlnYjdabytWQ0lGRVpTTFVMMkNLUTBXc2QyYWMr?=
 =?utf-8?B?V2cvTno2bjZJdUlyWlhjaGYzcGk3TERhTy9tKzFEWStvcFJqTmVwRGM0YUlY?=
 =?utf-8?B?dVdlV0thZDdINStLMEcremtpcU1XVGIrZVBGYld1LzVkM1lNR1A1dzl4WHhZ?=
 =?utf-8?B?YXZJRVpHcnlySHcrZTZ4cjZocXY0NDBZSHQ1SXZjM2RveURIVmFxRUg2dWdB?=
 =?utf-8?B?RGlVSUJiZ0czNXIzTFZ1a1ZSK3dDendJdy9DWE9icWtVWkxRZzdWL0sxWjlr?=
 =?utf-8?B?clA2VXllWG5xUVFzWXo1UUxESUk1NDdXdjBzelpML254L29NOGJwRTJ2MmV0?=
 =?utf-8?B?WVlpQjZiWG1hOHgwRTJkZmYzSll4STJKSTQ3RWV6MnhlSXUzbS9kSDRyazdG?=
 =?utf-8?B?OTVBZXprSkNUaTdUQm9tWDJQdEVlQUxDcGlRYlBjM1p4OEdLNmRWUWtBSDlo?=
 =?utf-8?B?dGR2QnBFYWZVOUlCdVhqK1hQTW8vdFF6b0NFdlNpZnp2cExEV3JkOGhuUmRF?=
 =?utf-8?B?UGZoUER2R0NubXkvL2dLb0J2Zy84RDVwOW5qdG04VzB2ZmFaUXp6YTVLTmJ4?=
 =?utf-8?B?RVpsSEFqQjN6WExWaUpHc3BJRkVLbmNhWXNOS000dVA1MjhEbjZSb1RydlZh?=
 =?utf-8?B?Vkc3NTNZdjZPcFdXK2JmUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aTBvQVRFb1lKOWs0YnNodHd4MXpESlh5YkxvY0RNUmFFSEx3RzhXNHV2aXd0?=
 =?utf-8?B?bFNRRHplem5rU3VtdXEwUmRBYzNpazViOFNWVXdkVlg2Uk9seE45VG1Wbklx?=
 =?utf-8?B?YXFKczRlUWZVQ1ZlY0IxQ1NIWVZtanFNTDFQZXpMSzhPWnFTTmlEUnRaeHBy?=
 =?utf-8?B?bzMxUFBJbGpNVVJWQk5oSkQvbGw3d2VjRkpWZzlkeHFzZmZTMFJqTDg5eDh6?=
 =?utf-8?B?ZzQ1MU1ORGdPQTJuaDF3Ny9sTXhwR1dWb3g0TXEwN0hMdWovM1RZT0FIbWFy?=
 =?utf-8?B?bnhxVHJFcldNaFRLOFhLalRObTA2NnpDM0tRWFJzZEordUVZd2dWT0pYaEJR?=
 =?utf-8?B?L3lGYi9ZSktkR09ZMWdRKyt1cU5OWjVkbDR0T2xjeHVFMGF2aUxIMWViRmp3?=
 =?utf-8?B?SnZGT3JKbnRmWlhONnVIZi9kT2VFRVc0bFlxV3FjT1RlWTVZTm9OZGNmMVln?=
 =?utf-8?B?dlRpUmcyK0RHSDIvYzlJZTFadUIwM2k2Qk02NUFJOGJQYVoyR1NhbkJMaFkv?=
 =?utf-8?B?UHliVFNmamozOW81d05wU0NVK1VJUjZVWTJZVHo5OU5sRVdPRm12azdpZjJy?=
 =?utf-8?B?Tm5wQzM4NUxkbGRtTlBCY1JRajBUNjNkR1J5SE9SYWwzcTdIWnB1ZEVKTkRG?=
 =?utf-8?B?TnZXbW0rN0szVEpCa0N3RE5GMUVoQWtDQUdSdHZtSjFaT1ZnaWQrellZVkty?=
 =?utf-8?B?T1hLRXhjQXdJVGNrcTJsNGU2U3ZvQ25uZERqVjhYVDc2K3gyWnR6ZU1zT3BP?=
 =?utf-8?B?RFVjQ2FPVUJKMW1kYldNVC9UQlNFY1NQVE9FY1VIdkJJTGxXZG9hVWRIbW1v?=
 =?utf-8?B?T1VjNDZ6NldQZWdQYzcwRVQ0QncySGZVdjZySDN4K3plSkUzZTV0K09DVGNx?=
 =?utf-8?B?SEQ3MktjNEhMNC9zRDZ1MnQvL2trODR6cWlRWTUvMFBFSHk1VzNHTnlYRXFu?=
 =?utf-8?B?VWZ5NjdtY1J5RDZKL0JkTHNtbllvdTZ2Z1FjK3lYUUE2Qk9EMTVkVUM5VDdi?=
 =?utf-8?B?QUUvRVVRMHJaR1RvRTVoSzUyMEM0TEZDRUFlTkxPM0t3QXoxMXpPektIVXln?=
 =?utf-8?B?bVNNR2ZMOWFRRnNCaFpzdVdHWFF5WVdzeFYyVHZZSnBqeG4wZHhZR1NFS0VL?=
 =?utf-8?B?dkpnSGszZGpza3hMV2pGWEtGK0VHd3BZcFFTMkFtbVRGVFB0Q1F0Q1JWMDFX?=
 =?utf-8?B?L2xpSW1PSC9tQkxJY3RJZm90ZTZ2UWhtYVFscGpYZVArZEhIRXorSmtnbWFT?=
 =?utf-8?B?STlzOHJ5K0tWSS9xVkNRUlhLbkduUWcwRzQ5QjRNUU56dFJQS1lQZFpMRzNX?=
 =?utf-8?B?OGQ4MFBnSHV1d2J4dnd1Qk5PS2NHaGh0UmpFVmcvRWlmYzlEd0RLTHlIcEcv?=
 =?utf-8?B?ejJ2MTAxQytrQUpVdkpUTXFCdmVzYUYvSXExYm96Q1Rzb0dtR1AzTGhzVDBC?=
 =?utf-8?B?VEQzNWw2a1B6S3RRRXZ3TzFYSWh2RDFqUGdJQlhEUnZiU1p1bG5IRlBBYzJz?=
 =?utf-8?B?Y3RLQllndWJuUEp1b0ZUNTRuaDlUbHFHN3VxRjBQZWgyUUQrN3lVN3RDWGxB?=
 =?utf-8?B?bnZZQWxHalBwODloYkFreWZvVnlOcDFCS2tLblp1aG9ySzdHdmFjTDk3WmZp?=
 =?utf-8?B?c3Y0L2J5NFNaS0FuQm42TFJIWTJLZE1OaHd6RnI5S21jZzhzak54NzdsSkJ6?=
 =?utf-8?B?YlFhSzBGU2VqeWFCWFhWekRTRTJRbW9nYUt4QU5NWjgrdVBaMlB0SHZ6ZDhQ?=
 =?utf-8?B?VmFqRk81NHBadnhOM2YzVVp1Q1J3Zm0xWUg1U0xzczE0L2lqb3hmNFRaZVpv?=
 =?utf-8?B?TElOMi9aclVmWm9RU0VzWCt5bGhwbkszMTF5UHlOYllyaVowYWpsVHBFbG9w?=
 =?utf-8?B?Sk5URHptbFJsWGpFckliY3ZQNjkzWnNKQnBJd0lFMEx2VDhwNzN1N1FUY3NI?=
 =?utf-8?B?ZEpLbi84RUFaN0ZPWEVZM2FWV0lQVEQ4ZEpqQzJ2MFNTdHpZUTU4T0ZnNXBO?=
 =?utf-8?B?QVZDbzcwSm52WDE2R0ROeU0wNU8rcFdnb3pTMGF3ZnpqWk1KTkdSZ0NKdzdJ?=
 =?utf-8?B?T0tuMThwTFFrektZdHVaYS9wak04eW5uMVF1MVdKcHB2WXM5aXZicjdxRElO?=
 =?utf-8?Q?E+0huRggWQhkhRYm1sBpg0iWG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GRrxQ1M6apWau7DsfoyvmOw2YeNdh3YHyFHMeJNyukJKPJ96XCcHLIEiDg2cEfbrwl0+IjfuiD/2ZWfsQsgW1K0sgcWTD8/1QXHlAUquzNJRuGR/5LPbKFOstvcvtWzMhiHX9PEKuJ1X3ob8A88MzgY21Z/yfnNLkNrdjgLiaUcLZyHDbkbA6b23GTT/gyF31cIDfmNKrIqhRSBOsm5X+Is38csGgdxAXX2eN8txygcfHM4SvF5tKgcvDpbwxTdUkcX86TSRB3KjfmMVNmwz9wAQLeHFlKRp8lIg5Ne38Q6qDfWcQ4LW38NbLTBVpHC78LGBZ4s6fCZa+avF4RjCpNUFO/O4xJ3w6awKAvI8dA7Vw/FJZO4T63hlvQLea+AQY8gBzahD6T+txQqJlGczvoEdG8X4bKogPMavPnfoqYeTcZQvu5Dv8TsGL2Kqu6WWoi4L7cChkNbQx2e/PKlNW71U7ocni6cjtULbNwsADE7UMPlFRjM6lpHDjKIuNr7nTNMDNfXfC0I03jmox1XAvkmz7SBBFkL/xHThIZkWG117lXHzDGMCIKZiW4PjTpLCz3pCChgCZlzsk23hTcYjXJKk4E/VsVk6btBGbMBv6qc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 059ba7c6-ee2a-4ed4-ce8c-08dc9b5a87e2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 12:20:31.1050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vC+qnXCq+/Cqd/Z41pLPel9NxfdNV4DUxswGBghy0MLK9YJoTs8gjtDhb7AJxXwWNHahagX0CM/ycG55k205kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7329
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_07,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407030089
X-Proofpoint-GUID: RgaRFvtjyI5LOE_psGmFNmIhupAlve7d
X-Proofpoint-ORIG-GUID: RgaRFvtjyI5LOE_psGmFNmIhupAlve7d

(trim list)

On 29/06/2024 06:07, Christoph Hellwig wrote:
> On Fri, Jun 28, 2024 at 03:30:00PM +0100, John Garry wrote:
>> On 04/06/2024 05:46, Christoph Hellwig wrote:
>>>> It also looks like a good idea if this check was just done in
>>>> blk_validate_limits() so that each driver doesn't have to do their own
>>>> checks. That block function is kind of recent though.
>>> Yes.  We already discussed this in another thread a few days ago.
>> Has anyone taken this work? I was going to unless someone else wants to. 4
>> or 5 drivers directly reference blk_validate_block_size() now.
> 
> I haven't look at it yet, so from my point of view feel free to tackle
> it.

I spent a bit of time on this, and the driver changes are pretty 
straightforward, apart from nbd.

For nbd, we cannot only change to just stop calling 
blk_validate_limits(). This is because the LBS is possibly updated in a
2-stage process:
a. update block size in the driver and validate
b. update queue limits

like:

static int __nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
		loff_t blksize)
{
	...

	if (blk_validate_block_size(blksize))
		return -EINVAL;

	nbd->config->bytesize = bytesize;
	nbd->config->blksize_bits = __ffs(blksize);

	if (!nbd->pid)
		return 0;

	lim = queue_limits_start_update(nbd->disk->queue);
	...
	error = queue_limits_commit_update(nbd->disk->queue, &lim);

So if we stop validating the limits in a., there is a user-visible 
change in behaviour (as we stop rejecting invalid limits from the 
NBD_SET_BLKSIZE ioctl).

We could add a "dryrun" option to queue_limits_commit_update() (and call 
that instead of blk_validate_block_size(), which is effectively the same 
as calling blk_validate_block_size()). Or we can keep
nbd as the only blk_validate_limits() user (outside the block layer).

Any better ideas?
