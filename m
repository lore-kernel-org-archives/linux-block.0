Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EB6C433FE
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 18:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E819823F37
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 18:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404457AbgLKRGT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Dec 2020 12:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394139AbgLKRFD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Dec 2020 12:05:03 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4335FC0613D3
        for <linux-block@vger.kernel.org>; Fri, 11 Dec 2020 09:04:23 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id i9so10166710ioo.2
        for <linux-block@vger.kernel.org>; Fri, 11 Dec 2020 09:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ahs5t1jZns6ylc9n/wQ8MrZRCY05NSLjV+Xm6qlZmLQ=;
        b=zPUAnFNXEnwQtHYNq+I7qPfUoI8EVGgTxP0/iGLSHfDmyInG2LDbhs9r/EkIbIws8g
         +tc+4J+wYoGyhR1T3pCXIh4maa5l4C52jjlDdLbaVVHq3k4x3JekcVriET2qfzY5Ct6o
         5eudLBLQnDHdpGb6II17x7Z/TowpBxtnkBEK5NkIHTONdXo8LtzXX72g0MXkGnICc1F0
         ryqSKSST6ElCPelyX8AoSk1qKB7v0TD0VjwpEup15c+sBO6UDOxBmXUKfNNJXu0+V5Zi
         K37EIHat/mC2110jJLvc4JcZfLPBlSajSv/WFZh0KqABiOK2ZqtugGsAnF6SA8snmDtk
         eDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ahs5t1jZns6ylc9n/wQ8MrZRCY05NSLjV+Xm6qlZmLQ=;
        b=EnBQ0IZy2WcwfNADF5kMkUgooh2L1LrY4S6L8hzKWmVSGnsbqUva/WBnejiy0fgB7B
         iV2zftREaZycJoqwanDC1DImcQ4IMPHcCTD1nGZMk9AdISGxa5rLQ7MoR7ufsfbjNSAQ
         CjJQCExJSIyo8e+xCrtF0Cjiw6XO0oqpJKk7cwBA7e19sFXOrzQJDVVmWb5OfY/GFUaF
         h5l0Qqelszco8s/vlQw9sGowO3nSGGNsZH4ATezd8hEXYUdr+WnqkO6Zp29eIgpgd6Y5
         izF/1Qo9noOxuPP5Ye42HgsCxynIT1nZgMHcdBhiOjUtj6NuRbO/vFemc79xexdJVbyv
         WW3w==
X-Gm-Message-State: AOAM532752A8W0NwYiJa6gYKqiWUUXrqhFIDdeQEmprpaehNq+11YYqe
        zqpGJo97LgiOgA4iD1YaU2MZ2w==
X-Google-Smtp-Source: ABdhPJwvy2YLEploQHFEOTRB0QTKfSZuVTASwHRyClJtYVNu+IyG0KHrsLyQREi4mMQkK0EoS7AyTQ==
X-Received: by 2002:a6b:920b:: with SMTP id u11mr16128922iod.191.1607706262460;
        Fri, 11 Dec 2020 09:04:22 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g6sm5597052ilc.85.2020.12.11.09.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 09:04:21 -0800 (PST)
Subject: Re: [PATCH 0/3] block: blk_interposer - Block Layer Interposer
To:     Hannes Reinecke <hare@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Sergei Shtepa <sergei.shtepa@veeam.com>, hch@lst.de
Cc:     "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "koct9i@gmail.com" <koct9i@gmail.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "steve@sk2.org" <steve@sk2.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pavel Tide <Pavel.TIde@veeam.com>, dm-devel@redhat.com
References: <1607518911-30692-1-git-send-email-sergei.shtepa@veeam.com>
 <20201209135148.GA32720@redhat.com> <20201210145814.GA31521@veeam.com>
 <20201210163222.GB10239@redhat.com> <20201211163049.GC16168@redhat.com>
 <1ee7652e-b77f-6fa4-634c-ff6639037321@kernel.dk>
 <208edf35-ecdc-2d73-4c48-0424943a78c0@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <06b4a10d-5ea5-27e1-af0d-83d5c714996f@kernel.dk>
Date:   Fri, 11 Dec 2020 10:04:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <208edf35-ecdc-2d73-4c48-0424943a78c0@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/11/20 9:56 AM, Hannes Reinecke wrote:
> On 12/11/20 5:33 PM, Jens Axboe wrote:
>> On 12/11/20 9:30 AM, Mike Snitzer wrote:
>>> While I still think there needs to be a proper _upstream_ consumer of
>>> blk_interposer as a condition of it going in.. I'll let others make the
>>> call.
>>
>> That's an unequivocal rule.
>>
>>> As such, I'll defer to Jens, Christoph and others on whether your
>>> minimalist blk_interposer hook is acceptable in the near-term.
>>
>> I don't think so, we don't do short term bandaids just to plan on
>> ripping that out when the real functionality is there. IMHO, the dm
>> approach is the way to go - it provides exactly the functionality that
>> is needed in an appropriate way, instead of hacking some "interposer"
>> into the core block layer.
>>
> Which is my plan, too.
> 
> I'll be working with the Veeam folks to present a joint patchset 
> (including the DM bits) for the next round.

Just to be clear, core block additions for something that dm will
consume is obviously fine. Adding this as block layer functionality than
then exposes an application API for setting it up, tearing down, etc -
that is definitely NOT

-- 
Jens Axboe

