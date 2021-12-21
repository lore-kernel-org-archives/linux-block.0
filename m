Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53322C433F5
	for <linux-block@archiver.kernel.org>; Tue, 21 Dec 2021 15:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239311AbhLUP02 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Dec 2021 10:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235892AbhLUP02 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Dec 2021 10:26:28 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4C9C061574
        for <linux-block@vger.kernel.org>; Tue, 21 Dec 2021 07:26:28 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id k21so18160358ioh.4
        for <linux-block@vger.kernel.org>; Tue, 21 Dec 2021 07:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nZILDGyMZn168Emcyzk++2f/Rxpp3GQ0Ij4K620L9B4=;
        b=MKBZNm0hWnEn7qYZ4x7FWmHRYwk9fslrDCmJBv0r9OtKsFVqhoOtZZcsm9n8O7MUQV
         Kbw/QV7UHf3vfPjOf+kL9HXilXAY2rZUE985M0BXCc+/3YYrR0QlF7fCe8UpUpcjkiah
         BJaGKmKK6U7VBashSyencxtwVMn1QZxXCaY49Rk0UxbKSutrU0alxChsUfhWgylLinHz
         PMn5O4mY9TDwPga3rD2zQ+IYz+FiVzgpBvn5xeDwB27HRtYERIi3dr57QtVCs3pRgDm/
         r1VzKMaGoXHcgoGD+Q6Te9Qf9MjIpx49O3zIruBfjpV5Ht51AxinJH/HYX2qBdlXFAAc
         KveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nZILDGyMZn168Emcyzk++2f/Rxpp3GQ0Ij4K620L9B4=;
        b=OUmFI231tqKVvyOVBr59ALwNR9/Qd3xBqudghh2PKuwINEzxslDmUrE7abuQd1VfrQ
         yaAmHvb6mLskThEeeu9KD03499COXZD+Ler6P9/I1b3BwVLU1UgjzQ3LqseNBPFGD6TB
         Xiw4HBKDv0pQ/bB/dFWxHOWjIav8wiArJQUMYLJ3jVa/8X+oP/+RZKTGJq2n4cY4MVL1
         51rAXMrZ0pgXY/asqVekAKJ2CfxrLy0sKjsfKWYtLaN3II41Yf5u8YFzymr/2P0tExtx
         1gcLr9FEtuSNojKBMakw0dRPgn0AUI6f3eMS4LpBp4HmSlgfO4ge4jrQoLH3YoRgX6pF
         hlNQ==
X-Gm-Message-State: AOAM53343zcQ98zRbaqy+J2JcM1nH2yQ3gTe8tJB24mbjIf0lf6aTdeN
        5XtGb5TrcrjV3xQJ1dh1fVYKH06WIXumJQ==
X-Google-Smtp-Source: ABdhPJxdVHY0PUTJGPMz/oRE6wOT68T7PuJXZZkJJJfTdXirqq9Q0cmRmzyoSnOETyIUeyYo7RPxog==
X-Received: by 2002:a05:6602:1686:: with SMTP id s6mr1945968iow.186.1640100387475;
        Tue, 21 Dec 2021 07:26:27 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f16sm11728148iov.33.2021.12.21.07.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 07:26:27 -0800 (PST)
Subject: Re: [PATCH] block/elevator: handle possible null pointer
To:     Peng Hao <flyingpenghao@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211221081042.78799-1-flyingpeng@tencent.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5b848910-0972-dfa7-e056-4467e5484a6e@kernel.dk>
Date:   Tue, 21 Dec 2021 08:26:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211221081042.78799-1-flyingpeng@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/21/21 1:10 AM, Peng Hao wrote:
> There is a check for q->tag_set in the front of elevator_get_default,
> and there should be a check here too.

I always get suspicious when I see patches like that. Is the other check
valid? Why does it need to get checked? There's really no meat on the
bone in this commit message.

-- 
Jens Axboe

