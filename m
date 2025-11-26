Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2332E22BA
	for <linux-block@vger.kernel.org>; Wed, 26 Nov 2025 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764163545; cv=fail; b=R7TJ9ZMvvDHb7UNIN69wMy4mrGM8w8ccTv09iK5FsAySpl/3c25JXYD64NwEyIr5W1Rfd07jaxgbofe1Fe6GjFmQ+BnNFOULnDMVlWHorSkZr/DnXqM4mEzIFvFgXa+N8LabcnXSbR45LMrAajBlquvECAGardRRrfTb00+7y7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764163545; c=relaxed/simple;
	bh=TbE7S4XjWSJ6SOxmiHqNC3GFc0auHg0+TAjdJATcFy8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=hDtP4zzncgkc4JR5w1uFHxhxDBQ7UosLjaWVTE2OqbnidpfKj3pl5snT/haKQuRBMAx5ZkIlOXc1I0IqQrtnCPCWhYIvwhFfOmiqUns6+Y91epHus2PrXKWYzvkWXYajqU10gh1aixSqf57KHb/pSVInMrHaHqkV4CnO1dqRF3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hn1qS3yb; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hn1qS3yb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764163544; x=1795699544;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TbE7S4XjWSJ6SOxmiHqNC3GFc0auHg0+TAjdJATcFy8=;
  b=hn1qS3ybAhTvESak5x+mVs32mJg7xSNhC2abF8rLrGT2Ts1+37LN1QzT
   RPB/bX8xBkYNMubuwJFNSkrKBvuHPiTGl0+u4Y0khieuoL9CGCzYRL/iI
   75AMUpIndhlbMmcvHL11aQLj4IJ6TSUFU2jqnf3j6RGmI5GTACJFKuo57
   1HqL3Uoil2EfS/OXOzcifDc3tPTxp4BGgX6YcmBI24qzt9Tih6qK/EQTr
   whnSNzpgp3CFnOfKGUm0Q9njgcZe8rOgjt8/syMXF1vUKuzr9rOR3KMbe
   8GSIqekMXM4Ucrn3t3KA4WqtuaMT8+hvnDu0kaZqRox94x8z9FbufZshN
   g==;
