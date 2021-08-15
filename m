Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BF3C4320A
	for <linux-block@archiver.kernel.org>; Sun, 15 Aug 2021 14:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A89C96112D
	for <linux-block@archiver.kernel.org>; Sun, 15 Aug 2021 14:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbhHOO2K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Aug 2021 10:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbhHOO2K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Aug 2021 10:28:10 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2C9C061764
        for <linux-block@vger.kernel.org>; Sun, 15 Aug 2021 07:27:40 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so3076914otk.9
        for <linux-block@vger.kernel.org>; Sun, 15 Aug 2021 07:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6c7zBDU5BkSft4TW2fJaqiBbGNodfBo2siSVYmSoJjM=;
        b=rF+6w3aGWF+1CJw5omp0FEp3nBoZzezR+MNe2yp8ZCv+aBNGLWDIwvOURpjHUy/Vjf
         yG3vzLrZhN5lSvYuT5gNG+KGcrbOTSOjyOmHicNd7vmiLjK+8ZVArAMkyy3fXj4GmNQc
         Sy2Z5twmYjzpYg+00JEVf4iSSLojT5zYXYpO18UCHkW+50eaorFkBc4MQeGXWsH4OCl1
         aSvc9fInp9+jp2+TI7oNtuC6aQa5ffG4brARn9SvEGir3055gZrDKv8+pr4tRaobAfwd
         /7IrpmdqhhTDgHrlzN8joJfFojjmwoiSPoOE/RcD+IMJtnEBOfLdz0a8++OSlJTFBofO
         EtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6c7zBDU5BkSft4TW2fJaqiBbGNodfBo2siSVYmSoJjM=;
        b=kWyZD74h8jdSDQIXcFMEHRP/XKV7As3157rJkVIVDdCtHilfQgt97bIEgAtOFSCS4N
         xoeY7E7XvzRVjQ4CwGWnPTjM6G2TlmCk8OeS6lR7OlRDbuRw17hePiXM2tNvM57noAJt
         xguBQWctWM++wjHmybxfbo9HKyiPyxl9QH/4gbfutnc0HVtb6NQqbiWB+8ZKXezeA0s/
         ZgN5dcKrKkIQWNqtETjbQPn7vb3+PFjZ1pDwU2RsX5Zj3fgck0+m3dwS/xVlt33WfF22
         N08f0Ya1xyIQhRNEAKapEWUTtGMUvpTArl3jt8iyCZcEVUqoI3f8As96LX9hzr/Lb4fF
         6B6Q==
X-Gm-Message-State: AOAM533xQH6VmhVpc51A6X+nUMN+rY1jsgIfdRNFs4hVD5uJWz8juUR5
        BXk+NnfGLigs9ZGitXtcZJQ=
X-Google-Smtp-Source: ABdhPJyQ8HplngCONuGftc64bEc/JJ6coYh6og+bUJ6PeQJVELk4xOtqWPARJpZn+00/x6ypfMsS0Q==
X-Received: by 2002:a05:6830:2b25:: with SMTP id l37mr9405078otv.324.1629037659740;
        Sun, 15 Aug 2021 07:27:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bd3sm1557487oib.37.2021.08.15.07.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Aug 2021 07:27:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [dm-devel] [PATCH 4/8] block: support delayed holder registration
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
References: <20210804094147.459763-1-hch@lst.de>
 <20210804094147.459763-5-hch@lst.de> <20210814211309.GA616511@roeck-us.net>
 <20210815070724.GA23276@lst.de>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a8d66952-ee44-d3fa-d699-439415b9abfe@roeck-us.net>
Date:   Sun, 15 Aug 2021 07:27:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210815070724.GA23276@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/15/21 12:07 AM, Christoph Hellwig wrote:
> On Sat, Aug 14, 2021 at 02:13:09PM -0700, Guenter Roeck wrote:
>> On Wed, Aug 04, 2021 at 11:41:43AM +0200, Christoph Hellwig wrote:
>>> device mapper needs to register holders before it is ready to do I/O.
>>> Currently it does so by registering the disk early, which can leave
>>> the disk and queue in a weird half state where the queue is registered
>>> with the disk, except for sysfs and the elevator.  And this state has
>>> been a bit promlematic before, and will get more so when sorting out
>>> the responsibilities between the queue and the disk.
>>>
>>> Support registering holders on an initialized but not registered disk
>>> instead by delaying the sysfs registration until the disk is registered.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>> Reviewed-by: Mike Snitzer <snitzer@redhat.com>
>>
>> This patch results in lockdep splats when booting from flash.
>> Reverting it fixes the proboem.
> 
> Should be fixed by:
> https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.15/drivers&id=6e4df4c6488165637b95b9701cc862a42a3836ba
> 

No, it doesn't. I could not apply this patch alone, so I applied the entire series
on top of next-20210813 and gave it another try.

f53c2d11ac98 (HEAD -> master) nbd: reduce the nbd_index_mutex scope
f2f5254b356f nbd: refactor device search and allocation in nbd_genl_connect
d5b03177e069 nbd: return the allocated nbd_device from nbd_dev_add
350b3f6a6e6b nbd: remove nbd_del_disk
49efbeb9de86 nbd: refactor device removal
cdd920eb7cf2 nbd: do del_gendisk() asynchronously for NBD_DESTROY_ON_DISCONNECT
4b358aabb93a (tag: next-20210813, origin/master, origin/HEAD) Add linux-next specific files for 20210813

Still:
...

[   14.467748][    T1]  Possible unsafe locking scenario:
[   14.467748][    T1]
[   14.467928][    T1]        CPU0                    CPU1
[   14.468058][    T1]        ----                    ----
[   14.468187][    T1]   lock(&disk->open_mutex);
[   14.468317][    T1]                                lock(mtd_table_mutex);
[   14.468493][    T1]                                lock(&disk->open_mutex);
[   14.468671][    T1]   lock(mtd_table_mutex);

Guenter
