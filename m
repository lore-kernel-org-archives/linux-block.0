Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CC7C433DB
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 16:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D455764E6B
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 16:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbhBWQzF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 11:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbhBWQzE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 11:55:04 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AB6C061574
        for <linux-block@vger.kernel.org>; Tue, 23 Feb 2021 08:54:23 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id g9so14734551ilc.3
        for <linux-block@vger.kernel.org>; Tue, 23 Feb 2021 08:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LKXgkh3WyGABz3Z+QGWP0BdM2RFG1PxsZAMH3q+mYo4=;
        b=PcEjZGKz3vVOBDGLLRLUYz8Fumrclho6ZlNXebpV3x+Tl003Qupb3Qwohax3BBtFki
         z5cYvBkMbOG0QyvTdFL9a/Jkz66E9LdvfsPSP/90a7uNJDxLl8e9P57q8fXJKLKqgcZ8
         vof3MODI6Ed+xMt2yrwxG8aJPXkZ1p4qUCWyp+wpGUOD1voBFhPs3vpPUWbP/m5JibAe
         cMNESE2W64PESMfUMbix8UccMIcy7/6931oJbnEmidHtEsEaa5eiA7ACav2HEWdctIkR
         iXy5Ns7cmEoL8MTyx7ydvg+MqjhUCMbpnlANBqt7nxMDt/ImRqu+rcKPewM+5BHpItig
         n6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LKXgkh3WyGABz3Z+QGWP0BdM2RFG1PxsZAMH3q+mYo4=;
        b=UOtqt5KpZ52uN02MNIdJrtqsP1FWshBAg3a5Zf98pIqYz6RuY7o3JBGlYWXgMY2hvg
         7rMncmvHdgJSobeQrPVufGd7ISuFv8UssC4Bt66rnooOJaBGlHIk14iJ7Fi+zA5uhsOt
         2sb/H0PSVVEICrmJSw7D1DCYfGl7ikkVQZSU2JueW0ng8qDisP04q/9eQZ7vr7n1x/h7
         y37wOEQmASjPElEN47yH2U+B/znviuZF8OI87W473V1+H5OugSl/3Zij3zg8Iwmz+hDF
         jWv290h0N6z0GyyTqNKmIIfvsjhz3BT4too6OicMvkFlWQetb06/L8LdsjShSrfIfgCU
         doRw==
X-Gm-Message-State: AOAM533T/cecmKqhkIW9cncuKTITpjwTvf1QsCnbiuWzDNvgZK3p2ELQ
        RAmXcViasOvGCa2VaGtkd8P1sKQ8F8KIM/bz
X-Google-Smtp-Source: ABdhPJxlRs+EByyAM5wGUjIYBKSTxpVoYpBGxYeAfpE34lYvP0LYv1E0VjTPLlE1WQmjuXJsGB6/yQ==
X-Received: by 2002:a05:6e02:152f:: with SMTP id i15mr20008432ilu.183.1614099263281;
        Tue, 23 Feb 2021 08:54:23 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e1sm17976971iol.31.2021.02.23.08.54.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 08:54:22 -0800 (PST)
Subject: Re: [PATCH] blktrace: remove debugfs file dentries from struct
 blk_trace
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mingo@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210216155247.1015870-1-gregkh@linuxfoundation.org>
 <20210222180255.1b117616@gandalf.local.home>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b0caa52e-5817-5ba4-29da-1444e6d6be86@kernel.dk>
Date:   Tue, 23 Feb 2021 09:54:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210222180255.1b117616@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/22/21 4:02 PM, Steven Rostedt wrote:
> 
> Jens,
> 
> I guess this goes through your tree.
> 
> I'm pinging you in case you did what I did, and confused this patch as one
> of Greg's stable patches (which I almost archived as such)!
> 
> No, this is an actual update from Greg, not a patch that was backported.

I did! Greg really needs an alter-ego for these kinds of patches.

-- 
Jens Axboe

