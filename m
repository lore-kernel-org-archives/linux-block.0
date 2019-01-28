Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B37C282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 18:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2092621738
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 18:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JGErBXKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfA1SZR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:25:17 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:56153 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfA1SZR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 13:25:17 -0500
Received: by mail-it1-f196.google.com with SMTP id m62so22038964ith.5
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 10:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XnHohwj3TQgPNEGAnv9zwxSTsbH3k3pYQxtr3CHUQSc=;
        b=JGErBXKnWfaRgO9+xwbiTBzxV0yyDflAb1YBR/pz8iL+YLtnuTifc1tH78bI+tfd8F
         PHWh76HDd8JvYP/ZAfy25mwnU4NOwe8O4zMxFFTWI4kW2SWOAk1/sqg+YiY0nyXCkQ+J
         lwUm132T48LhoYMy9XHvLhGpPNCLaAsGQcDiw4PDdATqM3Ch+NSzsDl9qh3XDy3LKPAX
         KMJkRAOm6FwsdsShLqn++gTCcXGb6gL6QNgcAooxUqKbwETi61jEmG1HdeTD+TX4fdg5
         1e0TBm00LN2/l6p6gOgy0saGu+n8obuES9N9UjDb2WUDzyr+478Q3WPxbaW6cTTojfGw
         pK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XnHohwj3TQgPNEGAnv9zwxSTsbH3k3pYQxtr3CHUQSc=;
        b=kopoKivsjHpK4PD2e3Bd8zgmDr0Bum+WlmoY+z+k97xTH0JmbfZAaR+t7RsbbfoEYn
         ktJP2n+sOUNxMiPYY2onlxWr+HmZMyBZB13mp54Q6b6GW9IOIvUew3Ny9rVEL4LB+/RC
         Lt3ZgRsxZ6TnmYwZ2a31ROhfK0Irt6t2YHyJkzxaaj8cLBUCDzbpaxNW0Z3mSFk7Mngp
         UPpA1rH/euqms1bUeUg0P/a4TDRe0Bp4NhK45qTfHijmu4kR0CTH7FBwD4/8nYQ+1MX9
         8D2XJC7bjUVBeGn7S0aXwjGvhZWIs8zIPBhYOpA4aq381Y4t1IdElWeG+7lygPG9xLhQ
         lXMw==
X-Gm-Message-State: AJcUukdypxDcx8UKspyOd8QQHzlJJ8FGuOANrdyDnX6Qtt/5JnILjw/J
        KyRJyraRFXE1GNw6ynqiVk5/jw==
X-Google-Smtp-Source: ALg8bN4sh3CxUNxv2RvZNKBayMjjvEXmkAENC76sAxO5111ExiQPSHyTyDqDNAAoJzivNFx9Kycltw==
X-Received: by 2002:a24:6192:: with SMTP id s140mr10494062itc.97.1548699915777;
        Mon, 28 Jan 2019 10:25:15 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r195sm98512ita.3.2019.01.28.10.25.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 10:25:14 -0800 (PST)
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, jmoyer@redhat.com, avi@scylladb.com,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org
References: <20190123153536.7081-1-axboe@kernel.dk>
 <20190123153536.7081-6-axboe@kernel.dk> <20190128145700.GA9795@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2729ab43-b2bf-44b0-d41d-dbb495ddffbf@kernel.dk>
Date:   Mon, 28 Jan 2019 11:25:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128145700.GA9795@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/19 7:57 AM, Christoph Hellwig wrote:
> [please make sure linux-api and linux-man are CCed on new syscalls
> so that we get API experts to review them]
> 
>> io_uring_enter(fd, to_submit, min_complete, flags)
>> 	Initiates IO against the rings mapped to this fd, or waits for
>> 	them to complete, or both. The behavior is controlled by the
>> 	parameters passed in. If 'to_submit' is non-zero, then we'll
>> 	try and submit new IO. If IORING_ENTER_GETEVENTS is set, the
>> 	kernel will wait for 'min_complete' events, if they aren't
>> 	already available. It's valid to set IORING_ENTER_GETEVENTS
>> 	and 'min_complete' == 0 at the same time, this allows the
>> 	kernel to return already completed events without waiting
>> 	for them. This is useful only for polling, as for IRQ
>> 	driven IO, the application can just check the CQ ring
>> 	without entering the kernel.
> 
> Especially with poll support now in the series, don't we need a ѕigmask
> argument similar to pselect/ppoll/io_pgetevents now to deal with signal
> blocking during waiting for events?

Is there any way to avoid passing in the sigset_t size? If it's just a
32-bit/64-bit thing, surely the in_compat_syscall() could cover it? Or
are there other cases that need to be catered to?

-- 
Jens Axboe

