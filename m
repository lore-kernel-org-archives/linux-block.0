Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD646C388F7
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 20:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B633216FD
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 20:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PBcYQgmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgKLU7a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Nov 2020 15:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgKLU7a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Nov 2020 15:59:30 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5521FC0613D1
        for <linux-block@vger.kernel.org>; Thu, 12 Nov 2020 12:59:30 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id l12so6589529ilo.1
        for <linux-block@vger.kernel.org>; Thu, 12 Nov 2020 12:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lDnpPB7nKgaMbTFAoAOs8WVp3kvpFh4hC0mKRWBgwOk=;
        b=PBcYQgmG9UGxXKwhv1HVH+39QEMa3MfiaK59TCNaaSKh46MV8rDF0Wk82tAunl+XvL
         /pAU6fX8Fuwuw3JW2Orv4zdMoSfF4yykIWJ8YeNKdYtkDUUWQxLkZY7Y80q/FVE1Qrqh
         8YFnXVjHfAPLOqkEd77HESBJ7DTf87Do1KfMBDTnD1jlm5nBZP1CGYzblEoWuoU3FHqM
         KFDlsfKAYXFhn6BE4hTzW1kSbBUCPcTwp/mYjEEEo4lJcPmObyAiUHb7G2R7ZdjeAOKY
         zTOaThmv8VrahGK9QpoB1oU7hmKspvsWri8Et1JWCSZIYXE/GoitdVN6c9PXmkOplHbE
         C54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lDnpPB7nKgaMbTFAoAOs8WVp3kvpFh4hC0mKRWBgwOk=;
        b=aD+qgxEFqyyeW6BZXTWxE8msAOxfIj5rCoNgqcvSowzRpApOqOqd4x5kD3Jk9r7zI9
         BqsuDMeG6gqGuLxZbwffudOTKgJH8S7KGCENR4Ia/ApBYpb80Tq70L7eopbKqszJ1qd4
         ROgwIZUj9J6x074k8NKOgS4KogiLBTkDakZVOAJCUBFTjtUWQkR7RPnfWl5VG0wfVvnF
         GMz3dx1/IzZoTcHzHYgMR/0Xl4tkj1ICfmGqRhEue0mCohqWW5+jnDI2Aa841symQz3b
         pjfYiXSdGMpOxuYn/RbY8y73XHlcXpZYMhArFh85AVKi9VsGzPN3B3cfw/ID5CmEj9qT
         oDzQ==
X-Gm-Message-State: AOAM533UvdyANn0KlWL6aX0K9mveIKznwfFAL0LvNSNWNzjRhXFAy3hq
        ci+0VXGHV42mUFEDCEdr/yYrGVCEfAPRMA==
X-Google-Smtp-Source: ABdhPJxHYaroXxnOU42LeaN1oHTw9U/iAiahGKpE11pLmVId1o0fcSffrHpc2kr6WReOCA2FnzBB2g==
X-Received: by 2002:a92:aa53:: with SMTP id j80mr1242337ili.88.1605214769474;
        Thu, 12 Nov 2020 12:59:29 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j85sm3677209ilg.82.2020.11.12.12.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 12:59:28 -0800 (PST)
Subject: Re: loop uevent fix
To:     Christoph Hellwig <hch@lst.de>
Cc:     Petr Vorel <pvorel@suse.cz>, Martijn Coenen <maco@android.com>,
        linux-block@vger.kernel.org
References: <20201112165005.4022502-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9366a9e5-0abb-8347-9861-cbc8cdd4760f@kernel.dk>
Date:   Thu, 12 Nov 2020 13:59:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201112165005.4022502-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/12/20 9:50 AM, Christoph Hellwig wrote:
> Hi Peter and Jens,
> 
> this is how I'd slightly respin the patch from Petr on top of the
> set_capacity_revalidate_and_notify I need for 5.11.  Let me know what
> you think.

LGTM - I've added it for 5.10, marked for 5.9 backport.

-- 
Jens Axboe

