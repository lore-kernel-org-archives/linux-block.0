Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC38C6FD1D
	for <linux-block@archiver.kernel.org>; Tue,  4 Apr 2023 16:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbjDDQCC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Apr 2023 12:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbjDDQCB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2023 12:02:01 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FE01A5
        for <linux-block@vger.kernel.org>; Tue,  4 Apr 2023 09:02:00 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id h11so17331035ild.11
        for <linux-block@vger.kernel.org>; Tue, 04 Apr 2023 09:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680624120; x=1683216120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=curhK01sXfmE2RlMU8WuYjmrkMgBz4YATpsIYnecl9s=;
        b=Voe6H8asBoDcHT+e20k3gQeZBAWjN9nGktg6hvKLxI7qZX/w7TTjQ4c76fxR6H0kdr
         l9XoSO3IVCeqx3/+Tdho7vggVvzo2WZ6NREw5t3K6LsZYymclNs7cDf7wYpBNC2qE3Dy
         h0aB65/EpwOEjNDSGcJcrXyJL+6nrR1/tHx+hd4JpeehnF6CAA/4bIUp3UyFoeQp3GlG
         1dNJJKsA3XVtPzBsXeJc6vfz8sMXjs1vR6t+wsvoNDLRdFVmQZqDShLchwhmpeZt93Fp
         ZElvqp3NL//6FkB8Dbgtq1Cz6HYchWJp0m7gdjulHW4WBOl5RKHXYF0xVNRCBQYu625L
         HUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680624120; x=1683216120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=curhK01sXfmE2RlMU8WuYjmrkMgBz4YATpsIYnecl9s=;
        b=UoRZf0qVmnzrQDjVSUtK/mNZb1axjFNK463iNb2WusURYG4qrrTVrrRHKKq0DQarpM
         5im+yejdn0v3XiK4Tgof99XBmhkL/+2Lem6VdX0jdiuogB9EZpB5YjH9JeUUZ5PMyb8I
         b5NXaHINtwE1rIk5rxo1QdmFK9NQSMoB6spUTZVjJROQwYZKl+zNFJ+tFLAqXUMidrDk
         /ykHkWYvbKbWHKiGX569r75yczu10i+yLQakC8p1b7nBujK62vj0Tegu21nHo1Lswjv3
         msQiXUUpsdrieKXsh+ZO4ddJjHI2/anbn6t6wvmn0rU5ajnGU/kmtGfC9lH7O3YZP1HJ
         96eA==
X-Gm-Message-State: AAQBX9eegxdEU50Gn/fjwrwZctNyYAJQiR63e07cFX9Whi3BCx1bRs0c
        BQ4n32zPQkPa3qGYwi8eUfDuPg==
X-Google-Smtp-Source: AKy350ZvJfoL6Hx+3SqvCcTcVb7W0gEDSrd0utc/WEB4l8ZL6zAVfLpCbWwyW3n0PqeaSdsSyUVcPQ==
X-Received: by 2002:a05:6e02:1cac:b0:326:3cfc:f702 with SMTP id x12-20020a056e021cac00b003263cfcf702mr133522ill.2.1680624119970;
        Tue, 04 Apr 2023 09:01:59 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id z3-20020a029383000000b004062e2fdf23sm3332885jah.74.2023.04.04.09.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 09:01:59 -0700 (PDT)
Message-ID: <2bbdb38b-a3ac-5127-23c0-56badd113538@kernel.dk>
Date:   Tue, 4 Apr 2023 10:01:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/2] bio iter improvements
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        willy@infradead.org
References: <20230327174402.1655365-1-kent.overstreet@linux.dev>
 <ZCIVLQ6Klrps6k1g@infradead.org> <ZCNN2GE3WBjMkLkH@moria.home.lan>
 <ZCrsbv+zKGf4jvUm@infradead.org> <ZCsAhDpsiNWpiAxS@moria.home.lan>
 <ZCxAIR8pxOfSE6OR@infradead.org> <ZCxGdj3JKl2RPUJW@moria.home.lan>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZCxGdj3JKl2RPUJW@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>> Starting to get personal instead tends to not help to convince your
>> reviewers that it's really useful in general.
> 
> I know you and others like to talk a lot about what you want as
> maintainers and reviewers - but I find that the people who are the
> loudest and the most authoritarian in that respect tend not to be the
> people who drive discussions forward in productive ways.

One issue is certainly that nobody wants to engage with people that
instantly try and make this personal, or just uncomfortable in general.
Then it's better to focus on other things that are more rewarding and
pleasant, nobody needs extra drama in their life. I sure as hell don't.
And unfortunately I find that your postings most often degenerate to
that. Which is a shame, because there's good stuff in a lot of these
patches, but it's often not worth the time/energy investment because of
it.

-- 
Jens Axboe


