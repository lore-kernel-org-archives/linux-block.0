Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A08C67839
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 13:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05992133F
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 13:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MFf6Rcr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C05992133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbeLNNCO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:02:14 -0500
Received: from mail-pl1-f173.google.com ([209.85.214.173]:44829 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeLNNCN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 08:02:13 -0500
Received: by mail-pl1-f173.google.com with SMTP id e11so2072440plt.11
        for <linux-block@vger.kernel.org>; Fri, 14 Dec 2018 05:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8XXs8FjzZguf7baxmTw+VMZhZ3Uah1FhqP2O91JlnL8=;
        b=MFf6Rcr6rRTRSHuCMtp1hqSPlRzJQROyAEUDoP2fRNKTZ8wFa/Zqb/AtH6h4xJ93Hj
         QRuaGLcbkHEhCDvsLXu7CBI0tu8Lyp0OJT7HQYKwmVXzjFBffG3tWE4DcQAW5gIl/B6F
         LvRoxYuRl0A8oLjfikWFTkT11Sho9dTzlpZeDUQA+t7MqDpIz0eBkNTllqDsUtVeUy5s
         1E4kp4MaFDuo32sF89iBMterR4f8AsWvQKzug3xEER9YzxAKY/XrR58ZOzHY04rjUZ68
         yJI3zSuW60MC01AfmZx43/k3o055NclMqI/IdMT+yF3osM7vfRWlY4r58sy2RGbml88n
         yb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8XXs8FjzZguf7baxmTw+VMZhZ3Uah1FhqP2O91JlnL8=;
        b=ljGGwn0AZEE1adkxZaJkYs4PfYEKHJdSyAWeBKMSS5ZcM97GIp0FCCjPvMmM+9VhMX
         1XTMKCGmReQs99u4GnTdxJg6wNBCYJDOV8/L6WtYnE96EqMHtEVNV/UXoP7pz6mUtseh
         J0QBwncap+Z91eiI4Y8A2CZLtkUgoJ39sxikOVa2wC3ISCythHtgPfEBOwV42PyA07jZ
         rIPaqKnAPBuv9UybXz1n7y8AqhkPdBQO1bMp+rc7gP06A5jRV3PEdKnzmbDOo1iylURx
         7uAsOhRN447l/EQzV7X6kHBT4Jn+g9Phb1eOK3zma2WTZlGXkRsXIjTg2HmDhLap8IAb
         bDFQ==
X-Gm-Message-State: AA+aEWata1+8F33i2iPBZ6cOp8+71JBtcmKC8a8TX5S8YBieDk/om2A0
        vEQKdZ0hkHoqIU5Mi1Mt0Fe1sVS/rMULjA==
X-Google-Smtp-Source: AFSGD/WsJnzmkO9UG7BvKo2yFmLtMebL+gF42ZgatIBSLcp6U6Sou9m9CEx+qJVNNKxUX3tWWdzLwg==
X-Received: by 2002:a17:902:720c:: with SMTP id ba12mr2804092plb.79.1544792532757;
        Fri, 14 Dec 2018 05:02:12 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id g185sm7023071pfc.174.2018.12.14.05.02.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 05:02:11 -0800 (PST)
Subject: Re: misc block cleanups
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20181213203214.10650-1-hch@lst.de>
 <5a57919d-7098-8b00-bc72-54538d384d09@kernel.dk>
 <20181214130022.GA11066@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <63f1c8fa-f390-8c61-8083-ddb7a041a4ff@kernel.dk>
Date:   Fri, 14 Dec 2018 06:02:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181214130022.GA11066@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/14/18 6:00 AM, Christoph Hellwig wrote:
> On Thu, Dec 13, 2018 at 09:28:33PM -0700, Jens Axboe wrote:
>> On 12/13/18 1:32 PM, Christoph Hellwig wrote:
>>> Remove a few pointless helpers and unused exports.
>>
>> We've got quite a bit of churn this round, do you mind if we
>> push #1 to next round? I'm fine with killing the exports, if
>> they are not used, they should go.
> 
> Sure, fine with me.  Are you going to drop the accidental hunk
> yourself or should I resend?

I can drop it.

-- 
Jens Axboe

