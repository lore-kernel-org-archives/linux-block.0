Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99589EB64D9
	for <linux-block@archiver.kernel.org>; Thu, 15 Jun 2023 01:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbjFOBGS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jun 2023 21:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjFOBGR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2023 21:06:17 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E2526A4;
        Wed, 14 Jun 2023 18:06:16 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-651ffcc1d3dso5620313b3a.3;
        Wed, 14 Jun 2023 18:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686791175; x=1689383175;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AhxwF6VPBkSFZ7VN0Npm5/cBY2nIa0+bTqjacSN5QuA=;
        b=PBDOqpLKw8m02ByaVvWNSj7j/ernhI8ENBkMcu2rygtysKh3qorvI9M80YU6FFjboL
         /E8OsRo8cCbcWXMYhoygfyr9Ukw1NK8Byr89ysK9p2K65eUEBEEE6WkbbzKOxbkWBs5b
         xGJtvy0C/hiq40JJOl+RUqaarmlXgbOsuAs2pL0/9S4ArUYqSjhxKVwJntIbg9BbLiWY
         xrlwcRgvitHrAMkJ2cypeNoiHvaf8xZ/ioAuWDTqQwZKOPGnGLTgCe1iWW7hZYeybvID
         XxApqH0oF5bdAKget34mTQd408PP1GlgLjWCEM+NLgnDM5Xl22jfghMOvWBdLtC7lu4a
         7cTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686791175; x=1689383175;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AhxwF6VPBkSFZ7VN0Npm5/cBY2nIa0+bTqjacSN5QuA=;
        b=SVJctx7Dr8/1VI7J6Kxd1WWMpGASJ/t5p3qhsQjwkVFmfEC3PUMFyxC9uIy+y2vRoc
         gU2eRowdeRmDWV248sD/lqllO0j0vZUXzOd8u1kzSM3S3AQMnHyjsussZqNYlUVhoo10
         zo1oMAY4QBeU+DlZ+KzBaORL0/2L02fKGdvhM4lZN58OQJuRx25ULx6ssanPXPNgWQ9Z
         r4pi1TQANBnZCdsl1jj4ccFDTSlEXyFve+8wNsOI6/7AeCH/IG/sF9HUzp74w6dOImvt
         hH5FUCR70hw5ZqMyywYKe5L4cKo2BtShwN3EK84SpKFB4plvZuwrjZ++4hkvQzWDWNyg
         pJkw==
X-Gm-Message-State: AC+VfDyAqeXHjyznIb5JZxSFUAgzKcirFY85fOrKhYCzop4mgA9W2jJj
        MMDIqsAI6vI28NaJ0R8GNcE=
X-Google-Smtp-Source: ACHHUZ4bA2fcjqTacqqx6yEf8Pz4JR2BjlgYq+ouIXsTCm/nWQ5tzpW4ZB/tNjFRaEGtDe1XwJllYA==
X-Received: by 2002:a05:6a00:1a4a:b0:653:a90e:b63e with SMTP id h10-20020a056a001a4a00b00653a90eb63emr3509618pfv.21.1686791175574;
        Wed, 14 Jun 2023 18:06:15 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:5447:d1ff:c6bd:ec5d? ([2001:df0:0:200c:5447:d1ff:c6bd:ec5d])
        by smtp.gmail.com with ESMTPSA id a16-20020a62bd10000000b0065ecdefa57fsm10855866pff.0.2023.06.14.18.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 18:06:15 -0700 (PDT)
Message-ID: <738c6c33-4a95-53d4-cff0-86a3e8170b63@gmail.com>
Date:   Thu, 15 Jun 2023 13:06:09 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH v7 2/2] block: add overflow checks for Amiga partition
 support
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        Christoph Hellwig <hch@infradead.org>,
        Joanne Dow <jdow@earthlink.net>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <1539570747-19906-1-git-send-email-schmitzmic@gmail.com>
 <3748744.kQq0lBPeGt@lichtvoll.de>
 <86671bf8-98db-7d82-f7cb-a80d6f6c064c@gmail.com>
 <4507409.LvFx2qVVIh@lichtvoll.de>
 <98267647-af04-d463-cb5d-c5d6b0a05777@gmail.com>
 <82d25ec7-47cb-cb40-c800-892af48a71f6@linux-m68k.org>
Content-Language: en-US
In-Reply-To: <82d25ec7-47cb-cb40-c800-892af48a71f6@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Finn,

[resent after it bounced from vger ...]

On 15/06/23 12:13, Finn Thain wrote:
> On Wed, 14 Jun 2023, Michael Schmitz wrote:
>
>> The reason why only rdb_SummedLongs, rdb_BlockBytes and
>> rdb_PartitionList are explicitly declared big endian is probably quite
>> simple - nothing else was used by the Linux RDB parser. My patch adds
>> rdb_CylBlocks to that list, so that ought to be changed to big endian,
>> too.
>>
>> affs_hardblocks.h is a UAPI header - what are the rules and
>> ramifications around changes to those? Might not be worth the hassle in
>> the end.
>>
> I think it's safe to fix the UAPI header if we are talking about
> endianness annotations that affect static checking and not code
> generation. The existing annotations in that struct would appear to
> support that notion, if indeed they were put there for the benefit of the
> kernel.

The annotations pre-date mainstream git history - looking at Thomas 
Gleixner's full history git 
(https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/), the 
annotations were added by Al Viro in 2004 (commit 
380768f5a50524ff7eab00d03d82a56cf2fdfe7b 
<https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/include/linux/affs_hardblocks.h?id=380768f5a50524ff7eab00d03d82a56cf2fdfe7b> 
there).

Al said at the time that he only annotated only those fields that are 
used by the kernel, and left everything else alone even though it all 
ought to be big endian.

Reason enough to now change the rdb_CylBlocks annotation.

Thanks,

     Michael



