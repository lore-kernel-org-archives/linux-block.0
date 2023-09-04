Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03BCC83F2D
	for <linux-block@archiver.kernel.org>; Mon,  4 Sep 2023 02:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350412AbjIDCZg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 3 Sep 2023 22:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350078AbjIDCZf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 3 Sep 2023 22:25:35 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A152DA
        for <linux-block@vger.kernel.org>; Sun,  3 Sep 2023 19:25:09 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c0d5b16aacso4629045ad.1
        for <linux-block@vger.kernel.org>; Sun, 03 Sep 2023 19:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693794308; x=1694399108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7gWr2NdMRB7w9t/LSaCpp2WEPnGXvp2qwpPt42E19uI=;
        b=FjDhKBsIbtpTUnwtFSAZx0vft3BY1fZi6a2ZfQxQVv2rh6FSVxC+mes3/YbUlryXuc
         eTOOJFYvDfhTIAnBhoPGAqrcSDhYsSzUdsZ4VBWcTI5qtHAIjGEHxsJGyT4ROg8keCRL
         i3zSYkgqKA33DMHuVZD996MfdVvucqyuUnWAOd3M/L21S3+ufb4XHYdx2PISIJDKmEhK
         Y6JE9nNoHcdnAuvlgBWTk790fLUFKpC/rFGr5fQFz34lE8BRxLReMMM53h+reX0eLZFV
         mtElJaGa1Qj0gz1FSqQwsEGQKmrTPyhkpEKF2DsjBeJ5qMHw/fM6lbQRSe8JE1cHQN+y
         hlzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693794308; x=1694399108;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7gWr2NdMRB7w9t/LSaCpp2WEPnGXvp2qwpPt42E19uI=;
        b=ghsUdj7RjAlaATYBN+lWT3dGERFNWG5AxU5e/nMI+Z8H1axd+KvYOoTW7zqI22G9wZ
         mVjaMvJLho0kEgFvIhuyY+HoUrRRe5Hst5P0MzZTi/0OTCkWo5Rg5eVSWfaarLGhGEMD
         yLg3CMzyszMKaQrWt3BZ8TBhVsrUkbA40fDwuQ6nZtTQiUo/ZyWrhTs9LCrc6no1Egpq
         3D0mbtQ7lyHcAE8miRby+ccXPi97b1oz3ib6mMXNB6ZJumMBxF43xaW6aFR7Pd5PvVl0
         EUmsKyBAJfMKbsXfeefXOMiDk+0aKB2PvsnOZsIRovFYHD3Yf8LPmgDW1snm78Jccd43
         DCMw==
X-Gm-Message-State: AOJu0YzU02oq9nTEgFQwdd5Om20VfkYPzh2grDFiioJ82NgUo/Ti2WPa
        lYM4QwZRA+8Nxt8YL/jq6xo4pw==
X-Google-Smtp-Source: AGHT+IHTX/NRbGpOQgZI7zKwBvAFLb1aMEEYtQAtzJFeT5lbWnZ7RlEXRfIZNRvsM7fVd17QZ8uBIw==
X-Received: by 2002:a17:902:e548:b0:1c2:9d0:e176 with SMTP id n8-20020a170902e54800b001c209d0e176mr8257613plf.27.1693794308518;
        Sun, 03 Sep 2023 19:25:08 -0700 (PDT)
Received: from [10.5.68.94] ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id jj14-20020a170903048e00b001b89891bfc4sm6450126plb.199.2023.09.03.19.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 19:25:08 -0700 (PDT)
Message-ID: <94b76d95-0ebe-396a-d00f-1aaa4ed00409@bytedance.com>
Date:   Mon, 4 Sep 2023 10:25:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 0/6] blk-mq-tag: remove bt_for_each()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, chengming.zhou@linux.dev,
        axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230823151803.926382-1-chengming.zhou@linux.dev>
 <a84b5ccb-151a-2de1-c213-de68a6f81f29@bytedance.com>
 <13c27994-e372-674f-d265-dc623fae26ce@acm.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <13c27994-e372-674f-d265-dc623fae26ce@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/9/4 07:51, Bart Van Assche wrote:
> On 9/2/23 07:58, Chengming Zhou wrote:
>> Hello, gentle ping.
> According to https://lore.kernel.org/linux-kernel/CAHk-=wgmKhCrdrOCjp=5v9NO6C=PJ8ZTZcCXj09piHzsZ7qqmw@mail.gmail.com/,
> the merge window opened on August 27 (one week ago). Since we are now
> in the middle of the merge window and since maintainers typically do
> not merge patch series during the merge window, it's probably the wrong
> time to send a ping.
> 

Oh, I get it. Sorry for the noise.

Thanks.
