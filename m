Return-Path: <SRS0=S578=Z3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B5FC43603
	for <linux-block@archiver.kernel.org>; Thu,  5 Dec 2019 15:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D657524249
	for <linux-block@archiver.kernel.org>; Thu,  5 Dec 2019 15:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IONzYt78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfLEPAl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Dec 2019 10:00:41 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:45367 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbfLEPAl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Dec 2019 10:00:41 -0500
Received: by mail-il1-f193.google.com with SMTP id p8so3199249iln.12
        for <linux-block@vger.kernel.org>; Thu, 05 Dec 2019 07:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=F5mXGgQfdcX4ulNvMgJjySGQKhJoMGbY4UManmb5rnw=;
        b=IONzYt788nj+bQP2DMnWzbIsVtvCFVv2q6kQwcurdaDuXq17O2n/Dz3sP337r4xXmb
         cCYaeWsw6A6b+gGxworEyXUUjtWh7q+Hd2lIEgPAWiPeNIZ0eIeiHV0h9Kk0dnG9aDSA
         SswE0cfdhCdZ143x1FjVlUplkNtdBbCEA6KKcuXXB+43ZKbXGx4etEdt6tEL0Y3wEhqX
         EJWUhVgFESZKT6os3cMmoYDQ9OD72ahcrPnZP0VTak8sFIvI6Goeq96q8Vk1yzE99e3G
         uoCDSIkKp+/PPwoOO9WAeAxqVNreJMKLHsET3MvKV8DAXrrYjORfeUsMuRnW43otuvGW
         GYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F5mXGgQfdcX4ulNvMgJjySGQKhJoMGbY4UManmb5rnw=;
        b=nm5xJOP1q3P4cNMx70tDzWv5qwnZknq3/jrjnJMCqElP+dlwyYLR0X4niZgUPJKhWF
         Ff5Yf2alw0VI5zCttcuNbZBbRVZ5ggXQ8FrZCg8nlZeSVZZdJfx/ceHGXI0BZfArbNHn
         Cgym/Bm3+au3socK6gB9nqdb6BFoZSTJXZzFtH0D3+KYeuDQTI2B/IBB8Lc4KWKladN+
         ECZ7gESYoawJZWILPgxnaWG3j1zoJfcBdH8AgN2otVgzNHQD2bfqlKxF0muNhvAIk/Eb
         /+FRLQVTtSwjRgIWQKbzj0g2uzmvFT8o0ALuJvGT8jXev8bPH0Bmv7ZW7WhkVS+IRALE
         zXdw==
X-Gm-Message-State: APjAAAWK4ieYz/UtIdNXrqIGujhbQXc33kRINCV3zEBXyjAPuvYQQCOb
        ng/e866jUNQ8DXVxD8QL8H0YdQ==
X-Google-Smtp-Source: APXvYqxIYA4JrNV5BxAT0DEq/LbOrIBZ+ExgEHJoa8r5nn9zo9eBUe6YgDO9mP2pcqCfGBRcYrltUQ==
X-Received: by 2002:a92:9885:: with SMTP id a5mr9316849ill.107.1575558040476;
        Thu, 05 Dec 2019 07:00:40 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o83sm2874577ild.13.2019.12.05.07.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 07:00:39 -0800 (PST)
Subject: Re: [PATCH 0/3] blk-mq: optimise plugging
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1574974577.git.asml.silence@gmail.com>
 <da7f8969-b2ee-2bfd-c61c-50f12eb7dc16@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0f7be0b5-1d70-ae41-ad15-2e1ae7c73f09@kernel.dk>
Date:   Thu, 5 Dec 2019 08:00:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <da7f8969-b2ee-2bfd-c61c-50f12eb7dc16@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/5/19 6:19 AM, Pavel Begunkov wrote:
> On 29/11/2019 00:11, Pavel Begunkov wrote:
>> Clean and optimise blk_mq_flush_plug_list().
>>
> ping

Looks good to me, I've been waiting a bit on this as I'll queue it up
for 5.6.

-- 
Jens Axboe