X-CSE-ConnectionGUID: zROui+r8QiK5EV7esMMxvA==
X-CSE-MsgGUID: dvipJQNFRf+yyZWfZUt4kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="83592797"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="83592797"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 05:25:43 -0800
X-CSE-ConnectionGUID: yk85Kh21Q5SeEkOYHOs+1Q==
X-CSE-MsgGUID: kNFvqP7jSM2zW2ZfJUisiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="223657929"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 05:25:43 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Nov 2025 05:25:42 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 26 Nov 2025 05:25:42 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.43) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Nov 2025 05:25:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scBTFSKyVsll/AdpMYnfhBldw7B1Lnx3KoVDaf9HMhS9MDYatB86pN0Iats030RQxtv2KUB2/PpJ1DETT3V73Qfm9mRnOeOivMPIX+M/f+aK/nP7XAcsKJNId/+qQHo1YzL4wgfwCekkS1t7GeNARppA1br8RmomJG3WfBUcc1kq5ZP555472ds1KagcbNbKrWtw/uLcj7avkKtQRaXWk/sQP5lRhKfo8IOBPIBVSPuI9rL2zn7VdOWMip/MuMB22u1ymtKxL9DGufcnpGo+frEbtq2/IRkhp9aJyRtfXP9FixOWTBC9C3ZemxPyVax7vkRHEpXOZdZHjTjBbyq6HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vScPiG2CnORV0CwlBeZqySxfSlfesfP0DuMw1f1GgEo=;
 b=mAORve11ODsD31LGT0OqGJ8drEQ1FVnCwc9d/Adngra5jR4oxan4Q+XOSAH72VzFjz8oa9aY7+OVqGMGMpZ41T3AaV2U6DRsgwx4MuGbHaLLn3eDOa40FqYwsi9PHLeKrkiW0+Pev9Gjrky/PSG8Bbn/FAM8TnfV61R8JVr6r7kTCgNxxdVv2vtPbk1CMnnKW+qxJQUWt7HDFlZXZ3TsdmsWPOAgCpFOzRhhfezMNJYoyJDHAo/unoZfTo96qQEzhCoiBgpp3PRcxXPKPcullM6aVQGG+L7r2bMhbrOBnTXzVcmgdrPLjLTXb5r8ud0XEPcWSq7fkW245lXVXbFwEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS7PR11MB9449.namprd11.prod.outlook.com (2603:10b6:8:266::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Wed, 26 Nov
 2025 13:25:40 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 13:25:40 +0000
Date: Wed, 26 Nov 2025 21:25:33 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ming Lei <ming.lei@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [loop]  0ba93a906d:
 kernel_BUG_at_fs/jbd2/transaction.c
Message-ID: <202511262144.9c2a4258-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: TP0P295CA0019.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS7PR11MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: 46f54852-3cbb-4a26-1c9e-08de2cef4b58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0RQeqM9Ky4Ddtmji/C6u9sVbBMgiTOxkeEKa+qwwYpKAgWzR/6unrllB86Vn?=
 =?us-ascii?Q?xnx48fM0QmekZYFnv0wZiCAg6sGMf1Sbd1LMveGHtC6ddW2oRRPC+QGVGdzw?=
 =?us-ascii?Q?WpvKKYRdJ0/wZpPH2Ic+Sxgjln51/B6ORMybGUAAonmN721dgCDYM7CerRP+?=
 =?us-ascii?Q?+ccM3U4X6ZtY9OA3pzTM9fC0jxx1P5y0GtI4hwcXnGD7kiyZaZoq7wpdZxpc?=
 =?us-ascii?Q?OKOz28FwhLaSMi/0exqIM48iYW9wHwODpf3+Vxj/uGqS6amgeZrhkgsetaoI?=
 =?us-ascii?Q?japouhwHO446cMl2lBtIFzMDWNMMutbAO6SqeTzs4IlJDqpfcFDFt3+WY4iT?=
 =?us-ascii?Q?SMQShUfl1RSB4oKHxATlfDbBo1r6+7qShcK2uhM2Pz71Fvk3KIHCfLPm9A5V?=
 =?us-ascii?Q?1QP/5oDo8Dkm0rrTKkT9BihGJN6wjOSo8Rd7K/qdEIvGvWO9px5VtU9geQFU?=
 =?us-ascii?Q?vPcHxRSX2MIX70xNrBODB65/NxUEDz8MXtOveG6ZxHBTePtQ1wfcMIQ93rrw?=
 =?us-ascii?Q?KmvEmObwnX2XYvWvX+BeqoTGjKiH0VmEPkhcBGgI1C1P9RaCcR7YuX88uCof?=
 =?us-ascii?Q?Dp5XsJNNK9GctaITP26TwcX6TMQ/gIusanZEu8v1D5JbwZrNP3J/RfZVxsrE?=
 =?us-ascii?Q?hSEejVf6hfJHgAQluMtXbfHwH9ybaoo5Jj0k1fZhpK+fS8FpCiFHo6XFk9hd?=
 =?us-ascii?Q?p8iR8AWxv0F3tI6i1kD1lEFFokuUJG+2wQgJmdhjZ0dARY1fILDC2UD34IIm?=
 =?us-ascii?Q?aqr8y7utJlardVJdljIrpHz6McBqNMDQWSiCZ19HM/chBVxJDq1ghdEodPqD?=
 =?us-ascii?Q?iHpV8gNIPXJ0xyJLHBBzX/npO8YOYWvmiF8jDZqblaoQXJmDo36payGA4GDs?=
 =?us-ascii?Q?5XZix05bWk3FflbSjlK+9UeakWfb6/DSMg1kQKoXpUqpUxrgIkZI5GqyVmdY?=
 =?us-ascii?Q?1EUPU07Vpr+V74fMKVyJgUi4mJ8FV8S2Gjx943rT6P7XqdvznsTSw5Z32/Mc?=
 =?us-ascii?Q?przsathdk7WAfDeBK5Vi/zNMbXoNgWC12NNExE7S0blaLjkTQuCMYSw8epPX?=
 =?us-ascii?Q?X0qnbL/aFOI3a6KIiRptNEft6zpx2WUSWSFyuvJTORSy5j0hqHTJpUlJi8YO?=
 =?us-ascii?Q?Uulh9itgU1vPb73hDAIMjcGjm1reI7KNPxVott8x/0P0aAO3dAqB1BH3fNIv?=
 =?us-ascii?Q?ie666+Fox02po1Ws6IjRIf+Dw9nzsT5SDN1DPvqz20jgUCx73BtzJhbDCSz/?=
 =?us-ascii?Q?7aTNhmlxUf65OThUrHgmSfDyGVA29Yo3IEns2dwwP6h2VUgi6bcriF7P3TDf?=
 =?us-ascii?Q?JxfpRAUQh0+RXqWu18b4rM+tkk/oxrcoQiOKFGWobjsAWSthHXVeDY1EmNVw?=
 =?us-ascii?Q?s/fL1moh1SxKauZiR4UH+HLNMcUXi35LWs22hZ/svWhzBYgvom3dak8ycGpw?=
 =?us-ascii?Q?B+8FTuj8jlnP9gbltLzOLSbOZqQn7AFFjU1ffjFycC03vnWI+JS7qg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WQa5IDS7cqr5eSSCIb1d06FOO2YfzXp3JeH3j9FVr3SXGW4OMPMYrBHAwEH/?=
 =?us-ascii?Q?Zbwlerw/QXhQvNvcaze/yGyI8B1Qkevyo8kXkp3nKwdi2eowE5vQn1+kHLch?=
 =?us-ascii?Q?JIrXJOyxzzUEZXSB1zIfmprJTbFrsUz/heORYnu6nX4BrANm5S+eLfnNdQT2?=
 =?us-ascii?Q?nFx0mvBBZXqFDLfVYV4J0GVC7ena6D6TL9nmyQG6oQu8wpUOcKt8M4qnk+2H?=
 =?us-ascii?Q?xUDFzcqwyMBkaRgjJd1XcgWxVqnknMrGtgfXbrV6twyCoww7onQW3w5NWW0U?=
 =?us-ascii?Q?wS+md+uidZM6GW/yAyWAG0/JAuUFuw7JzztjTArQF3xoWacMOAhIjZo1qRil?=
 =?us-ascii?Q?vgeRLC67AGL9hhcxwzG2dBpsRletxF4ERwYFNKv8l9CPx7PmeNIy0iIPAsLD?=
 =?us-ascii?Q?9nokdzp/0g0xra/Q9FRRcOj0qu32QiqcwF94TwcglRu5soIiox4JMk8srqQp?=
 =?us-ascii?Q?r+LuW2F/fbtCTE/IoIcKFtf+AkGsFGz7/Zk/tiIM8YJ943DjYdHHnPWHdyBu?=
 =?us-ascii?Q?pQS9OmuNqX2/GkSOtBeU4tHkupsBCWpfBTZ+DUl9MbxLY83xNP6DDliDszQx?=
 =?us-ascii?Q?lnuz5eAUSLhix5i+cg0uI/oND19+DvkMLGT+D6MrqQ1aCuXjWG9PfYKDWnc9?=
 =?us-ascii?Q?MmAEIvPJsJ9mEjkCSPi9rd3XWYcdZWxilVDpw2DlhkzL727TesCOjq9gg634?=
 =?us-ascii?Q?y3MzXpEIOtE6wx98BiEMkbFqeZG6otAYLJMH39ty4SbzmhaRofFDeDUsgB4n?=
 =?us-ascii?Q?HAKLy+/IQtICuuDTgMT3MYbwQuz5Zzv9mgv0AqGzV+QH5GPaopUZA/NRvYkN?=
 =?us-ascii?Q?BGvtWz1EhumiGBITUQHPHWzq4/kWFPn/M42bWfDuk1aVwrpIb00H7oOm0HW4?=
 =?us-ascii?Q?SuJPpeK+KoEoFP0BjhN0ECo/klZtzxgGkf5+CVgbTyBBp7jz4VAWSWAcdNBX?=
 =?us-ascii?Q?HtgTkPTk0lSB5sWo/k+jyiOet+kf08sdmErjNsZ/PEvAi9Sdb/mkRvG0/qpl?=
 =?us-ascii?Q?E+q+0EwnwjRMQs5ZHy5UpTq/Apx7HDgLLEyEfzY64raue2O2dPOuM3W5/cQY?=
 =?us-ascii?Q?yxEmqdGIGOQPNVYrFxYRpp4nkVXd6jUghQSMguRpY6/FlUIjZbzHh0H19zVm?=
 =?us-ascii?Q?Gki6kaI6jZXogUqmM1zxKX8BLuCJMsNIf9bAam0ByLzsUCHuLjxzV3/9T6C9?=
 =?us-ascii?Q?urYO8hji3j3BQGYwdmI14gI2CSzdMdSp8+fo+tdr94Nc5viOJyT4k2F00YjI?=
 =?us-ascii?Q?Y5MR/OTcUA9ILLaM2BZoRFLz7pk/HHdXdqYqnQKbyxzUvH1cxVmXh+FWRDHV?=
 =?us-ascii?Q?MPz5ydX6kJjNInwe8mSwUD1y+iMafT/PHyqkDTPY5ECOgVdooH7m8Y1/s5s/?=
 =?us-ascii?Q?zJt6bW2r7wlv34gBSZllZG71edqJBQ4bIDyNVex6yffLYv4MmlI3GacbiPvn?=
 =?us-ascii?Q?HZLsGF91rLYo6V5tKecsNO5fFy5KJ3ddoAiN3EzHpmmINnZ+FWA1LZnnQhOf?=
 =?us-ascii?Q?gjxRRzrhc+miwka0iL16PY9Y0y3OsXrpxGuhBUYEu2qv6OGpQSXRbw6C6mbs?=
 =?us-ascii?Q?Rck4e2VtfzQKCBO+xn56Y1lYKxZbQX8th3FULUdfOxwxY+4Ihs9C1gX/Ji2/?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f54852-3cbb-4a26-1c9e-08de2cef4b58
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 13:25:40.7001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWSoZdIxvorJILBvwWqTTxdnCPOlVnX898tGPc8dTNLjK4WYP072koK5TgqD4hBWdYLoOCQKrLCxZkUk/DISsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9449
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_fs/jbd2/transaction.c" on:

commit: 0ba93a906dda7ede9e7669adefe005ee18f3ff42 ("loop: try to handle loop aio command via NOWAIT IO first")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 422f3140bbcb657e1b86c484296972ab76f6d1ff]

