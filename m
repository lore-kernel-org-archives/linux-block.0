Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A7CC433EF
	for <linux-block@archiver.kernel.org>; Mon,  6 Dec 2021 01:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhLFBZl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 Dec 2021 20:25:41 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:44771 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhLFBZk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 Dec 2021 20:25:40 -0500
Received: by mail-il1-f200.google.com with SMTP id a3-20020a92c543000000b0029e6ba13881so5914515ilj.11
        for <linux-block@vger.kernel.org>; Sun, 05 Dec 2021 17:22:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
        b=jpva+rhd8qpkHxujyhiwuvrJNU7UI6wnpj1IRlctsKjnbPModBunUJyNxQsaUvELfK
         PFc5rPLYkCPyDNJC8zOwazLYJpVTNeyVW7nvD4VelIg2o+Q8+f0ZOs7N210XOgWBgAGz
         xya/8kX8bQNG0VFitXqHz0BEHcro0lExz/zUsGFJsi/zOHkCzvbicPI/LfdEf5jREtu5
         i2HmW4HGwG2bNk/ktVK/KEGL93B6+8zvoemNJ7cdQdN7lgd1ndGwBvIdL7TglZG4skD5
         yfzYP+uBZu56cpIz7fd8/JEtLMT/BnVexflMi84O4Lp6Un3qBiC3ta7DEz0BAiYa2BAO
         uqfw==
X-Gm-Message-State: AOAM5307WcNVcO7B5wYu+YV3nGzErYqg5zEVuVjo4IuWjRBwI7D6XZ86
        xSYnlL22aJYJtefHbFYqPL6fMajHPaohmAP5CPcPGkGrw/7r
X-Google-Smtp-Source: ABdhPJy/LFie2vec2wVfvdbXF6LNvp20a0txNPQ2lsWp0Aoj+RwONdCz82+R9QNxfomVLUkwUx0wglERxX6iV6T3k8z+9P4CSiY/
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d08:: with SMTP id q8mr38383669jaj.38.1638753732571;
 Sun, 05 Dec 2021 17:22:12 -0800 (PST)
Date:   Sun, 05 Dec 2021 17:22:12 -0800
In-Reply-To: <0000000000004c10220598f8a1d0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ab61405d2701689@google.com>
Subject: Re: KCSAN: data-race in blk_mq_dispatch_rq_list / blk_mq_dispatch_rq_list
 (2)
From:   syzbot <syzbot+2c308b859c8c103aae53@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, elver@google.com, kasan-dev@googlegroups.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-upstream-moderation@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Auto-closing this bug as obsolete.
Crashes did not happen for a while, no reproducer and no activity.
