Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B43C433C1
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 16:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 380A3619B8
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 16:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhCWQxi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 12:53:38 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:35837 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbhCWQxQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 12:53:16 -0400
Received: by mail-pj1-f50.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so5153838pjb.0
        for <linux-block@vger.kernel.org>; Tue, 23 Mar 2021 09:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Huv1PsgApLvsYhBoVOiQ5rQqjLFomkXY/H8Ll/ZYTSM=;
        b=rzKjYnbHNJIvi3FLUW6cOyVIJuqq3KHnaUyZCf5BajSCBsM/nrPXZA2G/9l+YBXmv4
         ntai+hZQxzOsxSv7IYmJWkk9IhXcNfOxspx7JThRkKVBSwYM3VVpDGn/w7UH3upZ00Dt
         hC8l5UfqwyQu3jEIfksrhxciDn8Z6TCsvzVRCstB96UdI/TPX8jInnp3LTFkm0OUidTf
         puNDcRwr+JEM/IVX7fnUVxwXuAP1s/YTmwBMYWojjqwtur9E2DmJPCEqycFxQEW7wAvy
         +LsKLETJON51Fsf1Ofrv2I8DK8+Fulcb+EaO0ndEnN5qakz+jksQKYI9Iq+0b57C61b+
         DzmA==
X-Gm-Message-State: AOAM533GlD+j7ymC7CyfaEhQmd6hLvUHp1YblQwAw92buQ0AO7U+1Wpm
        rnb79N6H061QdcDrjr+Lx7g=
X-Google-Smtp-Source: ABdhPJxEQpPHukpB8nSyFEHuLB2u/msuqukiZByRmRysnncylai5H8xCmaLsPyqWbYYQROcfOhFNdw==
X-Received: by 2002:a17:90a:2c4b:: with SMTP id p11mr5609466pjm.75.1616518396249;
        Tue, 23 Mar 2021 09:53:16 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:d137:e468:a6ec:38ce? ([2601:647:4000:d7:d137:e468:a6ec:38ce])
        by smtp.gmail.com with ESMTPSA id t125sm13159452pgt.71.2021.03.23.09.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 09:53:15 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] blk-mq: Fix races between iterating over requests and
 freeing requests
To:     John Garry <john.garry@huawei.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Khazhy Kumykov <khazhy@google.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20210319010009.10041-1-bvanassche@acm.org>
 <721c833d-7dc6-30a5-371e-c8c6388fb852@huawei.com>
Message-ID: <e1f1e219-7ebd-3a7c-1682-d011e23d24bb@acm.org>
Date:   Tue, 23 Mar 2021 09:53:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <721c833d-7dc6-30a5-371e-c8c6388fb852@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/23/21 5:34 AM, John Garry wrote:
> Do we have any performance figures to say that the effect is negligible?

Jens has been so kind to run a quick performance test (thanks Jens!).

> FYI, I did some testing on this, and it looks to solve problems in all
> known scenarios, including interactions of blk_mq_tagset_busy_iter(),
> and blk_mq_queue_tag_busy_iter().

Thanks for the testing!

>>   +DEFINE_SRCU(blk_sched_srcu);
> 
> out of interest, any reason that this is global and not per tagset?

That's a great question. Making it global was the easiest approach to
evaluate and test an SRCU-based solution. I can change the approach to
one SRCU struct per tag set but that will increase the size of each tag
set. The size of an SRCU structure is significant, and in addition to
this structure SRCU allocates memory per CPU:

struct srcu_struct {
	struct srcu_node node[NUM_RCU_NODES];	/* Combining tree. */
	struct srcu_node *level[RCU_NUM_LVLS + 1];
						/* First node at each level. */
	struct mutex srcu_cb_mutex;		/* Serialize CB preparation. */
	spinlock_t __private lock;		/* Protect counters */
	struct mutex srcu_gp_mutex;		/* Serialize GP work. */
	unsigned int srcu_idx;			/* Current rdr array element. */
	unsigned long srcu_gp_seq;		/* Grace-period seq #. */
	unsigned long srcu_gp_seq_needed;	/* Latest gp_seq needed. */
	unsigned long srcu_gp_seq_needed_exp;	/* Furthest future exp GP. */
	unsigned long srcu_last_gp_end;		/* Last GP end timestamp (ns) */
	struct srcu_data __percpu *sda;		/* Per-CPU srcu_data array. */
	unsigned long srcu_barrier_seq;		/* srcu_barrier seq #. */
	struct mutex srcu_barrier_mutex;	/* Serialize barrier ops. */
	struct completion srcu_barrier_completion;
						/* Awaken barrier rq at end. */
	atomic_t srcu_barrier_cpu_cnt;		/* # CPUs not yet posting a */
						/*  callback for the barrier */
						/*  operation. */
	struct delayed_work work;
#ifdef CONFIG_DEBUG_LOCK_ALLOC
	struct lockdep_map dep_map;
#endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
};

See also the alloc_percpu() call in init_srcu_struct_fields(). Does
everyone agree with increasing the size of each tag set with a data
structure that has a size that is proportional to the number of CPUs?

Thanks,

Bart.
