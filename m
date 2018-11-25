Return-Path: <SRS0=TDIO=OE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DACC43441
	for <linux-block@archiver.kernel.org>; Sun, 25 Nov 2018 10:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6596720865
	for <linux-block@archiver.kernel.org>; Sun, 25 Nov 2018 10:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6596720865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbeKYVmz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Nov 2018 16:42:55 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42832 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeKYVmz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Nov 2018 16:42:55 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so5174985pfr.9
        for <linux-block@vger.kernel.org>; Sun, 25 Nov 2018 02:52:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nHeLub39B153SSc75dm5J9D2DURO02btL/Rb4/HGZQg=;
        b=XpfHQ9v2H3j6E6B23vxAeiDr+chMq/tr6Sa/ihtCahg8hKuwj1z/bOML0ysO18m6sj
         y1HpR+/3f9MiWCRtvWYrrka94VzYjG1RJy+hqik5WxFz/AK0HjVSAjUBiI6hdn1dLf5i
         kwMJj+HY/Q6ozOEPtSCZ/bk3sHxvc/FGI3f4F+gVbqn/8C1js+n7VSGhXQOMiEtZAN52
         t5tSKIbo+uw2uZ7bUHDlXNi8rphEt2jPa01QDoTpDilmBtuq5/C3o0X+xZB7r5NhmL8o
         N0wyl3gE0A1J5+FGYq43N12kTA11gvPqz+GEgQ5acjFHuOwvBEJoYSs48ghDAtrIpspz
         4Phg==
X-Gm-Message-State: AA+aEWaJXwUW2FbiNQibam+f6KPfXGCfj3Ve1WlEb9ZELvOoYDRCCGHS
        eez4pI6zvm2x0y+BF8ERzJc=
X-Google-Smtp-Source: AFSGD/VrsHgpiWZNzr2Gu+vTXAbq74Bfb7+gx/OVyjD4CPHgmBlo0lcHN9uAlU+Pg9Zg0oeBOpLyhw==
X-Received: by 2002:a63:4613:: with SMTP id t19-v6mr20883385pga.197.1543143126527;
        Sun, 25 Nov 2018 02:52:06 -0800 (PST)
Received: from [172.20.8.115] ([207.8.179.17])
        by smtp.gmail.com with ESMTPSA id m129-v6sm70172308pfm.78.2018.11.25.02.52.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 02:52:05 -0800 (PST)
Subject: Re: [PATCH 2/7] block: have ->poll_fn() return number of entries
 polled
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20181117214354.822-1-axboe@kernel.dk>
 <20181117214354.822-3-axboe@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <fb1200ad-35ef-1c2e-25cf-d8a71bc505b5@grimberg.me>
Date:   Sun, 25 Nov 2018 02:52:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181117214354.822-3-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> We currently only really support sync poll, ie poll with 1
> IO in flight. This prepares us for supporting async poll.

Hey Jens,

So are we sure that this is fine to simply replace the
poll functionality? you say that that we support poll
with only 1 I/O inflight but is it entirely true?
semantically speaking?

The interface is selective polling, which means that
the user can have more than a single I/O inflight but wants
to poll for a specific one that it really cares about.

Would this introduce a regression for users that rely
on preadv2 to basically "complete *this* IO as fast as possible"?

Note that I like the proposed direction, I'm merely questioning
if it is OK to simply change how selective polling worked until
today instead of introducing a separate blk_poll_all(q) (but with
a better name) which would be wired up to aio polling and friends.
