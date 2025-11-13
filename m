Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B573271A7B;
	Thu, 13 Nov 2025 07:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763019872; cv=fail; b=UK9yWdCWC/Iu5Q+d2iEAjUiacmlR5l9jxBjcgn2p8p5izdJjGSElndAUPZyTt7wLymkvGSlL8Q2hOrRTMZYyASvpHM/HSd88Z/StVt555Y/A98SvSaemZeuuzmxtm9MfuIVt9XXUdGROnHXM4x327TkWb5PjNz/xpw8YPVL7DS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763019872; c=relaxed/simple;
	bh=O4SRRtt26wQOXLj3UYtlJxJYvydVbFYcetEL2CbKAu4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JX6ygZzRBnP8g4IGEM9lYYcqLG9wLBR81DMwgzzwqwmiIzD30kVzCtUP66nn2HQ2MyPgv5EchQyZyGkXihnFgpFcCAf9/QrDBLQIqeWgQUStqZTx7M7VlqiHvzgnDdZXV1JqJU9v2Unp7XVjb7IjCQPwZYvmgKb0fHrXoRsKzpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O8InaWB+; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O8InaWB+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763019871; x=1794555871;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=O4SRRtt26wQOXLj3UYtlJxJYvydVbFYcetEL2CbKAu4=;
  b=O8InaWB+QSdlLTA0ZO6XNftdeDgG65x463SJajRbR5xgWoSUMgiVox+t
   Yor3s8Vr53M+UvuPCdSKZ3gxQflNNKhzstNxHZZetSa1JDV+w8r05DtvN
   pO0uV+DlzNZyni2LzCFYGu5foTOFZhQGkk9HEPawD+w8yi+vcDOaM6d7H
   eHvRX6ewKZOkHRsdAITVlk/HjONWBh91rPDxJA6F1NxuGBUyEEme8Z/0t
   1CgQ9MEDjcKZQ4XjxxO5Dtx8/baxdahUhIEsbao0SnsyC2l75Eh1i79+O
   PTFC26lFFP/w7rTtsm+w3r2Ckbp2kMKPX7LY3q12deJij0quJPwCaeUto
   Q==;
