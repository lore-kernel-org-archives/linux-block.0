Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547A313DBB1
	for <linux-block@vger.kernel.org>; Thu, 20 Feb 2025 01:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740013492; cv=fail; b=KG5wuhTqv0KbxbVgAF24Ehq7n0OlwdhvXqNM8PX09lIw6/oHiL3jaeNAABljlZjMwxet9C/pZWm3vEcyDQAXUEW1P8a5ttuzNUobnuCiKjhWbq3Epi+30ryg9DgSA5gpQVCC2Je1Zb5W8fH9CJAC08I/ri8cKgjuZXzEn08TUSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740013492; c=relaxed/simple;
	bh=hGWifJBrXrgVrAhrOMCH4l+d8izYJPqKB469zIR5V/U=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KLPb2DzsO0TGDIvLSLUOUYX9wxbR7cBJVgbl+Ugvs0YbVkfiEALiJWaNEcseSerp7J8K2n5OEIvqKcwBYErq1ZnT3K88ox6uSsJh98U+/MedAHcwgajsNVnwUdMaEvJJGSWBFscbKWQwUengnQA8AkMJSGeLFbQuExlqydYH8CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WcFH9QQb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=llfV9btx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WcFH9QQb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="llfV9btx"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JMZY12029526;
	Thu, 20 Feb 2025 01:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=lbSVEcK2MsyHEwYVs8OOkLmE2lyyb2Nj9aFIfBdi0H0=; b=
	WcFH9QQbnopULbCXb8Kncwj0Rdl5AiA2pkcLyzWVQOGRO9ysfx5wW1ME3tEwymIQ
	euAlZZcsOpNMkGxdKMsa4In8dTz0R7nQje1Tp3XuUH3ysCqVVxW7nsKYvaoAgEcL
	kaZrT7iekcLFKqy+/s6oJep3AoQvLDo3H7QDPv4ZooMJW+fkOMA4pm+U+2+HL1kS
	gKGElw0vfqHBMDX+M+JmZkZIpQJr4AY0KU/qCYm4wLTLI486qWnQlzHMcoiqW+2M
	b5N6UrdjCf6OaPOmOgreR4+VvNXiwbonDA9PH8M2MpvbiI814JEW7YQjUguXKI0w
	JHBlgJkPyO5qsUygD2zljQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00nk43h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 01:04:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51JMkIu7026247;
	Thu, 20 Feb 2025 01:04:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0spra6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 01:04:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g37QUECLE4G8KK3tQaLQ//XFaVLdhW5yLYIAni4ySfJfFiYINdVE1K1Om66UY+KKrXTVsbpXXK1PjYmstfHPZprb5IgpLqbfqQTsQHZYxUnYQqmEqdgzswCRxoz+iQjSHunVGO+E6wdgTUqA6LOOV4Qyp7GJ93yeYd51VkpkKXFF7wqNROZ3kmfn36Y8DYqwHjIXzt8Nj+nr1H6a4oNSewm0wH3kWRrvMWuase4NqC/l55jeK5fB9QhNZfJ2d+D2/c9B3s40Z5Vc0+VcUITCiZgoyZq20imPw9VPRBSyS0AhSaIMN8fNPJYsyPX6USrA7fwBznk/VBZjtqXhz4wYVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbSVEcK2MsyHEwYVs8OOkLmE2lyyb2Nj9aFIfBdi0H0=;
 b=hM1GO1hdTh+Q1BPc/CYBHjeKgxhg7GNDCSp8YFNeOHfGAAy0DVlrGqRFrPT0eVnCVW/XV3beyl5jxvFp+1ycseay/ugy3m7hpY+CWjNz8FoUWXo9ARwdcyejd6TcVjDfBS/VkywXYX2bfrmo0PcriKCFKjzO+aePiKU9YI8noNeAyPPCH/MU3rez1nQzdNujTiKi2iGDbUGNTmq+TS7gViB00Ww/SEVjU9X+tJthwD2ijAX94liaPqkv7xutqMjznMRKii675OrCmZGXpQq0hsDPNAYvU8xVfNQFhaaxuDD51/RjVlb+FzvN5kvUCOcFNKfMjQkkc5nEgsB/k+uarQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbSVEcK2MsyHEwYVs8OOkLmE2lyyb2Nj9aFIfBdi0H0=;
 b=llfV9btxgsbEb7WLP8kfj/DhGvq5zKtZXayKtp8RBDEt0tQWNv3gPzGX1fRjxWCoUjUQ9/CmY42LyB/N6lLODtcNjXmWShSpv8ZRLe1XT3mIPZw1XkcUQB91o2+cb1cjerhdo7LPnRAYntZIpTC4pX9TnYYIL6Rk5RXDXc3L05o=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by LV3PR10MB8081.namprd10.prod.outlook.com (2603:10b6:408:286::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 01:04:44 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf%5]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 01:04:43 +0000
