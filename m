Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A45C00140
	for <linux-block@archiver.kernel.org>; Tue,  2 Aug 2022 21:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237078AbiHBVfc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Aug 2022 17:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237095AbiHBVf3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Aug 2022 17:35:29 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D02C6E
        for <linux-block@vger.kernel.org>; Tue,  2 Aug 2022 14:35:25 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so32021pjk.1
        for <linux-block@vger.kernel.org>; Tue, 02 Aug 2022 14:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PoX03oehMF0wnIzpJ56w6X5VtY/GoJG/jShcdA8YAPo=;
        b=P0UzIpn3zjmt9p4g4+B/B34Iappn+VfZawrf1uYR8r0mTT/FcJ+pX8SeewPebSZnZm
         xzMlJsM2DYb0LrEpSUeXD0ZRzUHZZuHx0cF0MwjmJtn2cJx0g/ogwz900nzHvEVzZSBP
         EY+VoeE+awzFGLLrGtraCES3TQb7yQZgYL6ofnSJEbtxndumJF9hUYpdGIFwm4f/kXqf
         Hvswj/RYDGby4GvyW0NfGTy1JU3Qhwqvtzp81HjrseyN+UmSVg5d6w8f3kurVw03mt8T
         782breFZlurcjz4a0Q8ZaW+ImV0iVvmpZyXtAMtf+Lksg0krllDcAxHYG9SL6Yz8me+d
         eadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PoX03oehMF0wnIzpJ56w6X5VtY/GoJG/jShcdA8YAPo=;
        b=N93bPQdleGPpj50BtUUqFwrIOnQM59dy4fyBM0bPkX1gcBtR8Y6owFNOnHCRpvc1dd
         6n7gSYemlCox3GgUq5UoEBK8hIhOsWkXo4Y/y8yG7qrvIrcS6wOazUIz8Gpo2EA9mco1
         kayMlT9Dc5sqFJAYeQ3HmIX2z6EyU5jzgg3708SVL8fGPzot+tYMkFbDPjRLc6zaoYn0
         YAyw0TLOPk0sPi7MqZH8q/hnE9pUjwcZbmWXW/pyE9vjeU8pzKNF/ylLiK4HuovuW9Gb
         LxsIWaG2EOtssJOmsbhpPrYikpjwVh0JtHxsgIA5QH8FsJbe7i00A08IgiGWbpQKpK4l
         sl1A==
X-Gm-Message-State: ACgBeo0IVsU1dWcPUIXvbua0d0eyxZMdD/1SV1p3ZwsAIUUKsXkFdDj9
        wgjcFFURN0XfLsNrU11ZpY7fZw==
X-Google-Smtp-Source: AA6agR4s0g1A/0Jk1uu71nR9UoYb85umEy5rgcJP3/U36OClCxq5Zp4SscxJi03uyjDYdgECNAkF9g==
X-Received: by 2002:a17:903:1ce:b0:16e:f510:6666 with SMTP id e14-20020a17090301ce00b0016ef5106666mr9456495plh.158.1659476124883;
        Tue, 02 Aug 2022 14:35:24 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902654e00b0016dcc381bbasm159545pln.144.2022.08.02.14.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 14:35:24 -0700 (PDT)
Message-ID: <74bb310b-b602-14eb-85f7-4b08327b0092@kernel.dk>
Date:   Tue, 2 Aug 2022 15:35:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL] Block driver changes for 5.20-rc1
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <87f60512-9242-49d1-eae1-394eb7a34760@kernel.dk>
 <CAHk-=wi+HuC_bs7VMTJSjp0vug9DRMY9+jKcsQryU9Eqofdxbg@mail.gmail.com>
 <YumYKVWYnoALoSBR@kbusch-mbp.dhcp.thefacebook.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YumYKVWYnoALoSBR@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/2/22 3:33 PM, Keith Busch wrote:
> On Tue, Aug 02, 2022 at 02:18:57PM -0700, Linus Torvalds wrote:
>> And no, I don't want some "fix up broken code after the fact" commit
>> on top. I want that code excised, and I don't want to see another pull
>> request before it's (a) gone and (b) somebody has looked at where the
>> testing of this COMPLETELY failed.
> 
> This issue was fixed more than 2 weeks ago, but wasn't included in this pull
> request. It's in the current block drivers-post tree, though:
> 
>   https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.20/drivers-post&id=4dfbd5418763018f33acded0871fbbc22c8e4695
> 
> Do you want us to rebase the nvme pull request with the above squashed
> into the original commit instead?

I can just rebase drivers and drivers-post into one now that the core
bits are in. It was a bit of a pain since later driver changes ended up
needing more core changes (and has made me re-think the split approach,
I want to make this one block branch going forward since this isn't the
first time).

But if I just rebase drivers + drivers-post into one branch, then I can
squash the commit.

As to testing, I'm going to punt that question to Hannes and Christoph,
as I have no way of testing that particular NVMe feature.

-- 
Jens Axboe

