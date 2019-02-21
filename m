Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB398C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 17:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8772084D
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 17:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IikpZ4pE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbfBURs0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:48:26 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:35648 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbfBURsZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Feb 2019 12:48:25 -0500
Received: by mail-pl1-f182.google.com with SMTP id p19so3297431plo.2
        for <linux-block@vger.kernel.org>; Thu, 21 Feb 2019 09:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ikLFJKgiZICG2FOMjOCMaOCHizLNK2GNPuu45sPXaPo=;
        b=IikpZ4pEngfqxTZKaviZuTIkuXCsj/CkH+TkmZcTVcH4i6g3+JkztncvgNZL+2d9ai
         i5uaeRxLSYjeHiR5jZmmNscl/F31tug3fby84Oe+WtMu0YW4rQnud3/uAIo0dToofvQi
         +RDcKpd49OlmKxB7LgFFvoKidtSV7ckaPmgbS4OvSA1Q5jzIVV8S2qEVWtDQ5EpjHObX
         /PqqkJdAq3N8Syz3/pe71+fjJhhr7GK/JPxcjUV0OmZQkfz/z0IHhzU5+ZQEwJHWqRvH
         1O61cq9DTa9kzvkuYvMf3GtlEoVy5FQCBCY7YmVYFf+fvoWMNl20ijSQz6DaNx9NcXhc
         pyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ikLFJKgiZICG2FOMjOCMaOCHizLNK2GNPuu45sPXaPo=;
        b=k4E09137IKWJWUO6FgnKB3SU2Mbr7+YpTHI1AjMComdwZv42L6zc/MKZ1lnYNFWQZY
         ZXO1nlrE4QDIWDelRARqwSWZV8a/2oawwWa+0uF9qUuXckKSw7Kkg03XeZdMOEH5bVh7
         d67zyttn2tFll1CfvQ0Vs0FlzqejwCswkTyXE4Aknrb1C9wCaz+eve8CF/kWW2pjNJFO
         v0KNFghSINm0j3s28ton8A6NBVjJG/ruh0Gdb2Gqx6FfHFIIEh70yyBJYnhvVVz+v1v4
         UIDgpdyWFthl/9TJidWAX0uxjlFcfjzeCsR8VClileFqFMQQRpv3iWXXHwTqy4Gf+iEk
         n6GQ==
X-Gm-Message-State: AHQUAuZXPBL7kXrTd5dzMP5hk02tQpW4ru4lttO6sDZpAY8AOVhY2NWn
        l7IOK5llw3iJiRzxPOALmFChCWmwPfNNjA==
X-Google-Smtp-Source: AHgI3IZcTaC9DhTzYibRvyhudw8oGz8cQpde4eCeX3fp+cAtt6YaGrwl3NQcbQoA5orWUv+Oukx3Cw==
X-Received: by 2002:a17:902:f64:: with SMTP id 91mr43788436ply.132.1550771305180;
        Thu, 21 Feb 2019 09:48:25 -0800 (PST)
Received: from [172.20.1.194] (71-95-160-189.static.mtpk.ca.charter.com. [71.95.160.189])
        by smtp.gmail.com with ESMTPSA id y5sm41978983pge.49.2019.02.21.09.48.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 09:48:23 -0800 (PST)
Subject: Re: [PATCHSET v15] io_uring IO interface
To:     Marek Majkowski <marek@cloudflare.com>
Cc:     avi@scylladb.com, hch@lst.de, jannh@google.com, jmoyer@redhat.com,
        linux-aio@kvack.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, viro@ZenIV.linux.org.uk
References: <20190211190049.7888-1-axboe@kernel.dk>
 <20190221121022.7867-1-marek@cloudflare.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e9b96cd8-71a1-d5bc-e3cf-8248f9654deb@kernel.dk>
Date:   Thu, 21 Feb 2019 10:48:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221121022.7867-1-marek@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/21/19 5:10 AM, Marek Majkowski wrote:
>> From: Jens Axboe <axboe@kernel.dk>
>> Subject: [PATCHSET v15] io_uring IO interface
>> Message-ID: <20190211190049.7888-1-axboe@kernel.dk> (raw)
>>
>> Some final tweaks, mostly cosmetic, but also two important fixes:
>>
>> 1) Ensure that we account the skb appropriately against the socket.
>>    Some network config options apparently return is an skb with
>>    ->truesize != 0 when allocated with a size of 0, ensure we add
>>    those as references against sock->sk_wmem_alloc. Reported by
>>    Matt Mullins.
> 
> Jens,
> 
> I tried using io_uring with network sockets. It seem to be doing the
> right thing. One bit is missing though: "flags" as in recv(2).
> 
> In perfect world I would like to specify at least:
>  - MSG_DONTWAIT
>  - MSG_WAITALL
>  - MSG_NOSIGNAL
> 
> Right now, unless I'm missing something, io_uring_sqe doesn't have a
> place where we could store these. "flags" is needed for any
> non-trivial network I/O.

We have flags for sqes, depending on the type. You can add to the
union that already holds rw_flags/fsync_flags/poll_events? There's
also a (smaller) flags field that applies for all types, which
currently only holds the fixed file flag.

If you're talking on a per-syscall type of flag, io_uring_enter(2)
does take a flags member.

-- 
Jens Axboe

