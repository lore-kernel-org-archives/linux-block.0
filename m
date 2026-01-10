Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6C330AD06
	for <linux-block@vger.kernel.org>; Sat, 10 Jan 2026 13:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768051476; cv=fail; b=khgHONg+8fUCiAQHTjMKCenbyXe9lDCKrhGxnIye4LqgZlOk9zZcUIhDDPnvyBDZz8sWL27MiSiMp0OUZGUUCi/VDw0g/BgFi1dEh1XR4JeqgKV1CUDh4SSZAnXn627TjRIPZwdcoD6nAMR9bAuOxC7N6Kwpqc56WRfwTeMqg+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768051476; c=relaxed/simple;
	bh=9Hi5eEq1/G66LMeynZJbloQSA8ruumvkyoPmB5qOzsk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=cJb7nvtyn8WWkCbfSQqppIFNefRoThH0/3r1FtQMjNZ9QXn7FBWvRcBguUYJ6RBlTzVRtVlyuBCZVVXzLw3SDCByF6KynGXkA+6WE8aoVbr9RYESegGdFdgt9eQLfUqtg3R21WX80pWkG/ZpZOjwqFjugKGbuAwHkXvepxbFf5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jkx9aOmS; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jkx9aOmS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768051473; x=1799587473;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9Hi5eEq1/G66LMeynZJbloQSA8ruumvkyoPmB5qOzsk=;
  b=Jkx9aOmSnwRdj63ns+vJjZVTHtjEtl8g0810Yxcd2r45xgRvfvFvziI5
   heNHNE1Itl1oBWv1oA8K2+vkLQNaEqzIZs7izJwiX4BZkW79t5/J7a+5f
   hfogEcGk1UC+8j+VKRteei2+CSB/Ie8OQ0IkdVOJTOglbbatH8n5SIoe7
   jSSnahJ8CHoaxDqySZEP6xT1H8NDOzvgLSwF0mgPvy/0JKGuu1nlj/pHG
   vSOi2UMgjyp35hMZYZsKKO+kG/tNvgG9TvVNh1d0+Z0sdztWeNHKiLMwA
   KRqXLTv2l90NFqqXpgksarArDajKC0iXp35tWr0wEYMTztuCDv4SuhD4l
   w==;
X-CSE-ConnectionGUID: G2aTZZKPRXy1q6nE6ze9MQ==
X-CSE-MsgGUID: 35/thjlwTAewBmU8KrTP0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="69453484"
X-IronPort-AV: E=Sophos;i="6.21,215,1763452800"; 
   d="scan'208";a="69453484"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2026 05:24:33 -0800
