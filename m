Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA347C433ED
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 19:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DBA2613E9
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 19:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbhDFTAL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 15:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbhDFTAK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 15:00:10 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC13C06174A;
        Tue,  6 Apr 2021 12:00:01 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id q26so16095117qkm.6;
        Tue, 06 Apr 2021 12:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9ym7fnN02BGhD2IwZ2fakQvS1+eBOSpJm6r44NQnjAw=;
        b=Yk5lNV2D7P99rW6gcaAWyO09heuCK21b7bv63CmrcUadS+lzOxteEzzS1KytJiSc2U
         GQpHo1ajHLW/xrQkDYM8BKWvZKFr1klaFJCrjceNzmEsMiMlhC/ACq4fspQc9OuwR5L7
         5wvblAeAlv4oePkxbqJQNfhjjFLJaejp/bvbnW6AbP57X4aPVb2TXn25qQmNV6QVMCPb
         2lMH8Vyzc9J/7WFjqt9ZHlqatP61l/5mE5Kq6KV4GXtb3gexIOC2mMNnsLYrGSdkuwAL
         AOvuieb4rlkM9PqX3qnikO4Zc2kfqIsog21nqV1cPlL6ZZfMawLvX9pZcGyRJmozuEuZ
         FgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9ym7fnN02BGhD2IwZ2fakQvS1+eBOSpJm6r44NQnjAw=;
        b=AfWnYotx1g3Zj9C1epPrK4E40yTLJYx6oRPFie3etGIQYTolP72SnWVaBYBCKuXkXz
         3BGyC9fyZqEYEh/0kWUKxUJfw2IWsReL4j7XH4LdO04BSV/F/EQnxet0CoefqMRDVhnQ
         r+D/5bzXP1Z118eY+fijoH5O5iKIVZ1DjOJKpIrbFuZhw23qlEqAw1pnX+1FHn0QN3nS
         MUfLZ9jbUHcaTGQfh4Tlos4rK4HJyq8P7KZ+QiCs/9JO18nwT2VOXIWJqxj0GKaJndc1
         zOKLsGfYcYER8zK9ORdJBsUOftE0fLAEhBs545vqGtVay/ElbNXslPsxnJ4ppxujKlKH
         jPHQ==
X-Gm-Message-State: AOAM532JCKTIcQCiwR7DP4rt5rYCxf98K9h5lVBHom0WskpZzXrZ88ag
        ZRHa6zkRRlq4cHWnPt07MRU=
X-Google-Smtp-Source: ABdhPJyMXii2VgCL1K8Ppyi+s3pqEMJbOVpNbJZTNNpzPdYV/5yED4Tm0/lyoxOcGCObtnk++1PNkA==
X-Received: by 2002:a37:b103:: with SMTP id a3mr31924660qkf.261.1617735600751;
        Tue, 06 Apr 2021 12:00:00 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com ([2620:10d:c091:480::1:438])
        by smtp.gmail.com with ESMTPSA id d10sm16484412qko.70.2021.04.06.11.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 12:00:00 -0700 (PDT)
Date:   Tue, 6 Apr 2021 14:59:57 -0400
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] loop: Use worker per cgroup instead of kworker
Message-ID: <YGyvra69F/DIa7KI@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
References: <20210402191638.3249835-1-schatzberg.dan@gmail.com>
 <20210403020902.1384-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210403020902.1384-1-hdanton@sina.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Hillf, thanks for the review

On Sat, Apr 03, 2021 at 10:09:02AM +0800, Hillf Danton wrote:
> On Fri,  2 Apr 2021 12:16:32 Dan Schatzberg wrote:
> > +queue_work:
> > +	if (worker) {
> > +		/*
> > +		 * We need to remove from the idle list here while
> > +		 * holding the lock so that the idle timer doesn't
> > +		 * free the worker
> > +		 */
> > +		if (!list_empty(&worker->idle_list))
> > +			list_del_init(&worker->idle_list);
> 
> Nit, only queue work if the worker is inactive - otherwise it is taking
> care of the cmd_list.

By worker is inactive, you mean worker is on the idle_list? Yes, I
think you're right that queue_work() is unnecessary in that case since
each worker checks empty cmd_list then adds itself to idle_list under
the lock.

> 
> > +		work = &worker->work;
> > +		cmd_list = &worker->cmd_list;
> > +	} else {
> > +		work = &lo->rootcg_work;
> > +		cmd_list = &lo->rootcg_cmd_list;
> > +	}
> > +	list_add_tail(&cmd->list_entry, cmd_list);
> > +	queue_work(lo->workqueue, work);
> > +	spin_unlock_irq(&lo->lo_work_lock);
> >  }
> [...]
> > +	/*
> > +	 * We only add to the idle list if there are no pending cmds
> > +	 * *and* the worker will not run again which ensures that it
> > +	 * is safe to free any worker on the idle list
> > +	 */
> > +	if (worker && !work_pending(&worker->work)) {
> 
> The empty cmd_list is a good enough reason for worker to become idle.

This is only true with the above change to avoid a gratuitous
queue_work(), right? Otherwise we run the risk of freeing a worker
concurrently with loop_process_work() being invoked.
