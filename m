Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F26FC10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 15:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C022148E
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 15:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AOrhh3OJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfDHPNg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:13:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33001 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfDHPNg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 11:13:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id k19so7519172pgh.0
        for <linux-block@vger.kernel.org>; Mon, 08 Apr 2019 08:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nWRmV5hnWcj49GRojO3p9tTh3nnI78KHTzO7Ks82NPI=;
        b=AOrhh3OJhv6fTgAN3lnFSC9P62p3kWX2b95w6xUrE5zmBy/mACCOcIaL04LdDW5UcU
         5x/neDtDbP+AV04jGUSZbehpsvOYe/lL7SjhBPyps1nnJCy3hptyMUQjLrhANj0f/XcO
         gbv4W5FZ7VptYg22lXnLODtRjhFxXvXIqajpH9ZVQlnmLGlD0VwQ3xYskLMDi8bhrmKo
         Q/WEY9qskUiJ2Jg+FV9E4ENFEo8q1s8gIk5lwRjWIvVWC2PidRHko/8jYy4XU6ECWFk0
         kVYtzeFq+fezy8FxJWeJdd2kQVcuspOT/HUnioRllLQQGROHyWTprsHS2vgGprbrvJ3N
         p3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWRmV5hnWcj49GRojO3p9tTh3nnI78KHTzO7Ks82NPI=;
        b=nB3FR8bskU1WYB57XkIoaDJPmKnr06KraajbbAXpEvk3Ja6w6WZmsrURs8BcXnM7Ld
         1sHdrJDpMxUJU5lGRR/+W6fcKrRbcLv/XAU2YI1gEIhcYPqRlt9+gInDtr5hoeUk0/kE
         R/mh7mAc2n4S65OZteni5mKunyRxkk9Ux/2zNNHMT5G+pvs0QVz1QV+5XUm6+7RyFC+H
         upAfdauoj5C9dDnyXQ2+QknBscXYv6pu39jGIxmvyKhWeCqMpsCXErhDAJ/LyzBgn/qd
         6VsoYPf56P0xq7ejcHvKoQ+8ODvbWF3jO/HRKMkyKqEyFuA9Bh0lw8ZwaPDMTwy+z6Lm
         n+Pw==
X-Gm-Message-State: APjAAAVKTfSaC2KTN4mjjRMYp0UvjlaoP09jxu6KeYIvJOpPdm9E/aca
        qrc8wzXuYe/SoNnd79mnEnzbsQ==
X-Google-Smtp-Source: APXvYqyC4lebBvqpoMDFRPcl9LSlOCct2H5VzPdRztvGNyNyYoaj7J3CJ+ns1DcZBrMblJJesmG9jg==
X-Received: by 2002:a63:9a4a:: with SMTP id e10mr28779764pgo.366.1554736415473;
        Mon, 08 Apr 2019 08:13:35 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id g64sm70307820pfg.13.2019.04.08.08.13.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 08:13:34 -0700 (PDT)
Subject: Re: [PATCH 1/1] block, bfq: delete "bfq" prefix from cgroup filenames
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        'Paolo Valente' via bfq-iosched 
        <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        lennart@poettering.net, mkoutny@suse.cz
References: <20190408143935.9062-1-paolo.valente@linaro.org>
 <20190408143935.9062-2-paolo.valente@linaro.org>
 <20190408144925.GA23021@linux-x5ow.site>
 <7B68DAA9-61D9-4AE0-9FA9-05C07C7FE408@linaro.org>
 <20190408150430.GB23021@linux-x5ow.site>
 <df1dfe5d-c763-91c2-4aca-25d4622c4820@kernel.dk>
 <20190408150828.GC23021@linux-x5ow.site>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d5c1fb9c-16ec-420c-4067-53d6bccb4ebd@kernel.dk>
Date:   Mon, 8 Apr 2019 09:13:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408150828.GC23021@linux-x5ow.site>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/8/19 9:08 AM, Johannes Thumshirn wrote:
> On Mon, Apr 08, 2019 at 09:05:19AM -0600, Jens Axboe wrote:
>> I did consider that, and that would be doable. But honestly, I'm having a
>> hard time seeing what issue we are attempting to fix by doing this.
> 
> Yeah, I guess the real fix would be to update the documentation and the
> expectations user-space has. Including eventual re-write of some udev rules or
> whatever is facing these files. But to me that sounds more like a systemd or
> even distro thing than a kernel thing.

I agree. Trying to force someones hand by renaming isn't going to fix
anything, but it will potentially cause issues.

-- 
Jens Axboe

