Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394CBC433EF
	for <linux-block@archiver.kernel.org>; Wed,  9 Mar 2022 03:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiCIDC6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 22:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiCIDC5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 22:02:57 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7347238BFA
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 19:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646794919; x=1678330919;
  h=message-id:date:subject:references:in-reply-to:to:cc:
   from:content-transfer-encoding:mime-version;
  bh=6aEqL91/AtSvkrkAZYCYinykxb3vMI93VpoBceqKlTU=;
  b=hoKR/R4DktP6rkljTT60T/uYyz1R0Q9dJZiRLflLxB06AVkC4CwJIzed
   bwqAP4EfLVF3v1/gLNUAJDJ54IjL2tgtXmgboaxxciaMs73k1fEF69WVz
   eEpfTdolVk+R7uA3VMbkNgpysA3YjMTcIS3Hd5lBPRCa+GQudJXdBvzK4
   aooWxykt6FKIEIUsg2Ldy28IA3p43YIf5AiSzb4MK53nYwWlLz65O50F7
   6UY2nOxSmPvkN4cmxXwveAbQ1xrhfG5GQazC+59gRZMWuuHxGYQUdRMc+
   G/kPYsFifaJ6AlR4TQ1mmE/+UQgYHdo6Iun5iD4DtMnGhOnImcu4OwEIS
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="279595107"
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="279595107"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 19:01:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="643881196"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 08 Mar 2022 19:01:58 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 19:01:58 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 19:01:57 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Tue, 8 Mar 2022 19:01:57 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Tue, 8 Mar 2022 19:01:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgCuD03Mr7q9izGVkCLlPhz2e69AWADgIprDtXsYy6uO/q61jAqqQtNf8JVHnqm4x2b6vK0ZYTvZG6fjEv3PgXXzw+fT48GUWzvA0h/emfHOfK2hh+HH4HGwbQ7efmO1qvcjRyoeFXicy4y5e/eLuSuqP/cZioN+Bo51IGH2VZUCxHyn6qr2/NUHSIc02fWZ0YE9zNNGttTdQIHByhEK+HDYtlSMwwInI+kOQbX6Ay23UJBZnUykbLmv6lw1RHsAfAhvMhMHZDcRtkuSQ4ngn2GPtCBhUoaRHt5bTA9yHZQ/+/O0c1JCXOUlkJDXtrJOqHgZ0z0qneKTRZEL9Ra+PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkGSXne9wZsg4asdRklJEolTRo3oerMQgGTGbHFYe5g=;
 b=gVMDTFoYa/7vJzbqrrW2C+UnulSyLOXEQhObFZ5CwCi7siCIBbJt+o9KOBWWB2sbzAazmjbIy9bx1W67YP2oygwYoMmBGb7m9vEEzRhn06dHbcFBrAGXuhZaKja+nHtm5rpzbkOxUq/8hWFCz237YRTHfNaVHsDYFpYZvWeXjyjpMTAlAoHGf8EO1F9vuKSlI7rAOhwi23ChGga9At4g8qJWk1zy75nIlKa0daoF10YlrW6yn96Pz2EcIIW5clErMPzf6im8wzXSEf9zyjR89/IN3eDLTp4GZE5jtNFhonD3tseiyNpgbvR9G580ZO4Un1Klipo/HiYaKFLjDo32Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Wed, 9 Mar 2022 03:01:54 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d%9]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 03:01:54 +0000
Message-ID: <8aa94cd6-365b-6ffc-ebc5-3a938ad3ae9b@intel.com>
Date:   Wed, 9 Mar 2022 11:01:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.2
Subject: Re: [PATCH V2 5/6] blk-mq: prepare for implementing hctx table via
 xarray
References: <202203032010.V1VcXGQT-lkp@intel.com>
Content-Language: en-US
In-Reply-To: <202203032010.V1VcXGQT-lkp@intel.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <kbuild-all@lists.01.org>, <linux-block@vger.kernel.org>,
        Yu Kuai <yukuai3@huawei.com>, Ming Lei <ming.lei@redhat.com>
From:   kernel test robot <yujie.liu@intel.com>
X-Forwarded-Message-Id: <202203032010.V1VcXGQT-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR0401CA0009.apcprd04.prod.outlook.com
 (2603:1096:202:2::19) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9f76db1-e941-4305-423e-08da01792a1c
