Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0CB206296
	for <linux-block@vger.kernel.org>; Fri,  6 Dec 2024 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505563; cv=fail; b=ivnIBqJ0rUakicqGD126rPIKs8s4vpQxQ30+fS6YXL3iOjnOiEdC7U9IUwy5KVzFYKiHaZa90WZyPnH55r/cz3UdZQd47IQl8sHYU8tZ1VHV20IkBSnz0KvG0tuRLYGfzQYSujCtGkp29XoyWpSylg4w4zvNRDDLagYpHm/NEpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505563; c=relaxed/simple;
	bh=3yBtrcX1YQP3xOB7t4VvHMznk6gKehSiQtKE461wUlM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bTtx/gmqKa5Xs7O3VhJjfqMACGN5GfSl6u0CY710bmGUlJ3KxLqRjbssVogsEUQ5LZFEjHJiru1yMne2r2N96da0cZlZsz5HWdOj2aSY0QezKnaOPOSJ085XY3GTW1lhF/MvRtdSAj0JWQRyMIpvzIlYIFhfZ+Dk5EYgpy7DNjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VEReRbY/; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VEReRbY/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733505561; x=1765041561;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=3yBtrcX1YQP3xOB7t4VvHMznk6gKehSiQtKE461wUlM=;
  b=VEReRbY/k2g4p6uUU+ITohOcMkGJrPp3naugRqWyqT00HhyJjSUuIxOv
   qyG0ekSVCmw5KWSGAuSmEditM9mqjxPqEb/+i8ifc2ulVj01p/4DumU2/
   9p67v2Nhm6/imLEoaAiSA87LP3wvbXi0+cMJLkj9BJV0rj8oNsdA13Wly
   Bvno6zFIEiB/JvRw4PiFBgohin+mBf8MtU4SxTNpzIHrIAjmtd3giZrk6
   vTpDr7Wbkb0SIzxfOV4+0dJhsAy0mpKu5+EwRa1ETLeop0MUIudlUD/lP
   p8+sU7LhSe4J1H0VOAuHE91qVzWmxBL5SpGU5vBM3vXfSL0bm9guC90nl
   g==;
