Return-Path: <SRS0=5EYj=43=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B521C18E5A
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 13:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2DEE222D9
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 13:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="y9KsGApx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731386AbgCJNSn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:18:43 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33865 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731315AbgCJNKT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Mar 2020 09:10:19 -0400
Received: by mail-io1-f66.google.com with SMTP id h131so11973145iof.1
        for <linux-block@vger.kernel.org>; Tue, 10 Mar 2020 06:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UUrMv36zRnXkHf6Asqo5OYZ49ZjO94p/ePSfPLoDD+0=;
        b=y9KsGApxeWW4bXMF/eML312C8m5yz0+k9k/rMVZdh2TJp5z2v0/zHiEph3X+d5m1Vl
         OrKzvyCQWZo/hAA8y+7zjn+n3NhEr3t0CKtBR9Hy8Kz4XxpzkpBoBzpGENnqpGkAX38Y
         aEffyNzpTIqhVjnS5AoPZHtFVrDhd3XehfGlqQSSTKy7P6HI5O3rFk65klnLRaLij8Av
         154wdDsHVmhct6MDBmK/xIVdXL7MuZuYoLEr8tfMtOcl0not2SApfHE7b/hxhlCnLSL6
         xmxZrYDQg7yYdpxJwDIft/k0QB4N2PwZlbP/zVLGAtF4zgSGpcxZ1WEmwCqwwQey7Bfe
         gkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UUrMv36zRnXkHf6Asqo5OYZ49ZjO94p/ePSfPLoDD+0=;
        b=CcEP/qtzblqFtflgx+zoXK4XL36yFg3O7XJSiiQ9TmHEl+uaSObY94EFzpS4nHD9ZD
         ZyEHOEYmYl+yb70+P8bY5ITwA+CcMlhD4f2nkf8t4dPyn+y43QUSOU/0kwF/7zeGGBW3
         7HdkfCju+s8njtr8+ZwHqB8zcXui4eHV5YEY08nvq2S6uTBW/vf5snuIETlT4FJodYAp
         y7k//yUXRNzPw084NM+snQYyhvWOzLZoO9ovhyf35jvCMUazsjv0jmWVG0WiwZo7enRK
         ef7Rb8fTmjDRBmQwAx7r4EFIRBhls1fl/s2x+DaL+vzivUKu8M8CIAeNaxVsap8L/h8M
         y0zg==
X-Gm-Message-State: ANhLgQ1RcKHkoiEU+0A+qK23uQ/C5+nFSHs+xG9cb8Ge5NbOwtN70SOE
        8I7ohVxO5sv3ArsXzVCTF7KnXQ==
X-Google-Smtp-Source: ADFU+vsXmw4yjiLjFO+x46Yj/AB/A5j+a7XfI5z4kZBPNozeTU0zocrBCi23jRfaMwTr0+0NPAcWjw==
X-Received: by 2002:a5d:9f13:: with SMTP id q19mr17173953iot.69.1583845818301;
        Tue, 10 Mar 2020 06:10:18 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w22sm396739ili.71.2020.03.10.06.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 06:10:17 -0700 (PDT)
Subject: Re: [PATCH v4 0/8] Improve changing the number of hardware queues
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20200310042623.20779-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <eadcc805-a159-2c64-c50b-7563cc8fc592@kernel.dk>
Date:   Tue, 10 Mar 2020 07:10:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200310042623.20779-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/9/20 10:26 PM, Bart Van Assche wrote:
> Hi Jens,
> 
> These patches are what I came up with while analyzing syzbot and blktests
> complaints related to dynamically changing the number of hardware queues.
> Please consider these patches for the upstream kernel.

Applied for 5.7, thanks Bart.

-- 
Jens Axboe

