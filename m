Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1C0C433ED
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 21:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00202611BF
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 21:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbhESVVd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 May 2021 17:21:33 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:57043 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhESVVd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 17:21:33 -0400
Received: by mail-il1-f197.google.com with SMTP id u5-20020a92da850000b0290167339353beso14154857iln.23
        for <linux-block@vger.kernel.org>; Wed, 19 May 2021 14:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
        b=p2XTwD74ms/KvOYsiGEl5qKN3uwLALweCi5QltcRogdsvxwN8NSp5XaEnvgsSA/sri
         JaS6CrvZ7VyeTF6o8DGZk7oJRFQUwBvVm7HBYJex7VE/nw304EDJSOozoxRbotK0kocS
         kuSPYaaDta613poItZfULgmjJdjhq07elmibGE7ljISSnwnHKUSWt0VLpNl21UbjCIBi
         seqt8M9l1loSuPLW5IvojS4xBU0dxqYm8/Za0mBMvqmRQluZn1/MYOYfCdj8NsGHhArv
         NlsXTcBWDlj7m2dvkXLvj3L1TwTQXDtjnnkAfpDJl6XzT/LTZEOJ9uBcd4eM/LP46MUh
         Z/eA==
X-Gm-Message-State: AOAM532Kc+mjbpw7Q781ItqVX/FzAw+lU6ZJ+8w0yHpcSsUMRiOevqpb
        KYJHHidFgPfC/qGmE01IjivVVb5NJtxfBBQxpCUW2jGnqjWE
X-Google-Smtp-Source: ABdhPJx8VGV2AowHbhQLRUUM3t2/NTkPxF/lr8g2940N1fdAGo4lnn8PGW6H1XIbKr7SpsV+18LlWRt4H4yTIMVu63/Nu5zWdSEY
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:e05:: with SMTP id a5mr1018062ilk.235.1621459212835;
 Wed, 19 May 2021 14:20:12 -0700 (PDT)
Date:   Wed, 19 May 2021 14:20:12 -0700
In-Reply-To: <0000000000006932df0596121784@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000066201405c2b56476@google.com>
Subject: Re: KCSAN: data-race in wbt_wait / wbt_wait
From:   syzbot <syzbot+ba8947364367f96fe16b@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, elver@google.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzkaller-upstream-moderation@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Auto-closing this bug as obsolete.
Crashes did not happen for a while, no reproducer and no activity.