in testcase: xfstests
version: xfstests-x86_64-5b75444b-1_20251117
with following parameters:

	disk: 4HDD
	fs: ext4
	test: ext4-group-01



config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202511262144.9c2a4258-lkp@intel.com


[  939.823614][T22441] ------------[ cut here ]------------
[  939.828895][T22441] kernel BUG at fs/jbd2/transaction.c:477!
[  939.834554][T22441] Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
[  939.840607][T22441] CPU: 2 UID: 0 PID: 22441 Comm: resize2fs Tainted: G S                  6.18.0-rc2-00132-g0ba93a906dda #1 PREEMPT(voluntary)
[  939.853453][T22441] Tainted: [S]=CPU_OUT_OF_SPEC
[  939.858033][T22441] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.8.1 12/05/2017
[  939.866057][T22441] RIP: 0010:jbd2__journal_start (fs/jbd2/transaction.c:477 (discriminator 1))
[  939.871760][T22441] Code: 00 fc ff df 49 c1 ee 03 41 80 3c 06 00 0f 85 e1 02 00 00 48 8b 3d c6 1f 36 05 48 89 de 49 63 dc e8 8b c7 a3 ff e9 cd fc ff ff <0f> 0b 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 24 48 89 fa 48 c1 ea
All code
========
   0:	00 fc                	add    %bh,%ah
   2:	ff                   	lcall  (bad)
   3:	df 49 c1             	fisttps -0x3f(%rcx)
   6:	ee                   	out    %al,(%dx)
   7:	03 41 80             	add    -0x80(%rcx),%eax
   a:	3c 06                	cmp    $0x6,%al
   c:	00 0f                	add    %cl,(%rdi)
   e:	85 e1                	test   %esp,%ecx
  10:	02 00                	add    (%rax),%al
  12:	00 48 8b             	add    %cl,-0x75(%rax)
  15:	3d c6 1f 36 05       	cmp    $0x5361fc6,%eax
  1a:	48 89 de             	mov    %rbx,%rsi
  1d:	49 63 dc             	movslq %r12d,%rbx
  20:	e8 8b c7 a3 ff       	call   0xffffffffffa3c7b0
  25:	e9 cd fc ff ff       	jmp    0xfffffffffffffcf7
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  33:	fc ff df 
  36:	48 8d 7b 24          	lea    0x24(%rbx),%rdi
  3a:	48 89 fa             	mov    %rdi,%rdx
  3d:	48                   	rex.W
  3e:	c1                   	.byte 0xc1
  3f:	ea                   	(bad)

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
   9:	fc ff df 
   c:	48 8d 7b 24          	lea    0x24(%rbx),%rdi
  10:	48 89 fa             	mov    %rdi,%rdx
  13:	48                   	rex.W
  14:	c1                   	.byte 0xc1
  15:	ea                   	(bad)
