Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E494C6FD18
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 17:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjC1RoH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 13:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjC1RoG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 13:44:06 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE8CD1
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 10:43:49 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id cn12so52985995edb.4
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 10:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680025420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9pG4ykKXTPasFcUZIf/e8S9vCCN31pN+vneMGpJbP4o=;
        b=56M5bOM/pNtngeUWBHnxJY71NBq4XowDWZ8RCfQNb/yCxXYYMrgyYMqobQXbL4C2JB
         RGGu/tdd2jHQlnibWvl6Yl2Z+V9C6/sqQqYlpBk4QH75MtYWG0vntrQt7EbpI3qbQira
         FHF9oSn85isHlRZq305s1ZjPBaMG8ngitCC5W0QK+URXlKcrqGLcbNcKDtVwKwQLiwbR
         WMQuohmUWWq5bvjuyfeOZWbD0dG18QNgGsHHriTK1OT4ETrZ393Glp5m0QCwsT84vxCX
         wa9EQLvH3eVpihWS8y/qQIMRwHoKRu5ba4FiqWeWAVMZkZoYdAYv+LAzhrhkCBMtOsOj
         R8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680025420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pG4ykKXTPasFcUZIf/e8S9vCCN31pN+vneMGpJbP4o=;
        b=1AN3NZ2WOP7Gh9d97p4ApzGaJOfKNDckOuIRLMJABZYK5Z6GjRqVNJx55GJKcbU5Hp
         dbNraxSWSrq3l1zMZjqz6cDbJnIokeE5s0U+DUizCmENsdnfEgOzejx1+iTPYoUuG3YW
         4QVoPdtJB+j8Oju4rIcshkpBs6TgWw3KZxvVpPWycYRCSdNE8SnBeoNFkCT/SGC9CD1r
         5yxlmsyqkuKyEioIimMR6ORfEFWOaBD9Yb192CEAXzScESeNrBZrSXlGmpX9eMai+gFO
         NouihQpg3dE/5aMBskFfC/zW275eljfFaZBFOCorV5ebh++aB66XZi59oIBgM3uNVPT/
         xW1g==
X-Gm-Message-State: AAQBX9f39cAK07BClHHmfYRMG5u6QgcpBIQKlq1uB+4/GJG+yQrSrCM+
        RPwQQN1ZMsvEfVSpr0rGGVP5Yw==
X-Google-Smtp-Source: AKy350bEMUfD5edr2eY3ReXrsmi/UKNwI4AGoYGOQQHnouyDcbguhMOmjjDAI+qc0Tc8bdcoatqnCA==
X-Received: by 2002:a05:6402:1a48:b0:501:d3a1:9a4a with SMTP id bf8-20020a0564021a4800b00501d3a19a4amr16860635edb.19.1680025420478;
        Tue, 28 Mar 2023 10:43:40 -0700 (PDT)
Received: from localhost ([2a02:8070:6387:ab20:5139:4abd:1194:8f0e])
        by smtp.gmail.com with ESMTPSA id 8-20020a508e08000000b004fa012332ecsm11889276edw.1.2023.03.28.10.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:43:40 -0700 (PDT)
Date:   Tue, 28 Mar 2023 13:43:39 -0400
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
Subject: Re: [PATCH v1 3/9] memcg: do not flush stats in irq context
Message-ID: <ZCMnS8LWXQ4I6vYD@cmpxchg.org>
References: <20230328061638.203420-1-yosryahmed@google.com>
 <20230328061638.203420-4-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328061638.203420-4-yosryahmed@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 28, 2023 at 06:16:32AM +0000, Yosry Ahmed wrote:
> Currently, the only context in which we can invoke an rstat flush from
> irq context is through mem_cgroup_usage() on the root memcg when called
> from memcg_check_events(). An rstat flush is an expensive operation that
> should not be done in irq context, so do not flush stats and use the
> stale stats in this case.
> 
> Arguably, usage threshold events are not reliable on the root memcg
> anyway since its usage is ill-defined.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Suggested-by: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Excellent, thanks!

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
