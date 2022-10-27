Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE106FA3740
	for <linux-block@archiver.kernel.org>; Thu, 27 Oct 2022 13:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbiJ0NuM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Oct 2022 09:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbiJ0NuK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2022 09:50:10 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2739F21252
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 06:50:09 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r18so1448163pgr.12
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 06:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FW8SDDyFoIgZ11fCIDEb5/njIXheP9SuXFNwX7gCdRo=;
        b=ray4nfHffyq7wCaoQJ9uQlQj/pCf7S6TJAXjZhh4ad+oNuCYd/SfDjmc77hoNQ/4l+
         4gyVN4X3rutBPHsezP22Dj+xroj0007DMiBKb3G7LW0DA7ZcDY2cPV9dAZD7s71eIbwg
         +Ebqmfhho9ibASmGzecwP/y8ZVkp9GPDzjUaAsMqLraNIXrLDCSPuFemw+5B4CqpUKVj
         XZeAodAb7Zjw70OddrkE8aSXCDupItRibKvLhphxLfqUN5TA0TlzKMrQzWZFxAZVjQqs
         7Khnir2K5Xf1du6SQs+fPa5XNIGXUvvGRyiIi6CvsmlpxOphi9YHoFokDQXfSnGQCF72
         Oteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FW8SDDyFoIgZ11fCIDEb5/njIXheP9SuXFNwX7gCdRo=;
        b=CQyumT+K4Y6jopiBQwaLHNiDzyr+gwAmEfmxL81i1odKwAsJUXkblT4faKEfLfOuy7
         PJbtKd0vQdNJOrW5d9qRXCxr84CGsSoVJrtov0DdsuXVy38UMnre7QRl/rTQcn2alrnh
         1gv+HQV+OFv8FIGen2A7OfkHn6Kqtr/QyRUrRVRyE9uuCb+DCCvpLaycl9JNczvaUrsi
         rbtqvSwg4OMUkAITr2vRv/E8f5+4onYRBndWYL8lHXSiy5p7NKBFrW5JpHDHquT4w2Qb
         j7o/0Cs6nzDQbbEgP/DpDJHlYMeGSJIs7vD23j3KiQ+ok78uidkoihVKPhp4sBEtdPnw
         nmzg==
X-Gm-Message-State: ACrzQf1p7Nh7dIXkA8z7pc2lQRyFqsa24AJInukbdKdBUyVwiRxguQQ7
        L+9GuDOt0q6u826SGhAjRNN4oA==
X-Google-Smtp-Source: AMsMyM6/UqY2wxYkRITNJDsA3m1jKb4ifNK/phsUmeXLP92Q2pWQ3mpu6Pos+qOD9W1NFosMwxYe+w==
X-Received: by 2002:a63:ea4c:0:b0:46b:2772:40a4 with SMTP id l12-20020a63ea4c000000b0046b277240a4mr41589073pgk.342.1666878608384;
        Thu, 27 Oct 2022 06:50:08 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902d2c800b0017f73caf588sm1226367plc.218.2022.10.27.06.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 06:50:07 -0700 (PDT)
Message-ID: <7cb31ceb-94cc-40ae-95c2-7e26e4c9a8ac@kernel.dk>
Date:   Thu, 27 Oct 2022 07:50:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [GIT PULL] nvme fixes for Linux 6.1
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <Y1qL1zsNFc6w2WTd@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y1qL1zsNFc6w2WTd@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/27/22 7:47 AM, Christoph Hellwig wrote:
> The following changes since commit 02341a08c9dec5a88527981b0bdf0fb6f7499cbf:
> 
>   block: fix memory leak for elevator on add_disk failure (2022-10-22 15:14:38 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.1-2022-10-27

Pulled, thanks.

-- 
Jens Axboe


