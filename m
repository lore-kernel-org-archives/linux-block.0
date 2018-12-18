Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A884AC43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 13:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764EC21850
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 13:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kN1pwzFP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbeLRN1n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:27:43 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33886 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbeLRN1n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 08:27:43 -0500
Received: by mail-pg1-f195.google.com with SMTP id j10so6614556pga.1
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 05:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vFs5EMo+qzZrwTe9qGLzYDZcdil4JGTc1uk4DSdikGA=;
        b=kN1pwzFP3BOWzf2Qf3RCfM7xKPozHqW741ilB7AmyrXzz2kMgPJzHC8+selsrNWpxD
         KO/s+biKPVAfNcz6UsQAQy+6nssiJWucEmvkuPTBUcFzxNDgfls3pP60nXr2WQoMKErw
         WxzzXKjUp4ckNd0gY81VmedPv+VZfUgAvrNhUePk2f5lz37sBLiPIrTfb2E3wAQTp1GA
         n7oE7e6D3DXFeV/SF0UppBHP22DnKBctKLs9mhvhj1n/buAn5CGZx+y/X4SZenj4YBol
         DWhcZlBteymEt3IkIANhgXf1jYPczL0KuqmGZK+zYcZ5McmHGAupIi9BHa+lbEEQh/dM
         nAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vFs5EMo+qzZrwTe9qGLzYDZcdil4JGTc1uk4DSdikGA=;
        b=tj38XqoJKaex5MOHaPI9YQJU6pR5GFGwf2NjkLeqMVFiu5I+A7GMZGRWrop0/TZvwh
         Htft4L4XV5xUlXL7wd6hkq7FRxTHTRuSokttEDHdStlETEe7IOsrchexqOKCaN1mjF7y
         YtM7fWrbfK92ceU7D4gsmAPVdmwVbJDC9MjBlyZcV3M22sJhnCzViyuaJHMrHYiDbzsg
         LdQOJQQlZ8B9j2melhH3dVC7EJIiGZ8Jv0BtTWKd68p+Vt9MvssvFMge+KTRiSQOYRqx
         61rNThw96lSg4ewstniNMe3MO8pgNjYiDb1EjdKiWVlWhcON3+vlR6UE9D7cJwDxfIOZ
         Z35w==
X-Gm-Message-State: AA+aEWb92u+VYaZjQ4Beo2FZLlr7n2ja2k48NExmtBi5wrTO/f+TS6Z5
        Gi2hKxV/0mYet4h/pdHWnKAdXQ==
X-Google-Smtp-Source: AFSGD/Uenji7xumJs2sGJ9blrtu3PEhSipMMvZVEeIaVopWdTdKBfvcht6f34JHTVHCljxBO8uBptA==
X-Received: by 2002:a63:5b48:: with SMTP id l8mr12654416pgm.80.1545139661893;
        Tue, 18 Dec 2018 05:27:41 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id w128sm21669372pfw.79.2018.12.18.05.27.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 05:27:40 -0800 (PST)
Subject: Re: [PATCH 14/26] aio: support for IO polling
To:     Benny Halevy <bhalevy@scylladb.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com
References: <20181213175645.22181-1-axboe@kernel.dk>
 <20181213175645.22181-15-axboe@kernel.dk>
 <d0ad25816ccc6fcb388b34f5e0d42ea9105c9097.camel@scylladb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7e207359-6ee2-bce2-3c17-be328a965333@kernel.dk>
Date:   Tue, 18 Dec 2018 06:27:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d0ad25816ccc6fcb388b34f5e0d42ea9105c9097.camel@scylladb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/18/18 3:32 AM, Benny Halevy wrote:
> On Thu, 2018-12-13 at 10:56 -0700, Jens Axboe wrote:
>> Add polled variants of PREAD/PREADV and PWRITE/PWRITEV. These act
>> like their non-polled counterparts, except we expect to poll for
>> completion of them. The polling happens at io_getevent() time, and
>> works just like non-polled IO.
>>
>> To setup an io_context for polled IO, the application must call
>> io_setup2() with IOCTX_FLAG_IOPOLL as one of the flags. It is illegal
>> to mix and match polled and non-polled IO on an io_context.
>>
>> Polled IO doesn't support the user mapped completion ring. Events
>> must be reaped through the io_getevents() system call. For non-irq
>> driven poll devices, there's no way to support completion reaping
>> from userspace by just looking at the ring. The application itself
>> is the one that pulls completion entries.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
> 
> Looks good to me, thanks.

Is that a reviewed-by?

-- 
Jens Axboe

