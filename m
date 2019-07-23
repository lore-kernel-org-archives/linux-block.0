Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039B9C76186
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 18:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4740218B0
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 18:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zxlu3jmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391455AbfGWSoL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jul 2019 14:44:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36122 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731007AbfGWSoK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 14:44:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id l21so19850012pgm.3;
        Tue, 23 Jul 2019 11:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=l9EaeUD1EfcP9AM3vJoniX4CCo7K4dxxFRLzu0GHOrU=;
        b=Zxlu3jmxs13GUbDTkNap3i3qoStYhkYZf7U+liKMi8gUVWJjM8iVC3bvvQ3kAp+Z+k
         2Sm1QuSxi7HlSgVXqHpokA2gfnj9+U4Ddgr33lGYdD/l0tU3Qi+UGnwxKWcWfUESiu21
         sUI6i5dL/V3Dq3LeXgExblTqRbw9u7R2dM6HGY5HPacn6Tl4wr1B2ci9LahiJfEv58zA
         TMSb45C9Fm3t4WteOpWzy6LEYoNQZF725a8PgsBP3HmNahf1qUo3gn1BgSphtC9x3wn0
         f3c5oc5Tw1gMFZxlI6GAILHgpwtrFqt9gZ5/tzeo+vpYRGGlGm2lXK8qkRLdh2UFcuHu
         lpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=l9EaeUD1EfcP9AM3vJoniX4CCo7K4dxxFRLzu0GHOrU=;
        b=uU8bZ61rPVnxkwPJBjbG7yFG+TXOrcZWWDzdStfOZanFRzIjJTVLcdAPpJe8WBr+sM
         e8/NcfDHRXmMyp3d39qmsI3zNVrlOsCdC5uklJwxlCzkh0H8+4dyEE4vDXNiApN5KFQw
         hX4SvmaYuDcgm91lvVaUhUhZMCIoCwVeF/9k1GQdW1AwVERrHHlyM1ufSdl4a6TKY0QD
         mxjdVmif+wRUBA1juMehqSodTlKE3k/jKJL1ELgD/6cwaVPE62PaNVkzeMGGiKE7BZsD
         3u0ncemi0cmtcxW4itLLA82EZgh2u09l9nZsmICQVqe7hoofY8JDizeTJV0Gd6MhxXp9
         jcAQ==
X-Gm-Message-State: APjAAAVJjIzApzTY35RPi1mUHefZFRGNwZUxVahwRoVweBZFZW/fS9E9
        kl/ZNkbUgUwJ2knTfzDWyG5By3hjLVc=
X-Google-Smtp-Source: APXvYqwJa3j/o2XLe1UaxJif7QRqQrhRsy7eCeK6wiIXqp5NzQp36EeLuZ8ufe4P3fZPIK/jd7Ihsw==
X-Received: by 2002:a17:90a:5887:: with SMTP id j7mr82726493pji.136.1563907449726;
        Tue, 23 Jul 2019 11:44:09 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id g11sm41007308pgu.11.2019.07.23.11.44.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 11:44:09 -0700 (PDT)
Date:   Wed, 24 Jul 2019 03:44:06 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
        Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>,
        Klaus Birkelund Jensen <birkelund@gmail.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Miwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH V2] lightnvm: introduce pr_fmt for the previx nvm
Message-ID: <20190723184406.GA28357@minwoo-desktop>
References: <20190723184243.4347-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190723184243.4347-1-minwoo.im.dev@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19-07-24 03:42:43, Minwoo Im wrote:
> all the pr_() family can have this prefix by pr_fmt.
> 
> Changes to V1:
>   - Squashed multiple lines to make it short (Chaitanya)
> 
> Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
> Reviewed-by: Javier González <javier@javigon.com>

Please ignore this one, sent a new one with V3.

Sorry for the noise.
