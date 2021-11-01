Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96C9C433EF
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 23:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2BF46052B
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 23:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbhKAXWe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Nov 2021 19:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhKAXWe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Nov 2021 19:22:34 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66383C061714
        for <linux-block@vger.kernel.org>; Mon,  1 Nov 2021 16:20:00 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id w15so14033542ill.2
        for <linux-block@vger.kernel.org>; Mon, 01 Nov 2021 16:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4WMoSsL6c+ht+6bOeZ3XujyCedYvyb+inQni1z9nhVs=;
        b=jlckLYcOGD5VFVe5wGVWoIQ01u/eAgKr/XAPN1dcQaMMex+N2+qjoChZzfVzALq187
         snj84esaF4SYTQ7wyqU8mx9LCVDdOyOy/qg2frbVlswQ3RWxqCM3ABkgxdxOppzWEr+h
         eaLX655ftuJpSBg73E0ZPGscTeHsRQCmE9N4m/uFlvefVH7UNs9HETt7qsKg9hSzBOu+
         uTMFBbzQrGjJ74505oR8jAKfWTEjMg1uNrmDAsByLBj5Rb73ssXwodxS3KAwfNm5CTPJ
         ybP0rBHEcDfkvR8fGZUFrDOS7E0sxKbhqmr26UNfi7tAOFcTlb+ZcsSWtJoM4b7NocSt
         +yCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4WMoSsL6c+ht+6bOeZ3XujyCedYvyb+inQni1z9nhVs=;
        b=nC08yN/09cJdza8J4uNlStHA2A7xzW+4RsCJg9RLQko3SrgLjw9nWipglP0t5pLN3z
         zle0yFCE1w02k3asmFlXieqjxTq7WweewhviCGLxDX2eoiDucHBzN1nbOJo/UIm6micl
         7+9CrpAZhNopUIhPFasgByoFdg6IaPnuOLigHloXe3f5+vTqiO3rirJiIkdFjRMSXmdI
         6roY5WctL0aZYSRGByFrM7+v1KxHv/Mh0hgUDyX2ZGWZp95pI+RX2Tn9ZWiLbTTBwJCc
         7pMUbyEot0OoRufV4LHAtrHCIZd2eigRi7Z/vNF23a+sTCjtkgGVS24I6P/ussSuXLTA
         wHHQ==
X-Gm-Message-State: AOAM532enCZj489TMGatcPXwpPos0zCGXG4NklcFZdllLCR+I7lkajEA
        YpXd5PxxLcRYMOQM0qV1Vt14vkiy7ptCuQ==
X-Google-Smtp-Source: ABdhPJzVk67IThQoK7lekLOO9SusKYVOUCmZhqPdM+c6DH4I/tE9xtii3xJaJf5/ca18pfJomja+4A==
X-Received: by 2002:a92:d5c5:: with SMTP id d5mr20257745ilq.307.1635808799705;
        Mon, 01 Nov 2021 16:19:59 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id k8sm2968083ilu.23.2021.11.01.16.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 16:19:59 -0700 (PDT)
Subject: Re: [GIT PULL] bdev size cleanups
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <f870c029-140d-3e77-dcd1-1890025b5795@kernel.dk>
 <CAHk-=wii3c_VebHJxEyqU5P6FKjOLirYHQm+0=oaL59DNi-t1A@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <71c40f9b-7f83-be81-18cf-297077db005c@kernel.dk>
Date:   Mon, 1 Nov 2021 17:19:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wii3c_VebHJxEyqU5P6FKjOLirYHQm+0=oaL59DNi-t1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/1/21 11:02 AM, Linus Torvalds wrote:
> On Sun, Oct 31, 2021 at 12:41 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On top of the core block branch, this topic branch cleans up the bdev
>> size handling.
> 
> So on the whole this seems to be a good cleanup, but some of it worries me.
> 
> For example, it seems to have lost the cast to "loff_t" when
> generating the byte size from a "sector_t".
> 
> Ok, so these days those are both 64-bit, and it doesn't actually
> matter (the time when we had a 32-bit sector_t as an option are long
> gone), but I think that bdev_nr_bytes() helper really ends up being
> subtler than it looks. It very much depends on 'sector_t' and 'loff_t'
> being the same size (although sector_t is an u64, loff_t ends up being
> the signed version).
> 
> I've pulled this, but I do think it might have been better with the
> type conversion being explicit. One of the reasons we had "sector_t"
> originally was that it ended up being configuration-dependent, and
> could be 32-bit. Those times may be gone, but it's still conceptually
> a very different type from "loff_t".

Yes, probably safer just to make bdev_nr_bytes() return sector_t as
well, even if loff_t isn't strictly wrong. Christoph, want to do a
followup?

-- 
Jens Axboe

