Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021119.outbound.protection.outlook.com [52.101.95.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AEC35AC1E;
	Thu, 21 May 2026 03:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779333174; cv=fail; b=R9CIVpaykB6P3Sf5tPNKrR9wjxnWwlb6wwTdOnNfCsLUK4A68vFppq1eqETZ7AbVwAS4pkJUAiJaDjtKgJzCZaXDrKabBoPH1Wm/Z3iHrCYNcw963H48rmEnPApg1iAJPLEaxDCJ2smNIQKGKV+whNapYJXdycuIThvSS5pEQQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779333174; c=relaxed/simple;
	bh=JuHvPVi2x2yFknQzpTq2c27CEovGljOPOqUSoZt00ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iifBblIsUyr/qPvgwfwYVMdsDH0Z9kfu90GKplExj/h3DhV08nWLtgThIT47JZi0EGI4Kr8D9Ltq386RTbGvtyWCANqYNN+CVg4dUD9GxwZfXMS3NzcccO4VW9tyA+SmzGtNLh6cTR69v+ZSxZj/MKyYZ3QlU9oEuP453vQx9ZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYT/xAuyIVXNuE2nuincYVXKEBBu4ohxmLpJLHN4P5Z9T5zA63vFgM1rKi6ol6XeqbUHs8vNQNLA5qp/UfmSoWYADzluXPTYNHk2nHiMi4RycEF+lT94gdQxr5dZzYa3fvo6cMYuap5yZHGm6pOeYt6caE16+QhL9aV0olTc2Tb9v+Jofu/uh3zRtkO3yjJjMYchlcdXsklwQzZAhGaj6fskK1sGbnTCEAI/JJhugB/V81wmqcfhLPNImT8tWW0K7Qb/kXtjwwr4haZ/MBzv1qeHTeuwW3KzAFI3Bo0GauMb6FCeov3bEwPwuAa99vwg4ioNvaUjbu9sUSSrF7yBpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMUYcdAR84R3HRc/tQh2qPI7wyKtVfeB67uNA1c/Tu8=;
 b=hk4arII7lQPgDsNr7slYpH5AnDg5P8M0DrIKozcJyFJHmsYConk5AqB4ZS/CvmPp43l1lW0ANw2etwyu9hR37YA9m3nOVOvXTu8FZn3+E7j5JMTDuVuljAbjjURn2k1Qei2XyoolVX58q/rJfIEszFS4IavRo/vfTDUcBOoA7nO3y4a/+LVV50IA9CHyFupEdt+Ut2BMCNitUfmrdfIotFZbwHBvphojHWbFZQ+xVL0GMynuRkoSwwKzronzdxwUq5i/N853wGLtjf3zhL+CS7t0KAJXCgmiY6+zv4NbpXXXeKa2e/RsErSq1ZLi6nhWhQPrDe+xXyr7BzRZYv9NQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO0P123MB6847.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:309::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 03:12:45 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Thu, 21 May 2026
 03:12:40 +0000
Date: Wed, 20 May 2026 23:12:35 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
	mst@redhat.com
Cc: aacraid@microsemi.com, James.Bottomley@hansenpartnership.com, 
	martin.petersen@oracle.com, liyihang9@h-partners.com, kashyap.desai@broadcom.com, 
	sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com, 
	chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com, 
	suganath-prabu.subramani@broadcom.com, ranjan.kumar@broadcom.com, jinpu.wang@cloud.ionos.com, 
	tglx@kernel.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com, 
	bigeasy@linutronix.de, yphbchou0911@gmail.com, wagi@kernel.org, frederic@kernel.org, 
	longman@redhat.com, chenridong@huawei.com, hare@suse.de, kch@nvidia.com, 
	ming.lei@redhat.com, tom.leiming@gmail.com, steve@abita.co, sean@ashe.io, 
	chjohnst@gmail.com, neelx@suse.com, mproche@gmail.com, nick.lange@gmail.com, 
	marco.crivellari@suse.com, rishil1999@outlook.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 3/8] lib/group_cpus: Add group_mask_cpus_evenly()
Message-ID: <a7d7kh7jcxzyzuciapou3k7tzkmzryixce5vbqxzz62wze5plm@7hf5gszwsfgx>
References: <20260520215030.496803-1-atomlin@atomlin.com>
 <20260520215030.496803-4-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260520215030.496803-4-atomlin@atomlin.com>
