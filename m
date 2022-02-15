Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EF8C433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 14:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiBOOxK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 09:53:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239503AbiBOOwt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 09:52:49 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF54106B19
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 06:51:52 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id u5so2075170ple.3
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 06:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=c5Wpci62tHuJUAuzU/KZt5qR1ELYyaR4x8tumenSCho=;
        b=acxOoiimWCRJ0bqWPmmRMSvRc4QXJOWebEtAy1BdPoJOlsdTYwwgY6XDQZkUl0pky+
         KQIXAL0mxD3Cpji3YO/PWl3L/fTKV+fst4EQ8xRUMk3YDJP40lvE2QDqMaXrEmi7YXK/
         nakYvi6e5+Ns8h0YI0B9ZMIt1qSDO7W5KiqL+LZ2AtIMmAyxSWiGY/UjbrJglJi9KNNq
         fJmJPZ2Su5RDt/WROKfO7WN/mUadoREhQXL5WAxvuw4y/f+0Ga5HEwFT01E/pU3F36IZ
         MTKEYgCAFzVlA6vwuc0z2wbRuHLg6xjzSblctb3KgZf5GfSS9Nzh8007PkvWk1veprIi
         TZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=c5Wpci62tHuJUAuzU/KZt5qR1ELYyaR4x8tumenSCho=;
        b=r0agOuJmCviqED8pRPhWFs0csoizkBiWmx8udcHK/AmLxYV+EcwDLPAKrBbD3bGk07
         TE2KVU1ploYa2mLAGEbnKW0U03liUsx6D+RUqP/U0/vckWH3e/GoKi4wcI+tQbC21Ldj
         /qImMLEoImrpBT3on4LCEd/5zjkyI69K1ZhPvdw5Ll1FnRmnvNGJDN5kc5RVa3gkbvHM
         SyK9fxpZNLjgJVnWjSuEcxxCeun69HYaXkb3DQmdYIebjQbmVxz6sWTzfEuvAbccv3k/
         HvpBH0pfEScZq8Tzf7dbhAifW7CU4JdPfpjXcrowlOZAdTeUxiS28fm3L3aof5ckCOiB
         OG0A==
X-Gm-Message-State: AOAM530nMbGuWAL7eoduoYSCdeXEuYskBh0XiANDBibKfVj/nKnlkxuH
        PKSTXzkrqLNXZePOc1huCFOP4Q==
X-Google-Smtp-Source: ABdhPJx6jelD+UMGtsdsnTLxETS5qXqXGNzwFWtfMtZKXM7Gqu75WKcpLteezyOVccuqQq0OrQxmPQ==
X-Received: by 2002:a17:90a:780f:: with SMTP id w15mr4737226pjk.139.1644936712211;
        Tue, 15 Feb 2022 06:51:52 -0800 (PST)
Received: from [192.168.1.116] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f18sm1019471pfj.6.2022.02.15.06.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 06:51:51 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
Cc:     jiangguoqing@kylinos.cn, damien.lemoal@wdc.com,
        ming.lei@redhat.com, shinichiro.kawasaki@wdc.com
In-Reply-To: <20220215115247.11717-1-kch@nvidia.com>
References: <20220215115247.11717-1-kch@nvidia.com>
Subject: Re: [PATCH V2 0/1] blk-lib: cleanup bdev_get_queue()
Message-Id: <164493670969.128372.4039545396164602842.b4-ty@kernel.dk>
Date:   Tue, 15 Feb 2022 07:51:49 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 15 Feb 2022 03:52:46 -0800, Chaitanya Kulkarni wrote:
> Based on the comment in the include/linux/blkdev.h:bdev_get_queue()
> the return value of the function will never be NULL. This patch series
> removes those checks present in the blk-lib.c, also removes the not
> needed local variable pointer to request_queue from the write_zeroes
> helpers.
> 
> Below is the test log for  discard (__blkdev_issue_disacrd()) and
> write-zeroes (__blkdev_issue_write_zeroes/__blkdev_issue_zero_pages()).
> 
> [...]

Applied, thanks!

[0/1] blk-lib: cleanup bdev_get_queue()
      (no commit info)
[1/1] blk-lib: don't check bdev_get_queue() NULL check
      (no commit info)

Best regards,
-- 
Jens Axboe


