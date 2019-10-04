Return-Path: <SRS0=jhC6=X5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E27C47404
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 15:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F93222C5
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 15:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Z8s9z0zv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390071AbfJDPpp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:45:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45677 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389880AbfJDPpo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Oct 2019 11:45:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id q7so3945705pgi.12
        for <linux-block@vger.kernel.org>; Fri, 04 Oct 2019 08:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TC99C2pKhiaK2L0mj891njVUowa6oqX+okTQ6jqyH0Q=;
        b=Z8s9z0zvbZTTO41KCuq5iY6Yqr26n59aDOl2bvp3tAy3azkc3ZLeLEn4jdLJ7h2sui
         YhnrKIRyZYpgkv4NybCGh8aZHxPtWYHdZ8i2YHhSyzFI+Sr8fSnLPoiI/nQil8bTeSVT
         rzd7qPayrvd7qE8xQaR9SIw16rtoP8Q7JBofa4Azz112NzSJmGJz6gXj77nsqcrTgmHx
         FCoJQh+0WIrsBVtNyPGNxnHMYsYYqejAERhmtoqzJzKRd+cefGm4V12B1YxAYKAwALtj
         AMi6eLd4j+urStexgEzV1SDWicU5EoN105xSPGijOS+fORlrBJdk6sBnC05oHir8oMyb
         xvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TC99C2pKhiaK2L0mj891njVUowa6oqX+okTQ6jqyH0Q=;
        b=LvH1npoxVT5MAfc2cvbKKf/81dUBeZH+Yv1NW0VDhQESNVGVhrQZzf59bJS7/HCT1P
         uqQdREPTQLRVFXNhy70O5aKZvxj/mXPcvJENCTAoWJHJef6SZUAONF6Au9q1/hPeGDFa
         /59pUoYujNocJYAe7T2yMwldqgOCKJJYxKgwatqigcLT4TgwdHAKvLaMsybUf38uXECp
         sFXmFX9zfjhIGU8ntpOH2OW5dYARClujGboH1JUfiWpy25OSevhfNuThFfmR0YBEdgXe
         bNbfpE9IFebp9kvVGzr/tVz/A3MTXWSEpdTQ+CvT9NRlsNSFMXtWTn3At+jBBv1fNIzz
         Y7oQ==
X-Gm-Message-State: APjAAAVILWQH0gOp87QutMt0Uesk5xSgKrNYS+mxaJnj6jkVmODT+s2w
        NtWfdGXV0RNL2hoLBkccW6hAHT7OLpRJyQ==
X-Google-Smtp-Source: APXvYqx67P8YCXR94iMDLSQXg7fxKgAkyOTeJRs+K4reIVLvTiJ+K4QtRgENsChEgittngAD1ppn9g==
X-Received: by 2002:a17:90a:5ae4:: with SMTP id n91mr17810811pji.143.1570203942856;
        Fri, 04 Oct 2019 08:45:42 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id u5sm8907511pfl.25.2019.10.04.08.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 08:45:41 -0700 (PDT)
Subject: Re: [PATCH] io_uring: add support for IORING_REGISTER_FILES_UPDATE
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <a7bc8d7f-2379-7492-93af-6ca0353c5eab@kernel.dk>
 <x49d0fcmsn8.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bbf022a4-9091-1e65-8516-aab39942e958@kernel.dk>
Date:   Fri, 4 Oct 2019 09:45:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <x49d0fcmsn8.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/4/19 9:34 AM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> Allows the application to remove/replace/add files to/from a file set.
>> Passes in a struct:
>>
>> struct io_uring_files_update {
>>          __u32 offset;
>>          __s32 *fds;
>> };
>>
>> that holds an array of fds, size of array passed in through the usual
>> nr_args part of the io_uring_register() system call. The logic is as
>> follows:
>>
>> 1) If ->fds[i] is -1, the existing file at i + ->offset is removed from
>>     the set.
>> 2) If ->fds[i] is a valid fd, the existing file at i + ->offset is
>>     replaced with ->fds[i].
>>
>> For case #2, is the existing file is currently empty (fd == -1), the
>> new fd is simply added to the array.
> 
> If I'm reading this (and the code) right, that means you can't add files
> to a set.  Wouldn't that be a useful thing to do, instead of just
> replacing existing ones?

You can add files to a set, you just can't grow a set beyond the size
you originally registered. I actually forgot to post the pre-patch for
this, which is:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-5.5/io_uring&id=fb3e60f87aa43f4f047f01243d6be54dadd9d67a

This allows registering -1 as the fd, so you could register 10 files,
but an array of size 500 (for example), and the last 490 fds are just
-1. Then you can use the IORING_REGISTER_FILES_UPDATE to replace those
empty fds with real files later on.

> Can you post the man page update along with this?

Yes, I'll write the documentation too, just wanted consensus on the
approach before I wrote up documentation.

-- 
Jens Axboe

