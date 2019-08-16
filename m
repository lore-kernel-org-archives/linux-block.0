Return-Path: <SRS0=fyvH=WM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7A2C3A59C
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 17:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6B72086C
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 17:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfHPRYK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:24:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:15218 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfHPRYK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Aug 2019 13:24:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 10:24:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,394,1559545200"; 
   d="scan'208";a="168107160"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga007.jf.intel.com with ESMTP; 16 Aug 2019 10:24:09 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 839F43019B6; Fri, 16 Aug 2019 10:24:09 -0700 (PDT)
Date:   Fri, 16 Aug 2019 10:24:09 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
Subject: Re: [REGRESSION] commit c2b3c170db610 causes blktests block/002
 failure
Message-ID: <20190816172409.GA3216@tassilo.jf.intel.com>
References: <20190609181423.GA24173@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190609181423.GA24173@mit.edu>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> The git bisect log (see attached) pointed at this commit:

bisect must be wrong. The commit only changes the perf tool, so cannot
break anything in the kernel.

-Andi

> 
> commit c2b3c170db610896e4e633cba2135045333811c2 (HEAD, refs/bisect/bad)
> Author: Andi Kleen <ak@linux.intel.com>
> Date:   Tue Mar 26 15:18:20 2019 -0700
> 
>     perf stat: Revert checks for duration_time
>     
>     This reverts e864c5ca145e ("perf stat: Hide internal duration_time
>     counter") but doing it manually since the code has now moved to a
>     different file.
>     
>     The next patch will properly implement duration_time as a full event, so
>     no need to hide it anymore.
>     
>     Signed-off-by: Andi Kleen <ak@linux.intel.com>
>     Acked-by: Jiri Olsa <jolsa@kernel.org>
>     Link: http://lkml.kernel.org/r/20190326221823.11518-2-andi@firstfloor.org
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Is this a known issue?
