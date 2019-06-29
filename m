Return-Path: <SRS0=xgQW=U4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2A1C5B57A
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 16:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27359216FD
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 16:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nJ6hEyg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfF2Qff (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Jun 2019 12:35:35 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43087 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfF2Qfd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Jun 2019 12:35:33 -0400
Received: by mail-io1-f67.google.com with SMTP id k20so19165977ios.10
        for <linux-block@vger.kernel.org>; Sat, 29 Jun 2019 09:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0bLcPXD293myVNKmMw/+HXfUyYNiVcqiviMrBWHy3K0=;
        b=nJ6hEyg3jX+4MXvvPdz75vPCWZ2LYuqhZlzSd2zW1dmPKZqnhrUgLqvgF/PsHutTn1
         FcygzfAPw9KHygKpqg4jYfhQLrZXU98FkC8Vdc1iz30YuoCBql104JBsQPdRWOuDAhjg
         IPaxQAFpuJgK+qNSYBvTQPh4rt8wZAdh/7AR/3PWzoJXQhrlkByBcivaW7AAfA8XIwOQ
         vnO4SQaeJ16m3ncYWHqkK4mOqvDBwBVQfcERw+KuEThU972nXv02cPJur8AebwXmLhMQ
         tGdJc5vwfxoV/88tzdDVu7b1hUdZ2iz5PSCoBNrzeDWr/f4yx4oa1Y13bKmuXaFFHK6O
         C/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0bLcPXD293myVNKmMw/+HXfUyYNiVcqiviMrBWHy3K0=;
        b=R07hfzSDsMoXlxuMxP1lMm2uNtIXDNHubKM51ykNGs0upFyrSMxZwvZ4jlITjFi0MC
         NzjRWyKxK+J1FjOZeY0BECjj4r7rMzMgyzrGqqIyIqninr5NYMzQXQL5WLJTtuGI0uUD
         Ism/EoFid6FSbDdFjxublegmkO5WOAkT0YvLdJX2m3X87aWS9g/+kBDqJuEWpmra6BP9
         LnwG2Yfcabr9XWMLPoSqldwnuGe+jOjV9gU13FjVBa+QVcQTM3hT829LhbXfqXmHz1qo
         YIIe3VbultBEyh2PJ/sFHK2VbNNF7H85wc4uuE9rTywWfMcpH1dJIqmJ4sCYVciNI7e4
         i/0A==
X-Gm-Message-State: APjAAAWTn8/A47QFmzU4P0WqAYuH37jzGvPJwcYi/kpeMDy1XaZ46KhA
        idaouuo9AboPgDGXM815HH9s2w==
X-Google-Smtp-Source: APXvYqy2wRKtN2cvMlA/F9Z2nWcwqtokFG7YSVfK/YCihAPLXVBzuTMTb6+TFylxQ7+N2cD40p3C3Q==
X-Received: by 2002:a02:a48f:: with SMTP id d15mr18068186jam.12.1561826132648;
        Sat, 29 Jun 2019 09:35:32 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r24sm4260675ioc.76.2019.06.29.09.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 09:35:31 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] block: sed-opal: add support for shadow MBR done
 flag and write
To:     Scott Bauer <sbauer@plzdonthack.me>
Cc:     jonathan.derrick@intel.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zub@linux.fjfi.cvut.cz" <zub@linux.fjfi.cvut.cz>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jonas.rabenstein@studium.uni-erlangen.de" 
        <jonas.rabenstein@studium.uni-erlangen.de>
References: <1558471606-25139-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <7ee5d705c12d770bf7566bce7d664bf733b25206.camel@intel.com>
 <20190629161947.GA20127@hacktheplanet>
 <d3074ee1-0506-511d-c29c-44effb4eda97@kernel.dk>
 <20190629162835.GA21042@hacktheplanet>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cb37028f-bff9-92a6-4ecd-efe938274d24@kernel.dk>
Date:   Sat, 29 Jun 2019 10:35:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190629162835.GA21042@hacktheplanet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/29/19 10:28 AM, Scott Bauer wrote:
> On Sat, Jun 29, 2019 at 10:26:52AM -0600, Jens Axboe wrote:
>> On 6/29/19 10:19 AM, Scott Bauer wrote:
>>>
>>> Hey Jens,
>>>
>>> Can you please stage these for 5.3 aswell?
>>
>> Yes, looks fine to me. But it conflicts with the psid revert in terms
>> of ioctl numbering. You fine with me renumbering IOC_OPAL_MBR_DONE to:
>>
>> #define IOC_OPAL_MBR_DONE           _IOW('p', 233, struct opal_mbr_done)
> 
> Sorry for the conflict. That's fine. I'll fix up userland tooling.

Renamed 232 -> 233, and 233 -> 234, for the two conflicts. So now we have:

#define IOC_OPAL_PSID_REVERT_TPR    _IOW('p', 232, struct opal_key)
#define IOC_OPAL_MBR_DONE           _IOW('p', 233, struct opal_mbr_done)
#define IOC_OPAL_WRITE_SHADOW_MBR   _IOW('p', 234, struct opal_shadow_mbr)

-- 
Jens Axboe

