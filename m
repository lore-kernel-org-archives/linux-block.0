Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BAF304BC6
	for <linux-block@vger.kernel.org>; Fri, 19 Sep 2025 08:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758269566; cv=fail; b=HI+/62nM1f0Ui9xzf8weh0/8cYRGriy1INMHPg4IaM4XWEgMYCeLaTa+PUrUkg2frj0m92X43pE8UpdMXuR4SL8E4RypOm7YxULQQQjiZnxY90VDcRXQlTxLUOGYBlerYPxUo/QJjz7IaPxTAJEyzBjCmEcgsvM84U4QWt973dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758269566; c=relaxed/simple;
	bh=nC46VyRsLMrBzq54O5QL7w79Kjq1rFUD1TchEZclXZ0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=PSP6BzuC7yXKXo1mimuk3H2Bx3S2p/BGAigLu1J7sP4rRpeo5EEyvoL8Dtg9pPaNtvgEA1jYfcKZRxvxOsXREeXGQXubMJoWPjGl7ZT88saLHQVKpJkSEC5i1BdCV3d1bJQw3EONMZJ+t6+F0CXAd7gopLzMTcN/VOGYeBzE93A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MrfPJVWQ; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MrfPJVWQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758269565; x=1789805565;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nC46VyRsLMrBzq54O5QL7w79Kjq1rFUD1TchEZclXZ0=;
  b=MrfPJVWQnNolAzBqMEVgNE4pXKXEeaUjwESd4ZNN+e1hw+pUgDUEjHT5
   bryLRgs8AqSiRf9awjEEjvmKHPqJMks0W6KToRh98MyUEckvQmf6meCwp
   YR/n2Wh4LQYlIKO80pRmhSW5Jb6odolRd+7dYnKMFWji1tU5EkK4DOTbW
   +6oXAUtPyCprescYxyngzCwE0JG2x/8uMjW+su902AnvU+X1oPzQXvZK0
   2uvlmB4FtOlIs3OWYhuDxDom32w+0YLW+l1rrH4S5BZmBoY2z9sA98j49
   J08uL3jlhDEH3zttAZ1DlEHl/uRA2nrw9t9KM+pHym6NglXD6RJkyq+By
   w==;
X-CSE-ConnectionGUID: Xg4sbtG/RWqki5HRFJJ7/w==
X-CSE-MsgGUID: hjEVuiJCThmsvIwYctzHHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60676383"
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="60676383"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 01:12:43 -0700
X-CSE-ConnectionGUID: j+aXItmVRVeBNli4T2IwKA==
X-CSE-MsgGUID: 9l2A+NmIRu6FoHTayyJvHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="176217268"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 01:12:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 01:12:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 19 Sep 2025 01:12:42 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.15) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 01:12:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqQ68DIVMU8Qg9fuGb/6YTw1nDqn+Xm71XYajPrNE/f4GJMj7N2dVuB8qevnRI2AhVZAERm+s3gI0Ddq87hIF8GI310LgvJoWZwXEkGkfZqD3O0j42YFLfK/eXcP0uWKKDGz53B0SP6IWzCEAcXnxCl6As3QMtqi4WNK0sst348BBdjF088gtansPuoJ8zTBkHG88LjnCimfhjJ1cmk1mXqKyvqrrXcs/dYr2Aork5gKtnlLVxL8QsgYQtZ6GL+GuWcciZaWqV9YjH2QRv0YG4t8lXoD1zmpv2gaiGH63IZ1tDj3AhDqfAZR6UWod8WMKgjqXfzrNl4OK8NppJPDJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8ggaarBRFi0jWiNV5uESfli0xlBjg1NzAHKbCNNf0Q=;
 b=YlCqEZZoJRr2XARMtiNDnr4Y4zigTtT4zncOWC3nlE/wdKun5PBYPTZU0vsowuyrDSNHK4kuhTImECCAhmKxOzsvX7tE0aLqdFAO/sjYMus8urWHU34dDb7+iNCVo+XOVuvPCsGy0tfItHzy+fU8p5WjBx6bV5Gu8fJ2t2k+zVduY2LcI7ER9m592VSVCCBJ0lj8PvvZhLXg1AhoBaLy+g3SeeKUJNQb64G1IMykvkIc+XgUv3HOxrtnuLMiRj5FatyqBRcjDP8JZj5WKbH8W9F5PQqIEP1Cehx8uipK3+d3TBHhIauVtpUNYgDCBuxTyKqcfC4No1AdlQYsGU1xIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by PH7PR11MB5913.namprd11.prod.outlook.com (2603:10b6:510:137::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 08:12:35 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125%5]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 08:12:35 +0000
