Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D7AEEB2
	for <linux-block@vger.kernel.org>; Sun, 20 Apr 2025 08:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745136390; cv=fail; b=bNnOek8gwl8zhzlVplkaZgFCIBEiitYNH30Adq/h/xvm88yF/mudiMRG9ikv0nVZ2q/6K0h5HL5Di3DHcJ3ibHSHiRQAbkI4fgDAumKPdnuHyGzAOJ6j7euqOXu3Q8RGqCus0vK7VHr6tZCQ4QFkYn5fXMY9z0SWkVySIPiqkiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745136390; c=relaxed/simple;
	bh=gTaZH/pPaV97xX4MobZ4yGozQPCZbqRYY1CkAlAKXds=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ekyYfVsCaNapJQzlvfE0h5vpIOOAVJirQmQNye62n3Y9AVuwEke7Hte0WTsIcABJhUaWAqwkc6l0daYwJhpVBqJlT6rHKuy5gIRGUKqy3aAGdSa4DLhWHU96dQbQGzEs9q6xEPs0q3NT9PFMQv+m5eJT7Q+iXMnTC6hcwlLJqXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gkVhuXO9; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gkVhuXO9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TrMyDNAEaYuHBI0c8uVaOLOraq1gEAzmEPuZOII79Wwf//OVQL0G7d7b7RKOTb7kl670kILiPTsYTTsWh/SDspfOuDFpOYFyCevsRdXHATnyUotJ/5kSFsJNo0okNMt+NF4prKXIP2DMw7lZPHwntvHyz/VUXxZ4yQK5Ozu4aH6vNaHREwI3g/sLuKLws4e3QtRye2ma6NoMc/Pj5ofh0SnuCKTyNJ0gcU18JqdnOTB9U2nNlI7I3nqbN7ZlmqlT/wZxLZLy/EYtgTw3rTA00EgWfNKQFVs87pjpFW3BdmWkm/CJP9wYnAbXoYJe6V4k2BMOH1jUDKBAxY+OeOcCkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrMmm/aB5YUi5/XGKO470crnNY6sOSK4KQQqtzodHmQ=;
 b=m5aMzoT5Wh0878tikzlxKAc9TH1RrzB2s8r7DX+ZwBxqAjRNAIRrXWH1+mfpZh8iIPUh/Ufq5NVFd5VGxW4uY4+Mzs3aA+nLhexZG3eK+eNYKANm35WZir4dCPgUAS6reIjOv6lfJROo9h1jSiOYx9GMfS8HmdEs4C33+RMCe+08muqStj9BHn7WRI8csYYSLkQZRH1r+TZ+qWjmQmGqFbYIRyRqO79uCdd5gzdUEbfsm0K1BViRrYSq8hfep9gQTuPO/MwrLBPpjq6GXLeCNZDsjg0eL/Rsqkuzll14oAi9nxPNW7WA8aIn7fSaa6WCuIRPnGIvv/0yrqTPh6ikjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrMmm/aB5YUi5/XGKO470crnNY6sOSK4KQQqtzodHmQ=;
 b=gkVhuXO9CczYA0ecfXSlTzyvgvOa1c9Vdq/3nuYPytH6guIJMBaCgzSQwMvLdd/xEEjCyqxsJf0Ekk0ide6g+b/UCSDqIXAEnbt3G0TwBv6dqtxd3yeArKDdSyOWJuwG53vzeaV2XfazJ2/w7T//YldKa2gracNJX1ZjRopVU7fimA+e7h1iRBLdSQEVCA1VJ/ji2mDYco/WZ8b5Mt1OxP56Q7CIen/+aFK0FRFE1EKkn+PWqXhetIbn6ieLxb5T0c1H61j9d6H2PZK98a9W9XNV6NPjnf2kcCqxE9dnVfH8l6aCw3joWiFr1ZyFiYlBO7D2CjBqouBNuRMylXVZ2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Sun, 20 Apr
 2025 08:06:24 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%3]) with mapi id 15.20.8655.031; Sun, 20 Apr 2025
 08:06:22 +0000
