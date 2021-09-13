Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C220C433F5
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 03:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 618E660F92
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 03:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238149AbhIMDxk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 12 Sep 2021 23:53:40 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:39458 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235475AbhIMDxk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 Sep 2021 23:53:40 -0400
Received: by mail-pf1-f179.google.com with SMTP id e16so7555930pfc.6
        for <linux-block@vger.kernel.org>; Sun, 12 Sep 2021 20:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6a8pd9EEdnhsrxZXUyfO7pLRzGCd4IeJzbz3/2hWPXE=;
        b=n6rORYP/gcF8wUyiCb4iH6cZrHkHXbwVrk7loium6Pk5yzE5S4zfZmUO56E48Y7QaS
         eEEtbStxn9ke1rEo1x9F3iE1H+aPgoSTsp4y0Wp+SP2WFKR//hgemvL5SelQVlXFUYL4
         1GHX7qUIxvQJVp3fVwCaGlFYsUUW68hGh9qLYLRC6OVej5vZQuNxVh0L4NKLzLigyAbe
         yI7TtLPLp5xuOq7x1kvX8xu+cnwLX4N6SH+ZSc5EjEqDuNNibQ3UDqks68Dz7teVKdgm
         c+rmjZJl3gjh4ndRXQNbFAcaCRx62Lau+Q9ktNM/qZz/b+Xuvt50IX5ykbn/rTlRdDBe
         TslQ==
X-Gm-Message-State: AOAM5324JytYaPmSC17F/JLUPUewQAzf91hnoMNTsQFgY9WSQLeLObRm
        cHfIZRsrpjX6w9EHX7Z7/EiaDskV5Kw=
X-Google-Smtp-Source: ABdhPJwA+jkYnMjGaRVwPSNRQGFg3ZBjdEtRc7AcEckAqHWiM6cPnPoFbEagOYXMgnb4h7CmgpNoTA==
X-Received: by 2002:aa7:9542:0:b0:434:5a64:bc8 with SMTP id w2-20020aa79542000000b004345a640bc8mr9113230pfq.30.1631505144811;
        Sun, 12 Sep 2021 20:52:24 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:559e:5ce1:19a:4ed6? ([2601:647:4000:d7:559e:5ce1:19a:4ed6])
        by smtp.gmail.com with UTF8SMTPSA id c133sm5211000pfb.39.2021.09.12.20.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Sep 2021 20:52:23 -0700 (PDT)
Message-ID: <1944d3c1-9214-6afe-6ef4-171e7f40d386@acm.org>
Date:   Sun, 12 Sep 2021 20:52:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH] block: Optimize bio_init()
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20210911214734.4692-1-bvanassche@acm.org>
 <c61afcb0-dcee-8c02-d216-58f263093951@kernel.dk>
 <c810ce05-0893-d8c8-f288-0e018b0a08ca@kernel.dk>
 <fe7f7cc7-2403-7ec6-7c1c-abb6ac6a68fa@kernel.dk>
 <c728eac8-3246-2a6d-84bd-a04fa62fbc04@acm.org>
 <200438e7-1a04-ae88-e79c-a4276b9dbb0f@kernel.dk>
 <b81606eb-b2cb-eaf2-b64c-55390f9b5456@acm.org>
 <2adf05af-2d05-ad1d-49da-2b87c00b3e46@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <2adf05af-2d05-ad1d-49da-2b87c00b3e46@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/12/21 15:13, Jens Axboe wrote:
> Now I kind of want to compile the kernel with clang and see how that
> goes...

Another question is what compiler we should use as a reference to decide 
which implementation is faster? My view on the conversation in 
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102294 is that it could 
take a while before gcc generates code for memset() and structure 
assignment that is as fast as what clang generates ...

Thanks,

Bart.
