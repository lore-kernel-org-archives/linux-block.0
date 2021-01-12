Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BF9C433DB
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 18:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9231422C9F
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 18:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406212AbhALSlw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 13:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406210AbhALSlv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 13:41:51 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB0FC061794
        for <linux-block@vger.kernel.org>; Tue, 12 Jan 2021 10:41:11 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id y187so3092889wmd.3
        for <linux-block@vger.kernel.org>; Tue, 12 Jan 2021 10:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=w4WSdwQHCuBBoHOg1WZaw9qfXJ+QY/Ppef3OSGAHOA0=;
        b=bq5JZKKAb79n+BSBUQXdU7UHQaRL9LdBEp8Lrl3CMJwWYj4p6msErVgfZI2jlCo48l
         Nim0IOZsK85nZb3Ygo8maY5FcB33ysVBhhjswfjElQSR3PyemFQ6e7/1n+CvBI5kZTDv
         ngm4pEDjeJSZV9k9KWMYK/6JM7ir4JGZ2Gv5NRJpbd9Q6QqstyZT2cKjJqSrjl/ad6lg
         itTXC/fODp1VoqPkQN1vJy2Rl4LyNaly7vga3zJOjmFH8dSVv+36hwekdRMjW4g+ljVA
         Wc4tK6fSIUimhMerYa/y6v35BRwL42uAhKEi3Cc4CPT2QlbImEsJPo9LbeIKut1/Oj8P
         Loew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=w4WSdwQHCuBBoHOg1WZaw9qfXJ+QY/Ppef3OSGAHOA0=;
        b=l7jyPaTAh6eCxXqatficq2n1coswsEVKo78jW3OTOw3iZ0uSllks2bUDTmfwtvptZm
         WGW4icTyL78MDjjOKvlrczofjo/DqVsxwIPFhl6uILgszJR20QGU2+mcuobGYjFsLH7y
         YtcJbCIrXF1Elc21iBHsbqFyPRimvn29YitAWuy9kWbX/H53BKBvJnDFYh+ltFB/Yk2r
         W7Ouy4PtL7ceQPLT195nqlgEucOs6W1WZRO52m93h3x0RZVmzP86W+xK9H8eiRsns2lx
         xE+3hhg/9vC+vBtetZ/TlR9HPSSySUEAdw2dG6GHV92tKq1jXR//g1tJtHvUUuMsdnXQ
         +s4A==
X-Gm-Message-State: AOAM532UFaoG7avf5YiNe2DHAhjcBMu55Lb2xt88Qy5LGon1vYHRc7Ta
        YUmkksDxH1GEE0NLKWsfBikIUA==
X-Google-Smtp-Source: ABdhPJxx3J9+uNlXGEKW8tNS+zV8I7UkvHkJu286t4sUVejfG/Cl77KRY7Ay8SlrhUnSXmtUxQdGIA==
X-Received: by 2002:a1c:4843:: with SMTP id v64mr586660wma.186.1610476870119;
        Tue, 12 Jan 2021 10:41:10 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id v11sm6125820wrt.25.2021.01.12.10.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 10:41:09 -0800 (PST)
Date:   Tue, 12 Jan 2021 19:41:08 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Minwoo Im <minwoo.im.dev@gmail.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, sagi@grimberg.me
Subject: Re: nvme: enable char device per namespace
Message-ID: <20210112184108.x42fhpdtfn2a24wz@unifi>
References: <CGME20201216181838eucas1p15c687e5d1319d3fa581990e6cca73295@eucas1p1.samsung.com>
 <20201216181828.21040-1-javier.gonz@samsung.com>
 <20210111185347.oqqzdmoglg3lzo5y@mpHalley.localdomain>
 <20210112092207.GA4888@localhost.localdomain>
 <20210112183055.u3y34tfxh4d5aeue@unifi>
 <20210112183303.GA5050@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210112183303.GA5050@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12.01.2021 19:33, Christoph Hellwig wrote:
>On Tue, Jan 12, 2021 at 07:30:55PM +0100, Javier González wrote:
>> I have not implemented multipath support, but it should definitely not
>> crash like this. I'll rebase to 5.11 and test.
>>
>> Christoph: Is it OK to send this without multipath or should I just send
>> all together?
>
>We're not in a rush at the moment, so I'd prefer working multipath
>support if you can spare a few cycles.

Sure. I'll work on that and submit all under the same patchset.
