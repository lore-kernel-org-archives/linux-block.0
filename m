Return-Path: <SRS0=Yov/=X6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A87C47404
	for <linux-block@archiver.kernel.org>; Sat,  5 Oct 2019 15:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A346D2133F
	for <linux-block@archiver.kernel.org>; Sat,  5 Oct 2019 15:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="t31R3YAG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfJEPvG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Oct 2019 11:51:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39527 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfJEPvF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 5 Oct 2019 11:51:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id v4so5741766pff.6
        for <linux-block@vger.kernel.org>; Sat, 05 Oct 2019 08:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=8EwNigCA74/f0j+CsqTR3QaiEve/edCDGqXkZKqUwLU=;
        b=t31R3YAGgtgXuIkbC2Bhx+6/nntxpmRf4fm4HvQ/ORFiv8C1JkBK5kPGSLTEjlUwWT
         ezmwpRsBd7JFaCOaqBZKPXXvxmUG8pYgsh3URXWzGZY5xrjBRcGKsouxo+OeK8mEqneD
         EdsnWNEroLU5VLMbijwH46+OWGPZr+f5sshb/VNOGEu38vVdIDq5JQBn4o8qScxUIorA
         UgSVvU1sI2v6KxYRwJiIT/tWhIVESq19i6UfT8X1A8ePIzp1FFTp9dRo+CCU9VArjcAl
         19Z2JHAVxPbvY3YGmZCi2f4KpY+AjujcH0DUalgSpb3w6tlGThJKerly8uOkpnHXKcKJ
         /lmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8EwNigCA74/f0j+CsqTR3QaiEve/edCDGqXkZKqUwLU=;
        b=I0QNvQTOORpWmjPuZw7Xe4B4UAS0nb+2GLOmk26YQ5wSWSgEumrzTmvLJ0Q9vq/w1O
         Ns04paEJkvwYGv9V6IZt1tmu7uzQqt9eI6/BePfWNDsN1Ycp21aiivQA8vUrOZx1TGlq
         K04v7pJas4ZlQ92ctpFxaXq9dU44KYQPOKDzAohwBqvi2e7rw3Jak0/wSSjxhgwpLJOP
         dU12wmuSzGnkviu6uGAMPUnTzNSvWuS7iOVSEvLwN1hgolP2ZHaRv/zJU0k3AqOzR63+
         +zMCuPo+W0PjgShPloHyvblHEHvB1yE6vBnVRMSKQuY5ATzO7ByRRZMifpw+0CR04Jkj
         Pdhw==
X-Gm-Message-State: APjAAAUeEMjMZeROrZ7TGbpJYrpCSKb4k+CEAeRw4e5oGFiqxIGJVAuQ
        80b4Mo9kz8EaUfldw7D9UyeuWBiPKVLvrA==
X-Google-Smtp-Source: APXvYqw8pqY/T35RqN8JSEYLVjcfeLZZ1DAonrJHMx5DQ0iIn0hCP1kHSAS5iv8YKGb3LA3T8/mYUg==
X-Received: by 2002:a65:6687:: with SMTP id b7mr21432359pgw.143.1570290662791;
        Sat, 05 Oct 2019 08:51:02 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id g7sm15102085pfm.176.2019.10.05.08.51.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Oct 2019 08:51:01 -0700 (PDT)
Subject: Re: packet writing support
To:     Mischa Baars <mjbaars1977.linux-block@cyberfiber.eu>,
        linux-block@vger.kernel.org
References: <db5c89c3fe26e4b7ec96443ec97a05df97162889.camel@cyberfiber.eu>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6e381f83-9a12-30d7-8f99-caaa6a608c4f@kernel.dk>
Date:   Sat, 5 Oct 2019 09:50:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <db5c89c3fe26e4b7ec96443ec97a05df97162889.camel@cyberfiber.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/5/19 4:12 AM, Mischa Baars wrote:
> Advised by the linux-next mailing list to repost this message on the linux-block mailing list:
> 
> Hi,
> 
> If I'm correct, packet writing support is going to be removed from the
> Linux kernel. Is there any particular reason for
> this, as far as you people know? Both DVD-writers and Blueray-writers are
> still being sold to date.

The reasons are mostly that it's ancient technology and my doubt was
that nobody used it, and it's completely unmaintained code as well.

> I'm currently working on quite a large project. I would be dependent
> solely on USB to store my backup files, when the packet writing support
> is removed. Actually I'm quite uncomfortable with that idea, because
> USB is rewritable. Any serious attempt to do damage to my project will
> result a permanent loss of code. Personally I would do anything to keep
> packet writing support in the kernel.

If there are folks using the code (successfully), it's not going away.
But I can't quite tell from your email if you're just planning to use
it, or if you are using it already and it's working great for you?

> I'd hoped you could remove normal floppy disc support instead. That
> seems the more logical course of action. Floppy disc drives aren't
> being sold anymore for quite some years now.

It's not really a case of quid pro quo, if someone gets removed,
something else can stay. I'd argue that the floppy driver is probably
used by orders of magnitude more people than the packet writing code,
and as such that makes it much more important to maintain.

-- 
Jens Axboe

