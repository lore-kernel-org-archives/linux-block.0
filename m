Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978FCC433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 12:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FF866137B
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 12:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbhJSM0u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 08:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbhJSM0t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 08:26:49 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F0CC06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 05:24:36 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id r134so20039108iod.11
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 05:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uiLrSseU6nRGfDg29RQox7hHludLA8ajWFfGQkhjtO8=;
        b=TbO4o+ebkcSLJotlmGu3+6RCPlmjcU4BG/CZSGJ4ix39G5ILYVgC4hfNv5wxx+BH6f
         4cMDU2BTWpZCijTqwUWbdPUQLOfYtz9a1Vmzb6P3CPGQ0Zw47hHTWiur3sLd8ecPHgQr
         BQWKbsq4AOTB4JB8kk1fWThBxeHiqaB7kfUV0QeAGg7lUkAGm9aUfzijgFGVJGkm35LH
         uRkDsWn1u34w53EvlMV+0Ewjmw6fi+WhmBow7oFxwvTxkEO3TePuvPzDbNtpUANsuDgK
         sat0+Z8u5NSaqZ10jz9pycAUhcjvVOWcAgMbXZE6DHk4OWdW0HLih4k2UuO9gT0mK9uc
         5MKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uiLrSseU6nRGfDg29RQox7hHludLA8ajWFfGQkhjtO8=;
        b=qB3lpsVYLtBlbZyJxZQDTcdrKs+5d5JXCqXbOpi7NMC3VGjktvLniLChuxU0GqBdsC
         YJuCXFuWef3+LYOSNVJ54LWAbD1cycTsvxdLhV41JtNTC7xruFVn6qsFVo8IvHxExTgs
         FERl1C0YR7fEEDYBkkBQdEs4FjKGKduy+TTWigGJXIG1qQFMWckwyjx0ELaPer0BNeIJ
         mFQPRCOI9PLGm+gZM2orTYdfGUHfIKPZckHeOwRp5/BxZeqtoZdbB4bDXDxZWkhhiN8u
         yVgs2dWNReDgH8bmvKAUVtY9SDgqCOauwm9iPV6++4Sv7727TSTeGTW+ZnsIpbduD+aw
         pOyw==
X-Gm-Message-State: AOAM531xUhB/swRhJbx0VERjXEXalDhAKKZ0yzJ+8f/kAyfMWFtklB7h
        1ROFlJNd5Wv+YrNA1fTrlHTXJQ==
X-Google-Smtp-Source: ABdhPJwPbNLdZhZJzUpxjtloiHAhPsOdxCOa0OD3uNlc3OUeMIElGAStfjnRHPMg+r6STfc2RCNNlQ==
X-Received: by 2002:a02:1688:: with SMTP id a130mr3911945jaa.40.1634646276234;
        Tue, 19 Oct 2021 05:24:36 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id u15sm4288367ilv.85.2021.10.19.05.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 05:24:35 -0700 (PDT)
Subject: Re: Is LO_FLAGS_DIRECT_IO by default a good idea?
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc:     Lennart Poettering <lennart@poettering.net>,
        Martijn Coenen <maco@android.com>, linux-block@vger.kernel.org,
        Luca Boccassi <bluca@debian.org>, Karel Zak <kzak@redhat.com>
References: <YW2CaJHYbw244l+V@gardel-login> <20211018150550.GA29993@lst.de>
 <YW53SrKnKmn2Aa0k@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <32ccb509-37b7-c9f0-14f3-d68c24c55dad@kernel.dk>
Date:   Tue, 19 Oct 2021 06:24:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YW53SrKnKmn2Aa0k@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/19/21 1:44 AM, Ming Lei wrote:
> On Mon, Oct 18, 2021 at 05:05:50PM +0200, Christoph Hellwig wrote:
>> On Mon, Oct 18, 2021 at 04:19:20PM +0200, Lennart Poettering wrote:
>>> A brief answer like "yes, please, enable by default" would already
>>> make me happy.
>>
>> I thikn enabling it by default is a good idea.  The only good use
>> case I can think of for using buffered I/O is when the image has
>> a smaller block size than supported on the host file.
> 
> Maybe we can enable it at default in kernel side, then fackback to
> buffered IO if DIO is failed.

Yes I think that's sane, pure DIO probably isn't a great idea by
default. But if we have a sane fallback, then I do think it'd be the
best way to run it.

-- 
Jens Axboe

