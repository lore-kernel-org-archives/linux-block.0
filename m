Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB6AC433F5
	for <linux-block@archiver.kernel.org>; Fri,  1 Apr 2022 01:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243701AbiDABZ3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Mar 2022 21:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbiDABZ1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Mar 2022 21:25:27 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C595017ABF
        for <linux-block@vger.kernel.org>; Thu, 31 Mar 2022 18:23:38 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id c15-20020a17090a8d0f00b001c9c81d9648so1108477pjo.2
        for <linux-block@vger.kernel.org>; Thu, 31 Mar 2022 18:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YOOADrKp+VUH8nQO7+wMgoqOiNsAto5K2zBbiDRvBQA=;
        b=P5BxKWEahEPPwlw9a0QpM7zhhBpUCCEILLqvIR/xRoAa3YvZpOhKP+yXYRBNCX9ow0
         6NsaY3Ylj1u/LcftP5yMzqWPd5RGrwhphqdoWoprMMtYcqFq8O9kz1BHf7x1jW1PT9va
         0/j3dE0tY3Izu0mIwiN2CcxdkelYk5Q/mlLhsiaKaticT+8l4vcP+SKhh7YKplYuqaDD
         m9ADLE4Jx8aUxaf5JVFA6J7qbO1Gwcrv7rG3YLmAmPCglJGQNMWYR71HPQmpn/fXkbox
         8MpSHFY7mYqwz7Xs7tyx1uY37iC+4bcy6wkrHcX5hqC2/ax40Qx6wGzV2jGZhsCPEYSb
         eFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YOOADrKp+VUH8nQO7+wMgoqOiNsAto5K2zBbiDRvBQA=;
        b=qdUjMSoQSrx7+j5Ip+kMgeOX3OxVnmccAe4pO89oN72e/0dRwfyNtHqlNUJiv1GJAU
         dydn6HTep/FHFuBq94l+/ioy3Fwi8F32yQSMKagJl7EVRlf9UGtLa6PBAQhdrT/5Fjum
         UeuYbR9OWp/8vbpQTP2TDd704gEfZP51lGgBrlW+sy1SCa/Z28JcDjf/nojuy9JQTTNp
         i5FJyEDikkqsq8zgUFTQBPc9WZ9VeY5io08hIGNp7VIBqf7b2wf7dI+CMMSy2GZz/v0B
         3KTq8PBXgEf0Qe9lr3PS6+tOSuXW/sgpUc4hTz6MTsN1AYFiNrUy6Zsp/kGi2mlkdWp+
         Vgig==
X-Gm-Message-State: AOAM533b42Gn/C9zerb3jdtvBiAG4qtwZ6Ms7EVcTZ/CPpeSwvA+ILAk
        219DuTH44xVUm7+x4LSjaIvZmA==
X-Google-Smtp-Source: ABdhPJyk/iqyzfWVXReArPDPtUOmxZ6AqZAFhyA9YOyL8iLIs3KsI+YBk4BVzOcEA2hz0c81JcEaRQ==
X-Received: by 2002:a17:903:1249:b0:154:c472:de76 with SMTP id u9-20020a170903124900b00154c472de76mr42608330plh.81.1648776218273;
        Thu, 31 Mar 2022 18:23:38 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004fae885424dsm718823pfx.72.2022.03.31.18.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 18:23:37 -0700 (PDT)
Message-ID: <30eea8a2-2bd0-7aa2-42a1-523c61de563c@kernel.dk>
Date:   Thu, 31 Mar 2022 19:23:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 17/17] nvme: enable non-inline passthru commands
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>
Cc:     Kanchan Joshi <joshiiitr@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, sbates@raithlin.com,
        logang@deltatee.com, Pankaj Raghav <pankydev8@gmail.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>
References: <CGME20220308152729epcas5p17e82d59c68076eb46b5ef658619d65e3@epcas5p1.samsung.com>
 <20220308152105.309618-18-joshi.k@samsung.com>
 <20220310083652.GF26614@lst.de>
 <CA+1E3rLaQstG8LWUyJrbK5Qz+AnNpOnAyoK-7H5foFm67BJeFA@mail.gmail.com>
 <20220310141945.GA890@lst.de>
 <CA+1E3rL3Q2noHW-cD20SZyo9EqbzjF54F6TgZoUMMuZGkhkqnw@mail.gmail.com>
 <20220311062710.GA17232@lst.de>
 <CA+1E3rLGwHFbdbSTJBfWrw6RLErwcT2zPxGmmWbcLUj2y=16Qg@mail.gmail.com>
 <20220324063218.GC12660@lst.de> <20220325133921.GA13818@test-zns>
 <20220330130219.GB1938@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220330130219.GB1938@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/30/22 7:02 AM, Christoph Hellwig wrote:
> On Fri, Mar 25, 2022 at 07:09:21PM +0530, Kanchan Joshi wrote:
>> Ok. If you are open to take new opcode/struct route, that is all we
>> require to pair with big-sqe and have this sorted. How about this -
> 
> I would much, much, much prefer to support a bigger CQE.  Having
> a pointer in there just creates a fair amount of overhead and
> really does not fit into the model nvme and io_uring use.
> 
> But yes, if we did not go down that route that would be the structure
> that is needed.

IMHO doing 32-byte CQEs is the only sane choice here, I would not
entertain anything else.

-- 
Jens Axboe

