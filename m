Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C3CC433B4
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 21:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CCDD613CD
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 21:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240303AbhDPVRv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 17:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240288AbhDPVRv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 17:17:51 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784D8C061756
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 14:17:26 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id z22-20020a17090a0156b029014d4056663fso15301705pje.0
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 14:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gqseJO9CGkz4pjTNjpt/nx0Gv1B/seEPYR8+YldK4DQ=;
        b=J+QPCrpx5ys3um23Pc3yHQNgbQBS4103CCl2Za2cJAFOtNUQmPpsfEQ74i71MpZBQC
         2bYZNMCARMNZx4TEkbh+Gj5F6SWwVPT/WHUl6u0TXoUh4VeK1IXyW4zVQDg5MoZgsMx4
         QBngws+jfRZ3sC63TPG+cOd6pcVqR0Xwcc9Fvc3cZruLBUpbtsN5XrIMkNAzXKR3IhHs
         dkPkQ35otebcIopwyk+vV+f5YmNYkDJ7dqYJnrgn+sBYC5CfBGnHzWsSVo1laofykT2G
         Q4N/UBuipQMC0Pzcxnl0zgyPYDXZyJEmryh+Yt5fb4MrcEjly7AGOpdfe30uAGvL4hm6
         6Q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gqseJO9CGkz4pjTNjpt/nx0Gv1B/seEPYR8+YldK4DQ=;
        b=ZkHRtteMoUdEtDf6FuWnuf1epeeP7kVnSB34lQJyU8o6czDI4rnrEkCfTFHXQjCcOC
         97m69b+WeC85rO2+wy5lh7sO1c7C6OXvoQh2mds/q0M2hC+ckOMFYFsws3wEgDFLo4mp
         QdleW8LMe2aJC/gcW8siken7drmbzONOX9cVc9cpc7ipbp/0++ZfUpZEczC6JJTEYpPl
         cGv1Fkp44WA28s17NMovQ+5Wrn1bY5ZFcRIANbM3rR5fm//MyMuYUZqIy7InbCjOlflH
         sXdmkCtm5DXKEhl3nA94TurOhqWtIPZkAi9fn/dXztuVwKwkGmUxBQJCxfxYkNth8o0D
         mv8Q==
X-Gm-Message-State: AOAM533enbVh4LX8893VKiyp5B9HuU02g3WLgNoeCGlDr7H6bcEyXf0O
        u8p97mQvgmMc2OsKkk4rnsH03A==
X-Google-Smtp-Source: ABdhPJycKk0fhXKxdfx45MkKO7GBaFwkMCNnqoM4DLdWSYUjMpfakDZWHaWqmCxWKbXspyPy9TVsow==
X-Received: by 2002:a17:90a:7e03:: with SMTP id i3mr11562361pjl.234.1618607845801;
        Fri, 16 Apr 2021 14:17:25 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id u18sm5444862pfm.4.2021.04.16.14.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 14:17:25 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: Fix spurious debugfs directory creation during
 initialization
To:     Saravanan D <saravanand@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tj@kernel.org, kernel-team@fb.com
References: <20210407175958.4129976-1-saravanand@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ab220998-cd24-e8e9-6694-f7143efc744a@kernel.dk>
Date:   Fri, 16 Apr 2021 15:17:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210407175958.4129976-1-saravanand@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/7/21 11:59 AM, Saravanan D wrote:
> blk_mq_debugfs_register_sched_hctx() called from
> device_add_disk()->elevator_init_mq()->blk_mq_init_sched()
> initialization sequence does not have relevant parent directory
> setup and thus spuriously attempts "sched" directory creation
> from root mount of debugfs for every hw queue detected on the
> block device
> 
> dmesg
> ...
> debugfs: Directory 'sched' with parent '/' already present!
> debugfs: Directory 'sched' with parent '/' already present!
> .
> .
> debugfs: Directory 'sched' with parent '/' already present!
> ...
> 
> The parent debugfs directory for hw queues get properly setup
> device_add_disk()->blk_register_queue()->blk_mq_debugfs_register()
> ->blk_mq_debugfs_register_hctx() later in the block device
> initialization sequence.
> 
> A simple check for debugfs_dir has been added to thwart premature
> debugfs directory/file creation attempts.

Applied, thanks.

-- 
Jens Axboe

