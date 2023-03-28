Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64436C77B60
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 18:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjC1Srv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 14:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjC1Sru (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 14:47:50 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB94B1FF5
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 11:47:48 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id eg48so53556023edb.13
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 11:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680029267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I8WAHPAOnoIsGbAeWRafsGc8bwd2YsHJNAiOdGspwD8=;
        b=2tUg7yrV99oGL+e/zjpM6igGege2u9YnHOxxfFKTkkGmkvvsMuO5PP2CzmH4hK514p
         OzAsp3rsWzlACLUdxakQBAEu3DoNf1m1iEqZVmxkPC4lkUAa1iTtcOp79RuXlJUkXN4G
         1Lm8am1hQ0KiyAtiXbahXpw30N5l7giyxjPWyz9NmYZx7HpzMdk3Vmqu5d4MOCcUyFVu
         RFjgUxlRIctgglXcHpHZI8WvxXkJJVPGw5ub8PRTGm7qCnNEMvs+AVviN3pW1AWwMm6/
         ma702djNMmmFeEwEYG6dbvKLFpzQm7B7QJvUgM6JKqGvshMPXh32s/FylmX7wpm3S4tS
         Y63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680029267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8WAHPAOnoIsGbAeWRafsGc8bwd2YsHJNAiOdGspwD8=;
        b=badFX40waNZbW9zWv/NxI1qnFlhSBsCEnuE5Br8zuoSdl4nwIHtmY7nt5X+SCx+8t8
         sw4787388qiA9MWOAcg5YPMVso4ihZ3vSlpcc4hDUC9KGrXY97u8D6paDMcPg8bJiz/T
         Y80mCDiAXscVSlZIh44jzMk5lUAQNKvF+7FrvL7IISKeUUDdT2d6sPrGOuvW3DZ084EJ
         KXyNPE+JapPETY7t3Fui2/bbgCdz73XzHMfC6hPeZ+MXKwnlOzxj9Qr7YReadpXAuhU9
         Ny55gOCfPXRyuEuS4gtV+jUsGD7ajaJ6alfX/J1BcPuy5NyCOAwdeVaG4huldIwmPauR
         z6/Q==
X-Gm-Message-State: AAQBX9cggBljLCPVFCaaNSPSSW6mwuifpXsFUcR6+ZCB3kzakcFx89wd
        KFSOFe7IHmkv2/I0CZTNO9l++/T5SziWq35IeTc=
X-Google-Smtp-Source: AKy350ZnaJNd8MXO1Vdjq+UQfXQqGNI7qy7qfVIDOlnZ69/PbdfJFKY7U4aJywQE80FPcvYhpkQmzQ==
X-Received: by 2002:a05:6402:8d9:b0:4fe:19cb:4788 with SMTP id d25-20020a05640208d900b004fe19cb4788mr17038191edz.42.1680029267444;
        Tue, 28 Mar 2023 11:47:47 -0700 (PDT)
Received: from localhost ([2a02:8070:6387:ab20:5139:4abd:1194:8f0e])
        by smtp.gmail.com with ESMTPSA id q18-20020a50c352000000b00501d39f1d2dsm11663627edb.41.2023.03.28.11.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 11:47:47 -0700 (PDT)
Date:   Tue, 28 Mar 2023 14:47:46 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v1 7/9] workingset: memcg: sleep when flushing stats in
 workingset_refault()
Message-ID: <ZCM2UseWAhahYVtS@cmpxchg.org>
References: <20230328061638.203420-1-yosryahmed@google.com>
 <20230328061638.203420-8-yosryahmed@google.com>
 <CALvZod5_NVTrYUhLjc3Me=CC6y3R4bhA71mCt-jXo0rX+2zUxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5_NVTrYUhLjc3Me=CC6y3R4bhA71mCt-jXo0rX+2zUxw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 28, 2023 at 08:18:11AM -0700, Shakeel Butt wrote:
> > @@ -406,6 +406,8 @@ void workingset_refault(struct folio *folio, void *shadow)
> >         unpack_shadow(shadow, &memcgid, &pgdat, &eviction, &workingset);
> >         eviction <<= bucket_order;
> >
> > +       /* Flush stats (and potentially sleep) before holding RCU read lock */
> 
> I think the only reason we use rcu lock is due to
> mem_cgroup_from_id(). Maybe we should add mem_cgroup_tryget_from_id().
> The other caller of mem_cgroup_from_id() in vmscan is already doing
> the same and could use mem_cgroup_tryget_from_id().

Good catch. Nothing else in there is protected by RCU. We can just
hold the ref instead.

> Though this can be done separately to this series (if we decide to do
> it at all).

Agreed
