Return-Path: <SRS0=5kok=TX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CDBC282DD
	for <linux-block@archiver.kernel.org>; Thu, 23 May 2019 10:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81BED218B6
	for <linux-block@archiver.kernel.org>; Thu, 23 May 2019 10:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfEWKEN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 May 2019 06:04:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38340 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfEWKEM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 May 2019 06:04:12 -0400
Received: by mail-ed1-f65.google.com with SMTP id w11so8420498edl.5
        for <linux-block@vger.kernel.org>; Thu, 23 May 2019 03:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OqWu9K98diHE/z+ycDwbyxcKok8JbJud6vPiwvkFCxI=;
        b=Kj5Ygbt7Yk19UJrHhu9G9hbA4lfGLAZOiBchSb4rl5P0TJcc/T573gfB0MX8m7AE3R
         s3eugvXUZOc8ieAtsLojfXvsV3EFqZ1YeeIOUd92EWNT7pivulJwPkyRzFLg0dYL0+aG
         mB+fRUa9e2MaT/s6KDeb3QUbqmW4QlrRo0dlQmW4U9onPWZS3i5JmltCzm9AvZSDg+Gs
         LkYHXB3jcNwH4A0ol6/lrETC+A5xvf0IHerWAIZq0SsGNbJ4H8AFvIBKx9dJtg2YCZaW
         4pZ2DK2PLcaM70IoBY7G1s4FZGbmCgq/AthIH1mRA70gySJnRBMg/SYlSLiZVUXNGLlV
         nzJA==
X-Gm-Message-State: APjAAAXcosN7cgUsLjdGQy1LhYmimZa9HRoDqpC0aHj08ozK81POw0HI
        7Q5vCvDvaFj0wXXB+VEJvw0=
X-Google-Smtp-Source: APXvYqyITuiw9vIRuHQxE8jW7QXxyRWXQ9vaVzvRpfJ4PdoND8+7Sbsp/oa+1PuCZ9/ZvJgXNmVV9A==
X-Received: by 2002:a17:906:6a97:: with SMTP id p23mr23240666ejr.203.1558605851029;
        Thu, 23 May 2019 03:04:11 -0700 (PDT)
Received: from [192.168.1.6] (178-117-55-239.access.telenet.be. [178.117.55.239])
        by smtp.gmail.com with ESMTPSA id j3sm7591001edh.82.2019.05.23.03.04.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 03:04:10 -0700 (PDT)
Subject: Re: [PATCH 0/2] Reset timeout for paused hardware
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190522174812.5597-1-keith.busch@intel.com>
 <721e059e-ed88-734c-fea2-3637e6d31f4c@acm.org>
 <20190522202805.GA5781@localhost.localdomain>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <83503209-cc83-7ca6-7775-638800626dfd@acm.org>
Date:   Thu, 23 May 2019 12:04:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522202805.GA5781@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/22/19 10:28 PM, Keith Busch wrote:
> On Wed, May 22, 2019 at 10:20:45PM +0200, Bart Van Assche wrote:
>> On 5/22/19 7:48 PM, Keith Busch wrote:
>>> Hardware may temporarily stop processing commands that have
>>> been dispatched to it while activating new firmware. Some target
>>> implementation's paused state time exceeds the default request expiry,
>>> so any request dispatched before the driver could quiesce for the
>>> hardware's paused state will time out, and handling this may interrupt
>>> the firmware activation.
>>>
>>> This two-part series provides a way for drivers to reset dispatched
>>> requests' timeout deadline, then uses this new mechanism from the nvme
>>> driver's fw activation work.
>>
>> Hi Keith,
>>
>> Is it essential to modify the block layer to implement this behavior
>> change? Would it be possible to implement this behavior change by
>> modifying the NVMe driver only, e.g. by modifying the nvme_timeout()
>> function and by making that function return BLK_EH_RESET_TIMER while new
>> firmware is being activated?
> 
> Good question.
> 
> We can't just do this from nvme_timeout(), though. That introduces races
> between timeout_work and fw_act_work if that fw work clears the
> condition that timeout needs to observe to return RESET_TIMER.
> 
> Even if we avoid that race, the rq->deadline needs to be adjusted to
> the current time after the h/w unpause because the time accumulated while
> h/w halted itself should not be counted against the request.

Hi Keith,

How about recording the time at which the firmware upgrade finished and
making nvme_timeout() return RESET_TIMER if either a firmware upgrade is
in progress or if it has finished less than (request timeout) seconds
ago? The reason I'm asking this is because I'm concerned that the
patches you posted would need a careful review to see whether or not
these trigger new race conditions.

Thanks,

Bart.

