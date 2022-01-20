Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CECC433EF
	for <linux-block@archiver.kernel.org>; Thu, 20 Jan 2022 13:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiATNa0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jan 2022 08:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiATNa0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jan 2022 08:30:26 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B262C061574
        for <linux-block@vger.kernel.org>; Thu, 20 Jan 2022 05:30:26 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id r15so4954849ilj.7
        for <linux-block@vger.kernel.org>; Thu, 20 Jan 2022 05:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=5UnmskyHNG5ZrnVj7B952INTBTaxqow5mDngjiluqss=;
        b=z82sHatixwbGF6nSRmKEK2yFpA3IAXaEwW/S+J6o6sDDjca1Fy8/KPAozNr6sfXTjO
         OuAGFHna1qYnbM776n2NdROosJkwAezHPf+sMhNsMj0qXJtWZX1Azlz8C8W54/7RZrhv
         ntgw0+ge0d6qPCV/o1QfUl8APjIaU0BhWWu0e2D3FqF6kaPmL9goVH5d6d3d/1WzAvdx
         Na1EIPxHL6aIBpZrJ7FZc2ke7LGsCNVl/CN47M4d9cs7Hy/756jn2ZHYTzn3HmUxM9hJ
         EA792IXMuixzPX9teGd6+gFxa+d0kyYCwsIXAnCzVo5hxVNvWIEouYNQr3z+ln+6jfyp
         m1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=5UnmskyHNG5ZrnVj7B952INTBTaxqow5mDngjiluqss=;
        b=43VW9QAcbFMfue0z2eHdwf75xZe8/jXue0vhNZWsTzyaKL7B/tlgzDtdOI13jEV18+
         yV1A3D/eK8U24QKuH0dbUOYlpqEQ2Mttnh4GKXe/Od0SvsqagZRqYvvk6MxhcKk7Doaw
         dOZup4QFfAJDEaXnJYtTsaJ1YjKLtLOiJHlF+2DnhB8W4RzV9122Yn9W4yODYZS0vtP8
         ZE+K7cHjWuPu0DXMzjAxdIDUP/bsjzTxLUkdbPVf2Q5xx3PSViBzugq20ykl5crP595y
         TwH9Jy3JqMG8lt797Xp2P1MXm5xDrsdDyiNQ2H5PkDIslNip+7aRMHo56T4kxIqqkbSH
         0MrQ==
X-Gm-Message-State: AOAM530lrTt2oezT/vxoS/LI8nLoeyM1uL0henAG9PT/PxHPfBNh5Y+T
        mxHQvIT/DArZOM71nuz/DP9elw==
X-Google-Smtp-Source: ABdhPJwFZ5b64m2rn9m2glx8SvcTfImp5FdrnmiMhpWyVAVDt6YAodHnVu67dd/cOaF/8TP0QvZyrA==
X-Received: by 2002:a05:6e02:190e:: with SMTP id w14mr19686799ilu.191.1642685425422;
        Thu, 20 Jan 2022 05:30:25 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id d23sm1443754iod.26.2022.01.20.05.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 05:30:25 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-block@vger.kernel.org
Cc:     syzbot <syzbot+ac94ae5f68b84197f41c@syzkaller.appspotmail.com>,
        glider@google.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
In-Reply-To: <875yqt1c9g.fsf@mail.parknet.co.jp>
References: <000000000000880fca05d4fc73b0@google.com> <875yqt1c9g.fsf@mail.parknet.co.jp>
Subject: Re: [PATCH] block: Fix wrong offset in bio_truncate()
Message-Id: <164268542304.61815.9970184633084359443.b4-ty@kernel.dk>
Date:   Thu, 20 Jan 2022 06:30:23 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 09 Jan 2022 18:36:43 +0900, OGAWA Hirofumi wrote:
> bio_truncate() clears the buffer outside of last block of bdev, however
> current bio_truncate() is using the wrong offset of page. So it can
> return the uninitialized data.
> 
> This happened when both of truncated/corrupted FS and userspace (via
> bdev) are trying to read the last of bdev.
> 
> [...]

Applied, thanks!

[1/1] block: Fix wrong offset in bio_truncate()
      commit: 3ee859e384d453d6ac68bfd5971f630d9fa46ad3

Best regards,
-- 
Jens Axboe


