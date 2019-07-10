Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCE2C74A36
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 17:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC992087F
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 17:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ncmtdtrO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfGJRZJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 13:25:09 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37011 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbfGJRZI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 13:25:08 -0400
Received: by mail-qk1-f193.google.com with SMTP id d15so2523841qkl.4
        for <linux-block@vger.kernel.org>; Wed, 10 Jul 2019 10:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TWts3AWfLnZY/8+mDzywCA4nm3cpMgjgcvkY/eDGR8o=;
        b=ncmtdtrO5IfRIdy6defB/gA1akppNcnrs/xDXn6wjW/eWkMukIrAk8PP/ePQIhRMbi
         54aoWJB5p7Lbx+mF1/hicNwDphXcetqHU2j3iUsddC4fGCH8bY5TnJZPD0//g/Xjs2S4
         EaekTTVYdUM3ylNuE2NNtIDnRIsxFjhSmM+8ID1PtZvKbRC8kIkioM7t4qzCbvtPIsBF
         D/WZ5xnPT0XBrlT6C4zpOkmQkMBGLwM4KPXvEw7cBt64OJZYFRJm5qA2SqbuzsBeqOUd
         ZH1QM+bLzcENhT+4B0d/ht/Se7EBhN48Jur9ancatz4ItZPZuNjxzihfLyr9B5f0kq26
         eK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TWts3AWfLnZY/8+mDzywCA4nm3cpMgjgcvkY/eDGR8o=;
        b=kU7zu76EK3DdUr/dzfvhtWVcZ1cu5h1Zfq0KhvpecqJkhpf29o9edbmBnPi4ir28zG
         mOR6PAKM9IPswAqBNnawBFnl3CyXBSswi4zd+NCran1hJ9D2iUdQKybaHeU+bcLReiaI
         EY5MmIMIpbd8xv5M8geg/X6vHw+WdTUB4PyGrG8yN37AyPoUwgmpmx620JPlAYNxuh3Y
         +gIkFDH4a6rWN69zZlSTbRv37NJDdF88AgMeppWg50usjEQToKCaGC4iyBtl+egkG4iD
         UydsDUa2VL8H71ND4oLB1ADfyMYFPwyLdpiQooYmnO/wzUKs6WdqzE95YlN4N166vnC1
         jb0g==
X-Gm-Message-State: APjAAAWsiFNOBQuIeLkXxc4ocaPw8xVsTCfdf7+OLpH0Zfxa9JtxfPcD
        b0iJ4V7xVwfgayU2/nABYsq+YA==
X-Google-Smtp-Source: APXvYqywp1nQDJSnPdloNfzGTdBxnieSDQEVi61zIVsJYQritxdbe6jGkDlH5zkBnCGtuhW9rBbfIA==
X-Received: by 2002:a37:b045:: with SMTP id z66mr24424150qke.501.1562779507861;
        Wed, 10 Jul 2019 10:25:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id y194sm1420543qkb.111.2019.07.10.10.25.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jul 2019 10:25:06 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hlGL3-00046r-EV; Wed, 10 Jul 2019 14:25:05 -0300
Date:   Wed, 10 Jul 2019 14:25:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, axboe@kernel.dk,
        Christoph Hellwig <hch@infradead.org>, bvanassche@acm.org,
        dledford@redhat.com, Roman Pen <r.peniaev@gmail.com>,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
Message-ID: <20190710172505.GD4051@ziepe.ca>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
 <a8f2f1d2-b5d9-92fc-40c8-090af0487723@grimberg.me>
 <20190710135519.GA4051@ziepe.ca>
 <c49bf227-5274-9d13-deba-a405c75d1358@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c49bf227-5274-9d13-deba-a405c75d1358@grimberg.me>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 10, 2019 at 09:25:05AM -0700, Sagi Grimberg wrote:
> 
> > > Another question, from what I understand from the code, the client
> > > always rdma_writes data on writes (with imm) from a remote pool of
> > > server buffers dedicated to it. Essentially all writes are immediate (no
> > > rdma reads ever). How is that different than using send wrs to a set of
> > > pre-posted recv buffers (like all others are doing)? Is it faster?
> > 
> > RDMA WRITE only is generally a bit faster, and if you use a buffer
> > pool in a smart way it is possible to get very good data packing.
> 
> There is no packing, its used exactly as send/recv, but with a remote
> buffer pool (pool of 512K buffers) and the client selects one and rdma
> write with imm to it.

Well that makes little sense then:)

> > Maybe this is fine, but it needs to be made very clear that it uses
> > this insecure operating model to get higher performance..
> 
> I still do not understand why this should give any notice-able
> performance advantage.

Usually omitting invalidations gives a healthy bump.

Also, RDMA WRITE is generally faster than READ at the HW level in
various ways.

Jason
