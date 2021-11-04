Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF38C433F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 11:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3267661205
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 11:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhKDLuj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 07:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhKDLuj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 07:50:39 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C27C061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 04:48:01 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id h23so5853046ila.4
        for <linux-block@vger.kernel.org>; Thu, 04 Nov 2021 04:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=6D3m9hQhNNh+DZHHgxABmmHrUdrpBzDR9m4z6btvJn8=;
        b=u72XzcTo1iHYWegAvG5kb6z3AlWGF4EidMa7H29qkx3j8Z0CY5TDK9Y2Z0nYglB3bq
         VqGiyh25NZYUiFonr0sz0xKZM6Vwhiesalx5zB/IocigCdyDzoAYaKnwosrZjXBJgQus
         slHxCJcJ+fUBUvPZ7UsT/ImxtyHXvUwWf6Rtkz2zyAIaImnbS3rL3OEp+WauZxKTCemI
         G8dI28Ibsb7tMQW736cZMvsfYqP9Ii7dIzO+w7KvLlc4kc7kYbm15gD8XYFvCNTglYm0
         kAnMQNWD1OgqrkiZyap6Py108mCdlJOFCuiPeuMfBY5ISmTVR5EHHaRc213LyJ3Hp8r6
         NMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=6D3m9hQhNNh+DZHHgxABmmHrUdrpBzDR9m4z6btvJn8=;
        b=xp2CkbH2ZXn/dDB0L4F7d0lMheFtT+iowqTk80sACt82dGgrwUjR7VvvSwAMF7Ah/e
         t6nNsTEVzRWO+yn4/SOTBNXFAxakAuI3BfvUN1z4UI24/IH6vFecpW4cbVF40WKuylfm
         VrdFaQk5H7KxrItBGNxvwn+eQwRy8iDFE3Fw7Nq0R+XYEZdLlPKfK5TM/EC7IWOsAyi/
         sChShox2ZcHOEpiLmjCCryu7dbarjpfpv0brzVUhSg4gcaR9hq7Km6QGZwDi+MInL44s
         gTi55E+23eRWWXPJKJYR63pFguSSnP3llznWnGBBXhUHwzKq4j7+Ke3McLxXmNpePRA7
         qN7Q==
X-Gm-Message-State: AOAM531mPXLuqF8SU3fkKDqZg5nvX1SuzSzdZrWgfF2aYqgYwXgdMF3A
        LYQYbccpXoIoQFE70q6jY1yLMA==
X-Google-Smtp-Source: ABdhPJy7Zmu2d6IZ0R7M8bvqWAFB9W+c0CYjm/WLg6noYRR9Dou9Q/ObWBWx2pxv11nxx164VHV8dQ==
X-Received: by 2002:a05:6e02:2143:: with SMTP id d3mr18231797ilv.241.1636026481070;
        Thu, 04 Nov 2021 04:48:01 -0700 (PDT)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id d10sm2706869iog.25.2021.11.04.04.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 04:48:00 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     cgel.zte@gmail.com
Cc:     luo penghao <luo.penghao@zte.com.cn>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
In-Reply-To: <20211104064546.3074-1-luo.penghao@zte.com.cn>
References: <20211104064546.3074-1-luo.penghao@zte.com.cn>
Subject: Re: [PATCH v2] loop: Remove duplicate assignments
Message-Id: <163602648043.21894.10954316557172380359.b4-ty@kernel.dk>
Date:   Thu, 04 Nov 2021 05:48:00 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 4 Nov 2021 06:45:46 +0000, cgel.zte@gmail.com wrote:
> From: luo penghao <luo.penghao@zte.com.cn>
> 
> The assignment and operation there will be overwritten later, so
> it should be deleted.
> 
> The clang_analyzer complains as follows:
> 
> [...]

Applied, thanks!

[1/1] loop: Remove duplicate assignments
      commit: 18c6c96897a3b1ba44ab4df7324bf0b3454e090b

Best regards,
-- 
Jens Axboe


