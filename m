Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50FDC6FD18
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 17:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjC1RnL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 13:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjC1RnH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 13:43:07 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BF5F744
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 10:43:00 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id h8so52934428ede.8
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 10:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680025379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YG+UIQYgxqGHyxX9M5F8H7BPrKcU2ibGbTNwGE2wMMA=;
        b=lUUqF6Gya0c4F6EmNxmKWP3J//Rfc+fMUR5PY0DlyVsha/TGEgRjN4mCOT1l6A8IiY
         n7xFgRU2eUNmyXHQduREl8GSVPQMGcc7AZS0+Yez2IHxxhB1Uh8xq5g8Caq0YNkYnsGy
         SJ5p88YcGM+O0E4pTE0ozZEm/wN++qhR9hFCmUIAikpRO3S9cwjnvwjA4/KEwZ1DdN94
         tcIp0SZS/C/QVh3Q8pNXwF0lOeoF8rHc+vz0WJ1G8dYJJF9qtD5/DcKJlm3B1G+5jlRk
         1GAWOqe5Ff4znRwZqdRMVPIyWXptPQmx152n8P8iGBLIVlpm9mLKaGq+4+SvyxzWPYLi
         W/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680025379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YG+UIQYgxqGHyxX9M5F8H7BPrKcU2ibGbTNwGE2wMMA=;
        b=eCJ7D1dHL92B0EAbiByn0QtBn0DUIUxSJ3Ofj+RYM6RX+eZw9ovHpXxvgTxd5P+Wdd
         QXxbWL2EOiTZRktlPh0lNJ+m0VbjAZgRl6/y3GGVggnybXharZVJKsa6hycHPVd6Z+an
         xge/Zi28okeXQRnFwXEStr3K+/EEAQukFgYc3d92IS9k6ySGVFjKQ/Jqf5Bwyjn3iWAn
         K3gM3f+SHcLcdJzoBehxnDcMNjYHU4DfbjByURGNRGbOtqtHvMItUXd4l+i6JpQRwYV3
         sSTh3ayBwEyzlWu3fBWPdO/uPisglOQxCZH823EPp6eTI8zcsPm81Kd5+EgC/5PxucsX
         746A==
X-Gm-Message-State: AAQBX9dHcm20/Yvw6QZTa+gco1G87dYH+3jskgal+1UGiZyvsFNj8q2k
        exAD8HDMIRV5jUjxGib1XhvB1A==
X-Google-Smtp-Source: AKy350akeYx8oU/FGVNmJIEWdKG3qETomY6DnhcwhKi0pJVbzha8m5e4mfxmESwKm4v0+8LDxhs04g==
X-Received: by 2002:aa7:d053:0:b0:4fa:e129:31cf with SMTP id n19-20020aa7d053000000b004fae12931cfmr17134270edo.23.1680025379828;
        Tue, 28 Mar 2023 10:42:59 -0700 (PDT)
Received: from localhost ([2a02:8070:6387:ab20:5139:4abd:1194:8f0e])
        by smtp.gmail.com with ESMTPSA id g20-20020a50d5d4000000b004fd29e87535sm7296869edj.14.2023.03.28.10.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:42:59 -0700 (PDT)
Date:   Tue, 28 Mar 2023 13:42:58 -0400
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
Subject: Re: [PATCH v1 2/9] memcg: rename mem_cgroup_flush_stats_"delayed" to
 "ratelimited"
Message-ID: <ZCMnIvfFwRbcmhf0@cmpxchg.org>
References: <20230328061638.203420-1-yosryahmed@google.com>
 <20230328061638.203420-3-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328061638.203420-3-yosryahmed@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 28, 2023 at 06:16:31AM +0000, Yosry Ahmed wrote:
> mem_cgroup_flush_stats_delayed() suggests his is using a delayed_work,
> but this is actually sometimes flushing directly from the callsite.
> 
> What it's doing is ratelimited calls. A better name would be
> mem_cgroup_flush_stats_ratelimited().
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
