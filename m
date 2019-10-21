Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B1ACA9EAF
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 14:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366112053B
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 14:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="E/SlSvAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfJUOph (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:45:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45803 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfJUOph (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 10:45:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1so7935473pgj.12
        for <linux-block@vger.kernel.org>; Mon, 21 Oct 2019 07:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yTPxXfaDi/cyr4JY0Jgze0DAKcyw3G+EJ8T7To77x0c=;
        b=E/SlSvAkGWL8pGfVnOrx5+GTnF6CvSrWmR+zkwKOSkkzfwcdpu65kTGYr8fiTIgmTb
         /MDHOSXlb+rVJq0m8ODzgBgQNzhPe5snw/63q3NW2jxh3bIjMmPPoHfMdNcqEjFu2lb+
         HumNyf3lPhRJ+nZ3otIGsjmfY8uPQQfSP8ks+6W2RDchYKLh/XZ3zALOUlwItL3A9JYN
         cug3R8Dor9BHokXb+24HyBdDBrqK8YqTgzzb7oFXQ3Ntr6SpH4TpJFaeAI/MPl+QVvnd
         /Wx9r1UMh6hDjKQF0/f2FEXTJFwUTWxWNK2wuUajZn2v7djIAqlDwleTaP9XiJlRpqRO
         PvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yTPxXfaDi/cyr4JY0Jgze0DAKcyw3G+EJ8T7To77x0c=;
        b=BZfB0AcYYRdqiAqdp4kcU9Puifq1aZoCByCTnD1N/yaH04yd47Eb4oqV5GJvE5VY00
         aOG7CkPCYTfPAEtEhLwImDg5+nMdxQZlOY52vGwbUEGxnjEm9jf9NWU0VffXH44pjeG6
         XkWWYSGKHSs4vw34BxkyVU0O+1bgRM4J6278HxaeOf+AKED2OwO3564VrYx0ZmgvyIRQ
         Q1v4om6883Y9iOnaiHgYDbeja6uT6W3fDHC2FbQ6f42x3lHqi0JmJtuC+CqykWm95d8r
         lkSJobZSs3BsBqED/KpgOUA6SWJ1Y+fl1HEl7aDgyRrQocACPF/9jful0ceQlUobPVyH
         O/ww==
X-Gm-Message-State: APjAAAXWo9lsvzgTyKuEtLVEJR1mXoiyhPQi7Miv61dStS7ADNvMJOeX
        ciG/q7yxqDyeNl7VTDeTLKnk4AwELcl+uQ==
X-Google-Smtp-Source: APXvYqzrYlQXe7Wl+Pdo7pLekzBcv2vcqfOuYQs+fs6gn9SlfFOZLCyLa+RYqx/pnpy4I4e9QMaEgw==
X-Received: by 2002:a17:90a:a605:: with SMTP id c5mr30180069pjq.28.1571669136286;
        Mon, 21 Oct 2019 07:45:36 -0700 (PDT)
Received: from [192.168.1.182] ([192.40.64.15])
        by smtp.gmail.com with ESMTPSA id y80sm16549698pfc.30.2019.10.21.07.45.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 07:45:35 -0700 (PDT)
Subject: Re: [RFC PATCH 1/2] block: add support for redirecting IO completion
 through eBPF
To:     Bart Van Assche <bvanassche@acm.org>, Hou Tao <houtao1@huawei.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     linux-block@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, hare@suse.com,
        osandov@fb.com, ming.lei@redhat.com, damien.lemoal@wdc.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
References: <20191014122833.64908-1-houtao1@huawei.com>
 <20191014122833.64908-2-houtao1@huawei.com>
 <CAADnVQ+UJK41VL-epYGxrRzqL_UsC+X=J8EXEn2i8P+TPGA_jg@mail.gmail.com>
 <84032c64-8e5e-6ad1-63ea-57adee7a2875@huawei.com>
 <737d9d3f-e72c-ac31-6b2a-997202a302bd@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b09f97a5-4097-6ac4-00fd-27a77c5d15dd@kernel.dk>
Date:   Mon, 21 Oct 2019 08:45:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <737d9d3f-e72c-ac31-6b2a-997202a302bd@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/21/19 7:48 AM, Bart Van Assche wrote:
> On 10/21/19 6:42 AM, Hou Tao wrote:
>> Your suggestion is much simpler, so there will be no need for adding a new
>> program type, and all things need to be done are adding a raw tracepoint,
>> moving bpf_ccpu into struct request, and letting a BPF program to modify it.
> 
> blk-mq already supports processing completions on the CPU that submitted
> a request so it's not clear to me why any changes in the block layer are
> being proposed for redirecting I/O completions?

That's where I'm getting confused as well. I'm not against adding BPF
functionality to the block layer, but this one seems a bit contrived.

-- 
Jens Axboe

