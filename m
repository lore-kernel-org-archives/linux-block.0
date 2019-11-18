Return-Path: <SRS0=eqh8=ZK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E421EC432C0
	for <linux-block@archiver.kernel.org>; Mon, 18 Nov 2019 15:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7492195D
	for <linux-block@archiver.kernel.org>; Mon, 18 Nov 2019 15:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JaQ3lkdx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfKRPlS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Nov 2019 10:41:18 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:45861 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfKRPlS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Nov 2019 10:41:18 -0500
Received: by mail-io1-f66.google.com with SMTP id v17so8113374iol.12
        for <linux-block@vger.kernel.org>; Mon, 18 Nov 2019 07:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LDK9yK9BoIJXiRshGH8S+ARb//vvA/0NHK9tQB/EqPk=;
        b=JaQ3lkdxJbg8bC1c3jS+KwvIPC4OYHwwfxOOr83yS4U4QDzFNnWNlZ/p8PuJ96np2E
         fSAKxEDc8Nlw46j0x8sDTkmy8rEIthr/WFem2d8bAl0iNj18msLAPp9+Qqw8SvjrYFOj
         3EJP2rizmnWjpUQ81QDQLHav2Tp5HVA4u81MwCU4l9mmA08xnqINakg2qQ0Qqif/jPDU
         cj76eJwfOZnRj3nWeBGiV/PEuiL0fSFQfPs36u/4sn+YKAJg5MIM0MMYKTeugndAPPka
         ajIMC8PlwEyo22uO2Ji9NNlBpygJnk5UjX4ca26Yx50OfsMWk84dbtjiEcKRS6BQEBNE
         yt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LDK9yK9BoIJXiRshGH8S+ARb//vvA/0NHK9tQB/EqPk=;
        b=D5Nn3kVBSURgsrcK0kHaKBxRCjBxmRl9ogQXdVovOXDW96i2Hfpg9xm+DWbgCrt+Be
         nfBN8hw9wdsWvBGkGY6DDjCsTKVWRtdKBT6s0UNQNXCoSGQsed90xEGkAHcndXQLKGRg
         7dQIJOuuICOZORLl8NiA9XrIAaJPRW7vv7AdUsoGRPuKT6Aqd0/es/NMVZjoI10LkOVt
         /1rzt6FHuExh4E16Mp3meyXWXHbIEcVcIb76CUj9X6NUz7ViggDRQJMwFZwE3Qc4xjja
         g6Ycwvg8H7O8hKa8gt5C1nIlnlEn5URDwYpywb8xOZrcEqTcfwYA71bUUDKv4uq+iJ92
         1UHg==
X-Gm-Message-State: APjAAAXoBz4Dcm+qez6DAd4ZePNZiS4Tj85+zbrN4gqACFIM7ww6IaPr
        WMH82quN6/HMQxJbbAVHrjLcDg==
X-Google-Smtp-Source: APXvYqwof3l/MsVfP7ktJ3h+n1HCG5pvVXBQdOFvhVIS26ekBuLo1YKhPDa/JlQ2jH5waDFiOTh3+Q==
X-Received: by 2002:a6b:c0c7:: with SMTP id q190mr9712406iof.256.1574091676102;
        Mon, 18 Nov 2019 07:41:16 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u6sm4612045ilm.22.2019.11.18.07.41.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 07:41:15 -0800 (PST)
Subject: Re: [PATCH block/for-next] blk-cgroup: cgroup_rstat_updated()
 shouldn't be called on cgroup1
To:     Tejun Heo <tj@kernel.org>
Cc:     Faiz Abbas <faiz_abbas@ti.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        lizefan@huawei.com, hannes@cmpxchg.org, kernel-team@fb.com,
        Dan Schatzberg <dschatzberg@fb.com>, Daniel Xu <dlxu@fb.com>
References: <20191107191804.3735303-1-tj@kernel.org>
 <20191107191804.3735303-6-tj@kernel.org>
 <cd3ebcee-6819-a09b-aeba-de6817f32cde@ti.com>
 <20191113163501.GI4163745@devbig004.ftw2.facebook.com>
 <20191114223128.GM4163745@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <091022e8-e6a1-178d-80cd-b2a070d3519f@kernel.dk>
Date:   Mon, 18 Nov 2019 08:41:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191114223128.GM4163745@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/14/19 3:31 PM, Tejun Heo wrote:
> Currently, cgroup rstat is supported only on cgroup2 hierarchy and
> rstat functions shouldn't be called on cgroup1 cgroups.  While
> converting blk-cgroup core statistics to rstat, f73316482977
> ("blk-cgroup: reimplement basic IO stats using cgroup rstat")
> accidentally ended up calling cgroup_rstat_updated() on cgroup1
> cgroups causing crashes.
> 
> Longer term, we probably should add cgroup1 support to rstat but for
> now let's mask the call directly.

Applied, thanks.

-- 
Jens Axboe

