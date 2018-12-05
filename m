Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E64C04EB8
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 02:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56AD320850
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 02:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fB+lNBqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56AD320850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbeLEC6u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 21:58:50 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39687 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeLEC6u (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 21:58:50 -0500
Received: by mail-pf1-f193.google.com with SMTP id c72so9241033pfc.6
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 18:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JOUY7c2Uvay4l5W0HFTSaetsFBVms6zdryQecubImNA=;
        b=fB+lNBqqQ/hb5g+9Nbc7C4RTlzt93A3AoESpCI47+IfshGedEtaLtAZlOL2VvM0Rp9
         oDfvmisw+Wd2tftkp0zC1iLqvfClXK1PKP15Y9+/bSKFukiyaqRXmbwl1BzK57DCENII
         zdlCZWEBDAcgqjmXziT0kbOnNH9LgO5dfkL2r7A36tnUb8Y2E/yE/L6gV6/Co7xejpiP
         NGy80WyilN/BpJxphHUr/in3Sh6QLBmP09HzDEqFJtA7UV6HtDeLfL4euiNh0usLhTti
         fCfAsljfn/dwmDdVpG6U41lhKgLOPyrGDZ7hEweL+qAvT8VwsuQ3NN+8I5JXdgDNhtZ5
         6Uaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JOUY7c2Uvay4l5W0HFTSaetsFBVms6zdryQecubImNA=;
        b=rU3BwQDjxFfWVLztjXcjwTAdaz/AeOUfSNelk7zJ5sQbKS5ru51ZPhB07zrVKM6GYH
         w4Mf485bkajFqBZd9YXYQKXz24lEZqA3vC2ZLjotfm8JMIEvy0DlH6Spi3YIb7dBxGx1
         TIR43ezdVHV+yiwJDerY+tICvh5CjZQfwV0mr3Fu3iwjkBpNAqkd7RTdoGLXEVR9vfRv
         Q4Kj6BRb/RrM3l1ukkdpdv/vHK8SyDuVy7ua/sPD8bhBEdxRzkoRXyQIkocRiJFS7Bvl
         A/E8PiapMuOcGSQoQ7M2kBD5o60o/Hg4WhXOI+J9pnLYbDU2IOYqSWxc3FbWWlSAP+lW
         UKqA==
X-Gm-Message-State: AA+aEWazxg27xQBEkrCLghNCzkUMTesoNEl99vbA5eWt9elyY+/lk593
        zMO4AB1WKIyT+EEbRklk4Mv4mA==
X-Google-Smtp-Source: AFSGD/VAEyeKyZGWnIA7ksjgOwq9LKXPRt9zpX32Ujjl/iylu8HTrO9MxGHyJ4qTUg6fZMyeC6kjuQ==
X-Received: by 2002:aa7:8354:: with SMTP id z20mr22318844pfm.81.1543978729706;
        Tue, 04 Dec 2018 18:58:49 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id o13sm27533895pfk.57.2018.12.04.18.58.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 18:58:48 -0800 (PST)
Subject: Re: [PATCH V8 0/3] blk-mq: refactor code of issue request directly
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1542251558-10517-1-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <88fe68c6-886c-1328-009a-9c7c5fa4ebc9@kernel.dk>
Date:   Tue, 4 Dec 2018 19:58:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542251558-10517-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/14/18 8:12 PM, Jianchao Wang wrote:
> Hi Jens
> 
> Please consider this patchset for 4.21.
> It refactors the code of issue request directly to unify the interface
> and make the code clearer and more readable.
> 
> The 1st patch refactors the code of issue request directly to unify the
> helper interface which could handle all the cases.
> 
> The 2nd patch make blk_mq_sched_insert_requests issue requests directly
> with 'bypass' false, then it needn't to handle the non-issued requests
> any more.
> 
> The 3rd patch replace and kill the blk_mq_request_issue_directly.

I'd love to get this queued up, the direct dispatch path is a mess and
it's even now been known to cause corruptions... I'm going to queue
up the direct dispatch fix shortly, and apply it to for-4.21/block
as well. Any chance you can respin this on top after that?

-- 
Jens Axboe

