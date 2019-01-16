Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007ACC43444
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 15:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F7E205C9
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 15:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vAj/V75M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393967AbfAPPPU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:15:20 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37814 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393965AbfAPPPU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 10:15:20 -0500
Received: by mail-io1-f66.google.com with SMTP id g8so5149729iok.4
        for <linux-block@vger.kernel.org>; Wed, 16 Jan 2019 07:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uR0DDzuilglcjxF2/CBvrs5/40EJvUcTi57fBqp4aZ4=;
        b=vAj/V75Mgqchtik+Jwrb0LL7mViMec+uuTM7f0+RvNhzDPEwUMsVl5RDFqdJrUmNfx
         9gcTKIy+5TBmo9JN4UzDkyR7IVrpyU9TBpqKYNgG8rjA/RX5UzchhEdRPrTsRb/1klV1
         aLtL/uvS++VmW3cCzwV13ChCGnxEZl4Bk/dkvyzqbauEx9CgXG9p838QwOvaFrqNFjoL
         tLPW81VqOh65NVN3f8juC0aUH5x/3EQkkvuzznnWoSkqbP3ZvLdK4NPm6E4Ula1SoX8p
         vQk9MY8BFg765S4iQOt2+Muwww1q/3aaqrmbyECadUs0u1HzBAsxsCyJSdA9BHgMsNnS
         K6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uR0DDzuilglcjxF2/CBvrs5/40EJvUcTi57fBqp4aZ4=;
        b=hUOQW98GGkB1BYdLpaPrPtb8KsruZZr4Mz+k09ynffUCbEpL5cEwSiSYRcB2LE9ZA9
         /8pkkz0VamgUwYO1ik1uGBnJ0RRzdaf6PF1WU2UuM+NXhn3BYUxfcPRZEQwcZU+1oRcs
         hbGHAmpmKrnp3svBUPsXJme+2bBXc26LYlAJNP6+jREZg8nmy6Kn6f8eiMmtrB6Ap8VO
         CdGcWhPNL0HcprlXaeC+Kl3LYoTqh5YmhRt6ZjNcNCZVg65YI29gEFFlQlsCI/+l625v
         4lVVDcSkCzFGDPiIt4D/NfFcUnqo9KepEK5qbX6VaxUm7XNzbX3X6GKhLo0uUk1AWLBY
         Upbw==
X-Gm-Message-State: AJcUukfHUdA+7T2sH/jLHVIvl0gXReItoNt9xgPhxgmZ9BfDHrNtneV7
        shxQXN/JiObm8oC8041NyTXjzQ==
X-Google-Smtp-Source: ALg8bN7B0henLxV37MdK0ZhBDr9r+Zr9fkcvX99fkog3D+fnLIEJ+4uHTGz/fdf+cSY/nwlGLyaNXg==
X-Received: by 2002:a6b:6919:: with SMTP id e25mr4904938ioc.119.1547651719471;
        Wed, 16 Jan 2019 07:15:19 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id c21sm2440065iob.22.2019.01.16.07.15.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 07:15:18 -0800 (PST)
Subject: Re: [PATCH 15/16] io_uring: add file registration
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        Avi Kivity <avi@scylladb.com>
References: <20190115025531.13985-1-axboe@kernel.dk>
 <20190115025531.13985-16-axboe@kernel.dk>
 <CAK8P3a2oHO-q6Nes3uakjFVcwYOAPHvLMyQW_qQg1_47PfH8Ng@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d19dbfae-f424-8987-14a4-66f801f7fa71@kernel.dk>
Date:   Wed, 16 Jan 2019 08:15:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2oHO-q6Nes3uakjFVcwYOAPHvLMyQW_qQg1_47PfH8Ng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/16/19 3:45 AM, Arnd Bergmann wrote:
> On Tue, Jan 15, 2019 at 3:56 AM Jens Axboe <axboe@kernel.dk> wrote:
> 
>> @@ -132,4 +139,12 @@ struct io_uring_register_buffers {
>>         __u32 nr_iovecs;
>>  };
>>
>> +struct io_uring_register_files {
>> +       union {
>> +               __s32 *fds;
>> +               __u64 pad;
>> +       };
>> +       __u32 nr_fds;
>> +};
> 
> I think you should either remove the pad field here, or pass the pointer
> using a __u64 argument itself. With the current definition, the ioctl
> command code is the same between 32-bit and 64-bit architectures
> (since the length is the same on anything other than x86), but the
> structures are incompatible.

Ah ok, I think I'm starting to follow. Thanks Arnd, that's useful.
I'll make the changes throughout the structs.

> I would also suggest adding an explicit 32-bit pad field at the end
> of the structure, to avoid the implicit padding on non-i386 machines.

That's a good point, I'll make that change, that was an oversight.

-- 
Jens Axboe

