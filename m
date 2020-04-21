Return-Path: <SRS0=KmMx=6F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E009C54FCC
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 19:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E7842072D
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 19:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WxTmLPXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgDUTR6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Apr 2020 15:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725963AbgDUTR5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Apr 2020 15:17:57 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68947C0610D6
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2020 12:17:57 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id e9so8638589iok.9
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2020 12:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fg+d9vwBB0VnYM+Wjdo25HAeAJv48I8DsMCOjXRYSG8=;
        b=WxTmLPXr0CN6t9INnjIZm6HWE9QW38vHWbuWfNXcN8JB45LP9RjUQ7HFqJS1djAXRU
         k+P7IT6uNQo+fwAG3q8DqgKjoph9cgAC6XQ0PKjysheJvfoS8V8fnMZ7OgVT1FVIlMA0
         /iwnGO9u9Cb1SzhpdYcUmyotjBJKOdxagT6B9dmmwLeuXQQIxvFnz3odHVnQRxOgDsun
         pjeXRwbbcgBEfq6a0zAcRLm0a5WbMR31UOdNDMm5+FSGu8XKPuVuT57Kj3PsAffgourz
         r/7zjLUsy/uukZFD3XTfmn++PGk5nvBuD0CLCES88WJQB7EJvov0tsSt1VdqXFB5HaeT
         Vfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fg+d9vwBB0VnYM+Wjdo25HAeAJv48I8DsMCOjXRYSG8=;
        b=oZD47u0uTYaKCbN9fO8uxVeZsyeoPlfxzcYlAHO3kSy7C8zNxHfMWymbGarwqSQ4mp
         7X8ASZT2awtoc45ek1txu5dYDcHLJJELc6bD+ImK126tQiHbiTYT8/4uJpLNGInwl3d3
         9IMKm0KP71w6Xwu7Y0Ot0rBnJc+7Lo1f7gsMXImNSy1wmUgun5JyPXBQAPER5pfs4jxa
         TASDEx+Wqbg2CpNzIBHz08MUqF41oYuJGR7tdDFLVobbA/EBo/OCFGwyS5+g1CxOAZuX
         6Dn3y5CobmamngGfNYv80ASE2pKlFVOsnC77feKJEoOkELARiRKtyKeGZ5W3i4w0MgzN
         D7tw==
X-Gm-Message-State: AGi0PubIt97xsz4G6RRDZpdzxjEMbNvxl+akAOjqOC0A+Kx3i9726abe
        5156il7YZlJEiCfj5PcVqz/Gdw==
X-Google-Smtp-Source: APiQypJ+r6SoH5WGNOv8uTtJ4RO+FvnSg+7Z68uby7s7ga0AKoakunxfUDh5bzrg79Fuy2kc4j/saw==
X-Received: by 2002:a5d:9490:: with SMTP id v16mr1497006ioj.63.1587496676697;
        Tue, 21 Apr 2020 12:17:56 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c87sm1208311ilg.2.2020.04.21.12.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 12:17:55 -0700 (PDT)
Subject: Re: [PATCH] blk-iocost: Fix systemtap error on iocost_ioc_vrate_adj
To:     Steven Rostedt <rostedt@goodmis.org>,
        Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <20200421130755.18370-1-longman@redhat.com>
 <20200421105948.4f5a36f5@gandalf.local.home>
 <22ccb042-7d6f-3717-4024-9ec094b2f363@redhat.com>
 <20200421151649.11300568@gandalf.local.home>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3a747a8f-629e-f9d2-088d-963791d99486@kernel.dk>
Date:   Tue, 21 Apr 2020 13:17:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421151649.11300568@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/21/20 1:16 PM, Steven Rostedt wrote:
> On Tue, 21 Apr 2020 14:36:29 -0400
> Waiman Long <longman@redhat.com> wrote:
> 
>>> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>>>
>>> -- Steve
>>>  
>> OK, will send a v2 patch to update the commit log. Thanks for the review.
> 
> I think Jens already took this patch.  Doesn't sound like a v2 is needed.

I did, with modified subject line.


-- 
Jens Axboe