X-CSE-ConnectionGUID: w/HmdO4JS4mgMbohnBmYrA==
X-CSE-MsgGUID: uxp41eHsRTOaihMDu5gnSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="44537833"
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="44537833"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 09:19:21 -0800
X-CSE-ConnectionGUID: kYkHcf5ASOKsgBzjYTKBRw==
X-CSE-MsgGUID: OacOXOD3SWyRrtqWAB/Qrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="94946421"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2024 09:19:20 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 6 Dec 2024 09:19:20 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 6 Dec 2024 09:19:20 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Dec 2024 09:19:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+O8ZjuVm1dR5q7w2R/TRa36ajLwhT2OyEvVSiXy9Hn1i/9j+VUzNfP0oh8+ueIPWggNN7DocMGSAwUteSEVPBXCQmIWkGDoxAT6nFN5LWnr5u4XpdUwslG/YDCsj1XHcZh4AuVtyFlM/jLhIKGB+MILXGc56qobR6Z8UMTWJLGAMkrWji3NlI17BHIho72rCG/ZOIqYmu79asK2Gl8XPtNizZCTsckHNAY2Dm2GNIVwpqeN32y9K6xSGArfWLsX4m+2ZiXVK3TcBGkmHARl7ceJR01cNZK8uDXe0FsjIEY/YIbSA3qDPSZxijq0eGuzzyma250JXYMRhgvnV6mxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JfGAK5WdcxzYylci8RtPwNbvPw69YjL8teXc64bzfc=;
 b=FVe4OmeVpqBDlRxe3QTRYzv7t+wJ2uRiOWfoFUaZYcnbclUkshMR4OkoR38mQLxy6Et7V0nYZ6nIh4iyhBop6aKeLOYApy0tHNSQb+a84yyx90UprfqG3HoupVWGGhvatyOiZ5Yo0aHpgRcUUH22it2V31A48kYdcP1Kb0CB8VG/YoULR6xr6ZIg3bMxlNQZIEftoHQWncB625ggKUfRJl5IQ+0SzVgPfzdmUJCiAsB+PEguGVaCJnWcY7O8+FBToGJVlPepyyfwXP2u5Pm7BV8nIJ8li0nfqsORSOOoGMDkxJk7TnV6c8o5SEsKVLBmRk0DK5j0QGAhnlU3xharTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN2PR11MB4695.namprd11.prod.outlook.com (2603:10b6:208:260::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Fri, 6 Dec
 2024 17:19:17 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 17:19:17 +0000
Message-ID: <3da2fabe-772c-4984-8380-724a33bc820a@intel.com>
Date: Fri, 6 Dec 2024 09:19:15 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 0/2] blk-mq: fix lockdep warning between sysfs_lock
 and cpu hotplug lock
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>
References: <20241206111611.978870-1-ming.lei@redhat.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20241206111611.978870-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0377.namprd04.prod.outlook.com
 (2603:10b6:303:81::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN2PR11MB4695:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a6e98f-33d9-4db9-38d2-08dd161a1d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tkh5NithaVdtenRhSnFkK2ZoWTRYcGkrS1o3T2VFVFd3UUJyMnY4b1hkR09i?=
 =?utf-8?B?Mm5TakJPbDNCZndXRzc3am5xKzhDeTRQWVFaRk5nTG9rNFp6OGpUK3NRbnUr?=
 =?utf-8?B?Q1BiclZIdkZ3RFVTOU1LcmlibklMQytTYzRWeXVPUEVBZnUyZjRxaEdYVW1O?=
 =?utf-8?B?Y3A5VzIyWUY4WGxKc1pQTXpkM2p0Z1BjR2htOGZVd2FpMDU1alhwL0w0Y0pm?=
 =?utf-8?B?dzhqeEQ0Q1hhRGZ5dWgzWlBSdENrQmpnWHFGc3E3czlLb0hQNytDQnFxSFha?=
 =?utf-8?B?c0dOVDJiUGdZZWJHRVE5amprVkxXTVJMUjNZd2wyMjJodTdMWS9rSFBMVEhp?=
 =?utf-8?B?dlluM1BiY0JqUXZIM3RMeHRlVzFxd2s4KzZVeTZsYW1NQk04bEZpT2hVZ1pr?=
 =?utf-8?B?R3duSkNqNkVKcGxWZWxmamFzUUczNVNyZWx6Z1JQcklPZ1ZpL3hiN2lLUzEx?=
 =?utf-8?B?TFN1V0ZuQ2ZEbTJkVE84b3g4R3M5Tm1abXBDNXpqY0VBeWxSYnNhakRuQWtm?=
 =?utf-8?B?V283WXN0RTZRR0JBYVFUbmUrK25pQnBZME9pWUlhREpSSldpY01zMWdRVVgx?=
 =?utf-8?B?NjZqQy9kZWhHQlgySzhwbE56bTBxb1NEaksyd3EwbDQ2Vy91NC9KdG9IdExz?=
 =?utf-8?B?ZU00dktqTVZnRGFSbllmcUVXYzRSR1VNRTRYZlVrQXZvczgwQ2tFc0R1MVMy?=
 =?utf-8?B?b3VKNGMySU9qQnZzRi9nUVlhUlM2RHJ2K1ZXWndoOG00aTZmc083TXNldDcv?=
 =?utf-8?B?NUpROWtNSDhxZ2tnZmoycmJLVkY2V2pyUEl1Q2Qyb0xSamlJaGt6d0lpcnBZ?=
 =?utf-8?B?a0tvUXhsZEpBMU81eWZRYWo4aVZoTEFDZlBXbDdhUlgydS9LQldtczZEM3JD?=
 =?utf-8?B?RWFNTTU3Um0raFN3Q0ZBeUxNWWh2VjF0UUNFbjJGclEvYkxBVHpWTzcxSUlz?=
 =?utf-8?B?R0RWQWRqNUxBQlpZdVI0OXNZWEozSUwvWS9qYVg3MEFGZVdCcUpzbFVaRS93?=
 =?utf-8?B?bHEzbWRqUFI1QW9EZnVqWkFuZWwvMWJ5ZUMwM1RZa0ZiSlVEakQ0SEFiUW5w?=
 =?utf-8?B?akg5V0cxSXlvNVFHREFQYzlKS2J0N284WUJWbzQwK2ZYSzNqM0hqVUQ3RndW?=
 =?utf-8?B?VDV3bmU2NDVPRmp6djBVbVJsZUxURmUwT2FjVjhGWVRwQVVyaEx2UGIyckFM?=
 =?utf-8?B?UmRyZW11SkV1alVDVFRaMTcvR3N1OThmV3hDZm1nS3hPN3VSamczTG5GZ0JM?=
 =?utf-8?B?TG1QRmVzUG5jdm51dnNVNnR5azlHRmxDYkkza1Z0NmxTS2Ixb2t3SXVOTkM1?=
 =?utf-8?B?UDBLTCtPZGx5VFJGSU03cnBiTW96VkpUZ0NZWktkWHJxcWdFK0xyaFZxZ21E?=
 =?utf-8?B?Y2hWd1BTM28zZDZQS2w1R0lEcDJWSnNpVUVnQTlsYjd5dWtIUmtQZkpxa29K?=
 =?utf-8?B?Tjl5WHNjZFRjMVMvby9odlp1UERBVXFvdXpwc244aHgzdXJNZ2RqMG1Fendz?=
 =?utf-8?B?b2dSMjBaTlhmWXl0WHFPUllJWEVyZDNsejNCZ2ZOenlBQWJFSnZwNVlzNXZ2?=
 =?utf-8?B?MkthMjZZanVBSVVXWDhEdUlxWmZEdm5WU3pHS3NyeE5rT21ud01EakxzT3lp?=
 =?utf-8?B?U2RwUFhLTkExOEdsT0JrNmxidk9mSlpmWUJGVGt2cGtqLzY3dElKc2NVaHUy?=
 =?utf-8?B?QUEzWWl0ZytMdjNXTHBCVmhHbmpnYjJ5YWF6MWNNQTlKdGRQTmxSODlNU2x5?=
 =?utf-8?B?dGllaVhRajdDbjlod050YWZIQ21nUnhEYVNBQXJrR1ZHL2hHTTByajA0RHpY?=
 =?utf-8?B?VndCeXgvcXRUdk42NmZwdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bSt6emhGWHRpdnFGeEVtN212YXpxSXVGK0ZFTU9neng1Z2lBUzRNa0RVTmto?=
 =?utf-8?B?cm5xNEgvbHE1YzlJd3Nab2FvMUNybGZoMitmdnJ4dUIycHU3OU9WQ2gxdlN6?=
 =?utf-8?B?WjA3c2UxVm84WFBoZXhoYmhVNUxsRmx3Tit6Wk93K0tWUVk2MEZpT3ZiZEdL?=
 =?utf-8?B?bEo2RldqbFFXbkljaUpob0lHbUVtY0IyZElaYVVxbFl2V2dhcWExRzl4OGhy?=
 =?utf-8?B?QTNpdnlOU3cvcTlIMk9heFM3U2JGZlhUUmRpWXI5YS8zRjBvWGtYMzVtWXJm?=
 =?utf-8?B?M01QUG5VZW4wRnNjT2pFd2x0YlhNTmpNSGEzRTRKSUtvSmk5SlVlNFNvdzh0?=
 =?utf-8?B?UnZSUmo3aDJGSjdxMU1Sc2JMMnZ6YkhZaUFZUEdhNDZ3TWVZdVB4blhYcXFt?=
 =?utf-8?B?dXYveVl1NGpiU0dLRmxlN0VWdlJXK1I5aENaRDhHa2UyRitxK0FWZ1IvR08x?=
 =?utf-8?B?L0I2WXpkbDNqU1JZekVGZ28vZTdGQkZoS3dEbEtWQk5ucUM3RHlxYWdYSk8z?=
 =?utf-8?B?NHlidHl6L2VMd3U3OXNCN3U1UmlvdmpnMlVFSjBzOVN0U2FSMXdjT0JzbUJY?=
 =?utf-8?B?OFRsOTVYVnd1REV2U3czblA2UUUvVUoyTDNud3pDeGE2QmNqWXV6djFQSVVx?=
 =?utf-8?B?YkVLTXhZQkM2QTNteDNMSWdnUDhlK3pzd054YjRyaVdPaVhuRndJYnNYdVRD?=
 =?utf-8?B?aWlnaUZ3djN1ZWM2U2g4L21pNk1KRDVaWHJzWFljRWEwZEJVbHpoNzVWUitO?=
 =?utf-8?B?WGxrV01jV1FxLzB0OWI1UnFrSE55S3gwWUJVc3ZaL3JVUkFPMTFEcFJOdHQz?=
 =?utf-8?B?U1psWUszT0JnUjFScGc3REtNOFZsRTg5WWEzd0tMMkY2eitiUWFDaDhQNFpM?=
 =?utf-8?B?SzI0dDlEV1ZaYXUvaXhGa1JOUVZkZk5mcmRCZ0RPOHArdkczNTkzNkljSHlK?=
 =?utf-8?B?Vnp2SS9OaVRCRW9lVFVXVU96T212N3dqSGZKdUUrN3hSZTF4MWdKQ1VzbHFI?=
 =?utf-8?B?SjF4U3lscFNLVE1RTkxzd2ZvZWhxMEloYktnVW1EZkRhY3owU2dWQW1wbjFu?=
 =?utf-8?B?Q2dhMHYwbXpzZE5WTDZuSDlLUjNWdExqUzFSN2Zyd3EzKzlxSmh4MzZvczRL?=
 =?utf-8?B?RDJ5YXJSNmtLL0N0NFN6RWkxaEZyTjUwZEM4QUplVStVMUpyYU9OU2lNTEZS?=
 =?utf-8?B?VmozeTNsaDFUZFFWelN6TGVhUUkzRGoxSk4ydWdhWENFK1dOUlZWdUpGMHZJ?=
 =?utf-8?B?NXNBTlUzRFpNVW4raUh0ckdEMGVRVkRyb2tkdm5STkJhVW1kMlF4SmxWU2JD?=
 =?utf-8?B?RzV6UXpoTVpkODMxY3hqMlJ0ZFlZWDFzWmVnME5TemxjUmNXK0ZPcVRIcTRR?=
 =?utf-8?B?Z2tOUVNtNFhya2JuU291MEIwRUJkUnFxNlJURDlQakc5ZnNOZ1JXS3pPT3Rn?=
 =?utf-8?B?MnR4UFBMSE4zK1RnRDhDeTk3ZW1BQVEvblBzS2lEdEVRcjA5OEN6SUUxNTRC?=
 =?utf-8?B?SDZQc2tMQ2lXend5aStQZm1qb201dW1IWDFyU1BtNDNHMi9GV0pzeHJxVzhE?=
 =?utf-8?B?QW9kZmpxUVZXNHZaeCtBQnp0MUV6b0gyNjEzb2J2WHUzVE5CbERJNlJITTZK?=
 =?utf-8?B?RDN3VUFibFE5Z245T21UZnBHaEd4a2ZobXNlTmROZ0ZEZ29wS0V5bHBsSVFt?=
 =?utf-8?B?OUFhVENxYzFBU1JJSlRoaHdwa3J2VjlrRUtyenBBNEpwcFpkcnVFR3dKQTRz?=
 =?utf-8?B?cjk1ekxMKzRCdXFqUnF5WkpwTDdtZ0ZYR1VGSHFCVm1QTllnTVFoakJUS2ZU?=
 =?utf-8?B?QnM5VUxoV01LS1NZekRKa3NjKzVIVTRHTDNESVNpeGdDVXFiYnBkanNYZzhs?=
 =?utf-8?B?OVdIeTFXbm5rUm9EUnpzNjNPNmxNRno1UGw0eFlESG1RUmFnUWE1RXhiVG0z?=
 =?utf-8?B?b2xtVlpjVVFTSU8xOVc0UjJGeDlid3FSU3BDUE5ZaUZVd3p6dFN4eE1weDZP?=
 =?utf-8?B?R0p6YWJ0YkxSWWE3NGpKdU81VnRmdWY0T2E5RUV4T09PYTRaVWVIQWtlbTZP?=
 =?utf-8?B?NlVtMnBYVnBnUGlQcGxJUTNpSnJFSXlxN3BidVN0eTFneTBkSkJvd240SE9L?=
 =?utf-8?B?Q2trZWF0WDVFbGlodTdaSDFucXNtM2plVURXdnBjRzhGNDZpcVlCTjJXbERm?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a6e98f-33d9-4db9-38d2-08dd161a1d0e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 17:19:17.0255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +xMN4FG+27NTHExW7NUUAF46eAenp6qPTcnBDacBFAqLw8xDGW4QDM9iA+JIC8xuqdaIsf4Vepf5/+XpWCOBpWkD2rFFM5Ulsn5y94kawDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4695
X-OriginatorOrg: intel.com



On 12/6/24 3:16 AM, Ming Lei wrote:
> Hello,
> 
> The 1st patch is one prep patch.
> 
> The 2nd one fixes lockdep warning triggered by dependency between
> q->sysfs_lock and cpuhotplug_lock.
> 
> 
> Ming Lei (2):
>   blk-mq: register cpuhp callback after hctx is added to xarray table
>   blk-mq: move cpuhp callback registering out of q->sysfs_lock
> 
>  block/blk-mq.c | 108 ++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 94 insertions(+), 14 deletions(-)
> 

Thank you very much Ming.

While this is a block layer change my focus was on testing resctrl.
With this change using resctrl no longer triggers the lockdep warning
and all else looks good from resctrl side. Thanks again.

Tested-by: Reinette Chatre <reinette.chatre@intel.com> # resctrl impact

Reinette
