Return-Path: <SRS0=SzsG=WD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D8DC433FF
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 18:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA852229C
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 18:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389273AbfHGSpF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Aug 2019 14:45:05 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35907 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389158AbfHGSpF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Aug 2019 14:45:05 -0400
Received: by mail-pl1-f196.google.com with SMTP id k8so42112890plt.3
        for <linux-block@vger.kernel.org>; Wed, 07 Aug 2019 11:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xIJw/ZOwme1F0OeE1c3HaXVK6oxWj8lplf3WugJxvuo=;
        b=fC9bZUG2SIe5x6szH472PDR/K9Zm3BaiLLrTfjKTbU+6OuFWxd21tnbroO2UJRf8ZP
         XLGlcjZ1rL3IMT7fgL8MGBcluUJqoz5FA152GmAefBlVyNyRwYYbQO4rvBzZXyyH2fvU
         1iG9VFk68xpBt/+Mpp5tFlq5cn1lGniB8zTXe/DtLLgy1bErY67po5SWtdlhunszkP6J
         IW6HxJxC3Z8aAhNlhPg6RNNcz8tnN+AE5LZO63/07ETFgtaZAZ7cEbA46WOJuwZCF2Pz
         Wmu4D3vq5pokeHYgRo1BpkzxPlM1P2P72gm1QF9TG/UqW+RJL48S79HMQxoTo0hnxemF
         qXrQ==
X-Gm-Message-State: APjAAAWy0S5K3duiXAbIThA5oLgCt1Qx7VZH6/dWP7E70TQmtWxPoK5Z
        pHXdJnGqaX7+++3iuecCuLs=
X-Google-Smtp-Source: APXvYqxmcApZOoqb4/n0aSsva3g1eGu297I9jkpMsC8Ts8mNU46EBP2QaL0QNlHDl+ZAtQ5746S6sQ==
X-Received: by 2002:a17:90a:1c17:: with SMTP id s23mr1298094pjs.108.1565203504855;
        Wed, 07 Aug 2019 11:45:04 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:fb9c:664d:d2ad:c9b5? ([2620:15c:2c1:200:fb9c:664d:d2ad:c9b5])
        by smtp.gmail.com with ESMTPSA id i123sm125059867pfe.147.2019.08.07.11.45.03
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 11:45:03 -0700 (PDT)
Subject: Re: [PATCH] loop: Don't change loop device under exclusive opener
To:     Jan Kara <jack@suse.cz>
Cc:     John Lenton <john.lenton@canonical.com>,
        Kai-Heng Feng <kaihengfeng@me.com>,
        Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org, jean-baptiste.lallement@canonical.com
References: <20190516140127.23272-1-jack@suse.cz>
 <50edd0fa-9cfa-38e1-8870-0fbc5c618522@kernel.dk>
 <20190527122915.GB9998@quack2.suse.cz>
 <b0f27980-be75-bded-3e74-bce14fc7ea47@kernel.dk>
 <894DDAA8-2ADD-467C-8E4F-4DE6B9A50625@me.com>
 <20190730092939.GB28829@quack2.suse.cz>
 <CAL1QPZQWDx2YEAP168C+Eb4g4DmGg8eOBoOqkbUOBKTMDc9gjg@mail.gmail.com>
 <20190730101646.GC28829@quack2.suse.cz>
 <20190730133607.GD28829@quack2.suse.cz>
 <43344436-99b5-f0a7-b71e-2bbb025dfd09@acm.org>
 <20190807094520.GB14658@quack2.suse.cz>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e8a14811-7091-dc0a-dcc6-38ff597bddc3@acm.org>
Date:   Wed, 7 Aug 2019 11:45:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807094520.GB14658@quack2.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/7/19 2:45 AM, Jan Kara wrote:
> On Mon 05-08-19 09:41:39, Bart Van Assche wrote:
>> A new kernel warning is triggered by blktests block/001 that did not happen
>> without this patch. Reverting commit 89e524c04fa9 ("loop: Fix mount(2)
>> failure due to race with LOOP_SET_FD") makes that kernel warning disappear.
>> Is this reproducible on your setup?
> 
> Thanks for report! Hum, no, it seems the warning doesn't trigger in my test
> VM. But reviewing the mentioned commit with fresh head, I can see where I
> did a mistake during my conversion of blkdev_get(). Does attached patch fix
> the warning for you?

Hi Jan,

That patch indeed fixes the warning. Feel free to add my Tested-by.

Thanks,

Bart.

