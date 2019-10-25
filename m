Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4655CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 20:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A1820659
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 20:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WNZinwbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfJYUhj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 16:37:39 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:36308 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfJYUhi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 16:37:38 -0400
Received: by mail-il1-f196.google.com with SMTP id s75so2978299ilc.3
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 13:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sFOHXijh8F7tyUILbQgSmtZ9TMRFJZXJfFdJlMEpFPw=;
        b=WNZinwbnHex8EMNtR8ji0Dh852Tlp8yGQIPZGwopQsOOv7S0K3a0x+aKXrHab/az0L
         CBXYM+H3I7QPFYpETwbLDWQdmPHvJSMkbJb2HyaZLXveRDOLU7v9AQwpVttKWxHnFEou
         ec+O8VyYRUb38iLmJFRX+0UWgJfiVYniIknFpN9v0N4/hx8euf5wzGm0u44wKiOnEOH5
         FYznj4oTzceVuPaPhehf/NfAUeSGngJVsLCe07hDCGDZ/ww5fWFZMDR6hqoVwaEUF6YQ
         esEoARTsvAPSdKKbURCN9uaHKiRX9sFkXwsRRIZ25UOoMVdkfzewXcU29RwhgN/nDpNM
         IsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sFOHXijh8F7tyUILbQgSmtZ9TMRFJZXJfFdJlMEpFPw=;
        b=HuhO549DCXzatv+8YvnE/FQYHrfKPRn2i5CnBruDqZXSZ07on91LZZgJ7lw8ClNh5G
         hx0gM6kU0MPlJ8oqQZ3JVPy1raZZvXAADlpG14n5fsqOonV6cr/CLx46vjcDo99CRPsv
         0YPMd+7wFrH3K6lNT6DHYZfVal24FosC3VDIJi5yLaZ7FXtFp5spZy6ftRejU9f1YyoB
         kH0EGJBsEJVIkAzTG0OWf903ehx2beBmXadqyT5NMihq/bn0QRaaF2wSqWSgqa+6Ztdj
         85sPIXSY1OUYYvEJW4wLlbOPcdqmNW8Nyn1yfZL1dM9FEL+B8Dq8VRXQAKRzdLeT5AII
         090A==
X-Gm-Message-State: APjAAAW7alcOum0fe/nyUWXN6EANl3L4Mj/cuSBHSoZArZFkKpBYxHi6
        2q4OWYHlZADkom4QPEyNGBNr9e4gw5VH3g==
X-Google-Smtp-Source: APXvYqxAb860qHVJ/S/BtDt5SCY75IP/zMUFwrG6/xVzIa7onloMW/63uMiyOEizoVxwCYerRRX52Q==
X-Received: by 2002:a92:17ce:: with SMTP id 75mr6369822ilx.88.1572035857658;
        Fri, 25 Oct 2019 13:37:37 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 128sm348265iox.35.2019.10.25.13.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 13:37:36 -0700 (PDT)
Subject: Re: [PATCH] nbd: verify socket is supported during setup
To:     Mike Christie <mchristi@redhat.com>, nbd@other.debian.org,
        rjones@redhat.com, ebiggers@kernel.org, josef@toxicpanda.com,
        linux-block@vger.kernel.org
Cc:     syzbot+24c12fa8d218ed26011a@syzkaller.appspotmail.com
References: <20191017212734.10778-1-mchristi@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <abf05db4-03ce-43a1-396c-a366b1d46451@kernel.dk>
Date:   Fri, 25 Oct 2019 14:37:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191017212734.10778-1-mchristi@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/17/19 3:27 PM, Mike Christie wrote:
> nbd requires socket families to support the shutdown method so the nbd
> recv workqueue can be woken up from its sock_recvmsg call. If the socket
> does not support the callout we will leave recv works running or get hangs
> later when the device or module is removed.
> 
> This adds a check during socket connection/reconnection to make sure the
> socket being passed in supports the needed callout.

Applied, thanks Mike.

-- 
Jens Axboe

