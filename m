Return-Path: <SRS0=pu/s=XM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F3FC4CEC9
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 23:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DCF20665
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 23:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CqNKSH8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbfIQXLR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 19:11:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34511 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfIQXLR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 19:11:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id d3so2193215plr.1
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2019 16:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1bl2/4kBYW46VUOFCSG5tzZb49kfyMGv7ONYxx097I0=;
        b=CqNKSH8IgNHukXEfb2DWsZBBwEdai6mhK75op46xKM4EWqwoRFbhR6xE0+MApDuX6X
         cWU0HwTl049k5ye/Tytrk2wmOHDCvlBfKQO59b4E6BX3Vrnz1vDQAJixzI47l745aFOx
         YR5Wzboi0TinNFlS9N1uyierAtOJH835Mm9iek6ekL2KQzrZSbxb5esfDbpQmgtFWkT0
         D1pmRdtY2kVlwSi9/zzqTZjARr9kuTMwLMgwyInlK8AjXzR0UFSbXFRKiZmeyr7E80YI
         LiZ3WBjRzo8/PBRd/qvmx7SrC35Xbo4jGV406TKcar76tokxy3xOgZdbWDA+/DvMhCs0
         eQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1bl2/4kBYW46VUOFCSG5tzZb49kfyMGv7ONYxx097I0=;
        b=p02f7Mrovl0KBQzaEdh2V/TmS8NR+UqHY3bdzUlMxRmWxUw5GsFMYtyzHYzk0Pe+ON
         2NuoP5ghBKP8DtSlrzSQWonf3ELAHLOQzdqK9V5HPHPchidvLePwYDpUVY/120s0F6oY
         QyQtUbVT4kZ5fM+0Q4kA1xg6XH2kMz47xIyrJt0EEn4v9Pd+jK9nROkKrlLX0DfF8jAs
         0c7Zd6CCdcjscUYv9Xksgh9JxDHxcq7ZFw4XrOts0gerQlMiNl5lQFMnsgqumIGLgrpH
         6ukZunEQJOZixTUDVjh8ZBhi+nTm9geVWWvntWmIG1Oqt98KZ2AKStzsD0a28kFk9kA6
         Ojdg==
X-Gm-Message-State: APjAAAWsMhJ7r1tmU2zCnh5xaWl9FIWCrXM+RWV5hCj8VP7lC/fJIVeN
        rCXb4cWMlVPhWM/usMkd8uvtPjgHgVdLZA==
X-Google-Smtp-Source: APXvYqxf7xUZwP2gITNhum1hwnwQJohhVlY/Sn4ZsR85uyJhOHpVyKCVstsEAQUmHZhu2oPKo8nzFA==
X-Received: by 2002:a17:902:8b85:: with SMTP id ay5mr1111697plb.120.1568761874778;
        Tue, 17 Sep 2019 16:11:14 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id j26sm4135967pfh.100.2019.09.17.16.11.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 16:11:13 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] blk-mq: Avoid memory reclaim when allocating
To:     Xiubo Li <xiubli@redhat.com>, josef@toxicpanda.com
Cc:     mchristi@redhat.com, hch@infradead.org, linux-block@vger.kernel.org
References: <20190917120910.24842-1-xiubli@redhat.com>
 <426aa779-1011-5a75-bb73-ae573c229806@kernel.dk>
 <eaa4fb45-3a62-839e-bdcf-5219fe1c8211@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e7e0ed6a-be80-241c-3841-4eaaba6a9bf9@kernel.dk>
Date:   Tue, 17 Sep 2019 17:11:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <eaa4fb45-3a62-839e-bdcf-5219fe1c8211@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/17/19 4:54 PM, Xiubo Li wrote:
> On 2019/9/17 22:13, Jens Axboe wrote:
>> On 9/17/19 6:09 AM, xiubli@redhat.com wrote:
>>> From: Xiubo Li <xiubli@redhat.com>
>>>
>>> Changed in V2:
>>> - Addressed the comment from Ming Lei, thanks.
>>>
>>> Changed in V3:
>>> - Switch to memalloc_noio_save/restore from Christoph's comment, thanks.
>> This now seems to be a mix of both approaches, which I don't think makes
>> sense at all. I think we should just stick to the gfp_t being passed in,
>> and defining the standard mask for init time blk-mq memory allocations.
>>
> Hmm, I might missed or misunderstand from the last thread. In this
> thread with the save/store, the GFP_KERNEL is using instead. Maybe
> save/store pair is not a exactly correct place or occasion to use here
> as @Bart mentioned.

Just make them all gfp based please, and skip the memalloc() stuff.

-- 
Jens Axboe

