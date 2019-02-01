Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A489EC282D8
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 15:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695BA218AF
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 15:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oFsuI+hZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfBAPeu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:34:50 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35854 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfBAPet (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Feb 2019 10:34:49 -0500
Received: by mail-it1-f194.google.com with SMTP id c9so10336304itj.1
        for <linux-block@vger.kernel.org>; Fri, 01 Feb 2019 07:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7Vp+DGBZGxEE2s5PpXWlcivBg5TYRjRohltMhSZAA08=;
        b=oFsuI+hZ+gGJk5IiMJQHDxIc+yOBR7gU198U+S4AR9cnjLDwVRkHuY97NrHy9viyMX
         o72I5eEpNcQG0u/fKE5ZVvKW7uN8Eg4o6vtc408/XLyCl4LdlUGPvuWlmeLYFaNqL9In
         UYoC92lymBiub5uajO3/xSdsnOlvchpCjtLk3bUABkJ7UHzzA1zK8wlY7GQh/sBXmmDI
         4iHw/bzL7SrLvfHg0MX/D8y94Q4rAcGn6buKey8RYbha9uLMtlKigcVq6/HAFC3KIk5b
         rKGbpJ+w2nzxkydXOLZ/klQcQz/VgU3pvtFyRh6mK8EoMVozmNvbcILdFc+vq08MNzuk
         lNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Vp+DGBZGxEE2s5PpXWlcivBg5TYRjRohltMhSZAA08=;
        b=pRjodNC9KJoRE9NkwIH4JGz6NGNdRNnSvX+MSjWwk+cLKMx6zQB0OckslkIXb52lhm
         IAmKxR86PHwbJYoi2gtbYTNxDIyHHsfcFoDA7iMWIhE5FX5hoDTZF1LiH0RJC3V8gkuz
         /+hT9oFkzpinzojTDftxczpyhJFNVlf+9/nvn2jgCKij/GjTMQL42NdiZ6Gh1vzI8TAD
         mGqA3kEOoO/VJZ/8CmzCbcADUKLTIR7PZRKtlsik/H2rgdyQU7VoxyGYOJjeIwTTl180
         upPgHw9q16ek1SNEbvhdrldo6y6Q8WTMnKknPd5axdQo0wLM4WSV0ZA8AutlrpFEiypX
         7UfA==
X-Gm-Message-State: AHQUAub5pmgY0w/ClCwx6heHEmGuZRPiSQM/06Zr3xhDyligV7MT8dNi
        1BMg7MoQ4+bo7E/RQ3AMlwnojOJMLHc=
X-Google-Smtp-Source: AHgI3IaHJ1ruAD8kh+MPcHRHHwj62n0G27svaFXj1uQgUdU8CVpEQiJsXo3lX2RbFdZjgJCTUrz7wg==
X-Received: by 2002:a24:3391:: with SMTP id k139mr1760528itk.25.1549035289024;
        Fri, 01 Feb 2019 07:34:49 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id v4sm2061636itv.20.2019.02.01.07.34.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:34:48 -0800 (PST)
Subject: Re: [PATCH 0/2] small optimization for accessing queue map
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1548325533-1695-1-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <94a2634f-24e2-b846-9c13-2fc9c0117e0c@kernel.dk>
Date:   Fri, 1 Feb 2019 08:34:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548325533-1695-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/24/19 3:25 AM, Jianchao Wang wrote:
> Hi Jens
> 
> These two patches are small optimization for accessing the queue mapping
> in hot path. It saves the queue mapping results into blk_mq_ctx directly,
> then we needn't do the complicated bounce on queue_hw_ctx[] map[] and
> mq_map[].

Doing some targeted testing, the cycles wasted on the double indirect
are reclaimed with this. I've applied both for 5.1, thanks.

-- 
Jens Axboe

