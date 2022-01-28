Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790FAC433FE
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 14:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349397AbiA1OpW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jan 2022 09:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349416AbiA1OpV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jan 2022 09:45:21 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58727C061749
        for <linux-block@vger.kernel.org>; Fri, 28 Jan 2022 06:45:21 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id p125so5397896pga.2
        for <linux-block@vger.kernel.org>; Fri, 28 Jan 2022 06:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=tHZMd140zpIEoj2CecnDxVRiFeDUjbUC1wxqPW+oecg=;
        b=FgCuhEx0mkvM7saXOLOVMI1MIOyEj5vw3bcRnIuyWTYKhrkW+5bCVLOMQ/VchCGjEE
         SVzPxfw5nFI5+p3BLT9mptUsuaoS21kI1r6kJwKtFs2BmfSALC+TJe1e6WM5onQqnhbG
         Pd3KR3+SY7V7OPFQQ9h4TJnW5/dBIHbzjuYJf040JZbZG+ClOIDFW3uUY3yN6rHn+oiC
         P2ZdxxnCStjQ57ZOGVd4o5+H9yaLhpLYI1xf91xU/Eir5iEDxiskNhFH0wH6mQWtlCG8
         e6iXpYihbDomILqZ/1ePLK8ooOug8iYFDb03bohpV9fdaWr4f/lQZrlIO8QKDTm1XB1L
         FDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=tHZMd140zpIEoj2CecnDxVRiFeDUjbUC1wxqPW+oecg=;
        b=JnJSEa1XqnDBdrLc8vCXxPKkRrC2cjsux4klWT4JhIx2GsP/7P7TgwydvE9sUlgOFi
         AYJbqsDkSMlPtn5qHgJVpEvPZJsG1aslyc93uWPPjBjt2nh1eUBBsvKcjsiyJuUKhqs5
         YVtvQxgRYgOd3GB4CLvKfp+O4BkbcTmDhkYrE8RLcCK1lYxRFRlmcuO6bqulAXzQDWdm
         IuTOUL5TrXtWi4UwiiWV6rKvFv9SufHGskoKvJBPVhEqiQmdbygG19JlFdY5A63tuNG0
         m9rG8ZGQwGCIeqJGxHoyIAYTcOWmZxFkIWAYmqrIWCLELExmU5xqrd/k0pT8uls1ppyU
         cc0A==
X-Gm-Message-State: AOAM5333hA8cR7t2QFfF0LX3Ai2QB93ta+drRZu3wtJB2Ki83hROmOZY
        ZrCDji2yt54LUIGhR+9lAQwN/N9yWls9PQ==
X-Google-Smtp-Source: ABdhPJyJtofyeIzj6pV3Ak8U+4WgL1YeQg6Ft+maZoiVI4RvqGB5wBOxqHxxconuZVKUqhAOv64WiA==
X-Received: by 2002:a63:2c01:: with SMTP id s1mr1312797pgs.309.1643381120588;
        Fri, 28 Jan 2022 06:45:20 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id x187sm11238798pgx.10.2022.01.28.06.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 06:45:20 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Yu Kuai <yukuai3@huawei.com>, paolo.valente@linaro.org,
        jack@suse.cz, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        yi.zhang@huawei.com, linux-kernel@vger.kernel.org
In-Reply-To: <20211231032354.793092-1-yukuai3@huawei.com>
References: <20211231032354.793092-1-yukuai3@huawei.com>
Subject: Re: [PATCH v2 0/3] block, bfq: minor cleanup and fix
Message-Id: <164338111974.263985.3933987922467783334.b4-ty@kernel.dk>
Date:   Fri, 28 Jan 2022 07:45:19 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 31 Dec 2021 11:23:51 +0800, Yu Kuai wrote:
> Chagnes in v2:
>  - add comment in patch 2
>  - remove patch 4, since the problem do not exist.
> 
> Yu Kuai (3):
>   block, bfq: cleanup bfq_bfqq_to_bfqg()
>   block, bfq: avoid moving bfqq to it's parent bfqg
>   block, bfq: don't move oom_bfqq
> 
> [...]

Applied, thanks!

[1/3] block, bfq: cleanup bfq_bfqq_to_bfqg()
      commit: a9c77f6ec0b566439182a10b64dd3e60a0408849
[2/3] block, bfq: avoid moving bfqq to it's parent bfqg
      commit: 36ad7fe0ec7485ee435f7a40452c7a58598779d4
[3/3] block, bfq: don't move oom_bfqq
      commit: a0b98e6fba18a40aa9672cc3e0abf980456f3ae6

Best regards,
-- 
Jens Axboe


