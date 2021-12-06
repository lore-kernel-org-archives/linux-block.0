Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C00C433EF
	for <linux-block@archiver.kernel.org>; Mon,  6 Dec 2021 16:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242063AbhLFQh0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Dec 2021 11:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349384AbhLFQh0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Dec 2021 11:37:26 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5E4C061746
        for <linux-block@vger.kernel.org>; Mon,  6 Dec 2021 08:33:57 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id s6so5333517ild.9
        for <linux-block@vger.kernel.org>; Mon, 06 Dec 2021 08:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0A+n/8oYWAVLEaX6QNHvT8JRs25q0UkHcPBeVY3Ef3M=;
        b=xq9AwavLLfVfJKTBWllxznuajFIjbap2Xzd0ClVwTDLZCEJnqaYTzOVVmeygvtgSFo
         V4EhQZqw7l1YxrK1/EysxfyNz9gBC4Ckf5SbjUI4XysB8tvCpP4qbjQnOsbMez3sCrWG
         4k+0o6abyy32x3WbsVlSb9A0GhbhwVTJenONESVi62Y8/PewTjBIypFw9HFRzudQKqId
         M9n3e2oiWHhmi9SBR4Rc7jVr4jCvPGWdVAj7sfXu/LDlXLdtZn2S8rFZadVFFWWsA+C7
         HPDY+yCL1MKTDodapGxkGJgVPVH3Y9lPJ8/bKBMuoPMPG8f1mYPViiT/lX5FgP6eJSKu
         43FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0A+n/8oYWAVLEaX6QNHvT8JRs25q0UkHcPBeVY3Ef3M=;
        b=Is4YGgNuKjTHX9jSGFOdJNpg3nDArSJ1mVwT3s359EqA+jFcpNEMfT8gCbbgKRkWUD
         CgmR6bzj4c80XFgda77sUPUi4vxVXsqN/l5R/nmz2bOU9/ZNJzZIH+mOtO+Hk4quryak
         U6T1QcofFZIMcyJ/cjIfkUkJ3PmD99fq+m6fMlUFqN9mnKXnUgO4e0uVyVe20EZZfTLp
         Hr2bN9ORHkD0wFoKBU+wDkESkvQq82SylXG4KX+POivX5A25Tg4aLxBs/KoFVkCzTvKS
         j/Buv51S2yW6+nZS/11qUqt2vSvg0mXEpSAaYmDzOuR9gnWsjBqzH7s5sxar4WO1qdPB
         oVvA==
X-Gm-Message-State: AOAM531obyVnYmwmqxTDJocce+OjpQKZboM1k/Ns8+cg44u6NjPDm2Ra
        mhYglZh+ucqzlZs61rhqgSebBJE/ODHrEAJb
X-Google-Smtp-Source: ABdhPJzVY0jOFXTRVbJa0UFmJY2n1MJYYqppN9UG2PDpUBGG9ZaDG/OV6/ctedxJbCOlHCPbB9ddpg==
X-Received: by 2002:a05:6e02:1d88:: with SMTP id h8mr35349108ila.138.1638808436771;
        Mon, 06 Dec 2021 08:33:56 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m2sm6933625iob.21.2021.12.06.08.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 08:33:56 -0800 (PST)
Subject: Re: [PATCH 2/2] block: move direct_IO into our own read_iter handler
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
References: <20211203153829.298893-1-axboe@kernel.dk>
 <20211203153829.298893-3-axboe@kernel.dk> <Ya20gsKLF4eo4X/4@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fcf79347-2d12-64e0-5607-c01d4f2fde31@kernel.dk>
Date:   Mon, 6 Dec 2021 09:33:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Ya20gsKLF4eo4X/4@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/5/21 11:58 PM, Christoph Hellwig wrote:
> On Fri, Dec 03, 2021 at 08:38:29AM -0700, Jens Axboe wrote:
>> Don't call into generic_file_read_iter() if we know it's O_DIRECT, just
>> set it up ourselves and call our own handler. This avoids an indirect call
>> for O_DIRECT.
>>
>> Fall back to filemap_read() if we fail.
> 
> Please also do it for the write side, having a partial ->direct_IO is a
> really bad idea.

Sure, I'll do the write side as well.

-- 
Jens Axboe

