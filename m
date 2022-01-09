Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92273C433F5
	for <linux-block@archiver.kernel.org>; Sun,  9 Jan 2022 17:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiAIRhT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Jan 2022 12:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiAIRhS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Jan 2022 12:37:18 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8324C06173F
        for <linux-block@vger.kernel.org>; Sun,  9 Jan 2022 09:37:18 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id v18so9370031ilm.11
        for <linux-block@vger.kernel.org>; Sun, 09 Jan 2022 09:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=bODOj2iY3281uNiwPt+MJVU4a89V+UJ+UJjJJrO9Fss=;
        b=2jUIhvux0YeD6RwsfY9TYfiTTCrZC/XkWBXPY6d4SSwtcWoudBsnmtW77Zo8j81Byv
         M8XhUvHBQ7mEe4C1J8+ZKq2ow/tSXRsPgmfb0WHkksx8+YMZv4kbgmE/WreyNqdwf9W3
         EzYpWN+PCl1usIO0RX5fwDQvohttuTUKY+9yq0t/D5s2zpzPtuW5sjnxiVS7SGkJR+5x
         RqPS7AjuNrbPc+U0kMY6YmLxfNRoiFD/0CSFoU6wE9JBOFgemm9JAUwJa0m5bUgocD98
         Nr6iwQs1GxG2+Bc0U3Yb0iycZ7stWNSSNHcTZfZ7XF4wal6YY29N2gQkIVKGyMCMiqhV
         q8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=bODOj2iY3281uNiwPt+MJVU4a89V+UJ+UJjJJrO9Fss=;
        b=h9oCwOsSpzDr1K8GWwlRda6lXUOQd/DXdJMt0GF17pT61MdPV2TpSV1SEVLIehDovl
         CiaTtzuzoJOqgxltAVldXMIPvu6EqU7kxAXo0iTw40wUE3kAqHlyGtj53/YZrWTpiqF9
         vpBhGIWdW6xE5bWxr01CvwQKXwk6hFww9cp9bS7IKDTrSmZxW5VO03LYQX8qZ1cLxOp+
         W79HxvGBZY36cwMfhL2FYWSvuaXB/cC/0U2VpMqmdgZTSFK/L7Ur9QN2KmHD6P6H08yt
         rN7/ni9M6cdoM9ggFAOxgWlBeFAF9+LjMErkXBrwChsSMyrNw4FJP9Ez4fBD/JVeNyB1
         QAsg==
X-Gm-Message-State: AOAM530/uFNZZlMak0d9ky4Q/Z5RcVDZTS+s5O6b6midKm1V5E5DuoQS
        BRwZOf2lcO47HJMdsyKF7mfzJQ==
X-Google-Smtp-Source: ABdhPJzhgT9GoDuxD82LpzWq8JlymoPqHojM6SncquisHWWAsIZsqGdPvlwlCE6um9UeCQbTaZ44VA==
X-Received: by 2002:a92:de0a:: with SMTP id x10mr3078309ilm.309.1641749837966;
        Sun, 09 Jan 2022 09:37:17 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id g5sm2991212iok.52.2022.01.09.09.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 09:37:17 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20220107005228.103927-1-yang.lee@linux.alibaba.com>
References: <20220107005228.103927-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] block: fix old-style declaration
Message-Id: <164174983619.77550.9171818584702975669.b4-ty@kernel.dk>
Date:   Sun, 09 Jan 2022 10:37:16 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 7 Jan 2022 08:52:28 +0800, Yang Li wrote:
> Move the 'inline' keyword to the front of 'void'.
> 
> Remove a warning found by clang(make W=1 LLVM=1)
> ./include/linux/blk-mq.h:259:1: warning: ‘inline’ is not at beginning of
> declaration
> 
> 
> [...]

Applied, thanks!

[1/1] block: fix old-style declaration
      commit: 292c33c95defd0b814fec1fc8cd60d16556cf7b8

Best regards,
-- 
Jens Axboe


