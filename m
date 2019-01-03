Return-Path: <SRS0=Dd+4=PL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AB2C43387
	for <linux-block@archiver.kernel.org>; Thu,  3 Jan 2019 07:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE12620896
	for <linux-block@archiver.kernel.org>; Thu,  3 Jan 2019 07:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SV20QXOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbfACHpd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jan 2019 02:45:33 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51013 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfACHpc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Jan 2019 02:45:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so28513426wmd.0
        for <linux-block@vger.kernel.org>; Wed, 02 Jan 2019 23:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KMBG1izyj/uhQIJVBuaJBt4At6WWrgdp0gA++pbgMn8=;
        b=SV20QXOM1NDd9o+sJmo/rOY/eXtH6yaVtp3IwYPWG+1EoDDrBRtgNvre/+bNICVtIZ
         K8aOTB4wxzTc074g4TsnHAWAj7hS8vKBIEACSXPrJSM9PGbrNXTSW974GATsMbRt4Bhe
         DlQJDfrEfvEYQK6hQOLbcN53gXZfXBxFNmIl9SejtuMqZ8EReeJUW/7mO3WiNm+AEukJ
         FBdyxLe7dWmh+0+LKJNvtpfxrcjDlOwa6uvjZIgW7PLaJaeoeOBY1TjluDrRzh9nPzmO
         RkDMTxKhDZqL4Hp4KHuYpb/NFkhWXL84SlxgM6R9ozx7nctBB08qPJb2PBgVRTuY+jY9
         85VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KMBG1izyj/uhQIJVBuaJBt4At6WWrgdp0gA++pbgMn8=;
        b=WhXojglP9q09LgLuz7eGk2t4dHi0DJ4mjPOBHW4BpfngmcJfW3DMO3hV/nW7DHK/rD
         1T+8tZ+qtQg67ite7F2ODrYeoMrv3dVxUX/Gp944sjs4okrlk1/AaDuJ06h3lmvAt1be
         1fnsV6/6KrYmFT1bYO3SWXbKtiuK3ziWaQdwQ8aTFWr04PPbJQjIPT0tB4ufT8pNdUTB
         SlesGpa700jIzPLF16LyPt0nuklmdWxo8Hr2TxMP8Iw3umAWdoULmGny+reSxUz6TxbC
         nxqiehCmkdnj7eGqmZu6Po43t4tJbk6eOuUCpJa3jbi9Uf2fWTuOrjXrfBYtQEx9+tuq
         YMag==
X-Gm-Message-State: AJcUukfhE7KaZticdZ0ZGldSFpaYnAYKp/CrslQc8cJFkteU4sRNzqpo
        5D8GrMqHf2k+mqsuJFrQVXo=
X-Google-Smtp-Source: ALg8bN5kR8brQA0yuvGavQya1ZXLZg+a25Vd30GPefSh7qYqkB+wKudvBnNzgYo1ECpgG67yeSz0Hw==
X-Received: by 2002:a1c:7306:: with SMTP id d6mr4153146wmb.98.1546501529353;
        Wed, 02 Jan 2019 23:45:29 -0800 (PST)
Received: from [10.43.17.21] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g16sm44426903wru.41.2019.01.02.23.45.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 23:45:28 -0800 (PST)
Subject: Re: [git pull] device mapper changes for 4.21
To:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-block <linux-block@vger.kernel.org>,
        Alasdair G Kergon <agk@redhat.com>,
        AliOS system security <alios_sys_security@linux.alibaba.com>,
        Colin Ian King <colin.king@canonical.com>,
        Eric Biggers <ebiggers@google.com>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Milan Broz <gmazyland@gmail.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Shenghui Wang <shhuiw@foxmail.com>,
        Sweet Tea <sweettea@redhat.com>,
        wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
References: <20181227160944.GA12190@redhat.com>
 <20181230090646.GB1022@infradead.org>
 <alpine.LRH.2.02.1812301413220.7178@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh89gmqGaK4K7+ns9S6CSeCfuUmiy8GPeVz8_ntMz-DYg@mail.gmail.com>
 <20190103072754.GA2667@infradead.org>
From:   Milan Broz <gmazyland@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gmazyland@gmail.com; prefer-encrypt=mutual; keydata=
 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
 vzRmJp4=
Message-ID: <b527fb75-340e-c3ba-7cc7-97dd466e6780@gmail.com>
Date:   Thu, 3 Jan 2019 08:45:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
 Thunderbird/31.3.0
MIME-Version: 1.0
In-Reply-To: <20190103072754.GA2667@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03/01/2019 08:27, Christoph Hellwig wrote:
> On Sun, Dec 30, 2018 at 04:25:46PM -0800, Linus Torvalds wrote:
>> On Sun, Dec 30, 2018 at 11:15 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>>>
>>> But you're right that 2TiB devices are common and that perhaps this option
>>> should go away.
>>
>> 2TiB devices are definitely not common in the one situation where this
>> option might matter: small embedded devices.
>>
>> I don't think the cost of 64 bit is in the arithmetic, but it might be
>> in some of the data structures.
>>
>> But my gut feel is that it probably doesn't much matter, and we could
>> get rid of the config option without anybody ever noticing. I don't
>> think we have that many data structures with 'sector_t' in them.
>>
>> We might try to first just force the option on, and see if anybody even cares.
> 
> Our smallest embedded devices use raw flash using the MTD subsystem,
> and even that is using 64-bit size types everywhere.  So I'd be really
> surprised if it is an issue.

I agree with Christoph here.

(I fixed some CONFIG_LBDAF problems in DM in this pull request because
the code was apparently wrong, but it was a pain to see all these possible
sector overflow checks...)

If it helps anything, we require 64-bit calculations for cryptsetup userspace for >5 years
(you cannot compile it with 32bit support; everything uses 64bit, including these
DM table sector calculations for kernel) and NOBODY complained since we enforced it.
(Ok, it is not a hot path, but....)

Please, if possible, go with 64-bit sector size types by default in future.

Thanks,
Milan
