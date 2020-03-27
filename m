Return-Path: <SRS0=yDPB=5M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FADC2D0ED
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 16:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5DD20675
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 16:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DkxLtJJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgC0QSz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Mar 2020 12:18:55 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:37633 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgC0QSz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Mar 2020 12:18:55 -0400
Received: by mail-pj1-f53.google.com with SMTP id o12so3976063pjs.2
        for <linux-block@vger.kernel.org>; Fri, 27 Mar 2020 09:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UquzxbwmO78QKCJ8GvUGG+PHBO9lh8BRRDLn/bTE84s=;
        b=DkxLtJJ61uWVyKpBlbNQrHrYvOYuLDf8xNt4TLZ+KPWUyj+lJosKVG22FtvtiB6yf/
         HQxg1JsJgQ2oQpC0RGq2WENmA+Y5oMA9RvVsfM0Za8v9w5z0lkMo0aqPQ+21Fsp2XahU
         2IBybYChfgjVaPCyFtWaqk418x/IJdXYnbjxBnzHnyitlujPApriYfEofNwR+hKwiMLN
         TZAISXMZvXlR7a/EI66fJcI4ZilnOIdRjiYk5RMLdhTpKTkcOiGWamKMO7bjEsnojK95
         DvgdvidNJdagQkU7HOe1hbjP8UvoUQVgg0mGD42U8fj9fuA+FTimVeWJ9UyO1jfuK+Ad
         9mHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UquzxbwmO78QKCJ8GvUGG+PHBO9lh8BRRDLn/bTE84s=;
        b=ZpsVsBA6QPcEfMcEJdsqB19+FDhegoKaz/tf3WSEgpacZHMGpxVRv+FSp7olw7ygaV
         JFgzhTfENhwffy+zASHUgKRcchRG6O5MzoNDC3D8pVaU4XWudhmOZQVYe5o0me4zmvF2
         Zd0Lqxq0lqomJR2iq667OJJkYQynSVdxi9GLjklFehaObmbE8LqOmf1KUbmnIdJwjmqu
         E/FbOjjrWaPcRqnmT5cY/hP7WMu9WZTyWjXDlHYx2mr+NJRLeF9KVjBCtS7VTEPuRn7C
         ZdBvP7/gV8GLelHzcRPkXovF9isLA06E42VMn3IF1LT57BbAetgJ93m+zL2AxZi70X9X
         8Nhw==
X-Gm-Message-State: ANhLgQ1i/pMtEmlpGZqkIX/8vgeCTzk1m+jWJGfyYLiuZGyDQ848h6Ls
        hJV7PGw8il+J1VBfh1/HoNNXlkPDzavx+g==
X-Google-Smtp-Source: ADFU+vuVl9MB2Gp7aINk2gq8j89Z73xugxEyUifYbhIbdWR0EkZLXaGJ8Y9aD9YArtjcEwWNDNr8dA==
X-Received: by 2002:a17:902:40a:: with SMTP id 10mr13517789ple.183.1585325933514;
        Fri, 27 Mar 2020 09:18:53 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id v14sm4459229pff.30.2020.03.27.09.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 09:18:52 -0700 (PDT)
Subject: Re: simplify queue allocation
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20200327083012.1618778-1-hch@lst.de>
 <b1123d19-0c4a-5d3d-d0d4-0a412830c2b0@kernel.dk>
 <20200327161754.GA19480@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <21bb5f8e-d395-c8fe-bf08-00e4f37cbb69@kernel.dk>
Date:   Fri, 27 Mar 2020 10:18:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200327161754.GA19480@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/27/20 10:17 AM, Christoph Hellwig wrote:
> On Fri, Mar 27, 2020 at 09:53:16AM -0600, Jens Axboe wrote:
>> On 3/27/20 2:30 AM, Christoph Hellwig wrote:
>>> Hi Jens,
>>>
>>> this series ensures all allocated queues have a valid ->make_request_fn
>>> and also nicely consolidates the code for allocating queues.
>>
>> This seems fine to me, but might be a good idea to shuffle 4/5 as the
>> last one, and do that one inside the merge window to avoid any potential
>> silly merge conflicts.
> 
> they should be trivial to reorder if you want to skip patch 4 for now.
> But looking at current linux-next there isn't any conflict yet,
> and I don't expect one as most block drivers go through the block
> tree anyway.

Yeah I guess so, and any potential conflict would be trivial. I'll apply
it and hope for the best.

-- 
Jens Axboe

