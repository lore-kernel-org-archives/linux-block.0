Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B36AC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 17:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107AE20834
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 17:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="M6KU9iOk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107AE20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeLAEWH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:22:07 -0500
Received: from mail-it1-f170.google.com ([209.85.166.170]:38506 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbeLAEWH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:22:07 -0500
Received: by mail-it1-f170.google.com with SMTP id h65so10309306ith.3
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 09:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H+7GbOkm2lC7zEhmVnPkqJY9J9NVFRmgz/oF12ol40k=;
        b=M6KU9iOkU5i+wBEPsBZuO7ZF9VFsl7nHA2bsH/BcmkTVqbTqsCUkq2/Zou7IIIfFA5
         EcdMdY9USQmkW9t6ePkHQWDHyst+Az3Bdf2+k8p4Y+O4QzyQm7NnLFIx/Z1KKd03O3Vp
         MZ+rj6jnVYM+XQpg8kDhwJr82hIK8ONbAGQNbb6tjSd71iKk/rl+/59UGsRoWO7xNigz
         4G3uaMtiAu47LZzR8HaNNr3f6lR0soMO9UVAVVi6YnNwkUCerVGMWqtg11Jzu+q8mMsJ
         aCUSxdPuMl+mPrQUfTQaxZSnGYwm7OxFqSi2UgON++tWAiK1VMKhG+lv4vWr2op/Vttn
         aGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H+7GbOkm2lC7zEhmVnPkqJY9J9NVFRmgz/oF12ol40k=;
        b=kjs1zJTKLDbRdLjK7JdcG9D0I5S1LrJqRC9VDwljy8kOdofkTXszr3M9Yh59VjlbFZ
         TeDg5Xjp7xSY5RMH6uZ3YvH42+YAsT0DEG7uBM0LCePfn3mCl6LEg8HDB6zQrMEveb6T
         dLn4HfEnV8FoEYmnq6GQkYx/QO3c/30Y+HqEMQyOZ+63rItuVMfCZiaqADcMYZ8qK66i
         tVSclFNZ+40rm4IS2vNwuLbqsgh1PPnXfyUSwdmuwpQ4pb1L09eAZmJrNT3BFf3ON7qv
         EIpgiUVrb4aSOtJrUxxkoeuYqCjD2iipeUSNbVSoR8VHOzUTE1aHM6wIvxLlgshrrwbU
         UvpQ==
X-Gm-Message-State: AA+aEWaxAh+t/02h21msOj1wIKBDUliGnfBmn51Fxkm77Bnze/i5pzzb
        dYANQvj74QnbgmCjUqSNWAc/oxjASM0=
X-Google-Smtp-Source: AFSGD/XfeTArbBYrzMh/CzcoVP+e40p5QxXyv+6XIQBtng4lzhmYqInylEq4Z7L/yIGb+9HRsuArLw==
X-Received: by 2002:a02:9870:: with SMTP id x45mr5344607jaj.41.1543597928547;
        Fri, 30 Nov 2018 09:12:08 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id i74-v6sm3477267itc.29.2018.11.30.09.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 09:12:07 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for 4.20
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20181130152430.GA3107@infradead.org>
 <01b6314c-903e-6787-ccf6-e93aa789199a@kernel.dk>
 <20181130162633.GA16933@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <08296696-8fd5-1c99-1df2-39ccda11dea7@kernel.dk>
Date:   Fri, 30 Nov 2018 10:12:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130162633.GA16933@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/18 9:26 AM, Christoph Hellwig wrote:
> On Fri, Nov 30, 2018 at 08:26:24AM -0700, Jens Axboe wrote:
>> On 11/30/18 8:24 AM, Christoph Hellwig wrote:
>>> Various fixlets all over, including throwing in a 'default y' for the
>>> multipath code, given that we want people to actually enable it for full
>>> functionality.
>>
>> Why enable it by default? 99.9% of users aren't going to care. That
>> seems like an odd choice.
> 
> Because its small, and if you don't have it you are going to run into
> problems pretty soon.

Let's do it for 4.21...

> Anyway, to get the fixes out ASAP here is the updated request without
> it:

Pulled, thanks.

-- 
Jens Axboe

