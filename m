Return-Path: <SRS0=uUnX=Y5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3D5C5DF60
	for <linux-block@archiver.kernel.org>; Tue,  5 Nov 2019 15:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2CC6214B2
	for <linux-block@archiver.kernel.org>; Tue,  5 Nov 2019 15:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YpRQq1TC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389908AbfKEP3s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:29:48 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:45465 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389884AbfKEP3s (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Nov 2019 10:29:48 -0500
Received: by mail-il1-f195.google.com with SMTP id o18so6398388ils.12
        for <linux-block@vger.kernel.org>; Tue, 05 Nov 2019 07:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D4kluc2UXLt7ANBxIooFAqYy9BjH/ti0RahbVIn0oeo=;
        b=YpRQq1TCYCgfBqjO6PSF4y+KQPnwQDYjJU1cXd+HSurrkHZ1BvdsDGpYxQK2bfZPbw
         JU60cVnVBgbPJILowJyTVOKJ1l6EaXRU8XOBGnuZl5H+kwbmo3TDk5Yewhj9eEdkSp4F
         CHGPigHm0dJ90Q1OE1GiJfKMyBrTIAP3TsSs2arOjefTbxj9KiQPkbq0c8I2zn6JLg06
         akiyAmUoQ1CTQ0rY7j2UFKyUAA/3s04XvjkgZ/RZ6e+S4BPs8fRv2WuUoqfUlY1j4/A/
         IIGvqBEb9RChPC9reFEiGtGyRdfn+WHDKCuhhJ73A1JT1BWEOzYdevgUVlyFllt7NDW3
         dIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D4kluc2UXLt7ANBxIooFAqYy9BjH/ti0RahbVIn0oeo=;
        b=ZIUy18dVHgJOOmRGFWO/grx5MLm6EDcfsBUbcaALYKuZwGJho0jLgvHuaMCSFrTzNM
         nMh204negUsno4gB8H+sPj7oE97lLrV1qg8aDiN2RvnwfBB0Ne37n9QJaJPjnEm8jXZa
         IgmJsi44Q2LPjbwB9pYGwaJqka0szJWvPcJiAzG+xdMRdpQDP9QdBBikE3EOffzXMkJd
         VjWwckkizTF7r6lGUCaChFTYcOuD7pJlJLv7Uenvk0O0KC8Ij4a88dCsrEwFZiWhI+dE
         AP89W7zFPEWAIVn0BskNqsYT2za3Y/byZD+Gd1/aTKE7vNfACzLi21U4e1BfQbqVut4R
         06lA==
X-Gm-Message-State: APjAAAU4JguS/khveLDRSslM9dYFj+TH4DESKQvqSKt44VeMqM45vd42
        m/1dr84pKxXLMNJRPXpP/GQlGkSTiAU=
X-Google-Smtp-Source: APXvYqyxNXYvYkjX4d6jtXU+SOwJFYAnvCxcJQdbfjna9iU/xEsYNvsBgSf0gg1r3KDyrOI5GH29Dg==
X-Received: by 2002:a92:490f:: with SMTP id w15mr33928006ila.187.1572967787212;
        Tue, 05 Nov 2019 07:29:47 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j87sm2915731ild.82.2019.11.05.07.29.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 07:29:46 -0800 (PST)
Subject: Re: [PATCH liburing v3 0/3] Fedora 31 RPM improvements
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Julia Suvorova <jusual@redhat.com>,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        linux-block@vger.kernel.org
References: <20191105073917.62557-1-stefanha@redhat.com>
 <x494kzibhbh.fsf@segfault.boston.devel.redhat.com>
 <a039c944-f282-f9cd-6ddf-6ffb49228f17@kernel.dk>
 <x49o8xq9wm1.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <45975f14-2687-ffc7-28ee-a3cd1167823c@kernel.dk>
Date:   Tue, 5 Nov 2019 08:29:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <x49o8xq9wm1.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/5/19 8:22 AM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 11/5/19 6:09 AM, Jeff Moyer wrote:
>>> Acked-by: Jeff Moyer<jmoyer@redhat.com>
>>
>> Patch 3 is attributed to you, but not signed off by you. Can
>> I add your SOB to it?
> 
> Yes.

Great, done

-- 
Jens Axboe

