Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107933B1A1
	for <linux-block@vger.kernel.org>; Sun,  6 Oct 2024 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728223668; cv=fail; b=HsIY0myzqHRscMqVZ6KVo9F6EVEOHlyMMXFWNIEySz8mGncNRkCjLzs0UhdsvchPMbIJOrGmMPteF33HO6e7h484d7YDLYARlt5HpJcXkilL3gxhJ5jBNwEkfGxbz0VBQS5XWYEzP+GZvhSrh6+TK66daxHtDEAj2uCE/72JFfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728223668; c=relaxed/simple;
	bh=x/zaNOx+n9vYEgcMZeCMfzyLQzCeJMubKs3Cjd1riVU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z+o0NTHbV8ecPgDs0IUNUvsWkiKyX3h9vBFoSG8CgpMjL1TI+j21nzDUzfqVbgIIrolhj7bjF7v+Ly0j1PDymbvklcOgyCO4ovD+QAdwdyB2wyqd10J4J/kRyvRXZHplGSfPE1ZvRledrCr+4yKjeQRdXZgqMnpRvRv3RwbVLnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=edJLqLFT; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="edJLqLFT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728223666; x=1759759666;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=x/zaNOx+n9vYEgcMZeCMfzyLQzCeJMubKs3Cjd1riVU=;
  b=edJLqLFTSZxiNnSZ6d0pJc4XfhWmCoP1uf6WUfOzRrPOHxZm8IO/hfrj
   jYMYTSvIQM9GBK8OzmqSaRQ2BP/eIxytCDHrfFZroYrez6uz1LIGbelgx
   acEYk0MRxBsHy8zW1Px2s5wKvgS3eUAdROMWUjOIqeEkE27Mdbka0x6pB
   B47ylS5bLNiJ0SMyjoYgx9I/GRPKrGULeqBSThXu9MR8jNBIdO/T4Kkv7
   c82rnw5Liix/XD0ar3zcx0LhJY+ImkTFef54Mg2Ta+ysPssRiAJ5/Et4k
   IklBJQsxn1Tpi91x2ZSh6NAQSVC9VnbVz+7c3vPk6k8dlJc4G+HPcu4Qw
   Q==;
X-CSE-ConnectionGUID: E/0lRXLyQPyDnIoJSSOfXw==
X-CSE-MsgGUID: Q0SviDSfQw2CPtFknrlsgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="27554900"
X-IronPort-AV: E=Sophos;i="6.11,182,1725346800"; 
   d="scan'208";a="27554900"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2024 07:07:46 -0700
