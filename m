Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8793EC76196
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 19:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjC1TGK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 15:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjC1TGJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 15:06:09 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7F82690
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 12:06:05 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x3so53773296edb.10
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 12:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680030365;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WQyIrdKCsHvb8zLTh5h/QnKicAPnjV8XyfAnbUhyqtc=;
        b=eGikLsGLFoVUkW6GbVQkOFBoDpp+W99UiFbI/1642zWEFZ3juLQaRaltNCn2wU02D4
         YL7jzA8mTQn67wxUeBcnWhvdMnr7A5ebifJPOyfQPIkEOzJxi6194cbH6C6j3kKl8Ywl
         XY3zE4et0pjZlCrDxONVchgaIVK8GzX60e6GQTpdrsOE/QF3qkhQESQeWnFpo7qhv9f7
         3d5b6XKEPzhosboezNX9Lu3mnNa36lMRugddSdn5yJmIE4bQr6mBDyVxDY/HWbX3+3KJ
         cJRFP4ssIfd/HvC3ZbE6cl+jYuymOoi7hkVc8hvAod8Y9FnsSo8mTPul4jkMAP7OITxv
         Ta/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680030365;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WQyIrdKCsHvb8zLTh5h/QnKicAPnjV8XyfAnbUhyqtc=;
        b=6s3curL5YsYB1J29cL9ePSnZSVhPueJhqeQwXkTc9Fq43btC45mRFp9hy3Ar8Xw4aJ
         yA/iDefY0tiY9GRxArNx4ONXLVIH8RttxsIQEYZpsYqPOzCtOQfk8V9m7ulI33Pj66V6
         FM/iW8xGOC8hDFA6m+JWufgV2BkzuZKeqRKP76/ezV2ZMS1OMtVy6hTeascIB3Fr+Cv/
         hxdLypnxgxs01U3DhxnzMmDsp3qZ8rzWHcJAhVwhxDYDusrj5ScHTZjow66Jjesof4wh
         DOKpnNa79yvBkLCHY2AzHUUHhefx/Kv4K3cHGZNIQb1Jz9Knhs+iQZGii4IcYNGiEvwq
         Uzkg==
X-Gm-Message-State: AAQBX9cQIZGneL1j+I2WawwOElVldvk4skQkJnZigLcER+W/dT+wfU49
        Skvm6FFLXd6Z6Xb/qMivV7QfWw==
X-Google-Smtp-Source: AKy350aw3p2OspiyiuuWmLGeQQA0Ae4PemXrygP5k1HGpsqdCzFAOkR4Ju/Zc6bJrxyK3dozuSVLvA==
X-Received: by 2002:a17:907:d402:b0:930:ca4d:f2bf with SMTP id vi2-20020a170907d40200b00930ca4df2bfmr19816432ejc.54.1680030365312;
        Tue, 28 Mar 2023 12:06:05 -0700 (PDT)
Received: from localhost ([2a02:8070:6387:ab20:5139:4abd:1194:8f0e])
        by smtp.gmail.com with ESMTPSA id xh9-20020a170906da8900b009447277c26fsm3069805ejb.72.2023.03.28.12.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 12:06:05 -0700 (PDT)
Date:   Tue, 28 Mar 2023 15:06:03 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v1 6/9] memcg: sleep during flushing stats in safe
 contexts
Message-ID: <ZCM6m/4ujEqvFVsn@cmpxchg.org>
References: <20230328061638.203420-1-yosryahmed@google.com>
 <20230328061638.203420-7-yosryahmed@google.com>
 <ZCMzfQuo9IhWVzRA@cmpxchg.org>
 <CAJD7tkZxEEcVZ9G7NSM56q_uOyL7e353NT06kD0mY5DyNmKTpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZxEEcVZ9G7NSM56q_uOyL7e353NT06kD0mY5DyNmKTpw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 28, 2023 at 11:45:19AM -0700, Yosry Ahmed wrote:
> On Tue, Mar 28, 2023 at 11:35 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > On Tue, Mar 28, 2023 at 06:16:35AM +0000, Yosry Ahmed wrote:
> > >  void mem_cgroup_flush_stats_ratelimited(void)
> > >  {
> > >       if (time_after64(jiffies_64, READ_ONCE(flush_next_time)))
> > > -             mem_cgroup_flush_stats();
> > > +             mem_cgroup_flush_stats_atomic();
> > > +}
> >
> > This should probably be mem_cgroup_flush_stats_atomic_ratelimited().
> >
> > (Whee, kinda long, but that's alright. Very specialized caller...)
> 
> It should, but the following patch makes it non-atomic anyway, so I
> thought I wouldn't clutter the diff by renaming it here and then
> reverting it back in the next patch.
> 
> There is an argument for maintaining a clean history tho in case the
> next patch is reverted separately (which is the reason I put it in a
> separate patch to begin with) -- so perhaps I should rename it here to
> mem_cgroup_flush_stats_atomic_ratelimited () and back to
> mem_cgroup_flush_stats_ratelimited() in the next patch, just for
> consistency?

Sounds good to me. It's pretty minor churn.

> > Btw, can you guys think of a reason against moving the threshold check
> > into the common function? It would then apply to the time-limited
> > flushes as well, but that shouldn't hurt anything. This would make the
> > code even simpler:
> 
> I think the point of having the threshold check outside the common
> function is that the periodic flusher always flushes, regardless of
> the threshold, to keep rstat flushing from critical contexts as cheap
> as possible.

Good point. Yeah, let's keep it separate then.

> > > @@ -2845,7 +2845,7 @@ static void prepare_scan_count(pg_data_t *pgdat, struct scan_control *sc)
> > >        * Flush the memory cgroup stats, so that we read accurate per-memcg
> > >        * lruvec stats for heuristics.
> > >        */
> > > -     mem_cgroup_flush_stats();
> > > +     mem_cgroup_flush_stats_atomic();
> >
> > I'm thinking this one could be non-atomic as well. It's called fairly
> > high up in reclaim without any locks held.
> 
> A later patch does exactly that. I put making the reclaim and refault
> paths non-atomic in separate patches to easily revert them if we see a
> regression. Let me know if this is too defensive and if you'd rather
> have them squashed.

No, good call. I should have just looked ahead first :-)
