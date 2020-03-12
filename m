Return-Path: <SRS0=va7b=45=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA27C10DCE
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 15:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8112067C
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 15:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tJy46I8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgCLPKU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:10:20 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:39741 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbgCLPKU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Mar 2020 11:10:20 -0400
Received: by mail-il1-f195.google.com with SMTP id a14so5781127ilk.6
        for <linux-block@vger.kernel.org>; Thu, 12 Mar 2020 08:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hhGOn+1YitvQD6+toAylHamjxpq+u9eSAzvyzeYUhlg=;
        b=tJy46I8fViRqMW55A8pVB2KIpHAUBRNUO4Ij6GiW6hKLBZhxuKqn1hMmoANc+KoTH3
         oVWlWq9aB/Rc4Kh4kMNQIFIb8ofuHdU2zkrA5w3NO/vzo/RVbF0BJZ/jNb+BU42avjdz
         dIQd3kHblLU8HJB+3nvyPIMA0IOPGQhVbwLQBA/W9tJkTeMBGpsbX93lsPuSpNXLTtzR
         G8zvXINW5u0jXkhq8ttBJw4q66CXy5s2w0r1tJNgvXAw865ZBU2nVaFQi19+UAVNjEme
         +Of6LjnnXYHEdz1XF+1uRLfABVzs7pVqUQOhvDOkYwAVnvKuCdZpQguNO5MiIG6cWW+/
         puVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hhGOn+1YitvQD6+toAylHamjxpq+u9eSAzvyzeYUhlg=;
        b=JGVBJxvWKld0rn/9jqM/2bhQf+rNr1X18xF/1uJdH166AHbIc713T+zt3Kdi0kLZo0
         lK87Ro71VGuZ2zhYRO0TtbvcO9Jj6b35A8iCHRoNFo/iFAgE+IN6JURZs77s8MXgcrXc
         9ogaiH/vFToi23urnJKYhD/VFBwB9Dgt2/lmmsEcU2WD0xFCvjBBQkQ8lJLA8CR59mvl
         Fqzc3VWRm8qNP9ACEfmmrWy/R4CzdbmDw2mwLyv5q5LgNYopB+5sureK6Vmw6DQQVDag
         aEXmFPyUzfw3MCOAW1Jzra2aKMrwc5el8RAJA3Wje7zlE0sc2iqll+m6pOf5dAtRC3zF
         Tl2Q==
X-Gm-Message-State: ANhLgQ27338Z4kh+0rYA5LzcRNG0KJLUpamUlU2scrIi91XOP+roDq4D
        XkNXdMCdG93DpOEKV4dnY4avNl/oJftz3w==
X-Google-Smtp-Source: ADFU+vtftSrjbdTIUVBKhkytSWC+NMU7ApYyJuzep+h2n++zELb+aVQY3UH6M6NQbXqM5FHE1C+ftw==
X-Received: by 2002:a92:7742:: with SMTP id s63mr8461799ilc.184.1584025817445;
        Thu, 12 Mar 2020 08:10:17 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v21sm1709337ios.39.2020.03.12.08.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 08:10:17 -0700 (PDT)
Subject: Re: [PATCH] null_blk: fix spurious IO errors after failed past-wp
 access
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-block@vger.kernel.org
References: <20200212202320.GA2704@avx2>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c28ee7eb-6ee5-4502-0b9a-1385b29fd23c@kernel.dk>
Date:   Thu, 12 Mar 2020 09:10:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212202320.GA2704@avx2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/12/20 1:23 PM, Alexey Dobriyan wrote:
> Steps to reproduce:
> 
> 	BLKRESETZONE zone 0
> 
> 	// force EIO
> 	pwrite(fd, buf, 4096, 4096);
> 
> 	[issue more IO including zone ioctls]
> 
> It will start failing randomly including IO to unrelated zones because of
> ->error "reuse". Trigger can be partition detection as well if test is not
> run immediately which is even more entertaining.
> 
> The fix is of course to clear ->error where necessary.

Applied, thanks.

-- 
Jens Axboe

