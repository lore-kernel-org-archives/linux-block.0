Return-Path: <SRS0=S7xR=XV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6648C47E48
	for <linux-block@archiver.kernel.org>; Thu, 26 Sep 2019 09:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4BD2053B
	for <linux-block@archiver.kernel.org>; Thu, 26 Sep 2019 09:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pr38dFCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfIZJ4e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:56:34 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:44930 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfIZJ4e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Sep 2019 05:56:34 -0400
Received: by mail-wr1-f53.google.com with SMTP id i18so1670401wru.11
        for <linux-block@vger.kernel.org>; Thu, 26 Sep 2019 02:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NlkCdkYLYBl+V4BvoMR13p0f1FLvtBmZG+HZB0KZ5U8=;
        b=pr38dFChJ7xwA2a6C9o4qVwmjfhPb1k812KgLstdGSVS9FFPygT7/MfveuO33kz9Hz
         1fzNLsyzPXlda0tm4Bnrd1IXFLsLQSCnZIxOaEdzYSUlR79hiXTol9kvnPwNoGRE3uzV
         TGDmcp6hQbgRqX/5LpuuasGLu6H4HvnczCHkdGszujGo333A4wxgWCawqm9fcX6TlXcx
         5BIUCVB2TVUYMridf4NU46JgU8ZXTnoZ6VX7hGX1GdMKa+djmP+2rawMzpNWCVTr3n2L
         C5G+ET1FbcNCmH8AJVZyiB1BEgVOwaUwrM7rkPIORgnmJr9GyTIiABrQ8AAr79re6/oI
         bssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NlkCdkYLYBl+V4BvoMR13p0f1FLvtBmZG+HZB0KZ5U8=;
        b=QO7ZxcqOkW2HC87pq6QnwOpAvTKIIZ4Cup4jPsv6fx8zTiSYMAl0jk9HwtR92FW7yz
         VqAv2NHaDL3/M1xY5HORCFRBVAL8rwObsF38uJM2DsfBtdJ9BeSNGZI6yxQfmNR7NBR/
         nOjfHrWbVYOWiFpBjN8PLFzRobzHwHR093nkW81Kx79YqW+ItyhcKMtOpRuQDNzIyyvN
         jF9eGxgiJyqZkrClJZMteE0CMHT5leTJA1Y08e0zCWSIJbefzOcJNXmB7dE9BP6/rSy6
         xrt/r1pu/NjpfBmBtAHso40Drqs2zxa5yTV+MZBaZZQwtAIZGE52aH5/vHjictOeZn89
         d6oQ==
X-Gm-Message-State: APjAAAVT+eF76TuDRxgfiCAL/Ab6/rMHQr2sQbH+6sNfcoV/GnCr6Wfu
        RzYTd7ph8fGh5T1fxKLxCf7KuQ==
X-Google-Smtp-Source: APXvYqzVa3ZvYbsWCQUozmOJ+3w5ZbZpyvYMC9oEdXrxIBNKEFzLtY0AvOnHWQcLiFYhQZX+3BIu/A==
X-Received: by 2002:a5d:4251:: with SMTP id s17mr2336613wrr.126.1569491791600;
        Thu, 26 Sep 2019 02:56:31 -0700 (PDT)
Received: from [192.168.1.145] ([65.39.69.237])
        by smtp.gmail.com with ESMTPSA id z12sm2645832wmf.27.2019.09.26.02.56.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 02:56:30 -0700 (PDT)
Subject: Re: [PATCH][next] io_uring: ensure variable ret is initialized to
 zero
To:     Colin King <colin.king@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190926095012.31826-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3aa821ea-3041-fb56-2458-ec643963c511@kernel.dk>
Date:   Thu, 26 Sep 2019 11:56:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190926095012.31826-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/26/19 11:50 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the case where sig is NULL the error variable ret is not initialized
> and may contain a garbage value on the final checks to see if ret is
> -ERESTARTSYS.  Best to initialize ret to zero before the do loop to
> ensure the ret does not accidentially contain -ERESTARTSYS before the
> loop.

Oops, weird it didn't complain. I've folded in this fix, as that commit
isn't upstream yet. Thanks!

-- 
Jens Axboe

