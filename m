Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48094C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 17:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CE4260F57
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 17:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhJTRho (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 13:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhJTRho (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 13:37:44 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3455C06161C
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 10:35:29 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id l24-20020a9d1c98000000b00552a5c6b23cso9123594ota.9
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 10:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3qdkGS6nWGa6DIGxTkS5kzwbPgDeOBsvHVNSW721MxI=;
        b=48WLfHxpTQLpT0tUgWuSt4zXgmR64ij3Ikm8xUySS4voFZjXDqH/9AA3kqxblwubZa
         OLPsOO2SoGU+5CX+ksD6RkcZhFyMBejnYWIP/4t+clIqrnD/rWsK2UrsqcevALsA5yF4
         Gjee61YE6DP7+kQG48wPdg0EDzZwNaDVIUQROJd2pCP2w5H2olWdul2nZAYLzd51dor2
         xxlfFI4Kf9EJ/0HcBfZOZ9t4GcwolTJNgBDo2Xi1n2aE5UpzpJh7wnF/gkrQfvR41Hks
         9QO+FqYnlm4ugw7sL37KMWtpORpTul7W+y1fk0J/9IGqgka1sAMLFCgk+NulkK2jOBdH
         Yawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3qdkGS6nWGa6DIGxTkS5kzwbPgDeOBsvHVNSW721MxI=;
        b=02tnNw6NJs3zm9m7zpU4A4nYRXdA57Ex+3JKzEcVY8aSz/H+by4Vhog4e4PvNl1r28
         FNWWXRnfx8YyzzT9h6lAYht24uBMlSVvysQZkUOzc8a+58scARPvapTVZj+/svQCsvcu
         ywCG7sQvle2oERNwyFpxD6QDa6LZvKwm1yBCMs5dHoK40FQFp1marjbHizsoHYlfv6Te
         vC0LufyCDFyRDS+HoMbOpfau42movnfTr6aGVOCAwcjXxWWvZkXfGO6x47J32eCLoRko
         VsyPoGYds/8mhHAplmDMRfRYbe4EMJySVaiEdibgVF9BA7elr+p4B2EM5sJPZcQUbQzK
         ITjA==
X-Gm-Message-State: AOAM531cJEDRGjYkSlRuVoAHJjKzaOiYwmd84IvtF/K2IipavDWWQOne
        lMGR9Js2kC7RQ8za7rkV7E0rJg==
X-Google-Smtp-Source: ABdhPJwZhE5aOVEBJg+B29uGYRLol/63NjjBsjTMQYekIxgCxYCQsJoWJUZ4yRJhVp+j2vsNKAx3MQ==
X-Received: by 2002:a9d:424:: with SMTP id 33mr512439otc.340.1634751329074;
        Wed, 20 Oct 2021 10:35:29 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id ay42sm566290oib.22.2021.10.20.10.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 10:35:28 -0700 (PDT)
Subject: Re: [PATCH] fs: kill unused ret2 argument from iocb->ki_complete()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <ce839d66-1d05-dab8-4540-71b8485fdaf3@kernel.dk>
 <YXBSLweOk1he8DTO@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fe54edc2-da83-6dbb-cfb9-ad3a7fbe3780@kernel.dk>
Date:   Wed, 20 Oct 2021 11:35:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YXBSLweOk1he8DTO@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/21 11:30 AM, Christoph Hellwig wrote:
> On Wed, Oct 20, 2021 at 10:49:07AM -0600, Jens Axboe wrote:
>> It's not used for anything, and we're wasting time passing in zeroes
>> where we could just ignore it instead. Update all ki_complete users in
>> the kernel to drop that last argument.
>>
>> The exception is the USB gadget code, which passes in non-zero. But
>> since nobody every looks at ret2, it's still pointless.
> 
> Yes, the USB gadget passes non-zero, and aio passes that on to
> userspace.  So this is an ABI change.  Does it actually matter?
> I don't know, but you could CC the relevant maintainers and list
> to try to figure that out.

True, guess it does go out to userspace. Greg, is anyone using
it on the userspace side?

-- 
Jens Axboe

