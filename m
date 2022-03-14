Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B680CC433EF
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 20:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244035AbiCNUNx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 16:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242151AbiCNUNs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 16:13:48 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A5913D18
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 13:12:36 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id q11so19725652iod.6
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 13:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HiYc4ISa7ZL1yQ+Rprgv5l+81jHlR8ggXb5sTSpYTmk=;
        b=mXgTNrB2fjuxlsby2WcGurcaFfuY6HXm0jHcu5KQj8KAQf3RqW9AyLf0pIxstHhQMO
         vxYp8vBdzXaOBb3mRysuyYaHij6acTnxkoIlYzmv5astoPfmRwBS27PX+sJzr+KKY0iT
         bUtUdfllMexdzkraKlakhKI+sR3RdRRbjVYWnsNHZcM0IR/7vxGm7wLpbTO5Ic26gnZB
         oBzrIqg/jZC01y/6acsj5ABd1eFuCJy1TjpZq7js7QA80uq/ZyKLOJGKPpEy0Fgah/tk
         LwEV1Ojfe7+nH/5IqRycTd0ufJqVV7E4YKJFujc4JcJd1vlLZzMNFEHLGFacpO38dnf2
         xOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HiYc4ISa7ZL1yQ+Rprgv5l+81jHlR8ggXb5sTSpYTmk=;
        b=ELS1Ss95UDJtloeBWB+HOhj0T8Cxl2FpM/2fFOn0ECPXyAEpH0xYq3p1QAMjz2gxlE
         NJAID++INRuTVQumuMiOldz8EffeIIY+TKmTTctSDE/MTTJ0s06e3l16VuE2bdlcaTyz
         SXIMYQfXGjne5aPmsULbS+9N8JwatLP/yJRzmAjHKXGqgyQgOMYgeAAdZVZ8CAD4wDEr
         Qz7YQORecU+R7cUcbB93wcf1vWYjaVSt16pJPZaSBQxlwBjaY7WVxBEvuNwDy+IruYPE
         032Fx1wWAibrhRxz6fdKzUmuMbRWbIGmuna8qLkYVtbR7a8btrsoEUm7QbWRCgd6qlD+
         VWIw==
X-Gm-Message-State: AOAM53184dAvaJapF6lVfvnfA2b6LpBZhOvjBKvIyBXgFEnjTXvFxP9/
        U3EZSMdPoiEa/OndgOnorBKOfQ==
X-Google-Smtp-Source: ABdhPJxJl1MVkXMb2rpNqw6zI0l/rJUr44Z5K6FcwIGuPygsvlewem52rucTA1a9l/810O1YUbtH/g==
X-Received: by 2002:a05:6638:2402:b0:317:b520:62ba with SMTP id z2-20020a056638240200b00317b52062bamr21595707jat.238.1647288755890;
        Mon, 14 Mar 2022 13:12:35 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a4-20020a056e02120400b002c638c50efesm9537559ilq.68.2022.03.14.13.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 13:12:35 -0700 (PDT)
Message-ID: <107965ce-a29a-b5f4-ef87-63b753380891@kernel.dk>
Date:   Mon, 14 Mar 2022 14:12:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH block-5.17] block: don't merge across cgroup boundaries if
 iocost or iolatency is active
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, kernel-team@fb.com,
        linxu-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <Yi71WZ3O9/YViHSb@slm.duckdns.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yi71WZ3O9/YViHSb@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/14/22 1:57 AM, Tejun Heo wrote:
> blk-iocost and iolatency are cgroup aware rq-qos policies but, unlike
> elevators, they didn't have a way to disable merges across different
> cgroups. This obviously can lead to accounting and control errors but more
> importantly to priority inversions - e.g. an IO which belongs to a higher
> priority cgroup or IO class may end up getting throttled incorrectly because
> it gets merged to an IO issued from a low priority cgroup.
> 
> Fix it by adding blk_cgroup_mergeable() which is called from merge paths to
> test whether merges are acceptable from cgroup POV. When iocost or iolatency
> is active, this rejects cross-cgroup and cross-issue_as_root merges.
> 
> While at it,
> 
> * Add WARN_ON_ONCE() on blkg mismatch in ioc_rqos_merge() so that we can
>   easily notice similar failures in the future.
> 
> * Make sure iocost enable/disable transitions only happen when iocost is
>   actually enabled / disabled.

Is there really no better way to do this than add a lot of expensive
checks to the fast path?

Even just inverting the checks so that

if (req->bio->bi_blkg != bio->bi_blkg)
	...

is checked first would seem a lot saner.

In any case, since this isn't a new regression, I'd feel a lot better
deferring it to 5.18.

-- 
Jens Axboe

