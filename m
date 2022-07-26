Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC64C43334
	for <linux-block@archiver.kernel.org>; Tue, 26 Jul 2022 01:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiGZBx1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jul 2022 21:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiGZBx0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jul 2022 21:53:26 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92022248DD;
        Mon, 25 Jul 2022 18:53:21 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r186so11943272pgr.2;
        Mon, 25 Jul 2022 18:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=m2UU2TIWhhdzYnHpRkXXzs1Mbk/tkxEW+++vFpsQVgg=;
        b=pJ/E7pUnCrY+GqvhkK7LMg1HoJeiPCkPxX6EPqMSq83JoEaA7AT3iMNGnIrMVhmQOU
         2v1vYotGr7jwzfp7LlrFrEUNCW7ga1qNBye65LQMG3ZwLJpqHBGU4nlg8qCDnLl6uWmM
         Nbfw092hB9FGrQID5lJNNnn3dcIBrxdTPu/ZWSesFdRuwhdOXHOp2C2QuiI7Tso10Eg2
         JD7f30aXrYtSOaRrQyCi+O5V55RodCpnepOEnqQf2kxATgvvzBqvRU3PNmRO8tiXLcZd
         5m3oK+nhDqIQLet4YBTGjz/NfWdMZ9ZPsmBNKwsjLnOiqDAi99Z+4nbP6c6SmwHbUtYW
         7l6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m2UU2TIWhhdzYnHpRkXXzs1Mbk/tkxEW+++vFpsQVgg=;
        b=FQkkNYlnI2o63ffmExCNwvOXzLqV5+10btBrfFjNCPLRwKCtDWVjlwCU9XS5i0Q7Vv
         tHAPlyX0ndEyVeDeTxBjlM5l8QtSuaBtFJqiknXqLFKERuVZ61eEPbUmG5p/MxqgC671
         XEuQzX5kogOkXT4xim6vGPlC7mSo3D9qxe19W1VDukZIj8GByLu28CD0/BxzUnQ1Mpe3
         KpDxGiZjumea6DzoHeDA4VCvA8pMBXzk2d/dw0AFiUHwnT/1g+b1UZQPqqJyKz2ci3PB
         iDCDlhPrV5P3GYTGxyCtqxtrTEEsTeh/qOcYMR7ePk4AhHv7vkMRCCByjsc3NGXR60Kb
         WbIA==
X-Gm-Message-State: AJIora9hq/Z6wHlcN0BVx9HdltdaJmTR5w6+U+CiI6oGbGre6ZkqYPMv
        BF3FFpr6SM5djo8G9VwFaBg=
X-Google-Smtp-Source: AGRyM1vFkLLz9kM3ZL5OzsP0A1Yo58Ri5Z0ApQUp3hoX6+Gv46IH9ND5jn5AEfMy7CrJzZlpK3QEmw==
X-Received: by 2002:a05:6a00:1a86:b0:52a:d419:9552 with SMTP id e6-20020a056a001a8600b0052ad4199552mr15525605pfv.70.1658800401078;
        Mon, 25 Jul 2022 18:53:21 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:a55c:63b0:4c0:df1f? ([2001:df0:0:200c:a55c:63b0:4c0:df1f])
        by smtp.gmail.com with ESMTPSA id b3-20020aa79503000000b00528669a770esm10513961pfp.90.2022.07.25.18.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 18:53:20 -0700 (PDT)
Message-ID: <e0b99db6-ab3e-1c6d-d431-99cee32c1ced@gmail.com>
Date:   Tue, 26 Jul 2022 13:53:14 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 2/2] block: add overflow checks for Amiga partition
 support
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>,
        Martin Steigerwald <martin@lichtvoll.de>,
        linux-block@vger.kernel.org
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org
References: <1539570747-19906-1-git-send-email-schmitzmic@gmail.com>
 <1539570747-19906-3-git-send-email-schmitzmic@gmail.com>
 <2265295.ElGaqSPkdT@ananda> <5e45c2a8-b35e-9a15-18e6-2e3a7ad00f5f@kernel.dk>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <5e45c2a8-b35e-9a15-18e6-2e3a7ad00f5f@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

there's been quite a bit of review on this patch series back in the day 
(most of that would have been on linux-m68k IIRC; see Geert's 
Reviewed-By tag), and I addressed the issues raised but as you say, it 
did never get merged.

I've found a copy of the linux-block repo that has these patches, will 
see if I can get them updated to apply to current linux-block.

Cheers,

     Michael



On 26/07/22 11:03, Jens Axboe wrote:
> On 7/25/22 6:36 AM, Martin Steigerwald wrote:
>> Michael Schmitz - 15.10.18, 04:32:27 CEST:
>>> The Amiga partition parser module uses signed int for partition sector
>>> address and count, which will overflow for disks larger than 1 TB.
>> Did this go in? I did not find anything in git log. I wonder whether I
>> can close the bug report mentioned below.
> Looking at the history (2018!), doesn't like they ever got reviewed or
> went upstream. Looks like they are still needed, however they no longer
> apply as-is.
>