Message-ID: <26675f4e-07c5-4a76-ba98-463c5bd0406c@nvidia.com>
Date: Sun, 20 Apr 2025 11:06:17 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4]: ublk: Add UBLK_U_CMD_UPDATE_SIZE
To: Ming Lei <ming.lei@redhat.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>, csander@purestorage.com
References: <918750ec-42e8-46d4-bbfb-e01d3dce6ed0@nvidia.com>
 <aAGQLYDOFY5PyUMJ@fedora>
Content-Language: en-US
From: Jared Holzman <jholzman@nvidia.com>
Organization: NVIDIA
In-Reply-To: <aAGQLYDOFY5PyUMJ@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0024.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::8)
 To SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|BY5PR12MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b9cdc15-c042-4276-6f21-08dd7fe23d2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1hJc3ZFYSt0MlVaaGE5MkgwdlRiTXZvSGJDYTMvZmZLajZKYUZESkQ2bEN1?=
 =?utf-8?B?aDF1QThDT2F4MUJXQ2ViRnU5dTF2aVgrdVd1SkJtREtPR0ExTThUVldRQ2tl?=
 =?utf-8?B?cnVSaHZ6NkQ5VCtCb0JlK3g4enBOUnhpL2w2RytKT3VxQWtQYUt3ZVVhRjdV?=
 =?utf-8?B?MnhtVk1SK0NKODBjRjFjaWE3endvU2dwdzUvOW5jQTlncUlFNjYzWVNrcUpH?=
 =?utf-8?B?R1lzUWs4UHVTL1lPSDBzRW1GeHBCSG1GVklaZmkwRlAxVDZaTm9ZWVB2RDZY?=
 =?utf-8?B?bkFMQ1VSTVZuM1plN1NDWTFMTjVpZ0didkN4UUhuRXRXU2FFeS8yNHlySHJX?=
 =?utf-8?B?dEwrbWZTOVRseDc1YUZwVlliNlJpbG9JN3p0eXZxRFZPd1ZCY3MyMDBtaVZF?=
 =?utf-8?B?SEY5c1VZeWFEMW1RNTcxaG1BUjNkb0pUTEV6c2RoNlFLRzVvVUt1c2liT1BC?=
 =?utf-8?B?R0RvdGJwY1laREpzTTZSZElSVWorUTJhTkJvcnY0ejM2aVBhY0ZrdmZuVFJk?=
 =?utf-8?B?dytSQkpkVzdaZURpRitQekM2emxheGpHK0VJKys5WFpJYnM3djlXazZrMWti?=
 =?utf-8?B?TXJ0SjdtMExiUWtVTFk5VE9RanAvVzQvYXZyMGFLOXpqWWxxeEZOMVN5R0Zz?=
 =?utf-8?B?a3lZSlc4Q0lzNmpYY0pmeStTL0p6S1JSVjlpWDJaVnlsbVNQMTI1RlNiMFZV?=
 =?utf-8?B?TkFpSzRuUHpJWDBuUXNnQmp1VGxIcGZNVFVnelJ0NzdVM0NNSWEyMUVDVzdz?=
 =?utf-8?B?RmNYbkdybG1OTVY4cEIyVHZLQ2N4TmNyVThjSDBYRU91Q0xTUzZ5dHV3dXNR?=
 =?utf-8?B?VzcrRTR5dUd1SDdoaU9LUVBLdll3YnFIUkxSVnRiRXo3bHYyZUN4V1dmWG1i?=
 =?utf-8?B?QU1hbXhFQ3ZiZHVHN0VzaDRpa2t1UHowZ2FFUDdZb3E5YzQ5N00zMEhKOHhS?=
 =?utf-8?B?WUNKR2luYS9XZVFSbXYwenl4cXFJMjMxRENrZHdJWCtXcExqOXBTWmFGS1ZC?=
 =?utf-8?B?cHNrZm8vOFNmTWxOVWRTaHdhYVVxckJ4MWpWV3VMMC9FTXR2OUJMeDJPaXpZ?=
 =?utf-8?B?MHVUUXdIdkdFaXVTZUtHYzdTaG01Um5TbW5wWUU3VlpOS0ZFK3hlb0h5NGJO?=
 =?utf-8?B?bHh0U1FheFJnbkZ1NTE2VWpxYi9KZ2xlckV1Vk1JcUQ2RWlFYmpTN3h4RlVs?=
 =?utf-8?B?OWZURTk1Vm9JdzZrN2g1WDVNUk44UElWRUQzOFluNGV1VWRNZUd2ZGtDODM5?=
 =?utf-8?B?N0tjMUZGeVU0cnVmcW1HNDhaTFdGTkR6TlZHVDVXTzYzZDlZTy9yTGZZc3hp?=
 =?utf-8?B?NzlPVmtIK1hXTDVCdHdzVTRlcFZRNFpDQ2tyOFlrdC9rQ2E4U0R2ZGF4REly?=
 =?utf-8?B?NjRWck1FdzV6TUh2cGlJNjErL2w5VzduMWZwVllWelpNaFo4bFlRbDk4STl2?=
 =?utf-8?B?d0Fqdlc3YTlnUnRjWXVFcnJ0UEw2aE9BTjkrYWwvMzlmdW1ObGlLOWM3NllY?=
 =?utf-8?B?MTU2RExPT3B4UUhwYjZkK01tTDdoTE0zNDh6ck5sVk9EM3psMk4wWjRWVkpx?=
 =?utf-8?B?VTBwSzUvTUpuUGJmdW1vVHo0eVNPNUkvMW5ra0xDakVTTzJVSVlBa0pEMS8z?=
 =?utf-8?B?ZURXd2hhSkpHUFdFUzBXY1NNbUtNa1lNU2dZaEE4NS9CUlYzV056SkZkNUxx?=
 =?utf-8?B?TXFJekgvMm03NElTeGZwSjZCRDA4dHR6TmhsN3BRSUx5ZGp4MnZvVlRJNThm?=
 =?utf-8?B?L1VRZURRZHJUSnRLODVaSXZBa3QyOEFPYmxFVmtiUzluWlZmaldRYUF2UmlW?=
 =?utf-8?B?Qm51Z1dmV28xOGFBRU92N0dUWDBPbjJoZHc0STd0Y1Ywa0orUlRZN2E0WVRp?=
 =?utf-8?B?SkNZVGIyV3FuaUNFeitFTVdaeDdJR0pOMUkyZE82cWdXTVd3dEdDSGhhVnkx?=
 =?utf-8?Q?OTZyQw9S4Ks=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTZ6VFhDMUJobjJSd1QweGZlNHZvSTdPTUVYK0lqWWVEOHo4WUM1WXNXV1Nr?=
 =?utf-8?B?R0VyUkdzRDBRSjdjNlh3K0JPY2pEY0RwS04xVUhhdWR1SURGaG5vUXl2ei9n?=
 =?utf-8?B?a0hJUlpnMWN4bHNkQlpNNUpnN1p0OWcxV2U4OVpUcko2cFVwb1B4M1hEdlpJ?=
 =?utf-8?B?RGVkdG1sSHMrSGhVRHpNdzdWL3c3QmpYVFh6eEIza3JVSXhlZHpzNktpYmsr?=
 =?utf-8?B?MjZNazNZT3dYZzNwTkFOR1R1YUJLTlpSRWhXZFZFSmViZGpvejUxaGdEdk9W?=
 =?utf-8?B?clF4RXY2VXQxSS8wemhxQ2NudG5xZXJxckRFSEJDdUIxTXVKYVhOTkNtN3ZF?=
 =?utf-8?B?YldFOWJHM2JGUDVBYXdNVHVqM1NKYXZldDJNMGxla0FUdWtGU0hYc256VWE3?=
 =?utf-8?B?aEdBU2RsVVZ6VFFjL1pvam9kM1pXenpPVFFNQ1FzdjZvWmFOSTVidzIxdlBF?=
 =?utf-8?B?eEl5Um1IZk05MmhTbjFxTG5sR05tbVFGUjRUanVJd2VwT2FnYmNJVmFYK2VT?=
 =?utf-8?B?OXVtMzhDaG5pY3dQQURra3NiS2tiLzB3ZmNGNGkyZ2p1ZjltM3VDOUQ1OXFh?=
 =?utf-8?B?Sy9CSnpmN1JucVNDcFJmUm9iWFhzVlQvSlgwL1h3dFdXTTlaOGtSbGhNc3hM?=
 =?utf-8?B?NlRDbk14N1FuaXo5Y2YwYVQvZE5iZUFQYzNjRDZuT2ZqU3gyYnZiWVFCa2t0?=
 =?utf-8?B?Q01iV1grOXRyVEd3RE4rMmVRWjVabjliL2puN3c0Z3lTZDhLZ1UxUk13YktW?=
 =?utf-8?B?ZEJzbXZJL1BOZWRHVWQ5YWFTblJKc0FIdmRSaTNIVXN5T1dSVG1PN1EwRU1k?=
 =?utf-8?B?ZW9XbmZyUTRiUzZ5TlFEc1RZU00zekR0cWlNVmRPdHJFNmxzTXJaM3dPeC9a?=
 =?utf-8?B?NnY5UWl1K0hhbjJPbnc2MDlER01vdWhFNFplY1B0NTI5Z2g0UnRoSmxJTGZ6?=
 =?utf-8?B?cUN1K29odFZJUHhtR1NnQ1RUZm90bVE5QzZkSFIzY2RNZ1NXYVVmdVk3UVVn?=
 =?utf-8?B?ZHdQZ2RwdXhXRnZtckMxSTNQSTg1Q2o5S000dzdhdXBsSFhqaGZSNWFJTVE5?=
 =?utf-8?B?S0xnTm1MTWl6VlF1WDZXbmFpMU5iOHhLRUZ2dzdxNDNYSUFOVjhKZVYzaENr?=
 =?utf-8?B?K1R3dWZiUHVKYzhCZ3BnaXNsSy9PRGUzN2txdi9idW53T0ZBWTZ6MXR6WkFW?=
 =?utf-8?B?eTFBTVJabnUyUDZpdmlJMlV0cStsVjJFS3JKSTI2a3VaUWdoWVJxR0RlNmdv?=
 =?utf-8?B?ZFVOSTJtM3lvMENkTThRL0RiejRlYUxMZFd2bElhMjBsQnNkMjlwNmpHTjlL?=
 =?utf-8?B?cTNiNnRUUTk0OWtKRS92T1ZaME5wWUNEQmhOQ2hKd0c2T3VYZ29UMlpoVmU2?=
 =?utf-8?B?d0Q3SUsyTFlxdDJMV1ZzaHp3SzZaQWtVeCthSklYQU92Nm9lSWlEdGEzM2JE?=
 =?utf-8?B?VkxYMzZWS1c5aTFtenhvS1h6eUR6eDd2QTVkWFM5WFBzekdKK0RuTFh2Si9l?=
 =?utf-8?B?Qjhqb1ZsL09vOXJYUG1sVEZKTlFXaEtIRGxzdDBPNjU4amVEeTRRU3ZFZGxJ?=
 =?utf-8?B?MFR0dldEQkVleEJ4RnVPWDQ4dGhFMWcrMVk5QzlERWxIVFZvb2RDU1hJOEJl?=
 =?utf-8?B?Zk5Zb0w5ek00dlNSOTkyb3RoK252Y2ZSeHFOS25DdG5XNUg2SXJLSnpJN2sz?=
 =?utf-8?B?V2Y4QjFUTGVJbE5sd0hHZi90OHpPSCtoZmZCRWMvM2JadmlaZXRwN3ZUMytT?=
 =?utf-8?B?NnhmMEZZeHVjOHpEWXV2aE9ORXJFeE9BS1pxb0NRbHpYcEZuRDVPL25iTTJ4?=
 =?utf-8?B?NjM4ZmdXbU93SjJ5Ym94aUoyM0R1TUw1cnUxbDNGMkxsQTdFZEtyb2VmTEYx?=
 =?utf-8?B?VDhFVzhiUHJpdFJGUDNLSXFOejR5UkFtV1UxQk1hV2lrOXhMSWpjL2x0bWRL?=
 =?utf-8?B?QVRhVHRYU1JVNzFPcUdWYUVRcHVwUURlc1lMOFUrYUgyMDI4TEZiSUVjQmJv?=
 =?utf-8?B?WjE0K280Q25tQUJyZU1iUW5LbUtVTHBuTGN3RWUrREdhZklmMXh6Z2YrN2x2?=
 =?utf-8?B?bmRaUjdYcFNlUFkwenpzYW9WRWtVVlRHQlhieGhudkkybGxtQmlnZHJ0R2l3?=
 =?utf-8?Q?Tu1aR8eLxv0fIljQrK2wqZoSa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b9cdc15-c042-4276-6f21-08dd7fe23d2e
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2025 08:06:22.5604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ves+s8zFq6GkRVNod+0l08EMQasVVb6zFiR80J0mpTPVqbafuju62m62/ZNZVDOM2T9C2rDDBlrchoFhJAFrlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210



