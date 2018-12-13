Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818D1C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 14:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447E820849
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 14:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uyfJbT+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447E820849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbeLMOCT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:02:19 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34162 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729558AbeLMOCT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 09:02:19 -0500
Received: by mail-pg1-f195.google.com with SMTP id 17so1118915pgg.1
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 06:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HG4tMMye3FgltELwKwZSaGZYUrRWTQQau8+QrC86PrM=;
        b=uyfJbT+mw/sknZcZ1u18vwWTOEza6T9ditTMj84+2OqZlAyrwErA7YSJAHaBpe7AaD
         Zmreb4YJMCwr9pOfMpxeRojy/AScS7s93rTYn7KD6SbwOwHKy5w8CLezfyswjrZGEihQ
         pnalInp5UyRipR5GPxOtxKGIzjSGU2q1UR30g8aiTeXczU+yLW6KwZZ6NNx2MiwFHxaV
         roxV2+S4D2kokpVWwLmOh91sSTBlr7I5BHiSEjlb3fVRKcPPyku0AVNtM1HNF4vfB0z2
         ZKHODiRyRjCCZLs1XI44O80S5bC2pZ1jvUKCjawjRY4jfdsc2VqT04RWNniEfxrShMJV
         uSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HG4tMMye3FgltELwKwZSaGZYUrRWTQQau8+QrC86PrM=;
        b=c15ngpEbm0HLi4W5bgfh9noBeEQ6U3uNmpQ8Y0xi8UYnrwOT6nF846MWmAhES1iBgU
         4O4FhSUJJ8WMJiunXJ03rMbneawczdIOUCfIOGKuP36y7EpjKrbZ9tqzc8ZWT7tz0Y45
         RYaopxfEJIiomnOLUg5BWDDJpgOeFCTdQFILJuzI1bFe/UDwuTkySFbwFst5Y7RuW34k
         MxvFBh1BK1ezQUdu40gH9Kj34QJw3lWAQdG0o/cKluVOjsxSwZKHCmKYL6hugCX1zU38
         sl8xj2EabKyHuKxAvIFutGx3XF7QE5f4yUFDuO9NOL4qfaEPVR9o2gfBZPlBFd02aMcj
         ScCg==
X-Gm-Message-State: AA+aEWZ4OTaabbfvO9w89W5LZ1roVp5mV7U6/x650AtCwhzlWIlPtqDP
        FhAQ06tmOXoSvqutSu3qQaPH9w==
X-Google-Smtp-Source: AFSGD/XOmg7qDxen/lpFGaLYT9qO6vk/67V8aSyrg1Cpcn0q3/ojt5+BQJV6ch6IEmEpL4OBipkqyw==
X-Received: by 2002:a63:658:: with SMTP id 85mr2262994pgg.373.1544709738461;
        Thu, 13 Dec 2018 06:02:18 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id z13sm2497592pgf.84.2018.12.13.06.02.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 06:02:17 -0800 (PST)
Subject: Re: [PATCH v2 0/5] implement nvmf read/write queue maps
To:     Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20181211233519.9350-1-sagi@grimberg.me>
 <477ef7e7-bc81-5c27-84ba-27c75989bdc4@broadcom.com>
 <be43de64-eb4b-c116-85f2-8c5d5a62e3c1@grimberg.me>
 <ce273a86-ae5c-0d82-d3d5-a43367f9ba53@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <90ebfdb6-8890-ad7d-a302-c6e3e5d8a97b@kernel.dk>
Date:   Thu, 13 Dec 2018 07:02:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <ce273a86-ae5c-0d82-d3d5-a43367f9ba53@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/13/18 5:04 AM, Hannes Reinecke wrote:
> On 12/12/18 6:58 PM, Sagi Grimberg wrote:
>>
>>> Sagi,
>>>
>>> What other wins are there for this split ?
>>>
>>> I'm considering whether its worthwhile for fc as well, but the hol 
>>> issue doesn't exist with fc. What else is being resolved ?
>>
>> I've pondered it myself, which is why I didn't add it to fc as well
>> (would have been easy enough I think). I guess that with this the
>> user can limit writes compared to read by assigning less queues as
>> jens suggested in his patches...
>  >
> Weelll ... isn't that what blkcg is for?
> I do understand if one would want to implement something like this if 
> there's a real benefit from the _hardware_ side, but if there isn't we 
> should try to keep it in the upper layers where it belongs.

The point is that nvme round robins queues, if you have 1 write queue
for N read queues, then you would get better read servicing as writes
can't flood more than one queue.

Obviously this isn't a replacement for any kind of real throttling,
but it's cheap and easy to do.

The multiple queue maps are more useful for the polled IO, and for
future prioritized IO in general. But it is also handy for not
oversubscribing the write side.

-- 
Jens Axboe

