Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93656C4338F
	for <linux-block@archiver.kernel.org>; Tue, 17 Aug 2021 14:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 764E660EFE
	for <linux-block@archiver.kernel.org>; Tue, 17 Aug 2021 14:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240213AbhHQOfc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Aug 2021 10:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239873AbhHQOdm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Aug 2021 10:33:42 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49358C061764
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 07:33:09 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id hv22-20020a17090ae416b0290178c579e424so6675096pjb.3
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 07:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=isGxWOTd5shMg5EAgo6PA5diCL2W6al9cYd9Z1D7xus=;
        b=GfdPkYOtP4rhHMyKJMYfl9O4KfTR81yOpB11oGxRr4snKRGkMGuDVIFm9k4VaI3bl2
         6YCEEmkbQ52KpyNf5HDMNNiN+rHvjFRlib6CqpQcoBwv+ehyBWIcOwBPLhkpValSuQw5
         ck1cML3GY4EHFKS417XSfj+1v2GVsEAipQWla/6Pl2A3WY4lJ7uUDdy8USpgWIT8ouZJ
         fIj1dlue7rt0ndSFSRAgWGkZMvKU0AuY3i8CNPpf7LxWXewHoDX7+m3bwGbckIbK0hPl
         f6ymUA82Z/eJOMKMigFXKA5AnGE5Uhrlwzd1U4oW0vz/0NHaNOQVs843+qdRnp+Gh/PX
         ChyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=isGxWOTd5shMg5EAgo6PA5diCL2W6al9cYd9Z1D7xus=;
        b=OwwNUvj8hkXGC3LluRSVoA0QtvS9b+fNbFx+251nPAyaI5JXct0lUJJBWS7NlMOgWb
         LHAXfiJ57ka5e70gTRn2vMLzAzvvOiwKFYYy91Xe9MiLhqAyBQGxhioLDol05IUI2Yeo
         n33UCB3t2n+JcPB4hHR5rEUL/eFbsefv0YoBm6kSRDj/prYSBVHcdcR9mfE3NYFIKGdv
         OeYhx/i105TTzzqcWpNFIt2wFMifgR8ZXMRWTty3n6aO7szAvd0qUNEmPT/Z5vHzri7V
         tF5N5JCtKgvNng+vXw7n1XDaVzjxPr3Qk4/LfYaYH4MDUA3ibWXUdQNbycC3g5lIFiVM
         zsEw==
X-Gm-Message-State: AOAM531RvvKOCxc5Xyv2oTcixUrX3md1/Nq5pJo1zUYuMbCEUOCIEfPl
        +kb1mDsFIB/aTfnpeF69bBKlGg==
X-Google-Smtp-Source: ABdhPJz6Srqy23ixsmudsSlEEYQ4uMlG6hoCFjmTuJRe3/TgL+lKhk+i3Oyev5etj53QCleXhErHOQ==
X-Received: by 2002:a17:902:c406:b0:12d:d0ff:4aa with SMTP id k6-20020a170902c40600b0012dd0ff04aamr3145532plk.48.1629210788567;
        Tue, 17 Aug 2021 07:33:08 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id pj14sm2190827pjb.35.2021.08.17.07.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 07:33:08 -0700 (PDT)
Subject: Re: [PATCH V2] blk-mq: don't grab rq's refcount in
 blk_mq_check_expired()
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        Keith Busch <kbusch@kernel.org>
References: <20210811155202.629575-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <38484926-becf-4aea-8a92-5d209657722a@kernel.dk>
Date:   Tue, 17 Aug 2021 08:33:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210811155202.629575-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/11/21 9:52 AM, Ming Lei wrote:
> Inside blk_mq_queue_tag_busy_iter() we already grabbed request's
> refcount before calling ->fn(), so needn't to grab it one more time
> in blk_mq_check_expired().
> 
> Meantime remove extra request expire check in blk_mq_check_expired().

Applied, thanks Ming.

-- 
Jens Axboe

