Return-Path: <SRS0=qpPD=UU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF19C43613
	for <linux-block@archiver.kernel.org>; Fri, 21 Jun 2019 16:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0177820673
	for <linux-block@archiver.kernel.org>; Fri, 21 Jun 2019 16:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jcwuwK82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfFUQX2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jun 2019 12:23:28 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:40457 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfFUQX2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jun 2019 12:23:28 -0400
Received: by mail-ed1-f52.google.com with SMTP id k8so10878754eds.7
        for <linux-block@vger.kernel.org>; Fri, 21 Jun 2019 09:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CZ3/5D2qpAiSmlbR4vDefPWBqzf0YzramALDo6qKb6w=;
        b=jcwuwK82t9s9a4nikBJURTIBLZNyor5OemOJX52q69EIaXu9eUsE/d5/lnJ4rpLs6c
         Cy3EeIjQa1XS7mVW86tiRuCP28pEyRLwqMbjBBQl49VNQ15ePAYFxJOfiR2yC3tKGGtz
         6lHNiZv8upF4L5eQhdS5GzZlZ33xtC8QaNsaMJ2vvnGh30GiFpEPkA4P6MjulM6rDim1
         Hvvh540lkq8cEKum9kwuKkrIslELZGumDrrTlzyLLfIFiNy3i6lN07b2J711u+VE61BM
         tg6QsOnR05Vx+Z0gkHihzw9jYg8QPkJA0K776sN19EEsvvNKK8SCdc3Tl+fzUz+oT0hu
         RY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CZ3/5D2qpAiSmlbR4vDefPWBqzf0YzramALDo6qKb6w=;
        b=E0QL2nXVJzSlc6jOtMWiS7O/BL8C79a2vxlRQWiVFUYqgPuGgyRnDTyknCtaUiX1y5
         aZ5TSU2Lmph0IZu1x787ZDme3hqlkg4EH+e6FOCxv4pB5wIL4QWK5TJJHQmgcV5zyKo8
         LLb5qUcCNm1gDFHo3KtPxd7dPCWf+nc/SjXfWj4SBPFkvlUEfGDic8juLkZih3CAslUP
         bWRSWa9IP97RGiMaBmDypXs+y6dBazvICYA+1fsj7ODmU0wp42KHtEw+23/q9aFK7sPz
         ftR3SvCUkibueYGh2vPlzu2qt/HGdnMUnJ0y4uXDBxsekkGERg7i4CcMptky9OzYxhe4
         hr0g==
X-Gm-Message-State: APjAAAWfI9nwZIhahcXjldndPglNM26fkyD1A1fBHT2yWene4Eava7r4
        3EL4bfR8Pq/XF85lGDm4ZzPXZFbrOrmRcAn/
X-Google-Smtp-Source: APXvYqz0H11Mn+9EMa62dJMvMahJwosPx9cXGONodBOcuB+zN4xFLnXtGg7YdzRzTzseaKqoNqY40g==
X-Received: by 2002:a50:c908:: with SMTP id o8mr117795372edh.131.1561134206385;
        Fri, 21 Jun 2019 09:23:26 -0700 (PDT)
Received: from [192.168.1.208] (ip-5-186-115-204.cgn.fibianet.dk. [5.186.115.204])
        by smtp.gmail.com with ESMTPSA id i6sm1005218eda.79.2019.06.21.09.23.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 09:23:25 -0700 (PDT)
Subject: Re: [io_uring]: fio's io_uring engine causing general protection
 fault
To:     Stephen Bates <sbates@raithlin.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     "fio-owner@vger.kernel.org" <fio-owner@vger.kernel.org>
References: <7A8449F0-0E79-43B0-9FDD-45292691F0F2@raithlin.com>
 <4882e4e8-2c58-9c37-9131-91217baa55c5@kernel.dk>
 <0EB5169E-C942-4974-8FEE-9F03B7574F36@raithlin.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <561130eb-175b-7b34-2ba9-5e4cf7e60c54@kernel.dk>
Date:   Fri, 21 Jun 2019 10:23:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <0EB5169E-C942-4974-8FEE-9F03B7574F36@raithlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/19 9:15 AM, Stephen  Bates wrote:
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index 86a2bd721900..485832deb7ea 100644
> 
> Jens
> 
> Thanks! I tested that and it seems to resolve the GPF. I now get a Bad
> file descriptor error in fio (which is I think what we'd expect). If
> you turn that patch into an official kernel patch feel free to add

Yep indeed, it's supposed to just result in an EBADF cqe. Thanks for
testing, I'll queue this up.

-- 
Jens Axboe

