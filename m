Return-Path: <SRS0=QBb8=4U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71214C3F2D1
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 16:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3944F20CC7
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 16:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583251392;
	bh=mAPL8cqY6aXXbfCNzxczZ75FlqrGyHFN6d6MOwnBNRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FId/DYwV0/xITKolng+rY9JeCg8j71NYMee+Hb8MMi94j2j/2dFLM+tQIF3tRssi1
	 VezjVqxKpnVyAv2EfjSpJtrPd3/VJqKWkT5t0PaTSeKQ+J/q1udZh3QacbEsdIOd/5
	 JOVHAhYm1kAorpMt82JYYYwhJp9ITIXMI2p7wjpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbgCCQDL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Mar 2020 11:03:11 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50658 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729680AbgCCQDL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Mar 2020 11:03:11 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so3886288wmb.0;
        Tue, 03 Mar 2020 08:03:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6cZqu3E9qwQ8IPoe9SjNtyIoE9lo8mbH7ak38NmV4nA=;
        b=UlwXEAXHEK7drZROOZtj6cF8p55t6O1hz4h/pSYNsYnuMOdEJIhZF5a/7VcaEhK3GZ
         PATbZAFZTAUblFxs9201+urb8mjbRFcdWv9YzLWPi4hK7NJAj5TEd9d3cIA78Gfl/40M
         Oefbzqs1Ade6wTMq4tiAduTcCO0PHIl+oQtGPv9Ct3R9JnIDX/UpvrtQS51QBp+OUgc2
         0Ppr/Jf5FhZUYv7CONCpZ5y++wiv9dL4TKanlfpFMK/kyzDH4mpf2Uu5FQ2xuqoHjHrY
         xe5jsem9efb2fAqly07QyS+A3CQxmpAzchOO5fpsgxv2gkxpSyUfcHyvsng+A3jyYjOV
         +2nQ==
X-Gm-Message-State: ANhLgQ36tj6XalON0uj+ihgXfCUG6oHXU8VXfGBjEFrKj/DcqapLTFRk
        QeDzz+pQLx7CHBrVVNK0cNf/4qDfS6c=
X-Google-Smtp-Source: ADFU+vtAui0vb0XSCCDXURHL23TZuPcyxH8PWxzLV8B/zZLm+upolIJdf0K8iOtdvHs+UeyJqXROKw==
X-Received: by 2002:a05:600c:21da:: with SMTP id x26mr5164698wmj.66.1583251389685;
        Tue, 03 Mar 2020 08:03:09 -0800 (PST)
Received: from localhost (ip-37-188-163-134.eurotel.cz. [37.188.163.134])
        by smtp.gmail.com with ESMTPSA id f17sm13788616wrm.3.2020.03.03.08.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 08:03:08 -0800 (PST)
Date:   Tue, 3 Mar 2020 17:03:07 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Coly Li <colyli@suse.de>, axboe@kernel.dk,
        linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        hare@suse.de, mkoutny@suse.com
Subject: Re: [PATCH 1/2] bcache: ignore pending signals in
 bcache_device_init()
Message-ID: <20200303160307.GI4380@dhcp22.suse.cz>
References: <20200302093450.48016-1-colyli@suse.de>
 <20200302093450.48016-2-colyli@suse.de>
 <20200302122748.GH4380@dhcp22.suse.cz>
 <20200302134919.GB9769@redhat.com>
 <20200303080544.GW4380@dhcp22.suse.cz>
 <20200303121918.GA27520@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303121918.GA27520@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 03-03-20 13:19:18, Oleg Nesterov wrote:
[...]
> but I am not sure this optmization makes sense.

I would much rather start with a clarification on what should be use
what shouldn't. Because as of now, people tend to copy patterns which
are broken or simply do not make any sense at all.

-- 
Michal Hocko
SUSE Labs
