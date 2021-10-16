Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F38C433F5
	for <linux-block@archiver.kernel.org>; Sat, 16 Oct 2021 14:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEA5060EE9
	for <linux-block@archiver.kernel.org>; Sat, 16 Oct 2021 14:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhJPOgF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 10:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbhJPOgB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 10:36:01 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D96C061570
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 07:33:53 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id f15so10240691ilu.7
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 07:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cPeQaqbZzw/NPmxUlFqYS+Vp17ZYtK18oFoQqeTJA3U=;
        b=tfMzBIfQAXCxphhl0qJdbSBH4c86jwhyDbGWR68ArnowAsSF5vMdq8rw+kvSbEHwDe
         unVDozs/nlPhgXXZ4jESyZkZgiEnEvifRajZa+FRxPSOmZImRb5JXcwp9w4Fs54o78cx
         g40DcZvnAUQWKEk9BFiKnhfXf16PDYM0Y/NoYGOEpemg9GT6/Q6x946miz7IaWlofrf4
         OBaaDcmnPIbVG+z1ylkg9JcjwkiQY/AhpK9jVFWpnGvppSznCbjX7w0M2IsWvbfsjqFb
         7RfJzExGREf97qCLRERlkSqy/z/WoTTZekfKxmIC+EXzamVqQgLQHV1a7XC3bK279sK+
         jviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cPeQaqbZzw/NPmxUlFqYS+Vp17ZYtK18oFoQqeTJA3U=;
        b=LN+j5SDth9dzJvllobcYPKXuOA0do9v1MNvaPg0xZTyhlOnjegN9vPejopBRWRphnk
         CpP9U6ochkJJsrFzrSsjha8kY5vAW+8egmD4zt/UgPS4vfw8jDByWoKZTnNkua2OFWXc
         IPoABNK6CM4ZTLDKZ0mhBqSY/JYDxwHz3zrK49vzqeDc23c0IazplbtAZ4DZWuH2qt7e
         dATYiqjIY08NMYBZhMY9CmBG3cFTDMKfNRr/e/oLdiJuT8SUhlvwVio3Bi4oG+qNcv/S
         0GScR3mrOrgxxx3FbymhU4fw2FLMBA18b4Bk9dZkSnjuzHv6YrBaKuSiCJt8xhCkXaiq
         v4Ow==
X-Gm-Message-State: AOAM5327QVUb+BspgAtE9FpCLCSo0UgYLT0BLTiMScgt4oWCK4WLoAOa
        pOhxyNGN6N6Z8+CImdmhHrTAHkLyucoc6A==
X-Google-Smtp-Source: ABdhPJxPi+/UiA/8bcsGV6iafokAG6ebmKkQ82gjt1jwoDAautaKJ02KSWizCTcSWrOJThflvT/yCg==
X-Received: by 2002:a05:6e02:b4f:: with SMTP id f15mr7551512ilu.183.1634394831848;
        Sat, 16 Oct 2021 07:33:51 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id u15sm149408ilv.85.2021.10.16.07.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Oct 2021 07:33:51 -0700 (PDT)
Subject: Re: [PATCH 8/9] io_uring: utilize the io_batch infrastructure for
 more efficient polled IO
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211013165416.985696-1-axboe@kernel.dk>
 <20211013165416.985696-9-axboe@kernel.dk> <YWfkVtB+pMpaG2T3@infradead.org>
 <7ed66f47-6f5a-39b2-7cd8-df7cf0952743@kernel.dk>
 <YWhWBt7kljI+BGbX@infradead.org>
 <c80263c8-f6d6-e3d9-058f-26d64c7e5acc@kernel.dk>
 <YWpVRXYGuN8mA7nH@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dc60f44f-cf20-b81b-5272-0d517868e07d@kernel.dk>
Date:   Sat, 16 Oct 2021 08:33:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWpVRXYGuN8mA7nH@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/15/21 10:29 PM, Christoph Hellwig wrote:
> On Thu, Oct 14, 2021 at 12:14:19PM -0600, Jens Axboe wrote:
>>> Either way this should be commented as right now it looks pretty
>>> arbitrary.
>>
>> I got rid of this and added a dev_id kind of cookie that gets matched
>> on batched addition.
> 
> Thinking about this a bit more.  I don't think we need to differenciate
> devices, just complete handlers.  That is everything using the same
> ->complete_batch handler could go onto the same list.  Which means
> different nvme devices can be polled together.  So I think we can
> just check the complete/complete_batch handler and be done with it.
> The big benefit besides saving a field is that this is pretty much
> self-explaining.

Good idea, cleaner than a dev_id cookie too. I'll be sending out the
revised series soonish, but I incorporated that change.

-- 
Jens Axboe

