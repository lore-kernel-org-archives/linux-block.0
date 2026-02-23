Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6249B2874FE;
	Mon, 23 Feb 2026 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860163; cv=fail; b=GM2KPLQ0paqonc1uQcS7NmRWHUpaKzUyyGnakNCA2tLoTPIEmHChGWxpyTNDAjSXluKnn9knc0KdI/SSjVfC36zfXRIennXFrBM1ZSBAO+nuElfNirnzO8zz8h+sL/xnoP3T2ICwmLpwLqRr8mQI2rPA1kHqvLAGvQB3ZRw0S3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860163; c=relaxed/simple;
	bh=jKWwpiA4tn4S0F/L0gHj8WRjp0yCIkCm2d2dhJ8IEr8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kh4+D2o6NclacW1Wy/tljPTzjB5DHTiKu/2rFLuTtlcTyxTF3vgfMh5YJI6sqWtNP1WIem10dgDLVQQfAWexObjoeCOFd0Ixnok9WCiRokcQKDA1mEDJqtygqWmJhWO0LMBc+0n5rnzqwXCMqmQLP+PUb5urpSkRpNC6rCcDAuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1R8fHFBg; arc=fail smtp.client-ip=52.101.62.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1R8fHFBg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGsWoYQEn5BteuaHUdwewRBKmYId9br1Xf6oKr6/Zl7DWDjPheceNAH/A9GQtJN6sZ9ev0wVoAvBrSxJ1Yzz6kJIo4c/fDMqbm+OT3SxGkXhcCBZKJHgh1dPXXH8t30Otp5Poq5wVD+xj70R0PAFusrJi/vCRhZrMCE+f5BXYkNjpJ/iGqbSb1Z63MeTVeJem80sID8XT2VdGLhHpUxkXNbCh4I9ngrgTV5NWy0sJqXAFdu8cLZlsdxdYQMa15iOQb48gYJVG2/qXDUwqAM3Rlmcoh/kLgMBf01EJNZiOdARyYm5fGutnubM68UhwktWGUAWQcHVq19AXPcHnopfNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1a8DOf85OXZZ9cRZWI2U5OsHQxBvst5ogD53MlLBsMc=;
 b=JSoLMdD4Az83v3RXlDrRqYALtLtGtQWY0Qi6ZNNn0jClzZh+tpcJb9Ymqw6eAF0+1DcRmMi3G9eJjkZMLr3iOdDa0VhW0HwYUwMm/Ld0y0EV8PhJdjGVVq5MRoycTj4ziqCyqL+EOTIEzhl9yK1FFpMgLSMIZesZh1fyw3othDVtgo/qI6EBmBdHViSU0mAoMKLbZ4F9rrq4dcPAKYNL262AwNUn8oAilgAK0zblPMp8pTWw3xqGQqv/ETQMvPiUDJ0AZqDiWly/qIWuHKBbr3A+7kT5+pdmQbhfMMEZasMc4PNtZqJ1+TQjKe3+RHlmWLWTxce+RlkWTLsL/4jXKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1a8DOf85OXZZ9cRZWI2U5OsHQxBvst5ogD53MlLBsMc=;
 b=1R8fHFBgUVgxvXX/8n38SAQySgwHRMVByiGxuhLHkUcWANG+m5bqzIFlDRcX1vlm1yqVaC2efQZi/O9F//d12ZvHwscIAwdb9oCEvLEZ+BnIHvreo9BfmwtCa2cQEW3oe5zVdkXnXQmFm42uiKzxe2IbwIr57p/t6qLfjOHzST8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB7096.namprd12.prod.outlook.com (2603:10b6:510:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 15:22:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 15:22:31 +0000
Message-ID: <da2f5f7c-0252-4085-a490-a505d0169bc4@amd.com>
Date: Mon, 23 Feb 2026 16:22:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/11] Zero page->private when freeing pages
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-erofs@lists.ozlabs.org, linux-block@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Eric Sandeen <sandeen@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Carlos Llamas <cmllamas@google.com>,
 Alice Ryhl <aliceryhl@google.com>, Damien Le Moal <dlemoal@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Gao Xiang <xiang@kernel.org>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Chunhai Guo <guochunhai@vivo.com>
