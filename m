Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F06CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 15:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DDF206DD
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 15:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="he6aRuQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395487AbfJYPrN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 11:47:13 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:42648 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395419AbfJYPrN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 11:47:13 -0400
Received: by mail-il1-f196.google.com with SMTP id o16so2233300ilq.9
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 08:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SsJ9ZEsxHLQX+f5vHYqEDrQy/+4JococvH2/h9P17zw=;
        b=he6aRuQ/AIXKWZI2PJA3rZyD95WzKjyJhLQXtgU2F+cFoWNyNr5oBn19vvmLGvleil
         GtyNdLTqx/qKDJhASDKdA1OfeQ86afMcrr/1/YA9HXLHyfYmIt7m3BmNszqWRC1PXtOT
         GN48AV+vgsBLwXVGUlHCoQDhuSmUX3pyzwuAzEkUEAnQvfVFIWXlNZAKRxSZJuKgBdI2
         OvTYiTD9G/QxLBgOpNQA7oNTsqQ04KOIk+35wesndDTFmphRZB595YIcQvhWf4LrfhK0
         JFczvffbCSE2VRcGW3zi4kBnPLP8B5grOkdyw2RRc3Zt64X7oda/4dyyi61tr7FjGNbi
         Jksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SsJ9ZEsxHLQX+f5vHYqEDrQy/+4JococvH2/h9P17zw=;
        b=F8Xyxj0D8FLB26Syme/F/FpTj/tMLj5Uouwi4FrUzrVeeNAqLPj97v+lXM7KPrh1Df
         5GaLloj1iQxVhvyIslFkiHUidxdYND6fBtZOXVDsDoLAqokyAUTrjiECrYGCRq0mjiMN
         5fECJozSrQxKLs/AkxHsXJWS+hJx4AVH0w1VcEoAT2yK5MEH1Se5xr/zCYkGdxWuDFsm
         w4TYh7QKp4N47V+3d9CXOoCA7CfdtzoZBrT8uW/LhZ9NO/AFRFtsEumWVHPxwPLuzVW2
         arj+d12hlwzYtD6wVdvZ+Po9H1qSP/nZ3zhh9jIRP95jIpxMcfnrf8NRMHKBBihMIVwt
         JiHg==
X-Gm-Message-State: APjAAAW5ZAf0p11zUN42rTi93olUDUlXUQaZAPojsaAe/QaFDDPgcBvn
        22as7sU5e4nk/cg2GPoMQA618g==
X-Google-Smtp-Source: APXvYqwyySGpPibGqJVkRv9IbFQnmdKTYqHgRrLK378RuRbWMxYvoS8nhyRCggpIVCKVC1/kW9KC/A==
X-Received: by 2002:a92:ce12:: with SMTP id b18mr5159832ilo.130.1572018431360;
        Fri, 25 Oct 2019 08:47:11 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q11sm366277ilc.29.2019.10.25.08.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 08:47:10 -0700 (PDT)
Subject: Re: [PATCH liburing 1/1] test/defer: Test deferring with drain and
 links
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <b9509294fde6425b000d71613bd352059334c60d.1571995330.git.asml.silence@gmail.com>
 <3d2e8533-6085-b328-7e27-9a5be2027b7f@kernel.dk>
 <9ec359eb-b639-65a5-4f01-7e7fdfa9a8af@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7a2af956-e96f-a24c-2afe-806789a7fae2@kernel.dk>
Date:   Fri, 25 Oct 2019 09:47:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9ec359eb-b639-65a5-4f01-7e7fdfa9a8af@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/25/19 9:40 AM, Pavel Begunkov wrote:
> On 25/10/2019 18:13, Jens Axboe wrote:
>> On 10/25/19 3:48 AM, Pavel Begunkov (Silence) wrote:
>>> From: Pavel Begunkov <asml.silence@gmail.com>
>>>
>>> 1. test user_data integrity with cancelled links
>>> 2. test the whole link is cancelled by sq_thread
>>> 3. hunging io_uring based on koverflow and kdropped
>>>
>>> Be aware, that this test may leave unkillable user process, or
>>> unstopped actively polling kthread.
>>
>> That's fine, that's what the test suite is for! Thanks, applied.
> 
> Just found it "a bit uncomfortable", that after several runs
> my CPU was doing nothing but polling in vain.

Looks like it's testing one of the cases that isn't fixed that. We
shouldn't do that until a known fix is available, at least. Basically
the tests should test for things that used to be a problem, but are
now fixed.

But let's just get it fixed :-)

-- 
Jens Axboe

