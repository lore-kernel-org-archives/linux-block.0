Return-Path: <SRS0=03jz=XI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B2CC4CEC5
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 20:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199E2206BB
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 20:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbfIMUWW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Sep 2019 16:22:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42834 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfIMUWW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Sep 2019 16:22:22 -0400
Received: by mail-pl1-f193.google.com with SMTP id e5so2665941pls.9;
        Fri, 13 Sep 2019 13:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mAM07QavgvszW8h2pJrRMughxQBytjenaDIjAUeKITc=;
        b=cM2rmnj9l7etkrs+nOU/5jjU5UPHKc7tdFBkvACZ+pzY7Tjf/k1ZIeRoM9m3ySCC4E
         g518pvoQ0qbbQQLAborWW/5JUXfbjtNVMuuVSG6k+66FAKw2LYWGCTWMUWbg8Xt6j05/
         mktJuZminqZdJ+g6B8puKdmiabxlbk40CY5i8+SMkpJopCxMgm5cBMlhPlPOzx/oaBkH
         R0Og1yAM1YDBZzM4OloVJYrJyGw6aHWi5ny9k4wKs7j7/oDwzTE6jSMTglmkopwVI79F
         wBN2FNqzR5+ShJ6U3fh5OdQf5hpO3YXbMR99na1RmNHPkL413o0chBIZbpPKncqEaAf1
         Dsvw==
X-Gm-Message-State: APjAAAUapDOkusIt91e9lGfbCwKQ+QdaBN3F3cJbmGczTFSkL07V2bYh
        QYT7UHbxKa9SceyEzNPWrjc6hSZ5
X-Google-Smtp-Source: APXvYqzzuuNXe0WJwCdas9lOtDuhsl5jhREKUP7vp4wmbE3OQB48lA16Z9M9SYL0hBiRsoBKXYXm2w==
X-Received: by 2002:a17:902:9a8f:: with SMTP id w15mr51145465plp.221.1568406141133;
        Fri, 13 Sep 2019 13:22:21 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id m13sm30066125pgn.57.2019.09.13.13.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2019 13:22:19 -0700 (PDT)
Subject: Re: [PATCH 4/4] coding-style: add explanation about pr_fmt macro
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, axboe@kernel.dk, kernel@collabora.com,
        krisman@collabora.com
References: <20190913185746.337429-1-andrealmeid@collabora.com>
 <20190913185746.337429-5-andrealmeid@collabora.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <125475bd-ca6d-5d2a-712d-9cb37a4b8164@acm.org>
Date:   Fri, 13 Sep 2019 13:22:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190913185746.337429-5-andrealmeid@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/13/19 11:57 AM, André Almeida wrote:
> The pr_fmt macro is useful to format log messages printed by pr_XXXX()
> functions. Add text to explain the purpose of it, how to use and an
> example.
> 
> Signed-off-by: André Almeida <andrealmeid@collabora.com>

Since Jonathan Corbet is documentation maintainer, shouldn't he be Cc'ed 
explicitly for documentation patches? See also the MAINTAINERS file.

Bart.
