Return-Path: <SRS0=UGhi=5B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E28EC0044D
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 15:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077EA20783
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 15:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OK0QZP+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbgCPPIM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:08:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:47047 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731688AbgCPPIM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Mar 2020 11:08:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id r3so91497pls.13
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2020 08:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SueAxX5eGkVwaiqNpop9oq5H6n/zweDvWrtavlfgylY=;
        b=OK0QZP+iaxu4V61Q+ur02KwyU6iEqC36paQ8AvV6u8bQ5aiakL8fpQeZym9hJ+TxEG
         yF2h9LjKGAtvRG4XmZtFKVGsxprDgxXFcb/fq3SL1bfTPtfbhAvwSe066pLBWvJ97MkI
         Orh2ySIDEQcvdIcbk5bx8E74isNPevMyu3RUMnyayyHH1rxnF8h4AUdGMjW4MpwNTD5y
         0F6qieajinziIRvT+08kjw0mnH79Sk4YiWcvR+ZUd5Rs7KUj/Ezjhyn5KGe+z31wPGjM
         SAL2OvCGdtMxn7ssOqCFsFelS7l2mNAKlAJ8m5dntO2LOfLWucMbVdJ9eFJdisfa1mTx
         ClVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SueAxX5eGkVwaiqNpop9oq5H6n/zweDvWrtavlfgylY=;
        b=jRvXXsfDYIcmn97sylw/1+RsYIE9EwGwxFmNeCsJgM7BCfx4v6Fzp910RLGTeGLJcl
         X/LWsXgkMuIgxRA+gva6B3yfPWDnKx5dvVFYp1ny7qodtFhSS3WQCEkyIgmy0Fe83C+F
         pzYFBGzR5oO7QAZsF5y/5uek1ySjRmw8TrJm/gayzNCJ/jeHlc8hvKd5zabE/x50vOif
         8T8qyBq7a6zFBFxh54p1gPx3pjaGXmkLPbeErObZB9zTOe66TI0VqQEhLHclKa696hBV
         cy+O5L+ZOBLzfabMoxUUjAOn0RYSvEkferztQ6bge7jm10uUb1HvnpKS3wjcdCEIyEfS
         W+FA==
X-Gm-Message-State: ANhLgQ1Wnmvtuqy4oqxaGNZ0tqlDTYGOPfi8hqGMw5uB9Ni5uYDkj/mm
        d+97mY2Z0zCisBzW1hp/JnFb+w==
X-Google-Smtp-Source: ADFU+vtG3XzehIqqMBGu/eDH7NBJ2L35kdPeTQgmGBiEeCXw8j9V44Fw4/LJnEx/j/HnLSnNs5lJSw==
X-Received: by 2002:a17:902:421:: with SMTP id 30mr5034500ple.271.1584371289283;
        Mon, 16 Mar 2020 08:08:09 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id a18sm238701pfr.109.2020.03.16.08.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2020 08:08:08 -0700 (PDT)
Subject: Re: [GIT PULL] Floppy cleanups for next
To:     efremov@linux.com
Cc:     linux-block <linux-block@vger.kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>
References: <57ce0ee0-839c-a889-0bc0-ec46985e76d3@linux.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6f4fd061-a47e-7de5-df6e-c3002beedee0@kernel.dk>
Date:   Mon, 16 Mar 2020 09:08:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <57ce0ee0-839c-a889-0bc0-ec46985e76d3@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/16/20 4:47 AM, Denis Efremov wrote:
> Hi Jens,
> 
> The following changes since commit 5d50c8f405bf91d9d9a48628fde0f2f4ff069d7b:
> 
>   Merge branch 'for-5.7/io_uring' into for-next (2020-03-14 17:20:45 -0600)
> 
> are available in the Git repository at:
> 
>   https://github.com/evdenis/linux-floppy tags/floppy-for-5.7
> 
> Please pull
> 
> ----------------------------------------------------------------
> Floppy patches for 5.7
> 
> Cleanups from Willy Tarreau:
>   - expansion of macros referencing global or local variables with
>     equivalent code
>   - removal of incomplete support for second FDC from ARM code
>   - renaming the "fdc" global variable to "current_fdc" to differ
>     between global and local context
> 
> Changes were compile tested on arm, x86 arches. Changes introduce
> no binary difference on x86 arch (before and after the patches).
> On arm, incomplete support for second FDC removed. This set of
> patches with commit 2e90ca68 ("floppy: check FDC index for errors
> before assigning it") was tested with syzkaller and simple
> write/read/format tests for no new issues.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>

Thanks - I hand applied the series, my for-next branch isn't really
stable, only the parent branches are.

-- 
Jens Axboe

