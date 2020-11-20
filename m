Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4F3C2D0E4
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 21:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 625012240A
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 21:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnlBcZOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgKTVkR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Nov 2020 16:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbgKTVkR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Nov 2020 16:40:17 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8F0C0613CF;
        Fri, 20 Nov 2020 13:40:17 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id t21so8445289pgl.3;
        Fri, 20 Nov 2020 13:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EwGlWFruZutLPh9i2RwZfVnE97aWU8s6UdBnfnWbVd4=;
        b=QnlBcZOM2fJeY9Z5CLpd34mV+7UGn+t2xsYQWov6ZoWywLRUebEBa2jFm7RdoST92U
         lvDmq8KSi3ER+aIwTMPb99lqTSPS5z6NyXDA4Ch1meeaYj+gCAp9/Twggu/WoNipy7P9
         ZNKX7wyhBZokl1CGE2ih+jOvjNejm7Ct2Odk2UZ4gI7oo0/Cews2Ep6wrwEmCCy6u/nq
         lsHWvBdx3CNmUK36mZW///6pIMh+9yOEZIToSihyUsG1hcahSEb+uYnzdBkREukzaLhy
         sNCtlENHrQKu5ZsLF4SnEQpYSjvL7Vog817KVcrCmXoITTexL9sybksEXvCiCjnOptvU
         RS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=EwGlWFruZutLPh9i2RwZfVnE97aWU8s6UdBnfnWbVd4=;
        b=XC2h69ScRVKeAUnU5HGqENpXNCtRpWgZrWLNrYIscAw9C6qXlLHzrG0OfYEb6e7LkG
         XyAW6HvstutTubeI0A7XsLx+nF+kYSAtHZ9/TvQWMfupju+xmTQex/MaCeCEg8roYx7e
         Kf3sFAV4a2FSODMKpMio5vKhCUDn2j2POV1N0nRv1RbFlE2xxl1yx+AiyCZ0hoYdV9Ps
         FKvjLAjujCHWkHWGYlutRxtz+kgJkFCo/JIDmyUGL1xUWLkCoH8nHmgOR2NuoBD0Qb25
         7cURGXPLhndNamwqBT/w8zyMk0/SHlOHgwrgF267WEo/uGZgaMDN+7n16T06+S9cCCHW
         1jPQ==
X-Gm-Message-State: AOAM533aaCzVfmcpdMZHHv4k36WtthPDJ+NwuyTSPxbnrG+522odb1QH
        eamFFmNh4/mFM/3yU1grCFE=
X-Google-Smtp-Source: ABdhPJybvSSHPXf/oWSn23C7ksXtTNisxVBwhvtPM6xM/ErYqCFAc5XNRhFyEuh4ijqJKrHOOqbvsw==
X-Received: by 2002:a17:90a:4dc8:: with SMTP id r8mr12043132pjl.1.1605908416770;
        Fri, 20 Nov 2020 13:40:16 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id 143sm4756386pfc.119.2020.11.20.13.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 13:40:15 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 20 Nov 2020 13:40:13 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] zram: break the strict dependency from lzo
Message-ID: <20201120214013.GD3377168@google.com>
References: <20201115101514.954-1-rsalvaterra@gmail.com>
 <20201119222610.GD3113267@google.com>
 <CALjTZvbK6_UqDQFhMxdEQAR-FbsZKrztkEFronvoFpLUWsi_gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALjTZvbK6_UqDQFhMxdEQAR-FbsZKrztkEFronvoFpLUWsi_gw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 20, 2020 at 09:10:13AM +0000, Rui Salvaterra wrote:
> Hi, Minchan,
> 
> On Thu, 19 Nov 2020 at 22:26, Minchan Kim <minchan@kernel.org> wrote:
> >
> > What's the purpose of ZRAM_AUTOSEL_ALGO?
> > If you and Sergey already discussed, sorry about the missing it.
> 
> The purpose of ZRAM_AUTOSEL_ALGO is to make sure at least one of the
> required compression algorithms is enabled, either as a module or
> built-in. I believe Sergey agreed with the reasoning behind it, but
> he'll let us know if I misunderstood. :)
> 
> > Below doesn't work for your goal?
> 
> Unfortunately, it doesn't. :( It breaks the dependency chain, allowing
> you to deselect all compression algorithms in the crypto menu, and

Hi Rui,

I don't understand it. Please see below.  ZRAM_COMP_LZO_DEF select
CRYPTO_LZO, not relying on it. If system supports other CRYPTO module
it will show on choice list. Otherwise, default lzo will be always
there and select CRYPTO_LZO.

Do I miss your point?

+
+choice
+       prompt "zram default compressor"
+       default ZRAM_COMP_LZO_DEF
+       depends on ZRAM || CRYPTO_LZ4
+       help
+         a
+
+config ZRAM_COMP_LZO_DEF
+       bool "lzo"
+       select CRYPTO_LZO
+       help
+         b
+
+config ZRAM_COMP_LZ4_DEF
+       bool "lz4"
+       depends on CRYPTO_LZ4
+       help
+         c
+endchoice
+
+config ZRAM_DEF_COMP
+       string
+       default "lzo" if ZRAM_COMP_LZO_DEF
+       default "lz4" if ZRAM_COMP_LZ4_DEF


