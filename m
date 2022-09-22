Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5D8C6FA82
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 14:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiIVOJT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 10:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiIVOJS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 10:09:18 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3337DE9CDE
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 07:09:17 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id d8so7760001iof.11
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 07:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=jzpa/f4CKkKyy6uba2SDWcbjAF/yWl4Y+oXV6gEKIkI=;
        b=dA59ypiU0EaQ0kEwLi5PAX8pZuZQA7I2mrl8C2SSHaPc/rb5Kmn5CyVESotfUSPDat
         T4hkbN5LHeTNzGk4CX/CkCZvyL0G7jtVkZIufdCHRXOkcsDkuOc6HX08bL5AznrRv0KV
         ehOwlXZNAuIHsROz/X+w2Up0vzjfiL05ECCW4agIYN9aawgxufbBjqR+8OkIxHMZ7SRJ
         UdkMkb8NASac4O/ofd968rijZy0BjFC6rp+Araa7ZRYQj3y7clJtOVrGJnSXh4nGySvx
         FiUOyH1FErrugKrJ6N8AdU2aFB2Lbu4D89f8BK2DvzRkkfCDly4ll0NaeGXfdCuoR+Dh
         cKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jzpa/f4CKkKyy6uba2SDWcbjAF/yWl4Y+oXV6gEKIkI=;
        b=Bp4LlJrfUkkHk4vHmrBQYRkIrb0JpjiD2N7dGoCybVYgKbmS5C7IYW4DGtygWb3i7S
         UDezRpAY+oCzZdJH1DKG9pR21tVjhYiTa9Lg7IsnHIsIy9pulmMhmYc1XW4nrBKAolrN
         qHKKgMcqbSaTjIhlGkWZ2F/AHOIeKwr+QNh5NVrSf9A8dYAEDQD1BYALW+WSH7QnhZ2Q
         KPT1BAe8uF3RN4Kw4Cotf3DYnD0ulHVRTzS6vFBCUvRWKtLvgixmTCB4+Z0/uWO6bWFh
         OuOSfTQODQMZPK3QUOwy/X35q11/7puGmJ8F7kCGgJ0e5f897JQwZtL2CHoiCf+tf426
         aJ5w==
X-Gm-Message-State: ACrzQf3rI1nkzyWmsTLNjaVZyYVKmwyCE4Gd0mQ5DijosgLYOsUpWahk
        pO6ahujGWhNTMPxTuYx136flDA==
X-Google-Smtp-Source: AMsMyM7GpkVAFisuaxmSTeAnCawJblj5jsAudfLArh556pTnkFD5o7Z3d7xWRQexonkrimSt8FFzzw==
X-Received: by 2002:a05:6602:14:b0:6a0:f2f2:4c96 with SMTP id b20-20020a056602001400b006a0f2f24c96mr1614461ioa.63.1663855756502;
        Thu, 22 Sep 2022 07:09:16 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t12-20020a92dc0c000000b002eb5eb4f8f9sm2068295iln.77.2022.09.22.07.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 07:09:15 -0700 (PDT)
Message-ID: <db25bfe2-ed2c-9702-91a0-5078c3631cba@kernel.dk>
Date:   Thu, 22 Sep 2022 08:09:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v5 0/3] implement direct IO with integrity
Content-Language: en-US
To:     "Alexander V. Buev" <a.buev@yadro.com>,
        Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        io-uring@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Mikhail Malygin <m.malygin@yadro.com>, linux@yadro.com
References: <20220920144618.1111138-1-a.buev@yadro.com>
 <Yyoer7aEPBWGQCfR@kbusch-mbp.dhcp.thefacebook.com>
 <20220921092609.m4duniwc6jmfrort@yadro.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220921092609.m4duniwc6jmfrort@yadro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/21/22 3:26 AM, Alexander V. Buev wrote:
>> ?????????! ?????? ?????? ?? ???????? ????????!?
>>
>> On Tue, Sep 20, 2022 at 05:46:15PM +0300, Alexander V. Buev wrote:
>>> This series of patches makes possible to do direct block IO
>>> with integrity payload using io uring kernel interface.
>>> Userspace app can utilize new READV_PI/WRITEV_PI operation with a new
>>> fields in sqe struct (pi_addr/pi_len) to provide iovec's with
>>> integrity data.
>>
>> Is this really intended to be used exclusively for PI? Once you give use space
>> access to extended metadata regions, they can use it for whatever the user
>> wants, which may not be related to protection information formats. Perhaps a
>> more generic suffix than "_PI" may be appropriate like _EXT or _META?
> 
> Currently we use this code for transfer block IO with meta information 
> from user space to special block device driver. This meta information includes PI and some other
> information that helps driver to process IO with some optimization, 
> special option and etc. In the near feature we can extend this info die to increased
> requirements for our product.
> 
> Also we can use this code for transfer IO with PI information from user space
> to supported block devices such as nvme & scsi.
> 
> And you are right. Just for me "_meta" is more appropriate and abstract suffix for this,
> but:
> 
>  1. "PI" is shortly
>  2. "PI" and "integrity" is widely used in block layer code and I decided that
>     if it's called PI - everyone understands what exactly it is about.
>  3. User can read/write general info only in case of using special block layer driver. 
> 
> Anyway I'm ready to rename this things.
> 
> May be it's enough to rename only userspace visible part?
> (sqe struct members & op codes)

Let's please make it consistent across the userspace and internal parts
in terms of naming.

-- 
Jens Axboe
