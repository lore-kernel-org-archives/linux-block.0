Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7377C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 14:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822E5218FF
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 14:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="j/flaYKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfCUOZI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:25:08 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45012 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfCUOZH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 10:25:07 -0400
Received: by mail-io1-f66.google.com with SMTP id u12so5337190iop.11
        for <linux-block@vger.kernel.org>; Thu, 21 Mar 2019 07:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F8Y2C2pWdwqiZQ6umIn735wlHM8tkF/QgiIK/4oNIzY=;
        b=j/flaYKETxoRCJGTwnyhqhSLVpQ9+J9KLb1jD5OxooWd4qTBdoNNXbIo6+8rDv5Xr+
         6CfmkAO/6XrCgi9Q/dREF8dQ8WzR+2C51cN2BhcSGafN2oFkL0IiI2xAfoaEP2rpHGY+
         WuHpWiK8NWZmiTZw2vRromgCYY94Tu+yfHTMrk7IKxpsVCH0E+PE9L5g+Fb+mRSiiTFm
         5jZ7mnWNg8Q7rcK7n8tvPaNhFUkP5jcaZpxtsVvbodufWaZ72PBpa1WxM7t4Gi6WEKaD
         fSKUavu+oGrR34iqdT9LRaKhhST2d2WMqL9wV1wjPcXKrgmjQbk16K0gQhFKE9G4V2rf
         z/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F8Y2C2pWdwqiZQ6umIn735wlHM8tkF/QgiIK/4oNIzY=;
        b=g+fMXVF5CW3RcQ+bJ+YELIlnp4OXZjKTF6w9DEzWN1ZxBU5lgxAgN1d2KyIrQiABR5
         3N8jz8o0v7AplFXTYlFJrM0FUfbfy3LIdnp2vUbUzfcFa6+OyN9dgNSxbkmbAJA/mGIM
         XPkP7DMxcIQbel8ztJ+HziE/4dVL3zuAfKFyEOau3MJV83/ex6LkZZY7ygn/zqKQTQMI
         6yTomH/IyDLs1IWngJZWIuWMH/iCuXYLfARMl+IY8woFn2MLwBqQ0jTm+GyxXmJpChlH
         eD4TLC11jG/znQj3CLQPMyqUsGi43DTeiq4+I01nIooDWwow+a52FWJoVB08LYg/fQ9d
         +3Jw==
X-Gm-Message-State: APjAAAWdWutn2wgWZFW99Is/iPyoVN/nwS3NXYZuR8pDp4+M6pJYo27e
        HdGvu5rqffUOl2Q/9dGzTGtjwT/xTDxvwA==
X-Google-Smtp-Source: APXvYqxj3/jnrrUrVXcoNbuZ9o/RV3jXc5YX5JgxPzf7LmlIpQfWMRT17mbdO1Jva8hbasuZRdmCrw==
X-Received: by 2002:a6b:f90c:: with SMTP id j12mr2818856iog.53.1553178306837;
        Thu, 21 Mar 2019 07:25:06 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x63sm2724228ita.15.2019.03.21.07.25.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 07:25:05 -0700 (PDT)
Subject: Re: [PATCH 1/2] block: bio: ensure newly added bio flags don't
 override BVEC_POOL_IDX
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>
References: <20190321123045.32396-1-jthumshirn@suse.de>
 <20190321123045.32396-2-jthumshirn@suse.de>
 <78cf685f-2bb4-c494-4677-afa513b47339@fb.com>
 <17f1ef65-5fcf-0cba-4d37-a43d5e5038b0@kernel.dk>
 <64dce739-128b-1770-4062-9ba566ceda63@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <beaecea2-13b2-e8ef-de18-b841f4fe82de@kernel.dk>
Date:   Thu, 21 Mar 2019 08:25:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <64dce739-128b-1770-4062-9ba566ceda63@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/21/19 8:23 AM, Johannes Thumshirn wrote:
> On 21/03/2019 15:21, Jens Axboe wrote:
>> On 3/21/19 8:15 AM, Jens Axboe wrote:
>>> You also haven't solved the issue of now having an extra bit, 2/2 uses
>>> the last bit which the other patch already took...
>>
>> Here's one way - kill BIO_SEG_VALID. We should just use
>> ->bi_phys_segments to tell if it's valid or not. This patch uses -1 to
>> signify it's not.
>>
>> Totally untested...
> 
> 
> That sounds like an idea, I'll trow some testing at it and report back.

That'd be great, thanks. If we can do that as a prep patch for you, then
you can just use an enum and not worry about initializing since I'll just
shove BIO_PAGE_NO_REF at the end.

And this is simpler than having to shift the masks around.

-- 
Jens Axboe

