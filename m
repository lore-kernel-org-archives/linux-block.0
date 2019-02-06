Return-Path: <SRS0=fg2o=QN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB46C282C2
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 19:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AD0217F9
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 19:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="t3T9kqXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfBFT7P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:59:15 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35688 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfBFT7P (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Feb 2019 14:59:15 -0500
Received: by mail-pl1-f196.google.com with SMTP id p8so3591863plo.2
        for <linux-block@vger.kernel.org>; Wed, 06 Feb 2019 11:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nZ5R1ygRWFZWDJbkdVi9ouxz2H+F674HSxOqdEq9tHA=;
        b=t3T9kqXEyMj1cjtgEoTbVgdalusOftwAUR9U/Z1SlB8+/0yb2R1x1jPrY3LUy9XtEh
         BUbRaccnfGeL7/0ujafJO4zX/84X2CrhmPdEqwBsQkphL/ckMYdyJrLNhr9xYQ8LXkhU
         Pm5y8Su5/XaEiXDrkWAGNeGlia6Hjs3sSvsOO53JHRLf7r9Nv6gWkvCMjWvpc8VmXFhb
         Ti11eyKmJecsI/GeDBh9AB/h9EqFh6igtkU3F5reC8AqJzKUtQIGjpj9UzNSOxrCXMk2
         /uN4IHvdFz0FuJVQz0A0F37H2majIe7AcxHeFmdKNu0gepoa5JePj1gwRX0UP9lT13gR
         NT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nZ5R1ygRWFZWDJbkdVi9ouxz2H+F674HSxOqdEq9tHA=;
        b=GUry5kKe8B241XiIeGdj+72CIXrJcAjzsc2uhZWBHiVGyXG83R1mzmi/hAQy7lGDuC
         khHi1E+RboOhm1VUIPlmT0YSM3q8RvRxWrTPlAWarmWQthT6j6SoA1UnYBXLBaLpAHsB
         hoU7dy9VSTbORdQPBQbXD+UlCW4nZ3LNxTWxHOjiK71Cy8HFtG5FJN5Cfi6YKxqzi9S2
         LsLWiRECHFDjpFA5TZpGxM1qKIQCNbINPDT2wIH59xL7fb7p0iXOi2EB+FendJo1RL1a
         qy+dtizo3NRxFEPHlr68VP4UpwaSL61pg8MtM+f3mO+WyV/3cVpduuXNgRDgPzzW8rsm
         RtBA==
X-Gm-Message-State: AHQUAuaKbbafPFmbaqD/ChUlKTIA0Hi0+Hjh9ucM4Rdq2TaU6/MWNYyt
        0acj9GpoKKSrwkTn6eHNtwq0ug==
X-Google-Smtp-Source: AHgI3IbLvjHmhlf2JiNaA17oAayPE21ZiwEI0y5oFA9+VqmRxL+z169kh9pSv3wV1L9dW6ogITo8xg==
X-Received: by 2002:a17:902:8d8e:: with SMTP id v14mr12359598plo.133.1549483154357;
        Wed, 06 Feb 2019 11:59:14 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id y9sm9885266pfi.74.2019.02.06.11.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 11:59:12 -0800 (PST)
Subject: Re: [PATCH v3] fs: ratelimit __find_get_block_slow() failure message.
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>, Jan Kara <jack@suse.cz>
References: <1548078577-10353-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c64d6020-4779-6938-5d9f-ca67b0644ce5@kernel.dk>
Date:   Wed, 6 Feb 2019 12:59:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548078577-10353-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/21/19 6:49 AM, Tetsuo Handa wrote:
> When something let __find_get_block_slow() hit all_mapped path, it calls
> printk() for 100+ times per a second. But there is no need to print same
> message with such high frequency; it is just asking for stall warning, or
> at least bloating log files.
> 
>   [  399.866302][T15342] __find_get_block_slow() failed. block=1, b_blocknr=8
>   [  399.873324][T15342] b_state=0x00000029, b_size=512
>   [  399.878403][T15342] device loop0 blocksize: 4096
>   [  399.883296][T15342] __find_get_block_slow() failed. block=1, b_blocknr=8
>   [  399.890400][T15342] b_state=0x00000029, b_size=512
>   [  399.895595][T15342] device loop0 blocksize: 4096
>   [  399.900556][T15342] __find_get_block_slow() failed. block=1, b_blocknr=8
>   [  399.907471][T15342] b_state=0x00000029, b_size=512
>   [  399.912506][T15342] device loop0 blocksize: 4096
> 
> This patch reduces frequency to up to once per a second, in addition to
> concatenating three lines into one.

Applied, thanks.

-- 
Jens Axboe

