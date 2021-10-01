Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5587C433EF
	for <linux-block@archiver.kernel.org>; Fri,  1 Oct 2021 15:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE51961AD1
	for <linux-block@archiver.kernel.org>; Fri,  1 Oct 2021 15:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhJAPDA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Oct 2021 11:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhJAPDA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Oct 2021 11:03:00 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067B5C061775;
        Fri,  1 Oct 2021 08:01:16 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4HLYGK2ddSzQjhJ;
        Fri,  1 Oct 2021 17:01:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :subject:subject:references:in-reply-to:message-id:from:from
        :date:date:received; s=mail20150812; t=1633100470; bh=4J5HpEj9PI
        gaNqH8sYcJ7kaGnNR9PO2w7go2s+EnliU=; b=Z29wguy+F6ITVnLKidGmdz5XFj
        /daaHpKkhE/hZ1u6jv1rHoI5V65KVk32vWPZ9aTJ0JkKpSAtkMFOVmqQhgYqV35I
        1hGpxA4FqVSFWgjcRTnypKOjeB0TCGoOSmdB7OH8KMPDXbgsnnvtOeR/SbGibJ2v
        /P1NRtMKQfQe+ZtfmY2wVntajQgEXczLNM9D6jLUaj44Yk/fD9tGtAY3BTwby8Mv
        FEBffJ3glRZLs7EzplhmrNazG2HzTxF+3uCoCN3P0pTXtFgdRcf5Zdym9PvfYQPP
        YNXur94pedkOwAMVVUsHutrRsjAGPLw+Qb3NBa7s6bL4RL0FrncZrVwAmmWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1633100471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gC8lZCt63UyxoZI5uFbYTSMp7MC0RJhh8HtvLj0uzcE=;
        b=wXs0HTMdzrenM41bwhyM/dG6JRMCyDAUnXVdp5h/F703F58/Prebonq2o27w8ZJ5Z/zz1G
        lE/efA26342uaoee4e+eH4hMatsPtoclq553GgIRM+LBNwSoGcn/N2Sq6LYD+orryLUiOa
        cNoocbmYUOdf4CFZzieR3A21v8y+D63BBg0vZ2vXrBwOhq4IGG6pniLR4JIDArX0Tlo7pf
        g+Qjq3eIupGkYKxSzjOT0m4wLXkAOrQmhbTF0bTyzUbO1DY5tWX7xIk+Bf3voVJTMf1yAl
        itYX/AqlCa0rwy+PusuPtFdYwHQoF7rC9n3JFJqUelw3w+cGoOLZHXXjbfm2TA==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Date:   Fri, 1 Oct 2021 17:01:09 +0200 (CEST)
From:   torvic9@mailbox.org
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <1889051823.161943.1633100469857@office.mailbox.org>
In-Reply-To: <1624640454.149631.1632987871186@office.mailbox.org>
References: <1624640454.149631.1632987871186@office.mailbox.org>
Subject: Re: [BUG] kernel BUG at mm/slub.c - possible BFQ issue?
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Rspamd-Queue-Id: 8DFBA272
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> torvic9@mailbox.org hat am 30.09.2021 09:44 geschrieben:
> 
>  
> Hello,
> 
> I encounter a hard freeze on both 5.14 and 5.15 when using BFQ.
> Unfortunately, I do not have a full error log, because the computer
> totally freezes and slightly corrupts the display, so it's
> impossible to read the entire message.
> 
> However, what I could get is the following:
> 
>   kernel BUG at mm/slub.c:379
>   invalid opcode: 0000 [#1]
>   RIP: 0010:__slab_free
>   [...]
>   Call Trace:
>   bfq_set_next_ioprio_data
>   [...]
>   bfq_put_queue
>   bfq_insert_requests
>   [...]
> 
> This issue appears more or less randomly and it sometimes takes a
> little while to reproduce it (running fio helps).
> The call trace always contains references to BFQ, but they are not
> always the exact same. Once, I could see on the corrupted display
> the message "general protection fault".
> I could reproduce this issue on two computers.
> 
> Not quite sure but I *think* the issue first appeared somewhere around
> 5.14.5 or 5.14.6, during which time BFQ only got the following commit:
> 
>   (88013a0c5d99) block, bfq: honor already-setup queue merges

I have now reverted the above commit and launched some heavy I/O like
e.g. git kernel, fio, xz compression, and so far, no freezes anymore!
Too early to say that this commit really is the cause though.
Would be great if someone could have a look at it.

> 
> 5.13 doesn't seem to be affected AFAICS.
> 
> Does anyone have an idea what is going on?
> I will now revert the above commit and see if that helps...
> 
> Thanks,
> Tor
