Return-Path: <SRS0=G4H8=2H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032F5C43603
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 16:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46BE24672
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 16:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="R7KIp6zl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfLQQCJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Dec 2019 11:02:09 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40320 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfLQQCI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 11:02:08 -0500
Received: by mail-io1-f66.google.com with SMTP id x1so2449397iop.7
        for <linux-block@vger.kernel.org>; Tue, 17 Dec 2019 08:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5JIm+66jed2pLoKMUo/hqq7wkhQB4//2xuBd2ygSaNg=;
        b=R7KIp6zlfUik0IXY+VjHwKMOdTHoc7uLYkmii16Joq6fT0R6SDlBzaVfg3xBvCU3MI
         A0sg8uE8R+aKAYgeJa1pCB348yHY1bgNArCl3P8UJyhLQh8Eu09QJJ8KY/of6nAnLSWQ
         N7/t/ptfH7gAtWnk176IxWb4+KVdE12gjSKO56OgPAIPz8M0YxVuuP31daA9s91hYuYg
         e1xhT/bH+Jw+6aEq9BT49RD4eKQLiy01BYJxa+dJoFA7izEeNcN9i435vcwkXQIJOT16
         DRvgzzGLslNRs2H8jM6Aqc3eIAmd61B2b594brygRh8xrk+FBHMUQVMz5CSvxKK2vHU1
         fzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5JIm+66jed2pLoKMUo/hqq7wkhQB4//2xuBd2ygSaNg=;
        b=n4pV3nlaBymgJfn8iKEIpb/reFz89eszPwN8imuvpdSLxfqG+tn8ZnkxhsicHQXdMV
         E6/vhS+fC++cU0qo13e0u8RL5DHi+hs6uLb/YL9PvwxhKwe7M7Mn0wKcRTFqaD/RyBWr
         0FBen9ZBGKM0oZnJCNaTPX4jvvMa9R8WS2ERlsX4boAuGj4b7jFwuvZGTfWxkrEahZYx
         CscDOWoJnLHC1p0CzP5+lOi+s6xC7iYUtgsBQpn2QmBkjkJVrw6IIsxgrZGT+kGi4IKO
         6aBipaa3T2TeRc6mQ0rjDobg/PBqCInzxRwuCJVqo3mT81NmQRhrwk0ZDmtO6TMjdIty
         yllw==
X-Gm-Message-State: APjAAAUa9X4i8vXljQAt71fi8d5ZM779T9WeYkkcsevZp7+Vmz1U67VG
        N42gfFqA3j0ccYZ7SEdeGN3udK3U8wyblQ==
X-Google-Smtp-Source: APXvYqyXqI7MAB3jK3X4MXe3QR4hgLAKfWqQppblEyl5vfrVHkY23Rws/m2uca0zCYYDu2blc6H41g==
X-Received: by 2002:a02:1041:: with SMTP id 62mr17461376jay.51.1576598527956;
        Tue, 17 Dec 2019 08:02:07 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 75sm3970179ila.61.2019.12.17.08.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 08:02:07 -0800 (PST)
Subject: Re: [PATCH 1/1] block: end bio with BLK_STS_AGAIN in case of non-mq
 devs and REQ_NOWAIT
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     linux-block@vger.kernel.org
References: <20191217155407.928386-1-rpenyaev@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <08f4bf46-fc8f-b2e4-d887-cde71ff4a75c@kernel.dk>
Date:   Tue, 17 Dec 2019 09:02:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217155407.928386-1-rpenyaev@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/19 8:54 AM, Roman Penyaev wrote:
> Non-mq devs do not honor REQ_NOWAIT so give a chance to the caller to repeat
> request gracefully on -EAGAIN error.
> 
> The problem is well reproduced using io_uring:
> 
>    mkfs.ext4 /dev/ram0
>    mount /dev/ram0 /mnt
> 
>    # Preallocate a file
>    dd if=/dev/zero of=/mnt/file bs=1M count=1
> 
>    # Start fio with io_uring and get -EIO
>    fio --rw=write --ioengine=io_uring --size=1M --direct=1 --name=job --filename=/mnt/file

Thanks, this makes a lot of sense, doing -EIO for that case is wrong. Applied
for 5.5.

-- 
Jens Axboe

