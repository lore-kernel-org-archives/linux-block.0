Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253ED2AE78
	for <linux-block@vger.kernel.org>; Sun, 11 Jan 2026 21:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768165692; cv=fail; b=ZUldc7r5UiQheyjMWfBRM4en353va4Y24uQBXeF8GOa8ygkwgx5Y7aErNebk/N7CnAiCCl30a0aLFHtkKwLR2Ps+FjpKnycdTXpAcd8tPsZyQzgnHoDFw02LINAVtmc0gSr+xUgEgY+iWkgCvlYfDUECEEdtpNXNbK4qYf/EOpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768165692; c=relaxed/simple;
	bh=fDwQZtpx2AzIiMpp1FF+vaxpRAQzmS0YU54gq5KoTbw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MA7c0Ge6Z0rq5EfwS0r02bXdgv7XDhihi7O+j6Dn4mpRJPUCYwcz2QhlBJmq6UfDmEw3TTKZCmAKvdvmgw6ckkooF4vGutxk7owcPnK7o2z5aq99wHyUvSOBVDxrxBSyn0pTFqqrJqrsG80ND/U36veIPaMOAhSNMUMzV6SuEkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r4nuR/0V; arc=fail smtp.client-ip=40.107.208.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r4nuR/0V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eg/S4m8BO9fxX4GTvCa/6SHxhfee2t5apOXKgyzjiaxVT1e8uz5TqPv293xWCukqpdD5O3K2WZnN8uQNkbPEz2EfNQQxPRFEp0zIA99hBAOuKLFVgbH7TJgzpXIjLh+s0a6+c19qSTxDyvPb/ARt9UY0Pil7ynBzlgRdY3A73+BkU1/+yMinzwOuHdR9mAXO/SFPyLCO/Y+oYv8bsVMaI7xnLrYMxiSzJfPgajOPVCfr1LLXNhRqn5vZe7zuIVQXMukgT99+KEvsa9Q6JrzoEvwgkecbRKMLC9ezhjsjaQq9kMJMiViOKYiZSMeYmL5MLE/7Unx8ESNIqrOciP+xGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDwQZtpx2AzIiMpp1FF+vaxpRAQzmS0YU54gq5KoTbw=;
 b=FGVc9c6oaEV4N01qjRWUdpxmJoZ08tAE/xtzcvc3ziAYWN1f/WpSnyYlQ1/LTfa4mR9K8PTE004VQXS3R0OaYks59yGq9OVMg3ojQXfoE32w1jN/zgXqlJ4D5mSFJU/vwHUYw2B0WN35k5lyLCFlelg00eZykhKBRWOpQmK/F6vBUPK7lAcxnhJQVbKbc+IMURBLMAlNbAjD7f99RbtwXZwHvsmRhbr1UDjKhlC3hZocxom+TYEXfwiDtwuxrAiclmRA9bzM0cha5/SA6sHZ28gyFE5r+PVu0IufZGbMUteWSZOnjlYgpNitkuol/fBfpeO/5GZL0CZNmsmGKKkYWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDwQZtpx2AzIiMpp1FF+vaxpRAQzmS0YU54gq5KoTbw=;
 b=r4nuR/0VVgHVHyYBDchhuHPVjyMBosJUJtq0p52j32oIF5Etlba2IkGMKQo4NFB4DWSzXPYLuAj0txayWoFi3A8xtIN873J+oflLvWID/xC9ukluMr1aarx42jnYNkyOXxoskBdMXFZ0k0IYqWnIDcmEkQb1bZWQQVpdSFHaVdLvF3oYDvG7BvB/Vm17115SbtolRwP45esOlkacVgF1vsWoQbYL1lnDCjJYMKG6ATH4n7VAz8HmxmyKgv7l+ZOhR/W1Oyc5gxNXawayW31FRGxmZh5dTYslMbXqZPhl5bKAPC/HyBAuMouNyqHqc1jO03HmCXHZQV7t7XStv0YX2Q==
