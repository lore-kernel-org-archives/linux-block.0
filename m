Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4B7C433ED
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 15:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5671961244
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 15:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243087AbhDMPRR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Apr 2021 11:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhDMPRR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Apr 2021 11:17:17 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CE4C061574
        for <linux-block@vger.kernel.org>; Tue, 13 Apr 2021 08:16:57 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so16437200oto.2
        for <linux-block@vger.kernel.org>; Tue, 13 Apr 2021 08:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=maeKwgZ3Lu8umQLZ5DD3nN2KhyzFuHK+4JJFm9x8Z/w=;
        b=TWatFnzDBbOFMgZ+0nCNkXOHFU8Shx2uoOyHgnF/ojEGIUQzrFC2JbGGuIoa35yjxA
         8FlCAxphn1wuWSWJAZ9S3dxqee/wl6lc2ED2/l0MJQiej4XDLSLggeGsDNJTYc92qLW4
         iF9OZ+yIv83+/Zk/p/e72slaS8s/bCfrTaEpzoWDHbPOpfYEXqyDu+XH3m9ydNyxhS7z
         oHPgXyCgfGetMqw8lslRqm/jpN4HnOD3OxmyNt7f3prFF+7j8gVlSJIMX7C7+sxyrnbn
         p4OEp71ZNdQv14bq1tRdUQWS4mQpDtVt6EP8ZmeoDqOM6dQggoL7g9dtD2F9YGLF6HKf
         EbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=maeKwgZ3Lu8umQLZ5DD3nN2KhyzFuHK+4JJFm9x8Z/w=;
        b=UfX2CSnnrDcQMKcmLhFOAG5gHk92SFZLYh4BdE3YOQ2EM3fhxinpxOb7+3r38dz0gW
         sLuh7BoB6b1MW+D/IRxD3wMe6dsHCS8U99keNkspooP03n4ts2e4vgUCbUmIMQOzcrQn
         y6RWZ4iI4G0rFZz1x75mtYDqvPMvavmN6is/Gi3jGsEuIgzAAuQEh+2gKRH6s2tPkhlr
         ADoXiKiDuhenllE9Cvw7YTDouOjSra16CBh6Vj+9lmGUCvIgTQfNSUnUluu7dsOyoX4U
         nXAV6R4wptaJ7TUj5ei41GUKQveGzjVhvev5Bwmy9wPk5WO55q39V2ZRiifxEYLlM8gE
         SVrA==
X-Gm-Message-State: AOAM531bprSOs/VYMPqrkJ24sqxaFxfFjcuBRWz5grwY1vypmmaSHZOf
        RZTKqz37ENsu+dQ9kvPOT2flTzg6kybmzQ==
X-Google-Smtp-Source: ABdhPJxYhdZFUxiUBR519/0s4nZ9P7wOmaeBgEXWQUB2RenVdljJUA8HKF9TUClrMMu9vqokSow3Jw==
X-Received: by 2002:a05:6830:1093:: with SMTP id y19mr28428742oto.337.1618327016721;
        Tue, 13 Apr 2021 08:16:56 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.233.147])
        by smtp.gmail.com with ESMTPSA id u18sm1805125oor.15.2021.04.13.08.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 08:16:56 -0700 (PDT)
Subject: Re: [PATCH 0/4] lightnvm pull request
To:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>
References: <20210413105257.159260-1-matias.bjorling@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b98f19e9-bfda-fb61-fa56-c41d69d56edc@kernel.dk>
Date:   Tue, 13 Apr 2021 09:16:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210413105257.159260-1-matias.bjorling@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/13/21 4:52 AM, Matias Bjørling wrote:
> Hi Jens,
> 
> Please pick up when convenient.
> 
> This PR officially deprecates the lightnvm subsystem and prepares
> it to be removed from kernel 5.15 and onward.
> 
> The lightnvm subsystem has been superseeded by the recently standardized
> NVMe Zoned Namespace (ZNS) Command Set specification. Together with other
> advancements in NVMe, it is now possible to implement all of the features that
> the original OCSSD work introduced.
> 
> Thanks for enabling me to contribute the subsystem. It has been an incredible
> journey. While the subsystem itself had not had that many users outside of
> academia and initial PoCs, it has been instrumental in gaining
> enough mind-share in the industry, which ultimately has allowed ZNS SSDs to
> emerge. Thank you!

Applied, thanks.

-- 
Jens Axboe

