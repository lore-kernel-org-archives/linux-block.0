Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F703C433E0
	for <linux-block@archiver.kernel.org>; Mon, 21 Dec 2020 05:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 226ED22B2A
	for <linux-block@archiver.kernel.org>; Mon, 21 Dec 2020 05:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgLUF6I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Dec 2020 00:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbgLUF6H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Dec 2020 00:58:07 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA9CC0613D3;
        Sun, 20 Dec 2020 21:57:27 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id g1so7882711ilk.7;
        Sun, 20 Dec 2020 21:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:cc:subject:message-id:mime-version:content-disposition;
        bh=Ua2/mrhX7ym2QXGBEungLOzE+u2b0KzmVzT/pkdbpzo=;
        b=bFZlldJt3vfK14cwTAu+D0ZhNYxMOzJOoFBVGenuCiGG9uwOKBJ92qRYIdUb/u6c9P
         JO4nYeQWfr4iDiKbMraAqJU0SjxfrQFkg82aFN3vOXyBUT0YyQuTWd5GLUec7JsZAJeB
         7pA+MLq+lfreJ0tVRaM2JBSouHDFFfOrvyNeglPoqSQ5R+fciWA+36ZOcd1bUvKb2sPM
         vBrXsHumfB9pT3Y/XpSzFrNRVJCfa9g2jdUISYS0SjNIR5hsa9oSB1I4LfFNuoAnS/Ge
         Yn3bnUgnRQtyp2K/wAwBjJ8g4AE//Dtci/ad6QfIpymH/VYbliEQ4AkuhFjwadb2Ng0O
         u+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Ua2/mrhX7ym2QXGBEungLOzE+u2b0KzmVzT/pkdbpzo=;
        b=rgodsMa4c/46s19+KoUzykgwBXhiO+mt40GxH5J22piOMp8MC5t8xL7nyZmO03qlBP
         fFg4OL2dsd0yhXaHeb2CDT9B54TQpN+tlejJ7436T0m8QTioFX2hqv60EAKPLjggK714
         mndVD1RIAsLKgrOiP1l+Wn1IDELnHkLlD2uEhWZtQYqVCGChE1Lyvsz4avWHB7nU7w/E
         j6bZTOscUPtEv2tZYIDZ+MO9hluIoJDWd366eQn5PCx5xzywX6ljVypkVbznf9CVsLyo
         GBrA3OoBeGncanL6KcI/QHG+Fa44FqBwIsYvBOgmHADQRHnNT6o1DLuGbHu4WxZbrB+n
         ev1w==
X-Gm-Message-State: AOAM533Yfh9ABHtVWmlIK2H6dOS6A7jicy6GDozNJNZnU7lE+H6lFT+t
        Rp8Wga2TmmrN8bpdxmSrcF7zGjqvVE9kFQ==
X-Google-Smtp-Source: ABdhPJw3OxbU8kCBPjHc/G4pSzt1LGk2w7H+roZ4Z/vrGyD+/2nbsAT4FpHB7iZjGY10MMc6yUeogA==
X-Received: by 2002:a63:9dc1:: with SMTP id i184mr5900518pgd.409.1608497817444;
        Sun, 20 Dec 2020 12:56:57 -0800 (PST)
Received: from localhost ([103.248.31.152])
        by smtp.gmail.com with ESMTPSA id c62sm14367644pfa.116.2020.12.20.12.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 12:56:57 -0800 (PST)
Date:   Mon, 21 Dec 2020 02:26:50 +0530
From:   'Amey Narkhede' <ameynarkhede03@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: aoe: replace use of __constant_htons to htons
Message-ID: <20201220205650.nznim44tnseb66hb@archlinux>
MIME-Version: 1.0
Content-Type: message/rfc822
Content-Disposition: inline
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Date: Mon, 21 Dec 2020 01:50:23 +0530
From: 'Amey Narkhede' <ameynarkhede03@gmail.com>
To: David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH] block: aoe: replace use of __constant_htons to htons
Message-ID: <20201220202019.j7x64yahapgilr7u@archlinux>
References: <20201220164625.94105-1-ameynarkhede03@gmail.com>
 <d708db73308747feb0484287a09c443e@AcuMS.aculab.com>
Content-Disposition: inline
In-Reply-To: <d708db73308747feb0484287a09c443e@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8

On 20/12/20 07:35PM, David Laight wrote:
> From: Amey Narkhede
> > Sent: 20 December 2020 16:46
> >
> > The macro htons expands to __swab16 which has special
> > case for constants in little endian case. In big
> > endian case both __constant_htons and htons macros
> > expand to the same code. So, replace __constant_htons
> > with htons to get rid of the definition of __constant_htons
> > completely.
> >
> ...
> >  static struct packet_type aoe_pt __read_mostly = {
> > -	.type = __constant_htons(ETH_P_AOE),
> > +	.type = htons(ETH_P_AOE),
> >  	.func = aoenet_rcv,
>
> Does this cause grief if someone is doing a COMPILE_TEST on LE?
>
> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
I did COMPILE_TEST on my x86_64 machine and it compiled
without any problems.
I assume that was the point or am I missing
something? I'm a beginner contributor so please
let me know if there any mistakes.

Amey
