Return-Path: <SRS0=i+2c=SP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC33C10F11
	for <linux-block@archiver.kernel.org>; Sat, 13 Apr 2019 21:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C88C82147A
	for <linux-block@archiver.kernel.org>; Sat, 13 Apr 2019 21:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555191230;
	bh=T4zFi8HUyLT04ErtqNLZ3ag+psNH6G5n7pdi+X447zQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pxjTuBgZHgOlIpsiWl+oDH/rL0oR86GeQc8DVvn14Lcz+2GM7z0Bzlrq9LdbWSxQe
	 1O1OWd3x0VQaqv0BH0wSMNt6sOIZsNu9EL1fk2Vvg1JHVRBfeXE1fXKNndLLx5NUeH
	 fvNxPru0sB5tN2MjEE0HqLNqWBhwcX7a3uCRIoeA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfDMVdu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Apr 2019 17:33:50 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:39458 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfDMVdu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Apr 2019 17:33:50 -0400
Received: by mail-lj1-f170.google.com with SMTP id l7so12014137ljg.6
        for <linux-block@vger.kernel.org>; Sat, 13 Apr 2019 14:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KasGhybau6ek/8+iIopVBWcSFetIrvLvLo2a/tRGx+c=;
        b=G8FeKcUPrVzHeQWXrIwzWYxHT0jzin456FHmDTyHTY1Dv6E6kfw9BWr7bIT56oTIuY
         yumajpnVrL8tpkIanA6axbkMBgHCkKny/CQGrUZVp2HpHu6OpMV7hsdcWP7I7YXKElOa
         XuJhaNdS7Vhp3htd/lKNaJmkPn6h3hnrF6Rkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KasGhybau6ek/8+iIopVBWcSFetIrvLvLo2a/tRGx+c=;
        b=fwjruMcGMMl6MIrzgYQlj9KyuPAhmM89qqYvuJl0gJoldMRMbuCOETeLWXm3ZqeM6k
         x/Z2IVut7lr29se+y6POYB5vdYYQW+ph0Ha3z4yqRtJTPGi00ON68Qdcr14LrGCT+j3m
         QiDpfqTvCSMxTeNow+KRg5ckdm0mkCG0D45noqDK3+PSqr2SXlP5Wzta7G066ExO85dl
         guzr7ppAFHQ0dogLXjT8/mw/cv/IWeFNkt1eUdAf4zNCPKk47+royvjscTGWWCd/Goqy
         keLCNzH1hw0IHYU1UpPP+qUj9BnHEZBU+k9AZ2yPFFlCAIRTQT3t+bK0s5lvuh1b4LnM
         JgPw==
X-Gm-Message-State: APjAAAWa2O2VMVSqHqDRUHWhcHUG6JZmAhHWVS6MEaZze0YPMTKsxFyP
        U6N0tcOThppRb6zOslOaPNm3VnRx1Fg=
X-Google-Smtp-Source: APXvYqx97N5YdP7BQUxstL9UIviuZK/zL1kUF4QkiVeyw5gN05qoPiMOrmTBPtKn4cYHB8vtlSPD9Q==
X-Received: by 2002:a2e:9348:: with SMTP id m8mr16548874ljh.23.1555191227513;
        Sat, 13 Apr 2019 14:33:47 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id y3sm9123690lfh.12.2019.04.13.14.33.46
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 14:33:46 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id j11so10149279lfm.0
        for <linux-block@vger.kernel.org>; Sat, 13 Apr 2019 14:33:46 -0700 (PDT)
X-Received: by 2002:ac2:495e:: with SMTP id o30mr13534890lfi.35.1555191226045;
 Sat, 13 Apr 2019 14:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <79665835-13af-ad47-14a0-2b377bc356dd@kernel.dk>
In-Reply-To: <79665835-13af-ad47-14a0-2b377bc356dd@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 13 Apr 2019 14:33:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZHvghu6iZYkPCUxZ-g5b4xREdAU6zWSfPs7M7P4hKdw@mail.gmail.com>
Message-ID: <CAHk-=wgZHvghu6iZYkPCUxZ-g5b4xREdAU6zWSfPs7M7P4hKdw@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 5.1-rc5
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 12, 2019 at 12:04 PM Jens Axboe <axboe@kernel.dk> wrote:
>
>   git://git.kernel.dk/linux-block.git for-linus-20190412

That tag does not exist. There's a for-linus-20190407, but not a 20190412..

Pls advise,

               Linus
