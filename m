Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD3CC433B4
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 12:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D3C161289
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 12:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhDZMzT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 08:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhDZMzS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 08:55:18 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBF6C061574
        for <linux-block@vger.kernel.org>; Mon, 26 Apr 2021 05:54:36 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id b17so2964585pgh.7
        for <linux-block@vger.kernel.org>; Mon, 26 Apr 2021 05:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6USX4quXzkT9/UzC7f99Y0oOIPZG1f5NLEYb63HY874=;
        b=KjzXYJlzOk1ORfRY3ykMOJXDm+Mq8Pc/dlQwWClg8ENoCUXeVcXbCHONj+VSmgSd4a
         wWHUbZ/ji9CUGWA8ExWq5djFty8c7cH3Zvh/Kgcgx3TzXDohoZ39Iyg0NcDcSJwqLyGm
         wOee7dNNoMfwTbZqRv6vC9ru9TqI7oouKN91EGgqk7cNmIepUzUepgatKdpFjzdlgFyE
         m6pl25vZ1wo04tCLotxCg+lRdHqhNb5X4ztENpNQUYxyo20jprT6NKrWL5Y7dlWxeodd
         JPlpEosCZXbXIxJ+KAR+2hM2WGRlDDiRCLfZTAR/qmTpbsmBzNb7e/vvKnJKhE63JHSx
         zxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6USX4quXzkT9/UzC7f99Y0oOIPZG1f5NLEYb63HY874=;
        b=Lt/fmD+ifhIY75mc+GUpqiEe03dOhXIzAG8/+iMVc+6k12XPYEasFBDqAqW5/CyZx2
         ll3efal+okN1Ad4L9ucxm/m0aZzmu4GnDbfTZFPdIfYi3b7nCrbDABiyE6wg8rFvzTV9
         aaqjSSUVYafxOjr55/m5t9dZ/YqF9vc7J1pFFOuTnvBKe8Kq4/dJKz86j7GTZzW12aij
         idy7fTRr5nobtwq1y+rKMtgKam4m8CGp+AqriORwnvv2IcRO/uaLOCdmBJsfanlGkT1h
         gwmy+6Fmq8VH/bj3rXOvL3MhOc0bz8+1e5KVKztmfRBrGb/deprq1Ci9u1LTWteC7P2B
         v+uw==
X-Gm-Message-State: AOAM533l26nCWttvbV/UGuQdz45+7GIdlTQU7AyXdK29AiC/Xu3WwGwR
        wIyDPi1TIYcDSxftaqgBynv9Ug==
X-Google-Smtp-Source: ABdhPJxqtuoCxApUNorjHLZNlmU30AwUL0QTakMfIMlLv5E35XOHdM4jwzjW0LwET0td+AZx5fS88w==
X-Received: by 2002:a62:63c7:0:b029:251:4c9a:5744 with SMTP id x190-20020a6263c70000b02902514c9a5744mr17794268pfb.39.1619441675542;
        Mon, 26 Apr 2021 05:54:35 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id x17sm17027284pjr.0.2021.04.26.05.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 05:54:34 -0700 (PDT)
Subject: Re: [PATCH v2] block: Improve limiting the bio size
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bruno Goncalves <bgoncalv@redhat.com>
References: <20210425043020.30065-1-bvanassche@acm.org>
 <a6d1b5a0-01ca-5f17-d7f1-31257457c13f@kernel.dk>
 <CAHj4cs9E+9n9M6W59LuTWQbbhTzMGgi8KBPaN+cAYC3ypC3dCg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0f078c05-b212-3877-fa64-77fd79cc50ce@kernel.dk>
Date:   Mon, 26 Apr 2021 06:54:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHj4cs9E+9n9M6W59LuTWQbbhTzMGgi8KBPaN+cAYC3ypC3dCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/26/21 12:32 AM, Yi Zhang wrote:
> Hi Jens/Bart
> CKI reproduced the boot panic issue again with the latest
> linux-block/for-next[1] today, then I checked the patch 'bio: limit
> bio max size'[2] found Bart's fix patch does not fold in that commit,
> could you help recheck it, thanks.

Hmm, maybe I botched it. But a bit too much churn around this patch,
Changheun maybe you can resend a fully tested version?

-- 
Jens Axboe

