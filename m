Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C21C433EF
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 02:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242140AbiC3Cyn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 22:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242135AbiC3Cym (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 22:54:42 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E6F17F3DD
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 19:52:58 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id k20-20020a5e9314000000b00649d55ffa67so13586885iom.20
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 19:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=QTWd4i/NLWNwVTetwl9CtbJr/No1iCLKabQJftIK/JA=;
        b=fiehqZ94kbB/cg0MYzj37rFZ3+GusmNp1Ri4Ok1pMWMpi48vw6ka0cqVnlpARHiptw
         ZcJqgzbWz80XxDp6QOoTznjgGxCiq4PIxrjPGrS2438UWoez5PqvZtit00pFmkhF9imz
         dDzPx608VJDi8AwUPfEP4+TGju67FeUjdZKxc+LDox/mSlBFFKCV0FktT6tU0BUB3BNR
         V9qZvqgnoLFv8ediMroi27dD9pfv7OGXlbhWx3Q8eWsa0Ej0UkevaA4XOhGz+x0Z+u+B
         KntoeDJrleUVtyvuZ7ByWkJ1FCyS+PttSkVgpaFwFL0QJ9LoJwhzmpq3KpNqT2WPtf7V
         AXkA==
X-Gm-Message-State: AOAM533Sj7xMRDbUrDxH8DK6zQLAlcwfhr/dYTnde0uMJ8UOdCM0XHmg
        4N1+hoy+HEgn/4hIIGFJl9531GDPTEiY10VdA1m03FFhwBao
X-Google-Smtp-Source: ABdhPJyq9cQJoYCYrKX1O1yqGx4xWLqI4SbSujkC+1zs14yfWnJqdT9ztdF8dPSAxYZS5ZRJPB7UCGp5tHB/P7vcWu8eb6aUgH5Y
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3043:b0:314:7ce2:4a6e with SMTP id
 u3-20020a056638304300b003147ce24a6emr17819523jak.258.1648608777933; Tue, 29
 Mar 2022 19:52:57 -0700 (PDT)
Date:   Tue, 29 Mar 2022 19:52:57 -0700
In-Reply-To: <CAFj5m9+Gc-t6vD17yWBNos-fk9vmhUTLsXYGrSx4Bdzn7R67JQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009518f205db66a47a@google.com>
Subject: Re: [syzbot] possible deadlock in throtl_pending_timer_fn
From:   syzbot <syzbot+934ebb67352c8a490bf3@syzkaller.appspotmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On Wed, Mar 30, 2022 at 5:23 AM syzbot
> <syzbot+934ebb67352c8a490bf3@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    cb7cbaae7fd9 Merge tag 'drm-next-2022-03-25' of git://anon..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=17ef8b43700000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=7094767cefc58fb9
>> dashboard link: https://syzkaller.appspot.com/bug?extid=934ebb67352c8a490bf3
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+934ebb67352c8a490bf3@syzkaller.appspotmail.com
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git

This crash does not have a reproducer. I cannot test it.

> for-5.18/block
>
> It should be fixed by:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.18/block&id=d578c770c85233af592e54537f93f3831bde7e9a
>
> Thanks,
>
