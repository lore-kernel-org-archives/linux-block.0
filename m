Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2591FC76196
	for <linux-block@archiver.kernel.org>; Fri, 31 Mar 2023 15:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjCaPbP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Mar 2023 11:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjCaPbP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Mar 2023 11:31:15 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF4E1BF54
        for <linux-block@vger.kernel.org>; Fri, 31 Mar 2023 08:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680276672; x=1711812672;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ye/j50bf7//X+64352yoHG7fzpN8AxSYlOt5j9k9DjU=;
  b=EBH7TPmU/F9QgkSyPWxHndDqXhc8k2v38XXN4g7JyhtMG/4zbJzKs1QF
   JFaqeSdcC9e4Ldcr9dtXoC7jaXdpeGzb/MCYWJMOx9m5xlwu+9Nzhuzpl
   tXMdqqvwH5/FNlmjSvkBOjx+XuKQl9u4hc4BZfV9xM105NvICgHaFjGD2
   yxSWDU+5Q26vKAlKK7lkvLSLObuZGtrKDx4Cg01ySlw0WS0V0aMjb43Kn
   7JCuYOvkdywno0xUOH+Gs35LHPcNsGqSYLqhJ+1OyWm6KjY04Y6eDr9aw
   OVXBxgi4tAekJcMOlVi4oeyxlNyC/mRk/ItkxmSnwB8+7B4PPddEZwq0c
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="341491055"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="341491055"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 08:29:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="715491084"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="715491084"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 31 Mar 2023 08:29:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 08:29:11 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 08:29:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 31 Mar 2023 08:29:11 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 31 Mar 2023 08:29:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxGPlHM5YDhZymt+YXwYvj5UtmL2fqy8oXdgtptg15cMr4fXdbwgt4aCIylkHEjjsaSzpN3Ydmxwbn70+Us3Ppv9MXUx6Jg3TYd1JTEBImenwYrbM5zjV6LccryIp/O77bHi4F2EfhPcCdhgYwtSdeBPS1zIFduv4mK7Zag//WA0Z3oG782CIBao5EaVpHM0f9+MxLlXX/cnM2RKvkajAWiCyPsXYtWUUlu3AydAm/yqqoCfPTu4HfzvPebTbR5x6ARO2aX1+77kA+BfXhQ1sQJpS54wePzoYE9HU55glH8wLwR3+PRvvW2kwdI2YEciWCX3CzDPJJh334E1jH6rmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAVBeOq2blD+J8oYVr+5NztgiyXniXS5HwQbMir7ynI=;
 b=dPmGuDUbj0k4UZBzRkOgwfWJaRzDRHZF1R1N81HAkyjliTiyS8tOByCHMi3EKOEQ925iJkikxwi3CbMzu73KV9bGuIwQq3R6Xo/WP4kFENVUa4ZNWfc9XAfzjQetwJz8L2mhgWEiP0gYNI2IiXD+1M+oGox0kT5eStlC1JCR64cPtHzoupaZw4/5OV5Iytnkjme7Y3XDiCezoa71jppSm80bPb238AA9GWetPPXXnA32pFQrm2EVqhMrgeRI0BUj/i3oE3DoSmZfv1W460YxVZFx8u+ipwsWGzQYBXXN/yYLd8ZsjH000JRPwHsGqxDYLLv4wlUgMF410IWUaPJBXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by CH3PR11MB7299.namprd11.prod.outlook.com (2603:10b6:610:14b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 15:29:06 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::5ac7:aae0:92aa:74f0]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::5ac7:aae0:92aa:74f0%8]) with mapi id 15.20.6254.022; Fri, 31 Mar 2023
 15:29:06 +0000
Date:   Fri, 31 Mar 2023 23:26:29 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Alyssa Ross <hi@alyssa.is>
CC:     kernel test robot <lkp@intel.com>, <chaitanyak@nvidia.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        <oe-kbuild-all@lists.linux.dev>, <axboe@kernel.dk>, <hch@lst.de>,
        <linux-block@vger.kernel.org>
Subject: Re: LKP kernel test robot and blktests patches
Message-ID: <ZCb7pRxflkMHPLEz@yujie-X299>
References: <20230330160247.16030-1-hi@alyssa.is>
 <202303310316.QS2vADHM-lkp@intel.com>
 <20230330195053.hpb4upyezb7uy2dw@x220>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230330195053.hpb4upyezb7uy2dw@x220>
