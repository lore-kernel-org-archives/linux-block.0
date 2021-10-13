Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C207C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 08:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09CD961053
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 08:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbhJMIsO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 04:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbhJMIsN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 04:48:13 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F79C061570;
        Wed, 13 Oct 2021 01:46:10 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v17so5647174wrv.9;
        Wed, 13 Oct 2021 01:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0VFk+51xpem3lCydw/SgtpoptzvnLBUdv9gVbfKWlsk=;
        b=YakdbvDfmfTCQIawnG+GvuHAgeNp9iJjT37y8gV9UfBA70dnb76Ni6Rx4lt7dHYx2E
         4iU4s4rZ8mP80TXfSpvSutWrATUzX/gBK8e39lryQHOpXRte0YSyDwm4KngCAssMz20O
         wuohbQFSoSJH0cCVFQcERAiTnhFkJxhPc5bAMLeTRqncX+r5woDE6tvrVmeG87rM254z
         UJWxWsEuol6jQ2OTG5qZbrZSD03CF8fk9zS1dA72OXMn7V/ETr/eY3EYSAUiBca+d31Y
         8Utfbu9mq0GgLebvlpscoijg+2Ph9ayOwO28r8ltfx5nLpFzwUTt9ArTpK1hJe3syseN
         xqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0VFk+51xpem3lCydw/SgtpoptzvnLBUdv9gVbfKWlsk=;
        b=yvs9FD+B56qhJ6LW2gxVIxCf3yxa+5qVUcbCn1jvM1/azM14F0AKYrtm1an4E8QBaw
         QQbYspkgIVm+5HJ84jiTTNVzwuR8/CdwmQnHzlQF8DbWF39FPF1vMSDy1movHdKiL/h8
         kAlu1+5ozaIZJ39/Wqa4v35g0GZ9vtVSwdt/qhvqBtqHeDz6WapmzfDko0x7Yfl1VL83
         2hEPo/43bK+e7gr5eNgWV5zZHlb223ftSRs5GBr6y64h9aoduwdNg2Hu37ClNIH9Y5pK
         xbcFLu3vTsARnuzGiTNG1WeKe6i5p/Q5Ua3VDlJ4a8E9qpZOsJpMM+JXpxdlKE/CQUIN
         HDvQ==
X-Gm-Message-State: AOAM53266hKufuABhBSFDquP85k0X+xdr+pBEfYL43gt2ixhIXP5FG0k
        qlZDYHJbR3VlIBNeGKlV5is9PYRVfPE=
X-Google-Smtp-Source: ABdhPJz80981iNu6IqqdZZObheAZBa5PEI4JGMetk0qMIF11oyltoWcBD1w7pgNLsu9gGf9sQtZ+iA==
X-Received: by 2002:adf:9c02:: with SMTP id f2mr38714628wrc.329.1634114769354;
        Wed, 13 Oct 2021 01:46:09 -0700 (PDT)
Received: from [192.168.8.197] ([185.69.145.208])
        by smtp.gmail.com with ESMTPSA id t18sm13047322wrm.81.2021.10.13.01.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 01:46:09 -0700 (PDT)
Message-ID: <85028200-1dc4-c012-8f84-9ef582cb66e6@gmail.com>
Date:   Wed, 13 Oct 2021 09:45:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 1/6] block: cache bdev in struct file for raw bdev IO
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1633781740.git.asml.silence@gmail.com>
 <cfc66d9946422fa1778504f976621c91be2befb5.1633781740.git.asml.silence@gmail.com>
 <0785c707-ba82-1e46-5d4d-63ccacdb471f@kernel.dk>
 <YWP1O+oZmsovShoR@infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <YWP1O+oZmsovShoR@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/11/21 09:26, Christoph Hellwig wrote:
> On Sat, Oct 09, 2021 at 10:33:17AM -0600, Jens Axboe wrote:
>>> +static inline struct block_device *blkdev_get_bdev(struct file *file)
>>> +{
>>> +	return file->private_data;
>>> +}
>>
>> Get rid of this and just use bdev = file->private_data where
>> appropriate. Easier to read, we don't need to hide this in a function.
> 
> 100% agreed.

The reasoning is as always, it's much easier to change if we change
what we store there. I don't agree, but don't care enough to stay
on the point, will resend with the change

-- 
Pavel Begunkov