References: <20260223032641.1859381-1-ziy@nvidia.com>
 <aZxaIEFZr2NvO2eQ@infradead.org>
 <cb8d6ee2-fd1d-436a-b934-aff87adf5dcb@amd.com>
 <5105764a-8313-45bd-8b91-8c0ea8cdf077@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <5105764a-8313-45bd-8b91-8c0ea8cdf077@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: 3364a66c-0ac8-4d55-5507-08de72ef5c87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UG9uNWhBRUZOUXJvUHNQNjhhTjFDenRMeGpUdlNnR1BUY1U3SnJrbFRoWmxM?=
 =?utf-8?B?RTNMZ3dRb0RjVXJIYVA5RWtxQ0lGZlhjWW1pMDZIOWRxaSsyVDBrcUZIOWZa?=
 =?utf-8?B?MlFjZ2MvRDI1M3pTc0ZrYVlDdnhvRDhrbUZrOTBVU1hWcXZwOFMzV1EzWXpj?=
 =?utf-8?B?TzZqeFhaR3F5T0p2eXNUT0Exa0h6N2xCQ1Vub29zcCtkakVxRmkzcWJUK2lu?=
 =?utf-8?B?VnJjM0FSL3lLS1dROGtwZU9EaitWUmZzQmduL09ZNWJYY3JIdVhOdUFrU2dG?=
 =?utf-8?B?N2VtMXZ4MWJtWGxRWnN3VWhEWWc5eU1ObVpiNEF2ZnVKendib25WdmNKZkNX?=
 =?utf-8?B?eXpCN3diUVc5LzBYYVUrYlM3THJUcS8wZUJUZG00QktJdldHdGR3eFJhZE9h?=
 =?utf-8?B?c0JlWWFwWG5qRWpramppZXV0TTJtZ1o5VHRBdlVGYkZJNWlRQ0pMaVdhQmVY?=
 =?utf-8?B?dk9ZUXAwYlZHa2FWREpuM3FFUUxFODBCSFBvZ2lsbTdLbGtJY0c2dFFBNEFr?=
 =?utf-8?B?WTE2RXNkWWVZWlBZN01leEtTUVl4aFVxQTZuS0FsWUVQbHZFVDVqakI0cHdm?=
 =?utf-8?B?eGtQU1hVZjRYS0dlSVdaNDFSV2ROSUpCa1pzSmdXeGxYUGdjK1RYczd1UDFi?=
 =?utf-8?B?NU0vL0w3MEcvaTR1d2FmK0tsUWVWUmJzdkhheWVDVHpLVXlWdCtDVFBPT2sz?=
 =?utf-8?B?Z3ZuMnV1VjVKcFdpdkVrMy9rSWVBYUpTTk8yeDFQNVB2MXRqL2Z5Zm5EWDJ5?=
 =?utf-8?B?cStOZmdOTXRYWmZpSS9FOEJYTW1CN3NZL1Zwc0FGOXU2OWd4eXJOQXQ2QWJX?=
 =?utf-8?B?MW14UjNydlVPWVhubkZzanYyTk5TUk9ZWW9yM0MycGVwbVd0STd4M2xxUVJk?=
 =?utf-8?B?eC9VVkQ0UlBKVmFqSnpLZFdlNlRhZm8vM3phL3JXa2Z6NzgvZnk3VVNrY3pv?=
 =?utf-8?B?RzRqQ25BUmVEbjVsSG5TWm9sVU9rc2syTXo0TnBIN211TUpjWngwT09vNzRy?=
 =?utf-8?B?cWxMVEQ5YTdoL2dQVy9iZUpZQ2dJK0gxSWxIMFJPbDJuUGVkbTBOWFJXSU1y?=
 =?utf-8?B?UzhZTDMvWUpVK004TGJLNU16bzVWaXpoZTh5R1JqRG9tbEtGTCsyMmZreG43?=
 =?utf-8?B?NzBUNXJqOEU5TTFTWEFNOTVrZks2S3MvUG0rU0Q2amo0anhhdWFqTTBPbitw?=
 =?utf-8?B?dHFkMzJPbkJxRllHd3RhZGJub1dtbEpYdGM4Y2FWYWtDdm1hUDY2QUtOdGNa?=
 =?utf-8?B?ZDl5M0g5aFkwRUJ4dStVTWNkdnk4UTlrb3ZzdE9WQVoxSldzdGtvS3JkSHFj?=
 =?utf-8?B?ZmpRZHhLQm9TQ0FTdnFPZWN6YkpvdTB2Rk1lTjJYQmZta2hUMDVIM3Fma0dt?=
 =?utf-8?B?WGlUNGxUWGVXUUJpaUJpK0ZEK1hCVld1NG9ta3F5RFI1OW0zOXZQQnlDZlIv?=
 =?utf-8?B?V1NLRkZDZHM5clY4bjNPRkdBWWwvTTVuRG1WcklTVFdGZ2RrQlY5c2JjWDJC?=
 =?utf-8?B?QWo1clRzWi8wUW9yVTBrOEhCZHljaEdqKytkUzNhRnZTM2hWZitlQ3Y2eHly?=
 =?utf-8?B?QWdVRWZCSUt6d2tSYjQyVDFicGFDaXpuQXBpajVPNVQ0NDFaTFp1NzlhM3NM?=
 =?utf-8?B?ZkZBM0VrWi9vcEdVME1ZMkhjdy9zOFYybkJJNFIzVmVBUEx5MWh2TUFIZmZ1?=
 =?utf-8?B?ZytoZ2RjUnBJdjYydXo0YnFPRUNUZjRXT244aDlpTThRSUhsQkoyaS95WG43?=
 =?utf-8?B?dkpnako2L3NhRjRTRzNPemtkb1lwSFlGTGpMWHJnNTJUOTFFZTR4alNUQnJR?=
 =?utf-8?B?bnN3d0dINU5EUzNVRlpnKzl3VmtCZHREdGYzbHljQzZRWlI2UTdHMVdHeUQy?=
 =?utf-8?B?MFNPQmwyQVR1aGdSdXFVNjdJRlFTczBsUFJYc0t3dFhpTWJEMnVRSjJXWHVi?=
 =?utf-8?B?aWVCaEVDdkFrN0x0VnRmUWxPcXV6eG1XRGhVeEQ4VzZpb2R5SFhmaHR5Z1F0?=
 =?utf-8?B?YkMwV1VRbFBQSkxvTGZscWlXMzhvYUhvcjhaaW5tSFpUS3JnUDg3L2tiWmdH?=
 =?utf-8?B?cFlKRFpsOTY5amNWUE81U1QyVDM0RXZwNTA4bWRtd2VjSGJuQVo3SGI0ekk2?=
 =?utf-8?Q?ghgQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEtrTmdLSHRMditnMmtZVWsvQmY4ZlZ5VU1BeVdQa2RvS0tGY0R5aVY1Rysx?=
 =?utf-8?B?TmlXS1g0SzRXMktqMVdZQzRoTTNaY21lOHhFL3lrZ0thUkJ3Rm5wemNZUmpG?=
 =?utf-8?B?WVprT3pZajBxTkNMcy95Ynh5ck1rQ0FwZWpuRksrelpQYjVxWFZkUWtQSWV2?=
 =?utf-8?B?bTVJSXRIU0U5WkZ5Szd5NnEzNDIvbnBnMHhnTzZGVlE3TkZFRWtXb3JBeVA2?=
 =?utf-8?B?TG1FK016Y2dxaVN3cURWOTNURExHbERyTDBTbHBNL0l2Ny9DUkNiR3ZPeVRP?=
 =?utf-8?B?RjRySTR0QjRjb28yYWpJeHJzd2M0NE44OHlaTE1MVHQrdnpSZkxSdFBKUDZW?=
 =?utf-8?B?RXhUU0lwZEl2S2lCVDdhYUI0TVl2ZFV4Zm96d3VTK09kSnl3MDEwZ2dYSVJn?=
 =?utf-8?B?VnRwWkpsdjNwd1BzTmxmUmtPZDFzTFNZYk9UNG92TU9QT2ZuamdNRTl1eWtN?=
 =?utf-8?B?RjNBL1lnc2cxVHNCbkNXUnJKcEU4QWtpQkNXeDNVenV4Ly9paTNoMXl2emFK?=
 =?utf-8?B?N0N3ZHB1RzRjblFZajJKN2pTTTBDQzJXZ3JENm1teGs0QmlvOUdabXZrOXpQ?=
 =?utf-8?B?ZGowcmhDVUJxVDV3a2VNRXZnL3hvOVUvMWh5MWVtcHp0WVF2WmhmNmtYK0ps?=
 =?utf-8?B?dU1GZExEajVBQ2hVbHNsWnUvc3pTNnNVeG5RNExVK1VoUmhTUjdGM0ZWWHN2?=
 =?utf-8?B?b0hQL2lhc1ZkMmtyOTYrU05qRkd1S3pQUzdWTDhvWGxWMzdIb3VOVC9tWnZ3?=
 =?utf-8?B?SEpvb2ZRTmJRbTNlMmZiOTlmdTMzZDZ1MGg4U3JVTTQyVUZ1VGZMakRKMmp2?=
 =?utf-8?B?eTlkSjUzZzVVOVBHOWp1WmgyRDVxTkRBK2RPMEdYdkNGdkZwU0pGdUNHMUlO?=
 =?utf-8?B?MnNVRVhTRThPMERLcnY5VVdEM2V0NFVnRkducmFRWG1qZ0FHTVZFRXdhbmpB?=
 =?utf-8?B?cXpnSDI5QWdaUFlzWmQxOWc3NlR3VHAwTFpZc1JmQ2h2NjRCZWEwL3N2cnBK?=
 =?utf-8?B?WDF6SFJQcWtzYlBaZm5sdHlmNnN0SlJSSHF0cTRzdk9hSEk2ZjRIZnU2UHZ4?=
 =?utf-8?B?Wm9ycDF2UU1qcnJsMGVFaU1nclh4QW5pSm51ek92L3QvbWc2S3lhcGUyZ1Fs?=
 =?utf-8?B?dnM2cGZaVUp6ZHd0eUNuWGlmRTRQdFZRdlBKZlE0TlJobGFGYWJHRER3ZHBG?=
 =?utf-8?B?SXdFTVY4M21IQ3ZOQ1YxdTg4Q3lReWJVanVZdmx1U0RxbXdWbkt4Qjh4NkNX?=
 =?utf-8?B?QnhhK0dsQjRpb3p5amJ6R1MzclRiY200VFAyZ1FDYnNwSHlVZnQxbVE4MHdZ?=
 =?utf-8?B?Q2pnRGh1azc2RUF2TElLNmdzNnpHNU9LWEpqSkFLMG1XRGlQMU0zbldIK3V3?=
 =?utf-8?B?MGlKWXVUOW9LTHMyMlhYeXJleDBQSVAzSElFT0dON2g4VUpFVHlMeENodDY2?=
 =?utf-8?B?K3JZL3RJOHRDSlBrVENxY1hNck1JRVRWWkFJQ0ViTGkwTFJrM3dpTFhXTVlB?=
 =?utf-8?B?R0RPK0Z3SUpCd2ZlVitIZGxzSy9xUHd1bDR3RXNmMUhwSG9EeWl3OXZmeEpP?=
 =?utf-8?B?Yk5hOHd6S2RqeElNajNIUDY2bUl3VExzUFBYU1hPWGNYcUtuQUVyZlZuSjJK?=
 =?utf-8?B?bzNsRHhuc0dTR0ZORWltcEF3VE1EQnJubVU1VFFiRGkxWDM0MmQwZFZXQTQy?=
 =?utf-8?B?Z0FjemVSRUJhRkhMRFVWYitFY1pyc0UrbSt2ZXREN0xvV3d6RVBwbzg0dDcx?=
 =?utf-8?B?Y0xQYmx6VGh1aWxqTTQ1RXpPYTcvU3ZYRXRENzJMVkZYZUtrVmttcVNqNjZk?=
 =?utf-8?B?YmZidFk0amp5enRqYUFRM2JlbVVSckF5ZmZWeFpPVk5Pc1ZmdjFTUUtaMEVP?=
 =?utf-8?B?UHg0NlFzL2lncHJMN1BVSnpBNXBDSXBGb0tGdDluOFZHWXpnTEZOVFhOclVx?=
 =?utf-8?B?d2F4Uk9xNzZpbE9ING00VW5vRnJqa3Z6d21MTWlOUzdJZVM2Q2V5eDUwSk1T?=
 =?utf-8?B?cHBENitMNEhrTE1xUjk5QStsSHc2L1BZSDl4ZzFrVHFTVENZQnJBS0pFY1k1?=
 =?utf-8?B?OEVqbFpDMzFZbGNQVk1CQnd1OEtGcFZYeERjUWNEbHFWTm9aRUYrUEF4MzBq?=
 =?utf-8?B?bnUzdTBwT2QzWlNpSnpjMmFTSWhoZ2toRzYrZ3haMW1KUTJ6QXJMeDI0b1pv?=
 =?utf-8?B?SU52clpaVXNsYnZkeDFIaTNma3ZPdTF3ajhIWGQ3TjVWNGd3dUFHYSsxbDV6?=
 =?utf-8?B?WDZMeVQwNzdqM2x0VXZqeG5SNEdPRWxNRGxIM04xMUNCd1JzZlIxbFV3eUp6?=
 =?utf-8?Q?oNt/DRR6nbShYklv1Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3364a66c-0ac8-4d55-5507-08de72ef5c87
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 15:22:31.2876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ObwsaqhfVgEujivvym37aVRlFcjn2SUWXLOtHZw8Y5i7PdnDsTHnhcYGobYklASG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7096

