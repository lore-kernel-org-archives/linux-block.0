Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8485DC54EBC
	for <linux-block@archiver.kernel.org>; Thu,  5 Jan 2023 00:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240806AbjAEAd6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Jan 2023 19:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbjAEAce (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Jan 2023 19:32:34 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776E64731B;
        Wed,  4 Jan 2023 16:28:15 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id jn22so37742395plb.13;
        Wed, 04 Jan 2023 16:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4sAIIgxsgcM6zCelHdPEl6Pb++H0W0grrXecdKrLDE=;
        b=jpt0IjXHlEgXNsAkpNEBgOwddPdEdRQokPy72ekZwKiT9h1afZv3+0Y4oXUI/ls7Da
         M+lJJZOATHkcXS8p4V510taPyr9xXF7StKG/iLf/FyRk4QB5KkHnSty9uIoyvOkVEeZp
         BjWy7mnsoa+F5PzRBvplc7mgoYOJQneKp8y4lVh70aA2iDkRWv1Gk6jCaojSw4D9E2Bk
         3F2PBjQt2WR6/GrDvKG05PY2M2awwB5cviAxOW/rjtO1YHw+QghI+hb+CDctmysNGaIk
         hHcK1Qf9kK0iFdF3AGULMaOcqtu7EQUufxbz6ldBgJi+mvtPViLghN4F9jUJtZzyrGgO
         3kvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4sAIIgxsgcM6zCelHdPEl6Pb++H0W0grrXecdKrLDE=;
        b=ZTVRYolcEdUQvLXwuQWKz8jqcN/nJMX8cpOZrhbpd7sEyBwgZwETsLvAITIBNKItX8
         YiKa5955w9k46iQhcct51QCTvAWxc0wo10VyUKva7xEpxFXaasZ2JA3RQSk2HEDbvoes
         39iyVoEIwJtyi6tw+MUju3qk5iJVViy5h2SWGtuXGGEjdgDUSpQnMCJnN4081rbU+niL
         ShcSKmVMruSpx0LuCos1cZRQvBOTKpU+12LCRGQlMr7VtvTfn4JwOm6pj8PVrDV85u5A
         n136/77JcsJvIA+XSU/RYX5f4TKF1ac2sv1Z6w/rl8LyZMcgM3ykA6e0WucJX0771YCY
         7AGA==
X-Gm-Message-State: AFqh2kr6fyBC8rO+qs5YTicqSd3CZ4cH5WIxZWTwtKOW1pjUTTR7xVC8
        sGtD0zFwHrAPafrMdOGqzP8=
X-Google-Smtp-Source: AMrXdXsAh0wzb7z/R3ew+jDxUTvJ9VdlLSOUKmzQ3IS1924XcOUlOLpE55jTLp3A7pOxdAjBjU6YyA==
X-Received: by 2002:a17:903:328e:b0:191:191f:e7af with SMTP id jh14-20020a170903328e00b00191191fe7afmr52164628plb.16.1672878494877;
        Wed, 04 Jan 2023 16:28:14 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902c1c600b0017fe9b038fdsm24747271plc.14.2023.01.04.16.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 16:28:13 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 4 Jan 2023 14:28:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@infradead.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next 3/4] block/rq_qos: use a global mutex to protect
 rq_qos apis
Message-ID: <Y7YZnM/nqb0gxOei@slm.duckdns.org>
References: <20230104085354.2343590-1-yukuai1@huaweicloud.com>
 <20230104085354.2343590-4-yukuai1@huaweicloud.com>
 <Y7XyIzGptuqO8EAt@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7XyIzGptuqO8EAt@slm.duckdns.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello, again.

On Wed, Jan 04, 2023 at 11:39:47AM -1000, Tejun Heo wrote:
> > 2) rq_qos_add() and blkcg_activate_policy() is not atomic, if
> >    rq_qos_exit() is done before blkcg_activate_policy(),
> >    null-ptr-deference can be triggered.
> 
> I'm not sure this part does. I think it'd be better to guarantee that device
> destruction is blocked while these configuration operations are in progress
> which can be built into blkg_conf helpers.

A bit more explanation:

Usually, this would be handled in the core - when a device goes away, its
sysfs files get shut down before stuff gets freed and the sysfs file removal
waits for in-flight operations to finish and prevents new ones from
starting, so we don't have to worry about in-flight config file operations
racing against device removal.

Here, the problem isn't solved by that because the config files live on
cgroupfs and their lifetimes are not coupled with the block devices'. So, we
need to synchronize manually. And, given that, the right place to do is the
blkg config helpers cuz they're the ones which establish the connection
between cgroup and block layer.

Can you please take a look at the following patchset I just posted:

  https://lkml.kernel.org/r/20230105002007.157497-1-tj@kernel.org

After that, all these configuration operations are wrapped between
blkg_conf_init() and blkg_conf_exit() which probably are the right place to
implement the synchronization.

Thanks.

-- 
tejun
