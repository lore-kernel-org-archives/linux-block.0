Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358F8C433E0
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 22:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D549206DF
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 22:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cA4YQx3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgGHWFO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 18:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgGHWFO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jul 2020 18:05:14 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5AAC061A0B
        for <linux-block@vger.kernel.org>; Wed,  8 Jul 2020 15:05:14 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e18so3520pgn.7
        for <linux-block@vger.kernel.org>; Wed, 08 Jul 2020 15:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+dcCNqQfq+GGAohNtidK8fXg4IXlIGhMyJSsVaTzSEs=;
        b=cA4YQx3Rn8eiqk3/8gIv7ncFqDvo8b7/cSPqTqO/3LjHL7OD4jzPvfAVBQqnpGSSnu
         pMYbR3xRaqFiewOn4R3TagBRds+YO3pNSr0Bq7cINyagQa/ooYDqEeRWor2rxUUwheaE
         zXhcRCd0tv4tHXlyJUVRZPnYJO5UmYni6lq6E0BQkqSX2QSga3nZ7l051/KFhulKCCeI
         gkfyYVVENxPoHxYDyKS9S9EN2FI4pEgel0mYRQdAwHfo9o3E/cuRByiMwq6DtxWouhAB
         /W7inoLrLw7i9cZL3Li9JR1HrP8/Pi4R5fGIMNLDvepPTkGuS3hMiVlquF0FyZ8ZBaoZ
         qmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+dcCNqQfq+GGAohNtidK8fXg4IXlIGhMyJSsVaTzSEs=;
        b=E5Dfh8ogdEaISufoG9HaIJzgSGM7wCc5ot+fBsWJz6L6Y21e0kpqtSF1kTUtOa7T1w
         54vvoGLfg7qoX94F6+WuZIxP++R5Bj55RExGeVXKgg0011Ip6b3SV4I2pR8gG23o/19d
         O182rTcnfAcDbRZCe38ShgdYEUH2xlvFHS40MmLvITtjSblWvFl+mCQZCvAsE3q/PVPu
         XtK0b60iXo78Cwql5DlCStGUOmQtnwiKQAmvlybpFSiuIiYSyXEWUX00zjxu+IkGHHyA
         b4NOejWo/icK7nvUAgMVGqLr9nDLC5k70jJL6uxnZtFyE7oavkGEyD4T2XiNpudI+ecq
         unuw==
X-Gm-Message-State: AOAM532WeP8lbMlqCJRKrJOdcJhiC6XwJuFOcIRRsUyc379QbJXHNLiP
        DZtnLRhp21/A4NPABCdBRc5hl4rp4/7jyQ==
X-Google-Smtp-Source: ABdhPJwq2FrJusKcVu0CTqXdMyXWPktvhfZEKZqaCWf8X0JAsEVQ/2PgHlIxreFDJxSZwqjk6iHCMw==
X-Received: by 2002:a62:17d8:: with SMTP id 207mr52098025pfx.44.1594245913425;
        Wed, 08 Jul 2020 15:05:13 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id o42sm483035pje.10.2020.07.08.15.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 15:05:12 -0700 (PDT)
Subject: Re: [PATCH V2] blk-mq: streamline handling of q->mq_ops->queue_rq
 result
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <20200701135857.2445459-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f4163e85-5b23-fadd-bfbf-8c33106cdacf@kernel.dk>
Date:   Wed, 8 Jul 2020 16:05:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200701135857.2445459-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/1/20 7:58 AM, Ming Lei wrote:
> Current handling of q->mq_ops->queue_rq result is a bit ugly:
> 
> - two branches which needs to 'continue' have to check if the
> dispatch local list is empty, otherwise one bad request may
> be retrieved via 'rq = list_first_entry(list, struct request, queuelist);'
> 
> - the branch of 'if (unlikely(ret != BLK_STS_OK))' isn't easy
> to follow, since it is actually one error branch.
> 
> Streamline this handling, so the code becomes more readable, meantime
> potential kernel oops can be avoided in case that the last request in
> local dispatch list is failed.

Applied, thanks.

-- 
Jens Axboe

