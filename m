Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A641FA171
	for <linux-block@vger.kernel.org>; Mon,  2 Dec 2024 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733135031; cv=fail; b=rmlioPwBz4dBtaw2jOhu8P0oqupDQvaGU4rwjZWte+i46CahakbdxfVDvVf7yPgGuZ9cvuGGEk1RAVeBtX6qS6G47naJMeiRrmML2fOmx/JqPD9XvRRh5G0LvEW5LSI/RtE0Z+zmoHUtJBOA4Ob9lFJ/PWc8hnnZAaNUKNns0xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733135031; c=relaxed/simple;
	bh=B8FKnD6EPWd0eT+hbHU/qe7uPOn4fL/sndjGidbfCTg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=qjIkAXlB5/RZmkjGR9yJcMiTkrGeB13n0UJvoea8Zy7Xk7j0Wcn2Q9aKe5ZBWJMRKfAsJ/tCJaCu/GDqpY+IiZPSaXK8AebFHXNn4C/rgr5ux2HcW5q1n4YeRplXHq4bOVGpSi7Rp3R9vhkHXNTBDbLvwL7P6RX6Urk13Lk+Lj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DbFFqT//; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DbFFqT//"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzDzyHwTy1pd3YDYCDkkMxSXp2ztDo3dYxcNKETO31j8sek5k+r0VuU46wAP7cO2sHCiZ9/w6gN0bYM+Mi+Xwn0JmU4pnBha79Cdu9H7inkdHb8OTHpyRpdhXxNA/VseGZKwwMq5rHGNgTDodzk+p8og7Ps/kNFjR7FH2Ajq+pbiVJ7Z47ZoUd7tm+vTPI0vfvGPTDAupHOnjyrR16w0dktuv6jeA4k0P4tgEpfBV88jVXjxc4GagftBrrOMahow32T4rHvHJE4GY2eiDnLL2/GTqxhDIbbZS25id1q7K1aWfi3cXBlmJDSxBkw0OWty8qiD+gE2e6VYu0IcXd3kNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQzdUBzng1g8VNKfahIKw9NHt/vst7Ys+ypvLQ5/L1Q=;
 b=Xf9mZwqiWjy8zdZ4hne+OmJx5ThCGq+koAhivpFVnA0U82qx4JpCly/DUfXhHMhTuArLZgtWTtaY1XpG0DqeNOZvev3M4lHjIc3w0RISYOxWh8qj8wVQOtJ2XaNllPU6epnfI+c/HaOTonESfq/U6cghohu3sevNY14fzEMEfAszGDEi8mm0WOB+5M5kqSjp3wvsBU4xeOWbo8YhzRjrM0kWFBEnMrjV5GD5ykCKRkCGiZP1qSk0hFiXdvirP3zhVVT0mpeuPrX+eV8ABikDoKVSVjI/v48pJJ7BSgWobH2OzGgd63J9R6VlejtJolg2ihubqsAMguufg0spOFVbNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQzdUBzng1g8VNKfahIKw9NHt/vst7Ys+ypvLQ5/L1Q=;
 b=DbFFqT//cImozqQ5WS2Qz+5EYz+NtnK1bnMOY3nDIFwKIz3xseeS7yloHKAbPhletCRMjQwSAGNRsONO+Hv4TujA2TX1Su1GEl1xKOPQdIwBfLoB8Pe7mD85W0ZXEL9w6Hk/2XrsXEsdtFMrAKXsacjtGqOm9VukIZZ8KrajHFUeG1Z4IELW/c+NclAvVGwoOHXTG1siHk1H5I1WQl7VzAflBzdg3HfVbDRn/V7IvT+u8lyB6v9tFPPSVamUXSZVKSk0/ZphSw8+BQW1NQ2BJ6Wy7a6NtWcgLGxkd8y++Er7yb8Z7BhYDvehkhmlyMqchgucpw/WczRJiSG100rgfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYYPR12MB8940.namprd12.prod.outlook.com (2603:10b6:930:bd::17)
 by LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Mon, 2 Dec
 2024 10:23:45 +0000
