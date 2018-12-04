Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AF7C04EB9
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66B62087F
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66B62087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbeLDBdL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:33:11 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43265 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbeLDBdL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 20:33:11 -0500
Received: by mail-oi1-f195.google.com with SMTP id u18so12829716oie.10
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 17:33:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=riEhp5EfzIzgQBt4enIusISlRBS9Nx+g2jJnRSdgYaI=;
        b=O/kINi/Iko+TJRbb1lFp+w5rXUkBhVKsnAINj603Tj7bPLh7J1RNfGzQ7sOoOq3Pgd
         wt5H+lNR6K5DSaFtKhe1U+hGilVImb2cYjKp9bftTtYb/dpt8Ts6hgzugnfhWkgfOpsX
         k2Zv7Z1enfcctCCsRnpvhi8wzaGIInOF1Pj6S4iOar/kpKIZmF+zhf6YrQoJxpubaQa3
         eedOlh+x+uiHL0qdcLyVD3lp5Yz2ky3+lyk9L9BuDkX7r1J7VXwpMYMMf/5AKcZktb9K
         DYxutC36iExM9tvG1KIKiYWpdQRnp11SHK372E8IftSYoViDbUPcY8peuwgS0cbwi2eo
         vRkg==
X-Gm-Message-State: AA+aEWa2Xb4cw2UNjg2N0+FA39lMYtzFbgz2cfe5fRLj5/HdPmege0kh
        PwmWA2Z70aaUBzXHFtB0RtWIX138
X-Google-Smtp-Source: AFSGD/UWsA6kBdZ+5/gMgQxhop3czCXLcd74vAzIt/bMdbLT0yiYGXor990u7hQUiJQ5pRrtnhrYCw==
X-Received: by 2002:aca:b104:: with SMTP id a4mr10717267oif.133.1543887189479;
        Mon, 03 Dec 2018 17:33:09 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id b124sm7576757oia.35.2018.12.03.17.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 17:33:08 -0800 (PST)
Subject: Re: [PATCH 1/2] blk-mq: Export iterating all tagged requests
To:     Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20181130202635.11145-1-keith.busch@intel.com>
 <823fc3bf-78a4-c8fb-c80c-e3944f320af0@kernel.dk>
 <20181201164804.GB19557@lst.de>
 <9346f289-f265-e2ee-2d2c-c97973b45e23@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8cd9a950-6605-6387-e4d4-4346a46da781@grimberg.me>
Date:   Mon, 3 Dec 2018 17:33:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9346f289-f265-e2ee-2d2c-c97973b45e23@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>> A driver may wish to iterate every tagged request, not just ones that
>>>> satisfy blk_mq_request_started(). The intended use is so a driver may
>>>> terminate entered requests on quiesced queues.
>>>
>>> How about we just move the started check into the handler passed in for
>>> those that care about it? Much saner to make the interface iterate
>>> everything, and leave whatever state check to the callback.
>>
>> So we used to do that, and I changed it back in May to test for
>> MQ_RQ_IN_FLIGHT, and then Ming changed it to check
>> blk_mq_request_started.  So this is clearly a minefield of sorts..
>>
>> Note that at least mtip32xx, nbd, skd and the various nvme transports
>> want to use the function to terminate all requests in the error
>> path, and it would be great to have one single understood, documented
>> and debugged helper for that in the core, so this is a vote for moving
>> more of the logic in your second helper into the core code.  skd
>> will need actually use ->complete to release resources for that, though
>> and mtip plays some odd abort bits.  If it weren't for the interesting
>> abort behavior in nvme-fc that means we could even unexport the
>> low-level interface.
>>
> Yes, I'm very much in favour of this, too.
> We always have this IMO slightly weird notion of stopping the queue, set 
> some error flags in the driver, then _restarting_ the queue, just so 
> that the driver then sees the error flag and terminates the requests.
> Which I always found quite counter-intuitive.

What about requests that come in after the iteration runs? how are those
terminated?
