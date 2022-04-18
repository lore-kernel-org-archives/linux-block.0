Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A28C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Apr 2022 01:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235756AbiDRCCR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Apr 2022 22:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbiDRCCQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Apr 2022 22:02:16 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF59183BB
        for <linux-block@vger.kernel.org>; Sun, 17 Apr 2022 18:59:39 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id u2so16250983pgq.10
        for <linux-block@vger.kernel.org>; Sun, 17 Apr 2022 18:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=ZZxPehgQ7BxhHq86q6EIcDoubsk2JGGHWGF5WmZqX2E=;
        b=q2XAIlZI0B15eh6O+rc29i6jL1MMB2pkL4/4/3Z6YzzTFqULLK3UWGinAKcLnt5L2x
         9kseeJBYvSXE8z5XnSAAp+WIMHSdJnMTHTGhrbpR2uOqWBNapqbwoegou8fC/oUbSyDP
         SwCz2MhMCMFCsLG3VC2Cjq0ahsQwWvmXV008zLXc5zTv6bziqInZCpyf3eCww57Ja2ep
         eXOTgmguDxIBIRCFkY/jIVODq/Y69sLFaUsKGi0YqWF91a6Oi+ozWnpVAkI0bh3kKfKe
         jPCoEDhHjcqPsmswBQwoyx7DBSLPhnOwbs49vFc26BEPD9v1KIdmzpJbHxBU/3vTcTDj
         vDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZZxPehgQ7BxhHq86q6EIcDoubsk2JGGHWGF5WmZqX2E=;
        b=ly+dtTah9JXOaSnoTl1Vi7VHPPDOE6xYcZOJNb+QbO9ndGv8tX5q8otc7TdAYzKdNy
         lRNW47lml/ixuiC6FLmApztl7PIjHAX8scOlSN8hOR8wtKNmBG0eL9wbjalgvCSFGYQN
         BJdlrdRDE6pkwzsTN2T/BYSKkxAdqq+oqTbGOdkwVjBFa+BPzpCeDta49wlLg6u6zagR
         7llArYZNlboHlJNVe7Q8JL38wijfR309sFq5zbnSiwqkvCs2U42kxsWaAEe0kAxFaVDU
         T1MgHBlqbF0Kvnu2ol39/EF2O8rA4hzazYXz9hK60ZMU2qYvUhaGAJ+GcjxvPLaEt0Nq
         kOQQ==
X-Gm-Message-State: AOAM532S71sh+e+dYl1EYTD+ecbgmCMblBseUz34wQvkixpTmO7sQ0gm
        ihv5SjVPmT4z6JZZyFqbjGqoKAnGwnDcx/ql
X-Google-Smtp-Source: ABdhPJxpsx96J9IHFYcFJxtc0fHo2cufmx1U5xBX7RC5Rmi/c1YLqZ90KetQXwhgqshnpM7uhLyj9Q==
X-Received: by 2002:a05:6a00:c8d:b0:50a:62e5:6d30 with SMTP id a13-20020a056a000c8d00b0050a62e56d30mr5912164pfv.47.1650247178717;
        Sun, 17 Apr 2022 18:59:38 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d21-20020a056a0010d500b004fd9ee64134sm10215608pfu.74.2022.04.17.18.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 18:59:38 -0700 (PDT)
Message-ID: <eab14c0a-dd66-555c-8830-d23a5068273c@kernel.dk>
Date:   Sun, 17 Apr 2022 19:59:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [Question] Accessing read data in bio request
Content-Language: en-US
To:     Jasper Surmont <surmontjasper@gmail.com>,
        linux-block@vger.kernel.org
References: <CAH4tiUtGuZP6QnO6L9EEDFL08O-UusHihO6CbvEf-QwJM3QPCg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAH4tiUtGuZP6QnO6L9EEDFL08O-UusHihO6CbvEf-QwJM3QPCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/14/22 8:15 AM, Jasper Surmont wrote:
> I'm writing a device mapper target, and on a bio (read) request I want
> to access (for example just logging) the data that was just read (by
> providing a callback to bio->bio_end_io).
> 
> I've figured out I could read the data by using bvec_kmap_local() on
> each bio_vec to get a pointer to the data. However, if my
> understanding is correct this seems like an unefficient way: if the
> bio just finished a read then shouldn't the data already be mapped
> somewhere? If so, where?

Not necessarily - if you're doing passthrough or O_DIRECT IO, then
no mapping necessarily exists for any part of the IO.


-- 
Jens Axboe