Date: Fri, 19 Sep 2025 16:12:23 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, <linux-block@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [block]  60949057a2: last_state.load_disk_fail
Message-ID: <202509191539.78090606-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR06CA0211.apcprd06.prod.outlook.com
 (2603:1096:4:68::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|PH7PR11MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d876dfa-f183-4fae-65e7-08ddf75448f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z9qhV+GTYk9b0zL7cS7GPmfLH8tqBQ0IY893v4CbgSqfDTdCv815fIzQO5vF?=
 =?us-ascii?Q?9sZ/9qt2XQ3S44EGhzWq/L8i6gjF7i6L9vwRPs8+ov3Hq+s+W7WLOrnwATIh?=
 =?us-ascii?Q?+DS6jZ3ofkQr3bQ0MMQOTGtIlrgMYFMtd69BnIXFK5kIn42M8HCFhDn3M4qD?=
 =?us-ascii?Q?hpYTbjxFtRyMh6vVAznMOx5/ga/896YCI/mr6Yq7myxKwMY5bzfDSQNOWGbm?=
 =?us-ascii?Q?11usuUCiDn9N1RxIig24ID/4U1Nn7gGOCZLuEiNQGkSsR9KSbW78HXhTcB3H?=
 =?us-ascii?Q?Sh+ek2DDTHKb9dS+opbjvOLGdHskvMpZCr/KXz9Oyq+/rKC+aLgKaXEzC6wj?=
 =?us-ascii?Q?6IOieNevdbQDb4Eyo8Cgk778OJOckc8FE7DDXLk5gZ0iLgc1i0XmnSyeBstZ?=
 =?us-ascii?Q?F1BUGdg/THcesb8pNOOQFIwk7LCsp443oXA2K01AB/qFMGWJYSLr1hmv5jI6?=
 =?us-ascii?Q?3sOMEubbtYo5JhaqzzxhKbqB0uFlfK5KDGuY9RLaYKXJphK4Ictkh7fFMwF9?=
 =?us-ascii?Q?SyDxMj/AIwtSpRzbQweocpZINZOIaMFlTriCWVh2v7bzFlZ3sGDLTKq/XAmq?=
 =?us-ascii?Q?Nbi6oBC0Y1HoHiESisoROHz9q6+/kZa6dBrgSzjSuRmMLnuoj3CgRGE3aUq8?=
 =?us-ascii?Q?TN9BiIGWS7+qq306sBX/jwf7QlYvbv62+pu/4tsWVLRZiC4axT+aqwkbeoV8?=
 =?us-ascii?Q?z955xMU63O2DcSFW1rHuVWrD0TczFkhU4Zs9jOULDRpcuIPBxLkqwNwEi6h3?=
 =?us-ascii?Q?etD5QceItgJc82uWeS1B4RgIaoHPqP8nkFMGlKBbuEH00m1QQG9Z6p2w7ybU?=
 =?us-ascii?Q?Jqsnam4+ouKB/K8zM3NMOHGEab8xr9pYbLYSmddRXSEx2dV1e+R4PUTuYJ+Z?=
 =?us-ascii?Q?hL2/Ct9ZzksPd9B6jUkFRUF/mIfODKh8eM2/sluQXE326f96fw+xzrdGk/aT?=
 =?us-ascii?Q?P6WeOr6hMVIKonsc/fCZUqWvAj1BpaKEpJsWuuXRZZsutlD4Rj4USzkthspP?=
 =?us-ascii?Q?9XiN46E5wzAfqUZQRAYbQTJJnfgx3AdCRqngAdAvrzAn14987CMQ64XwN4lz?=
 =?us-ascii?Q?zBY4FDT6zxfIhAMrIe4Q0r+mTI3BzKc3R4xtKGpo7mzuzTrNGKHsexCKKX0u?=
 =?us-ascii?Q?lqiKCv2jeVjSS0RYV3opOmSWZ1XrottfcqiHu0XhY2Jw5NzY6kfQTuJBZbmx?=
 =?us-ascii?Q?BR9F64DnSdyfvcvSdvbMERzDKi6nVE5lcLSAvU9LlShRL3shhw4kAMborXSy?=
 =?us-ascii?Q?YAK1G+DTKY20b1BB2zXOim3lLAQwtXwrZGJQ/vLzWL+59cZSQACgmg5B9iQZ?=
 =?us-ascii?Q?pPGTDSrax6qtakz3tNASs348kFju0yHTunXZnMFotkws7Vj/wcIcqYnzkl3n?=
 =?us-ascii?Q?JrgHlmcNibJ8KhgBTD+fQSLac06M?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RV/zwjCK9Ghwc/GywEz/adRcyvxHZt6DQEQWvpr6AcTJa2vrhg/OWMhqgb8e?=
 =?us-ascii?Q?Xwyd7/qgxHnLyhdTOhs4r5LM/7/gB3x6qk0bMvbUr6UqB2QIRTi0vFTnNqMH?=
 =?us-ascii?Q?qaM5qTO1ThdTftFJrxkczEHwqVXWMH5gy6EE/HyGrskBwcQhYF3Jf78Fto7n?=
 =?us-ascii?Q?8YX3Oew9lZZxQ5yMvyN7XGAJhZo6AVqxn1nEjncH9CvHUFsi/KiK+AvXT2/v?=
 =?us-ascii?Q?P8KQKwO7f5wb8+/tDYFBP++yUU8aNcaSZnKu61CrakgymxNuT7YrL2Zn9M4p?=
 =?us-ascii?Q?RckNq4RRuktQ3TPukltLTNs11++2kc32hXHu3kKjT5QNebXmPPiu8UaZ1Ydm?=
 =?us-ascii?Q?4r1d/nEgIUuzPoEL71cxiQ/hwyCC0ZGXER/nmzhufJwKzpp3VdCW5/y6IDDH?=
 =?us-ascii?Q?vPFQdVuCn39qePJwoYL54vW9eTCxJ7b8qMiiiyLUpoXvmxewLqU4y6MYs1Bg?=
 =?us-ascii?Q?FaoVNiLz36vi7mSJ0CxtkXy4cPkjKkG8IYpa8vK5vJutKdAnPTzXfZAmlgwA?=
 =?us-ascii?Q?Z2bPeTZyCHFlguw2yqs9Ksur9SE25oAShGnGTdcwQr/nSdsnon29sKoEyNwW?=
 =?us-ascii?Q?JOOgBZoGpYRHkOo/fPSe695dNYrLKeJR7nnrXWigztC+UV0iGD10zgy9riDD?=
 =?us-ascii?Q?hFqYiwOoqT7ngQQoPcZcJTi/ZmqgfXB1jF7OaNF6vhrmu5OGhZ9U9u1pYW99?=
 =?us-ascii?Q?WjowhjwjMLjDGR1HXaaDBslbOM64XFOzNeFuS9/HNjFsenb7wo9x8ZSqCu1G?=
 =?us-ascii?Q?Agp7klkGekVIfSOG8df/xELz7dwHAljFWm608FRG2UXqXG9+0M558epphls/?=
 =?us-ascii?Q?ssqmtfwEyCFcREfro7VGn6QjLdM5joKKEpKH4dXpKw4APMS79zRaJ7R811sx?=
 =?us-ascii?Q?ySkriyCBj2xIq1S8E7fkJSHOSFSbkW0iojf07zdz7mgsO301XwyQLU5VHDSy?=
 =?us-ascii?Q?khvOgv45AOVCyrjsrScasfrBHbi4YWBwsOVHON4CKEUAp6DTGQOHOJkYQv7+?=
 =?us-ascii?Q?kJkclSYMvbOX9kwvdGgugPFA+Pt3m9H8nz1eyu71gsbbi252XIyJMZ8kVerl?=
 =?us-ascii?Q?zD85c4eOzCw0uXnhDzFKvhCsrBTdaYQBR8PVZZDqCLxl0jCZD/Lmmf+FUfac?=
 =?us-ascii?Q?J5+RF7RbXp9A7rwatxFtVrj6JPY0wemu2QJ/8S9dK1J39xwFsh8fEOx2Oblh?=
 =?us-ascii?Q?bAxdKhP9qi0SfJLn859vzUKCjH70Oibj+zAxnpDbYRlVU5zoIwvGxRmqZZz/?=
 =?us-ascii?Q?bmFNGpQe8OF/kdv5YeG4ku6PpU+EVnkK28SFWNbgQsd2VPEDNZ9aIZBy3V3/?=
 =?us-ascii?Q?VIv+28HGtcnJH1I8WkBnfatjB1XlOGepI+J32mtwbQbNGV3zNzm/leUn3AZ8?=
 =?us-ascii?Q?KQVZ5vlmn26l1+CMhUOinChdkoQ89V9QsObwKkM1EpwcLFzSBWm5zY1d3ZAL?=
 =?us-ascii?Q?9Z2x21Mnq+uuWeqksFWB2muh7fx8lBX0uRoP2c3w+QgFS/aZXgz/k9KRyefW?=
 =?us-ascii?Q?p4ez3GPJBTl5ziNA+eNvU+KU4qyf+TMybtov664JOAKCNXZ+TCxFXa8zlWwI?=
 =?us-ascii?Q?T+eOtuSK6bWhKe4Wf5jPy/Xc0LlqLbZJNEp6BsbMIj0GJenVolMqhPW9yYG4?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d876dfa-f183-4fae-65e7-08ddf75448f4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 08:12:35.0356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /a8dwxtwnDfLTA6/f/CKAxVSPQ0bV/1yb4XrPUmt4wDDDNu3QtCqNfiBJRew0OBNGC3mu1lFxmSUjIlyUKG/Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5913
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "last_state.load_disk_fail" on:

commit: 60949057a2e71c9244e82608adf269e62e6ac443 ("block: use extensible_ioctl_valid()")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master ae2d20002576d2893ecaff25db3d7ef9190ac0b6]

