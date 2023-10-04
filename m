Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530FFE936E1
	for <linux-block@archiver.kernel.org>; Wed,  4 Oct 2023 20:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbjJDUbL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Oct 2023 16:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244973AbjJDUbK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Oct 2023 16:31:10 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45389AD
        for <linux-block@vger.kernel.org>; Wed,  4 Oct 2023 13:31:02 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-41812c94eb5so1330961cf.0
        for <linux-block@vger.kernel.org>; Wed, 04 Oct 2023 13:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696451461; x=1697056261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXYkNNwyK1dpfEtHp9sOFR0NjxTumXuiYxFY0CQML8E=;
        b=Yb/yLZ/lSKqCcNTFd0++jfe7LwtA1e2a8fxeowPvo/ZqVvAxCu+eFjSfwtxq4GwSp0
         qQ1jy/fxuFb1yaqaYa/1Bi1CvsCNRFEaFo7kHIcJu1+M/U+xfJ3IqjFmPw1VhpAoPDfp
         Nfd1qFtaYZ1veD5XH8E6d/9JxtzEc4pQAwljQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696451461; x=1697056261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXYkNNwyK1dpfEtHp9sOFR0NjxTumXuiYxFY0CQML8E=;
        b=vPElGA+8Daq8kb0tboFumUKI4Xl9EuYaO1QELW4V+d8Wxx3ZYwFVTlZ8UhyGZj1Ucp
         AWj53TL+quLQbhRzDpW6uYukcpEbuBsQXMJQ0kAZiMdmJH/CqmZpy0m11dxGaTJdeLGq
         CD/66W1tEDjM2i5OdWEoJkmzx+9/hu4zAglufh1W8mNw6kOMOor+TOowIxcsZFHUnjj7
         dEAnukWV+CzEI9jzuoFV93OXvLmQGRVI4pEebbmr5ZmtXGTBSq6s3XUnoirR5RaKAEL+
         rXVR5bO4Dp5CC/2y4DUWtIFN47xs/csGlcmmRhM8agKAVtiDDTxOLQUOX9d4OgYSDaT8
         Qv5A==
X-Gm-Message-State: AOJu0YxzxTPhNK8KTk3A9IJwwMY8o8llGu/I9ot7WkfawT24rOVrHG4t
        uSJRabKwrYnKp/Yr6OqPv+s5SEXY1SmHQxgrHzE=
X-Google-Smtp-Source: AGHT+IEiH4wwwivtm03EYHk+qsFjMoj4wUCbpITTaJVN4q5Fih8h5XGoPPzAkDQiVMgLuN/4e0dCzQ==
X-Received: by 2002:a05:622a:11d0:b0:417:b746:8dec with SMTP id n16-20020a05622a11d000b00417b7468decmr3874943qtk.58.1696451461037;
        Wed, 04 Oct 2023 13:31:01 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id kr19-20020ac861d3000000b004197d4a4335sm385qtb.22.2023.10.04.13.30.59
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 13:30:59 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-419886c7474so15011cf.1
        for <linux-block@vger.kernel.org>; Wed, 04 Oct 2023 13:30:59 -0700 (PDT)
X-Received: by 2002:a05:622a:1a92:b0:419:6cf4:244f with SMTP id
 s18-20020a05622a1a9200b004196cf4244fmr64519qtc.20.1696451458698; Wed, 04 Oct
 2023 13:30:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230928015858.1809934-1-linan666@huaweicloud.com> <ZR29mvoQMxcZcppw@slm.duckdns.org>
In-Reply-To: <ZR29mvoQMxcZcppw@slm.duckdns.org>
From:   Khazhy Kumykov <khazhy@chromium.org>
Date:   Wed, 4 Oct 2023 13:30:44 -0700
X-Gmail-Original-Message-ID: <CACGdZYLFkNs7uOuq+ftSE7oMGNbB19nm40E86xiagCFfLZ1P0w@mail.gmail.com>
Message-ID: <CACGdZYLFkNs7uOuq+ftSE7oMGNbB19nm40E86xiagCFfLZ1P0w@mail.gmail.com>
Subject: Re: [PATCH] blk-throttle: Calculate allowed value only when the
 throttle is enabled
To:     Tejun Heo <tj@kernel.org>
Cc:     linan666@huaweicloud.com, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 4, 2023 at 12:32=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Thu, Sep 28, 2023 at 09:58:58AM +0800, linan666@huaweicloud.com wrote:
> > From: Li Nan <linan122@huawei.com>
> >
> > When the throttle of bps is not enabled, tg_bps_limit() returns U64_MAX=
,
> > which is be used in calculate_bytes_allowed(), and divide 0 error will
> > happen.
>
> calculate_bytes_allowed() is just
>
>   return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed, (u64)HZ);
>
> The only division is by HZ. How does divide by 0 happen?

We've also noticed this - haven't looked too deeply but I don't think
it's a divide by zero, but an overflow (bps_limit * jiffy_elapsed / HZ
will overflow for jiffies > HZ). mul_u64_u64_div_u64 does say it will
throw DE if the mul overflows

>
> Thanks.
>
> --
> tejun
