Return-Path: <SRS0=uopx=OM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B064C04EB9
	for <linux-block@archiver.kernel.org>; Mon,  3 Dec 2018 22:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7737206B7
	for <linux-block@archiver.kernel.org>; Mon,  3 Dec 2018 22:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AG8gRDhI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7737206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbeLCWZC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:25:02 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:39756 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbeLCWZC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 17:25:02 -0500
Received: by mail-io1-f45.google.com with SMTP id k7so11944960iob.6
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 14:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=UnMdHDOzF6nD6G7DqwjY3Yn6XKPWBgkbSlFeKV9tAm4=;
        b=AG8gRDhIf3xOFEifxyjPLPi/d/xoH/KhR0QyOhEW4w9ZizkR4Nj5I37KFEU5qW4LHb
         tW9HMUiKt8wk/2pMd3kXMMbV2/TAxVrArIOYlc516vOHWiaX1M6yY74J+C5JWYf1TQYt
         ppduhiuyRVLXhNLOTj2c+zHVmrg2cWyxir2bRuJdY7ZgrJIjtGCSjd9r5Ggp5JZtCEYR
         +vq273bsmsT2fM6Tc/YOm0XwUKNCMBSWAbm0nzrpWPA7a/UscifIoYlmj8P6szEy52Jj
         zo0H01ZIMGBPV/AgDLcg8Xu95rfQLzeO/nTk5mP8ddpCvMSSMMPUko4AR5xw9zAO2D6z
         P0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UnMdHDOzF6nD6G7DqwjY3Yn6XKPWBgkbSlFeKV9tAm4=;
        b=Yadya4WTR6sMoZjhRH6gmq0EUr9F9Zf1f3enmElV8fgT4MUbBI7QhNNJBjxhq06uKX
         IHzcG6AratIOvxvFoYQ5y3UDDe2xgH8ysyCNjITznqneiLqW+BQXqDM6be0e9mBofDio
         PlcfHKkZAXO3c25maUd6F/VnBJlFEAbya60376UUm0U9lzPudxp0w4zw32bKPJhebwcq
         DQ95MsvFrILmpdXGxaz/xC6hl7TTQ5/N5//r9fk8wfZpStS3K2gCu6EuadbuCWA9gUP2
         ritX+gaNQcWpBB6BAYpYjsUyCiF/1PyGVY+mjsB3LI0Z3O8Rgwhk6qIL+XYAci29ww3+
         Bp8A==
X-Gm-Message-State: AA+aEWap0m2GhhIRrz8T/CjC7cWOUsdXB5GCS2ljaeHAERYviCJnLSkC
        5fSKI0Wpsbi/+FITkYdC/ecyu3czH0g=
X-Google-Smtp-Source: AFSGD/XNMDKIGAOHkqWX1WatkWqsXmWgJV5TV+ACQq8n4yqVCpPqgHcApGvGQ7v9v2PnygG3n73wRA==
X-Received: by 2002:a6b:670d:: with SMTP id b13mr14669788ioc.22.1543875901199;
        Mon, 03 Dec 2018 14:25:01 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1131::106f? ([2620:10d:c090:180::1:94b1])
        by smtp.gmail.com with ESMTPSA id 134sm5646625itl.25.2018.12.03.14.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 14:25:00 -0800 (PST)
Subject: Re: block: sbitmap related lockdep warning
To:     Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
References: <CACVXFVObAF+keMw3aDSMBg0vfL-wSVFMw46ubkxEP-09QX4bsw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <879e4f73-caa0-93e0-a6c3-3d53d1962cee@kernel.dk>
Date:   Mon, 3 Dec 2018 15:24:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CACVXFVObAF+keMw3aDSMBg0vfL-wSVFMw46ubkxEP-09QX4bsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/3/18 3:02 AM, Ming Lei wrote:
> Hi,
> 
> Just found there is sbmitmap related lockdep warning, not take a close
> look yet, maybe
> it is caused by recent sbitmap change.
> 
> [1] test
> - modprobe null_blk queue_mode=2 nr_devices=4 shared_tags=1
> submit_queues=1 hw_queue_depth=1
> - then run fio on the 4 null_blk devices

This is a false positive - lockdep thinks that ->swap_lock needs to be
IRQ safe since it's called with IRQs disabled from the
blk_mq_mark_tag_wait() path. But we never grab the lock from IRQ
context. I wonder how to teach lockdep about that...

-- 
Jens Axboe

