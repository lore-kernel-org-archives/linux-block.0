Return-Path: <SRS0=93Gy=OS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBD9C07E85
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 14:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8145820837
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 14:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="J8T2ELfI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8145820837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbeLIOhZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Dec 2018 09:37:25 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:47064 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeLIOhZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Dec 2018 09:37:25 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so3755720pgp.13
        for <linux-block@vger.kernel.org>; Sun, 09 Dec 2018 06:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fuIiQkKShVSvqxTwy7zm/xDAJXHW6FXHBL5uLpnmyxk=;
        b=J8T2ELfIj8v2GKOLfAJ19Te+S26b4cYY5N+zw+zCE/TWogEf2X4ZTqaFo7AAipKYXS
         Q2acigZRxw7KEFsDVc65tEFoGRWKjKFWl+9aY7X0gFgGdOGiW/k/8r6H2lVvbKoBhdz6
         xHZ0UL64QiamkxaE+pk8EMkGZPT9AbkOqGrcE4TWF4/+qO2AlkIsefGt/et3fPlvSDw/
         uBaOjj58ZLcwxjm/VyP+1G6YacxAIoNDNU/LGogBBf46Nu3cbQ/A5gTETirO/VLviurl
         /kylOk6QPevMsjNziedcWYsZM3XvMtad5inXLUHicsWxD3R6YqNE1h0/Lv8lYQR1D47K
         KhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fuIiQkKShVSvqxTwy7zm/xDAJXHW6FXHBL5uLpnmyxk=;
        b=YymDEgow97720BD6mvmWUSK9XUEaDkVcXZsK7Bcp1xKm/aG2y2hpPFV4C3KhA7QEne
         q62Se4HOIp7fpiElLoFK5473YdIKIU/C5pH4wnr2zhu8YvQedx7aBnTmaPKA9uAgUdFO
         1MTn/YRvHVACTxA0FKV4oAjrNfSQh+RbN5xq7xl3wgMBG4rO1GPoukyp1v6b59IXBBDq
         lywe0/oOesJPQKt1GMaHihDqu1tOQ0UQrDbWsS3pZp5hsWMjtyMhzAcqo/5lyWe4vRmR
         xJQUOWyK07lkdg3cQiidKlIZXW/zjpZ/LWNdXAqdOu7Q57NR0YbAelfB/LjYHtJlMGKM
         k03g==
X-Gm-Message-State: AA+aEWbkI4p42RGvvr2L/FSbKtmtuZeBCQ82lqlocgVZm8FZnlVsBtBh
        vZCb4x5q1B56JIxnexlNCxzM8w==
X-Google-Smtp-Source: AFSGD/XythI9IEIWoa6sMBSko4tS1Pwmjvyqz80GT41vBVuEI9zzY7C6XzHn5GXNSr5rAsJ3syRrGQ==
X-Received: by 2002:a65:62da:: with SMTP id m26mr7923114pgv.278.1544366245136;
        Sun, 09 Dec 2018 06:37:25 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id k14sm9218378pgs.52.2018.12.09.06.37.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 06:37:24 -0800 (PST)
Subject: Re: [PATCH 13/26] aio: add io_setup2() system call
To:     Benny Halevy <bhalevy@scylladb.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com
References: <20181207222016.29387-1-axboe@kernel.dk>
 <20181207222016.29387-14-axboe@kernel.dk>
 <a3a53e7fad297a71149efd718f1fdaaf852c0f28.camel@scylladb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d60bc583-1cb6-c081-f00a-726d9780b7d5@kernel.dk>
Date:   Sun, 9 Dec 2018 07:37:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <a3a53e7fad297a71149efd718f1fdaaf852c0f28.camel@scylladb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/9/18 3:12 AM, Benny Halevy wrote:
>> @@ -1281,6 +1288,34 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
>>  	return ret;
>>  }
>>  
> 
> How about adding a comment similar to io_setup's below?
> 
> And would you like to mention also io_setup2 in
> Documentation/sysctl/fs.txt?

Sure, I'll add a comment for this system call too.
 
-- 
Jens Axboe