On 2/23/26 15:14, David Hildenbrand (Arm) wrote:
> On 2/23/26 15:06, Christian König wrote:
>> On 2/23/26 14:46, Christoph Hellwig wrote:
>>> On Sun, Feb 22, 2026 at 10:26:30PM -0500, Zi Yan wrote:
>>>> Hi all,
>>>>
>>>> Based on a recent discussion with David Hildenbrand on page->private
>>>> is not zero when a page is freed[1], this patchset is trying to fix all
>>>> users do not zero ->private when freeing a page and add checks to make
>>>> sure all freed pages have ->private set to zero. For compound pages,
>>>> both head page and tail pages need to have ->private set to zero.
>>>
>>> Requiring the user to clear a field before freeing is just a way to
>>> awkward interface.  Don't do that.
>>
>> Completely agree. This is just asking for trouble.
>>
>> The cache line(s) backing this struct page are most likely accessed anyway on free/alloc. So I don't see much extra overhead.
> 
> I think the question is more around handling non-head pages when freeing larger orders. But maybe the overhead of zeroing page->private it there as well in __free_pages_prepare() is tolerable.

Good point, sounds like that is a bit more than I thought it would be.

> I'll note, though, that we already require page->mapping and page->memcg_data of pages to be zeroed by the caller, so it's not completely crazy. (see page_expected_state)

Well that's not defensive at all, basically everybody which forgets to do that can cause hard to debug trouble. Maybe that practice should be reconsidered.

Regards,
Christian.
