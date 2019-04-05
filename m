Return-Path: <SRS0=t+Ub=SH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A5AC282CE
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 23:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB072175B
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 23:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hhB0cFIi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfDEXGZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Apr 2019 19:06:25 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32900 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDEXGZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Apr 2019 19:06:25 -0400
Received: by mail-pl1-f193.google.com with SMTP id t16so3805893plo.0
        for <linux-block@vger.kernel.org>; Fri, 05 Apr 2019 16:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uVEvPh3CJM8jI6uy1N0HYD/6nCQAa5wIkVtsUWNVwkA=;
        b=hhB0cFIi7pUc/rpAXFoMMPK/zDACB3ZjkP7djfYhOU4Bm2g5xlzUEicYITvnjBNdsx
         Q8Kzz0/mZ55Du+HdxnIYCgU17xxigrKKsJme1uwwbPteGVnueEx7pdoRJ9tePKLqIKVO
         LAibxPnmsIhcnEP3clfH+0cI65MseNXJW4n8MgfHMUM1pxxrh/RjqDu5XiwWx/+wd7eD
         qYT3tBkaXr/3HYurTe2QqQyFG3X8dGnuAx/skjEysPNb1la7psY9E2O4ZPQk8LdzJfQK
         1T4atpZrKI/qj2m73HmtCU81upd7qOOGPJvFnFubMADdkSXsyS+DGaF9ExjMjsEKPJi0
         3qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uVEvPh3CJM8jI6uy1N0HYD/6nCQAa5wIkVtsUWNVwkA=;
        b=jMw8DWcBiF1M3q5mmAHXoKi/TYT2epKyCX1jBGP1CQ32vyLdR680rNYNOuHw01sJO7
         ns3t0uRrC4M/BrFXA0YCreKbgLJtC9O3BrIfCMyNC1NAoPC1AZjfiRCxYlatxpsElw3j
         5Vs4l27kadWOYa5DWzDW+zljCM54yBjjyIm4n2BhwZOshmLYNxG183e/+QZo3Js5Dop2
         FTAIwd7IrISVQ0Dadj+UXSw5QMJ2kKpPVfZwcrTI/U0ynMqGtrtGaoEbo9N0dbjLJqF1
         sPQ0oskmqxdfFb2f1TFHcHOykdjxyGFjpOW2Wa3+1gIj4XZ+9gtg+SjBP/YBecR1RX+0
         U9pg==
X-Gm-Message-State: APjAAAUoPk+ohpo3HEJL7U0mALzvqV4x95miD87rprbiqtpXFj8u93ri
        /hPN5su9gDhSgMmpS9duoHJUkA==
X-Google-Smtp-Source: APXvYqx5VSDqeMMl3CoyMudTcnJwltWcRx8CcGMa3S81BTjlzBQXHj00TJ1Be7K6h4bRSJcfNxRAcg==
X-Received: by 2002:a17:902:b68e:: with SMTP id c14mr15356913pls.49.1554505584543;
        Fri, 05 Apr 2019 16:06:24 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id y12sm63498276pgq.64.2019.04.05.16.06.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 16:06:22 -0700 (PDT)
Subject: Re: [PATCH] xsysace: Fix error handling in ace_setup
To:     Guenter Roeck <linux@roeck-us.net>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1550594996-11453-1-git-send-email-linux@roeck-us.net>
 <20190405224458.GA19556@roeck-us.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0c428aac-f488-525a-49d1-506ce92be418@kernel.dk>
Date:   Fri, 5 Apr 2019 17:06:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405224458.GA19556@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/5/19 4:44 PM, Guenter Roeck wrote:
> Hi,
> 
> On Tue, Feb 19, 2019 at 08:49:56AM -0800, Guenter Roeck wrote:
>> If xace hardware reports a bad version number, the error handling code
>> in ace_setup() calls put_disk(), followed by queue cleanup. However, since
>> the disk data structure has the queue pointer set, put_disk() also
>> cleans and releases the queue. This results in blk_cleanup_queue()
>> accessing an already released data structure, which in turn may result
>> in a crash such as the following.
>>
> 
> This crash is now quite persistent in mainline. The fix didn't make it.
> Should I stop testing virtex-ml507 with qemu ?

I've applied the fix now.

But given Michal's comments, should we kill the driver for 5.2?

-- 
Jens Axboe