X-MS-TrafficTypeDiagnostic: DM4PR11MB6019:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM4PR11MB6019EBE0BE302F1D9F7261B0FB0A9@DM4PR11MB6019.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WN16oNJ7DBYtxar3I6Mhg6XSc8oauyYEuRtM5PO/qMdrC3TTO1Js5ePY9rJ+QuVW1fMDYV5h/KnMKVY4TuEv9sxx+4HC3aNrh0o6eI/USJWPLjqcKHPRoEHnp41HF58OI4zGTkvUPXYzZSukQ8uP4AfLwKjKzCdNNVv7cb2GbQBy2pkiF3jNtfqoBjdfLJixQ3QfpPCSmHZS8g7KdROCO5lRpkOT3aWT/i893Qrf9p+h/2BkBYZNUD6iFMfGKOjf0CLc/AaVorePSlAT2LRNZ2Y9bIl7ZQoIpo0zwDzRjS3XNlQ7zq+UoinuFIajHqbjjd0rsG1istOaaholKGQTeG5n16jfBkDminZKkMRthUCbhxWsDclAk4RHOuySSy8F26PzgaK7PZ4UuC53GxiCqhyTv9CNJkUpQA4i6ZZRWmXt8IudyvvLdAnT1w/rw+mjmeWwMRSBfS5OYFpPrcmu6uANqwJTKytBKy6+fgrufvOBWJ8L/i00FKYBelQoxnGbGgoBGdO5QW9SP0GXIdv4TUxf7Ej1A9fuBC4YA9yK/7zFoCy96H22Svo0/XNZ+jKyK/L+/T/FgHjUoLrjNPKKE8EkfYi6BncY92AWbGtAODgZ3lWn3pcFBA2dsfi9+Uw6bUIzVgRNJWmx2CzIyYuKX+8WvOf60mBlLfIHKnP3XRRFsUt/KltV+ga4VrTdysDAWQw3ijr8nu/FylmA1e4w5gCOWhPGk3Mf8A+JhB9rakfTTS50MgNK8lt4ECKyv/y+wLhQpYdDVpg93DXF05eeztfeYQLKSx1P/LMZlbqDjY9wpZnelIEqEV6MTrAjmW+JK9vw52nkEUmksT7wCLI0bQXahKuPPD3P8PWekzdvZM8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(508600001)(316002)(6506007)(6486002)(31696002)(966005)(6666004)(2616005)(36756003)(186003)(26005)(31686004)(83380400001)(6512007)(66556008)(4326008)(66476007)(66946007)(8676002)(38100700002)(82960400001)(2906002)(110136005)(8936002)(5660300002)(4001150100001)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkE4TVpkWFNWRlNwLys4enlHcWdiOG8xUnNXbU9SMlRucSsyZkdJaTlYWVA5?=
 =?utf-8?B?d0o5SzgyRnpLZnlKVVZHZW5pV1lCR0hrUFFYSUNSWUJJZVk1RFZaeDNvblNk?=
 =?utf-8?B?YWh1bzZaR1RCMW44ZjROVEVySzFCMlZPampnR0hGaUlZWng1NTlqWU5BaGlh?=
 =?utf-8?B?NWU2SVJucU5OSUkzVmZ4VkJKUHV6KzlaUFhBcktOQjBTL1BFS1J5S1d3Z2dF?=
 =?utf-8?B?d1Z3Q0N5OWVvb2Jwc0ZlZEFBUWNEc0FHR3E2cEV2Smw5Sjk1Q3RWL3drZ3No?=
 =?utf-8?B?NUd2cnZITWk1amh3SEM2ZjBhN3J5RGt4TEtyQXlFWXNuT2JCVUFjVnBsZDJC?=
 =?utf-8?B?RzBvNll2MFVxYXRPWGNmVTlaaWpzNFR3TkRkSXFQRG9teW5xMityOEw0NEpk?=
 =?utf-8?B?L3RYU2p2eGZudGU0NDhPNXNuamovY0hxQ3J3VVV5bWZaTFBvMzc5Y1R1SElZ?=
 =?utf-8?B?TmUweVNpOTFVVWdzUXFVWWdxQjhuRGozNGpsZ0dNeTRzcnBvSEFnbmVpcHZn?=
 =?utf-8?B?NThJbkM2bEIzVFp6ODlTQTZWNG53U3ZieEE1ckFGQ2tQaTUybmxwTGNZMjFN?=
 =?utf-8?B?MXBUMFhrZXErVHNFL0c3V0JGUlpCT09YSllQbTNsSzVrUVBlSDFHQ3hkSDNU?=
 =?utf-8?B?MkpPY3p1RGtKam8vWW1BZWljYnVGQnhwU2xRWVJUekpoQ0xNV0piaFRkQXl4?=
 =?utf-8?B?VUpDRmJUa2Z4OHlWVldOOHZFSzJUMU4rUVp4ZnZ4VDBMZzlrSVdQUUNNVG9C?=
 =?utf-8?B?UmMvT2lzVm9RNWVWbnRxY3BpT1g3dXVxZnR4aUtmbnNtWnJkaGFJMGFaYWZU?=
 =?utf-8?B?WURJeExOdlBKbzhrakQwUjExNHFBc3BsTnA2cUNNYVIweGkvcXFSMHoyWHg0?=
 =?utf-8?B?emgySmFadXExcDJacmhSR1ZmbjRNNTZQRGVSWFlPcTRmQVRNQ2xpeWxwZVht?=
 =?utf-8?B?Rno2Q0wyNWxMcWFVdVU5S1EwbjNsSXcrNDhCWkI2SXRIQmhpdVhRUmp1bUNj?=
 =?utf-8?B?TkdncUpFckJ0SlJieFFhM3hBRHhicFowRXIzT2FwN01VamlkQm1qcDJ1Wm1W?=
 =?utf-8?B?eFAzejBuMjczRVZLMmZRM0d5VFE0T0Qwb0g4VDJMc2swL1Zpd0xHdDVWTE9m?=
 =?utf-8?B?Y3I4dkJaLy9nMUk5Vk5SSWtiY3FvangzbDJ6RndwRkhicytKa2RpRmRRbVB5?=
 =?utf-8?B?dWtpdDVOSlplSCs2aE9hcmdicHNhZHM5ZXJKaDMxSzROSmlPYmRyRExiWlpF?=
 =?utf-8?B?UkhMWEZZSnl2SU8wbTdxZUlJak1uaHN2bklsdml0b1dybENUMlFCaVYvMldU?=
 =?utf-8?B?Y0JTdWZZS29zek5xM2R4VUthTzN0bkp4UDJtRHB1bmJmTlZXbEp1UXA0cDZm?=
 =?utf-8?B?QURjSXZoNVBqOFJpYStUY1BCbTduS1g1Z2JFTTV3UXVZOW12NFloWlZhc0pG?=
 =?utf-8?B?M2FuMHpmWmhmeXZiVVllYVRnTlJHOFd6RTZtbjkwZ2NIemk3WWN2ZWlJK2Rr?=
 =?utf-8?B?LzN3ZWR5dGNWZ3RDNUlHbHBadi9FL0VNMm1QVlcrMVR5ek5qOGVKTE9jdlRU?=
 =?utf-8?B?RUNIVzRyTXdRSmdFdjFHWkNXRjFMOXQ5eXpsY0djc0NyWjNNWG1DUlc1eGN5?=
 =?utf-8?B?L2MvR1pHcDlzams0L0V5ajRlaTN5S2Q1T1VjUEozblUwWHYzcWpUSGRjL2dR?=
 =?utf-8?B?Ry9lTjQ2VlEwQTMxbHYrTlhyUVQ3Rkt1Zm82ckczQVVwWEVmVWlQLzM4WXRv?=
 =?utf-8?B?Qkx0M0NsbnRzNm9ZTmdNNDNjMElHL1JZN3hOWXZ5WmF2Q0Y1M2pITU9oaFhz?=
 =?utf-8?B?dGdhVVBNcUVoTVFiSENObDVtZGhUKzdsWkEwL21JM3ZGa3NPNDJneXhZNVJw?=
 =?utf-8?B?U2lRRTF3Vmlia1JhQ01HVTBEbXp6NlFjb01CVnBDYkM5Nkg2ZFJOQmJsTHM3?=
 =?utf-8?B?VDBaaGxXdmQxano3YU9US0xnTTh1R0tjdmdSay85WE82ZFFpd0JrWk1qUkQ5?=
 =?utf-8?B?RWR6OEtuWWV5eXJQbWZETjM4VFluQ2tjWElGTnp4a0J1cXJhd1VyUXRxZmRZ?=
 =?utf-8?B?dWhZQWlqM2NlWWg4amFBOW1IYzBoOWZzM1VMWVpHdDVPYW5PSFAxdDRQa1Qv?=
 =?utf-8?B?aDJlZmRkcnRReDRvT1o3VWxzVFBTUTZRRXEyYVBwMDFnVGtFWTBibnVOblZy?=
 =?utf-8?Q?3vfO3zRiAQorUIFms24gXrE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f76db1-e941-4305-423e-08da01792a1c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 03:01:54.1448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HhgEVfufsToAZYitknTLKleVIthxIb9wQBOegu8Qy2hqvm9zO8BGs6iPWqQIJ+fPzOU1BQdsIl5w29Yv8+UkCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6019
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on v5.17-rc6 next-20220302]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Ming-Lei/blk-mq-update_nr_hw_queues-related-improvement-bugfix/20220302-201636
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
compiler: m68k-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <yujie.liu@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not be real problems)

 >> block/blk-mq-sysfs.c:282:13: warning: Unsigned variable '--' can't be negative so it is unnecessary to test it. [unsignedPositive]
     while (--i >= 0)
                ^

