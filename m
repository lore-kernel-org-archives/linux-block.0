Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33524C43460
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 14:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0226561480
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 14:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhEKORQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 May 2021 10:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbhEKORJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 May 2021 10:17:09 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73B7C06174A
        for <linux-block@vger.kernel.org>; Tue, 11 May 2021 07:16:02 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id q2so16122491pfh.13
        for <linux-block@vger.kernel.org>; Tue, 11 May 2021 07:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6Kr+74lLzvExC5EBfjylvQSRlSeUZiyfyFgKHEvUxZs=;
        b=O9Jzzj2SBI/7xE/xcX519SliCkV+oGtB07OdKZ+58EwsEp72sNclGc91f/YNiO+kCY
         yxT5dPyDFNTD7c6qkCXxyxp9V6pXsgb6Fm9nlZQOQI0E0RCZgEhkQyJJhTZ3IQMXa/K9
         ivTun/6vDwn25h3qtiuiWy3QzoZ7OlSRQ+QCTxzI3YSFEvCh3RRNcTAE4oPLyIizx7j3
         qjZUmAb7fzAVgrL/+EyjXq0HHJrR6atlhcGr4JiiBlCOk9sAZ3iQ3p0xrlR+WQ/6Ct1a
         TlvIZvPnwqgTdEOXVCB7Sbv2sOescppa7a3oGuEMHbxOU0+E+2eD6PTpERHIdNzcnpAt
         iuzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Kr+74lLzvExC5EBfjylvQSRlSeUZiyfyFgKHEvUxZs=;
        b=ZAMSoJIzz9Z3auZr8BhYkoK2tTMSnVYOAG5VNltwsIrNE114VgHqM4lx7VzUY4KwjM
         yLzs2tQMPdHB9w/cV1gRvWpyy+BD6DS7uOWQo3edewNhnjbDqsuWKtb0wxOppuYeydCi
         3kTbzVQ38WaRnYTSZUa2+Rw6VjYE5jx+gy13BNBDRn+T7FJ65SEMg/JhOYIaWu5CQCJG
         BadBAr5WdUSVVRu3Hoz7OLgGbgCxr5/aU1lKkwdLlEc2sql1OSMOGthWUegqT7f21xJL
         HwvR31/YTAWTTStsD4BYtSjc1WXGRNn0kFRhrO1lORxf8c3UwoZjvIl0oDsheHQnysY8
         bBxQ==
X-Gm-Message-State: AOAM530PPrl8l0OdOc7iZMNzGbrcRqeI6A0xfmILZ9/SQmtqkg9LIQKR
        4eaNTpotNI+zbzDz/qjfVmVDqQ==
X-Google-Smtp-Source: ABdhPJwpA+U2F33wQhf1W6dNhR+8dXarC43E0JsA8GHVzfwozhKwKGpohRer44734RwtZZ012bQG6Q==
X-Received: by 2002:a62:7e41:0:b029:249:287:3706 with SMTP id z62-20020a627e410000b029024902873706mr30446282pfc.76.1620742562433;
        Tue, 11 May 2021 07:16:02 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id a7sm2502652pjm.0.2021.05.11.07.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 07:16:02 -0700 (PDT)
Subject: Re: [PATCH -next] aoe: remove unnecessary mutex_init()
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     justin@coraid.com
References: <20210511113440.3772053-1-yangyingliang@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5fa5f0c5-4162-ab45-4abf-965a0613bd95@kernel.dk>
Date:   Tue, 11 May 2021 08:15:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210511113440.3772053-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/11/21 5:34 AM, Yang Yingliang wrote:
> The mutex ktio_spawn_lock is initialized statically.
> It is unnecessary to initialize by mutex_init().

Applied, thanks.

-- 
Jens Axboe

