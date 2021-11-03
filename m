Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAB4C433EF
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 21:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6222D610A8
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 21:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhKCVny (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Nov 2021 17:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhKCVnx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Nov 2021 17:43:53 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEF6C061714;
        Wed,  3 Nov 2021 14:41:16 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id s19-20020a056830125300b0055ad9673606so4213142otp.0;
        Wed, 03 Nov 2021 14:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Aw/gEqUH4lCNeAQ5cpXRMPQZYEQ427CSvFShVqQiYz4=;
        b=UFhD7yFOLohYb7ltHU4wZ8LhbZyhE4O6RIztyk3k9+uDl0nxfoMRYwBZER1Zvo54NE
         U3ENN8JdAiXe04dEprIp5huZ6VkyDOARyIqVNkVyz1i+XcYuah3dT5rxYhYRS5esvzDv
         +b01jUkNP6mpHJBlYAC0UpQgBGqgNXvLQ6XxuMEtYCVAkaAIbw10BBoneqGDGet8IxHW
         gOZ9ZfqbnrFtxFN6FTebQ1UFI2xiCbgOl1nkNihDGvlOmwMCnm7M09WOAT6MBdHUzhx7
         RPvj/nvOIcAEwAp6OWEnriqM3gY9/q6H3O4DetY+aBKbmsYC3M61O06ywWcW6ZurAcxw
         I89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Aw/gEqUH4lCNeAQ5cpXRMPQZYEQ427CSvFShVqQiYz4=;
        b=QVOx0wE1eqNZIh6qIo+55qnNQVFqlUUQoARqheSksxYKzn3Q4+wHNRn6CfSw6VuGrx
         uu5qyNzAV6rzgzTsUKSjZfmMrNiwOnlCLbTeXCcLbeXIcwZ3gGqpS8CdojZ34RwmEQTv
         +r20OhqO8EBRxg+akw2fAgnWE+VZil2CZf0Y0wgyutO6ggctsBH+dkkVIF+TQqKjgSFr
         POwsDvbxWjmFKDNDk9dfmnkxoKCn5K0Y85PJSElK6ToAEBFAcYbsREodHKbWpyZSP1AV
         JaqRuVevowMD7fLk1HIsb47Q0JitLqYxC3wL+NxgTVdDu4nyeZYQwd2o7dOXfO7B6VG8
         mFcA==
X-Gm-Message-State: AOAM531XVLM8kReM9sINWP0SZVSxxmY3/in09MxtuUOFW8j4WLkXGB7n
        PGa6r26Hxvx2Sj0XNhP2ayc=
X-Google-Smtp-Source: ABdhPJwaLFyVJbiS7LNNkYZpkEJ6gwfP12GZJNtdBQKrzxaKRUBP9Ug39JsBXj5SYi0xJyGVIqd1tQ==
X-Received: by 2002:a05:6830:1ad5:: with SMTP id r21mr35294027otc.192.1635975675462;
        Wed, 03 Nov 2021 14:41:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t12sm912756oth.21.2021.11.03.14.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 14:41:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 3 Nov 2021 14:41:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] block: add rq_flags to struct blk_mq_alloc_data
Message-ID: <20211103214113.GA3354463@roeck-us.net>
References: <20211019153300.623322-1-axboe@kernel.dk>
 <20211019153300.623322-2-axboe@kernel.dk>
 <20211103195411.GA3156469@roeck-us.net>
 <ef74ff48-6d9c-f39c-aff2-8a820440c953@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef74ff48-6d9c-f39c-aff2-8a820440c953@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 03, 2021 at 01:56:29PM -0600, Jens Axboe wrote:
> On 11/3/21 1:54 PM, Guenter Roeck wrote:
> > Hi,
> > 
> > On Tue, Oct 19, 2021 at 09:32:57AM -0600, Jens Axboe wrote:
> >> There's a hole here we can use, and it's faster to set this earlier
> >> rather than need to check q->elevator multiple times.
> >>
> >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > 
> > This patch results in a warning backtrace with one of my qemu
> > boot tests.
> 
> Should be fixed in the current tree, will go out soonish. If you
> have time, can you pull in:
> 
> git://git.kernel.dk/linux-block for-next
> 
> into -git and see if it fixes it for you?
>

Yes, it looks like the problem has been fixed in your for-next branch.

Thanks,
Guenter
