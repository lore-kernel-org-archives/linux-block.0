Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07863C432BE
	for <linux-block@archiver.kernel.org>; Tue, 31 Aug 2021 02:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D60C561027
	for <linux-block@archiver.kernel.org>; Tue, 31 Aug 2021 02:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239310AbhHaCHh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Aug 2021 22:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbhHaCHg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Aug 2021 22:07:36 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D5DC061575
        for <linux-block@vger.kernel.org>; Mon, 30 Aug 2021 19:06:40 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id a13so22720073iol.5
        for <linux-block@vger.kernel.org>; Mon, 30 Aug 2021 19:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1C2V9Pa9XhgvpVesZz7d3mIOHeGwV4EzhkmO3mbYVLE=;
        b=q8SS6Cvwl6FA5BxMpe/DsgszuKTvB5hGMjE/U/xQU5lS7GiKG7kP9pXGgE2bFZEZwe
         CmDDtjC8Yf8n0bRyGeN4Cns/b2jzpc4iZ8cEmL2jb3cE9r+Pa0ija0h8XbJkdfJKrmJf
         nNVgdvStVbumiM7aZRfMfhasdM4uV3o/fK92TC5Z6L2eh9HcdrhhWORtrSM29LZtnJOw
         w1es7UIPbGQRZCdFcivSSauIYAJ+39ydOR4tvVvQsR6ZeSz6tInN4qcY7XYuDG7aXUdm
         /elLdcnJsPqOQvhW4tJr45efXGPo1nvTv/yR+es1ydnLtzNf2FrduUkUrLra8DV8Rclh
         apBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1C2V9Pa9XhgvpVesZz7d3mIOHeGwV4EzhkmO3mbYVLE=;
        b=Y24pt9Uva0zEKw0VgKPFtp7oIG57h5JtbFpKSdbafU2KEuFMvkKS1tPG+bMTbNf0PD
         2JXxxZjS6unvRkKEpmi9JlEsf1+MKpupLQ27J7K/G+UGwdzaHqtrupmWs84Y7cBosnSC
         6OCFAb2Mu6lQQ+g6Nym6MgyEcnpcn7DDGuFuRXvj+QB02Fzh+eH0Xan+XIauo/k7U7zB
         JW47NUX/SFdcPbCFJNUOzYxetmWKyGPQtwNHcy6HIbk4AbfdbXLRRz60gW+dR2zdXgZu
         JuvZnVo23eyVnpbfmv+8a25RK6lhn4DvhViBhSwo+DDiF331d4SYrYudRKmJV8c9ot0f
         yS4A==
X-Gm-Message-State: AOAM533RXt/lml8QfZw/WAV1rHg/yjCxOerb2+UPVT7ODq6sRfEuvAVN
        IHZwMpC4VmMWoNbelYbUSzOdMtKJQN2lnQ==
X-Google-Smtp-Source: ABdhPJzQvdGclc4oqdcK/nX8GQv920+WU+IcKnK1ItDsn0DpVK6yOqcutG+EEJpt659VAc4OUivkNg==
X-Received: by 2002:a02:c055:: with SMTP id u21mr533828jam.113.1630375600079;
        Mon, 30 Aug 2021 19:06:40 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id l10sm9594632ilq.80.2021.08.30.19.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 19:06:39 -0700 (PDT)
Subject: Re: [GIT PULL] Block changes for 5.15-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <e1a3e2aa-ad96-c9c6-af38-16b7300a5612@kernel.dk>
 <CAHk-=whbPcDsJqKoW1HO_8c=FCUGhOifDR+tUpdt4bALAgtTJA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <90ecd1a6-c7e2-8899-15c4-57183380b63c@kernel.dk>
Date:   Mon, 30 Aug 2021 20:06:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whbPcDsJqKoW1HO_8c=FCUGhOifDR+tUpdt4bALAgtTJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/30/21 7:56 PM, Linus Torvalds wrote:
> On Mon, Aug 30, 2021 at 7:32 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> 2) drivers/block/virtio_blk.c - error handling fix later in the 5.14
>>    cycle ends up touching the same out path. My resolution:
>>
>>  -              goto out_cleanup_disk;
>> ++              goto err_cleanup_disk;
> ..
>>  -out_cleanup_disk:
>>  +err_cleanup_disk:
> 
> I did it the other way, and used "out_cleanup_disk" to match all the
> other "out_xyz" cases in that function..
> 
> That should obviously be equivalent, unless something strange is going on.

Yeah that's totally fine, and it's funny because that is how I did it
the other times too. When sending this out, not sure why it ended up
differently. I do think out_* is the right choice, matches the other
ones.

-- 
Jens Axboe

