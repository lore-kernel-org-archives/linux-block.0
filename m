Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4579CCA9EAF
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 15:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169D420873
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 15:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PQmNYPxl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbfJUPtw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Oct 2019 11:49:52 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:42483 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbfJUPtw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 11:49:52 -0400
Received: by mail-pg1-f171.google.com with SMTP id f14so8042397pgi.9
        for <linux-block@vger.kernel.org>; Mon, 21 Oct 2019 08:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sr1FRxnMyt6/DYt7/ItCEsnHho0MFM5VlJloVHS4wE4=;
        b=PQmNYPxlZnPWeY7CiKseNo3FBl5pZmk25Jtf0vIdnXGsWPzVzwsOZFAT2XCt7wUQ9b
         vVC2Irp8Gbfn5YFp91JtK5NRGB6pKANq1jZmRb8n/z/BUXTttcupUGeF+ZciCrupIhnx
         HWfe79VIpt89Cq5f1Ss4Um80QqSMfycaeEHMX1scVGWBCA0Q2FozKJ5VZE7q5hMO+cjd
         bANq5JNFreTps+0xXqlpWnPMJe8Y1YZVNp0oYH6QxJ6HSaXYKJR2oO/eCayi0PSs46XF
         gY7OrbqpNJ4vugV6whtCrYctyGx8yZTYkqAAlHboR1moiRoRaxV8DsA5LcDujSk7R7FW
         N3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sr1FRxnMyt6/DYt7/ItCEsnHho0MFM5VlJloVHS4wE4=;
        b=Gf9dVJnkNZ7O2oZTw1Y+twGh6uEBiC6uo1e+EMoXhSZuQ1AzyMazqrEOf4vq+BT20D
         avmPS0T6BLu6MGDpJZNDdq6XMDUChLff+cy9U6Xza0PC//a+THaw2n5TCOO2koFXis00
         T1+YFLTyDjenZpZvAje7NoP9N9F99waCrGS/i0IwJGcFRXmbeVnCH2NjsUYpF3LYQ06l
         sMa310ZR02rE7/jxYO9O5FQLyoSzCM6860zun60HVGYZPF61S5pPrKcoyTwovMQNNTv2
         1ZErBlVcOgCI0xS9OZQaXMDjvRx5gIy0fmt1V3xPtgGhSe+myvARC5qlVv/X1Ex6uerK
         6SEA==
X-Gm-Message-State: APjAAAVbAUuygnzzpL2n1RCCAf/sZNoqKjjT1Tu/aKs9idBL09CCTFt8
        rELxx2sLMwPI/zzfpSl73a+Frg==
X-Google-Smtp-Source: APXvYqzAOpbI7nqe73Izkg0dDkGnUQXIJY0JwrPPhqMDGxtmrvxWYr+9cI7KcZA0ptH5tkExGWXJeg==
X-Received: by 2002:a63:160a:: with SMTP id w10mr27068232pgl.212.1571672991136;
        Mon, 21 Oct 2019 08:49:51 -0700 (PDT)
Received: from [192.168.1.182] ([192.40.64.15])
        by smtp.gmail.com with ESMTPSA id 203sm3628289pfa.165.2019.10.21.08.49.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 08:49:50 -0700 (PDT)
Subject: Re: liburing 0.2 release?
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, linux-block@vger.kernel.org,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@mail.ru>
References: <20191009083406.GA4327@stefanha-x1.localdomain>
 <414ccf6c-8591-a82b-9ae7-9b0f270d18e8@kernel.dk>
 <x49k18ygkxy.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e4a6052d-b101-cb0b-949b-110c96dba131@kernel.dk>
Date:   Mon, 21 Oct 2019 09:49:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <x49k18ygkxy.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/21/19 9:47 AM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 10/9/19 2:34 AM, Stefan Hajnoczi wrote:
>>> Hi Jens,
>>> I would like to add a liburing package to Fedora.  The liburing 0.1
>>> release was in January and there have been many changes since then.  Is
>>> now a good time for a 0.2 release?
>>
>> I've been thinking the same. I'll need to go over the 0.1..0.2 additions
>> and ensure I'm happy with all of it (before it's set in stone), then we
>> can tag 0.2.
>>
>> Let's aim for a 0.2 next week at the latest.
> 
> ping?

Still on the radar, just got dragged out a bit with the changes last week.
Let's aim for this week :-)

-- 
Jens Axboe

