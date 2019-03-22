Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB52C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 13:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C515721916
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 13:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfCVNmf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:42:35 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:37533 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbfCVNmf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 09:42:35 -0400
Received: by mail-pg1-f179.google.com with SMTP id q206so1568155pgq.4
        for <linux-block@vger.kernel.org>; Fri, 22 Mar 2019 06:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ocJOCosZ9OF3/mdM0y5kx5mfNJHzJpnW3S2kjcwd4ug=;
        b=t/ewmotl8q6EutbhJrHxxeL1txeKwRoHV311zdq9BA6DtV5WamSfCz/cRA708miF6q
         MrPVbX6sbn8sTUBsMlelmrJlEpJgpRWI7lsYEQ3fwz13bi8E7LGnTH8/uh7FW2T8iBfT
         h19Ag3hZZLmOgM8mOznZSMP6ktObRTWqzZITqNH7fXUShDvbOkMnZOXiQTW1/3JyT71a
         YC3YsGssXhrOKr4oyhVFPyuDz8HOLFzOAin9gbOd/QPSZK2kapge1YH5//B5BpCfLrw5
         YaDJOf6TlOoInoD8oeBUgeHN2cTl2fENDJwv4YLSw8kDqGpiKsB4oDcS6rJ9mvaSloI2
         MZAw==
X-Gm-Message-State: APjAAAU4zX4dKhFSAXIstF3zhXQGXONEDGI7xzLsogOBZ4s3RDDqSCe3
        xYDdJXQNIyYDJdnjAF56bjyZyGlGe9Y=
X-Google-Smtp-Source: APXvYqyXKJ1h1JUkA+y8DailIu0pUqdeFj5LtDfuuYcY7Vir/LpNwQ9Nvj0xmRKAvs8ULR1j1VO/tw==
X-Received: by 2002:a17:902:9683:: with SMTP id n3mr9737176plp.333.1553262154112;
        Fri, 22 Mar 2019 06:42:34 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id r66sm9277375pfr.131.2019.03.22.06.42.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 06:42:33 -0700 (PDT)
Subject: Re: Read data to kernel buffer by blkdev_read_iter
To:     Ivan Safonov <insafonov@gmail.com>, linux-block@vger.kernel.org
References: <b6d54ac9-ee29-edcf-907d-1e12fce321ac@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <98dec559-60bf-2463-7b0b-0cc2dd57db7d@acm.org>
Date:   Fri, 22 Mar 2019 06:42:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <b6d54ac9-ee29-edcf-907d-1e12fce321ac@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/22/19 6:06 AM, Ivan Safonov wrote:
> Kernel version is 4.19.16.
> 
> Is this behavior valid for iov_iter with type ITER_KVEC?

Are you familiar with the ITER_KVEC flag?

Bart.

