Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0F7C433ED
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 00:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16C89613AE
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 00:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhDTANP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 20:13:15 -0400
Received: from zimbra.cs.ucla.edu ([131.179.128.68]:37838 "EHLO
        zimbra.cs.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbhDTANP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 20:13:15 -0400
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Apr 2021 20:13:15 EDT
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id E01FB16005F;
        Mon, 19 Apr 2021 17:05:17 -0700 (PDT)
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id aQoZRtc58TO3; Mon, 19 Apr 2021 17:05:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id DB3E216013B;
        Mon, 19 Apr 2021 17:05:16 -0700 (PDT)
X-Virus-Scanned: amavisd-new at zimbra.cs.ucla.edu
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HegHXED5qJ3V; Mon, 19 Apr 2021 17:05:16 -0700 (PDT)
Received: from [192.168.1.9] (cpe-172-91-119-151.socal.res.rr.com [172.91.119.151])
        by zimbra.cs.ucla.edu (Postfix) with ESMTPSA id AB05D16005F;
        Mon, 19 Apr 2021 17:05:16 -0700 (PDT)
To:     Stefan Hajnoczi <stefanha@redhat.com>, libc-alpha@sourceware.org,
        "H . J . Lu" <hjl.tools@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20210413150319.764600-1-stefanha@redhat.com>
 <YH2VE2RdcH0ISvxH@stefanha-x1.localdomain>
From:   Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
Subject: Re: [PATCH liburing] examples/ucontext-cp.c: cope with variable
 SIGSTKSZ
Message-ID: <7ea0a289-204b-14a9-2488-af379e8d24c8@cs.ucla.edu>
Date:   Mon, 19 Apr 2021 17:05:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YH2VE2RdcH0ISvxH@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/19/21 7:34 AM, Stefan Hajnoczi via Libc-alpha wrote:
> The commit referenced above broke
> compilation of liburing's tests. It's possible that applications will
> hit similar issues.

Yes, other applications have already had similar issues, and we've fixed 
that by recoding them to not assume that SIGSTKSZ is an integer constant 
expression. See, for example, this patch to Gnulib last September:

https://git.savannah.gnu.org/cgit/gnulib.git/commit/?id=f9e2b20a12a230efa30f1d479563ae07d276a94b

This patch appears in the latest GNU grep, for example.
