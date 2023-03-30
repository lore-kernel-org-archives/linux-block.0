Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34A8C77B60
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 19:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjC3TaW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 15:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjC3TaU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 15:30:20 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4FE210B
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 12:30:18 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id g21-20020a4ad855000000b0053e563c2f72so1942595oov.6
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 12:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680204618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Khpw7ou3XcOkEyyu20b7pCpZUxpOS3o1zWL8rB8cIWg=;
        b=EBZ5RSwu7qAxwJOxXP+VV5tCHAvd597imHWQHEOpyHjV99Yma2yYj2+GVrBE3CvEYu
         j8GOYLIo/8V6p01dDFwWDz0SuE7pJ9ps3e/uuV/vrp+Efny6FMlE8BM6+lrA9yui5XXy
         BP6sOtWFiXcCali8wq+wJ3ZeGb16MFGin5/zucLqAsEfB6IkgmUZYUNLVZS0o4LTsQYV
         p4WDiyCZ5dD1Xl6y5Lz0GhJWbb1bQHZ85QIJV0Hj8hcm7nUsFbYsfBttw01lkBWhwMDp
         adaoaJrHF1Tqpn0MyPd0QZKQohCtbf0gRnsrAsPTFufImEuTtaA7mENwlPt7Do/NeuEl
         4V8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680204618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Khpw7ou3XcOkEyyu20b7pCpZUxpOS3o1zWL8rB8cIWg=;
        b=qoCVq/GfNGQWtI1KLtYk2dflAAr5wuc19POcgFN69ErUKYmvQH6rw1445ncnLgrezW
         vwIxIW2KYxNZScEDAXitdN/dx26oB6sTidUAQyBoWeKyGH4MDHK+D443igIZ2vEYGBpe
         JaSiXA/GIDCNWwB3+7bg0CeL52AUhFbWtgatUIZiRkh8WSZn4w7ZEFBbOTVuGyepqsDT
         w87wnrMuwnA+tZwxTYLc7qN2jtshsq6dFHbHz7cOmUV+s4uTL5jWMPWdSkAn8/PL/9rH
         DxV4z5aey3urzggoLC3xprG1UKLPFruk1c0zeLyYz+gOZH1ja/2xVeqE1XHAM4kSDzpj
         jYmA==
X-Gm-Message-State: AO0yUKX4qiZC0aOiyvVE0Uk2LE+6ra4ag3IW1o1Byf5V6O5CbtLK8Nre
        3odNG4gXTvOIWKE5BVp1nGKGJA==
X-Google-Smtp-Source: AK7set8ZpEUnr0vsSLvX76E+UiWGEN8KrfPFawZyGwI6bQmQYsusk8/LecZTtUIeYJN+T8sl467z8w==
X-Received: by 2002:a4a:558f:0:b0:534:c237:eb00 with SMTP id e137-20020a4a558f000000b00534c237eb00mr11810755oob.3.1680204618144;
        Thu, 30 Mar 2023 12:30:18 -0700 (PDT)
Received: from localhost ([107.116.82.97])
        by smtp.gmail.com with ESMTPSA id 2-20020a4a0302000000b005251f71250dsm13103ooi.37.2023.03.30.12.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 12:30:17 -0700 (PDT)
Date:   Thu, 30 Mar 2023 15:30:13 -0400
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
        bpf@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v3 5/8] memcg: sleep during flushing stats in safe
 contexts
Message-ID: <ZCXjRYASA+Cjomlx@cmpxchg.org>
References: <20230330191801.1967435-1-yosryahmed@google.com>
 <20230330191801.1967435-6-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330191801.1967435-6-yosryahmed@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 30, 2023 at 07:17:58PM +0000, Yosry Ahmed wrote:
> Currently, all contexts that flush memcg stats do so with sleeping not
> allowed. Some of these contexts are perfectly safe to sleep in, such as
> reading cgroup files from userspace or the background periodic flusher.
> Flushing is an expensive operation that scales with the number of cpus
> and the number of cgroups in the system, so avoid doing it atomically
> where possible.
> 
> Refactor the code to make mem_cgroup_flush_stats() non-atomic (aka
> sleepable), and provide a separate atomic version. The atomic version is
> used in reclaim, refault, writeback, and in mem_cgroup_usage(). All
> other code paths are left to use the non-atomic version. This includes
> callbacks for userspace reads and the periodic flusher.
> 
> Since refault is the only caller of mem_cgroup_flush_stats_ratelimited(),
> change it to mem_cgroup_flush_stats_atomic_ratelimited(). Reclaim and
> refault code paths are modified to do non-atomic flushing in separate
> later patches -- so it will eventually be changed back to
> mem_cgroup_flush_stats_ratelimited().
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