On 18/04/2025 2:35, Ming Lei wrote:
> On Wed, Apr 16, 2025 at 01:07:47PM +0300, Jared Holzman wrote:
>> Currently ublk only allows the size of the ublkb block device to be
>> set via UBLK_CMD_SET_PARAMS before UBLK_CMD_START_DEV is triggered.
>>
>> This does not provide support for extendable user-space block devices
>> without having to stop and restart the underlying ublkb block device
>> causing IO interruption.
>>
>> This patch adds a new ublk command UBLK_U_CMD_UPDATE_SIZE to allow the
>> ublk block device to be resized on-the-fly.
>>
>> Feature flag UBLK_F_UPDATE_SIZE is also added to indicate support for this
>> command.
>>
>> Signed-off-by: Omri Mann <omri@nvidia.com>
>> ---
>>   drivers/block/ublk_drv.c      | 18 +++++++++++++++++-
>>   include/uapi/linux/ublk_cmd.h |  7 +++++++
>>   2 files changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>> index cdb1543fa4a9..128f094efbad 100644
>> --- a/drivers/block/ublk_drv.c
>> +++ b/drivers/block/ublk_drv.c
>> @@ -64,7 +64,8 @@
>>           | UBLK_F_CMD_IOCTL_ENCODE \
>>           | UBLK_F_USER_COPY \
>>           | UBLK_F_ZONED \
>> -        | UBLK_F_USER_RECOVERY_FAIL_IO)
>> +        | UBLK_F_USER_RECOVERY_FAIL_IO \
>> +        | UBLK_F_UPDATE_SIZE)
>>
>>   #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>>           | UBLK_F_USER_RECOVERY_REISSUE \
>> @@ -3067,6 +3068,16 @@ static int ublk_ctrl_get_features(const struct
>> ublksrv_ctrl_cmd *header)
> 
> I try to apply this patch downloaded from both lore or patchwork, and 'git
> am' always complains the patch is broken:

