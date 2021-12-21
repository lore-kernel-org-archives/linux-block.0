Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96F1C433F5
	for <linux-block@archiver.kernel.org>; Tue, 21 Dec 2021 03:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhLUDem (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Dec 2021 22:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhLUDem (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Dec 2021 22:34:42 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7513FC06173E
        for <linux-block@vger.kernel.org>; Mon, 20 Dec 2021 19:34:42 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id r2so9141919ilb.10
        for <linux-block@vger.kernel.org>; Mon, 20 Dec 2021 19:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=W3CMFMMgIakeXJljyBRRnzi+FFYB1yqECcEGVJEIzJc=;
        b=Bm5h+LECyArPghdyQUryuJcBKKX/q6dkGKozeQqxnP5RfZx4A16YXTt0Yn4/dq4QrK
         HUdIfYR072Qw3/vAoCVJCCTOoM+vJnmdKXV4DhBN3SAZUfyMphEe33BNhKjAbXS2JLcD
         E+4Q6tJk2rHK9vB8lrDTZD/s5cOgnwN1cVwLzmwjHvCLF8/9lrBWy901aw5MHcm1Mg/L
         z6vUronHz7gQYoDj9jS6XwVec1NAMLvZXZTxe2T6frSQHJiyyhGepgJ6JOvmkt/cc4+M
         mqIm1hvmYnEYWVHb5UMwBitUezcWSKmi7p5/gSaQ7grIni19b4Gt+lUUH4KHlAr/9g6i
         y83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W3CMFMMgIakeXJljyBRRnzi+FFYB1yqECcEGVJEIzJc=;
        b=cfxHivgWvFoNd+WydG0mPKv+3Zk6mbVUneZqukv6FjZ6BP/EYEDkvLAbB3bPhRmyxZ
         FwXnnfsFHaPHKxP8hfktCdb93fgurdiwaxtmfOfwxaEUWsiI+FshmlvJgLlLh4F8lyVD
         PenVzvXtZf0lvKxkNSfZXaw0fVxzcCNkiispT5w2HAtXB1ACbwY8EIWXGburkAR+hstH
         9IUBBfq/lOYimVFx8uh0aDVDEO2hf4Ak+DJI8uLQ4Ca7lLhKFWhCEOUgI84gltQffw/u
         SPtBw1cvidlYbidt+sm5YR0rKcootU+cCAFtB3AbadTcr6+5DY70BAFECdscEGkZqwp+
         xLGQ==
X-Gm-Message-State: AOAM532c97mMF8UbHfqRIDLCOXKMTcpzYgMla4NCLxKHIaOgjW/2w1Hh
        VX/F4pw3QwIG419PABkep7R/jxagYaaE4g==
X-Google-Smtp-Source: ABdhPJyScs1goaUMwMt3BNmukjum+oUVK9Q4lyIc02WY5Emi7ap0W882AE5nf4MmXQyelz9sIJaJLw==
X-Received: by 2002:a05:6e02:92d:: with SMTP id o13mr21234ilt.49.1640057681765;
        Mon, 20 Dec 2021 19:34:41 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id i8sm1214071ilv.54.2021.12.20.19.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 19:34:41 -0800 (PST)
Subject: Re: [syzbot] general protection fault in set_task_ioprio
To:     syzbot <syzbot+8836466a79f4175961b0@syzkaller.appspotmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000c70eef05d39f42a5@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7ded6b2a-1f95-73a2-c074-2841dd5aaf96@kernel.dk>
Date:   Mon, 20 Dec 2021 20:34:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <000000000000c70eef05d39f42a5@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/20/21 8:04 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    07f8c60fe60f Add linux-next specific files for 20211220
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1355d295b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2060504830b9124a
> dashboard link: https://syzkaller.appspot.com/bug?extid=8836466a79f4175961b0
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12058fcbb00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17141adbb00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8836466a79f4175961b0@syzkaller.appspotmail.com

#syz test git://git.kernel.dk/linux-block for-next

-- 
Jens Axboe

