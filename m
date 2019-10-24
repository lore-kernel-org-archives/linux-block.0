Return-Path: <SRS0=pYcy=YR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D22ECA9EAF
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 22:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BF321D7F
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 22:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fVhIIxCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbfJXWJN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Oct 2019 18:09:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41489 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730090AbfJXWJN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Oct 2019 18:09:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id l3so135478pgr.8
        for <linux-block@vger.kernel.org>; Thu, 24 Oct 2019 15:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E98M1/ou9fgCOAvOYwJOH7reFbR3fQSP3SjmG57QJLo=;
        b=fVhIIxCKBoeYpz5kchcql1q10bOMIPgeVBPM0TNDyhPye5wglH9Jq0ihZSDMyIxDwI
         VuJDbEUsacEbr60ewWSaPOmgJ6V2Vgm5QWC1ssrtH6eKvX7A0SIXdHY7MxnelLdorPpZ
         278LZzHUKXwoyCcV/xnK1ezKihm5DlNl2rwsaqQ/wNR0ijyp7UAW1TeWx47GpmcYOd0l
         psspdtsNCq6Q9sKKn/UqbW4n9mj9MSXGiJ1avJs9a486dzDu7dDrPm0IThyjSjgLymhp
         dA1kPnhxTmrvXC8WCzm9IW0lir+nEhy4Bmb4ShhpLFp73wkDB8lBJKORu62GkC+XYNGm
         Ex2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E98M1/ou9fgCOAvOYwJOH7reFbR3fQSP3SjmG57QJLo=;
        b=MHASNOXCMrkXAMn1AJUUa80QKww+Z0KAyeRcxFEIev6JH4QPJLcELYosYNnbz5bFQh
         NQ+isEkfgl5krG5bTdqmHFfx4vT6336dBNN8tLIheN7TmdUpk48O3spZ0974ow7JaK3M
         THrsq/mRabMlEUo4y727oiI6KJXy95SgSvWd0n8OJsnumff9acJ5rsvqXPAitWznXjRa
         cW2u58pQTMz0f3WE92INOQr1KJdvSjzF9I14V4PLAmqOKZH+OrMo33Y3r8yM6WNtZBeA
         MVtiq281ZvuDTPpTk7K6IGgpQROIMaO7hrbG+n/NQ6eACAxNJFGoaMH0fV8P1iDuSHzw
         qICg==
X-Gm-Message-State: APjAAAWVeUKgk2SulQdtj+no236NGqFEEBIEx5fatDxDdkTbC8A+kTpg
        30M5iKExgtaMQ/0gIf+1mWfu93thUlci4w==
X-Google-Smtp-Source: APXvYqzIPRcPAxlxKJyEDd0Ad165K5uAAla2IctOoZfjYN+rUky+SWiNHdESEshqbK4hFSYwbsLvtA==
X-Received: by 2002:a63:1564:: with SMTP id 36mr306748pgv.149.1571954952121;
        Thu, 24 Oct 2019 15:09:12 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id k7sm15844363pfk.55.2019.10.24.15.09.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 15:09:11 -0700 (PDT)
Subject: Re: [PATCH 1/3] io_uring: add support for async work inheriting files
 table
From:   Jens Axboe <axboe@kernel.dk>
To:     Jann Horn <jannh@google.com>
Cc:     linux-block@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>
References: <20191017212858.13230-1-axboe@kernel.dk>
 <CAG48ez181=JoYudXee0KbU0vDZ=EbxmgB7q0mmjaA0gyp6MFBQ@mail.gmail.com>
 <a54329d5-a128-3ccd-7a12-f6cadaa20dbf@kernel.dk>
 <CAG48ez1SDQNHjgFku4ft4qw9hdv1g6-sf7-dxuU_tJSx+ofV-w@mail.gmail.com>
 <dbcf874d-8484-9c27-157a-c2752181acb5@kernel.dk>
 <CAG48ez3KwaQ3DVH1VoWxFWTG2ZfCQ6M0oyv5vZqkLgY0QDEdiw@mail.gmail.com>
 <a8fb7a1f-69c7-bf2a-b3dd-7886077d234b@kernel.dk>
 <572f40fb-201c-99ce-b3f5-05ff9369b895@kernel.dk>
 <CAG48ez12pteHyZasU8Smup-0Mn3BWNMCVjybd1jvXsPrJ7OmYg@mail.gmail.com>
 <20b44cc0-87b1-7bf8-d20e-f6131da9d130@kernel.dk>
 <2d208fc8-7c24-bca5-3d4a-796a5a8267eb@kernel.dk>
 <CAG48ez2ZQBVEe8yYRwWX2=TMYWsJ=tK44NM+wqiLW2AmfYEcHw@mail.gmail.com>
 <0a3de9b2-3d3a-07b5-0e1c-515f610fbf75@kernel.dk>
 <CAG48ez1akvnVpK3dMH4H=C2CsNGDZkDaxZEF2stGAPCnUcaa+g@mail.gmail.com>
 <c3fb07d4-223c-8835-5c22-68367e957a4f@kernel.dk>
 <CAG48ez0K_wtHA4DSWjz4TjohHkMTGo2pTpDVMZPQWD2gtrqZJw@mail.gmail.com>
 <c252182a-4d09-5e9b-112b-2dad9ef123b5@kernel.dk>
Message-ID: <696ce52f-b984-e42d-d0f8-dae5695d4bab@kernel.dk>
Date:   Thu, 24 Oct 2019 16:09:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c252182a-4d09-5e9b-112b-2dad9ef123b5@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/24/19 4:04 PM, Jens Axboe wrote:
> Also added cancellation if the task is going away. Here's the
> incremental patch, I'll resend with the full version.

Full version:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-5.5/io_uring-test&id=24f099c6dd49fdedec464c5a7c0dfe2ac5f500d0

-- 
Jens Axboe

