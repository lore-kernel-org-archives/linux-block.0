Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C575CC19F2B
	for <linux-block@archiver.kernel.org>; Tue,  2 Aug 2022 22:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbiHBWYU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Aug 2022 18:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiHBWYS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Aug 2022 18:24:18 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B6F53D1A
        for <linux-block@vger.kernel.org>; Tue,  2 Aug 2022 15:24:16 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id g12so14849905pfb.3
        for <linux-block@vger.kernel.org>; Tue, 02 Aug 2022 15:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hNEYUAO92N4pCY8sKiISrxHLoe2N5y8rJIEZlA2rSfs=;
        b=AezUzRCTINyyAI+D6BuA7DrFA6e074vhOiTwM+DnFo8c9F+wss42JH+Fxpf3N9mPUb
         RtL1CMSohN3CDpGp6hPZZ+rkDQwvNGbKmzCmuVrlid0U4VlJd/sYtJ1h8pyE2+pYpH+i
         u54WxctVY1qRX3Mdj04InMhcbuTXc2yFq94u80OSqKp/xM5Xq2Lh0sKCKAr5GO8IJUwe
         3y0brH9+tSgtkjiG2/A+E33HNIrJdKss3WxXB15CwjrA53U2jka4x8KXc/YhJvVSNq0h
         +joW+IqdUAyiEjrWu4+N6NMHW3XmzGewg82anFmufLvXqg7BGzkGgHYNPcuX9llDmGtL
         d7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hNEYUAO92N4pCY8sKiISrxHLoe2N5y8rJIEZlA2rSfs=;
        b=d0a3cTFx8+TwG9ZJsFWN6VxvW/WtfJ4L45yEndRkrW5Hb+T+DXbbOUFr6MeSCwt5UG
         SvR+12zei2OcokR5HvxkHTna8y5ovmHDOgc6OEd5OyRUVuU03ckE5VmItU1p+qoGQjqG
         NVpvIT+8rkOLHUzwAPLcIaPBfsjazHSkc1ZqjIBRwtyqGw1KFCmaRTFJLpVGtP2fmOUk
         UAPgQfCPzgVLQ55Lx8zEk6yf4K/hUqVfy1PKTseYv2l440YFjXLRUbJ8kqlPDOha8aMr
         I3QtxRVAxnmDGf/lPB1kI9jrlGeZuK1sAKaBiG4hG8HcD3KYLqDsOmS01DNk2pFLaitP
         lqPA==
X-Gm-Message-State: ACgBeo2g8MctJaIL2IENFMGSYaagtfgg102RGbhkLxON7w+iRP8qH2yM
        Dq3Tr+KaH5TDAFaDHk2BRSDjrw==
X-Google-Smtp-Source: AA6agR7fpoNe1AlmQZAzmHvJHiPXg10hVWXeg8bpk5QGlrzyWOlzcnETs8uNL8Y9V83I/SYXRLpaDA==
X-Received: by 2002:a63:9142:0:b0:41b:f217:8b83 with SMTP id l63-20020a639142000000b0041bf2178b83mr11704942pge.478.1659479056144;
        Tue, 02 Aug 2022 15:24:16 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id im16-20020a170902bb1000b0016a7b9558f7sm157286plb.136.2022.08.02.15.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 15:24:15 -0700 (PDT)
Message-ID: <7d663c1a-67a2-159e-3f93-28ec18f3bd9d@kernel.dk>
Date:   Tue, 2 Aug 2022 16:24:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL] Block driver changes for 5.20-rc1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <87f60512-9242-49d1-eae1-394eb7a34760@kernel.dk>
 <CAHk-=wi+HuC_bs7VMTJSjp0vug9DRMY9+jKcsQryU9Eqofdxbg@mail.gmail.com>
 <YumYKVWYnoALoSBR@kbusch-mbp.dhcp.thefacebook.com>
 <74bb310b-b602-14eb-85f7-4b08327b0092@kernel.dk>
 <CAHk-=wgAeL8+BYsy4mnut+y7sBF_+LXmW5bjUfegBpg8SisBJQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wgAeL8+BYsy4mnut+y7sBF_+LXmW5bjUfegBpg8SisBJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/2/22 3:50 PM, Linus Torvalds wrote:
> On Tue, Aug 2, 2022 at 2:35 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>>
>> As to testing, I'm going to punt that question to Hannes and Christoph,
>> as I have no way of testing that particular NVMe feature.
> 
> I can't test the *feature* either.
> 
> But dammit, I test two very different build configurations, and both
> of them failed miserably on this file.
> 
> Don't you get it? That file DOES NOT EVEN COMPILE.
> 
> I refuse to have anything to do with a pull request that doesn't even
> pass some very fundamental build requirements for me. That implies a
> level of lack of testing that just makes me go "No way am I touching
> that tree".

I can tell you that I always compile the whole damn thing, and this one
is no exception. The tree is also in for-next and has been for a long
time, both the drivers and drivers-post branch. The build bot has also
vetted both branches, individually, not just as the merged for-next.

I take it this is only happening on clang, which is why I haven't seen
it as I don't compile with clang. We can certainly add that to the usual
pre-flight/post-merge list, but I'm a bit surprised that clang isn't
being done by the build bots too.

If you want to make a clang build a hard requirement for any pull
request, then that should be explicit and not illicit outbursts if
that's just an implied assumption that it is being done. Really.

-- 
Jens Axboe

