Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686E5C33C99
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 04:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AEF2206DA
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 04:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AgSB2QGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgAGEAw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Jan 2020 23:00:52 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38139 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbgAGEAw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Jan 2020 23:00:52 -0500
Received: by mail-pj1-f67.google.com with SMTP id l35so8649321pje.3
        for <linux-block@vger.kernel.org>; Mon, 06 Jan 2020 20:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IDCrh5LU02xdyVVSeGrhk0v+Nn+rcCBZJkM7RND9gQc=;
        b=AgSB2QGcNOkAmQDnPg0qJ95jZuF+cox/xKD8BbOZPNirA5QsJ2qABy6jsOHbmFe86x
         feKPo1pAzo5sNCeduh1hwtHtLlqlI3KqiQfI3X84uB/ZdCymQ6/jKqDhDOp5ISFzwUeU
         W0Zc5STk1TY4RG2xQ9M5kW1GwIsoPNDDz/J2F3xef2CoXrLGRzWMQXat7Y15YLT8Gzrx
         O08dvSkjnrUFYr3OdkVNFRuoR6xo4U447jP2K6R3irf8dkurnhJmkvLOwHfvzIgwpCQ3
         0VtuhTtLDYytE0lzl3RnNoRJjtq1/L5aBFyxl25W+9mpkBt0tg3q8Z6wd8QenQmAWOpB
         nvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IDCrh5LU02xdyVVSeGrhk0v+Nn+rcCBZJkM7RND9gQc=;
        b=N6XwPM2LKpMaN1Kjj72oidi5QaFpPiW/rRzwcIb3LCdOzud4SHsKx814wI+K3sLxWT
         W6cvY1Hd6L2sC95ILMlpO+Nr4Yjk9vIYM8NOPOv6k6V7vrs0Lyh9u1tVzuUl3BJ/p69a
         eS89Ly2es78atbQJkSXFrAPmY4l5XZwDK26ol0AHAhKja6j+335NxZWvLF+NtTWLGbEO
         Y4d4p1FFM39CNLzInnyQLrYCm2MWl/maUPfg80oMWnjhC9ivTiy04Jo8OhMDX38Oaf2T
         qX2Hp6BDj9pE1t5g0+dRJdlvA4DYkfNApMHugm7db9q919FmC+yU3mCsF4SuAcvf91QA
         NTbQ==
X-Gm-Message-State: APjAAAXhsk8JBm8PSZIY4BWiRL4y9JYum5J6My90YCt5wk/HUb+qfJ7Y
        tzMO7/GOoRfiI2Rcdi0ti4wq4hl8sUU=
X-Google-Smtp-Source: APXvYqxXapE4v1DYtCz23M9HSUSd41DR55c5Hx3bHbCFrSt8T1CTv9+m5BUMjHoBcbR81AGcHP0z0A==
X-Received: by 2002:a17:902:a407:: with SMTP id p7mr103951146plq.4.1578369651826;
        Mon, 06 Jan 2020 20:00:51 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id z22sm73051202pfr.83.2020.01.06.20.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 20:00:51 -0800 (PST)
Subject: Re: [RESEND PATCH v3] blk-mq: Document functions for sending request
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, krisman@collabora.com
References: <20200106180818.85365-1-andrealmeid@collabora.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6ff62e36-b285-3fcd-be2e-fece1ddcb0cb@kernel.dk>
Date:   Mon, 6 Jan 2020 21:00:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200106180818.85365-1-andrealmeid@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/6/20 11:08 AM, André Almeida wrote:
> Add or improve documentation for function regarding creating and sending
> IO requests to the hardware.

Applied, thanks.

-- 
Jens Axboe

