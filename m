Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0293C433FE
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 02:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242114AbiC3Cyi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 22:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242104AbiC3Cyi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 22:54:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BA3517F3DD
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 19:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648608773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ma0cdZKvD2y8q033msWkRp2PLEzhGQ/8y/lyYzyaHeg=;
        b=Mx0ieUTdU+kloR8uaNZpzoFCKpCyeUTDNFRCywoyz0HjglZ96A7Ji6/f6/EgZqwPhSfWKC
        7bty6q6dNbU7xnnAaWvJGfoeC6zM12a5MJ5pKuCc4YUHvA3Ul6oEk3A8qhoyNQqmHm1mFJ
        bS5euydr777E/LfkH6EsnoRtuohv0MQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-YW-49ioDPEmY5OkLZcOJvg-1; Tue, 29 Mar 2022 22:52:52 -0400
X-MC-Unique: YW-49ioDPEmY5OkLZcOJvg-1
Received: by mail-lf1-f69.google.com with SMTP id z24-20020a056512371800b0043ea4caa07cso5970884lfr.17
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 19:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ma0cdZKvD2y8q033msWkRp2PLEzhGQ/8y/lyYzyaHeg=;
        b=4956RJRuKq5jDH0uh3rCpSrLkluF/uD1yPaZB6PVen9GbKr701G4m7hm+fqZ7Z+AV/
         bD5e9dZVrgXUUr7e7hqt6mwVEZHjsvouwlLuLdE3VbhQBu+IF1//JVgzSJLq6LCzAflc
         PF+IBywm1DvCQW+5R8Ki+CoMtN9hzuvagDNpnM38j848VU5wcfc+uLjRnjXzVAl30hw9
         D9dxaae8CmtVbzNREzuKUU3XhvfSAihgU+ohTHZAzqlu0n0hI8fSetjnOreNYSPGaO4W
         QIsXvrgr4jAzSkse9EnEfaMEOFi46m6iBywMqpWdSSm8jgWO6Bfs+rH56eCgmPeb8NNg
         TNRw==
X-Gm-Message-State: AOAM5333M07pWBoJchsBVWTfB0FalN67OIZlVj4evSGkM2GtdDhkkZxG
        MdW0Gqr/414QKH6RPiZovCYbdXFD8m4RRXsv6cqFGYO5MgG0HzQjBux4bx3/tZrBzzV0xqviQ2J
        7ZEkI65ezPy+zPG91h6g3xhv6vFE0KEKaaNnZSU8=
X-Received: by 2002:a2e:9c8:0:b0:248:f8:67c5 with SMTP id 191-20020a2e09c8000000b0024800f867c5mr4912822ljj.19.1648608770580;
        Tue, 29 Mar 2022 19:52:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkIA/whlS3j6eKLVHrldj2gWMf7FSGbkfNTmCl8OCDZ34eNxVwmazKVZychrCmUiRKlM0h/YaN1Vs3UK4+JYA=
X-Received: by 2002:a2e:9c8:0:b0:248:f8:67c5 with SMTP id 191-20020a2e09c8000000b0024800f867c5mr4912804ljj.19.1648608770371;
 Tue, 29 Mar 2022 19:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000921fd405db62096a@google.com>
In-Reply-To: <000000000000921fd405db62096a@google.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Wed, 30 Mar 2022 10:52:38 +0800
Message-ID: <CAFj5m9+Gc-t6vD17yWBNos-fk9vmhUTLsXYGrSx4Bdzn7R67JQ@mail.gmail.com>
Subject: Re: [syzbot] possible deadlock in throtl_pending_timer_fn
To:     syzbot <syzbot+934ebb67352c8a490bf3@syzkaller.appspotmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 30, 2022 at 5:23 AM syzbot
<syzbot+934ebb67352c8a490bf3@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    cb7cbaae7fd9 Merge tag 'drm-next-2022-03-25' of git://anon..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17ef8b43700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7094767cefc58fb9
> dashboard link: https://syzkaller.appspot.com/bug?extid=934ebb67352c8a490bf3
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+934ebb67352c8a490bf3@syzkaller.appspotmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
for-5.18/block

It should be fixed by:

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.18/block&id=d578c770c85233af592e54537f93f3831bde7e9a

Thanks,

