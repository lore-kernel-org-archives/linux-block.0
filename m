Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C107C004E6
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 20:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2742820665
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 20:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfF0UYF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 16:24:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:11026 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfF0UYF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 16:24:05 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 13:24:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,424,1557212400"; 
   d="scan'208";a="156355340"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga008.jf.intel.com with ESMTP; 27 Jun 2019 13:24:03 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 81DB6301618; Thu, 27 Jun 2019 13:24:03 -0700 (PDT)
Date:   Thu, 27 Jun 2019 13:24:03 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
Subject: Re: [REGRESSION] commit c2b3c170db610 causes blktests block/002
 failure
Message-ID: <20190627202403.GE31027@tassilo.jf.intel.com>
References: <20190609181423.GA24173@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190609181423.GA24173@mit.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> The git bisect log (see attached) pointed at this commit:
> 
> commit c2b3c170db610896e4e633cba2135045333811c2 (HEAD, refs/bisect/bad)
> Author: Andi Kleen <ak@linux.intel.com>
> Date:   Tue Mar 26 15:18:20 2019 -0700

>     perf stat: Revert checks for duration_time

You must have misbisected. The commit only changes the perf user tool,
not the kernel.

-Andi
