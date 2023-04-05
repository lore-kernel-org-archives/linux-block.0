Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAB5C76188
	for <linux-block@archiver.kernel.org>; Wed,  5 Apr 2023 10:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbjDEKxd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 06:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237597AbjDEKx2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 06:53:28 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B073E559F
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 03:53:25 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-54601d90118so513627067b3.12
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2023 03:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680692004; x=1683284004;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BF8S57zklCF7SEsUQ/f/6fRKqS2VWXlKEiFk3IkRkRs=;
        b=YN1D6LOtOFRSeouKb6cK3VN6jjVIlEMke0wFGzXTwKgvRRcLB5OfG8b0/gV4obNhpo
         9+S+aZrMGtdNH6hj10BKAj+XRr5GU4W/Y9a9BrgZERiquN+MIgRoQ/TV/q5cYuYFn4OA
         ODsCGShNoizOXXKgKSk7JIXAxaba6pguNHBo1jg6uX+M412FAnCF3RYcMMaMum7k3JyV
         iS+QPhm6UPhiGss0C6Z2n6Q9yYLmXkM2b1FT+cuoNFcjAj/aykM7u0ami4XIsmFGslQV
         uNkCltgQHeaDsNeOHP149IFzk51+dlDDSgRqJ3V7Ky71u1PQea8BlKvdV/DZvjQZpppR
         sqGg==
X-Gm-Message-State: AAQBX9fta4Qd7omwwvfxVU9G+3rS1tvFc3kKAsJGnQ2vgn+QOFE6TdW7
        NlK0GYqI6DaYsFpmzJvfFnJh/ZpVyAavlA==
X-Google-Smtp-Source: AKy350Zk7+yjHpjdCGvhfHuEJ5RNwN95bnjdVP7WQkhK5lDxglSvnm4fUZoE2xHB6ohAiMImd4fFqA==
X-Received: by 2002:a81:490b:0:b0:541:66d8:ef7 with SMTP id w11-20020a81490b000000b0054166d80ef7mr5361326ywa.4.1680692004453;
        Wed, 05 Apr 2023 03:53:24 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id bz2-20020a05690c084200b00545a08184b3sm3787604ywb.67.2023.04.05.03.53.23
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 03:53:23 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id j7so41987501ybg.4
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2023 03:53:23 -0700 (PDT)
X-Received: by 2002:a25:8487:0:b0:b26:884:c35e with SMTP id
 v7-20020a258487000000b00b260884c35emr1625689ybk.4.1680692003275; Wed, 05 Apr
 2023 03:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230322151604.401680-1-okozina@redhat.com> <20230322151604.401680-6-okozina@redhat.com>
 <20230405-komitee-treten-36f2c0a823b6@brauner> <36d11bf6-a0c9-b02f-020c-df25d06c7aee@redhat.com>
In-Reply-To: <36d11bf6-a0c9-b02f-020c-df25d06c7aee@redhat.com>
From:   Luca Boccassi <bluca@debian.org>
Date:   Wed, 5 Apr 2023 11:53:12 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnSw5xhEr_vEcOgk0WVhvQ1jFd3W5TJPx5erXpHkzzxpLQ@mail.gmail.com>
Message-ID: <CAMw=ZnSw5xhEr_vEcOgk0WVhvQ1jFd3W5TJPx5erXpHkzzxpLQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] sed-opal: Add command to read locking range parameters.
To:     Ondrej Kozina <okozina@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-block@vger.kernel.org, gmazyland@gmail.com, axboe@kernel.dk,
        hch@infradead.org, jonathan.derrick@linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 5 Apr 2023 at 10:39, Ondrej Kozina <okozina@redhat.com> wrote:
>
> On 05. 04. 23 10:27, Christian Brauner wrote:
> > On Wed, Mar 22, 2023 at 04:16:04PM +0100, Ondrej Kozina wrote:
> >> diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
> >> index d7a1524023db..3905c8ffedbf 100644
> >> --- a/include/uapi/linux/sed-opal.h
> >> +++ b/include/uapi/linux/sed-opal.h
> >> @@ -78,6 +78,16 @@ struct opal_user_lr_setup {
> >>      struct opal_session_info session;
> >>   };
> >>
> >> +struct opal_lr_status {
> >> +    struct opal_session_info session;
> >> +    __u64 range_start;
> >> +    __u64 range_length;
> >> +    __u32 RLE; /* Read Lock enabled */
> >> +    __u32 WLE; /* Write Lock Enabled */
> >
> > Why is that in capital letters if I may ask? That seems strange uapi for
> > Linux. And why not just "read_lock_enabled" and "write_lock_enabled"
> > given that we also have "range_start" and "range_length". Let's not
> > CREAT one of those weird uapis if we don't have to.
>
> See 'opal_user_lr_setup' struct above. Since the new command is supposed
> to return those parameters I did not want to add confusion by naming it
> differently.
>
> >
> >> +    __u32 l_state;
> >
> > "locking_state"?
>
> Same as above, see 'opal_lock_unlock' struct. It's even spicier
> considering it's impossible to set WRITE_ONLY state (lock only read I/O)
> with sed-opal iface.

Yeah we really want to keep the parameters names the same across the
various ioctl, otherwise it's going to get very confusing very
quickly.
