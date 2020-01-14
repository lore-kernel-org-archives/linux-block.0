Return-Path: <SRS0=JLuE=3D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDCAC33CB3
	for <linux-block@archiver.kernel.org>; Tue, 14 Jan 2020 20:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1CF82467A
	for <linux-block@archiver.kernel.org>; Tue, 14 Jan 2020 20:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="D2zHMCun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgANUiL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jan 2020 15:38:11 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44435 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgANUiL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jan 2020 15:38:11 -0500
Received: by mail-io1-f66.google.com with SMTP id b10so15331817iof.11
        for <linux-block@vger.kernel.org>; Tue, 14 Jan 2020 12:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UYuAvyM6eKkIdewcDd2HsrDUAjfpLHDq9QI0D6aHqnA=;
        b=D2zHMCun7ScFcsJf2i7ZNI4jQignTqfQ3oHuAqqRVrYDNz890tv9MYJs5yQ8rBMD39
         5AdqZMhAFRDXnX+IYt5JhkOffONeVZYQzWtlveoEWCL/DzbK1f24PY36kc/uOtVloKSe
         ee/Sr4q5cLlGb/exKZuYxnKYmPx5hSIbvSuMlkFFJj5XI/P0mVlng+uTC0qipALhDpMQ
         RcBMeFDDyHJ0eA+6t9zJspvf5Z28urQrKGVfIgdvgrb47oBRz1N1obwTuSGI0Bwn4qYp
         0ydsPRbzPysmru8NUz5pXkOI/VJygp8GuWwRot031WKTTqr/64fJPBoYLDLrFLbIcw4V
         RviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UYuAvyM6eKkIdewcDd2HsrDUAjfpLHDq9QI0D6aHqnA=;
        b=ZjxNqdeELwpC4ZQvrgL8I/AaZzT8EyqFThh3FVJ9AE7UjxLv3BoIgvs9De5ly4JirH
         SUCoWswdqcTyWyjVf0cuXUHEuRiGZukPyu3jM96F+pICTM8CO8y/FB59MjxphMTnkgtH
         ZWgix98IoQ1V0Md0CXtNUBp+UhNRW8nTwc2j9t+Q3iCaApl+yO/sIcZZJXlfxS7vcffZ
         mitHt4yOvSdvSpcqHn9iogUSDwUWLqWg9cRPHbZGg2SOwwotVj8GU5YAuSdZJGrbOox+
         eJwiOgGj6Ut4+ZI4LRi7Km3gqtI7cEeM42oAZEeU/hLl6iVlP6jAAhRUlWXLWN88+fYQ
         GQWw==
X-Gm-Message-State: APjAAAXX9x8QfMhqfEuMKQjG7DA2ObGCtss2k302SJIe3OmmvGg0vN/m
        6h5/zZQZdLjOLnfB4kQm31aO8A==
X-Google-Smtp-Source: APXvYqyNm4MvD2hJ2cWcIeEqueLlPTm75AYaWoijguRzNhDQ2/uAXGSZV2BPwZH+FuTDS2f4S5jGVg==
X-Received: by 2002:a6b:740c:: with SMTP id s12mr19790805iog.108.1579034290369;
        Tue, 14 Jan 2020 12:38:10 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s10sm3754869iop.36.2020.01.14.12.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 12:38:09 -0800 (PST)
Subject: Re: [BUG] bisected to: block: fix splitting segments on boundary
 masks
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Chris Mason <clm@fb.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200113221317.0e27f0a9@rorschach.local.home>
 <e8bd9824-20ff-03e0-c289-e77c4f6669af@kernel.dk>
 <20200114153456.2cbae42f@gandalf.local.home>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <421d2492-ec70-b5aa-26bc-dd3fc1e6c14d@kernel.dk>
Date:   Tue, 14 Jan 2020 13:38:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114153456.2cbae42f@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/14/20 1:34 PM, Steven Rostedt wrote:
> On Mon, 13 Jan 2020 21:09:41 -0700
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> Can you try:
>>
>> https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.5&id=1ca6b68e516b3de3707ae2cec9e206c8f9dd816e
> 
> This appears to fix the situation, Thanks!
> 
> Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks for testing, I'll add this to the commit. It'll go upstream in
the next day or two.

-- 
Jens Axboe

