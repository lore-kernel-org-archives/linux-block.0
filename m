Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D05DC10F13
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 15:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0502083E
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 15:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zWXhjyIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfDKPXQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:23:16 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38373 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfDKPXQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 11:23:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id f36so3579899plb.5
        for <linux-block@vger.kernel.org>; Thu, 11 Apr 2019 08:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qtc8JICqyTDVy55kdJNNtJtDUNKNZhVzya47CXbfr8w=;
        b=zWXhjyIlpZ4AZ7kQ8f82B7MULL98oBg30xH6cYGs8FShwxge579b9tm1iCDmlM1+1r
         BmIi/M63ZiiD7ovGH546sj2u0k7LisVwjK/6YIZml16GhKGzLgi5ozWlATKopSkkQF2c
         q6ADleG+hBP7maNxPTiTy90IwxRIOqO5EDYLSTgK29aXt0b1aEQrCMRIFdNzNzo2nisz
         AQjF/GE1CbMpSgjDsRao6FfMG3GyZt9d4jlivwQvdJ/U7tAXroYEdqukHzEJs2MHzSi2
         SQjYKS3R4cJePWxgXyuiY/jkOcaKw7VjSYeck2apIKj/P9BjvvJ/q2BFPQJdK+Ip4Ae0
         +0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qtc8JICqyTDVy55kdJNNtJtDUNKNZhVzya47CXbfr8w=;
        b=PKRaCmaB+4VIlQVcgIzA1bHq6gGOQmazknf6O4NxGaXt6P0kFr5zmtbShi7lBVMKX6
         JzC/NPPY1llQIFIlUdr2/aaM5d4xqF1zmeBtmQfpbNqGdGkI0Uj58t5iK9tdrRSCOWq0
         a00vifInCg1VBmYbSRwcBERRWvOHsiAEW42/lrjYPOVj9TmdOGg3VUdLaArZjyhRGGuo
         dEu7ibCAgB5uGhLvBHb7a97WAKMbwcsEYWvP54g+d13XpI2WJqCJN8vqSX1K4s0m/zlO
         XS7jRh9PUJnsJEDDtAVU1b07QuwHZj1xbt1+qqM51fJ0EsI+HNvzNckJOkFgZblGoIUV
         1UXg==
X-Gm-Message-State: APjAAAUZ+3ga0C/vy9Fis+UJ6YIoJNXxf01zNoQGrS4DRWpkDlrdlm1m
        ZD5iJJ1IYmFFfMLSwT3IbzBAnGyWBNGzVg==
X-Google-Smtp-Source: APXvYqy3l6UE2NQelh7oR+fVN8C7R4Hkw98F7UBrVSNi8wN8+sjHGeY1nzsojR46o+yW1OFipz8GnA==
X-Received: by 2002:a17:902:b191:: with SMTP id s17mr49281287plr.70.1554996195556;
        Thu, 11 Apr 2019 08:23:15 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id s5sm44554698pgv.8.2019.04.11.08.23.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 08:23:14 -0700 (PDT)
Subject: Re: [PATCHSET 0/3] io_uring: add sync_file_range and drains
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        hch@infradead.org, clm@fb.com
References: <20190411150657.18480-1-axboe@kernel.dk>
 <20190411151657.GD22763@bombadil.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d7d45594-d1bb-493c-6e92-9475e6ffbe7c@kernel.dk>
Date:   Thu, 11 Apr 2019 09:23:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411151657.GD22763@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/11/19 9:16 AM, Matthew Wilcox wrote:
> On Thu, Apr 11, 2019 at 09:06:54AM -0600, Jens Axboe wrote:
>> In continuation of the fsync barrier patch from the other day, I
>> reworked that patch to turn it into a general primitive instead. This
>> means that any command can be flagged with IOSQE_IO_DRAIN, which will
>> insert a sequence point in the queue. If a request is marked with
>> IOSQE_IO_DRAIN, then previous commands must complete before this one
>> is issued. Subsequent requests are not started until the drain has
>> completed. The latter is a necessity since we track this through the
>> CQ index. If we allow later commands, then they could complete before
>> earlier commands and we'd mistakenly think that we have satisfied the
>> sequence point.
> 
> That's potentially going to cause quite the bubble in the pipeline of
> commands being sent.

Definitely.

> Do consumers know which writes they are going to want to fence?  We could
> do something like tag each command with a stream ID and then fence a
> particular stream.  We'd need one nr_pending counter per stream, but
> that should be pretty cheap.

Or you could just split your streams between io_urings. That has other
overhead of course in terms of resources, but it'd avoid having to do
any extra accounting on the kernel side. A pending counter is not
necessarily cheap, though it'd be acceptable if we required writes
that you want to fence to be tagged (hence it wouldn't happen for
"normal" IO).

-- 
Jens Axboe

