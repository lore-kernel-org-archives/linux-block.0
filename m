Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E7DC433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 16:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7125161050
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 16:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhJLQmS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 12:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhJLQmQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 12:42:16 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC432C061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 09:40:14 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id q205so24368543iod.8
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 09:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sEmrYH4NvVF1ZxwPs0S6iKBLW+ysA/a6Qo/ICdcQRbc=;
        b=3nL4zjRpwVaQ/p6Pi2tmm87a0617NKBDP/hP2EdeaycDqZhPrYi8bXI8Hiqgri/6g5
         VJftCyPnnkuf+2QEm1l/z1AYdGYwuGHzn9/clo00ZesG8dTMEqKIJqRPQd7u9xgbV+bu
         MP1kwo17olTqnuHMwLm1nAIYweS9NweMnOZkgqQd89kT4faQUJ6UU6w0vFxTUhnR15X+
         vbs0CR4cm5OsqTIitpxh1fEszBvz2OdUUzDTVV6eB0/TrIVvwOS4TOyeYMC0MjJAUmsl
         Tl+Lm8Aqx2KCRolNxATbY1HoQ5rLE5LLch+7Fwu00uW3USuImIiFjBG9dzG3kRiPEs2D
         y/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sEmrYH4NvVF1ZxwPs0S6iKBLW+ysA/a6Qo/ICdcQRbc=;
        b=3quV8qkVNt0tqucXuwTyR4PzxtjcnXey8RRx+iW9XK9qDyCkDbnGKkanE+UDdOLnzR
         xOMlJ+hAnTpQg/RUHs+h1ByfJIbW1hwoAu58tkIVSRZHIttuC5fX7BEUDqU+ee0reyq9
         BxgLW7EGwoL9KTuw+ul1lspT4kM+likhvQi+P2xBCvZlqNhrzNLo0K6ZMJFbY+OPPbMO
         h1NzDMXBvDpfN5aQvuwi6igoRAMtAy9bArx01MqK9LFwYlENrQ48y8CEX6OP+vWOzHSy
         epbQWs211vuU/Hpy8TUuILe2lajrJwe/CmGUWA9NbRxlv/O1jIcKjZrMSEff9L0OuJoL
         t1fg==
X-Gm-Message-State: AOAM533XuKp5vfiHBfrXckeON1mDTSuTluWgMQCOzZUJbeIhvXJn8RLs
        7/qS9DTGsFUhpNrFpm38FfySzY2csyjZlA==
X-Google-Smtp-Source: ABdhPJyoCGYA/LBoSf/aWtXK+RRf4FObGtqq6cJ72BENLpdrJuzBTSV/BePKatlqFJOlExnFnKgKAw==
X-Received: by 2002:a05:6602:2dd4:: with SMTP id l20mr1660574iow.151.1634056814226;
        Tue, 12 Oct 2021 09:40:14 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id j17sm5807696ilq.1.2021.10.12.09.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 09:40:13 -0700 (PDT)
Subject: Re: [PATCH] block/rnbd-clt-sysfs: fix a couple uninitialized variable
 bugs
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20211012084443.GA31472@kili>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fd6395eb-c237-68fc-f5bb-9c3f563fa6f3@kernel.dk>
Date:   Tue, 12 Oct 2021 10:40:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211012084443.GA31472@kili>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/12/21 2:44 AM, Dan Carpenter wrote:
> These variables are printed on the error path if match_int() fails so
> they have to be initialized.

Applied, thanks.

-- 
Jens Axboe

