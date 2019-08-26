Return-Path: <SRS0=sRwj=WW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9EDC3A59F
	for <linux-block@archiver.kernel.org>; Mon, 26 Aug 2019 13:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FE12173E
	for <linux-block@archiver.kernel.org>; Mon, 26 Aug 2019 13:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="c80aseIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbfHZN7V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Aug 2019 09:59:21 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41845 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731140AbfHZN7S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Aug 2019 09:59:18 -0400
Received: by mail-io1-f67.google.com with SMTP id j5so37448314ioj.8
        for <linux-block@vger.kernel.org>; Mon, 26 Aug 2019 06:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HZ5+cm8oDGl9y7yBYTWMqRdFKjeGGqeRgHWdEMhzSsw=;
        b=c80aseIwaJV0ASqHmXiAVw59RoXvUUaEsL1tMrAmSu40HsButu6rq2Gj0CwjrLkiMF
         +0T4yP2gwaA0QMWgjR3idAX51delKj08+kYC7eyvr454TqC7/v6EALIni538EYlR45fW
         BMsOhTnHEhGN4YNraEjCsWTqyNZeAlkqCkQdB7dWPBaUuowqyn7om1itPED5NsWl9waj
         dYULOL86V6uykIjjS4DhBEqQk0Ujdp/DEk+t2m33F9Ipg6yN/MVmbvr3RcuorJOK0MbP
         HOdAQSuk8iW/4ro/6N6j+21PJhEINl0t4b6HunVmSNCIEpQsaI2c2TusbzERoooLWRyf
         xhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HZ5+cm8oDGl9y7yBYTWMqRdFKjeGGqeRgHWdEMhzSsw=;
        b=rbYNW3luYJ3FtNdJmzDk0IDoh7xfuf/T8iAbV9zYR2/mWvB+T9lX7e0Qlx7yEuzjyb
         DaPcZITbFVvGjRrJ4+VRooJxzvrs9emISzz1TjmSdoQuNR6rv7KbFLfAOP0iaOo0/30K
         qhNDRvpaUzuBN4FSOCJbwp9FE9q3MT6x8QTi83wgr0/3ZFF7hoOz7tti1Vn+HDmTXiwC
         CwnS14R95kKHSC7z2Soy/riSYFlpaGrThRvN2wjt303zhkPDj1rnZD1u0dQ/6bLSgxCW
         vQFShflz959/Ae0u0kL7tLhoN9T4XNvOCPipdsxjit5IRbC8x5UG4xqNwrSAN+ajKJbX
         3Wow==
X-Gm-Message-State: APjAAAXkjJ6K41aal8NpbTYP/vCx3wLh2c+aPcuDAANindWW/UqhAwWy
        FXW4mGcwXMKB1KFgk3BoPHZULA==
X-Google-Smtp-Source: APXvYqxsoPCPeSgpdUMZt1/AuxahBNZgEiTDX9WR6Q7MRgICyOdbpgFi1TfU8vU5EWfgSY8nktdgvQ==
X-Received: by 2002:a5d:8f8a:: with SMTP id l10mr23666295iol.306.1566827956999;
        Mon, 26 Aug 2019 06:59:16 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k7sm10354777iop.88.2019.08.26.06.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 06:59:16 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] bfq: Add per-device weight
To:     Paolo Valente <paolo.valente@linaro.org>, Tejun Heo <tj@kernel.org>
Cc:     Fam Zheng <zhengfeiran@bytedance.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fam Zheng <fam@euphon.net>, duanxiongchun@bytedance.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        zhangjiachen.jc@bytedance.com
References: <20190805063807.9494-1-zhengfeiran@bytedance.com>
 <20190805063807.9494-4-zhengfeiran@bytedance.com>
 <20190821154402.GI2263813@devbig004.ftw2.facebook.com>
 <C2F0BE1E-9CAA-4FBD-80D8-C18ECCE3FD4B@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fff76a58-65e7-7060-0329-aef15c422639@kernel.dk>
Date:   Mon, 26 Aug 2019 07:59:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <C2F0BE1E-9CAA-4FBD-80D8-C18ECCE3FD4B@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/26/19 12:36 AM, Paolo Valente wrote:
> Hi Jens,
> do you think this series could now be queued for 5.4?

The most glaring oversight in this series, is that the meat of it,
patch #3, doesn't even have a commit message. The cover letter
essentially looks like it should have been the commit message for
that patch.

Please resend with acks/reviews collected, and ensure that all
patches have a reasonable commit message.

-- 
Jens Axboe