X-ClientProxiedBy: SG2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::9)
 To CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|CH3PR11MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: 6064ca06-2e17-4de1-433f-08db31fcaa23
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CL/f9WpgXGIivY9sFAwPYzBXxEWUjas2ieaS+iYO4AMo8atxWMtRHzt0DTkM5x0BtkxkTMXIPef+uXYypoSMCLHBjBsWzWcWnSZUfd6kmpKTUr7/B/4ugp6hJyvmjz4UeK9SiDijIjzlTvdMEpjh2X0KH38eAA/2s8yKOV8+I12rAkJiSx2owVZWMRgzME1sawTv6eHogImtSe4GDgnxpQnfKMZvZvBVAtSPoZf3zC7HD/IYKZT090AdXI1Or2GsGtvagQCR0WWos6ie28Ocp8crYPkmDxlGi88qRodJ+0Wo2ToFsIQTGkDd+w7MdGfqeWXJG8bYssiqNFQe/NtjoQaRBnQQWgKnSl2XZj+L1qI2BQ0EGLS5HW9kvXVa+kYOVO8d3n2KQ573Jz65+ieNTOJDThGUpEIf9lO3s4gTLcto49a3re/URt5+fE+POdl/ySocqI1zY8HSceameJZ1MrqBiBZOITx2p9WMPALwh32y8K+9UPdxmdGFiScD060xDenmXqTyt0OJ1oh5s8KcctqKf7OxRt4jDVEdMe1QVz9YgAn5SvboxBgvIt9Hg6AbP66iR6livSMF8WA+r4j76g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199021)(33716001)(186003)(6666004)(9686003)(6512007)(26005)(83380400001)(66476007)(478600001)(54906003)(316002)(41300700001)(66946007)(38100700002)(966005)(4326008)(8676002)(6916009)(82960400001)(2906002)(6486002)(86362001)(5660300002)(6506007)(8936002)(66556008)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f08UoBqfaFfgxUPfYwkLyRbX1tAr2wZ7TQBxi0cBqmi6ERqTFlBdZiOdlhLT?=
 =?us-ascii?Q?VL5mSrMmz27lLQ0iqY8Pf4vSiXS8xPr44KRqe0ieBdCs6JwELCxWLsG04U09?=
 =?us-ascii?Q?afXz3BzG8fbRgo60aB4eThCbSQfR7FFBKypeb31CMvr3NcpEF4w9TXRXSkIM?=
 =?us-ascii?Q?Jw6Big86kyP8SeYk253FzCaHGqsHIoh9Ab/YDYT73b0QIxBcigrBhVAUVDLo?=
 =?us-ascii?Q?1HC9b7ZO3hD1RFlv2uOEqu5kXMak16Mr6el0Fu2uYS/+NARWMURaMDE+Xg4S?=
 =?us-ascii?Q?JjoujqXK1DW1ItgeL/txNIe7tWYS3MwdMlJYS63a+VVqO8T0r8So4A11YPWD?=
 =?us-ascii?Q?jwc4iS08+nCFnSOQhY6ngE6jQbGy8BRFcmmaz+LR10Ft5csbmdDL+9gxDuf7?=
 =?us-ascii?Q?5lrtg/0yrgAsyxfd/ot/4QYnOTsDJeamZLHWucj+XQwWk0TPZ0PpMaW+xVd4?=
 =?us-ascii?Q?026teGF3mlcYbz9c0YUW3Cb0pnFnJASXPoMaQLi7t/3hizqgZtAD1ACbuyHl?=
 =?us-ascii?Q?Y3rlimlZf7/JW/HeIJoauR5bpL+eLJCep6v/gkst+okKvSGBGSMzVNiAL2eN?=
 =?us-ascii?Q?Wct+guh3UXXFNH5XQ09dZhkboXxgXXCkZwTOpZ3NXpQ1iP/gnq+cBBktKBzv?=
 =?us-ascii?Q?n85vaNTqbC90aYJnmZpphiiUGMKpJeNcEQAwt29pRUWdjs/JmwwD4EjVZ+Wp?=
 =?us-ascii?Q?iA8b1TC52Aalm54KANXCOLYuErbrFAlr4yO1KcF4cNXcRzDz4sl5faveYguQ?=
 =?us-ascii?Q?0VSGxUDR2auaH5cyswb0fSW9j4l6a2hYpMI1rgDXQZZxYN2hsGstOqtUUlYE?=
 =?us-ascii?Q?wR8c9gAv6dIqsmU2Le0WF5KftCe+UPrfItKWPlYyjauAGMyK/RtXG+3eRZnk?=
 =?us-ascii?Q?BQzna7X5zLhoBRmbqXRVL9ez5fa2ca54XCKtcB+TBZHXaWsTI8eWRw+COFl/?=
 =?us-ascii?Q?Tw9WigEu7SQDvp2TkbdpL8cl5+Q0bIK/Y08tqPMAIB1I1VXnYx4ecMN/1DRc?=
 =?us-ascii?Q?k3kI/nJL7H58E0FziRH467KoqO0GBvhHWMAz09SmMTg+5DhM+INc82sr9jF2?=
 =?us-ascii?Q?RVXz/oumIeQECD/B7PQWMtiW3w24MhN6Eyl/EWr0zRddhBnPkXNY8vZjfJ2r?=
 =?us-ascii?Q?pjdfdOyJ58cD3tfxKljtg6eG4z0VZVx+8WOlOuJR+AEkvQqeyjPDOQH6tYoG?=
 =?us-ascii?Q?9VgtQqzSWDN07fCvxHldnvsjoZQ97H/MdCtmCmR6mYZU7M66r/IJq5YiMv6y?=
 =?us-ascii?Q?Wlxpr1Z35yJETh18D5mpj6KHau/FPrOI2+74HfwjBeqwfO51zudg6npqkNWi?=
 =?us-ascii?Q?q9u29HBZ8j5Prv8Wo82A0xBiqan6MdZU8k3wP6KViJ2No8rs5Z5GBByFuqhJ?=
 =?us-ascii?Q?w8tyQZw1p031S2IYT3omzSkuD6fXhOuO7D/K/nkS2F3vHeyb0YsEmmDLiXpd?=
 =?us-ascii?Q?1fvaFox3VBda0uE2DqTS4mgJj3WlmS/tcDu6vBzszxQ02Ldt/4UTG5ZWcrG2?=
 =?us-ascii?Q?XvZyeZf8cQdcJOysIWsFdUrrGJrI8rhmOXcntoj3Mu4tzAvEgafx5boowdw4?=
 =?us-ascii?Q?QLf8YFXC+lHtVJx5s/8Am/wg5PK7flhJq3NbCs+L?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6064ca06-2e17-4de1-433f-08db31fcaa23
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 15:29:06.0755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8QoSlfwapR3rknI+2anzyZaQht2x/vRxttnHbpIsFmuo9E+WbhVkCR1f8I0OsfeutiVudHKiLkF+0vPU1Bcpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7299
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Alyssa,

