Return-Path: <SRS0=D4S7=UT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0856C43613
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 07:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31342084B
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 07:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KcNSSGxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbfFTHgr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jun 2019 03:36:47 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45910 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730891AbfFTHgr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jun 2019 03:36:47 -0400
Received: by mail-ed1-f66.google.com with SMTP id a14so3198338edv.12
        for <linux-block@vger.kernel.org>; Thu, 20 Jun 2019 00:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rDdWAqffTT+oSdiXbKqtbjpzXQIFQC5WZi7REe1Jpzc=;
        b=KcNSSGxz6j/9c3/UU7EzkVXLQw9IHfAGIei+vpcXLRgZ44F848Gjw8vTiozTuhmJzb
         B4/Ly0hMdiaMtR8CIKDoo0KChBXSSTJeSztn+0hZpWeBm9OYKd9GQLVYaaRWlo4NpcdN
         q6IBUhcDB12PNLoSQKL2/6EKWxiiKJ1rybUVqmN7pkl3UPjghMnmOMBVURJ/VzNDMvlc
         o0C252Hrku5hqxWQtP3wnXREg4907cByetiXowftDk8nDt4FHe2NiinFND33XyOHrK9z
         kDI72Bj0mYTTmvm7cS4eL+ZDiln7UOpr+aD8WK8inz70jGgqsloeBZsvdaF36+MXuX8J
         V8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rDdWAqffTT+oSdiXbKqtbjpzXQIFQC5WZi7REe1Jpzc=;
        b=L2xZocMyxRr5QQKEhdlLAjTpMtWPtQDMxp1llvJlCksC0yNbIvobwcBew8B03Hvg4g
         pfae6+41SGdSN30ezAaizb7y/8zPPqyWDBh6QyMSwsGrO5he7y4kG++k4sQPO2RNQ1Oj
         /MOfRcHg4QSJYQ1RZxYzNW9lnMKoattdqEAlCUWjcM01HWJix7M+J7KfmUeIZCKEQ85z
         u+hIxy1X3gQkt/+A1hYD5CAyOoR3xvSyxV8zrm2/TqSHuG3nDdZxWV2SMW3RvGvRqoXu
         gZ+N+t8rRCwKG2t/HqLzRYCWZBz7VRTzKCff3DmmcEW7+8D4kZV8M/IlSZXBkMSQz/GP
         AfLA==
X-Gm-Message-State: APjAAAUm0WKbIIlhJ5FkwwW6jGtZNigiasKickU3/fABfWScfUqWReTX
        dEFhtbHPQ2KGyCK/lG8OcM3E2g==
X-Google-Smtp-Source: APXvYqxG5E8urhDC9+2T2Bc7xL0pcd3QezOCfgkQo8wMsGgaoB49aehLx/TSw6mOwnP6Ca4xscr16Q==
X-Received: by 2002:aa7:d30d:: with SMTP id p13mr55603903edq.292.1561016205308;
        Thu, 20 Jun 2019 00:36:45 -0700 (PDT)
Received: from [192.168.0.115] (xd520f259.cust.hiper.dk. [213.32.242.89])
        by smtp.gmail.com with ESMTPSA id e19sm3730317eja.91.2019.06.20.00.36.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 00:36:44 -0700 (PDT)
Subject: Re: [PATCH] [RESEND] floppy: fix harmless clang build warning
To:     Arnd Bergmann <arnd@arndb.de>, Jiri Kosina <jikos@kernel.org>
Cc:     Robert Elliott <elliott@hpe.com>, Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke <hare@suse.de>, Omar Sandoval <osandov@fb.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Whitcroft <apw@canonical.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190619131959.2055400-1-arnd@arndb.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <649b433f-9a6b-a8a8-65ea-aa15a6296246@kernel.dk>
Date:   Thu, 20 Jun 2019 01:36:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190619131959.2055400-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/19/19 7:19 AM, Arnd Bergmann wrote:
> clang warns about unusual code in floppy.c that looks like it
> was intended to be a bit mask operation, checking for a specific
> bit in the UDP->cmos variable (FLOPPY1_TYPE expands to '4' on
> ARM):
> 
> drivers/block/floppy.c:3902:17: error: use of logical '&&' with constant operand [-Werror,-Wconstant-logical-operand]
>          if (!UDP->cmos && FLOPPY1_TYPE)
>                         ^  ~~~~~~~~~~~~
> drivers/block/floppy.c:3902:17: note: use '&' for a bitwise operation
>          if (!UDP->cmos && FLOPPY1_TYPE)
> 
> The check here is redundant anyway, if FLOPPY1_TYPE is zero, then
> assigning it to a zero UDP->cmos field does not change anything,
> so removing the extra check here has no effect other than shutting
> up the warning.
> 
> On x86, this will no longer read a hardware register, as the
> FLOPPY1_TYPE macro is not expanded if UDP->cmos is already
> zero, but the result is the same.

Applied, thanks.

-- 
Jens Axboe