I think this is because of my workflow. I cannot send email outside of 
our network using git send-mail so I've been copy-pasting the patch into 
Thunderbird.

I will try instead sending the mail from git send-mail to my account and 
then forwarding from there.


> 
> [root@ktest-40 linux]# git am raw
> warning: Patch sent with format=flowed; space at the end of lines might be lost.
> Applying: ublk: Add UBLK_U_CMD_UPDATE_SIZE
> error: corrupt patch at line 11
> Patch failed at 0001 ublk: Add UBLK_U_CMD_UPDATE_SIZE
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abort".
> hint: Disable this message with "git config advice.mergeConflict false"
> [root@ktest-40 linux]# patch -p1 < raw
> patching file drivers/block/ublk_drv.c
> Hunk #1 FAILED at 64.
> patch: **** malformed patch at line 192: ublksrv_ctrl_cmd *header)
> 
> Please use 'git-format-patch' to make patch and run `./scripts/checkpatch.pl -g HEAD`
> in kernel top directory to make sure no ERROR.
> 
>>       return 0;
>>   }
>>
>> +static void ublk_ctrl_set_size(struct ublk_device *ub, const struct
>> ublksrv_ctrl_cmd *header)
>> +{
>> +    struct ublk_param_basic *p = &ub->params.basic;
>> +    u64 new_size = header->data[0];
>> +
>> +    mutex_lock(&ub->mutex);
>> +    p->dev_sectors = new_size;
>> +    set_capacity_and_notify(ub->ub_disk, p->dev_sectors);
>> +    mutex_unlock(&ub->mutex);
>> +}
>>   /*
>>    * All control commands are sent via /dev/ublk-control, so we have to check
>>    * the destination device's permission
>> @@ -3152,6 +3163,7 @@ static int ublk_ctrl_uring_cmd_permission(struct
>> ublk_device *ub,
>>       case UBLK_CMD_SET_PARAMS:
>>       case UBLK_CMD_START_USER_RECOVERY:
>>       case UBLK_CMD_END_USER_RECOVERY:
>> +    case _IOC_NR(UBLK_U_CMD_UPDATE_SIZE):
> 
> Here it could be more clean to add one private definition:

Will do.

> 
> 	#define UBLK_CMD_UPDATE_SIZE _IOC_NR(UBLK_U_CMD_UPDATE_SIZE)
> 
> just like what we did for `UBLK_CMD_DEL_DEV_ASYNC`.
> 
> Then use UBLK_CMD_UPDATE_SIZE directly.
> 
>>           mask = MAY_READ | MAY_WRITE;
>>           break;
>>       default:
>> @@ -3243,6 +3255,10 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd
>> *cmd,
>>       case UBLK_CMD_END_USER_RECOVERY:
>>           ret = ublk_ctrl_end_recovery(ub, header);
>>           break;
>> +    case _IOC_NR(UBLK_U_CMD_UPDATE_SIZE):
> 
> Same with above.

Ack

> 
>> +        ublk_ctrl_set_size(ub, header);
>> +        ret = 0;
>> +        break;
>>       default:
>>           ret = -EOPNOTSUPP;
>>           break;
>> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
>> index 583b86681c93..587a54b3cfe1 100644
>> --- a/include/uapi/linux/ublk_cmd.h
>> +++ b/include/uapi/linux/ublk_cmd.h
>> @@ -51,6 +51,8 @@
>>       _IOR('u', 0x13, struct ublksrv_ctrl_cmd)
>>   #define UBLK_U_CMD_DEL_DEV_ASYNC    \
>>       _IOR('u', 0x14, struct ublksrv_ctrl_cmd)
>> +#define UBLK_U_CMD_UPDATE_SIZE        \
>> +    _IOWR('u', 0x15, struct ublksrv_ctrl_cmd)
>>
>>   /*
>>    * 64bits are enough now, and it should be easy to extend in case of
>> @@ -211,6 +213,11 @@
>>    */
>>   #define UBLK_F_USER_RECOVERY_FAIL_IO (1ULL << 9)
>>
>> +/*
>> + * Resizing a block device is possible with UBLK_U_CMD_UPDATE_SIZE
>> + */
>> +#define UBLK_F_UPDATE_SIZE         (1ULL << 10)
> 
> Please document how size is passed, and the unit is sector.

Ack
> 
> With above addressed, this patch looks fine.

Great. I'll make the changes and send a new version. Let's hope it works 
this time.
> 
> 
> Thanks,
> Ming
> 

-- 
Jared Holzman
Senior Software Engineer
NVIDIA
jholzman@nvidia.com

