Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5BFC43462
	for <linux-block@archiver.kernel.org>; Mon,  3 May 2021 16:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34C25613E6
	for <linux-block@archiver.kernel.org>; Mon,  3 May 2021 16:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhECQhE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 May 2021 12:37:04 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:43644 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbhECQgd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 May 2021 12:36:33 -0400
Received: by mail-pg1-f171.google.com with SMTP id p12so4008002pgj.10
        for <linux-block@vger.kernel.org>; Mon, 03 May 2021 09:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lnsvUIYIY/h2DjeBgyGF/3AhK6HKNSCKGTA5mWnsEbM=;
        b=qKHoNxXxAK6B9hUUA0o7iX47hc1UPh4k/6AlLZADEe859ppDnvBRQQvACT3F1QFTC1
         P3q2IfFVtzvsohAjlZIGgGh44JjKbdsaoLXerszr6K64QnEunNVjk8acz4NTj5P2AOT6
         Fr0Q0ouQTpKzkDZ3b3RJrluFoJZ0dB6E4hEHLUxzcpgkla+ct35pXwzLwaCi9c7ooY/T
         r2w3NjMlpq3PkkxUJktugkaAfBzcHDRy8E4vB7WqWtLG1oLwi1pzPSYCeNjQimF/tkbE
         OZKC2G3lH6LASlQxZGTSbgI8nc+06ZFKPy/jPjIjVa7o9VrDfj100NGuj+te7UcPB0Gt
         Fszg==
X-Gm-Message-State: AOAM533eXWhuQqGLWzFCGAjdYAnNVUdMPjI4coDNz6XaMBcg5AmH+79f
        sJqRmjQIKypeQRc++F8RzwM=
X-Google-Smtp-Source: ABdhPJw02XrpboQ9deuknqRyWDXjmOFghgUHs0/YEWblHOaPcd7Gc0w9J2A4taU8A38U0URHsFHvlg==
X-Received: by 2002:a63:1109:: with SMTP id g9mr19498541pgl.88.1620059739156;
        Mon, 03 May 2021 09:35:39 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:e960:31db:6b4:8ca7? ([2601:647:4000:d7:e960:31db:6b4:8ca7])
        by smtp.gmail.com with ESMTPSA id mh15sm19087339pjb.25.2021.05.03.09.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 09:35:38 -0700 (PDT)
Subject: Re: [PATCH v2] block: Improve limiting the bio size
To:     Changheun Lee <nanich.lee@samsung.com>, yi.zhang@redhat.com
Cc:     axboe@kernel.dk, bgoncalv@redhat.com, hch@lst.de,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        ming.lei@redhat.com
References: <20210429063901.9593-1-nanich.lee@samsung.com>
 <CGME20210503094654epcas1p3ce7761e2f0fc304d1c08a9b0bf0485ff@epcas1p3.samsung.com>
 <20210503092850.25122-1-nanich.lee@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <9a1f25af-cda0-0d3b-262a-d0d718b25453@acm.org>
Date:   Mon, 3 May 2021 09:35:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210503092850.25122-1-nanich.lee@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/3/21 2:28 AM, Changheun Lee wrote:
> NULL pointer dereference is not produced in my VM environment too.
> 
> Dear Bart, Yi
> I'll prepare v9 patch including Bart's modification.
> Could you please test it on your environment?

v9 does not cause a change in behavior for blktests on my test setup. It
would be great if someone could rerun xfstests on a setup where this patch
has been applied.

Thanks,

Bart.


