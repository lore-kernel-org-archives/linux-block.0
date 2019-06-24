Return-Path: <SRS0=7YUI=UX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829B6C43613
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 19:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A6120674
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 19:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nZF7W2zl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbfFXTSW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jun 2019 15:18:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46353 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729083AbfFXTSV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jun 2019 15:18:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so15051582wrw.13
        for <linux-block@vger.kernel.org>; Mon, 24 Jun 2019 12:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lxEW1OohvlQcLnagUdrYZ6F+TsIBwQcFUxd02nvE+RU=;
        b=nZF7W2zlo265XbVDmUW32F/aZ/dmrJn/qv/ufMVAlkQ7G2TrlSGoiJV6JG7i5WkRNN
         myB610ho4vcL4xXltP4/bhb/3bomHurKJAsfS9/sIcp4N0WQCkdWItPgN45uKFCAwlIb
         Q+HZtCD4EYL+HhNkgFJ0kzouqPVZIneLjqPMjYxcH5WbR8IOn1BiWSKF3jpA3c3X8YKg
         VYmlBt00NjmVCB71z12QU+9+1ZW9ZomzmoQ1tgVxncZB3bJhN3+R5v0UOo2JgWHUvTL1
         vxDKeEzSc/GSdp84fsOljLUkAhtj9f+SDApmZNGkgn3gTeigKk5X39cqqd5Ai70onFJ/
         KnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lxEW1OohvlQcLnagUdrYZ6F+TsIBwQcFUxd02nvE+RU=;
        b=tTh2duVYv9U5yHVj/iTR/VdJMQMWe7T73t4ehHy9WCfyZ94ZNuiWKhrmMrmJYLJ2Do
         ejyP4+daY/CS8CoD14G1yrpiuHO+utosSi0gvwyX8XaRF6W6avq30CoAege+IjH7y/+Z
         9SnLwBqPGJMWeINxuzVBX8ZzV4Tb+249vTXrfyJUt8+NfhnnbNMfgWCNhQPYiHIzD9Zl
         ZE+3PGWix02zkT3cD88jgF6/t9XMNO4ORJxSB4jpj3lrudjdSNZzTvq3Td34NpyqtRbR
         A+9u0Xe/2Vi5sVquOxjhiUQnEa43/mwDrKNWA9dzDgk//z/QgstVw1LYuZ/+gj55jOJe
         oQCg==
X-Gm-Message-State: APjAAAWDaE4ciPCfYFY2V9GFWSzUoG/vxy9PMWWQPafrQBVQhSe2rZK5
        2HCBvwiQU4blcPXX/UToWg9ujw==
X-Google-Smtp-Source: APXvYqy4h5N/FeLOcZq3C1dFJDFd9oY8xJ0xWTlvXWev+mU7fzOJSsCmLphcLGBac/kUFB96zQ1acQ==
X-Received: by 2002:adf:e301:: with SMTP id b1mr22616047wrj.304.1561403899298;
        Mon, 24 Jun 2019 12:18:19 -0700 (PDT)
Received: from [192.168.0.103] (146-241-101-27.dyn.eolo.it. [146.241.101.27])
        by smtp.gmail.com with ESMTPSA id a7sm12181604wrs.94.2019.06.24.12.18.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 12:18:18 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH BUGFIX V2] block, bfq: fix operator in BFQQ_TOTALLY_SEEKY
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <aec3e7b1-c235-ddb1-62b2-4ad7a7246a35@kernel.dk>
Date:   Mon, 24 Jun 2019 21:18:17 +0200
Cc:     linux-block <linux-block@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name
Content-Transfer-Encoding: quoted-printable
Message-Id: <D9A203CB-DDA2-4C67-A20C-A3CA7354E3FB@linaro.org>
References: <20190622204416.33871-1-paolo.valente@linaro.org>
 <aec3e7b1-c235-ddb1-62b2-4ad7a7246a35@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 24 giu 2019, alle ore 18:12, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 6/22/19 2:44 PM, Paolo Valente wrote:
>> By mistake, there is a '&' instead of a '=3D=3D' in the definition of =
the
>> macro BFQQ_TOTALLY_SEEKY. This commit replaces the wrong operator =
with
>> the correct one.
>=20
> A bit worrying that this wasn't caught in testing, as it would have
> resulted in _any_ queue being positive for totally seeky?
>=20

Fortunately there's a somewhat reassuring explanation.  The commit
introducing this macro prevented seeky queues from being considered
soft real-time.  And, to be more selective, it actually filtered out
only totally seeky queues, i.e., queues whose last I/O requests are
*all* random.  With this error, any seeky queue was considered totally
seeky.  This the broke (only) selectivity.

> Anyway, applied.
>=20

Thanks,
Paolo

> --=20
> Jens Axboe
>=20