X-CSE-ConnectionGUID: Fp7aqWpMRty+dr5XbMG4LA==
X-CSE-MsgGUID: 7HqYjNa6T1aR8jETB9lTjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,215,1763452800"; 
   d="scan'208";a="202900918"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2026 05:24:33 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sat, 10 Jan 2026 05:24:32 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Sat, 10 Jan 2026 05:24:31 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.66) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sat, 10 Jan 2026 05:24:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyhRb5zvjPbgVuI/Zaq7nmBXMfnyuKdPr/0I1joE+aMLKwV5fPAmcqWJOiYFIb7cTCXaBgSb5n5NsASSDt7jISTHT6QujvoACpv1idTMg2I5PqV8MQVyEurrZnJFv1pS8UFVpnRLcyKmwIMiLgfkYQ3yxLgIJpmNWjpbuUM4nd/RFdDNloyECJU6p2y1HoAEXI22fx4O5FuuUL6E6XMIDP4VBPUnYCK2zQYvqP3xI5R/D/4M3gWp1isiT/TXFKAPXkejDeAS+IuEfOLprbNH1rv82tomzDndCoOLJBlkw0/afmRCH9Gx1W3LHxzuhGLzG8ikLLP0hnSD5doBX0H2zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=028U7fgDDAe5gXmgJHi7MnUeltuauJhiReCKVRHnsD4=;
 b=c9tOazozeO+FL/Fk2f8w/+pAFXosz1gf0F2lKeZFsDirNZSFh3xWcfrPryrsk0ICwsYUdUrB1JUmFQ70GiMg1P/ScJTlbhRbNnqBdpw8aACus7luiCpydxAY+CExtvKqxJdl5ygEqf4+hoVefh78YiFiM5139hZodZFlMgHVWC04SvYUWcbVxpYjvvKNu7i4wrcJTeGxtlilXmW8mQ+2QeDdy4ZUDt5O+pM64wEPi+RoRzLRrY92QZhac6ny9HYvjvqT6t3bQrvB+oVzF5njjlQmyupEiaceyt7pbDeayS1Qqow61YR9z05eLj4fn5vWc5qH9GLj6hFZPI5KyQdz9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB6147.namprd11.prod.outlook.com (2603:10b6:208:3ed::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sat, 10 Jan
 2026 13:24:28 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9499.005; Sat, 10 Jan 2026
 13:24:28 +0000
Date: Sat, 10 Jan 2026 21:24:19 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ming Lei <ming.lei@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Nitesh Shetty <nj.shetty@samsung.com>, <linux-block@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [axboe:for-7.0/block] [block]  ee623c892a:
 BUG:KASAN:slab-use-after-free_in__blk_rq_map_sg
Message-ID: <202601102120.cf5782cf-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c8049e-5061-400e-5e23-08de504b94d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GakYWE8/cXAtdU5Qf0tjpoRZxhhN5i5/lKAAZikcg68GbvnZtYRPlbgmHW9n?=
 =?us-ascii?Q?0Xo6ttJdi+qgN5+71MgFMwUoERAr68ggXeUxJeyqiTk5pj/8HBKWmX1uxeXn?=
 =?us-ascii?Q?HKdlptRwKi4MDw7NZCqn+7MlyUvcIufiZ8ei6vvPL2AyX+YZFXSwfL2egqKi?=
 =?us-ascii?Q?C5nbMGbHDUAmt93JkpgQvBDE2cafgTB1Jj6V8SQKbE5UaXWuxzp+GTDzJzN8?=
 =?us-ascii?Q?WjY1w3sIkBfvsIPq6h7YZvuwRhvl8ftrDi45x31RIq6V1awwWcbp/VWWP51g?=
 =?us-ascii?Q?GyRn1IX2ouyntjnPgT/OsPY0fP5vpMwNe3NlaLFMzhlv0skTpqwmM3LBzx/N?=
 =?us-ascii?Q?jlodWVNTpfvGmVKRPxySn9x1JHEP3+LWN1JF4kMx9Cy1DZGRZJsnejQVWtrq?=
 =?us-ascii?Q?VoFa/U8qL6vUYL+Td8q7yCH9pZzyTEi1srb9w44DOH1Myx9xShaqIwJExzKl?=
 =?us-ascii?Q?TXoodPEfl6jk5B/LWYPAW/aDtwR8tTUsjHStqfZg86Zcuoo57h0r6Mhnp0/7?=
 =?us-ascii?Q?6FChc7XCXzbFrOimwc+D8S9Iqd/BaQ4wC0RuaJq8KKjTnpGF93HrxHyGjNlc?=
 =?us-ascii?Q?OzJ64L3zZgBFjDeaatYShDIYiG66gO1NoRBpThgmCXBEOvGTLKgAW7TuJ2zd?=
 =?us-ascii?Q?vrC2ZeQwWkWXdkn6YvxJgHnuJ7v7WudaJexvwBDjo80yJ3HXePt17uScXmBU?=
 =?us-ascii?Q?Wh+VjGKgBOE7pcGTFMVeApkI3wybvBl91EUFKidSBN5sYB0iru3+mbsGE7aB?=
 =?us-ascii?Q?RzLjTpp8p8OpIoTUJ9HXszhJd42HJ5g6B/z4343DxWwDnPn6RS023j1eZLZU?=
 =?us-ascii?Q?mmTU7fDycEhbwtz2CX41er13PkXn9RN4xcjDVMhC/GkNB5IL76AwKxK66sfz?=
 =?us-ascii?Q?EV+/wdo4jPomRCasoSiOhNYpI67XI2VrhNxNgU+UKUJnVD84IHTpHhipi/BK?=
 =?us-ascii?Q?8wxcxAJRLpeWBNNWbbV0uGcjm3Jfz7D4FfaHZBYtPHUp4Mg7Zz07IuugVhvw?=
 =?us-ascii?Q?0659jWzQ0EfuOH0/rBxxTO85Yi8j/jjd2tl2e8LwqF/ohtRiTF7yTXnQcYvA?=
 =?us-ascii?Q?gykPdOcfwFrrZmNV5DVOJ6PAx/9SI+1TJHq8wnXk91RfheuAWzA5Mx4CJMl7?=
 =?us-ascii?Q?sJn9HIZAMgYGuLGA3d5Jjy0JkX2MefED64hJzl79tH4h0HK0/dxUVBr8vHXu?=
 =?us-ascii?Q?83wribB/yniuckbSJHcIYsE2HAMsjQUoee/oQZX4oBnfYIw2iaFgEyDqtmFB?=
 =?us-ascii?Q?h/OUxpO3adckEiSL3+TtHj4jwEe5QJx4lpW/ZsqnZMQDB69FQw15VEVMmSIs?=
 =?us-ascii?Q?/GAbPrdluNcrZyu//GwBXaAqbsgIoNU+crF3CzHOV8kHQmTs0WUDMYLK29wx?=
 =?us-ascii?Q?c0Lr4GKfMLWWJM6ztpV6TxwSB8c/7RqTsj+wiW4ViZikNnKAsWhJ6lhwKMTB?=
 =?us-ascii?Q?fxrLhaHQs2JGtmlPuP70t7HYImJm8t180kBh8ZgWt6+WSfxZcwVq0Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LcbelkiPZ/aRWNggtBRn3EwBJ1LxfVgeEVJWjAVOowSgYFhWitMuCm/A82yp?=
 =?us-ascii?Q?arEqPHxEUv4Fdy/FoFWpuaAwnJLE7kHf1BCSPRn8FY7HVLAc71OhEFPpvbF3?=
 =?us-ascii?Q?lU71GD1K2j+83gdYM/eWl4CcMFrHaqD3jM4z60FqpOuGX9cN/Fn2uY6SlNBj?=
 =?us-ascii?Q?yOVNlWuDnuTAF0l+hj1xKpAP7FSwOyMRzG0fiM0dtkeo+ibk6fHMURv6PzhG?=
 =?us-ascii?Q?jSk5RCf1ozeSS0et7DW/SuPn6McDUwQBzEZshNJb2KLWEjOCoqCiNPI4vVTZ?=
 =?us-ascii?Q?/lUepEDPcoEf3zOptxHw1EZHppsBNR9BTIb3oiw4DUDS2+1iuwbwIqbCnoJ2?=
 =?us-ascii?Q?Dt9RBakEboe/Ol6zVjp6HwOT4ds9pTGEt8qI1suJNFqGXIecuYftsUaOY2OO?=
 =?us-ascii?Q?vP6C8z1WKAGwKuzSjszLgO8ucYu/iQx3eSDgL4rYvG/9EzbkQ55vge6326oG?=
 =?us-ascii?Q?eIecli5gxf3CvHSvwicwAMsW9Cci38jxrfHUWJl6u9AMj4eAkSwZPEwNJ7uT?=
 =?us-ascii?Q?n3RtpLAdoYp+OZEmr39WSjjYk3yqIdr/FcDovxEGDB5Z7d0iTKkMyWZ5dJTk?=
 =?us-ascii?Q?SF7XJM4dI8E25D2m4ZmrrG2z7DTlE9u/PDqKrbWCiGgkFbje7io6BwavbJfM?=
 =?us-ascii?Q?5yk1hyrIteppBxMkPHSj8hzTu4XucaP/PfwaKea7gWsd+e3XHQhAbrhljOdR?=
 =?us-ascii?Q?V9bBzdR4CeESMZWf2jtjBf5N+ph0/kNf84tNSslL7vNKQxqHiv/+YN7Oo6o3?=
 =?us-ascii?Q?clhCYvJVgIZj4ttcSwnEp1bdUMTmCrxtdUFVokOHQoMYclkpgyVGHl9Kp1Dl?=
 =?us-ascii?Q?XFFx21zuD5usd7YyGDHHeTksN4ARcxJ4UOaMTEeafELbi5tOVawT2I34LOGk?=
 =?us-ascii?Q?CFzEm1V+yP7cduIogB+nWEC9Wqy3722SiBNVhOEbGTaFPeForAC5y6fLVtM8?=
 =?us-ascii?Q?09tfUqi4z9IHtCCZO0KBXesg4KbMSjWH4sHN//WqhRvAuNDkRkNaOQB41P9p?=
 =?us-ascii?Q?o//9OuT6YO4Yn/k+1BW6iq8SQRBB3pmVNGrdIgyWmI4cV9akrB3bYNR/l+kp?=
 =?us-ascii?Q?io/5kfWi9Zf8Lsuv5VUsBPlARP1xlMRXTsl0klw9gzr/7MCkl1geAb0mX7AU?=
 =?us-ascii?Q?354XsBYpKbCaDE+RcHsBNdTe+2NZ13ZlDriLCiel6ShpCJaDvpPrM8Twzv+3?=
 =?us-ascii?Q?kOYNW1uq4DoF0joXCkqMDatT51JXMwtY/E2fU9ahG8QqrftTTn9wm5XWyJno?=
 =?us-ascii?Q?dMaMpDZMc2znnoqTrma4K9yLtIDrLsqE78k2rAxAODD/0sxylqZHbH4FD0rj?=
 =?us-ascii?Q?f41hjbl0IYH8m5iwuOZl8K3ygLdWxFsnqpdMZ/I2uZiJgmNYqJnFytacSmSZ?=
 =?us-ascii?Q?eUCyLzjQsJVDx6bNanfd0yOTFkI97aCHrsG4je7TQ4kgJdx+BPG2+7Y4yb0D?=
 =?us-ascii?Q?si2x9XGPdKbfM8f5ueoCQe+J3mYN7D8bL28uNXW2Cp9V/PCFgVihj4qVqGFz?=
 =?us-ascii?Q?GvcHqIe2EfI4oKDDQs+IbrrRzP9DGNr05ag35ij0s3mtY0Ft32sh+2jcij/6?=
 =?us-ascii?Q?1MD2hX9RxLwQ064ZI4GHibt4zFRM2YZGWrIL1fKPou54ldJ66QL/q96qpbEo?=
 =?us-ascii?Q?fv7920ae+57XklBWJqDHiPyLGDy7TJrWDf6r3K/uQYWajHsi67LbuJ+fkfNp?=
 =?us-ascii?Q?U8avO+9BQcSXRxihSzNw3Q7QZ2ND5Es7iVq1WVs+p0BAsr4kT8Q0YytmJZb3?=
 =?us-ascii?Q?Q0TZQIPgYA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c8049e-5061-400e-5e23-08de504b94d3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2026 13:24:28.4265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mgdxe1l4lTxZO875KRdlfo50B6BmLRBSudOqtu+46iIHh/IxJUoe3WVQTKZgljTwps8uYPkcIiN7yYlsdoy/Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6147
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:slab-use-after-free_in__blk_rq_map_sg" on:

commit: ee623c892aa59003fca173de0041abc2ccc2c72d ("block: use bvec iterator helper for bio_may_need_split()")
https://git.kernel.org/cgit/linux/kernel/git/axboe/linux.git for-7.0/block


in testcase: xfstests
version: xfstests-x86_64-df16c93a-1_20260105
with following parameters:

	disk: 4HDD
	fs: xfs
	test: generic-group-76



config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202601102120.cf5782cf-lkp@intel.com


[   94.845194][ T5251] BUG: KASAN: slab-use-after-free in __blk_rq_map_sg (include/linux/scatterlist.h:131 include/linux/scatterlist.h:162 block/blk-mq-dma.c:300)
[   94.852772][ T5251] Read of size 8 at addr ffff88816bc71180 by task fsx/5251
[   94.859809][ T5251]
[   94.861988][ T5251] CPU: 3 UID: 0 PID: 5251 Comm: fsx Tainted: G S        I         6.19.0-rc3-00010-gee623c892aa5 #1 PREEMPT(voluntary)
[   94.861994][ T5251] Tainted: [S]=CPU_OUT_OF_SPEC, [I]=FIRMWARE_WORKAROUND
[   94.861995][ T5251] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.1.1 10/07/2015
[   94.861997][ T5251] Call Trace:
[   94.861999][ T5251]  <TASK>
[   94.862000][ T5251]  dump_stack_lvl (lib/dump_stack.c:122)
[   94.862005][ T5251]  print_address_description+0x88/0x320
[   94.862009][ T5251]  ? __blk_rq_map_sg (include/linux/scatterlist.h:131 include/linux/scatterlist.h:162 block/blk-mq-dma.c:300)
[   94.862013][ T5251]  print_report (mm/kasan/report.c:483)
[   94.862016][ T5251]  ? __virt_addr_valid (include/linux/mmzone.h:2100 (discriminator 1) include/linux/mmzone.h:2182 (discriminator 1) arch/x86/mm/physaddr.c:54 (discriminator 1))
[   94.862019][ T5251]  ? __blk_rq_map_sg (include/linux/scatterlist.h:131 include/linux/scatterlist.h:162 block/blk-mq-dma.c:300)
[   94.862022][ T5251]  kasan_report (mm/kasan/report.c:597)
[   94.862025][ T5251]  ? __blk_rq_map_sg (include/linux/scatterlist.h:131 include/linux/scatterlist.h:162 block/blk-mq-dma.c:300)
[   94.862029][ T5251]  __blk_rq_map_sg (include/linux/scatterlist.h:131 include/linux/scatterlist.h:162 block/blk-mq-dma.c:300)
[   94.862032][ T5251]  ? __pfx___blk_rq_map_sg (block/blk-mq-dma.c:292)
[   94.862036][ T5251]  ? __asan_memset (mm/kasan/shadow.c:84 (discriminator 2))
[   94.862040][ T5251]  scsi_alloc_sgtables (include/linux/blk-mq.h:1117 drivers/scsi/scsi_lib.c:1154)
[   94.862043][ T5251]  ? __pfx_scsi_alloc_sgtables (drivers/scsi/scsi_lib.c:1122)
[   94.862046][ T5251]  ? __pfx_stack_trace_consume_entry (kernel/stacktrace.c:83)
[   94.862050][ T5251]  ? __pfx_stack_trace_consume_entry (kernel/stacktrace.c:83)
[   94.862054][ T5251] sd_setup_read_write_cmnd (drivers/scsi/sd.c:1366) sd_mod
[   94.862062][ T5251]  scsi_queue_rq (drivers/scsi/scsi_lib.c:1868)
[   94.862065][ T5251]  ? sbitmap_find_bit (arch/x86/include/asm/bitops.h:136 arch/x86/include/asm/bitops.h:142 include/asm-generic/bitops/instrumented-lock.h:58 lib/sbitmap.c:181 lib/sbitmap.c:200 lib/sbitmap.c:245)
[   94.862069][ T5251]  blk_mq_dispatch_rq_list (block/blk-mq.c:2139)
[   94.862072][ T5251]  ? __pfx_blk_mq_dispatch_rq_list (block/blk-mq.c:2108)
[   94.862075][ T5251]  ? __blk_mq_alloc_driver_tag (block/blk-mq.c:1874)
[   94.862078][ T5251]  __blk_mq_do_dispatch_sched (block/blk-mq-sched.c:168)
[   94.862081][ T5251]  ? __pfx___blk_mq_do_dispatch_sched (block/blk-mq-sched.c:86)
[   94.862083][ T5251]  ? elv_attempt_insert_merge (block/elevator.c:349 (discriminator 1))
[   94.862088][ T5251]  __blk_mq_sched_dispatch_requests (block/blk-mq-sched.c:183 block/blk-mq-sched.c:307)
[   94.862090][ T5251]  ? __pfx___blk_mq_sched_dispatch_requests (block/blk-mq-sched.c:269)
[   94.862093][ T5251]  blk_mq_sched_dispatch_requests (block/blk-mq-sched.c:329 (discriminator 1))
[   94.862096][ T5251]  blk_mq_run_hw_queue (block/blk-mq.c:2378)
[   94.862100][ T5251]  blk_mq_dispatch_list (block/blk-mq.c:2943)
[   94.862103][ T5251]  ? __pfx_blk_mq_dispatch_list (block/blk-mq.c:2902)
[   94.862106][ T5251]  blk_mq_flush_plug_list (include/linux/blk-mq.h:251 block/blk-mq.c:2988 block/blk-mq.c:2959)
[   94.862109][ T5251]  ? __pfx_submit_bio_noacct_nocheck (block/blk-core.c:731)
[   94.862112][ T5251]  ? __pfx_blk_mq_flush_plug_list (block/blk-mq.c:2960)
[   94.862115][ T5251]  __blk_flush_plug (include/linux/blk-mq.h:251 block/blk-core.c:1232)
[   94.862118][ T5251]  ? iomap_dio_bio_iter (fs/iomap/direct-io.c:516)
[   94.862122][ T5251]  ? __pfx___blk_flush_plug (block/blk-core.c:1222)
[   94.862124][ T5251]  ? __asan_memset (mm/kasan/shadow.c:84 (discriminator 2))
[   94.862128][ T5251]  ? iomap_iter (fs/iomap/iter.c:106)
[   94.862131][ T5251]  blk_finish_plug (block/blk-core.c:1253 (discriminator 1))
[   94.862134][ T5251]  __iomap_dio_rw (include/linux/uio.h:160 fs/iomap/direct-io.c:768)
[   94.862137][ T5251]  ? __pfx___xfs_trans_commit (fs/xfs/xfs_trans.c:826) xfs
[   94.862542][ T5251]  ? __pfx___iomap_dio_rw (fs/iomap/direct-io.c:627)
[   94.862547][ T5251]  ? xfs_vn_update_time (fs/xfs/xfs_iops.c:1226) xfs
[   94.862926][ T5251]  ? xfs_file_write_checks (fs/xfs/xfs_file.c:491) xfs
[   94.863321][ T5251]  iomap_dio_rw (fs/iomap/direct-io.c:847)
[   94.863324][ T5251] xfs_file_dio_write_unaligned (fs/xfs/xfs_file.c:879) xfs
[   94.863667][ T5251]  ? __pfx_xfs_file_dio_write_unaligned (fs/xfs/xfs_file.c:823) xfs
[   94.864153][ T5251]  ? kasan_save_track (mm/kasan/common.c:69 (discriminator 1) mm/kasan/common.c:78 (discriminator 1))
[   94.864169][ T5251]  ? __kasan_kmalloc (mm/kasan/common.c:397 mm/kasan/common.c:414)
[   94.864171][ T5251] xfs_file_write_iter (fs/xfs/xfs_file.c:905 fs/xfs/xfs_file.c:1122) xfs
[   94.864565][ T5251]  iter_file_splice_write (fs/splice.c:739)
[   94.864570][ T5251]  ? __pfx_iter_file_splice_write (fs/splice.c:665)
[   94.864573][ T5251]  ? copy_splice_read (fs/splice.c:322)
[   94.864576][ T5251]  ? __pfx_copy_splice_read (fs/splice.c:322)
[   94.864579][ T5251]  ? __kmalloc_noprof (include/linux/kasan.h:262 mm/slub.c:5657 mm/slub.c:5669)
[   94.864583][ T5251]  direct_splice_actor (fs/splice.c:1163)
[   94.864587][ T5251]  splice_direct_to_actor (fs/splice.c:1105 (discriminator 1))
[   94.864589][ T5251]  ? __pfx_direct_splice_actor (fs/splice.c:1156)
[   94.864592][ T5251]  ? up_write (include/linux/instrumented.h:96 include/linux/atomic/atomic-instrumented.h:3390 kernel/locking/rwsem.c:1385 kernel/locking/rwsem.c:1643)
[   94.864596][ T5251]  ? xfs_reflink_remap_prep (fs/xfs/xfs_reflink.c:1728) xfs
[   94.864982][ T5251]  ? __pfx_splice_direct_to_actor (fs/splice.c:1029)
[   94.864985][ T5251]  do_splice_direct (fs/splice.c:1205 fs/splice.c:1230)
[   94.864988][ T5251]  ? __pfx_do_splice_direct (fs/splice.c:1229)
[   94.864991][ T5251]  ? __pfx_direct_file_splice_eof (fs/splice.c:1175)
[   94.864994][ T5251]  ? rw_verify_area (fs/read_write.c:473)
[   94.864998][ T5251]  vfs_copy_file_range (fs/read_write.c:1632)
[   94.865001][ T5251]  ? vfs_write (fs/read_write.c:594 (discriminator 1) fs/read_write.c:686 (discriminator 1))
[   94.865003][ T5251]  ? __pfx_vfs_copy_file_range (fs/read_write.c:1555)
[   94.865005][ T5251]  ? __pfx___do_sys_newfstat (fs/stat.c:551)
[   94.865008][ T5251]  ? __pfx_vfs_write (fs/read_write.c:667)
[   94.865011][ T5251]  __do_sys_copy_file_range (fs/read_write.c:1681)
[   94.865013][ T5251]  ? __pfx___do_sys_copy_file_range (fs/read_write.c:1651)
[   94.865016][ T5251]  ? ksys_write (fs/read_write.c:738)
[   94.865018][ T5251]  ? __pfx_ksys_write (fs/read_write.c:728)
[   94.865020][ T5251]  ? __pfx_cp_new_stat (fs/stat.c:471)
[   94.865023][ T5251]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
[   94.865026][ T5251]  ? do_syscall_64 (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 include/linux/unwind_deferred.h:37 include/linux/irq-entry-common.h:296 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
[   94.865029][ T5251]  ? vfs_getattr_nosec (fs/stat.c:215)
[   94.865032][ T5251]  ? __do_sys_newfstat (fs/stat.c:551)
[   94.865034][ T5251]  ? __pfx___do_sys_newfstat (fs/stat.c:551)
[   94.865038][ T5251]  ? xfs_file_llseek (arch/x86/include/asm/bitops.h:202 (discriminator 1) arch/x86/include/asm/bitops.h:232 (discriminator 1) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 1) fs/xfs/xfs_mount.h:597 (discriminator 1) fs/xfs/xfs_file.c:1756 (discriminator 1)) xfs
[   94.865369][ T5251]  ? __x64_sys_lseek (fs/read_write.c:389 fs/read_write.c:402 fs/read_write.c:412 fs/read_write.c:410 fs/read_write.c:410)
[   94.865372][ T5251]  ? do_syscall_64 (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 include/linux/unwind_deferred.h:37 include/linux/irq-entry-common.h:296 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
[   94.865375][ T5251]  ? do_syscall_64 (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 include/linux/unwind_deferred.h:37 include/linux/irq-entry-common.h:296 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
[   94.865377][ T5251]  ? do_syscall_64 (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 include/linux/unwind_deferred.h:37 include/linux/irq-entry-common.h:296 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
[   94.865380][ T5251]  ? irqentry_exit (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 include/linux/unwind_deferred.h:37 include/linux/irq-entry-common.h:296 include/linux/irq-entry-common.h:341 kernel/entry/common.c:196)
[   94.865383][ T5251]  ? __irq_exit_rcu (kernel/softirq.c:688 (discriminator 1) kernel/softirq.c:729 (discriminator 1))
[   94.865386][ T5251]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:131)
[   94.865389][ T5251] RIP: 0033:0x7ffb11506779
[   94.865392][ T5251] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
All code
========
   0:	ff c3                	inc    %ebx
   2:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   9:	00 00 00 
   c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d 4f 86 0d 00 	mov    0xd864f(%rip),%rcx        # 0xd8689
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d 4f 86 0d 00 	mov    0xd864f(%rip),%rcx        # 0xd865f
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260110/202601102120.cf5782cf-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

