Return-Path: <SRS0=NI9l=Y6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC98C5DF66
	for <linux-block@archiver.kernel.org>; Wed,  6 Nov 2019 14:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15B62067B
	for <linux-block@archiver.kernel.org>; Wed,  6 Nov 2019 14:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fzZsg08p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731897AbfKFOPi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Nov 2019 09:15:38 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:35964 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731865AbfKFOPi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Nov 2019 09:15:38 -0500
Received: by mail-il1-f196.google.com with SMTP id s75so21924564ilc.3
        for <linux-block@vger.kernel.org>; Wed, 06 Nov 2019 06:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sfg73q48XghSbh0CCQ4+9AL4+ZAk1iYFEp2KjsUi0O0=;
        b=fzZsg08pL9h5yfCA1Uv5ygONtH9lx8/9tWKHfu65SonHYcZximudpl4gdtEZPlFRQT
         ipluQjDTgc8mY5le7pofUxhxKy4hztNfNoSHT+oitwbd+J1BB9BWL6mki7JczYTpfwwT
         v/gtQwtQfAIWtcKbrjGZz3u5gWn82F79n62nIdCK5Ebgx2LIeKOg3ICTefTAhfWtkKl7
         XEmqfWLnBnFda7l9nzEAzNUfaE5IaC4FSX3DJx6HaFHJl9p1U2o7k7ljc2IhLuJVsoKC
         IV9K+I0vHBj5GUmwHbh5vwgRuJgk+HxAkVRW8scqhNiY0ZDdJ/jNXSGXqi6AwJY5+VvQ
         u04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sfg73q48XghSbh0CCQ4+9AL4+ZAk1iYFEp2KjsUi0O0=;
        b=JTiyn63W/80SFyglXjPAwEqd1jcF3WDL/4nqBN5UGfkXoHTuWO1bOF9Cu0MgqIMy8v
         poNk6Av+c7eA3qOwwptfAUM7wCD7KjJo9WlNmpI6B/gTG+NOS6Qb7gaYnZjjJMM9AbOb
         6Pmo2dmMOubTL1SnZ6gMYLZIilXq95bjytn3QuLUgR7N2SE5+GL5odyCf2qZeAmCDzLK
         ku99yvcfOs486rguHuLMXIeiSqtOeSmMh8L47uvP+aFQJsDwYo8ZtG7QvogebVkq6OTR
         dwdkx2sNB9FeGjWJO0B1VATP/T4iWQr+Pv+7BjvQDgAn5/ZCt1JGeXkHgOllX1+8zIXR
         UOww==
X-Gm-Message-State: APjAAAWhDh8wSmTbFogXfJ3xiN1o1OvvmYiEFSHzRuCOM/fq5fQ4w1Tr
        epQLX7raH3ca1OPV37TP7ddOrg==
X-Google-Smtp-Source: APXvYqyPs0lN33Wn9Ir8iVl+v5nSrzeqrGZdBRYUi2vd+kaba+W5TLfb2Pt89TnSUviuSg5/Vyz4ag==
X-Received: by 2002:a92:5c4f:: with SMTP id q76mr2775148ilb.158.1573049737792;
        Wed, 06 Nov 2019 06:15:37 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w69sm3466047ili.84.2019.11.06.06.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 06:15:36 -0800 (PST)
Subject: Re: elevator= kernel argument for recent kernels
To:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org
Cc:     mgorman@suse.de, hare@suse.de
References: <20191106105340.GE16085@quack2.suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1a0539a7-75c2-1ad6-aa5c-bf07a92e1eb3@kernel.dk>
Date:   Wed, 6 Nov 2019 07:15:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191106105340.GE16085@quack2.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/6/19 3:53 AM, Jan Kara wrote:
> Hello,
> 
> with transition to blk-mq, the elevator= kernel argument was removed. I
> understand the reasons for its removal but still I think this may come as a
> surprise to some users since that argument has been there for ages and
> although distributions generally transition to setting appropriate elevator
> by udev rules, there are still people that use that argument with older
> kernels and there are quite a few advices on the Internet to use it. So
> shouldn't we at least warn loudly if someone uses elevator= argument on
> kernels that don't support it and redirect people to sysfs? Something like
> the attached patch? What do people think?

I'm fine with that, my objects have always been centered around trying
to make the parameter work. A warning makes sense to point people in
the right direction. I'll add this for 5.5.

-- 
Jens Axboe

