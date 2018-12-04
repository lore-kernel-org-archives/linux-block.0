Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C364C04EB9
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 00:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55F520851
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 00:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="j46Ajbo/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E55F520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbeLDAui (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:50:38 -0500
Received: from mail-pg1-f169.google.com ([209.85.215.169]:33916 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeLDAui (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 19:50:38 -0500
Received: by mail-pg1-f169.google.com with SMTP id 17so6537953pgg.1
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 16:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=GpX/zPLO3I/pkQLlWvbglTwdt75oblt9d8KgjW02tgA=;
        b=j46Ajbo/OBItnvhuOPrPXZN0TVtUvK/Em9RI6sp+fiWzEvWCQo5cUNIqecb/6cs4Xg
         n1j3z1FHXajl6Q7VeVRvqiXPbHJKEeEwUffTk55dw73XTV6WYG0c7Zz0wnuvd5rWTfKv
         Ujq4Q8T3bGHdtHez01hzZbksUxmi7fX9n3gduoO2BxyCuOuD9qsyf3VrdnSRGVlZrmyG
         0FlOG06D1+oRoIJCIHrSA8iqlwsQTwBB1qCSAZI59YLe65xNJUC4Dp0bi++y8ItahNq8
         7Tt2nT55bSBNVig/jMSfQakbAqGOeOd/T/UgGtVUrWG+pGETrMIeKiySZ4XLhMgXUoLZ
         y34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GpX/zPLO3I/pkQLlWvbglTwdt75oblt9d8KgjW02tgA=;
        b=T9qrOVUPzSJL/ZhsgwCEfPPncPSbtZLCeH+IzCcZwZVEcF9vlO8v8Dub15kMYVY2bb
         zGDuU9ZYRlHhNgohWrvFTzav4Es+WCy8jCWzYShx10kZoXj5Le8EtAyEE+3vuiKyyu2W
         nWPD8v/n6hRk5M28wFJ13XTZTL0bSw6amgJdCgkpgEDHOs+PUM1EwoQGTI+YGEg+TKOK
         OLShbKyLUjo3OaJqm9kOfsXyFLUy9AaDJ7P1ai0dr9H0cxzKi2koTwNy+3bBCH44NLTU
         /gjXbFHAQQETii+sr6FOGVvkdJNsBJi9ewm6Z4EnLFmcjvStDZO6c3iTI24Nm2ksdMyq
         ilIw==
X-Gm-Message-State: AA+aEWakwhe8184igkfOHos9PYMJqSi3iPY+EsdxE9Zs9i5GjwB3EnZg
        Qm+uUx9wRTuL3Cu7Kwsfti3c6lSVg1c=
X-Google-Smtp-Source: AFSGD/UHVAMX1wLKw66xlPQAKxjp5EHMcaCg0u5zQJc92G4Naemhbnu5xLoEZT/pR/6SqaQQ5Utn0w==
X-Received: by 2002:a63:9b11:: with SMTP id r17mr15151590pgd.416.1543884637236;
        Mon, 03 Dec 2018 16:50:37 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id y12sm21791026pfk.70.2018.12.03.16.50.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 16:50:36 -0800 (PST)
Subject: Re: block: sbitmap related lockdep warning
To:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
References: <CACVXFVObAF+keMw3aDSMBg0vfL-wSVFMw46ubkxEP-09QX4bsw@mail.gmail.com>
 <879e4f73-caa0-93e0-a6c3-3d53d1962cee@kernel.dk>
 <1543883488.185366.176.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f9209a51-6dc5-d7f7-56ba-75d61af3627e@kernel.dk>
Date:   Mon, 3 Dec 2018 17:50:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543883488.185366.176.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/3/18 5:31 PM, Bart Van Assche wrote:
> On Mon, 2018-12-03 at 15:24 -0700, Jens Axboe wrote:
>> On 12/3/18 3:02 AM, Ming Lei wrote:
>>> Hi,
>>>
>>> Just found there is sbmitmap related lockdep warning, not take a close
>>> look yet, maybe
>>> it is caused by recent sbitmap change.
>>>
>>> [1] test
>>> - modprobe null_blk queue_mode=2 nr_devices=4 shared_tags=1
>>> submit_queues=1 hw_queue_depth=1
>>> - then run fio on the 4 null_blk devices
>>
>> This is a false positive - lockdep thinks that ->swap_lock needs to be
>> IRQ safe since it's called with IRQs disabled from the
>> blk_mq_mark_tag_wait() path. But we never grab the lock from IRQ
>> context. I wonder how to teach lockdep about that...
> 
> There is probably a better solution, but one possible solution is to disable
> lockdep checking for swap_lock by using lockdep_set_novalidate_class().

That does seem like a sledge hammer, but I don't see anything that does
what we need directly. Surely this isn't a unique situation? Maybe
marking it novalidate is just the way to do it...

-- 
Jens Axboe

