Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E92C76195
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 22:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjC0Wn0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 18:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjC0Wn0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 18:43:26 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA9A1BD1
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 15:43:25 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6261eca70f7so472871b3a.0
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 15:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679957005;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3iXXnfnF7EI/235mK2HYTkO3Rz6p6PkVQjqgI8pFLS8=;
        b=gB9cpIctyhEGEmO31zPTfRjbU/7BclW223yi7gcRtZchTOqziIh975i9d7WaEjtQIU
         wWiGhE+Do/ajniJGPoJ3XRTup7xa/aHW/NzAJc5CyObQW8GcJc05n9o7nCcrs3YR5iVS
         YqN74rupvrELYorpYqfVqmv31SmAXvSp2zSXZvnBBVizu6hZIseqSsht4S8lhXhvCVmh
         fqjgVA2d1lsvCTBf1AFqWhwKGDoC8uHMzPJn6kVLLyJCpEQcRvaUqAWPlwuZKSaFHhpv
         mNVroGtwvif6/Zllr0zIPwbwr8FcFlNubR/lUkrVaH2QgrP9K1Cge03bC+AusXP4ZRY9
         D9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679957005;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3iXXnfnF7EI/235mK2HYTkO3Rz6p6PkVQjqgI8pFLS8=;
        b=hbOAlbEB8i7PTu9QDipxvj38mMdzkg0Exllx//1tG0KXGS3KwDJYlDcpRhHxhsbt8o
         FYa/64pce90dRbVKVXZ8WK7Os/x5D7BemTFWt7HkOmHfU1LxyFNVN9IKOhV0qf6CZ6BS
         1+iuqYMjncj0fBImsz7epYWvcyTqWCkU+CX/3woRJZ+5B+JGQ+pJWpF5PO7bJiVA5OrC
         qojBqcPi5X9JPzrTybcMbiiBGAP4AgOKYFtHfVLWSHhyKck5i4gSaGKq0ZJ7kEtZ+Oya
         JiF9LDPQrdZ6dgI8vS4yHMnNkGIufHbs3y4xuDeqFYBg9uKTTBpdqiorGyucVHYJfNx6
         B2Dg==
X-Gm-Message-State: AO0yUKWJKxiJTekeB+AQEQUbUVbgJCrQbTVWxMPyYgz2f6Xtxw6brYTb
        LUnS/HYgGftnADH+5zdDcoqzmA==
X-Google-Smtp-Source: AK7set94owwP0CqP3tPCT1h5HEeDocJVWzVWnlxMDfnTchCBI6/dET1rrd6iMGR+xsUSG4ngfraUrA==
X-Received: by 2002:a05:6a20:748c:b0:cd:fc47:dd74 with SMTP id p12-20020a056a20748c00b000cdfc47dd74mr14797786pzd.4.1679957004631;
        Mon, 27 Mar 2023 15:43:24 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q27-20020a63505b000000b0050bebfe464dsm18423471pgl.53.2023.03.27.15.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 15:43:24 -0700 (PDT)
Message-ID: <d544492c-dcc4-9be8-7692-05c4f73e2f90@kernel.dk>
Date:   Mon, 27 Mar 2023 16:43:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] block: open code __blk_account_io_start()
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org
References: <20230327073427.4403-1-kch@nvidia.com>
 <20230327073427.4403-2-kch@nvidia.com> <ZCIUtZGOaxIza3j3@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZCIUtZGOaxIza3j3@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/27/23 4:12 PM, Christoph Hellwig wrote:
> On Mon, Mar 27, 2023 at 12:34:26AM -0700, Chaitanya Kulkarni wrote:
>> There is only one caller for __blk_account_io_start(), the function
>> is small enough to fit in its caller blk_account_io_start().
>>
>> Remove the function and opencode in the its caller
>> blk_account_io_start().
> 
> Having the account slow path in a separate function actually is nice,
> same for the next patch.

Then it should be made explicitly out-of-line, the compiler would've
inlined that anyway.

-- 
Jens Axboe


