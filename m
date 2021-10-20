Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67D7C433FE
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 18:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A552B60F6E
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 18:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhJTSYN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 14:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhJTSYM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 14:24:12 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F4EC061749
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 11:21:58 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id e144so25821310iof.3
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 11:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ex5SCR8f/Ofpd9PRD2RCWFb6jmiWvWLzi5h7xF73/YA=;
        b=xpU8r6C3E6oD1Nic7RChgKaEK8fHWvVIbhcTnVkJ8t+4DUaXrxQ42P6DfJHiWsPRKt
         /k6OSdKgsI6Q2SuN4RkDEiXbQAN61WVMNfm8qDFact/Zta/JijHoakOrSwalQVKYBtCp
         3KFPFerBl0xxKRAHG4AjvzX8JJ/Uity3ewvjHP9frJ3IoHTXbF5Z64IkNiLWNx2yeXO8
         X7my5ypgk7jaXKo7z1KYQEC0I84u53IGs5Z3tq2YE9FjYkzuUDnD0ziEGuh5ZRgpuFsb
         hl2BgGfnIA70Sz4k4dfy4DB08BdKvrxU1O1ChB+Pgkg7Zc7x0n/vXg6CS60sRyI9GF/8
         WcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ex5SCR8f/Ofpd9PRD2RCWFb6jmiWvWLzi5h7xF73/YA=;
        b=P5EOSHFvs47843sF1QnwphyAU6oBZ7jfrdNHp0pByBaeDtaV1JCCb0vnwKV+VBGTeA
         Pb9LbNMMmuw5RTpQggStnPwgMrpZaS7fszVPtF9yFWGPAaifsthdO7twJp33xPdVvqam
         nbYhEMVscwgrw4PLtHx5Q987QWl06hJwYbhAjdosB3jmad631ffJaOl00s4uvron0heN
         5rJ4vdL6hxeeLBebO3Tpq2YPZBm/pn78M4RSePpVXvHbBZZoHO3F9F5FOEpVjLTvTgbu
         3KWwhSzpmBFCmrhRsWo/GkJc/2LsnfkL7RIraDMww/YMfo3AwF3dojKLL/dVyfxanx+s
         fLPw==
X-Gm-Message-State: AOAM531AmGMGaz9o2ZoPuaFOgmem2I12G5GT6NXrkvVZOpVi5k7ZLDP6
        SxmUX3bJyv7G2qEp3/M1Z8TZJw==
X-Google-Smtp-Source: ABdhPJwYNhwKXtTG8PIhG+M/8CG1f2/cmMD19Xpe2Bkll2p8/WtGPNFRexlObl+GoQXiYpwH7m/HXQ==
X-Received: by 2002:a5d:8884:: with SMTP id d4mr544448ioo.137.1634754117101;
        Wed, 20 Oct 2021 11:21:57 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id i11sm696567ila.12.2021.10.20.11.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 11:21:56 -0700 (PDT)
Subject: Re: [PATCH] fs: kill unused ret2 argument from iocb->ki_complete()
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-aio@kvack.org
References: <ce839d66-1d05-dab8-4540-71b8485fdaf3@kernel.dk>
 <x498ryno93g.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <16a7a029-0d23-6a14-9ae9-79ab8a9adb34@kernel.dk>
Date:   Wed, 20 Oct 2021 12:21:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <x498ryno93g.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/21 12:16 PM, Jeff Moyer wrote:
> Hi, Jens,
> 
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> It's not used for anything, and we're wasting time passing in zeroes
>> where we could just ignore it instead. Update all ki_complete users in
>> the kernel to drop that last argument.
> 
> What does "wasting time passing in zeroes" mean?

That everybody but the funky usb gadget code passes in zero, hence it's
a waste of time to pass it in as an argument.

>> The exception is the USB gadget code, which passes in non-zero. But
>> since nobody every looks at ret2, it's still pointless.
> 
> As Christoph mentioned, it is passed along to userspace as part of the
> io_event.

Right

>> @@ -499,8 +499,7 @@ static void ep_aio_complete(struct usb_ep *ep, struct usb_request *req)
>>  		/* aio_complete() reports bytes-transferred _and_ faults */
> 
> Note this comment ^^^
> 
>>  
>>  		iocb->ki_complete(iocb,
>> -				req->actual ? req->actual : (long)req->status,
>> -				req->status);
>> +				req->actual ? req->actual : (long)req->status);
> 
> We can't know whether some userspace implementation relies on this
> behavior, so I don't think you can change it.

Well, I think we should find out, particularly as it's the sole user of
that extra argument. No generic aio code would look at res2, exactly
because it is always zero for anything but some weird usb gadget code.

-- 
Jens Axboe

