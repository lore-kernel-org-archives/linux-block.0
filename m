Return-Path: <SRS0=mumx=BQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AB2C433E0
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 19:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 131532177B
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 19:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELraWo7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgHFTUr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:20:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21629 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726055AbgHFTUq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Aug 2020 15:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596741645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xksIODSgQJFquFghXdjFt8DevhlwMpk62x6LENq6tTk=;
        b=ELraWo7wb9H6pT/GOPFDWLHM/vFmJ/94SNPGrvD/70Pb1NiPvmZ/qJNkuGjLyBOrs6wp0z
        EZlSzbEIob8805r7/Aw1W7x2+KPN8gyuMHBFfw3ul/1Vh1BwNAGgM7RYqXvVVndRRDq2eA
        kDnMttQUnu2X8q5T+Ub6kl8dUH7mK30=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-xiEXg9qgOTq-DxzSZRoKyg-1; Thu, 06 Aug 2020 15:20:42 -0400
X-MC-Unique: xiEXg9qgOTq-DxzSZRoKyg-1
Received: by mail-wm1-f70.google.com with SMTP id p184so2093559wmp.7
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2020 12:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xksIODSgQJFquFghXdjFt8DevhlwMpk62x6LENq6tTk=;
        b=tTZ1E6OrjjtaPbK/B08kaeRh85q5/9TQONPtHfmwIyKgoAcfTSkjL6yOvHMJ3zakt5
         FysvdvapGyzic5SR3YkwszNigSNqVOH36UTWTdG85YsnOpGERDYU2syBBcuZc3Br3i8G
         9hD3PKo/IWjRqDKKgF6Vezhf49TczWVZIZO5G98k8g1B9eN4L0CXfo6tCgl7NfBKfaqf
         5FcGWV1DMT7/NU1kb4OeiB9BMiZyg7zgeMcoK1pvUTYtKvhh12cn0SMqPi7Fnfo6ZiN8
         LBnQti5W9WKvuUN1M5j9IRP2FnKZ7q5Xogb0hWmsbHf3741z4SNXbzduYEZz/6rqb7rj
         36Dg==
X-Gm-Message-State: AOAM532q9UD2dl+j78uABkQwcvFG3+i9u8h9dvt4fjGZT0heYCDNC93R
        FxOvumknLigiFkeupToldCIVcHzzT4X7aIY0HAz6v3ckwMK2RfgEaFT4afN0WBWu41xJP9id5UQ
        L6qykCqc4iL9r1SIEFvvzO3g=
X-Received: by 2002:a5d:43c4:: with SMTP id v4mr9107885wrr.426.1596741640883;
        Thu, 06 Aug 2020 12:20:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzF2qvBkdbbAz82ivFuJFBiv5/5fq62E6i55Jt9AKWyBEns1rJTE6V6YIA9dfKiZ/KoJtfe/w==
X-Received: by 2002:a5d:43c4:: with SMTP id v4mr9107873wrr.426.1596741640567;
        Thu, 06 Aug 2020 12:20:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20? ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
        by smtp.gmail.com with ESMTPSA id d11sm7576859wrw.77.2020.08.06.12.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 12:20:40 -0700 (PDT)
Subject: Re: [RFC 16/16] lpfc: vmid: Introducing vmid in io path.
To:     Tejun Heo <tj@kernel.org>
Cc:     Muneendra Kumar M <muneendra.kumar@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, emilne@redhat.com, mkumar@redhat.com,
        Gaurav Srivastava <gaurav.srivastava@broadcom.com>,
        James Smart <jsmart2021@gmail.com>,
        Ming Lei <tom.leiming@gmail.com>
References: <1596507196-27417-17-git-send-email-muneendra.kumar@broadcom.com>
 <61d2fd75-84ea-798b-aee9-b07957ac8f1b@suse.de>
 <08b9825b-6abb-c077-ac0d-bd63f10f2ac2@broadcom.com>
 <aa595605c2f776148e03a8e5dd69168a@mail.gmail.com>
 <20200806144135.GC4520@mtj.thefacebook.com>
 <96930d0f-cb4d-94f4-9cbb-c82d2f0c3840@redhat.com>
 <20200806144804.GD4520@mtj.thefacebook.com>
 <b7fb1e9a-49c4-f639-475a-791a195be46b@redhat.com>
 <20200806145901.GE4520@mtj.thefacebook.com>
 <8850c528-725f-c89a-cdc6-a9abada80a69@redhat.com>
 <20200806184920.GG4520@mtj.thefacebook.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a2522463-daf1-ea45-1dbc-2e31eb8bced2@redhat.com>
Date:   Thu, 6 Aug 2020 21:20:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200806184920.GG4520@mtj.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 06/08/20 20:49, Tejun Heo wrote:
>> perf and bpf have file descriptors, system calls and data structures of
>> their own, here there is simply none: it's just an array of chars.  Can
>> you explain _why_ it doesn't fit in the cgroupfs?
> What's the hierarchical or delegation behavior?

If a cgroup does not have an app identifier the driver should use the
one from the closes parent that has one.

> Why do the vast majority of
> people who don't have the hardware or feature need to see it? We can argue
> but I can pretty much guarantee that the conclusion is gonna be the same and
> it's gonna be a waste of time and energy for both of us.

I don't want to argue, I want to understand.  My standard is that a
maintainer that rejects code explains a plan for integrating with his
subsystem and/or points to existing code that does something similar,
rather than handwaving it away as something "that I can't remember off
the top of my head".

Thanks,

Paolo

