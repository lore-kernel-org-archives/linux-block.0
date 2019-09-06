Return-Path: <SRS0=sY57=XB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24867C43331
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 14:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED9D214DE
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 14:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567781912;
	bh=x1c0Spa+Qjq4re2LGUvCBcQxxEGgtZC4TTO10h8FMUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r5Znui4/dnp8/e33P/KfxXAL0xQyNTtzRPhuPWz4pviAu/Q9vhYkrNNDI0nxTZg1o
	 G4unC8mWmPcx3rScgdkKrKz1Lj0NmVkPjWOeQx9az/X5R9plp341IiJsWCxf4d37rs
	 rLOQ/tV23BuQwGjSXydqQ+lWX66OAVlwMrcbq2Jc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391291AbfIFO6b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:58:31 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34697 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfIFO6b (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Sep 2019 10:58:31 -0400
Received: by mail-qt1-f193.google.com with SMTP id a13so7407633qtj.1;
        Fri, 06 Sep 2019 07:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LOL4RkhxwNmxVBDlkkOKh5q7eIdq3MEVHDS6KxIm1I4=;
        b=MOXP8ySNFPJpMxFpoTNloLC7w8Wh/zABeSUGLmy9GcZZLTPwTWbLNAiqmpDc3ec4/o
         fd/SQEbUNPqNvtpl1/z5Lvnd779JkYSuyqQbJvM8lCbSRUV/hrvYwZxSgL1rKwz0us/i
         ZREmz6vxrZfPNGqJkZmhWJzITJzzyL2gIw8RxEgkUTgtbxCjFWnGsP1l5JXqBN4ds0LM
         SVyRMrlR29TEH85320jHVL5TDIO8nn5KCyJ9cdcTr0DMf2el5OoMqyCl+KPnXNdr78gM
         NnqSEpEKFjrjmUF5jre4PNzvz5/0G04w9u5myf8I6/pAcoyhos2ouAn+mFiJ6I12Kg6r
         75JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LOL4RkhxwNmxVBDlkkOKh5q7eIdq3MEVHDS6KxIm1I4=;
        b=bvCsxm+7mke4oAm9lVJ7sqkX5g8rBzceWjkhyKXuRsc7PKNbiEpuNWMiVcpq+43ulF
         QIolFhhZOJQAM/S7B5/PM4pqoiPJfFOsQSwJhJaGjF+zLmVkw0O6kRO3rGfg3MuiBgzw
         O7tgFWS8GMtyuaX1tVND2xrnvXgCSSir8sxkhAXA0ArA4Wy+qPbV1Sgc0d8OvVmhwrrt
         qsNn8FjJm0XGGU7K5iiJ060rOC8fp7hPSGyPAMGNpTsSluIaeLyppOgsMNMp0vvGfM8X
         pWdHPdj3GbuAG696f4vO/fihvrVzS7fUHL/fx/6D8hHVxnhamUcqWdcA1dq030oHeX/m
         hmqQ==
X-Gm-Message-State: APjAAAXupRDMVQga3obNhhiRDQ6cNTSbLe6kxxhsSDAkqGdUtexBXq9C
        VcrEGiFSQeTq0pO4Vig0Y4A=
X-Google-Smtp-Source: APXvYqzw/ynJVnXeScViPWyvcMnfE9uWmFXTKN6Uah/pXOmrexC6Mnw/vVsY8SiKAx59SdE4f2ivQw==
X-Received: by 2002:ac8:5390:: with SMTP id x16mr9499947qtp.390.1567781909530;
        Fri, 06 Sep 2019 07:58:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::e7cb])
        by smtp.gmail.com with ESMTPSA id g194sm2967170qke.46.2019.09.06.07.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 07:58:28 -0700 (PDT)
Date:   Fri, 6 Sep 2019 07:58:26 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, newella@fb.com, clm@fb.com,
        Josef Bacik <josef@toxicpanda.com>, dennisz@fb.com,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, kernel-team@fb.com,
        cgroups@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        bpf@vger.kernel.org
Subject: Re: [PATCHSET block/for-next] IO cost model based work-conserving
 porportional controller
Message-ID: <20190906145826.GL2263813@devbig004.ftw2.facebook.com>
References: <5A63F937-F7B5-4D09-9DB4-C73D6F571D50@linaro.org>
 <B5E431F7-549D-4FC4-A098-D074DF9586A1@linaro.org>
 <20190820151903.GH2263813@devbig004.ftw2.facebook.com>
 <9EB760CE-0028-4766-AE9D-6E90028D8579@linaro.org>
 <20190831065358.GF2263813@devbig004.ftw2.facebook.com>
 <88C7DC68-680E-49BB-9699-509B9B0B12A0@linaro.org>
 <20190902155652.GH2263813@devbig004.ftw2.facebook.com>
 <D9F6BC6D-FEB3-40CA-A33C-F501AE4434F0@linaro.org>
 <20190905165540.GJ2263813@devbig004.ftw2.facebook.com>
 <EFFA2298-8614-4AFC-9208-B36976F6548C@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EFFA2298-8614-4AFC-9208-B36976F6548C@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello, Paolo.

On Fri, Sep 06, 2019 at 11:07:17AM +0200, Paolo Valente wrote:
> email.  As for the filesystem, I'm interested in ext4, because it is
> the most widely used file system, and, with some workloads, it makes

Ext4 can't do writeback control as it currently stands.  It creates
hard ordering across data writes from different cgroups.  No matter
what mechanism you use for IO control, it is broken.  I'm sure it's
fixable but does need some work.

That said, read-only tests like you're doing should work fine on ext4
too but the last time I tested io control on ext4 is more than a year
ago so something might have changed in the meantime.

Just to rule out this isn't what you're hitting.  Can you please run
your test on btrfs with the following patchset applied?

 http://lkml.kernel.org/r/20190710192818.1069475-1-tj@kernel.org

And as I wrote in the previous reply, I did run your benchmark on one
of the test machines and it did work fine.

Thanks.

-- 
tejun