Received: from CYYPR12MB8940.namprd12.prod.outlook.com
 ([fe80::49b0:41bd:54e0:cce7]) by CYYPR12MB8940.namprd12.prod.outlook.com
 ([fe80::49b0:41bd:54e0:cce7%6]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 10:23:45 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Daniel
 Wagner <dwagner@suse.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, Shai
 Malin <smalin@nvidia.com>
Subject: Re: [PATCH blktests v4 1/5] nvme/rc: introduce remote target support
In-Reply-To: <ghcsy46j652pvawoikkpym4buqo2hmimrvxrfnetlmqjnkvxr2@kncqoxdc77zi>
References: <20241126203857.27210-1-aaptel@nvidia.com>
 <20241126203857.27210-2-aaptel@nvidia.com>
 <ghcsy46j652pvawoikkpym4buqo2hmimrvxrfnetlmqjnkvxr2@kncqoxdc77zi>
Date: Mon, 02 Dec 2024 12:23:41 +0200
Message-ID: <2534j3mv0wi.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::18) To CYYPR12MB8940.namprd12.prod.outlook.com
 (2603:10b6:930:bd::17)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8940:EE_|LV2PR12MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d51a423-aa93-472c-a745-08dd12bb66ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uk0cH0t8thBiB5luiC1jDQe1oYTvgL9KugzOUCexWEy/1g/1t4+r7j+S/210?=
 =?us-ascii?Q?XfYseZw74oMxMo/5vrr/dN8MM1+MTYeaHdzpt5b0RI7nk99ByrgXAk+yi4E1?=
 =?us-ascii?Q?y+kEd5ti0zydeZKafY7r8RiAaU2oDW35yO1wHeHCiGqvrBEQuvFhgOIY6P0R?=
 =?us-ascii?Q?AIvI9/39pcYh2eNnyEmJ9Gi4tHHV48hIH8gtNu0hnhThMRqeaz0CiI1EvB4i?=
 =?us-ascii?Q?h27O+XrLL70lSmz+ZcC1N5xbK265PTmFPO/z26dnf6fJZNIRBHj1lI5KK19G?=
 =?us-ascii?Q?jc+EhpnWvvBS43aPfpOnGJAvtvrXhJeBIUYXxB8M6IiW37LYVgWvWBrI8IOc?=
 =?us-ascii?Q?WqAxjZ8UJqVEXOAof/hqyMwFnpgb1JMt4RxOUgcJ97TFveuzfIo+WAjH56v8?=
 =?us-ascii?Q?v7eAwzhfeD1Bhb6a+VjN4A/E5zywA+z4Y3dVprWbKCWCL4JPCK5JLvJ4l3Rf?=
 =?us-ascii?Q?orBCwOLw1eMteyFIbTddHetEgzVry9jq6JKb5q4lic5GawtN6PduqJTIYvXr?=
 =?us-ascii?Q?PJZa7/hha2aOGptsriP/iUrkBLGzF0+bTf7xGAJBCHWjU9b2QFvlJjpG5mav?=
 =?us-ascii?Q?mjxCb14b1J3Kz410Ij44mlXXZglAlpvetpUEaGZ0qj86XvSS7+Z04o8VHkCv?=
 =?us-ascii?Q?pvDmWZU4rP0SPYY71b90KHPdG0xk8Tag2DsPZKXn9sgJbjgbHvfCRBjs3cFy?=
 =?us-ascii?Q?uHaAU0SDBMtH8QaYFKqPsgbtfgFwXXQB80s+WsV4HKL512lHcn6WvCd/HjnK?=
 =?us-ascii?Q?xukYyNHrpEfahpKZShm8EyIGzgEmeRSyPuhXHjKfafozkkJipVaBkEjhUjy+?=
 =?us-ascii?Q?QXbpdii18wtIABKCND6q+tj0fvJZqybacz2SW42z+YJH6RWyPo8G90rH5K4t?=
 =?us-ascii?Q?dRtMvSdvdC6rfSpJ3HVV96TKdC5OB2yedzze8p8fg+SNl7RQsSvCDPmf39zc?=
 =?us-ascii?Q?j2jy97C1S4ZAoonCzUUf3emzJjXveu47IBPyxQCvMLD/wbhUVz7HUYUxwKuu?=
 =?us-ascii?Q?ew3MaCogYBgnOeVj6Yfof5TshQeywTXC0IU3u2q1vsEmxDrP4UxpkgedoP7f?=
 =?us-ascii?Q?Lb95F5fXzuSFhpK3HU8ChAkpzbJRV88JUrzmBFw8iXuM+Tncf8AjtC1LWAGi?=
 =?us-ascii?Q?FY9lpWWiV6balRjExne6oTI66Jkm7ppf1+GB5YpkoZ9GOjXXc+hrigIvlaoM?=
 =?us-ascii?Q?CcN3MVeyQdrgWAx4hBDDreQUw7M+MSTZzH2m6pnRAaQE2eqsgRSpa079eRT0?=
 =?us-ascii?Q?kR6707AdZoYY2yULaK5neSeu3SnYGOg7L1JWS0Ez+ExmHdgkdHUNUsfAS9SN?=
 =?us-ascii?Q?pEOvHm5BVA3vOxpshgmenxdLYqvTRyCdBL9Kxuiglr/Zpg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8940.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W2RjuErrD8MyLRwLJXcNt1ZUjttM5o8CzLlA93gkbYJikY8N/rgLfEbA8VOf?=
 =?us-ascii?Q?KbOcY7ZtbzEtE8RG1zmoJl5RKlHOu0kUOfzh4pCtzsevqxHT2fvqMkHNszyx?=
 =?us-ascii?Q?+/I0zQxuIUQw9iVo+2iJZpOgHbUe//cJoSkaoq05204rGaJ771bqcgNfUWTW?=
 =?us-ascii?Q?VD0OkyxIo6ZAdX0BCpDsJJLn2dKHqWy3ZM2djCSdxFKqDNJdgLM+jUeZPyPG?=
 =?us-ascii?Q?oPdiGwpikcVVBo9mt2RF8/rWZTShQK2KV9ck/punhsnx+BXsXLvNOohaMNsg?=
 =?us-ascii?Q?3tM8eecgVncmq6olL03450A6Xyyc3y5fI3FyNYi7+WFY1QKPOg0goNGZqhw1?=
 =?us-ascii?Q?fRCzGMP9Rlp6Gk4GirT39/dowUbbJdXO3kILlW4fJrdSvmoqs4/++RcEBP6P?=
 =?us-ascii?Q?IpyiAzRjTpsOuumhGy+RpTMB4s3hG1ta2ewlvLcKPp5yBJMZrYg4PFudk3oK?=
 =?us-ascii?Q?4K9JH7YRFQNv8l4LoYb3AnZKqH+rSVrhDgNrRjQMsP6qFq5HIQSknbSdb9hQ?=
 =?us-ascii?Q?YE080PGpywhuKYamVLNE9Cqb/9jvnG+1xJjSs8+wSipMUv4vcLHZ1YNXDcm8?=
 =?us-ascii?Q?zamFKYha5Ht+goc2SsatuiMPtJ7xRuVs78Bv/bH8J58irUWQvd9whdustKOo?=
 =?us-ascii?Q?XwcgkjbSsT6H4WIWtemPkaxWWxgPxVOnXuQQvKrlK4teLbaERFHqSu+40YXf?=
 =?us-ascii?Q?npNZkIIdDzNsl/+wnbGYfmAmSShmilk80BAzWcq/aWqMb15322n+fjwNpJ0u?=
 =?us-ascii?Q?eaqPkZ289NleGxn/9f7uBbCb/r9nCFDR5SWE+MM08BRrEAjglUXybDWK/GPz?=
 =?us-ascii?Q?KFF1eTsAC7z7K6DKpsYi8WaBdnd5hqUdyVELkpPRSZ1+MNncT8h7bJocFNZs?=
 =?us-ascii?Q?bXd84sDKxY+EeTVbHOjOi28utKi3Z2YApj8Uk2CBuLAAk4qAPKJclq1LHoQR?=
 =?us-ascii?Q?zlzbUH29zy22yzTDYUHQoB9lYOFL3jvIh1BKVfJyHEiJv6LbVvaaj9S89Z/3?=
 =?us-ascii?Q?Im5bl+demX9iZBcdw4/T+lDHiCyt16WeozyxxKovHr1Kp2Q0gs3n3dwWmW5W?=
 =?us-ascii?Q?P+jQz8istjnu4sDZ1BqFnnwR/IDQG2yHgq8grwNRq8OQYcOkkbptviXLvFTE?=
 =?us-ascii?Q?ZtEZKXzq7HzCKKrfaR2N6c/7MqlGemnb85W7RvVQfP1NHHHUyU+gCdq8Zmap?=
 =?us-ascii?Q?DLO+BSzqYLczSd37awimLEQxndp8y3u1Rp/3QbP94ws+a+lZyn1s/fnLCaZh?=
 =?us-ascii?Q?eS8MY1ZJ+Z7xb77B4SAmlINoLZfWy3acbu3RIyvHJ4CDzyAd1J5rGSBeJQ3Q?=
 =?us-ascii?Q?6aLmm1KehNKQ1m/lwiSRjbye5jgRev9WhCVUT0khV+m0JvU3MDSA/XOkMY6f?=
 =?us-ascii?Q?qRxv7dp2g27vlQjnwdr3DbHZ9clm53vSnnYndyuhJibC+VKBugJIp1W5Y/n4?=
 =?us-ascii?Q?ONXc0wHQiDhtPQs8Ay/Lei4n7XlBaobsP5qD16Tmi8s3olmo0JxHyOokKaRU?=
 =?us-ascii?Q?c2HsCrVFNnQOIFvU0z9Sjro4DhbSlOJw9OzHzshRCSwfXBHd0NSeILOJnyYd?=
 =?us-ascii?Q?ad84SCsNbUVe7rIk2BVpr6ORP5sPbYG/heIrapNh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d51a423-aa93-472c-a745-08dd12bb66ee
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8940.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 10:23:45.2700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TAXIDzUPahibJO+eTB6vBdmD/qIkfRwVul4V4teh1/o5Khl80+MDMQln/mdzqNqigVCAuxxcRIaG4yufny0Ehw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750

Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com> writes:
>> @@ -208,6 +213,18 @@ _cleanup_nvmet() {
>>
>>  _setup_nvmet() {
>>       _register_test_cleanup _cleanup_nvmet
>> +
>> +     if [[ -n "${nvme_target_control}" ]]; then
>> +             def_hostnqn="$(${nvme_target_control} config --show-hostnqn)"
>> +             def_hostid="$(${nvme_target_control} config --show-hostid)"
>> +             def_host_traddr="$(${nvme_target_control} config --show-host-traddr)"
>
> I suggest to remove the line above. It caused ShellCheck warning SC2034. I think
> def_host_traddr is not used anywhere.

Ok.

>> @@ -811,6 +836,29 @@ _nvmet_target_setup() {
>>               fi
>>       fi
>>
>> +     if [[ -n "${hostkey}" ]]; then
>> +             ARGS+=(--hostkey "${hostkey}")
>> +     fi
>> +     if [[ -n "${ctrlkey}" ]]; then
>> +             ARGS+=(--ctrkey "${ctrlkey}")
>> +     fi
>
> This part above sets arguments --hostkey and --ctrkey in ARGS to pass to
> _create_nvmet_subsystem(), but I find that _create_nvmet_subsystem() does not
> refer to the arguments. Though I know this part was in v3 also, I suggest drop
> this part.

Good point.

>> +
>> +     if [[ -n "${nvme_target_control}" ]]; then
>> +             eval "${nvme_target_control}" setup \
>> +                     --subsysnqn "${subsysnqn}" \
>> +                     --subsys-uuid "${subsys_uuid:-$def_subsys_uuid}" \
>> +                     --hostnqn "${def_hostnqn}" \
>> +                     "${ARGS[@]}" &> /dev/null
>
> The line above causes the ShellCheck warning SC 2294. Let's replace ${ARGS[@]}
> with ${ARGS[*]}.

I think using quoting [*] will merge the args as one and is not what we
want. I will remove the eval instead. It came from v3, not sure why it is
needed.

>> +             return
>> +     fi
>> +
>> +     truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path)"
>> +     if [[ "${blkdev_type}" == "device" ]]; then
>> +             blkdev="$(losetup -f --show "$(_nvme_def_file_path)")"
>> +     else
>> +             blkdev="$(_nvme_def_file_path)"
>> +     fi
>
> This truncate and blkdev setup part causes failure of nvme/052:
> [...]
> Also, this part looks duplicated with the other part in _nvmet_target_setup().
> Please see the 'if [[ "${blkdev_type}" != "none" ]]' block.

You're correct, this was a rebasing mistake. I will remove it.

> I guess this is the part you added "to specify the backing block device on the
> target, instead of hardcoding '/dev/vdc'". If so, I think such changes should
> be done under 'if [[ -n "${nvme_target_control}" ]]' condition.

No that part is done in the contrib/ script and the template.

Thanks