Message-ID: <b31cff79-cb81-4792-b700-b55a83637aad@oracle.com>
Date: Wed, 19 Feb 2025 17:04:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: cleanup and fix batch completion adding conditions
From: alan.adamson@oracle.com
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20575f0a-656e-4bb3-9d82-dec6c7e3a35c@kernel.dk>
 <y7m5kyk5r2eboyfsfprdvhmoo27ur46pz3r2kwb4puhxjhbvt6@zgh4dg3ewya3>
 <92239c7c-e7e8-494c-9bf9-59a855d70952@oracle.com>
Content-Language: en-US
In-Reply-To: <92239c7c-e7e8-494c-9bf9-59a855d70952@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN8PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:408:94::34) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|LV3PR10MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: 841aa5dd-853b-4fd8-c4a1-08dd514a8fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDR4RzB0UGhPUmhrQlZpNXM2N2JKM1JzS0NIYUlQQWxTbkRid2U4VTN0UFlJ?=
 =?utf-8?B?Nm5HejJsVmJjeWNsbTgraW43UUJOejRXejNYSmhKMWsxUWlLak16L2hsMG9R?=
 =?utf-8?B?VG1kM0dMOEZGMUttN21CVUtnWWVzejUwQmZxM050bWRFY2w0T0NROCs5UEVz?=
 =?utf-8?B?ZmVWU2RnbzVUMk9sQzJxd08wRENzQmhOQnRmanEyZ3hBaGkyd25FNVdWdWdQ?=
 =?utf-8?B?SHV0TnREanlRNmM0VFk1T0I2T25WQW9qeTA1ek9jaDhnRE5HOHNNcCtLNHAr?=
 =?utf-8?B?N2l5WG02V2pHQ29aVHNUcnB2ZVdnS0ZBdnV3U1ZLcUtja0ZjWnhJbWZFb1B3?=
 =?utf-8?B?RFVVb0YwMzVEY1hyVmI5TVZlenF1YXdTYzloWE5rZ0RySGNyZExaNWVMd2tx?=
 =?utf-8?B?OVFSamtQUjF1bVBJc1B1aVZOY2RrNkZiTmlGWEhuR0hETmlDNEp1d2M2SVdl?=
 =?utf-8?B?ZGNwTlZnQm9vS1RJRExSRExEOHliWFJweTk2YURGVUVXVENDUS9aYk53MC9R?=
 =?utf-8?B?N1M2WFNHZ3ppTTFSQ241VmZOcXRueGR6WERmSVJaeStCUGZYYTY2WkxMWEZM?=
 =?utf-8?B?K09NRHBEMFV5Ynp4NW14ajVsaUgzTktuNU1qKzNHQnlqSmpVUVRXb1R5aUo4?=
 =?utf-8?B?TmRFcDMvdFkvWVU2V1dHWnoyamZwTU1Rd1ZyanBUc1VvZW54QXVEbHhYUk9l?=
 =?utf-8?B?bEZVUFVWUkdCUVcrY2xMZHJZcUNrWjNCeU9pZytIMkFERWY2cTFZS3BhdHQz?=
 =?utf-8?B?OG16SnBJdlB5b2J6VXhRbDVjaXZUUEh0aGE1UkxrOVF4Y3FsUytsbG0zR0xl?=
 =?utf-8?B?VXdrL2NPVGJ5dm1tODl4ZXd1TWY2WHh4ejU0VEI2QXhrV3h6NTlVZ3NHTWhy?=
 =?utf-8?B?NnY4Ukg5QkNnRjdMUkN1UldnVFE2SXJ1cGwxQTlEUm1VSmNBSTVudEttYnN5?=
 =?utf-8?B?dmtIM3JnSjNiWnlENkRPRE1ObnpicWZ6WTVkTG1ocTNSbHhhR214ZVRTbS81?=
 =?utf-8?B?Rmx1aHl0V1pYWFRiUU9FQU5mb0Z2L1NnNUVQSTVDUzRZekRFZnFlWjNvNzBU?=
 =?utf-8?B?Mm9DcjZGYW9aVVphbHFFUVVjb3E0S0MrK1F4bDdqQTYzdjVkZElQd0NzOHp2?=
 =?utf-8?B?b0lJa1ZveG0wMldTR3U1ekhPNWpieCtpV25FU2FmaGpxSUxTaWw2R0E5dWI3?=
 =?utf-8?B?YnlybGRMellRK3cvTnJ5dUxMcDBSbWxWakx3N0N0a1pyWWlWcHhjTEhVUjYv?=
 =?utf-8?B?akRidERxQUhKZ2plbTAwa2dkQzJPdnBYMXJaZHc3MnJBRGk2VXVoL1RpTUYv?=
 =?utf-8?B?aFlycjFqY3NCd0loeW42TFhiNkhNU3BDNjM0ZGttejJjME9XcFdhOWUxVHY3?=
 =?utf-8?B?QXFhMGlzMUFHeDBtVTl3Um5icE9JazFzZnlYMExnTyt5N2d0Znlob1FrdzVi?=
 =?utf-8?B?K2ZpQStDNC9jSjFBU1ZzTzM1Zk9IdFlMNXZ6L2FBK1VENWQzZDlEQ00xdGc5?=
 =?utf-8?B?WWdWbnhuS014QThrUWUxOGdSdWIvTjlZc09udFlDNVFnSnRlclU4ZzNJSG5u?=
 =?utf-8?B?MzBaenpaNVFqRmhjanpzT0xqN2UvOTRCaDVmNGcxWjJKYmhSZm9ZbnJJLzNx?=
 =?utf-8?B?blBKU0RTQXJtbTNoQ05IVTV5RUNoRXNSNmpVTGZsVGRlbEdGcHVmeFlQbzlS?=
 =?utf-8?B?aVhjTkJHamdhZkhzeHBkYk1YaWVOZ2hLZVpqZUVPcFZiZE5QbjNiRWtpSWxz?=
 =?utf-8?B?UDZUTjdaZHNSMUNrWDZLQ3JnNkdRR0JoNkIrUDk1eXBTUjlvQVloTkx0VEI1?=
 =?utf-8?B?OHVWV0xFVmE3dGVBOXFKaWtUN3VzUEYvQ1lld1NlaWVLTFRnZHBqOXE5TTJy?=
 =?utf-8?Q?N2H7NRQ0Xi2jk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wk82YXFXa2piLytTaStKV3M3RGdYNkFkVzJWakZybmttUkwyaCtLOHpkaXYz?=
 =?utf-8?B?anFEbGtBRlhycVF1ZGJra0YvaUZxeHBhblNGbEttQzVwRVF2NEJ4SkZ0MTF2?=
 =?utf-8?B?bmp5VjQ1U2FCdlpPVEcyOHRuRnl3L3E1R28yV3lMQkx2NFUrWTlwMjUwZHdU?=
 =?utf-8?B?Ny8wZ1AxSStZdkIwTGJIS0hnRlZ2RWdScFltMTgvVm5BTEZkSk9LL1VZckRz?=
 =?utf-8?B?TkhRMGQ2QXdDenU0bzI2b2wraG5rbTJOY2pqMkQ0TDM1dUtSYWRwTlI2UFN2?=
 =?utf-8?B?UE5SRjhvRjJ0UXgzM3duSnVnaERXcjk5anF3NmloS2d3VkppMzgxenZkbDBR?=
 =?utf-8?B?a3Qva0FPc3JjL0M4OWIrSUxpMWdROFlSUjAxN01obkVNREhtYnA1NytLUGdw?=
 =?utf-8?B?YmNFN29aN1RSQWNWMmI4VmVhZ0lBTjdoSmxJcWxZK0doaGdhU3lCblFQUXhG?=
 =?utf-8?B?RjVBRGlhQms5UHMzQjAxM21EMTVrNUtLVFhjRC9NY2ZxYmhZMVhHME14ZHZk?=
 =?utf-8?B?d2t1QXowRFFiMnZtZzI0VWFqVCtKSFR4Z1czOStYdllteUUwdG9nZ2FhMnhE?=
 =?utf-8?B?SVYwTDg3aVFWb1VzSWRMYmorZFJ0aHcwdFVYNHVJdGlHWUE4YWxsRXVIM0J5?=
 =?utf-8?B?U3RabnZndFhESDk3MktGTm01UzZCK0xza2VrdEJuKzk5eHpHSkFWbVcvQytL?=
 =?utf-8?B?UlZhelRSM1h2azYwNzBoeGdUVkZ5cVVwcmtTMXAyLzljdXduQWJTOUhNb0NH?=
 =?utf-8?B?cXd0OVpoWkpVQkdRTUtkT1JRQVlORG1vWkE5OUtaS3FXYXJPTmdUb2V2RFVQ?=
 =?utf-8?B?eFMxdnA4aFVjUVU4NkxKZ04rNE83cGFWOGt5ZUFqb2tNTG00VFVkSE9jWVky?=
 =?utf-8?B?dE5vbDhmUnk4WHl5aWcvUERnYllnWkFrZ09TeHdmRCtjQ1Z3TnpNelpuSjN5?=
 =?utf-8?B?QzdFSjhoWTBPS0U4TmU2MWlqcUVxWFh0UHVYUUxrTVoyQlAvSkdjU25kdGFP?=
 =?utf-8?B?N3prVDBwdjNCU1ZuajQyL0FIZ3FmQTJQd0d5WFlQeVJQSjlHSStFc3hwb1hy?=
 =?utf-8?B?RExoNjNYaFlZYWVlUGdmMU4vWHRrTWd0MDJuaTFjUEwvMDVvM05YdUZpT0VS?=
 =?utf-8?B?My9DYm1pZ2tCeG93RXM4TjZZdHkvUHREeHVBU0VKaVFlUmpuMWh6Q0FhU1JD?=
 =?utf-8?B?UVZhZnJMZTB3TEV5UDZMdzZnQm92Y0hBNFRNb1ZZNDlvS0VZUGx5aUh2TWJn?=
 =?utf-8?B?VzRHYVd6UnRTU01wdVVGWWF1QjRzRVFhd3Z2c2hEVU9ocDZtbG55anBYRXcw?=
 =?utf-8?B?TWdTSXVmUWxBNFd6VHR0RjNYVkk3alJXejIrdXpiVm0zbU5kMmwxejhWK0Fs?=
 =?utf-8?B?OHRWbDV4RlFhUUNRaWFuKzkvNWl6VXE5M3VVem9MTnVrM2t1TkNaNUdBNDFU?=
 =?utf-8?B?YUFua3c2b0I2dm8xTHV5UU5xSnlmWUxhZENDR1FLS20vcVk5SDR1UHpIK2pR?=
 =?utf-8?B?dmtYTnJBaisreFg3c1JLbTJsREtLTGplK0pRSVlvVjFTbWFHa3NHN2NsQnU1?=
 =?utf-8?B?dzdqeTRaZ2IrSjFMem1KOTUyWXJISHA2NUpUWWljZkZrTGpsZDh3N0pQRith?=
 =?utf-8?B?VWpROTN1UmMrVklDMk1zWklaTUZQOVJCUUlHb3dhd2x0TWZ5c3FKM2xFbUtq?=
 =?utf-8?B?V0Q3czg4NEJLbWU5clRacEkyOXo2SGJVdkZmTHN5TlIxMlArSEk5UXhtWVR5?=
 =?utf-8?B?TEtjM3p5ZzhEK3A2L1hUd2I4bHhSb0hjWmFGQnV0QkFMblFoeSt2aDVPWFN2?=
 =?utf-8?B?ZVJnQVQ3L2FLYXFMREpnZTdjbjFGK0U1cVFaMytiNnpHM2JOTFI3R2J0Vndr?=
 =?utf-8?B?SkJsZ09va3hTcUxxeGtPbmU5SHcrWEw0UDZxakR3c1hKdFAvNGVzOStra1Bv?=
 =?utf-8?B?UEpLbjVma3dzWFdIUGNlaU1NQVJLcndEYUc5TjN4S3Z5QWlmOHBUQnVyTHRl?=
 =?utf-8?B?NTZHeXhlc2pyNWhCeVZFTXFpamlDaHIyTlROZjRXalB2MElPTlBsek1XZWNv?=
 =?utf-8?B?clVmZm5xQ1RSN2xWM1BNeDBtVExrdmo3STRPeFp5Q2p5M0R3TnNHR0hUYXlR?=
 =?utf-8?B?Y0ZVQzVRSWtLYmszQkFkQy9oVlQ1U3NDT1BFUS95S0dLbjJWdkhQTzJ6bUp0?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t0+N1v6HaWbNhRKctzs5p2jTb5ZQ4h95JeRCHwqDpyRANlP1pOwSz/ha5F8ZkpuDUadnAjePIpF8u0S2VRQEQ4N0+9uVq4IikBbhG7ZZRPgkUU4nXuYk0dNINX5XzORXA003mb5BDDJndytHM82H6sdCU8d5hqH7iM88Zq+1cpFD2cWFKvbLBb7cnX/OBo0mUmrXRsGxx2PV3/+X3gdbDp6/UI4FWO5QTDDn5An3dR26wPZnHz6WkytRHH6ViOfLotEiQdhFXQ2zNPXkJhfm9k09xNd3UTBfrh+15pKATWDLj4JXraVCai6JIS03g7JcLQ2/ctHRZG0Efws5oyKk3GKNscIQSaxqEP9SdcjIPsp2FKJh0V/NZsya3rq3Cc85lHTe1v0cM6AMzzWiB5seoF5RIMWJ3fh7Dcnnki4RxvqryrJRpmumHHTQIN75Zv5OG9Tl/w7b+cAKEaPeTru0bz4wy+mTTEeXwD/Wsvezdux0xPF6yIL+hE39bBQfZJHUT86ufjplGtMv4Mo5YV3eXRkEDN/jIFgxyoxZ57js1ozeq8cSxfp+MNvH3XRq0dRSMsv8/xIUs1HmvfuV3w8b0anPkk99QIfKLEi1JU/yGdE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 841aa5dd-853b-4fd8-c4a1-08dd514a8fab
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 01:04:43.9144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJMfoU8f1VrmGmWHoTDGw+mwNlR7L67aiuJawW1FUI5LFkQicu2w4XgGiPl9bnel6f486yi3uIPP4jc9pFuxqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_11,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502200006
X-Proofpoint-GUID: uUOC0YEPhOTHeCqUjKR0gNMmq2E699fJ
X-Proofpoint-ORIG-GUID: uUOC0YEPhOTHeCqUjKR0gNMmq2E699fJ


