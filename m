Return-Path: <SRS0=JlK2=XS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0223C04EBF
	for <linux-block@archiver.kernel.org>; Mon, 23 Sep 2019 13:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B7A20673
	for <linux-block@archiver.kernel.org>; Mon, 23 Sep 2019 13:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406982AbfIWNX5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Sep 2019 09:23:57 -0400
Received: from foss.arm.com ([217.140.110.172]:42066 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405137AbfIWNX5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Sep 2019 09:23:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07AF61000;
        Mon, 23 Sep 2019 06:23:57 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A54F53F694;
        Mon, 23 Sep 2019 06:23:55 -0700 (PDT)
Subject: Re: sched: make struct task_struct::state 32-bit
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        Alexey Dobriyan <adobriyan@gmail.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>
References: <a43fe392-bd6a-71f5-8611-c6b764ba56c3@arm.com>
 <7e3e784c-e8e6-f9ba-490f-ec3bf956d96b@web.de>
 <0c4dcb91-4830-0013-b8c6-64b9e1ce47d4@arm.com>
 <32d65b15-1855-e7eb-e9c4-81560fab62ea@arm.com>
 <alpine.DEB.2.21.1909231228200.2272@hadrien>
 <d529c390-546e-a8a4-f475-c3ee41f97645@arm.com>
 <alpine.DEB.2.21.1909231340090.2227@hadrien>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <84a9fa83-8048-44c8-3191-07aa63337cfb@arm.com>
Date:   Mon, 23 Sep 2019 14:23:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909231340090.2227@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 23/09/2019 12:43, Julia Lawall wrote:
>>>> // FIXME: match functions that do something with state_var underneath?
>>>> // How to do recursive rules?
>>>
>>> You want to look at the definitions of called functions?  Coccinelle
>>> doesn't really support that, but there are hackish ways to add that.  How
>>> many function calls would you expect have to be unrolled?
>>>
>>
>> I wouldn't expect more than a handful (~5). I suppose this has to do with
>> injecting some Python/Ocaml code? I have some examples bookmarked but
>> haven't gotten to stare at them long enough.
> 
> You can look at iteration.cocci, but it's a bit complex.
> 
> You could match definitions of functions that do what you are interested
> in, then store the names of these functions in a list (python/ocaml), and
> then look for calls to those functions.  Something like
> 
> identifier fn : script:ocaml() { in_my_list fn };
> 

That seems promising, will try to have a look when I get some spare cycles.
Thanks for the pointers!
