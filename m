Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FA8C433E1
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 15:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8050461A28
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 15:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhCZPqs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Mar 2021 11:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhCZPqh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Mar 2021 11:46:37 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C163CC0613AA
        for <linux-block@vger.kernel.org>; Fri, 26 Mar 2021 08:46:37 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id d10so5395000ils.5
        for <linux-block@vger.kernel.org>; Fri, 26 Mar 2021 08:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9neBGUkGjeI9Wss3qn32vtUKfxnPNKgHyjXqvLAXo2U=;
        b=JF80Equ1gB3yG7jN/+29x9IlqK4Ui20FfaAFAYDVBr0IKlN1ib3rKnf5J2Pm9h5g9d
         DV0tmCOoETubjqAjQsuSM4Q9S0I5KKukBEA/TRN266CKIE/RyqbtOBX8XNv/YkuqryiN
         yZ4Stevs8aLoKsEUf9JUB6FJswGgu9rAMtmStyu8UrPbW4wG05UepFTwnRJNFhDUCVjW
         1g00yZVOV7FFZIDkVjHtzMrdCYJpGo1RugDXqeY3sLPHgA2DXdWgGsF0ahl8ZlXJi278
         m2v/K2KtaZ3ohgiUrxngmEsnsZtsVL/kXWE1bcmTVKDV8WKw8EK67lU8SaXivUVKiOF1
         /58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9neBGUkGjeI9Wss3qn32vtUKfxnPNKgHyjXqvLAXo2U=;
        b=gXMxSQmNRd6eI85DCSfIy1Z2Z/G2jeVtbrEearXWzHTo09lsUDPm3hYBZM2gcufsD9
         a0JO6cDQ5EB5Ftut/S0n1qHQxWCeKXmj1pnw71oAZS94orZ2Ceb7mK0I42qmjcyDApbV
         1QTxyU7UHfiZwTaBrwzS6C8da2B/yiHpRx1xsz7payVw3WPHXS0ErhFbYGwVlDfKh2Ut
         0lBWEeXo4PansGMmXatZGcOVBJwsT5ofKJuDVDFMqNuzQ69AvwMBE/nrbKSc0vc5hTBK
         5oPlORqQfwEK110T0NhsfwNzhBY8AP378ybLT9nrqUjlef6bw4DKxDlvMQXnl4wG2H0U
         +MAQ==
X-Gm-Message-State: AOAM532UUdFg0taGpcjRDU5APk58OBdLl7bk6u3yg/D5V3FP99frMhkh
        ZN+P5mXivGiUl9NrsCoh6Ehc0Q==
X-Google-Smtp-Source: ABdhPJwPBJfSOFUbk4FOeyWWAqmyOcvafcn2ucUp8HrIrijfyHm0mad4xPcCOGlR307l1SSHNCJ/gQ==
X-Received: by 2002:a92:3003:: with SMTP id x3mr10930135ile.124.1616773597176;
        Fri, 26 Mar 2021 08:46:37 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e195sm4540586iof.51.2021.03.26.08.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 08:46:36 -0700 (PDT)
Subject: Re: [PATCH 1/1] block: fix trivial typos in comments
To:     Tom Saeger <tom.saeger@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
References: <31acb3239b7ab8989db0c9951e8740050aef0205.1616727528.git.tom.saeger@oracle.com>
 <2831e351-0986-28d5-5eef-53edcf8f41c3@kernel.dk>
 <20210326154519.y2ztm2fqirxejaht@dhcp-10-154-182-208.vpn.oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <02e3bdd7-896c-2286-d090-1931c5cd807e@kernel.dk>
Date:   Fri, 26 Mar 2021 09:46:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210326154519.y2ztm2fqirxejaht@dhcp-10-154-182-208.vpn.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/26/21 9:45 AM, Tom Saeger wrote:
> On Fri, Mar 26, 2021 at 09:41:49AM -0600, Jens Axboe wrote:
>> On 3/25/21 9:04 PM, Tom Saeger wrote:
>>>
>>> s/Additonal/Additional/
>>> s/assocaited/associated/
>>> s/assocaited/associated/
>>> s/assocating/associating/
>>> s/becasue/because/
>>> s/configred/configured/
>>> s/deactive/deactivate/
>>> s/followings/following/
>>> s/funtion/function/
>>> s/heirarchy/hierarchy/
>>> s/intiailized/initialized/
>>> s/prefered/preferred/
>>> s/readded/read/
>>> s/Secion/Section/
>>> s/soley/solely/
>>
>> While I'm generally happy to accept any patch that makes sense, the
>> recent influx of speling fixes have me less than excited. They just
>> add complications to backports and stable patches, for example, and
>> I'd prefer not to take them for that reason alone.
> 
> Nod.
> 
> In that case - perhaps adding these entries to scripts/spelling.txt
> would at least catch some going forward?
> 
> I can send that.

That seems like a good idea.

-- 
Jens Axboe

