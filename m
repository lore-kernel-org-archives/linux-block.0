Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F684CA9EBD
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 15:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79BF21D71
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 15:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0dJBpJic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407863AbfJYPBk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 11:01:40 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:34817 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409463AbfJYPBj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 11:01:39 -0400
Received: by mail-il1-f196.google.com with SMTP id p8so2129887ilp.2
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 08:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7GmtzZy7croPEQDptRcTsxKybbnF94HZTydxe9zCc/k=;
        b=0dJBpJic3MXgTSdJXNYetPcb4q4ONYJKfPNQJoRzstIdGh4T9JwqtSh69qPj8r1Ubx
         gZRwFpyritBdDGVxrYI/jhtkM4PkUXE3vq6P8GhebJnJpWTtf6bWXOMGB1wJKj1D3d13
         XeuWZPfJGgQq8l3dH9OdfzIiet35lkNULVAYJL/OoXZX1DcBaINdR+wgTxMvjWdrVST2
         Mth2O2/Rz2W7OiW2siRZrqhaZYbmVtfSYaD1//OJJma1IGs6qO+Thpc0XSE/Pg6cfti7
         pGY0HlW93NGC+qBm30QJmW4ZFOVNvGQLpHbYUG5XuvoOMH8JRzO51kBERmObgyy0nfLF
         mSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7GmtzZy7croPEQDptRcTsxKybbnF94HZTydxe9zCc/k=;
        b=BCQA4MjDAx4Vy4jcxfXpCwBtq3bSnLXeLjRDX3q3Uz8pNXifsZfLikE180dA1NW10a
         DcWpM2hQQUDVCVpbyFmGR/CmIYaVKVxwWUGXjPP7eDzB2HozG2HFqhXd5pnyHXSWz7Q1
         Obn+xQS9qvc5DrGVGM+5e2EcGDI/DqHKmruitm4bApqhNlH3Gfmi5rGZeuSdhAImoz8A
         0l/f2H6QXdLL/sVOTwaqbpR7zPkoai82aS/tZZtVtJbDzO1zeSjmBSF4u1g5UnXTBS+G
         O+ZWoQN0pLoJb6ba95D6flsEwph6j/wTdzp3s3WjWszto5J5cs+LyMBI/lAjyj+6oMMK
         uZDA==
X-Gm-Message-State: APjAAAWLJgA9Z6dzhfDDgBqteywhUCVzkrgh367LmPa2fARGd9VEOcFr
        1TaP++/16d8mF6Lfp/hGgLsy+g==
X-Google-Smtp-Source: APXvYqzlQ4CvNTlup/i4cwSXZVQKIgsf3HZXSuj/3e5HVWCQfg/08jMlWPGiL0FlU64xPBCkwfEk+A==
X-Received: by 2002:a92:8dd9:: with SMTP id w86mr4360524ill.277.1572015697073;
        Fri, 25 Oct 2019 08:01:37 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q17sm265612iob.20.2019.10.25.08.01.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 08:01:35 -0700 (PDT)
Subject: Re: [PATCH 0/3][for-linus] Fix bunch of bugs in io_uring
To:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1571991701.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b095f79a-9699-fcc2-83d3-434febcaaf14@kernel.dk>
Date:   Fri, 25 Oct 2019 09:01:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cover.1571991701.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/25/19 3:31 AM, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> The issues are mostly unrelated. The fixes are done with simplicity
> and easiness to merge in mind. It may introduce a slight performance
> regression, which I intend to address in following patches for-next.
> 
> Pavel Begunkov (3):
>    io_uring: Fix corrupted user_data
>    io_uring: Fix broken links with offloading
>    io_uring: Fix race for sqes with userspace
> 
>   fs/io_uring.c | 67 ++++++++++++++++++++++++++++-----------------------
>   1 file changed, 37 insertions(+), 30 deletions(-)

These all look good, I'll apply them for 5.4. Thanks!

-- 
Jens Axboe

