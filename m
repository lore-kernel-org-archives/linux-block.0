Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0389C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702F52147A
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMvKegxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbfCVOzB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:55:01 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44416 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbfCVOzB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 10:55:01 -0400
Received: by mail-lj1-f196.google.com with SMTP id n18so2262310ljg.11
        for <linux-block@vger.kernel.org>; Fri, 22 Mar 2019 07:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=dHLeSHDrYgbSB2JusfLYx17Mi6oXvKxS/T8ghheSOXQ=;
        b=JMvKegxJGvEe6wqsUlCO4mAWuqO76Nzx6erJb91wOYR+dzbVj8AHXKD+9Bau9Z3Gis
         JGfxWgbDCLy4WdzPVSy3H6bzTca6V/7a9DaY4zhoLqQvTMXZ+mM1jL+HgSD7pnpku9dw
         TwBY4Gt2eTCHQbxO5weVz4EXvwtovGjO0ylACmpOvI7YTJUXgMiqgZtLY7rvGbQTzRrO
         FzNsbipr8bYV8TJhnebHM+Z+Sl9SZgMWpvFIazbXnBIkMdZQg3hGFi7OpQQ/Zoxmru3g
         l+0zSutbB+Q+btdWvS+jJNYKImmAdOQUI36kUshQUJ3seFRUJCzMw5lRQyMY73KjBpYp
         QC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dHLeSHDrYgbSB2JusfLYx17Mi6oXvKxS/T8ghheSOXQ=;
        b=rhOZDF4o67txrgM3h7QIMdx2gkNIkk0rVrv33PnUo1ZPcpY/dV4nO/x88cOkjrBfOi
         8yMhEMe5QRsP4d0UcaxDgmV/rvesFv7+d68JIL4Tcxbb+FBW+rG5843+/C3Jmu08MKbs
         dGBLqda5zamG6p2zY2ds7RvLZ0D16tju/ZifyWO2b0R2OtzSHkoucSUXIX15y7eyrNiu
         He343J/cgsSIwjamwM49okAXXZ4hXUsO6GEGVmUXd9FCNAZLotNxBALGclsnXz+gaTtA
         OJwxtEz2r9l7MkeOBb1j5mefB27jgV1gidbkO0uIEvn0ph8Eesz/LHR3OSYHhwQ0aq1C
         ASnA==
X-Gm-Message-State: APjAAAXJK1Nv4iAVJW3Mjpn9eRkd5A0LaP5eNobmTCXiyzA6NfO/MtSS
        AS8NfnYxP8+B64gbpl1iUnGnvcib
X-Google-Smtp-Source: APXvYqx1B575UgvJSxNWAoxm8PJ85awshX13dV9UFbTI3/5uK0ybvc+WVibbykKjDdGzmfZFqSZ5hw==
X-Received: by 2002:a2e:9ec9:: with SMTP id h9mr5505125ljk.176.1553266498963;
        Fri, 22 Mar 2019 07:54:58 -0700 (PDT)
Received: from [192.168.0.160] (ppp89-110-13-118.pppoe.avangarddsl.ru. [89.110.13.118])
        by smtp.gmail.com with ESMTPSA id w3sm454354lji.59.2019.03.22.07.54.58
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 07:54:58 -0700 (PDT)
Subject: Re: Read data to kernel buffer by blkdev_read_iter
To:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <b6d54ac9-ee29-edcf-907d-1e12fce321ac@gmail.com>
 <98dec559-60bf-2463-7b0b-0cc2dd57db7d@acm.org>
From:   Ivan Safonov <insafonov@gmail.com>
Message-ID: <1a5a1b81-49c0-2817-73d9-d58716c44b0a@gmail.com>
Date:   Fri, 22 Mar 2019 17:57:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <98dec559-60bf-2463-7b0b-0cc2dd57db7d@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/22/19 4:42 PM, Bart Van Assche wrote:
> On 3/22/19 6:06 AM, Ivan Safonov wrote:
>> Kernel version is 4.19.16.
>>
>> Is this behavior valid for iov_iter with type ITER_KVEC?
> 
> Are you familiar with the ITER_KVEC flag?

No, I did not find a clear description of this flag.

In the previous message I misled you: iov_iter has ITER_KVEC type only 
if set_fs(get_ds()) present before iov_iter_init(). In this case 
_without_ IOCB_DIRECT blkdev_read_iter() work fine. With IOCB_DIRECT 
blkdev_read_iter() return -EFAULT.
