Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426D5C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 19:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A17A21841
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 19:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pPjrMY+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfCTT5r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:57:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45087 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfCTT5r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 15:57:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id v21so2659128pfm.12
        for <linux-block@vger.kernel.org>; Wed, 20 Mar 2019 12:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yYmV2tUPVsSk9ezKkUd95L16J48PzGWFM4wgB/f7d2g=;
        b=pPjrMY+tKXQfn+C8QM1/HbR10eCbBClq43NT4u+4tGn6+OFiKw5mk+wKg+1pccjsxg
         pFN+ld3mHbIpuUSzH/MRvh5AdqlgQ/XcjVtXmuF5vuNI4O2v4j9qHIcXzUr6HSlEq3JO
         RdcBp2lJR1xGHEwX5dlQvyLO3RM0Hjf8V9c4M5P6sbtIhGKGrN8tKQA68NES98zuBaXQ
         Wn+fa2L6hp71qSWXmaSBI16zIkLc0vbcpH0RonQlso+jEP2eoBf6VNyOsa9rEjuVwCvd
         SdgtciBLi/alEkNTBKxlXVyfZfjaOTmh8ljb8SCSOoYz8BOBtK0QOUKfwWkaDXAs/oy4
         gPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yYmV2tUPVsSk9ezKkUd95L16J48PzGWFM4wgB/f7d2g=;
        b=f9j5FzgLQwEsUIiFPoC9UYq23V7TIn0Xjn1M/39hnuJztfvMC7uZVYw4sNXF5Her8t
         /vKw7loRRa1eSSr0FhnvoUX3tn9s1EBoAGfP9CkCcGDFzLgh1cxhDREXZO01q4QzK5wk
         f4KXidtrE+ug0ekCCsff4DgWTa8x0X9uV37INqyO4EsYXsfjAwMAjgVDOKYEY9oPa+fL
         UXjbBGbOTHSvwtplDpmPOkqhmhsS62y62utC3jxdQjX8lIPt2vblnQ0GjjmvFkiG8AEa
         tVL5gMQin2lWkW8k5haGXCVAswUZv5XnQZ9MvBiXw7EBmzBgaLNU/o+J3yQIx1tsFa1K
         or2Q==
X-Gm-Message-State: APjAAAW8JShwkd/s/mpERbi4LgwSXBzBTaciHamkrIj4Z6hH3BG0rUzc
        BOiBaIddIHLLPHrZRywRueXB+Q==
X-Google-Smtp-Source: APXvYqwn2aM2JoTSckGzbPjn4TXL9wNcGX/UDSr2gmb4Os724dKzr1A+lonmdZzI48AkoYKDdWM/hg==
X-Received: by 2002:a62:69c3:: with SMTP id e186mr9199508pfc.169.1553111866368;
        Wed, 20 Mar 2019 12:57:46 -0700 (PDT)
Received: from [10.155.59.239] (96-86-215-89-static.hfc.comcastbusiness.net. [96.86.215.89])
        by smtp.gmail.com with ESMTPSA id c13sm5517130pfm.34.2019.03.20.12.57.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 12:57:44 -0700 (PDT)
Subject: Re: [PATCH] block_dev: fix crash on chained bios with O_DIRECT
To:     Johannes Thumshirn <jthumshirn@suse.de>, Jan Kara <jack@suse.cz>
Cc:     Hannes Reinecke <hare@suse.com>, Hannes Reinecke <hare@suse.de>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20190320081253.129688-1-hare@suse.de>
 <9cec723b-d0d0-859f-37c2-bfdccb898071@suse.de>
 <e9953e6c-fd4c-cde5-976e-a5831d7c79a3@suse.com>
 <abd08aa4-f5fd-8ed1-1ae2-9987f6a43dc7@suse.de>
 <20190320114734.GB9485@quack2.suse.cz>
 <94293d71-fab4-43cd-3d83-243995218907@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c5c3312f-9670-01f7-1303-e05414dc96f0@kernel.dk>
Date:   Wed, 20 Mar 2019 13:57:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <94293d71-fab4-43cd-3d83-243995218907@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/20/19 7:19 AM, Johannes Thumshirn wrote:
> On 20/03/2019 12:47, Jan Kara wrote:
>> On Wed 20-03-19 09:53:10, Johannes Thumshirn wrote:
>>> On 20/03/2019 09:51, Hannes Reinecke wrote:
>>>> Yeah, should work, too.
>>>> But we should be calling bio_uninit() for all bios.
>>>
>>> Yup, probably.
>>>
>>>> Will you be sending an updated patch?
>>>
>>> Let's wait what other's thing first.
>>
>> FWIW I'm OK with either solution. Yours seems a bit more future-proof so I
>> like it a bit more.
> 
> FWIW Bit 13 for the Flag doesn't work, need to find a free one before
> doing a proper submission.

Yeah, you're going to overlap and crash... We really should have a build
bug on for that.

We don't have any free ones. I've got a patch in io_uring-next that
uses the last one.

That said, I do greatly prefer your approach to solving the issue.

-- 
Jens Axboe

