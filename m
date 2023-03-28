Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD5BC77B60
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 18:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjC1StM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 14:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjC1StM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 14:49:12 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6098F212C
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 11:49:10 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eh3so53594020edb.11
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 11:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680029349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MHTXhpf5WdLfr15cViMQdFbTg30x0rT0B0hTFtHLctQ=;
        b=A+bhfvmqTQqrdmC67+EygQyWGShN3KOSkBIckR39BPvNI8GfURZ1gozY1+nQ8g2e0m
         jwALDtiRqqvy7Dl6sjQAE+x4uZOoeCwvcdvpQMAFmHxFO9KQeg/CqH4tpOYfL1gF7py3
         B+n9C6BMcKyPaz7fjY1oMPBMIPiwkgZJD2o1gtyoR0aVn76NuZ3ODcG/dQlbntZyKyq6
         Xp7hkl1M8VCln1cL+sIq11V/s6ekKJ+lkdBoRdQoAwlxN14hlHAny4tZFSms6XFgMKTS
         V06rgFWRb/PQ2lg3EQ2mbe6dpaAnFDwTh6qWLNe59V5mvbJ8uoQwqImOyZBKI4BAmbGJ
         bMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680029349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHTXhpf5WdLfr15cViMQdFbTg30x0rT0B0hTFtHLctQ=;
        b=1+i4S02qquLtBcrhUY7T42gkemxr/T6mwwuQTC9PU+PeML6DE5swiXilV6OUYBq7LW
         BIqnLAun9iHDTxH1N4XhLBBI5EC1t3h9fMPiLVS+Pg7H/kuaHoKploak9gxWI6cRUwa3
         ZqWjAXbpPVaC8aIcmyRwd2iwMbnaOMpMihm+zx1hfbSoJ7lGTLa+xooORa+Qvwv02efM
         fgA+ZwkD/ezFMUBJVoptT0hpCnEjNJbrhyQvx4G6WTHFoh+Pwr53+M+X/gG8N5c/mxpL
         dMZIbxzpIqSQ+H41NGI3E9n3smBLsRhRgzYI14L2lPjmb00HgBD5P5+KJSzxUaqG7MWq
         u/rg==
X-Gm-Message-State: AAQBX9d1zOivVM3peC/DIykYQUwacHqmlGZjJd27ZeecesiBuznhnq0Y
        8cTOLEd+o0QO1aSV6nL1xswDtA==
X-Google-Smtp-Source: AKy350adtGZ/7F/zVdHFitatxgIwu2Smy8+dPv9uzMEAZupE75jqmmpPy4o+6UrU3JW/cx73A3BepQ==
X-Received: by 2002:a17:906:9bdb:b0:93c:81b9:a2b1 with SMTP id de27-20020a1709069bdb00b0093c81b9a2b1mr17059102ejc.62.1680029348943;
        Tue, 28 Mar 2023 11:49:08 -0700 (PDT)
Received: from localhost ([2a02:8070:6387:ab20:5139:4abd:1194:8f0e])
        by smtp.gmail.com with ESMTPSA id a21-20020a170906191500b009339e2e36e4sm12932534eje.81.2023.03.28.11.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 11:49:08 -0700 (PDT)
Date:   Tue, 28 Mar 2023 14:49:07 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v1 8/9] vmscan: memcg: sleep when flushing stats during
 reclaim
Message-ID: <ZCM2o8zgNhtgdhij@cmpxchg.org>
References: <20230328061638.203420-1-yosryahmed@google.com>
 <20230328061638.203420-9-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328061638.203420-9-yosryahmed@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 28, 2023 at 06:16:37AM +0000, Yosry Ahmed wrote:
> Memory reclaim is a sleepable context. Allow sleeping when flushing
> memcg stats to avoid unnecessarily performing a lot of work without
> sleeping. This can slow down reclaim code if flushing stats is taking
> too long, but there is already multiple cond_resched()'s in reclaim
> code.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Forget what I said about this in the previous patch. :)

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
