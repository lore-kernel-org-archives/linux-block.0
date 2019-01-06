Return-Path: <SRS0=sA/n=PO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF706C43387
	for <linux-block@archiver.kernel.org>; Sun,  6 Jan 2019 19:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B8520830
	for <linux-block@archiver.kernel.org>; Sun,  6 Jan 2019 19:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uNfkcuTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfAFTXe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Jan 2019 14:23:34 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42163 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfAFTXe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 6 Jan 2019 14:23:34 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so19723699pga.9
        for <linux-block@vger.kernel.org>; Sun, 06 Jan 2019 11:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RvA0y35qCLja6k9PMYIFZ1nrlyy7oVm/17HJNaDtZL0=;
        b=uNfkcuTRZXqLRL2FFVOGMNQu0/ZjWBma4JDUgESlEbUMvbKiolvoKztH7lDzcYvEEX
         dJav0lNYJB/X9+/lHK9jQBZP9iD41keIdR3IIcZduerjQ4EImGGOwxUKoYHIi4wSmWax
         vSHc8pP/bod0/EguXW1ZYNXKit1DiIds30c613pbKEBjLggmbPMxGaSw3ZjvYP4GUWY0
         qmfG/yeQjYJgpLtl9c6lBnoXda1kd50XQRwGu5HmxfR9DMX7YjRd/Mv5UpY+y27J8M4p
         HWhCUXpJhiIN2Ki4LTyUbIrPlpiMbmPc5zYlLzkSJ9MdVIOD+Ami0USW9vNcwWSbuqrp
         xCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RvA0y35qCLja6k9PMYIFZ1nrlyy7oVm/17HJNaDtZL0=;
        b=nYbDye++VI9CUpwpD2fOqCF1Q5s/l4VkuD3+U/aXl/F1QId/f4u20LUIDX/3uK/bbO
         TRFl1Cb18TexMyrk/tvZ0Q3kdGYttyON+NslHQYAOKlA2jm6eTd4CdWQIIv7bS5n1nuh
         /fclHpc83VRhGIim5CZpbMYHncSMZNp9gUWV0vukOUS0GmWw1R0mpRuSefg/JHkwfiE9
         W8ZYJgS4dzi8/OLnS32emuD4QUn1QNs6JXvi30Ya/1ds/4ORTlSTcMFcIHt1C6tMxox7
         BW8P7jqDFyTJHfw8iAmz8F9N4L6dom8kgsBdACoybvsf/7j9U51me6fAL+Qrb2skV6M7
         ffQA==
X-Gm-Message-State: AJcUukc6ah3dAMMoqesFThMP1Zt4czcz6yCUzspbr05XZcb8eu/isxOR
        8WFo5Z/RQoTgKPJyut8wfWWFHtmyhrpm8Q==
X-Google-Smtp-Source: ALg8bN6Z3bQdETT508XuTmRJW91jjLnd9hsMxKoR4Ohv9vmgyz1UGu4AmFFLh4ZqgrlIXmiw2AbWsg==
X-Received: by 2002:a63:4745:: with SMTP id w5mr8761036pgk.377.1546802613106;
        Sun, 06 Jan 2019 11:23:33 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id g6sm11692127pgq.18.2019.01.06.11.23.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 11:23:31 -0800 (PST)
Subject: Re: [PATCH] null_blk: add zoned config support information
To:     John Pittman <jpittman@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org
References: <20190104154243.3538-1-jpittman@redhat.com>
 <1546620417.163063.45.camel@acm.org>
 <CA+RJvhyfKrLwFkxAOxqAW=Mthu5HaF_JU6_rgKLjL07uD8TM+g@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bdf278c3-312d-d714-b06c-be2bd6db07e4@kernel.dk>
Date:   Sun, 6 Jan 2019 12:23:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CA+RJvhyfKrLwFkxAOxqAW=Mthu5HaF_JU6_rgKLjL07uD8TM+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/4/19 1:37 PM, John Pittman wrote:
> Thanks Bart; I made the changes and sent them in as a v2, I'm sure you
> already saw.  I have a quick, unrelated question if you have a moment.
> In testing the null_blk driver, I found that trim commands sent by fio
> were rejected due to lack of support.  Tracking down Shaohua's commit
> 306eb6b4a ("nullb: support discard"), he mentions that "discard makes
> sense for memory backed disk".  Just to see what would happen, I
> edited the source to make discard a configurable parameter at
> modprobe, and after the edit & build, the trim commands submitted
> fine.  Does this sort of change make sense?  I mean the ability to do
> discard to null_blk without it being memory backed;  solely for
> testing/benchmarking purposes.  I haven't found any good instructions
> on creating a memory backed or discard enabled null_blk device from
> the command line, so I assume a higher level driver would have to hook
> in and enable these features manually.  Thanks for your time and any
> information.

I think that would be fine, no option needed. It's really no different
than reads/writes being completed without having a memory backing.

-- 
Jens Axboe

