Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC252C4320A
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 02:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B9A761056
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 02:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237316AbhHJCFy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Aug 2021 22:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbhHJCFy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Aug 2021 22:05:54 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EAEC061796
        for <linux-block@vger.kernel.org>; Mon,  9 Aug 2021 19:05:33 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso2060106pjb.2
        for <linux-block@vger.kernel.org>; Mon, 09 Aug 2021 19:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4obz9WkqAEaS3SU/Ft8ZVbZx29A5UvHIZHpNuPkmvSk=;
        b=kZGou/+ar6VkGad2l0SxaqeFt1SKZRIzP9scQKzNs4UWQkTcp9RFq2j7DzVxV5KgyK
         5TlRRQZiF84syxutswoRu9al2wgA6RIdYNPOBxcnTDzmobwr5KimozZFSDPrq4diHXeX
         ipKAui0LFbQLJxIpk5KS/wFGdunbQWFii1rXT4wS1I8XQZsesNjv4HPv3iAD3ea+upBS
         JSg6AlDBdu61OSsdQuXUhveKPb1AmEK5XcKA36O+/DwyPCvucbwUCa4b3wIe+ypj3GQo
         a62adTZ9xmyyPOvuM6rVkvObTb2FdTjAK6ijP2kom0N55yhlEBTjNlqSbSS+QSc+1saE
         805Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4obz9WkqAEaS3SU/Ft8ZVbZx29A5UvHIZHpNuPkmvSk=;
        b=rgzjbD8USAzoHS4sxSKeDhH/EFbtGqSRekAp91OsmTpjUEF8NlOk7X6ZM9ywIdDP22
         Kuo/5Ji1vC+LUXL/yhjjWXnuKIGQaDrbPYf7Kak3SaTnnb76paKdNT7K4KH2eUVp8+pO
         V5HrDfYhIaLyLO9JPD32xk19L5EGED/jkPo0DEfokaFx8zmIt3FJhVioj4GDupAh4syr
         VSTMfWr+VtQSyTBCDJ05QSHspjPnBEoAkfPXOUOBXAsD5njf2zttEeMqaHb3kaq1qYdC
         mJeGG1i2lohD4xmXaz2aWWg54F0C7oGQk4hJRuDIvboB87/A4/kPXqqInyMSKywH2sR/
         s7ug==
X-Gm-Message-State: AOAM53122K70ZT8+MAHReDmy6WXLfxDlRrz6Ffltu7NGLUzrFqIceQ6s
        aV22ktFDOxB/G/m7hiTuMnNqdw==
X-Google-Smtp-Source: ABdhPJwMjMG5NuvlBdsJwiOAWKSMNKV4GrcOGftPPG58i6c5kNWYn1StXNhVEiq6b+QLIyTgFs/jww==
X-Received: by 2002:a17:90b:17c3:: with SMTP id me3mr2143130pjb.203.1628561132632;
        Mon, 09 Aug 2021 19:05:32 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id u3sm18289827pfn.76.2021.08.09.19.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 19:05:32 -0700 (PDT)
Subject: Re: [PATCH] xen-blkfront: Remove redundant assignment to variable err
To:     Colin King <colin.king@canonical.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210806110601.11386-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f87ecb57-12f7-71cd-29a7-9cecd6605c88@kernel.dk>
Date:   Mon, 9 Aug 2021 20:05:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210806110601.11386-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/6/21 5:06 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable err is being assigned a value that is never read, the
> assignment is redundant and can be removed.

Added for 5.15, thanks.

-- 
Jens Axboe

