Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9AFCA0FE5
	for <linux-block@archiver.kernel.org>; Fri,  1 Sep 2023 14:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238849AbjIAOTD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Sep 2023 10:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbjIAOTC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Sep 2023 10:19:02 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D8210EC
        for <linux-block@vger.kernel.org>; Fri,  1 Sep 2023 07:18:59 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-760dff4b701so17760539f.0
        for <linux-block@vger.kernel.org>; Fri, 01 Sep 2023 07:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1693577938; x=1694182738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKW1nBpS9Q1X56VwSVFjCsUpOjQeYfRziNFoaW07QFU=;
        b=OdyR2l3NjsHiGUqHvapLNx/ge4OdMUccs7484R+VEENqMDBqwgke3wB1WFBqSU013n
         vkfDVhWFAKOjr9QHFbQRr6GgG0UQR5QlYM/bmHgwObTcUJOTHCz0OIgsZoIdlUU45UFN
         1W+EbHzq69HXnWIVbCPR040dKrlXlGtDIItpzm82HEgy4tq0jMSSEouA2lil2dU0QXnF
         TT5Nk+EGPSpFXBzS1PcrXYzHr81jBq7haxC47aHCeciQB9KHBWrEf9fISs7EeDZ+VZJe
         /aQqo0OgiINXa01r7YBbHoxP2FfIdZCYItKN0umlA7vijIoHCEig2C+uNeYWAlWZfMKi
         TNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693577938; x=1694182738;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKW1nBpS9Q1X56VwSVFjCsUpOjQeYfRziNFoaW07QFU=;
        b=G2Jp6gBMRIV0ti3CsggrD2mmBLce9L+pn8xPbymASgd9FXEczBzX2eXP9ADV1i91FN
         WFJyHzZoHyEr21NIdKG+8JxXwUoQlcf6NbN8dlkhOThf6bBjY+drY7F3kA9+0cY+JZhG
         LVBPf9DDSSYHM9/NWMZW4vcx/0OHLtdSDPoqwy9XWdnt/m965Le0iOtgB23XQmh9AmBU
         tXZHz4+a+4dxN5Lts3CBZQzjyCiq3VhvuIaCZFjcTaPad+3nK99qfZStgkwZDguXE0CO
         hF5AeS0u2OnVQlt/Xr7QX8Ay7WG0aE8qkU7n8ypSsTWSw0bJ/6vR3+AhlvS5Jk6B9Ekz
         fQsg==
X-Gm-Message-State: AOJu0Yxi1VXFG6/FpqnunmBA71GMFD3+s/xQrKEIvY4TVsklkRtyrM0e
        uux/n5eab9YJl9/XXkOyf0aNUFjflwnU3ackkA0SFg==
X-Google-Smtp-Source: AGHT+IG0FShxW6UI1rD4z3lHhMt+9RIs9nN9WfcpkcaP7pSgzZyph0R8n1EkmyMxNwZ7byZTuhPHtw==
X-Received: by 2002:a6b:1495:0:b0:790:958e:a667 with SMTP id 143-20020a6b1495000000b00790958ea667mr2645886iou.2.1693577938521;
        Fri, 01 Sep 2023 07:18:58 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id fq24-20020a056638651800b004182f88c368sm1080139jab.67.2023.09.01.07.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 07:18:57 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com, chengming.zhou@linux.dev
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com, dhowells@redhat.com
In-Reply-To: <20230901120306.170520-1-chengming.zhou@linux.dev>
References: <20230901120306.170520-1-chengming.zhou@linux.dev>
Subject: Re: [PATCH v2 0/1] block/null_blk: fix poll request timeout panic
Message-Id: <169357793753.310999.18144823981209368799.b4-ty@kernel.dk>
Date:   Fri, 01 Sep 2023 08:18:57 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 01 Sep 2023 20:03:05 +0800, chengming.zhou@linux.dev wrote:
> Changes in v2:
>  - Improve the commit message a little.
>  - Add Tested-by from David Howells and Reviewed-by from Ming Lei.
> 
> The 't/io_uring -n4 /dev/nullb0' is easy to trigger poll request timeout,
> then panic the kernel.
> 
> [...]

Applied, thanks!

[1/1] null_blk: fix poll request timeout handling
      commit: 5a26e45edb4690d58406178b5a9ea4c6dcf2c105

Best regards,
-- 
Jens Axboe



