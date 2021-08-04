Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382E0C4338F
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 10:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A51360BD3
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 10:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237077AbhHDKOs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Aug 2021 06:14:48 -0400
Received: from mout.gmx.net ([212.227.15.19]:56953 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236963AbhHDKOr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Aug 2021 06:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628072072;
        bh=HV7eli1vuMcu6Ew0Hu/EpiNn6PONIIGPU46AFy5jnLU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=UcmK6x9ucfsRjaAaNgtUp+EFpLZk5W+ppoyWXplGX/VAU6nczShgoZWpRxS7DLDot
         dsxBxlhwTogamE4XXa2M8+eBXpz6CQk/1B4vSDWiCD/cL9NkSNT2xuHweOPsuyRU97
         2hfUU29QsbhHFYQONzKeqAK6QTubm7W91nTwc8LI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Valinor ([82.203.167.171]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MVN6j-1mcLrL1OGl-00SOZY; Wed, 04
 Aug 2021 12:14:32 +0200
Date:   Wed, 4 Aug 2021 13:16:42 +0300
From:   Lauri Kasanen <cand@gmx.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] n64cart: fix the dma address in n64cart_do_bvec
Message-Id: <20210804131642.8ca8fe9c1572ee8c0af4cb79@gmx.com>
In-Reply-To: <20210804100203.GA20072@lst.de>
References: <20210804094958.460298-1-hch@lst.de>
        <20210804130136.55f633eeb4522f844463159a@gmx.com>
        <20210804100203.GA20072@lst.de>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.18.6; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+NRZlQ2ruFE+41MhVYigIM7DrxRbwiaLePHgrpHYvwsfczcHQES
 4klfvPPIzlLYhawSQwFeFf2+xd7rkqA0ADU5+F9BkULGpSjB/YAA4gsZ0Kz/oXBlAnTSQtb
 hfcNT7nrLXxcmn8tnhvC5YOHCHVZssEpJoUIuUk9sR5VvP2y/TobsGfLCIIS7nAWjvtf7Ju
 APDzQ0M/aNkHYvENtjsng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uToo0KofUy0=:ag24gwXmy/cK8V9bmOFIsC
 Na3vCCoGAbPJQwnfTMxdGAbhno4m1ZNWPhIrN9dy3ulTWp4zTzGckZi/pfTfEdLOyUnwX+zmP
 mKOPikZ+fhm0Ls2dGwPELk2Ga872cn1+k+VqwgnSz6OHgEWnq73tg4tJiiqTV8VHb3G89kpxj
 ItqtyZBxhwpbKFbuhI3s4unvGDzdhlPr9eiUJjiI5KN/fVWZrFkoOGu/0a6gwTWT1wv8main1
 PqkS+MPYEFfM+7bdO9ysYhAVv0i1/Mu8+Rt022XJB9vsZUJOuv4kqA5r0TU42qtNiIgCamqnf
 e6yGuKNL8Ixk6kGBUjkk6xJnOvGgjh1DfbnOtERw39BMJ5QTkE4ubOyr9TMdQtUdTkJRGRIKx
 6sj48h0u7UP0CsxmgCMUD+hMsFZtGHSWs6T4ZTXInR1BZb0Yq6wAUA4D0OqohsNlNRhagjXl4
 3990BLsgoyqCHHvMjz8sG9ytk64je4OdDjl5J2P56HIjb70zxIBWzPa8k8lho53zuJm+b+XeX
 cX0Z/GtWIVXNpnagG6E/AXBhTnbuC6PtQ0VvUrdkv7kzXrpETyn8svAxXjHSmGGiBHiKxCO+F
 zuo3gLxwt9ATqcVpWHokad5IaNiQtJwQBLs5M2tbl6CFwtpfoPe3oBxbLV8EB+4/ggKGlFT7L
 tJ2AKLMgttnq9F1Q9SKHTHbWnG49IwxSIMEs77ePK2nQp5rZltIB9P2B8bh0g939z4K2QKdiR
 Ra0X2MX3N/hbsTMHcUXdYPMbDMs8v2mKbR123M7bGzNG+2W8Yrwe2zXqd1D7kGkWEvBwZAKRn
 QSniEB7WC3FYVp9teA+MpoHT6YqJVSbHW9QaX1HVEZ2cI6AdG13D8lSLsc9UlnsLVjJrwkJKz
 l5yH2xXiAuh3tiKR9S5F9cAZiCn3c3OAklofUiYGfcgAUr2aNiXNa1dmWoB8YZfu3mGthQFdQ
 NnwsqZfvqHXKQSGuL3x+7YlUF+vPOMPOotOIOjgZuopwaF1xuKcchCVFTz4NkKUQHJBoIl9gX
 XqZjffQd6CgF6zVXJ4GHTrz6s6C23JGoirjQQoBzr891O62av49jsQ0X9lxu4G2ayxM7vhp+K
 KLatq7mH6ryjscaNAX89s94o2o9PwLDxIOV
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 4 Aug 2021 12:02:03 +0200
Christoph Hellwig <hch@lst.de> wrote:

> > Have you tested this? I don't have the equipment currently.
>
> No, I don't.  I'm just auditing uses of bv_offset and this one is
> clearly bogus.

I won't have the chance to test until about two months from now. So I
can't ack it until then. But it's probably fine to apply now.

- Lauri