On 2/19/25 11:17 AM, alan.adamson@oracle.com wrote:
>
> On 2/18/25 11:26 PM, Shinichiro Kawasaki wrote:
>> CC+: Alan,
>>
>> On Feb 13, 2025 / 08:18, Jens Axboe wrote:
>>> The conditions for whether or not a request is allowed adding to a
>>> completion batch are a bit hard to read, and they also have a few
>>> issues. One is that ioerror may indeed be a random value on 
>>> passthrough,
>>> and it's being checked unconditionally of whether or not the given
>>> request is a passthrough request or not.
>>>
>>> Rewrite the conditions to be separate for easier reading, and only 
>>> check
>>> ioerror for non-passthrough requests. This fixes an issue with bio
>>> unmapping on passthrough, where it fails getting added to a batch. This
>>> both leads to suboptimal performance, and may trigger a potential
>>> schedule-under-atomic condition for polled passthrough IO.
>>>
>>> Fixes: f794f3351f26 ("block: add support for 
>>> blk_mq_end_request_batch()")
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> I observed the blktests test case nvme/039 failure with v6.14-rc3 
>> kernel. I
>> bisected and found that this patch in the v6.14-rc3 is the trigger.
>>
>> The test run output is as follows:
>>
>> nvme/039 => nvme0n1 (test error logging) [failed]
>>      runtime  5.378s  ...  5.354s
>>      --- tests/nvme/039.out      2024-09-20 11:20:26.405380875 +0900
>>      +++ 
>> /home/shin/Blktests/blktests/results/nvme0n1/nvme/039.out.bad 
>> 2025-02-19 16:13:05.061387179 +0900
>>      @@ -1,7 +1,3 @@
>>       Running nvme/039
>>      - Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error (sct 0x2 / 
>> sc 0x81) DNR
>>      - Read(0x2) @ LBA 0, 1 blocks, Unknown (sct 0x3 / sc 0x75) DNR
>>      - Write(0x1) @ LBA 0, 1 blocks, Write Fault (sct 0x2 / sc 0x80) DNR
>>        Identify(0x6), Access Denied (sct 0x2 / sc 0x86) DNR cdw10=0x1 
>> cdw11=0x0 cdw12=0x0 cdw13=0x0 cdw14=0x0 cdw15=0x0
>>      - Read(0x2), Invalid Command Opcode (sct 0x0 / sc 0x1) DNR 
>> cdw10=0x0 cdw11=0x0 cdw12=0x1 cdw13=0x0 cdw14=0x0 cdw15=0x0
>>       Test complete
>>
>>
>> The test case does error injection. Test method requires 
>> reconsideration to
>> adjust to this kernel change, probably. Help for fix will be 
>> appreciated.
>
> Not really an issue with the test, rather the error injector is 
> broken. I'll investigate.

The following change allows the test to pass.

- The check of (ioerror < 0) should be (ioerror != 0)

- passthroughs can also have ioerror set, so false needs to be returned. 
This needs to be resolved.


diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index fa2a76cc2f73..b2bd2ac40441 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -865,17 +865,17 @@ static inline bool blk_mq_add_to_batch(struct 
request *req,
          * 1) No batch container
          * 2) Has scheduler data attached
          * 3) Not a passthrough request and end_io set
-        * 4) Not a passthrough request and an ioerror
+        * 4) An ioerror
          */
         if (!iob)
                 return false;
         if (req->rq_flags & RQF_SCHED_TAGS)
                 return false;
+       if (ioerror)
+               return false;
         if (!blk_rq_is_passthrough(req)) {
                 if (req->end_io)
                         return false;
-               if (ioerror < 0)
-                       return false;
         }

Alan


