Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCB8C433B4
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 20:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE9061422
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 20:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbhDVUds (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Apr 2021 16:33:48 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:35741 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbhDVUds (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Apr 2021 16:33:48 -0400
Received: by mail-pg1-f171.google.com with SMTP id q10so33658896pgj.2;
        Thu, 22 Apr 2021 13:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vC1xHAkIho9Ukh7HvWx1fHpYYEd6QZIs9EuEZLrOjWc=;
        b=rGUHO6bnbIhBCUa0/oTssTE4wEitc6hOLPN4I/sle2cUrru4ogTuk3frWvWoj3VnSY
         RJj2V2faEoOIpd6ylXVF6S2fccsN3futIMlhheiH8KipbB/EzTyLKb+mBjTHPYqqLRR5
         BSEzn8FksRyEjTG8P2Y0TJJTawhkkY6yX+MxO28P7B5YGbY3L4aK/czzF4t/VDsPk98p
         Pgqe3pG7fTq85cHWp2LvbTxDroeU/4aH5v4G0oyGqyYa+13cturukEvkQdG9lr2hixZb
         4yO6UsvuNjtr18O21UYTXxZcDoCQeTpZ/jA3NGqBGmoVq1XnbadK7IUtEi8uxzmU8xHr
         zs8Q==
X-Gm-Message-State: AOAM530rzQ26uQKmQJkyRnf325AYaBS9cZ0I79k72JVYSiAPFzAYqmm+
        SZOrcK3sSwlPBvS6/XIj1SA=
X-Google-Smtp-Source: ABdhPJyMJ/uLJQk1wQG9xNa9F+ZBhYVee6nt0vIriteXQf9/rdrgvygHEGYLOmQIQIRBfjW0sMkEjw==
X-Received: by 2002:a63:3812:: with SMTP id f18mr457024pga.380.1619123592619;
        Thu, 22 Apr 2021 13:33:12 -0700 (PDT)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id a7sm2768706pfg.65.2021.04.22.13.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 13:33:11 -0700 (PDT)
Subject: Re: [PATCH v8] bio: limit bio max size
To:     Changheun Lee <nanich.lee@samsung.com>, Johannes.Thumshirn@wdc.com,
        asml.silence@gmail.com, axboe@kernel.dk, damien.lemoal@wdc.com,
        gregkh@linuxfoundation.org, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, osandov@fb.com, patchwork-bot@kernel.org,
        tj@kernel.org, tom.leiming@gmail.com
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com
References: <CGME20210421100544epcas1p13c2c86e84102f0955dd591f72e45756a@epcas1p1.samsung.com>
 <20210421094745.29660-1-nanich.lee@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <8799c4da-a07f-1837-2fa8-f968469742f0@acm.org>
Date:   Thu, 22 Apr 2021 13:33:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210421094745.29660-1-nanich.lee@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/21/21 2:47 AM, Changheun Lee wrote:
> bio size can grow up to 4GB when muli-page bvec is enabled.
> but sometimes it would lead to inefficient behaviors.
> in case of large chunk direct I/O, - 32MB chunk read in user space -
> all pages for 32MB would be merged to a bio structure if the pages
> physical addresses are contiguous. it makes some delay to submit
> until merge complete. bio max size should be limited to a proper size.

Hi Christoph, Ming and Damien,

Can one of you take a look at this patch?

Thanks,

Bart.
