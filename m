Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F705C04AAF
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 20:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A5020818
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 20:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0eDh7fH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfEPUoL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 May 2019 16:44:11 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:37392 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfEPUoL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 16:44:11 -0400
Received: by mail-it1-f195.google.com with SMTP id m140so8535168itg.2
        for <linux-block@vger.kernel.org>; Thu, 16 May 2019 13:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ykHQl86Sla8ocODEf66DBTS2PNkL7EqHjixhDXTbtic=;
        b=0eDh7fH38tOZZ+ZnXWWTkLdWOyB7tWVpMnp2/i8ljjn5lueCBuAVctI+HgF5vwZaHZ
         dIDfIRYnu7jFOCXNNA/liKJuIK75dCfCcxGCLdXVZfcvYMHq/Y8ZneTajn4CuIFcpkvA
         5i4B1U+LRATPkVSkUQQQvUWZpzFuO1+ViX/HBwxx2ENwkU+JZkLN+OnRAmArjr02bgAD
         UJyCZOfF5qhd7lAwy9cLdfhWNddhkZ9CKqminL2A7Vq8gvKI1PveezPZuwlj1L+rs0an
         Uie00ao/a0cg004z3AgSpbMbOItmTcG/M4RJBtUXOB+BYhSAPBOS94JxzzPr0RWVMI7F
         cncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ykHQl86Sla8ocODEf66DBTS2PNkL7EqHjixhDXTbtic=;
        b=CRaaS1/vFDp7s0ZOLpSdEkCKeQtmJ+naGHef/Om75LXXBdQloSHitOpI2lyNmxW+G1
         DQvck2NnJ7A6A2ZQV/uZaAga7j+4+3GosxZ6jzZqyBTsWkrVxr48iOCcYYgyWtxNKy87
         WFlQ1vasIiyexyJFTDiydbGfGWl8OlX99oviBqSdR5xgyOZIEqj9/fSxxe3qaCH7hHrt
         AE39dguGXB93zL1viQ9D6xLBEppek5djYike7iwXGP+j4ZfR5OkBBPoynzOKn/wMj2Tz
         slxBkdwLYTYZYFQNldZ+7LXKYyL9sQ62XlbdjqPN+cxpljp8c7QtkANELn3CrPRCvbw4
         a1Qg==
X-Gm-Message-State: APjAAAX3mrkvOB1BepINV0qr4KvTIx5AQSZPiHFrjI+Pv9G+322Prbz0
        U84WS3cu20mPhH9vgGvxDYBFsszdnEWMgQ==
X-Google-Smtp-Source: APXvYqz4ErTr5zT74uGCRaNfjtC4dXGpUB+D9qFPTpmXRJCltn5+DjhhCl82VOJqwooUhYUZ/gq3Tg==
X-Received: by 2002:a02:b89:: with SMTP id 131mr35138323jad.58.1558039449694;
        Thu, 16 May 2019 13:44:09 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id l13sm2013423iti.6.2019.05.16.13.44.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 13:44:08 -0700 (PDT)
Subject: Re: [PATCH] loop: Don't change loop device under exclusive opener
To:     Jan Kara <jack@suse.cz>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org
References: <20190516140127.23272-1-jack@suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <50edd0fa-9cfa-38e1-8870-0fbc5c618522@kernel.dk>
Date:   Thu, 16 May 2019 14:44:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516140127.23272-1-jack@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/16/19 8:01 AM, Jan Kara wrote:
> Loop module allows calling LOOP_SET_FD while there are other openers of
> the loop device. Even exclusive ones. This can lead to weird
> consequences such as kernel deadlocks like:
> 
> mount_bdev()				lo_ioctl()
>   udf_fill_super()
>     udf_load_vrs()
>       sb_set_blocksize() - sets desired block size B
>       udf_tread()
>         sb_bread()
>           __bread_gfp(bdev, block, B)
> 					  loop_set_fd()
> 					    set_blocksize()
>             - now __getblk_slow() indefinitely loops because B != bdev
>               block size
> 
> Fix the problem by disallowing LOOP_SET_FD ioctl when there are
> exclusive openers of a loop device.
> 
> [Deliberately chosen not to CC stable as a user with priviledges to
> trigger this race has other means of taking the system down and this
> has a potential of breaking some weird userspace setup]
> 
> Reported-and-tested-by: syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  drivers/block/loop.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> Hi Jens!
> 
> What do you think about this patch? It fixes the problem but it also
> changes user visible behavior so there are chances it breaks some
> existing setup (although I have hard time coming up with a realistic
> scenario where it would matter).

I also have a hard time thinking about valid cases where this would be a
problem. I think, in the end, that fixing the issue is more important
than a potentially hypothetical use case.

> Alternatively we could change getblk() code handle changing block
> size. That would fix the particular issue syzkaller found as well but
> I'm not sure what else is broken when block device changes while fs
> driver is working with it.

I think your solution here is saner.

-- 
Jens Axboe

