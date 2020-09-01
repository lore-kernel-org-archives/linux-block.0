Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58160C433E2
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 14:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223A1206FA
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 14:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kLF1FWjM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgIAOEl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbgIAOCg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Sep 2020 10:02:36 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86C3C061244
        for <linux-block@vger.kernel.org>; Tue,  1 Sep 2020 07:01:58 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e33so742961pgm.0
        for <linux-block@vger.kernel.org>; Tue, 01 Sep 2020 07:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gIXfaQDgbn029TgIxmMG7Q9CoL1FfsN6/cwSaIs/q3c=;
        b=kLF1FWjMzClH33qU83bQYV9Fej4FNKJk26CfJ59eMRpzGzd2EZNQuMgARac7HugGld
         mu6Gd8uDWWGGrYmZo8g33oJR456a4xQzYYYkPNIlkEwqFR+G0L9ZJ+RQBEoII8hUp//+
         lPBgzwFehKrMpOPyoFzndamCVXxeRwYXd916OepcY1QvOKo1aan1PV3by90wgIQkThdw
         GPQFlbXyoNswOeXwXK2lLkHLSM5Jzw1As+NTFWg85+E5E7IeNP5SCmu9FzmipMOAtUSm
         VORA7LDvLpbC9aP9s4GovZYe7hkVzt+9/nKq1Ci6cD/1hZC3OW7QFI2zfpNYMSQ9s3H7
         Ql3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gIXfaQDgbn029TgIxmMG7Q9CoL1FfsN6/cwSaIs/q3c=;
        b=q8pwgdORmpz1jZn4q1EjWlwqgO4u9OFDIkycCuetmQVR11t0fsv5xYBU+W5r9TjbvB
         +R6Vb5ZDOGQG6O3+lvb2RgKiJWBi44hd02WjYB7vdK0yxW4rhip2NpJ1BLPdimi8LQ6+
         eEOGe+ZC7RgdsiHGBAGxoaVhgqpRzohhpdn6Ol5KCSh6rFIV91WIr8EdCdDR1Xu9y/Ij
         2dqgjqBS5mREe91TyJh8PR3PCj5TX1oUhjbwlPdfhXFpQ3PovjfcS8cslo8T9D3kD6i8
         pGnsrjgDu0v3kI/uHHUl457HV5SaInBCKY54QvNNrjNF1oEfFX7Ya29BEqI8SmmpOZKi
         DAdg==
X-Gm-Message-State: AOAM5333d15LzQwicrROSGm1Y1tL4RW/r91cBAGJWb5xMj53TGUUOMy5
        n5eOE/ALBbVReFGN/Nj8/+UQ59TW49Ci5Oi8
X-Google-Smtp-Source: ABdhPJwlglXOZ4MAX78SdFpn1am1G+R0kCg1i+n5GrQymhT8jyLipZeNRnuctvYRQSLMUqBh7UFXKQ==
X-Received: by 2002:a63:c904:: with SMTP id o4mr1507402pgg.99.1598968916748;
        Tue, 01 Sep 2020 07:01:56 -0700 (PDT)
Received: from [192.168.1.187] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id x6sm2226729pge.61.2020.09.01.07.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 07:01:56 -0700 (PDT)
Subject: Re: [PATCH] block: fix -EAGAIN IOPOLL task/vm accounting
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <d27ff6f0-9347-e880-fa9d-514e993014dc@kernel.dk>
 <20200830062624.GA8972@infradead.org>
 <9681be4b-298d-7fcd-ed72-9599e08a26a9@kernel.dk>
 <20200830152800.GA16467@infradead.org>
 <ebdb0929-782c-fb66-e3e9-86c077e3b710@kernel.dk>
 <20200831141237.GA13231@infradead.org>
 <57807438-3ba0-e320-b6a5-0ad3f46d8335@kernel.dk>
 <20200901054235.GA29886@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <56eaae8a-5743-8a59-bcf1-47c550bbd25f@kernel.dk>
Date:   Tue, 1 Sep 2020 08:01:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901054235.GA29886@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/31/20 11:42 PM, Christoph Hellwig wrote:
> On Mon, Aug 31, 2020 at 08:18:48AM -0600, Jens Axboe wrote:
>>> We'll still need a flag with the above to skip the submit_bio_noacct
>>> bios.  But I think it is the right way to go.  Eventually we'll also
>>> need to push the accounting down into the individual bio based drivers.
>>
>> For the iocb propagation, we'd really need the caller to mark the iocb
>> as IOCB_ACCOUNTED (or whatever) if BIO_ACCOUNTED is set, since we can't
>> do that further down the stack as we really don't know if we hit -EAGAIN
>> before or after the bio was accounted... Which kind of sucks, as it'll
>> be hard to contain in a generic fashion.
> 
> Well, that's why I think the only proper fix is to only account a bio
> when we know the driver is actually going to submit it.

Yeah I agree, it's a lot less code too. Which is basically back to my
original RFC, I'll see if I can clean it up a bit.

-- 
Jens Axboe

