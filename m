Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04610C43331
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 15:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF61F20BED
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 15:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585669903;
	bh=UHk7kd07698C0bG0d9Q037aoUo5iEQmsIYHi6IFTBQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vH3kGbAnJC081AR5r4Qunl4gkBMLRiG5W7aYUe0Ui0CidSKJx9aJDwrgz1rv6JeIS
	 SBGFPP5CesL+DHM7HqvA3SCpyJnZnfbQp5ac2p3yPQZskG6ru+3GfSAYueEH5Q7w35
	 etsVlMsGNBowjeZUpN2A+UExWSltZpZ8JZhFeDdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbgCaPvn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 11:51:43 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44785 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730677AbgCaPvn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 11:51:43 -0400
Received: by mail-qk1-f194.google.com with SMTP id j4so23443962qkc.11;
        Tue, 31 Mar 2020 08:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Cw3Eh01JFPi8BMIikV3NbP3KCc0IWLFrVC/r+JOBGd8=;
        b=qr5/dccWdp9TcfXD7AQm7YO7pfp2jr9W5meVcYfS3ee7ORl14fhtMqp24mEz3V//yV
         oCvp/JGHSpVTWxB15h0c4Tw4O8c1eid8vCrasK7pLmAxllaXl7JMxoiUl1ZOaAqtK57r
         UMthNrTT0vql6RAOKLEgwD7eh66Fi4BszDDk6REcQ0sqcE7dN72eZLVR7G7/5UzmKZba
         OmLFFwYl+GFCNz04bRJLRvd1MTzSsngAaRY0p5NnLVAkllK4quqmspn/6m+08ObMrl/E
         W3tgCwzmxzN6zKhpLMiWVQkk5u4DBqjeRqjREusjH7t5/6gJ0PyqmnXM9Cg8igKeYqAI
         odmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Cw3Eh01JFPi8BMIikV3NbP3KCc0IWLFrVC/r+JOBGd8=;
        b=tynUR38IdTA7eMwlFXYttjEMMjtofwLL3OFxwfrKvSndUJmGSrlVXFHT1wj/zxeoPK
         Od5UrN6Tq6LoTk8CicqXRzw5JAsl1qpwKZ3vPiVMuH4qtuwFf5xECJFWFrhGAjIbY9k7
         MnNmpUkXSpcqOqOMCcSPnN8UBQabvhUm5g1OI+ZOYFBu9W9qmZIHtfrpSP/Z6EOI88m3
         SX7IWsVMwh2HBH1H+QaFXkvlCQAIJZU7aIoa15fhUg6O9682h8DTc/MkviVETw5o/Rcg
         25kbUlbiYxsrMfSQHvX46FTsfRi0gEXSCDLglqh8PpnhVVsAzaLjvf2yFfGjo3arzHcY
         B1DQ==
X-Gm-Message-State: ANhLgQ0qbk3gWoEFeJ5KD2v+2nN8VToo9rbNsebnNtiqjRSCffluMdS8
        zibyUrA7ViE8UDt6XdsoNqQ=
X-Google-Smtp-Source: ADFU+vseiSMDCCMUSqV42NlgSPKMidOk1UFamFIexPEWiz7tGJMgVKMgaJDPmj7yocflFhcqlI5dWw==
X-Received: by 2002:a05:620a:a86:: with SMTP id v6mr5450463qkg.156.1585669901806;
        Tue, 31 Mar 2020 08:51:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::b946])
        by smtp.gmail.com with ESMTPSA id o13sm14130529qtk.12.2020.03.31.08.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 08:51:41 -0700 (PDT)
Date:   Tue, 31 Mar 2020 11:51:39 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Weiping Zhang <zwp10758@gmail.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>,
        "Nadolski, Edmund" <edmund.nadolski@intel.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v5 0/4] Add support Weighted Round Robin for blkcg and
 nvme
Message-ID: <20200331155139.GT162390@mtj.duckdns.org>
References: <cover.1580786525.git.zhangweiping@didiglobal.com>
 <20200204154200.GA5831@redsun51.ssa.fujisawa.hgst.com>
 <CAA70yB5qAj8YnNiPVD5zmPrrTr0A0F3v2cC6t2S1Fb0kiECLfw@mail.gmail.com>
 <CAA70yB62_6JD_8dJTGPjnjJfyJSa1xqiCVwwNYtsTCUXQR5uCA@mail.gmail.com>
 <20200331143635.GS162390@mtj.duckdns.org>
 <CAA70yB51=VQrL+2wC+DL8cYmGVACb2_w5UHc4XFn7MgZjUJaeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA70yB51=VQrL+2wC+DL8cYmGVACb2_w5UHc4XFn7MgZjUJaeg@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Tue, Mar 31, 2020 at 11:47:41PM +0800, Weiping Zhang wrote:
> Do you means drop the "io.wrr" or "blkio.wrr" in cgroup, and use a
> dedicated interface
> like /dev/xxx or /proc/xxx?

Yes, something along that line. Given that it's nvme specific, it'd be best if
the interface reflects that too - e.g. through a file under
/sys/block/nvme*/device/. Jens, Christoph, what do you guys think?

> I see the perf code:
> struct fd f = fdget(fd)
> struct cgroup_subsys_state *css =
> css_tryget_online_from_dir(f.file->f_path.dentry,
>         &perf_event_cgrp_subsys);
> 
> Looks can be applied to block cgroup in same way.

Yeah, either fd or ino can be used to identify a cgroup.

Thanks.

-- 
tejun