[  939.891057][T22441] RSP: 0018:ffffc900011ff0b0 EFLAGS: 00010206
[  939.896939][T22441] RAX: dffffc0000000000 RBX: ffff8881c2580c60 RCX: 0000000000000008
[  939.904715][T22441] RDX: 1ffff110219c19e0 RSI: 0000000000000002 RDI: ffff888289698d88
[  939.912494][T22441] RBP: ffff8881107ca000 R08: 0000000000000c40 R09: 0000000000000001
[  939.920294][T22441] R10: ffff8881104c4237 R11: ffffffff81e75650 R12: ffff88810ce0cf00
[  939.928061][T22441] R13: 0000000000000000 R14: ffff8887fb9126b8 R15: 0000000000000001
[  939.935827][T22441] FS:  00007efec8397100(0000) GS:ffff888803fbd000(0000) knlGS:0000000000000000
[  939.944540][T22441] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  939.950938][T22441] CR2: 000055903d381a28 CR3: 00000001aa534004 CR4: 00000000003726f0
[  939.958704][T22441] Call Trace:
[  939.961819][T22441]  <TASK>
[  939.964591][T22441]  ? __pfx_current_time (fs/inode.c:2289)
[  939.969431][T22441]  ext4_dirty_inode (fs/ext4/ext4_jbd2.h:242 fs/ext4/inode.c:6514)
[  939.974014][T22441]  __mark_inode_dirty (arch/x86/include/asm/jump_label.h:36 include/trace/events/writeback.h:149 fs/fs-writeback.c:2568)
[  939.978766][T22441]  generic_update_time (fs/inode.c:2107)
[  939.983532][T22441]  touch_atime (fs/inode.c:2119 fs/inode.c:2190)
[  939.987781][T22441]  ext4_file_read_iter (include/linux/fs.h:2673 fs/ext4/file.c:97 fs/ext4/file.c:145)
[  939.992708][T22441] lo_submit_rw_aio+0x194/0x530 loop
[  939.998581][T22441]  ? arch_stack_walk (arch/x86/kernel/stacktrace.c:26)
[  940.003166][T22441]  ? __pfx_lo_submit_rw_aio+0x10/0x10 loop
[  940.009558][T22441]  ? __rq_qos_issue (block/blk-rq-qos.c:49)
[  940.014054][T22441]  ? blk_mq_start_request (block/blk-mq.c:1370 (discriminator 2))
[  940.019151][T22441] loop_queue_rq (drivers/block/loop.c:484 drivers/block/loop.c:1977) loop
[  940.024165][T22441]  __blk_mq_issue_directly (block/blk-mq.c:2001 block/blk-mq.c:2712)
[  940.029347][T22441]  ? __pfx___blk_mq_issue_directly (block/blk-mq.c:2696)
[  940.035133][T22441]  ? bdev_count_inflight (block/genhd.c:169)
[  940.040058][T22441]  ? blk_mq_request_issue_directly (block/blk-mq.c:2794 (discriminator 1))
[  940.045930][T22441]  blk_mq_issue_direct (block/blk-mq.c:2818)
[  940.050854][T22441]  blk_mq_dispatch_queue_requests (block/blk-mq.c:2892 (discriminator 2))
[  940.056726][T22441]  blk_mq_flush_plug_list (include/linux/blk-mq.h:251 block/blk-mq.c:2976)
[  940.061909][T22441]  ? blk_account_io_start (block/blk-mq.c:1131 block/blk-mq.c:1106)
[  940.067093][T22441]  ? __pfx_blk_mq_flush_plug_list (block/blk-mq.c:2954)
[  940.072791][T22441]  ? blk_mq_submit_bio (block/blk-mq.c:3228)
[  940.077888][T22441]  __blk_flush_plug (include/linux/blk-mq.h:251 block/blk-core.c:1232)
[  940.082576][T22441]  ? kasan_save_track (mm/kasan/common.c:69 (discriminator 1) mm/kasan/common.c:78 (discriminator 1))
[  940.087255][T22441]  ? __kasan_slab_alloc (mm/kasan/common.c:342 mm/kasan/common.c:368)
[  940.092093][T22441]  ? __pfx___blk_flush_plug (block/blk-core.c:1222)
[  940.097277][T22441]  __submit_bio (block/blk-core.c:1253 (discriminator 1) block/blk-core.c:651 (discriminator 1))
[  940.101600][T22441]  ? __pfx_mempool_alloc_noprof (mm/mempool.c:389)
[  940.107128][T22441]  ? __pfx___submit_bio (block/blk-core.c:627)
[  940.111967][T22441]  ? bio_init (arch/x86/include/asm/atomic.h:28 include/linux/atomic/atomic-arch-fallback.h:503 include/linux/atomic/atomic-instrumented.h:68 block/bio.c:281)
[  940.116117][T22441]  submit_bio_noacct_nocheck (include/linux/bio.h:609 block/blk-core.c:725 block/blk-core.c:755)
[  940.121578][T22441]  ? __pfx_bio_alloc_bioset (block/bio.c:511)
[  940.126762][T22441]  ? __pfx_submit_bio_noacct_nocheck (block/blk-core.c:731)
[  940.132720][T22441]  ? submit_bio_noacct (block/blk-core.c:877 (discriminator 1))
[  940.137741][T22441]  ? __pfx_end_buffer_read_sync (fs/buffer.c:159)
[  940.143276][T22441]  ext4_read_bh (include/linux/buffer_head.h:418 fs/ext4/super.c:207)
[  940.147605][T22441]  ext4_get_bitmap+0x9b/0xf0
[  940.152624][T22441]  ? __asan_memset (mm/kasan/shadow.c:84 (discriminator 2))
[  940.157043][T22441]  ext4_setup_new_descs (fs/ext4/resize.c:1322 fs/ext4/resize.c:1368)
[  940.162064][T22441]  ext4_flex_group_add (fs/ext4/resize.c:1590)
[  940.166990][T22441]  ? __pfx_ext4_flex_group_add (fs/ext4/resize.c:1539)
[  940.172433][T22441]  ? alloc_flex_gd (fs/ext4/resize.c:269 (discriminator 4))
[  940.177014][T22441]  ext4_resize_fs (fs/ext4/resize.c:2166 (discriminator 1))
[  940.181596][T22441]  ? __pfx_ext4_resize_fs (fs/ext4/resize.c:1998)
[  940.186607][T22441]  ? security_capable (security/security.c:1181 (discriminator 1))
[  940.191287][T22441]  __ext4_ioctl (fs/ext4/ext4.h:1787 fs/ext4/ioctl.c:1746)
[  940.195780][T22441]  ? __pfx___ext4_ioctl (fs/ext4/ioctl.c:1526)
[  940.200618][T22441]  ? do_faccessat (fs/open.c:533)
[  940.205114][T22441]  ? __pfx_do_vfs_ioctl (fs/ioctl.c:494)
[  940.209951][T22441]  ? __pfx_do_faccessat (fs/open.c:468)
[  940.214792][T22441]  ? __x64_sys_access (fs/open.c:550)
[  940.219460][T22441]  ? do_syscall_64 (arch/x86/include/asm/jump_label.h:36 include/linux/context_tracking_state.h:108 include/linux/context_tracking.h:41 include/linux/irq-entry-common.h:261 include/linux/entry-common.h:212 arch/x86/entry/syscall_64.c:100)
[  940.224042][T22441]  ? __handle_mm_fault (mm/memory.c:6318)
[  940.229054][T22441]  ? fdget (include/linux/atomic/atomic-arch-fallback.h:479 (discriminator 2) include/linux/atomic/atomic-instrumented.h:50 (discriminator 2) fs/file.c:1167 (discriminator 2) fs/file.c:1181 (discriminator 2))
[  940.232863][T22441]  ? __pfx___handle_mm_fault (mm/memory.c:6229)
[  940.238132][T22441]  __x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:597 fs/ioctl.c:583 fs/ioctl.c:583)
[  940.242715][T22441]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
[  940.247123][T22441]  ? count_memcg_events (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 mm/memcontrol.c:560 mm/memcontrol.c:583 mm/memcontrol.c:564 mm/memcontrol.c:846)
[  940.252136][T22441]  ? handle_mm_fault (mm/memory.c:6360 mm/memory.c:6513)
[  940.256889][T22441]  ? do_user_addr_fault (arch/x86/include/asm/atomic.h:93 (discriminator 4) include/linux/atomic/atomic-arch-fallback.h:949 (discriminator 4) include/linux/atomic/atomic-instrumented.h:401 (discriminator 4) include/linux/refcount.h:389 (discriminator 4) include/linux/refcount.h:432 (discriminator 4) include/linux/mmap_lock.h:143 (discriminator 4) include/linux/mmap_lock.h:182 (discriminator 4) arch/x86/mm/fault.c:1338 (discriminator 4))
[  940.261904][T22441]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[  940.267602][T22441] RIP: 0033:0x7efec84a48db
[  940.271839][T22441] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
All code
========
   0:	00 48 89             	add    %cl,-0x77(%rax)
   3:	44 24 18             	rex.R and $0x18,%al
   6:	31 c0                	xor    %eax,%eax
   8:	48 8d 44 24 60       	lea    0x60(%rsp),%rax
   d:	c7 04 24 10 00 00 00 	movl   $0x10,(%rsp)
  14:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  19:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
  1e:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  23:	b8 10 00 00 00       	mov    $0x10,%eax
  28:	0f 05                	syscall
  2a:*	89 c2                	mov    %eax,%edx		<-- trapping instruction
  2c:	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax
  31:	77 1c                	ja     0x4f
  33:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
  38:	64                   	fs
  39:	48                   	rex.W
  3a:	2b                   	.byte 0x2b
  3b:	04 25                	add    $0x25,%al
  3d:	28 00                	sub    %al,(%rax)
	...

Code starting with the faulting instruction
===========================================
   0:	89 c2                	mov    %eax,%edx
   2:	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax
   7:	77 1c                	ja     0x25
   9:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
   e:	64                   	fs
   f:	48                   	rex.W
  10:	2b                   	.byte 0x2b
  11:	04 25                	add    $0x25,%al
  13:	28 00                	sub    %al,(%rax)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251126/202511262144.9c2a4258-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

