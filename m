Return-Path: <SRS0=7tOu=5L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB61C43331
	for <linux-block@archiver.kernel.org>; Thu, 26 Mar 2020 16:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9BF2078E
	for <linux-block@archiver.kernel.org>; Thu, 26 Mar 2020 16:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585239285;
	bh=wAtkTu3p9/K8+g/ejzVY/AVfHxAVaH2OymqzkKd26Fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UNHL6Zi+yzMA+LDYt3hfjYWXiv42cFhcW+hSOOgC4RdnrK3z9DWwGTFkkGOG2tl9z
	 RhJHNmtsbJ91HnCP0IOtC7rNytxCKsoocbamsdglamRnZ7JKz5DS36x3Mw+cc3rxvA
	 eXamTsNG4CD6iE9eFk5rdq2oYD4b/DilrmG2wCH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgCZQOo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:14:44 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:42763 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbgCZQOo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Mar 2020 12:14:44 -0400
Received: by mail-qt1-f180.google.com with SMTP id t9so5788111qto.9;
        Thu, 26 Mar 2020 09:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8IKwyciStCgZpdnJkZlUrSTPI/Vlrtv9Ag4mNeyNDVc=;
        b=dqoznUEMpvZVbysLF5hQNKMHq3mH4oGS/Ao7V5rSK91a9khv579x9UUPWAKgJXHEzZ
         bkgfHuz2YJeG7Yp/3psz+pFlIGC7HdE3FJzN1Gf91FKM8wJmYykfwG2QlifcFmT9UiiV
         /zCa+fUOmXlYnrUrSkMwFusZ2N0ld4ebN0Oj38etpkldHa22keV1IUzjucTAuJiuvFnh
         z65g6ZaxHni7zfalSC00WM+U/FDTbzutOFD75hykMUHPNOg6/N8d04qNpZkyJxFO3muo
         p7gcmx0C6SRpqJnUJi3HloGGQmWDlFIQ7i0EfZzuThvv4AnPzTYw47dvI6ozAPLj0IP9
         yl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=8IKwyciStCgZpdnJkZlUrSTPI/Vlrtv9Ag4mNeyNDVc=;
        b=fEfpDyeAJCF9cs2f22KJgDdMTMDMGOivtf9K/4s90sJu2JfJLInJv9YK6lmjZMnc0V
         tXCr0HJb4SUJl34cQrpPCjh9wrAk5QlYl94ZuJO/o7z1EYLltE7KWGYEbuxZ8ZQrDxjK
         AAAlKcet4MrSnN8o1rwVBHA4R6xGcrsiCcqpWe5Gih5RSlPRfHmOQ8xD0SNiitpEn1LL
         L7l81d+1z6WOIuZTvio5Cdod+LCAJ6XvAXpCK1a4Tpiictjfn/Hg2i2A90+xo5c/S5y+
         o9QFli71EsC4RmAEPHYieyq0UyCsMfZHJKNqmwXzNzHAN5UdzRrh+IMgxEmN8TFv19VV
         vQ+w==
X-Gm-Message-State: ANhLgQ3rDLnj8vYxDDu0+srkSdaZcQxoEvLMBnnsvfWtkm/KtGSuUqyZ
        XvOzaLGjszuCSZ+D7DDDSV0pqyGfRNU=
X-Google-Smtp-Source: ADFU+vtb6NjiukzhVvws3c+D7BawP0Br0Bdn1caHYKsyxxG6rU38goRSAiY77OcJ5grAGuORCEcS6A==
X-Received: by 2002:ac8:2f93:: with SMTP id l19mr8952275qta.14.1585239282784;
        Thu, 26 Mar 2020 09:14:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::d3b8])
        by smtp.gmail.com with ESMTPSA id v75sm1686891qkb.22.2020.03.26.09.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 09:14:42 -0700 (PDT)
Date:   Thu, 26 Mar 2020 12:14:41 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Weiping Zhang <zwp10758@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [RFC 0/3] blkcg: add blk-iotrack
Message-ID: <20200326161328.GN162390@mtj.duckdns.org>
References: <cover.1584728740.git.zhangweiping@didiglobal.com>
 <20200324182725.GG162390@mtj.duckdns.org>
 <CAA70yB7a7VjgPLObe-rzfV0dLAumeUVy0Dps+dY5r-Guq2Susg@mail.gmail.com>
 <20200325141236.GJ162390@mtj.duckdns.org>
 <CAA70yB5yH9H6-gaKfRSTmgd6vvzP4T9N7v-NAD0MsRL+YTexHw@mail.gmail.com>
 <CAA70yB4e65nbV=ZA8OT-SUkq+ZQOGGB9e-3QKJ_PqXjVaXGvFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA70yB4e65nbV=ZA8OT-SUkq+ZQOGGB9e-3QKJ_PqXjVaXGvFA@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 26, 2020 at 11:08:45PM +0800, Weiping Zhang wrote:
> But iocost_test1 cannot get 8/(8+1) iops,  and the total disk iops
> is 737559 < 79388, even I change rrandiops=637000.

iocost needs QoS targets set especially for deep queue devcies. W/o QoS targets,
it only throttles when QD is saturated, which might not happen at all depending
on fio job params.

Can you try with sth like the following in io.cost.qos?

  259:0 enable=1 ctrl=user rpct=95.00 rlat=5000 wpct=50.00 wlat=10000

In case you see significant bw loss, step up the r/wlat params.

Thanks.

-- 
tejun
