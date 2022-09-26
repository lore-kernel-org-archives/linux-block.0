Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C05DC6FA82
	for <linux-block@archiver.kernel.org>; Mon, 26 Sep 2022 16:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbiIZQGv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Sep 2022 12:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbiIZQGF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Sep 2022 12:06:05 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB1E2645
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 07:54:08 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id 138so5401022iou.9
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 07:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=GFgIjACJN9ef5+O5Og9/DlD2wJW0SUIxL2QcgPrbsYc=;
        b=O6BuwalmwwYXOzo+C/YM69mwnYKMYr8o+VXsmRvl4i7rwPH1XHeNiAWtZYlhHu3x1k
         ABZI2Iw0Glk+PwbhLkcVqjJy13+aSHZm9s3Za2oqc6nV1K1AmDgOUSWmX+KVKGph4Bsa
         Vtj+9n4D2sLGmdmjZz12dBLj6rklBdCVvkckfXkH3xFBKgBm0ee3A3hFOrrsiu3uqHWL
         QeYHgJscKTg88T8/KrFdITuLCVfqvWVszV2ZOaRIBC4FpVne0XcJSgLpIGqCWMsv2qPj
         EMSpHNc0Vb+ilgIJ+rleGG9DdET7ZoUGxEQYCqREFz0goJgMZzIWRJ5BoAvEDg1n17i7
         1Wbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=GFgIjACJN9ef5+O5Og9/DlD2wJW0SUIxL2QcgPrbsYc=;
        b=i4xlxCoMVdzbeRojoaxdWv7s93ad56L2sbeH6OL6/rZ1tA9oKDtz9IfjplYdlaShya
         PmQYp8GuIAQ1/YVhlx9ycFZ0MH8lyhxurpiQeBg9+JDNThDCKuhe7UsjtnR+rg41jPe2
         uINtoC8OXo69siuKUUaoYkIfkRyZRraF1mqfXXn8wJUEUfO+Q4Kj7PmFyhUu8TT7w4fq
         ljdIkgSdHC+uaopAPGFfVxgpqljIlsV3I5DcaW55wgk+t2KK9IDdV2wI9EkhP953luw5
         Lfl5BAGEj3pMJEOyyjpRlEugZVn20IC6gaJYGAsZodGF/+1i4WiFQ2dLUQ5Qyqz1T2dS
         m8OA==
X-Gm-Message-State: ACrzQf3QK/gdn6JXMqEGW95yuj79JBJjjtaO7ka7NxeYoZShmYQvJxgc
        OJfruwr6F8THChz/lVnotg6+og==
X-Google-Smtp-Source: AMsMyM4hzRj1NCt5qjQmyZkoVCT9OWmRSxwmpvJsL6WjnZ+oLf++I8kF1xpoVmAbCJWyaZoIbUOzKQ==
X-Received: by 2002:a05:6602:2b06:b0:67f:fdf6:ffc2 with SMTP id p6-20020a0566022b0600b0067ffdf6ffc2mr9866886iov.111.1664204048218;
        Mon, 26 Sep 2022 07:54:08 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t23-20020a02b197000000b00346e7ca2463sm6868577jah.135.2022.09.26.07.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 07:54:07 -0700 (PDT)
Message-ID: <f7b92f52-8a33-4cf0-b8b6-328c573ad1bd@kernel.dk>
Date:   Mon, 26 Sep 2022 08:54:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 4/5] nvme: split out metadata vs non metadata end_io
 uring_cmd completions
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, Stefan Roesch <shr@fb.com>
References: <20220922182805.96173-1-axboe@kernel.dk>
 <20220922182805.96173-5-axboe@kernel.dk> <Yy3O7wH16t6AhC3j@infradead.org>
 <d09e1645-919f-9239-f86d-a8e85a133e5c@kernel.dk>
 <YzG5/1zSdiMlMLnB@infradead.org>
 <69598e37-fb91-5b92-bb80-b68457a7b6f8@kernel.dk>
 <YzG6mZhtd/QysvdH@infradead.org>
 <25b9899f-0c60-39f2-179b-789b914e0f0a@kernel.dk>
 <YzG8vsR8j0VIt6Nx@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YzG8vsR8j0VIt6Nx@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/26/22 8:52 AM, Christoph Hellwig wrote:
> On Mon, Sep 26, 2022 at 08:50:41AM -0600, Jens Axboe wrote:
>> Or just the union named so it's clear it's a union? That'd make it
>>
>> pdu->u.meta
>>
>> and so forth. I think that might be cleaner.
> 
> Ok, that's at least a bit of a warning sign.

I'll go with that.

-- 
Jens Axboe


