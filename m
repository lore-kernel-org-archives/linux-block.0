Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F817EB64DA
	for <linux-block@archiver.kernel.org>; Wed,  5 Jul 2023 21:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjGEVoe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jul 2023 17:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjGEVoa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jul 2023 17:44:30 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A1619BE
        for <linux-block@vger.kernel.org>; Wed,  5 Jul 2023 14:44:25 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b7e0904a3aso9151965ad.0
        for <linux-block@vger.kernel.org>; Wed, 05 Jul 2023 14:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1688593464; x=1691185464;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TLeN5byw/2yTM2aTSNa6jricbe3xA/mbs2Hdqzc0fus=;
        b=Q5P8vVNbURZv8h8VFQLrk0JlDn32UnhsyhHsQax6ycxk34f0gPJdTXdemPBVAx6ix5
         XVQR1gXDISQXpdfjtIGYgNJqA2c40jk+l2jXI5/BSu3Ew5B/DXLTFHpzxm7+kkHuvTqf
         ntYA8PTJzjSrxX+LR2lriqCwq3mxOr/THbQ54Mlh/VtxmI3jc/8rZis9yRj4dZ4oXPz1
         91ivESAKqd3EdleiFskF5YQv6rRj4CurAUZiF1kmnIO9CVkSJLOxr/oVutb6cYvT49VI
         KSW9rXfNdZaYSecXSvRpxtCmZ/kH6y6VZh2dyscY1DuKBREcshlsuXoieE/zYy69cwQe
         75VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688593464; x=1691185464;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TLeN5byw/2yTM2aTSNa6jricbe3xA/mbs2Hdqzc0fus=;
        b=OAzk2dya9NwiACgIy2qv8yLyqG+NHJaeyyJpdwzrvYqOqk+6kLl5UpoGUEo+9LLioy
         dgTUeEG3yi1kmnSKx0vX0xE9ajV+s+5rN9rKW+psjOuAIr7oAN+mK2SfVgWGtFSNkSJr
         brxbPFZhhCbKDeAFDE5pohEsfvp5tFeHpfWYhvfstywGtC+12Pz5b12O/belltK6xT5s
         ABMcfUVVNQF7TcillcLVvP9T/8ZRUDClY4I/MzaI9c96hsru2ahSVy44ko9/dM1WoQYM
         V8tl0ufcNp/IcTDpMcH8mbsoFBAKFd6eMwstyDgQROTa3ISn0KEYJAc5daEFgmGaCfxv
         sCfA==
X-Gm-Message-State: ABy/qLamQZbDbv/JaoKXkQcqORRDMqZ+0zj+D23o3XQedfj8EghmAbsi
        BXzpm7RzLU3j0eqe8eh706uZBQ==
X-Google-Smtp-Source: APBJJlE59gel2YEUqbYIdSol53yTFV2xlITWpqvUVCUNsRt8bO/3zMPOP64yxkRiBJ2TfzBqRXo4KA==
X-Received: by 2002:a17:902:f68c:b0:1b8:17e8:547e with SMTP id l12-20020a170902f68c00b001b817e8547emr282949plg.1.1688593464624;
        Wed, 05 Jul 2023 14:44:24 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902eecc00b001b89b1b99fasm5619084plb.243.2023.07.05.14.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 14:44:23 -0700 (PDT)
Message-ID: <f61ba21f-a8a0-756c-2a41-b831a0302395@kernel.dk>
Date:   Wed, 5 Jul 2023 15:44:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 1/1] block: bugfix for Amiga partition overflow check
 patch
Content-Language: en-US
To:     Michael Schmitz <schmitzmic@gmail.com>, linux-block@vger.kernel.org
Cc:     linux-m68k@vger.kernel.org, chzigotzky@xenosoft.de,
        geert@linux-m68k.org, hch@lst.de, martin@lichtvoll.de,
        stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
References: <20230620201725.7020-1-schmitzmic@gmail.com>
 <20230704233808.25166-1-schmitzmic@gmail.com>
 <20230704233808.25166-2-schmitzmic@gmail.com>
 <a84267a2-e353-4401-87d0-e9fdcf4c81a0@kernel.dk>
 <6411e623-8928-3b83-4482-6c1d1b5b2407@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <6411e623-8928-3b83-4482-6c1d1b5b2407@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/5/23 3:41?PM, Michael Schmitz wrote:
> Hi Jens,
> 
> On 6/07/23 08:42, Jens Axboe wrote:
>> On 7/4/23 5:38?PM, Michael Schmitz wrote:
>>> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>>> Fixes: b6f3f28f60 ("block: add overflow checks for Amiga partition support")
>>> Cc: <stable@vger.kernel.org> # 5.2
>> This is confusing - it's being marked for stable, but also labeled as
>> fixing a commit that isn't even a release yet?
> 
> True - but as you had pointed out, the commit this fixes is set in
> stone. How do we ensure this bugfix is picked up as well when the
> other patches are backported? Does that  happen automatically, or do I
> need to add a Link: tag to the patch being fixed?

This:

Cc: <stable@vger.kernel.org> # 5.2

should be enough for it to go into stable from 5.2 and onwards.

> (Greg didn't seem to object to the Fixes: as such, just to the
> incorrect version prereq)

I think it's really confusing... A patch should only have a Fixes tag if
it's fixing a specific bug in that patch. Either it is, in which case
you would not need Cc stable at all since it's only in 6.5-rc, or it
isn't and you should just have the stable tag with 5.2+ as you already
have.

I'll apply this and remove the Fixes line, and the message id thing
too.

-- 
Jens Axboe

