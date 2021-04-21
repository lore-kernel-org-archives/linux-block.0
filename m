Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D7FC433B4
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 16:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FEA661409
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 16:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238604AbhDUQaK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Apr 2021 12:30:10 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:39868 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbhDUQaJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Apr 2021 12:30:09 -0400
Received: by mail-pf1-f180.google.com with SMTP id c17so29360660pfn.6;
        Wed, 21 Apr 2021 09:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tdBzVFIF/DPj5kbx7GhM1WCivnxc+70C6D8b8ZMfgmY=;
        b=L6N2izgSg3LZsX4wK4hXy9Sj4/KdERx/GtNhBuGF53xAKlZHULxuzhrANZisN1GOj4
         6QOpRoN/9fjd2TCs+0KqrWbpxrD6e2nrjGpESFY384fi7nJ3zyfW4ClMDR8WVj72fXav
         noM4GmfKhJVnFeYR/iO5RDicR2E/ZpsGmS+JtPGLDsb97PHXubPq+Hmaxje0ZtxXbTO9
         rPEFhPSkJe7QpIgPre8JgrTL5L6wHeARqpmnkId+W6LbVFTIW0ZQQNu6ic9NN/L8aW1u
         YvXsMSUD1eTE/P2O9LYH2uJgFfjEYbufABKyDkDhYqW1KCehPWhIXHfc0n6VgHHYj+Ho
         x/UA==
X-Gm-Message-State: AOAM533pAltunC+7dzeaV3yt/pJZb7jnVyHB36vgwEqkiQTBY3hrzoyy
        tCjtl3rDcWxrNeIUy1kwydmP3NxKp/tHD1/v
X-Google-Smtp-Source: ABdhPJzhTf4hM1Q4ATSIeN7fJ/jFcF9h/9gIblfr0Cu5BY9riuV7Q2SbOH6p1aA5h5vMueg8v3W3qA==
X-Received: by 2002:a17:90a:aa15:: with SMTP id k21mr12359134pjq.115.1619022575060;
        Wed, 21 Apr 2021 09:29:35 -0700 (PDT)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id h8sm2700352pjt.17.2021.04.21.09.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 09:29:34 -0700 (PDT)
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
Message-ID: <55adfb07-7f10-7ad6-e05d-7aeb7d9c3b29@acm.org>
Date:   Wed, 21 Apr 2021 09:29:27 -0700
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

This patch looks good to me, hence:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Do you plan to submit a dm-crypt patch that limits the bio size when 
using dm-crypt to the bio size of the underling device?

Thanks,

Bart.
