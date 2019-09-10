Return-Path: <SRS0=q0Gp=XF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DA2C49ED7
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 18:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09065206A1
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 18:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="eFEJ0DHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfIJScI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Sep 2019 14:32:08 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36037 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfIJScI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Sep 2019 14:32:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id f19so8983208plr.3
        for <linux-block@vger.kernel.org>; Tue, 10 Sep 2019 11:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gmihbRTTguhKuF5poqPrKOZtRuKZ2B/FVhu85kYPomo=;
        b=eFEJ0DHdQ+gOjr08che3M4Ms36pQZ/j0IezL7oi03HQnX2YjfG1S+nNKpcLRqLGWtQ
         PPxCQw+rHkJOyVpzA+WrbkIWHKwEQwYWJoThRT+YJ+Z3FLxkwzRk/gUSR4mBaYxPs/A3
         ZHHHb/+KW51o1rmGeub/erimGc9yzYv0SnByD5rdzoyIJ7PwZNxKm4n1vCbrVDwpCWvS
         sAbC06jkTUKjyfwSL8GcQMX4lTVlRzbXbCyowRdrk/eNaJMSv2bHcL8+UjIkLfgVeR0a
         eK1lxBcNMUCi4/G5rr+vfxQG/ioz4oWUm9RgMCHhKh1G9K44i828u1woNK4lOf65DSik
         a8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gmihbRTTguhKuF5poqPrKOZtRuKZ2B/FVhu85kYPomo=;
        b=g4kpzYa+NfQjay/HgDNW/QP7+hgwg9NuAzm7kJBfsZto5RErQX8WTQYhP8C//rsiv5
         96nBNu8FwBWdh4PpKsAp4VNFe6TXz3zE0Yc5Cq2syjwH5s6Ra6QNDRDXoASP+JaI5wM5
         eenPCQUC4B/GL1mLBbQL10RFTVINgi25bch9p5GG9i1sQ0fjw0WwZIC4+sZ4aD+PG4+i
         w1anhc32JRpGXbsbUWkQt+gjfXRCSHg9ilCG+rwV2eNt1wsV1rn2Sc1LyGVKJkFdh/qa
         MokfRyxbqpsXn+36siucZ605PjrXCW9mntUA3g3/iqklQj+m94xU31sFn0FcVoHl6R2a
         ZbOA==
X-Gm-Message-State: APjAAAXwo68ztpqau4CBZAWZQokCmJKc8gHA3Puolv0kjJWd/dxLBS0x
        /2xYN5RSJvX0rLd8f9O4hSJDpZzoILjOug==
X-Google-Smtp-Source: APXvYqxUyL7Z6oVqM2K/cpBXdQ5XU4zczgojdiiYF8PPrDacQNODuEfl8nlxlhZ7o1pEL7sF4f2lww==
X-Received: by 2002:a17:902:b086:: with SMTP id p6mr32047305plr.315.1568140326506;
        Tue, 10 Sep 2019 11:32:06 -0700 (PDT)
Received: from ?IPv6:2600:380:b456:5481:2ce0:140c:7117:4b2a? ([2600:380:b456:5481:2ce0:140c:7117:4b2a])
        by smtp.gmail.com with ESMTPSA id b20sm22735360pff.158.2019.09.10.11.32.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 11:32:05 -0700 (PDT)
Subject: Re: [PATCHSET block/for-next] blk-iocost: Implement absolute debt
 handling
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@vger.kernel.org, cgroups@vger.kernel.org,
        newella@fb.com
References: <20190904194556.2984857-1-tj@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1d8b7394-09bc-63ef-5bb7-de0f2ff2c75a@kernel.dk>
Date:   Tue, 10 Sep 2019 12:32:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904194556.2984857-1-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/4/19 1:45 PM, Tejun Heo wrote:
> Currently, when a given cgroup doesn't have enough budget, a forced or
> merged bio will advance the cgroup's vtime by the cost calculated
> according to the hierarchical weight at the time of issue.  Once vtime
> is advanced, how the cgroup's weight changes doesn't matter.  It has
> to wait until global vtime catches up with the cgroup's.
> 
> This means that the cost is calculated based on the hweight at the
> time of issuing but may later be paid at the wrong hweight.  This, for
> example, can lead to a scenario like the following.
> 
> 1. A cgroup with a very low hweight runs out of budget.
> 
> 2. A storm of swap-out happens on it.  All of them are scaled
>     according to the current low hweight and charged to vtime pushing
>     it to a far future.
> 
> 3. All other cgroups go idle and now the above cgroup has access to
>     the whole device.  However, because vtime is already wound using
>     the past low hweight, what its current hweight is doesn't matter
>     until global vtime catches up to the local vtime.
> 
> 4. As a result, either vrate gets ramped up extremely or the IOs stall
>     while the underlying device is idle.
> 
> This patchset fixes the behavior by accounting the cost of forced or
> merged bios in absolute vtime rather than cgroup-relative.  This
> allows the cgroup to pay back the debt with whatever actual budget it
> has each period removing the hweight discrepancy.
> 
> Note that !forced bios' costs are already accounted in absolute vtime.
> This patchset puts forced charges on the same ground.
> 
> This patchset contains the following five patches and is on top of the
> current linux-block.git for-next 35e7ae82f62b ("Merge branch
> 'for-5.4/block' into for-next").
> 
>   0001-blk-iocost-Account-force-charged-overage-in-absolute.patch
>   0002-blk-iocost-Don-t-let-merges-push-vtime-into-the-futu.patch
>   0003-iocost_monitor-Always-use-strings-for-json-values.patch
>   0004-iocost_monitor-Report-more-info-with-higher-accuracy.patch
>   0005-iocost_monitor-Report-debt.patch
> 
> 0001-0002 implement absolute debt handling.  0003-0005 improve the
> monitoring script and add debt reporting.

Applied, thanks.

-- 
Jens Axboe