in testcase: stress-ng
version: stress-ng-x86_64-665b4465f-1_20250912
with following parameters:

	nr_threads: 100%
	testtime: 60s
	test: chyperbolic
	cpufreq_governor: performance



config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 104 threads 2 sockets (Skylake) with 192G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202509191539.78090606-lkp@intel.com



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250919/202509191539.78090606-lkp@intel.com


bot failed to capture more useful information in dmesg uploaded to above link


LKP: ttyS0: 1276: can't load the disk /dev/disk/[  192.533567][ T1315] LKP: stdout: 1276: can't load the disk /dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_CVWL34300015800RGN-part1, skip testing...
by-id/ata-INTEL_[  192.533580][ T1315] 
SSDSC2BB800G4_CVWL34300015800RGN-part1, skip testing...
LKP: ttyS0: 1276: LKP: rebooting due to boot init failure
LKP: ttyS0: 1276: can't load the disk /dev/disk/[  192.533567][ T1315] LKP: stdout: 1276: can't load the disk /dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_CVWL34300015800RGN-part1, skip testing...
by-id/ata-INTEL_[  192.533580][ T1315] 
SSDSC2BB800G4_CVWL34300015800RGN-part1, skip testing...
LKP: ttyS0: 1276: LKP: rebooting due to boot init failure
LKP: ttyS0: 1276: can't load the disk /dev/disk/[  192.533567][ T1315] LKP: stdout: 1276: can't load the disk /dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_CVWL34300015800RGN-part1, skip testing...


we tried to rebuild and rerun the tests, but the issue seems quite persistent,
while parent keeps clean.

f8527a29f4619f74 60949057a2e71c9244e82608adf
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6          100%           6:6     last_state.is_incomplete_run
           :6          100%           6:6     last_state.load_disk_fail


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

