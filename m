Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A617C77B7E
	for <linux-block@archiver.kernel.org>; Sat, 29 Apr 2023 07:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjD2HLx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Apr 2023 03:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjD2HLx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Apr 2023 03:11:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6F62D47;
        Sat, 29 Apr 2023 00:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682752312; x=1714288312;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SFPEDZnozEBQlUD9/3iEWO9nIAGT61b+OuTn4t84e38=;
  b=ZF17TsT0zEhegJhaRjs1+6Gkp5Cc07ehayIO8nu+i62ZwBG60Ivbrt0l
   rn2pz50G9Y/EWyavTM7OxFWbBwAQvcDOBSlrBSRn8KB/CPVo30V5hNr+x
   xa+BhNZiKmdDoe/sGbJBe88SA0K5FxQki+AUNEoptVl3leaBFjislX2s6
   eux+BoyqFgefm5dTSYMQXcnzLIyE0tL4xgbgZXLgVnSjs6GJoHOmJSEN1
   xz6F7i1SpXwVFHpw1sRP5xGIytcwVGkGAOi8MQwA+WhxdiaoGqSbzhl22
   o7J2+Bvs5ePmZHqTKDTpNPYAj/EGUO1H3KYmWUCOeiY7iRprIT7edPXop
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="434212135"
X-IronPort-AV: E=Sophos;i="5.99,236,1677571200"; 
   d="scan'208";a="434212135"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2023 00:11:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="819296869"
X-IronPort-AV: E=Sophos;i="5.99,236,1677571200"; 
   d="scan'208";a="819296869"
Received: from linux.bj.intel.com ([10.238.156.127])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2023 00:11:49 -0700
Date:   Sat, 29 Apr 2023 15:10:12 +0800
From:   Tao Su <tao1.su@linux.intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        tj@kernel.org, josef@toxicpanda.com, yukuai1@huaweicloud.com
Subject: Re: [PATCH v2] block: Skip destroyed blkg when restart in
 blkg_destroy_all()
Message-ID: <ZEzC1BAX7e7t8Jaj@linux.bj.intel.com>
References: <20230428045149.1310073-1-tao1.su@linux.intel.com>
 <168270266088.259022.9566325777722187933.b4-ty@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168270266088.259022.9566325777722187933.b4-ty@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 28, 2023 at 11:24:20AM -0600, Jens Axboe wrote:
> 
> On Fri, 28 Apr 2023 12:51:49 +0800, Tao Su wrote:
> > Kernel hang in blkg_destroy_all() when total blkg greater than
> > BLKG_DESTROY_BATCH_SIZE, because of not removing destroyed blkg in
> > blkg_list. So the size of blkg_list is same after destroying a
> > batch of blkg, and the infinite 'restart' occurs.
> > 
> > Since blkg should stay on the queue list until blkg_free_workfn(),
> > skip destroyed blkg when restart a new round, which will solve this
> > kernel hang issue and satisfy the previous will to restart.
> > 
> > [...]
> 
> Applied, thanks!

Axboe, thanks!

Tao

> 
> [1/1] block: Skip destroyed blkg when restart in blkg_destroy_all()
>       commit: 8176080d59e6d4ff9fc97ae534063073b4f7a715
> 
> Best regards,
> -- 
> Jens Axboe
> 
> 
> 
