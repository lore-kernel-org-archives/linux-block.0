Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8598EC4743D
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 21:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6669961364
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 21:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbhFHVKE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 17:10:04 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:40842 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbhFHVKE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jun 2021 17:10:04 -0400
Received: by mail-pf1-f171.google.com with SMTP id q25so16701523pfh.7
        for <linux-block@vger.kernel.org>; Tue, 08 Jun 2021 14:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MGLCdeBLiTe2f4V4JEmoMnndE97yDmCfVG4Iupoew3g=;
        b=Lcy0tVg50qiIXFLitPVl7wFqCgojIT3/y16tRAlET+JCs6q4bYgceWNDzEdqV9KgW6
         ZHGtAz329S9MYTMjBYenEev8FR6ivu6g2q/+Mqd6EOaJxN0IMlGd2TO+mbnEEX1iUnc1
         eHAm5IMwQz+eh9WsZmj861E4mYsIO7Qhn5PrO3DRMKlcWxGPFzPujef+K1PMIPo9tRon
         m6/k0euiSDYpDE210TP5gPBhLkAwr7sP/5b/LdhSVfPtJAdqo9fuQ3mSZANZaCijtFv5
         aoPRinn5JroIRjhrHbACMdGltgN0yDdEKPEwpfLop3zLjKpIKb9X3eGdH6P5USCu7fOI
         5V/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MGLCdeBLiTe2f4V4JEmoMnndE97yDmCfVG4Iupoew3g=;
        b=uWpqHctQSwnR6y/59C2LTDYNH+U8mnVIx/Dxg168iB7jnGIkNVvGo0kwgtsfHjPLch
         0wemCc3hFw7H+sQxgWhev7w21vTHb5Z0SPumnIyNFF7AZ3Djyv205cm9pPuAgXvaOwZQ
         OFZIOhG6EQzR7WZiPQJJxeZq6LKk+IrXHu9BdrsNYL1AwES4e87jppLl0z8t2sy9ZQPo
         e73/ia2/jIkG9syP6iov+QQCZG5a1oa8wpvhJ+IRlQbv9qmhzKgeKAn6LVYo0iBcnPQ1
         nMK1awb45OU2mdC2PH2xWoHF0Co4EwOdPOAYDlb3YrQ5wapDfAoMHUR9QQKDt8rAUsnx
         8ufw==
X-Gm-Message-State: AOAM5329ncaoO76nLWcy4k18mXFGbtiU1yW8b3QScSW0p5qd6jLMRMXP
        CMgs+qwk1i2dW5epbx3q8x4taw==
X-Google-Smtp-Source: ABdhPJyPUM9RmrARRoAMIYu+eAF/uIHsBtMmhfg9qdBeQ0TOpf+UNFscT7GvhJKO0ez+MF086oMoxQ==
X-Received: by 2002:aa7:8119:0:b029:2b5:7e51:274b with SMTP id b25-20020aa781190000b02902b57e51274bmr1666573pfi.32.1623186417402;
        Tue, 08 Jun 2021 14:06:57 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id mi10sm2974329pjb.10.2021.06.08.14.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 14:06:56 -0700 (PDT)
Subject: Re: [Patch v3] block: return the correct bvec when checking for gaps
To:     longli@linuxonhyperv.com, linux-block@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Ming Lei <ming.lei@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <1623094445-22332-1-git-send-email-longli@linuxonhyperv.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6691cb0d-d368-7115-87f2-ae5950699b7d@kernel.dk>
Date:   Tue, 8 Jun 2021 15:07:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1623094445-22332-1-git-send-email-longli@linuxonhyperv.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/7/21 1:34 PM, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> After commit 07173c3ec276 ("block: enable multipage bvecs"), a bvec can
> have multiple pages. But bio_will_gap() still assumes one page bvec while
> checking for merging. If the pages in the bvec go across the
> seg_boundary_mask, this check for merging can potentially succeed if only
> the 1st page is tested, and can fail if all the pages are tested.
> 
> Later, when SCSI builds the SG list the same check for merging is done in
> __blk_segment_map_sg_merge() with all the pages in the bvec tested. This
> time the check may fail if the pages in bvec go across the
> seg_boundary_mask (but tested okay in bio_will_gap() earlier, so those
> BIOs were merged). If this check fails, we end up with a broken SG list
> for drivers assuming the SG list not having offsets in intermediate pages.
> This results in incorrect pages written to the disk.
> 
> Fix this by returning the multi-page bvec when testing gaps for merging.

Applied, thanks.

-- 
Jens Axboe

