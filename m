Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5CBC05027
	for <linux-block@archiver.kernel.org>; Sun, 12 Feb 2023 03:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBLDzb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 11 Feb 2023 22:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBLDza (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 11 Feb 2023 22:55:30 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F0011E99
        for <linux-block@vger.kernel.org>; Sat, 11 Feb 2023 19:55:26 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id w20-20020a17090a8a1400b00233d7314c1cso1310586pjn.5
        for <linux-block@vger.kernel.org>; Sat, 11 Feb 2023 19:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EhWxFB4ODTurP+Bbh4zJn7gAxthxpyL6UKX+g4y+ZjQ=;
        b=4oXWD6WwwvKtE7IE7ek3e8RvqRagQZ8C8ZrVALBgqtBxdRjm/aG7oxpBqUnFwwM4DJ
         ek/S+kJ9IUeThE7HJuw7gpf7HnWARkN688eLl24wK0jaNeXhgDkFMWm0NfKMMJn1y6SE
         h4EA/zeco7f8KQFXqBOXxVOPDf13kk+VjrfQQ7bZyHvYFEvs9qdQjwn1PPKGX+s5ShQ5
         tKUPaXqT5Cu/VF3Afq8HKMWuhPcNDkMsOmtEgIMUaSFUcO5ihZ/plT4S3Rx6zU8mFNOH
         g5Zee/a2NpptVNbnAIkNNH6nT3tQKF4AxjMi81qPNsjzLk52oa+VmL15tBMLA11JguiU
         zNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EhWxFB4ODTurP+Bbh4zJn7gAxthxpyL6UKX+g4y+ZjQ=;
        b=BNclecLNp1lnt2K10Lq57O1YzwLM0uyI1eRaTlB1eFJvJsodfq6DnVsdwgcPYtv4Gw
         J7GfD3e9jOeX1jzK/fyi2WYzEYip3U70lqVilS3Toc7DcojXY/fRPObOfRmqfCKMjeyF
         aekaDhAJaPlkOJu6BPRPKwLcFM9U1dxOV3std6Z3Icgw+ws41IgPyS2YKstQXZjaKaCv
         lB6cDPQtX/amh7N2Wr3TtqlVY5U7lvvGDR2I0EJn2CBcSPDsEw+jhDMOJK4wn8kYpnP9
         bc5x53IGE7Zr68DHU5l5Z5ZBl3/IwUQ/iVFC3wiwzbzlqAPx/bGiRzhxnP1R86bA4dTH
         qlwQ==
X-Gm-Message-State: AO0yUKWlBAbzAZpuJyXHBxrSV8TkJrE7QEwbyybbAcbTv+/d5hYZndfC
        OkZ/m324VDeDUoj1X0Jn/yYmlg==
X-Google-Smtp-Source: AK7set9jwghXObjJgAAtgV3PvPOahGO37nT0OGYuWJMwgbbwncNytT3Wwxr2VE0SCOTnwxETr7ru1w==
X-Received: by 2002:a17:903:182:b0:198:a5d9:f2fd with SMTP id z2-20020a170903018200b00198a5d9f2fdmr21711336plg.6.1676174125887;
        Sat, 11 Feb 2023 19:55:25 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902ee8a00b001992e74d058sm975727pld.7.2023.02.11.19.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 19:55:25 -0800 (PST)
Message-ID: <44355d28-776a-0134-b087-c11cf4e82f34@kernel.dk>
Date:   Sat, 11 Feb 2023 20:55:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 3/4] io_uring: add IORING_OP_READ[WRITE]_SPLICE_BUF
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
References: <20230210153212.733006-1-ming.lei@redhat.com>
 <20230210153212.733006-4-ming.lei@redhat.com>
 <a487261c-cc0e-134b-cd8e-26460fe7cf59@kernel.dk> <Y+e+i5BXQHcqdDGo@T590>
 <22772531-bf55-f610-be93-3d53c9ce1c6d@kernel.dk> <Y+hbggDCm9wViPAv@T590>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y+hbggDCm9wViPAv@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/11/23 8:22?PM, Ming Lei wrote:
>>>> Also seems like this should be separately testable. We can't add new
>>>> opcodes that don't have a feature test at least, and should also have
>>>> various corner case tests. A bit of commenting outside of this below.
>>>
>>> OK, I will write/add one very simple ublk userspace to liburing for
>>> test purpose.
>>
>> Thanks!
> 
> Thinking of further, if we use ublk for liburing test purpose, root is
> often needed, even though we support un-privileged mode, which needs
> administrator to grant access, so is it still good to do so?

That's fine, some tests already depend on root for certain things, like
passthrough. When I run the tests, I do a pass as both a regular user
and as root. The important bit is just that the tests skip when they are
not root rather than fail.

> It could be easier to add ->splice_read() on /dev/zero for test
> purpose, just allocate zeroed pages in ->splice_read(), and add
> them to pipe like ublk->splice_read(), and sink side can read
> from or write to these pages, but zero's read_iter_zero() won't
> be affected. And normal splice/tee won't connect to zero too
> because we only allow it from kernel use.

Arguably /dev/zero should still support splice_read() as a regression
fix as I argued to Linus, so I'd just add that as a prep patch.

>>>> Seems like this should check for SPLICE_F_FD_IN_FIXED, and also use
>>>> io_file_get_normal() for the non-fixed case in case someone passed in an
>>>> io_uring fd.
>>>
>>> SPLICE_F_FD_IN_FIXED needs one extra word for holding splice flags, if
>>> we can use sqe->addr3, I think it is doable.
>>
>> I haven't checked the rest, but you can't just use ->splice_flags for
>> this?
> 
> ->splice_flags shares memory with rwflags, so can't be used.
> 
> I think it is fine to use ->addr3, given io_getxattr()/io_setxattr()/
> io_msg_ring() has used that.

This is part of the confusion, as you treat it basically like a
read/write internally, but the opcode names indicate differently. Why
not just have a separate prep helper for these and then use a layout
that makes more sense, surely rwflags aren't applicable for these
anyway? I think that'd make it a lot cleaner.

Yeah, addr3 could easily be used, but it's makes for a really confusing
command structure when the command is kinda-read but also kinda-splice.
And it arguable makes more sense to treat it as the latter, as it takes
the two fds like splice.

-- 
Jens Axboe

