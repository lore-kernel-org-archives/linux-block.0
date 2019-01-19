Return-Path: <SRS0=VL3J=P3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDF1C61CE4
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 14:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284682086D
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 14:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rfYpi2ht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfASOhl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Jan 2019 09:37:41 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:35503 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbfASOhl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Jan 2019 09:37:41 -0500
Received: by mail-pg1-f180.google.com with SMTP id s198so7444694pgs.2
        for <linux-block@vger.kernel.org>; Sat, 19 Jan 2019 06:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3kRLm9sWlKk6B2B1dzaSmj3RajnCuJQbbf2dnoemKh8=;
        b=rfYpi2htxxaB2vmgyFqBS8latsSjvPLvWk5J5NE+UY7G4OfBn7s1GJ1ZQsgU6RWHK1
         QGm/T5sV3mSU0EIApuRLL68YOWSD63XvblT5W+3L4wckNQLMqyATiA4AYnen6a0OS/RF
         H/RtiOnaLfnnJAdUr7tYiRTjTZRlyqzzVlRqq542GuBIQP/W0fFi7B6oGLUFcak03bm+
         C5UIP5vh6iCIGicLwekQQN8EQpqaUAszdE5bTSC4/sKEmrQGOuRQA/Bx9UCZsI8t2Xv9
         YuQ9UsAqHZ6R2rNiHiAx6UgiMlEzIJUvMAHH4LKyhemlIPXFtUNWj4QNBNI/0pKdiw+l
         NXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3kRLm9sWlKk6B2B1dzaSmj3RajnCuJQbbf2dnoemKh8=;
        b=oCKVrep3RuY1QQSIRHdjxXvwyrEVhv2byy4FY65C20D8kmCh3bu1U1bDM13xvoV58c
         y7aStzkW+oJ9Ysn1vyalfUrmdWSblD9OlfX5Ks6AZnN3F4rmCsm4q86HtZiuOuNxhEGW
         9DIvKEXXQ5yCUtiz7FWa/G4UMPUg9BS2sbE74MIAfZ9Iij1zKacq2kvtHPVRZYrCplZ+
         esVP534jYw63F5wOUCOdAQoe0wnDJMj/esnCsdaKGLp0iU0vnRv/HNJsCOr9tqk6ehvL
         JCQppQHEJYct5brymv+m6jB8sPu0zQSpPdqeIN2aCpM7/8/d0HAaSF6j+WZ0FTmDFYTe
         oTrg==
X-Gm-Message-State: AJcUukfcTpoC28bsKoLA+bP/u6v/8uinhnjvboK2+kee3lo49LmGxTaS
        OThs8PlbeSOkOseC8DRZ/4l9Nw==
X-Google-Smtp-Source: ALg8bN63usghEEnR7Gu439+e4dZwcNGUdN2LLGo7rpXenDPKxaECbr/YoPwBIlK69y+nsnQnfCeubQ==
X-Received: by 2002:a62:5ec5:: with SMTP id s188mr23051226pfb.145.1547908660591;
        Sat, 19 Jan 2019 06:37:40 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id o66sm16324111pgo.75.2019.01.19.06.37.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 06:37:39 -0800 (PST)
Subject: Re: dd hangs when reading large partitions
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.com>, Joao Pinto <jpinto@synopsys.com>,
        Fujita Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Paolo Valente <paolo.valente@linaro.org>
References: <f792574c-e083-b218-13b4-c89be6566015@free.fr>
 <398a6e83-d482-6e72-5806-6d5bbe8bfdd9@oracle.com>
 <ef734b94-e72b-771f-350b-08d8054a58f3@kernel.dk>
 <20190119095601.GA7440@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6cbe0bc6-1a6b-5333-9a2e-a67c8e104672@kernel.dk>
Date:   Sat, 19 Jan 2019 07:37:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190119095601.GA7440@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/19/19 2:56 AM, Christoph Hellwig wrote:
> On Fri, Jan 18, 2019 at 10:48:15AM -0700, Jens Axboe wrote:
>> It's UFS that totally buggy, if you look at its queuecommand, it does:
>>
>>         if (!down_read_trylock(&hba->clk_scaling_lock))                         
>>                 return SCSI_MLQUEUE_HOST_BUSY;
>>
>> UFS either needs to get fixed up, or we'll want a way to do something like
>> the below.
> 
> I think the right answer is to just revert the offending patch instead
> of papering over it in the SCSI code.

I fully agree.

-- 
Jens Axboe

