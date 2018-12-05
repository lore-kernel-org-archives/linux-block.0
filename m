Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EEBC04EB8
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 02:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A07F20645
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 02:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="irphp1qm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A07F20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbeLECZJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 21:25:09 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44942 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeLECZJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 21:25:09 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so9190770pfh.11
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 18:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9epP0ALotJ2DanvTQB0OxJ6njeYh8BUSHUixqYq0IZo=;
        b=irphp1qmEKKR88RxJifOLyNnWraLMmBMwEFE1Jn+7fP6jTUKN+k5Z2Z+XHDxy9imoj
         oydB1QStTxhSD2DRSgLkKjwCB5/sKo++pdgAYRpxs7lRU4hU4SBSyUkY4OPgZI+Y0xTm
         JoVGU/IKpQgQm+KV+7vzp8bPR67CSKmLwY1DnQH5VlcshnH4P3oQ8AmYo+xpQ7U7IL7h
         5ryu12k8gt0kAqzNPDBzzProWoeWX3aR2KocGrd9HifSRuqs5o/VGxXR2c8q73W3y2hN
         idHZUSKmdKurqobqE5tnyFQmRF8EClcfcbHhLXjNkJvT5tBpH/inqDZiWiueiO21y2MN
         vRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9epP0ALotJ2DanvTQB0OxJ6njeYh8BUSHUixqYq0IZo=;
        b=TU6iO/PAyN7vSXwNWMbYA4UWsLef068KsEOwyJ9RtWO2w27y5TJ1D6fB1m9LLUkDqP
         6kZmcQgL10nYYbA/HQfeadAjqwflZ6lb0sAAgxOtyHG1VnnbfjzPBOowGwDc2E1TSpTG
         6kA8vO9ySLk6V2LEwa/M35UBbmKZdw53SyTPkVrbiybeiza6rwbmlv6FUhKFksuqfx1M
         phy3FX9Y4VQXxd8LkH0jFUQ1oFEomL/44Zt/EkFkrPxXL5UeRNn5bErqPnhEWo+N6+xx
         9BFUJPKtKO9aAb4r5DjM+UPdM9JkIz447lyyDIstRS30cYpSjm5n70sXh/5+YSbAZnd/
         4Ajw==
X-Gm-Message-State: AA+aEWZeJHr5AnCP06B+4em/aBCaJHvhn3dqBNHlp2e1Nzy+msWIz//5
        NnznevFiIMysXFCwkglAzIIawjFPlps=
X-Google-Smtp-Source: AFSGD/WKNCzV5nnfMnnTDr0bOy6e1fsP9HXr/SNCJGfWPzrRxWN/ZpOFm48qEN3EkUYvKREriU0FxA==
X-Received: by 2002:a62:61c3:: with SMTP id v186mr11270006pfb.55.1543976708706;
        Tue, 04 Dec 2018 18:25:08 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id l5sm17691299pgp.82.2018.12.04.18.25.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 18:25:07 -0800 (PST)
Subject: Re: [PATCH] blk-mq: fix corruption with direct issue
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
References: <1d359819-5410-7af2-d02b-f0ecca39d2c9@kernel.dk>
 <20181205013821.GA19605@roeck-us.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7aa746ff-58ab-e0e9-7058-3086a7f19c47@kernel.dk>
Date:   Tue, 4 Dec 2018 19:25:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181205013821.GA19605@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/4/18 6:38 PM, Guenter Roeck wrote:
> On Tue, Dec 04, 2018 at 03:47:46PM -0700, Jens Axboe wrote:
>> If we attempt a direct issue to a SCSI device, and it returns BUSY, then
>> we queue the request up normally. However, the SCSI layer may have
>> already setup SG tables etc for this particular command. If we later
>> merge with this request, then the old tables are no longer valid. Once
>> we issue the IO, we only read/write the original part of the request,
>> not the new state of it.
>>
>> This causes data corruption, and is most often noticed with the file
>> system complaining about the just read data being invalid:
>>
>> [  235.934465] EXT4-fs error (device sda1): ext4_iget:4831: inode #7142: comm dpkg-query: bad extra_isize 24937 (inode size 256)
>>
>> because most of it is garbage...
>>
>> This doesn't happen from the normal issue path, as we will simply defer
>> the request to the hardware queue dispatch list if we fail. Once it's on
>> the dispatch list, we never merge with it.
>>
>> Fix this from the direct issue path by flagging the request as
>> REQ_NOMERGE so we don't change the size of it before issue.
>>
>> See also:
>>   https://bugzilla.kernel.org/show_bug.cgi?id=201685
>>
>> Fixes: 6ce3dd6eec1 ("blk-mq: issue directly if hw queue isn't busy in case of 'none'")
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> 
> ... on two systems affected by the problem.

Thanks for testing! And for being persistent in reproducing and
providing clues for getting this nailed.

-- 
Jens Axboe

