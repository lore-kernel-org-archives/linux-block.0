Return-Path: <SRS0=iUg4=CC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BC2C433E1
	for <linux-block@archiver.kernel.org>; Mon, 24 Aug 2020 18:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E94120738
	for <linux-block@archiver.kernel.org>; Mon, 24 Aug 2020 18:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598295396;
	bh=ZYZ5zUCTCO+3YAP8BmXs59JPBP8Qfo12gU2de/2Haf4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aQQtHa/HhD2vyk9gZPuIOuBo36CDEKCrQ8Nxtu6Ws3gQaUsYdnPHvSIITE87odpkC
	 mb8zH5CNPqwwGw9pmwE5KNYgxIsF7tpat3RGKBjvcFao9n08qxNERYYAWiVyu8hPMi
	 CDhnHNNHBIMZYEo1HG0I0RTnTANK4PXyv5EaIHzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgHXS4f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHXS4e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Aug 2020 14:56:34 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F34C061573
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2020 11:56:33 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id v12so4849099lfo.13
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2020 11:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tm3EEynbk2sQFJXLtEU/waIfg5j0S4RQtFryGKgbTEI=;
        b=L+vgojworNKXb9HzRx32/knA/5otANw2S6bfUNnHGQc4gaa/mVxwE8BeoaLnWtN6BT
         WB0KwhgCF9m0dsSUSew8gqb9YAUg40OU3TlQmWXRXj66PEPI7vR37voldgiSau/pE59O
         SJdfejFuSVmP5lPua50Ot0ePFVB+Oib4BaRRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tm3EEynbk2sQFJXLtEU/waIfg5j0S4RQtFryGKgbTEI=;
        b=FW1rDXpqoNbaoVE1/zMJSE8+gnAHmBN++nfNrFspOjQxn1GpWcxvl6RtUiDE9GbIDp
         6zr4GxLio//VkG991dNglghO9Ijgg1GCwGC3DXjDh6YhYSKq0qlJcSLVjPxdw/pw//kk
         5U97XCFdwb1fLbWVNPhAIRUX/FDL9LOh8QwAJnjbdzdEIGebs6KZ9848GJov6QXMcCf0
         3VgD3C4ZyYOiO2DYrmAPc/+PDUVWwfV1+HxF41BiLb+GbF6S20/2nZfIxgB9Eam+CSD9
         pf3QT4JOOHMQcFRULQEJrOAEfkns/pOMbOueIBAq7bH+WUcozGRTArIUrpMMCesXceMj
         KUXw==
X-Gm-Message-State: AOAM530bhRM3Lk0+afkybdtA9mlFe7+n7tSAf7V5dTGoJTqDbUFHjyY7
        gIWMw5RY6RgQ8RZCgg1CFQdcUH9ASn7bGw==
X-Google-Smtp-Source: ABdhPJxa3BG0jtJOLFcGnEakL4HhDC726dblW/qLLQ1Tewy47/fgkJvDM7z8Y76qEqTTJMAgSBOKeA==
X-Received: by 2002:a05:6512:14d:: with SMTP id m13mr3231909lfo.173.1598295388090;
        Mon, 24 Aug 2020 11:56:28 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id p1sm2347703lji.93.2020.08.24.11.56.26
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 11:56:27 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id w25so10863140ljo.12
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2020 11:56:26 -0700 (PDT)
X-Received: by 2002:a2e:b008:: with SMTP id y8mr2829077ljk.421.1598295386631;
 Mon, 24 Aug 2020 11:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <4945e1c2-a6dd-2827-e7ff-db7aa7ee3bec@kernel.dk>
In-Reply-To: <4945e1c2-a6dd-2827-e7ff-db7aa7ee3bec@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Aug 2020 11:56:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjXzLuN5+koGeDZig6qwabdU3ZG3Ra7TQjSzQr50YPwVw@mail.gmail.com>
Message-ID: <CAHk-=wjXzLuN5+koGeDZig6qwabdU3ZG3Ra7TQjSzQr50YPwVw@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 5.9-rc2
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Aug 23, 2020 at 12:27 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> io_uring-5.9-2020-08-23

.. you ran the wrong script. Oops.

But it builds cleanly this time.

                Linus
