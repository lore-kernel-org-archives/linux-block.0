Return-Path: <SRS0=U0+/=T3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02060C04AB3
	for <linux-block@archiver.kernel.org>; Mon, 27 May 2019 13:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5589208CA
	for <linux-block@archiver.kernel.org>; Mon, 27 May 2019 13:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NtXiKUPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfE0Ned (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 May 2019 09:34:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35683 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfE0Nec (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 May 2019 09:34:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id t1so9146137pgc.2
        for <linux-block@vger.kernel.org>; Mon, 27 May 2019 06:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=okasw02j/vPiwHkEjHUsvt+sfw5uWW3XZmw6m6Ql8+o=;
        b=NtXiKUPEjI5mw5w5u63KEK032WyQVOQsQfmCmlmNAgbw5bGvNpUFUvTOntFZegpHWv
         YjSSWu6Z6yOu2yPSBn2VYPd2ngMZV0DK33BqN+GFaO9ocp4MD+TaWzpksycVFidNc0c5
         nAasLNnxvcIfgEbR9+sl/bRdvVfuoNBTitBuA4cO/QAUT3U5c3GqFqUNtCpt/z7LU+bf
         L2+xVijnjDuxtAKFNON4nmrGbztO92FRVf20eT0k+IW9nueoB/7gtl606xuAs4J87yCf
         xQXViUw+h5un5yNVJTb4xWtZntn55A8OqR06/mXn3pDnKcfmUbzGm702o3/96bYDdE9F
         BPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=okasw02j/vPiwHkEjHUsvt+sfw5uWW3XZmw6m6Ql8+o=;
        b=prbM9FrV4AtcDuO8kKSFBt7TkO3QcdkKPF/uP0EuC9UXmpFTd55xJGCUBTO8lzVhV4
         md4+ol74ExTK6VBVKx4JNi9D06lm13GK/8otgVDbwaShPC+RP8w38Ksxm3FWcHNthZCJ
         ng/8q3LOM0Lzbm5qCw8vs9kI9s01euKp6IyNNAH434vMoFZ6w4BeNw3H5mdzxNL80xsr
         EoihvfvISw2lnXAgdkLvhdliRoFWO3joahTx9LtGX6d64tqyRYBBFeHLaimvE684u4no
         CnVao2CzrM4/ppwlpdASfObNd3RRdLc4W8QFSuw7M50pvLtSrUPPGSPN7brBfG/pNmlL
         mGDg==
X-Gm-Message-State: APjAAAXNuOFq9aHdHY8vO/0zB4LkMYVNCXP4BiOO/B0SIDFiHEeCCuXx
        tO9+iIzEy6WldhluKm3epyvkydVUuco+yQ==
X-Google-Smtp-Source: APXvYqxNs4/Foq4kgXGck6rpEH58VSCi25g70wg0mdKXlNSVjYCxkDyHkafGAvznkqxs9KmHO0gJ4Q==
X-Received: by 2002:a63:5166:: with SMTP id r38mr55256738pgl.429.1558964071707;
        Mon, 27 May 2019 06:34:31 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id f16sm16532608pja.18.2019.05.27.06.34.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 06:34:30 -0700 (PDT)
Subject: Re: [PATCH] loop: Don't change loop device under exclusive opener
To:     Jan Kara <jack@suse.cz>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org
References: <20190516140127.23272-1-jack@suse.cz>
 <50edd0fa-9cfa-38e1-8870-0fbc5c618522@kernel.dk>
 <20190527122915.GB9998@quack2.suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b0f27980-be75-bded-3e74-bce14fc7ea47@kernel.dk>
Date:   Mon, 27 May 2019 07:34:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190527122915.GB9998@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/27/19 6:29 AM, Jan Kara wrote:
> On Thu 16-05-19 14:44:07, Jens Axboe wrote:
>> On 5/16/19 8:01 AM, Jan Kara wrote:
>>> Loop module allows calling LOOP_SET_FD while there are other openers of
>>> the loop device. Even exclusive ones. This can lead to weird
>>> consequences such as kernel deadlocks like:
>>>
>>> mount_bdev()				lo_ioctl()
>>>    udf_fill_super()
>>>      udf_load_vrs()
>>>        sb_set_blocksize() - sets desired block size B
>>>        udf_tread()
>>>          sb_bread()
>>>            __bread_gfp(bdev, block, B)
>>> 					  loop_set_fd()
>>> 					    set_blocksize()
>>>              - now __getblk_slow() indefinitely loops because B != bdev
>>>                block size
>>>
>>> Fix the problem by disallowing LOOP_SET_FD ioctl when there are
>>> exclusive openers of a loop device.
>>>
>>> [Deliberately chosen not to CC stable as a user with priviledges to
>>> trigger this race has other means of taking the system down and this
>>> has a potential of breaking some weird userspace setup]
>>>
>>> Reported-and-tested-by: syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com
>>> Signed-off-by: Jan Kara <jack@suse.cz>
>>> ---
>>>   drivers/block/loop.c | 18 +++++++++++++++++-
>>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>>
>>> Hi Jens!
>>>
>>> What do you think about this patch? It fixes the problem but it also
>>> changes user visible behavior so there are chances it breaks some
>>> existing setup (although I have hard time coming up with a realistic
>>> scenario where it would matter).
>>
>> I also have a hard time thinking about valid cases where this would be a
>> problem. I think, in the end, that fixing the issue is more important
>> than a potentially hypothetical use case.
>>
>>> Alternatively we could change getblk() code handle changing block
>>> size. That would fix the particular issue syzkaller found as well but
>>> I'm not sure what else is broken when block device changes while fs
>>> driver is working with it.
>>
>> I think your solution here is saner.
> 
> Will you pick up the patch please? I cannot find it in your tree... Thanks!

Done!

-- 
Jens Axboe

