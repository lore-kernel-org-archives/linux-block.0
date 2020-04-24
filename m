Return-Path: <SRS0=nYW3=6I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404F6C54FD0
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 14:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 131612071E
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 14:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Rn2FIfyY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgDXOxm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 10:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726791AbgDXOxm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 10:53:42 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CDBC09B045
        for <linux-block@vger.kernel.org>; Fri, 24 Apr 2020 07:53:42 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id u5so9532383ilb.5
        for <linux-block@vger.kernel.org>; Fri, 24 Apr 2020 07:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=36A9ddDrJdy694dy+wY5wqnMU7ps6fUgob1RO3cfwno=;
        b=Rn2FIfyY3wAdCqAOZKQHczKFG1lpsr+C+/+HE70GlMF0nRJ6d7Q5e78dPKFXAXT6Q0
         qRVVhiafVOgzJwhZ5usb/Qmuheslu8Olcgbda77OKV9K+oZggoUOQ/JlFchuJnNYros3
         f+6Lk+FkivXE2YvLoxJr4KHmoJrAKxM6ecHcl7bMy4HHmf+wrQr66uNEU5aNns5/xhWj
         YlJrUA0TML3pm1k7CsoZn3CCYa/KicWRM9nhn2a/4Dkc53xuD9rcv/w/Mle654N3DfCX
         MX8HotGA/NzMF88FsXwg4oooMuKpie1cfNrxHgHTO2MY637cO32fePYUGCTWKumDq3Q7
         SRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=36A9ddDrJdy694dy+wY5wqnMU7ps6fUgob1RO3cfwno=;
        b=GXdcCdXSfaUXmagNCMdaa0ciqeNW2bxZjGMKHgOh+FAWiQ3yMtXi3b2elApIqnqrjj
         fWJiAXHYx4HTjsmOp8ve9ySHkahBQ8jrmDIc7OPxRXMVgdw5VJ9I4g/t1Hae8rI4J7r2
         HCNMk2MDwahejhHoHSav78bAZ34vkjNnyR21Wp4AfeGtS3J5p+8Bx5aZMk1UpK0ykfrr
         XzJXPGE3FTeM0jdwHoxFblFCHVASbIzq0oRnje1WqGECAcZ+U4EZTv+Siqvjq43yXH+0
         7BBCkshB16akfXF8gEZQX/wgDzSeF20h+/RY92HmN2y7TPKVgfKO4hvYbCX5rrBAz13N
         MxBw==
X-Gm-Message-State: AGi0Pua7ZWdmCXLqTT27Iq+fqs1t8BF/5PCXKUZ27MqMXEGBDCoY17hd
        N4ZFiU0mb1pLubE/ViC8mNXqcmquj5C8tA==
X-Google-Smtp-Source: APiQypL4FysJvDAvc+EUxXHnJOkcnFDUSlWxj/uddIgleKCC6ubtjQcZ2mJvEdz7ioFWwPMOCWamdg==
X-Received: by 2002:a92:aac8:: with SMTP id p69mr8745756ill.305.1587740021185;
        Fri, 24 Apr 2020 07:53:41 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s22sm2168960ilk.50.2020.04.24.07.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 07:53:40 -0700 (PDT)
Subject: Re: [PATCH] block: remove create_io_context
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20200424110228.572808-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <46541f90-30d7-1977-c0d8-428592a9f027@kernel.dk>
Date:   Fri, 24 Apr 2020 08:53:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424110228.572808-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/24/20 5:02 AM, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This really needs a commit message.

-- 
Jens Axboe