X-CSE-ConnectionGUID: QiFxvau+S9Kke9MZZHeRpA==
X-CSE-MsgGUID: kGbl9SHiQu+oWA2XzK5Htg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,182,1725346800"; 
   d="scan'208";a="74886856"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Oct 2024 07:07:46 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 6 Oct 2024 07:07:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 6 Oct 2024 07:07:45 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 6 Oct 2024 07:07:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPAajM2yUcQDo8KYXHSr80ixVcExSHmu/cydYJ7XH6C4FKLPhPuGED6XoQIdAu9EPfmH+8wPj/dVQpKRXIe1+sCPqFld5BUSJR/HEWNNcjDL6qZ3EZt5gOp9niyA2T6004ta0B49snfuVByCeASGoBEjlzhKzIibB0ydBRHFYK/FPqW3+GF+SwrpNqUV2og5Xcm9C8FKwBhi5FHUpBHQlP8+aYRq/kz38ElVLeHRchpgCMymIUFocu4fLa9pIkofbdFyqBDpHSfT+JuYihXxi/WK4C+9dHn8nPOPoh6WmiJWw2zplb5MMkSVXN8vC3Q5F2cAQ9VK8z+ThVQIZT35/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dDHG3vqIoGy3M2sYeZyKOCgLd/v86rSJSIpCddfmcg=;
 b=ni4n68kVUTRAeJRgd2PCSoq72+JvZTkg/6FklurBuqFSb8YnrjRYyYJgIYhzOLQUNew1OUnEMEEF4rZ+3fiUtnoLPCj8WVMFn+MqHwcU4E+F+4z9QceRpzUYms07LFZRgt6ogk24h+BDK/qGkon2G+zxmKlznQoTgvdNElua+MTrQjK9XxalD7TrBql1CiYdH+DP82AIc+V2Qs3AOtd083V7z6iU253fU+JSkmxpMjAmQ0kMjJYXfl9KJ21fKOyfI+veNXXkE9bMZfw7VbhTXXgh0OT0eTvWXMDqqIU4Kdv32BTZRS4Z8bjEB8nVQ8/MZEEG2lKtESCMJxT6WGvm9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO1PR11MB4961.namprd11.prod.outlook.com (2603:10b6:303:93::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Sun, 6 Oct
 2024 14:07:42 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8026.019; Sun, 6 Oct 2024
 14:07:42 +0000
Date: Sun, 6 Oct 2024 22:07:33 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-block@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] block: move iostat check into blk_acount_io_start()
Message-ID: <202410062110.512391df-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <550fc8a0-3461-49ac-879e-32908870f007@kernel.dk>
X-ClientProxiedBy: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO1PR11MB4961:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ea1e016-08c7-4ff7-8253-08dce6103e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?69/yGATUGyhmyl4uuBcdPdBqLXKXg8pNuOsIKG/27gyCtg5wdFyXRXmRQ9nR?=
 =?us-ascii?Q?jQ2qjuVj4FTqUdHWu7EdIXqU6xVQ5kFhIe8+Zr6EwPh1nAXfOpTXjb5O3ZVx?=
 =?us-ascii?Q?f3rmkSJ6b5sUyWUwAfuSOa1z6UZzIsr9XWguoXAVagjNmibC/js3j5QtLtLa?=
 =?us-ascii?Q?MFeuNNeevdw22yIBNTvgZKDhUEOpF1XxF1tfTs1FjCrgZJ13otnO25X3UZPy?=
 =?us-ascii?Q?JiSVX83w4UJtqQHhPzrwM8EG34053QPmQwBr758i2vRYzhnEUo27YH9wYHwb?=
 =?us-ascii?Q?9sOGND8AsYRejphgE7k6vWmuuU8yWYNOK8wnB3A3oDhLY9WOQqqF27EzQUN9?=
 =?us-ascii?Q?EQ4Ufk/QFiHDLNZ2dmDyTPp1L8LBavBAfzrkfY9G5u4S13mjWs6oWdYsmoc4?=
 =?us-ascii?Q?9/xFM+kDg/IFm0GBVOuf90UuGQYSwS0EeCvGdIcAThbLwyo8rPUsVCQc1E9m?=
 =?us-ascii?Q?lqMRcYEAeucl1Beet1aTyGg3sKed9bOtHAfiB4f5lSwV4XProoqThEKTYlHl?=
 =?us-ascii?Q?8xGYK9j0w+urIhEiUDaAnIhFtBuGz1VsMTmF7fVE2kGcTV6Auj2KerlTcSf8?=
 =?us-ascii?Q?JePVasRtZ4eOQX00vpGUTv8StMJXUoXcyIFVXXQcnoWtOwBYGDSUtRqgdBdv?=
 =?us-ascii?Q?VWbi4w3JJcMKMgUU3v+AHvIxM0rwkjW6huVGej4HkZzExlHRQ+Fh88rQRzgb?=
 =?us-ascii?Q?qljKdmC78gjICWo5THpkZwz+Z8NIuJWLMuKxFkZgiCY4HhDKs9uOz4m3vMkl?=
 =?us-ascii?Q?yTASNWUT3e9w6uaH3SLXQs++bIW5bdl+P9IBw8jXziutCtW0ilvSHnvPN7af?=
 =?us-ascii?Q?PFhShN0fr694K53lG9Acu4Eyh8knxPZEwQwTSlEdUPkqEzaYjeiChFe972z+?=
 =?us-ascii?Q?ShA1NOmky0/eP7tGmxQUJVe0lXz3Ar17GXE/CMExG9k43g92axm7DFVPb20E?=
 =?us-ascii?Q?mjcc+g6PCjFpGQzdm7s19hPSN/7D+hiiQXFUMI0ZXVVWFCX9ushF1zOaKnPD?=
 =?us-ascii?Q?YpCnYlg+vvrd1J7jSCPQiNKyk/Oere3pvD4e6XqG4eX5/jcZ00ySs8P0aB0Z?=
 =?us-ascii?Q?jkgI2f8cf7hNMdTg0G2E2bSHvjczTbie1mVU09POT0jIcaUPJ3eTqdNq0OHO?=
 =?us-ascii?Q?UrUtrFMUrc0J3MxidtbSQ6ZXHBOFnBPWWABd9NEdwykG9oDNnqrV7nOa85UW?=
 =?us-ascii?Q?Qlpe5xMEUVhTyZfE41u3UxdSF4LCwReXc+AuQW7Mmf7IUgHVHnTc2tVx0EQ?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MMfk9AqDfba/ASPJ9PxFCUZoAJwVlV7Wc6EamBIA6bkLhh/IGTx3c52rTFEr?=
 =?us-ascii?Q?y49Go8kfDA/yvnCeHO0JXPcvFD9bBY3VcWjLWWSuYizvX8uY5BMBRkwqxUmN?=
 =?us-ascii?Q?IdEGIR1HDvQ3jqQQfHRNfHOTEd7+bRBcE7qdHjRIa9kXd3T/hy2clDx12IRK?=
 =?us-ascii?Q?voDctKaZ4yWIYcQ/KGqiMQEmWQzCICZYyZzEGs1kOZgilbgS6wpwbdvc2Z3n?=
 =?us-ascii?Q?msxdJJeewEH0QH+f3l/ZJ3aTWsFwfqGrUu10qolxRe8xJMrPGZ51M2NPcLy0?=
 =?us-ascii?Q?GKo2MQZLuBkUp/JomI5dxfINC5dyNnqHIiIaZ6LRABSFk4Yk81T3J1XPSIEU?=
 =?us-ascii?Q?iPbOXM4ZISuPv9kfVG4RoizkVzvyvOeQghxOfDP7EyCJNrlezQX1v0DtjNZR?=
 =?us-ascii?Q?B+ucUZExuoMtZHJGJkUOJKbUYAZSpoy3Im0iMObc0VpmPIbhQoZw6JD24T0v?=
 =?us-ascii?Q?6NYglsZ1nvxjYEn4cOr+i9WlRxPgpEYKfoMVDf6qL73Zj3NVp+Xyf7v+yB9j?=
 =?us-ascii?Q?ixVY0YYQ2T3NEqdWtjTstKODMxOXTL78Y3hDK/6mBfrO1dTWSWEBM9fLU8MH?=
 =?us-ascii?Q?F8EeXLFUVSXBNqJEmP758Eej9syDmDzwUwYayW16dqvaQw+/80Oogb2TJbRa?=
 =?us-ascii?Q?hFXHkz47UijsGnh8tDUkUCYHZCsDtm7KYmYI91rbrH8Vb9wnFeaq8N1w6d8t?=
 =?us-ascii?Q?N9IpQLkLnHYtWYoB0el5pCtY1lZBkl5d1ooNbIWrNxI36pk1IPbk/OpWopGT?=
 =?us-ascii?Q?braDXACAqH1yCFIcebQsh/VaaBeXtUsL5sTZPYzBbj7XTH0Q8wIsLY/d3w4q?=
 =?us-ascii?Q?98tfZgZQICQmSKzPmvvGiBSWXqXlAtcbz5fzjg8GEsLLeXO2hwspxxNRMtH4?=
 =?us-ascii?Q?kBi4OZ/81PuSe9aB4z/0x2Ny/x0g2d+iMX2CqdDt6hKsY95tza12HQap+RgE?=
 =?us-ascii?Q?RTLmH/lkF6CubA8jpXAkthneLMU4IzO0iaeArJ24kBFTh5z9kwZxmdwhDWye?=
 =?us-ascii?Q?hr6dQss6fzUoUy5B280JhVG3PIxwGS4JnQ8DKW5kMjAllta+PVVQ2WrCcGW8?=
 =?us-ascii?Q?Yt2jwuSGhd6oGeTcGv3VwjmQwAFNfg/VYrRoUn3eijPm1+n0VbShrUArf18z?=
 =?us-ascii?Q?1gHprGLGt5B0I97zarF2Z9UqoMSShXsJspi8fJ/cPed3cMCC1ct9Uvcxk27V?=
 =?us-ascii?Q?unEyLUh0Z1WOZjHJJGqOmb6+NQHfQ6JYFxCpWOCxd5kZzLpbNIwoWdTSSmab?=
 =?us-ascii?Q?j0aMVmB2peqQA8DNJXcP5muexnex3TeF6Svycm6kIFlgyTEdkRNHdWys6pHD?=
 =?us-ascii?Q?FNfwWJ9jQBfwE8TuvQt49yQi7u2SHfSEWYBfefxLaIakMZNBTNjthL16aMj3?=
 =?us-ascii?Q?7Oo/JygjkK2t2LwspI09Dn5GPHeXULFrgkEMUmuft/2HVkz6/7uGXEjqX8zO?=
 =?us-ascii?Q?35n/ZWVaM7inWlSqh02KaFFVxsnEL1wP87LPDnqLxEBttpzQUJoJKeRwHQxx?=
 =?us-ascii?Q?Gfh3v/g47bDZnf6yLfbVJc2wgH3zKd1DOuRIwNcFwenM+SxaPj58BFfL7afU?=
 =?us-ascii?Q?Sbm4raYKvy6U8OV4ufd7bGuX6pGHJmMUJITpKVDnDQKsfJ4b3UD5XOVjKE8t?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea1e016-08c7-4ff7-8253-08dce6103e7b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 14:07:42.2834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jIJASta2fPE6ddK0TsE3VcSEqLMXU0iMRJIMC/ryHtFe84uT8GYIp8AeaQCMlb88aJSxcIvjW8AXmuUI9UWm0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4961
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "blktests.block/024.fail" on:

