Return-Path: <SRS0=cbU1=EJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E50AC388F7
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 15:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCB5F2236F
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 15:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="nQl3xTsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgKCPy2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Nov 2020 10:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgKCPy2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Nov 2020 10:54:28 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE50C0613D1
        for <linux-block@vger.kernel.org>; Tue,  3 Nov 2020 07:54:26 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id s25so10894793ejy.6
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2020 07:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GKkCAwgf84ufWl+/PdshXLTU/tRGU7u3qAN89WeITQ4=;
        b=nQl3xTsa5vtJQjG4KYbo4x6TiBF19hSWOhPinkbd4ngLeDqxIvyrZlIky2gBQij/B+
         86fFPDQU6yhtiSW5yCiun7WIjBXS2QulI4gqVpuqLSPpG/REKrE5gFHwCxMItBsoLNdn
         86ZK0mXhTcjXk5jtGlSRipii8IClrNlP/hNCq3W/qXLkK2MAZ5YNoanmcH1+yzbU1axc
         wu5CcbWz9StAFHMr9nHJnIfjmrVNl7o4vILAZdLc2I0QKQBYMZlCZwBpY7uUDEzecVUB
         9ZuoLUoWmG5IMFWwqwa5CJewNL4IF2YS2RgRI/ZzwW2Zu1ocdLmM+vdrVGnvw6RBBeRs
         V1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GKkCAwgf84ufWl+/PdshXLTU/tRGU7u3qAN89WeITQ4=;
        b=VG7TsgL8bU0I6jFseAgZXfZ0a7xfRP7+6RivZ8ZqPgOL55Io/wtcM75+w6Y8Uf20VJ
         Wy72x0XjqCirMgawxS7oxd3e0Vj57bviwJIRukuMHhxmKSv+9A86csl7c3CAmM73qBAX
         TPUDJbZGnLtEPyQ0wX9nvVnj6gVWfI2Bg/65l6fZz6TJ0PajSqzviwsd6SrPyXBsnQka
         pNr4BSJtaxlxtjNt8ZLhsUsqTPRwF1xsx+W+QVn9vrtzdkhDhoKqBxkA4QIet+hMjQT5
         XTyZcQKs5tCAb2koSNaz+kqhP8snXW9HhKmXQZ4E2Qnj/W23TWxYw2pz8hlzGOD1Ab/4
         KgDg==
X-Gm-Message-State: AOAM532AydGdmtly/JOc9kMjI4iv5C7erf0g2h+Iiwp6KErIWkoYAA6C
        rTVKniVE+Y4bO3f1qX+lppiLxA==
X-Google-Smtp-Source: ABdhPJzXawt82+9ygKeGcsIucHItooLGUZLhbu6fkX9FwzaMORFdls64C3yEYstxDfmZvWnDJwIBNA==
X-Received: by 2002:a17:906:b294:: with SMTP id q20mr3755330ejz.234.1604418864925;
        Tue, 03 Nov 2020 07:54:24 -0800 (PST)
Received: from localhost (5.186.126.247.cgn.fibianet.dk. [5.186.126.247])
        by smtp.gmail.com with ESMTPSA id t8sm11097412ejc.45.2020.11.03.07.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:54:23 -0800 (PST)
Date:   Tue, 3 Nov 2020 16:54:22 +0100
From:   Javier Gonzalez <javier@javigon.com>
To:     "hch@lst.de" <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "Klaus B. Jensen" <k.jensen@samsung.com>,
        "Niklas.Cassel@wdc.com" <Niklas.Cassel@wdc.com>
Subject: Re: nvme: report capacity 0 for non supported ZNS SSDs
Message-ID: <20201103155422.uwoigzmrgks27rtw@MacBook-Pro.localdomain>
References: <CGME20201102161505eucas1p19415e34eb0b14c7eca5a2c648569cf1e@eucas1p1.samsung.com>
 <0916865d50c640e3aa95dc542f3986b9@CAMSVWEXC01.scsc.local>
 <20201102180836.GC20182@lst.de>
 <20201102183355.GB1970293@dhcp-10-100-145-180.wdc.com>
 <20201102185851.GA21349@lst.de>
 <20201102212405.j43m47ewg65v4k5k@MacBook-Pro.localdomain>
 <20201103090628.GA15656@lst.de>
 <20201103141019.5eomaxs4qn4ezaeh@MacBook-Pro.localdomain>
 <20201103152609.GA10928@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20201103152609.GA10928@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03.11.2020 16:26, hch@lst.de wrote:
>On Tue, Nov 03, 2020 at 03:10:19PM +0100, Javier Gonzalez wrote:
>> One question here is that we are preparing a RFC for a io_uring passthru
>> using the block device. Based on this discussion, it seems to me that
>> you see this more suitable through the char device.
>>
>> Does it make sense that we post this RFC using the block device? It
>> would be helpful to get early feedback before starting the char device.
>
>If you wan to send the RFC with the block device that is ok.  But I
>think the separate character device is pretty trivial, at least for
>NVM command set derived command sets like ZNS (for others we'll need
>to finish the Command Set Independent Identify Namespace TP first).

Ok. Good to hear that we can do this in steps - I was worried that we
would need to cover this use case too in the beginning, which would
delay this work significantly.

>
>> I see that this does not make much sense for the other non-supported
>> features in this patch (i.e., !po2 zone size and zoc). Since this is
>> very much like PI today, is it OK we add these the same way (capacity 0)
>> and then move to the char device when ready?
>
>I'd rath avoid adding more of that capacity 0 mess if we can.  Especially
>as the character device should be really easy to do.

Ok. We will move ahead with the char device and port current capacity 0
there in the series.

Thanks for the guidance Christoph!
