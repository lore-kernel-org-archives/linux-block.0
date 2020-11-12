Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C090BC2D0A3
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 15:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6692722227
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 15:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QQbc2H3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgKLP7T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Nov 2020 10:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbgKLP7Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Nov 2020 10:59:16 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4364C0613D1
        for <linux-block@vger.kernel.org>; Thu, 12 Nov 2020 07:59:16 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id n129so6537048iod.5
        for <linux-block@vger.kernel.org>; Thu, 12 Nov 2020 07:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bpYaD/RKbCzyAbZxAQjufdftApCsyZEN40qiWlLJNUs=;
        b=QQbc2H3KSmRoCsrBq94OMdgtpj47aWHGw1yU5pktsESh+sw194Y0rinwlIOiK3wtY0
         P7O6OXFkVSk+Xk++dHipIVV97+tt54F0odH5G2u0uAJRyqEW59pt7pAVqldIZKuXEF2R
         FdUTIE26SN1wFiEmLMyo0bRBG8nqNzvZAcD7qxf7b1eejx0qjJKs/L6oWICCOf3NvD5r
         Wh8RLbvYmyLhJEDl491whZdUgXnNJ2ea6HFQeFf8WKt7FnMbCMPwpl42z29Syn5d/rAo
         jREjO6Sb3BDtmyD4Bg7A9mVZJs89swCcLFRrbRnbA68L2YDxSnI+1rTZMQgqEG7ZMXcM
         usGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bpYaD/RKbCzyAbZxAQjufdftApCsyZEN40qiWlLJNUs=;
        b=Ku4IxgSvw5tkwBrHSO68SY9XwxNytsaz07Bkau8FGivQRvqnXMus63wxpOjYZ4Ylhw
         uVpDmoeHYK7n+rikNHQ3ePwZfzXoUmNFu2nY9bEHskr9H8qQ8pZhOrwD/RLpD4WulW97
         5SSVHIrJ2D4c1/O+MrpQb+EfxwGbYdBPNGMfivo9GGSIq8eIstAGchBdzTebCVZBWVzE
         XigniovV3jiCXreSPJl+iuVrlw8iJDEFnZZcmL3UFkxNdKW3Mrj55eaXnFFfKPv258UE
         MY3olT2HLdiLjd7sSWbd5hs52uk2lckOSqu4gEwYFb51P7Oyz/HFefKQJSMmddT0PNa+
         yweg==
X-Gm-Message-State: AOAM532JzUSJZ/qKaeoztsp7+Fxax/ezMoLxOZuUG1ysRQbPoCpbh45d
        JWfz+uwOLtfyp+AI2XNy7s2cdg==
X-Google-Smtp-Source: ABdhPJwtjlLhAJTcQqOcZurQtr63fOLOH6itk4jvtBKj/IRUZVFpUQNLe/UN18rZHHFJfn+h5p4mkA==
X-Received: by 2002:a02:208:: with SMTP id 8mr254570jau.79.1605196756037;
        Thu, 12 Nov 2020 07:59:16 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w12sm3138231ilo.63.2020.11.12.07.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 07:59:15 -0800 (PST)
Subject: Re: [PATCH 1/1] loop: Fix occasional uevent drop
To:     Christoph Hellwig <hch@lst.de>, Petr Vorel <pvorel@suse.cz>
Cc:     linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Martijn Coenen <maco@android.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>, ltp@lists.linux.it
References: <20201111180846.21515-1-pvorel@suse.cz>
 <20201112144307.GA8377@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9276a97c-3b71-ddb4-d027-6b184c8d86fa@kernel.dk>
Date:   Thu, 12 Nov 2020 08:59:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201112144307.GA8377@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/12/20 7:43 AM, Christoph Hellwig wrote:
> On Wed, Nov 11, 2020 at 07:08:46PM +0100, Petr Vorel wrote:
>> 716ad0986cbd caused to occasional drop of loop device uevent, which was
>> no longer triggered in loop_set_size() but in a different part of code.
>>
>> Bug is reproducible with LTP test uevent01 [1]:
>>
>> i=0; while true; do
>>     i=$((i+1)); echo "== $i =="
>>     lsmod |grep -q loop && rmmod -f loop
>>     ./uevent01 || break
>> done
>>
>> Put back triggering through code called in loop_set_size().
>>
>> Fix required to add yet another parameter to
>> set_capacity_revalidate_and_notify().
> 
> I don't like where this is heading, especially as I've rewritten the whole
> area pending inclusion for 5.11. I think the you want something like what
> I did in this three commits with a loop commit equivalent to the last
> commit for nbd:
> 
> http://git.infradead.org/users/hch/block.git/commitdiff/89348f9f510d77d0bf69994f096eb6b71199e0f4
> 
> http://git.infradead.org/users/hch/block.git/commitdiff/89348f9f510d77d0bf69994f096eb6b71199e0f4
> 
> Jens, maybe I should rebase things so that a version of that first
> commit can go into 5.10 and stable?

That's fine, already wasn't a huge fan of pulling in block-5.10. So let's
plan on fixing this for -rc4, and I'll rebase the 5.11 branches on top of
that.

-- 
Jens Axboe

