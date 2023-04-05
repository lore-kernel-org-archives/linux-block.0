Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0551BC76188
	for <linux-block@archiver.kernel.org>; Wed,  5 Apr 2023 13:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238246AbjDENe2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 09:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237960AbjDENe1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 09:34:27 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141DB49F9
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 06:34:26 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-3261b76b17aso1179075ab.0
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2023 06:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680701665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3+CwkkX40YD6GiL/QPdmYDOm3IjGvaN6PvuLBJI8B70=;
        b=F3bjlMyCof1RWee9b43GG76KYPLck9/tyXmosXsq6KUbxXyI+zN9L2oX8/AZP4uzh1
         rTW5x1WRCwCXDXrNj9VPdliBso12eUaNfKFb7Ggoyilt4LdQtdeHtOYdDpBeJFy0vjuk
         kMw0oBBCI73IdDjQTf/I96KExIHBSIAM9x36xa8o0K9QqXGjV87F4jxftiX0rvhVDD9k
         Ol40ZiEfXsRqUTpzwLVvZnamQQzH3P9t153F57Vvyrivb3ZTteoeuOBlBQEcMzX9QJuF
         J6bhV7CGS6sj0PJBgrevT3+Qoy2zB7xwvYOyk+HQ5jLs+Db7X1T8+HVXu6IGpLGYsxc5
         z1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680701665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+CwkkX40YD6GiL/QPdmYDOm3IjGvaN6PvuLBJI8B70=;
        b=bL1THXjyXFPksz08JDQt9Hll55iI8w+CEbk5r/VZtr9xFdMus4tQ0COwvLot9Ik8Qu
         qAkTehQEEiFyBuFTmcvoqcyaVS6nAzHAC4ggl9xzeMvh/WGK+6h0g6H4wzex4sctiT3c
         ow0Dlg4YmJWhdXX83TM8biyMXpGecpUNyi5HBYgbgve/9EbLYkFB3mc21SkzmjqHavvT
         A5FvxRwbDcfBxbwuZw987iVfTZ/XrkcpLDPldh8liK0Uuawn9cclrIXkH00m0rVjYnJZ
         FxOKljPDKuKKwA61HkZq28KX+5c3bhbol96Lz8Shz42VEhjq+oIc2uUopx4vstaxMqva
         s3FA==
X-Gm-Message-State: AAQBX9fa/YWRcI8IcpHI4FHPMf5ACQa2j413Qbz4/qTXS8aXGW4fh6x2
        HGfo7AkBBlW4w8hrfhsqBX0pFw==
X-Google-Smtp-Source: AKy350amKQOfi/el/3wzuFjrm7LDTuCEPWt2eESN6efZ27TydrLztun8/ipSAfxed6gTCvksYnJ2zQ==
X-Received: by 2002:a05:6e02:20c2:b0:326:3b2e:95b1 with SMTP id 2-20020a056e0220c200b003263b2e95b1mr2031608ilq.2.1680701665346;
        Wed, 05 Apr 2023 06:34:25 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id p12-20020a056e02104c00b003141b775fbasm3923483ilj.16.2023.04.05.06.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 06:34:24 -0700 (PDT)
Message-ID: <15487b3f-62cc-ae99-6a86-abe251808fcf@kernel.dk>
Date:   Wed, 5 Apr 2023 07:34:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: two little cleanups for the for-6.4/splice branch
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230403142543.1913749-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230403142543.1913749-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/3/23 8:25 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series removes two now unused functions.

Looks good to me. David? I'll add them to the splice branch.

-- 
Jens Axboe


