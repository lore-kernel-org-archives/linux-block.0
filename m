Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E419AC07E99
	for <linux-block@archiver.kernel.org>; Mon, 12 Jul 2021 23:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB083611B0
	for <linux-block@archiver.kernel.org>; Mon, 12 Jul 2021 23:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhGLXHL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jul 2021 19:07:11 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40652 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhGLXHK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jul 2021 19:07:10 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by linux.microsoft.com (Postfix) with ESMTPSA id 01CE320B83DE;
        Mon, 12 Jul 2021 16:04:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 01CE320B83DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1626131061;
        bh=4CjPOUAxzVubyai1qUKS2UmLuMVKC4zzcEjDKnIOt6A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CtUMyhCnyAiHNNbRjD1VdSV2uPbx23HYApfuo+ZneiRtEhZZWX7mhDYuCtWD+Uyml
         sh3KjV0xL5xqe9cM+I2cxlsiOhFFA+BI0lVkk9QO2QZBEOgnvP0FOZmRUfA7VIN/cT
         6PK9nHgvVz49chG0Kua3e86sKoFs+p+hyjVsjI8g=
Received: by mail-pj1-f47.google.com with SMTP id bt15so5925460pjb.2;
        Mon, 12 Jul 2021 16:04:20 -0700 (PDT)
X-Gm-Message-State: AOAM531WVd/N1q22/lfdwMp6WI7ZH+rwY44ybmUBeF4jZl6SUiaMci98
        ex4OHRNXBN1t3/XZiPPyf3p37iFStJKq5qvUEe0=
X-Google-Smtp-Source: ABdhPJySPc1OmbFETVHHWk5fhfjLvUwKzvPb95LPNjHzPt8Cmw7M3aDsddJfLS+UQojHulC9aTlbiHGwvEluZNiU/bg=
X-Received: by 2002:a17:902:bc44:b029:12b:415:57bf with SMTP id
 t4-20020a170902bc44b029012b041557bfmr936057plz.33.1626131060388; Mon, 12 Jul
 2021 16:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210712230128.29057-1-mcroce@linux.microsoft.com>
In-Reply-To: <20210712230128.29057-1-mcroce@linux.microsoft.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Tue, 13 Jul 2021 01:03:44 +0200
X-Gmail-Original-Message-ID: <CAFnufp26HOR2K_MJbgX=A6T7Mzw9bxnCkku=w_HEbb8-=SY4Hw@mail.gmail.com>
Message-ID: <CAFnufp26HOR2K_MJbgX=A6T7Mzw9bxnCkku=w_HEbb8-=SY4Hw@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] block: add a sequence number to disks
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 13, 2021 at 1:01 AM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>

Wrong subject, please discard

-- 
per aspera ad upstream