commit: 5b0b8be85f1ca1c11566890f5d4564ee97cf2d41 ("[PATCH] block: move iostat check into blk_acount_io_start()")
url: https://github.com/intel-lab-lkp/linux/commits/Jens-Axboe/block-move-iostat-check-into-blk_acount_io_start/20241003-032648
base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-next
patch link: https://lore.kernel.org/all/550fc8a0-3461-49ac-879e-32908870f007@kernel.dk/
patch subject: [PATCH] block: move iostat check into blk_acount_io_start()

in testcase: blktests
version: blktests-x86_64-80430af-1_20240910
with following parameters:

	disk: 1HDD
	test: block-024



compiler: gcc-12
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410062110.512391df-oliver.sang@intel.com

2024-10-06 11:02:24 echo block/024
2024-10-06 11:02:24 ./check block/024
block/024 (do I/O faster than a jiffy and check iostats times)
block/024 (do I/O faster than a jiffy and check iostats times) [failed]
    runtime    ...  2.673s
    --- tests/block/024.out	2024-09-10 23:15:59.000000000 +0000
    +++ /lkp/benchmarks/blktests/results/nodev/block/024.out.bad	2024-10-06 11:02:27.595709543 +0000
    @@ -1,10 +1,10 @@
     Running block/024
     read 0 s
     write 0 s
    -read 1 s
    +read 70000 s
     write 0 s
    -read 1 s
    ...
    (Run 'diff -u tests/block/024.out /lkp/benchmarks/blktests/results/nodev/block/024.out.bad' to see the entire diff)



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241006/202410062110.512391df-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

