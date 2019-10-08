Return-Path: <SRS0=ti8e=YB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AF8C47404
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 03:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824CA2173B
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 03:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XXZLs70W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbfJHDPI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Oct 2019 23:15:08 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:43793 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729536AbfJHDPI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Oct 2019 23:15:08 -0400
Received: by mail-pg1-f178.google.com with SMTP id i32so2140582pgl.10
        for <linux-block@vger.kernel.org>; Mon, 07 Oct 2019 20:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oNu7yT0yvVsNke43d0Ybgmrh30URkFaOvoyWjzR77FI=;
        b=XXZLs70WPIh9sv9zQ95KuKPLdpef5Jr2p3bw8rWvcxuXx5Y1cQxUf/9WTYPCettJWr
         i7jDf2nruy8lPGEDAc/1IM2YnAQhWWuc7UK+0+G47lH57zoZy8WssH5jGqhyhJDDVRLg
         HqA5PTmOx5QvBH1+z6eKBo1pBtZu3DQVOwGjIfCqF7a5wO0OkY8HKcn25HqGP7KXCxrp
         5bnDcw9VMcyRxk4+TWWV0GHsCRrWXmwKefJdo/XdOM1idxA1bU8V0YH//0GIwmzMxkMS
         ZpzGEl0IcPyq0OQzMlXTDH57CRXdl2+49+NsPC2wxyVV1GsRUXuXK/Y+J0A44HPFafoq
         Lw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oNu7yT0yvVsNke43d0Ybgmrh30URkFaOvoyWjzR77FI=;
        b=fft6bCCptc9XBYDipG5zhaOC6oZJCaA4PlNwp6FA9fhgI0noRumykt1A5THLDI50nh
         a20NGgt5Vrb4SThIIGPKs6lQaAYD0JElOpmYaIOEyji1M8a+YOzgs2Txvnp9bAvy/N5y
         D/+X1ACKc+yD5wV+UYi4YzngOieSxc/jS1qErJD2gc1pinp56k8rqD0zQ9fpa2VbXrJG
         96r7gDQuPWUHfs4HePeLNJlSgdjk5dVIxc33a7xbkLtcGsvaXqu1ydHBbxSTfODBjXU8
         9OqRlXhDyP0GseebXcrm1g7GGk9KTYh4pIXZ4DVIJBxi6v03EnIS4EU2SvLmryrYWogp
         kQ/A==
X-Gm-Message-State: APjAAAX/982VphnAl0nlgh3JR7zbZbsyJMXLKEZiCNPjUN13IvPuZAfg
        MV0l46gKmO1gvNAEDLKVPLOU50KJi/CGxQ==
X-Google-Smtp-Source: APXvYqx+OfdHLJAxRBz8ePcuBQ41f5iPS2XlqmtpP4oAH4R6p8R0Tl7W+wpCjIxyWjA12zGOU2/uIg==
X-Received: by 2002:aa7:998f:: with SMTP id k15mr37784738pfh.203.1570504507455;
        Mon, 07 Oct 2019 20:15:07 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id q132sm15776299pfq.16.2019.10.07.20.15.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 20:15:06 -0700 (PDT)
Subject: Re: [PATCH] block: Fix elv_support_iosched()
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20191007221246.12824-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6fbdefb2-03c7-ca26-228f-614c0e1ad7a6@kernel.dk>
Date:   Mon, 7 Oct 2019 21:15:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007221246.12824-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/7/19 4:12 PM, Damien Le Moal wrote:
> A BIO based request queue does not have a tag_set, which prevent testing
> for the flag BLK_MQ_F_NO_SCHED indicating that the queue does not
> require an elevator. This leads to an incorrect initialization of a
> default elevator in some cases such as BIO based nullblk (queue_mode ==
> BIO) with zoned mode enabled as the default elevator in this case is
> mq-deadline instead of "none".
> 
> Fix this by including the absence of a tag_set for a queue as an
> indicator that the queue should not have an elevator.

Why not just check for mq_ops?

-- 
Jens Axboe

