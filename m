Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AA6C433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Dec 2021 23:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhLTXqB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Dec 2021 18:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhLTXqA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Dec 2021 18:46:00 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622DCC061574
        for <linux-block@vger.kernel.org>; Mon, 20 Dec 2021 15:46:00 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id y16so15456532ioc.8
        for <linux-block@vger.kernel.org>; Mon, 20 Dec 2021 15:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qhtVAR+sknJEbgT3KYqmYZUz0TiJ2iQjq2f6Rqlsa2k=;
        b=XxElCAKWWJs2pQKrBlJFbACA67N2Vl59wigT46QPpfxbIZYqq9XJ72QJuKq+2ZE3sG
         ZBAP0t7vZCvdkJtpyQZgsx2MyzMh58D0uzF6+CSNsqiNPCkXG+m1c5znt9SeHTW0WLkt
         2GA6dIXavpJopJMLWH+j/CizTQk9SDZDewCBzjvQykY043C7blJ1GSk69iEyftKTR+9K
         0u9k6jcaIZL0lL2bewC/cElBXgvayAuggxmDUrnIHNSNtQ0DvdoGzhEuqTEymxoFqGbQ
         lz0xOBH3J/PJzGffW0JZljufm7Y4dOuvDkIbL8wP47u0czxrs5X7EEPtRmz27vRETAZu
         ezQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qhtVAR+sknJEbgT3KYqmYZUz0TiJ2iQjq2f6Rqlsa2k=;
        b=t3rpvRCsgPduAg2J2TFdOO5xGBuSF5cZlxrAD55DjMq4Ka/UWJn6XeiDkdY2ya6ecg
         OEjLt/zN6NZ99vgtfe8U+R6XStAs/+DU+0kqnaELNbG1rt//6ynl2HCEWTzdPd99fffA
         CKAhsoLje1IW7BW7OF8ZgxiOpRkGUNWimY/Jl/JCirr8axOtWzt8iHcXoIAsU0qA8zas
         ZIKM5etwtsLaFwZ78Y8KSZpdlbKsuUgB8nOnydIs6uLjulEAMJH8n/QfaAgu/Lee0AIN
         TDaNdTKtV0dx8nScYEkNfqqU3KFu9cReXK/nI1TCRzySUymqrUL5ahISX5slQ8qpplPD
         vO4w==
X-Gm-Message-State: AOAM531GYT546259juvTTI+iv+FfUfIUMMGx48OUyXWY+PrfsNgjyYVN
        hAu2Z5OnzuQBV1q+L4LeLQw/yg==
X-Google-Smtp-Source: ABdhPJzFnCR55CYq0guosnTFrAh3y1n2+5JK2rxvkxO9p/h+QGR5kXv2EVonphXgb6l69YDxEzRaMg==
X-Received: by 2002:a05:6602:2c50:: with SMTP id x16mr305051iov.114.1640043959752;
        Mon, 20 Dec 2021 15:45:59 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id l1sm9509232ioj.29.2021.12.20.15.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 15:45:59 -0800 (PST)
Subject: Re: [PATCH v5 1/1] blktrace: switch trace spinlock to a raw spinlock
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Wander Costa <wcosta@redhat.com>,
        Wander Lairson Costa <wander@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20211220192827.38297-1-wander@redhat.com>
 <8340efc7-f922-fb8c-772c-de72cefe3470@kernel.dk>
 <CAAq0SUn_Nru1NTyzgjB9ETsaM46bgDRf3DTa+Z9sG-c8yjuQdw@mail.gmail.com>
 <b07b97b4-dff2-5915-ce56-a039a14a74dd@kernel.dk>
 <CAAq0SUmQ5aXtr-tVYLry7zZwTHG6J=X7QV9q0man7pXn7uZjQQ@mail.gmail.com>
 <2f2f5003-e1bf-15ce-32cd-a543634ba880@kernel.dk>
 <CAAq0SUkZ_Zm_KZc-S02xAuR+td0T1nx=cPCs6D2cb_xt6EsUEg@mail.gmail.com>
 <76333783-cb3a-d1b7-5e40-d07014c4e2c0@kernel.dk>
 <20211220183046.7193720d@rorschach.local.home>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4d110c2a-2e70-8fc1-a16e-cd576c646a39@kernel.dk>
Date:   Mon, 20 Dec 2021 16:45:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211220183046.7193720d@rorschach.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/20/21 4:30 PM, Steven Rostedt wrote:
> On Mon, 20 Dec 2021 13:49:47 -0700
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> Alright, fair enough, mistakes happen. I think the patch looks fine, my
>> main dislike is that it's Yet Another things that needs special RT
>> handling. But I guess that's how it is...
> 
> It's not really "yet another thing". That's because in general tracing
> needs special RT handling (and a lot of other special handling, not
> just RT). blktrace falls under the tracing category, and this just
> falls under one more thing to make tracing work with RT.

This isn't the first patch like this I've applied. I'm not saying this
is an issue with tracing, just that it's another one of these "spinlocks
are now preemptible/sleeping with RT" and that necessitates changes like
this.

-- 
Jens Axboe

