Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F2BC282CD
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 17:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D9220881
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 17:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyxCGIWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbfA1Rle (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:41:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36407 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfA1Rld (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 12:41:33 -0500
Received: by mail-wr1-f68.google.com with SMTP id u4so19054640wrp.3;
        Mon, 28 Jan 2019 09:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5vc6fOfslJWy5sWFTwgNUTYSBoY4beFxKhyW6yNq43U=;
        b=ZyxCGIWIFdIJwqAc909bUF8QkXU4RWeTBsXKEfjadet9jaEbPc5ELLnAcmX9vrEAoj
         4NALy406Ap9cSMH3WTzzetUnB3aNDm26fs7+72KgYqN3ehRUkfzRcDrTD2HpEyiq+97Q
         aY5GzdhmPxquRZJoyWusg0YoBcy1mmPFDuPq5DSci2RA7PhnMYGkJnFxQcd87rIC4hua
         SgDz/ivjmElsUlOWHYOr2iZzmNweKeH2i3c/Gy0UpA1pOaqLg6o9hPU8W4mX2zMePGa7
         OnW6wbTv66bqLexWwwQSWF96OlvqwOkfqd2+fzxtRPJ3QR/Df6TYjeyeyIECdD6EQ+xX
         2Qnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5vc6fOfslJWy5sWFTwgNUTYSBoY4beFxKhyW6yNq43U=;
        b=L7lGX0N6e+6nT+1PdwArT7PdMONMl6E4/V0xzf0io7M7IXPr+mPhE1c/SvmCE09PqI
         SiMsOh68ON5pANeOpSLg2AzY175D9CdDhGDYeeE1b9xZWC42elv9QQMg4d6muPKmRw4f
         KWYUcXoAwYHMaqJPMJLf8lNsJ73VhWLMIezFQcFjSu4AINiMYDcbEo6h90RYs7GhIZNi
         qDE3MM5rVJG2CN+2NmRhxyQhVA72I4CvgYA9l+kjmIt806l8VRtMNEx4KUDq1etxb18W
         kpku5ap8quzVtMk7MGZIl67HKkrjIWlLTcYDoq5NsOA+RIw95Ovt8KPBaJ6G08sHDpo1
         De0w==
X-Gm-Message-State: AJcUukdiwMWYZSd6vAp83O4uPQx+8zYIWvE5CgrMDLAFJBeKQEFgzfPo
        aKY74vQCW2ejABLTRQj8wA==
X-Google-Smtp-Source: ALg8bN4KR0SrDjNg1URWwVyddQdjpIY76qB3T6mlRAF3Q4ioCcsEbVPi/wfMFW6d+eqFkf6eLBLD7A==
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr23901214wrn.27.1548697291307;
        Mon, 28 Jan 2019 09:41:31 -0800 (PST)
Received: from localhost (host180-106-dynamic.51-82-r.retail.telecomitalia.it. [82.51.106.180])
        by smtp.gmail.com with ESMTPSA id 129sm89886wmd.18.2019.01.28.09.41.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 09:41:30 -0800 (PST)
Date:   Mon, 28 Jan 2019 18:41:29 +0100
From:   Andrea Righi <righi.andrea@gmail.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jens Axboe <axboe@kernel.dk>, Dennis Zhou <dennis@kernel.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] cgroup: fsio throttle controller
Message-ID: <20190128174129.GB8272@xps-13>
References: <20190118103127.325-1-righi.andrea@gmail.com>
 <20190118163530.w5wpzpjkcnkektsp@macbook-pro-91.dhcp.thefacebook.com>
 <20190118184403.GB1535@xps-13>
 <20190118194652.gg5j2yz3h2llecpj@macbook-pro-91.dhcp.thefacebook.com>
 <20190119100827.GA1630@xps-13>
 <20190121214715.GA27713@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190121214715.GA27713@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Vivek,

sorry for the late reply.

On Mon, Jan 21, 2019 at 04:47:15PM -0500, Vivek Goyal wrote:
> On Sat, Jan 19, 2019 at 11:08:27AM +0100, Andrea Righi wrote:
> 
> [..]
> > Alright, let's skip the root cgroup for now. I think the point here is
> > if we want to provide sync() isolation among cgroups or not.
> > 
> > According to the manpage:
> > 
> >        sync()  causes  all  pending  modifications  to filesystem metadata and cached file data to be
> >        written to the underlying filesystems.
> > 
> > And:
> >        According to the standard specification (e.g., POSIX.1-2001), sync() schedules the writes, but
> >        may  return  before  the actual writing is done.  However Linux waits for I/O completions, and
> >        thus sync() or syncfs() provide the same guarantees as fsync called on every file in the  sys‐
> >        tem or filesystem respectively.
> > 
> > Excluding the root cgroup, do you think a sync() issued inside a
> > specific cgroup should wait for I/O completions only for the writes that
> > have been generated by that cgroup?
> 
> Can we account I/O towards the cgroup which issued "sync" only if write
> rate of sync cgroup is higher than cgroup to which page belongs to. Will
> that solve problem, assuming its doable?

Maybe this would mitigate the problem, in part, but it doesn't solve it.

The thing is, if a dirty page belongs to a slow cgroup and a fast cgroup
issues "sync", the fast cgroup needs to wait a lot, because writeback is
happening at the speed of the slow cgroup.

Ideally in this case we should bump up the writeback speed, maybe even
temporarily inherit the write rate of the sync cgroup, similarly to a
priority-inversion locking scenario, but I think it's not doable at the
moment without applying big changes.

Or we could isolate the sync domain, meaning that a cgroup issuing a
sync will only wait for the syncing of the pages that belong to that
sync cgroup. But probably also this method requires big changes...

-Andrea
