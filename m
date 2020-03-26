Return-Path: <SRS0=7tOu=5L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0DAC43331
	for <linux-block@archiver.kernel.org>; Thu, 26 Mar 2020 14:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8AB20787
	for <linux-block@archiver.kernel.org>; Thu, 26 Mar 2020 14:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="qoWgKMmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgCZObG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:31:06 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37185 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbgCZObG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Mar 2020 10:31:06 -0400
Received: by mail-qk1-f195.google.com with SMTP id x3so6592191qki.4
        for <linux-block@vger.kernel.org>; Thu, 26 Mar 2020 07:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OG09KzA4HuO3BOZQKOUcZGEc5bHon2VHvRmMFTk+/XA=;
        b=qoWgKMmxmpHam08hoCe/t+7K2pObYsUEj4WceDC2aYtZWU8vi2g/tN8slLtc3BxjBQ
         pGuuz/h4e4WdyEA4STkS2V20DKT0odYewLHs/KD6Swj+Hjz0EopvGoPjguT9OiHImxgz
         JSNQ4UfzFQLnDG8g0kaJ5JiI+DQgHfZDhV/C+QIVkyHBN6j/fCiN8tQFb1Gn0RXjPl/s
         p1XAl2850NR2WnH+fot1vcN8DkLnIB+aYxYnPX3B9cFQ4/gwFx4nH2GYGeguWFdMTR17
         yhUPE6GdTz0DDJly8bhRXzbabDbpiPZ9fctxKFzaD0nWYgvZ8wshtAgHBcC/gFOmLc3k
         wXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OG09KzA4HuO3BOZQKOUcZGEc5bHon2VHvRmMFTk+/XA=;
        b=m23IkhaVxxbMKWVac2AOz8qae3MOcXM7UsRT7BF7bkeJJrGGQMjgkGifA+9HBTaoT4
         NyoIGMUvhw6kOLfCseI58v1pZ+e/WYhFl0n/M6Kr3NVGWcs/0sXOR4wFJO1recnxAy1d
         Nb5kX2SVp2DbcUy34+07kEVcyh6s6Z/kZAYnL5nd+2bSDyNPUqzY3C8Lx3rxWcTPEf5m
         2EANXesPwHEzjpH+GyPuOkZF78Dr/6WDhTUKW0h8Kkcbgz9oT7hAf4yZfw2C7eZqPljz
         t85n+g3o/2n198UVq9ICEAp+a0WmMN2ExORW8SXvM5/8JGWu4g+DZViXlKeo4TD2671t
         c+Lg==
X-Gm-Message-State: ANhLgQ2az/tb2uzAfW44xNj8AkVaRaU0JrmN+5IlhXcrA8dy55yjMQVY
        wRwj4tWoj17NqkeVZMcEeXsXsQOwloM=
X-Google-Smtp-Source: ADFU+vvGmFJhahNS012z36bU++nM6aRvUkvuLENBAKAt9FwVnPCjAaq50NPPkVV/ZfywFdTOJpV6LA==
X-Received: by 2002:a05:620a:529:: with SMTP id h9mr8463342qkh.142.1585233065063;
        Thu, 26 Mar 2020 07:31:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a9a9])
        by smtp.gmail.com with ESMTPSA id l60sm1700051qtd.35.2020.03.26.07.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 07:31:04 -0700 (PDT)
Date:   Thu, 26 Mar 2020 10:31:02 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     peterz@infradead.org, akpm@linux-foundation.org, mhocko@kernel.org,
        axboe@kernel.dk, mgorman@suse.de, rostedt@goodmis.org,
        mingo@redhat.com, linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] psi: enhance psi with the help of ebpf
Message-ID: <20200326143102.GB342070@cmpxchg.org>
References: <1585221127-11458-1-git-send-email-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585221127-11458-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 26, 2020 at 07:12:05AM -0400, Yafang Shao wrote:
> PSI gives us a powerful way to anaylze memory pressure issue, but we can
> make it more powerful with the help of tracepoint, kprobe, ebpf and etc.
> Especially with ebpf we can flexiblely get more details of the memory
> pressure.
> 
> In orderc to achieve this goal, a new parameter is added into
> psi_memstall_{enter, leave}, which indicates the specific type of a
> memstall. There're totally ten memstalls by now,
>         MEMSTALL_KSWAPD
>         MEMSTALL_RECLAIM_DIRECT
>         MEMSTALL_RECLAIM_MEMCG
>         MEMSTALL_RECLAIM_HIGH
>         MEMSTALL_KCOMPACTD
>         MEMSTALL_COMPACT
>         MEMSTALL_WORKINGSET_REFAULT
>         MEMSTALL_WORKINGSET_THRASHING
>         MEMSTALL_MEMDELAY
>         MEMSTALL_SWAPIO

What does this provide over the events tracked in /proc/vmstats?

Can you elaborate a bit how you are using this information? It's not
quite clear to me from the example in patch #2.

