Return-Path: <SRS0=mumx=BQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABF4C433E1
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 17:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A92020786
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 17:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UM238+Fz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbgHFRJG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:09:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45256 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729503AbgHFRJD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Aug 2020 13:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596733741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sjJhCuPta4WpVmZKxG0yo8dqBNBcHGQL4Ez+gkydzN0=;
        b=UM238+FzudAlxP1/dskTBjvUS4nfrrnqMpPlw/BUfJj5l2pmzxaKruf6k7su8M8Zu7897+
        9R+t/iDWwpkO3I3k/oYop3cMWWKaHuG9Bjjefn9lpCpCV1/9xbfXzhLZ66bfxT8Uz6qjZw
        fSTtHdU8JPGq0w5H26A93fF1ifif/To=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-ULQgSiIwM7epo0rmGR6B5g-1; Thu, 06 Aug 2020 09:41:08 -0400
X-MC-Unique: ULQgSiIwM7epo0rmGR6B5g-1
Received: by mail-wr1-f71.google.com with SMTP id w1so12862398wro.4
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2020 06:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sjJhCuPta4WpVmZKxG0yo8dqBNBcHGQL4Ez+gkydzN0=;
        b=fZZk7H/ZgNgt0tnaCAdIwbfKLRoABubgajZ8iszG6aRJ2+KfrIgQzqnKZGJGyEVrgz
         l6HLOCnqZgjSSKJakCfcwMB5JACHw/nitzaJN0MC7lfDiq/EpFnKzTYLcBfjvHmVDh81
         oXESjY60d40lmar76Ja8sSLjRO0x4UoWOyu4TgTXKkF3ZFXecti6M4C7AS0rie+fW464
         RLYUszHQmr9A8WVRZzvOFE3wKlrOBMCU3LeTnFqRZ9sZ0Cu/ioJHxj9J/NRSxZCIfyvd
         6tBwWOjllageRXV/eCF1CZc9fsUrX24JKL/M+R2WaZNTfPkb1RVNPq9pIKx70GI+kylM
         /LOg==
X-Gm-Message-State: AOAM532omipx5rA9w77TJUIQxsl/U/FWyMS1kjLJFdPdY5fjh2d8L2sP
        ltjL+R8IeNjX3VtnopFtSn16wJs10xfnR67+kduZhLlRTA5/2LpSNE0huEO8U6g5IfiC4oGpsOt
        4PLAOiOljY7fPrmnRkAYmHx4=
X-Received: by 2002:a1c:c913:: with SMTP id f19mr7777451wmb.173.1596721267521;
        Thu, 06 Aug 2020 06:41:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvp1W4XiDKNSf4N+cwMgbUHVygTtIjEkDlFD8MnUk4aTeuitV8JS5C+MnEveTJ1uyh+qNg6g==
X-Received: by 2002:a1c:c913:: with SMTP id f19mr7777420wmb.173.1596721267269;
        Thu, 06 Aug 2020 06:41:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20? ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
        by smtp.gmail.com with ESMTPSA id i4sm6702440wrw.26.2020.08.06.06.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 06:41:06 -0700 (PDT)
Subject: Re: [RFC 01/16] blkcg:Introduce blkio.app_identifier knob to blkio
 controller
To:     Ming Lei <tom.leiming@gmail.com>,
        Muneendra Kumar M <muneendra.kumar@broadcom.com>
Cc:     Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>,
        James Smart <james.smart@broadcom.com>,
        Daniel Wagner <dwagner@suse.de>,
        linux-block <linux-block@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Ewan Milne <emilne@redhat.com>, mkumar@redhat.com
References: <1596507196-27417-1-git-send-email-muneendra.kumar@broadcom.com>
 <1596507196-27417-2-git-send-email-muneendra.kumar@broadcom.com>
 <20200804113130.qfi5agzilso3mlbp@beryllium.lan>
 <20200804142123.GA4819@mtj.thefacebook.com>
 <b35e0e83-eb6c-4282-5142-22d9a996d260@broadcom.com>
 <CACVXFVPVM-xU0d2nETztPrS_EpacMy8A4x8FbShhLYt2iV_ouw@mail.gmail.com>
 <227c7f27-c6c7-5db1-59ac-2dd428f5a42a@suse.de>
 <20200805143913.GC4819@mtj.thefacebook.com>
 <c40bc34840566366177a84b0d8b7ae90@mail.gmail.com>
 <CACVXFVOYc9KAaLsQ1kPa_bW_MsUgcxhqec45f24pB62=r-KXPg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3d48f9fd-9793-453d-1a17-61d25ea2f678@redhat.com>
Date:   Thu, 6 Aug 2020 15:41:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVOYc9KAaLsQ1kPa_bW_MsUgcxhqec45f24pB62=r-KXPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 06/08/20 04:22, Ming Lei wrote:
>> Could you please let me know is there any another way where we can get the
>> VM UUID info with the help of blkcg.
> As Tejun suggested, the mapping between bio->bi_blkg->blkcg and the
> unique ID could be built in usage scope, such as fabric
> infrastructure, something like
> xarray/hash may help to do that without much difficulty.

So do you suggest adding one (or actually many) driver-specific files in
/sys/bus/pci/drivers/lpfc or something like that?  That seems very much
inferior to just sticking it into blkcg.  Even though this is only
implemented by lpfc, other FC drivers will follow suit.

Paolo

