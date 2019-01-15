Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84895C43612
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 03:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5683E2085A
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 03:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CR94H1pU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbfAODyS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 22:54:18 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37254 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbfAODyR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 22:54:17 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so641134plr.4
        for <linux-block@vger.kernel.org>; Mon, 14 Jan 2019 19:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OEq3fZwJsAuBmM99Irgh2vXZP8B45DZuzpVHQBzpQCg=;
        b=CR94H1pUYvro6G53vHo8MkFxuAtWtRi2PE5kHzMB4t8XsP65vj69fJxApIK5UKJ1cb
         YAKvcaXDo6VxV8mBFdI8Zu1mFSGjEdJRl07bTUvlyy4wz2yOid30tS0AF7LYq5gvLL0g
         mMiO1nNWqmckI2NaIS7DNdkUxkflUTpa78rxCFUwcIAPPwkSBqFNjljrvvpIz8CRp4ka
         BzH+yr6sfino5H2jgDWEKn1t5t8PgKWMhqaLly+QobL6+kMCll26Rc9mivGe3E7mrAvk
         /nhn95kmkcSKKWIQhHxArtoAr5RrGuMk8idUaM7diAK9IBNt9qaFOb6Ge9yy7VDC2zHh
         5AQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OEq3fZwJsAuBmM99Irgh2vXZP8B45DZuzpVHQBzpQCg=;
        b=OPJqGBG3HEbRhcN9P+GJaWEmU20QinwwXa2DvuTXecngxuZl2HPNAgqAqEZTOWYYHm
         kVB3smUdGoJNLi+pQXoV7YqXPjqLcqiPTqGKIa1taQ7im3EQfoMXW1sMLTrt223zK3ru
         IuWIyUJ1GjD32TuN5w/e5JIes2SnMuTQKDs1i4vJlHv5pabzH3jGpltG8GQYXagAWFid
         ZOCVxe1N0r+klLz0FAdfZQAJrXvQXCXpNBfWfzwGuHwV5OWPOpkSYGlqKTaYewesBQ/I
         VP7C0IRKINbUyA5jUkCmLLRnJBvmnIEyK8vw8cyEZEP8z0pDXqaYy13qCSZwzAWmyCHy
         CUDQ==
X-Gm-Message-State: AJcUukf1bXnoiwarTFNMP/qJkRlQ5a7PJBr0lqXhe40oQwRN4lAlCkUk
        ng+L08KHsppedTVKu+AuJ7SNMJbCs5MqjA==
X-Google-Smtp-Source: ALg8bN4yaa7HIFHn/SyFfYTQkTLj9f6rjjMNULvLlSqh6lPj5+j4CcEUo9ChTe3c4FvNtqa3FcNF0Q==
X-Received: by 2002:a17:902:27e6:: with SMTP id i35mr1972671plg.222.1547524456395;
        Mon, 14 Jan 2019 19:54:16 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u126sm4524522pgb.2.2019.01.14.19.54.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 19:54:15 -0800 (PST)
Subject: Re: [PATCH] block/blk-sysfs.c: Remove last reference of
 blk_init_queue
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
References: <20190115030615.1090578-1-marcos.souza.org@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d255d497-62aa-9fc3-fa21-20c9b0226a17@kernel.dk>
Date:   Mon, 14 Jan 2019 20:54:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190115030615.1090578-1-marcos.souza.org@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/14/19 8:06 PM, Marcos Paulo de Souza wrote:
> blk_init_queue was removed in a1ce35fa4985.

Honestly, most of that comment is wrong anyway. Since this isn't
a visible API, I'd just kill the comment completely.

> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> ---
>  There are more two references in Documentation/block/biodoc.txt, but maybe that
>  file needs a rewrite in rst anyway?

It probably needs a rewrite - period :-)

-- 
Jens Axboe

