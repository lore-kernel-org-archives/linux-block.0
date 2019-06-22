Return-Path: <SRS0=VjOk=UV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4EBC43613
	for <linux-block@archiver.kernel.org>; Sat, 22 Jun 2019 07:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570912089E
	for <linux-block@archiver.kernel.org>; Sat, 22 Jun 2019 07:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="c8FoU+4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfFVHsD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 22 Jun 2019 03:48:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46089 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfFVHsD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 Jun 2019 03:48:03 -0400
Received: by mail-ed1-f68.google.com with SMTP id d4so13504477edr.13
        for <linux-block@vger.kernel.org>; Sat, 22 Jun 2019 00:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j0pTpoFtmc61TrE7sVJUbFMdNf+iYrYrV8+0Uja02OE=;
        b=c8FoU+4dqExKBTLPzwfEuZfZvPYjsZ8EKlrwIHunw6FBD2BpmgfTl5AdrHAOyXv3LN
         ZuDLqNgp4tWSb4ZPQDjS8EeNhP7mFo81qG3tZMS+EdrlQdnRevu3IjWasj7/askxh/rv
         01YdUfNbJXsM3hgvN3JvfB57hA1Kvr0BsAG8kypeR+rr5IPpTWmJa8Nh8Zumvh+Pva0P
         ip+fXQf/TMGtT31sdQDm7GgbikV+op2EJEJiIoqXpXbg3iHMTNwgNrvu5EWvrNCx5cun
         MOtHukaPWa8hU6I4s+EfjArfpkOR2jwWa4X+AWVXsdn3VW+Ml6PWHsX0+Zq5Xf1bYLyz
         5LKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j0pTpoFtmc61TrE7sVJUbFMdNf+iYrYrV8+0Uja02OE=;
        b=WO0T18WkiyQJrgDYvvaCRiYKh/VCRGLxqIvlwT3w6XDNXFhDriMCd6He/GN36hZt3o
         tZXhdTEGBmJSEk+GTrPjIG4+RnoGS2rvPFjdI1sJpnEf5Q1zPluZszkO4B46SF19/H6d
         ZdlcCEpN2uHfiGExyVgBwNtKbmr/1RH9sfdbRDxoOPXrBkSaiejHPmLlCAWT2jL+ecXA
         JHXzziiV15hEQgwkUQ1pzDRpHNa7TwkVIxWaaW3qpbqPR4XRw99u4FrpCuMlbZwwFsK2
         saS8XkFDiq4N/1Ul8f6UAU1fYJ+iFWzqrPL8+gngP4kN+N7K4dbe1QUSbonLk+NIjBBg
         J2ag==
X-Gm-Message-State: APjAAAXUTGYisEkEyLVjKKGlU79J2TQQCDV9NrJi6nwzJshh5MuCn1sS
        7ZmLfMfN/AHnwBYhrkkMz8XfJw==
X-Google-Smtp-Source: APXvYqzOxk9pjGU/H/ABIdrhPcodDd8kEwAUrnjExUJvJ6W2eUB/gcDzK12O10XAJ5CRU4PDGfWt5Q==
X-Received: by 2002:a50:9157:: with SMTP id f23mr40671128eda.79.1561189681874;
        Sat, 22 Jun 2019 00:48:01 -0700 (PDT)
Received: from [192.168.1.208] (ip-5-186-115-204.cgn.fibianet.dk. [5.186.115.204])
        by smtp.gmail.com with ESMTPSA id dc1sm785697ejb.39.2019.06.22.00.48.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Jun 2019 00:48:01 -0700 (PDT)
Subject: Re: [io_uring]: fio's ./t/io_uring on /dev/nullb0 causing CPU stalls
To:     Stephen Bates <sbates@raithlin.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     "fio-owner@vger.kernel.org" <fio-owner@vger.kernel.org>
References: <02CA47A4-B51C-4393-9C90-8EAFFE825669@raithlin.com>
 <5660C665-196B-4A4F-B61A-0A7569B6056C@raithlin.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b3f4f22c-5f83-0118-d930-bd3745884baf@kernel.dk>
Date:   Sat, 22 Jun 2019 01:48:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <5660C665-196B-4A4F-B61A-0A7569B6056C@raithlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/19 6:06 AM, Stephen  Bates wrote:
> Hi
> 
>> I hit the following BUG when testing fio's t/io_uring test on a null
>> block device
> 
> I confirmed the same BUG occurs on 5.2-rc5. I also managed to hit a
> similar bug if I use the io_uring engine in fio but only when the
> hipri engine option is enabled.

Can't seem to reproduce this, but from your description, seems to be
specific to polled IO.

Do you have any options set for null_blk? Can you send your kernel
.config as well?

-- 
Jens Axboe