X-CSE-ConnectionGUID: HohvtTd/SQm3hC8zVGsgjQ==
X-CSE-MsgGUID: zk2rZ5KHT8iBL/9llIRjEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="65186999"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="65186999"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 23:44:30 -0800
X-CSE-ConnectionGUID: 9BB+nn3GRAOzk94SBzCpxA==
X-CSE-MsgGUID: Xse8kAe3TyCJUvfRQWHykQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="189858758"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 23:44:30 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 23:44:29 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 12 Nov 2025 23:44:29 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.63) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 23:44:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YU81mI3n73yh2fJRNpJuxce0ywVYEdW6ZYMYXakDtdUPYR1fraJsHdinvYy9rHDHhFoYqrnxeIM0pYQhm4wA8Z7B0gpWp8liU/znCTRV+8dMTRz7UpoNzwDqCLg2idSjNSyzc6GpuNAS17tlh7Ds0F4Ym39omZt7xnmD4aQos4vuYZuTTWvkMyVxshLuWpqN6jqJ/J1fEFBMUksqrYb+diXQf5vovkdN22XMNqvbCysNpbsU/y2/KoGbDRVMPxrpwyYqvpSM6LHy0yaNrvc4cdgNBZ1WNr6Yvo9C+6Gq012bXm13ryxPyXxhXMfEdJEotQxyEpoyeWR9wxbkYQfcLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtDjthc4KYrirnRUf4mMns+D/fcWep4L0dF2WL9SP50=;
 b=cKJNVhfvb9fgbORm6/hT5fJJYiby9rYY8dpnprXSYLm6QFH+ZNYcuIsDCe64HqMgkAqRUF6FeWXzCzRi4Z5u5XhLsLyBzUq69tWUjs/xdSmkU9lh44owV5bGP3kzNJWWYFx9oJJnEdxKqA60v8pMO4lsAU6ITxCbLf0DeXxT+UFG7tHkCLdIAXZIEXX/MV8o9DqxmZlgMjuiHiXUHp27mXgOMXwwyEeAaz91yXqejYdB+8UL+cr7UayFSvdBAbhOeEELVslY9ZdUq5JVnB8vfUZNkDDISjxjqoDR45dMOiVK8beH6QYbuHzETQFJenwHtTNxaLmM4weI4swsNr4gtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB4958.namprd11.prod.outlook.com (2603:10b6:a03:2ae::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 07:44:27 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 07:44:27 +0000
Date: Thu, 13 Nov 2025 15:44:15 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Vlastimil Babka <vbabka@suse.cz>
CC: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
	<linux-mm@kvack.org>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Jens Axboe
	<axboe@kernel.dk>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>, Anuj Gupta
	<anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: poison_element vs highmem, was Re: [linux-next:master] [block]
 ec7f31b2a2: BUG:unable_to_handle_page_fault_for_address
Message-ID: <aRWMT6DTNhAdudn+@xsang-OptiPlex-9020>
References: <202511111411.9ebfa1ba-lkp@intel.com>
 <20251111074828.GA6596@lst.de>
 <a90b1707-b97a-454c-bced-a25068b28325@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a90b1707-b97a-454c-bced-a25068b28325@suse.cz>
X-ClientProxiedBy: SG2PR03CA0092.apcprd03.prod.outlook.com
 (2603:1096:4:7c::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB4958:EE_
X-MS-Office365-Filtering-Correlation-Id: ec32d6dd-3589-4395-da81-08de22887916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i8QcXvdA5ReEEzym2JfkRZu9KXfXaMOz+IV3IJxh9LmC9ka/X2ruRP7JiQbS?=
 =?us-ascii?Q?KUthcit3OgW7h2B6o3PLTfvjn5sseR/RAA4oZlc3F3v2iZFJUlO3bE6z7VPc?=
 =?us-ascii?Q?/TcqAGjbtwbemoRuBjjzBwVcjWQa72P+XiHfw5jFrUTXQqXtL/PkETaXle3O?=
 =?us-ascii?Q?YIKV8u8HgObJWp2oDYFRew4obliS6945TevWKiBFuTjSZwPduSgFW5QtWdgV?=
 =?us-ascii?Q?K6i+Zw31EiNu6fTK8fc9SivLOp8n96P5MFQru6MrOxTdFbUOxF4yIdRADh6U?=
 =?us-ascii?Q?44k+wXCK4Xz7tXQHkK8ggIs6mVViEierGFC4gJ/IK54cQZEcDftY7FpdBcmk?=
 =?us-ascii?Q?E+BztIm7Xagw3JxWBAdfLcsf53WphJ6QniWCManSTmnnKix8WPxco8zLKGDc?=
 =?us-ascii?Q?2aYm2gBCx0HhyPqZO1ygPhjRGpivnZIUY/A0NTc4M8Y9IIeeO2dmdji/dUZX?=
 =?us-ascii?Q?nnlsY2J0AAOVucnNGAs+Gr0vzA3RxPea+RG2SAFnejjw1OQ3CeCneTtCzYQE?=
 =?us-ascii?Q?GHN/ILCklK49nOQ0T5KILEFVUv0tABlajpnXeBsOSamFCwQeVCJz2jw+F/ef?=
 =?us-ascii?Q?2ftL9uwB320zLUyb/NDy6fKXMCe4AGx3XyE6HbRK0w0JJxl/fNmeXgonj+/R?=
 =?us-ascii?Q?1vd8QlkVzBuL+ceETTQAI3f3qOmDBnlAsaekhE2CQMp33W94vci+dR8MLMIl?=
 =?us-ascii?Q?GOk04nOysSPtmrBzje9rjjoj94SRhfb6wsYaO4HqoftlQc+URfNg5bqwPiER?=
 =?us-ascii?Q?Ot4oXhm127drqaGeUZc1ZutirfsYYp3EXr9sVZhpdE+YXQYUmFCDtwS9cLqL?=
 =?us-ascii?Q?4J1G7MWXIDMlk0Kce7ANJaz6eQBSWCP65ic345vL1eb3P1cuZgJrl5cK0qE/?=
 =?us-ascii?Q?M6lEGkjbBqKRPM6zGAuUB2O2dRbG7K2C+c8Xmd6JhX98vRXUb2lIzm67khBE?=
 =?us-ascii?Q?Pbg8cpBkReQ4vri5ALWi5n7Tj09v5/KeCBHcTIJf0bbgM197JK+dlg8xlvaB?=
 =?us-ascii?Q?9qVYHLaFZQKAjIjtcmPe5ZG0Da230bk/VWlQ2rJAixPiOUzSxTff0eLBF4xw?=
 =?us-ascii?Q?cDbQyCSl5Ex0tNCKGymQHkAbjQx7jlk5ggqmvizc5jSlQZ5p0NRlsWPdPOyK?=
 =?us-ascii?Q?eyfltXcMvxO7XGN2Een9SfVtyBk2ziWJduddiYXKKysGiblRXXAplH/ruPtn?=
 =?us-ascii?Q?TuzaPnD4zLqZ9zlW0p/2fgA40V7izZW0A9vjlJU2fq2L51senGmgwVC9Ze7O?=
 =?us-ascii?Q?4aFLxrzfI2G4vLyr+ryVBxeu3aLy3171NxQ0rDSZ5cs1GcMze/EPNTWok2XT?=
 =?us-ascii?Q?wyLk166T5NoIFBD5zB++MCZ7DFBWYoaQQm2Fky3CrDKuINQZvr16loCEHYD6?=
 =?us-ascii?Q?N9KFR0xL6/ZsxIFMdvVVrBmuF+9ujW6swsUrRVTJNF8AzNNRXmXcPj5YWCbM?=
 =?us-ascii?Q?u42tLkbjGyJSa+vIRBl06GA3L7E3eYLk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hnuh/vNqQOdeQS0uVDY9OvaSRiE38O8U2qwthi5cleM3jAbvrfUIfS9TFfLU?=
 =?us-ascii?Q?LT43FLkA1FxKetNBLoh6RmvMk69zBHqiU3fnq/F6QyL67rD1Ob0YNtKadflh?=
 =?us-ascii?Q?86cuQz0f3WVJppPPqHgk91CtGLKvmO4dGXkW56FRiPA0Qd4YNXeapLnAyt2e?=
 =?us-ascii?Q?M1PmcSyBC8bAl7Mm5HzVRHjrafO46tBLcAwJfv9iEBydw3ZgZVpeFso9XDZy?=
 =?us-ascii?Q?IOH9cuvTwZBWy42Z1eSTGTmH3vx7BLrf5Fo7YJ+jrtZ6gGN48xKLGv8VpfCg?=
 =?us-ascii?Q?CrtV5TLhNMoIfSQTz5R+MoscmdDkAN8k0M2L2xCDoq/0DZp/9CM6GkRJPaNc?=
 =?us-ascii?Q?2jgShq2jWLOyC8t3CORiqP0Q1UwVBf7NorJBECWceAA2nzizc0OWQTxbCo9o?=
 =?us-ascii?Q?40FRsmtK4p0wR99gnSC5tEui1WZhjzR5Naw7UA29e3ISC/GEZP8E0TKrNgfx?=
 =?us-ascii?Q?xW4zBGliDkyFIwbwJO9QPBkbNBjfPNRd855yK37g0/6iv9JtoW2vF/i1ZgEi?=
 =?us-ascii?Q?ikvDV/vkDnXCjsFWJMBl7ssXrpRgT3AVHRA82pWMYb8AYx43XgkAVo4E6vC/?=
 =?us-ascii?Q?1d6OXQ6cVQECZY8JJISHacnZst+F+gifWM6L5qfZYpa+1PZ18kzd7iq+RcCt?=
 =?us-ascii?Q?8zalgMjvjr6HZRN3yGhIAOG05THYBcEaYu/VcFJyGSJm6FLAgRy4eOJteKWG?=
 =?us-ascii?Q?M2SWiGZPklRqgY2DjWULri8yWUt6kEJO/Hu+atEeZZi3PfbS0S2wJfg1pO+d?=
 =?us-ascii?Q?15aQgqENHvgTzorYcRjyl//kzljE+t85fAUSpvbukqr/jLcS6kwQmt8hot3I?=
 =?us-ascii?Q?iKSYzis3DxzZ2VWny5ZLWjABEZ7XnAt9gMvQkiazlPKMcmxAVq0es7/7XHNF?=
 =?us-ascii?Q?cfD9tahIWNeZpl506ASEAPneJYF8Loh5cvrEsksE5yJ5LORIj9iu7qSxfOmv?=
 =?us-ascii?Q?l52AzVfv/+6fbVkqj+xqIsevJzlZjHvw7nTIbrPEEJpy9MY69mmQWInOncz6?=
 =?us-ascii?Q?yIBZIJcPd849O2D5QlRg+u3LeSBM5zpZyrRdDRJXu3cPJWBeomToEG6XKMYh?=
 =?us-ascii?Q?VTGpq+FTI+nH2IPpad1jHSFhYyknB1zpKjvX72H8e/xP3VsRy2JjDyE7Qjdt?=
 =?us-ascii?Q?5pQKuSHTn4ku8uGobDbrs+MT23De5ruNhw2p8szylOLM3AnZ8C6oxNu1/uGk?=
 =?us-ascii?Q?+jU2u1ZPXp2137aptEe6Sqn+6IWEq0PPK9ckbf5xmWjtFPTfh5FnBQypijcj?=
 =?us-ascii?Q?0Vmq6werAmIW/WR77xDpnaKJThENi2kRTV6YqwIc+KsI57l/swn6BtOx/Voz?=
 =?us-ascii?Q?cxV1vnYL3Tva6kP7lu0bAdtMZB/MWbuqnxHf3QcO66LiErCuwafiUA0yjq0h?=
 =?us-ascii?Q?cMLFeRoBkOYSJYKVwimWt7pCQV9+8bfzpAp9GYFs5NgS4mcrY99bAmSbPmwj?=
 =?us-ascii?Q?TJKcE3mp70WURfxAYO+gN+cT9ExLdLw4SpgIgFd66EhbnaqQElvd3LgcIJeJ?=
 =?us-ascii?Q?BIt8oYJIDwpFNJgea5kfrl6Pc+5jbN5/gCI3L3T67q7qf8MrBz51Wr8alPtS?=
 =?us-ascii?Q?9AwO/w0bHQXEmR24dtSimGFGKh/0ZNR0vbjip3ZbzbM6/dWXXKGykydalM8p?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec32d6dd-3589-4395-da81-08de22887916
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 07:44:27.7087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oeoEw2CuOmizk5ySyWWrwQM0tjCBYTvMe/9QeA2uRiB3+1qtP8Q00b0ej9VWlfMAC0jy7Li1FHHOrcaN5wyMOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4958
X-OriginatorOrg: intel.com

hi, Vlastimil Babka,

On Wed, Nov 12, 2025 at 10:33:32AM +0100, Vlastimil Babka wrote:
> On 11/11/25 08:48, Christoph Hellwig wrote:
> > Looks like this is due to the code in poison_element, which tries
> > to memset more than PAGE_SIZE for a single page.  This probably
> > implies we are the first users of the mempool page helpers for order > 0,
> > or at least the first one tested by anyone on 32-bit with highmem :)
> > 
> > That code seems to come from
> > 
> > commit bdfedb76f4f5aa5e37380e3b71adee4a39f30fc6
> > Author: David Rientjes <rientjes@google.com>
> > Date:   Wed Apr 15 16:14:17 2015 -0700
> > 
> >     mm, mempool: poison elements backed by slab allocator
> > 
> > originally.  The easiest fix would be to just skip poisoning for this
> > case, although that would reduce the usefulness of the poisoning.
> 
> #syz test

we applied below patch upon ec7f31b2a2 directly, and confirmed the issue we
reported gone now with the patch.

Tested-by: kernel test robot <oliver.sang@intel.com>

BTW, we are kernel test robot, not the syzbot :) thanks

