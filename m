Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F80C432BE
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 16:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCB1160EE5
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 16:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbhH0Qxn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 12:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbhH0Qxn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 12:53:43 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FECC061757
        for <linux-block@vger.kernel.org>; Fri, 27 Aug 2021 09:52:53 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id a13so9315936iol.5
        for <linux-block@vger.kernel.org>; Fri, 27 Aug 2021 09:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8/v86nFIsJZKQBvxoNaiRi6i/I8eC7f7i3zRjsKUdOo=;
        b=0b5hPdgDNp5k1cZXUm+lOybsv1pSFxptA8ZXjpxBLmX9ii4KuGukQ28JmUrLAaUNL+
         X6aBtwcTlfFPcCSO7kI+tgZU2PJA3zA7EhZl289/HRy5Wv0NASv6Ua8pH67FyWtIP5lQ
         COx+3aLtHoVRr1+bpfnzTE+8OcuCEJb+gC9KvFfOlbjsHM83662Dp0xZK8FdmSO4ZNEn
         jZocRY2wBQX2/TQBRNYYyltU0osMiLRBwkKgBhP4ulYrFkpQDvLLVet7pYBzLf1XZHWj
         vGAzPt7a67fhqUobnEUuLsxz8flXmEtXyn+wZMnIgIuYH+t3WM3er3ZkGowKr2LPgTkb
         fjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8/v86nFIsJZKQBvxoNaiRi6i/I8eC7f7i3zRjsKUdOo=;
        b=AVCc59/25DtDuOx33CZLi9S5y3hXy8KEy49JNJ0nhPr16PpsWDtQtLkrhsziNXaGOv
         tU9AFMq7wO1EhxUIIx6D36amrLYH3rACCqypbpehL/p4LMzges/Vx47zxBtjyI4h7/96
         YSXRV4WzdurO1F5alfAmfKldnXK4tKSMPt1IC3cbfCqO0HaOtTIFpriaE1C2V1zplvs5
         znG6mdfp+ivWQ48nDIhq9ExjT4MemZJ2ddwi7gMYDeIF/+n9TLOGNhaBZ7QaayxbX/FL
         RXlmmcJ/V4DEL4XkyBCvNGvgUjYvnDbKkRNENfjmNEZew3LTvgRTTxkywjBK2TLeuUCM
         jtfg==
X-Gm-Message-State: AOAM532SPJvxx9aVxzexLz0TzMvCozhzcjTyAUn8hqbSDMF0n8o1KE66
        hcvDyOjrhIBT68b/ZL4irpFD14DSWef+Eg==
X-Google-Smtp-Source: ABdhPJwZD7czUoNAZ1VdNn0ZfTTZjYdYbebYhMVGHTuN9hB1rnZ+Nz2m3xOJGUaUdskaZPXvr/eofQ==
X-Received: by 2002:a6b:e616:: with SMTP id g22mr8444917ioh.67.1630083172971;
        Fri, 27 Aug 2021 09:52:52 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x10sm3796305ila.4.2021.08.27.09.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 09:52:52 -0700 (PDT)
Subject: Re: [PATCH for-5.14] cryptoloop: add a deprecation warning
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20210827163250.255325-1-hch@lst.de>
 <59808096-34ff-151f-b7a2-f53d4262f00a@kernel.dk>
 <20210827164051.GA26147@lst.de>
 <cc2108b6-c688-cceb-a953-f156ad21c3a5@kernel.dk>
 <20210827164325.GA26364@lst.de>
 <c7e538b3-e669-1963-b6c5-475285e96784@kernel.dk>
 <20210827164637.GA26631@lst.de>
 <5724b5a9-e8e9-d05d-83fe-8a0920261573@kernel.dk>
 <20210827165019.GB26631@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6332d413-291c-7b1a-504e-aa69d6bf300e@kernel.dk>
Date:   Fri, 27 Aug 2021 10:52:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210827165019.GB26631@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/27/21 10:50 AM, Christoph Hellwig wrote:
> On Fri, Aug 27, 2021 at 10:48:09AM -0600, Jens Axboe wrote:
>> I don't disagree with that, but that's not a new situation. Hence my
>> question on why there's this sudden mad rush to get it queued up for
>> removal, literally a few days before a kernel release.
> 
> Because this allows the very useful deprecation warning to go out
> ASAP.  It's not like printing a message and adding a little Kconfig
> text has any risk.

You're still not explaining why it should go asap, just that yes it will
provide this deprecation warning asap if we queue it up asap. Which is a
given.

As I said, I don't really care that much about it, but it would be nice
to have some actual justification for WHY it should go out asap. It's
not really about risk.

-- 
Jens Axboe

