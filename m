Return-Path: <SRS0=mNKb=VZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0045CC7618B
	for <linux-block@archiver.kernel.org>; Sun, 28 Jul 2019 06:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9202077C
	for <linux-block@archiver.kernel.org>; Sun, 28 Jul 2019 06:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZL03HATz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbfG1GRN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Jul 2019 02:17:13 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44233 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfG1GRM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Jul 2019 02:17:12 -0400
Received: by mail-pl1-f196.google.com with SMTP id t14so26238505plr.11
        for <linux-block@vger.kernel.org>; Sat, 27 Jul 2019 23:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KTTaUbTLx3YmShMUqFxi9uQq16aJdSw6b/hHf2Cm7Pg=;
        b=ZL03HATzddmr/FBU5iry6xYSEfCjJpvsKQFzCpOjyXvdvddkUu7okeV6zF13/jbWfA
         5JVNKeuV3Ck7sBvN4Y4QQo1XuJMvFJJdn5ci/bVIBeH7VfHtVpsbimp81tvC8t6XRtxP
         dRcPRLCFD3BEeWHWoucC+TbRy5BE4MarsUQva79BU3qlNXp0MW55nZNMVfw7bnvf8Dut
         +89F6KnFc9dKEUzUptpW13jENL/4CMiHIQkcLYwCE7P3VjvwpLut6OTwMbnMbgfLgBy2
         5oVE9LOHILM7g0q6gEw/UtlSydEit6RVL/+NFufaztKbiWI3T7pBZbqYnyU8VDUKnGkb
         NalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KTTaUbTLx3YmShMUqFxi9uQq16aJdSw6b/hHf2Cm7Pg=;
        b=PNeDr/6GMYvQuawE0vRRJYOW5bCU4NpJcB5lbiOq+dHW/IJOXG6Wgp/2locC+hyXVi
         Q/E+JssR7vmi4ZQM2QhodqS9mD2NZvgYj6Y4hFxS68fMW0dIqyMPAEItjorJw5Raw2vx
         FYWo6peUu6GNLLCKRAiQmn7xCKa4RtNK8rgAU/y4I44rYZfO6fmBn8EajOSaF27Fmel6
         BAT+LwuyRTxiqO5bGklqOTedrdOr0oqhsX05wO8g5TXCUjxa6Q4Mu+6mN+4tI3BeL1Nr
         FDZaz3D3Bqks8S8wuSuTmIK8V2UNpce9n05owQmDoEk8I+TlTnvUKhx/NSozTtbDQ2cB
         O0MA==
X-Gm-Message-State: APjAAAVvOJgfEPkMMJtKgLrN8MCBOKdXoYgeEa5g3aDwqp0BRY7ylDx8
        iiQqn0gDTMdik6McEwB1fX0=
X-Google-Smtp-Source: APXvYqxOMWoVOOrxxN032xbm/XtCaFm53NktFiyRFq578eod+OxK7ENfN7pteMMq1eSvdUC8SbF+Lg==
X-Received: by 2002:a17:902:aa09:: with SMTP id be9mr19512219plb.52.1564294632095;
        Sat, 27 Jul 2019 23:17:12 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id y22sm67873734pfo.39.2019.07.27.23.17.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Jul 2019 23:17:11 -0700 (PDT)
Date:   Sun, 28 Jul 2019 15:17:08 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH 2/8] null_blk: add REQ_OP_WRITE_ZEROES config property
Message-ID: <20190728061708.GH24390@minwoo-desktop>
References: <20190711175328.16430-1-chaitanya.kulkarni@wdc.com>
 <20190711175328.16430-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190711175328.16430-3-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19-07-11 10:53:22, Chaitanya Kulkarni wrote:
> This is a preparation patch for implementing the support for the
> write-zeroes operations for null_blk. We introduce a new bool flag
> write-zeroes for nullb_device structure so that user can either set
> this value through configfs when null_blk is memory backed or use
> module parameter. Following two patches are implementing respective
> support for REQ_OP_WRITE_ZEROES.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Hi Chaitanya,

It looks good to be squashed with 3rd patch.  Code looks good to me.

Thanks!