vim +282 block/blk-mq-sysfs.c

67aec14ce87fe25 Jens Axboe      2014-05-30  254
2d0364c8c1a97a1 Bart Van Assche 2017-04-26  255  int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
320ae51feed5c2f Jens Axboe      2013-10-24  256  {
320ae51feed5c2f Jens Axboe      2013-10-24  257  	struct blk_mq_hw_ctx *hctx;
44849be579332ce Ming Lei        2022-03-02 @258  	unsigned long i;
44849be579332ce Ming Lei        2022-03-02  259  	int ret;
320ae51feed5c2f Jens Axboe      2013-10-24  260
2d0364c8c1a97a1 Bart Van Assche 2017-04-26  261  	WARN_ON_ONCE(!q->kobj.parent);
cecf5d87ff20351 Ming Lei        2019-08-27  262  	lockdep_assert_held(&q->sysfs_dir_lock);
4593fdbe7a2f44d Akinobu Mita    2015-09-27  263
1db4909e76f64a8 Ming Lei        2018-11-20  264  	ret = kobject_add(q->mq_kobj, kobject_get(&dev->kobj), "%s", "mq");
320ae51feed5c2f Jens Axboe      2013-10-24  265  	if (ret < 0)
4593fdbe7a2f44d Akinobu Mita    2015-09-27  266  		goto out;
320ae51feed5c2f Jens Axboe      2013-10-24  267
1db4909e76f64a8 Ming Lei        2018-11-20  268  	kobject_uevent(q->mq_kobj, KOBJ_ADD);
320ae51feed5c2f Jens Axboe      2013-10-24  269
320ae51feed5c2f Jens Axboe      2013-10-24  270  	queue_for_each_hw_ctx(q, hctx, i) {
67aec14ce87fe25 Jens Axboe      2014-05-30  271  		ret = blk_mq_register_hctx(hctx);
320ae51feed5c2f Jens Axboe      2013-10-24  272  		if (ret)
f05d1ba7871a2c2 Bart Van Assche 2017-04-26  273  			goto unreg;
320ae51feed5c2f Jens Axboe      2013-10-24  274  	}
320ae51feed5c2f Jens Axboe      2013-10-24  275
4593fdbe7a2f44d Akinobu Mita    2015-09-27  276  	q->mq_sysfs_init_done = true;
2d0364c8c1a97a1 Bart Van Assche 2017-04-26  277
4593fdbe7a2f44d Akinobu Mita    2015-09-27  278  out:
2d0364c8c1a97a1 Bart Van Assche 2017-04-26  279  	return ret;
f05d1ba7871a2c2 Bart Van Assche 2017-04-26  280
f05d1ba7871a2c2 Bart Van Assche 2017-04-26  281  unreg:
f05d1ba7871a2c2 Bart Van Assche 2017-04-26 @282  	while (--i >= 0)
f05d1ba7871a2c2 Bart Van Assche 2017-04-26  283  		blk_mq_unregister_hctx(q->queue_hw_ctx[i]);
f05d1ba7871a2c2 Bart Van Assche 2017-04-26  284
1db4909e76f64a8 Ming Lei        2018-11-20  285  	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
1db4909e76f64a8 Ming Lei        2018-11-20  286  	kobject_del(q->mq_kobj);
f05d1ba7871a2c2 Bart Van Assche 2017-04-26  287  	kobject_put(&dev->kobj);
f05d1ba7871a2c2 Bart Van Assche 2017-04-26  288  	return ret;
2d0364c8c1a97a1 Bart Van Assche 2017-04-26  289  }
2d0364c8c1a97a1 Bart Van Assche 2017-04-26  290

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
