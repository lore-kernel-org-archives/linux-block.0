Return-Path: <SRS0=U0+/=T3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D95C04AB3
	for <linux-block@archiver.kernel.org>; Mon, 27 May 2019 13:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34BC2075E
	for <linux-block@archiver.kernel.org>; Mon, 27 May 2019 13:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lGNfmIy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfE0NfW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 May 2019 09:35:22 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:33949 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfE0NfW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 May 2019 09:35:22 -0400
Received: by mail-pl1-f177.google.com with SMTP id w7so7073576plz.1
        for <linux-block@vger.kernel.org>; Mon, 27 May 2019 06:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fEk8VIC6fXLkeok+rVFqyR9po0rPxEc6NLrEag/CaBk=;
        b=lGNfmIy5xWOgjOFAoBWefudZS1JHk4AJyDzprElZWLG/zaSvGZEXWum39gCSTFI/ZU
         1tqTt5Mp5IZQdB3ZPaiBdDD5MRnFLxUpxv+XzboZ/m2y1YJG0nNLGsCMYVkPeDxOkJQF
         STp1+jMos+LQ+msjUqmmf1ViRQwqrCrxSRmMWyIuc+jfjHrZJbgoSotDJhSTDKRGPH+k
         UCvcjcrCgBf0cWSBA0NWDLbK0z85VI28pPguWJ1gB5tnGICl8xufTAz9/LGpoAD3b3al
         vM9yaoJ786jYxBmBRhgkQTRYjERMY3TTntt/AfQJy1vEyyl8un0FI9H/Kmjkqjd5L8F0
         5GXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fEk8VIC6fXLkeok+rVFqyR9po0rPxEc6NLrEag/CaBk=;
        b=elzmg/+ucyavRPILuFRfyrhscWbhae959qqG1C8i2kj4ryopBOcYDDiiomiirPX/uH
         WIwGyvQdKZEU1x8X3Jz4OyPZyiTzTMSehINjV7zqZU0oTl3e1I6oxd9TYbQmEy6SFZng
         1USQpQixzZ0+glvNJcAhl7VmczA2zicR+lq4mASTBklAU/ZLn5XU4AVcOxJYQmYQTDYI
         q8Dj1oZcxXOdTX78rBe7muxFped+GVbeou1+VPghpW/gNZcWYqXHYkUZkWq9RVC4bEyY
         LCBsiv1hHGlolunOR9dWE119bjQcGg6zMEnn8V+RFDRWzvGGBbFv2at2rRWNXEsZrLeC
         BZcg==
X-Gm-Message-State: APjAAAVV0lwboQRU/3L5qAA0RCGDxzXlk6sdVQWQCk/BZDwkSVjK89wQ
        ykwuPrrgf6Enamo/fEoGMiwDQndxGr3l+g==
X-Google-Smtp-Source: APXvYqw80QO+NnclFbZabRIUJYk3eZ1fx0BOGXnj7YcAoGj2Bc/nbhkaf+D07HaDn9/E+j/xNdkiVA==
X-Received: by 2002:a17:902:d896:: with SMTP id b22mr115605311plz.40.1558964121421;
        Mon, 27 May 2019 06:35:21 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id h60sm13268034pjb.10.2019.05.27.06.35.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 06:35:20 -0700 (PDT)
Subject: Re: [PATCH] block: Don't revalidate bdev of hidden gendisk
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, hare@suse.de
References: <20190515065740.12397-1-jack@suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d514ada8-d196-5766-731a-beb9897d2bc3@kernel.dk>
Date:   Mon, 27 May 2019 07:35:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515065740.12397-1-jack@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/15/19 12:57 AM, Jan Kara wrote:
> When hidden gendisk is revalidated, there's no point in revalidating
> associated block device as there's none. We would thus just create new
> bdev inode, report "detected capacity change from 0 to XXX" message and
> evict the bdev inode again. Avoid this pointless dance and confusing
> message in the kernel log.

Applied, thanks.

-- 
Jens Axboe

