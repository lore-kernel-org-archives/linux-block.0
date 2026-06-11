Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011000.outbound.protection.outlook.com [40.107.208.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E57736F413;
	Thu, 11 Jun 2026 08:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781164931; cv=fail; b=nPBN3nIBwcEsevnrMnZbmgWTMM4ACqUR4qfvt5uwhw/VCZlt+TvhvHzggzRQpwgQ/q20a2o5DOV3bp5QwpTLV809xcAJXj/bZ/voenstR5mmcWeq5ISLDtUYE2n4+UUrw7pj8sIfgqOHGmjb+aJryE27nKxQX16D7ez+1G0r+28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781164931; c=relaxed/simple;
	bh=R4CA06yNfLkEVqto3//34mQpOYLEmVdqjfsNjzqGNk0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LnfR46nSEtU5nCNNFEf5UcrI0UMJlWUWxrkmUsfmcTg7GcQDxnuQdwAPq386yeg2LbkbZMpM3UKejKi0N1x26YSJRu8bNLGPiclgNugtYOcKcG97uRpV4Ua71h6MauipY3TMXKHrd2ATNQWjYnwOZhbFIxXv/WGZ2qVNS1pd1LI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WGcCDjow; arc=fail smtp.client-ip=40.107.208.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WGcCDjow"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQLX8zabzpWc70aq8SJmqI3sePCP2cR5Qr1sS6LdgHtWyofcP7NGdX3sJtacptQ8rie7d7e2TraDAMNXLKK1FASa9BMdJY88m71DWL58vM8D1CQ3oN/JY9pN33EoRZB00huaPmZaLJIENjqd1U5BMtqkaI6RwFkGe+uDq0IsXdrJ6I1VtZ/8ybvdsVBH8FLTi66sK1/JgQHue+WlHsY7jZcvSbAJBZ3BwGpV5CAD6AjNtbdaQuncOqVZ1oQ4CIE3QjD6j5ecFF8akumVlxjLAgRZkIuUC7sZJ1uaM8kbJWcXBwch9GE1RGj7XJEbVBu6MZxHTCBYn1MFdOI0o7sEvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1l4L2KZOkl3OQtjo8wiusThkx1Bv4k4J552WYRPRLo=;
 b=exXLzskEDD/BCKBF6KIqGWx1im6JtFEdWMNKr4j8fjo1s7CabcfzP62KxQB/Ve2sZU3dsMmSMqUWIfAmBNUv1q+KrEXciWonfJ+Mjvt7Dl1wRPYPlSesILu/BTS4EAqeUnK5khKBq11B04aMw2EU9ICSN0a4aVDLXDRSvr2Tt7t+/VCtv+qUSLRVdd1qWqAzK4ihAAdym5AA31DTqmC8rfE6m2HLj/kHTJqqNuKVq3RbijvyVhm8A21+hlP6pc3YyKBEVfwNhQEFchjV+uu6Vk5BvYjMPkKoI6v/s7I5fBCvfbJ/wvH3MqU1Kxzthn7D+bA29516WfTQeX7Eo1GDjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1l4L2KZOkl3OQtjo8wiusThkx1Bv4k4J552WYRPRLo=;
 b=WGcCDjow4rqR2DPOb936zshpMU6RnT6hEz88DuoFTc5aX8agh59UpBO09eUJY4eiph3jElpmq+DGIsoIzo+PLA4o81/mDREPTeVW0MR1H5Y7edR6Ihy2snXl6LCrcMYGwvAxMfXxKnmJFBLMxDnGkbmZ6D8RmevMKm5mpOcoZpk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB8523.namprd12.prod.outlook.com (2603:10b6:8:18e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 08:02:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Thu, 11 Jun 2026
 08:02:04 +0000
Message-ID: <92683537-8404-47fe-a4ba-160e54870f0b@amd.com>
Date: Thu, 11 Jun 2026 10:01:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] list: Prepare entry iterators to cache cursor
 state
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kaitao Cheng <kaitao.cheng@linux.dev>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Davidlohr Bueso <dave@stgolabs.net>, "Paul E . McKenney"
 <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Huang Rui <ray.huang@amd.com>,
 Eddie James <eajames@linux.ibm.com>, Mark Brown <broonie@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Laxman Dewangan <ldewangan@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Waiman Long <longman@redhat.com>,
 drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
 linux1394-devel@lists.sourceforge.net, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, linux-spi@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Christian Brauner
 <brauner@kernel.org>, David Howells <dhowells@redhat.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Kaito Cheng <chengkaitao@kylinos.cn>, Muchun Song <muchun.song@linux.dev>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Jens Axboe <axboe@kernel.dk>, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
References: <20260609061347.93688-1-kaitao.cheng@linux.dev>
 <bd0b7393-8ccb-4d67-8bfc-18c68347122c@amd.com>
 <5152089a-2808-4fe9-b633-b03018105dd2@linux.dev>
 <6b2efdee-95b0-4306-a682-0d0466497ddb@amd.com>
 <2399841f-d834-4652-8285-4a15c7d9a9b9@linux.dev>
 <d974a2ea-6102-45ff-bf36-3b25a2404e40@amd.com>
 <ail8iNvPrJnE7p58@ashevche-desk.local>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <ail8iNvPrJnE7p58@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:208:52d::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB8523:EE_
X-MS-Office365-Filtering-Correlation-Id: d88b51d7-4a73-4e9d-b823-08dec78fb987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|7416014|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	i763Z/yN9QSE/0E3zH19KNbxVfG91nw+dD37LePGrpOYWeKztx4BbBBN0gVnHiIAOLiRAHP/2IjK1C+1JW/JEi4+7m1e7H4CSsGKBEUdF4v9PJFCijiBp+MixrFPlkfNeMBbhrbCDUhXVqPohAIX5nL1ydLJu/ztwl8rQ9FOfd7ZXqtfmXo1tv+65UUgmgq/WnF+fEnr2MoIIetdBx4tEyDBCVohIe/jotzSim1dyrmHLgqg54RbfOV3tv+SnYb3bPkklyyQpAASrI3STfW3mDmHxbwqrJAUw+yK2DV7L3N9UhWtxftmJFqUgw6TK/ZNOi3M0qXQ95nE5c3SHiw1Z0ViunlP7WO/jz+1S0sMDOvgxetDYFb06syvbYIncDdiTe1HWM2XrpKLB+ExmML5spDiYLP6viSIKpNKemr8XHUgWm7kE3qRmc9+QQLX188QEc0zzjB2OiCqJfe4+1e3CvNbY1PmR2taeWJ5j6TPhIvfksDCL/0/giB1yUduXCxgGO3sbSJv30Ddy9XHqaZHoLxvUgCfjFBYChKfszzNVjGlUk0450V2mHguwaW0EUkArlYrYf82R3ghyDtSuONG7tXnBak6ITrwtfuTZCQiRLVExSzUiWQLfVWeiHwUwqRZpzHa2QN02GwecCkPPKxRbWm2Kmbdk0sWopFlVclhJqm9sGIB5kWpsQSULBGX5qide9FZsFs746Kg/4HIWO3lAg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z05Ncnc5L0JndER4cm1xV2o4MHlGOUJKTVdoS2RFQUYxYVF5VmQwZkVYS3Fm?=
 =?utf-8?B?T3ovYnpaYmw3WXB0MG9HOVY0WnRiM2ZnMVNnTExBSTVrZXV4Ylk0a3U2dzNQ?=
 =?utf-8?B?dGlXbmR3UnRRT0YvZmU0TmxpcCtCOTZualI5NHp3WTlhOUVRQ0MrSnVBbzRK?=
 =?utf-8?B?RExxVXh0a1hMUngrQWJEcTVuTm9uc0tJTGU2YW01cXdOUVRWQzkzTEhFRzFU?=
 =?utf-8?B?SGZsblBSOEFlYjlWTnM4eXpsaW1scG9IUEZOSVh4Zmg5V0dKNlVzZVI1WUlG?=
 =?utf-8?B?bFNFZy8vZXk1cmJRYnZWMWlPV2dVKzQzejdSUmdIZTlXQ2Q4S0pTOVRsNUZM?=
 =?utf-8?B?TVBpOTRpc2pFTCtrYi9iV3NpQmIwTDVObnpzOW5rSlpKWHBmYkdzUmZkMGZa?=
 =?utf-8?B?U3lvRHM0cjA0anpPODUraWFiYkZ4V2FuWUgwN0h4UThwRVArWmd4alBlNnMv?=
 =?utf-8?B?WDhXbStSSUl3UW05NEdydjFsdXRZQXJ6bDZIbXoxTGEwRHZKZzEvWFI3UjVV?=
 =?utf-8?B?U210UUlOdktsNkUyOVdHb3NlZEZBUGplNWV2dmpzUzIzZWVYbnBxSUl6ZWly?=
 =?utf-8?B?K043eGRXY1dLSENEb3dIanNWZExCakpyWGtxRE1XVXgzOEJzRWZOZE1TZy9o?=
 =?utf-8?B?NTdxbkoxaCsxVDhyYWplbzBQT3ZkR1BOak9SUHd1MUt3VG9FWkRhdjJJcG85?=
 =?utf-8?B?YS8vZXZYRVdhRWR3T0x2aVg3YjNxeTZZTURNczE5dmxDeWlPNWlTWkNSL1BY?=
 =?utf-8?B?bSszOVJqSXFIUTJZSlJrMlB5NEhocExWS0FXOXQvQ2lWRTVNSTVOY2JYSWpB?=
 =?utf-8?B?d01uYkE5cnZ5bmNHd25PR2hXTUZhMmpJMmQwN0FpQmFxL202U3lHQmdoMC9D?=
 =?utf-8?B?ckNKaVBQdzM3VkFpaE9taENkTkhuMEc4a3A0TnF3NEIrWkk3SWJvY3V6Uk55?=
 =?utf-8?B?YU1jcGhjNFdoNlNWbEVRUTJwK2FjN3FJUCtqejF6Ykw3RHVKdUhqeW9YNDJD?=
 =?utf-8?B?amlUSVYyRG9pSlNuS3dQbXpPWlZuUTZzWUlwSk4rREw3WUlQT292bTNMVGFk?=
 =?utf-8?B?SGFjMWt2eWxzenVCV0VtWU4rcmdEb1ZJYWhUSWtPSFVkajB4ajFBZ2w5Wlpy?=
 =?utf-8?B?bXcrSW9henRUZ2svRWtTdUVZSVZSZm0rUStZZE5uc3J4RkE0R0w0Z2pjaW5Z?=
 =?utf-8?B?YVQ3M0tyRno2V05YNVBpendvUCtISk1oWWU3clJseG8yV3ZOY25BMjJROG91?=
 =?utf-8?B?b2gzdm9MMHMrbmIrdlMvYi9ONmUvR2prb082QVJkWjJuKzFDMlpRVjZlbjFW?=
 =?utf-8?B?QngzRXZrdWIwYk1FQ2Fzd0xQM2kyWktCcWJ1WUtPcmVZR2FPbG5odDh3V3A3?=
 =?utf-8?B?WFdwYmxQbjZQaDVYWnRaQkdrTk1zbmthQjc1SXUzOEhocXpEZVZncEowTlZs?=
 =?utf-8?B?Qms2b05rLy9NYmhlQTRYNUxQWXJwYVg1a3ZFdzRqRWUzWWx5R251dVEybmhh?=
 =?utf-8?B?eFdOdkNVUlFQVGJkQ1FvTWhMejRPVWVnUGNON0RlbmZEK29PUm5hU3Z4U2lU?=
 =?utf-8?B?RkxwQnNFcS9LYTZuYVJhT0xWb0JtSHRwVDhSRTdmdnp0YzkwL2M0K29LVW9M?=
 =?utf-8?B?ejlXZlBHVWtaSExJYW4xUndBd2dtU1dMNnNpc3lNZFVDYytsUnFhUWs2VTNk?=
 =?utf-8?B?bzRGTzFPVjREZW85YTYxVFRXQ2w3MVN1UEdvY3hiZ2RBbUJCL1ZOQWw1dml5?=
 =?utf-8?B?ZS90VnhvaGZkN0lVY2pSTjVSdzdzUGdJMGI0MWhpcE9Ld09ESTNxMkZEelo0?=
 =?utf-8?B?eHc1cE10cW5VcWNZOXU5dXJzbWJXVytVZFE2NnlFa2dxZUhqSnM1dGNpSEhG?=
 =?utf-8?B?T2ZJeGY1YkNvQVZPRmV4MCsxbHo0NURMcFhRSmRYaHlHdTlLV0tPVk4rdjl0?=
 =?utf-8?B?QTJVc1AzM1ZOV1ltWmhMd3BuZDdGZXpleU5sVENERTZheEZZSjIrVVprSjlE?=
 =?utf-8?B?VEh6aEoxKy9FNDhtQXNUOXNCb1pJTFVjNVBNWXZYQ2VGM0hsRXBIQW5aT2R5?=
 =?utf-8?B?ZWNzMTJzWXlPbyt4ZktranRIeitjRzlpd2FiRmJJYXd1SzBKVSs1aDVFd2pZ?=
 =?utf-8?B?QVBXUWF5MjE5QkxadVVySXNkOWJvYkR2MFcyZ2VwZVhSbnBieENWcFRpUUsr?=
 =?utf-8?B?cjVMR01taHpERVNzamtHaktHTi9vRlBjWHk5am1NV3kyQUdLdElCWnR5YkpN?=
 =?utf-8?B?SnRyT2pKZzQ0UDJPTWZsb2xoQ2ZydE5mN1RheHNRamQyLzl0dldRRGo1LzJi?=
 =?utf-8?Q?OS33vQYzpuGM0t2bg0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88b51d7-4a73-4e9d-b823-08dec78fb987
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 08:02:04.1722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9Ieec8W5GNnHevvvWWrKeDSDvvpHyAMm34tm5sASpPik2PfNYwk289Hx6uDwMdK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8523

On 6/10/26 17:02, Andy Shevchenko wrote:
> On Wed, Jun 10, 2026 at 11:11:34AM +0200, Christian König wrote:
>> On 6/10/26 10:18, Kaitao Cheng wrote:
>>> 在 2026/6/10 16:07, Christian König 写道:
> 
> ...
> 
>>> Should we revert to v1, or keep list_for_each_entry() and
>>> list_for_each_entry_safe() as they are, close this thread, and make no
>>> changes?
>>>
>>> Link to v1:
>>> https://lore.kernel.org/all/20260529082149.76764-1-kaitao.cheng@linux.dev/
>>>
>>> Or do you have any better suggestions?
>>
>> v1 looks perfectly reasonable to me.
> 
> But why not just hiding that once for all (in case they don't use the temporary
> iterator)? Easy to automate, robust — everyone is happy?

As far as I can see that is an extremely bad idea.

The distinction between the use cases of 'iterating the list' and 'iterating the list while you modify it' is completely intentional.

See the bool type can be implemented by int as well, but it is just a different use case.

Regards,
Christian.

> 
>> You should just include some patches in the same patch set to actually use
>> the new macros.
>>
>> If you modify the files under drivers/dma-buf or drivers/gpu/drm/amd to use
>> the new macro I'm happy to review that.
> 

