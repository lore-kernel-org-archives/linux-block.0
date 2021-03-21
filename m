Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67286C433C1
	for <linux-block@archiver.kernel.org>; Sun, 21 Mar 2021 21:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 270C461943
	for <linux-block@archiver.kernel.org>; Sun, 21 Mar 2021 21:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhCUV0L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Mar 2021 17:26:11 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:40767 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhCUV0K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Mar 2021 17:26:10 -0400
Received: by mail-pj1-f54.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so9356449pjq.5;
        Sun, 21 Mar 2021 14:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0iamQhREoLz4yBTZ1ac4df91aNQ8GHtf/WoDk/3WJ7o=;
        b=sxUcnHfbX2QQz4bFtJOqUDSrKvM8STDfC90kgoIZzZOx+ulBr8xVfZqPSY7+9uourS
         2NfpEhP4FBOIE9tFRLQEadlkVlCIG9BEyi0gVUumuYCccb0F0lusPhgg+/sKTBBxTS3r
         /3mG+XPkTOzG0neqsp9T2Q6wUOOup8lL68AL8nC6Mf/uChFgkSG8+IJjRkn3ZyqX1QOL
         NAlT5IYwSemu+D8IH0AvrCPu6QVbEd2hNd+7B7oFg86Bu+SGmn8JlaqzsBB2PN137/QO
         NTi7gxGLqG+MdNNe3GfjEX0FFMNiZTypUP7myYEUph+oEzOOaFVCMGYpIc4TZ1cC9GG4
         BIRA==
X-Gm-Message-State: AOAM531aHdSJ4QcfZCDVZPMcwMUM7/hrhR7LM6+edv9mFcDVaQJK1DQD
        u48wO8ea+o/3t+Hi1Qw2CV4tMHlbKUE=
X-Google-Smtp-Source: ABdhPJxBYX3cfQlW+9TXDGgYilDA2rXayowMbW3ZqGmlFDGOE2zxgvxrS2qAmngN6wahKWveqXBYbg==
X-Received: by 2002:a17:90a:a4cb:: with SMTP id l11mr9648060pjw.144.1616361969509;
        Sun, 21 Mar 2021 14:26:09 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:17e0:fd07:e626:199? ([2601:647:4000:d7:17e0:fd07:e626:199])
        by smtp.gmail.com with ESMTPSA id l19sm11320534pjt.16.2021.03.21.14.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Mar 2021 14:26:08 -0700 (PDT)
Subject: Re: [syzbot] KASAN: use-after-free Read in disk_part_iter_next (2)
To:     syzbot <syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000053da9405bd7d2644@google.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <f40ed33d-8ca2-a2f2-e534-9db9920570ad@acm.org>
Date:   Sun, 21 Mar 2021 14:26:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <00000000000053da9405bd7d2644@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/14/21 4:08 AM, syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    280d542f Merge tag 'drm-fixes-2021-03-05' of git://anongit..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15ade5aed00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=952047a9dbff6a6a
> dashboard link: https://syzkaller.appspot.com/bug?extid=8fede7e30c7cee0de139

#syz test: https://github.com/bvanassche/linux a5f35387ebdc
