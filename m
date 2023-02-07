Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59668C636D4
	for <linux-block@archiver.kernel.org>; Tue,  7 Feb 2023 17:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjBGRVV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Feb 2023 12:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjBGRVU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Feb 2023 12:21:20 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CB86585
        for <linux-block@vger.kernel.org>; Tue,  7 Feb 2023 09:21:18 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id m15so6285761ilh.9
        for <linux-block@vger.kernel.org>; Tue, 07 Feb 2023 09:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMaLavanXS/g3XR3klgJ+AXxx5vAw+8OAiDcCfQmZ38=;
        b=2hB7T/Tz8d1WAzTpONaDpUxhkaEVNbh0h9B8xkNZvMe43HL03tD7YHvce0HxfrvSHK
         27TQB0k86z1+5j3w7l/y3jAOB44wuDACRwfuKfwiJN/nidqs5p29wXBUM66DXkWXEycp
         cMWJuan9yazhuWeUKcH+IHOSqbxYNqlXD5NKddeMraXgh6GEXjdlHlHpJyW7vDpWXoDQ
         L7leV7jz/f1xn0D1aufsFqCWMrQ/UZpU6CJ5rRTtpdlr5rsBNLqkGF0Fw8pAnEBkHHct
         31HWrimj50t7Wu8Ne4X4ZrZcrspXj4vtQJqA7m7G8Puhuc971lLRbiah8iZFSsg9u6RA
         55Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMaLavanXS/g3XR3klgJ+AXxx5vAw+8OAiDcCfQmZ38=;
        b=dG9c0wz1jRntH4RROFYVX+zWqOo/lTygdGG3nAdafple6au+Xbas8Y2wTPrw7F+Erc
         TPcpx6YCWxqYk3bTWzV8blkpjOMvUpkmJsLK57cvIGiRmGz5AgGWC+q0J/jXSv+6S+8G
         +FPhOPm5oswPQNUl5JJMnSkYFObkWs8J6oHD8Z1qn/MUy/WxRRZP4KdHGUDA+hLsOhdm
         2JF6zr8P85JiuE7qX3KVmbqgdkHi0ov1XWjttIGfr9+YemeV9J29RGDV5bnEcLmR7Awx
         unTeuoPr+aXkkB43ROosUaXN5OCT/KNGgnaV5bWeKb2zZpdLLE7I2dr12+ZrpTI71xuk
         7R+w==
X-Gm-Message-State: AO0yUKWkd8O7hQGJriY76Ef9XQ5vFyBRHIPDVIEjMAcko0tWtCU/dK3J
        DmHKDhF6CL847eQwBurOTkblRw==
X-Google-Smtp-Source: AK7set/maPiAXbvZYUNHIhip1EuI2XjwF3XkL6fwc5FCqiezmpvNiqijmluX8zrB+uL3EvqJCHmnUA==
X-Received: by 2002:a92:d851:0:b0:313:d6b8:dc30 with SMTP id h17-20020a92d851000000b00313d6b8dc30mr3729931ilq.0.1675790478156;
        Tue, 07 Feb 2023 09:21:18 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id s10-20020a02cf2a000000b00374bf3b62a0sm4529598jar.99.2023.02.07.09.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 09:21:17 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     jack@suse.cz, paolo.valente@linaro.org, tj@kernel.org,
        josef@toxicpanda.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230202134913.2364549-1-yukuai1@huaweicloud.com>
References: <20230202134913.2364549-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next v3] block, bfq: cleanup 'bfqg->online'
Message-Id: <167579047693.46818.10367166447142980266.b4-ty@kernel.dk>
Date:   Tue, 07 Feb 2023 10:21:16 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 02 Feb 2023 21:49:13 +0800, Yu Kuai wrote:
> After commit dfd6200a0954 ("blk-cgroup: support to track if policy is
> online"), there is no need to do this again in bfq.
> 
> However, 'pd->online' is not protected by 'bfqd->lock', in order to make
> sure bfq won't see that 'pd->online' is still set after bfq_pd_offline(),
> clear it before bfq_pd_offline() is called. This is fine because other
> polices doesn't use 'pd->online' and bfq_pd_offline() will move active
> bfqq to root cgroup anyway.
> 
> [...]

Applied, thanks!

[1/1] block, bfq: cleanup 'bfqg->online'
      commit: f37bf75ca73d523ebaa7ceb44c45d8ecd05374fe

Best regards,
-- 
Jens Axboe



