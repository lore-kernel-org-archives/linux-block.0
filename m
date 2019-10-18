Return-Path: <SRS0=h0yA=YL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610AACA9EA1
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 08:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251EB21852
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 08:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKgF2qgU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733304AbfJRI54 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:57:56 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:40276 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731444AbfJRI54 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Oct 2019 04:57:56 -0400
Received: by mail-lj1-f180.google.com with SMTP id 7so5396917ljw.7
        for <linux-block@vger.kernel.org>; Fri, 18 Oct 2019 01:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SfNoC+F6v5ki3pqEYjfX6cOPv4RA4U+8Hk1NTS35MIw=;
        b=RKgF2qgUS2Z4LsqD4udf23C1z/LnQvQl1y6QzWaQGSPlNmtwy36jRl5ThRCC7yIhPd
         6mHF2WE3Ip3NGym6Rl53118PrfmQS3tTJGiW1l0gTy+8mO9TQmZdGV2+WUk1fb8riUrI
         j4x4Tq6+7BckJO3ktJ2aB8uBIWs+aUtTk03DdVT4N9rE21dSSlM5UCCxo8Dg30c1Wk+R
         7yq4S7/z3v3s2tsDjrFLUCrU9sl4MaP6B4VJY4gxDOMEU2KyiTptU6LIdlQKhku6oYnD
         1G6c7QFYqR6AnFUAJYaJ4KeKTCSZ//90q+YIK9mknt8tbDiIUbh6++CL+NWrVd1u3jnH
         F7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SfNoC+F6v5ki3pqEYjfX6cOPv4RA4U+8Hk1NTS35MIw=;
        b=E4AkaFczV+g3hfjVY26mm+YrzK7RvKi/D9ak8SBH7hj6ZammHmy6N32ZTQ31FTf1n5
         JKEewXXKdzghIbtFHTZS+IQmuJWPb6EvrBvVn3572Tn2sfQIveVpw+b+ZQXdMem5Vzwt
         IZy7REvmbXK1uG8WNRVkaDm+1p3hM7ydVA5wuwqkHqpmBvSSKYiVlsA2u14AeifqEoQ0
         B0pn2N/ej1Sbx1lInU9GZQBp7D3HnFNxB7ppHCRJIZYp+zNLSp6PHnsdHxpH0UEyMamj
         bIkRtb69BeOCMDYFCmwGNlKuAic/x4E1ozBC8APPBqi3t42FS7RrIwgtOD0dQhCA/zQM
         Q6yg==
X-Gm-Message-State: APjAAAXTfFbkRNItKLqwt0/fLv8xrsCrNNMqvM/Y92mTH3+gsngh0WDm
        lwE6mTmyNv6v9/ZlxpEoBUZDu6JIFNDxLUcvK71QpGnv
X-Google-Smtp-Source: APXvYqxAxUdaLcpck0mXAI5BOIWKaU6jND83mdild9qiJPX+rawyzYmD6EeFrr9dLy/6e6cMcLC0Wkl5tgRs06kwXwA=
X-Received: by 2002:a2e:81cf:: with SMTP id s15mr4686971ljg.99.1571389074589;
 Fri, 18 Oct 2019 01:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191015170201.27131-1-9erthalion6@gmail.com> <af0fc0a7-11cc-08e6-cdfd-6b55fc208c8f@kernel.dk>
In-Reply-To: <af0fc0a7-11cc-08e6-cdfd-6b55fc208c8f@kernel.dk>
From:   Dmitry Dolgov <9erthalion6@gmail.com>
Date:   Fri, 18 Oct 2019 10:59:00 +0200
Message-ID: <CA+q6zcXjun0Vk8HLwyh7GHq=Qkm2V9OvSFQpGupQN+LDUSNfXQ@mail.gmail.com>
Subject: Re: [RFC v3] io_uring: add set of tracing events
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On Fri, Oct 18, 2019 at 1:28 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> Looks good to me, I've applied it for some testing. Thanks!

Thank you!
