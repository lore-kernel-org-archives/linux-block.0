Return-Path: <SRS0=zlmp=6K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C84C54FCB
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 20:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAE6F2071C
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 20:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgDZUpG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Apr 2020 16:45:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34870 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgDZUpF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Apr 2020 16:45:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id g4so15464209ljl.2;
        Sun, 26 Apr 2020 13:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9ZZNwPbq/C41ede2jP9NihjpFNfOYrifeVd3ObGtsSI=;
        b=ThghEj0izijvCAKo8NxO9GCu9JRQu5ZXu4sWSLcgbz3DUcJm+E2ArbE3+FaTCEj2mj
         iybqsH0dYf9Bcm/+KxtpkKmd14xdt7pfEFC84ZwWnwvX4F39Pk3+67IWrg+Fii1sKFak
         AkZpcz/W0lgA1rzMVo54Bi2r1EKJGFbNka1zZEYu4fh5SJyOFE7UyLEk2N4iRegWXg8m
         YoRnSt7aLFZ5oFkBxAxeEocQTm6QAVSXpJRJUnYkcppcWI+dcc+6zDL3gLo/+ke+UxE3
         hJA12uncJNNQQJOhdaEKxP0gDt17vF6vDrFun93UgSbo2dJW+g+ytj+qSmENA+3NmcPE
         FmsA==
X-Gm-Message-State: AGi0PubPgHbAYZKfaRj6VCEb50BT7vuXn/f0L76f+I7mvlxDSiUH5Ibn
        H9bj5WApFCDmEVCoJYK8kK08YffHlaY=
X-Google-Smtp-Source: APiQypJt/ZaMWYeU02gKVS19xHLw+3RQ5dwsfHAImyW5DFplDNdylE9ShRiEskDp9uoewijoy+ZEkg==
X-Received: by 2002:a05:651c:48a:: with SMTP id s10mr11654189ljc.226.1587933902425;
        Sun, 26 Apr 2020 13:45:02 -0700 (PDT)
Received: from [192.168.8.103] ([213.87.147.211])
        by smtp.gmail.com with ESMTPSA id q23sm9095692lji.92.2020.04.26.13.45.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2020 13:45:01 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] floppy: add defines for sizes of cmd & reply
 buffers of floppy_raw_cmd
To:     Joe Perches <joe@perches.com>, linux-block@vger.kernel.org
Cc:     Willy Tarreau <w@1wt.eu>, Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20200426130728.63399-1-efremov@linux.com>
 <20200426130728.63399-3-efremov@linux.com>
 <6a051ca29c9017f1c6fefc5d2894c8dd4542a208.camel@perches.com>
From:   Denis Efremov <efremov@linux.com>
Autocrypt: addr=efremov@linux.com; keydata=
 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
Message-ID: <24165d38-3144-ed4a-3118-4fecf8ad86ed@linux.com>
Date:   Sun, 26 Apr 2020 23:44:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6a051ca29c9017f1c6fefc5d2894c8dd4542a208.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 4/26/20 11:28 PM, Joe Perches wrote:
> On Sun, 2020-04-26 at 16:07 +0300, Denis Efremov wrote:
>> Use FD_RAW_CMD_SIZE, FD_RAW_REPLY_SIZE defines instead of magic numbers
>> for cmd & reply buffers of struct floppy_raw_cmd. Remove local to
>> floppy.c MAX_REPLIES define, as it is now FD_RAW_REPLY_SIZE.
>> FD_RAW_CMD_FULLSIZE added as we allow command to also fill reply_count
>> and reply fields.
> []
>> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> []
>> @@ -1847,7 +1846,7 @@ static void show_floppy(int fdc)
>>  			output_log[(i + output_log_pos) % OLOGSIZE].jiffies);
>>  	pr_info("last result at %lu\n", resultjiffies);
>>  	pr_info("last redo_fd_request at %lu\n", lastredo);
>> -	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 1,
>> +	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, FD_RAW_REPLY_SIZE, 1,
>>  		       reply_buffer, resultsize, true);
> 
> FD_RAW_REPLY_SIZE happens to be 16, but it's misleading
> to use it here.
> 
> This use of 16 is not for FD_RAW_REPLY_SIZE, but the
> width of the line
> being dumped, and this value must be
> either 16 or 32.
> 

Yes, you are right. Thanks for catching. I will resend the patches.

Denis
 
