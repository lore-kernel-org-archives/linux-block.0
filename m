Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31A1C71153
	for <linux-block@archiver.kernel.org>; Sun,  3 Sep 2023 23:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237486AbjICXvn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 3 Sep 2023 19:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjICXvn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 3 Sep 2023 19:51:43 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501A6101;
        Sun,  3 Sep 2023 16:51:39 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1c0bae4da38so4932425ad.0;
        Sun, 03 Sep 2023 16:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693785098; x=1694389898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ADnKw0W/UsRkjXvTVJNNboOZq94SyLmEu8LrYVuRXYc=;
        b=fL+jPeS7iY2c5hVROLI4TqW4Rti+xD/0uZdC4C9BtnvU1Kpp/9W1d1gBwFkNuWoorR
         ROb8A7z4N+6oHzl33XXJlWbvbrFnOirOTjuvPUVdG3UdgP1OSqVTWC8bJiVLTg3OEszx
         shWHr2mAUfEmNqML8YK+uQzBJ2bOWtZ1SkLh8hqEEJLasvHziBeltI4sJ1vT+LIlLQNK
         nSYV8ZpvZPfqJbPKdYiGslOVZBULlTzECZMprUJV18vgCm8h9vy5060SlGTCX2Htq60i
         WQ1f9py8zJ8SL8vEnNi7NXcAyjS2cEGqAw5SuCqqUYzwPan6Sf+KBRktlo83a1F3+OtU
         zZ3g==
X-Gm-Message-State: AOJu0YxMB3axPeQQWvIFMpOb9xzZpfmVDJUs1aGzrEpTwOGXgPwBDKtc
        I5ta/n0KfERleo8ylX04muY=
X-Google-Smtp-Source: AGHT+IGVxhESb6AXKsqFygXQ5Nwv6dnJpRb3uG5hX63kaP4jRjov6+WKTVTRO8CqFVfQx9roqztSTg==
X-Received: by 2002:a17:902:e54e:b0:1c1:eb8b:799d with SMTP id n14-20020a170902e54e00b001c1eb8b799dmr11718856plf.21.1693785098541;
        Sun, 03 Sep 2023 16:51:38 -0700 (PDT)
Received: from ?IPV6:2601:647:5f00:5f5:4a46:e57b:bee0:6bc6? ([2601:647:5f00:5f5:4a46:e57b:bee0:6bc6])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902c1c100b001b83dc8649dsm6347957plc.250.2023.09.03.16.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 16:51:37 -0700 (PDT)
Message-ID: <13c27994-e372-674f-d265-dc623fae26ce@acm.org>
Date:   Sun, 3 Sep 2023 16:51:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 0/6] blk-mq-tag: remove bt_for_each()
To:     Chengming Zhou <zhouchengming@bytedance.com>,
        chengming.zhou@linux.dev, axboe@kernel.dk, ming.lei@redhat.com,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230823151803.926382-1-chengming.zhou@linux.dev>
 <a84b5ccb-151a-2de1-c213-de68a6f81f29@bytedance.com>
Content-Language: en-US
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <a84b5ccb-151a-2de1-c213-de68a6f81f29@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/2/23 07:58, Chengming Zhou wrote:
> Hello, gentle ping.
According to 
https://lore.kernel.org/linux-kernel/CAHk-=wgmKhCrdrOCjp=5v9NO6C=PJ8ZTZcCXj09piHzsZ7qqmw@mail.gmail.com/,
the merge window opened on August 27 (one week ago). Since we are now
in the middle of the merge window and since maintainers typically do
not merge patch series during the merge window, it's probably the wrong
time to send a ping.

Thanks,

Bart.