X-ClientProxiedBy: BN9PR03CA0667.namprd03.prod.outlook.com
 (2603:10b6:408:10e::12) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO0P123MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: e63a37f5-3c96-4840-e1a1-08deb6e6d06b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|22082099003|56012099003|18002099003|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	ZzfmyBfY6htLblpYKG352/IRxUReZgLiz7sgUFdRNGJvmwakOSp0WkmW2s0k2YSFjN0PsYHUo2z7T69BOMwWXly++rC/WTBr82nbeGVrmkPKheUVFaESGsrZl4yNCku7FcwmBOyUsF42/L7ASsuHXCF1Tq/MPmQcnp2VTTTjT9018XAUMjYqn2OLjEgaqrosxdHCt9NEBl9dC91PCmGWPkNAatWAgct3B4NZdWM1kQ/QHA/fbVJ7QbKVeNKyOfeG8F22JEzibkc5965Qdh3hk3/RD7QtGoKuVxR1/tlMN1gNbGavAq+mpuq57l2r5h8TUJ4+vI9kJ+m5Q2swyNtmkY4/cYpL782yyQuo12TjYLoBL37ZeCl7U5xpxPsifQF2Rnjizcg8hcWvHHUw83KQZ4ye3i0zpMrNsp6IpcX1edBqs/UIo4k1bey0H0fInLxzzxzwas0pKEX9XGYvKnFcjk8JDqkFroSQnqc6cfOJT6M/3XNXMKC7gDPU5lKnGIBdeCc7F23U9WzoTpxjCPRJqtblZsjQEgm9lJ0NTCrCxcfc5RHRJrEL8XWtkcXRBghWe172eLf+XHbhI3Wd5/JIXl5npBPICV7jaf67Rwz32UbvEOL2YKb3EDAhrYAsm2H7MvXlB7oZgFvKpUQudbW3DNn8s/VreMZRanrOwCGHaZe5+6ps7El4sc9qFKkjdvOd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(56012099003)(18002099003)(6133799003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YW9ib1dxNTJ5OW1WUkZIQ0kxakttQWJ6TmdZWjdmZkRyVzBXcDMrUnYrTjRL?=
 =?utf-8?B?ZTRGcDBCWldFN2tyTnY1T1RUSm1SVkZ1UjJOVHJJV1FZejlRRnhZUTNwbUtX?=
 =?utf-8?B?RzBSSEoxTkFRRlN4aHFLbGhER3hRTmh2TzF1bjY5YlRjNUdOb2w5aG1oaWNP?=
 =?utf-8?B?L3Z4UzI3c1F3RXZkQWtWeXROSnAxMjlkQmVETUMzSEczRFlaaTdUNnRzd2gr?=
 =?utf-8?B?TkZiNWFCOXZlLy9DMnhpb2JZeXViTGlIaU5VT3MwNC84Q0VQUW1IbkNGZzJk?=
 =?utf-8?B?RldCdFN5YVpnLzNWeFBlNXF3S20vRFB3K0JJOFdiZkRtOFBaYVQ2Mm4zNmdD?=
 =?utf-8?B?UXBnMTVCdC9CU0Z3by8xKzJTUURtMnlHS3JaQy9tZDJRYmhuWFBPRFgvSjd3?=
 =?utf-8?B?dStNQ29oWi9FQUJqN2dBN2YzZU5tSWJmd1ZFSmgwUzB1MFMxU0xRSUZWMHZ4?=
 =?utf-8?B?dlNDSzVhNXVwUVQvdlFMMUpmd3QxV0dVMlVZaFUyNDI4Wk5JcnJpRHIrVC9R?=
 =?utf-8?B?bk5RbkJzMERDb2JLZWRJVTJUajlQMjZxTXM4ZXFYc0dsZHR6dHhBTTNUU2kz?=
 =?utf-8?B?NW9hM3FEZlJadXZTWUtzL2ZCRHErbFF3bkxoMThwamhlMzFDU3IyeTFZSGdq?=
 =?utf-8?B?bWMrWEJFc1Y4SDVKamgwNFRLRzU2RVJFVXZQaFc4RkNINkNpNURTYWExQkdh?=
 =?utf-8?B?UWFCR0tsb3ZETHRZbnBpWW9pSkJzeE1JNVl1aHNUbExnQko5T1ByZm9MdVJQ?=
 =?utf-8?B?bDRXandRZ0dyLzF2bksvMk52SndXV0JmeVAvdzdpclZON29KM05zSEovTTdl?=
 =?utf-8?B?NC9BRUZ2NmhVMlpHREo0NXJOM3g0K1FKMXJ4dWxHNlozYVdiUnFFMEttaVF0?=
 =?utf-8?B?a1hBQlZRYmp5Qzh6a2RBS253QnQ2UjN2a2U5d2orTVYwVFRGdWQyNEcyVXpt?=
 =?utf-8?B?K2FVWjFSRzRLZlQ0NFBSeHRCMG1rRzVMQlBkMm03akJQTmptV0ZMWERJVnJr?=
 =?utf-8?B?dFZ0bThqOTZMN05nTExuUUQ0dWpKMkYySy82L0JGQUpmWWt5MDM5cGx1Q1Jr?=
 =?utf-8?B?b3lLNzd6WTZMM2JhWlN6S3huRS9mWUYybytGa1A2ZGhPYXdZVFNFTlUvTUxr?=
 =?utf-8?B?Q2ZGU293bEFIWXpZWW9pMWJsMmFMOTFWbENrajY4anFXVzNkUUdhVVpBSFFi?=
 =?utf-8?B?YUU4T3QxNEZQQ3hUdlhXaFpSUlc1TW10QU5ydVdhVG82QzAwaXhwTVRXNUk2?=
 =?utf-8?B?ZHB4SURhcHFrMkhSRjEzeHNBSWprQWpvRXhTYms0Y3lTUmk1OXZEa1dEVVpo?=
 =?utf-8?B?d0pJNFd6VnFSaEdKZUtTbjN5elpWUm9nRUtCa1BvOTZnUFlIM1dxQWdpa3Y3?=
 =?utf-8?B?RTJaUWxPQWxFVGZTZmVxdmllcGdPdWhXT3ZDeEFBckg4eE1LMldrQUVhVVZR?=
 =?utf-8?B?SXFvclZhRG44NmE1a1k2aW83dlNyMEZQZXNKYmlYbnNVTVFsZldzMGZEWGF6?=
 =?utf-8?B?dDI4alR2VkdzWFNKNElkcHpvK2JleURXNy84UTRXdUdKQU1iMWZyTzJiUTlG?=
 =?utf-8?B?cExIUXZ5dEthR2JBS1kzQVVqdzgyNFBaNVNHd2hnQVNKb1dianNSRkZJbm80?=
 =?utf-8?B?c0h3OVZHWGFYTXZkUWdJRFNyWTZhWkdwOC92YWJEREFBdGFsYTdYOGs1ZkJR?=
 =?utf-8?B?SjhDK1pLQlZ3ZlVqVmRqeFYxUG9FQ01tVGdYeU1TdTdIcUZBMmt4UkJrdzdO?=
 =?utf-8?B?aXFzUVNSOWtzajMyL2xHS212cFh3VzJsOEtJRnBJSTRVMlpNZW5oRmlqc2pB?=
 =?utf-8?B?TWM2YUh5UTJYd3U0WUVud0t5SFNEYXVxQ1A5Ynh3TWJKcHdlKzdkaUcrNVY1?=
 =?utf-8?B?dWI0Y2xCaVZoeFFteTN5eStpV3B1akRVTHVUVTVqTHdYUTVuL2lwYVF3QThp?=
 =?utf-8?B?NVFRbDJ4TXM2OVRRNnF6WFlLdFUxTm15bzNoVklqTnZ1S0s2ZmxTMFRzT1RJ?=
 =?utf-8?B?RzVyZEFpeTVsUmpSU0R5Q0V4MVMyZDFNRnhoYVN3UDZNZ0tkaFpjaERCQkdw?=
 =?utf-8?B?bTB6cXpiTzEyL05XODhvU0djcC9DTWkwWUlYc3RaQmwxT0JrL05XUmFFZDNX?=
 =?utf-8?B?Mk1JTlZ3cWNqRGJqSnZ2clUzKzdGTEc2a3RkaGNQWENTVHdYa0JpSDd3WmQ3?=
 =?utf-8?B?WXdhQ2Q4UGdHY1kwbGFTUHgvVzNEbDk1MGFFaVc2RzUrbktsWnUrc1diNUl3?=
 =?utf-8?B?TUpyQnJyS0d3REJpTUIyY0p4QlcyVU1mME1Ub0hqZSs2VWs2RGNCUjlNS0lT?=
 =?utf-8?B?SXlqSFdlUlljV2RoNWFlcCs3OFhYRW5yVUlXeXlTL2tMdXhaT011dz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e63a37f5-3c96-4840-e1a1-08deb6e6d06b
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 03:12:40.2431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54zEPssiyUfCSkSYZ+Pqg3Wm1KdN2eV7IJGJCSKjHCfSGonKHxqEEznRntH+PUXl1ktLfL89+O1HDgoIbEqdTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6847

On Wed, May 20, 2026 at 05:50:25PM -0400, Aaron Tomlin wrote:
> +	*nummasks = min(nr_present + nr_others, numgrps);
> +	return masks;
> +}

If a NUMA node has exactly zero online housekeeping CPUs, the grouping
algorithm processes zero for nr_present and nr_others. Erroneously, the
caller sees a non-NULL return value, assumes the mapping succeeded, and
executes a loop doing fatal: queue % nr_masks.

I suggest we must intercept, free the array, and return NULL. Therefore,
the caller falls back to safe default routing:

@@ -432,6 +432,10 @@ struct cpumask *group_mask_cpus_evenly(unsigned int numgrps,
 		return NULL;
 	}
 	*nummasks = min(nr_present + nr_others, numgrps);
+	if (*nummasks == 0) {
+		kfree(masks);
+		return NULL;
+	}
 	return masks;
 }

-- 
Aaron Tomlin
