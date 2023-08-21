Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1150EE49A4
	for <linux-block@archiver.kernel.org>; Mon, 21 Aug 2023 01:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjHUB4Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Aug 2023 21:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjHUB4X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Aug 2023 21:56:23 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF529C
        for <linux-block@vger.kernel.org>; Sun, 20 Aug 2023 18:56:21 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bf095e1becso4863625ad.1
        for <linux-block@vger.kernel.org>; Sun, 20 Aug 2023 18:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692582981; x=1693187781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZjXSX1KvMmGYvEdakPnG0KcUT8Tam2tiQMZo6hWZ+Po=;
        b=PXTx9YW2Rkf28ce6bA4D7bJZwT5HMOIWgbmiy+lVU2Rt9RjeFNWHPKYymqoGckQiku
         EXUSnnosxoS9pS3X8hHdZCHY/EgZw8vXxalt3oMPiL5VMxibvJP5Z/VITC4AtpRE1cT1
         PpgCWvPkxJuFTVTG8iRW54Bz5usdTUTwlFkSBSULsSqGh1W5Tn9QtbgTu/f4SetdTbbP
         jsH75jjwtsO8tp6BYWFmIs7BiV4fuhxgQOwKsHHG7JCiAf96iVyS9ChuuTCJ5vJeGlwE
         Mpo0vf4MZNIDRyT1RRXPo9tsXt+qyktFZjT7FAy4h1/csIzZs7eMrivU8dEeW1GI/WEw
         qYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692582981; x=1693187781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjXSX1KvMmGYvEdakPnG0KcUT8Tam2tiQMZo6hWZ+Po=;
        b=b5bBY2sJwcOitVjeF3t7voatiWmR6nYv1qssCV/BLyqPeM2yjN1v7PRr5CRTxfJTmb
         N3r5FaXHQqyr7HO3bTes0HweHa5u5FUK8Nf1Nng/weXE+KgyFBCRmGoAw7AG+g66XQH9
         tLLRbCxYQvGovc3G0b6zYt5bLt1fayjgsoqSaO5GPR/Jfb5o8ExNUe0WYJVk1b9r6W8j
         0slU4U5q3g/dtWd2LeqrmEprm1hqTF2optzTMruEFxsAjdmj3lq+66YqSK5BW6tAw0pr
         tq/uJydk7ehHX8GyYD9Nn3pT1CzyVq17CqvWQbJFzjxGnAfGY87opjKcPyBQf92azuYW
         M4dA==
X-Gm-Message-State: AOJu0YwgzGQmsiFrI5cgLZcSuFbhpzdiUrj7ea4hJZKqAkd7dFo9w6oK
        jPmEP5QOR1mwsw/mXJrNzlKJYD29eSYlQdvbaEs=
X-Google-Smtp-Source: AGHT+IGkRYxRGuq/ym7VGYpeO9npieWjiXePJSASBz1Mv0+FfZuP8QhtRzmyIWPU/ePcLV0kn1Si6g==
X-Received: by 2002:a05:6a21:6da5:b0:133:6e3d:68cd with SMTP id wl37-20020a056a216da500b001336e3d68cdmr7973254pzb.3.1692582981340;
        Sun, 20 Aug 2023 18:56:21 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x3-20020a63b343000000b0053051d50a48sm4748930pgt.79.2023.08.20.18.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 18:56:20 -0700 (PDT)
Message-ID: <cffead50-032a-46d3-bc9e-ace6586a69d5@kernel.dk>
Date:   Sun, 20 Aug 2023 19:56:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] WARNING: CPU: 12 PID: 51497 at
 block/mq-deadline.c:679 dd_exit_sched+0xd5/0xe0
Content-Language: en-US
To:     Changhui Zhong <czhong@redhat.com>, linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>
References: <CAGVVp+Xiz99dpFPn5RYjFfA-8tZH0cSvsmydB=1k08GfbViAFw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAGVVp+Xiz99dpFPn5RYjFfA-8tZH0cSvsmydB=1k08GfbViAFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/20/23 7:43 PM, Changhui Zhong wrote:
> Hello,
> 
> triggered below warning issue with branch 'block-6.5',

What sha? Please always include that in bug reports, people don't know
when you pulled it.

-- 
Jens Axboe

