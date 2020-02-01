Return-Path: <SRS0=B3LW=3V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A459C33CB3
	for <linux-block@archiver.kernel.org>; Sat,  1 Feb 2020 14:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C558B2051A
	for <linux-block@archiver.kernel.org>; Sat,  1 Feb 2020 14:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nttcNARI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgBAO6Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Feb 2020 09:58:16 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45093 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgBAO6Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Feb 2020 09:58:16 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so5010812pfg.12
        for <linux-block@vger.kernel.org>; Sat, 01 Feb 2020 06:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V+84GWr3lNxKTeqdrIO3Ly1rWoYrT/g923krQ6rxDLw=;
        b=nttcNARINoiVnToJQunZTfaUhhCBA/lUHMZKSsL/PkfJQDSSmbsIzYDmu7Jy0+zWZS
         Bib1xY7D1kZwY5XL/ggpmVqhw10/GXgDwV/LhiKMcvRT8n99ISMJSX6PP0Bc+4Mz9ArH
         DjCQ/FjvH+aJXKjKOpKMmgjYKT2Abq/rrLrSXCUxT/MoytsQhT/mlocpypg7i5b7F22V
         4mmWS9tBntu8EMIzywFqr6P1UiOK4MayR8mXM2aCRRykVQh58zHoXPQCnERgLLbJAzYt
         ctIpXqASP4qjy8u0N1CgV6TYPlwvcBCcdpsufRu1QoXrps4DZu+uoGevjeyglWDwkvCV
         F0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V+84GWr3lNxKTeqdrIO3Ly1rWoYrT/g923krQ6rxDLw=;
        b=MCJtXqS+NOqDdYG6h6BYfJM5E1EGpAyICHoKvOPQt4SuOhvBaYY4gk2Nx6xADM323d
         zoh8L8BnGGbmF2iGp7pRilpTHzTfo9TfbagpjfqzbFFxDlWnWn0Ah0DczU8mZDcYZOJW
         Gf4W868ovV5zMTjcQoXZ6c5DOpD3Hmm1C3uXXMTyAnZcDNCM801KfyVUnNQjswwXITak
         zxh8T8YpvkF9xa1v1YzxUFlM/VTnykqIXQ3hfXz0/9avle7JzDd07CcUanGhBo2AyTLg
         bmdgg32dM8HWcKixCZ97RbhAM9JI2A4MRFRtIGIsbiV81briAuVogbYW2jg/VLnVu1Wm
         PxKQ==
X-Gm-Message-State: APjAAAXZCI9VStsFW8EHSr9Mv6Qt2xevXxtAcmtxjWz4i7qNlg4NpN+p
        4WwnY/p1T+XTgKfJskvBvYJJqBikybo=
X-Google-Smtp-Source: APXvYqy+LLvTgvNXz+iQuaKSqdszQer18XNv+HwNu+J3eA4SeYPHlNcmFIxZUipJFZqyTHWyJG79CQ==
X-Received: by 2002:a63:ce55:: with SMTP id r21mr15390338pgi.156.1580569093462;
        Sat, 01 Feb 2020 06:58:13 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id r3sm14648747pfg.145.2020.02.01.06.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2020 06:58:13 -0800 (PST)
Subject: Re: [PATCH 0/5] bcache patches for Linux v5.6-rc1
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20200201144235.94110-1-colyli@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fee4f649-eb8a-e7af-70d6-ad75e9a4c8bc@kernel.dk>
Date:   Sat, 1 Feb 2020 07:58:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200201144235.94110-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/1/20 7:42 AM, Coly Li wrote:
> Hi Jens,
> 
> Here are the bcache patches for Linux v5.6-rc1. All the patches are
> tested and survived my I/O pressure tests for 24+ hours intotal.
> 
> Please take them. Thank you in advance.

Applied for 5.6, thanks.

-- 
Jens Axboe

