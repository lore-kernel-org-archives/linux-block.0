Return-Path: <SRS0=kmcw=XN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2836C4CECE
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 16:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E0B21927
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 16:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NkofmqnC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfIRQTq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Sep 2019 12:19:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40503 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbfIRQTq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Sep 2019 12:19:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id l3so55420wru.7
        for <linux-block@vger.kernel.org>; Wed, 18 Sep 2019 09:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jkRvwN7j8d6+3yYxujaDpdYkk73iNWb6wxPtS0qswdE=;
        b=NkofmqnCSprkwxBJoUDKnTb+3Uj/9yc6OmR4Yulm/W/mK7DM5Yry64Bb0TLfbeA4w/
         0L360/+PzUU7wzqahEZy7qO+5UvxDTAuFOwOCAlEg3LFZvahuaRqYvKBr9K10Xko2Cx+
         XHb6rYgdUm5i86gYRLXVj6258yQs9Qw1UUxnefk5no8k4IgTFts/Ue/Ou5RUqYyJHQOv
         UFME+F58lY294Ujkr+Mw7u0QddYKlPHlIRh8zdFjNIMsMF1PIOFTOFLfuZsWEhEiI1+y
         rNCoJv6uVhgfXsk+B7W/Laa1irG7idIEgpNZWvrfpDHtsFgiepPac8d3vgK4e82lcrgY
         Gciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jkRvwN7j8d6+3yYxujaDpdYkk73iNWb6wxPtS0qswdE=;
        b=JN+XNvi+cYv+pCD7o8XIq/ollgOzpLly/SP4fUulZ65nr11JaWjSoAa8oX75/lXChQ
         16xdKnBPKx/rcx5w9iQDLE8WEA7jXoZVz4UnRm0nhKB+gwiOkcoLWjeLpqM2vTma27wq
         55XDSm/eaH4rXW57k+YdSI6z6N0Kg96gP7W1lKD3KcB3oxVXMxkuocFKfQhaacbEHRNj
         TBjlM9g8be3i1GklYI0cupjL6UV63F2Oaaume5azMh/1e5ZaZ6Mfqe2AZ91tCZoH12yn
         D+ey8gfmkz2gEIA+gXSS83y3PpaUbjNJS92lqttr2H6OMNHTnOIlO6bH1nuwHlH0u0Oo
         BUhQ==
X-Gm-Message-State: APjAAAXIlOXiml9VOKwMw6vi+1c0c2mH0OKl7cXi1x8azj0trTaCSxiL
        vICfkqanNumgy6NeNX8tRhvdJQ==
X-Google-Smtp-Source: APXvYqxG3GZQpL0HIFBdWAF2a/qxLz0iEIJr3xmJKW6qnJ6mfouGFwWt9YLefI+hWVtg6SpdqccGFA==
X-Received: by 2002:a05:6000:14b:: with SMTP id r11mr3737040wrx.58.1568823583638;
        Wed, 18 Sep 2019 09:19:43 -0700 (PDT)
Received: from [192.168.0.105] (146-241-52-159.dyn.eolo.it. [146.241.52.159])
        by smtp.gmail.com with ESMTPSA id c132sm4283228wme.27.2019.09.18.09.19.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 09:19:43 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 2/2] block, bfq: delete "bfq" prefix from cgroup filenames
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190918151948.GL3084169@devbig004.ftw2.facebook.com>
Date:   Wed, 18 Sep 2019 18:19:42 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        noreply-spamdigest via bfq-iosched 
        <bfq-iosched@googlegroups.com>, oleksandr@natalenko.name,
        cgroups@vger.kernel.org, Angelo Ruocco <angeloruocco90@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4F416823-855F-4091-90B9-92253BF189FA@linaro.org>
References: <20190917165148.19146-1-paolo.valente@linaro.org>
 <20190917165148.19146-3-paolo.valente@linaro.org>
 <20190917213209.GK3084169@devbig004.ftw2.facebook.com>
 <4D39D2FA-A487-4FAD-A67E-B90750CE0BD4@linaro.org>
 <20190918151948.GL3084169@devbig004.ftw2.facebook.com>
To:     Tejun Heo <tj@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 18 set 2019, alle ore 17:19, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> Hello,
>=20
> On Wed, Sep 18, 2019 at 07:18:50AM +0200, Paolo Valente wrote:
>> A solution that both fulfills userspace request and doesn't break
>> anything for hypothetical users of the current interface already made
>> it to mainline, and Linus liked it too.  It is:
>=20
> Linus didn't like it.  The implementation was a bit nasty.  That was
> why it became a subject in the first place.
>=20
>> 19e9da9e86c4 ("block, bfq: add weight symlink to the bfq.weight =
cgroup parameter")
>>=20
>> But it was then reverted on Tejun's request to do exactly what we
>> don't want do any longer now:
>> cf8929885de3 ("cgroup/bfq: revert bfq.weight symlink change")
>=20
> Note that the interface was wrong at the time too.
>=20
>> So, Jens, Tejun, can we please just revert that revert?
>=20
> I think presenting both io.weight and io.bfq.weight interfaces are
> probably the best course of action at this point but why does it have
> to be a symlink?  What's wrong with just creating another file with
> the same backing function?
>=20

I think a symlink would be much clearer for users, given the confusion
already caused by two names for the same parameter.  But let's hear
others' opinion too.

Thanks,
Paolo

> Thanks.
>=20
> --=20
> tejun

