Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B842C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 10:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6813721841
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 10:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb-com.20150623.gappssmtp.com header.i=@scylladb-com.20150623.gappssmtp.com header.b="ptSl76kp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbeLRKc4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:32:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44760 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbeLRKc4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 05:32:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so15312028wrt.11
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 02:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=HROpD5dcLeoqz7+zZzPIsasLmADEMxHLeWT0KFPPcbE=;
        b=ptSl76kplVc62sW1fQvFjB2fbqUXF5Im9bEEguBcYSFIzOXuOiIjTedaYHRAsm+Nrv
         zZF4VeQFc3uGWrSNW52r/9HYigO66YPjD/pkmMr/roWwpgU70VZtBrOUwWfzsVCUeFcq
         3sypTfWZ5W2Li+mwmUCLjFc3Dao9Id8NwJo8X9BfAF4NnsD9+ogZlxvqeRlSCz2j93tV
         5txH3h2eKn3wtxTAiaiWfl1CLDDQOdPu3GSYSr+ra+ZEmSVcoCVrmpKbuC5CsEMKrHJ5
         iQBv9TZ1ouIDEupvKN9lxKp7SH2H4cHKSMjrxAQSXpr1KQjDEt34E63mh0LjmCuZ8iiv
         W7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=HROpD5dcLeoqz7+zZzPIsasLmADEMxHLeWT0KFPPcbE=;
        b=VR69PkvenrA37IhI/qa+Wb7if8NKZkIuM36tsXhGqVmklVDfUkeeoLGPeiMvMhakMJ
         3sPaZfPOJ39YCpf+LuQh74X+iJiqeJrpOsOcfyWCEFy6cm2L34EaVh1Oee9AXL3bbu4B
         fzEu5akRgoCk7fY2ii6Wq0j3/ZStdAYdSVQBbpM68aGPFDGbrFrlSVf3KkEDDaUvFQrh
         tEFSBsL9FDbQy/SDf7ej8l8+TfetTOFDjwyY3StbUY5ERz2RS1a5yo5d9uICRIL5Vlrk
         YDe4e28YCaNSeaJqKu2ZfwWDoUSuUfPGrl+L6A4N3sVwzymSZDaUxXGMYaku3OSpAXlN
         D2cg==
X-Gm-Message-State: AA+aEWaM+3pxNc77SbLIyU4Mii5WH3CUKmxRE2Ie00RyjAMoScuGRzOs
        77jVnF0WGpfo5A07Sd/MFElzhg==
X-Google-Smtp-Source: AFSGD/UvOuGs5Kgyx8sUox+11L7VqYUq/b1k/PWMS1VDqeORLIYYh1MlGWtuwPnTAoyWSlVk/0de2Q==
X-Received: by 2002:adf:ba8e:: with SMTP id p14mr13513996wrg.230.1545129174193;
        Tue, 18 Dec 2018 02:32:54 -0800 (PST)
Received: from t1.scylladb.com ([84.94.198.183])
        by smtp.gmail.com with ESMTPSA id e16sm3263004wrn.72.2018.12.18.02.32.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 02:32:52 -0800 (PST)
Message-ID: <d0ad25816ccc6fcb388b34f5e0d42ea9105c9097.camel@scylladb.com>
Subject: Re: [PATCH 14/26] aio: support for IO polling
From:   Benny Halevy <bhalevy@scylladb.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com
Date:   Tue, 18 Dec 2018 12:32:50 +0200
In-Reply-To: <20181213175645.22181-15-axboe@kernel.dk>
References: <20181213175645.22181-1-axboe@kernel.dk>
         <20181213175645.22181-15-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2018-12-13 at 10:56 -0700, Jens Axboe wrote:
> Add polled variants of PREAD/PREADV and PWRITE/PWRITEV. These act
> like their non-polled counterparts, except we expect to poll for
> completion of them. The polling happens at io_getevent() time, and
> works just like non-polled IO.
> 
> To setup an io_context for polled IO, the application must call
> io_setup2() with IOCTX_FLAG_IOPOLL as one of the flags. It is illegal
> to mix and match polled and non-polled IO on an io_context.
> 
> Polled IO doesn't support the user mapped completion ring. Events
> must be reaped through the io_getevents() system call. For non-irq
> driven poll devices, there's no way to support completion reaping
> from userspace by just looking at the ring. The application itself
> is the one that pulls completion entries.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 

Looks good to me, thanks.

Benny