> 
> ----8<----
> From 4d97b55c208c611cb01062e0fbf9dbda9f5617d5 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Wed, 12 Nov 2025 10:29:52 +0100
> Subject: [PATCH] mm/mempool: fix poisoning order>0 pages with HIGHMEM
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/mempool.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/mempool.c b/mm/mempool.c
> index 1c38e873e546..75fea9441b93 100644
> --- a/mm/mempool.c
> +++ b/mm/mempool.c
> @@ -68,10 +68,18 @@ static void check_element(mempool_t *pool, void *element)
>  	} else if (pool->free == mempool_free_pages) {
>  		/* Mempools backed by page allocator */
>  		int order = (int)(long)pool->pool_data;
> -		void *addr = kmap_local_page((struct page *)element);
> +#ifdef CONFIG_HIGHMEM
> +		for (int i = 0; i < (1 << order); i++) {
> +			struct page *page = (struct page *)element;
> +			void *addr = kmap_local_page(page + i);
> 
> -		__check_element(pool, addr, 1UL << (PAGE_SHIFT + order));
> -		kunmap_local(addr);
> +			__check_element(pool, addr, PAGE_SIZE);
> +			kunmap_local(addr);
> +		}
> +#else
> +		void *addr = page_address((struct page *)element);
> +		__check_element(pool, addr, PAGE_SIZE << order);
> +#endif
>  	}
>  }
> 
> @@ -97,10 +105,18 @@ static void poison_element(mempool_t *pool, void *element)
>  	} else if (pool->alloc == mempool_alloc_pages) {
>  		/* Mempools backed by page allocator */
>  		int order = (int)(long)pool->pool_data;
> -		void *addr = kmap_local_page((struct page *)element);
> +#ifdef CONFIG_HIGHMEM
> +		for (int i = 0; i < (1 << order); i++) {
> +			struct page *page = (struct page *)element;
> +			void *addr = kmap_local_page(page + i);
> 
> -		__poison_element(addr, 1UL << (PAGE_SHIFT + order));
> -		kunmap_local(addr);
> +			__poison_element(addr, PAGE_SIZE);
> +			kunmap_local(addr);
> +		}
> +#else
> +		void *addr = page_address((struct page *)element);
> +		__poison_element(addr, PAGE_SIZE << order);
> +#endif
>  	}
>  }
>  #else /* CONFIG_SLUB_DEBUG_ON */
> -- 
> 2.51.1
> 
> 
