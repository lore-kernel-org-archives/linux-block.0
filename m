Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8422CC64E7C
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 16:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 294D522240
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 16:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbgLBQsC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 11:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgLBQsC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Dec 2020 11:48:02 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031EDC0613D4
        for <linux-block@vger.kernel.org>; Wed,  2 Dec 2020 08:47:22 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id 81so881841ioc.13
        for <linux-block@vger.kernel.org>; Wed, 02 Dec 2020 08:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zol2C3x1MpOzz1E0I2X0Xu9pD3c1eo4ablGKhHx2Q/I=;
        b=VJFF5u1RtTw3H5fA71XF341hMq/B6fNG0U1xvRXi2kaT9e/euqApxIa2nUwXI/oXvY
         usq/E/FGZY60zISjUJTdfL706RMojTGZ04BICGBlU5cygX4VtQTwmwvcyLaJpwzrkL5l
         wwzSlR2h6ROnVfTObdeTLnrrbWEdbCBvPXDRDxU9r01JCyT3Y/KkWPKHFKkVoVQpInNf
         AyADh0fIgDl7iT82TQ1tH6RxIYCmm5N8/xb8qrl3DFA18Iwy4O2QCunhpZTtDjdPWKj/
         odWE/E4Q/vMdtlToAh9+G2NFhSgIzy7n78oHYPJQhfkQ05pGRpgRdNInWULIDqsD5TE7
         pYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zol2C3x1MpOzz1E0I2X0Xu9pD3c1eo4ablGKhHx2Q/I=;
        b=b4XqNZavMZXUv7UNogUnXskrCBjT6pWEodPi04yJFoqC43ABsfnv9v7GEuxtU7v30v
         P3Ewc1EZo3FrV3hwqZPBamLrXtPLcaZi3cVv5Ym2jLuf+Ut40qUoS6VB1ol8DDtHA3dx
         ONz2wdA9AjWoEi7kVFaniuaJdlNNM5piXGa67XeWq5TwfzAzwAKo+2qt+wBHjdgRmb7P
         Rdlw3MhWA/nD0hovdcNzwJRXXyQNlCOuf+SSHA6shAajIhP2wRCBj/4XoGeIpJBNjC/C
         /rIz3n2vhHuqXFVr9ePFkHhd9tvnon5g2jAJ24wxx5ubM33fvwcMR8T25c6cGdUB8HnF
         lWHg==
X-Gm-Message-State: AOAM532Za/zAXPWmyPwygNjeTIhkJhNpWYG4eMto++6fez0pdykm1UYw
        hGfxkA3TuZnvHxY0LCE3eWWgYw==
X-Google-Smtp-Source: ABdhPJwQVQshzqxeUQpTotwdP0W1jY0nkGx2oNjGdNM4H2mmoQSDhDPPVxwcg7vOg+16ZJQWIG8RjQ==
X-Received: by 2002:a05:6602:3303:: with SMTP id b3mr2677562ioz.179.1606927641308;
        Wed, 02 Dec 2020 08:47:21 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r10sm818002ilo.34.2020.12.02.08.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 08:47:20 -0800 (PST)
Subject: Re: [PATCH 0/2] optimise bvec/bio iteration
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
References: <cover.1606240077.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a315f9c2-e574-a5df-83c4-a70fed604e01@kernel.dk>
Date:   Wed, 2 Dec 2020 09:47:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1606240077.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/24/20 10:58 AM, Pavel Begunkov wrote:
> This adds simpler versions of bvec_iter_advance() and bio_advance_iter()
> (i.e. *_single()), that are faster but work with the restriction that
> @bytes shouldn't be more than available in the current bvec segment.
> 
> That covers most of bvec/bio iteration/foreach, that are massively
> inlined, and thus also nicely shrinks binary.
> 
> Others non core-block users might be updated on case by case basis
> (if applicable) after the change is merged.

Applied, thanks.

-- 
Jens Axboe