On Thu, Mar 30, 2023 at 07:50:53PM +0000, Alyssa Ross wrote:
> Hi LKP team,
> 
> blktests's CONTRIBUTING.md says that blktests patches should be
> sent either on GitHub, or to linux-block with the "PATCH blktests"
> subject prefix.  I just sent such a patch, and because it was just
> adding a file, the kernel test robot happily applied and tested it as if
> it was a kernel patch, which naturally resulted in it finding problems.
> 
> Maybe the kernel test robot should skip patches starting with
> "[PATCH blktests]"?

Sorry for wrongly applying this as a kernel patch. We've configured the
robot to skip blktests patches.

--
Best Regards,
Yujie

> n Fri, Mar 31, 2023 at 03:22:28AM +0800, kernel test robot wrote:
> > Hi Alyssa,
> >
> > Thank you for the patch! Perhaps something to improve:
> >
> > [auto build test WARNING on linus/master]
> > [also build test WARNING on v6.3-rc4 next-20230330]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Alyssa-Ross/loop-009-add-test-for-loop-partition-uvents/20230331-001157
> > patch link:    https://lore.kernel.org/r/20230330160247.16030-1-hi%40alyssa.is
> > patch subject: [PATCH blktests] loop/009: add test for loop partition uvents
> > reproduce:
> >         scripts/spdxcheck.py
> >
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Link: https://lore.kernel.org/oe-kbuild-all/202303310316.QS2vADHM-lkp@intel.com/
> >
> > spdxcheck warnings: (new ones prefixed by >>)
> > >> tests/loop/009: 2:27 Invalid License ID: GPL-3.0+
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests


