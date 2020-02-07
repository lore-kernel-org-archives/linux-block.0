Return-Path: <SRS0=URwg=33=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F97FC2BA83
	for <linux-block@archiver.kernel.org>; Fri,  7 Feb 2020 20:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9A0214AF
	for <linux-block@archiver.kernel.org>; Fri,  7 Feb 2020 20:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgBGUTg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:19:36 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:44770 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgBGUTg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Feb 2020 15:19:36 -0500
Received: by mail-pg1-f179.google.com with SMTP id g3so332596pgs.11;
        Fri, 07 Feb 2020 12:19:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=enhiSx1rzR+RPq1L2dMhTge0oU78rWexnmv2B9uDahc=;
        b=L/eXjbpiLLO8dt+sG7QV4cwHntNZenWNM6pMMGM91FBhPBnf50w5X9hndlswSQG0Zj
         uWmTsrSl07w2DKI4AYJzi7r19w6O16EwpH10QtTqDbG0msyVeRvYJulNOexI07maj41s
         g+JA9uYCEVyDHzAipZ4L/E+IuH9ETzxWpx1WRKesPEF96r1ZjoYiV1Ypvv7Bx+bGLLL4
         RnfxgrVd5Pn358tst+sYfGgdgMh6e98vNenNzUQbatnbFo9CRaY5kyNglWLQ8KSinlbc
         +OzFfYvfpZpRarar/augMolL+5Wil2134yvlDgLgBtmKmvQGeTj7jWcLz1wEDH98sDph
         t+dQ==
X-Gm-Message-State: APjAAAU3wKCj0KnRJcuoVlNJKlO24hUa2OaRgtOCrE06Dyzpf3ad8tSW
        fk6cXeSZ0+WU/UVxSLVkmLc=
X-Google-Smtp-Source: APXvYqx1ZkV8JQQI7A49xmP/CjlVkZxuoAIhEJHvJAY7U3XidYSCCYa7X46WCvwlDDelOk+QTg+u3g==
X-Received: by 2002:a63:61d3:: with SMTP id v202mr1029013pgb.184.1581106775569;
        Fri, 07 Feb 2020 12:19:35 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id r9sm4025420pfl.136.2020.02.07.12.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 12:19:34 -0800 (PST)
Subject: Re: [PATCH] block: Limit number of items taken from the I/O scheduler
 in one go
To:     Salman Qazi <sqazi@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jesse Barnes <jsbarnes@google.com>,
        Gwendal Grignou <gwendal@google.com>,
        Hannes Reinecke <hare@suse.com>, Christoph Hellwig <hch@lst.de>
References: <20200206101833.GA20943@ming.t460p>
 <20200206211222.83170-1-sqazi@google.com>
 <5707b17f-e5d7-c274-de6a-694098c4e9a2@acm.org>
 <CAKUOC8X0OFqJ09Y+nrPQiMLiRjpKMm0Ucci_33UJEM8HvQ=H1Q@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <10c64a02-91fe-c2af-4c0c-dc9677f9b223@acm.org>
Date:   Fri, 7 Feb 2020 12:19:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAKUOC8X0OFqJ09Y+nrPQiMLiRjpKMm0Ucci_33UJEM8HvQ=H1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/7/20 10:45 AM, Salman Qazi wrote:
> If I were to write this as a for-loop, it will look like this:
> 
> for (i = 0; i == 0 || (run_again && i < 2); i++) {
> /* another level of 8 character wide indentation */
>      run_again = false;
>     /* a bunch of code that possibly sets run_again to true
> }
> 
> if (run_again)
>      blk_mq_run_hw_queue(hctx, true);

That's not what I meant. What I meant is a loop that iterates at most 
two times and also to break out of the loop if run_again == false.

BTW, I share your concern about the additional indentation by eight 
positions. How about avoiding deeper indentation by introducing a new 
function?

Thanks,

Bart.
