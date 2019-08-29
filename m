Return-Path: <SRS0=37yO=WZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AEDC3A59F
	for <linux-block@archiver.kernel.org>; Thu, 29 Aug 2019 15:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84DCD2166E
	for <linux-block@archiver.kernel.org>; Thu, 29 Aug 2019 15:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567093574;
	bh=K1DC5a8M0SmiDc8LclIbau54Wi3kHL5WsQYED1zUqlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ybWWxJf/E9ktHaD0luXxBsp9TYxkGqljpgSSlea8KGHOo8DHqZhU3+2lWCIryMe7k
	 HIxBX1awiOBfg9rdfPMv3QrW1u51fWDyOyxK94GzBDfgTW0BQfu5ultk07TnPZJMln
	 Yz8ap75exhAJb926sbqL/Rwq/9OmAFx0Hx8eetTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfH2PqN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:46:13 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38573 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfH2PqN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Aug 2019 11:46:13 -0400
Received: by mail-qt1-f194.google.com with SMTP id b2so695561qtq.5;
        Thu, 29 Aug 2019 08:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aegqxwkNQfcl+Wg+uXNzhfA96N2TVnZEqWU/pVTp7O0=;
        b=SYTOMOQY9y4DHxazFL0VJ5Esl3I6kjkjeY0wH2mN1HPH/S+CJKwCkJ9ApmUWzpIltd
         7mJTwhspOUW+Xq1yyt6HsCav03dKy3i8mHcOeUt+mYUBpY0Scdy6du0IdP5UGhKYWKR4
         uO9gCZM6CksSTlpE/JECpZ/UtrIVw4ggrkWHKzVoykbTt3IfBI/zajFxcXk5E/VTWwHz
         RHQBykyBHBb/8qCtJR6BCiUAf21PHnWpn6uGQvPH2tRR/eEiZQhk+FPlqF/+32rRDSgD
         WwxUJYxcBZ4ZLQbdgQJDNQyHCJ1vtyy7JdkUZ9bxQdOZd2BI7CS43lRjQqsx224uAh4h
         F56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aegqxwkNQfcl+Wg+uXNzhfA96N2TVnZEqWU/pVTp7O0=;
        b=RzGAA9/t1uy9W4FmUE7fpNbp6L0B8Eg8hCEz85gcX1y52xNxBoVj52j2faeNuNRkIp
         izC/Ey/quYQ2emuYsRvPm9tw5Enwk1hVCNsyu1P88UVlLl5FQaLiSEXTjjvmRSsbyMcd
         384vF/LKyNHiFmcs+bR4ipVC5C4orTGtuFd40ENaTUBQ/A0+Wdnu48B2bok5dcF8g9TF
         HJwwipEEpb0YWgb4RtwqrcvuqGZGR7kHzut0VCsjC3Q0cDvUg6+L1fuuV71mCDqQ6v1o
         rNb+QKwepDjnde0wE0gyR9NfIs8NDKz5w6ipMYdMEuldBSOg6HiSyR4TJ4PXMbzrvfxm
         pk2g==
X-Gm-Message-State: APjAAAUzyTH1bW73y1+fP+R3gi+gwiZdGAXUuGx2UfCY1A+lsErj7Sbm
        vXJR8NFW27jXttfHcld/28k=
X-Google-Smtp-Source: APXvYqzjcJkE7617DYDqIr3PG4ZNC8XGG7HEcgfFWkDmRvAS0Ibl+uE1pNYw7GOE8LHelm+6jWMe2A==
X-Received: by 2002:ac8:3449:: with SMTP id v9mr10473377qtb.163.1567093572550;
        Thu, 29 Aug 2019 08:46:12 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:7e32])
        by smtp.gmail.com with ESMTPSA id k11sm1194357qtp.26.2019.08.29.08.46.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 08:46:10 -0700 (PDT)
Date:   Thu, 29 Aug 2019 08:46:09 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org,
        Josef Bacik <jbacik@fb.com>, Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH 08/10] blkcg: implement blk-iocost
Message-ID: <20190829154609.GU2263813@devbig004.ftw2.facebook.com>
References: <20190828220600.2527417-1-tj@kernel.org>
 <20190829133928.16192-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829133928.16192-1-hdanton@sina.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Thu, Aug 29, 2019 at 09:39:28PM +0800, Hillf Danton wrote:
> > +	on_q_ns = ktime_get_ns() - rq->alloc_time_ns;
> > +	rq_wait_ns = rq->start_time_ns - rq->alloc_time_ns;
> > +
> ehm... alloc_time makes no sense wrt start_time if this is their only
> use. What are you trying to measure with the two stamps if they are
> meaningfully apart?

Queue depth depletion.

> > +	rq_qos_add(q, rqos);
> > +	ret = blkcg_activate_policy(q, &blkcg_policy_iocost);
> > +	if (ret) {
> > +		rq_qos_del(q, rqos);
> 
> 		free_percpu(ioc->pcpu_stat);

Good catch.  Will send a follow up patch.

Thanks.

-- 
tejun
