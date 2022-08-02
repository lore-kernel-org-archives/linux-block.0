Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61937C00140
	for <linux-block@archiver.kernel.org>; Tue,  2 Aug 2022 22:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbiHBW0q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Aug 2022 18:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbiHBW0p (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Aug 2022 18:26:45 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CBE49B50
        for <linux-block@vger.kernel.org>; Tue,  2 Aug 2022 15:26:44 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id f11-20020a17090a4a8b00b001f2f7e32d03so2427774pjh.0
        for <linux-block@vger.kernel.org>; Tue, 02 Aug 2022 15:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=DA5SbbBLsx6OBeAEGGLih1rBV5Xosevbs/SM7d9HOpA=;
        b=x8tx5qso7pGGcsWKm04AKxApNdzM+kjh1wFYyEr6HQUz/UKW2EBV9L5/hdKkx2sT+R
         Kh9+SCvio1Wpbl0pxl2VvrIX0Kpeurejx6OYQRobuQ5aNkelj/qF/EektF92shAoKRjT
         L2JA5Vtp43/bDe4W6OG/WrSSVd28qM0HGPdMMx5vtKXUir82MCZCe+1VnyauVaArboyb
         i19F66WVxqjiJJPsHmL3qzUzkzeXtyA+rzPoKg8XLBP6U2cSjPIcgM38noC4e6AfSI6b
         SfRO5+VLrzblXjq4p/t0+Kiv3RbahbI5WVIQ+0v9e0RMpdPwrRLlxTVFiC4jzDrDHAKj
         coZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=DA5SbbBLsx6OBeAEGGLih1rBV5Xosevbs/SM7d9HOpA=;
        b=5OMl30bEeX7iIZz1M/kgOWx8/lrcqpar0c77HCwv52YaBuE4h8aGtmWzk9IG0qd5Zv
         iq9YAAIlecoTyA8okSInc7G2e1z+7HS023/PDG6CmAjSHlaxjUBlg2Dw2HSi1A9qQC2E
         Y+21zrR8QYXcf973vSlU1O9E5QSbdLSLZjXB7e8j0WUTbyPhfSNbv/A0kyIfZmqX+K3u
         Zn8CNIFi+DRHcSIfILghlXW0DjeAjxohdvbQOp36aQxwVfG1fUiKviEcbdCg8XYYx4IN
         epZ7O0qqlxSfgAh/zZPPuaNDSbryNd80ZzZiuJQPoFAoul38OQlV1KAnlLlV9QMywEW8
         Jirw==
X-Gm-Message-State: ACgBeo2FRswWEtl4lb8gb9tEQbEsebsEdt0UKYyUHSh9HdNWH1XMYsQ8
        bHfIrtMj8pWpEGjy6C1aL3zS0g==
X-Google-Smtp-Source: AA6agR7DNzLX6nHvGtX1oCvalPCFgu/KCl0h6odE6OscAzKgLIwKrR5K/a3H142CdvpT4hiiEgb4dA==
X-Received: by 2002:a17:902:dac7:b0:16e:fc21:4e17 with SMTP id q7-20020a170902dac700b0016efc214e17mr7837350plx.168.1659479203579;
        Tue, 02 Aug 2022 15:26:43 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l3-20020a170902f68300b0016d5b7fb02esm211162plg.60.2022.08.02.15.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 15:26:43 -0700 (PDT)
Message-ID: <355a62e0-3bd1-9ce1-4737-c915ee79d6b5@kernel.dk>
Date:   Tue, 2 Aug 2022 16:26:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL] Block driver changes for 5.20-rc1
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
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
 <7d663c1a-67a2-159e-3f93-28ec18f3bd9d@kernel.dk>
In-Reply-To: <7d663c1a-67a2-159e-3f93-28ec18f3bd9d@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/2/22 4:24 PM, Jens Axboe wrote:
> On 8/2/22 3:50 PM, Linus Torvalds wrote:
>> On Tue, Aug 2, 2022 at 2:35 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>>
>>> As to testing, I'm going to punt that question to Hannes and Christoph,
>>> as I have no way of testing that particular NVMe feature.
>>
>> I can't test the *feature* either.
>>
>> But dammit, I test two very different build configurations, and both
>> of them failed miserably on this file.
>>
>> Don't you get it? That file DOES NOT EVEN COMPILE.
>>
>> I refuse to have anything to do with a pull request that doesn't even
>> pass some very fundamental build requirements for me. That implies a
>> level of lack of testing that just makes me go "No way am I touching
>> that tree".
> 
> I can tell you that I always compile the whole damn thing, and this one
> is no exception. The tree is also in for-next and has been for a long
> time, both the drivers and drivers-post branch. The build bot has also
> vetted both branches, individually, not just as the merged for-next.
> 
> I take it this is only happening on clang, which is why I haven't seen
> it as I don't compile with clang. We can certainly add that to the usual
> pre-flight/post-merge list, but I'm a bit surprised that clang isn't
> being done by the build bots too.

Side note - it is possible this all happened on the nvme branch
side and hence I didn't see it.

In any case, I've got the branch prepared and we'll send it out
later this merge window when it's all vetted.

-- 
Jens Axboe

