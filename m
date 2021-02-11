Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8B5C433E0
	for <linux-block@archiver.kernel.org>; Thu, 11 Feb 2021 18:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E51464E66
	for <linux-block@archiver.kernel.org>; Thu, 11 Feb 2021 18:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhBKShK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Feb 2021 13:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhBKSfJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Feb 2021 13:35:09 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A75EC061574
        for <linux-block@vger.kernel.org>; Thu, 11 Feb 2021 10:34:25 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id g9so5977028ilc.3
        for <linux-block@vger.kernel.org>; Thu, 11 Feb 2021 10:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W5xqSQEqNa7VWm5f18JqQ7X2PMrfpMdRo0ENoP0C/bU=;
        b=ZQL72SZiPb2lAkc2QSg8cK5zNsUjkbqoVUIZxHY0+3QiKlXZ7No9xsZ5SelUBnJ6qB
         m7EKaEGLmODZ02Ow/HOcxv6snDahUQlyOB9UY/GvYiEEyElINBwPVSkxnNDj+9qj21gb
         aP2RmIeK0OTdDWslF1Id8qKo6++7wfnJOSJ5xAwjAl5Xp/XUIOJVeM2E40LcgdLK9ieS
         UUuwDcXMK8WiwuXA+oQURELnoN+ETH1hYw+bRzV2HDmzOS4biyW5rTPZC9rUo6e6W26b
         myT0PeZE97WyEqQRi99eL+lyBSsuOJpWH2uuxZIT4b8tCmFrQI47i6bT5dTWenqmaFN4
         uQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W5xqSQEqNa7VWm5f18JqQ7X2PMrfpMdRo0ENoP0C/bU=;
        b=kwOf7t/p8yTW41zaXuPM+HqgLFcpU+7kpOSXbZPy1zKhMVtdVcuigVtF3iVfC674tg
         mBDzQLr3WYcZWyU9mMD29Wwm35K/lgI4syPP9/REZ7H6X8yGRK+xdsuXFNexXckBL5xd
         6/36W658bnJK1u5ajTnpHIkFSk3PDYjgkoeVCrS7Qsuph6pSbKQcqcI9Xj/mZF+Mb0X2
         FaD/c3pdgAL7OeQDkQBiPLK2x5+mU14Q/1G7Wn6HNQPCu/CpxgaaCoAKPfE/HsP+zWpU
         RheJEW8+98SQpBBzeXnhEp3QE85RGZoSvh5W5dYGfpKgF/rIfPynOOYjLsl6uZp6J2JJ
         cLaQ==
X-Gm-Message-State: AOAM5321I4HeBAWfNY8Wn/nYW/tlFkuowPgUJ1kv6Somotv4lmc7yRAs
        rPJqaR8TW8/dw7KxU0lWVJ0dbA==
X-Google-Smtp-Source: ABdhPJyVWfI0szbeblheEu9U8yvRcSwO5mPTnxtmdPeTIpZRgipQdNG232Lwf9BKxhkGTzIXCoYK/w==
X-Received: by 2002:a05:6e02:13eb:: with SMTP id w11mr6819376ilj.103.1613068464766;
        Thu, 11 Feb 2021 10:34:24 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b9sm2962688ilo.41.2021.02.11.10.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 10:34:24 -0800 (PST)
Subject: Re: [GIT PULL] second round of nvme updates for 5.12
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YCV0PmcdMDOeQp5Q@infradead.org>
 <d76200cd-1ab2-8ac5-31b6-388db44bef3b@kernel.dk>
 <20210211183316.GA2527859@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <06daa8d8-3ec9-8372-f912-65e844b87e31@kernel.dk>
Date:   Thu, 11 Feb 2021 11:34:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210211183316.GA2527859@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/11/21 11:33 AM, Christoph Hellwig wrote:
> On Thu, Feb 11, 2021 at 11:31:58AM -0700, Jens Axboe wrote:
>> On 2/11/21 11:15 AM, Christoph Hellwig wrote:
>>> Note that we have some issues with the previous updates.  We're working
>>> fast on fixes for those, but in the meantime I think it is good to get
>>> these changes out to you and into linux-next.
>>
>> Pulled - it throws a trivial reject in the quirks list, fwiw.
> 
> Yes, people are producing buggy controllers way to quickly.. :(

We'll do whitelists instead next time, less churn ;-)

-- 
Jens Axboe

