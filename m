Return-Path: <SRS0=Rcoh=SY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D55C10F11
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 13:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C792064A
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 13:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VoS3xNhu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfDVNlq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Apr 2019 09:41:46 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35177 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfDVNlq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Apr 2019 09:41:46 -0400
Received: by mail-io1-f67.google.com with SMTP id r18so8684809ioh.2
        for <linux-block@vger.kernel.org>; Mon, 22 Apr 2019 06:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=u3wViDHeG/89EKKZKpQYGfSxP6Rpc7NezXV58Gpag2I=;
        b=VoS3xNhupmKe++zC0Ywd2E/SLtayfiV5JaZLzbJuhPkWZAqBPhOdpoUaZjf5ikK1vA
         AQ1C24RDc9ON6KSCfQY7z+1MxuCKmLwlWXj3gYYkvqeozad7ctZBGlAygXzd27kisReZ
         cCGq7N8J5Til4elE6JJ8HxILJo1M6vY+qcBnr4MLOMHtkMPLyfnInS0Aewd90cKI8Ey3
         Om2TGCrh8RtvQtI70vAIl4f3WIH8jpJBfx05tvXKZXIrzORdiF15IH9iYAEHhWRaK8AY
         0gXFIPsjiO8raXVzwBTZ1gKxRnBo7gRwD9x3NfriqlHL0db/llRgY+MBdyb/SYx500y1
         r8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=u3wViDHeG/89EKKZKpQYGfSxP6Rpc7NezXV58Gpag2I=;
        b=DT8tdSf7/kWCzj49OG5GVaeX3dxpuHk6VEMsokN2ij/FYKaChKRBz/ZkGxaN/N6Vx6
         MVmj5AOZXaAooPbbQsLATzlf6u4ItnmNtMcRFSrAPLRbik34K8MxdCRCuSIBrkzpPRXw
         z2YT9nZ28kqZLem3cLTieFQEquRjPHDj+zT+lSs2dpOk1nrN4ySaVYkEo2GdTD3XoZvh
         afaRfq5LeNFchu8a9KLklXcXsq3nQ/bUgnF+PWLR+s/hqAfcxQZxeDv7yoAP3DVdcbg3
         +8MqGrf3cQ/JhPriFF/Mp9NwJlEbhko5+r60eNyttoHawLHwJ2UyKfZQj0i/sW7uBvmW
         fBdg==
X-Gm-Message-State: APjAAAWtpggs73U0I6UilSVPpJJAjNY5OJqwfvfH7lwb27fc2FcTmc6B
        FSabVApn+scyDSTWrKahzPv1pt76nLAF6XFNi8JY28OxqE4=
X-Google-Smtp-Source: APXvYqzkcjSDfD2kj2NaOWWE/XH4GRlcsu1qKP9UA9ItsTxThbqvQCZa1IdMqr3pJCA58pFbZSOUi7YAIsT+Vv2vB4o=
X-Received: by 2002:a5e:9b17:: with SMTP id j23mr13318367iok.60.1555940505285;
 Mon, 22 Apr 2019 06:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAKv+Gu-fprVgQ576__VDZ1L8HRghtCus_E-F0Q3gRzDLN=pjtQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu-fprVgQ576__VDZ1L8HRghtCus_E-F0Q3gRzDLN=pjtQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 22 Apr 2019 15:41:34 +0200
Message-ID: <CAKv+Gu-WZLo7UJd8k9Q2piEaJ8E319XRGheratuR47sfbH_DUg@mail.gmail.com>
Subject: Re: breakage after "io_uring: offload write to async worker in case
 of -EAGAIN"
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        rpenyaev@suse.de,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 21 Apr 2019 at 10:33, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> Hello all,
>
> I ran into an issue booting a graphical desktop (GNOME) on an ARM
> based system with nvidia graphics and the nouveau driver (which is the
> only one available on arm64). Bisect identified the following commit
> as the culprit
>
> commit 9bf7933fc3f306bc4ce74ad734f690a71670178a
> Author: Roman Penyaev <rpenyaev@suse.de>
> Date:   Mon Mar 25 20:09:24 2019 +0100
>
>     io_uring: offload write to async worker in case of -EAGAIN
>
> and reverting that on top of v5.1-rc5 gives me a working system again.
>
> I don't see any errors in the kernel log, but the graphical desktop
> never comes up. I can still ssh into the system and everything else
> appears to work normally.
>
> I'm a bit out of my depth there, so could you please help me diagnose
> this further? Any conditions I should check in the 'else' path?
>

Actually, I am struggling to understand why this particular commit
would make a difference on a Debian Stretch based userland, since I
don't suppose the new syscalls are being used there yet ...
