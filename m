Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D767EB64DD
	for <linux-block@archiver.kernel.org>; Sat,  1 Jul 2023 02:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjGACFo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Jun 2023 22:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjGACFn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2023 22:05:43 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9E34205;
        Fri, 30 Jun 2023 19:05:40 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-392116b8f31so1787779b6e.2;
        Fri, 30 Jun 2023 19:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688177140; x=1690769140;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5bdNj9qKQT+LeuE7FEpcenxaBQ8UjPqvhX6kCdJ3+8=;
        b=klNg5sOXfBJXrDawfc5c+uQJmZ+nApGGt1VXEi+R7IlNg/rSm2Ny7D1GLQQpWqocOK
         MxHsGIe2gumfIfX4h8mfvv5eA0GdovAoPiDqh1i6iUdwrM5tExjVpakVRTzn9hJoFnFS
         jMgPpUG5oFddVbTu8ZnpZ9gaIZ3xAfJOePdabxCdpJD6VUUW5vpc12hyafyrFzsXmT4A
         62XMihkd7iqELBXqUrlYzgPIH1yxjXqTAUwy8LF4kvAwnGPbK9z1Ohm+RUNwb2TZ8p+n
         wCAPcD1To/tp0oqYNk50Z8r7u5DZ08vhwTX3EZ5/iEUYJbT8UJrR9ZZDxa9tKirjFQfK
         JnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688177140; x=1690769140;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L5bdNj9qKQT+LeuE7FEpcenxaBQ8UjPqvhX6kCdJ3+8=;
        b=MUFKh4qrH2j18Ycj67iL5x64DAQVh1zMt8QfPgUNVqrHFWeiEeqpARHUR8tB/tjoCH
         nuinoQ5gYx5cVj/MCO2URY6LQKQay7JLQhgDhgZIsfTzYAw/0sDnPLe2ODkPY1iwtqb0
         fQgawM/JzamXA665mhGehIfTeB9fY/qfo/Gj9ivY0DpAC23NXYQT7JceoWlyGrQIeNE9
         KVANsirSKVNT2+iAMM41u9195O1FaF9XRutoWz+WUADP51IbCTjBh+DsVmKRDIhVUyG5
         wRPIerIHGusQd2S8kjItCu/fuwQoMtVEtfA60H0gR7uo0ju7SnktbBWgSSgQnTL/CPOw
         gqqQ==
X-Gm-Message-State: AC+VfDwT1brI4Xxy0eJHcTScexUZoX2hRuNxce0TmztViqcRLhMkPdFt
        Gz17s7cdhgwkYpoq81Whxao=
X-Google-Smtp-Source: ACHHUZ48tjc+IcWDbAbQg+zPS5cMLuBmRVp55qa2h5UwKVxtsAFzEaJw8mfQvpwupbww2dwFvHPYJw==
X-Received: by 2002:a05:6808:13cd:b0:3a0:492b:f07b with SMTP id d13-20020a05680813cd00b003a0492bf07bmr5455977oiw.26.1688177139964;
        Fri, 30 Jun 2023 19:05:39 -0700 (PDT)
Received: from [10.1.1.24] (222-152-184-54-fibre.sparkbb.co.nz. [222.152.184.54])
        by smtp.gmail.com with ESMTPSA id az10-20020a170902a58a00b001b1866f7b5csm11284418plb.138.2023.06.30.19.05.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Jun 2023 19:05:39 -0700 (PDT)
Subject: Re: [FSL P50x0] [PASEMI] The Access to partitions on disks with an
 Amiga partition table doesn't work anymore after the block updates 2023-06-23
To:     Martin Steigerwald <martin@lichtvoll.de>,
        Christian Zigotzky <chzigotzky@xenosoft.de>, axboe@kernel.dk
References: <024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de>
 <a113cb83-9f82-fd39-f132-41ba4c259265@gmail.com>
 <5866778.MhkbZ0Pkbq@lichtvoll.de>
 <0a8cabbf-89c6-a247-dee8-c27e081b9561@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-m68k@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        mad skateman <madskateman@gmail.com>,
        Darren Stevens <darren@stevens-zone.net>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <48ded6f5-242c-a1b7-39b3-0585be4b848a@gmail.com>
Date:   Sat, 1 Jul 2023 14:05:30 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <0a8cabbf-89c6-a247-dee8-c27e081b9561@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Martin, Christian,

Am 01.07.2023 um 09:17 schrieb Michael Schmitz:
>>> By reverting my patch, you just reintroduce the old bug, which could
>>> result in mis-parsing the partition table in a way that is not
>>> detected by inane values of partition sizes as above, and as far as I
>>> recall this bug was reported because it did cause data corruption. Do
>>> I have that correct, Martin? Do you still have a copy of the
>>> problematic RDB from the old bug report around?
>>
>> It is in the first attachment of the bug report I mentioned above. The
>> bug the patch fixed.
>
> Thanks, I'll get it from there.

Confirmed the bug on that RDB block, also that my proposed patch fixes 
it, at least as far as that's possible to show with a sparse image file.

Now I note that this patch will actually treat any partition block 
address beyond the 31 bit limit as end of the linked list, but that's 
been the behaviour of Linux RDB partitions since very early on, so I see 
no reason to change that.

The RDB format description URL that appears in one of your messages from 
the 2012 thread has gone dead. I'll try to find it on Wayback later. In 
the meantime, I will submit a patch to fix the new bug ... We can has 
out details in the inevitable review process.

Cheers,

	Michael
