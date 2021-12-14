Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5D2C433FE
	for <linux-block@archiver.kernel.org>; Tue, 14 Dec 2021 13:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbhLNN7O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Dec 2021 08:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbhLNN7N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Dec 2021 08:59:13 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8D2C061748
        for <linux-block@vger.kernel.org>; Tue, 14 Dec 2021 05:59:13 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id t7so1105072iln.12
        for <linux-block@vger.kernel.org>; Tue, 14 Dec 2021 05:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vkt27jyKBc5TiS5qbM/sF3Ng+qiD9oaD9dpLTZFgFPg=;
        b=kCqmAyxLCtc04xEUN622f2pBz4Sq5b3enBRS2WBkOfvzwPxyhZfT/xTcxVBQI7Ro+C
         GMxC6qdBC8qslybcmpMnhV9JUVcL51Fh7OCNrXxWx74ljsvFLlkSz7QJIy+GJywgQhPm
         80Mlb/xVqO6y2sKI/M6zY7QwlUAgX86e0LYpN4nA5qv6MdSl+8GvWKEGjpqPAWUNOnms
         CJyQ18nl+nT+h/Agh3i3iTcEcaTggSq8bBWQxkNCI/i+VETqWOtABVk1KJFop+hCr1t2
         gH7ytI82UxhJG7Qduh997UggOPKpEvGHdgDAKfbAULnmF+La/UaZDsCG/TlBqvenQVPj
         KJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vkt27jyKBc5TiS5qbM/sF3Ng+qiD9oaD9dpLTZFgFPg=;
        b=G5mnQinog+wV4S5bV6vX6TdqqL1mpuiLxNzP5Oa1WM4H68QizB3hiWVjoljhYhWKCo
         gyx38QvjkFhkXFJ6O+IPHOV/bSw76Vvf3OiiBQP7/6A2Np/7Q3PwbiCy7qjv2ZQ2GecV
         CE06N0XU2HA4PxqN3yVFoa/ClRGaHrcPZXEz6HnlHI0e5FnGvaZzBR98U+YUG7pFFOeQ
         jMLToXV6CiqnDZMjLImZOS0bwfCvnolmzp0y39KWKOfy7CxRXroteypSerFFhq5E7DZa
         q/bgA3BH8VfJiU2TnJ0el9y0ag7BOt3xroCW/yOI/MSvr05UolMbNHwG0e5c4lFy2BQL
         g23w==
X-Gm-Message-State: AOAM532vflvAr8yZ7XV3bbX/7IfoYU5fEodlAA98f0P+0b4vVIJee2Ou
        KbAIfH8h8TEp8CCLWgAJr1r8lQ==
X-Google-Smtp-Source: ABdhPJyT+360tMyccVsA34sWxQ0fjtyqpQ95UeHJXv9okxV27P74TnPV2Qys2chTJBB++ikJ8jqMRw==
X-Received: by 2002:a05:6e02:1be5:: with SMTP id y5mr3679166ilv.156.1639490352892;
        Tue, 14 Dec 2021 05:59:12 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id x7sm8894631ilq.86.2021.12.14.05.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 05:59:12 -0800 (PST)
Subject: Re: [PATCH v5 4/4] rsxx: Drop PCI legacy power management
To:     Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20211208192449.146076-1-helgaas@kernel.org>
 <20211208192449.146076-5-helgaas@kernel.org> <YbhN69IhTbGhvVeD@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4c856b61-6e16-1943-c816-3736b872aa06@kernel.dk>
Date:   Tue, 14 Dec 2021 06:59:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YbhN69IhTbGhvVeD@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/14/21 12:55 AM, Christoph Hellwig wrote:
> Maybe it is time to just drop this driver?  It was never widly used,
> seems unmaintained and uses a cumbersome own queueing layer instead
> of blk-mq.

I think so, but let's do that independently of this series.

-- 
Jens Axboe

