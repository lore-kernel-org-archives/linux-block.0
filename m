Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17B3C433FE
	for <linux-block@archiver.kernel.org>; Wed,  2 Mar 2022 22:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243286AbiCBWGV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Mar 2022 17:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbiCBWGV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Mar 2022 17:06:21 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95763C993D
        for <linux-block@vger.kernel.org>; Wed,  2 Mar 2022 14:05:36 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id ge19-20020a17090b0e1300b001bcca16e2e7so6004696pjb.3
        for <linux-block@vger.kernel.org>; Wed, 02 Mar 2022 14:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=78871N9j2OIrc6iGWGggw4pfpFc8EnPeshVR+tFRL7I=;
        b=cb/g/X/SUs/vpTwoXVWYEE0m//+Y1EfiQKn6tw3zn748u4qpX8lq4ncjFVDoH2OZ/B
         mzREEFrSQWrps/pQbeNaJ5VEOT6oqF9URMcU3CgaBFfephHh9A1wz33yKfcQg/bLHL2t
         bstqcuDN9QUbtK7NntKGl2mT5olkT8bWxr5alwmmdx3TKcY62+40ATf2+td+uQr7CiqG
         R5f2GDUImPCA7BxUL6ikA/nDOg82QDxiAZyPhR5iD/kLUcpaZipMGAWaF8OiOcNw0jxS
         5LO+oFGbBpkIrAFToXx3JvH35grvjt1aqyyaerjrjIo0vjvlfpWxlebY5lmyGBpLn0Lz
         L9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=78871N9j2OIrc6iGWGggw4pfpFc8EnPeshVR+tFRL7I=;
        b=6nUclnvjGcbQcYjLMtLGxBhMEUkn2MWbh3oMdfxJF67EmAkmNtTsRYVub+h2qKweki
         jF/OJONyAEPNTElI282/XIzOtbUEQ0m5WuBsBEsjO5wzdbKHqO3OWPbbC/qDRopd0HsN
         +wsvDSG0FDfBm4MqdPM/6sR+Nd+ZD4bOqO3ksiKf1eOxpZ1V15pd+FPcQ9iyLxtq32G3
         sVRlcJlahtXavkfAqVDqMlpfcfMKQUT9oB/sLQ5a3qZhmlsu/ydWeFpd85tTfmSafro+
         TYZi2Pl+si6Z21H7bhmUTW5cMlNi7R1sF+xJumuS+x0QqJHZIoo4ZH1VuLfHs9svg9IH
         ekoQ==
X-Gm-Message-State: AOAM530nimfBWx84XWi/ERZc5FHp/5J8nJciv2NcD+aEsKhlEbpmeueo
        4dz3aKT08TAiiDeCaORG62g5cQ==
X-Google-Smtp-Source: ABdhPJzx6rbHNZ/Dt6zxiDPjLgJzNRH7EuCrWHx2lYZdXuGWQWMWXzL2tx1CdfcYMN9ODVN8ZTAYRQ==
X-Received: by 2002:a17:902:bf04:b0:149:c5a5:5323 with SMTP id bi4-20020a170902bf0400b00149c5a55323mr32754710plb.97.1646258735983;
        Wed, 02 Mar 2022 14:05:35 -0800 (PST)
Received: from ?IPV6:2600:380:7767:9c7b:f525:6c13:52ea:fb9? ([2600:380:7767:9c7b:f525:6c13:52ea:fb9])
        by smtp.gmail.com with ESMTPSA id t5-20020a654b85000000b00373cbfbf965sm125177pgq.46.2022.03.02.14.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 14:05:35 -0800 (PST)
Message-ID: <c16dfd08-14f1-bd43-73ca-c1f3e7b3c205@kernel.dk>
Date:   Wed, 2 Mar 2022 15:05:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [LSF/MM/BPF TOPIC] configfd as a replacement for both ioctls and
 fsconfig
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
References: <Yh1swsJLXvLLIQ0e@bombadil.infradead.org>
 <2ee1eb2b46a3bbdbde4244634586655247f5c676.camel@HansenPartnership.com>
 <1476917.1643724793@warthog.procyon.org.uk>
 <3570401.1646234372@warthog.procyon.org.uk>
 <Yh/nn1yjU1xF9qCG@bombadil.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yh/nn1yjU1xF9qCG@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/2/22 2:54 PM, Luis Chamberlain wrote:
> On Wed, Mar 02, 2022 at 03:19:32PM +0000, David Howells wrote:
>> Luis Chamberlain <mcgrof@kernel.org> wrote:
>>
>>>> It'd be nice to be able to set up a 'configuration transaction' and then
>>>> do a commit to apply it all in one go.
>>>
>>> Can't io-uring cmd effort help here?
>>
>> I don't know.  Wouldn't that want to apply each element as a separate thing?
> 
> There is nothing to stop us to design an API which starts a
> transaction / ends. And io-uring cmd supports links so this is all
> possible in theory, I just don't think anyone has done it before.

Only thing you're missing there is unroll on failure. It's quite
possible to have linked operations, but the only recurse is "abort rest
of chain if one fails".

> I mean... io-uring cmd file operation stuff is not even upstream
> yet...

Mostly because it hasn't been pushed. Was waiting for a good idea on how
to handle extended commands, and actually had the epiphany and
implemented it next week. So a more palatable version should be posted
soon.

>> But you might want to do something more akin to a db transaction, where you
>> start a transaction, read stuff, consider your changes, propose your changes
>> and then commit - which would mean io_uring wouldn't help.
> 
> I think Pavel had some advanced use cases to support that with io-uring
> cmd work. For instance open a file descriptor and then work on it all
> in the same chain of commands sent.

That already exists in the kernel, it's direct descriptors. See:

https://lwn.net/Articles/863071/

With that, you can have a chain that does "open file, do X to file, do Y
to file, etc, close file" in one operation. Links like mentioned above,
but can pre-make requests that operate on a descriptor that has been
opened.

-- 
Jens Axboe

