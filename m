Return-Path: <SRS0=KeVv=B4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8FAC433E1
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 21:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55E7C207BB
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 21:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597785799;
	bh=94loho5QZHl6BzrcD1cKQZk9CXgJR8XXN2SLmIF24EQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jdi0Cl2zIhEds+nesGERFy0skP39TjoLButf4cot9V3cYm9veZ8LlhdQ4YsdzZfKd
	 FGRdChatZvZ2u5jAPGbLofyCpoMHYQlyY9f9ACKjH2R7MS6QCr+qT2NF5mnIuUeC8y
	 KvZ/5NTTpmjbvclPRZRBxCtu08MUGbmhzK+fOJjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgHRVXS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Aug 2020 17:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgHRVXR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Aug 2020 17:23:17 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487B4C061389
        for <linux-block@vger.kernel.org>; Tue, 18 Aug 2020 14:23:17 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t6so23032754ljk.9
        for <linux-block@vger.kernel.org>; Tue, 18 Aug 2020 14:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OmT1FnyKo0Wh0P/+e3N7XEqd970i7QN9hATVR3Wn72s=;
        b=A1iWJUOnVvpbPtv02YJX1HZW38lw6NpFYmwM52mi7mqWHhWUhxFQTg1UJ1POjyz5Gl
         egyt5IzBgtSW0X+y82qWLoeHa4zZ9Z4tojBV3oCjS2epRM87Xwon7UxOwlM/GYmBtrvp
         ssPxh1W8HTKARwlpR3cjwvzcKopqh4uALH6lA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OmT1FnyKo0Wh0P/+e3N7XEqd970i7QN9hATVR3Wn72s=;
        b=Eaou8UJaer7q5vtiKRynfld+NRAUtzfvVQDTcbFofLyxmPW81b1P3IIqbB+TBAQSbB
         XY+YwpBPncMrITqs0HXsyRnW1mOgXaVkvpvYogI3fkMeWc6zdUslkQM/fy8qy08h7Ya8
         IalHlCTyFZZfS50OjMAG72xcYDh5cYBsbJeIoTw6AllasDQHYzu2h8M6C0BCYxpwv1gU
         VSekpH0piuWYjayFYtwtqwIfOhZWiSwCDP1qJK0+EYPIDjD805DKDPlHij9DAldvb/df
         PLFHz0ubG7kRUARBk18Md68SaRzXAnPsLpybGGQkj1YQ0UKrKcxChyDQKiyAbLu3jFgp
         eRuQ==
X-Gm-Message-State: AOAM531F4VgL2mO5qk6rNQvkH1NBncWohwKMpC6YID40SwV0zbZ7RcCg
        /ZxL2700FOezN0542UUWmgxN18lZso5J7Q==
X-Google-Smtp-Source: ABdhPJzUKa0ZL8ABgxYiQc8vO13SqIugg7xTcki2WUSRKu8A2CaU5SG7AKQbmlCeUrwVu8KN3N59oA==
X-Received: by 2002:a2e:9f4c:: with SMTP id v12mr9776209ljk.139.1597785795369;
        Tue, 18 Aug 2020 14:23:15 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id m142sm6805854lfa.47.2020.08.18.14.23.13
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 14:23:14 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id t6so23032648ljk.9
        for <linux-block@vger.kernel.org>; Tue, 18 Aug 2020 14:23:13 -0700 (PDT)
X-Received: by 2002:a2e:92d0:: with SMTP id k16mr9890735ljh.70.1597785793360;
 Tue, 18 Aug 2020 14:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200807160327.GA977@redhat.com> <CAHk-=wiC=g-0yZW6QrEXRH53bUVAwEFgYxd05qgOnDLJYdzzcA@mail.gmail.com>
 <20200807204015.GA2178@redhat.com> <CAMeeMh_=M3Z7bLPN3_SD+VxNbosZjXgC_H2mZq1eCeZG0kUx1w@mail.gmail.com>
 <CALrw=nHD81X4YCpuk-Pp9_FSFba6LZEVUwo-YkYh1nL9pEbzpA@mail.gmail.com>
In-Reply-To: <CALrw=nHD81X4YCpuk-Pp9_FSFba6LZEVUwo-YkYh1nL9pEbzpA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Aug 2020 14:22:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj95eQxPOEMHe8j3zmpZYHbv8kZ0nz8fUUCO6acENTs0w@mail.gmail.com>
Message-ID: <CAHk-=wj95eQxPOEMHe8j3zmpZYHbv8kZ0nz8fUUCO6acENTs0w@mail.gmail.com>
Subject: Re: [git pull] device mapper changes for 5.9
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     John Dorminy <jdorminy@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Alasdair G Kergon <agk@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        JeongHyeon Lee <jhs2.lee@samsung.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        yangerkun <yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 18, 2020 at 2:12 PM Ignat Korchagin <ignat@cloudflare.com> wrote:
>
> Additionally if one cares about latency

I think everybody really deep down cares about latency, they just
don't always know it, and the benchmarks are very seldom about it
because it's so much harder to measure.

> they will not use HDDs for the workflow and HDDs have much higher IO latency than CPU scheduling.

I think by now we can just say that anybody who uses HDD's don't care
about performance as a primary issue.

I don't think they are really interesting as a benchmark target - at
least from the standpoint of what the kernel should optimize for.

People have HDD's for legacy reasons or because they care much more
about capacity than performance.  Why should _we_ then worry about
performance that the user doesn't worry about?

I'm not saying we should penalize HDD's, but I don't think they are
things we should primarily care deeply about any more.

               Linus
