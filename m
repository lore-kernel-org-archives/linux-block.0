Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FA7C433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 19:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3A04611F2
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 19:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhJTTHQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 15:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbhJTTHP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 15:07:15 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23959C06161C
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 12:05:01 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id g25so434458wrb.2
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 12:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=x5o5qOC5zaeF4Exo+5NMKrVVTF7HFM5+2h5j7VwA47Y=;
        b=E5dW9v2i2PzTxIXUlJZ8F81G12Tm5r8iKAUO1itguuMh1rJIiFByN6BmKz6BGpHmQk
         uQ2At/TSSjvMa7vFIz//goccGCf+xW9XsHTpxz/uuAKKMuhIDD0I8hddomVQcn3NP9QJ
         chaGnHLtL9SYvIH1QHEV+rWXZKQc37+E207T7LiVvxJWa8/K4Ad30zOFfuSIckjGqLJK
         TlyEycxjfJycQv209bY/d9C5ikeiVrMchqJ4CpPvd1EEycgOqMkBjmqpaUJkjPqWM+YG
         H0dF6L8btnirH7ck8T0xcgMc2WD8a+azMkhluYWM8kyn5eu70pFa5YP6WRnCbIZSsGgv
         UPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x5o5qOC5zaeF4Exo+5NMKrVVTF7HFM5+2h5j7VwA47Y=;
        b=wa0SPgHpLd320QXnP5ecDR6zJiN5K2G4SoJ2kyiILprFfIKz4V7PVhsLwct25RuUlT
         /WXAHANDQWYemDNv4QhOVI2ahXfCy16vmmgl0035M1udHnfoQln+hochybu3VlmNjdzy
         h9eewSVx11FuMJuJJTvvnBKNZrhO5JNKOdDyrKomtQLLsCAPIcsgLLkqs4J1JIT9kl4n
         o4CoO/nqRqfCtdJg+mxBWRjvZ+opkI8Ku0UlGAN55yDu2NxdWvFK1W39x11R8iEA8m8V
         kdZoyQMi+N07WTDh466QEfw76tAIWvBlGZL+bt+12a79jZnf8n//7xjTp97kdOFdOhfm
         zWFQ==
X-Gm-Message-State: AOAM533logTRJ9LC8EHeLcBw/IJQYb4PstAS0pQDvJX2D/zDPfwkTicQ
        /ZFo3uNcMdbTOnz4HE72Z7RCvSYry74XEg==
X-Google-Smtp-Source: ABdhPJw83fO9dXnsfGznaP1ncTGNKAiNB9ZVj5+hZ/jmgOU+evBqhxbFkvqw9I0f6NB7727J0weeIw==
X-Received: by 2002:adf:a3c3:: with SMTP id m3mr1261927wrb.83.1634756699187;
        Wed, 20 Oct 2021 12:04:59 -0700 (PDT)
Received: from [192.168.8.198] ([185.69.145.206])
        by smtp.gmail.com with ESMTPSA id e9sm2826842wme.37.2021.10.20.12.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 12:04:58 -0700 (PDT)
Message-ID: <b04799e9-3bb0-e8ce-162c-55ca6c53022e@gmail.com>
Date:   Wed, 20 Oct 2021 20:04:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/3] block: clean up blk_mq_submit_bio() merging
Content-Language: en-US
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
References: <cover.1634755800.git.asml.silence@gmail.com>
 <daedc90d4029a5d1d73344771632b1faca3aaf81.1634755800.git.asml.silence@gmail.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <daedc90d4029a5d1d73344771632b1faca3aaf81.1634755800.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/21 20:00, Pavel Begunkov wrote:
> Combine blk_mq_sched_bio_merge() and blk_attempt_plug_merge() under a
> common if, so we don't check it twice.

Forgot to add that it's v2 with changes from Christoph's review.

-- 
Pavel Begunkov
