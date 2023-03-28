Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B21CC77B61
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 14:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbjC1O7l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbjC1O7d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 10:59:33 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09A8E397
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 07:59:19 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id p15so15394658ybl.9
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 07:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680015555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/Tr76xWiRdPhCzh2iAIz1ngMVJemqmUsrV57MPqNeE=;
        b=Tt1MpwBCckGfBRJPyJn7mnYIufUfVxu0osm9Xuq8gDBzp9Zl5SijHD6x4KQjbrMWEh
         cR4itExVYXUY8HTQuYCWuV5Rg6H125SdaHSCPAvUlKamplxStCH4rjE2/WcnHTjKhjrt
         038rfwwfndQ2ou7fJtK3qBflN/A1iDRlkq81JX+Z7insN5nb1uTL0Uo01n0XraIao7M2
         Fdp9ucU3Ljn6qpuDyKhjPEtSctWImYf+1VP6nPOE2U4SSXgKWYIn4QDlVxtNK1zY5mgr
         bLTFWCgmCGlE6IuJslMe1IS18hr0AuFjkuVwxblk3dP0+AkaQl8W95dVHmZXdHKaN7fx
         PZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680015555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/Tr76xWiRdPhCzh2iAIz1ngMVJemqmUsrV57MPqNeE=;
        b=TZ/Q4zu+MlL7owQE39BkaO9xU2fhV8XzrGQFILi6sTl0pl27xfOgNHa23/T979+olB
         nuc9D3tGXrUUtiRBX9MrTChvvnLdwKRqhTtbKEmJ8lAHwL/Hhnrpe0PR6ubVDvjoGY82
         3n37337YaEIPMvdKi/m3egF6UAy52O97AAQ4dN+eCNNwsmoazz4Jt+K3q3SaGKBRxP70
         IjONKVtoAVjYXkzX7tvl+IEe0djWUoZ6WXK0QAQT2zIZmbeo4HfDwvIPEd6QoWQuDhAf
         aaTLDlojNOdNh9PWYYEpm6fFIlo38PuqLQGl0NysVy9rENnWJjNDRWZ8goh/SR8Qzv+L
         xg9Q==
X-Gm-Message-State: AAQBX9eF3IfT+Udrh8zhYrl2uXcyFw2QB/gHbEEPIz7RLVxtBoe1x9fl
        eUVgikjblatOj0QJhy/T6eUaTKTOCzDeDfVD+ScvcA==
X-Google-Smtp-Source: AKy350aNQtresOYs68OKsUS0vcF2N6XmOyJ60HmYb6YXhXcoQU+dKlCLTm68Gcz+3vaqlOs4fNhYSgxXyk+d8mzAE3I=
X-Received: by 2002:a05:6902:1108:b0:b6d:fc53:c5c0 with SMTP id
 o8-20020a056902110800b00b6dfc53c5c0mr13259448ybu.1.1680015555044; Tue, 28 Mar
 2023 07:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com> <20230328061638.203420-5-yosryahmed@google.com>
In-Reply-To: <20230328061638.203420-5-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 28 Mar 2023 07:59:04 -0700
Message-ID: <CALvZod4zLhgjd3Tr5Qauz+OwF7Gj-NwDZPMpYAsxaMSUvu3F4g@mail.gmail.com>
Subject: Re: [PATCH v1 4/9] cgroup: rstat: add WARN_ON_ONCE() if flushing
 outside task context
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 27, 2023 at 11:16=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> rstat flushing is too expensive to perform in irq context.
> The previous patch removed the only context that may invoke an rstat
> flush from irq context, add a WARN_ON_ONCE() to detect future
> violations, or those that we are not aware of.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
