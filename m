Return-Path: <SRS0=DC0a=XA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFBBC43331
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 16:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0723B2082E
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 16:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733232AbfIEQwf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Sep 2019 12:52:35 -0400
Received: from foss.arm.com ([217.140.110.172]:47510 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728254AbfIEQwf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Sep 2019 12:52:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D10D28;
        Thu,  5 Sep 2019 09:52:34 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4354C3F718;
        Thu,  5 Sep 2019 09:52:33 -0700 (PDT)
Subject: Re: sched: make struct task_struct::state 32-bit
To:     Markus Elfring <Markus.Elfring@web.de>,
        Alexey Dobriyan <adobriyan@gmail.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>
References: <a43fe392-bd6a-71f5-8611-c6b764ba56c3@arm.com>
 <7e3e784c-e8e6-f9ba-490f-ec3bf956d96b@web.de>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <0c4dcb91-4830-0013-b8c6-64b9e1ce47d4@arm.com>
Date:   Thu, 5 Sep 2019 17:52:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7e3e784c-e8e6-f9ba-490f-ec3bf956d96b@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 05/09/2019 16:51, Markus Elfring wrote:
> Can a transformation approach like the following work also
> for your software?
> 
> @replacement@
> 
> identifier func, p, state_var;
> 
> @@
> 
>  func(...,
>       struct task_struct *p,
>       ...
> ,
> -     long
> +     int
>       state_var
> ,
>       ...)
> 
>  {
> 
>  ...
> 
>  }
> 
> 

I actually got rid of the task_struct* parameter and now just match
against task_struct.p accesses in the function body, which has the
added bonus of not caring about the order of the parameters.

Still not there yet but making progress in the background, hope it's
passable entertainment to see me struggle my way there :)

> 
> Regards,
> Markus
> 
