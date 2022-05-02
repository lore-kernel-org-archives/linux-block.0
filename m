Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6971FC433FE
	for <linux-block@archiver.kernel.org>; Mon,  2 May 2022 18:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiEBSUl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 May 2022 14:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbiEBSUl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 May 2022 14:20:41 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1830CF6E
        for <linux-block@vger.kernel.org>; Mon,  2 May 2022 11:17:12 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id m11so15964753oib.11
        for <linux-block@vger.kernel.org>; Mon, 02 May 2022 11:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PvvCOgnjGe0dYXKpJ9pI0+txM7TbvHNXdAlhk2Ap5Yg=;
        b=Xqee0d5J3oUetpbpmAlaaa6uUsjPvfdyp9ln0Pg93lEhd8ZbKF4GQbqchalEjtWhAm
         LzN1nMYSUc9r08R7CXuDaBBKRxTHN71hM33/DewqYJOWnWfm70NS4mFDvAbdxxN+oe/M
         oACztDsZUVPctNp7u/LdnrL8a39LYqPZsopRjWhvscfZuw1SBIPcZvLdX+eOYzt4va1G
         vXh87zUEI9ZMZonSYxrs1m2lgpbKAXkTlh1ic0Cc0a2n06uqYuwtcTw1U/tMK0PfN7mP
         a6s2EPNXm1rsPYe4Bh50fq8CA0fHDx5dFaCeLnEPbAjQpaz82bithZGOLZhL4WzBC1Pb
         /dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PvvCOgnjGe0dYXKpJ9pI0+txM7TbvHNXdAlhk2Ap5Yg=;
        b=43xZRpbQI7ea1K1uTSv5HsNRnhbCbAozjhGixp9SwPiHVcGapycnyd+wk2lrGWjJIo
         9OTB+qCCTtYgPrzOFXgqr1XJkaQvaQnMnYwlf4ugr2KyK2GQl2JVmQh6JKtCFOVulTc7
         cqXTyJCtsSdd8D0WGSgbigtGaLZUj4phxHfAu3dwhOhrVvZbuzaBZLk1OiSrstoSB/Fb
         vR4Cq2Jd8YR+2kICM0jt635o6G84XAhj43dqlG6zn0c2gC2HDQoN3U6t55bSpNl7n3Fw
         23XjBAd0LRPi0I6NV4sNydJof4q7pUpwmVxOVp5BwVaPx5d3aoV/sOklW3APsu3ryZrz
         m5Og==
X-Gm-Message-State: AOAM5312CHyeh9c/v1iWhnEqhDNw9h8BfuosreP7kgxSy7tODn2uIdWp
        Pbqufzf7fl11pQ4p183eGZRP7Q==
X-Google-Smtp-Source: ABdhPJwlXrDwQp35s264Q+VU/wLn5epYL/oA8E3CjaBdIi6PbgL8c2NDun1Cz2ubLZgO9Bv7EP8hhA==
X-Received: by 2002:a05:6808:13c2:b0:326:254d:8bcf with SMTP id d2-20020a05680813c200b00326254d8bcfmr198413oiw.153.1651515431378;
        Mon, 02 May 2022 11:17:11 -0700 (PDT)
Received: from relinquished.localdomain ([8.34.116.185])
        by smtp.gmail.com with ESMTPSA id i6-20020a9d6506000000b0060603221255sm3119177otl.37.2022.05.02.11.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 11:17:10 -0700 (PDT)
Date:   Mon, 2 May 2022 11:17:09 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Omar Sandoval <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [LSF/MM/BPF TOPIC] eBFP for block devices
Message-ID: <YnAgJZUzDTTbAOXY@relinquished.localdomain>
References: <5276e9fa-a253-6195-e697-60b4ff6e9bc4@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5276e9fa-a253-6195-e697-60b4ff6e9bc4@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 02, 2022 at 09:21:31AM -0700, Hannes Reinecke wrote:
> Hi Omar,
> 
> and another topic which came up during discussion yesterday:
> 
> eBPF for block devices
> It would be useful to enable eBPF for block devices, such that we could do
> things like filtering bios on bio type, do error injection by modifying the
> bio result etc.
> This topic should be around how it could be implemented and what additional
> use-cases could be supported.
> 
> Cheers,
> 
> Hannes

Do you want to try to coordinate a joint session with BPF, or were you
planning on brainstorming what we need just in the IO track and tracking
down the BPF folks offline?

+Alexei and Daniel
