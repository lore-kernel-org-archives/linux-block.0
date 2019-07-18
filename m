Return-Path: <SRS0=jAbK=VP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD91C76195
	for <linux-block@archiver.kernel.org>; Thu, 18 Jul 2019 16:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A3721850
	for <linux-block@archiver.kernel.org>; Thu, 18 Jul 2019 16:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xLNwdMMX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbfGRQUd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jul 2019 12:20:33 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39578 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbfGRQUd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jul 2019 12:20:33 -0400
Received: by mail-io1-f68.google.com with SMTP id f4so52369242ioh.6
        for <linux-block@vger.kernel.org>; Thu, 18 Jul 2019 09:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=nYyVXK1tFqn45cTOPH3AaTYLY1zCX9f4fL5CiQ2kw4Y=;
        b=xLNwdMMXVvWHtGO6xk1rdRNn7SGE5OLsplPS7IkQqsjdk6lWYZIA1o1FfVdOsKjB2/
         Q/LVXmUTAvd5EMjJb0KxqS62R3RsQRCFgS0OIWAMs8ednosZfVN7R8EkN5PEVpjBRprj
         yfwVQJk3t5Aagfw0iV7VijugXQFc+46oo2Chc/oTfUe822FAt0Ga8HW/0TRNmhl6/IEG
         m21/vKai7FHXdRRHjjUgR0u0maC9CGmL2HeP/l9s9PtyNjp6Vs+Fz8twOpG6SbxOmyoK
         3dZlYWdAx96Xe21Oorfvz+x6AA6URbxqeZV7RRSkYkZA0zmjncgIuU3dqRpxDvWef9qB
         5Ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nYyVXK1tFqn45cTOPH3AaTYLY1zCX9f4fL5CiQ2kw4Y=;
        b=ALZi41OIZv1BfWeewQ1fiOoQoUK0yhkkpumwEmxZSNoVOGEKUTcYlr8XsdCbP7iquF
         yVCxN4NREcuWHgmfV2vDh4RSRto6gZvg6j/74PiZEegbjv802B/+x2hqOFVxSIPxuTVs
         n8Nr/i0qbhLdwA7nmbE69jCqy6O2UDYb27RVyR1gziDl4Y0rl3o2EOTFYAR//GiJoQOe
         wjrzgHnUlAjl4OEmf6Om5o0mdmxbEC6Au7nBJ/QP/qxlicgAP23MklJauNEibMEUIzSU
         N/t7at0DD+hQZUbbH57oVl4qUI8k15EFpesAjq1rM14IelGb3Zaa/4RS2qxvFNsExWxA
         loyA==
X-Gm-Message-State: APjAAAUD1+nHQXyHuIVBlfxzxc3A3M2UAcv4yK7CdATzFtrVM93E5xhd
        bS6cV44ywI7PGxgyOEQjyWE=
X-Google-Smtp-Source: APXvYqxcmIyavTpclCVeZJRsZo8dwLRFMGW3X0ruvk8Xi614v8B2Bkf87aKStF8JxSw8V5zYpE3S6w==
X-Received: by 2002:a02:c549:: with SMTP id g9mr47860204jaj.14.1563466832941;
        Thu, 18 Jul 2019 09:20:32 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h8sm27408179ioq.61.2019.07.18.09.20.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 09:20:32 -0700 (PDT)
Subject: Re: [PATCH 0/5][v3] rq-qos memory barrier shenanigans
To:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, peterz@infradead.org, oleg@redhat.com
References: <20190716201929.79142-1-josef@toxicpanda.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <21b307fa-ecf7-51d7-938f-75aed125b742@kernel.dk>
Date:   Thu, 18 Jul 2019 10:20:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190716201929.79142-1-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/16/19 2:19 PM, Josef Bacik wrote:
> This is the patch series to address the hang we saw in production because of
> missed wakeups, and the other issues that Oleg noticed while reviewing the code.
> 
> v2->v3:
> - apparently I don't understand what READ/WRITE_ONCE does
> - set ourselves to TASK_UNINTERRUPTIBLE on wakeup just in case
> - add a comment about why we don't need a mb for the first data.token check
>    which I'm sure Oleg will tell me is wrong and I'll have to send a v4
> 
> v1->v2:
> - rename wq_has_multiple_sleepers to wq_has_single_sleeper
> - fix the check for has_sleepers in the missed wake-ups patch
> - fix the barrier issues around got_token that Oleg noticed
> - dropped the has_sleepers reset that Oleg noticed we didn't need

Thanks Josef, applied for 5.3.

-- 
Jens Axboe