Received: from DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) by
 CH0PR12MB8579.namprd12.prod.outlook.com (2603:10b6:610:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 21:08:05 +0000
Received: from DM4PR12MB6328.namprd12.prod.outlook.com
 ([fe80::35dd:a6f9:6b74:3caa]) by DM4PR12MB6328.namprd12.prod.outlook.com
 ([fe80::35dd:a6f9:6b74:3caa%5]) with mapi id 15.20.9499.005; Sun, 11 Jan 2026
 21:08:05 +0000
From: Yoav Cohen <yoav@nvidia.com>
To: "alex+zkern@zazolabs.com" <alex+zkern@zazolabs.com>, Ming Lei
	<ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"csander@purestorage.com" <csander@purestorage.com>
CC: Jared Holzman <jholzman@nvidia.com>, Omri Levi <omril@nvidia.com>, Yoav
 Cohen <yoav@example.com>
Subject: Re: [PATCH v5 2/3] ublk: add UBLK_CMD_TRY_STOP_DEV command
Thread-Topic: [PATCH v5 2/3] ublk: add UBLK_CMD_TRY_STOP_DEV command
Thread-Index: AQHcgt8OVyRg7OX7VEamPbhiQOb097VNaKeAgAAOWoA=
Date: Sun, 11 Jan 2026 21:08:05 +0000
Message-ID: <748ecf62-85d2-44b6-a9b8-babfda760044@nvidia.com>
References: <20260111094504.24701-1-yoav@nvidia.com>
 <20260111094504.24701-3-yoav@nvidia.com>
 <e1998ea0-7948-41cf-be65-b283eb388c47@zazolabs.com>
In-Reply-To: <e1998ea0-7948-41cf-be65-b283eb388c47@zazolabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6328:EE_|CH0PR12MB8579:EE_
x-ms-office365-filtering-correlation-id: b42d2727-8a49-4ee1-50ad-08de51558366
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UlN3b3RraUpYRkY4WVNkMC80RHJtb2FqclZqdXgvZlppcVEzc0xXK0d6Si9O?=
 =?utf-8?B?Y3UwTlNBTnNwNmdOYjZSMm8rbnZJNUJKVEtOaU1VRzg1VlI4MUx5TXB2STVX?=
 =?utf-8?B?c3VRL1JWbXIvUXpmWjJXVFZjcGpWd1MzeW9WT2JNc2lySmpFbnZ3cUVNb1VF?=
 =?utf-8?B?cmNRTU5pSGlhdU1CTUhCeXFlVGlub0lENU1FTXZyWG9MdFdsbGZaSmVzaHpP?=
 =?utf-8?B?MHA1ODNSZlgvZVppOUhJVHNxNEZMRkNmTVgyU05ycGZTbzZjTkE2aWlubjBN?=
 =?utf-8?B?VGhDWm0xTGk2L1BFdldBeGc0emJWVklvN243SktJUFR6S1kxOGV2ZlVpUmNS?=
 =?utf-8?B?QkdMQThiSFV2S1NnSW45L2FSU1N2K2JPc2drTmVHOUpLbFlGL3UxMUZ0RGww?=
 =?utf-8?B?WFVGQzFDWVRrMHVrZG5HOXNWdW1VeDcrbytETWQ4ek9lOUIzTFltVEhpY3BV?=
 =?utf-8?B?RldHSGpYRjAwVlNnMFFmNjloYzdFTUpPM1lVVC95L2NrN2NKUVhBT1Q5bG5q?=
 =?utf-8?B?K3F0WWNOR1dwWGtIZVZyZHVJNkFSc2VKN0YzZUV6ZGxrSFFQZ1dQWjc3aEFR?=
 =?utf-8?B?QzkzdHRkTmMxYmN5dk5oWVpzRUVqTHRJQ2V2Y3JVVVRNajhUYzhBNVA2UjJw?=
 =?utf-8?B?aExuWVd3bkpoWXdDQ2hzSCsvcEZzWHFGdTh0WkpMYjFtb1VhNlJSRW4xNXdh?=
 =?utf-8?B?K0hQWkZ0VWg0SUZpTEhOSDQweVI3SkRqMEVBRHNJcU5IVWtNMm1KQlpyaFp4?=
 =?utf-8?B?STd6aitKUEhwejRkNmFpb2M1d0Y0bG1MK3ZGWi95WmVJMlJRQnFRS1l6d2pl?=
 =?utf-8?B?aCtIVGZkb1pIWi9OcUM0dVdMS1NHait2K0Uwd0Y4dGs0b3dZNmJXbUc2dHF4?=
 =?utf-8?B?ejBIMldRWXRpSEJNMUo5V3cvMlkrVWZSN2I3WlNIUXpKMUZsejhBSURyS2Nt?=
 =?utf-8?B?ZW9mVld2OUd4N0IxUm1HaFZhVEZRRGZGR0tPVXlycDVsdWV2SmlhTjNyZ3J3?=
 =?utf-8?B?VXc3WDZ3anAwRC9UREdZeklCd0RMMHk2dTNvWVd1ZEJiL3pYdzVTLytteXRh?=
 =?utf-8?B?aXYxcEgxSm8raC9WTW5qMlpEUzRoYzFnNFNvRUlJUTc0bXFQZHdjYVBWU3pC?=
 =?utf-8?B?YjBIWmlhMUFEckV5QnphK28zajIwaHJtSTdXMkp6cDJ6aGNOZHZXUXVsYlAz?=
 =?utf-8?B?YlNxRGdoUVdXbzdWcWw3cEZlbVpEeU5YYnhwM0VoK2lGeUtHZk1FNEtPWTQy?=
 =?utf-8?B?SzRwaDJ4UGZMY05SSHhnQk13ZnIxbUFKVW5md0ZrNHVFa1EvU21OVmt3MEds?=
 =?utf-8?B?UHE1dk5sNGhSckFmVGRtdmhzOHk1c09tM2FkU1RCVVNpQ3BaMzEzTm1BWW0r?=
 =?utf-8?B?b1Noa2g3RTdKdG05Ly8wMDhFYXI4M2VRNi9oUTlQbU9JWVBER1psTFJ6MjlX?=
 =?utf-8?B?bS9qYktoV2VuZ0Q4L2F3RjZNOTBwT1QxNG9qTjVZSDNtVitQSzJyeEtVRlpp?=
 =?utf-8?B?akZUaHVJUWNYUFJwcEpsS2tZajI3SGkzYk1PRHhWYW5vWG5Za1k3Z2NTckxn?=
 =?utf-8?B?eHBqWFd2bkpsSzZQS1ZJeTNEL0h4cnZTWUIvbVcwSVhEMGduK0hLUGg1WFlW?=
 =?utf-8?B?d3VsZHBFOWxjM2xqTDJxVnBzSTU3L29qSkd1Uk9ZakJnSWR5d1BDaW1EMThH?=
 =?utf-8?B?QXRFeGViK0szRk1lamJWTXZqcElWanlQRnBMTUVNbUpvNU1TVzFwNnlGeXNk?=
 =?utf-8?B?VU1BVDUxTzBDYXVwVzR2MStiMkh6NHBFdklrcEFsS01ocEF4NGFyQzBDVXZC?=
 =?utf-8?B?cTdZWHZWUEE2RSszVHQvV2VSNmdtLzV1T2psTTEwU1dhV2plYVFvWDVLU1NX?=
 =?utf-8?B?RVFZenR3TlFveDErY3FmRmo0L3F2VFJKZytWc2t2N3hCNUhxUmhkUGJFc1dx?=
 =?utf-8?B?YVZiZlF6UjRlMjNxYkNKQmsvNytTaFptRmhXNzJvVXdBN01yeU05V1g2ZEoy?=
 =?utf-8?B?cDQzMkc1Qng3K3hINmhkVHRDMGoyd0FsZ0hGekFrVU5WSHBoakdvMFI4eTdz?=
 =?utf-8?Q?83kC5r?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6328.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OXNkYnlXczk5b0tYSGJreE02TXJFZG83OTBCYjhUWXAwOWR0NCttTURUcnpS?=
 =?utf-8?B?eEx3eEo2ZXlLM1BkaHlRS0pMb0VvWGJkL1VXdFZUdFgzYmtTeFpOanB5ajhS?=
 =?utf-8?B?VWlDV2NDRW9jM0lDZ3FZcTAvd215Y1NGK2pEUEZmeTVBenBUMFZacVN4Nm1I?=
 =?utf-8?B?R3Z1ZEVnalZLSytsdnlJNnhVQ3ZWQlkwVzhDMFlhMHROMDd6REFFTzB1TCtM?=
 =?utf-8?B?RmdqWXRsM2Q3elgrVm9NczZQM3cxUUF1aThjRnArNW5BeThORXF5V3RzejVU?=
 =?utf-8?B?YkszaVBlS0VvWS9MTXlVSWlENmhEbmVkejU3KzF4MU5zekw1Qk5VeUtpMmdB?=
 =?utf-8?B?dTh0QzQveXF2NW5ILzF2NUp2YTlaYTF1MEZmbC9SeDAxTXg5UHZCYnhZY3RK?=
 =?utf-8?B?WHVTMGhoOVhXNkwwN1NUaDd6TEMvbkM3TUlDbHRYY3hnNk5DcU5xN21Obkw0?=
 =?utf-8?B?VHZqazBpaGdaY1FZa01SbGVzWmpRd3Z0N2lrVXFlUjg2dE1RbHRZbWI4YzVP?=
 =?utf-8?B?L3YyZG93NEVscVFMTVVMRWp1ckNwUlZLWE5GUjlvZkRwSGh0b0xHM2x0M1Zv?=
 =?utf-8?B?TTAxNDRmcWlQNDgyOW80a3Y3M2ROWFFKWDYrVWxmRERyMmRTaXYvYmJuMTh1?=
 =?utf-8?B?THE5ZnNqUTBzOFlZRW9aRXAxSWdJR2YzWThTQXRDL3dWd3ovOHNWQi9NZDBN?=
 =?utf-8?B?ekh6V3NFTVdBQ3M1OE1BNnl4SnNHTFc5Uk1SN3dzNDdPOTd1bTVxdTBKZFl3?=
 =?utf-8?B?SEN0aDk4VVlNQUwrUGtNRlgwVVVuSFVPVXc3Y3ExSHJtUUZrRWNLaDNBWEIv?=
 =?utf-8?B?MEhnQXFHQzZ6cTQ1MWIwbGFPTUdRSkl6K0VpNkdSZUtXbGtielp0dDlLUVJ0?=
 =?utf-8?B?WnVVZmErdjdmVHZGTFhzYThFNUQ5MlBMTUd4dmZwMTY4a0pwRHZicVVEc3dm?=
 =?utf-8?B?ZXcrMllwNDk4K3ljSzdmbmFQa243RzZRNkRIZGQrcjAvR1BYU05RMWZjRVVj?=
 =?utf-8?B?UHV3cGYwRU04MU9oc3B5UG9aYjhsZkdwUUVyeUg2dDdnOEJndFhtb3YwbjVE?=
 =?utf-8?B?c2g1K3hLbDZqT1ZiZjl0OFFRUVdSSVNmMk0rSUlJZWVsNWJSTTNONTU1eklY?=
 =?utf-8?B?dWpkSVFYWXU1R2k1Qnd4aW1jWnltOWVETWJCZGhKN2cyMVNkRGFBdnp1M0tn?=
 =?utf-8?B?SFpLR0Z6clpXT3FYK2daa2F4UEh6ZmJxMnYvdjk0bkRMcHBzTFFrbllGeElu?=
 =?utf-8?B?cjB0RVZxNGhsWCtIYmZVOHMzNXpRWkdVdDVBSzNZRlh0MFRqd1dvdDUyMW1y?=
 =?utf-8?B?d0J2cHQ5Ukh6alpRME5PRC9aSXpGanZXWFkrWWFhYUxFYnVocWJZNzdON1Vm?=
 =?utf-8?B?TGZuVFRsQzVRNk1tdGR5c0xLczcxbWxEanVGSmp4L05kWmRrSkZhbHk4MUY5?=
 =?utf-8?B?OXV6YkJSbU5FM3EvMWZXbFdGYVdiMDF3bHlBSTlwb2FmSE9FeDRLd1RFMHI0?=
 =?utf-8?B?T3NLWGJJVTBaaFJmbFlvakthRkwrWXhCaFFnSE1BVFg5d0o0M0szdE5NQjJj?=
 =?utf-8?B?dGoyWHVURjRHbjIyYWhMWUlyTHRmMEdoQlRzaHR5SmN0SkZHU0tJTEtndVBR?=
 =?utf-8?B?N1lLK3kyTFBXNFdSTE9reGMrQVVoaGJsMU4xbWpWSVlQdC8reUhRWnBTaEtD?=
 =?utf-8?B?TVFGNnVPanFaanFucmY1Q2wrZTdFaCt5dEpoRzRtekJzUytVc2xZUUJzbURs?=
 =?utf-8?B?WFRvRk5NU3JMS0JkMzl0S1ZvQW4rejROOVFYWSttSGNkSkU4ODVnODl3bndm?=
 =?utf-8?B?TDBwSm4vckF6aWZiN1ZJdGFGdVFYOGRlQjNwQWZGb3U0N0VodlZmb2JHWHY0?=
 =?utf-8?B?L3dZZVl5S01la1FhVk9XMXJEdVZ0SFR1QVcxK0x3M0dPMFQzOXpqc1NwRkN5?=
 =?utf-8?B?SkFBZ0tQSGtKa1FuZ0YwYnF0S20wd2s5R2xhSS9WVTdwTW15cjRUbStsMVIr?=
 =?utf-8?B?MlIzUzdDQ3BDcTZOdmIyRHRydWtKVGFQWW9oSjI5ajlpdUl5ZldORitzL1dY?=
 =?utf-8?B?RVhKZmVqc1FmcGFkZTlPNUhmTXlITUNGQnhtQjl1aitnVjZsR2VBd05yMGpI?=
 =?utf-8?B?Z1NhTGsxcDlzZ29NYTBTU2V4SitBcHlqaExyeW1kWFpLb3JqZWtDeWFlUGhr?=
 =?utf-8?B?bzdrWElmZURpN0VKRGY3RStnSTlnYm1EQ3V6Rm9XckZkZmxIaXQ0ZVRla1hM?=
 =?utf-8?B?N2VORmJBNjRYT0ZhNGVNZFYzQnN4RVN6dnZHSkFCTTZFbW5qYlJ6R2E0L0FR?=
 =?utf-8?B?RHluNjdaOVlpUVRoZzdnaFlhNVZ5T3lqZkgwbGlFS2JVVDl2SnJxUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD4082CF625F46479C802EA153CA76F8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6328.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b42d2727-8a49-4ee1-50ad-08de51558366
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2026 21:08:05.1366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sDtzbsi8IoS1SOaOnLSYtEw1Cgpe7vujb2BWfHyBGVoHGtXX6mGjpNwnP7WiNkgn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8579

T24gMTEvMDEvMjAyNiAyMjoxNiwgQWxleGFuZGVyIEF0YW5hc292IHdyb3RlOg0KPiBFeHRlcm5h
bCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4g
DQo+IEhlbGxvIFlvYXYsDQo+IA0KPiBPbiAxMS4wMS4yNiAxMTo0NSwgWW9hdiBDb2hlbiB3cm90
ZToNCj4+IFRoaXMgY29tbWFuZCBpcyBzaW1pbGFyIHRvIFVCTEtfQ01EX1NUT1BfREVWLCBidXQg
aXQgb25seSBzdG9wcyB0aGUNCj4+IGRldmljZSBpZiB0aGVyZSBhcmUgbm8gYWN0aXZlIG9wZW5l
cnMgZm9yIHRoZSB1YmxrIGJsb2NrIGRldmljZS4NCj4+IElmIHRoZSBkZXZpY2UgaXMgYnVzeSwg
dGhlIGNvbW1hbmQgcmV0dXJucyAtRUJVU1kgaW5zdGVhZCBvZg0KPj4gZGlzcnVwdGluZyBhY3Rp
dmUgY2xpZW50cy4gVGhpcyBhbGxvd3Mgc2FmZSwgbm9uLWRlc3RydWN0aXZlIHN0b3BwaW5nLg0K
PiANCj4gDQo+IFRoaXMgZGVzY3JpcHRpb24gaXMgZWl0aGVyIHdyb25nIG9yIHRoZSBpbXBsZW1l
bnRhdGlvbiBpcyB3cm9uZy4NCj4gDQo+IEl0IGlzIG1pc3NpbmcgdGhhdCBmYWN0IHRoYXQgYWZ0
ZXIgdHJ5IGZhaWxzIGFueSBmdXJ0aGVyIG9wZW5zIHdpbGwNCj4gZmFpbCB3aXRoIEVCVVNZLCB3
aGF0IGlmIGFuIGFjdGl2ZSBvcGVuZXIgd2FudHMgdG8gb3BlbiBvbmUgbW9yZSB0aW1lIG9yDQo+
IHJlb3BlbiAtIGl0IHdpbGwgYmUgZGlzcnVwdGVkIC0gaXMgdGhpcyBpbnRlbmRlZCBiZWhhdmlv
dXI/DQo+IA0KPiBBIGJlbGVpdmUgdGhhdCBhIFRSWSBpbnRlcmZhY2UgaXMgbm90IGV4cGVjdGVk
IHRvIGhhdmUgc2lkZSBlZmZlY3RzLA0KPiBzbyBtaWdodCBiZSB1YmxrX2N0cmxfZ3JhY2VmdWxf
c3RvcF9kZXYgd291bGQgYmUgYSBiZXR0ZXIgbmFtZSBpbiB0aGF0DQo+IGNhc2UuIEJ1dCBpbiBh
bnl3YXkgaXQgbXVzdCBiZSBzcGVjaWZpZWQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIHdoYXQgaXQN
Cj4gZG9lcyBhbmQgd2h5Lg0KPiANCj4gDQo+Pg0KPj4gQWR2ZXJ0aXNlIFVCTEtfQ01EX1RSWV9T
VE9QX0RFViBzdXBwb3J0IHZpYSBVQkxLX0ZfU0FGRV9TVE9QX0RFVg0KPj4gZmVhdHVyZSBmbGFn
Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFlvYXYgQ29oZW4gPHlvYXZAbnZpZGlhLmNvbT4NCj4+
IFJldmlld2VkLWJ5OiBNaW5nIExlaSA8bWluZy5sZWlAcmVkaGF0LmNvbT4NCj4+IC0tLQ0KPj4g
wqAgZHJpdmVycy9ibG9jay91YmxrX2Rydi5jwqDCoMKgwqDCoCB8IDQ0ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tDQo+PiDCoCBpbmNsdWRlL3VhcGkvbGludXgvdWJsa19jbWQu
aCB8wqAgOSArKysrKystDQo+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDUwIGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svdWJsa19k
cnYuYyBiL2RyaXZlcnMvYmxvY2svdWJsa19kcnYuYw0KPj4gaW5kZXggMmQ1NjAyZWYwNWNjLi5m
YzhiODc5MDJmOGYgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2Jsb2NrL3VibGtfZHJ2LmMNCj4+
ICsrKyBiL2RyaXZlcnMvYmxvY2svdWJsa19kcnYuYw0KPj4gQEAgLTU0LDYgKzU0LDcgQEANCj4+
IMKgICNkZWZpbmUgVUJMS19DTURfREVMX0RFVl9BU1lOQ8KgwqDCoMKgwqAgX0lPQ19OUihVQkxL
X1VfQ01EX0RFTF9ERVZfQVNZTkMpDQo+IA0KPiBbc25pcF0NCj4gDQo+Pg0KPj4gQEAgLTkxOSw2
ICs5MjMsOSBAQCBzdGF0aWMgaW50IHVibGtfb3BlbihzdHJ1Y3QgZ2VuZGlzayAqZGlzaywgDQo+
PiBibGtfbW9kZV90IG1vZGUpDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIC1FUEVSTTsNCj4+IMKgwqDCoMKgwqAgfQ0KPj4NCj4+ICvCoMKgwqDC
oCBpZiAodWItPmJsb2NrX29wZW4pDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biAtRUJVU1k7DQo+PiArDQo+PiDCoMKgwqDCoMKgIHJldHVybiAwOw0KPj4gwqAgfQ0KPj4NCj4g
DQo+IFtzbmlwXQ0KPiANCj4+ICtzdGF0aWMgaW50IHVibGtfY3RybF90cnlfc3RvcF9kZXYoc3Ry
dWN0IHVibGtfZGV2aWNlICp1YikNCj4+ICt7DQo+PiArwqDCoMKgwqAgc3RydWN0IGdlbmRpc2sg
KmRpc2s7DQo+PiArwqDCoMKgwqAgaW50IHJldCA9IDA7DQo+PiArDQo+PiArwqDCoMKgwqAgZGlz
ayA9IHVibGtfZ2V0X2Rpc2sodWIpOw0KPj4gK8KgwqDCoMKgIGlmICghZGlzaykNCj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTk9ERVY7DQo+PiArDQo+PiArwqDCoMKgwqAg
bXV0ZXhfbG9jaygmZGlzay0+b3Blbl9tdXRleCk7DQo+PiArwqDCoMKgwqAgaWYgKGRpc2tfb3Bl
bmVycyhkaXNrKSA+IDApIHsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gLUVC
VVNZOw0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIHVubG9jazsNCj4+ICvCoMKg
wqDCoCB9DQo+PiArwqDCoMKgwqAgdWItPmJsb2NrX29wZW4gPSB0cnVlOw0KPj4gK8KgwqDCoMKg
IC8qIHJlbGVhc2Ugb3Blbl9tdXRleCBhcyBkZWxfZ2VuZGlzaygpIHdpbGwgcmVhY3F1aXJlIGl0
ICovDQo+PiArwqDCoMKgwqAgbXV0ZXhfdW5sb2NrKCZkaXNrLT5vcGVuX211dGV4KTsNCj4+ICsN
Cj4+ICvCoMKgwqDCoCB1YmxrX2N0cmxfc3RvcF9kZXYodWIpOw0KPj4gK8KgwqDCoMKgIGdvdG8g
b3V0Ow0KPj4gKw0KPj4gK3VubG9jazoNCj4+ICvCoMKgwqDCoCBtdXRleF91bmxvY2soJmRpc2st
Pm9wZW5fbXV0ZXgpOw0KPj4gK291dDoNCj4+ICvCoMKgwqDCoCB1YmxrX3B1dF9kaXNrKGRpc2sp
Ow0KPj4gK8KgwqDCoMKgIHJldHVybiByZXQ7DQo+PiArfQ0KPj4gKw0KPiANCj4gW3NuaXBdDQo+
IA0KPiAtLSANCj4gaGF2ZSBmdW4sDQo+IGFsZXgNCj4gDQpUaGFuayB5b3UgZm9yIHRoZSByZXBs
eSwgYnV0IEnigJltIG5vdCBzdXJlIEnigJltIGZvbGxvd2luZy4NCg0KUGxlYXNlIG5vdGUgdGhh
dCB0aGlzIGNvbW1pdCBvbmx5IHByZXZlbnRzIG5ldyBvcGVucyBpZiBkaXNrX29wZW5lcnMgd2Fz
IA0KYWxyZWFkeSB6ZXJvZWQuIEluIHRoYXQgY2FzZSwgdWJsa19jdHJsX3N0b3BfZGV2KCkgd2ls
bCBiZSBjYWxsZWQgbGF0ZXIuDQoNClRoZSB1Yi0+YmxvY2tfb3BlbiBmbGFnIGlzIHVzZWQgc29s
ZWx5IHRvIHByZXZlbnQgYSByYWNlIHdpdGggYSB0YXNrIA0KdGhhdCBoYXMgYWxyZWFkeSBzdGFy
dGVkIG9wZW5pbmcgdGhlIGRldmljZSBidXQgaGFzIG5vdCB5ZXQgbWFuYWdlZCB0byANCmFjcXVp
cmUgb3Blbl9tdXRleC4NClRoZSB0ZXN0IE1pbmcgYWRkZWQgZGVtb25zdHJhdGVzIHRoaXMgYmVo
YXZpb3IgYXMgd2VsbC4NCg0KVGhlcmUgYXJlIG5vIHNpZGUgZWZmZWN0cyBpbiB0aGlzIGNoYW5n
ZTsgaXQgaXMgZWZmZWN0aXZlbHkgYSANCmJlc3QtZWZmb3J0ICh0cnkpIG1lY2hhbmlzbSBvbmx5
Lg0KDQpUaGFua3MsDQpZb2F2IENvaGVuDQo=
