Return-Path: <SRS0=KrPA=UR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41909C31E5B
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 15:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231B921479
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 15:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbfFRPUs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jun 2019 11:20:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41616 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfFRPUr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jun 2019 11:20:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id m7so2261038pls.8
        for <linux-block@vger.kernel.org>; Tue, 18 Jun 2019 08:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MEzwA9ULYhLNwnhoo4N1GwYOwygy/YcbZAbjiEMw310=;
        b=IOg0XxZkHqyr2tZxsDsA5tkN7HwxZSJMta7Os2nZILRL8AReqA3geTnCrjRv1JDy8Z
         W5wMnJSRrNL9YPUOHJ9rIHmcS8VLgL2oh5rNjjuzLxj1BQPNjQ/Fd/W/vskss0ldDiws
         lvdI4cm8GQU4RLrsSzxqoUJJf2Riedobp5bp8JvEIwMpa5jJPyZ2sy58zUeNwh4xFx8Z
         d5KNv0U+SufAa7nI3K70Elf3kh0XCIsWzeHr1EVDgyrL3FoOGPcsmByyJ/JSdY7P+gm3
         8cmQGcAPpKITboygDlAPRqSQ1IL+bpdDd7oIil9SrNC6f+W5/mSZjHNSi2nb+FRbVHNC
         r9Ng==
X-Gm-Message-State: APjAAAVZjTMXy5xlwAJTskdLYkRDMN75nGdBnpkVm9ohG09yMnPsd4Zo
        zqQmxYDym16EgM4zKGo4IHI=
X-Google-Smtp-Source: APXvYqyN62KJRO9j1nlclEwh67rtJRyL4msdbRcN4L1U2jRubzh/kH5mscxJvcKKrcE6gZm5CChD8A==
X-Received: by 2002:a17:902:2a6b:: with SMTP id i98mr28310649plb.75.1560871246513;
        Tue, 18 Jun 2019 08:20:46 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id u23sm13901486pfh.84.2019.06.18.08.20.45
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 08:20:45 -0700 (PDT)
Subject: Re: [PATCH V3 1/6] block: improve print_req_error
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
Cc:     jaegeuk@kernel.org, yuchao0@huawei.com
References: <20190618054224.25985-1-chaitanya.kulkarni@wdc.com>
 <20190618054224.25985-2-chaitanya.kulkarni@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <790e2fcc-d46a-cf8a-874a-da70f8897d2f@acm.org>
Date:   Tue, 18 Jun 2019 08:20:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618054224.25985-2-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/17/19 10:42 PM, Chaitanya Kulkarni wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Print the calling function instead of print_req_error as a prefix, and
> print the operation and op_flags separately instead of the whole field.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Is Christoph the original author of this patch? In that case I think 
Christoph's signed-off-by should occur first and yours second. See also 
Documentation/process/submitting-patches.rst.

Bart.
