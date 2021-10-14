Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2167C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 09:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8AED6109F
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 09:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhJNJhq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 05:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhJNJhp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 05:37:45 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D998C061570;
        Thu, 14 Oct 2021 02:35:41 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r18so17453273wrg.6;
        Thu, 14 Oct 2021 02:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oj/5iTHUSbflsGq1NVlUp8060YZQVT0EoAptzHBDUO0=;
        b=I/H4qtnTYnKsWC/MuOhARlWO7L3l3+q+WpPdmROnlOQ/h1KYnM2q2Q5TSktnls4seA
         bx66wns0rN/od5HJ+hCSxofulvYmt83ERtcY6uf7fFtNRo8OxlceP/YUgPVk3T5VRaOX
         dWo77/u/ICVNpeoiS6Pj93EZRxJqlsPI/m+QeOlGKiNh6AMPGhfZTa2ksQwgynvKa3zQ
         9lbz0G1j8T9qqRdYH1lDoRuv09MTvvrJ78bDgtOyBcsFA/PSjEo6sf2Kgd1amY3NtQJz
         h3dx9xE2zC2TsSZB0EzS9UL1+P3N9RmwBFJ+9SxqIZlYzforzwnlngUfkr4ttsP6LUN1
         QdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oj/5iTHUSbflsGq1NVlUp8060YZQVT0EoAptzHBDUO0=;
        b=rY0rYZOOVBA47AkaOCOx3mCOX/8WGK5HX7PL/mkgZ3VmGTcczTKev9KJ0FgBwI/HuO
         PF5gg52pZ42E2ktIaki0bj6+U2IbWruBEeWcOYiGZnGcEXByBIeR0I2SWDHs4sskE38w
         KOz6Ic2zmf8vqhOiXK0Xej18rwyz4+0hkGEJm3iLpZ7pCp7+q5lKgFXLYgI02Ut2+1j9
         iS+CQu4wQ8HTVrEyeLsB80cMQUxxGscvqGlfuUncNVMm2B3SiGnQdqKDuDv9dh0CzDN+
         5ShIaeS0kMXuNFofzRNqQojvT8J+7R1sgUuB2Uo43weH1ovsrkx7HxLeiGb+Ki4cJfi6
         fxig==
X-Gm-Message-State: AOAM533su+i7KUqoo7PjtsvlaMyMNn5NImQ1Tn958fulnk8+bz26LHLi
        H7O5DXXF+4Euzayeeh/Cmi06eivL+8k=
X-Google-Smtp-Source: ABdhPJwEbXJo3LY+9nKVPUVrAi9PStVow50MdBsnjhXx/yuUH+NIg56bu1o8Vn5O+i3r90ezJ68ufA==
X-Received: by 2002:a05:6000:18a4:: with SMTP id b4mr5373966wri.394.1634204139758;
        Thu, 14 Oct 2021 02:35:39 -0700 (PDT)
Received: from [192.168.8.197] ([185.69.145.214])
        by smtp.gmail.com with ESMTPSA id z2sm1876606wrh.44.2021.10.14.02.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 02:35:39 -0700 (PDT)
Message-ID: <59b4350b-db95-f771-c4a4-f3ce38b342f9@gmail.com>
Date:   Thu, 14 Oct 2021 10:35:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH v2 2/3] block: don't hide inode from block_device users
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1634115360.git.asml.silence@gmail.com>
 <2b8c84834a304871d78f91d4ebe153fac2192fd5.1634115360.git.asml.silence@gmail.com>
 <YWb6VgEjEZFexiV0@infradead.org>
 <194577df-0402-6e3c-3534-af289b5494e0@gmail.com>
 <YWe3QZD+g8MSoCtT@infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <YWe3QZD+g8MSoCtT@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/14/21 05:51, Christoph Hellwig wrote:
> On Wed, Oct 13, 2021 at 07:44:20PM +0100, Pavel Begunkov wrote:
>> Mildly hot in io_uring w/o fixed files, but that's not peak perf,
>> but would also be great to get rid of bdev->bd_inode dereference,
>> e.g. lots of in fops.c.
>>
>> Are you going to just hid the dereference in helpers or kill it
>> with some offseting magic?
> 
> The only real hot path uses I found is the size (which you and Jens
> already seem to have moved to use something out of the inode for the
> fast path),  and maybe the blkbits for which we could do the same.
> 
> So basically the idea is to not touch the inode in the hot path,
> and use accessors helpers in bdev.c that could do the offsetof trick.

I see, sounds good

-- 
Pavel Begunkov
