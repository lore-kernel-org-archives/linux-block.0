Return-Path: <SRS0=GSyA=X4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFB7C10F14
	for <linux-block@archiver.kernel.org>; Thu,  3 Oct 2019 20:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA092133F
	for <linux-block@archiver.kernel.org>; Thu,  3 Oct 2019 20:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vS7NvV9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732388AbfJCUWE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Oct 2019 16:22:04 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39650 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbfJCUWE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Oct 2019 16:22:04 -0400
Received: by mail-io1-f65.google.com with SMTP id a1so8609495ioc.6
        for <linux-block@vger.kernel.org>; Thu, 03 Oct 2019 13:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7WiJ4f6SzOGtMzESiBYziKahNzjtC5eHf7/cW0u7vRo=;
        b=vS7NvV9D9OYLkuvCt7II7enEg4sGb3wAj+I3sIp5o4kFmqlWNbVU70/ysfI8h8cY3J
         qrP4SdB4ZsiAQ0xQM6mv6VyA3lq7MOyYuX5Fv0Qxr4SdpiDZTJktQXnhfYRv+03o+JV7
         7b0bTMqPO1nnWWnr+laA4xpyZ2Dk9vkuHyR69SzmtHEQes5UYEdLCl5P/Y6no9rwCQzY
         7pg/9qjUdF3ZDhshcTtbiCSK/VFKGU/drrT2Tg5vZPg3N/yd+K8JpasxHUT5rZSWwnwm
         /aqDOpNfheEA07AIBX8j3pcQtqyzEKJBymD0OPfV2W9ICaY5xSspm+G2CFyzDzK4IFap
         55qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7WiJ4f6SzOGtMzESiBYziKahNzjtC5eHf7/cW0u7vRo=;
        b=J7TY/FDWfoYaBO5GmxdDagEQNk8f28fCOHuIp9CZCBTp+kc5EydP7ODRtBZizPRrC8
         kh2sF0USzdPyZ6XBRsMtAiYG+w5A9SDoiTcCEYiNngR00Xve9a2Ib6aifFHYVMJCL2RX
         28k+BN84nogZfFhJdXycPJFC0Xs5aYVh6ZGI0qEhXMw5sRRDbpgKSW1q9Zzmsdtc4W4a
         VXCsREmPMITGS32noDGUYYko8Lkmwoz0jTGjMovssH7OVesC/qCxy30q1n69WgDxv6zB
         MB8nu+gOsED51O1sKRIvqFD8sAMmIGj6v8kZ3jJluwUGXZXFyPgZz6IlzQInmrk03NFe
         r5Cw==
X-Gm-Message-State: APjAAAVAg/M77/gYhWKp8k0Vsh082QRSX1ciDWHjIc+R3JlpQMpLb+DI
        rQb62HN6WKK6d5cSi/I4QZ/6/HVUDG2DKA==
X-Google-Smtp-Source: APXvYqyuZfaiEVvhudwj8fPSSMbzWnn8JOvkbO8LVY3q31G+3mNsQRcG6YIyPsQm1Vd3oK9PFrpp6w==
X-Received: by 2002:a02:cd05:: with SMTP id g5mr11297113jaq.52.1570134123075;
        Thu, 03 Oct 2019 13:22:03 -0700 (PDT)
Received: from ?IPv6:2620:10d:c081:1133::1057? ([2620:10d:c090:180::832a])
        by smtp.gmail.com with ESMTPSA id f1sm1683227ile.77.2019.10.03.13.22.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 13:22:02 -0700 (PDT)
Subject: Re: [PATCH 1/2] block: sed-opal: fix sparse warning: obsolete array
 init.
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>
References: <807d7b7f-623b-75f0-baab-13b1b0c02e9d@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f8b4652c-4169-793c-b626-6e52e1cc0693@kernel.dk>
Date:   Thu, 3 Oct 2019 14:22:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <807d7b7f-623b-75f0-baab-13b1b0c02e9d@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/2/19 8:23 PM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix sparse warning: (missing '=')
> ../block/sed-opal.c:133:17: warning: obsolete array initializer, use C99 syntax

Applied this (and 2/2, no cover letter...), thanks Randy.

-- 
Jens Axboe

