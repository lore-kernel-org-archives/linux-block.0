Return-Path: <SRS0=s1xr=SI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B068C10F06
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 19:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186C7213F2
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 19:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLL0zxzi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfDFTe0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Apr 2019 15:34:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45696 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfDFTe0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Apr 2019 15:34:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id e24so5156418pfi.12;
        Sat, 06 Apr 2019 12:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tE61QvLDmm1XPqbXzI5lzXOoTay0BqBzsTx2Nzsk/2U=;
        b=iLL0zxziFTpuGbZMraU129T6IR158tcENueZDS/bLSdZjfA/GU7qtbMTiFSRBZ28IC
         A+mEXoq3H0KO2bFASmpn3y5LQ+aowdiP3y4VsRsfDC0ashiSFfJ8ExsBdtqrs5DDiMBn
         R+h1MB/f9QkyOLe833xmrXOXQ2feqrJv4j6FDVPubnl5vEka9Uya1ZLDP1LhDyIk8usj
         UVN6Mjh5oQ1rDMdV+q0G73ag4lP5EI3QbjpNKGbZFCTjPdsa4aUsKqi8YxUIzfidbtoS
         0h5wx+AKp2u/Kewc/ib42CuJsv/XD+ZbC2EyvexXNOs/sWF50cWLqek9QAJ7WW5jZEJy
         bVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tE61QvLDmm1XPqbXzI5lzXOoTay0BqBzsTx2Nzsk/2U=;
        b=TZKrvBDHtXqXYXCISxS7B2sJFcEaHOGrwBXaodsH1cnMr4B6bo/bdqIzsWTwOdUztS
         i4L/AUyXfo9KtG6HO0R60NApHa5FUNHqL7ZUfHMq+pNEiwzSCrfruxbFWYIvn3Ybjuno
         pRcAMJUkteqFxlig3OkNZXbbeHL4TL1Yra+/tL9Q97P/avIbas9IfezabbFzXzSsy4fR
         4LS1Noe4hxrzLNn1ZUpvjl1vw0x1NBtBiy2Xlzn3BWvyV7H0el68rTkje4otQC3cEBX3
         xvaHZlqXQILEnU+tL4NKzgvwDFCp4NNXpptIbqEQKLjjG5scKcYsimJ5Te6KVky+SwQk
         8o1g==
X-Gm-Message-State: APjAAAVj4f1iZ21siUat/wmurmHx57SX58wFsuxN+mxQZMPAcNh1gajT
        2HWpbMP6ZeyhEn8LLj7VJREKDStO
X-Google-Smtp-Source: APXvYqzfEzo3rXS9gtxYwjsMZf5nRYOTta+dMgO2OJ8hivk/dbDuyf/CofhWhVbt/jtn6tqzn9sbTw==
X-Received: by 2002:a65:4302:: with SMTP id j2mr18411442pgq.291.1554579265237;
        Sat, 06 Apr 2019 12:34:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t5sm9792434pfl.106.2019.04.06.12.34.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 12:34:24 -0700 (PDT)
Subject: Re: [PATCH] xsysace: Fix error handling in ace_setup
To:     Jens Axboe <axboe@kernel.dk>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1550594996-11453-1-git-send-email-linux@roeck-us.net>
 <20190405224458.GA19556@roeck-us.net>
 <0c428aac-f488-525a-49d1-506ce92be418@kernel.dk>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ff578f4e-9795-ade2-9321-93e4cfe2f3ec@roeck-us.net>
Date:   Sat, 6 Apr 2019 12:34:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0c428aac-f488-525a-49d1-506ce92be418@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/5/19 4:06 PM, Jens Axboe wrote:
> On 4/5/19 4:44 PM, Guenter Roeck wrote:
>> Hi,
>>
>> On Tue, Feb 19, 2019 at 08:49:56AM -0800, Guenter Roeck wrote:
>>> If xace hardware reports a bad version number, the error handling code
>>> in ace_setup() calls put_disk(), followed by queue cleanup. However, since
>>> the disk data structure has the queue pointer set, put_disk() also
>>> cleans and releases the queue. This results in blk_cleanup_queue()
>>> accessing an already released data structure, which in turn may result
>>> in a crash such as the following.
>>>
>>
>> This crash is now quite persistent in mainline. The fix didn't make it.
>> Should I stop testing virtex-ml507 with qemu ?
> 
> I've applied the fix now.
> 
> But given Michal's comments, should we kill the driver for 5.2?
> 

If the driver is no longer used or maintained, removing it would indeed
make sense.

Guenter
