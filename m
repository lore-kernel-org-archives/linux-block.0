Return-Path: <SRS0=2XXV=ZD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A980DC43331
	for <linux-block@archiver.kernel.org>; Mon, 11 Nov 2019 21:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF5C206BB
	for <linux-block@archiver.kernel.org>; Mon, 11 Nov 2019 21:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="eZ+Ecjx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfKKVm6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Nov 2019 16:42:58 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32967 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfKKVm5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Nov 2019 16:42:57 -0500
Received: by mail-pg1-f195.google.com with SMTP id h27so10325961pgn.0
        for <linux-block@vger.kernel.org>; Mon, 11 Nov 2019 13:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=1QzZLfIquYNV8rTA3qWxVcu8tp+90RTByQhwVFeYvg0=;
        b=eZ+Ecjx4dQUJzGlsnYGaPUK1fyIJ5ji12NLu9wJXgyGUe+K90aYG1RaGbxg14Z/ZRk
         MRDGkCd5EJGFvVjdu86Hl9snnVZ1tNGwJpGtFJeHx+3J4PwrFz2kk2kwCX6SKGvKCV7w
         yny6n1UiGvtrVaCvWllM+3pJDmfhifTlIUBmGYuWNtrZoKwvgZGV4EvdbDEJGlfT/ywr
         AuWtaO9rDjCzDgUINhpr8APKZMMXDaAdAzoM0f1lIRHWvoFSDHj53gy7tNUvpf+i2yi2
         PdN2ejPPFFg3WAi06g4PWc17MAdm5IUYOYRlYEWXjHz+L4ST0adc7paVc1NxkcmAzqG4
         a/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1QzZLfIquYNV8rTA3qWxVcu8tp+90RTByQhwVFeYvg0=;
        b=d/ieig3G7FhRJG4Skh7JE7acdWAMe42eqKXuRhUhY3EQwOwkoAcHHRAs3yWXoLbZrB
         XapvelaM6own/p1xCcBJEdhSQeKfRPuPgICxpVVcnlYPz7G8rGLHOmkN9Diwo64I8B0p
         Y89n4YAElD3zUhEK89/8//pBaN6lNq3SgAbVpFJmrdIwBX80CPVZcSsTsLNDw9+VIG0I
         Aj+xS/gi7ZHX9R9U/VezruX7gXAjKxnFJ2N2vCRmymzhwjkJ9Ozm9dDOMtMPXrECxzFH
         fGtoQcJQmN382rFF6iwCvM5z5r6XEB7jhOzuPzRTsl1xOX3H/kFs5kle3lhZUST+2G/y
         AwfQ==
X-Gm-Message-State: APjAAAVNze3brwG5CuqWYSgF7tZBfs3Mn4UXUOeedzc1CvJrFvj7qMdE
        xdIL22IVfk9HN1TZKuEtWyV2eAWFhzk=
X-Google-Smtp-Source: APXvYqxxPzCzp27m0VtsLQSHvs8vniMwJ4R9Bl6N97YUgGmre2vNv8zd7Slgn6R0oeZNMDE/p8Ikag==
X-Received: by 2002:a63:1323:: with SMTP id i35mr31596422pgl.450.1573508574992;
        Mon, 11 Nov 2019 13:42:54 -0800 (PST)
Received: from [192.168.201.136] ([50.234.116.4])
        by smtp.gmail.com with ESMTPSA id g6sm14823210pfh.125.2019.11.11.13.42.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 13:42:53 -0800 (PST)
Subject: Re: [PATCH] io_uring: fix compilation warning
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
References: <1573498948-27573-1-git-send-email-chaitanya.kulkarni@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d7f99bde-706e-c381-9ce5-15d80e4916bb@kernel.dk>
Date:   Mon, 11 Nov 2019 13:42:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573498948-27573-1-git-send-email-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/11/19 11:02 AM, Chaitanya Kulkarni wrote:
> This patch fixes following compilation warning :-
> 
> fs/io_uring.c: In function ‘io_uring_cancel_files’:
> fs/io_uring.c:4280:25: warning: unused variable ‘cancel_req’
> [-Wunused-variable]
>    struct io_kiocb *req, *cancel_req;
>                             ^~~~~~~~~~

Thanks, I folded in a similar fix last night though.

-- 
Jens Axboe

