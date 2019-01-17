Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63702C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 21:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320E220855
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 21:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0fxskG0f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfAQV1l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:27:41 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:42847 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728616AbfAQV1k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 16:27:40 -0500
Received: by mail-io1-f41.google.com with SMTP id x6so9019400ioa.9
        for <linux-block@vger.kernel.org>; Thu, 17 Jan 2019 13:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=emXJ3y1oCIqGvN1nW+Wj+f9uxRC4a7aU856O7Zzq4T4=;
        b=0fxskG0fHnyYrCOLjrB6GeOY41QjY05j/RjY9Q0bpPvjr9c7O2Z2p5lsxGjSPnu0Jr
         ttzeAQCsRHWVPoBEv2lPDTpNrsOBPYD98k9iLYgeZzJ8QMecK5rFPMTQuesMuDVoDjIq
         zlrSGcrpy6NrfL6g4qzdXaFQiChapEiyX/+S+u2cN7n0SLYNG9X8fk7yvalexVrnh/IV
         7yhNFPlIK+yguD4IdB+RO7nQalIbrAf1gPi31q3Q3+4f7bwsBiGO0Suq4B/55blRDDjG
         ZcOraT8Lx3bMIQuj0qSoqrBfVEmTRXFlal0B8fC3u7MaW43/gHXfCr1qMWjHu3izHRxm
         r12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=emXJ3y1oCIqGvN1nW+Wj+f9uxRC4a7aU856O7Zzq4T4=;
        b=UUZ7eym6AXe+XLzfbUQFychworNE0qCnyRzCcDsyMQVwY21ptdVd1Xr3xAchJkC4Tj
         aezuYUhmPWU7Y3MzLZJn5rhFiGFQG1EKW1EZqIL4CDx1XD8vb5fDlK4vHnTICzSiqlzJ
         DPXyofoFocFawVoGa5c/MsKeFB11Ls2GERRO1n4gGP9iulRMoZr+/Qg2FG0GJdA+emOk
         AwtL+KoQbd0/kIYi99rC2QbYoDludBkXQ8MP4p75zA4iAYq18Jw6jfq2MouRdOBvr4pC
         y8y8KLzrvq3165gFsArkBVYM6y7akJJFszR2x7JpnhFNMWZ2AL7/hnfupr7u0PonzupI
         VIzg==
X-Gm-Message-State: AJcUukdVVpakOFmhKPfYpD509Z7FqMdaRGMQKlYU5B3phNVt6pRRlApQ
        qsmLi0ojlPNMwLnA/NHDyTdFLQ==
X-Google-Smtp-Source: ALg8bN5KlKz0AXfWNIgOaB/cbM385RC0IWzxZIMG/e8cPTCg0kHF3VzRZvLbIXQovQ/JAuEHe4lcVg==
X-Received: by 2002:a5e:8817:: with SMTP id l23mr8059020ioj.272.1547760459428;
        Thu, 17 Jan 2019 13:27:39 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q76sm1032860iod.35.2019.01.17.13.27.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 13:27:38 -0800 (PST)
Subject: Re: [PATCH 05/15] Add io_uring IO interface
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Roman Penyaev <rpenyaev@suse.de>, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-arch@vger.kernel.org, hch@lst.de, avi@scylladb.com,
        linux-block-owner@vger.kernel.org
References: <20190116175003.17880-1-axboe@kernel.dk>
 <20190116175003.17880-6-axboe@kernel.dk>
 <718b4d1fbe9f97592d6d7b76d7a4537d@suse.de>
 <af41e99c-54f2-a94c-a876-d673fe477e0a@kernel.dk>
 <x49bm4f831e.fsf@segfault.boston.devel.redhat.com>
 <f5ecdead-ea0f-6b79-5f70-b002a103e503@kernel.dk>
 <02568485-cd10-182d-98e3-619077cf9bdc@kernel.dk>
 <x4936pr80uw.fsf@segfault.boston.devel.redhat.com>
 <3180aa85-68a6-0eb2-082b-f177344cefa9@kernel.dk>
 <x49y37j6lqi.fsf@segfault.boston.devel.redhat.com>
 <c86dbb69-1937-5a0d-11ff-98d933f6581a@kernel.dk>
 <x49tvi76kuy.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <efe49554-b163-9390-4cea-f6d8f990b2f3@kernel.dk>
Date:   Thu, 17 Jan 2019 14:27:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <x49tvi76kuy.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/17/19 2:21 PM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>>> So all we need to do is modify gpg2 so that is requires more locked
>>> memory, and we're golden!  ;-)
>>
>> Haha, that's some nice digging there!
>>
>> Yes, we could bump it, but with the default, we can get a 512 sized
>> ring per user, that's 13 pages (rounded up). Probably good enough to
>> get things off the ground?
> 
> Agreed.  I'll work on bloating gpg as a background task.  =P  Or I guess
> we could add instructions for modifying /etc/security/limits.conf to the
> man pages.

Pushed out with that. Yes, let's ensure that the man pages tell you how
to bump this limit. And we may just consider bumping the default 64k limit
to 128k on the side. Or maybe go crazy and make it 256k per user, damn.

-- 
Jens Axboe

