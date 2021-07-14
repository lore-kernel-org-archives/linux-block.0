Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0B3C1B08C
	for <linux-block@archiver.kernel.org>; Wed, 14 Jul 2021 21:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68DB761362
	for <linux-block@archiver.kernel.org>; Wed, 14 Jul 2021 21:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbhGNV47 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jul 2021 17:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhGNV47 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jul 2021 17:56:59 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6700DC06175F
        for <linux-block@vger.kernel.org>; Wed, 14 Jul 2021 14:54:07 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 75-20020a9d08510000b02904acfe6bcccaso4040421oty.12
        for <linux-block@vger.kernel.org>; Wed, 14 Jul 2021 14:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ViMyznVjJWi+/EIwQislboFLiVbDEIKkFBTz2gjKkZE=;
        b=UDe3R6XUZ99WQEvlgZTUwQv8nf6cth+ChxZR9sOLQTt+J/5UNbEhypZUJV2VGOstMq
         WNX0r3ab47Tv+TFQUxr4CnEvaMoAYzUipI9cd1XzAgId9n8v3wiYk2GHykrXSYXZDBK+
         Xdqt7Fkan7FztrT3zFFA/i9betEwzBrPEQk1VX8vevdHQk32/i+O7Ov5cVTG7l8kHBtB
         MAwqthmTUzoTqATpcNH3p+sLTr6E5hZ7Iuo+r1Au+DwLz3c2QCyATzcee8m2yNqg18Ri
         pJuJEGmrDvs6UurV+1sBBAoFUZiWFeIeCNM3WLdeqzEtM3QOxGos9k8R68KdqLNMnPK2
         u58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ViMyznVjJWi+/EIwQislboFLiVbDEIKkFBTz2gjKkZE=;
        b=MZVLbNvKLxJonsehcWXrKi4A5bGAX56ap6UWxje76O5vMIKQb7Z2TG0wZzG7wR2GZQ
         L99d38l0KpEJSgWfyUXgTNJQxPRKWfX0BaOwOlrsRqa5tJDIOYZ5NscGuF76kvOy4Sqi
         UTW1H0oxERzaBBUknm1EbTMoFmh9FKpbX3ADN4sD9JiM+XgrvQXnMpQXqjW03pMPghra
         ypeA18+Sq5vQtlOkEVeSp4MtrwCy3J+k7WGXQglccgW816/YYEy3SvNbBc58C3Qs0qlc
         YUXeLSgWrI+S1nJWYbxsZpdXYkoJE3mXX3trbqv/RTj3W5TwYjDXyk/PmJKr0zDqINyF
         J4GQ==
X-Gm-Message-State: AOAM531Ry4pcf7Olo8cSCAgbnmXEUQtkVeoCd6sfbFNUHXA53x6p3IdB
        jtwFXotjfbqGRtjXCtodx4I7hZ6uByqW0RH7
X-Google-Smtp-Source: ABdhPJw09120Q14wzc28lLxfEhvwNImmP6ji/Xl854vWFrOqTe4FgE+eOfXl1pRqz59XQyYzX6lQRA==
X-Received: by 2002:a9d:6044:: with SMTP id v4mr239799otj.117.1626299646724;
        Wed, 14 Jul 2021 14:54:06 -0700 (PDT)
Received: from [192.168.1.187] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id d3sm737831oia.36.2021.07.14.14.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 14:54:06 -0700 (PDT)
Subject: Re: [PATCH] ioprio: move user space relevant ioprio bits to UAPI
 includes
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-block@vger.kernel.org
Cc:     Kay Sievers <kay@vrfy.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210714195655.181943-1-socketcan@hartkopp.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cfcab506-b988-0061-01e9-0b4825af6e34@kernel.dk>
Date:   Wed, 14 Jul 2021 15:54:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210714195655.181943-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/14/21 1:56 PM, Oliver Hartkopp wrote:
> systemd added a modified copy of include/linux/ioprio.h into its
> code to get the relevant content definitions for the exposed
> ioprio_[get|set] system calls.
> 
> Move the user space relevant ioprio bits to the UAPI includes to be
> able to use the ioprio_[get|set] syscalls as intended.

Looks good to me, pretty sure uapi/ didn't exist back when this was
originally done. Applied for 5.15, thanks.

-- 
Jens Axboe

