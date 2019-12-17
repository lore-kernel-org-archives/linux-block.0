Return-Path: <SRS0=G4H8=2H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAD4C43603
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 16:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFA421D7D
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 16:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1YyNrajD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfLQQl7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Dec 2019 11:41:59 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:46269 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbfLQQl7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 11:41:59 -0500
Received: by mail-io1-f68.google.com with SMTP id t26so11290650ioi.13
        for <linux-block@vger.kernel.org>; Tue, 17 Dec 2019 08:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ch4pT9eAXuOnt9aCH34myvOKU14iVJ51Ia+nfld+XYo=;
        b=1YyNrajDUI2YIJxfCBALtwSAK2gvsMNAuP0i91YlCmUz62ouZ6WF1tT0fHhFeP/6Ja
         EHZRByZL6AsLF/yq7ZXwddBIxpOtC834HnFFkhzOIjYLlj44wlN+t+zxwxW7uK1NWN6X
         EP8j+6iX9riGl8ah/2GW3uiI5Xo+n51YlZ9VhoJp5FV3NPliTgjfmJ9VUN+0qr6I+Ho+
         YDcLmboVyDfRbYuvkgX8u9opGEQnwa8kyVxmmJyKXJq5H15fJiXxU0wiDyKZ8F2o3BAP
         adbhsTtK31AwYA+23QClWWweac1izfxeW2Ls+kOpiOQz3ScW5Su3tycEnWNzSWjmzan2
         mwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ch4pT9eAXuOnt9aCH34myvOKU14iVJ51Ia+nfld+XYo=;
        b=PBYE510kW9a1tlSk4LNdOFlWa3Fe97RB8a1/88ONf3QpfmpwXeIv8TcFAIgRY7imBU
         wyACIgBWiv/ukwK1RP9uiYuRTatiCz1ZLtfeYF1PIYorUoWg7nQ9M+0kTa23/TiwwLFh
         X+SccKz9WzbA3e4UqqbPqv519vLELuIbnzHkjbJ0atZlMbh39ktmtVOSTaEVKy++MjMa
         Y5eWf6s2NeZrofF5Wbc6MJtBp0ayRNGPsnQeQfKOuNlxyEgOSjoZV/IChFkBSoyK0bKO
         LSMcqTTPtkVdHRb6a4D5IxwFLd7OCLjuBR5LgwKwC0am8rP6QEhZ76I0nltd2/YpcouF
         gmlw==
X-Gm-Message-State: APjAAAVi27ptr9TOvX2YSTb/zFlcei7xy0IesyHxbwHT7QJ7RIKGogA2
        ui+bIq5ga5ocwAQ/+l3Du5IpIA==
X-Google-Smtp-Source: APXvYqxh5lsU9Ndk/BeMGn/zyvX+NgyYy2mh8ckeftTI6DIJt9pRgxZcg+f8Hepjj4yJa16wHgtlKA==
X-Received: by 2002:a5d:9a17:: with SMTP id s23mr4524073iol.293.1576600918943;
        Tue, 17 Dec 2019 08:41:58 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s64sm6948214ili.56.2019.12.17.08.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 08:41:58 -0800 (PST)
Subject: Re: [PATCH 1/6] fs: add read support for RWF_UNCACHED
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, clm@fb.com,
        torvalds@linux-foundation.org, david@fromorbit.com
References: <20191217143948.26380-1-axboe@kernel.dk>
 <20191217143948.26380-2-axboe@kernel.dk>
 <20191217155749.GC32169@bombadil.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <65992df0-1ccf-a51a-9ae0-43a0c268b1f4@kernel.dk>
Date:   Tue, 17 Dec 2019 09:41:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217155749.GC32169@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/19 8:57 AM, Matthew Wilcox wrote:
> On Tue, Dec 17, 2019 at 07:39:43AM -0700, Jens Axboe wrote:
>> +static void buffered_put_page(struct page *page, bool clear_mapping)
>> +{
>> +	if (clear_mapping)
>> +		page->mapping = NULL;
>> +	put_page(page);
>> +}
> 
> I'm not a huge fan of the variable name 'clear_mapping'.  It describes
> what it does rather than why it does it.  So maybe 'drop_immediate'?
> Or 'uncached'?

I do like 'uncached' a lot better, I've made that change.

> I think this needs to be:
> 
> 				if (!did_dio_begin)
> 					inode_dio_begin(inode);
> 				did_dio_begin = true;
> 
> otherwise inode->i_dio_count is going to be increased once per uncached
> page.  Do you have a test in your test-suite that does I/O to more than
> one page at a time?

Good catch! Yes it does, I have fixed that up. Thanks.

-- 
Jens Axboe

