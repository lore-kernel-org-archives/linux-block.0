Return-Path: <SRS0=kmcw=XN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472FAC4CEC4
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 19:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1677721D6C
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 19:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TjVGFJkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbfIRTtd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Sep 2019 15:49:33 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40837 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731779AbfIRTtd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Sep 2019 15:49:33 -0400
Received: by mail-io1-f67.google.com with SMTP id h144so2035928iof.7
        for <linux-block@vger.kernel.org>; Wed, 18 Sep 2019 12:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vCoijcauhMYJ1DvP1GZNkU063OIfcJ8cclBAqUVCvg4=;
        b=TjVGFJkz76waIBmVExpqCS7hysAaVglQjxwzfdVbPRTAeOdpzvCCiqlE4l5q8UsgMs
         GM7XjzvEPzO9jOoKcLl314Z84B24tP7mruE36AKFE8hCf0UyZjal94+E7kGaEoj01khq
         zMoYHvQezGagYbAtuPvzoP5uPbFgTRQ2xddXNlFhBHHrBSFJJ+F2VUxy1JBnDyYM1Nhr
         LAI6ZvTmiXTJLkKcOB+5RxyOM4y2VP8GPHvSUvEHq7awowz3C0qxzSJO8rS9FrYBG0jB
         kFbXhttq9noMwB4w9KLg1y1Es1p6x3xEG/4TLqHW3pIvwqttUH7CgBiERxPhBuqZpxRZ
         gPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vCoijcauhMYJ1DvP1GZNkU063OIfcJ8cclBAqUVCvg4=;
        b=H8NSPvWsmdSzw8IWyHzAxrOdxGz6+a/+PPAhLW86yr+I1Izmesd57zz9eIEaUS3qmT
         E/ZPezkJQH7aeKT9VzI2e0YfVehX6XTUYOXhmul311Qsea36Jy5FrjpE/aPIf2YjHkmE
         R19OMgmWIHQykHkjOeHXCzQDu3tXqsxyd8M3D5Q1PQY+34fEUStzEcYTtD4eimdEM7Gw
         B9KS7vCDxknR57gV/oc0dUTtrzASP+acrCqAtGIGWmDVFJAbauy0Usl1BNQCxxrgEXBf
         J299sk7N0XV400WrWqrhuWeUDz+jnP5BsAzmxJXNP4Fh8cEas5lA1BjFfUvsk9HDHtU8
         3ihA==
X-Gm-Message-State: APjAAAUy0sdPGZXRgVvFy+sXfkerPCll5CehnOfnE7mYQ9myiAg84ES5
        vaYc+8NIW7xj4szNdJqsUQK3fw==
X-Google-Smtp-Source: APXvYqxuuAg1zN5L9WSLAdSx0vkF5i9r+qfKKHbiyhauGBeQIzz02PIY43jFMrPPSM9MvGSQSo69oA==
X-Received: by 2002:a02:16c5:: with SMTP id a188mr7066095jaa.106.1568836171665;
        Wed, 18 Sep 2019 12:49:31 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c8sm1450558iol.57.2019.09.18.12.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 12:49:30 -0700 (PDT)
Subject: Re: [PATCH V2 0/2] block: track per requests type merged count
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     "osandov@fb.com" <osandov@fb.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
References: <20190918005454.6872-1-chaitanya.kulkarni@wdc.com>
 <369ecccb-06ca-68d0-1474-34abdc2e8851@kernel.dk>
 <BYAPR04MB57494B7D18A17A97A09C6661868E0@BYAPR04MB5749.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c7488e6b-01db-b0e9-3116-6c96374c3639@kernel.dk>
Date:   Wed, 18 Sep 2019 13:49:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB57494B7D18A17A97A09C6661868E0@BYAPR04MB5749.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/18/19 1:28 PM, Chaitanya Kulkarni wrote:
> On 09/17/2019 07:32 PM, Jens Axboe wrote:
>> Regular io stats get merging stats for read/write/trim. Why do we need
>> something else for this?
>>
>> -- Jens Axboe
> 
> Yes, but we don't have a mechanism through debug-fs to have such per
> request type information which makes debugging much easier.
> 
> One such a scenario where we want to add a new request type and
> examine rq_merged not as a whole number, which is not covered by
> the io stats (since it only covers read/write/trim).

What is this new request type that supports merging?

My point is that adding stats like this isn't free, it's a runtime cost.
And if it's just for debugging, there better be a damn good reason for
why we'd want to pay this cost the 99.999% of the time where nobody is
looking at those counters.

So why isn't the iostat stuff good enough? There's also the option of
having blktrace tell you this information, it would not be hard to add a
blktrace-stats type of tool that'll just give you the last second of
stats so you wouldn't have to store the data, for example.

What I'm asking for is justification for adding these stats, so far I
don't see any outside of perhaps convenience, it's easier to just add
them to blk-mq and retrieve them through debugfs.

-- 
Jens Axboe

